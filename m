Return-Path: <netdev+bounces-255336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OiyJSh4fWknSQIAu9opvQ
	(envelope-from <netdev+bounces-255336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:34:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB8C08A4
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08EF302AE2C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858D34F484;
	Sat, 31 Jan 2026 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6+PxyGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E734F46B;
	Sat, 31 Jan 2026 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830403; cv=none; b=NdGri7ar9In5VcK0Vre93ir0d5dThAXrYp52wEfdRsj5touSDjCdj+StGvnEDVnAtz6teTYpFVAvG+GUkPRGx6m/3Hv/gNC6dyTrmrTmTniZRFYo2G3jDjQAkim/b8etmjHxnI7nkNktf8ts/AKTSTHGx2DWMidBOyJvvpO1dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830403; c=relaxed/simple;
	bh=satQpSg5lfw1nu+Y/PHYoQPj7q1pdNcnzeuTKNpFxQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyN5gMlxXvkwdQp5VBzvOS5E/sXH0RgC628eSqCTz90W2uO1XIdmYcHD5ga6bSGOL6LfAavOcDnQEq19XwlvuW2V0yNzWn8YXa6WZuD/FexCX7q6Lh8jI7h9O0tHLi9krgkl/gGFwAbcXOUcIBMVwkLR7F6vSARxbKSNypIC9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6+PxyGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FE9C4CEF1;
	Sat, 31 Jan 2026 03:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769830403;
	bh=satQpSg5lfw1nu+Y/PHYoQPj7q1pdNcnzeuTKNpFxQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6+PxyGieUMHXrqr3LS8F3ISEfEYEEbVf8QJULmmix1UebXitMmZYfKE82DUGXQ8g
	 bTZ5SxNnIfgYJ8iamdhO/Rb8GTkG3oewiGt/bTtZiiU3mSEZainSSRBmC5/1jFJxP7
	 uLO5PhlNJyYnRkCuQ9aYPcNokn3eT0Y/SqQzRQI4DcHPhJLRBWAlvI5n2qVGK7DUQM
	 OkzAuWGpTJywTD8nksfOrCCQ8IJ2ZkRe+f5mtteGBfwojJbMAMaYFlH+jNbumr8uY8
	 e2C1nI/CtfQ0moVsJED0Y3gv/ekdrFDk0jNH+TEhcKqs15177xEDQa60JOhTkF0s2L
	 1ra45407PBPhg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v7,09/13] octeontx2-af: npc: cn20k: virtual index support
Date: Fri, 30 Jan 2026 19:33:22 -0800
Message-ID: <20260131033322.1013834-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129083339.264386-10-rkannoth@marvell.com>
References: <20260129083339.264386-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255336-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20CB8C08A4
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: virtual index support

This patch adds support for virtual MCAM index allocation and improves
CN20K MCAM defragmentation handling. Virtual indexes allow the hardware
to move mapped MCAM entries internally, enabling defragmentation.

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
> +	if (!npc_is_vidx(vidx)) {
> +		dev_err(rvu->dev,
> +			"%s: vidx(%u) does not map to proper mcam idx\n",
> +			__func__, vidx);
> +		return -ESRCH;
> +	}
> +
> +	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
> +	if (!map) {
> +		dev_err(rvu->dev,
> +			"%s: vidx(%u) could not be deleted from vidx2idx map\n",
> +			__func__, vidx);
> +		return -ESRCH;
> +	}
> +
> +	old_midx = xa_to_value(map);
> +
> +	rc = xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
> +		       xa_mk_value(new_midx), GFP_KERNEL);
> +	if (rc) {
> +		dev_err(rvu->dev,
> +			"%s: vidx(%u) cannot be added to vidx2idx map\n",
> +			__func__, vidx);
> +		goto fail1;
> +	}

[ ... ]

> +fail1:
> +	if (xa_insert(&npc_priv.xa_idx2vidx_map, old_midx,
> +		      xa_mk_value(vidx), GFP_KERNEL))
> +		dev_err(rvu->dev,
> +			"%s: Faled to roll back vidx2idx to old_midx=%u, vidx=%u\n",
> +			__func__, old_midx, vidx);
> +
> +	return rc;
> +}

When we jump to fail1, it's because the xa_insert() into xa_vidx2idx_map
failed (around line 352). At that point, xa_idx2vidx_map hasn't been touched
yet - only xa_vidx2idx_map had the vidx erased. The rollback here tries to
insert into xa_idx2vidx_map, but shouldn't this restore vidx -> old_midx
in xa_vidx2idx_map instead? This appears to be operating on the wrong xarray
and would leave the mapping inconsistent on error.

This was also raised in lore review feedback:
https://lore.kernel.org/all/20260129051307.376632-1-kuba@kernel.org/

[ ... ]

> +static
> +int npc_defrag_move_vdx_to_free(struct rvu *rvu,
> +				struct npc_defrag_node *f,
> +				struct npc_defrag_node *v,
> +				int cnt, u16 *save)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;

[ ... ]

> +		/* save pcifunc */
> +		map = xa_load(&npc_priv.xa_idx2pf_map, old_midx);
> +		pcifunc = xa_to_value(map);

[ ... ]

> +		/* Remove from mcam maps */
> +		mcam->entry2pfvf_map[old_midx] = NPC_MCAM_INVALID_MAP;
> +		mcam->entry2cntr_map[old_midx] = NPC_MCAM_INVALID_MAP;
> +		npc_mcam_clear_bit(mcam, old_midx);
> +
> +		mcam->entry2pfvf_map[new_midx] = pcifunc;
> +		mcam->entry2cntr_map[new_midx] = pcifunc;
                                            ^^^^^^^

Should entry2cntr_map[new_midx] be set to pcifunc here? Looking at all other
usages in the codebase, entry2cntr_map holds either NPC_MCAM_INVALID_MAP or
a counter index (set via npc_map_mcam_entry_and_cntr()). Setting it to pcifunc
appears to be a semantic type error since pcifunc is a PF/VF identifier, not
a counter index.

Later code in rvu_mbox_handler_npc_mcam_free_entry() retrieves this value and
uses it as a counter index:

    cntr = mcam->entry2cntr_map[req->entry];
    if (cntr != NPC_MCAM_INVALID_MAP)
        npc_unmap_mcam_entry_and_cntr(rvu, mcam, blkaddr, req->entry, cntr);

If the old entry had a counter mapped, that counter reference would be lost
during defragmentation, and if the pcifunc value happens to look like a valid
counter index, it would corrupt counter reference counts.

> +		npc_mcam_set_bit(mcam, new_midx);

[ ... ]

