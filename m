Return-Path: <netdev+bounces-151521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B39EFEA6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A27416B4B3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895B1D88DB;
	Thu, 12 Dec 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgEmmPta"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27E1B0F32;
	Thu, 12 Dec 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040018; cv=none; b=f0PsASygnCEDF6R8HJZ+8QX4clBozhBiSM/6Twq/dDbwnK9H22HNs9x+hmDtH+r9rNhl/suEEjW31MVTFPRZq49+sXvE2xmo+P5PX0ZWrVvZulqp3Eq4g22bM9EGf0u02uM5auViIR6PjfbxuMje5AM0KxX8PpNV4WWIZjfezIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040018; c=relaxed/simple;
	bh=OY9h37BubdSteB7SLMSe1UN8MTNMzssYQ/2LVWDqGbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8EuOh2toPRPH0Kst0EOdJWvs4pg63k4YRhn8ijx5FNlxS8++Ibb5A9sL4jTsc/HlCZDEg8BnUxEU3EceydL4ZIe7vd+w5WTVqITn1CyS9LCb1z1yLkxJVGPBzrOiKGjUkTzyUCvtfx3H0383eE2L3qpuNwktnGP6BOE6yVVodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgEmmPta; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734040017; x=1765576017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OY9h37BubdSteB7SLMSe1UN8MTNMzssYQ/2LVWDqGbg=;
  b=bgEmmPtaVody9LQprrUl4+zW786Zs/p7gnkzHmV/ZuVkO1TuerHseq/F
   o8RxzwTLznbgF6rlhz6AGmI+54TdGYjp5hceT2rldphKwu+88mri7FWQY
   fDKTlzqXudMs7HFYqXGl112NHoA6UNmYPDDmtW1i32XfGRZwBCON54nbR
   zQiMXu9syy29FXfBWkVChcn27dSdAH+ggSGPYGvXk0Tod0UkG0KVBmAfh
   Fm3dI623zrdsP6hnH4PmJG1+LjpKOCKaXl4YbAd9pAsT8x5PA1RcVZIaK
   pqNA1on+1qQNLBoNx1VYVbyl712ICfenCA8Az0Ekq8caoxFvxVRdRiqvb
   w==;
X-CSE-ConnectionGUID: +0VWLo1jRKK9XvJUnmC+HQ==
X-CSE-MsgGUID: nvBH65+vTsOrHrTwOWvN+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38163361"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="38163361"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:46:57 -0800
X-CSE-ConnectionGUID: v0ZRXvNXQyWaBcigK0OE5A==
X-CSE-MsgGUID: xJJ/D7X4Q4yJFoSnPDMLTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96892044"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.122])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:46:55 -0800
Date: Thu, 12 Dec 2024 13:46:53 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alucerop@amd.com, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com
Subject: Re: [PATCHv4] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <Z1tZzf_RqsfRFwvF@aschofie-mobl2.lan>
References: <20241203162112.5088-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203162112.5088-1-alucerop@amd.com>

On Tue, Dec 03, 2024 at 04:21:12PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL Type3 pci driver uses struct device driver_data for keeping
> cxl_dev_state reference. Type1/2 drivers are not only about CXL so this
> field should not be used when code requires cxl_dev_state to work with
> and such a code used for Type2 support.
> 
> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
> 
> Seize the change for removing the unused cxl_port param.
> 

Dave,

Jonathan previously offered Reviewed-by tag so this looks good to
apply. I've added another review tag and also massaged the 
changelog for your consideration.

cxl/pci: Add Type 1/2 support to cxl_dvsec_rr_decode()

In cxl_dvsec_rr_decode() the pci driver expects to retrieve a cxlds,
struct cxl_dev_state, from the driver_data field of struct device.
While that works for Type 3, drivers for Type 1/2 devices may not
put a cxlds in the driver_data field.

In preparation for supporting Type 1/2 devices, replace parameter
'struct device' with 'struct cxl_dev_state' in cxl_dvsec_rr_decode().

Remove the unused parameter 'cxl_port' in cxl_dvsec_rr_decode().

[as: massaged commit msg and log]
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c        | 6 +++---
>  drivers/cxl/cxl.h             | 3 ++-
>  drivers/cxl/port.c            | 2 +-
>  tools/testing/cxl/test/mock.c | 6 +++---
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b46bc46aaa9..420e4be85a1f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>  	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>  }
>  
> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct device *dev = cxlds->dev;
>  	int hdm_count, rc, i, ranges = 0;
>  	int d = cxlds->cxl_dvsec;
>  	u16 cap, ctrl;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..fdac3ddb8635 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -821,7 +821,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  				struct cxl_endpoint_dvsec_info *info);
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +struct cxl_dev_state;
> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
>  
>  bool is_cxl_region(struct device *dev);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 24041cf85cfb..66e18fe55826 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_port *root;
>  	int rc;
>  
> -	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
> +	rc = cxl_dvsec_rr_decode(cxlds, &info);
>  	if (rc < 0)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index f4ce96cc11d4..4f82716cfc16 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>  
> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			       struct cxl_endpoint_dvsec_info *info)
>  {
>  	int rc = 0, index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
> -	if (ops && ops->is_mock_dev(dev))
> +	if (ops && ops->is_mock_dev(cxlds->dev))
>  		rc = 0;
>  	else
> -		rc = cxl_dvsec_rr_decode(dev, port, info);
> +		rc = cxl_dvsec_rr_decode(cxlds, info);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;
> -- 
> 2.17.1
> 
> 

