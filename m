Return-Path: <netdev+bounces-259607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEkfKBqal2mK2QIAu9opvQ
	(envelope-from <netdev+bounces-259607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:17:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01137163818
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78FEC3034E11
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77BE1E1C11;
	Thu, 19 Feb 2026 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqmiFcvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB171B7F4;
	Thu, 19 Feb 2026 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771543016; cv=none; b=qMkXdgJGJn7y5Ac4UxdtpLTdIZBLDq1hIGQ/BwjD58LjFE9LktxWD2E9a1+x9DA1fNzIY7+OCrGXCHpaCdtm2zagrW6FvN4Cl5w3vRaDAqN2ejDG9UKgcm6xTZ8y0790oXT2cdFVmSV9+vcUouHY0HtlMxzqvJUr9HMJfIa67+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771543016; c=relaxed/simple;
	bh=q8poZrR+8Kv8WAPYxU+foxrSBtcaL/I2YQNkj2HuLJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPwWXCzWnH9i3Y4PDTQksb53pRtRw0AxHtoMTRHo8OI9NDgb0IyeBc8x9tak316OXoYvIUPBkT63c4azZIJtpGevUnag/VJgJmUMvgDEQbpTm9XcoRSGHiAqxmdx5pD9Sha/3Ni7pPvXc4AOm2mLwVyFRl5eYeILOXwERSogHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqmiFcvJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771543015; x=1803079015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q8poZrR+8Kv8WAPYxU+foxrSBtcaL/I2YQNkj2HuLJ0=;
  b=WqmiFcvJNuo7K+Ntk7H0HPXCX1kS6VG/VXhRK442g8WDZDmszqmOvjOd
   9JJOjnR7BmY1Wlm8aGSzUEz75QSn41zPryxwLtbolp/kIBvkuQh6IYlqm
   t76VbRwIOg/UkZ9w1vXK1xBm6CvcaOXaBXz4zl4QlN8dZ5aMsE/fo8V0n
   PO20BOKz1V4Y9lurmYAF0mDCdZYn/iY+rBHTawuj5J1StjIB0puwS4rnT
   rTnxpM3p5u7ATs4Wu+CPLWph8HXRdQkkmsxa62trlwY6SkE2BMIfsn40O
   trcrazro6M95fD+ezdiJ8DZyHvvOZySMJgmtFie8cvp/3jyUo9XnXvqlp
   Q==;
X-CSE-ConnectionGUID: mEiexDptRc6aVBJZ/hR74w==
X-CSE-MsgGUID: YPUINg1NRP27wxYMhTzCdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83266167"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83266167"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 15:16:54 -0800
X-CSE-ConnectionGUID: O6WHmfTTQyO7KJKChWqp1g==
X-CSE-MsgGUID: fYNO9aqvQvutLvet0VRouA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="237668398"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 15:16:53 -0800
Message-ID: <5ab04f4b-8758-4a02-ac58-4b4ca35cf033@intel.com>
Date: Thu, 19 Feb 2026 16:16:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 10/22] cxl: Export function for unwinding cxl by
 accelerators
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-11-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260201155438.2664640-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259607-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 01137163818
X-Rspamd-Action: no action



On 2/1/26 8:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add cxl_unregister_region() to the accelerator driver API
> for a clean exit.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 17 ++++++++++++-----
>  include/cxl/cxl.h         |  1 +
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index acf29ba3b205..954b8fcdbac6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2438,9 +2438,8 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>  	return container_of(dev, struct cxl_region, dev);
>  }
>  
> -static void unregister_region(void *_cxlr)
> +void cxl_unregister_region(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = _cxlr;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i;
>  
> @@ -2457,6 +2456,14 @@ static void unregister_region(void *_cxlr)
>  	cxl_region_iomem_release(cxlr);
>  	put_device(&cxlr->dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
> +
> +static void __unregister_region(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +
> +	return cxl_unregister_region(cxlr);
> +}
>  
>  static struct lock_class_key cxl_region_key;
>  
> @@ -2608,7 +2615,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> +	rc = devm_add_action_or_reset(port->uport_dev, __unregister_region, cxlr);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> @@ -2762,7 +2769,7 @@ static ssize_t delete_region_store(struct device *dev,
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	devm_release_action(port->uport_dev, __unregister_region, cxlr);
>  	put_device(&cxlr->dev);
>  
>  	return len;
> @@ -3878,7 +3885,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = __construct_region(cxlr, cxlrd, cxled);
>  	if (rc) {
> -		devm_release_action(port->uport_dev, unregister_region, cxlr);
> +		devm_release_action(port->uport_dev, __unregister_region, cxlr);
>  		return ERR_PTR(rc);
>  	}
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 906065e0d2a6..92880c26b2d5 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -254,4 +254,5 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>  						       struct cxl_region **cxlr);
>  struct range;
>  int cxl_get_region_range(struct cxl_region *region, struct range *range);
> +void cxl_unregister_region(struct cxl_region *cxlr);
>  #endif /* __CXL_CXL_H__ */


