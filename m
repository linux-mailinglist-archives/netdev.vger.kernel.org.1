Return-Path: <netdev+bounces-264816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH4+MEPkqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:27:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D23222A6D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C09D30ABBB7
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B073AE6E9;
	Fri,  6 Mar 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OqrV2kLP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6B3AE19C;
	Fri,  6 Mar 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806970; cv=none; b=lYNtLsPhfmDmyvL5MCkDRu9s7swo+RETWOhpkAKlvHd6I++qeSHJyYU6/NBSQBoHUFvpPxS5scCx9SY3FqZi2/Fh4ZhJ7/io+SpH2zt9yi/PiF9KXiui+GJqvmFrspJyxmX6Ll1TSRrDu/Hw5kHUnHFCpe+amSdEltmrs8f6fHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806970; c=relaxed/simple;
	bh=lr62eg/yQj6IZ/4UWLRsanCqEf0V+VNvikqmxUvGP50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7W3/caIDrk4q+/37foDriEB8+KsuuTKZl/mrnTJRfPFfqjVPZitodcujEfyJhsBOKhyAzCpXPkHmR0p/6W3dtJ1OQG8GF2rBlmcS1L6fFYQSKkf+iK7SM4BZAQuMaUAOF4RXRJH9ZZGdbvbC47GAelPY21qVJiMvOk1s+pPUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OqrV2kLP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Oav2I00FXUykFElmVCbBYXHqmVVnU2FMhl9aCXemvI=; b=OqrV2kLPU6zYICjhuOma14NfXH
	pXEu8FV0LZz1jLWhvIgyLbLttFQuiZ9nasMcryAsn44lWCSym1A02EtENFkeEttBO00UQSD9heX5X
	YNKz2oGRib1nHgHuMvJMMuNuuajiq8D/SilJcapK/UlsSsY4KiaSimHJGkhkepWipPqmJvVXnjkAu
	QvVRCrkumW8lvYY5kFfmknHnEFoaZQEaChfgVbQBZDCIZYVXXECOaMlDFRnAuXU33mNhJAkUYtxPG
	6/Y3ksqIQtRNg05cFPZ+4SzhZjQpuNxnkOU+EWRMDqq9YCh69l8EW+hflry4VfjRWFLjDJVJlnQP6
	a8DkAPDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39700)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vyW4H-0000000018R-0SQ6;
	Fri, 06 Mar 2026 14:22:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vyW4E-000000001Th-2OCc;
	Fri, 06 Mar 2026 14:22:14 +0000
Date: Fri, 6 Mar 2026 14:22:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <aarjFiS6NX_7glkr@shell.armlinux.org.uk>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
 <aahWu2-3YT92vMuC@shell.armlinux.org.uk>
 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
 <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 48D23222A6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264816-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.298];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,armlinux.org.uk:url]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 03:58:16PM +0100, Andrew Lunn wrote:
> > > > +     /* We configure delays on the MAC side. When the PHY is not responsible
> > > > +      * for delays, the MAC is, which is why RGMII_TXID results in
> > > > +      * rx_delay=true.
> > > > +      */
> > > > +     if (mode == PHY_INTERFACE_MODE_RGMII ||
> > > > +         mode == PHY_INTERFACE_MODE_RGMII_TXID)
> > > > +             rx_delay = true;
> > > > +
> > > > +     if (mode == PHY_INTERFACE_MODE_RGMII ||
> > > > +         mode == PHY_INTERFACE_MODE_RGMII_RXID)
> > > > +             tx_delay = true;
> > > 
> > > PHY_INTERFACE_MODE_RGMII means that the delays are provided by the
> > > board layout, so this seems wrong to me. Please review the phylib
> > > documentation concerning RGMII delays. I'd like Andrew to comment on
> > > this too.
> > > 
> > 
> > The idea with this was, if the PHY does not provide internal delay, then
> > we do it in the MAC.
> 
> That is not really what we want. The default in Linux is that the PHY
> adds the delays. In general, MAC drivers read the phy-mode, and pass
> it directly to the PHY. The MAC does not add delays. There are a small
> number of boards which don't respect this. In the past, there was been
> claims that an RDK used a PHY which was not capable of adding the
> needed delays, so the MAC had to. In practice, all the PHY drivers in
> linux which supporting RGMII support all four configurations of
> delays.

Unfortunately, I've discovered another case - dwmac-qcom-ethqos::
ethqos_rgmii_macro_init():

        /* Determine if the PHY adds a 2 ns TX delay or the MAC handles it */
        if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
            ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
                phase_shift = 0;
        else
                phase_shift = RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN;

This code was added by 164a9ebe9742 ("net: stmmac: dwmac-qcom-ethqos:
Respect phy-mode and TX delay") which doesn't have any acks from
phylib folk. However, before this commit, the driver always added the
transmit delay.

Sadly, too late to do anything about this now. :(

Should a regexp be added to MAINTAINERS phylib entry to detect patches
which contain PHY_INTERFACE_MODE_RGMII?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

