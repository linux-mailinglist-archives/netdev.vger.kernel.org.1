Return-Path: <netdev+bounces-280691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCvkMXfy6WkzpQIAu9opvQ
	(envelope-from <netdev+bounces-280691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DBD450905
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0999E3037E53
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6C37B3F4;
	Thu, 23 Apr 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPjLXDu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB4285CA4;
	Thu, 23 Apr 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939269; cv=none; b=tPL/sAbe8Ti0QRLuYdO7gkCPWa2n5vO0VTUXs0Ur8PjXLmKQgQsEbNa68awN1xWnUqdjymxQplNUAScSnvhuHWX0G190DfCkdvtRQ+ZxcLBkkUhfvcjSSaapx+It/Fltvs9k1GnBh7tuVI01nCr0vJ8frGwwHZzUyHEw8zCqMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939269; c=relaxed/simple;
	bh=n8PIjgIUEEPbYl8wiqKvWUmCj65cJf49TySsuytpK7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAC4xzI4oky6EDOr82PN1n1aEXFTC+KXCdP89MbDVcSU1ZOu1nBPjLpwEZSkPaflmHpP3/DfYjoHIpPyQdUhl31fByzEADKYvF0W9gsxc3Jfmxa4/85tthsv61UpXYjQK3HUfVPVE60bwpc+yHF2EfVWHgBq59pyQmLfXIv6vfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPjLXDu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D7EC2BCAF;
	Thu, 23 Apr 2026 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776939269;
	bh=n8PIjgIUEEPbYl8wiqKvWUmCj65cJf49TySsuytpK7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPjLXDu5U98lUgHoOFztzZjJCdypSNHcXrtuJDmG0XbCFaChSeQ100t7L5fCEF8Mr
	 lIX68jwc2X3Z1MQzcBDQk64Je/U3ajk5rM3aArELccP20WwII3W5jLqYFWBafTvC9J
	 2sTn3ugFy5R2FobE8ilHp+XFIWc7Ck65qWVbH/qjj0/T30h2/gSNYOZAhxNjvQ706m
	 RRPU+Wqc8TNRbSi0xKXw2nBCNyhHrHH6lBT++34BPsIK/tTY0E6x6BlE1wyBcSlPEw
	 cjIxa1BhsnUos6cWRMotJA6k1Gl2Y+LhjyruNa4EdnxsihoWHv2l/a31S4IHch9re1
	 wI4e/sUcylHNA==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	sumang@marvell.com,
	netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	sgoutham@marvell.com,
	error27@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2 net 01/11] octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
Date: Thu, 23 Apr 2026 11:01:47 +0100
Message-ID: <20260423100147.908443-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420023442.3295891-2-rkannoth@marvell.com>
References: <20260420023442.3295891-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,lunn.ch,marvell.com,linaro.org,gmail.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-280691-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 31DBD450905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k

This patch converts several cn20k NPC functions from void to int return
types to propagate MCAM key-type lookup errors. It adds error checking
for npc_mcam_idx_2_key_type() and threads these errors through the
cn20k MCAM handlers.

Link: https://lore.kernel.org/netdev/adiQJvuKlEhq2ILx@stanley.mountain/

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7291fdb89b03..18d70f4527d1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -1415,9 +1435,9 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
>  	else
>  		nix_intf = pfvf->nix_rx_intf;
>
> -	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
> -				    &req->entry_data, req->enable_entry,
> -				    req->hw_prio, req->req_kw_type);
> +	rc = npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
> +					 &req->entry_data, req->enable_entry,
> +					 req->hw_prio, req->req_kw_type);
>
>  	mutex_unlock(&mcam->lock);
>
>  	rsp->entry = entry_rsp.entry;
>  	return 0;

Does this function need to return rc instead of 0? If
npc_cn20k_config_mcam_entry() fails (for example, due to an invalid key
type), the function still returns success to the caller. The mailbox
response indicates the entry was successfully allocated and configured,
but the hardware entry may be in an undefined state.

[ ... ]

