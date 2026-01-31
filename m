Return-Path: <netdev+bounces-255335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2fViKAV4fWknSQIAu9opvQ
	(envelope-from <netdev+bounces-255335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:33:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7670C0886
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DAF9300DDD0
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32134D923;
	Sat, 31 Jan 2026 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC3ZSbNA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823C241CB7;
	Sat, 31 Jan 2026 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830402; cv=none; b=cDjL/RPHQB9b449uviKSJmN6ov1jpSKDe5k49SULi42B3nDabfanDga28FG/Me/sBenpLNzNnKr4kYA/prasy43UVXd2sKNSjbZWBZ/ycDrGIkgLAp/OgtP+sjxO5AFuVvBeZxekwSOh9e9YbpBIu2G/Z/hAJAQdAnuXzJZJkoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830402; c=relaxed/simple;
	bh=YGnGv8L+mEeAGVkTCNcg2HwdA4oRWh26LMl2uNwPWAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5AUP86QRlxbRunQ9yONOzjWFYUz2bIm0Bg3zu21DZUbyfKax9HXO7datdvxtUuRQX6UDxednqx3n9FyEC6Vmg2fRpCK0ZiZ9/ACemAo7WD4TM5JGZ/nb4Cz4bNajiev/KbaI8cJ17tQ8+YugquxEHLvSYfT4bSG50XytimlXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC3ZSbNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B7EC4CEF1;
	Sat, 31 Jan 2026 03:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769830402;
	bh=YGnGv8L+mEeAGVkTCNcg2HwdA4oRWh26LMl2uNwPWAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NC3ZSbNA9z7QmLIxwohozV1gq+meS4RzCeLalP8c60wE4dZpKSSF+7t8OmYhXQsQ4
	 XNjtawnj19JonkMGgye6hzzW5TvH7b3Hf5+/hWZUwcdhrthm1Dfo7HptHv1IrEEr4X
	 fezxDLHlbmjTCTzl9jv/Nrz3kIr9ht9rX8NcfcddiGlm9DNV8xT/htguTho3zvmqUW
	 VVF4d8xPb9yJwI7Vtb0be1R1tWZiHohugHf30j7ZiFwUBe9zh86F2xYHr7Oh2Bbxvr
	 NcoYTLnNtHZN4xLME1Hsd/HGygMkop8/eq8npnXkCSrO08x+oCopyMZizWpVRAk+tN
	 SZQIXjbnpXx8A==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v7,01/13] octeontx2-af: npc: cn20k: Index management
Date: Fri, 30 Jan 2026 19:33:20 -0800
Message-ID: <20260131033320.1013816-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129083339.264386-2-rkannoth@marvell.com>
References: <20260129083339.264386-2-rkannoth@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-255335-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,npc_priv.sb:url]
X-Rspamd-Queue-Id: E7670C0886
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Index management

This patch adds MCAM index management for CN20K silicon, implementing
contiguous and non-contiguous allocation schemes across the new subbank
architecture with reference, limit, and priority parameters.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> new file mode 100644
> index 000000000000..de3d5ad762d1
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
> +			       int key_type, int ref, int limit, int prio,
> +			       bool contig, int count, u16 *mcam_idx,
> +			       int idx_sz, bool max_alloc, int *alloc_cnt)
> +{
> +	int cnt, t, b, i, blkaddr;
> +	bool new_sub_bank = false;
> +	unsigned long *bmap;
> +	u16 *save = NULL;
> +	int sidx, eidx;
> +	bool diffbank;
> +	int bw, bfree;
> +	int rc = 0;
> +	bool ret;

[ ... ]

> +	/* Mark new subbank bank as used */
> +	if (new_sub_bank) {
> +		blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +		if (blkaddr < 0) {
> +			dev_err(rvu->dev,
> +				"%s: NPC block not implemented\n", __func__);
> +			goto err;
                        ^^^^^^^^

When rvu_get_blkaddr() fails here, the code jumps to the err label but rc
is still 0 from initialization. Every other error path in this function
sets rc before going to err. Should rc be set to blkaddr (or another error
code) before the goto?

> +		}
> +
> +		rc =  __npc_subbank_mark_used(rvu, sb, key_type);

[ ... ]

> +err:
> +	kfree(save);
> +	return rc;
> +}

[ ... ]

> +static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
> +{
> +	mutex_init(&sb->lock);

[ ... ]

> +void npc_cn20k_deinit(struct rvu *rvu)
> +{
> +	int i;
> +
> +	xa_destroy(&npc_priv.xa_sb_used);
> +	xa_destroy(&npc_priv.xa_sb_free);
> +	xa_destroy(&npc_priv.xa_idx2pf_map);
> +	xa_destroy(&npc_priv.xa_pf_map);
> +
> +	for (i = 0; i < npc_priv.pf_cnt; i++)
> +		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
> +
> +	kfree(npc_priv.xa_pf2idx_map);
> +	kfree(npc_priv.sb);

The subbank mutexes are initialized in npc_subbank_init() but are not
destroyed here. Is mutex_destroy() needed for each sb->lock before freeing
npc_priv.sb? The same issue applies to the fail2 error path in
npc_priv_init().

> +	kfree(subbank_srch_order);
> +}
-- 
pw-bot: cr

