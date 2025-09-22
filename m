Return-Path: <netdev+bounces-225249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85D8B9123C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6F41663E8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329342F1FE5;
	Mon, 22 Sep 2025 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oje7S2F/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E7632;
	Mon, 22 Sep 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544668; cv=none; b=HqG+34hKi3naExy9r9JBk+eoUYc62seEWHYLGaezlPmNAtOY+ic+HkMzJRimUeMFEAT27wvIMf2L+eLNpo2YU7nVG3DnU4O8iCZHW5HSjJdOXAO9tlu63BIbgCE4eIb20WrNZYfT9i7MO72uXrV14+ho4K1X8bUCL4oYHy8CSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544668; c=relaxed/simple;
	bh=8YypPf0aiPKuOwo+g5HDRj8EAxKrVBf8pOov84amq8A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdLQNxL5ID10bomjcKvQOzNEFpdiL4CntcdDs6k16tp248/yRFvmRfUc7sLR7LENEvV62ER+wCbi4ADZY4dtqV2ODry7HF/45VkSBaAfEtwPEt0Ac2kkumFsByUOqAQd7lLflpNw0M5kMVUqIhaKvbAVemr6dunaA7s8U/2LXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oje7S2F/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758544666; x=1790080666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8YypPf0aiPKuOwo+g5HDRj8EAxKrVBf8pOov84amq8A=;
  b=oje7S2F/vmbHLTKGhEGuB5lIwdjTI4bqYH83NM9foWgoiPXx75WN28xT
   8kROn3wNgb6n5ngOo3n6QvOpaOhreaiRWD+pXDTxSeD0A73l8i9S2iyqV
   eSCHueUeEaFfUilmVaKVkufelabxC/GMGuYAUC3vJ4YiG7PrD0mPlO4lE
   N92M2RpD4Gt0zl1cZjwmoWj8zD5l4r+ZI3ivRGjo+fzAs+nOYwA3DwDqu
   F3R2lgVOVfnsDYlNpaF/zi70kdekbCHM97tLOApsGyxydUvBoI+g8Nf7c
   +RWP8gPjcCYPJToz40WWqnpZi8SOywzL8vdTBu3k6XviHYmR8wQKyWCuP
   Q==;
X-CSE-ConnectionGUID: lBfTSD/JRDC5cyyuOb8Rqg==
X-CSE-MsgGUID: WaGxFZAVTR6h9GyLGG3I9w==
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="214199220"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2025 05:37:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 05:37:04 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 22 Sep 2025 05:37:04 -0700
Date: Mon, 22 Sep 2025 14:33:01 +0200
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
Message-ID: <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250922121524.3baplkjgw2xnwizr@skbuf>

The 09/22/2025 15:15, Vladimir Oltean wrote:

Hi,

> 
> On Thu, Sep 18, 2025 at 04:09:42PM -0700, Jakub Kicinski wrote:
> > On Wed, 17 Sep 2025 13:33:16 +0200 Horatiu Vultur wrote:
> > > When trying to enable PTP on vsc8574 and vsc8572 it is not working even
> > > if the function vsc8584_ptp_init it says that it has support for PHY
> > > timestamping. It is not working because there is no PTP device.
> > > So, to fix this make sure to create a PTP device also for this PHYs as
> > > they have the same PTP IP as the other vsc PHYs.
> >
> > May be useful to proof read your commit message, or run it thru
> > a grammar checker. Copy & paste into a Google Doc would be enough..
> 
> I agree, and I did not understand the problem from the commit message.
> 
> I would suggest something like below (maybe not identical).
> 
> The PTP initialization is two-step: first we have vsc8584_ptp_probe_once() /
> vsc8584_ptp_probe() at probe() time, then we have vsc8584_ptp_init() at
> config_init() time.
> 
> For VSC8574 and VSC8572, the PTP initialization is incomplete. We are
> making the second step without having previously made the first one.
> This means, for example, that ptp_clock_register() is never called.
> 
> Nothing crashes as a result of this, but it is unexpected that some PHY
> generations have PTP functionality exposed by the driver and some do
> not, even though they share the same PTP clock IP.

I agree, I need to be more carefull and more clear in the commit
messages. Thanks for the great example.

> 
> > Regarding the patch the new function looks like a spitting image
> > of vsc8584_probe(), minus the revision check.
> > --
> > pw-bot: cr
> 
> Also, even without this patch, vsc8574_probe() and vsc8584_probe() are
> structurally very similar and could use some consolidation.
> 
> Would it make sense to create a static int vsc8531_probe_common(struct
> phy_device *phydev, bool ptp) and call it from multiple wrappers? The
> VSC8584_REVB check can go in the vsc8584_probe() wrapper. The "size_t
> priv_size" argument of devm_phy_package_join() can be set based on the
> "bool ptp" argument, because struct vsc85xx_shared_private is used only
> in PTP code.
> 
> You can make a preparatory change in 'net' patch sets, even without
> a Fixes: tag, if you clearly explain what it's for.

Thanks for the advice.
What about to make the PHY_ID_VSC8572 and PHY_ID_VSC8574 to use
vsc8584_probe() and then in this function just have this check:

---
if ((phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8572 &&
    (phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8574) {
	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
		dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
		return -ENOTSUPP;
	}
}
---


-- 
/Horatiu

