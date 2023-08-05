Return-Path: <netdev+bounces-24645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20757770EC0
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC91282572
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59478487;
	Sat,  5 Aug 2023 08:25:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE7523A2
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 08:25:16 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6210CF
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:25:14 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a78a29bccbso248346b6e.0
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691223914; x=1691828714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQrkBGsxn/ZPSXp51aGyX6RqPiZoziqwF/d5IIUZ7Kg=;
        b=XHRqf4whMgPYpdX9xE25jLxoyEnmlQUJNcCkNtyFF4sQWzXGRBUhtOr3i47rC52e4u
         WK7NTlyJY+sgQkWBMap2Wbu2pDm2BP81xCj+RBMSxB7e9l/fKGoWizYo2E/UhdeCWbyM
         oqjw9+vQa0xffsC44aSNiImgvqlSjeJgODwcmEQ5EXWfycq+LOPIPsLFsdqNAamT7v35
         HPXYNZxWri7keUeinqzUJOyjOz8xrd2LUpaL2NrVKCIz+CBuxU5IsRkNBhDIlHqOOYP7
         DKZTJYcT7bQ6AOPQJ/mdBliuqlfv33WS7J+gV++VktmgdVwn/Ir8STkWIrNAIfaozvf+
         8jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691223914; x=1691828714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQrkBGsxn/ZPSXp51aGyX6RqPiZoziqwF/d5IIUZ7Kg=;
        b=XS1Wdx5Mcc6Sg5iAXqssq7Celr3eb74h/muxWkV9zFlk43VBPIRDoCGx5plQGAuvgI
         mq3vVnn9Gy3y863DDXqK33R/UjUNJAVjZUGsMCTRV3ewzW8+VZ15xkjeMroUv+HZ+02+
         oGM/wN9P6k+ZQ30sltizAawzsK9V4fVZxCOx4L5e0GPLgmD7n5NOWpvY87v05J1PbRYM
         NtCcbcezd/Sec6GyrirWjZqx3hek7HnLZdOE9xj4JctB0oQtEToQVTDj9ovrRw+H3BLE
         ZLRCXa+8D2TWzMegJszaCASAT2mmpWTCdfK3m5rjF9utC4Iq3+BSDEQC0X2n4VHczUhj
         mTqw==
X-Gm-Message-State: AOJu0YwD1ng8tKPeNEXNH3jpI/+/KmRdBgPGd+jytvw5IsAH62YYOY7I
	VOb32H2CCGZ4wmrNRhLCszAcvltFe+JL6Q==
X-Google-Smtp-Source: AGHT+IGyeEIFZVqSSB+7fFo19anxkwckuU+HzMyKfMZbh3D1IGPFr2gRJVoeVpEwfE/vVOz/SSeVow==
X-Received: by 2002:a05:6808:2381:b0:3a7:3a2e:e498 with SMTP id bp1-20020a056808238100b003a73a2ee498mr6035317oib.33.1691223913968;
        Sat, 05 Aug 2023 01:25:13 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w21-20020aa78595000000b00686236718d8sm2676824pfn.41.2023.08.05.01.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 01:25:13 -0700 (PDT)
Date: Sat, 5 Aug 2023 16:25:09 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org
Subject: Re: [Discuss] IPv4 packets lost with macvlan over bond alb
Message-ID: <ZM4HZUtk6jDJVjqJ@Laptop-X1>
References: <ZHmjlzbRi0nHUuTU@Laptop-X1>
 <ZIFOY02zi9FZ+aNh@Laptop-X1>
 <1816.1686966353@famine>
 <CAPwn2JRuU0+XEOnsETjrOpRi4YYXT+BemsaH1K5cAOnP4G-Wvw@mail.gmail.com>
 <1272.1687398130@famine>
 <ZJfuo6eyNbj29BcV@Laptop-X1>
 <ZLES9MiudlFMvfKo@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLES9MiudlFMvfKo@Laptop-X1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 05:18:48PM +0800, Hangbin Liu wrote:
> Hi Jay,
> 
> Any thoughts for my last reply?

Ping

