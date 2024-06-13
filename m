Return-Path: <netdev+bounces-103096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283D59064BB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAAB2836F1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C34F1FC;
	Thu, 13 Jun 2024 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E0c/uV8r"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515E7FB;
	Thu, 13 Jun 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262940; cv=none; b=Lur5lD1AUWVqgiMkKGy/31NNlwfe2wH539RRWj1D9QC5Fc6psT44moaNKxdBAkt2b5c5nieAA+yM++rLhLNfjUCGEVURiW6LxQ9fCf3oOkI8Z6RPIxfZME5CkrjbxaZ5G4xNraQdxlHSeteDvUwlKI+9uXCTvSRbI6ycdPWFlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262940; c=relaxed/simple;
	bh=0KZDVCHU1ke+scOPribbRJfLeKAfVbhgKdVtbbMs45Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7NACx2y+9sLtKzdonlYRUljO0sHsDAODf2HldBwSjK99MgfbxyB7E6C4HRtFOdniuFPdQe765AOcD9MjNDRZ09pql2j/Wh0E2MQ3JMWSfEQOL90IyZPox2pOVzdRIEKq9LdgMw7AXt2OKo7u/gXsqKC47WbUuATYvCf1fw/raE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E0c/uV8r; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718262937; x=1749798937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0KZDVCHU1ke+scOPribbRJfLeKAfVbhgKdVtbbMs45Y=;
  b=E0c/uV8rG2fVwqevqlQ2vJvou9G55tDTxD9RGM41aUJ37kKFIoWfwimV
   goTTs7jQ/SsVJOHDs79M6MuEy4zy+eAgdTv1NtZbHU91ZTdixWeVydiGY
   xU6hGcRLh+aywN50FmaMiRadaVEQZ+JtLvABS6HPzN7kh67fWakjCvzDW
   rJ3NXnfji8LRwtdWo4eKcv64YWnIbNTQX9fiu992syaJvBNMUygDr72ik
   61p0SJecZQp9WRNWqF8sVrz6S24YqLxMABFMWcRGl9ja8sFxcLh9oI448
   FmkvGvP/j7eOLTXz6q8xD9OotOJDtmEkuG4hQh0eHtZKMunDsPE0giT/H
   A==;
X-CSE-ConnectionGUID: z6dg9MMNQnuqOU7D85zK+g==
X-CSE-MsgGUID: h+nuc1/cQb2smCe4kcwaVw==
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="27356386"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2024 00:15:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 13 Jun 2024 00:15:33 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 13 Jun 2024 00:15:33 -0700
Date: Thu, 13 Jun 2024 09:15:32 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
	<andrew@lunn.ch>, <linux@armlinux.org.uk>, <sbauer@blackbox.su>,
	<hmehrtens@maxlinear.com>, <lxu@maxlinear.com>, <hkallweit1@gmail.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <wojciech.drewek@intel.com>,
	<UNGLinuxDriver@microchip.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net V4 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
Message-ID: <20240613071532.tx376cehgvqjgyqx@DEN-DL-M31836.microchip.com>
References: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
 <20240612172539.28565-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240612172539.28565-3-Raju.Lakkaraju@microchip.com>

The 06/12/2024 22:55, Raju Lakkaraju wrote:

Hi Raju,

> Prevent options not supported by the PHY from being requested to it by the MAC
> Whenever a WOL option is supported by both, the PHY is given priority
> since that usually leads to better power savings.
> 
> Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")

I am not sure if you run checkpatch.pl, but this gives you a warning.
The sha has too many chars.

> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/

I still don't think you should add the 'Reported-by' and 'Closes' tags
here because you introduced the issue in first V3 of this patch series.
Because the intel robot says: "If you fix the issue in a separate
patch/commit (i.e. not just a new version of the same patch/commit),
kindly add following tags".

-- 
/Horatiu

