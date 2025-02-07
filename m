Return-Path: <netdev+bounces-163965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD7FA2C319
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F30316AA75
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E51E04AD;
	Fri,  7 Feb 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZNM0J0d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DA1A260;
	Fri,  7 Feb 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932948; cv=none; b=RgCnJh/FuV3hV53rHgy7xF+ulZThnKroE1Qwie4igQlKjG164GVOSeUfs1PJfEZkw4XB+NK1aUMenOAqRY9l2HllISzi/Qleda/AC/IpNbuF5kkrvZ3kr26gKVGi5i87S2B+iWAmu+TTr6W1SpZDkmiG7qAqEnVWYMl/iiS5dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932948; c=relaxed/simple;
	bh=UBCBRhwkkRi/uwegXH4w6XZjDAhtUW45z+ZLEeQCO4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSXfb9Jy+qVvCH4VW4NWYdWjApo/5N9aEsJ6WeAp6sGoZcGl1dFJ0xygR3lMylwyjFj1GkiiosdJ8OAG0Vy0BOwBjdrbcacH+YH5K3fWPfloRtQ6oi9zLHZiQ49o7nMLLKeuDsfhMuaRTqvL03dYd4xTIMhB7AOrSSy2w6tSBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZNM0J0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B1EC4CED1;
	Fri,  7 Feb 2025 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932947;
	bh=UBCBRhwkkRi/uwegXH4w6XZjDAhtUW45z+ZLEeQCO4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZNM0J0duXEVVky2iOZ/6UoXSHv/b5mtU1raSX/+psvup92ghHs/zwYO61H2rXSyQ
	 pZnOAD4hZ6nE2Te7hpcEi92plq9EJ1BsC+3QFLdOr4RmJU99a0f7iwQ+QSJ95wKIU0
	 Z+ityEnTMJ1MT1WniwzUG/5v1jVmhYXMzLYAT+NsbOKCU9ELriZdJoC2GYh03dz+Vm
	 RvbxF+w5PYGUdbCTP/ATuYMRp3V115aheY+td3uRnq6nsH8oaxNaVJXwKTe42bu6oq
	 q6JVyEwo6Utrb2tJqjCr+DGpmPAPfzz0mndIH4Rf5cbfRX65dypOS2N7Uiru+pC8JH
	 D/bZXyTgePfcw==
Date: Fri, 7 Feb 2025 12:55:43 +0000
From: Simon Horman <horms@kernel.org>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 14/26] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <20250207125543.GR554665@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-15-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-15-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:38PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |  10 +++
>  3 files changed, 173 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 84ce625b8591..69ff00154298 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++)
> +		for (int j = 0; j < ctx->interleave_ways; j++)
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;

Hi Alejandro,

found is incremented here, but does not appear to have been initialised.

Flagged by W=1 build with clang-19, and by Smatch.

> +				break;
> +			}

...

