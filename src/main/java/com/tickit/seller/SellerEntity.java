package com.tickit.seller;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "seller", schema = "public", catalog = "tickit")
public class SellerEntity extends PanacheEntityBase {

    @Id
    @SequenceGenerator(
            name = "sellerSeq",
            sequenceName = "seller_seller_id_seq",
            schema = "public",
            initialValue = 50000,
            allocationSize = 1)
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "sellerSeq")
    @Column(name = "sellerid", nullable = false)
    public int id;
    @Column(name = "username", nullable = false, length = 8)
    public String username;
    @Column(name = "firstname", nullable = false, length = 30)
    public String firstName;
    @Column(name = "lastname", nullable = false, length = 30)
    public String lastName;
    @Column(name = "city", nullable = false, length = 30)
    public String city;
    @Column(name = "state", nullable = false, length = 2)
    public String state;
    @Column(name = "email", nullable = false, length = 100)
    public String email;
    @Column(name = "phone", nullable = false, length = 14)
    public String phone;
    @Column(name = "tin", nullable = false, length = 9)
    public String taxIdNumber;
}