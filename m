Return-Path: <netdev+bounces-214609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01430B2A8E7
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6EC7BD15C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716173376A1;
	Mon, 18 Aug 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g035lRP+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479733769A;
	Mon, 18 Aug 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525654; cv=none; b=doNHzf/X8z6m6se8dmnBHruRYQTmt5XdejQCsC7S/zz1siJxbU1tQ4xBBXD59eMnTTDxZCQ0yKW8VhI4qh1ZafZVE88PtVXDDQVGq3qjrHBdGPNMGWJj/07X9cDNQVKhXMCIyA1SkzIaDVccvxmI/nEJhk/RyEBk+e0NL7mG8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525654; c=relaxed/simple;
	bh=E5iyPsDk9H29cD9D9pxBQ5hBRtBIAKLKi2Znr3CPkqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF1KH+YTgT/X1ty8K9DNh+LvCNTho524hCSiEdMRm8FflS0bnEjxIkBAarXc6AvUa6sC80O0Mm/SXAvm4Q/+VfQPwGhn9HavyhBfWnQG0mXRl9BOwWTW3xFHOTaJzFvD8aa/XEroZbtmQo6rVH2aBmSq3FVuimNvZw7KpzLKq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g035lRP+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755525652; x=1787061652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E5iyPsDk9H29cD9D9pxBQ5hBRtBIAKLKi2Znr3CPkqE=;
  b=g035lRP+H0/+ITf17A6OIL3QBVBz5G7GcSGe0wr4/c8g5+Enfxc7y+op
   /p4HMS3buuMYPkvvvEjIBGnVMvGO66mwCiquMpu4gEADoDAu4ZnC76AtC
   cuUX7hvZG8jq1erlavN9h0JKYGKjUTNyIesp4PKQhIhcfW5ArlgdARj8f
   VsBRqYnZDilOV6agvb8WwtKbJXpO4C0UT8uxa6WH+t0m3P9VdwuD7ojsA
   NGed1B0efgeD1eglE50WKa+QMiy1mYxwk3b8qAIf4qeUyq+LQgD/EQDmG
   fQsVEVcGr78/fjgSqA5XHk01phEwbYsinY0BFHfkkVL/HO3xRAbUs2Agb
   A==;
X-CSE-ConnectionGUID: PqJWKOs1TemkFKVpsePsIQ==
X-CSE-MsgGUID: fwqzwb4vR8y2J/tvjpku3Q==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="44782887"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 07:00:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 18 Aug 2025 07:00:20 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 18 Aug 2025 07:00:20 -0700
Date: Mon, 18 Aug 2025 15:56:58 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250818135658.exs5mrtuio7rm3bf@DEN-DL-M31836.microchip.com>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250818132141.ezxmflzzg6kj5t7k@skbuf>

The 08/18/2025 16:21, Vladimir Oltean wrote:

Hi Vladimir,

> 
> On Mon, Aug 18, 2025 at 10:10:29AM +0200, Horatiu Vultur wrote:
> > diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> > index 37e3e931a8e53..800da302ae632 100644
> > --- a/drivers/net/phy/mscc/mscc_main.c
> > +++ b/drivers/net/phy/mscc/mscc_main.c
> > @@ -2368,6 +2368,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
> >       return vsc85xx_dt_led_modes_get(phydev, default_mode);
> >  }
> >
> > +static void vsc85xx_remove(struct phy_device *phydev)
> > +{
> > +     struct vsc8531_private *priv = phydev->priv;
> > +
> > +     skb_queue_purge(&priv->rx_skbs_list);
> > +}
> 
> Have you tested this patch with an unbind/bind cycle? Haven't you found
> that a call to ptp_clock_unregister() is also missing?

I haven't tested unbind/bind cycle. As I said also to Paolo[1], I will need
to look in this issue with missing ptp_clock_unregister(). But I want to
do that in a separate patch after getting this accepted.

[1] https://lkml.org/lkml/2025/8/13/345

-- 
/Horatiu

