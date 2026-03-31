Return-Path: <netdev+bounces-273623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAtNFlLFy2mnLgYAu9opvQ
	(envelope-from <netdev+bounces-273623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:00:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEE0369DC3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3532030AAC71
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9C3E3C4A;
	Tue, 31 Mar 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oAAvD3p3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF93E274D;
	Tue, 31 Mar 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961838; cv=none; b=pJc+cM3WeAHy8VrE5oDVD7RgfX3rNq2/uEBk8tSmg4D3YHX3U+ADD+m4NrCIV3XSwoaKyaIoDk6U6g65c5K3PrLjwotxxnaHQ+C9spTnjLWa536tXQf8M1Q/GzEUTz83v4VUBCbz+CcWAVcM4XjJveiREGWJTio8xCpiGOhlxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961838; c=relaxed/simple;
	bh=7qC1BnD4mH5LoQ13U3r4hGuW9xivO771/MGjXu8lqOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzymKXio92EH363v9nWViI97FRAv0BCbJGck+Vw7yijWLX8dvyR+bmtpGubNC8cC5EjQljco8CB6OPLupQLldpXeFaHU4ibUiRffLNCxHUpsoiuB1eMAFzBgcuIbFvjOh+8TE1JvZpPEcUf6sqxfNCrvHfFBfxn/emEckViKEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oAAvD3p3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yL0uEu6Z3xCXDhpY3P7bOBpUjSxvIYmVlxwP18YKcW4=; b=oAAvD3p3cZIWyfx7JI3Kk7oo6i
	5DqmzzChgJEnuvoRrzZGA19HncZUffXR0tiiZxxH6gO9SQh3Wa9NPkyVBAUxw8HzEVKy9tYSxcWcd
	eMCg66qejT7PB0jEVWXz3embJh1MUckFbyvTaCFiZV4okT2t19bQ2cAN2vPp+OULRJ6rZ8+su2U0p
	lz66nZ/Q2SXB17DQ7/XIE76ye2ZteYHmiKzOkJwHdAPgOgXmNd7xA6+4hR4HqU3s5YoJhsGQgCspe
	rsnCVUaIYLJYz8F9jqnMQ0g1bc5lAKwHJ3+7le1I8jtRut2wWRGjh8ijfwUpljGsheNI/ZPDieRBQ
	JA45P7tQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7Yee-000000001qk-3hkC;
	Tue, 31 Mar 2026 13:57:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7Yec-000000003k0-1RSP;
	Tue, 31 Mar 2026 13:57:10 +0100
Date: Tue, 31 Mar 2026 13:57:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <acvEpk1grDFAahzd@shell.armlinux.org.uk>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331123858.1912449-3-charles.perry@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273623-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.516];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 7AEE0369DC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:38:54AM -0700, Charles Perry wrote:
> +	if (!(bus->phy_ignore_ta_mask & 1 << mii_id) &&
> +	    !FIELD_GET(MDIO_READOK_BIT, val)) {
> +		dev_dbg(&bus->dev, "READOK bit cleared\n");
> +		return -EIO;
> +	}
> +
> +	ret = FIELD_GET(MDIO_RDATA_MASK, val);
> +
> +	return ret;

You don't need "ret" here, this can simply be:

	return FIELD_GET(MDIO_RDATA_MASK, val);

...

> +	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
> +		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
> +		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_WRITE) |
> +		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
> +	       priv->regs + MDIO_REG_FRAME_CFG_2);

Shouldn't this wait for the write to complete?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

