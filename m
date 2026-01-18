Return-Path: <netdev+bounces-250767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8957BD391F0
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0929C30101DF
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8301DE8AF;
	Sun, 18 Jan 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCA/frtO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC91C2324;
	Sun, 18 Jan 2026 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696827; cv=none; b=k834Jl1iP0dR3PVREq5Ymmbzn65gvfposqgjaKdt7LhxLf3JGhQPXHGiJcKabYrA25rfywYFYgcqIWhL1Fn1KAJ6ejGyUVk/zNi1PQy7djpe6/mMamWczUt5CFLqLHYKe6ptmNj1S5HKZzIQWjXqg052xRZdzXBxWCHZqBaIzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696827; c=relaxed/simple;
	bh=Gk02vul95XCWf89kFQZwBhzGewgFWOLYdTS3usOGkZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpTi1NPLrvboYTS2eIDBREI+DWFcM8+5NPMYMMyyt1hwHEv+H/rhxlDwC56Xpz7XvsVbz6R6WgSUzkj2qCay5NAg+Z4ENVnx8jEAkGDDWuji3Vfd33PaV6Sa3hi/ktFRQeZ6I+gVQV6yowzYLlIo60gcuw7iu+lFQ9N50MREbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCA/frtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D20C4CEF7;
	Sun, 18 Jan 2026 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696826;
	bh=Gk02vul95XCWf89kFQZwBhzGewgFWOLYdTS3usOGkZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCA/frtOHwszv5qHih1eFDZbznWYMb9a7VxecjsGprUZgtRAEcu1rHU0nzii75Or4
	 VZaVL8N3x8m2iCujuZpLtszTaD5oTk9+vKxNFN0HHGfVWSpMqF1ED67tHl10o4ahrX
	 mSylzqgfq7vVy/TJDrHfGkkw2TBJy0cVQ7n8PLk08CkJU8kIks7H3Olzy6jbPMJKCE
	 2NiKIeY9M7wMsAgCqLy4UzMclx7F1AkUilhLkDgJyyqrkz+guc8h3AYgbutHkmyx+c
	 qN7UW3ideRwX7wsM5NOjMyaG4uOAuCgrEP3+3N1HGNRRzqTjTZ7ZEr2tQvqCe3DzL8
	 3BR7UN+4978Zg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next,v4,05/13] octeontx2-af: npc: cn20k: Allocate default MCAM indexes
Date: Sat, 17 Jan 2026 16:40:24 -0800
Message-ID: <20260118004024.1044368-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113101658.4144610-6-rkannoth@marvell.com>
References: <20260113101658.4144610-6-rkannoth@marvell.com>
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
octeontx2-af: npc: cn20k: Allocate default MCAM indexes

This patch allocates MCAM indexes for promiscuous, multicast, broadcast,
and unicast traffic when NIX LF is attached for CN20K silicon, replacing
the previous static reservation approach.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 2d78e08f985f..df02caedc020 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c

[ ... ]

> @@ -1738,8 +1745,14 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
>  	if (attach->npalf)
>  		rvu_attach_block(rvu, pcifunc, BLKTYPE_NPA, 1, attach);
>
> -	if (attach->nixlf)
> +	if (attach->nixlf) {
>  		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
> +		if (is_cn20k(rvu->pdev)) {
> +			err = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
> +			if (err)
> +				goto exit;
                        ^^^^

When npc_cn20k_dft_rules_alloc() fails after rvu_attach_block() has
already attached the NIX LF, the error path jumps to exit without
detaching NIX. The caller (otx2_init_rsrc in otx2_pf.c) assumes that on
error nothing was attached, so it does not call otx2_detach_resources().

Could this leave NIX LF attached without proper cleanup on allocation
failure?

> +		}
> +	}
>
>  	if (attach->sso) {

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index c3f41f4ea99c..33be0bf0b481 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -2473,6 +2836,7 @@ static int npc_priv_init(struct rvu *rvu)
>  	xa_init_flags(&npc_priv.xa_sb_used, XA_FLAGS_ALLOC);
>  	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
>  	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
>  	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
> +	xa_init_flags(&npc_priv.xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
>
>  	if (npc_create_srch_order(num_subbanks)) {
>  		kfree(npc_priv.sb);
>  		return -ENOMEM;
                ^^^^

At this point npc_subbank_init() has been called for all subbanks (in
the loop at lines 2850-2851), which calls xa_store() to populate
xa_sb_free. This error path frees npc_priv.sb but does not call
xa_destroy() on the xarrays that now contain entries.

Similarly, the error path after kcalloc of xa_pf2idx_map fails (around
line 2857-2860) also skips xa_destroy() on the populated xarrays.

Could these error paths leak the xarray entries stored by
npc_subbank_init()?

>  	}

[ ... ]

