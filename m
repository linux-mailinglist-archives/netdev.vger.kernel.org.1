Return-Path: <netdev+bounces-92049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C98B5316
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF927280E8A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB289171C1;
	Mon, 29 Apr 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i/X8OM1W"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E27171B0
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379126; cv=none; b=aApJhZCBQuvQynF/LNE+XqlD3U0gCalUtZEN3iOdegvlakm3BU1gNCBfxf72yz7tD7r5OgtOaqg3+nOH8Iued4rV7L3nAkefEL1yZntaNzJMw3ncIAj3zcvQoXg5gQPPr7sWLrcY8VaCylq8tT4bPL83PBme2FnUkPvuySZXTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379126; c=relaxed/simple;
	bh=AnvFwEgs4j/U6FnNbOMO+eJ1974UmLXjn/fBK6cyvC4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWOKHQyKNm5beTtvc7j9fWlVn0izDXq9cDRdCOgK8nen+9mSdlQrPBylB+aMjdi3nps1ILTGA0rYcakghzV/sOzpTlDG9V322wfLeJeq0kJj1Gb5Nw1h78adFscMxUJPYDumPP5nSF/HI2v6m/I7HID6sO1z0Jvt5pD3jvJmuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i/X8OM1W; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714379124; x=1745915124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AnvFwEgs4j/U6FnNbOMO+eJ1974UmLXjn/fBK6cyvC4=;
  b=i/X8OM1WYtkgRM9KOSTdsbK2Q8KMpR0jooyK5/sEK1bzkFf6n3KId5Qn
   wSTTdynEvN+i+JOtH4IOOddlPZOn+lKE8Tu0NidoCRA4oo9dT1ilPR5XM
   UsphlBruQEvCczsXDa4R7aVbATf0Qbpfr2L9GuQeIXCKgQauHQbc4lxxf
   IwEjjYnzqhNXkn9LynR8F4gW2Oo4/gQwulYmWEBR6PjiM8F1yNOv4mSUM
   gpgGMKqm8J+F10GGLLN4U/vgY9pYZ5wUfCM1E3nxxyAE1R2LR/SHHL+XW
   Oh6oz3+agNWKjoIilMT39rpZd62W3PA7tSDIDFBx8AP0BUvGWxVAA8cxJ
   w==;
X-CSE-ConnectionGUID: ARxBGU7PTo+IxfWMKCI5MQ==
X-CSE-MsgGUID: ja9AL2+MQKiF2PmFiSUSYw==
X-IronPort-AV: E=Sophos;i="6.07,239,1708412400"; 
   d="scan'208";a="25281829"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2024 01:25:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:25:13 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 29 Apr 2024 01:25:12 -0700
Date: Mon, 29 Apr 2024 08:25:11 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sfp-bus: constify link_modes to
 sfp_select_interface()
Message-ID: <20240429082511.h32rsx5s3iu2jlpe@DEN-DL-M70577>
References: <E1s15s0-00AHyq-8E@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <E1s15s0-00AHyq-8E@rmk-PC.armlinux.org.uk>

> sfp_select_interface() does not modify its link_modes argument, so
> make this a const pointer.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/sfp-bus.c | 2 +-
>  include/linux/sfp.h       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index c6e3baf00f23..37c85f1e6534 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -355,7 +355,7 @@ EXPORT_SYMBOL_GPL(sfp_parse_support);
>   * modes mask.
>   */
>  phy_interface_t sfp_select_interface(struct sfp_bus *bus,
> -                                    unsigned long *link_modes)
> +                                    const unsigned long *link_modes)
>  {
>         if (phylink_test(link_modes, 25000baseCR_Full) ||
>             phylink_test(link_modes, 25000baseKR_Full) ||
> diff --git a/include/linux/sfp.h b/include/linux/sfp.h
> index 55c0ab17c9e2..5ebc57f78c95 100644
> --- a/include/linux/sfp.h
> +++ b/include/linux/sfp.h
> @@ -554,7 +554,7 @@ bool sfp_may_have_phy(struct sfp_bus *bus, const struct sfp_eeprom_id *id);
>  void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
>                        unsigned long *support, unsigned long *interfaces);
>  phy_interface_t sfp_select_interface(struct sfp_bus *bus,
> -                                    unsigned long *link_modes);
> +                                    const unsigned long *link_modes);
> 
>  int sfp_get_module_info(struct sfp_bus *bus, struct ethtool_modinfo *modinfo);
>  int sfp_get_module_eeprom(struct sfp_bus *bus, struct ethtool_eeprom *ee,
> @@ -593,7 +593,7 @@ static inline void sfp_parse_support(struct sfp_bus *bus,
>  }
> 
>  static inline phy_interface_t sfp_select_interface(struct sfp_bus *bus,
> -                                                  unsigned long *link_modes)
> +                                               const unsigned long *link_modes)

There seem to be some misalignment on the opening brace - at least in my
editor..

Other than that:

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


>  {
>         return PHY_INTERFACE_MODE_NA;
>  }
> --
> 2.30.2
> 
> 

