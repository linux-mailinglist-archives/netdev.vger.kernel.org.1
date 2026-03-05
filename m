Return-Path: <netdev+bounces-264272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJphAvdYqWkL6AAAu9opvQ
	(envelope-from <netdev+bounces-264272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:20:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9320F9C0
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A7330FC519
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD5372B55;
	Thu,  5 Mar 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXT9liLz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5914AD20;
	Thu,  5 Mar 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705865; cv=none; b=MpvSDG0ppwErYNFaiILiLyvPyHNmh7xqKa93LLFC2jduNTY8qFFIr8pd4UwQU1Uq/l3uCrozZuQDuZ7+BhJdu2HHuRpProw2kMTM3sUXZ4FTwp8CTN8hHsZ26B8jk1/YEufHnGibKeYVdJ/dHifrnLj9UIw3tBudt81F3pXdpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705865; c=relaxed/simple;
	bh=AjUon/x0AB0EiQNYrhxEfy7ntpWvNBlUGAPfrYJ9oWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFIpQPmta/WXSz2hNrmhF9xQDavzZq5Cd4DNUWf+6JPvhohAGOL2y9s6LAyFLZ1EigPnprPdT/LsVDd5KaEFQL4asjsNR6WP0ynrHSq+UFaaOQmNlBhtGjx9wGwZbbeKu7sTwJAyqegJa+a4IEyVvCDoS41p1JnL4/2HHzgLMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXT9liLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1334EC116C6;
	Thu,  5 Mar 2026 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772705864;
	bh=AjUon/x0AB0EiQNYrhxEfy7ntpWvNBlUGAPfrYJ9oWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXT9liLzbuFHNAAAI7gEGpoTYvPOBBh4iK9aQ4uIFqpVlB3P0e/ND6G+LrEEO/DTu
	 a/LxiuXN/lRHEAQnKf3S5w9KUYo7EPNYOTptNF7GVgNtQdKzPfH3DPyM4ptv0db4tD
	 mQSQgQ0VU1c2O9OLfiTDaJSdQilwSv41e7WOXJAX0eu2KTH5A0A8Kw0ogaORUBkscw
	 HrCk15qCgjYwz5nymAw1vulrkG98rVlKDhQrKwStyqTGmDRG2sxUAoRufpFzGJuJkj
	 8DfWjWkPcK8kNyDT1FsrguWs0IMW5HufM8hKDq/5K2HKQY5QBR/SKTRiEs7T1mt+vc
	 QLDvrUbTJrmDQ==
From: Simon Horman <horms@kernel.org>
To: ynorov@nvidia.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	linux@weissschuh.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	sbhatta@marvell.com,
	brauner@kernel.org,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	sgoutham@marvell.com,
	kuba@kernel.org,
	yajun.deng@linux.dev,
	kuniyu@google.com,
	yury.norov@gmail.com,
	jerinj@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [1/2] octeontx2-af: siplify rvu_debugfs
Date: Thu,  5 Mar 2026 10:16:41 +0000
Message-ID: <20260305101641.127065-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303185507.111841-2-ynorov@nvidia.com>
References: <20260303185507.111841-2-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54D9320F9C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,weissschuh.net,lunn.ch,redhat.com,marvell.com,vger.kernel.org,fomichev.me,linux.dev,gmail.com,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-264272-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: siplify rvu_debugfs

The driver uses bitmap_print_to_pagebuf() to store human-readable
bitmaps representations in a temporary buffers; and then feed
seq_printf() with it. Switch to using seq_printf("%*pb") directly
and drop intermediate buffer.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 413f9fa40b33..cae61c4de47f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -962,30 +962,21 @@ static bool rvu_dbg_is_valid_lf(struct rvu *rvu, int blkaddr, int lf,
>
>  static void print_npa_qsize(struct seq_file *m, struct rvu_pfvf *pfvf)
>  {
> -	char *buf;
> -
> -	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!buf)
> -		return;
> -
>  	if (!pfvf->aura_ctx) {
>  		seq_puts(m, "Aura context is not initialized\n");
>  	} else {
> -		bitmap_print_to_pagebuf(false, buf, pfvf->aura_bmap,
> -					pfvf->aura_ctx->qsize);
>  		seq_printf(m, "Aura count : %d\n", pfvf->aura_ctx->qsize);
> -		seq_printf(m, "Aura context ena/dis bitmap : %s\n", buf);
> +		seq_printf(m, "Aura context ena/dis bitmap : %*pb\n",
> +			   pfvf->aura_ctx->qsize, pfvf->aura_bmap);
>  	}
>
>  	if (!pfvf->pool_ctx) {
>  		seq_puts(m, "Pool context is not initialized\n");
>  	} else {
> -		bitmap_print_to_pagebuf(false, buf, pfvf->pool_bmap,
> -					pfvf->pool_ctx->qsize);
>  		seq_printf(m, "Pool count : %d\n", pfvf->pool_ctx->qsize);
> -		seq_printf(m, "Pool context ena/dis bitmap : %s\n", buf);
> +		seq_printf(m, "Pool context ena/dis bitmap : %*pb\n",
> +			   pfvf->aura_ctx->qsize, pfvf->aura_bmap);
                   ^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^

Does this code have a copy-paste error? The pool context output is
displaying the aura bitmap instead of the pool bitmap.

The old code correctly used pfvf->pool_bmap and pfvf->pool_ctx->qsize:

    bitmap_print_to_pagebuf(false, buf, pfvf->pool_bmap,
                            pfvf->pool_ctx->qsize);

But the new code uses pfvf->aura_bmap and pfvf->aura_ctx->qsize for
both the aura and pool context displays. This makes the pool context
debugfs output show incorrect information.

>  	}
> -	kfree(buf);
>  }

[ ... ]

