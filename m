Return-Path: <netdev+bounces-238028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C20C53065
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E8234F6C34
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D226A0DB;
	Wed, 12 Nov 2025 14:53:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258D31B11F;
	Wed, 12 Nov 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959235; cv=none; b=ZovctIHK2cRLMWJmEbBk32e1O7kOzU0HQPMltY5NLQovwdOmET7nJoUVRBAjURejp3o6jFPty4u5rDp3yWZ6SvM4NiYtvPwAJlan9OWl5TlXiHNjgH83TpH1NMxE4xMqZd+NGZ8Iem0MG/ADGYrI4Dr296qhG/yMrbuR2cOMG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959235; c=relaxed/simple;
	bh=rU0MyBBa/qOE8ElCHxl5lBbOyLP/0fAGsE3HWNBfSqw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIQqnsbvkLbPxnAQ5D21g240RrdKx4zDjPUm83fP3fT7sU1YEEd7rNKBEaCVzrQoUEP7PokhF3hugFHIsY6By/1f+42XrGw5i7OPDzVVYqCD79CyA7GK52U/TOmZ5sylI/CwVyvm+75nbxDnNMG7CxVN2LBQscZDWOz+KeCMCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d65xd1BXXzHnGf9;
	Wed, 12 Nov 2025 22:53:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6429C1402CB;
	Wed, 12 Nov 2025 22:53:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 14:53:43 +0000
Date: Wed, 12 Nov 2025 14:53:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v20 01/22] cxl/mem: Arrange for always-synchronous
 memdev attach
Message-ID: <20251112145341.00005b4e@huawei.com>
In-Reply-To: <20251110153657.2706192-2-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 15:36:36 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Dan Williams <dan.j.williams@intel.com>
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

Alejandro, read submitting patches again.  Whilst the first sign off should
indeed by Dan's this also needs one from you as a 'handler' of the patch.

Be very careful checking these tag chains. If they are wrong no one can
merge the set and it just acts as a silly blocker.

I would have split this up and made the changes to cxl_memdev_alloc in
a precursor patch (use of __free is obvious one) then could have stated
that that was simply moved in this patch.

There are other changes in there that are really hard to spot though
and I think there are some bugs lurking in error paths.

Jonathan

