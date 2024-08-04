Return-Path: <netdev+bounces-115562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DDA947008
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DB91C20356
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33DB762EB;
	Sun,  4 Aug 2024 17:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C018A95B;
	Sun,  4 Aug 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722792413; cv=none; b=DNvGJJpIihfQJOVBzfATX11QmPAaabUBRTYk9yznAs+ZTtmbNxrWpvjd9+dSz+9hUXjnellV/pQ94ZDHgc3cBhXoPZjnNwh2Zn4HjyPkj1WxDq6JgM9t93xMBQ1/gbVKcKwTgU4ICovm1H8DGng4aBeP3JB3a+ZHjPF9TCzMGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722792413; c=relaxed/simple;
	bh=RXap8eb+ilvj6dBmSI15dHfnmJWdw7x5LYjsWP8jCcA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULF0qt8dZd4EeXgd75a9sdcy0uT936cIt2oP0bzMVierrPN/262eZQF4QGOn3xanRS5z2ysAa7bxTiLcuzUJhvumKpCgp7xLKjc2p1wJRrXNpSCdNRSL7ENsq+F7Z1naVPvMcDM+nxjohneHVKLs5GZL8wuU3rKgLUOXjZNk6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcRJ80VxSz6K8pm;
	Mon,  5 Aug 2024 01:24:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AB6131401DC;
	Mon,  5 Aug 2024 01:26:48 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:26:48 +0100
Date: Sun, 4 Aug 2024 18:26:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 06/15] cxl: add function for setting media ready by
 an accelerator
Message-ID: <20240804182646.00004a56@Huawei.com>
In-Reply-To: <20240715172835.24757-7-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-7-alejandro.lucero-palau@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:26 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type-2 driver can require to set the memory availability explicitly.
> 
> Add a function to the exported CXL API for accelerator drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c          | 7 ++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
>  include/linux/cxl_accel_mem.h      | 2 ++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b4205ecca365..58a51e7fd37f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -714,7 +714,6 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -
Grumpy maintainer time ;)
Scrub for this stuff before posting.  Move the whitespace cleanup to the
earlier patch so we have less noise here.

>  void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>  {
>  	cxlds->cxl_dvsec = dvsec;
> @@ -759,6 +758,12 @@ int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
>  
> +void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	cxlds->media_ready = true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_media_ready, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 37d8bfdef517..a84fe7992c53 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -56,6 +56,11 @@ void efx_cxl_init(struct efx_nic *efx)
>  
>  	if (cxl_accel_request_resource(cxl->cxlds, true))
>  		pci_info(pci_dev, "CXL accel resource request failed");
> +
> +	if (!cxl_await_media_ready(cxl->cxlds))
> +		cxl_accel_set_media_ready(cxl->cxlds);
> +	else
> +		pci_info(pci_dev, "CXL accel media not active");
Feels fatal. pci_err() and return an error.

>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index 0ba2195b919b..b883c438a132 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -24,4 +24,6 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  			    enum accel_resource);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
> +void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds);
> +int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  #endif


