Return-Path: <netdev+bounces-233589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352F7C15EC7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55326188F8CE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09128CF41;
	Tue, 28 Oct 2025 16:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FA23FC4C
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669859; cv=none; b=J3ckzyhy0am819/H4QxqkjsaS7XU6fDyUYbWacekPPYJfjbjpdFqTh4UP/9SVI+Qmy7Oq+aT+rft2xmlC+dJ1u9RLJ3ACQbLF4eLpEB6F1w1/Z68FZ4iF5oAkd83USovl2yXnW3tsEGQ/MuSQE414wVdvJtqe5znYGKgzCJE1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669859; c=relaxed/simple;
	bh=+srsSr3QL/ATfSdQ5gbe8eCDuzk6Mm79uyNgV1W7C1c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l23beGvgcazjqqJ9WlFY8xTXljqdCNZ6V9bISQ98hh3b1a19v0/oEMGaJPg+7KHBteAljsuzI6FN/di2Wm5SVbI/MFBE2/hy36K5WQOzl64YQCyMcgrrBZRMxa9w9JYnJX/bwIfzjdcw9fP8fPpwREcgfOSq93iU1ATLWsSbaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwx1z4zwYz6M4gZ;
	Wed, 29 Oct 2025 00:40:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 266F814025A;
	Wed, 29 Oct 2025 00:44:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 16:44:12 +0000
Date: Tue, 28 Oct 2025 16:44:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v5 4/5] bnxt_fwctl: Add bnxt fwctl device
Message-ID: <20251028164410.00002156@huawei.com>
In-Reply-To: <20251014081033.1175053-5-pavan.chebbi@broadcom.com>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
	<20251014081033.1175053-5-pavan.chebbi@broadcom.com>
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

On Tue, 14 Oct 2025 01:10:32 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> Create bnxt_fwctl device. This will bind to bnxt's aux device.
> On the upper edge, it will register with the fwctl subsystem.
> It will make use of bnxt's ULP functions to send FW commands.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
A few things inline.


> diff --git a/drivers/fwctl/bnxt/main.c b/drivers/fwctl/bnxt/main.c
> new file mode 100644
> index 000000000000..b31f34c1cc3c
> --- /dev/null
> +++ b/drivers/fwctl/bnxt/main.c
> @@ -0,0 +1,453 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + */
> +
> +#include <linux/kernel.h>

Anything actually in kernel.h used in here?  There is a considerable
effort going on to not include that unless absolutely necessary. Instead
figure out which actual headers are needed.  In general follow 
include what you use (IWYU) principles.  A few things obviously missing
are cleanup.h and mutex.h for the guard(mutex). 


> +#include <linux/auxiliary_bus.h>
Pick an order.
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/fwctl.h>
> +#include <uapi/fwctl/fwctl.h>
> +#include <uapi/fwctl/bnxt.h>

I'd put the uapi after, but not sure if this is a convention for some kernel code.

> +#include <linux/bnxt/hsi.h>
> +#include <linux/bnxt/ulp.h>


