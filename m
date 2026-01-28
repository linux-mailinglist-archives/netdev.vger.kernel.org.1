Return-Path: <netdev+bounces-254077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKV5Fix1eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:32:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB219C491
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9E3F304D257
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416502BDC0B;
	Wed, 28 Jan 2026 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouBYWQEN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97D2BD5B4;
	Wed, 28 Jan 2026 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567374; cv=none; b=REgU8/ga3yRSpAe9HXcYMlWUTTpqrRG5T/PBQxzinpE0RAF0CtLnMF5vF6H9qX5MyB9d8y2+mesTF6X4iJaQyt26LAbMxHHvGjwhe4LwGyrxk/Si153mt3OUXC/kWTLjZGAS8CqokFfI+QYy+XqPSm4ndj3kK6g/4TsG14vK/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567374; c=relaxed/simple;
	bh=S2CcuGWCCyTnBoIT1fg9E5ORgW2+IZwQle6xt3mhhtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwpEjnuh9wahzFn6CUGmQXkCrGMhRnA6WSqC7SDXtAf5eMnz6tzBj0jAMmh1v80WdAKKwS5xtALID/rTDTDGkCy4JR0FSM9uuz0B3CLaiJw8e9Z673VpcLm9J02IZBZHCTvou6JH2NfkwiZ5+tO9JjFg2OzFFhus7i9WiEYUxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouBYWQEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464DDC19425;
	Wed, 28 Jan 2026 02:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567369;
	bh=S2CcuGWCCyTnBoIT1fg9E5ORgW2+IZwQle6xt3mhhtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouBYWQENFMa8aZDbnI+GGXfiza18EcXdYqqRL4Yuc8mRo3Xs62H8L8sPmGOpk7a4e
	 XX5QTDFmJCqYA2MOOuiEktK4NnUCZj4GXgOQ6nsxRSu7lf2cZi156IE2zQWRy8epL8
	 SGXQwri4xR7ofQS3GwtWynSjBViqQM2Sm1e9Pbl4spCD2KfSAF8cg9n06ViFZc3XzC
	 OiduYuLJwc5XFZdptkb0QSAMGJFRsJO6aqavHNenmASVkuX+7sBXbpHhVwu0zW+2bL
	 vwY00Y5VtThblSu6Tyu0Sl4zYXtY4xfiqV5xD8fd2d+SvTFd0aDFlGg5p1RfQJnMyn
	 AgEp4foChiOPw==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sbhatta@marvell.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	sumang@marvell.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v5,09/13] octeontx2-af: npc: cn20k: virtual index support
Date: Tue, 27 Jan 2026 18:29:28 -0800
Message-ID: <20260128022928.4153136-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126123254.1000480-10-rkannoth@marvell.com>
References: <20260126123254.1000480-10-rkannoth@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254077-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 8DB219C491
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: virtual index support

This patch adds support for virtual MCAM index allocation and improves
CN20K MCAM defragmentation handling.  Virtual indexes allow the hardware
to move mapped MCAM entries internally, enabling defragmentation.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 8b77ac053d8d..d1a927f3d5db 100644
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
> +		return rc;
> +	}
> +
> +	map = xa_erase(&npc_priv.xa_idx2vidx_map, old_midx);
> +	if (!map) {
> +		dev_err(rvu->dev,
> +			"%s: old_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
> +			__func__, old_midx, vidx);
> +		return -ESRCH;

If this error path is taken, xa_vidx2idx_map now has vidx pointing to
new_midx, but xa_idx2vidx_map still has old_midx pointing back to vidx.
The bidirectional mapping becomes inconsistent.  Can this leave the maps
in a corrupted state?

> +	}
> +
> +	rc = xa_insert(&npc_priv.xa_idx2vidx_map, new_midx,
> +		       xa_mk_value(vidx), GFP_KERNEL);
> +	if (rc) {
> +		dev_err(rvu->dev,
> +			"%s: new_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
> +			__func__, new_midx, vidx);
> +		return rc;

Similarly here, if xa_insert fails (e.g., memory pressure), the maps are
left inconsistent: xa_vidx2idx_map has vidx -> new_midx but xa_idx2vidx_map
has neither old_midx nor new_midx pointing to vidx.  Subsequent lookups
via npc_idx2vidx() for new_midx would fail to find the correct vidx.
Should these error paths restore the previous map state?

> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int npc_defrag_process(struct rvu *rvu, struct list_head *lh)
> +{

[ ... ]

> +err:
> +	/* TODO: how to go back to old state ? */
> +	return rc;
> +}

The TODO comment here suggests awareness that error recovery is incomplete.
Given that npc_defrag_move_vdx_to_free() calls npc_vidx_maps_modify() which
can fail mid-operation, should the defragmentation be made atomic or have
proper rollback?

