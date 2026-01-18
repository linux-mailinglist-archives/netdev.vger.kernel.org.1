Return-Path: <netdev+bounces-250765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A65DBD391EE
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11D73009840
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755AD1A23B1;
	Sun, 18 Jan 2026 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeSrE5WA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BE500972;
	Sun, 18 Jan 2026 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696820; cv=none; b=E519jQgxo+8xZmg7GlcSuaP3aejV5e3TMbWHI4wLrtQwyD//G8yb0C97L5fD7NottfJLnhzc/uEnQjKaQ8pg0qq8TBbC6rX8szNcpEXVV5+9OGpeqCZV7Iu14mEWf0xHz3oRqHTSk0z8F2O5j2MjRSiJvW/3mQiMOfExMqf+aE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696820; c=relaxed/simple;
	bh=CLXDgTdFKwraHgOpcsuMTZNcCbq9T8OGDv6lP4Y0Lk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fyyh1a7+pJpeM94isvMsen4NKDrNUQA/WAodBCJw8CrjO2i8gdpAa4ovRVRp1zfsLNQQVA1q2IrLZmAongujjdMSNwEla36S8YbD93OcuPzoaHr5pnGX83Rhk0PlcGzWBpYwAy4J8c/xkk0bahJI5wMPk0a+CbC6nS5Dn48dvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeSrE5WA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C288FC4CEF7;
	Sun, 18 Jan 2026 00:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696820;
	bh=CLXDgTdFKwraHgOpcsuMTZNcCbq9T8OGDv6lP4Y0Lk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeSrE5WAMkpsFyN+MCJXmXkw1wmM4wjoxNmjntiFHEaaeq97yE4uy87n+aljWMRRP
	 1LFK9kR2MgYGEu0ZiazUBadKwA6iaasmng/V4Y125kTWpZob/MJJiXLle+LAaHLAMQ
	 wJF+GZRHmhOMqdONbIHm/WTNNqeHqFbE/4Wt/+bCOmIi3zH09Eqrtvc+FFYOFWq7Rg
	 6/eMDPXyKZzswGSJl+bBGi0il2dnO2oXxrkkgAu0GNUse7Mf3xMURgyKn3fQ38pQL7
	 +KJaJmxY+euzJ31H9CPHE7H7cktmj4HkcqCb8Vl4ZThyBLqJ4C6ljvfhcijhXcfexp
	 5HoYzpmKabDBA==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next,v4,01/13] octeontx2-af: npc: cn20k: Index management
Date: Sat, 17 Jan 2026 16:40:17 -0800
Message-ID: <20260118004017.1044291-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113101658.4144610-2-rkannoth@marvell.com>
References: <20260113101658.4144610-2-rkannoth@marvell.com>
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
octeontx2-af: npc: cn20k: Index management

This patch adds MCAM index management for CN20K silicon, implementing
contiguous and non-contiguous allocation schemes with reference, limit,
and priority parameters across the new subbank architecture.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> new file mode 100644
> index 000000000000..ebccc780ab8e
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
> +			bool maps_del)
> +{
> +	struct npc_subbank *sb;
> +	int idx, i;
> +	bool ret;
> +	int rc;
> +
> +	for (i = 0; i < count; i++) {
> +		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
> +						 &sb, &idx);
> +		if (rc)
> +			return rc;
> +
> +		ret = npc_subbank_free(rvu, sb, idx);
> +		if (ret)
> +			return -EINVAL;

If an error occurs partway through this loop, for example when freeing
entry i out of count entries, entries from i+1 to count-1 remain allocated
but are never freed. Could this leak MCAM slots when npc_idx_free() is
called from error paths in npc_multi_subbank_ref_alloc() or
npc_subbank_noref_alloc()?

> +
> +		if (!maps_del)
> +			continue;
> +
> +		rc = npc_del_from_pf_maps(rvu, mcam_idx[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int npc_priv_init(struct rvu *rvu)
> +{

[ ... ]

> +	npc_priv.sb = kcalloc(num_subbanks, sizeof(struct npc_subbank),
> +			      GFP_KERNEL);
> +	if (!npc_priv.sb)
> +		return -ENOMEM;
> +
> +	xa_init_flags(&npc_priv.xa_sb_used, XA_FLAGS_ALLOC);
> +	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
> +	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
> +	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
> +
> +	if (npc_create_srch_order(num_subbanks)) {
> +		kfree(npc_priv.sb);
> +		return -ENOMEM;
> +	}

The four xarrays initialized above are not destroyed before returning
here. Should xa_destroy() be called for xa_sb_used, xa_sb_free,
xa_idx2pf_map, and xa_pf_map on this error path?

[ ... ]

> +	npc_priv.xa_pf2idx_map = kcalloc(npc_priv.pf_cnt,
> +					 sizeof(struct xarray),
> +					 GFP_KERNEL);
> +	if (!npc_priv.xa_pf2idx_map) {
> +		kfree(subbank_srch_order);
> +		kfree(npc_priv.sb);
> +		return -ENOMEM;
> +	}

Same question here - the four xarrays are still not destroyed on this
error path.

> +
> +	for (i = 0; i < npc_priv.pf_cnt; i++)
> +		xa_init_flags(&npc_priv.xa_pf2idx_map[i], XA_FLAGS_ALLOC);
> +
> +	return 0;
> +}
-- 
pw-bot: cr

