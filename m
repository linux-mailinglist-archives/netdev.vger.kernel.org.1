Return-Path: <netdev+bounces-130876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2798BD6F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678CE282C03
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9941C3314;
	Tue,  1 Oct 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glki7/V6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8C1C2DD6;
	Tue,  1 Oct 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789129; cv=none; b=npvioSSQ8X78BesCRO2eXHT4S/jwXUVU8qX787XALlWJqg7Uw0bDL9xS2OAtC1lVrAf8h/i3R/ntBwYF58iwMbtBMD1iyAhMVisbhh7F4VqYKSBDDmzlLp3n1hNdj0tZQL2MoshMykobdd8MVwatzz5Nr4zaHhmJLELaMaunYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789129; c=relaxed/simple;
	bh=1CE1AVPyTdLHY7nU4OIhfXrULaTU2aSDh/nKeaZPus4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoAqn5BhQafSFaj1gbQXid8wJUWenGuglMsFdPaIgUUDTFP0Quq8LFN5WxJR/fyw8MVqeJpjiIxWn+mp99xR3+Mlas0eg1fjDhm1fD4tyq/pKW9ZyHGWxCC1ekUkO54D/6F85II6cO+8FDs/0EYNEbdQoYtV+E2kry5sppkQHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glki7/V6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59926C4CEC6;
	Tue,  1 Oct 2024 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727789128;
	bh=1CE1AVPyTdLHY7nU4OIhfXrULaTU2aSDh/nKeaZPus4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Glki7/V63pMVYLOOSkJLAtr/TLQYWCYAWtLkc95H9aIMvw4Kr01M12W2hnKttuVBL
	 nJ3tjEvgThzqiB5iL/CzXaNJrEp2Rhx2NFFM4bdUQjv9PkOv/5h9OqaD9D0HSxQCVn
	 wdGxTnG/KVnb7j3v6FHYhvkpWpBhrEDNjpwbhIphHVBVPQy2zx2FuFHeYfla1DJ5mT
	 PDMCeuMFC+xBnLsg8grGUGKx2vv4PBB4wJ+fXfruwvmMC4Dixj96LaFpLz2z1owKqp
	 khaX7K7ofA5upFA7FcLKkCY3AVpFJLdqpcGbtilr0fuUL5XZjnjVHVnH1S5lyhag8j
	 tRCnBgZXjxicg==
Date: Tue, 1 Oct 2024 14:25:23 +0100
From: Simon Horman <horms@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
	sd@queasysnail.net, chunkeey@gmail.com
Subject: Re: [PATCH net-next 09/13] net: ibm: emac: rgmii:
 devm_platform_get_resource
Message-ID: <20241001132523.GQ1310185@kernel.org>
References: <20240930180036.87598-10-rosenp@gmail.com>
 <202410011636.QtBtiUKi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410011636.QtBtiUKi-lkp@intel.com>

On Tue, Oct 01, 2024 at 04:24:39PM +0800, kernel test robot wrote:
> Hi Rosen,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ibm-emac-remove-custom-init-exit-functions/20241001-020553
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240930180036.87598-10-rosenp%40gmail.com
> patch subject: [PATCH net-next 09/13] net: ibm: emac: rgmii: devm_platform_get_resource
> config: powerpc-fsp2_defconfig (https://download.01.org/0day-ci/archive/20241001/202410011636.QtBtiUKi-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011636.QtBtiUKi-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410011636.QtBtiUKi-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/ibm/emac/rgmii.c: In function 'rgmii_probe':
> >> drivers/net/ethernet/ibm/emac/rgmii.c:229:21: error: implicit declaration of function 'devm_platform_get_resource'; did you mean 'platform_get_resource'? [-Wimplicit-function-declaration]
>      229 |         dev->base = devm_platform_get_resource(ofdev, 0);
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                     platform_get_resource

Hi Rosen,

I'm curious to know where devm_platform_get_resource comes from.

In any case, it would need to be present in net-next, when patches that use
it are posted, for use of it to be accepted there.

