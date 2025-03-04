Return-Path: <netdev+bounces-171641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6FA4DF13
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC343A7225
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3967204090;
	Tue,  4 Mar 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoxhjnMx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE569202F68
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094511; cv=none; b=bzjSXRkok9N6x3zTl5WA3Mdn4Bx0MauPe2LjBDgoYIbpaCOhpg0TZt9rS4BFG3ViIquVO/tMlUiKUWvAzLucRJVLoRHjbQ2QniEvjzXaVcHKasJTpghsrEy3p0JsmqQ2HRu7pWLz0l63+KF6UtCw57h3EglGXdeVF6A0kvRM7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094511; c=relaxed/simple;
	bh=rGEYTpGgu0Hg/tX9juvTLm7Uxi9KwIEaxfrcFp96pNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzF+b78wKxuHTE213GVKorQG77Q1UX/2KrdPKtawGVtCGQzkcXBtSd4DJU1w06d6q2NFfTiVOg7tVTrYFlGpdDGCiLikI0bUFR8wBa7/7lktY6NY7BkTEMeqPgVh5n07ZL7vLOODec/B2/G+qR6OHeN7u77ZmbVHcWsfX7rbLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoxhjnMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FA3C4CEE5;
	Tue,  4 Mar 2025 13:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741094511;
	bh=rGEYTpGgu0Hg/tX9juvTLm7Uxi9KwIEaxfrcFp96pNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hoxhjnMx+KQE0cUceRAf6JawLNOMswvf2wan5MYgOXSJhjQNnn++gbrYuKotXrSyt
	 9gpb4t025h87EkE2UeLAriyokm3ygnpOTOrCbjhs62pSJ9IGuqHv4vQ05o3TO4OntR
	 zYspkjJSqJKeLh8DHlOsBbH5ele9w1t8tu/idWVAIep7vJqToyIT999urSjnMOi/ed
	 YsSjUu35NCyShbCGOL7dyyNfVFEsFkvx+T58T58VynsDO/9PeOi+Q3w6EH/qJDfB/x
	 5eYgTTwJbtghtD+jVHlNQKGOi660Mzle2esILQH3RUel2/R8rJBaLL142ZkWumogCX
	 Ji9cZn/94Ojrg==
Date: Tue, 4 Mar 2025 13:21:45 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org
Subject: Re: [PATCH net-next v7 02/14] xsc: Enable command queue
Message-ID: <20250304132145.GD3666230@kernel.org>
References: <20250228154122.216053-1-tianx@yunsilicon.com>
 <20250228154125.216053-3-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228154125.216053-3-tianx@yunsilicon.com>

On Fri, Feb 28, 2025 at 11:41:26PM +0800, Xin Tian wrote:
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

Hi Xin Tian, all,

Some minor nits from my side.

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c

...