> +static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
> +				   struct device *dev,
> +				   struct fwctl_dma_info_bnxt *msg,
> +				   struct bnxt_fw_msg *fw_msg,
> +				   int num_dma,
> +				   void **dma_virt_addr,
> +				   dma_addr_t *dma_addr)
> +{
> +	u8 i, num_allocated = 0;
> +	void *dma_ptr;
> +	int rc;
> +
> +	for (i = 0; i < num_dma; i++) {
> +		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		dma_virt_addr[i] = dma_alloc_coherent(dev->parent, msg->len,
> +						      &dma_addr[i], GFP_KERNEL);
> +		if (!dma_virt_addr[i]) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		num_allocated++;
> +		if (msg->dma_direction == DEVICE_WRITE) {
> +			if (copy_from_user(dma_virt_addr[i],
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
> +			*dmap = cpu_to_le64(dma_addr[i]);
> +		} else {
I would flip the error condition so that only that is out of line as
generally that makes for easier flow.

		if (!(PTR_ALIGN(dma_ptr, 8) == dma_ptr) ||
		      msg->offset >= fw_msg->msg_len)) {
			rc = -EINVAL;
			goto err;
		}

		*(__le64)(dmap_ptr) = cpu_to_le64(dma_addr[i]);

or something like that.

> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		msg += 1;
		msg++;
or do that in the loop update.


> +	}
> +
> +	return 0;
> +err:
> +	for (i = 0; i < num_allocated; i++)
> +		dma_free_coherent(dev->parent, msg->len, dma_virt_addr[i],
> +				  dma_addr[i]);
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
> +	void *dma_virt_addr[MAX_NUM_DMA_INDICATIONS];
> +	dma_addr_t dma_addr[MAX_NUM_DMA_INDICATIONS];
> +	struct fwctl_dma_info_bnxt *dma_buf = NULL;
> +	struct device *dev = &uctx->fwctl->dev;
> +	struct fwctl_rpc_bnxt *msg = in;
> +	struct bnxt_fw_msg rpc_in;
> +	int i, rc, err = 0;
> +
> +	rpc_in.msg = memdup_user(u64_to_user_ptr(msg->req), msg->req_len);
> +	if (IS_ERR(rpc_in.msg))
> +		return rpc_in.msg;
> +
> +	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in, scope)) {
> +		err = -EPERM;
> +		goto free_msg_out;

If you follow this path, you will free rpc_in.resp which hasn't
been allocated yet.  Likely not a bug, but definitely a problem for
easy understanding. 

I can understand why you want to keep the if (err) freeing of rpc_in.resp
for the end of the exit path, but if so move 
	rpc_in.resp = kzalloc();
to be the first thing we need to unwind, before rpc_in.msg is allocated above.


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
> +		err = bnxt_fw_setup_input_dma(bnxtctl, dev, dma_buf, &rpc_in,
> +					      msg->num_dma, &dma_virt_addr[0],
> +					      &dma_addr[0]);
> +		if (err)
> +			goto free_dmabuf_out;
> +	}
> +
> +	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
> +	if (rc) {
> +		struct output *resp = rpc_in.resp;
> +
> +		/* Copy the response to user always, as it contains
> +		 * detailed status of the command failure
> +		 */
> +		if (!resp->error_code)
> +			/* bnxt_send_msg() returned much before FW
> +			 * received the command.
> +			 */
> +			resp->error_code = rc;
> +
> +		goto free_dma_out;
> +	}
> +
> +	for (i = 0; i < msg->num_dma; i++) {
> +		if (dma_buf[i].dma_direction == DEVICE_READ) {

Consider flipping this to reduce indent and slightly improve readability.

		if (dma_buf[i].dma_direction != DEVICE_READ)
			continue;

		if (copy_to_user(...)

> +			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
> +					 dma_virt_addr[i],
> +					 dma_buf[i].len)) {
> +				dev_dbg(dev, "Failed to copy resp to user\n");
> +				err = -EFAULT;
> +				break;
> +			}
> +		}
> +	}
> +free_dma_out:
> +	for (i = 0; i < msg->num_dma; i++)
> +		dma_free_coherent(dev->parent, dma_buf[i].len, dma_virt_addr[i],
> +				  dma_addr[i]);

I'd prefer a little helper function with this to make it clear it's
underdoing stuff in bnxt_fw_setup_input_dma()  Probably only call that
if (msg->num_dma)
to simplify reasoning on whether this is always safe or not.

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



> +static const struct auxiliary_device_id bnxtctl_id_table[] = {
> +	{ .name = "bnxt_en.fwctl", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, bnxtctl_id_table);
> +
> +static struct auxiliary_driver bnxtctl_driver = {
> +	.name = "bnxt_fwctl",
> +	.probe = bnxtctl_probe,
> +	.remove = bnxtctl_remove,
> +	.id_table = bnxtctl_id_table,
> +};
> +
> +module_auxiliary_driver(bnxtctl_driver);
> +
> +MODULE_IMPORT_NS("FWCTL");
> +MODULE_DESCRIPTION("BNXT fwctl driver");
> +MODULE_AUTHOR("Pavan Chebbi <pavan.chebbi@broadcom.com>");
> +MODULE_AUTHOR("Andy Gospodarek <gospo@broadcom.com>");
> +MODULE_LICENSE("GPL");


