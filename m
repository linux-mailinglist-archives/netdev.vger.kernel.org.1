Return-Path: <netdev+bounces-261041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ5NNGE2n2m5ZQQAu9opvQ
	(envelope-from <netdev+bounces-261041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:50:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3719BC85
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA10B302EC9C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584642D5C83;
	Wed, 25 Feb 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eo67cY3v"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C714433B3
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041822; cv=none; b=Zwje1w/f43j9I9iccBLxd4k5zta6ygBQa6MvKMqvkM2K2VB8pv3a7C4AZe2x/OrIbKIGTZVQ19466ONofX4ViIWrIx571c3DfsdVwXnQHw9XCGbz5LurdUf4qBPMZoKN0xUPruZ18cgAf7OFsXMwemWBXBpRCcMTphUI5PTOHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041822; c=relaxed/simple;
	bh=bk58F2GzH/RlTRTTtPRboEFPupA02RhtI9p7QHOCNSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SciAX24IZFNfjPt57OHH+EnBQAB6HOQ3Xf/+nOuJD1h1JH30A37jl5t4+OS0fvZaU9L+BXOcVipOOGs4g+TdVNwCiWi+sIqVXEK5h90uSTb+SBBFTUy1ZS/8VkbsWjPdIIbzWb72RYT/wVwVhtOPJPrNpjt2i16eTsu4ZK9hLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eo67cY3v; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EQQY3uqd3zLWuRKt8lN5oNMmp8hnL6v12hW4GdilSfQ=; b=eo67cY3vb2phmPo19cUVuczCFF
	RR5w2RJp6t1jQ2175sprEaCb6MLALA+R1zop6f8OOaM/WakBqG1X67msUjE6ZlvFryd3wmeyrhFAd
	T9ySH9vw6L1lTjFw+TaLdA0qYdCwQ6bJpG0nrlH6l6rDUn4suuDN8GqP/4PlbEkBRw4dumWH9km2s
	IstfaqJ322CblAaDN1d2RVK8ApR9YEDQnv4Rvpz0fiJ90VnsYGoHqJt9QAhFVd7MROiXAUYkJOBCZ
	7LDW5/6MSdibPnkDEAAshWAvaQFnlYO3OYE5WrL4G9JO/CIc37H7K5zYGRiHDyge96c8ulD8ouPZ2
	LdZRVa5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59194)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvJ1c-000000006zk-0hUf;
	Wed, 25 Feb 2026 17:50:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvJ1Z-0000000019d-0lBO;
	Wed, 25 Feb 2026 17:50:13 +0000
Date: Wed, 25 Feb 2026 17:50:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	nicolas.ferre@microchip.com, pabeni@redhat.com,
	phil@raspberrypi.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
Message-ID: <aZ82VFPu2FDmPpJ0@shell.armlinux.org.uk>
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
 <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261041-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74B3719BC85
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:42:08PM +0100, Théo Lebrun wrote:
> On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
> > @@ -2349,6 +2454,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
> >  			     skb->len);
> >  
> > +	macb_tx_lpi_wake(bp);
> 
> Should this be protected by a bp->eee_active condition? It could go
> in macb_tx_lpi_wake(). We avoid a spinlock acquire per xmit for most
> platforms. Probably negligeable though.

It will read the register, find the bit clear, and then return if
EEE is already disabled.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

