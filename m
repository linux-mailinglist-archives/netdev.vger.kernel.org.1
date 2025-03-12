Return-Path: <netdev+bounces-174126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3DEA5D918
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CEE3AFDB2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053FE238161;
	Wed, 12 Mar 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="ABvlYv+0"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-32.ptr.blmpb.com (va-2-32.ptr.blmpb.com [209.127.231.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5422D7A2
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771051; cv=none; b=JFMGfuH5f7rHvAymzpNvBtuF0XTso1f1Ib8zJMYF0+WGVsoScHGIhjY6Ob5BDMvR4QCwcEadoLZv0iQ3UMFNRQfL8/bqNnDsutoARoWrNFMKkUYGgcVyVMFgLFTB4d7kWq/kboRs+R7XfJ9AKwd/pPmbJL4oL344nzEkVm54sSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771051; c=relaxed/simple;
	bh=Lx8I2lrqdHJ8204qCEDLkRrBaxjq5jrg13x3O5KtWWE=;
	h=From:Date:Mime-Version:Subject:Message-Id:In-Reply-To:To:
	 References:Cc:Content-Type; b=oTmuOaFws2YIZKgsEcPI788wZcswPaHuZN1EtQPxqOiej93oN4xTx2W8DUbuKCDM2EAqzxYCEaSjAI2IrmG5UfCK6XIxpD3q3DAaR91xs6Y5v9cSFwQDI/lhrlpVygc//QQTyZecC2JOrlTp4qki4+X0tdyO8XVHN9xB0aGFrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=ABvlYv+0; arc=none smtp.client-ip=209.127.231.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741771034; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ix9ue3+RDfvllHiCiUxseW8XraizQ9VkrUGFj3s/6gw=;
 b=ABvlYv+0ZwfxR0qxQjO8HANvHm5BQUytRfJq02N4wrJtmf3q1+WDWwPOLl5607hC2qAM7A
 zSUIoMeMsC+gFD39lasI/0TpeWEJ24T3Fis+loh9z1T/eH80tltZAyaPzhf/U7CHM0ye3d
 wBNz07hhTs0tuD8loHXLSTqpy/KN/kmVOpeVsYHbwQv7spA0hbBXR8Yp+vTayaIxaHFBl5
 rkclWfPjTSFplxGmp/fv+AWQDaS7q6Mt6OqQd8XS5tASNEw3aMsLzX/AIBJoFFGpmM7Wqm
 b9hw+YDDfvXg9jME4CtjZE+jTWVZGLlrO/0djxKLeF9GHlnzpvDysqRkDBykbw==
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Wed, 12 Mar 2025 17:17:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
Message-Id: <69c322e0-7e38-4ac6-b390-7a9b294261b3@yunsilicon.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <20250310063429.GF4159220@kernel.org>
To: "Simon Horman" <horms@kernel.org>
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100827.555320-3-tianx@yunsilicon.com> <20250310063429.GF4159220@kernel.org>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 12 Mar 2025 17:17:11 +0800
X-Lms-Return-Path: <lba+267d15117+914b0a+vger.kernel.org+tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/3/10 14:34, Simon Horman wrote:
> On Fri, Mar 07, 2025 at 06:08:29PM +0800, Xin Tian wrote:
>> The command queue is a hardware channel for sending
>> commands between the driver and the firmware.
>> xsc_cmd.h defines the command protocol structures.
>> The logic for command allocation, sending,
>> completion handling, and error handling is implemented
>> in cmdq.c.
>>
>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> Hi Xin,
>
> Some minor feedback from my side.
>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
> ...
>
>> +static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from, int size)
>> +{
>> +	struct xsc_cmd_prot_block *block;
>> +	struct xsc_cmd_mailbox *next;
>> +	int copy;
>> +
>> +	if (!to || !from)
>> +		return -ENOMEM;
>> +
>> +	copy = min_t(int, size, sizeof(to->first.data));
> nit: I expect that using min() is sufficient here...
Ack
>
>> +	memcpy(to->first.data, from, copy);
>> +	size -= copy;
>> +	from += copy;
>> +
>> +	next = to->next;
>> +	while (size) {
>> +		if (!next) {
>> +			WARN_ONCE(1, "Mail box not enough\n");
>> +			return -ENOMEM;
>> +		}
>> +
>> +		copy = min_t(int, size, XSC_CMD_DATA_BLOCK_SIZE);
>       ... and I'm pretty sure it is sufficient here().
>
>       Likewise for similar uses of min_t() in this patch.
>
Ack
>> +		block = next->buf;
>> +		memcpy(block->data, from, copy);
>> +		block->owner_status = 0;
>> +		from += copy;
>> +		size -= copy;
>> +		next = next->next;
>> +	}
>> +
>> +	return 0;
>> +}
> ...
>
>> +int xsc_cmd_init(struct xsc_core_device *xdev)
>> +{
>> +	int size = sizeof(struct xsc_cmd_prot_block);
>> +	int align = roundup_pow_of_two(size);
>> +	struct xsc_cmd *cmd = &xdev->cmd;
>> +	u32 cmd_h, cmd_l;
>> +	u32 err_stat;
>> +	int err;
>> +	int i;
>> +
>> +	/* now there is 544 cmdq resource, soc using from id 514 */
>> +	cmd->reg.req_pid_addr = HIF_CMDQM_HOST_REQ_PID_MEM_ADDR;
>> +	cmd->reg.req_cid_addr = HIF_CMDQM_HOST_REQ_CID_MEM_ADDR;
>> +	cmd->reg.rsp_pid_addr = HIF_CMDQM_HOST_RSP_PID_MEM_ADDR;
>> +	cmd->reg.rsp_cid_addr = HIF_CMDQM_HOST_RSP_CID_MEM_ADDR;
>> +	cmd->reg.req_buf_h_addr = HIF_CMDQM_HOST_REQ_BUF_BASE_H_ADDR_MEM_ADDR;
>> +	cmd->reg.req_buf_l_addr = HIF_CMDQM_HOST_REQ_BUF_BASE_L_ADDR_MEM_ADDR;
>> +	cmd->reg.rsp_buf_h_addr = HIF_CMDQM_HOST_RSP_BUF_BASE_H_ADDR_MEM_ADDR;
>> +	cmd->reg.rsp_buf_l_addr = HIF_CMDQM_HOST_RSP_BUF_BASE_L_ADDR_MEM_ADDR;
>> +	cmd->reg.msix_vec_addr = HIF_CMDQM_VECTOR_ID_MEM_ADDR;
>> +	cmd->reg.element_sz_addr = HIF_CMDQM_Q_ELEMENT_SZ_REG_ADDR;
>> +	cmd->reg.q_depth_addr = HIF_CMDQM_HOST_Q_DEPTH_REG_ADDR;
>> +	cmd->reg.interrupt_stat_addr = HIF_CMDQM_HOST_VF_ERR_STS_MEM_ADDR;
>> +
>> +	cmd->pool = dma_pool_create("xsc_cmd",
>> +				    &xdev->pdev->dev,
>> +				    size, align, 0);
>> +	if (!cmd->pool)
>> +		return -ENOMEM;
>> +
>> +	cmd->cmd_buf = (void *)__get_free_pages(GFP_ATOMIC, 0);
>> +	if (!cmd->cmd_buf) {
>> +		err = -ENOMEM;
>> +		goto err_free_pool;
>> +	}
>> +	cmd->cq_buf = (void *)__get_free_pages(GFP_ATOMIC, 0);
>> +	if (!cmd->cq_buf) {
>> +		err = -ENOMEM;
>> +		goto err_free_cmd;
>> +	}
>> +
>> +	cmd->dma = dma_map_single(&xdev->pdev->dev, cmd->cmd_buf, PAGE_SIZE,
>> +				  DMA_BIDIRECTIONAL);
>> +	if (dma_mapping_error(&xdev->pdev->dev, cmd->dma)) {
>> +		err = -ENOMEM;
>> +		goto err_free_cq;
>> +	}
>> +
>> +	cmd->cq_dma = dma_map_single(&xdev->pdev->dev, cmd->cq_buf, PAGE_SIZE,
>> +				     DMA_BIDIRECTIONAL);
>> +	if (dma_mapping_error(&xdev->pdev->dev, cmd->cq_dma)) {
>> +		err = -ENOMEM;
>> +		goto err_unmap_cmd;
>> +	}
>> +
>> +	cmd->cmd_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.req_pid_addr));
>> +	cmd->cq_cid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
>> +	cmd->ownerbit_learned = 0;
>> +
>> +	xsc_cmd_handle_rsp_before_reload(cmd, xdev);
>> +
>> +#define ELEMENT_SIZE_LOG	6 /* 64B */
>> +#define Q_DEPTH_LOG		5 /* 32 */
>> +
>> +	cmd->log_sz = Q_DEPTH_LOG;
>> +	cmd->log_stride = readl(XSC_REG_ADDR(xdev, cmd->reg.element_sz_addr));
>> +	writel(1 << cmd->log_sz, XSC_REG_ADDR(xdev, cmd->reg.q_depth_addr));
>> +	if (cmd->log_stride != ELEMENT_SIZE_LOG) {
>> +		dev_err(&xdev->pdev->dev, "firmware failed to init cmdq, log_stride=(%d, %d)\n",
>> +			cmd->log_stride, ELEMENT_SIZE_LOG);
>> +		err = -ENODEV;
>> +		goto err_unmap_cq;
>> +	}
>> +
>> +	if (1 << cmd->log_sz > XSC_MAX_COMMANDS) {
>> +		dev_err(&xdev->pdev->dev, "firmware reports too many outstanding commands %d\n",
>> +			1 << cmd->log_sz);
>> +		err = -EINVAL;
>> +		goto err_unmap_cq;
>> +	}
>> +
>> +	if (cmd->log_sz + cmd->log_stride > PAGE_SHIFT) {
>> +		dev_err(&xdev->pdev->dev, "command queue size overflow\n");
>> +		err = -EINVAL;
>> +		goto err_unmap_cq;
>> +	}
>> +
>> +	cmd->checksum_disabled = 1;
>> +	cmd->max_reg_cmds = (1 << cmd->log_sz) - 1;
>> +	cmd->cmd_entry_mask = (1 << cmd->max_reg_cmds) - 1;
>> +
>> +	spin_lock_init(&cmd->alloc_lock);
>> +	spin_lock_init(&cmd->token_lock);
>> +	spin_lock_init(&cmd->doorbell_lock);
>> +	for (i = 0; i < ARRAY_SIZE(cmd->stats); i++)
>> +		spin_lock_init(&cmd->stats[i].lock);
>> +
>> +	sema_init(&cmd->sem, cmd->max_reg_cmds);
>> +
>> +	cmd_h = (u32)((u64)(cmd->dma) >> 32);
>> +	cmd_l = (u32)(cmd->dma);
>> +	if (cmd_l & 0xfff) {
>> +		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
>> +		err = -ENOMEM;
>> +		goto err_unmap_cq;
>> +	}
>> +
>> +	writel(cmd_h, XSC_REG_ADDR(xdev, cmd->reg.req_buf_h_addr));
>> +	writel(cmd_l, XSC_REG_ADDR(xdev, cmd->reg.req_buf_l_addr));
>> +
>> +	cmd_h = (u32)((u64)(cmd->cq_dma) >> 32);
>> +	cmd_l = (u32)(cmd->cq_dma);
> nit: I think you can use upper_32_bits() and lower_32_bits() here.

