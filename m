Return-Path: <netdev+bounces-173425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2541FA58C1C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476C8163779
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930891C1F13;
	Mon, 10 Mar 2025 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdSYkWeH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32D33F9
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588479; cv=none; b=ofdCMsHQgudRrEvgkLlJG6fcXmEyW1ndg+rvo4BtpPG3A9MPcCLyZ9+tERrieJjIf9M7eHzyI2d3lwaQ9BtvHYLWO48rgCyKGqX0e5z38IGXVOdnoet7RaZBSFj2/dJ22gSehw27DqRHnSaCgOyHB7NJ1cqO80pKYDFSELen/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588479; c=relaxed/simple;
	bh=pWWHmE+Y0U5xpVyky0gqce4q0e0EfjTEoGgl+Qjfxzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVszoHanHV7AUhRovGcxgPXUmZWanS2GHwYQd/70R8YI4CpuHeOOlSxSchNBcg/vUqoqS3Nr09M8khTViNGhsWMoQ9XwG1T3JsiS0YsdaNqWMJ3POm/Xm+C34HEIuVyIqdUS4OMOEUEC9lpmPdy08i/2A0p076M30oxbNJF7MXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdSYkWeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42D2C4CEE5;
	Mon, 10 Mar 2025 06:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741588478;
	bh=pWWHmE+Y0U5xpVyky0gqce4q0e0EfjTEoGgl+Qjfxzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdSYkWeHn+9xjHGsV1/8Mi1shP4Eaf1WPtiDb1cklR1zLAycf/+qHQ99hZYx/RZ4B
	 /7jmEgvBwm9XvJy0GQK7q9j79xnNSZGzkUtByybXWnbH56Oo30EHV53AZCtiEIiS4r
	 6DPUoo2uaPseLGNPaylwniLmdA5o88BbozQifOf8eoV4PcILp/+1X9mcu10VKClqVh
	 z82q+F7I/e5CozaUiJX8+h94u7K9olCJBdv0ba6AdQuel/ZPQ0sifgh+GqZCzTwsRz
	 SYwTcsI2Vx/B1SsuYZbxWgGVuVgjfRQEcvl8DPKaCZGTcGnFvsnCfObMHosnS34Zye
	 uHn9+VZcrVnZg==
Date: Mon, 10 Mar 2025 07:34:29 +0100
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
Message-ID: <20250310063429.GF4159220@kernel.org>
References: <20250307100824.555320-1-tianx@yunsilicon.com>
 <20250307100827.555320-3-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307100827.555320-3-tianx@yunsilicon.com>

On Fri, Mar 07, 2025 at 06:08:29PM +0800, Xin Tian wrote:
> The command queue is a hardware channel for sending
> commands between the driver and the firmware.
> xsc_cmd.h defines the command protocol structures.
> The logic for command allocation, sending,
> completion handling, and error handling is implemented
> in cmdq.c.
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>

Hi Xin,

Some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c

...

> +static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from, int size)
> +{
> +	struct xsc_cmd_prot_block *block;
> +	struct xsc_cmd_mailbox *next;
> +	int copy;
> +
> +	if (!to || !from)
> +		return -ENOMEM;
> +
> +	copy = min_t(int, size, sizeof(to->first.data));

nit: I expect that using min() is sufficient here...

> +	memcpy(to->first.data, from, copy);
> +	size -= copy;
> +	from += copy;
> +
> +	next = to->next;
> +	while (size) {
> +		if (!next) {
> +			WARN_ONCE(1, "Mail box not enough\n");
> +			return -ENOMEM;
> +		}
> +
> +		copy = min_t(int, size, XSC_CMD_DATA_BLOCK_SIZE);

     ... and I'm pretty sure it is sufficient here().

     Likewise for similar uses of min_t() in this patch.


> +		block = next->buf;
> +		memcpy(block->data, from, copy);
> +		block->owner_status = 0;
> +		from += copy;
> +		size -= copy;
> +		next = next->next;
> +	}
> +
> +	return 0;
> +}

...