> ---
>  drivers/cxl/Kconfig       |   2 +-
>  drivers/cxl/core/memdev.c | 101 ++++++++++++++------------------------
>  drivers/cxl/mem.c         |  41 ++++++++++++++++
>  drivers/cxl/private.h     |  10 ++++
>  4 files changed, 90 insertions(+), 64 deletions(-)
>  create mode 100644 drivers/cxl/private.h

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e370d733e440..14b4601faf66 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -8,6 +8,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include "private.h"
>  #include "trace.h"
>  #include "core.h"
>  
> @@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> -					   const struct file_operations *fops)
> +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_memdev *cxlmd;
> -	struct device *dev;
> -	struct cdev *cdev;
> +	struct device *dev = &cxlmd->dev;
> +	struct cdev *cdev = &cxlmd->cdev;
>  	int rc;
>  
> -	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
> -	if (!cxlmd)
> -		return ERR_PTR(-ENOMEM);
> -
> -	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
> -	if (rc < 0)
> -		goto err;
> -	cxlmd->id = rc;
> -	cxlmd->depth = -1;
> -
> -	dev = &cxlmd->dev;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
> -	dev->parent = cxlds->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> -	device_set_pm_not_required(dev);
> -	INIT_WORK(&cxlmd->detach_work, detach_memdev);
> -
> -	cdev = &cxlmd->cdev;
> -	cdev_init(cdev, fops);
> -	return cxlmd;
> +	rc = cdev_device_add(cdev, dev);
> +	if (rc) {
> +		/*
> +		 * The cdev was briefly live, shutdown any ioctl operations that
> +		 * saw that state.
> +		 */
> +		cxl_memdev_shutdown(dev);
> +		return rc;
> +	}
>  
> -err:
> -	kfree(cxlmd);
> -	return ERR_PTR(rc);
> +	return devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>  
>  static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>  			       unsigned long arg)
> @@ -1051,50 +1035,41 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds)
> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>  {
> -	struct cxl_memdev *cxlmd;
> +	struct cxl_memdev *cxlmd __free(kfree) =
> +		kzalloc(sizeof(*cxlmd), GFP_KERNEL);

Trivial and perhaps not worth the hassle.
I'd pull this out of the declarations block to have

 	struct device *dev;
 	struct cdev *cdev;
 	int rc;

	struct cxl_memdev *cxlmd __free(kfree) =
		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
	if (!cxlmd)
		return ERR_PTR(-ENOMEM);

That is treat the __free() related statement as an inline declaration of
the type we only really allow for these.


>  	struct device *dev;
>  	struct cdev *cdev;
>  	int rc;
>  
> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> -	if (IS_ERR(cxlmd))
> -		return cxlmd;
>  
> -	dev = &cxlmd->dev;
> -	rc = dev_set_name(dev, "mem%d", cxlmd->id);
> -	if (rc)
> -		goto err;
> +	if (!cxlmd)
> +		return ERR_PTR(-ENOMEM);
>  
> -	/*
> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> -	 * needed as this is ordered with cdev_add() publishing the device.
> -	 */
> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
> +	if (rc < 0)
> +		return ERR_PTR(rc);
> +	cxlmd->id = rc;
> +	cxlmd->depth = -1;
>  	cxlmd->cxlds = cxlds;
>  	cxlds->cxlmd = cxlmd;

These two lines weren't previously in cxl_memdev_alloc()
I'd like a statement in the commit message of why they are now. It seems
harmless because they are still ordered before the add and are
ultimately freed 

I'm not immediately spotting why they now are.  This whole code shift
and complex diff is enough of a pain I'd be tempted to do the move first
so that we can then see what is actually changed much more easily.


>  
> -	cdev = &cxlmd->cdev;
> -	rc = cdev_device_add(cdev, dev);
> -	if (rc)
> -		goto err;
> -
> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
> -	if (rc)
> -		return ERR_PTR(rc);
> -	return cxlmd;
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
> -err:
> -	/*
> -	 * The cdev was briefly live, shutdown any ioctl operations that
> -	 * saw that state.
> -	 */
> -	cxl_memdev_shutdown(dev);
> -	put_device(dev);
> -	return ERR_PTR(rc);
> +	cdev = &cxlmd->cdev;
> +	cdev_init(cdev, &cxl_memdev_fops);
> +	return_ptr(cxlmd);
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>  
>  static void sanitize_teardown_notifier(void *data)
>  {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index d2155f45240d..fa5d901ee817 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -7,6 +7,7 @@
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "private.h"
>  
>  /**
>   * DOC: cxl mem
> @@ -202,6 +203,45 @@ static int cxl_mem_probe(struct device *dev)
>  	return devm_add_action_or_reset(dev, enable_suspend, NULL);
>  }
>  
> +static void __cxlmd_free(struct cxl_memdev *cxlmd)
> +{
> +	cxlmd->cxlds->cxlmd = NULL;
> +	put_device(&cxlmd->dev);
> +	kfree(cxlmd);
> +}
> +
> +DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
> +
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
> +	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
> +	int rc;
> +
> +	if (IS_ERR(cxlmd))
> +		return cxlmd;
> +
> +	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
> +	if (rc)
> +		return ERR_PTR(rc);

Is the reference tracking right here?  If the above call fails
then it is possible cxl_memdev_unregister() has been called
or just cxl_memdev_shutdown().

If nothing else (and I suspect there is worse but haven't
counted references) that will set
cxlmd->cxlds = NULL;
s part of cxl_memdev_shutdown()
The __cxlmd_free() then dereferences that and boom.


> +
> +	return no_free_ptr(cxlmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");


