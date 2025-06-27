Return-Path: <netdev+bounces-202012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97606AEBEF7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C32B646217
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27B1B6CE4;
	Fri, 27 Jun 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEYsBeWg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92F1DF271;
	Fri, 27 Jun 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048249; cv=none; b=Em4JkHkjhRrjvo/A3rM9CRJvFNAYympc2D0Vdgrq+0C2bv4H4THXyFP2SzgTWmNYNKNN8oa54J5/Bwtf51JogTLqWmPYehldcgleyWfvM35VsFBCf/Sry8etLTuS+EgSTjY/RiX38h1BLP7j9dcZGcf60+4Qodvq40wXxI6O9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048249; c=relaxed/simple;
	bh=Zy+rQDK2Rdtnv+WCJAroA36FonDrfwk2n38XI2RfCDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+qlNYTT/RN4AhK0QlNtJtWh5ljCHwCj3uG8O4XKdjrqSlsV10QHYniZsMEmAGr+GKidMU1hcL+YVNJr/ysEpIWZjmWI+iwdu6VZXGNsB7xZyzKYsnQsjXdrJIM5yHeJw0B0uA0Eih0IwElezhShmajPTIymkELvYXPuUtIewFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEYsBeWg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751048247; x=1782584247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zy+rQDK2Rdtnv+WCJAroA36FonDrfwk2n38XI2RfCDk=;
  b=JEYsBeWgSWJE47+uH8JbfSf7fZdCAjXLBJWNL/PI53eIoT4F3U1EVkOy
   uqJ2St0FsqAXzPIN5vyelx7kmFylJa7o4bid72mr41mF2rSXE4dvhZQCP
   kmRi+PVDfIsM9TfMjHS2ZDYyrH+TLmKpLSAdiGJS4f/llR+H1RvLodXYn
   LKQ91H0EsvTcBO5fPr5CdP3JpF9nwYMEVo5PWQiTTSo/j22DrEEeHMXgz
   MP9J9wVpRWc+c0R1jMn9kRbt6zdJgmXK8MA51p0Mv2EyQHbCL/LbKmnkJ
   4Enzn4EGiE9RfUQBHo1nO/gvswS/xfwqIEZgZjcv70yDhUPiKGEEBTN6E
   A==;
X-CSE-ConnectionGUID: Mq9Z7h9QTCyeXAGz9ARuhw==
X-CSE-MsgGUID: K3bam4oBSpyr4raZMH4hGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="52598116"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="52598116"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:17:26 -0700
X-CSE-ConnectionGUID: iRakPMNBTpGZzpkHHrRkng==
X-CSE-MsgGUID: pdPRwQqLQhSljapZMGp3UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="152485775"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.77]) ([10.125.109.77])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:17:26 -0700
Message-ID: <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
Date: Fri, 27 Jun 2025 11:17:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
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
> ---
>  drivers/cxl/core/memdev.c | 42 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |  2 +-
>  drivers/cxl/mem.c         |  7 +++++--
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f43d2aa2928e..e2c6b5b532db 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1124,6 +1124,48 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver.
> + */
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)

Annotation of __acquires() is needed here to annotate that this function is taking multiple locks and keeping the locks.

> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)> +		goto err_endpoint;
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

And __releases() here to release the lock annotations
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
> index 9acf8c7afb6b..fa10a1643e4c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1563,7 +1563,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7f39790d9d98..cda0b2ff73ce 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -148,14 +148,17 @@ static int cxl_mem_probe(struct device *dev)
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

kdoc to 'struct cxl_memdev' will be needed to explain this change of expectation for the endpoint member.
 
> +		return -EPROBE_DEFER;

Can you please explain how the accelerator driver init path is different in this instance that it requires cxl_mem driver to defer probing? Currently with a type3, the cxl_acpi driver will setup the CXL root, hostbridges and PCI root ports. At that point the memdev driver will enumerate the rest of the ports and attempt to establish the hierarchy. However if cxl_acpi is not done, the mem probe will fail. But, the cxl_acpi probe will trigger a re-probe sequence at the end when it is done. At that point, the mem probe should discover all the necessary ports if things are correct. If the accelerator init path is different, can we introduce some documentation to explain the difference?

Also, it seems as long as port topology is not found, it will always go to deferred probing. At what point do we conclude that things may be missing/broken and we need to fail?

DJ


>  	}
>  
>  	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fcdf98231ffb..2928e16a62e2 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -234,4 +234,6 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlmds);
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  #endif /* __CXL_CXL_H__ */


