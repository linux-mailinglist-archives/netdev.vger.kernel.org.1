Return-Path: <netdev+bounces-272866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI5KFzHtyGlfsQUAu9opvQ
	(envelope-from <netdev+bounces-272866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:13:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B196C3514CC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2EC43030E96
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF5218821;
	Sun, 29 Mar 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DwvvAKqw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90D24B28
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774775413; cv=none; b=r8cPLGPqluiuwU+xeZtGSpf/tNmtpovqNVC37qvdWD1WRlt1abMoZwdSKFJSGqjN9jbWE3mVQCE3CYRiid30yqaGHrQcbDzpj4helvcNkEdi0Y5kT9SkjPd9iYhZOeYHb7sIBbxAw7pRLGa+9kKrCONr80v/48HEbDepmgozUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774775413; c=relaxed/simple;
	bh=fnafvc3/H1KuPxR7pjFHpbJkiOOVFMLOH8Ffs4L3lNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKf9Xq1SXNveKgbp+q5OdZee5HrCdb2c9UuXB8B8f38DRxWc/HhdHoEah8+xItWgoJphEe1HxDijQeHDaCBeAJaT35BiHxUaEx3nHhrB6PrB0lchWtMMGv5ilV14U122ufqNeIGIHw6E8svEOU2MFhGrK/917O4VYYpfOXPpnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DwvvAKqw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bIAIfKdjfZ9D4330UHAm2Itp7N2ZuoxDtpoyKFVIDuQ=; b=DwvvAKqwSmDZiTn+EP8l1kK0az
	5IjGAbasoS17h7/jIYQOHjK5wfhtORIx2vX/AAfsZA/5qFblc2A7k2BYjXxYO6+RKElzPptK4uZK0
	k3ofQGHFouVABlTcj7uklZyI7HwrlJbBOnenpg1/2o7HLUkRCSIyh0M+uTb8Q6sf+qoVuaDrjzrOP
	SMcEudc+tlbpvzO2EoNLVrprcwnmb2ra0fZubqFTdTONODqvlsOz1V67gX5FyLNEq+rhYRV/z0oy+
	hUzEiNDTkITz0fAwc8Ul79NQu60V0CHQ6iwHMKLUPO3fyBLz8DkIwOK36eOQk8S5XvknVJ1FLJjS2
	pq8gmlbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59684)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6m9f-000000007oH-2tJx;
	Sun, 29 Mar 2026 10:09:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6m9c-000000001bQ-01Th;
	Sun, 29 Mar 2026 10:09:56 +0100
Date: Sun, 29 Mar 2026 10:09:55 +0100
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
Subject: Re: [PATCH net-next 03/10] net: stmmac: move TSO VLAN tag insertion
 to core code
Message-ID: <acjsY4HtQbtvNtV-@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
 <E1w6bKu-0000000ELtr-0U6v@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w6bKu-0000000ELtr-0U6v@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272866-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.736];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: B196C3514CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 09:36:52PM +0000, Russell King (Oracle) wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e21ca1c70c6d..ed3e9515cf25 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4419,19 +4419,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	u8 proto_hdr_len, hdr;
>  	dma_addr_t des;
>  
> -	/* Always insert VLAN tag to SKB payload for TSO frames.
> -	 *
> -	 * Never insert VLAN tag by HW, since segments split by
> -	 * TSO engine will be un-tagged by mistake.
> -	 */
> -	if (skb_vlan_tag_present(skb)) {
> -		skb = __vlan_hwaccel_push_inside(skb);
> -		if (unlikely(!skb)) {
> -			priv->xstats.tx_dropped++;
> -			return NETDEV_TX_OK;
> -		}
> -	}
> -
>  	nfrags = skb_shinfo(skb)->nr_frags;
>  	queue = skb_get_queue_mapping(skb);
>  
> @@ -4932,6 +4919,14 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
>  	features = vlan_features_check(skb, features);
>  
>  	if (skb_is_gso(skb)) {
> +		/* Always insert VLAN tag to SKB payload for TSO frames.
> +		 *
> +		 * Never insert VLAN tag by HW, since segments split by
> +		 * TSO engine will be un-tagged by mistake.
> +		 */
> +		features &= ~(NETIF_F_HW_VLAN_STAG_TX |
> +			      NETIF_F_HW_VLAN_CTAG_TX);
> +

I'm wondering whether this is the correct place to do this. If as a
result of the following tests we fallback to software GSO, then we
will be submitting "normal" frames to the driver to transmit, which
means it can insert the VLAN tag in hardware.

So, I'm thinking this isn't the correct place for the test, but it
should be after the tests that disable NETIF_F_GSO_MASK and only be
masked out when the features mask still contains any of the
NETIF_F_GSO_MASK features. Anyone concur?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

