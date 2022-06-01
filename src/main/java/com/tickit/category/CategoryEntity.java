package com.tickit.category;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "category", schema = "public", catalog = "tickit")
public class CategoryEntity extends PanacheEntityBase {

    @Id
    @SequenceGenerator(
            name = "categorySeq",
            sequenceName = "category_cat_id_seq",
            schema = "public",
            initialValue = 15,
            allocationSize = 1)
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "categorySeq")
    @Column(name = "catid", nullable = false)
    public int id;
    @Column(name = "catgroup", nullable = false, length = 10)
    public String group;
    @Column(name = "catname", nullable = false, length = 10)
    public String name;
    @Column(name = "catdesc", nullable = false, length = 50)
    public String description;
}