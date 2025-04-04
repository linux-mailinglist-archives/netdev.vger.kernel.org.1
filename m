Return-Path: <netdev+bounces-179347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B8A7C13C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9494D1789D6
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A621202C3D;
	Fri,  4 Apr 2025 16:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984B8F40;
	Fri,  4 Apr 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782760; cv=none; b=fQUmfn30IvQ+MRhowuTCK0ueNloMerSU0yYoqVjxX4bov3JxPs0vZNoOvjwQDWqT/oyg2i7tTt5wOEXrD5p84JkhIzfDhB0buEbpOSlOtzHZX1spX+WjQMVvt+Zc85AjMVlSZJKCxbNhoAXNbyhByI0WxQzosSU1JgLWo8mnrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782760; c=relaxed/simple;
	bh=lUHeIVdfGihbA0/9T++ikZ7sSEL0N6KLBdlWfjWAb0A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvVjYrULd4Oh7SsnYsxOjeTWzrNYBEhZBvtZDzYaEF+DcOXOqhktZYz4DXhvJyUJg5W77n8emTCvWJPO4C1s0DX8aiQkOjB/27Bq44uMhH8axEF8G6y1fr1d0EtT19dGphCgZHppzZyrOixYXgOpliO+1rZ/7Z/e+bA7Amgd1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTjzV04qhz6M4by;
	Sat,  5 Apr 2025 00:02:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0465E140857;
	Sat,  5 Apr 2025 00:05:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 18:05:55 +0200
Date: Fri, 4 Apr 2025 17:05:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 07/23] cxl: support dpa initialization without a
 mailbox
Message-ID: <20250404170554.00007224@huawei.com>
In-Reply-To: <20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:39 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for dma initialization.

DMA

> 
> Allow a Type2 driver to initialize dpa simply by giving the size of its

DPA

> volatile and/or non-volatile hardware partitions.
> 
> Export cxl_dpa_setup as well for initializing those added dpa partitions
> with the proper resources.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/mbox.c | 17 ++++++++++++++---
>  drivers/cxl/cxlmem.h    | 13 -------------
>  include/cxl/cxl.h       | 14 ++++++++++++++
>  3 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ab994d459f46..e4610e778723 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1284,6 +1284,18 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>  	info->nr_partitions++;
>  }
>  
> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
> +		      u64 persistent_bytes)
> +{
> +	if (!info->size)

Why?  What is this defending against?

> +		info->size = volatile_bytes + persistent_bytes;
> +
> +	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, volatile_bytes, persistent_bytes,
> +		 CXL_PARTMODE_PMEM);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");


