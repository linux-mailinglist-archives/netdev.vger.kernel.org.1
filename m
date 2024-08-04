Return-Path: <netdev+bounces-115564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F794700D
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F301F2132E
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39868136658;
	Sun,  4 Aug 2024 17:41:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864F79C2;
	Sun,  4 Aug 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793305; cv=none; b=pljWgpxEFyacYX0wCyGwRglAvPpfgJfU02IUydiry8+JGLapLSOQEqQIUaTJ6zrN2aLrB6YzwpSy+NyfsbEABr1pQQXuLI9WR5kRn0Nimu6vOWgU00hz8GmnWWgN+Sb3aHJLP5BCtYcSYfZ8FNqbUXGpT4GE8wFHf4eINFktU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793305; c=relaxed/simple;
	bh=UB90iiNzGYBh9ID0J0EcnhH+D0gsVsP8qfqNsyfFFE4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyLtz5dW/k5xH0gRcJVUv3Xwie3oFSKb8eipyyWuYfYZwnrXVATfmOdknvUoSzsYqxSWlOOatITHdgLenWqcRRKFj8Y1X6jgW3X+PoxcqXJQG62hWJCiTBQl4uXJZ6NlYLERgKBju2BaRQzSyYmzdws5vjH+Ehk6EpOcJMGgrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcRdr2pc1z6K5Tv;
	Mon,  5 Aug 2024 01:39:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 751D6140133;
	Mon,  5 Aug 2024 01:41:39 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:41:38 +0100
Date: Sun, 4 Aug 2024 18:41:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
Message-ID: <20240804184135.00001666@Huawei.com>
In-Reply-To: <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-9-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:28 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> The first stop for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
> 
> If the root driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci_driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
> 
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
> accelerator driver probing should be defferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> The first consumer of this API is a test driver that excercises the CXL
Spell check.
exercises

> Type-2 flow.
> 
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c          | 41 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c            |  2 +-
>  drivers/cxl/mem.c                  |  7 +++--
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
>  include/linux/cxl_accel_mem.h      |  3 +++
>  5 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b902948b121f..d51c8bfb32e3 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver

It might have deposited an error that isn't deferral I think.
I would be careful to make that clear in this comment.

> +*/
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);

I'd not really expect an 'acquire endpoint' to exit
in the good path with the cxlmd->dev device lock held.
Perhaps that needs a bit more shouting in the naming of
the function?

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
> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d66c6349ed2d..3c6b896c5f65 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	parent_port = find_cxl_port(dparent, &parent_dport);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index f76af75a87b7..383a6f4829d3 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");

Hmm. This seems excessive error print for a deferred path.

> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;
>  	}
>  
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {

