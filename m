Return-Path: <netdev+bounces-97923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E828CE11D
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7958C1F21876
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A7A1EEE3;
	Fri, 24 May 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mSLIHhFa"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FD11720;
	Fri, 24 May 2024 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533176; cv=none; b=Wa0yJWCYDOu38qCINpEg5e7LX8v/t4bE2QQ69piNTMWFa+CEoLmI717Yz8x+CKNxWQmCh5u2McoeJDMpEjGZ86CrdnjIZXIs5W3FA159sfzXgLbIaChDcNqGW2JQ7BW0viiKJlyNWXp6X6YvQR31X/1In+bHtD67tJvxsHj16d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533176; c=relaxed/simple;
	bh=eiRn/vN8iDS+Y+0RkaS2CgKhhRNR/qHiMq5yJ8nBx9Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8VxpjkGg0cKr2B6vsGpSAZ0Ex6+vw1QkFsmvay5JMfT4MhDBz2PwB1bK+cPqxuqiMr3tfB8wVIkctqfxTYdXQ7DXmJtH72ScXGapaNbfCQtkkpkpq4qsBRB3iCicobfnT+OOjgqBOeGE/MZump/JR0wiVExFsfwfyTbUY68cxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mSLIHhFa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716533174; x=1748069174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eiRn/vN8iDS+Y+0RkaS2CgKhhRNR/qHiMq5yJ8nBx9Q=;
  b=mSLIHhFaOEkbNnUlHa+mq/eLCKjWEhJ/CMe8MtGwU8rbEQVSVOXOBMWW
   Ey5T99RwbZ+tiuJYO7ON3We/aGtlxR/gtmn6a4RFXbRZVmAbPbE7+Sy2R
   e5YuqPRqA3V9stuL6KSHcgMEMT2hWZzrL7JK0L7CnDZikcL64qIogMxjP
   7M0qKvaCH5ZVg11ocW6ANN1rPaqVoDl/tErk3ey+v2fPoiAawQcz5NYlL
   uFoSsm71FNgPgRRzw1zxADkWkQpoGcztagwPlAUE9qDw4Ab79HgP9J10j
   6OfY4wo8vh5GsDqu+5RMgKm1+sELXFSMyuMlxLgVqinbPmRRWiwB/YEF9
   Q==;
X-CSE-ConnectionGUID: /UL2vblMR6SFoS4wMFNRWg==
X-CSE-MsgGUID: hRmXZyaxQuyNQP9XPV9WZA==
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="28356567"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 23:46:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 23:45:41 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 23:45:41 -0700
Date: Fri, 24 May 2024 08:45:40 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Suman Ghosh <sumang@marvell.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: micrel: Fix lan8841_config_intr after getting
 out of sleep mode
Message-ID: <20240524064540.azzmscw5k333zerr@DEN-DL-M31836.microchip.com>
References: <20240523074226.3540332-1-horatiu.vultur@microchip.com>
 <SJ0PR18MB52169D42D6D26244E003BCC8DBF42@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB52169D42D6D26244E003BCC8DBF42@SJ0PR18MB5216.namprd18.prod.outlook.com>

The 05/23/2024 16:35, Suman Ghosh wrote:

Hi Suman,

> 
> >       if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> >               err = phy_read(phydev, LAN8814_INTS);
> >-              if (err)
> >+              if (err < 0)
> [Suman] Hi Horatiu,
> Should we modify this check for phy_write() as well?

I don't think we should modify this check for phy_write.
Because phy_write always return the error code. Which is negative or 0.

> >                       return err;
> >
> >               /* Enable / disable interrupts. It is OK to enable PTP
> >interrupt
> >--
> >2.34.1
> >
> 

-- 
/Horatiu

