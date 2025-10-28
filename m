Return-Path: <netdev+bounces-233591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C76C15EBB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AA83343C09
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F44343218;
	Tue, 28 Oct 2025 16:46:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49C299954
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670018; cv=none; b=aFQLujCn/eaHC8Q0SgMfVPpjBa6rqzTJw0y1g97LKaugOgBVL0kJCoFkgiIN2qqTX06lmHu7E+gG3xcNP2d8PgZtXS46R9fTS864ZjQe0SJidQSBxo0Kv2SXEda317GWFB2lQO8K1UHbMx1QzJ24jFQ/ID3EAzkls9cya/adJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670018; c=relaxed/simple;
	bh=ekHHom5PfM1F2gUNZVpqnOaXeTa354EsGpk8jiSNYGA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3hD05hRk8X+k6KgvoDLgr4APBPysaY9vpswzSLNEeHdrTxpRfD+ycPqmR0UqrPhgUeuWwxRN1b8xbSIIPrOHSgIKDausrpi5fxls5OgZD32ZIj+oY2ok++f6B5zKh5L/3yHXGul5sIbcNKaSZeEMK7KCj7wXSbnCUl4TwSn6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwx535Nz1z6M4hg;
	Wed, 29 Oct 2025 00:43:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F82A1402F7;
	Wed, 29 Oct 2025 00:46:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 16:46:52 +0000
Date: Tue, 28 Oct 2025 16:46:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v5 5/5] bnxt_fwctl: Add documentation entries
Message-ID: <20251028164651.00001823@huawei.com>
In-Reply-To: <20251014081033.1175053-6-pavan.chebbi@broadcom.com>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
	<20251014081033.1175053-6-pavan.chebbi@broadcom.com>
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

On Tue, 14 Oct 2025 01:10:33 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> Add bnxt_fwctl to the driver and fwctl documentation pages.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Would be useful to provide a reference to userspace code that is
making use of this.

Jason / others, did we ever get the central repo for user space code
set up?


> ---
>  .../userspace-api/fwctl/bnxt_fwctl.rst        | 78 +++++++++++++++++++
>  Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  3 files changed, 80 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> new file mode 100644
> index 000000000000..cbf6be4410cc
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +fwctl bnxt driver
> +=================
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
> +===================
> +
> +Each RPC request contains a message request structure (HWRM input),
> +its length, optional request timeout, and dma buffers' information
> +if the command needs any DMA. The request is then put together with
> +the request data and sent through bnxt's message queue to the firmware,
> +and the results are returned to the caller.
> +
> +A typical user application can send a FWCTL_INFO command using ioctl()
> +to discover bnxt_fwctl's RPC capabilities as shown below:
> +
> +        ioctl(fd, FWCTL_INFO, &fwctl_info_msg);
> +
> +where fwctl_info_msg (of type struct fwctl_info) describes bnxt_info_msg
> +(of type struct fwctl_info_bnxt). fwctl_info_msg is set up as follows:
> +
> +        size = sizeof(struct fwctl_info);
> +        flags = 0;
> +        device_data_len = sizeof(bnxt_info_msg);
> +        out_device_data = (__aligned_u64)&bnxt_info_msg;
> +
> +The uctx_caps of bnxt_info_msg represents the capabilities as described
> +in fwctl_bnxt_commands of include/uapi/fwctl/bnxt.h
> +
> +The FW RPC itself, FWCTL_RPC can be sent using ioctl() as:
> +
> +        ioctl(fd, FWCTL_RPC, &fwctl_rpc_msg);
> +
> +where fwctl_rpc_msg (of type struct fwctl_rpc) encapsulates fwctl_rpc_bnxt
> +(see bnxt_rpc_msg below). fwctl_rpc_bnxt members are set up as per the
> +requirements of specific HWRM commands described in include/bnxt/hsi.h.
> +An example for HWRM_VER_GET is shown below:
> +
> +        struct fwctl_rpc_bnxt bnxt_rpc_msg;
> +        struct hwrm_ver_get_output resp;
> +        struct fwctl_rpc fwctl_rpc_msg;
> +        struct hwrm_ver_get_input req;
> +
> +        req.req_type = HWRM_VER_GET;
> +        req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
> +        req.hwrm_intf_min = HWRM_VERSION_MINOR;
> +        req.hwrm_intf_upd = HWRM_VERSION_UPDATE;
> +        req.cmpl_ring = -1;
> +        req.target_id = -1;
> +
> +        bnxt_rpc_msg.req_len = sizeof(struct hwrm_ver_get_input);
> +        bnxt_rpc_msg.num_dma = 0;
> +        bnxt_rpc_msg.req = (__aligned_u64)&req;
> +
> +        fwctl_rpc_msg.size = sizeof(struct fwctl_rpc);
> +        fwctl_rpc_msg.scope = FWCTL_RPC_DEBUG_READ_ONLY;
> +        fwctl_rpc_msg.in_len = sizeof(bnxt_rpc_msg) + sizeof(req);
> +        fwctl_rpc_msg.out_len = sizeof(struct hwrm_ver_get_output);
> +        fwctl_rpc_msg.in = (__aligned_u64)&bnxt_rpc_msg;
> +        fwctl_rpc_msg.out = (__aligned_u64)&resp;
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


