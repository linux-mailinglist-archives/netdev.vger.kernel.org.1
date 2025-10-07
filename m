Return-Path: <netdev+bounces-228096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 335A4BC1632
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 14:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB0EE34ED6F
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BBA2DF125;
	Tue,  7 Oct 2025 12:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4A2DF12C;
	Tue,  7 Oct 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840866; cv=none; b=KtW3/zCXXSQEeE2wohkiaSlDz6Vx6gGa3j7zdxH/P0dk164P8psEmyuh+4peU1Hnl5IO3/x7fpPcFTq/C0mZuHt2nLFejEQOJz18he7SlLeKbhh7SiWBrpTXmyjFcHTG5/3LjpCtFjL4TC5KlqU6S9p4O34QMUWAxZkKMwEkNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840866; c=relaxed/simple;
	bh=dy/6ZCjETNXHyHz1wZEgbItY3Ec3ucit3+My7GuapRk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P85UuDIdnltNCnesBITmFH6OyyHa9YaJmrslRdUMQFw2ZQTmafoz5Gqc9EUtwP+48NQllZetLRM9zSlFK6auGqLYqOQTztlQ8fOuAIdvrsb/OtdYujTWYq1+GmF0ILET1/ioCr16OuJfhuZsoclga7bplgM+97cwY0GymPbA6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgwfT2SJ3z6L4wL;
	Tue,  7 Oct 2025 20:38:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4637E1402CB;
	Tue,  7 Oct 2025 20:40:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 13:40:54 +0100
Date: Tue, 7 Oct 2025 13:40:53 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v19 01/22] cxl/mem: Arrange for always-synchronous
 memdev attach
Message-ID: <20251007134053.00000dd3@huawei.com>
In-Reply-To: <20251006100130.2623388-2-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 11:01:09 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for CXL accelerator drivers that have a hard dependency on
> CXL capability initialization, arrange for the endpoint probe result to be
> conveyed to the caller of devm_cxl_add_memdev().
> 
> As it stands cxl_pci does not care about the attach state of the cxl_memdev
> because all generic memory expansion functionality can be handled by the
> cxl_core. For accelerators, that driver needs to know perform driver
> specific initialization if CXL is available, or exectute a fallback to PCIe
> only operation.
> 
> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
> loading as one reason that a memdev may not be attached upon return from
> devm_cxl_add_memdev().
> 
> The diff is busy as this moves cxl_memdev_alloc() down below the definition
> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
> preclude needing to export more symbols from the cxl_core.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Alejandro, SoB chain broken here which makes this currently unmergeable.

Should definitely have your SoB as you sent the patch to the list and need
to make a statement that you believe it to be fine to do so (see the Certificate
of origin stuff in the docs).  Also, From should always be one of the authors.
If Dan wrote this as the SoB suggests then From should be set to him..

git commit --amend --author="Dan Williams <dan.j.williams@intel.com>"

Will fix that up.  Then either you add your SoB on basis you just 'handled'
the patch but didn't make substantial changes, or your SoB and a Codeveloped-by
if you did make major changes.  If it is minor stuff you can an
a sign off with # what changed 
comment next to it.

A few minor comments inline.

Thanks,

Jonathan


> ---
>  drivers/cxl/Kconfig       |  2 +-
>  drivers/cxl/core/memdev.c | 97 ++++++++++++++++-----------------------
>  drivers/cxl/mem.c         | 30 ++++++++++++
>  drivers/cxl/private.h     | 11 +++++
>  4 files changed, 82 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/cxl/private.h
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 028201e24523..111e05615f09 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -22,6 +22,7 @@ if CXL_BUS
>  config CXL_PCI
>  	tristate "PCI manageability"
>  	default CXL_BUS
> +	select CXL_MEM
>  	help
>  	  The CXL specification defines a "CXL memory device" sub-class in the
>  	  PCI "memory controller" base class of devices. Device's identified by
> @@ -89,7 +90,6 @@ config CXL_PMEM
>  
>  config CXL_MEM
>  	tristate "CXL: Memory Expansion"
> -	depends on CXL_PCI
>  	default CXL_BUS
>  	help
>  	  The CXL.mem protocol allows a device to act as a provider of "System
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c569e00a511f..2bef231008df 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c

> -
> -err:
> -	kfree(cxlmd);
> -	return ERR_PTR(rc);
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>  
>  static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>  			       unsigned long arg)
> @@ -1023,50 +1012,44 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds)
> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
>  	struct cdev *cdev;
>  	int rc;
>  
> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> -	if (IS_ERR(cxlmd))
> -		return cxlmd;
> +	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);

It's a little bit non obvious due to the device initialize mid way
through this, but given there are no error paths after that you can
currently just do.
	struct cxl_memdev *cxlmd __free(kfree) =
		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
and
	return_ptr(cxlmd);

in the good path.  That lets you then just return rather than having
the goto err: handling for the error case that currently frees this
manually.

Unlike the change below, this one I think is definitely worth making.


> +	if (!cxlmd)
> +		return ERR_PTR(-ENOMEM);
>  
> -	dev = &cxlmd->dev;
> -	rc = dev_set_name(dev, "mem%d", cxlmd->id);
> -	if (rc)
> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
> +	if (rc < 0)
>  		goto err;
> -
> -	/*
> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> -	 * needed as this is ordered with cdev_add() publishing the device.
> -	 */
> +	cxlmd->id = rc;
> +	cxlmd->depth = -1;
>  	cxlmd->cxlds = cxlds;
>  	cxlds->cxlmd = cxlmd;
>  
> -	cdev = &cxlmd->cdev;
> -	rc = cdev_device_add(cdev, dev);
> -	if (rc)
> -		goto err;
> +	dev = &cxlmd->dev;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
> +	dev->parent = cxlds->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> +	dev->type = &cxl_memdev_type;
> +	device_set_pm_not_required(dev);
> +	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
> -	if (rc)
> -		return ERR_PTR(rc);
> +	cdev = &cxlmd->cdev;
> +	cdev_init(cdev, &cxl_memdev_fops);
>  	return cxlmd;
>  
>  err:
> -	/*
> -	 * The cdev was briefly live, shutdown any ioctl operations that
> -	 * saw that state.
> -	 */
> -	cxl_memdev_shutdown(dev);
> -	put_device(dev);
> +	kfree(cxlmd);
>  	return ERR_PTR(rc);
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>  
>  static void sanitize_teardown_notifier(void *data)
>  {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index f7dc0ba8905d..144749b9c818 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -7,6 +7,7 @@
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "private.h"
>  #include "core/core.h"
>  
>  /**
> @@ -203,6 +204,34 @@ static int cxl_mem_probe(struct device *dev)
>  	return devm_add_action_or_reset(dev, enable_suspend, NULL);
>  }
>  
> +/**
> + * devm_cxl_add_memdev - Add a CXL memory device
> + * @host: devres alloc/release context and parent for the memdev
> + * @cxlds: CXL device state to associate with the memdev
> + *
> + * Upon return the device will have had a chance to attach to the
> + * cxl_mem driver, but may fail if the CXL topology is not ready
> + * (hardware CXL link down, or software platform CXL root not attached)
> + */
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds);

Bit marginal but you could do a DEFINE_FREE() for cxlmd 
similar to the one that exists for put_cxl_port

You would then need to steal the pointer for the devm_ call at the
end of this function.


> +	int rc;
> +
> +	if (IS_ERR(cxlmd))
> +		return cxlmd;
> +
> +	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
> +	if (rc) {
> +		put_device(&cxlmd->dev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return devm_cxl_memdev_add_or_reset(host, cxlmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");

