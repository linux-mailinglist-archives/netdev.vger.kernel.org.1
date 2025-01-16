Return-Path: <netdev+bounces-158904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B84A13B69
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0184E162FBA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60271F37CE;
	Thu, 16 Jan 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEbFkt2f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19ED142900
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035764; cv=none; b=ADD/5IpVuK1mscp6qgdVm13L3Nw1as7ad1+TV5aYgWfadd6e6vIutZNC1Q9SqjXEdQW3XC8sM/JUk1xNR086rgl9yXtZBsQT9WO87H6D1RN9mvYKu7G1F6CK4nZ3mM+QPX4zdmaaB7DxzEsXT5TSgfNJgD9XkJHQ/FKSZFsaxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035764; c=relaxed/simple;
	bh=N5ghbuoNNnHs88ftnq73DIsB4NyJ0OKPo2w5taUdKx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP3mP2ode0YGzUhgVB85fuutPpSEan0tLMPZB2nHcELNGLTLK/0YENhPmGhWzoIq3bHnhzPhvkbic5r6BNBCoANAd1aBri7Dk3vQjag2zux14bUaCy27l2wDrsBAQtxj93LjTSbr0RoGTyzDUCponvl9pgWR+XGnFg6ApDtk/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEbFkt2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2172AC4CED6;
	Thu, 16 Jan 2025 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035764;
	bh=N5ghbuoNNnHs88ftnq73DIsB4NyJ0OKPo2w5taUdKx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEbFkt2fYkV+zIunwnCmw/mo7y29PJE98Ukwd4GEEGIFyDL2kYolD6fMocJEciy1z
	 2+gkHCBGgMQcQXywBuNgG+w6Dz0mjFWxs1dEPd836LBjbTXQEGSvhkPnL2VnMuxOr5
	 mY+0HO2Y1IxBqnNpQ3sCqfWgqGW7hO2ZcZ3aLIAsujPn/CG5OepnP2MicmblCRI7vM
	 z4h85iVXAZZBpOSesMv3tKVdLc6jNslAKYQGZrxZA6JrIw/xaFnuCLPAiT4ZUEVVmS
	 YY27A06LQxxCXLR1WzC/VB8KLu/lInTUJc84S/j3RyLgVL4VucNVKciu1KQmlrX+fJ
	 4oQujmysongmA==
Date: Thu, 16 Jan 2025 13:55:59 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v3 02/14] net-next/yunsilicon: Enable CMDQ
Message-ID: <20250116135559.GB6206@kernel.org>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
 <20250115102245.3541496-3-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115102245.3541496-3-tianx@yunsilicon.com>

On Wed, Jan 15, 2025 at 06:22:46PM +0800, Xin Tian wrote:
> Enable cmd queue to support driver-firmware communication.
> Hardware control will be performed through cmdq mostly.
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c

...

> +static void cmd_work_handler(struct work_struct *work)
> +{
> +	struct xsc_cmd_work_ent *ent = container_of(work, struct xsc_cmd_work_ent, work);
> +	struct xsc_cmd *cmd = ent->cmd;
> +	struct xsc_core_device *xdev = container_of(cmd, struct xsc_core_device, cmd);
> +	struct xsc_cmd_layout *lay;
> +	struct semaphore *sem;
> +	unsigned long flags;

Hi Xin Tian,

Please consider arranging local variables in reverse xmas tree order -
longest line to shortest - as is preferred in Networking code.
Separating initialisation from declarations as needed.

And also, please consider limiting lines to 80 columns wide or less,
where it can be achieved without reducing readability. This is also
preferred in Networking code.

I think that in this case that both could be achieved like this
(completely untested):

	struct xsc_cmd_work_ent *ent;
	struct xsc_core_device *xdev;
	struct xsc_cmd_layout *lay;
	struct semaphore *sem;
	struct xsc_cmd *cmd;
	unsigned long flags;

	ent = container_of(work, struct xsc_cmd_work_ent, work);
	cmd = ent->cmd;
	xdev = container_of(cmd, struct xsc_core_device, cmd);

With regards to reverse xmas tree ordering, this tool can be useful:
https://github.com/ecree-solarflare/xmastree

...

> +static void xsc_cmd_comp_handler(struct xsc_core_device *xdev, u8 idx, struct xsc_rsp_layout *rsp)
> +{
> +	struct xsc_cmd *cmd = &xdev->cmd;
> +	struct xsc_cmd_work_ent *ent;
> +	struct xsc_inbox_hdr *hdr;
> +
> +	if (idx > cmd->max_reg_cmds || (cmd->bitmask & (1 << idx))) {
> +		pci_err(xdev->pdev, "idx[%d] exceed max cmds, or has no relative request.\n", idx);
> +		return;
> +	}
> +	ent = cmd->ent_arr[idx];
> +	ent->rsp_lay = rsp;
> +	ktime_get_ts64(&ent->ts2);
> +
> +	memcpy(ent->out->first.data, ent->rsp_lay->out, sizeof(ent->rsp_lay->out));
> +	if (!cmd->checksum_disabled)
> +		ent->ret = verify_signature(ent);
> +	else
> +		ent->ret = 0;
> +	ent->status = 0;
> +
> +	hdr = (struct xsc_inbox_hdr *)ent->in->first.data;

nit: hdr is set but otherwise unused in this function.
     Perhaps it can be removed (and added in a later patch if needed there)?

     Flagged by W=1 builds.

> +	free_ent(cmd, ent->idx);
> +	complete(&ent->done);
> +	up(&cmd->sem);
> +}

...

