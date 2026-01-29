Return-Path: <netdev+bounces-254567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB+xIZPsemmE/wEAu9opvQ
	(envelope-from <netdev+bounces-254567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:13:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E81B8ABDC8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00898303527D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535BE2DA759;
	Thu, 29 Jan 2026 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYElRqfm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310732DA756;
	Thu, 29 Jan 2026 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663586; cv=none; b=SXY9vxnClK8eUijevcOpggkJjxlZ1/CG9eQ46BUNZ7KhuYGQDvlCzr0wRG842krui4vmUWYFuyCMfZRf1iQYP/xhsDW9KCVcI7uZCHEF7jMKP/wFxbwiOxwpfePLTDp5ETWBOSrEz82WrYRX4Z/ygngAdF8BMID66qu0KWyQIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663586; c=relaxed/simple;
	bh=HLOAqD6ecQM10hv7JOzwxSd+Zq6ye5Sp8hnx1NEk0Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjkzQDx4G5R+lGc9kvdhfPnfDpl+KOcOhsRHF5x0HeZysMGY/seLC4LYYYTYzkGRAuVtYD6ELmCJVxq48hbD+LVV0uIQt2tInIubv9VIbIqEA4uRiOdOz2ZEnOT+W5C+CAOnMNS57yKycs4TxAwWBvWWDhQm/9v402NitWPwl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYElRqfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320CC19421;
	Thu, 29 Jan 2026 05:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663585;
	bh=HLOAqD6ecQM10hv7JOzwxSd+Zq6ye5Sp8hnx1NEk0Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYElRqfmWvoWQFiVnQ9qGp3qOaOzs+joIyFiRZgLWhalNIopBms0GLL8+L4GY9Z4m
	 Rd5J7CydkjjLFqTr3SV/Ct81fYHHv0NRw16ulvBvT2YhQ6lhKw2FnrWrpr/nFkHXp4
	 prqt2TrAW0qWec2Ui+Ck8gxWWlWkB7HiqSpD3s38FwmoKXH2lfJfQk6DFBFBlIo9zL
	 lwbYci3ok/fY8Ep3VsfQ/iCwIlHqVCt+k7jFI8CFxxTOxFfXoNmL0HUhNm4gTL+wUb
	 74znTBXxjxuVRbnwB1uqekSRTiOGuYfHV10uI/1xPiQ7+NOVc3/3wXlIe+UL6ALM9R
	 uSoKz9JRS9hKw==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	sumang@marvell.com,
	linux-kernel@vger.kernel.org,
	sbhatta@marvell.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	sgoutham@marvell.com
Subject: Re: [net-next,v6,02/13] octeontx2-af: npc: cn20k: KPM profile changes
Date: Wed, 28 Jan 2026 21:13:03 -0800
Message-ID: <20260129051303.376551-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128071235.3577206-3-rkannoth@marvell.com>
References: <20260128071235.3577206-3-rkannoth@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-254567-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E81B8ABDC8
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: KPM profile changes

This patch adds KPM (KPU Module) profile support for CN20K silicon,
which groups 16 KPUs into 8 KPM profiles (KPM0 = KPU0 + KPU8, etc.)
for more efficient parser resource usage.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 30cc05c64487..dfd94a30d81c 100644
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
> +	u64 reg;
> +
> +	action1.errlev = kpuaction->errlev;
> +	action1.errcode = kpuaction->errcode;
> +	action1.dp0_offset = kpuaction->dp0_offset;
> +	action1.dp1_offset = kpuaction->dp1_offset;
> +	action1.dp2_offset = kpuaction->dp2_offset;

[ ... ]

> +	action0.capture_flags = kpuaction->flags;
                               ^^^^^^^^^^^^^^^^

The npc_kpm_action0 structure defines capture_flags as a 4-bit field,
while kpuaction->flags is u8 (8 bits). The KPU profiles use flag values
such as NPC_F_LA_U_HAS_IH_NIX (0x20), NPC_F_LA_U_HAS_HIGIG2 (0x40), and
NPC_F_LB_U_UNK_ETYPE (0x80), which all exceed what 4 bits can represent.

Is this truncation intentional for the CN20K hardware register layout?
If so, will the parser functionality work correctly when these upper
flag bits are silently discarded?

> +	action0.ptr_advance = kpuaction->ptr_advance;

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> index 26da0a2c717a..55882a0f37fc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h

[ ... ]

> +struct npc_kpm_action0 {
> +#if defined(__BIG_ENDIAN_BITFIELD)

[ ... ]

> +	u64 rsvd_32_35     : 4;
> +	u64 capture_flags  : 4;

For reference, the existing npc_kpu_action0 in npc.h has capture_flags
as 8 bits without the rsvd_32_35 field. This structural difference
appears intentional for CN20K hardware, but the same KPU profiles
containing flags > 15 are loaded via npc_load_kpu_profile() for CN20K.

> +	u64 ptr_advance    : 8;

[ ... ]

