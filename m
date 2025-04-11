Return-Path: <netdev+bounces-181806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02623A867E4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE623BC4C6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F628F927;
	Fri, 11 Apr 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyuL0WlE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995C28CF6D;
	Fri, 11 Apr 2025 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405671; cv=none; b=Jt9Y4GmUoJwPqkgpyG+CT5Y3LNhXAnaKNQRj1Z5wO5ofbTSnOLIPhIx87bflYCg1y35KZwxoVDmvrczgoGcA2qP/yZrC1r9sbg1tTGRJ0or3RNteM5oftltEkLVH46adzJnULEuIZxexQJzPeUni2oO7y3KLR13oh4CVSwLZmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405671; c=relaxed/simple;
	bh=X0LgWlquaDV3JI+pcY0BRhjJpDQ3os4tk3p1Rg47CBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+HKOA98RPcju8LAQYv414sX4iWLcsIWSUcRaIkaJm7aHQGWxiENzg8yIk7s78bMkx+MxMczkQqd7mVJMvvuI1rDgH3nN0CTXICHALqbSv/UHZdzVpMDtnqWp54SsqONoeRIZHUgnNF6b9mkjZxSC4y0v6CbOly+CaKSgAQXkGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyuL0WlE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744405670; x=1775941670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X0LgWlquaDV3JI+pcY0BRhjJpDQ3os4tk3p1Rg47CBs=;
  b=GyuL0WlECpFy02S0WZ7xgkrXrfIjSruEjWO0ZW0YOpPak0oIfo+HcGW+
   Gt5kxEZn06yixuTzPWi1wzNP3LU/+DFcECVzktYBFVCkmg1z2BWthgMXk
   YDvQzy3b3ZX8dOksA9LFxZKkm3WNFuzT+YwPK/D3E9kih2ZlDLusFuUiP
   N/776sYPB1T4cDWDtH+WWwb20CumGUd2v6emcttltskrENzOpkkaWA4Th
   /bpENqiG0OBEqCuPMHe8D90Eyx/7KLRAznmo7hyOYVEA8cKVmqCylcdQw
   dX8PCnknKnkB7SJYc94T4DQo/GBIVyhfXin9NhLleWOX/l8QMAb7OjJ2Q
   g==;
X-CSE-ConnectionGUID: 5wfETKVfRSqls/3gTCkYKA==
X-CSE-MsgGUID: H3uuXZgCQOOKZPEB4BaB7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="63509860"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="63509860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:07:49 -0700
X-CSE-ConnectionGUID: QM8vcwisRdKXIknxhxFtxQ==
X-CSE-MsgGUID: rIcxNTYGTyuSt4HMgkJ5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129062460"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.170]) ([10.125.108.170])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:07:48 -0700
Message-ID: <85d6675f-081b-4973-8c18-15616db8a743@intel.com>
Date: Fri, 11 Apr 2025 14:07:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/23] cxl: prepare memdev creation for type2
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-10-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250331144555.1947819-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/cxlmem.h      |  2 --
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 6cc732aeb9de..31af5c1ebe11 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include "trace.h"
>  #include "core.h"
> @@ -562,9 +563,16 @@ static const struct device_type cxl_memdev_type = {
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
> @@ -689,7 +697,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e47f51025efd..9fdaf5cf1dd9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9675243bd05b..7f39790d9d98 100644
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
> index 74f03773baed..3686a9532d55 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -245,4 +245,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
>  void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>  		      u64 persistent_bytes);
>  int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlmds);
>  #endif


