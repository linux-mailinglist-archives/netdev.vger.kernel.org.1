Return-Path: <netdev+bounces-226758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB45BA4CA3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C83E2A3AAC
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8AA296BDF;
	Fri, 26 Sep 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fj+1mQVV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76041E51FA
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909201; cv=none; b=qMPq8YlhNO2U5fm2Va4pZQ0BpN+pZOzbt5yMXsg/8/qPDnqCrHvgthAFfG/kogFk05Zqx8u+X1E2/onsDjCkgPlRI1OdAV1nUSVXjlRd1q6hKyLtsty4T7MOTG5QEnrnmRRNP+BmxL7RX/J8AFNBW0uMPX356/uqw37/31T87sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909201; c=relaxed/simple;
	bh=yTWNE091ucFvirVLLSRvWfjkbaAtrIlG5NdwknBjyKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jShsI0BIw/N/ruc9smzMsoZXjcFqM+oDIU7JUYJ73PfoYsLfgGReMFam2b+ClLmiDsd3fOOw5D2jrFwDFl/SjF6+9yy4IIvoUp1TaSQStALnzOrd8Y5i7vhT3LswDZW+WMldn+CEhlxoOtWSvLNdA2DS+ObplwZhUepxrOrTNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fj+1mQVV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758909200; x=1790445200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yTWNE091ucFvirVLLSRvWfjkbaAtrIlG5NdwknBjyKw=;
  b=Fj+1mQVVewkpzv1PzJVMSZ7nLx8A7xLevQuR3MsIqwt7MCRphhfw9eAt
   OosSMGIG+UnFVhRUcA64hGbvVLTwE8JLz6fLS15DJeUaxMOPRtCP0y0OY
   uttFT2DrehcwmCjhV0q07gOWzp3NmsFN+XFOJM4R/5svWHe5SQqqx+Ub6
   fOfAqWfK83Ys87Ro0dkcGupgwMWT0OtahxlN8qa/rzVTvfsFb/Y5ejfjz
   Yp0yopaMT0PDj3T9mca7yIq45ejVCsFvVzeCSwxUKTnTef4sNuiXAH75k
   N8NqH84Zvt4fMM4EOUwEpdwudKKqr84rbNJyA2xK5xKXJrqIOsOhOFipc
   g==;
X-CSE-ConnectionGUID: ox9CY3n+RfmwV9xdoY2bsg==
X-CSE-MsgGUID: sAFFR/NlQ3SOOn6MBgoBoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="71865704"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="71865704"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 10:53:19 -0700
X-CSE-ConnectionGUID: GdHLDNZZSmaO4zit3rRlKA==
X-CSE-MsgGUID: qmpdvEdzQTGQO0+TrYuNDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177723423"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 10:53:18 -0700
Message-ID: <aa28f51d-341c-4477-b5d8-a15b4f2000e4@intel.com>
Date: Fri, 26 Sep 2025 10:53:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] bnxt_fwctl: Add documentation entries
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, jgg@ziepe.ca,
 michael.chan@broadcom.com
Cc: saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
 corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
 <20250926085911.354947-6-pavan.chebbi@broadcom.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250926085911.354947-6-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/25 1:59 AM, Pavan Chebbi wrote:
> Add bnxt_fwctl to the driver and fwctl documentation pages.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  .../userspace-api/fwctl/bnxt_fwctl.rst        | 38 +++++++++++++++++++
>  Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  3 files changed, 40 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> new file mode 100644
> index 000000000000..2d7dbe56c622
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> @@ -0,0 +1,38 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +fwctl bnxt driver
> +================
> +
> +:Author: Pavan Chebbi
> +
> +Overview
> +========
> +
> +BNXT driver makes a fwctl service available through an auxiliary_device.
> +The bnxt_fwctl driver binds to this device and registers itself with the
> +fwctl subsystem.
> +
> +The bnxt_fwctl driver is agnostic to the device firmware internals. It
> +uses the Upper Layer Protocol (ULP) conduit provided by bnxt to send
> +HardWare Resource Manager (HWRM) commands to firmware.
> +
> +These commands can query or change firmware driven device configurations
> +and read/write registers that are useful for debugging.
> +
> +bnxt_fwctl User API
> +==================
> +
May be a good idea to add the info() call and detail what gets returned. What are the expectations of the bits in caps value.

> +Each RPC request contains a message request structure (HWRM input), its
> +length, optional request timeout, and dma buffers' information if the
> +command needs any DMA. The request is then put together with the request
> +data and sent through bnxt's message queue to the firmware, and the results
> +are returned to the caller.
> +
> +A typical user application would send a FWCTL_RPC using ioctl() for a FW
> +command as below:
> +
> +        ioctl(fd, FWCTL_RPC, &rpc_msg);
> +
> +where rpc_msg (struct fwctl_rpc) is an encapsulation of fwctl_rpc_bnxt
> +(which contains the HWRM command description) and its response.

This part looks good. May want to add the expectation of the input and output buffer contents? Main thing is you want to make it easier for the user application developer when they look at this guide and know what they need to do.

> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
> index a74eab8d14c6..826817bfd54d 100644
> --- a/Documentation/userspace-api/fwctl/fwctl.rst
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -148,6 +148,7 @@ area resulting in clashes will be resolved in favour of a kernel implementation.
>  fwctl User API
>  ==============
>  
> +.. kernel-doc:: include/uapi/fwctl/bnxt.h
>  .. kernel-doc:: include/uapi/fwctl/fwctl.h
>  .. kernel-doc:: include/uapi/fwctl/mlx5.h
>  .. kernel-doc:: include/uapi/fwctl/pds.h
> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
> index 316ac456ad3b..8062f7629654 100644
> --- a/Documentation/userspace-api/fwctl/index.rst
> +++ b/Documentation/userspace-api/fwctl/index.rst
> @@ -10,5 +10,6 @@ to securely construct and execute RPCs inside device firmware.
>     :maxdepth: 1
>  
>     fwctl
> +   bnxt_fwctl
>     fwctl-cxl
>     pds_fwctl


