Return-Path: <netdev+bounces-226656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FCBA39EA
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04DB189D00F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A392DFA27;
	Fri, 26 Sep 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YI9oPORa"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332922DFA7;
	Fri, 26 Sep 2025 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889930; cv=none; b=ZxKQaKRG3MB0nZv1qN9D2enf3B0ZVdMJJ2+0GmJ3/i1BZZLLyTNrR9qhSBc8birv4qsxCkb3BZJqB/eSv9svlZWxMEvwNYz4gVeewGZUutJbrfo2c+vhNRq2NBsbep4g1UKuG5hXpdpywA5HDTPxvRtEH6HNpm7RN53kgDFEYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889930; c=relaxed/simple;
	bh=4pBFQ0Uz5QjWbEEBpSwXpSmkcB3ILJpm6lt9YiLAyZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYGJJVIn/vfHC5y7m1tMmMggk9a5qIdHwfgE8JdwVgSgWkzHDjNfjgxhQD4B5PcBAOjcRYolhugaiHqIojURY+lpe3ahEwV86xvEQv7NgcTurUPogFvaOLz2FCOH72hQWabqu7XlOXnb8mYW/Aqrg8kVKGcMdWw/lFcv35VIy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YI9oPORa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758889929; x=1790425929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4pBFQ0Uz5QjWbEEBpSwXpSmkcB3ILJpm6lt9YiLAyZ8=;
  b=YI9oPORaLlHTmuKQDQcDyimheHz+LVdwRsbNPHdrMT/ApVSwfm5Zi3jo
   DSGZh5Tsx/+nKfB4DMs6k7Ou7kfsBJ8v/xORVaV8zSlEtj9CW1j9AOjge
   XkX6dM6dDBZLVqxaXQvsniqrsNOQ+4R6azacEFD8e3q/haNzIXDYWUMij
   SNJJjiRe05+5KXEj24shRmbAL0/VU5MYAvDwkDr/XHn6eZQ9JUkEU+vKV
   EIrG2nqE74aFq1Y/OOqiR7xDAyCY5qJeGL9vLBp2zGTP6jKMgBAEL26dH
   eZ/PzBXMMyrAmaUW2V6a44zybtK7yVNFHM7P/odBOe+Gyc59z6n9hVrDI
   Q==;
X-CSE-ConnectionGUID: lLFS1YPBTD+yAQfyZWaI6w==
X-CSE-MsgGUID: +2RhxcgHRJK/5va2xXeGxQ==
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="47547359"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2025 05:32:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Sep 2025 05:31:09 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 26 Sep 2025 05:31:09 -0700
Date: Fri, 26 Sep 2025 14:27:01 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Jakub Kicinski <kuba@kernel.org>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250926122701.q2t7rk7vgccjzyi6@DEN-DL-M31836.microchip.com>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <20250922132846.jkch266gd2p6k4w5@skbuf>
 <20250923071924.mv6ytwtifuu5limg@DEN-DL-M31836.microchip.com>
 <20250926071111.bdxffjghguawcobp@DEN-DL-M31836.microchip.com>
 <20250926122038.3mv2plj3bvnfbple@skbuf>
 <20250926122116.iixyzxl3cjp2z66j@DEN-DL-M31836.microchip.com>
 <20250926122757.jvcl7xi6435wlztw@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250926122757.jvcl7xi6435wlztw@skbuf>

The 09/26/2025 15:27, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Sep 26, 2025 at 02:21:16PM +0200, Horatiu Vultur wrote:
> > The 09/26/2025 15:20, Vladimir Oltean wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > On Fri, Sep 26, 2025 at 09:11:11AM +0200, Horatiu Vultur wrote:
> > > > I have been asking around about these revisions of the PHYs and what is
> > > > available:
> > > > vsc856x - only rev B exists
> > > > vsc8575 - only rev B exists
> > > > vsc8582 - only rev B exists
> > > > vsc8584 - only rev B exists
> > > > vsc8574 - rev A,B,C,D,E exists
> > > > vsc8572 - rev A,B,C,D,E exists
> > > >
> > > > For vsc856x, vsc8575, vsc8582, vsc8584 the lower 4 bits in register 3
> > > > will have a value of 1.
> > > > For vsc8574 and vsc8572 the lower 4 bits in register 3 will have a value
> > > > of 0 for rev A, 1 for rev B and C, 2 for D and E.
> > > >
> > > > Based on this information, I think both commits a5afc1678044 and
> > > > 75a1ccfe6c72 are correct regarding the revision check.
> > > >
> > > > So, now to be able to fix the PTP for vsc8574 and vsc8572, I can do the
> > > > following:
> > > > - start to use PHY_ID_MATCH_MODEL for vsc856x, vsc8575, vsc8582, vsc8584
> > > > - because of this change I will need to remove also the WARN_ON() in the
> > > >   function vsc8584_config_init()
> > > > - then I can drop the check for revision in vsc8584_probe()
> > > > - then I can make vsc8574 and vsc8572 to use vsc8584_probe()
> > > >
> > > > What do you think about this?
> > >
> > > This sounds good, however I don't exactly understand how it fits in with
> > > your response to Russell to replace phydev->phy_id with phydev->drv->phy_id
> > > in the next revision. If the revision check in vsc8584_probe() goes away,
> > > where will you use phydev->drv->phy_id?
> >
> > I got a little bit confused here.
> > Because no one answer to this email, I thought it might not be OK, so
> > that is the reason why I said that I will go with Russell approach.
> > But if you think that this approach that I proposed here is OK (as you seem
> > to be). Then I will go with this and then I will not do Russell
> > suggestion because it is not needed anymore.
> 
> Yes, sorry, I am in the middle of some work and I'm not as responsive as
> I should be.

No worries.
Thanks for all the help you provided to this patch and all the previous
ones!


-- 
/Horatiu

