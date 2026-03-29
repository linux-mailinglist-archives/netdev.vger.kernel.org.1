Return-Path: <netdev+bounces-272867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLDWE0HuyGnSsQUAu9opvQ
	(envelope-from <netdev+bounces-272867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:17:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B781A351512
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D213300B549
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C851A239A;
	Sun, 29 Mar 2026 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KJhk2qyR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936D40DFCF
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774775869; cv=none; b=GLzekBTarK5PuJtNWYJQUPcaNlqiYC7qMx9TVpW6pBKf/JAJEQ2hOzgyoIQW5YNvnmt3lNUl11vPxQ19mgCk/arQm9y0+3c9qQuI4CyCBLIbxOwXKiQOcWJVGchLhSq7S21MXOqKXEhM8xrNiB+TtkU66dkJVHCTe1rdlQECxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774775869; c=relaxed/simple;
	bh=4b2+y3ILPE6Hf6XLRvd9crGrXVa7Nh/lNyB2hO0ixlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7cJewl4i3sYO+sbeF5GeBNOXPc6qqiD3Yb3Op3DVss7jQ/P+EDscC+2cUs86J74yFFKufQS9xYX6rsMGGmJSsZh8pjYcnZXKEg0gCPe16Cmw/T3+RxNwiTLGRBN/ltk+UwjcA1gIky1XzEIlnKnZplntCbwvvp9PyvtUGJ8ChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KJhk2qyR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9I9pWg1qiYfKGe+2u/Y2VqDef17Cucv2X9t5EHG/VHY=; b=KJhk2qyRb7hH9av5+qNwazNMTy
	/H/qCrwEypVy856dDzpTdNFAtkcNVVQQWMdtn7PtGZYzaC2M+en5DweQT9uriJql4SxDEPNXy1afc
	IytMSDELrmpfTx2w5SOY1FyFkgEOP36SNOVZ+6c0NPtSLbySQp4X2sqBWSsMYUKwnQVgm82tUpQBs
	Z+0NndiXiAcvInuKxbhUyAWkOxf184wn1GmoKnXd10wwoCrlsZWXbr1XnugFhNp2iWsmMocE8eNzN
	kFprirWTNz3gnTt0Cvn5AwxRcd+cgozm5qwxDdjJe5iYKCGu3FsQuQjxBm9jJrhicQAP0J6w3YjyF
	4QLWLwLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47022)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6mH7-000000007oq-2vj2;
	Sun, 29 Mar 2026 10:17:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6mH6-000000001bg-0198;
	Sun, 29 Mar 2026 10:17:40 +0100
Date: Sun, 29 Mar 2026 10:17:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 06/10] net: stmmac: simplify GSO/TSO test in
 stmmac_xmit()
Message-ID: <acjuM_ryTVHU9Ib_@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
 <E1w6bL9-0000000ELu9-1quN@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w6bL9-0000000ELu9-1quN@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272867-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.657];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: B781A351512
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 09:37:07PM +0000, Russell King (Oracle) wrote:
> +static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
> +{
> +	if (!tso) {
> +		priv->gso_enabled_types = 0;
> +	} else {
> +		/* Manage oversized TCP frames for GMAC4 device */
> +		priv->gso_enabled_types = SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
> +		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
> +			priv->gso_enabled_types |= SKB_GSO_UDP_L4;

I've been wondering whether keying all three of these off NETIF_F_TSO
is correct. Shouldn't SKB_GSP_UDP_L4 be dependent on NETIF_F_GSO_UDP_L4?

(The above code doesn't change the current driver behaviour, so this
would be a separate fix.)

> +	}
> +}
> +
>  /**
>   *  stmmac_tso_xmit - Tx entry point of the driver for oversized frames (TSO)
>   *  @skb : the socket buffer
> @@ -4671,7 +4683,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  	u32 queue = skb_get_queue_mapping(skb);
>  	int nfrags = skb_shinfo(skb)->nr_frags;
>  	unsigned int first_entry, tx_packets;
> -	int gso = skb_shinfo(skb)->gso_type;
>  	struct stmmac_txq_stats *txq_stats;
>  	struct dma_desc *desc, *first_desc;
>  	struct stmmac_tx_queue *tx_q;
> @@ -4683,14 +4694,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
>  		stmmac_stop_sw_lpi(priv);
>  
> -	/* Manage oversized TCP frames for GMAC4 device */
> -	if (skb_is_gso(skb) && priv->tso) {
> -		if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
> -			return stmmac_tso_xmit(skb, dev);
> -		if (priv->plat->core_type == DWMAC_CORE_GMAC4 &&
> -		    (gso & SKB_GSO_UDP_L4))
> -			return stmmac_tso_xmit(skb, dev);
> -	}
> +	if (skb_is_gso(skb) &&
> +	    skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
> +		return stmmac_tso_xmit(skb, dev);

I'm also wondering whether we should check gso_type in our
.ndo_features_check() method rather than here - if we get a GSO skb at
this point for a type that we don't recognise, surely it is wrong to
pass it via the normal skb transmission flow.

Yet more worms in the stmmac can... :/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

