Return-Path: <netdev+bounces-182123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFADA87E5E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6650B1896810
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713EA28541E;
	Mon, 14 Apr 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VV1AK1V5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C528135F;
	Mon, 14 Apr 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628695; cv=none; b=BByvUY5vp3iU5+/EPNUDyV4MT+iYIstak6V5WFfW9dblAL/xLvx+aYmDkM1mNcaA8F9gq5ruq30lKlIdDaDjOr5nfe11tTho4ZjqZRw/tP0WkNmJzaGYKJuFQoUeKI9pQvNyxxrqqXi/E+dGZTmw3gw5acnpCbFDjkMdwHbwcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628695; c=relaxed/simple;
	bh=Xb+ZACY0NBbV0NNh0WCuT+XRv3B9nkGlGyr3iQ9+hJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixGRGC1bxxYnVNc3hz9NpaNnpDqtU6+CCtyLCBiVPdz/di4PjVVwAUCkF80l8rNxhSZ+1uPTBsnbH1huHFS+rBruflnESr69L47boN2Biqq4retFywoDWAL6olyoW5vUw/Wvob6n4PdmKdTq7zLrB0eD70M841Knv0XiM7+002s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VV1AK1V5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744628693; x=1776164693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xb+ZACY0NBbV0NNh0WCuT+XRv3B9nkGlGyr3iQ9+hJg=;
  b=VV1AK1V5dHPqLTQMRCcbjP2GN9Vxfl9ALQ7NVZub2ce2CsTMxyp8G5cd
   zek6aobknvVXh7B7Om0TSaW6qIgRHzOSFjJtyPhffe/wDSTDfdpxTE4ui
   MFy/tVBB2OKpmXfHbJGG5VjblteMBXXl7SQGvHcAfetj3P4vf7ymnxKhR
   4XJj2zeVsxxKsG31jKO9QJ8a7YvLQUf5XUlV5y/4MUWYHyFhP+vYU5KFo
   OcCizLnXAV6ranPv1D+yUr/pjjFOqWYN/6M5sgHim1iNUI3Pt4L1kzQHj
   byhM5yGgLtFrucq315v4SvWojF2e9oPhAFYMWJPNDqvwd51jTUuiiSejJ
   Q==;
X-CSE-ConnectionGUID: EY1hxaWoR1e3clZarB9STw==
X-CSE-MsgGUID: olBH3KwsQduz10eJvQlGuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45975300"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="45975300"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 04:04:52 -0700
X-CSE-ConnectionGUID: r4FQGc8oSTibqdWydMwWnw==
X-CSE-MsgGUID: Sjmp7A6rQsiPjn1mfahqwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130328463"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 04:04:50 -0700
Date: Mon, 14 Apr 2025 13:04:32 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf: handle otx2_mbox_get_rsp errors
Message-ID: <Z/zrwJJhR1pDwfj/@mev-dev.igk.intel.com>
References: <20250412183327.3550970-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412183327.3550970-1-chenyuan0y@gmail.com>

On Sat, Apr 12, 2025 at 01:33:27PM -0500, Chenyuan Yang wrote:
> Adding error pointer check after calling otx2_mbox_get_rsp().
> 
> This is similar to the commit bd3110bc102a
> ("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c").
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 04e08e06f30f..7153a71dfc86 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -67,6 +67,8 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
>  
>  		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
>  			(&priv->mbox.mbox, 0, &req->hdr);
> +		if (IS_ERR(rsp))
> +			goto exit;

Changes looks fine:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

BTW, looks like now you can use break instead of goto exit, as exit
label is just after the while loop.

>  
>  		for (ent = 0; ent < rsp->count; ent++)
>  			rep->flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
> -- 
> 2.34.1

