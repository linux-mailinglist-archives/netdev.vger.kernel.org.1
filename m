Return-Path: <netdev+bounces-17886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A61753648
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5CA2817B0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140EDF4C;
	Fri, 14 Jul 2023 09:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE1D51F
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:19:01 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3930F5
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:18:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68336d06620so1646757b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689326329; x=1691918329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUv90nnhiN+x9a2O6KodgrFsOaGmTeKB9IpGOgitHTo=;
        b=FLyyzw3Dg5jGvyTfycKrUEtfkYYuq7D32PiQlmQTxZd/3UDmDpqqFM2TRHtBEQM5rZ
         FxzoPvahhd9RNnrHeoPQe9f/ErkLYbVPqyfxw8Jutqdd9CtKHGEaLg4aQKtLDRqLj+US
         16rJ1VgJETcHsyjSVKrq5pf/3KUliT/4o8gSKmXHOcmpkcbdMKxmuEJbAyz1suaowocW
         fTQ5rTjn/HEF2CILdz2zqLi2nPpoja183+fTStSy15gt6oSjCQDVLO2RMYxT3hrb5mxi
         bUASj0oOAr2cIQfw9yCn4fEb6pwmmgbX2v1rbCYuTQo0ojh/5J2P6t58J64ZCr5x67qb
         0rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689326329; x=1691918329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUv90nnhiN+x9a2O6KodgrFsOaGmTeKB9IpGOgitHTo=;
        b=W4ixItfcXkkgTTyO0f4qLcPiWzd5cgT789U+jH1Z7PZaKwB5nRt4owjHNFwk1x9VIp
         d6+aAAb9DSn/hgtInSdsR/JsCKGVzYcU+rpiO/rX2Z1Zg15hcvnHMKsPLYDu42L82Uc3
         30MymbIgO6jomFvd9n/fZTrWvF0a8D1YaK2vnIkbsWfRdN4aFCQj+ZngPRuap21fJAnQ
         fMlZ+1u3ZnQwF03XW3PsMLj/EV2cEXSmLl2nkk/f0kC34g0lzNyXyPXF/K4i/pEFC9ZH
         AJMTXnk6M3X0x/WVhbbxPb5ul+Ama4Gf2YJBs0wNUIEVCd5HA2ZPB9BBWUOt8/XFKwL/
         0cLw==
X-Gm-Message-State: ABy/qLaQy5Ce6E2kF+HpAZhmlOH8ajT8QT2Hp1F1DJ+B1nxij7Zcj+Eu
	s42y/IZy975SJMCpr+Kv2eSN60XOLLcO/w==
X-Google-Smtp-Source: APBJJlECdPLUa+rM/XeeBVglUa76sz01+tPvss2UTXm53LuaIH7eq++v/W8nPDWpMf2SUU3NDF42Ig==
X-Received: by 2002:a05:6a00:240f:b0:64c:4f2f:a235 with SMTP id z15-20020a056a00240f00b0064c4f2fa235mr4656714pfh.30.1689326328662;
        Fri, 14 Jul 2023 02:18:48 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id ff10-20020a056a002f4a00b00682a75a50e3sm6986046pfb.17.2023.07.14.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:18:47 -0700 (PDT)
Date: Fri, 14 Jul 2023 17:18:44 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org
Subject: Re: [Discuss] IPv4 packets lost with macvlan over bond alb
Message-ID: <ZLES9MiudlFMvfKo@Laptop-X1>
References: <ZHmjlzbRi0nHUuTU@Laptop-X1>
 <ZIFOY02zi9FZ+aNh@Laptop-X1>
 <1816.1686966353@famine>
 <CAPwn2JRuU0+XEOnsETjrOpRi4YYXT+BemsaH1K5cAOnP4G-Wvw@mail.gmail.com>
 <1272.1687398130@famine>
 <ZJfuo6eyNbj29BcV@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJfuo6eyNbj29BcV@Laptop-X1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jay,

Any thoughts for my last reply?

