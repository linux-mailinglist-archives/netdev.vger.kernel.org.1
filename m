Return-Path: <netdev+bounces-176077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D465FA689FD
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1990819C2EC6
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857825335B;
	Wed, 19 Mar 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+k6R8rZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BE1F4CBE;
	Wed, 19 Mar 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381374; cv=none; b=VLrbkxcbi3EA5x4ZDPNeaArk3tEemPIrrc1SmuLPYMYkOmc5plTgSwB+TIL9ajtw6H1cBDh28hRCJP1Ul4lZCa9EnbVBf9KO9dXbce+yZYXJMZWVf6KRrx61WAemet7t/pamcHAlRc6DPwbvB3PK1jBjgksYqzAV23wmUyLcuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381374; c=relaxed/simple;
	bh=Hya7auSVdyREqWERkbjgRLv4JYAV8mlJZeA4nf44CBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL5olORP4VHiy7EGHMuU+tGaoj3tWpKletJswSkQmCi7YsP7DDPqD7MvjLsy5UtODyUEknctUK4Su1MZquHIoFAvQCu8lx6md5QwACmeCFqyjIt4vHgI9pzyYL4bHjyilaNda4Ueq7Xzm8gBr5R3Jxoje8Ey92HZ/Px7UlIsyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+k6R8rZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381373; x=1773917373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hya7auSVdyREqWERkbjgRLv4JYAV8mlJZeA4nf44CBM=;
  b=g+k6R8rZqSgF5dtysoT1d/Yj+BT1Qob0kRwPWE6MNQYgwZ0GZkrdIjVW
   d6ejfSUFUgNVy09CsFp3MWYYFx+zE4lcbZVQMiQFH5mvz0UdVDfEF+QWY
   UyQV0ugvcEmmklqA0LgxE1u9q7QjUQCCid2e/RTWo22vuHUtvDOIVJ/r/
   4WaEck5+2wfvfT/mizCTY0lYxlYGwopSd1NzXUyso1p6KcofmdB+vGjLs
   tHZbCLqWF4gvqsIT7cAPEZZgwaFvHROZ807ijWjGe5t/VQ/9evB4TawMI
   SdJwENPeWAj/3zugDDWwcg7c0ohc4sd8MbrT8OrMWbITDMu6btxhWbNKp
   w==;
X-CSE-ConnectionGUID: aWiDWvyBRp62a92t1KayHg==
X-CSE-MsgGUID: Cv7zvkEvTNa4mU4NTbAnZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54233897"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54233897"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:49:31 -0700
X-CSE-ConnectionGUID: Ed/4ayEfQdukuG1A775k3Q==
X-CSE-MsgGUID: iSXvO9gGSnSls3y7j6dXCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="145754588"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:49:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuqzG-00000003tVA-2pN4;
	Wed, 19 Mar 2025 12:49:26 +0200
Date: Wed, 19 Mar 2025 12:49:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9qhNnnwkMaMCbI1@smile.fi.intel.com>
References: <20250318161702.2982063-1-andriy.shevchenko@linux.intel.com>
 <481268aa-c8e9-4475-bd5c-8d0f82a6652a@lunn.ch>
 <Z9mlWNdvWXohc6aM@smile.fi.intel.com>
 <f9640312-3641-4f32-9803-a76b2b010d7d@lunn.ch>
 <Z9qd6HfmfE18Clxv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qd6HfmfE18Clxv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 12:35:21PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 06:09:12PM +0100, Andrew Lunn wrote:
> > On Tue, Mar 18, 2025 at 06:54:48PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 18, 2025 at 05:49:05PM +0100, Andrew Lunn wrote:

...

> > > > > -	char phy_name[20];
> > > > > +	char phy_name[MII_BUS_ID_SIZE + 5];
> > > > 
> > > > Could you explain the + 5?
> > > > 
> > > > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/davicom/dm9051.c#L1156
> > > > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/freescale/fec_main.c#L2454
> > > > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/xilinx/ll_temac.h#L348
> > > > 
> > > > The consensus seems to be + 3.
> 
> And shouldn't it be 4 actually? %s [MII_BUS_ID_SIZE] + ':' + '%02x' + nul
> 
> > > u16, gcc can't proove the range, it assumes 65536 is the maximum.
> > > 
> > > include/linux/phy.h:312:20: note: directive argument in the range [0, 65535]
> > 
> > How about after
> > 
> >         ret = asix_read_phy_addr(dev, priv->use_embdphy);
> > 	if (ret < 0)
> > 		goto free;
> > 
> > add
> > 
> >         if (ret > 31) {
> > 	        netdev_err(dev->net, "Invalid PHY ID %d\n", ret);
> > 	        return -ENODEV;
> > 	}
> > 
> > and see if GCC can follow that?
> 
> No, with + 3 it doesn't work, need + 4.
> 
> Another possibility to change the _FMT to have %02hhx instead of %02x.
> 
> Tell me which one should I take?

I'll make a series, because on the second though it seems that fixing
formatting string will fix the other cases at the same time.

-- 
With Best Regards,
Andy Shevchenko



