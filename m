Return-Path: <netdev+bounces-224401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978FB84527
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38D23B9B2C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E12940B;
	Thu, 18 Sep 2025 11:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25A34BA50;
	Thu, 18 Sep 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194365; cv=none; b=IEOLbPWELCrXX0Mri+5fXk2hYNLSJSlvdDKmV5e2H0qAPgH9i4KhVixA3lv2XGSiEwJzl52QIyxysoULaJQgP+gZL0CAOXDDUwq9hwoUw602dzWwX8jgyMi6lnHCLa6xss3j8RHqCDuicSAHV8NR27pjP6CIWgMA2LHVe71LsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194365; c=relaxed/simple;
	bh=3hr6JxIPgNbsBjGSzeSPGcRF2aoio6jljckMdvzJ618=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnADY32L/A0vN+nAzVjDnjoKcXIAYXqmJ87viOEsL4Z2pFjduvPqngV8RTmJw7KoPTUYM7c/9RlbPSP49wd9r3vgaZyOejc1+mIWrmte2M0l8QE8oBdZE2AGu79Gmcw/bY/itOGFprciWdEbCeNgFUxmyHFb12orknYiee1iZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSCm70CNMz6GDBy;
	Thu, 18 Sep 2025 19:17:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 911F314038F;
	Thu, 18 Sep 2025 19:19:18 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 13:19:17 +0200
Date: Thu, 18 Sep 2025 12:19:14 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v18 08/20] cx/memdev: Indicate probe deferral
Message-ID: <20250918121914.00000af9@huawei.com>
In-Reply-To: <20250918091746.2034285-9-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-9-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 18 Sep 2025 10:17:34 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> The first step for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
> 
> If the port driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
> 
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when a
> accelerator driver probing should be deferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
In general this seems ok to me.  A few minor comments inline.

> ---
>  drivers/cxl/core/memdev.c | 42 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |  2 +-
>  drivers/cxl/mem.c         |  7 +++++--
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 3228287bf3f0..10d21996598a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1164,6 +1164,48 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>  
> +/*

Given this is exported and expected to be used by drivers,
it should have full kernel-doc.

> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited

I'd describe what that 'connection' means here.  I think it means holding
both the endpoint and cxlmd locks.

> + * a probe deferral awaiting the arrival of the CXL root driver.
> + */
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)

This is a slightly odd pattern for getting a singleton thing.
We more normally see this sort of release with multi parameter
when there is equivalent of more than one 'endpoint' per 'cxlmd'

> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");
> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 240c3c5bcdc8..4c3fecd4c8ea 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1557,7 +1557,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9ffee09fcb50..f103e2003add 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -122,14 +122,17 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
>  		cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;
>  	}
>  
>  	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 401a59185608..64946e698f5f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -251,4 +251,6 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_ops *ops);
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  #endif /* __CXL_CXL_H__ */


