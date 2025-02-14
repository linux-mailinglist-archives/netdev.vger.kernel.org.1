Return-Path: <netdev+bounces-166390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77170A35DD6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB9C168694
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D28DF5C;
	Fri, 14 Feb 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfXCOA8O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2E2753E7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537202; cv=none; b=VthVkBrVcl2JyVt1zXlKKfr2+C8m1hmVdD+tnRTmu02xOPjDPAA7cvMtb6l/RkTMqjBoQXZaHSny1vrrcnzMlbrqaU07SrqQk3X6Jue9xK7IPsX64MbaZEhHCE9dKvYOFSH0IoEKNzaHdxxnXyU7Iay8OaJz2Vikzbl9xjMBZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537202; c=relaxed/simple;
	bh=wxHauzlg+BXUiSKr0BD/Ua4+vBpvNMAqjIAiar5h21I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJF4064wZLXy6GYOqYIMjv0j+Hesr+BvXnwEIxlmyE6qV2SPl48M9IgRsUmy0rd6ynVshBCGJO8OfB7pYXu7BoXCqAyGb7Na3CkFWlSZLslR0Z1nwVHjDuFI/JE7OyjDI7k8xkRtHLvSG7lDsx/R+GUe5z2gtuHI9lsrsdbaP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfXCOA8O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739537201; x=1771073201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wxHauzlg+BXUiSKr0BD/Ua4+vBpvNMAqjIAiar5h21I=;
  b=CfXCOA8OKl7GrHj+f3C9pmgh1gtNFny/5hYzB2NbXr20JGJiuZdWL88K
   rBGA7hPG+WLulZV0BiGN2+5GhS48W6z2hyiBc1FCd0OH5Z+JzPoV0P8Ik
   txbMWpaVknB0/16IkHTrLB8w+h8cuHP5tbH1qaeD9iBLhxlx8KO1YS0Zt
   LkwM/TI7tuPR+UiGt+tl4mNuR3D6TcyzLFCsHMvl0cqeXcVmMN1dhFo9B
   rJRKvQjwLHvwOKpkw1K30ycIWVn6b7Eq2WaGz7TviZaA+Mhb46pdSlsN8
   mdlXuPAVEKU0ldGaT160GBk0MAjgfsmHojbhu6lKPOZHp/ePTbu0vBUeh
   A==;
X-CSE-ConnectionGUID: ZIhGIH2TQTCn27GkblN/zg==
X-CSE-MsgGUID: U1iX6HYZRF6JLTxBRZKAgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40319070"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="40319070"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 04:46:40 -0800
X-CSE-ConnectionGUID: oR6x/a2hSHaRC8/PNz/xng==
X-CSE-MsgGUID: +5RtNyuCQDOl76LRZ2Vd/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113939301"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 04:46:39 -0800
Date: Fri, 14 Feb 2025 13:43:03 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Pierre Riteau <pierre@stackhpc.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_api: fix error handling causing NULL
 dereference
Message-ID: <Z685fovQy0yL6stZ@mev-dev.igk.intel.com>
References: <20250213223610.320278-1-pierre@stackhpc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213223610.320278-1-pierre@stackhpc.com>

On Thu, Feb 13, 2025 at 11:36:10PM +0100, Pierre Riteau wrote:
> tcf_exts_miss_cookie_base_alloc() calls xa_alloc_cyclic() which can
> return 1 if the allocation succeeded after wrapping. This was treated as
> an error, with value 1 returned to caller tcf_exts_init_ex() which sets
> exts->actions to NULL and returns 1 to caller fl_change().
> 
> fl_change() treats err == 1 as success, calling tcf_exts_validate_ex()
> which calls tcf_action_init() with exts->actions as argument, where it
> is dereferenced.
> 
> Example trace:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> CPU: 114 PID: 16151 Comm: handler114 Kdump: loaded Not tainted 5.14.0-503.16.1.el9_5.x86_64 #1
> RIP: 0010:tcf_action_init+0x1f8/0x2c0
> Call Trace:
>  tcf_action_init+0x1f8/0x2c0
>  tcf_exts_validate_ex+0x175/0x190
>  fl_change+0x537/0x1120 [cls_flower]
> 
> Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
> Signed-off-by: Pierre Riteau <pierre@stackhpc.com>
> ---
>  net/sched/cls_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 8e47e5355be6..4f648af8cfaa 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -97,7 +97,7 @@ tcf_exts_miss_cookie_base_alloc(struct tcf_exts *exts, struct tcf_proto *tp,
>  
>  	err = xa_alloc_cyclic(&tcf_exts_miss_cookies_xa, &n->miss_cookie_base,
>  			      n, xa_limit_32b, &next, GFP_KERNEL);
> -	if (err)
> +	if (err < 0)
>  		goto err_xa_alloc;
>  
>  	exts->miss_cookie_node = n;

Thanks for fixing.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The same thing is done in devlink_rel_alloc() (net/devlink/core.c). I am
not sure if it can lead to NULL pointer dereference as here.

Thanks,
Michal

> -- 
> 2.43.5

