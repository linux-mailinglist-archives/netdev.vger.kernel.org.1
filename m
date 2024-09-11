Return-Path: <netdev+bounces-127341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503239751AC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8C31F222C9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB77188A06;
	Wed, 11 Sep 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nl6gX6a8"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01071502.me.com (qs51p00im-qukt01071502.me.com [17.57.155.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840218B485
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056927; cv=none; b=fGlrnoQM4SPiLn9Sp9aPBXutJdOGlLk8EFLgPpIhssm022shNmfN9LBgDcVgIrCCCSFIYm3twJvBlwDAxAia6ZNUh5KFtMEDamYY/FeefkCmc35Pc1zSFB5DM4CAr2jTgl6195IlCSZXy+l6ocnMnY3qeidLyCjhIpzIzGuk+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056927; c=relaxed/simple;
	bh=uvBoEJkZPMzyJY7fNpBdAjA0QoUIlWc+SNmkMyLKgLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgiZbkFMY3al3ZkWNfOiMk/94pFbJnhnKgkVapeWM+WJWUGVTK32VWBTsQuGZS/dD/n1T1cEHguPBj1gZxh80yQ1of+2BEv/YO5fm0k0lIn+Ur0L/tFQPfTHQ1B1z7I9rer/Xg5a3EbNQeG4JdhRQJLDu1fScIXzI+v22FtWxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nl6gX6a8; arc=none smtp.client-ip=17.57.155.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726056924;
	bh=mJlRX5g2zaG0MjZJ0FgGPU46Ka9U2vJBRMtqv60HUcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=nl6gX6a8Or3CYv+xGVRogzvx62ADgQCxshMMOyl+F7R5zWIMMc61zC9UcJqmxmoH0
	 7bZJsNJ94N3tjX+zcHiBeJmG3fAQHs6t57pxk2y/zss/tzGtZR3eF0a78g5Bo6hEdh
	 uJdmlxQxHfSvHYm1CDV2E/TVqz1HA7LRED85xr1IR1r5ROhi11GA+UQJj4nSR/HMCJ
	 5Z4hmaPiOYyzsK8d3SvdsB+gezQa4pOO/tLUiOCxB0sRvMP8elO7j43vyycU7TW7It
	 4q17nVQgZacy8dACvRCSbh80uMYnS/Qkc36uceYOmplUrrNptIC8KSBdWFZUj6oZP6
	 5NjbzjJVKnq1Q==
Received: from [192.168.1.26] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071502.me.com (Postfix) with ESMTPSA id D215666803FE;
	Wed, 11 Sep 2024 12:15:16 +0000 (UTC)
Message-ID: <11576596-f0e4-4e88-a200-ed22b86d5974@icloud.com>
Date: Wed, 11 Sep 2024 20:14:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Dan Williams <dan.j.williams@intel.com>,
 quic_zijuhu <quic_zijuhu@quicinc.com>, Ira Weiny <ira.weiny@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
 <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
 <e7e6ea66-bcfe-4af4-9f82-ae39fef1a976@icloud.com>
 <66e06d66ca21b_3264629448@dwillia2-xfh.jf.intel.com.notmuch>
 <66e08f9beb6a2_326462945d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66e08f9beb6a2_326462945d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UC_ONF6QW8nNb7s75RrcWy0ShHB2d9R8
X-Proofpoint-GUID: UC_ONF6QW8nNb7s75RrcWy0ShHB2d9R8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409110092

On 2024/9/11 02:27, Dan Williams wrote:
> Dan Williams wrote:
> [..]
>> So, while regionB would be the next decoder to allocate after regionC is
>> torn down, it is not a free decoder while decoderC and regionC have not been
>> reclaimed.
> 
> The "simple" conversion is bug compatible with the current
> implementation, but here's a path to both constify the
> device_find_child() argument, *and* prevent unwanted allocations by
> allocating decoders precisely by id.  Something like this, it passes a
> quick unit test run:
> 