> +int xsc_cmd_init(struct xsc_core_device *xdev)
> +{
> +	int size = sizeof(struct xsc_cmd_prot_block);
> +	int align = roundup_pow_of_two(size);
> +	struct xsc_cmd *cmd = &xdev->cmd;
> +	u32 cmd_h, cmd_l;
> +	u32 err_stat;
> +	int err;
> +	int i;
> +
> +	/* now there is 544 cmdq resource, soc using from id 514 */
> +	cmd->reg.req_pid_addr = HIF_CMDQM_HOST_REQ_PID_MEM_ADDR;
> +	cmd->reg.req_cid_addr = HIF_CMDQM_HOST_REQ_CID_MEM_ADDR;
> +	cmd->reg.rsp_pid_addr = HIF_CMDQM_HOST_RSP_PID_MEM_ADDR;
> +	cmd->reg.rsp_cid_addr = HIF_CMDQM_HOST_RSP_CID_MEM_ADDR;
> +	cmd->reg.req_buf_h_addr = HIF_CMDQM_HOST_REQ_BUF_BASE_H_ADDR_MEM_ADDR;
> +	cmd->reg.req_buf_l_addr = HIF_CMDQM_HOST_REQ_BUF_BASE_L_ADDR_MEM_ADDR;
> +	cmd->reg.rsp_buf_h_addr = HIF_CMDQM_HOST_RSP_BUF_BASE_H_ADDR_MEM_ADDR;
> +	cmd->reg.rsp_buf_l_addr = HIF_CMDQM_HOST_RSP_BUF_BASE_L_ADDR_MEM_ADDR;
> +	cmd->reg.msix_vec_addr = HIF_CMDQM_VECTOR_ID_MEM_ADDR;
> +	cmd->reg.element_sz_addr = HIF_CMDQM_Q_ELEMENT_SZ_REG_ADDR;
> +	cmd->reg.q_depth_addr = HIF_CMDQM_HOST_Q_DEPTH_REG_ADDR;
> +	cmd->reg.interrupt_stat_addr = HIF_CMDQM_HOST_VF_ERR_STS_MEM_ADDR;
> +
> +	cmd->pool = dma_pool_create("xsc_cmd",
> +				    &xdev->pdev->dev,
> +				    size, align, 0);
> +	if (!cmd->pool)
> +		return -ENOMEM;
> +
> +	cmd->cmd_buf = (void *)__get_free_pages(GFP_ATOMIC, 0);
> +	if (!cmd->cmd_buf) {
> +		err = -ENOMEM;
> +		goto err_free_pool;
> +	}
> +	cmd->cq_buf = (void *)__get_free_pages(GFP_ATOMIC, 0);
> +	if (!cmd->cq_buf) {
> +		err = -ENOMEM;
> +		goto err_free_cmd;
> +	}
> +
> +	cmd->dma = dma_map_single(&xdev->pdev->dev, cmd->cmd_buf, PAGE_SIZE,
> +				  DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(&xdev->pdev->dev, cmd->dma)) {
> +		err = -ENOMEM;
> +		goto err_free_cq;
> +	}
> +
> +	cmd->cq_dma = dma_map_single(&xdev->pdev->dev, cmd->cq_buf, PAGE_SIZE,
> +				     DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(&xdev->pdev->dev, cmd->cq_dma)) {
> +		err = -ENOMEM;
> +		goto err_unmap_cmd;
> +	}
> +
> +	cmd->cmd_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.req_pid_addr));
> +	cmd->cq_cid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
> +	cmd->ownerbit_learned = 0;
> +
> +	xsc_cmd_handle_rsp_before_reload(cmd, xdev);
> +
> +#define ELEMENT_SIZE_LOG	6 /* 64B */
> +#define Q_DEPTH_LOG		5 /* 32 */
> +
> +	cmd->log_sz = Q_DEPTH_LOG;
> +	cmd->log_stride = readl(XSC_REG_ADDR(xdev, cmd->reg.element_sz_addr));
> +	writel(1 << cmd->log_sz, XSC_REG_ADDR(xdev, cmd->reg.q_depth_addr));
> +	if (cmd->log_stride != ELEMENT_SIZE_LOG) {
> +		dev_err(&xdev->pdev->dev, "firmware failed to init cmdq, log_stride=(%d, %d)\n",
> +			cmd->log_stride, ELEMENT_SIZE_LOG);
> +		err = -ENODEV;
> +		goto err_unmap_cq;
> +	}
> +
> +	if (1 << cmd->log_sz > XSC_MAX_COMMANDS) {
> +		dev_err(&xdev->pdev->dev, "firmware reports too many outstanding commands %d\n",
> +			1 << cmd->log_sz);
> +		err = -EINVAL;
> +		goto err_unmap_cq;
> +	}
> +
> +	if (cmd->log_sz + cmd->log_stride > PAGE_SHIFT) {
> +		dev_err(&xdev->pdev->dev, "command queue size overflow\n");
> +		err = -EINVAL;
> +		goto err_unmap_cq;
> +	}
> +
> +	cmd->checksum_disabled = 1;
> +	cmd->max_reg_cmds = (1 << cmd->log_sz) - 1;
> +	cmd->cmd_entry_mask = (1 << cmd->max_reg_cmds) - 1;
> +
> +	spin_lock_init(&cmd->alloc_lock);
> +	spin_lock_init(&cmd->token_lock);
> +	spin_lock_init(&cmd->doorbell_lock);
> +	for (i = 0; i < ARRAY_SIZE(cmd->stats); i++)
> +		spin_lock_init(&cmd->stats[i].lock);
> +
> +	sema_init(&cmd->sem, cmd->max_reg_cmds);
> +
> +	cmd_h = (u32)((u64)(cmd->dma) >> 32);
> +	cmd_l = (u32)(cmd->dma);
> +	if (cmd_l & 0xfff) {
> +		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
> +		err = -ENOMEM;
> +		goto err_unmap_cq;
> +	}
> +
> +	writel(cmd_h, XSC_REG_ADDR(xdev, cmd->reg.req_buf_h_addr));
> +	writel(cmd_l, XSC_REG_ADDR(xdev, cmd->reg.req_buf_l_addr));
> +
> +	cmd_h = (u32)((u64)(cmd->cq_dma) >> 32);
> +	cmd_l = (u32)(cmd->cq_dma);

