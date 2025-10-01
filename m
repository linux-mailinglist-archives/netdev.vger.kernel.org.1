Return-Path: <netdev+bounces-227487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF7BB0F7C
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03814188A1DF
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288C2309DCF;
	Wed,  1 Oct 2025 15:03:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D85309DA4
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331021; cv=none; b=bJPoOQIqzAQJBMNO41J3IDjR46hRCR73h9pXZq/Ffi2Wz1s/XmogTUlsbxgPrmAQAbDKpV7bBqF498U9wvLbmOJ823Tr82EB0bPdk9tjMu8JC/BsjcCKQay7/5h1LVSzofiOhubQbsAxC6/QE60110x9ouar+D8EG1eDu49+7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331021; c=relaxed/simple;
	bh=VV+8wUgDYr5X+tXxkkvnXd95o0HO905MOBR6+9M7c3g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooUqnefQnDSbQ2V1cKFGoXuka0COe4Mq1kEjSB0NJ3hzvkbHc3QpLmiSfkjL8E1yPyK3WfYUuM4Ccv2IYBKzsj9dT+9pXKvtvXMwenFXHKpDr7ipjjfCzBiVmG8paKFr2RpPyz4kz2GrCzfgHpp8MOHYbP8QmDd/e6lHD6SzLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccJ5618mCz6K8x5;
	Wed,  1 Oct 2025 23:00:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A30EE140114;
	Wed,  1 Oct 2025 23:03:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 16:03:33 +0100
Date: Wed, 1 Oct 2025 16:03:32 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v4 4/5] bnxt_fwctl: Add bnxt fwctl device
Message-ID: <20251001160332.00000bbf@huawei.com>
In-Reply-To: <20250927093930.552191-5-pavan.chebbi@broadcom.com>
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
	<20250927093930.552191-5-pavan.chebbi@broadcom.com>
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

On Sat, 27 Sep 2025 02:39:29 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> Create bnxt_fwctl device. This will bind to bnxt's aux device.
> On the upper edge, it will register with the fwctl subsystem.
> It will make use of bnxt's ULP functions to send FW commands.
> 
> Also move 'bnxt_aux_priv' definition required by bnxt_fwctl
> from bnxt.h to ulp.h.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

A few minor things inline.

J
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index b5583b12a011..203b6ebb06fc 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -29,5 +29,16 @@ config FWCTL_PDS
>  	  to access the debug and configuration information of the AMD/Pensando
>  	  DSC hardware family.
>  
> +	  If you don't know what to do here, say N.
> +
> +config FWCTL_BNXT
> +	tristate "bnxt control fwctl driver"
> +	depends on BNXT
> +	help
> +	  BNXT provides interface for the user process to access the debug and
> +	  configuration registers of the Broadcom NIC hardware family

Full stop missing.

> +	  This will allow configuration and debug tools to work out of the box on
> +	  mainstream kernel.
> +
>  	  If you don't know what to do here, say N.
>  endif

> diff --git a/drivers/fwctl/bnxt/main.c b/drivers/fwctl/bnxt/main.c
> new file mode 100644
> index 000000000000..397b85671bab
> --- /dev/null
> +++ b/drivers/fwctl/bnxt/main.c