> 
> Thanks
> Hangbin
> On Sun, Jun 25, 2023 at 03:37:10PM +0800, Hangbin Liu wrote:
> > Hi Jay,
> > On Wed, Jun 21, 2023 at 06:42:10PM -0700, Jay Vosburgh wrote:
> > > 	By default, yes, VLANs use the same MAC, but may use a different
> > > MAC than the device the VLAN is configured above.  However, changing the
> > > VLAN's MAC address in a similar test case (VLAN above balance-alb bond)
> > > still works, because VLAN packets are delivered by matching the VLAN ID
> > > (via vlan_do_receive() -> vlan_find_dev()), not via the MAC address.
> > > 
> > > 	So, the RLB MAC edits done by rlb_arp_xmit() work in the sense
> > > that traffic flows, even though peers see a MAC address from the bond
> > > for the VLAN IP, not the VLAN's actual MAC address.
> > > 
> > > 	A bridge can also use a MAC address that differs from the bond,
> > > but rlb_arp_xmit() has a special case for bridge, and doesn't alter the
> > > ARP if the relevant IP address is on a bridge (so, no balancing).
> > > 
> > > 	Changing rlb_arp_xmit() to add macvlan to the bridge check makes
> > > the test case pass, e.g.,
> > > 
> > > diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> > > index b9dbad3a8af8..f720c419dfb7 100644
> > > --- a/drivers/net/bonding/bond_alb.c
> > > +++ b/drivers/net/bonding/bond_alb.c
> > > @@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
> > >  
> > >  	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
> > >  	if (dev) {
> > > -		if (netif_is_bridge_master(dev)) {
> > > +		if (netif_is_bridge_master(dev) || netif_is_macvlan(dev)) {
> > 
> > This is not enough. As a common usecase is to attach the macvlan to another
> > namespace(Apologise that my reproducer only has a comment, but no set the macvlan
> > to a separate namespace). So ip_dev_find() could not find the macvlan dev.
> > 
> > Using netif_is_macvlan_port() could make sure the bonding is under macvlan
> > devices. But what if there are middle devices between bond and macvlan? Maybe
> > we need to check each upper device?
> > 
> > If we want to skip arp xmit for macvlan, it looks like a partial revert of
> > 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds"), which
> > means we can keep the TLB part and revert the RLB modification.
> > 
> > 
> > So my draft patch is:
> > 
> > diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> > index b9dbad3a8af8..c27f1a78a94b 100644
> > --- a/drivers/net/bonding/bond_alb.c
> > +++ b/drivers/net/bonding/bond_alb.c
> > @@ -663,7 +663,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
> >  	/* Don't modify or load balance ARPs that do not originate locally
> >  	 * (e.g.,arrive via a bridge).
> >  	 */
> > -	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
> > +	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
> >  		return NULL;
> >  
> >  	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
> > @@ -960,7 +960,6 @@ static int alb_upper_dev_walk(struct net_device *upper,
> >  			      struct netdev_nested_priv *priv)
> >  {
> >  	struct alb_walk_data *data = (struct alb_walk_data *)priv->data;
> > -	bool strict_match = data->strict_match;
> >  	const u8 *mac_addr = data->mac_addr;
> >  	struct bonding *bond = data->bond;
> >  	struct slave *slave = data->slave;
> > @@ -979,10 +978,7 @@ static int alb_upper_dev_walk(struct net_device *upper,
> >  		}
> >  	}
> >  
> > -	/* If this is a macvlan device, then only send updates
> > -	 * when strict_match is turned off.
> > -	 */
> > -	if (netif_is_macvlan(upper) && !strict_match) {
> > +	if (netif_is_macvlan(upper)) {
> >  		tags = bond_verify_device_path(bond->dev, upper, 0);
> >  		if (IS_ERR_OR_NULL(tags))
> >  			BUG();
> > diff --git a/include/net/bonding.h b/include/net/bonding.h
> > index 59955ac33157..6e4e406d8cd2 100644
> > --- a/include/net/bonding.h
> > +++ b/include/net/bonding.h
> > @@ -724,23 +724,14 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
> >  }
> >  
> >  /* Caller must hold rcu_read_lock() for read */
> > -static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
> > +static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
> >  {
> >  	struct list_head *iter;
> >  	struct slave *tmp;
> > -	struct netdev_hw_addr *ha;
> >  
> >  	bond_for_each_slave_rcu(bond, tmp, iter)
> >  		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
> >  			return true;
> > -
> > -	if (netdev_uc_empty(bond->dev))
> > -		return false;
> > -
> > -	netdev_for_each_uc_addr(ha, bond->dev)
> > -		if (ether_addr_equal_64bits(mac, ha->addr))
> > -			return true;
> > -
> >  	return false;
> >  }
> >  
> > 
> > If we want to keep the macvlan support for ALB, as I said, the second way
> > is restore the macvlan mac address when receive message for macvlan port, e.g.:
> > I didn't test which way affect the performance more.
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index edbaa1444f8e..379d4c139b23 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -1585,6 +1585,36 @@ static rx_handler_result_t bond_handle_frame(struct sk_buff **pskb)
> >  				  bond->dev->addr_len);
> >  	}
> >  
> > +	if (BOND_MODE(bond) == BOND_MODE_ALB &&
> > +	    netif_is_macvlan_port(bond->dev) &&
> > +	    skb->pkt_type == PACKET_HOST) {
> > +		struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
> > +		struct rlb_client_info *client_info;
> > +		u32 hash_index;
> > +
> > +		spin_lock_bh(&bond->mode_lock);
> > +
> > +		hash_index = bond_info->rx_hashtbl_used_head;
> > +		for (; hash_index != RLB_NULL_INDEX;
> > +		     hash_index = client_info->used_next) {
> > +
> > +			client_info = &(bond_info->rx_hashtbl[hash_index]);
> > +
> > +			if (ip_hdr(skb)->saddr == client_info->ip_dst &&
> > +			    ip_hdr(skb)->daddr == client_info->ip_src) {
> > +
> > +				if (unlikely(skb_cow_head(skb, skb->data - skb_mac_header(skb)))) {
> > +					kfree_skb(skb);
> > +					return RX_HANDLER_CONSUMED;
> > +				}
> > +				bond_hw_addr_copy(eth_hdr(skb)->h_dest,
> > +						  client_info->mac_src, ETH_ALEN);
> > +			}
> > +		}
> > +
> > +		spin_unlock_bh(&bond->mode_lock);
> > +	}
> > +
> >  	return ret;
> >  }
> >  
> > 
> > Thanks
> > Hangbin

