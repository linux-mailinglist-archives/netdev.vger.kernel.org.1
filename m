Return-Path: <netdev+bounces-216820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2CB354CC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E224477B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D62F60CF;
	Tue, 26 Aug 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qWjUerfn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6D2882D7;
	Tue, 26 Aug 2025 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191184; cv=none; b=m5QXxa12z/TAQ/MWqKBV8XUlG2KN8z8bGzWJtDzJUECp54RNmMCNpTTHBG49ydN5OdITBb3r9HtGoWrMKbHhGEdFXzYX2pH6zUVoOpEUQYKXgnG9/Ay1fNgn2q5XFo4lmDpMIHo/AGb8rFyBi9CsXpw2NIp3I6HfZfj62J/AFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191184; c=relaxed/simple;
	bh=jH5bxK6EaSvWBxLcpjk++ZL/7lRyN+YA0ftWMGDqgc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcXI3Ijk/EMlzFr9yNHMyVBs51QBAnRNwuDpg3cT5EarIISd+tCBLdbM7Kp8ct7ZRTfAL3o9xDD6aTHFS/n3FN9zhFIP8kDbEBGxLNAwLgHJZkuPav3xKe63lAxhcFGR/uwlSmio+GXBJMyYOaYiEqy3gk66U+L+FRw90eAoqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qWjUerfn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756191183; x=1787727183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jH5bxK6EaSvWBxLcpjk++ZL/7lRyN+YA0ftWMGDqgc4=;
  b=qWjUerfnj3iM7b8ewKJZXalqSx/LqklC957niFXsBSMXJfKuH+YfQXi8
   bcGSNSRvuYKw11YTtbRfh7KrD2YabaAzydxnNAEWvCQdLV0Q1xyDUMZwf
   6hPD4t3ScVyKLIPQsQqWhIJ1lZ1GaIUdxcFc/N+QYfjHprk8LRxI+uSmV
   qv+mah4x1J860h/M/1ups8Xs7SvomjS0rlckbXr1ESOOvu9AaVluEJkNo
   SZapjX7s6d0b9jhOkL1o+Vp8vzZ+zorph9SKlR8aUqPdWLJE3JG2acsHb
   u2iBWj3TYoYfCJNmqOj9KxqeFUbc21OTlz6b3DmBDJsxeAWp4iPOTZLU0
   g==;
X-CSE-ConnectionGUID: vjBvharrSgWpaC/5HfU8uA==
X-CSE-MsgGUID: pdQwCPcSRSGCepZAD+3zLw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="277036521"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 23:52:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 23:52:49 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 25 Aug 2025 23:52:49 -0700
Date: Tue, 26 Aug 2025 08:49:18 +0200
From: Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To: Parthiban Veerasooran - I17164 <Parthiban.Veerasooran@microchip.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <20250826064918.xhqwgndlnhbfnvnb@DEN-DL-M31836.microchip.com>
References: <20250825063136.2884640-1-horatiu.vultur@microchip.com>
 <20250825063136.2884640-3-horatiu.vultur@microchip.com>
 <0b754e84-45d0-4d3e-aa14-564ab5528b98@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b754e84-45d0-4d3e-aa14-564ab5528b98@microchip.com>

The 08/25/2025 09:03, Parthiban Veerasooran - I17164 wrote:

Hi Parthiban,

> 
> On 25/08/25 12:01 pm, Horatiu Vultur wrote:
> > +	/* As the lan8814 and lan8842 has the same IP for the PTP block, the
> > +	 * only difference is the number of the GPIOs, then make sure that the
> > +	 * lan8842 initialized also the shared data pointer as this is used in
> > +	 * all the PTP functions for lan8814. The lan8842 doesn't have multiple
> > +	 * PHYs in the same package.
> > +	 */
> > +	addr = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +				    LAN8842_STRAP_REG);
> > +	addr &= LAN8842_STRAP_REG_PHYADDR_MASK;
> > +	if (addr < 0)
> > +		return addr;
> > +
> > +	devm_phy_package_join(&phydev->mdio.dev, phydev, addr,
> > +			      sizeof(struct lan8814_shared_priv));
> Shouldn't you check the return value of devm_phy_package_join()?
> Apologies — I missed to comment in my previous review.

Yes, I should check the return value. I will fix this in the next
version.
No worries, thanks for catching this.

> 
> Best regards,
> Parthiban V
> > +	if (phy_package_init_once(phydev)) {
> > +		ret = lan8842_ptp_probe_once(phydev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	lan8814_ptp_init(phydev);
> > +
> >   	return 0;
> >   }

-- 
/Horatiu

