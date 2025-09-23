Return-Path: <netdev+bounces-225573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3ADB959AF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE4D2A18B9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516CC322750;
	Tue, 23 Sep 2025 11:17:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F232255F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626238; cv=none; b=sbN3i4CEpDS3q9uGR340V02V3LJWn4OI8/e1cZvfGKZkqCbjpEY/EKR4GDm47fjlYWCLyqx3OVatyHosIVWsNB4cNb5Y/DVfISNo/zbiNaeerc5v7QqcHuS26+Aa5R8D/jbJ4tCxZ2a2gS+EhZLX8h2NjrxEYbMTFt3LPonQxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626238; c=relaxed/simple;
	bh=J/vSO5Gpj19mzI9MQnqFLTUPsBm1nfJ5s1FhEKwO3xQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khWPU5DJFC96/9MWOOcqxP48tgK/6+r9syea5KmqWZcE9GIRTo2EpFutmUEIJtJQtT6hIYxV1l2sRjVYWdAEm0J6FvICKxg0H+LyhdTxLFLbDQkGkVMsW+O+gaBO6Rja/aInwF4xcVAJEFjGzT3PK9O0Q+rULzpEAJbSMwQ/Vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWHT05k6rz6L5F7;
	Tue, 23 Sep 2025 19:15:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E5C7214020A;
	Tue, 23 Sep 2025 19:17:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 12:17:05 +0100
Date: Tue, 23 Sep 2025 12:17:04 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl device
Message-ID: <20250923121704.00000eb7@huawei.com>
In-Reply-To: <20250923095825.901529-6-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
	<20250923095825.901529-6-pavan.chebbi@broadcom.com>
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

On Tue, 23 Sep 2025 02:58:24 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> Create bnxt_fwctl device. This will bind to bnxt's aux device.
> On the upper edge, it will register with the fwctl subsystem.
> It will make use of bnxt's ULP functions to send FW commands.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

I'm failing to find where this driver applies the fwctl_rpc_scope
to commands issued.  I suppose maybe they are all entirely safe
non invasive requests for data?

That scope stuff is probably the most important thing that fwctl
provides so all drivers need to deal with it.

Thanks,

Jonathan

> --- /dev/null
> +++ b/drivers/fwctl/bnxt/main.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + *
This blank line doesn't add anything.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>

Is there anything pci specific in here?  I'd check all the includes
to ensure they follow (approx) include what you used iwyu principles.

> +#include <linux/fwctl.h>
> +#include <uapi/fwctl/fwctl.h>
> +#include <uapi/fwctl/bnxt.h>
> +#include <linux/bnxt/common.h>
> +#include <linux/bnxt/ulp.h>

> +static bool bnxtctl_validate_rpc(struct bnxt_en_dev *edev,
> +				 struct bnxt_fw_msg *hwrm_in)
> +{
> +	struct input *req = (struct input *)hwrm_in->msg;

> +
> +	mutex_lock(&edev->en_dev_lock);

Neater if you use guard() 

> +	if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED) {
> +		mutex_unlock(&edev->en_dev_lock);
> +		return false;
> +	}
> +	mutex_unlock(&edev->en_dev_lock);
> +
> +	if (le16_to_cpu(req->req_type) <= HWRM_LAST)
> +		return true;
> +
> +	return false;

I was kind of expecting something called validate_rpc to do
the scope checks that we see in other drivers.
e.g. mlx5ctl_validate_rpc()

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
> +	int dma_buf_size;
> +
> +	rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);
> +	if (!rpc_in.msg) {
> +		err = -ENOMEM;
> +		goto err_out;

Nothing to clean up at this point, so returning here would be simpler.

> +	}
> +	if (copy_from_user(rpc_in.msg, u64_to_user_ptr(msg->req),
> +			   msg->req_len)) {
> +		dev_dbg(dev, "Failed to copy in_payload from user\n");
> +		err = -EFAULT;
> +		goto err_out;
> +	}
> +
> +	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in))
> +		return ERR_PTR(-EPERM);
> +
> +	rpc_in.msg_len = msg->req_len;
> +	rpc_in.resp = kzalloc(*out_len, GFP_KERNEL);
> +	if (!rpc_in.resp) {
> +		err = -ENOMEM;
> +		goto err_out;
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
> +			goto err_out;
> +		}
> +		dma_buf_size = msg->num_dma * sizeof(*dma_buf);

kcalloc probably more appropriate given it looks like an array.

> +		dma_buf = kzalloc(dma_buf_size, GFP_KERNEL);
> +		if (!dma_buf) {
> +			dev_err(dev, "Failed to allocate dma buffers\n");
> +			err = -ENOMEM;

General (growing) convention is don't bother printing messages on memory
failure as the allocator is very noisy if this happen away.

> +			goto err_out;
> +		}
> +
> +		if (copy_from_user(dma_buf, u64_to_user_ptr(msg->payload),
> +				   dma_buf_size)) {
> +			dev_dbg(dev, "Failed to copy payload from user\n");
> +			err = -EFAULT;
> +			goto err_out;
> +		}
> +
> +		rc = bnxt_fw_setup_input_dma(bnxtctl, dev, msg->num_dma,
> +					     dma_buf, &rpc_in);
> +		if (rc) {
> +			err = -EIO;
> +			goto err_out;
> +		}
> +	}
> +
> +	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
> +	if (rc) {
> +		err = -EIO;
> +		goto err_out;
> +	}
> +
> +	for (i = 0; i < msg->num_dma; i++) {
> +		if (dma_buf[i].read_from_device) {
> +			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
> +					 bnxtctl->dma_virt_addr[i],
> +					 dma_buf[i].len)) {
> +				dev_dbg(dev, "Failed to copy resp to user\n");
> +				err = -EFAULT;
> +			}
> +		}
> +	}
> +	for (i = 0; i < msg->num_dma; i++)
> +		dma_free_coherent(dev->parent, dma_buf[i].len,
> +				  bnxtctl->dma_virt_addr[i],
> +				  bnxtctl->dma_addr[i]);
> +
> +err_out:
> +	kfree(dma_buf);
> +	kfree(rpc_in.msg);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return rpc_in.resp;
> +}
> +
> +static const struct fwctl_ops bnxtctl_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_BNXT,
> +	.uctx_size = sizeof(struct bnxtctl_uctx),
> +	.open_uctx = bnxtctl_open_uctx,
> +	.close_uctx = bnxtctl_close_uctx,
> +	.info = bnxtctl_info,
> +	.fw_rpc = bnxtctl_fw_rpc,
> +};


...

> +static const struct auxiliary_device_id bnxtctl_id_table[] = {
> +	{ .name = "bnxt_en.fwctl", },
> +	{},

No need for trailing comma.

> +};
> +MODULE_DEVICE_TABLE(auxiliary, bnxtctl_id_table);

> diff --git a/include/uapi/fwctl/bnxt.h b/include/uapi/fwctl/bnxt.h
> new file mode 100644
> index 000000000000..cf8f2b80f3de
> --- /dev/null
> +++ b/include/uapi/fwctl/bnxt.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + *

Trivial, blank line here adds nothing useful.

> + */
> +
> +#ifndef _UAPI_FWCTL_BNXT_H_
> +#define _UAPI_FWCTL_BNXT_H_
> +
> +#include <linux/types.h>
> +
> +#define MAX_DMA_MEM_SIZE		0x10000 /*64K*/
> +#define DFLT_HWRM_CMD_TIMEOUT		500