nit: I think you can use upper_32_bits() and lower_32_bits() here.

> +	if (cmd_l & 0xfff) {
> +		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
> +		err = -ENOMEM;
> +		goto err_unmap_cq;
> +	}
> +	writel(cmd_h, XSC_REG_ADDR(xdev, cmd->reg.rsp_buf_h_addr));
> +	writel(cmd_l, XSC_REG_ADDR(xdev, cmd->reg.rsp_buf_l_addr));
> +
> +	/* Make sure firmware sees the complete address before we proceed */
> +	wmb();
> +
> +	cmd->mode = XSC_CMD_MODE_POLLING;
> +	cmd->cmd_status = XSC_CMD_STATUS_NORMAL;
> +
> +	err = xsc_create_msg_cache(xdev);
> +	if (err) {
> +		dev_err(&xdev->pdev->dev, "failed to create command cache\n");
> +		goto err_unmap_cq;
> +	}
> +
> +	xsc_set_wqname(xdev);
> +	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
> +	if (!cmd->wq) {
> +		dev_err(&xdev->pdev->dev, "failed to create command workqueue\n");
> +		err = -ENOMEM;
> +		goto err_destroy_cache;
> +	}
> +
> +	cmd->cq_task = kthread_create(xsc_cmd_cq_polling,
> +				      (void *)xdev,
> +				      "xsc_cmd_cq_polling");
> +	if (!cmd->cq_task) {
> +		dev_err(&xdev->pdev->dev, "failed to create cq task\n");
> +		err = -ENOMEM;
> +		goto err_destroy_wq;
> +	}
> +	wake_up_process(cmd->cq_task);
> +
> +	err = xsc_request_pid_cid_mismatch_restore(xdev);
> +	if (err) {
> +		dev_err(&xdev->pdev->dev, "request pid,cid wrong, restore failed\n");
> +		goto err_stop_cq_task;
> +	}
> +
> +	/* clear abnormal state to avoid the impact of previous error */
> +	err_stat = readl(XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
> +	if (err_stat) {
> +		pci_err(xdev->pdev, "err_stat 0x%x when init, clear it\n",
> +			err_stat);
> +		writel(0xf,
> +		       XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
> +	}
> +
> +	return 0;
> +
> +err_stop_cq_task:
> +	kthread_stop(cmd->cq_task);
> +
> +err_destroy_wq:
> +	destroy_workqueue(cmd->wq);
> +
> +err_destroy_cache:
> +	xsc_destroy_msg_cache(xdev);
> +
> +err_unmap_cq:
> +	dma_unmap_single(&xdev->pdev->dev, cmd->cq_dma, PAGE_SIZE,
> +			 DMA_BIDIRECTIONAL);
> +
> +err_unmap_cmd:
> +	dma_unmap_single(&xdev->pdev->dev, cmd->dma, PAGE_SIZE,
> +			 DMA_BIDIRECTIONAL);
> +err_free_cq:
> +	free_pages((unsigned long)cmd->cq_buf, 0);
> +
> +err_free_cmd:
> +	free_pages((unsigned long)cmd->cmd_buf, 0);
> +
> +err_free_pool:
> +	dma_pool_destroy(cmd->pool);
> +
> +	return err;
> +}

...

