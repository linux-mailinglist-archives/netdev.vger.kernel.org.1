Return-Path: <netdev+bounces-225562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697F0B9570B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AAA17B8F3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E1627815B;
	Tue, 23 Sep 2025 10:32:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674D2750F6
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623520; cv=none; b=gdUguiZcEsGVA1JY0Jz4RUy8aZC1Qq0M5RFQxQXGY3kdxhcQn64cVgz7HHy3YiVtugxAvWSdS/obEKW12J6rmLO7KBW0VCPLUvJ+xQgFi8VkWE/ctwhM8AEYcE3RTYBjbzpqpQ1kagjyaaJw24zZx4G7ObQBFO4OA/mAocN/oxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623520; c=relaxed/simple;
	bh=Q9zpsLRkf76tLV0rnS1V4y6U20lfBTVY8O84630UYFQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXb3g6OP1EdHWvwwED+M0QWBsUGlpUNXMQzuw7SjGo8rvJHqcIQA4RU9FhAs3aK8e2YFd1Unh+/aRERI8ROFJN9DvYUbCP+ZUFrWNvi2zmyGnSwobnXat28ulSqZYVmPX9FLs0ZN6UAw7h/B7IChv/mp6ux2E3wEoaMqN04t7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWGRY3RxDz6M4sX;
	Tue, 23 Sep 2025 18:28:57 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 846771402ED;
	Tue, 23 Sep 2025 18:31:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 11:31:53 +0100
Date: Tue, 23 Sep 2025 11:31:52 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 6/6] bnxt_fwctl: Add documentation entries
Message-ID: <20250923113152.00006a64@huawei.com>
In-Reply-To: <20250923095825.901529-7-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
	<20250923095825.901529-7-pavan.chebbi@broadcom.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 23 Sep 2025 02:58:25 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

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
> +to firmware.

It would be nice to have a little detail on what 'sort' of commands
are available even if only in a hand wavy way.

> +
> +bnxt_fwctl User API
> +==================
> +
> +Each RPC request contains a message request structure (HWRM input) its,
> +legth, optional request timeout, and dma buffers' information if the

length

> +command needs any DMA. The request is then put together with the request
> +data and sent through bnxt's message queue to the firmware, and the results
> +are returned to the caller.
> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
> index a74eab8d14c6..e9f345797ca0 100644
> --- a/Documentation/userspace-api/fwctl/fwctl.rst
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -151,6 +151,7 @@ fwctl User API
>  .. kernel-doc:: include/uapi/fwctl/fwctl.h
>  .. kernel-doc:: include/uapi/fwctl/mlx5.h
>  .. kernel-doc:: include/uapi/fwctl/pds.h
> +.. kernel-doc:: include/uapi/fwctl/bnxt.h

As below.

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
Perhaps we should keep the specific driver bits of this in alphabetical order?  Once we have
a bit list that will make it easier for people to find what they want.



