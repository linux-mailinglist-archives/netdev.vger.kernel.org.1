Return-Path: <netdev+bounces-251274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E24AD3B791
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87550303178D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7292DC770;
	Mon, 19 Jan 2026 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvHYnhe5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490502DB7AF;
	Mon, 19 Jan 2026 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852012; cv=none; b=qS3Krw7MoQqHNOWDbOBerDowvq+M0PE7Ty6Wr/isTLC6ATi2KVTdu/hkPNuL6lpp+5rHUaXT9RQt1fTiMXTxA/Zh/2XcC7i2UlxFeK0m1ikoRU2OhEn67Dy76Uc4gNuFJ9bOR8BBamWqNTuXXhswEOrS9FJKWZ9wu8MOxNpMkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852012; c=relaxed/simple;
	bh=gWfXfmPEMCWWaExvOvOyUPeFKh770w+ZrVOnwMHSsC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2jlNZeo9GDmvARNuLCUGiiT/R5LCh+lsgfmsYIbDqqF5q+HrcBJbBK3rNR1MDEg7YGZb1OTk9gkeZ+8/C86h8ovDWBHjUhYwQYOY211zw9+UXk+9xM8ecpV/K5db3sXoHdDakEl4x9tjeVq9MDJ0Jgwge/1KnyOGH4CGI4dDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvHYnhe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E3BC4AF09;
	Mon, 19 Jan 2026 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768852012;
	bh=gWfXfmPEMCWWaExvOvOyUPeFKh770w+ZrVOnwMHSsC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvHYnhe5YzZzEjrNsxAVoiPwV0X4AJT59OpocwLo4sRrS1Cx7m45ilS9VkufnmyDI
	 DEQ4O4a0y3dF2USHeSHSUWGE+5Wg5Q2P/EcSRxMHbESqoEDQNdKowNT4VFVflW+/vY
	 RcsoERku0htxJzRmNJIcZ+F72VdrFDScXl12YHhwZL78bHJiINqAsvsU+yXDuMW9rw
	 7PULcH9ViQnsC3QC7XrqejKzuC9kQfcK902KJ8FzgvakZxbWVqNXIU9YytnfwqJDXW
	 4APQmiEj9evil/Lf0cKzg5tjbZtWSDovsCQLe2N5jwoaP62inmKuTeF8NQ6v9l8HNI
	 gkX+0/TjJoYww==
From: Jakub Kicinski <kuba@kernel.org>
To: hkelam@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PatchV2,2/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Mon, 19 Jan 2026 11:46:50 -0800
Message-ID: <20260119194650.1265288-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117165520.2215073-3-hkelam@marvell.com>
References: <20260117165520.2215073-3-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
Octeontx2-pf: Add support for DMAC_FILTER trap

This patch adds DMAC_FILTER trap support to the octeontx2 driver, allowing
devlink trap statistics to be queried for DMAC filtered packets.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> index a72694219df4..9f1b78286695 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c

[ ... ]

> +int otx2_devlink_traps_register(struct otx2_nic *pf)
> +{
> +	const u32 groups_count = ARRAY_SIZE(otx2_trap_groups_arr);
> +	const u32 traps_count = ARRAY_SIZE(otx2_trap_items_arr);
> +	struct devlink *devlink = priv_to_devlink(pf->dl);
> +	struct otx2_trap_data *trap_data;
> +	struct otx2_trap *otx2_trap;
> +	int err, i;
> +
> +	trap_data = kzalloc(sizeof(*trap_data), GFP_KERNEL);
> +	if (!trap_data)
> +		return -ENOMEM;
> +
> +	trap_data->trap_items_arr = kcalloc(traps_count,
> +					    sizeof(struct otx2_trap_item),
> +					    GFP_KERNEL);
> +	if (!trap_data->trap_items_arr) {
> +		err = -ENOMEM;
> +		goto err_trap_items_alloc;
> +	}
> +
> +	trap_data->dl = pf->dl;
> +	trap_data->traps_count = traps_count;
> +	pf->dl->trap_data = trap_data;
> +
> +	err = devlink_trap_groups_register(devlink, otx2_trap_groups_arr,
> +					   groups_count);
> +	if (err)
> +		goto err_groups_register;

[ ... ]

> +err_groups_register:
> +	kfree(trap_data->trap_items_arr);
> +err_trap_items_alloc:
> +	kfree(trap_data);
> +	return err;
> +}

When this function fails after setting pf->dl->trap_data but before returning,
the error paths free trap_data while pf->dl->trap_data still references the
freed memory. Similarly, if kzalloc or kcalloc fails, pf->dl->trap_data remains
NULL. In both cases, the probe error path will call otx2_devlink_traps_unregister()
which dereferences pf->dl->trap_data unconditionally.

> +void otx2_devlink_traps_unregister(struct otx2_nic *pf)
> +{
> +	struct otx2_trap_data *trap_data = pf->dl->trap_data;
                                            ^^^^^^^^^^^^^^^^
If otx2_devlink_traps_register() failed due to allocation failure, trap_data
will be NULL here, causing a NULL pointer dereference below. If registration
failed after pf->dl->trap_data was set, this points to already-freed memory.

> +	struct devlink *devlink = priv_to_devlink(pf->dl);
> +	const struct devlink_trap *trap;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(otx2_trap_items_arr); ++i) {
> +		trap = &otx2_trap_items_arr[i].trap;
> +		devlink_traps_unregister(devlink, trap, 1);
> +	}
> +
> +	devlink_trap_groups_unregister(devlink, otx2_trap_groups_arr,
> +				       ARRAY_SIZE(otx2_trap_groups_arr));
> +	kfree(trap_data->trap_items_arr);
> +	kfree(trap_data);
> +}

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index a7feb4c392b3..5da1605a1a90 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -3282,6 +3282,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		goto err_mcam_flow_del;
>
> +	err = otx2_devlink_traps_register(pf);
> +	if (err)
> +		goto err_traps_unregister;
                     ^^^^^^^^^^^^^^^^^^^^
When otx2_devlink_traps_register() fails, is it correct to jump to a label
that calls otx2_devlink_traps_unregister()? The registration function already
cleaned up its allocations on failure, so calling unregister here would operate
on invalid or NULL trap_data.

Should the error path skip the unregister call, perhaps by jumping directly to
err_mcam_flow_del instead?

> +
>  	/* Initialize SR-IOV resources */
>  	err = otx2_sriov_vfcfg_init(pf);
>  	if (err)

[ ... ]

> @@ -3314,6 +3318,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	otx2_sriov_vfcfg_cleanup(pf);
>  err_pf_sriov_init:
>  	otx2_shutdown_tc(pf);
> +err_traps_unregister:
> +	otx2_devlink_traps_unregister(pf);
>  err_mcam_flow_del:
>  	otx2_mcam_flow_del(pf);

