Return-Path: <netdev+bounces-233520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD4EC14BD1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55646350F76
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD63314D3;
	Tue, 28 Oct 2025 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v1RUAwQj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74463314AB;
	Tue, 28 Oct 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656479; cv=none; b=OtGEfvefoaOfZTgPDF+uqEWMshrAB+WLgcBEiiQdfcyFHgihde3qO5Um0+qayoJGRJ96geSnRERqGYmea6m2nxeyNW4JvPu+4H6Rv8qQBjdyvBxUZeyFUIBagiGun7aT+7gEKWTrp3RsqoIKwiR1j1fiQT3wpDQPZjFuEM9LAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656479; c=relaxed/simple;
	bh=Ip0/Cn7Eq8CRmBNQPrUXFmsK1Z7fBv8Q9ArF72Fhztw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlvqtiBuj5O3tz6GOL/YGC2GiTve6iBhfJCzeefwGoqYI7wvmQ4LqDriC2mPUS703V32wt0qIzz8/Osb3J7Z+/K4bRJSVSNJdnTPcNXZQRKMmCNWAfA6BHUIf5waRRnbi7X0028dupVDRB6MWGumH2/wiHaTo59eMW5bsyUSKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v1RUAwQj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761656477; x=1793192477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ip0/Cn7Eq8CRmBNQPrUXFmsK1Z7fBv8Q9ArF72Fhztw=;
  b=v1RUAwQjzS3HMSe4k2ir4jPY/RJhp7FMWsYjkOacyreF2Ln2FUd++lD3
   HiNUdTS8AerG6GKL8R3ReV6MUCfxFYz5kGvdzp/PXwHHzFgcLRokUJThU
   /VN5Jl/N4X5AZbrE6M9M2lQdfBQqm0qggKwtEJFpU9m6yToep6F4WjqiH
   /cQ1vYVsvgPdFcPnxDMKf0KYkgSIrckTTZyG+QUHRqwKh3JFgTKQOWqqI
   MFyBIQE5QFzWAvxhFpfyxIJrwyVPmJH3uAHe9/cWoPXAYvIx15+mv2dYb
   wq8hD0lkUz42qoUSgqb3ekj7yFQSNarNxC0eRiDc14IcrwpYsdsoAoKs8
   Q==;
X-CSE-ConnectionGUID: Gg7jUh6qR9u+EJ1jhFrNyQ==
X-CSE-MsgGUID: pDMRFxr/QW+1zSyrHNClDg==
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="48858559"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:01:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 28 Oct 2025 06:00:02 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 28 Oct 2025 06:00:01 -0700
Date: Tue, 28 Oct 2025 13:58:47 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy:  micrel: lan8842 erratas
Message-ID: <20251028125847.y2uracj2csvqhxy6@DEN-DL-M31836.microchip.com>
References: <20251027124026.64232-1-horatiu.vultur@microchip.com>
 <4eefecbe-fa8f-41de-aeae-4d261cce5c1f@lunn.ch>
 <20251028073354.7r5pgrbrcqtqxcjt@DEN-DL-M31836.microchip.com>
 <8b14b2b8-709e-4c83-8028-19ab2df1bac2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <8b14b2b8-709e-4c83-8028-19ab2df1bac2@lunn.ch>

The 10/28/2025 13:04, Andrew Lunn wrote:
> 
> > > I notice there is no Fixes: tag. So you don't think these are worth
> > > back porting?
> >
> > Definetly I would like to be ported but the issue was there from
> > beginning when the lan8842 was added, so I was not sure if it is OK to
> > send it to net.
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> says:
> 
> It must either fix a real bug that bothers people or just add a device ID.
> 
> Does this bother people?

Yes, I would say so.

> 
>         Andrew

-- 
/Horatiu

