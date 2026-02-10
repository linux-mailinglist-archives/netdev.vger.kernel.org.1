Return-Path: <netdev+bounces-258085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GuJF8kui2lEQgAAu9opvQ
	(envelope-from <netdev+bounces-258085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:12:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3511B21F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E19713004C81
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637F3246FE;
	Tue, 10 Feb 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p6PGcWly"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3C1E832A;
	Tue, 10 Feb 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729156; cv=none; b=Wmmim4CeJOgchXhUWZY7M5z2F6jF0F4U+m1Iqo/53+nPOLskcqhOKbT4YKJSVz0YgHjLhKr0/Q94Bm9HFJhiyriWoDoP3zdPqKWyZ8y1VHq8Iu2tWizTNwQZkaWG62v4Ar330pZOnIztWgjXKhTyYa/vjFkQl1qvs7/IXAr8bOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729156; c=relaxed/simple;
	bh=UPsoSOqaxvKNL9M+dEhrRrrgolXcFxKz8S27Tx834as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRdB73fAZmbW/XxxJcu4i5HTe6pNZ+I1mUtUPsGKgk6s+vTQAyqN57Pwi3/Zt5bUV7/XFpTw0EfI8inm1/98LW4wQSHb+XEaMKTG+IqOEsHC1LE8HyKz6QzFFdmN8BQKoPqrUg0VnYQTU/DUVffvPdberXo6ylf+2HT4kPgInIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=p6PGcWly; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z1pl4mFVhB9hfg+ucrkFR1J2Wb0obC6F6Knh+u+mA90=; b=p6PGcWlyiQfZAFkq2CZ+DOPR3o
	h8dLZjcP61+iJDGRA9jqOxwbGjzEQvoPfMKLFu6cl+4ZTbmUae/ie2be/hV324xdFXfMgnyI9kfvN
	6mmD/xKm5og586Bacuz15OkBozwx4aUblkAIQaevvIVE9Gz0M+hczb6Kw8TI8p6/pJvU3VfDl38+f
	WyiHBYIiJ0decwdMgxUe/cC9sIMtplYQIz3agdqanOGbAp3crSidrbMaA9VqvCV7PPrvig0u/jQZA
	HYh4Y5fSp4kVQMahQPLQjPaV97j7/ahH3s97WNQYc7XPY5ytOtqt5XZGASd3nDJeQGFRjmNEfXyEl
	iY1nb29Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vpnXM-000000002Zp-3rxj;
	Tue, 10 Feb 2026 13:12:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vpnXI-000000002og-2bsV;
	Tue, 10 Feb 2026 13:12:12 +0000
Date: Tue, 10 Feb 2026 13:12:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v12 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
Message-ID: <aYsurPBMnzWDZCco@shell.armlinux.org.uk>
References: <20260210052226.3005666-1-a0987203069@gmail.com>
 <20260210052226.3005666-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210052226.3005666-4-a0987203069@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258085-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67C3511B21F
X-Rspamd-Action: no action

Please note that net-next is currently closed, so you should be sending
net-next patches with "RFC". See section 1.4 of:
https://docs.kernel.org/process/maintainer-netdev.html

On Tue, Feb 10, 2026 at 01:22:26PM +0800, Joey Lu wrote:
> +static int nvt_gmac_setup(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	phy_interface_t phy_mode;
> +	struct regmap *regmap;
> +	u32 macid, miscr, reg;
> +	int ret;
> +
> +	regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
> +	if (IS_ERR(regmap))
> +		ret = dev_err_probe(dev, PTR_ERR(regmap), "Failed to get sys register\n");
> +
> +	if (macid > 1)
> +		ret = dev_err_probe(dev, -EINVAL, "Invalid sys arguments\n");
> +
> +	if (of_get_phy_mode(pdev->dev.of_node, &phy_mode))
> +		ret = dev_err_probe(dev, -EINVAL, "Missing phy mode property\n");

If you pass in the plat_dat to this function, then you have access to
plat_dat->phy_interface. I went through all the dwmac glue code and
removed such PHY interface gets, so please don't introduce new
instances.

> +
> +	miscr = (macid == 0) ? NVT_REG_SYS_GMAC0MISCR : NVT_REG_SYS_GMAC1MISCR;

I find the use of "miscr" to be the register offset, and "reg" to be
the register value is confusing. Normally they're the other way around.

> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		ret = nvt_gmac_get_delay(dev, "rx-internal-delay-ps");
> +		if (ret < 0)
> +			return ret;
> +		reg = FIELD_PREP(NVT_RX_DELAY_MASK, ret);
> +
> +		ret = nvt_gmac_get_delay(dev, "tx-internal-delay-ps");
> +		if (ret < 0)
> +			return ret;
> +		reg |= FIELD_PREP(NVT_TX_DELAY_MASK, ret);
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		reg = NVT_MISCR_RMII;
> +			break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Unsupported phy-mode (%d)\n", phy_mode);
> +	}
> +
> +	regmap_update_bits(regmap, miscr,
> +			   NVT_RX_DELAY_MASK | NVT_TX_DELAY_MASK | NVT_MISCR_RMII, reg);

Please consider programming the NVT_MISCR_RMII bit via the
plat_dat->set_phy_intf_sel() method.

Is this register preserved over suspend/resume ?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