> +
> +static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
> +				   struct device *dev,
> +				   int num_dma,
> +				   struct fwctl_dma_info_bnxt *msg,
> +				   struct bnxt_fw_msg *fw_msg)
> +{
> +	u8 i, num_allocated = 0;
> +	void *dma_ptr;
> +	int rc = 0;

The compiler should be able to figure out that rc is always set in paths to where
it is used.   If not fair enough leaving this.

> +
> +	for (i = 0; i < num_dma; i++) {
> +		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		bnxt_dev->dma_virt_addr[i] = dma_alloc_coherent(dev->parent,
> +								msg->len,
> +								&bnxt_dev->dma_addr[i],
> +								GFP_KERNEL);
> +		if (!bnxt_dev->dma_virt_addr[i]) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		num_allocated++;
> +		if (msg->dma_direction == DEVICE_WRITE) {
> +			if (copy_from_user(bnxt_dev->dma_virt_addr[i],
> +					   u64_to_user_ptr(msg->data),
> +					   msg->len)) {
> +				rc = -EFAULT;
> +				goto err;
> +			}
> +		}
> +		dma_ptr = fw_msg->msg + msg->offset;
> +
> +		if ((PTR_ALIGN(dma_ptr, 8) == dma_ptr) &&
> +		    msg->offset < fw_msg->msg_len) {
> +			__le64 *dmap = dma_ptr;
> +
> +			*dmap = cpu_to_le64(bnxt_dev->dma_addr[i]);
> +		} else {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		msg += 1;
> +	}
> +
> +	return 0;
> +err:
> +	for (i = 0; i < num_allocated; i++)
> +		dma_free_coherent(dev->parent,
> +				  msg->len,
> +				  bnxt_dev->dma_virt_addr[i],
> +				  bnxt_dev->dma_addr[i]);
> +
> +	return rc;
> +}
> +
> +static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
> +			    enum fwctl_rpc_scope scope,
> +			    void *in, size_t in_len, size_t *out_len)
> +{
> +	struct bnxtctl_dev *bnxtctl =
> +		container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
> +	struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
> +	struct fwctl_dma_info_bnxt *dma_buf = NULL;
> +	struct device *dev = &uctx->fwctl->dev;
> +	struct fwctl_rpc_bnxt *msg = in;
> +	struct bnxt_fw_msg rpc_in;
> +	int i, rc, err = 0;
> +
> +	rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);
> +	if (!rpc_in.msg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (copy_from_user(rpc_in.msg, u64_to_user_ptr(msg->req),
> +			   msg->req_len)) {
> +		dev_dbg(dev, "Failed to copy in_payload from user\n");
> +		err = -EFAULT;
> +		goto free_msg_out;
> +	}
> +
> +	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in, scope)) {
> +		err = -EPERM;
> +		goto free_msg_out;
> +	}
> +
> +	rpc_in.msg_len = msg->req_len;
> +	rpc_in.resp = kzalloc(*out_len, GFP_KERNEL);
> +	if (!rpc_in.resp) {
> +		err = -ENOMEM;
> +		goto free_msg_out;
> +	}
> +
> +	rpc_in.resp_max_len = *out_len;
> +	if (!msg->timeout)
> +		rpc_in.timeout = DFLT_HWRM_CMD_TIMEOUT;
> +	else
> +		rpc_in.timeout = msg->timeout;
> +
> +	if (msg->num_dma) {
> +		if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
> +			dev_err(dev, "DMA buffers exceed the number supported\n");
> +			err = -EINVAL;
> +			goto free_msg_out;
> +		}
> +
> +		dma_buf = kcalloc(msg->num_dma, sizeof(*dma_buf), GFP_KERNEL);
> +		if (!dma_buf) {
> +			err = -ENOMEM;
> +			goto free_msg_out;
> +		}
> +
> +		if (copy_from_user(dma_buf, u64_to_user_ptr(msg->payload),
> +				   msg->num_dma * sizeof(*dma_buf))) {
> +			dev_dbg(dev, "Failed to copy payload from user\n");
> +			err = -EFAULT;
> +			goto free_dmabuf_out;
> +		}
> +
> +		rc = bnxt_fw_setup_input_dma(bnxtctl, dev, msg->num_dma,
> +					     dma_buf, &rpc_in);
> +		if (rc) {
If there is a strong reason to override the value of rc rather than returning
that I'd add a comment.

> +			err = -EIO;
> +			goto free_dmabuf_out;
> +		}
> +	}
> +
> +	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
> +	if (rc) {
> +		err = -EIO;
Likewise here.

Overall I'd just use a single rc variable rather than having separate one for err.

> +		goto free_dma_out;
> +	}
> +
> +	for (i = 0; i < msg->num_dma; i++) {
> +		if (dma_buf[i].dma_direction == DEVICE_READ) {
> +			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
> +					 bnxtctl->dma_virt_addr[i],
> +					 dma_buf[i].len)) {
> +				dev_dbg(dev, "Failed to copy resp to user\n");
> +				err = -EFAULT;
> +				break;
> +			}
> +		}
> +	}
> +free_dma_out:
> +	for (i = 0; i < msg->num_dma; i++)
> +		dma_free_coherent(dev->parent, dma_buf[i].len,
> +				  bnxtctl->dma_virt_addr[i],
> +				  bnxtctl->dma_addr[i]);
> +free_dmabuf_out:
> +	kfree(dma_buf);
> +free_msg_out:
> +	kfree(rpc_in.msg);
> +
> +	if (err) {
> +		kfree(rpc_in.resp);
> +		return ERR_PTR(err);
> +	}
> +
> +	return rpc_in.resp;
> +}

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index ea1d10c50da6..a7bca802a3e7 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2075,12 +2075,6 @@ struct bnxt_fw_health {
>  #define BNXT_FW_IF_RETRY		10
>  #define BNXT_FW_SLOT_RESET_RETRY	4
>  

Can you drop the linux/auxiliary_bus.h include given I think this
is the only use in here?

> -struct bnxt_aux_priv {
> -	struct auxiliary_device aux_dev;
> -	struct bnxt_en_dev *edev;
> -	int id;
> -};
> -
>  enum board_idx {
>  	BCM57301,
>  	BCM57302,

> diff --git a/include/uapi/fwctl/bnxt.h b/include/uapi/fwctl/bnxt.h
> new file mode 100644
> index 000000000000..a4686a45eb35
> --- /dev/null
> +++ b/include/uapi/fwctl/bnxt.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + */
> +
> +#ifndef _UAPI_FWCTL_BNXT_H_
> +#define _UAPI_FWCTL_BNXT_H_
> +
> +#include <linux/types.h>
> +
> +#define MAX_DMA_MEM_SIZE		0x10000 /*64K*/
> +#define DFLT_HWRM_CMD_TIMEOUT		500
> +#define DEVICE_WRITE			0
> +#define DEVICE_READ			1
> +
> +enum fwctl_bnxt_commands {
> +	FWCTL_BNXT_QUERY_COMMANDS = 0,
> +	FWCTL_BNXT_SEND_COMMAND

Maybe there will be more commands in future. So add a trailing comma.
General convention is always do this unless it is a terminating entry
that is just there to count the elements above.

> +};





