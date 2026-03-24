Return-Path: <netdev+bounces-271184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP+MIwjDwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:59:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0807D3198B0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4324B3014535
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066563D5222;
	Tue, 24 Mar 2026 16:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E23A1685;
	Tue, 24 Mar 2026 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371064; cv=none; b=MhvfISf8n7hVGgFsQZjRDTMZgQmcyKpyzGB1Tj+ot4s0aUIjsUz9JDwxJi0oD1heYCYjx8hYNnTXPSkypQsBwdu0RCj9ibtrTJcMlbp9rbVcZ4Wrd01EQnf3auY5S4LsmDbFzKgDs4x5mq3SNBjcCHakfx8SJfx9cWF4LRZMgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371064; c=relaxed/simple;
	bh=Rhv1jKbAfD76JauhzUq88SPmUMAlx2Lko0H1YJDIPFo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0Imj3J1jIvOOrIL9N9D614R3oGGyLoghDQzZB815mVdjUFors1/POc12b5xwPeoPHalqhqshcdnZZOxsrZl2VttPMm4JAU44T//kmOwxMxbRFiJcLemF6KXUYx/uXjw/l2SyG8Bw+QLUcVjlyB96ZJq/7Y/UT9IopyuJdnc+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgGHj16YrzHnGj5;
	Wed, 25 Mar 2026 00:50:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D4DD840584;
	Wed, 25 Mar 2026 00:50:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Mar
 2026 16:50:58 +0000
Date: Tue, 24 Mar 2026 16:50:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Alejandro Lucero <alucerop@amd.com>, Gregory Price
	<gourry@gourry.net>
Subject: Re: [PATCH v24 08/11] cxl: Export function for unwinding cxl by
 accelerators
Message-ID: <20260324165056.000037b0@huawei.com>
In-Reply-To: <20260323113117.2352709-9-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
	<20260323113117.2352709-9-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-271184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,huawei.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 0807D3198B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 11:31:14 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add cxl_unregister_region() to the accelerator driver API
> for a clean exit.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
For this I'm seeing an outstanding question from Gregory on v23.

> ---
>  drivers/cxl/core/region.c | 17 ++++++++++++-----
>  include/cxl/cxl.h         |  1 +
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9c3ba911d865..8bb53a095290 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2468,9 +2468,8 @@ static struct cxl_region *to_cxl_region(struct device *dev)
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
> @@ -2489,6 +2488,14 @@ static void unregister_region(void *_cxlr)
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
> @@ -2642,7 +2649,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> +	rc = devm_add_action_or_reset(port->uport_dev, __unregister_region, cxlr);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> @@ -2797,7 +2804,7 @@ static ssize_t delete_region_store(struct device *dev,
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	devm_release_action(port->uport_dev, __unregister_region, cxlr);
>  	put_device(&cxlr->dev);
>  
>  	return len;
> @@ -3963,7 +3970,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = __construct_region(cxlr, ctx);
>  	if (rc) {
> -		devm_release_action(port->uport_dev, unregister_region, cxlr);
> +		devm_release_action(port->uport_dev, __unregister_region, cxlr);
>  		return ERR_PTR(rc);
>  	}
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 122b3331469d..b8cdc604480a 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -236,4 +236,5 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>  						       struct cxl_region **cxlr);
>  struct range;
>  int cxl_get_region_range(struct cxl_region *region, struct range *range);
> +void cxl_unregister_region(struct cxl_region *cxlr);
>  #endif /* __CXL_CXL_H__ */


