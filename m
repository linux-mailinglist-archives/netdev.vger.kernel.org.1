Return-Path: <netdev+bounces-298914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NR1TGoILLWrmZgQAu9opvQ
	(envelope-from <netdev+bounces-298914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:49:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED367E067
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:49:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=IQpKBRcq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298914-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298914-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F453031EB1
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B03C3BF7;
	Sat, 13 Jun 2026 07:49:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3281378826;
	Sat, 13 Jun 2026 07:49:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336957; cv=none; b=hd5tE5WTzRF+dcCmZFQaMhCXuJZ7U7dfV5G/XyyG177ilSzBbPDTz5I/ZXV6RXoQSaPOnL77bdgjEGrNIx/3+/mGvz3vt+vEkat5xAv02C8HwHgbgHFRJ+oz2Puoy2hOPdN0apZNzqT4bqNBwCBCs8zpX+GIBS6dbGvZxt1Kz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336957; c=relaxed/simple;
	bh=D/4YaXv6O68pLDVMMQNbaIxbc6megPfDRlzPP+EAV24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc4rs5lgXPpx1EKaYrMumZpTmhwIzom5sgCzxBTJCqmt4k390yVziYFlaYNmjX73NUSN7GxT7Fo/NE3ErlGYrg1HDGDbgxtzrqVxcT0vD9wY3C8cSuMmPxQhYeybQdqzqTBImu1qrT4g9rQtcoaDJruvBNPqDuz0mseOaoub1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IQpKBRcq; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ijozv1/zYB/1FW5r3iA6BSCWEsMm1mHuR8XAqmCPWx4=; b=IQpKBRcqQLSbefm3KDuxhfWcFc
	BgLCoBRK4g/QV7+3gQR1kTDZyHg3RUkT0NcxAdhym2ecnyz7JtlbTzqr/rVGg3fbKd4Dv5KM4aBmG
	BtIjToxReUvu8qIlJIKCuzKB8oKl7oarePJmPKIP0sco0QIbFQ1XdAbyZjytECiCpw80=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wYJ6k-007RqY-AP; Sat, 13 Jun 2026 09:48:46 +0200
Date: Sat, 13 Jun 2026 09:48:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com, horms@kernel.org, lee@kernel.org
Subject: Re: [PATCH net-next v8 3/6] net: stmmac: eic7700: make RGMII delay
 properties optional
Message-ID: <30229cfe-b395-4d0f-81ef-eb780ac26599@lunn.ch>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
 <20260610012937.911-1-lizhi2@eswincomputing.com>
 <eaa645fc-be06-4a15-8c2f-6e82129c4715@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa645fc-be06-4a15-8c2f-6e82129c4715@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298914-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:lizhi2@eswincomputing.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lee@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,einfochips.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,eswincomputing.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02ED367E067

On Wed, Jun 10, 2026 at 10:26:50AM +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 6/10/26 03:29, lizhi2@eswincomputing.com wrote:
> > From: Zhi Li <lizhi2@eswincomputing.com>
> > 
> > Make rx-internal-delay-ps and tx-internal-delay-ps optional in the
> > EIC7700 DWMAC driver.
> > 
> > The driver previously required both properties to be present and would
> > fail probe when they were missing. This restricts valid hardware
> > configurations where RGMII timing is instead provided by the PHY or
> > board design.
> > 
> > Update the driver to treat missing delay properties as zero delay,
> > allowing systems without explicit MAC-side delay tuning to operate
> > correctly.
> > 
> > This aligns the driver behavior with the updated device tree binding
> > and provides a safe default configuration when MAC-side delay
> > programming is not required.
> > 
> > Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> > index 4ac979d874d6..ec99b597aeaf 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> > @@ -165,9 +165,6 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
> >  		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
> >  		dwc_priv->eth_clk_dly_param |=
> >  				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
> > -	} else {
> > -		return dev_err_probe(&pdev->dev, -EINVAL,
> > -			"missing required property rx-internal-delay-ps\n");
> >  	}
> >  
> >  	/* Read tx-internal-delay-ps and update tx_clk delay */
> > @@ -187,9 +184,6 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
> >  		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
> >  		dwc_priv->eth_clk_dly_param |=
> >  				 FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
> > -	} else {
> > -		return dev_err_probe(&pdev->dev, -EINVAL,
> > -			"missing required property tx-internal-delay-ps\n");
> >  	}
> 
> I think then you need to handle RGMII, RGMII_ID, RGMII_RXID and RGMII_TXID,
> by using default delays for these (usually around 2ns), as here all delays
> will be set to 0, regardless of the RGMII mode in use.

No. By default, the MAC adds 0ns delay, and passes the phy-mode to the
PHY. It will then add the 2ns delay. It is possible to use the
tx-internal-delay-ps and rx-internal-delay-ps in the MAC to add small
tuning delays, but not the full 2ns.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

	Andrew

