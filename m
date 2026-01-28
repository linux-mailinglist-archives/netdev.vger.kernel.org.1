Return-Path: <netdev+bounces-254075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCB5CeJ0eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:30:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 954959C46B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54D0B3033AA6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF982BEFEB;
	Wed, 28 Jan 2026 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLpXqhRv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39C298CC7;
	Wed, 28 Jan 2026 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567368; cv=none; b=qLiaBoSrNGJBsbJNYQvtJY+wjGgoi57VaVn1zUsS3hQ0S/WkEKF56Hnj6El6YH+0W7j/mlFO8i+AVAuVOQnnIg0cieg1zOENHbf10cMZavq+VsjQjBL7eWdlYxX1YWtwhwjF0NY0L7Ku1qvb30aQPIVcEY8ednMH93ebhY7oZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567368; c=relaxed/simple;
	bh=RNAIFXOTh2SlPCZHDeR7k4xqqUN8w4iGAqGLx6n/fAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q60GQw4xtBC26kGs5xInuAAlVXLNiyv294lNzJ9akGZMf5Erc4Z9rRSQ8SxaARs2yidc0QlLEg0Yu7ZpB5Ue+E5/UGErtOoNu69w+ZrNspzyP/e76U/Qz0SiOtbFyKnMu7BShbVTU/+REb0WTyhM6OKwoNVtVkSxnHrZduyrGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLpXqhRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D1DC19425;
	Wed, 28 Jan 2026 02:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567367;
	bh=RNAIFXOTh2SlPCZHDeR7k4xqqUN8w4iGAqGLx6n/fAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLpXqhRvB7DeEUbxjyk/WWG3sLqb5aMrevc4LG1wwS40eWRv+g0niGS1xzHtC+HnL
	 pDzdo1RfzpJ9Xuy7lp8J1KnOWMKpjdJ/Nnjq8CneT3DeMSvhiNHvXFsaTL71WwRBNs
	 HlGGgjVSo9qRE86zntpwcjizFE+cBZkyqo488RlfUX8xx45Eir1fmGyRDF36vl/xdA
	 f9kjxhbLesoMiJYmdwCWyBgOOd//Aysy89tjK59e3j17IXIWmkJmDCebBYChxpzil/
	 D2Us/o3TpgBvMIqOic26y/i3wb6rd8QjtZEk7CPnZEFu1W2Mv5zWytasB3AMF3Hi3H
	 eXHxzDQZOIXlw==
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
Subject: Re: [net-next,v5,08/13] octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon
Date: Tue, 27 Jan 2026 18:29:26 -0800
Message-ID: <20260128022926.4153023-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126123254.1000480-9-rkannoth@marvell.com>
References: <20260126123254.1000480-9-rkannoth@marvell.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254075-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 954959C46B
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon

This patch adds new mailbox handlers for CN20K silicon to handle MCAM
entries with larger keyword arrays (8 instead of 7), using separate
struct cn20k_mcam_entry to maintain backward compatibility.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> index cb05ec69e0b3..cefc5d70f3e4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> @@ -644,6 +644,7 @@ struct rvu_npc_mcam_rule {
>  	u16 chan;
>  	u16 chan_mask;
>  	u8 lxmb;
> +	u8 hw_prio;
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 425d3a43c0b8..620724dad093 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c

[ ... ]

> @@ -3554,6 +3555,15 @@ static int rvu_dbg_npc_mcam_show_rules(struct seq_file *s, void *unused)
>
>  		enabled = is_mcam_entry_enabled(rvu, mcam, blkaddr, iter->entry);
>  		seq_printf(s, "\tenabled: %s\n", enabled ? "yes" : "no");
> +		if (is_cn20k(rvu->pdev)) {
> +			seq_printf(s, "\tpriority: %u\n", iter->hw_prio);

The hw_prio field is added to struct rvu_npc_mcam_rule and read here in
debugfs, but I could not find where rule->hw_prio gets assigned in
npc_install_flow(). Looking at the diff, cn20k_wreq.hw_prio is set from
req->hw_prio, but rule->hw_prio appears to be left uninitialized.

Since rules are allocated with kzalloc(), hw_prio will be zero, causing
debugfs to always show "priority: 0" for CN20K rules regardless of the
actual hardware priority configured.

I see commit 62770f15276b "octeontx2-af: npc: cn20k: add debugfs support"
later in the series adds "rule->hw_prio = req->hw_prio;" which appears to
fix this. Should that assignment be part of this patch instead?

> +			index = iter->entry & (mcam->banksize - 1);
> +			bank = npc_get_bank(mcam, iter->entry);
> +			off = NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank);
> +			hits = rvu_read64(rvu, blkaddr, off);
> +			seq_printf(s, "\thits: %lld\n", hits);
> +			continue;
> +		}

[ ... ]

