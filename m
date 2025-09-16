Return-Path: <netdev+bounces-223380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E12B58EDA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6867A523265
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6262E3B03;
	Tue, 16 Sep 2025 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d8KiUw1P"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AA2BAF9;
	Tue, 16 Sep 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006664; cv=none; b=g+WJ4WPLidPhzx6iO0LPdcGudxJH4UiK7K2TEqKpQ/VdZCnQe3sYS0IGgTR69EZLJg7aojuERLDOCkqhrhMOOEe91QOOxu4k3mRT2eSfvbPC7ZoraBLt78oMC8Cq/AjZ2Q6of8f4GzUgALAo+qdy4XHgtA/HHnZIhopwBQQEF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006664; c=relaxed/simple;
	bh=W5ajTpSNMNJWbfWHVcFvQAWx4kBahExAyHsoGBmxcyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNBU7/9hMLryZ1aXpUBeK9+K0ATMOGXtk/WIH4mpKLzz20hLcaIoyOvCNl07Zz2nnh+ZmsGQe+SKISnhXOFUEr2pk096KJuoXcwDWFL+PqAFQWRWVATbc+2wJiBpK8LifZNsmWl+RtgDbcPqmhh6RNDknuAVGf5DfJwTEqmbTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d8KiUw1P; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758006662; x=1789542662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W5ajTpSNMNJWbfWHVcFvQAWx4kBahExAyHsoGBmxcyE=;
  b=d8KiUw1PAF0CTxKY5RbvhUlCGQm8bVFyAB2e5GmeVejLCrYvhmI8hFvp
   3hm5EVkptx7wcYwBFh3jrl5UWsRxYoe2xtkN6BRtZuqoWOOYSVQqZ8Br/
   UbVEos/3LfxGBDadRawv3RhLgqSGpXy3nc9Nzx2n6FdEG9vnbk9Ov7crG
   6WNlwaCEFz7iY2hsHVNHIUAewF4jJMLneWDCu3vZAxcCTx1kT9fInruDz
   4BiMNdhMT9pwBbkjmiHrXvE+mzPxtrN7LkccfCrj0TfIhk3WdvEW/Owil
   QUhUZmdwkY0rbM/i2zfV06riSuCBEOn8NHO015CBqitmRh1cOACb/M9ze
   A==;
X-CSE-ConnectionGUID: IFmucD1jTJGMc+TDfuaTuQ==
X-CSE-MsgGUID: Rhyib+rKQ7G9UsGeAGA/lw==
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="277928140"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 00:11:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 00:10:56 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 00:10:56 -0700
Date: Tue, 16 Sep 2025 09:07:00 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add Fast link failure support
 for lan8842
Message-ID: <20250916070700.qxhnjwy4r3brvdys@DEN-DL-M31836.microchip.com>
References: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
 <aMgAKIn0YRyxK0Fn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aMgAKIn0YRyxK0Fn@shell.armlinux.org.uk>

The 09/15/2025 13:01, Russell King (Oracle) wrote:

Hi Russell,

> 
> On Mon, Sep 15, 2025 at 11:11:49AM +0200, Horatiu Vultur wrote:
> > +static int lan8842_set_fast_down(struct phy_device *phydev, const u8 *msecs)
> > +{
> > +     if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_ON)
> > +             return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
> > +                                           LAN8842_FLF,
> > +                                           LAN8842_FLF_ENA |
> > +                                           LAN8842_FLF_ENA_LINK_DOWN,
> > +                                           LAN8842_FLF_ENA |
> > +                                           LAN8842_FLF_ENA_LINK_DOWN);
> > +
> > +     if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
> > +             return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
> > +                                           LAN8842_FLF,
> > +                                           LAN8842_FLF_ENA |
> > +                                           LAN8842_FLF_ENA_LINK_DOWN, 0);
> 
> Would this be more readable?
> 
>         u16 flf;
> 
>         switch (*msecs) {
>         case ETHTOOL_PHY_FAST_LINK_DOWN_OFF:
>                 flf = 0;
>                 break;
> 
>         case ETHTOOL_PHY_FAST_LINK_DOWN_ON:
>                 flf = LAN8842_FLF_ENA | LAN8842_FLF_ENA_LINK_DOWN;
>                 break;
> 
>         default:
>                 return -EINVAL;
>         }
> 
>         return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
>                                       LAN8842_FLF,
>                                       LAN8842_FLF_ENA |
>                                       LAN8842_FLF_ENA_LINK_DOWN, flf);

Yes, I think it looks nicer.
I will update this in the next version.

> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