> +/*  Notes:
> + *    1. Callback functions may not sleep
> + *    2. page queue commands do not support asynchrous completion
> + */
> +static int xsc_cmd_invoke(struct xsc_core_device *xdev, struct xsc_cmd_msg *in,
> +			  struct xsc_rsp_msg *out, u8 *status)
> +{
> +	struct xsc_cmd *cmd = &xdev->cmd;
> +	struct xsc_cmd_work_ent *ent;
> +	struct xsc_cmd_stats *stats;
> +	ktime_t t1, t2, delta;
> +	struct semaphore *sem;
> +	int err = 0;
> +	s64 ds;
> +	u16 op;
> +
> +	ent = xsc_alloc_cmd(cmd, in, out);
> +	if (IS_ERR(ent))
> +		return PTR_ERR(ent);
> +
> +	init_completion(&ent->done);
> +	INIT_WORK(&ent->work, cmd_work_handler);
> +	if (!queue_work(cmd->wq, &ent->work)) {
> +		pci_err(xdev->pdev, "failed to queue work\n");
> +		err = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	err = xsc_wait_func(xdev, ent);
> +	if (err == -ETIMEDOUT)
> +		goto out;
> +	t1 = timespec64_to_ktime(ent->ts1);
> +	t2 = timespec64_to_ktime(ent->ts2);
> +	delta = ktime_sub(t2, t1);
> +	ds = ktime_to_ns(delta);
> +	op = be16_to_cpu(((struct xsc_inbox_hdr *)in->first.data)->opcode);
> +	if (op < ARRAY_SIZE(cmd->stats)) {
> +		stats = &cmd->stats[op];
> +		spin_lock(&stats->lock);
> +		stats->sum += ds;
> +		++stats->n;
> +		spin_unlock(&stats->lock);
> +	}
> +	*status = ent->status;
> +	xsc_free_cmd(ent);
> +
> +	return err;
> +
> +out:

Maybe err_sem_up would be a better name for this label.
Likewise for other cases where out or our_* is used
for paths only used for unwinding in the case of error.

> +	sem = &cmd->sem;
> +	up(sem);
> +out_free:

And err_free would be a better name for this label.

Also, in this patch (set) sometimes labels are named err_something,
and sometimes they are called something_err. It would be nice
to make that consistent (personally, I would go for err_somthing).

> +	xsc_free_cmd(ent);
> +	return err;
> +}
> +
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
> +	memcpy(to->first.data, from, copy);
> +	size -= copy;
> +	from += copy;
> +
> +	next = to->next;
> +	while (size) {
> +		if (!next) {
> +			/* this is a BUG */

Maybe WARN_ONCE() or similar would be appropriate here?

> +			return -ENOMEM;
> +		}
> +
> +		copy = min_t(int, size, XSC_CMD_DATA_BLOCK_SIZE);
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
> +
> +static int xsc_copy_from_rsp_msg(void *to, struct xsc_rsp_msg *from, int size)
> +{
> +	struct xsc_cmd_prot_block *block;
> +	struct xsc_cmd_mailbox *next;
> +	int copy;
> +
> +	if (!to || !from)
> +		return -ENOMEM;
> +
> +	copy = min_t(int, size, sizeof(from->first.data));
> +	memcpy(to, from->first.data, copy);
> +	size -= copy;
> +	to += copy;
> +
> +	next = from->next;
> +	while (size) {
> +		if (!next) {
> +			/* this is a BUG */

Ditto.

> +			return -ENOMEM;
> +		}
> +
> +		copy = min_t(int, size, XSC_CMD_DATA_BLOCK_SIZE);
> +		block = next->buf;
> +		if (!block->owner_status)
> +			pr_err("block ownership check failed\n");
> +
> +		memcpy(to, block->data, copy);
> +		to += copy;
> +		size -= copy;
> +		next = next->next;
> +	}
> +
> +	return 0;
> +}

...

> +static int xsc_request_pid_cid_mismatch_restore(struct xsc_core_device *xdev)
> +{
> +	struct xsc_cmd *cmd = &xdev->cmd;
> +	u16 req_pid, req_cid;
> +	u16 gap;
> +
> +	int err;
> +
> +	req_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.req_pid_addr));
> +	req_cid = readl(XSC_REG_ADDR(xdev, cmd->reg.req_cid_addr));
> +	if (req_pid >= (1 << cmd->log_sz) || req_cid >= (1 << cmd->log_sz)) {
> +		pci_err(xdev->pdev,
> +			"req_pid %d, req_cid %d, out of normal range!!! max value is %d\n",
> +			req_pid, req_cid, (1 << cmd->log_sz));
> +		return -1;
> +	}
> +
> +	if (req_pid == req_cid)
> +		return 0;
> +
> +	gap = (req_pid > req_cid) ? (req_pid - req_cid)
> +	      : ((1 << cmd->log_sz) + req_pid - req_cid);
> +
> +	err = xsc_send_dummy_cmd(xdev, gap, req_cid);
> +	if (err) {
> +		pci_err(xdev->pdev, "Send dummy cmd failed\n");
> +		goto send_dummy_fail;

I think that it would be nicer to simply return err here
and drop the send_dummy_fail label here as no unwind is occurring.
Likewise for other similar cases in this patch (set).

> +	}
> +
> +send_dummy_fail:
> +	return err;
> +}

...

> +static int xsc_cmd_cq_polling(void *data)
> +{
> +	struct xsc_core_device *xdev = data;
> +	struct xsc_cmd *cmd = &xdev->cmd;
> +	struct xsc_rsp_layout *rsp;
> +	u32 cq_pid;
> +
> +	while (!kthread_should_stop()) {
> +		if (need_resched())
> +			schedule();
> +		cq_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_pid_addr));
> +		if (cmd->cq_cid == cq_pid) {
> +			mdelay(3);
> +			continue;
> +		}
> +
> +		rsp = xsc_get_cq_inst(cmd, cmd->cq_cid);
> +		if (!cmd->ownerbit_learned) {
> +			cmd->ownerbit_learned = 1;
> +			cmd->owner_bit = rsp->owner_bit;
> +		}
> +		if (cmd->owner_bit != rsp->owner_bit) {
> +			pci_err(xdev->pdev, "hw update cq doorbell but buf not ready %u %u\n",
> +				cmd->cq_cid, cq_pid);
> +			continue;
> +		}
> +
> +		xsc_cmd_comp_handler(xdev, rsp->idx, rsp);
> +
> +		cmd->cq_cid = (cmd->cq_cid + 1) % (1 << cmd->log_sz);
> +
> +		writel(cmd->cq_cid, XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
> +		if (cmd->cq_cid == 0)
> +			cmd->owner_bit = !cmd->owner_bit;
> +	}

super nit: blank line here please

> +	return 0;
> +}

...

> +static int xsc_load(struct xsc_core_device *xdev)
> +{
> +	int err = 0;
> +
> +	mutex_lock(&xdev->intf_state_mutex);
> +	if (test_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state))
> +		goto out;
> +
> +	err = xsc_hw_setup(xdev);
> +	if (err) {
> +		pci_err(xdev->pdev, "xsc_hw_setup failed %d\n", err);
> +		goto out;
> +	}
> +
> +	set_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state);
> +	mutex_unlock(&xdev->intf_state_mutex);
> +
> +	return 0;
> +out:
> +	mutex_unlock(&xdev->intf_state_mutex);
> +	return err;
> +}
> +
> +static int xsc_unload(struct xsc_core_device *xdev)
> +{
> +	mutex_lock(&xdev->intf_state_mutex);
> +	if (!test_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state)) {
> +		xsc_hw_cleanup(xdev);
> +		goto out;
> +	}
> +
> +	clear_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state);
> +
> +	xsc_hw_cleanup(xdev);
> +
> +out:
> +	mutex_unlock(&xdev->intf_state_mutex);

super nit: maybe no blank line here.

> +
> +	return 0;
> +}

...

