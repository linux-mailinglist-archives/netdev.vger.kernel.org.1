Return-Path: <netdev+bounces-226117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD09B9C605
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591BE32260D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504B2296BD1;
	Wed, 24 Sep 2025 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6Mrh9DL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FCDF49
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753653; cv=none; b=lPfzgH7PucP6Fn8Ct+E46dKTE1uXVyVnS8IetJJGRqYMjt2JAZDEE8SIIqM081NZKdoC3XnvcuACd1voVfRy3BgsaHOLTG0NgHHKqznr1v/h2msK8nQ/uanfs4+siIW5KzWyZ02SkeY0zX+Abs+StD1U/9/QGFgYia25D2nM93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753653; c=relaxed/simple;
	bh=TL9tSqQs9DJoH1eG3I4NYwiJF5mKaMofy4gYs9c67Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrTSqi2cT0vPOlf/sAhsHkvWKTuUvcLj/RLb5FuC54sVbQNIu5JiDr4Koyr0Pz0YfxRo0DgCi+9SoxHt5qhKR1y9pAH7a1siys2Sp4JifRBvMcifAd6Tb+TmaXwF6SIyscRrik7jxH7XmmL4dFUNmKD091iVpX5Ve0qIKb0c/8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6Mrh9DL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758753652; x=1790289652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TL9tSqQs9DJoH1eG3I4NYwiJF5mKaMofy4gYs9c67Ow=;
  b=K6Mrh9DL7hQIpYguS0KoboTVrr3gcqPgQtyuDxHZp5tKJMlEI6Ze8JOI
   AcXgKNVLgXu+12YW+nVx9y5VAU0w9uDilNxvWYo2PI7t0YrmRxd7vAJjn
   KfhmVP5PSgWMWt6q+J71eVlrGXBVwf9dgSwxEjEcg+E3JkRgehDicgmpd
   v8mbaEGYNiD2Da242s4pBvLYPlYa+gSAXE27NrrgE8GBz3ZzAF/ii6pg6
   PlaecNiWqHZIsRdflUyZBh6g+RNlbtbMUWE6DAWRE2rXeXpIOyJC01miX
   /uIGiBv0Ot8bn0knWL13/4hpPYDVCvCw2nuv+rTYeY9tmIIiqM6rhVzKe
   A==;
X-CSE-ConnectionGUID: WgUuPVaBQyS7hgVDBASvFA==
X-CSE-MsgGUID: 7pqeqeWpQwGm1/UGB8PJAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61116247"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61116247"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:40:51 -0700
X-CSE-ConnectionGUID: R63qJkI4SCSLH0RXwjCmUQ==
X-CSE-MsgGUID: iZYu5PhRTO6jGB97eWIoGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="177591950"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:40:48 -0700
Message-ID: <9556a62d-3aa0-4810-af53-ce0f3a5c4d61@intel.com>
Date: Wed, 24 Sep 2025 15:40:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/6] bnxt_fwctl: Add documentation entries
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, jgg@ziepe.ca,
 michael.chan@broadcom.com
Cc: saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
 corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-7-pavan.chebbi@broadcom.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250923095825.901529-7-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/25 2:58 AM, Pavan Chebbi wrote:
> Add bnxt_fwctl to the driver and fwctl documentation pages.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  .../userspace-api/fwctl/bnxt_fwctl.rst        | 27 +++++++++++++++++++
>  Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  3 files changed, 29 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> new file mode 100644
> index 000000000000..78f24004af02
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> @@ -0,0 +1,27 @@
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
> +uses the ULP conduit provided by bnxt to send requests (HWRM commands)

Probably should expand the TLA on first time usage in documentation. What's ULP? What's HWRM?

> +to firmware.
> +
> +bnxt_fwctl User API
> +==================
> +
> +Each RPC request contains a message request structure (HWRM input) its,

s/) its,/), its /

> +legth, optional request timeout, and dma buffers' information if the

s/legth/length/

> +command needs any DMA. The request is then put together with the request
> +data and sent through bnxt's message queue to the firmware, and the results
> +are returned to the caller.

Would be helpful to explain the ioctls provided and perhaps some sample code for user side.

> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
> index a74eab8d14c6..e9f345797ca0 100644
> --- a/Documentation/userspace-api/fwctl/fwctl.rst
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -151,6 +151,7 @@ fwctl User API
>  .. kernel-doc:: include/uapi/fwctl/fwctl.h
>  .. kernel-doc:: include/uapi/fwctl/mlx5.h
>  .. kernel-doc:: include/uapi/fwctl/pds.h
> +.. kernel-doc:: include/uapi/fwctl/bnxt.h
>  
>  sysfs Class
>  -----------
> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
> index 316ac456ad3b..c0630d27afeb 100644
> --- a/Documentation/userspace-api/fwctl/index.rst
> +++ b/Documentation/userspace-api/fwctl/index.rst
> @@ -12,3 +12,4 @@ to securely construct and execute RPCs inside device firmware.
>     fwctl
>     fwctl-cxl
>     pds_fwctl
> +   bnxt_fwctl