sounds good.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..749a281819b4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1750,7 +1750,8 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
>  	struct device *dev;
>  	int rc;
>  
> -	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
> +	rc = ida_alloc_max(&port->decoder_ida, CXL_DECODER_NR_MAX - 1,
> +			   GFP_KERNEL);
>  	if (rc < 0)
>  		return rc;
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..1f7b3a9ebfa3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -794,26 +794,16 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  
> -static int match_free_decoder(struct device *dev, void *data)
> +static int match_decoder_id(struct device *dev, void *data)
>  {
>  	struct cxl_decoder *cxld;
> -	int *id = data;
> +	int id = *(int *) data;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxld = to_cxl_decoder(dev);
> -
> -	/* enforce ordered allocation */
> -	if (cxld->id != *id)
> -		return 0;
> -
> -	if (!cxld->region)
> -		return 1;
> -
> -	(*id)++;
> -
> -	return 0;
> +	return cxld->id == id;
>  }
>  
>  static int match_auto_decoder(struct device *dev, void *data)
> @@ -840,16 +830,29 @@ cxl_region_find_decoder(struct cxl_port *port,
>  			struct cxl_region *cxlr)
>  {
>  	struct device *dev;
> -	int id = 0;
> -
>  	if (port == cxled_to_port(cxled))
>  		return &cxled->cxld;
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
>  		dev = device_find_child(&port->dev, &cxlr->params,
>  					match_auto_decoder);
> -	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +	else {
> +		int id, last;
> +
> +		/*
> +		 * Find next available decoder, but fail new decoder
> +		 * allocations if out-of-order region destruction has
> +		 * occurred
> +		 */
> +		id = find_first_zero_bit(port->decoder_alloc,
> +					 CXL_DECODER_NR_MAX);
> +		last = find_last_bit(port->decoder_alloc, CXL_DECODER_NR_MAX);
> +
> +		if (id >= CXL_DECODER_NR_MAX ||
> +		    (last < CXL_DECODER_NR_MAX && id != last + 1))
> +			return NULL;

Above finding logic seems wrong.
what about below one ?

 last = find_last_bit(port->decoder_alloc, CXL_DECODER_NR_MAX);

 if (last >= CXL_DECODER_NR_MAX)
    id = 0;
 else if (last + 1 < CXL_DECODER_NR_MAX)
    id = last + 1;
 else
    return NULL;

> +		dev = device_find_child(&port->dev, &id, match_decoder_id);
> +	}
>  	if (!dev)
>  		return NULL;
>  	/*
> @@ -943,6 +946,9 @@ static void cxl_rr_free_decoder(struct cxl_region_ref *cxl_rr)
>  
>  	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
>  	if (cxld->region == cxlr) {
> +		struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +		clear_bit(cxld->id, port->decoder_alloc);
>  		cxld->region = NULL;
>  		put_device(&cxlr->dev);
>  	}
> @@ -977,6 +983,7 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>  	cxl_rr->nr_eps++;
>  
>  	if (!cxld->region) {
> +		set_bit(cxld->id, port->decoder_alloc);
>  		cxld->region = cxlr;
>  		get_device(&cxlr->dev);
>  	}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9afb407d438f..750cd027d0b0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -578,6 +578,9 @@ struct cxl_dax_region {
>  	struct range hpa_range;
>  };
>  
> +/* Max as of CXL 3.1 (8.2.4.20.1 CXL HDM Decoder Capability Register) */
> +#define CXL_DECODER_NR_MAX 32
> +
>  /**
>   * struct cxl_port - logical collection of upstream port devices and
>   *		     downstream port devices to construct a CXL memory
> @@ -591,6 +594,7 @@ struct cxl_dax_region {
>   * @regions: cxl_region_ref instances, regions mapped by this port
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
> + * @decoder_alloc: decoder busy/free (@cxld->region set) bitmap
>   * @reg_map: component and ras register mapping parameters
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
> @@ -611,6 +615,7 @@ struct cxl_port {
>  	struct xarray regions;
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
> +	DECLARE_BITMAP(decoder_alloc, CXL_DECODER_NR_MAX);
>  	struct cxl_register_map reg_map;
>  	int nr_dports;
>  	int hdm_end;


