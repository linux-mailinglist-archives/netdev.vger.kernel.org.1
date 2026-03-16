Return-Path: <netdev+bounces-268253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHbMMJxQuGmKcAEAu9opvQ
	(envelope-from <netdev+bounces-268253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:49:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7229F40F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28EF3307C4AB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13C3E6381;
	Mon, 16 Mar 2026 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Zdep9znd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF293E5EF9;
	Mon, 16 Mar 2026 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686874; cv=none; b=G2qM9ghxisQQI6fxHLbqW0TlG4Fjg3ExEQ2sM3tzJUSlkbBa9ZCQCOmT40FukvAQc9vq+QsBpahnuqfijOkFqVaEmkisvk1v2J6fUexTjZeYD/3iC6pqDp77OLgfa2cPdaSh5H8AhP+5m8q8X4FZMtAnMMNuNwMAVplOCXboG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686874; c=relaxed/simple;
	bh=+k/vh+t2Ou9nkNec8Wuif2/eQbkXmHc5dOYsgUKptbw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjczXmBwB5cayh93XNfj6swtzOSWvid6ZmccHCysH/T9DayzBAas4OgdogAfNs0MOnsuO0kmtFOzIKfxVC3qMmK03SIg8DLqGPxjklPrbkqfoRzYdeucZ70kp+buJsYMNJIMngRacG8MpkyKOglZjLKMwy80VbJAywJpTHPmQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Zdep9znd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773686872; x=1805222872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+k/vh+t2Ou9nkNec8Wuif2/eQbkXmHc5dOYsgUKptbw=;
  b=Zdep9znduvnJ4mkg0A9optEbL+vaFeZzIJ+5Nn5hPSFl02X/ZfMWE57z
   vXlBYk6IdLOOQAAqTnVGHM7YWgTu5/5OnuNzw/N5v0btToO6bqx+WjI3V
   LTHe9lJu9TgUc8GlXhQNehdkxefZBWs1OSW39QmngSh0ueO3h7asAExRy
   u+zP0sGPTMmyrYLhie1aj4EpvBLJGTt1eBI0xq9dx6B3HJvWD7YQYnCd+
   OvOVHXMDVczJMF9jXdTY/7Ng/80eiUGCZFL4NCe2/03/LxdkFEWU5G49k
   qQSvrrPBEYv5ts2ju2p800goIbIuomb3BP0/onlJDAdY7PmUZmY7PrCGN
   Q==;
X-CSE-ConnectionGUID: NYZhdgGsTtykT1Pwm+qYxg==
X-CSE-MsgGUID: xUBWVD07SjqIdcPeFUP6Jw==
X-IronPort-AV: E=Sophos;i="6.23,124,1770620400"; 
   d="scan'208";a="221993711"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:47:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 16 Mar 2026 11:47:44 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 16 Mar 2026 11:47:43 -0700
Date: Mon, 16 Mar 2026 11:47:41 -0700
From: Charles Perry <charles.perry@microchip.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/3] Initial support for PIC64-HPSC/HX
 Ethernet endpoint
Message-ID: <abhQTWsPI6TfpWxh@bby-cbu-swbuild03.eng.microchip.com>
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <DH4DU4Z4X9MM.398FQ3BIZQIJB@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DH4DU4Z4X9MM.398FQ3BIZQIJB@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268253-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: 2CD7229F40F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 06:28:39PM +0100, Théo Lebrun wrote:
> Hello Charles,
> 
> On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
> > Hello,
> >
> > This series add basic support for Microchip "PIC64-HPSC" and "PIC64HX"
> > Ethernet endpoint. Both SoCs contain 4 GEM IP with support for
> > MII/RGMII/SGMII/USXGMII at rates of 10M to 10G. Only RGMII and SGMII at a
> > rate of 1G is tested for now. Each GEM IP has 8 priority queues and the
> > revision register reads 0x220c010e.
> 
> Do you have plans to test higher rate? We might get our hands on GEMs
> that support >1G and would like to know if CCing you would make sense.

Yes. I don't have a 10G setup right now but that's definitively in my TODO
list for this year.

> 
> > One particularity of this instantiation of GEM is that the MDIO controller
> > within the GEM IP is disconnected from any physical pin and the SoC rely on
> > another standalone MDIO controller.
> 
> Ah, that means you instantiate the MDIO bus for no good reason.
> Code looks like:
> 
> static int macb_mii_init(struct macb *bp)
> {
> 	struct device_node *mdio_np, *np = bp->pdev->dev.of_node;
> 	int err = -ENXIO;
> 
> 	/* With fixed-link, we don't need to register the MDIO bus,
> 	 * except if we have a child named "mdio" in the device tree.
> 	 * In that case, some devices may be attached to the MACB's MDIO bus.
> 	 */
> 	mdio_np = of_get_child_by_name(np, "mdio");
> 	if (!mdio_np && of_phy_is_fixed_link(np))
> 		return macb_mii_probe(bp->dev);
> 
> 	// ... probe MDIO bus ...
> }
> 
> So to *not* get the bus we need to be in fixed link config. Do you care
> about that? I think that the proper fix would be to lazy probe the MDIO
> bus until a PHY (ours or some other MAC's) asks for it.

Yes, I do have a bunch of unusable MDIO buses in sysfs. It would be great
if those just didn't exist but that would be yet more code and one more
MACB_CAPS for little benefit IMO.

As for the fixed link, I can't specify that just to not instantiate the
MDIO bus because that would cause other problems since my link has a PHY
with a negotiated rate/duplex/etc.

Thanks,
Charles

> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

