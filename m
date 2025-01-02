Return-Path: <netdev+bounces-154741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929029FFA50
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894A33A2227
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328A1A2632;
	Thu,  2 Jan 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvzPjtUS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C7192D70
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827432; cv=none; b=me6AjD6azjxgIYFhKoYcKMdJQuti3dV3owJTRoHXA3IVA9g/XWV2UVqQXKFpd77WvLBk84RT+L5gkHENYR0D0uRO4xYAuuhpWHWuyu9winVSQS6gDw7u09EnPqc5kWUShMyclrjQA34lwe9r9xTtR8UHawYctX57GRIpuekyjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827432; c=relaxed/simple;
	bh=1EXu8p0MVErak0M/pugkG67/Oe5jhEkJvRGJafHRY2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htptaIJk5HJfS00prFFVtr6F+qi0R3HrwTYyX4VrnRiG4HdUjvIfkpvrHilu/F6Ap+EbC0ZhtbVGr2M4YPdUvZPqVtJkElyxu3YIJ/SEnbpvJ3bS47NPuS6A96ixUwZZ12uxIZu18UdZklDYsAJVj8mBQWOxaiLgyCXBdKW6aqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvzPjtUS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827431; x=1767363431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1EXu8p0MVErak0M/pugkG67/Oe5jhEkJvRGJafHRY2o=;
  b=FvzPjtUSKDkUM9pAkl763+5TnxzOATqAEC5Gcn4ATn8BWQCvI9DiylJ+
   8hFUxaxUFxoozbfczF8gy3d+ZODH6jzMhPv1BjOthFxAhPV5uRRnpMV5O
   gwXfCJrz+jly8mZjdfTp947nY9K5ayIMuxJ1VlooBZRL77/bvSa4y50Li
   sOSMre6PhybQc/R40IRFwODeI7QhRV8B9biZUpfORar9V6Ap34F+MUxB8
   XsSsCu147UpU23ymMKiBmb++y9l+vXFB46h+BsNZ+/CR2x5fLGcJGORzH
   8ye3HTNoBBEjht1IwQvKqM+W++MS42iw57ffEwRffhNHR8gWXmOVBbuxq
   g==;
X-CSE-ConnectionGUID: O3jg0MVvTciHvMTrU9ny8A==
X-CSE-MsgGUID: fNh1R2i6Tki7+ruaaIUlYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="61436728"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="61436728"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:17:10 -0800
X-CSE-ConnectionGUID: QAxi8C0RS46FjoFSxTBlPA==
X-CSE-MsgGUID: 1CgV45B3S6e+p0NIgfi46Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="106565859"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:17:09 -0800
Date: Thu, 2 Jan 2025 15:13:53 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew+netdev@lunn.ch, pabeni@redhat.com, bharat@chelsio.com
Subject: Re: [PATCH net] cxgb4: Avoid removal of uninserted tid
Message-ID: <Z3afIWnNJ/IAB8OJ@mev-dev.igk.intel.com>
References: <20250102121018.868745-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102121018.868745-1-anumula@chelsio.com>

On Thu, Jan 02, 2025 at 05:40:18PM +0530, Anumula Murali Mohan Reddy wrote:
> During ARP failure, tid is not inserted but _c4iw_free_ep()
> attempts to remove tid which results in error.
> This patch fixes the issue by avoiding removal of uninserted tid.
> 

You need a fixes tag. Like here for example
https://lore.kernel.org/netdev/CANn89iJP4unWmk2T36t1LiFrchy+DSGkbZWz_i42mb1eCDXyeg@mail.gmail.com/T/#m197e95ef4948a30732c1f6a046d3f0f7af163826

> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index bc3af0054406..604dcfd49aa4 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -1799,7 +1799,10 @@ void cxgb4_remove_tid(struct tid_info *t, unsigned int chan, unsigned int tid,
>  	struct adapter *adap = container_of(t, struct adapter, tids);
>  	struct sk_buff *skb;
>  
> -	WARN_ON(tid_out_of_range(&adap->tids, tid));
> +	if (tid_out_of_range(&adap->tids, tid)) {
> +		dev_err(adap->pdev_dev, "tid %d out of range\n", tid);
> +		return;
> +	}

Fix looks fine, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
>  	if (t->tid_tab[tid - adap->tids.tid_base]) {
>  		t->tid_tab[tid - adap->tids.tid_base] = NULL;
> -- 
> 2.39.3
> 

