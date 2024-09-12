Return-Path: <netdev+bounces-127683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85097618A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20ECA1C2265A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C8185B7B;
	Thu, 12 Sep 2024 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XFDiBOWj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BA2F41;
	Thu, 12 Sep 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122829; cv=none; b=sNh05SWAfqQNGAvx2Pg4k0Yy4mxLMJKx8mfgXtif1CO86Z238rMjjnBoRxHO5q27hURFNwndBiZqn49ZRLBnucq5PCZZWhReXrsyOgrd10fSU5BLJi27/UfEM11z0N+yiCoyKFhApSyHmANoTLgQJ45KobI0QI1cl0miZfPwoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122829; c=relaxed/simple;
	bh=S8MnfLRiSo4ybJcR4rdVyvw/UnNnKQY5LImslnLKjIY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPa7ObMh0R/KUxBUEAFnYuVX5DcaqvQ3C8b70UvptjEZDMMfzJ1GiG6JK/Ekm3fGy/67te0mjSxNl+UGCuhkACPWuneplut8dGP80XwWPRRH+WY2zbzdbvlNLBDcqwU5cC0WaLkOY6O3P2tCPf/45B5fD1YDcXNYa0kzpraa0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XFDiBOWj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726122827; x=1757658827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8MnfLRiSo4ybJcR4rdVyvw/UnNnKQY5LImslnLKjIY=;
  b=XFDiBOWjiH4CWmUlXdxndgkt8woTf/114j92qukJs6+aKbXO4BWbbEu/
   VovjOOSSFIkn5RY1OeyPGpsvCpeJuw2zafYSfAQh/4m+3T/kMw+giirQb
   u7PPCUQU6PYLOJn99F0DBbaAoQp2mtIBQ2d/JjQmrQ5PLqRbarM+IreTV
   DA7oilzw0kmqMaZTkKFRYRLjxdZcAR7UAWM8ZSYAGAxDZop65/cAiFtYH
   ecQ8YbxqJDROp5uww7yIyBwVCY0wkhiGiotufaPAsLKpHwGgVHonYe1YY
   UoAlWNXCEPcaUdKtOKmX5TtGubkmhnF4RSegxOMuzp/4sFYa6EeV3cmRw
   Q==;
X-CSE-ConnectionGUID: JicbGEixR6OBlb70AmjTSw==
X-CSE-MsgGUID: Q+yZxZtSTxmedyiLfDY4gw==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="31575181"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 23:33:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 23:32:54 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 23:32:54 -0700
Date: Thu, 12 Sep 2024 11:59:04 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Message-ID: <ZuKKMIz2OuL8UbgS@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
 <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>

Hi Andrew,

Thank you for review the patches.

The 09/11/2024 19:06, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > +     if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> > +         adapter->is_sfp_support_en) {
> > +             netif_err(adapter, drv, adapter->netdev,
> > +                       "Invalid eeprom cfg: sfp enabled with sgmii disabled");
> > +             return -EINVAL;
> 
> is_sgmii_en actually means PCS? An SFP might need 1000BaseX or SGMII,

No, not really.
The PCI11010/PCI1414 chip can support either an RGMII interface or
an SGMII/1000Base-X/2500Base-X interface.

To differentiate between these interfaces, we need to enable or disable
the SGMII/1000Base-X/2500Base-X interface in the EEPROM.
This configuration is reflected in the STRAP_READ register (0x0C),
specifically bit 6.

According to the datasheet,
the "Strap Register (STRAP)" bit 6 is described as "SGMII_EN_STRAP"
Therefore, the flag is named "is_sgmii_en".

> phylink will tell you the mode to put the PCS into.

Yes. You are correct.
Based on PCS information, it will swich between SGMII or 1000Base-X or
2500Base-X I/F.

> 
>         Andrew

-- 
Thanks,                                                                         
Raju

