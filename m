Return-Path: <netdev+bounces-109990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289392A998
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2854B211FF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C414E2C5;
	Mon,  8 Jul 2024 19:08:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA614B967;
	Mon,  8 Jul 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465694; cv=none; b=OyvB9Pkhg7GaiX4B0liNrsXOHkqJdcaSxczmgK7dE9sYmnvd9L0W+e3qmEW9AQuEZyz9iYf18XDznuq4jl90tixeQsiS39Eg+23GF4QfLzMh+rExKYtIjaMF+5ML78KeO3enSDqsyOXOJEkeuq/TNrskRXRunomDl/XbBDjiG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465694; c=relaxed/simple;
	bh=pYbSygs6DFw3cN9dVfNQF3w63IPyDQV/ph7ZmPU1o+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO5eyqz+2e1vMIexsxRu9mAYoWJoZZcvIgRliayGuW42qOYFqtOXjCgucMe+DkoAPMJ20Ys6UilnrV2Ylsfo7Qe+Px0TGYTKegUr/r0n0gaZOllP/DS1JpHQMgdksuXLL2iGxsaJQU7b1a+Ps6GPC2+FxjrCVLd0gYPbnexxPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so6406448a12.3;
        Mon, 08 Jul 2024 12:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720465689; x=1721070489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5VCdX60NWwfC1nVwekLYgNiGy5kNm96Cosdiq19/GM=;
        b=Vc3Mr2ZQG15v6DVdtNOutBGcabEVLFta2MGTxn8reDEw6Yo0IWSnD6IPzvEZM+6cKC
         K5Db3rTYoum2l89EN+2KapWbCCn2d9+TjfMe5+lF10zFZDpZL8wlJwJTpkU6VqwvFwHO
         mRwjZyAePEyyIHGTEyiNrRBFYsyC8F29SRGOjOYWDIKVaOkQ6OEmcTfp4uOGJ/YFSDZY
         tPrlIm3gjCVCeDUDoBPxDlckVAm1iCMtrkBaRLF+gR3BigVwZk4ajIZBgbzmUAsxAZPb
         uz4hFSze6MaFTGZaSCC329XEvXga+sc0IdH/cvTSGX/xXy+Wl5P/+HaCF4KlBl63Txf5
         o3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV98chX5X/iQdUCLMuD/yVXw9gyp0O5j+3GQMr4BbxjP29lcyy67kpIIW/0d+tH4RBdTyelKRlbeCglU8qTHBNYAK5vXz19UiWxj/3c/JeMAdoJ53wkEIfzW1b/nNwbj/UPhH+N
X-Gm-Message-State: AOJu0Ywr9vv+1LaplFf0i2oOdXdOV7jB9/C14FvGaCG+kgAflWQh3gMW
	jiO2krWkoO7XHeXnUTP/zLrUHO+nQLkIta8qEnhLTD/UWNk2nuv3
X-Google-Smtp-Source: AGHT+IHe2bAuF3QoVgM+CiLRff4u7OuOz5mDHUAISjnBCInvO4afmYAsw4m/dW4O/4hmNTBdmgEXYA==
X-Received: by 2002:a05:6402:84d:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-594ba0ced20mr293140a12.18.1720465688385;
        Mon, 08 Jul 2024 12:08:08 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda30f76sm146037a12.97.2024.07.08.12.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:08:08 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:08:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kuba@kernel.org, horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <Zow5FUmOADrqUpM9@gmail.com>
References: <20240624162128.1665620-1-leitao@debian.org>
 <202406261920.l5pzM1rj-lkp@intel.com>
 <20240626140623.7ebsspddqwc24ne4@skbuf>
 <Zn2yGBuwiW/BYvQ7@gmail.com>
 <20240708133746.ea62kkeq2inzcos5@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708133746.ea62kkeq2inzcos5@skbuf>

Hello Vladimir,

On Mon, Jul 08, 2024 at 04:37:46PM +0300, Vladimir Oltean wrote:
> On Thu, Jun 27, 2024 at 11:40:24AM -0700, Breno Leitao wrote:

> > > >      454 | static int dpaa_set_coalesce(struct net_device *dev,
> > > >          |            ^
> > > >    1 warning generated.
> > > 
> > > Arrays of NR_CPUS elements are what it probably doesn't like?

> > Can it use the number of online CPUs instead of NR_CPUS?

> I don't see how, given that variable length arrays are something which
> should be avoided in the kernel?

I thought about a patch like the following (compile tested only). What
do you think?

	Author: Breno Leitao <leitao@debian.org>
	Date:   Mon Jul 8 11:57:33 2024 -0700

	    net: dpaa: Allocate only for online CPUs in dpaa_set_coalesce
	    
	    Currently, dpaa_set_coalesce allocates a boolean for every possible CPU
	    (NR_CPUS). This approach is suboptimal and causes failures in COMPILE_TEST.
	    For reference, see:
	    https://lore.kernel.org/all/202406261920.l5pzM1rj-lkp@intel.com/
	    
	    Modify the allocation to consider only online CPUs instead of
	    NR_CPUs. This change reduces the function's memory footprint and resolves
	    the COMPILE_TEST issues.
	    
	    Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
	index 5bd0b36d1feb..7202a5310045 100644
	--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
	+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
	@@ -457,7 +457,7 @@ static int dpaa_set_coalesce(struct net_device *dev,
				     struct netlink_ext_ack *extack)
	 {
		const cpumask_t *cpus = qman_affine_cpus();
	-	bool needs_revert[NR_CPUS] = {false};
	+	bool *needs_revert;
		struct qman_portal *portal;
		u32 period, prev_period;
		u8 thresh, prev_thresh;
	@@ -466,6 +466,11 @@ static int dpaa_set_coalesce(struct net_device *dev,
		period = c->rx_coalesce_usecs;
		thresh = c->rx_max_coalesced_frames;
	 
	+	needs_revert = kmalloc_array(num_possible_cpus(), sizeof(bool), GFP_KERNEL);
	+	if (!needs_revert)
	+		return -ENOMEM;
	+	memset(needs_revert, 0, num_online_cpus() * sizeof(bool));
	+
		/* save previous values */
		portal = qman_get_affine_portal(smp_processor_id());
		qman_portal_get_iperiod(portal, &prev_period);
	@@ -498,6 +503,7 @@ static int dpaa_set_coalesce(struct net_device *dev,
			qman_dqrr_set_ithresh(portal, prev_thresh);
		}
	 
	+	kfree(needs_revert);
		return res;
	 }
	 

