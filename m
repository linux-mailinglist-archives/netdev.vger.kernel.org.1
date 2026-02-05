Return-Path: <netdev+bounces-256917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBMpM6H/g2nYwgMAu9opvQ
	(envelope-from <netdev+bounces-256917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B0AEDF40
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F8F83004066
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2B2BDC26;
	Thu,  5 Feb 2026 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw6xA3ij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C829D267;
	Thu,  5 Feb 2026 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258327; cv=none; b=rZVV2XqgfFvMwRNECLOLZHVRzqJPidgS4sDjWhEH6JwWWoTykjGQyUYlP+T6J4Wlx6x1ak/8CL+OL/q+YFWekGts8XSjX2bpbM+F6vNsqJaYX11UTrkCiMb2QEchCDu+rA5MWPzR2YBnb9BIAkjAPFL+A22I0NoO8XH3AF8Dccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258327; c=relaxed/simple;
	bh=2XOAWPq+a+3oseEshFy3G7zv1TiFMP52u0Tn8dNxv3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMCJ6aS6DtLcdmQ6wVc4YJxZ8Z46d1eh0eZHnrfy5N51dAmiYF9EXHshifCk0rGAn0LVCIh5sj9QuLAVHLsrm9XBVOHa6gyGEOsIY7PF4UlUSZxSTscCIvCxivnuu5phI1K0YXg8+RgbiT7N8P5Rrmo32Z8tnxtg+DjhYZEqJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw6xA3ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF48C116C6;
	Thu,  5 Feb 2026 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258327;
	bh=2XOAWPq+a+3oseEshFy3G7zv1TiFMP52u0Tn8dNxv3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lw6xA3ijKCggXBHPWZ9y+q6oRKnU46Wb7ljtgsGcjWnuREnI8RUzk7+44Rz3waM/0
	 NxN+vQ7SMqk7CA4zZUHbTQyKiIauFxmpLpvhH5jR9GWAOxIhRl0A+thDmz5PeDQ5So
	 aMvQcEqvQPl0FbPVtnzc1iNM1n+cmuV+CCiCujIwvoHL2CxjCBWxKXIR/4xobUwnEJ
	 OQtYfgoPi5DDiMRcDjPL/u8gfKtxiLNP4DvgF0dIP7iWdJ09pGG1M84wvA7bMiwkt5
	 IyF+D01DI32VjFaT7Txeo1Xpylt7a4X4Boy4aJwbMm0O48VR5R4CqrrRJOkBsvOgmE
	 4S7fLzDW1rJBg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumang@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net
Subject: Re: [net-next,v8,09/13] octeontx2-af: npc: cn20k: virtual index support
Date: Wed,  4 Feb 2026 18:25:25 -0800
Message-ID: <20260205022525.2271130-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202074607.2535569-10-rkannoth@marvell.com>
References: <20260202074607.2535569-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256917-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: F3B0AEDF40
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: virtual index support

This patch adds support for virtual MCAM index allocation and improves
CN20K MCAM defragmentation handling. Virtual indexes allow the hardware
to move mapped MCAM entries internally, enabling defragmentation and
preventing scattered allocations across subbanks.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
> +{
> +	u16 old_midx;
> +	void *map;
> +	int rc;
> +

[ ... ]

> +fail3:
> +	if (xa_insert(&npc_priv.xa_idx2vidx_map, old_midx,
> +		      xa_mk_value(vidx), GFP_KERNEL))
> +		dev_err(rvu->dev,
> +			"%s: Error to roll back idx2vidx old_midx=%u vidx=%u\n",
> +			__func__, old_midx, vidx);
> +fail2:
> +	if (xa_erase(&npc_priv.xa_vidx2idx_map, vidx))
> +		dev_err(rvu->dev,
> +			"%s: Failed to roll back vidx2idx vidx=%u\n",
> +			__func__, vidx);

At fail2, xa_erase() returns the erased entry on success (non-NULL) and NULL
on failure. The error message is printed when xa_erase() succeeds, which
appears inverted from the intended behavior.

Should the condition check for NULL to detect failure instead?

> +
> +fail1:
> +	if (xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
> +		      xa_mk_value(old_midx), GFP_KERNEL))
> +		dev_err(rvu->dev,
> +			"%s: Faled to roll back vidx2idx to old_midx=%u, vidx=%u\n",
> +			__func__, old_midx, vidx);

This isn't a bug, but there's a typo: "Faled" should be "Failed".

Also, at fail1, the rollback attempts to insert into xa_vidx2idx_map to
restore old_midx. However, looking at the control flow, fail1 is reached when
xa_insert() to xa_vidx2idx_map fails. At that point, xa_vidx2idx_map has
already been erased, so the rollback target is correct.

But fail2 rolls back using xa_erase() on xa_vidx2idx_map, which was just
inserted successfully. The rollback at fail1 should restore xa_idx2vidx_map
instead, since that's the only map modified when fail1 is reached via direct
return.

Could the error path rollback logic be reviewed?

> +
> +	return rc;
> +}

