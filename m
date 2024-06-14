Return-Path: <netdev+bounces-103456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB489082F4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 06:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53144283FF3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 04:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46A130A54;
	Fri, 14 Jun 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T6mBp3+T"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873851E4BE;
	Fri, 14 Jun 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718339428; cv=none; b=FNjzb/narVxGywEyDXV4GOBuN/aUcU2uAJyU4bTd1fxWPsuY/rt5J704RmVzCMHXESeAQrAwJSmIhNLOQ+9iPMracQUwAoweYXsjgLpNmy+UD95hngQcuPiP8MfQHx+32MZBNS4s0loLDZ5a4+io5plZTW9b2sV8FMwcEXq2v80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718339428; c=relaxed/simple;
	bh=tsflE49CV41bPrXn9OE6AiMLh5pZ25t/Y23e+/qJhy8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy0DDbf5yfLuJ+h1QN00wRIMSz5BfFFL3VhprlgQa5g8x1OA+z8wDS/JF0KbyBi9oT3c2rvci0xR+h39z8tXva0lM2w1UPbnJloTX+Bwi3zmdvYbmmF191916wzgvY1xNm64po9gscFzyjdJnXKyzpkrVpAjNQKSYlJ/VZCuGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T6mBp3+T; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718339421; x=1749875421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tsflE49CV41bPrXn9OE6AiMLh5pZ25t/Y23e+/qJhy8=;
  b=T6mBp3+TAcOXbjisT1nkUGnadFnFexdPgwJ1vXCEJE+nXhNoO8RiRACZ
   0ae6tNYN4GgEMYxIAnM2OyzrD5uH2iOnnWE+7Y58Em/ksd6+ag+6l+PMN
   aU51+1f08691TL+EimfSY9IFgQRYyqeYI5pGTxzXqvKZ/vcVRrOZ2WwxK
   wwH15jwTu3Xfwb02Ro9VwxrcTwcz7H1V1NsLZHJIzMmd68oV+q8VDxT8V
   Q8eI3CZKjNDDLxI8WnvXtx49UNOOa0l4WLTzpOnzmrmNZtNSOuOaKrAd2
   pkJXJXQ6i0GUeqqNJ7qUSZqVcKhnGUx7dWvCm4mfDRKDbLti20PBgiCeR
   A==;
X-CSE-ConnectionGUID: OjLhOlxKTSaOlxAEgbhxtA==
X-CSE-MsgGUID: I14g26kQRLef/3WKsLNqzQ==
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="194898935"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2024 21:30:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 13 Jun 2024 21:29:34 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 13 Jun 2024 21:29:34 -0700
Date: Fri, 14 Jun 2024 09:56:47 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<wojciech.drewek@intel.com>, <UNGLinuxDriver@microchip.com>, "kernel test
 robot" <lkp@intel.com>
Subject: Re: [PATCH net V4 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
Message-ID: <ZmvGhwxFNYx1OV4c@HYD-DK-UNGSW21.microchip.com>
References: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
 <20240612172539.28565-3-Raju.Lakkaraju@microchip.com>
 <20240613071532.tx376cehgvqjgyqx@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240613071532.tx376cehgvqjgyqx@DEN-DL-M31836.microchip.com>

Hi Horatiu,

The 06/13/2024 09:15, Horatiu Vultur wrote:
> The 06/12/2024 22:55, Raju Lakkaraju wrote:
> 
> Hi Raju,
> 
> > Prevent options not supported by the PHY from being requested to it by the MAC
> > Whenever a WOL option is supported by both, the PHY is given priority
> > since that usually leads to better power savings.
> > 
> > Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
> 
> I am not sure if you run checkpatch.pl, but this gives you a warning.

I ran the checkpatch.pl on individual files and not on patches.

> The sha has too many chars.

Yes. instead of 12 chars, paste the 13 chars. I will fix this issue in next
version of patch series.

> 
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/
> 
> I still don't think you should add the 'Reported-by' and 'Closes' tags
> here because you introduced the issue in first V3 of this patch series.
> Because the intel robot says: "If you fix the issue in a separate
> patch/commit (i.e. not just a new version of the same patch/commit),
> kindly add following tags".
> 

Ok. I will remove.
> -- 
> /Horatiu

-- 
Thanks,                                                                         
Raju

