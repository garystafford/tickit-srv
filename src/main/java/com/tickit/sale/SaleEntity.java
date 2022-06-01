package com.tickit.sale;

import com.tickit.buyer.BuyerEntity;
import com.tickit.listing.ListingEntity;
import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "sale", schema = "public", catalog = "tickit")
@NamedQueries({
        @NamedQuery(name = "SaleEntity.getBySellerId", query = """
                select sale, listing, seller
                from SaleEntity as sale
                    join sale.listing as listing
                    join listing.seller as seller
                where seller.id = ?1"""
        ),
        @NamedQuery(name = "SaleEntity.getByEventId", query = """
                select sale, listing, event
                from SaleEntity as sale
                    join sale.listing as listing
                    join listing.event as event
                where event.id = ?1"""
        )})
public class SaleEntity extends PanacheEntityBase {

    @Id
    @SequenceGenerator(
            name = "saleSeq",
            sequenceName = "sale_sale_id_seq",
            schema = "public",
            initialValue = 175000,
            allocationSize = 1)
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "saleSeq")
    @Column(name = "saleid", nullable = false)
    public int id;
    @Column(name = "qtysold", nullable = false)
    public short quantitySold;
    @Column(name = "pricepaid", nullable = false, precision = 2)
    public BigDecimal pricePaid;
    @Column(name = "commission", nullable = false, precision = 2)
    public BigDecimal commission;
    @Column(name = "saletime", nullable = false)
    public LocalDateTime saleTime;
    @ManyToOne(optional = false)
    @JoinColumn(name = "listid", referencedColumnName = "listid", nullable = false)
    public ListingEntity listing;
    @ManyToOne(optional = false)
    @JoinColumn(name = "buyerid", referencedColumnName = "buyerid", nullable = false)
    public BuyerEntity buyer;
}
