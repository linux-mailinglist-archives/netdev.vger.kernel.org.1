Return-Path: <netdev+bounces-254073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIvmLo90eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:29:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 514AC9C435
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35FED300B10F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BB2882B4;
	Wed, 28 Jan 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miu6xBxL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888842050;
	Wed, 28 Jan 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567364; cv=none; b=Ei3cu0osUTS75Ch5FdcjmvloAsU8S5szyEwWskrtNSpkBdVRcv5SBj0YpJ94hEdAYYwxTXJsP3NYvaiB5Be7zp0+jvNbLYgyg/pkDqe6x1UxLJXq3RNFkS9+3DzcHvOiTw51RNcbwgurRe4RtwloYU0t7B4rX5KIhQGwxIKeOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567364; c=relaxed/simple;
	bh=ZM5BX9RbgogohOBQDu0N8i61mh/sgc9aZ0sNXzW2gzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgkhuUuEmr8bHLDP8IUWREhcNaOEEFLOwp3gWnYSqLqp4OUXIEqQ/CVUNvcgtXMHpdYjjgcYwgdZXzgBWJMofh47BNUK2ubMtEyklFkIySET5pTe6vPdkVjvFYIzB+qpgEykAdk+MGetTH0eHRLmJbef+V0bZaSCrFXDyZkDlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miu6xBxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584D2C116C6;
	Wed, 28 Jan 2026 02:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567363;
	bh=ZM5BX9RbgogohOBQDu0N8i61mh/sgc9aZ0sNXzW2gzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=miu6xBxLfeVSr4PcJRoUmsXGwIcmBNkiIowyue27SQAXH98Ql9ENz6In4iHnHUeYD
	 Wsyqw2OJYUh8U7FLJeRARS+KqMEqTsd77a3T/qtLQXURdZy2SLvSv+x+SmIpHYmdzy
	 llEFWieFXowiOGg983OoDYEoK8fr9NmaKL6B6mhU9cJIvnA4RSwfBQ2fcba2bkcF39
	 XwaCKdfJKiiyuNLRWluJ83adOKshfDmdBwy+SIRapcESGmcsGJOy7/dOXfwNqNvkiv
	 mls3OgzNV54yFYhC4LUVq0y+UifdDgOxxQvwkiYRwXsvp1aweX/DxH6TgF1r/ytxjQ
	 mNzFAXvrMRF/Q==
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
Subject: Re: [net-next,v5,05/13] octeontx2-af: npc: cn20k: Allocate default MCAM indexes
Date: Tue, 27 Jan 2026 18:29:21 -0800
Message-ID: <20260128022921.4152787-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126123254.1000480-6-rkannoth@marvell.com>
References: <20260126123254.1000480-6-rkannoth@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-254073-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 514AC9C435
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Allocate default MCAM indexes

This patch allocates MCAM indexes for promiscuous, multicast, broadcast,
and unicast traffic when NIX LF is attached to PF/VF, improving
allocation efficiency over the previous reservation method.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index dd5352bd6dbf..6ae462d6ebaa 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +chk_sanity:
> +	dev_dbg(rvu->dev,
> +		"%s: Default index for pcifunc=%#x, bcast=%u mcast=%u promise=%u ucast=%u cnt=%u\n",
                                                                       ^^^^^^^

Should "promise" be "promisc" here? This appears to be a typo in the debug
message.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> index aadee502bac1..f1734435db4d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h

[ ... ]

> +/**
> + * enum npc_dft_rule_id - Default rule type
> + *
> + * Mcam default rule type.
> + *
> + * @NPC_DFT_RULE_START_ID:	Not used
> + * @NPC_DFT_RULE_PROMISC_ID:	promiscuous rule
> + * @NPC_DFT_RULE_MCAST_ID:	promiscuous rule
                                ^^^^^^^^^^^^^^^^

Should this say "multicast rule" instead of "promiscuous rule"? It appears
to be copied from the PROMISC line above.

> + * @NPC_DFT_RULE_BCAST_ID:	broadcast rule
> + * @NPC_DFT_RULE_UCAST_ID:	unicast rule
> + * @NPC_DFT_RULE_MAX_ID:	Maximum index.
> + */
-- 
pw-bot: cr

