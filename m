Return-Path: <netdev+bounces-271199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPlbJ4HMwmkBmQQAu9opvQ
	(envelope-from <netdev+bounces-271199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:40:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD331A2B5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26FD302D5C7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689D3D5258;
	Tue, 24 Mar 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7DQXXaI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA977391E55;
	Tue, 24 Mar 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373662; cv=none; b=a9saRzkIHbktr4bCuDeI8x+jgv329vrAHyiKPAl3xl9Jy0N4EzFIe59OuIlsa+z1V9FAYSfPb9AsRvwMFF3VqmKiMivZSq2foeZStk4t9Ut4dGrXQrwKGKrLPBOqSZmwJiypfjK4ZUwR2ONjWF9IBUCqD5Zu/kFrLW7ZeALVJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373662; c=relaxed/simple;
	bh=TgV0Fr5iTGuuuHI0U1ffgGpIrF+iC19GK5v7y4zz27o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIh4Q7ny6W/xItxPZ3YhBF+ThKraKo+rca6xMh77qcUZ5HAZ5nFBQWC1CUD+ZRYkuGxOVeHhmSFKhLkfC7YOJIkHMvoqvLDtjDv4nacugFZmC6yUdSIFLXs9XSuLqYK+CZkFmbvhM00i07CIoea2FIO1SUe1FFukDkXFXLvZbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7DQXXaI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774373661; x=1805909661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TgV0Fr5iTGuuuHI0U1ffgGpIrF+iC19GK5v7y4zz27o=;
  b=i7DQXXaINMErtQ5iF74qo9h+Y/SzuFoaJEPuO9DIDemGVTJHgeTWJzo6
   2VYMRqSo5DjRDZzjqRMoTgVaMd2T6ovgQxp+bqTc/YGuOyPpOLId5sEsk
   8VMAuYWW2vugqmIR0JiVmUd+lv0FGdxxv+w/bqzlHvb901f3IOIjldfLl
   8gsNx5Rnrv0J7jz93sUN7KfXj0efWyq1EctBnv7iJw/harIx1WBA2LKKK
   Y4xXj0K9nQaEnaK8PEF7tWxKqXpoWxEOPbr2CUuVRh+i/Dhwn97v+1LUQ
   PjIzyb5DUCeTkEBZzvn07QPAR2cSAAXuijHYMJ6krrNT9MRIkYYoQsf9V
   g==;
X-CSE-ConnectionGUID: J14o2xEsRsmjX+PTi0JOxQ==
X-CSE-MsgGUID: WfjSa487STa3bfq6c+7rZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75282587"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75282587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:34:21 -0700
X-CSE-ConnectionGUID: KdwIc/QaRpOthq3D0D4Dew==
X-CSE-MsgGUID: CVYwKCSgTI2q8Vng8KIUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247481172"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.110.6]) ([10.125.110.6])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:32:36 -0700
Message-ID: <e9d16c75-edcc-4c83-8861-223c18c979e5@intel.com>
Date: Tue, 24 Mar 2026 10:32:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 06/11] cxl/hdm: Add support for getting region from
 committed decoder
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-271199-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: CDBD331A2B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 4:31 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 

Maybe subject should be "Add helper function to retrieve a committed decoder and its region"?

> A Type2 device configured by the BIOS can already have its HDM
> committed. Add a cxl_get_committed_decoder() function for cheking
> so after memdev creation. A CXL region should have been created

Sentence doesn't quite make sense to me.

> during memdev initialization, therefore a Type2 driver can ask for
> such a region for working with the HPA. If the HDM is not committed,
> a Type2 driver will create the region after obtaining proper HPA
> and DPA space.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  3 +++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c222e98ae736..006be88efaa5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	return cxled->cxld.id == port->hdm_end;
> +}
> +
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr)

kdoc header for this exported function?

> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +
> +	if (!endpoint)
> +		return NULL;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
> +				      find_committed_endpoint_decoder);
> +
> +	if (!cxled_dev)
> +		return NULL;
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +	*cxlr = cxled->cxld.region;

Should SFC take a ref on the region device?

> +
> +	put_device(cxled_dev);

Maybe should let the caller release the reference? I think you will want to hold the reference by SFC until you no longer need the decoder?

DJ 

> +	return cxled;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 10a9b8fa2f6b..2a61138e2a73 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -231,4 +231,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_attach *attach);
> +struct cxl_region;
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr);
>  #endif /* __CXL_CXL_H__ */


