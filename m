Return-Path: <netdev+bounces-256915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G2hI5b/g2nYwgMAu9opvQ
	(envelope-from <netdev+bounces-256915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09525EDF31
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACAF53011076
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9608929C347;
	Thu,  5 Feb 2026 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bitcb48v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73312291C07;
	Thu,  5 Feb 2026 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258323; cv=none; b=QZnemtd3SOJU/3M5znHhuvWnPvZknfnWqKg4WXhqnpSVqdp+W88BrQ4b50hV2dAzsL5UJIDyGRTj3yErob0QzNBaLCspQw8MhftzY6oM4le7XA0MvP4yJGuOZ1xOyoUqmP3ihBFV7uqUtP1kqQksicTnscdBiLAFfZUnxJHoO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258323; c=relaxed/simple;
	bh=YfpZzt5pg0ogeopDHlH3eK8V5Q8USdP8y8QpWHC1PFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSuo/Q1lZa6veXkzjWmMVW3/2I1PB7fY0+Y0itW2v/7oSckopj4jFSbATbfF/Yn2DUX78KBKwbcIrtJ1H1cXflAWwtkeSpbTSSbQfHBAIVaOs3UJ67P64EKw5n6ZtUEuoPTHuDHbjluCgMHaJ2U+U3lfhArbazjqnVXvCZY2BQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bitcb48v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6B6C116C6;
	Thu,  5 Feb 2026 02:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258323;
	bh=YfpZzt5pg0ogeopDHlH3eK8V5Q8USdP8y8QpWHC1PFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bitcb48vyxtyATw7ODWd85geoJ8MEwqenWYicjQFhJmErNm1uTdGVQE+jk4yF9Twn
	 TgptkIEoPk3hEczrZu6KLpU2LBK0CoKmvuNrTQi5/pPW39K3p4nDwPjl4H94Swl1om
	 7/XORjwL2ClVWeHpIzt6m2JuYsG1gQXETCm0UJzVFDk6tufJEWoo8rzNyvrAKUxv1v
	 ntfib8c1z1Cw0Nk6Gs9Zwv+ZufFlojXcfr39esykmf1n1D2vtPt4eUyc03IeVynEQv
	 7qux/PypThvNXi3toNarPlKar8Wpyw1ACBk11eRXSoTck7KAzyU1CX+09K7rzvyH7c
	 hES/+Mk30ovUA==
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
Subject: Re: [net-next,v8,02/13] octeontx2-af: npc: cn20k: KPM profile changes
Date: Wed,  4 Feb 2026 18:25:11 -0800
Message-ID: <20260205022511.2270287-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202074607.2535569-3-rkannoth@marvell.com>
References: <20260202074607.2535569-3-rkannoth@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256915-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09525EDF31
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: KPM profile changes

This patch adds support for the new KPM (Kangaroo Processing Module) profile
configuration in CN20K silicon. It groups 16 KPUs into 8 KPM profiles, where
each KPM contains two KPUs (KPM0 = KPU0 + KPU8, etc.).

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static void
> +npc_config_kpmaction(struct rvu *rvu, int blkaddr,
> +		     const struct npc_kpu_profile_action *kpuaction,
> +		     int kpm, int entry, bool pkind)
> +{
> +	struct npc_kpm_action0 action0 = {0};
> +	struct npc_kpu_action1 action1 = {0};

[ ... ]

> +	action0.capture_ltype = kpuaction->ltype & 0xf;
> +	action0.capture_flags = kpuaction->flags & 0xf;
> +	action0.ptr_advance = kpuaction->ptr_advance;

The npc_kpm_action0 structure defines capture_flags as a 4-bit field, while
kpuaction->flags is a u8 (8 bits). KPU profiles use flag values such as
NPC_F_LA_U_HAS_IH_NIX (0x20), NPC_F_LA_U_HAS_HIGIG2 (0x40), and
NPC_F_LB_U_UNK_ETYPE (0x80), which exceed what 4 bits can represent.

Is this truncation intentional for the CN20K hardware register layout? If
so, will the parser functionality work correctly when these upper flag bits
are silently discarded?

This was raised by Jakub Kicinski in v6 review:
https://lore.kernel.org/all/20260129051303.376551-1-kuba@kernel.org/

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -1982,6 +1990,15 @@ static void rvu_npc_hw_init(struct rvu *rvu, int blkaddr)
>  	hw->npc_pkinds = (npc_const1 >> 12) & 0xFFULL;
>  	hw->npc_kpu_entries = npc_const1 & 0xFFFULL;
>  	hw->npc_kpus = (npc_const >> 8) & 0x1FULL;
> +	/* For Cn20k silicon, check if enhanced parser
> +	 * is present, then set the NUM_KPMS = NUM_KPUS / 2 and
> +	 * number of LDATA extractors per KEX.
> +	 */
> +	if (is_cn20k(rvu->pdev) && (npc_const1 & BIT_ULL(62))) {
> +		hw->npc_kpms = hw->npc_kpus / 2;
> +		hw->npc_kex_extr = (npc_const1 >> 36) & 0x3FULL;
> +	}

[ ... ]

> @@ -2116,7 +2133,10 @@ int rvu_npc_init(struct rvu *rvu)
>  		return -ENOMEM;
>
>  	/* Configure KPU profile */
> -	npc_parser_profile_init(rvu, blkaddr);
> +	if (is_cn20k(rvu->pdev))
> +		npc_cn20k_parser_profile_init(rvu, blkaddr);
> +	else
> +		npc_parser_profile_init(rvu, blkaddr);

In rvu_npc_hw_init(), hw->npc_kpms is set only when both is_cn20k() returns
true AND bit 62 is set in npc_const1:

    if (is_cn20k(rvu->pdev) && (npc_const1 & BIT_ULL(62))) {
        hw->npc_kpms = hw->npc_kpus / 2;

However, rvu_npc_init() calls npc_cn20k_parser_profile_init() based solely
on is_cn20k(), without checking for enhanced parser support.

If CN20K hardware exists without enhanced parser support (bit 62 not set),
npc_kpms will be 0. The npc_cn20k_parser_profile_init() function would then:

    for (idx = 0; idx < hw->npc_kpms; idx++)  /* loops 0 times */
        ...disable KPM entries...

    for (idx = 0; idx < hw->npc_kpus; idx++)
        rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx), 0x00);  /* disables all KPUs */

    npc_program_kpm_profile(rvu, blkaddr, hw->npc_kpms);  /* loops 0 times, never re-enables KPUs */

Should the condition at line 2136 match the condition at line 1997 to
ensure KPUs are not left disabled when enhanced parser support is absent?
-- 
pw-bot: cr

