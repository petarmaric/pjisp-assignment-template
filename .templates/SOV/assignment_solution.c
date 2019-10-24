#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAZIV 13+1
#define MAX_VRSTA 10+1

typedef struct namirnica_st {
    char naziv[MAX_NAZIV];
    unsigned kolicina;
    char vrsta[MAX_VRSTA];

    struct namirnica_st *next;
} NAMIRNICA;

void init_list(NAMIRNICA **head) {
    *head = NULL;
}

void add_to_list(NAMIRNICA *new, NAMIRNICA **head) {
    if(*head == NULL) { // list is empty
        *head = new;
        return;
    }

    add_to_list(new, &((*head)->next));
}

NAMIRNICA *create_new_item(char naziv[], unsigned kolicina, char vrsta[]) {
    NAMIRNICA *new = (NAMIRNICA *)malloc(sizeof(NAMIRNICA));
    if (new == NULL) {
        printf("Not enough RAM!\n");
        exit(21);
    }

    strcpy(new->naziv, naziv);
    new->kolicina = kolicina;
    strcpy(new->vrsta, vrsta);

    new->next = NULL;

    return new;
}

void read_list_from(FILE *in, NAMIRNICA **head) {
    char naziv[MAX_NAZIV];
    unsigned kolicina;
    char vrsta[MAX_VRSTA];

    while(fscanf(in, "%s %u %s", naziv, &kolicina, vrsta) != EOF) {
        NAMIRNICA *new = create_new_item(naziv, kolicina, vrsta);
        add_to_list(new, head);
    }
}

void save_item_to(FILE *out, NAMIRNICA *x) {
    fprintf(
        out, "%3u %-13s %s\n",
        x->kolicina, x->naziv, x->vrsta
    );
}

void save_list_to(FILE *out, NAMIRNICA *head) {
    if(head != NULL) {
        save_item_to(out, head);
        save_list_to(out, head->next);
    }
}

void destroy_list(NAMIRNICA **head) {
    if(*head != NULL) {
        destroy_list(&((*head)->next));
        free(*head);
        *head = NULL;
    }
}

FILE *safe_fopen(char *filename, char *mode, int error_code) {
    FILE *fp = fopen(filename, mode);
    if (fp == NULL) {
        printf("Can't open '%s'!\n", filename);
        exit(error_code);
    }
    return fp;
}

NAMIRNICA *get_najbolja_namirnica(NAMIRNICA *head, char vrsta[]) {
    if (head == NULL) { // list is empty
        return NULL;
    }

    NAMIRNICA *best = NULL;
    while(head != NULL) {
        if (strcmp(head->vrsta, vrsta) == 0) {
            // Gledamo samo namirnice koje su odgovarajuce vrste
            if (best == NULL) {
                // Pre ovoga nije bilo namirnica koji su odgovarajuce vrste
                best = head;
            } else if (head->kolicina > best->kolicina) {
                // Nadjena bolja namirnica, koji je odgovarajuce vrste
                best = head;
            }
        }

        head = head->next;
    }

    return best;
}

int main(int arg_num, char *args[]) {
    if (arg_num != 4) {
        printf("USAGE: %s VRSTA IN_FILENAME OUT_FILENAME\n", args[0]);
        exit(11);
    }

    char *vrsta = args[1];
    char *in_filename = args[2];
    char *out_filename = args[3];

    FILE *in  = safe_fopen(in_filename,  "r", 1);
    FILE *out = safe_fopen(out_filename, "w", 2);

    NAMIRNICA *head;
    init_list(&head);

    read_list_from(in, &head);
    save_list_to(out, head);

    NAMIRNICA *best = get_najbolja_namirnica(head, vrsta);
    if (best != NULL) {
        fprintf(out, "\nNamirnica sa najvise vitamina C je:\n");
        save_item_to(out, best);
    }

    destroy_list(&head);

    fclose(in);
    fclose(out);

    return 0;
}
