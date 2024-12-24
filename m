Return-Path: <netdev+bounces-154206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B4E9FC107
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B971606ED
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4211BFE03;
	Tue, 24 Dec 2024 17:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A706149C51;
	Tue, 24 Dec 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061571; cv=none; b=ke0hnvgowbKQZxvXt0uYp8d8VHIhUGTSGTdI/f+WlikJblbQDVl4KQpJ5hB+0AyxZBeo5gKwFUcJv2gV4vmypzpDSTO9WCAKgs1O+aZA6aMknPH/N4ig4kBoBK5N61r3jlLMWiOpuzccbvg3ipz1sk/kxxhOsZWU7eO0nU1HK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061571; c=relaxed/simple;
	bh=DcYjoEQqJRP4OrSTXtObF8w1dimz8czuI+MoKuBFS90=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMF7tnZGC4y7W8iEBTX4lT/k0TZGYWD+nqrY0REPBcnXxWNEtdvTY/TbL4wRLL7CKcjPXOBhb4yAu1Br8uazik+8oXVReDhOP/soPsTSwmCoxn+3CKdRoNc6kFyma7fN5QV8kH8xDCgvbZxQCBaoNFQ2Nf4aA9OAorrENVl9Rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhh56g6vz6K5pk;
	Wed, 25 Dec 2024 01:28:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FC7F140736;
	Wed, 25 Dec 2024 01:32:47 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:32:46 +0100
Date: Tue, 24 Dec 2024 17:32:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 13/27] cxl: prepare memdev creation for type2
Message-ID: <20241224173245.000028aa@huawei.com>
In-Reply-To: <20241216161042.42108-14-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-14-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:28 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 
> Avoid debugfs files relying on existence of cxl_memdev_state.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
You've added it to a header, but not removed it from a different
one. That is generally a bad plan.

I'm curious on the poison part.  Does your device support the command?
If so we probably want to think about what is needed to enable that long term.

Jonathan


> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/cdat.c   |  3 +++
>  drivers/cxl/core/memdev.c | 14 ++++++++++++--
>  drivers/cxl/core/region.c |  3 ++-
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  5 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..c57bc83e79ee 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dpa_perf *perf;
>  
> +	if (!mds)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  		perf = &mds->ram_perf;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 82c354b1375e..4d24305624e0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -547,9 +547,16 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_accel_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> @@ -660,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d77899650798..967132b49832 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> -	cxl_region_perf_data_calculate(cxlr, cxled);
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> +		cxl_region_perf_data_calculate(cxlr, cxled);
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		int i;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..93106a43990b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 473128fdfb22..26d7735b5f31 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -45,4 +45,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  #endif


