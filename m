Return-Path: <netdev+bounces-248760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90776D0DEDA
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE363006995
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622C25744D;
	Sat, 10 Jan 2026 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOqHMMxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAE221DAE;
	Sat, 10 Jan 2026 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085977; cv=none; b=KYv2MjiHi7KWGLyjaZO752aHOU0FWnd1v5Hh8M1UNcZW7R52EYtXSPj33Jo8umXZ8xmspYyhxVO5HTzEYr4yx5qNE7Xvqnr5j5lmFIx9SbLFBBjVdI7nddq7qJLTyCF1491NYqnhiK2mySG1vR0PWznofkgGDZwCa6hnQxEX0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085977; c=relaxed/simple;
	bh=bG/9bo5Wky0kCuC8gN4U922vGwG/EZPRCzruUYAydys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsqUDSiEVtsdHzqh8k+Je9sHAJmudUUN0F5M79QSKnI+vRRhFtx1f5r5DwGwn1wO8KQUvMAuDUokqookN9Q8WBMj/rNNXx3OkgGiXSF0GcSNewur1yX0ly9q/4QrP6dKnk1mltf+yKaVhUO1ZOedMk3h4RmBDtuYeWKqIybwPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOqHMMxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559FAC116C6;
	Sat, 10 Jan 2026 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085976;
	bh=bG/9bo5Wky0kCuC8gN4U922vGwG/EZPRCzruUYAydys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOqHMMxvoF3r3sgdcgqFuXeteTdpRYNmC09cPVtgDp/BB5hNtHCDAnZPTLJKSM5ON
	 oujNSLjXCXxxw31FJT2ZM1Iju3ZLQs9A6ru+GYGPxUDANwyRXYJ0FfL2iY+2TBqIoH
	 bqISV5bD+yQ6YQ8cHmVSFB2a5aufnI6emAdA2BDtnUhBXE01JNsJ3AS1G/MceW2wvE
	 wVVRYQkKk+6Hd0w9DpooODs2s9oG2gZeGPVYZJbj6wfTPyM7F7x126JaUG+vrYqzwV
	 MuxuBxdsA6/30gIh7S41jIwC5mvULIM7KCw3BLf4wtkw7RjnWKGRmVmkCXXaf15X93
	 v9qGT95DypGHQ==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,05/13] octeontx2-af: npc: cn20k: Allocate default MCAM indexes
Date: Sat, 10 Jan 2026 14:59:35 -0800
Message-ID: <20260110225935.3900857-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109054828.1822307-6-rkannoth@marvell.com>
References: <20260109054828.1822307-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Allocate default MCAM indexes

This patch allocates MCAM indexes for promiscuous, multicast, broadcast,
and unicast traffic when the NIX LF is attached to the PF/VF, rather than
reserving entries upfront.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 88d7f65d246c..cc5a2fde02b9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
> +{
> +	u16 mcam_idx[4] = { 0 }, pf_ucast, pf_pcifunc;
> +	struct npc_mcam_alloc_entry_req req = { 0 };
> +	struct npc_mcam_alloc_entry_rsp rsp = { 0 };

[ ... ]

> +	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
> +
> +	/* successfully allocated index */
> +	if (!ret) {
> +		/* Copy indexes to local array */
> +		for (i = 0; i < cnt; i++)
> +			mcam_idx[i] = rsp.entry_list[i];
> +
> +		goto chk_sanity;
> +	}

[ ... ]

> +chk_sanity:

[ ... ]

> +	/* LBK */
> +	if (is_lbk_vf(rvu, pcifunc)) {
> +		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
> +		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
> +				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
> +		if (ret) {

[ ... ]

> +			ret = -EFAULT;
> +			goto err;
> +		}
> +
> +		goto done;
> +	}
> +
> +	/* VF */
> +	if (is_vf(pcifunc)) {
> +		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
> +		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
> +				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
> +		if (ret) {

[ ... ]

> +			ret = -EFAULT;
> +			goto err;
> +		}
> +
> +		goto done;
> +	}
> +
> +	/* PF */
> +	for (i = NPC_DFT_RULE_START_ID, k = 0; i < NPC_DFT_RULE_MAX_ID &&
> +	     k < cnt; i++, k++) {
> +		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
> +		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
> +				xa_mk_value(mcam_idx[k]), GFP_KERNEL);
> +		if (ret) {

[ ... ]

> +			ret = -EFAULT;
> +			goto err;
> +		}
> +	}
> +
> +done:
> +	return 0;
> +err:
> +	/* TODO: handle errors */
> +	return ret;
> +}

If xa_insert() fails here, the MCAM entries that were allocated earlier
via rvu_mbox_handler_npc_mcam_alloc_entry() are not freed before
returning the error. Could this leak the MCAM entries?

The comment indicates this is known incomplete error handling. For the
PF case, partial xa_insert failures in the loop could also leave some
entries inserted in the xarray while others are not, leading to an
inconsistent state.