[ ... ]

> +static int npc_vidx_maps_del_entry(struct rvu *rvu, u16 vidx, u16 *old_midx)
> +{
> +	u16 mcam_idx;
> +	void *map;
> +
> +	if (!npc_is_vidx(vidx)) {
> +		dev_err(rvu->dev,
> +			"%s: vidx(%u) does not map to proper mcam idx\n",
> +			__func__, vidx);

The format string says "mcam idx" but the code passes vidx. Should this
say "vidx" for consistency?

[ ... ]

> +static
> +int npc_defrag_move_vdx_to_free(struct rvu *rvu,
> +				struct npc_defrag_node *f,
> +				struct npc_defrag_node *v,
> +				int cnt, u16 *save)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;

[ ... ]

> +		/* Remove from mcam maps */
> +		mcam->entry2pfvf_map[old_midx] = NPC_MCAM_INVALID_MAP;
> +		mcam->entry2cntr_map[old_midx] = NPC_MCAM_INVALID_MAP;
> +		npc_mcam_clear_bit(mcam, old_midx);
> +
> +		mcam->entry2pfvf_map[new_midx] = pcifunc;
> +		mcam->entry2cntr_map[new_midx] = new_midx;

Should entry2cntr_map[new_midx] be assigned the counter index from the
old entry rather than new_midx? The entry2cntr_map is used to track which
counter is mapped to an entry, and during defragmentation the counter
association should be preserved from entry2cntr_map[old_midx].

[ ... ]

> @@ -2214,14 +2444,15 @@ static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
> 			bool maps_del)
>  {
>  	struct npc_subbank *sb;
> -	int idx, i;
> +	u16 vidx, midx;
> +	int sb_off, i;
>  	bool ret;
>  	int rc;
>
>  	/* Check if we can dealloc indexes properly ? */
>  	for (i = 0; i < count; i++) {
>  		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
> -						 &sb, &idx);
> +						 &sb, &sb_off);
>  		if (rc) {
>  			dev_err(rvu->dev,
>  				"Failed to free mcam idx=%u\n", mcam_idx[i]);

The first validation loop passes mcam_idx[i] directly to
npc_mcam_idx_2_subbank_idx() without converting virtual indexes first.
Virtual indexes are defined as vidx >= bank_depth * 2, but
npc_mcam_idx_2_subbank_idx() returns -EINVAL for any index >= bank_depth * 2:

npc_mcam_idx_2_key_type():
    if (mcam_idx >= npc_priv.bank_depth * 2) {
        dev_err(rvu->dev, "%s: bad params\n", __func__);
        return -EINVAL;
    }

This means all virtual index free operations will fail at the first validation
loop, even though the second loop has correct vidx handling code.

Should the first validation loop convert virtual indexes using
npc_cn20k_vidx2idx() before calling npc_mcam_idx_2_subbank_idx()?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c

[ ... ]

> +static int rvu_af_npc_defrag(struct devlink *devlink, u32 id,
> +			     struct devlink_param_gset_ctx *ctx,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
> +	struct rvu *rvu = rvu_dl->rvu;
> +
> +	npc_cn20k_defrag(rvu);
> +
> +	return 0;
> +}

The return value of npc_cn20k_defrag() is discarded. npc_cn20k_defrag() can
fail with -ENOMEM when kcalloc() fails for node or vidx arrays, or with errors
propagated from npc_defrag_process().

Should this be "return npc_cn20k_defrag(rvu);" instead?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -3256,7 +3266,7 @@
>  	/* If shift has failed then report the failed index */
>  	if (index != req->shift_count) {
>  		rc = NPC_MCAM_PERM_DENIED;
> -		rsp->failed_entry_idx = index;
> +		rsp->failed_entry_idx = npc_cn20k_idx2vidx(index);
>  	}

The variable "index" here is a loop counter (0 to shift_count-1), not an MCAM
entry index. The failed_entry_idx field indicates which position in the request
arrays failed.

Should this remain as "rsp->failed_entry_idx = index;" without the conversion?