Thanks
Hangbin
On Sun, Jun 25, 2023 at 03:37:10PM +0800, Hangbin Liu wrote:
> Hi Jay,
> On Wed, Jun 21, 2023 at 06:42:10PM -0700, Jay Vosburgh wrote:
> > 	By default, yes, VLANs use the same MAC, but may use a different
> > MAC than the device the VLAN is configured above.  However, changing the
> > VLAN's MAC address in a similar test case (VLAN above balance-alb bond)
> > still works, because VLAN packets are delivered by matching the VLAN ID
> > (via vlan_do_receive() -> vlan_find_dev()), not via the MAC address.
> > 
> > 	So, the RLB MAC edits done by rlb_arp_xmit() work in the sense
> > that traffic flows, even though peers see a MAC address from the bond
> > for the VLAN IP, not the VLAN's actual MAC address.
> > 
> > 	A bridge can also use a MAC address that differs from the bond,
> > but rlb_arp_xmit() has a special case for bridge, and doesn't alter the
> > ARP if the relevant IP address is on a bridge (so, no balancing).
> > 
> > 	Changing rlb_arp_xmit() to add macvlan to the bridge check makes
> > the test case pass, e.g.,
> > 
> > diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> > index b9dbad3a8af8..f720c419dfb7 100644
> > --- a/drivers/net/bonding/bond_alb.c
> > +++ b/drivers/net/bonding/bond_alb.c
> > @@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
> >  
> >  	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
> >  	if (dev) {
> > -		if (netif_is_bridge_master(dev)) {
> > +		if (netif_is_bridge_master(dev) || netif_is_macvlan(dev)) {
> 
> This is not enough. As a common usecase is to attach the macvlan to another
> namespace(Apologise that my reproducer only has a comment, but no set the macvlan
> to a separate namespace). So ip_dev_find() could not find the macvlan dev.
> 
> Using netif_is_macvlan_port() could make sure the bonding is under macvlan
> devices. But what if there are middle devices between bond and macvlan? Maybe
> we need to check each upper device?
> 
> If we want to skip arp xmit for macvlan, it looks like a partial revert of
> 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds"), which
> means we can keep the TLB part and revert the RLB modification.
> 
> 
> So my draft patch is:
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index b9dbad3a8af8..c27f1a78a94b 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -663,7 +663,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
>  	/* Don't modify or load balance ARPs that do not originate locally
>  	 * (e.g.,arrive via a bridge).
>  	 */
> -	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
> +	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
>  		return NULL;
>  
>  	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
> @@ -960,7 +960,6 @@ static int alb_upper_dev_walk(struct net_device *upper,
>  			      struct netdev_nested_priv *priv)
>  {
>  	struct alb_walk_data *data = (struct alb_walk_data *)priv->data;
> -	bool strict_match = data->strict_match;
>  	const u8 *mac_addr = data->mac_addr;
>  	struct bonding *bond = data->bond;
>  	struct slave *slave = data->slave;
> @@ -979,10 +978,7 @@ static int alb_upper_dev_walk(struct net_device *upper,
>  		}
>  	}
>  
> -	/* If this is a macvlan device, then only send updates
> -	 * when strict_match is turned off.
> -	 */
> -	if (netif_is_macvlan(upper) && !strict_match) {
> +	if (netif_is_macvlan(upper)) {
>  		tags = bond_verify_device_path(bond->dev, upper, 0);
>  		if (IS_ERR_OR_NULL(tags))
>  			BUG();
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 59955ac33157..6e4e406d8cd2 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -724,23 +724,14 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
>  }
>  
>  /* Caller must hold rcu_read_lock() for read */
> -static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
> +static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
>  {
>  	struct list_head *iter;
>  	struct slave *tmp;
> -	struct netdev_hw_addr *ha;
>  
>  	bond_for_each_slave_rcu(bond, tmp, iter)
>  		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
>  			return true;
> -
> -	if (netdev_uc_empty(bond->dev))
> -		return false;
> -
> -	netdev_for_each_uc_addr(ha, bond->dev)
> -		if (ether_addr_equal_64bits(mac, ha->addr))
> -			return true;
> -
>  	return false;
>  }
>  
> 
> If we want to keep the macvlan support for ALB, as I said, the second way
> is restore the macvlan mac address when receive message for macvlan port, e.g.:
> I didn't test which way affect the performance more.
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index edbaa1444f8e..379d4c139b23 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1585,6 +1585,36 @@ static rx_handler_result_t bond_handle_frame(struct sk_buff **pskb)
>  				  bond->dev->addr_len);
>  	}
>  
> +	if (BOND_MODE(bond) == BOND_MODE_ALB &&
> +	    netif_is_macvlan_port(bond->dev) &&
> +	    skb->pkt_type == PACKET_HOST) {
> +		struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
> +		struct rlb_client_info *client_info;
> +		u32 hash_index;
> +
> +		spin_lock_bh(&bond->mode_lock);
> +
> +		hash_index = bond_info->rx_hashtbl_used_head;
> +		for (; hash_index != RLB_NULL_INDEX;
> +		     hash_index = client_info->used_next) {
> +
> +			client_info = &(bond_info->rx_hashtbl[hash_index]);
> +
> +			if (ip_hdr(skb)->saddr == client_info->ip_dst &&
> +			    ip_hdr(skb)->daddr == client_info->ip_src) {
> +
> +				if (unlikely(skb_cow_head(skb, skb->data - skb_mac_header(skb)))) {
> +					kfree_skb(skb);
> +					return RX_HANDLER_CONSUMED;
> +				}
> +				bond_hw_addr_copy(eth_hdr(skb)->h_dest,
> +						  client_info->mac_src, ETH_ALEN);
> +			}
> +		}
> +
> +		spin_unlock_bh(&bond->mode_lock);
> +	}
> +
>  	return ret;
>  }
>  
> 
> Thanks
> Hangbin

