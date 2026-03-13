Return-Path: <netdev+bounces-267638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AaSfKj+atGktrAAAu9opvQ
	(envelope-from <netdev+bounces-267638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:14:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 476FD28A9D7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8499E300AB1D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61A93876C5;
	Fri, 13 Mar 2026 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xXc7051f"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70437DEAC;
	Fri, 13 Mar 2026 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443643; cv=none; b=qILY5dHtLPJMEE9GpWlzUS1phNrHuHBkBLOv5BAbT4fkuJ6H94D6igupE1PzQPQuWdmamMXn1yRdEs24XeiVfsuPJqdr0r00v5UfvTzUW2yYOTb23WS7eRXwzqBz4++5hB8ZX0jPWBVpLSYaWEK73qf1oD/O2HtlH32DM8loR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443643; c=relaxed/simple;
	bh=e8Enhk3QXOf5yExYNdKIRG+B0oRQhLkMaPFJgAFIUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbKOOAg4kPYbSZF2wFi2YCnGGYCcwOnVApO+rjAMr/Ks7P9YtoZxx5xocljOh7fGIjDAbB/Fd/sC/63kep6jJDcEiveCHEzJ6cUfdST+a6GuGONj4+WaE0KZTVcUKR1ELwlZFAM2XnhwbcJA88ayxbRH8/VH8rTEMpH8QR9KA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xXc7051f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=888cROttyB4Mj3b/fjU2ay+60B251y1m25xcSu13rsg=; b=xXc7051f1MEEuQmjSkevTHfm/f
	RVZsc7Fd5Ygud2adC6JbbtX3Gmvt5co0Ax3Y5gXAyQdtdCV9avbke7TyZ5nzj/rOnizztf1BZkKOe
	OteMcqZE3GJC2GRj5jGTPbyGoN8HLOWvwtfziTMe8ZnCn7oIuYFIr781jB7sd3kj+qIzWIeobG8vW
	ggrGLs77qR9CY4gcyPhv3qmtzowjlqJ5D4TPPjivUbOYGYDmFdV+a3RmfIsk5GQeb7S40aXnkbNPX
	yrVGyWKdQEJYUm8Q8lhA1pLjo00eiAdN2HNX580Dha9HC7SaJGDsydNDvEH2+z37o8datC3XxZfy3
	sBJkoPRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54294)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w1BhZ-000000001bH-1R66;
	Fri, 13 Mar 2026 23:13:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w1BhR-000000000Bt-4A74;
	Fri, 13 Mar 2026 23:13:46 +0000
Date: Fri, 13 Mar 2026 23:13:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "\\Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	me@ziyao.cc, siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com, wens@kernel.org,
	vladimir.oltean@nxp.com, lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com, maxime.chevallier@bootlin.com,
	matthew.gerlach@altera.com, chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org, florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v7 2/5] net: stmmac: Add DW25GMAC support in
 stmmac core driver
Message-ID: <abSaKe3d4fcBMqLm@shell.armlinux.org.uk>
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-3-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313222206.778760-3-jitendra.vegiraju@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267638-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 476FD28A9D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 03:22:03PM -0700, \Jitendra Vegiraju wrote:
> @@ -42,13 +42,18 @@
>  #define DWXGMAC_CORE_2_20	0x22
>  #define DWXLGMAC_CORE_2_00	0x20
>  
> +#define DW25GMAC_CORE_3_20	0x32
> +#define DW25GMAC_CORE_4_00	0x40
> +

Do these live in the same versioning numberspace as DWXGMAC and
DWXLGMAC?

> +int dw25gmac_setup(struct stmmac_priv *priv)
> +{
> +	struct mac_device_info *mac = priv->hw;
> +
> +	dev_info(priv->device, "\tDW25GMAC\n");
> +
> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
> +	mac->pcsr = priv->ioaddr;
> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
> +	mac->mcast_bits_log2 = 0;
> +
> +	if (mac->multicast_filter_bins)
> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);

The above seems to be common amongst the other two setup functions.
Maybe there should be a helper for this?

> +
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
> +			 MAC_10000FD | MAC_25000FD;
> +	mac->link.duplex = 0;
> +	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
> +	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
> +	mac->link.speed1000 = XGMAC_CONFIG_SS_1000_GMII;
> +	mac->link.speed2500 = XGMAC_CONFIG_SS_2500_GMII;
> +	mac->link.xgmii.speed2500 = XGMAC_CONFIG_SS_2500;
> +	mac->link.xgmii.speed5000 = XGMAC_CONFIG_SS_5000;
> +	mac->link.xgmii.speed10000 = XGMAC_CONFIG_SS_10000;
> +	mac->link.xgmii.speed25000 = XGMAC_CONFIG_SS_25000;
> +	mac->link.speed_mask = XGMAC_CONFIG_SS_MASK;

Is there any point populating link.speed10 and link.speed100 ?
You're telling phylink that 10/100M speeds aren't supported in
link.caps, so these speeds won't ever be used.

> +
> +	mac->mii.addr = XGMAC_MDIO_ADDR;
> +	mac->mii.data = XGMAC_MDIO_DATA;
> +	mac->mii.addr_mask = GENMASK(20, 16);
> +	mac->mii.reg_mask = GENMASK(15, 0);
> +	mac->mii.clk_csr_mask = GENMASK(21, 19);

This will be the third instance of this particular mii data setup.
Please consider adding a function to do this setup.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

