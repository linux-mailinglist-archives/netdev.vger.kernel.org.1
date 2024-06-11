Return-Path: <netdev+bounces-102497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA09034C5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9C21F22417
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58078175543;
	Tue, 11 Jun 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d34ckmkz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E5174EC9;
	Tue, 11 Jun 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093088; cv=none; b=IEoLmG7CPGZzqK6BnaAfQ63k2NK9xsH8WQwsFUSG9jhkX5Y6Tt2bTKm2g9so1QnmWFGxSJU+avj/AExjKD2rb3f/+JOvJXFgia1HN0gjsTczK9zO5+8qfL8Eu3/J/WEh5J/TjCJhvIUMMIXQImopLISfUifXcj+fBsbb/zpYtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093088; c=relaxed/simple;
	bh=cjDSq1fkfavKtAt7cAib4nKFIPpMZ1jL1K0Sm23/ubg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvVa/bFOzwJHT4NIrlZRF4Sy4aCz9bzw3mwKPjHzJY0Swo6SymEHn4efjayCBJCjhwgjCWMIwuPHBNbKYzslwPG03W7jbRawSuXksiyL5MdgBiVKshJ+XmoRTNogFktTQDOcXFrrJMuMaCkrdEMZSd42TtzNiFG828d+FrFRl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d34ckmkz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718093085; x=1749629085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cjDSq1fkfavKtAt7cAib4nKFIPpMZ1jL1K0Sm23/ubg=;
  b=d34ckmkzBuzgnwgaEyERl8nGgTSGz6N676jUL5POrKM8LLuu4f0m78ac
   vD0+pylwwbhi1Dd3DMYZ0oc8XGs7F3Kv5rM5I+s2FFMZpFLiBp9zg2XBG
   8Pmxb32lToXe4qGJBEbXRfZPpFP01Zuy/qNRcwkHuRz0d6B39/cBYNTPg
   Ia/nQkpZQuaVZMMJ4Ef81W/5YviUcmDAHz4FbvphNAUZ9NZ3/TQ/6QemF
   /OroHw00DOy1RcXO9eWppLCwkG8Yg7IHIYPrunBHOrsNuOBbmKjzTXTOr
   hBZpfLqPjVSStLHn6Mv2zdX+3ss31tyk725EanAOLYZxFG41tas+JfMui
   Q==;
X-CSE-ConnectionGUID: u76H7Qz2QNSGdqOn7lTiWw==
X-CSE-MsgGUID: FGphlgQFRDye/ZbeONnACw==
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="27247166"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2024 01:04:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 11 Jun 2024 01:04:06 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 11 Jun 2024 01:04:05 -0700
Date: Tue, 11 Jun 2024 13:31:22 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <lkp@intel.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
	<bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <hkallweit1@gmail.com>, <hmehrtens@maxlinear.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<lxu@maxlinear.com>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <pabeni@redhat.com>, <sbauer@blackbox.su>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net V3 0/3] net: lan743x: Fixes for multiple WOL related
 issues
Message-ID: <ZmgEUrA6xM9vtDxD@HYD-DK-UNGSW21.microchip.com>
References: <202406052200.w3zuc32H-lkp@intel.com>
 <20240611062753.12020-1-Raju.Lakkaraju@microchip.com>
 <20240611071051.65e5n3bn7e4zm7lq@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240611071051.65e5n3bn7e4zm7lq@DEN-DL-M31836.microchip.com>

Hi Horatiu,

There is no new changes except "kernel test robot" reported issue.

I fix the issue and sent the patch along with other old patches.
Also add "Reported-by" and "Closes" tags to all patches and
--in-reply-to=202406052200.w3zuc32H-lkp@intel.com.
i.e.
If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/

Is it sufficient? or
Do you need to generete new version of patches ?

Thanks,
Raju
The 06/11/2024 09:10, Horatiu Vultur wrote:
> Hi Raju,
> 
> Is this not supposed to be v4?
> Because I can see v3 here:
> https://www.spinics.net/lists/netdev/msg1002225.html
> 
> The 06/11/2024 11:57, Raju Lakkaraju wrote:
> > This patch series implement the following fixes:
> > 1. Disable WOL upon resume in order to restore full data path operation
> > 2. Support WOL at both the PHY and MAC appropriately 
> > 3. Remove interrupt mask clearing from config_init 
> > 
> > Patch-3 was sent seperately earlier. Review comments in link: 
> > https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/
> > 
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>                        
> > Reported-by: kernel test robot <lkp@intel.com>                                  
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/
> 
> I think you should drop the 'Reported-by' and 'Closes' tags because the
> issue that is getting closed is the one that you introduced in one of
> your previous version of the patch series.
> 
> > 
> > Raju Lakkaraju (3):
> >   net: lan743x: disable WOL upon resume to restore full data path
> >     operation
> >   net: lan743x: Support WOL at both the PHY and MAC appropriately
> >   net: phy: mxl-gpy: Remove interrupt mask clearing from config_init
> > 
> >  .../net/ethernet/microchip/lan743x_ethtool.c  | 44 ++++++++++++--
> >  drivers/net/ethernet/microchip/lan743x_main.c | 46 ++++++++++++---
> >  drivers/net/ethernet/microchip/lan743x_main.h | 28 +++++++++
> >  drivers/net/phy/mxl-gpy.c                     | 58 ++++++++++++-------
> >  4 files changed, 144 insertions(+), 32 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 
> -- 
> /Horatiu

-- 
Thanks,                                                                         
Raju