yes, that's better

Thanks, Simon, I'll modify all the upper points in next version.

>> +	if (cmd_l & 0xfff) {
>> +		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
>> +		err = -ENOMEM;
>> +		goto err_unmap_cq;
>> +	}
>> +	writel(cmd_h, XSC_REG_ADDR(xdev, cmd->reg.rsp_buf_h_addr));
>> +	writel(cmd_l, XSC_REG_ADDR(xdev, cmd->reg.rsp_buf_l_addr));
>> +
>> +	/* Make sure firmware sees the complete address before we proceed */
>> +	wmb();
>> +
>> +	cmd->mode = XSC_CMD_MODE_POLLING;
>> +	cmd->cmd_status = XSC_CMD_STATUS_NORMAL;
>> +
>> +	err = xsc_create_msg_cache(xdev);
>> +	if (err) {
>> +		dev_err(&xdev->pdev->dev, "failed to create command cache\n");
>> +		goto err_unmap_cq;
>> +	}
>> +
>> +	xsc_set_wqname(xdev);
>> +	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
>> +	if (!cmd->wq) {
>> +		dev_err(&xdev->pdev->dev, "failed to create command workqueue\n");
>> +		err = -ENOMEM;
>> +		goto err_destroy_cache;
>> +	}
>> +
>> +	cmd->cq_task = kthread_create(xsc_cmd_cq_polling,
>> +				      (void *)xdev,
>> +				      "xsc_cmd_cq_polling");
>> +	if (!cmd->cq_task) {
>> +		dev_err(&xdev->pdev->dev, "failed to create cq task\n");
>> +		err = -ENOMEM;
>> +		goto err_destroy_wq;
>> +	}
>> +	wake_up_process(cmd->cq_task);
>> +
>> +	err = xsc_request_pid_cid_mismatch_restore(xdev);
>> +	if (err) {
>> +		dev_err(&xdev->pdev->dev, "request pid,cid wrong, restore failed\n");
>> +		goto err_stop_cq_task;
>> +	}
>> +
>> +	/* clear abnormal state to avoid the impact of previous error */
>> +	err_stat = readl(XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
>> +	if (err_stat) {
>> +		pci_err(xdev->pdev, "err_stat 0x%x when init, clear it\n",
>> +			err_stat);
>> +		writel(0xf,
>> +		       XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
>> +	}
>> +
>> +	return 0;
>> +
>> +err_stop_cq_task:
>> +	kthread_stop(cmd->cq_task);
>> +
>> +err_destroy_wq:
>> +	destroy_workqueue(cmd->wq);
>> +
>> +err_destroy_cache:
>> +	xsc_destroy_msg_cache(xdev);
>> +
>> +err_unmap_cq:
>> +	dma_unmap_single(&xdev->pdev->dev, cmd->cq_dma, PAGE_SIZE,
>> +			 DMA_BIDIRECTIONAL);
>> +
>> +err_unmap_cmd:
>> +	dma_unmap_single(&xdev->pdev->dev, cmd->dma, PAGE_SIZE,
>> +			 DMA_BIDIRECTIONAL);
>> +err_free_cq:
>> +	free_pages((unsigned long)cmd->cq_buf, 0);
>> +
>> +err_free_cmd:
>> +	free_pages((unsigned long)cmd->cmd_buf, 0);
>> +
>> +err_free_pool:
>> +	dma_pool_destroy(cmd->pool);
>> +
>> +	return err;
>> +}
> ...

