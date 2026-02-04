Return-Path: <netdev+bounces-256775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMyYE+96g2nyngMAu9opvQ
	(envelope-from <netdev+bounces-256775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:59:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F35EAAC1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C38CF3023004
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809A341657;
	Wed,  4 Feb 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/CWkuKD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509134107A;
	Wed,  4 Feb 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224271; cv=none; b=GQl450Iu3bQ1vMQtgUHN/FvWuu1Rd0cLbW1EicpiwjBQq6R38Mkpus+ZenByQHhY0YzeMSATPDPx63Q5+p1v+I2Hg/gzipxDmgoT8zurTLxeaGnmB+Zw8CEnEND+OLY8EQJ4NmRHMdIGaIx9TikHmb+lyKlUOvCFlJ3fL2Tj6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224271; c=relaxed/simple;
	bh=HlMlVnTgmkL7tsK9Wwfic2VfIH66MBM/lH/WwbwuTZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFPzgCkLYNs+Fsnh9zVAqoXv1wKblGSJDHo8jSAky66tvRgFaQhklk6mhd3ndnrvXbeyssPdxGkyXL0ht1wslUWiWUolQ1zTXO7PGtir3IrEFFRCFT7sBJLw/LzIAKGrQ4APj8TjFWz0pB8idA0LbGTVqtdlORNJNq0Nv05rwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/CWkuKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A39DC19425;
	Wed,  4 Feb 2026 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224270;
	bh=HlMlVnTgmkL7tsK9Wwfic2VfIH66MBM/lH/WwbwuTZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/CWkuKDjl0ikFJVKXNmZvvbFK/4Bzk5LnxCWEiyz0IZ4sNfkFp+PId1EsiZMDdQl
	 qtdTQzsO+r91SPgig0Gk0cWaDfud4EOJtqnOX22WQND7+LHExMMOScdN9V9VETjXv+
	 ftzXkMffEcxKBGzZpzS01mVQ0UXYTtXCVa2Qipiy6hdNACSo8P8LqB6OhHCap9y44u
	 xJ6jrBPTSDneS4KpwMGHcMPPzuAzYem9ZqZQ/v5CuiGDL3g1dH4DUHqQzIEDBAKO8l
	 7trosr0WaIvdOKW5MtLpEB6DWJROrsQQkdwl3FhlNmQsOaLTNJVWgVDhihj3BLSlNF
	 9sIMQyhKx0Z7A==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	sumang@marvell.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	sbhatta@marvell.com,
	sgoutham@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v8,01/13] octeontx2-af: npc: cn20k: Index management
Date: Wed,  4 Feb 2026 16:57:39 +0000
Message-ID: <20260204165740.2184444-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202074607.2535569-2-rkannoth@marvell.com>
References: <20260202074607.2535569-2-rkannoth@marvell.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-256775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url,npc_priv.sb:url]
X-Rspamd-Queue-Id: E4F35EAAC1
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Index management

This patch adds MCAM index allocation and management for CN20K silicon.
The implementation supports contiguous and non-contiguous allocation
schemes with reference, limit, and priority parameters.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> new file mode 100644
> index 000000000000..eb1f54d2bfce
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h

[ ... ]

> + * MCAM resource is divided horizontally into mutltiple subbanks and

This isn't a bug, but "mutltiple" should be "multiple".

[ ... ]

> + * @xa_pf2idx_map:	PF to mcam index map.
> + * @xa_idx2pf_map:	Mcam index to PF map.
> + * @xa_pf_map:		Pcifunc to index map.
> + * @pf_cnt:		Number of PFs.A

This isn't a bug, but there's a spurious trailing 'A' after "PFs." in
the kernel-doc comment.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> new file mode 100644
> index 000000000000..9b5da2665b54
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
> +			    int prio, u16 *mcam_idx, int ref, int limit,
> +			    bool contig, int count)
> +{

[ ... ]

> +add2map:
> +	for (i = 0; i < count; i++) {
> +		rc = npc_add_to_pf_maps(rvu, mcam_idx[i], pcifunc);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}

If npc_add_to_pf_maps() fails partway through the loop (when i > 0), does
this leak the MCAM indexes that were previously allocated?

The allocators (npc_subbank_ref_alloc, npc_subbank_noref_alloc,
npc_multi_subbank_ref_alloc) have already claimed the MCAM entries before
reaching add2map. When the loop fails at iteration i, the function returns
rc without freeing the allocated MCAM indexes or removing the map entries
that were successfully added in iterations 0 through i-1.

[ ... ]

> +static int
> +npc_priv_init(struct rvu *rvu)
> +{

[ ... ]

> +	if (num_subbanks & (num_subbanks - 1)) {
> +		dev_err(rvu->dev,
> +			"subbanks cnt(%u) should be a multiple of 2\n",
> +			num_subbanks);
> +		return -EINVAL;
> +	}

The error message says "multiple of 2" but the check
(num_subbanks & (num_subbanks - 1)) tests for power of 2. For example,
6 is a multiple of 2 but not a power of 2. Should the message say
"power of 2" instead?

[ ... ]

> +	npc_priv.xa_pf2idx_map = kcalloc(npc_priv.pf_cnt,
> +					 sizeof(struct xarray),
> +					 GFP_KERNEL);
> +	if (!npc_priv.xa_pf2idx_map)
> +		goto fail2;

[ ... ]

> +fail2:
> +	kfree(subbank_srch_order);
> +
> +fail1:
> +	xa_destroy(&npc_priv.xa_sb_used);
> +	xa_destroy(&npc_priv.xa_sb_free);
> +	xa_destroy(&npc_priv.xa_idx2pf_map);
> +	xa_destroy(&npc_priv.xa_pf_map);
> +	kfree(npc_priv.sb);
> +	return -ENOMEM;
> +}
> +
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
> +	/* No need to destroy mutex lock as it is
> +	 * part of subbank structure
> +	 */
> +	kfree(npc_priv.sb);
> +	kfree(subbank_srch_order);
> +}

Can npc_cn20k_deinit() be called when npc_priv_init() fails at fail2?

When kcalloc for xa_pf2idx_map fails, fail2 frees subbank_srch_order
and npc_priv.sb. Then rvu_npc_freemem() calls npc_cn20k_deinit() which:

1. Iterates over npc_priv.xa_pf2idx_map[i] when xa_pf2idx_map is NULL
2. Calls kfree() on already-freed npc_priv.sb and subbank_srch_order

Should npc_cn20k_deinit() check npc_priv.init_done before cleanup, or
should fail2 set the freed pointers to NULL?

