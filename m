Return-Path: <netdev+bounces-254566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLCsMWLsemmE/wEAu9opvQ
	(envelope-from <netdev+bounces-254566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:13:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB1ABDA2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F3923019C8B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9E2D5408;
	Thu, 29 Jan 2026 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qywtPADQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE1284898;
	Thu, 29 Jan 2026 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663584; cv=none; b=ZeH5aBjY4Fc0hof8W/KU9nznAZ8PaaaLBjXQDVMuaqcOZANdU8yfin4gkovLYnCAtnyms89PCtwvM1vuWp9wmM77TUI7u1AZmB186QaVbI2h/ZGnx4n3Vwusq9/00bovn5SGOyT6LiCfS3J4qcWxUc9/oYUuVd7f+VqThbWWkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663584; c=relaxed/simple;
	bh=ejc2KUPQ8/eGl7EFzf6K8hxRmI89PxauFJ0yRswEdrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEHYzvba+u5p4dEJ/vR6OTQKhTapujd4f1r55LhdjgsSPLsZhWIQJDTgirEcJqixr4tX3ER0CN8i2mPqtms60msE6fJxuEq3ZbcI8y4v5Hv/sb5AM3DfN2FUJvMnaOpGfJ/t5Bwti3xuqvhggFwqfc4Q/i3tgdA+WO4OQZ7H1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qywtPADQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A1CC19425;
	Thu, 29 Jan 2026 05:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663583;
	bh=ejc2KUPQ8/eGl7EFzf6K8hxRmI89PxauFJ0yRswEdrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qywtPADQvO80M//yqe+cGoAGor+TL+B6vcAkjsAngqaONYzNnKZLZl+XIfWGypukU
	 wEZnZ+D3fqCoQ857V6I/vIyuplzeWiTxKLZpydvzrcXm84ka7opxtp8ZhJ7U3ZQiSJ
	 Pq20MAJej17s8beX0lV9RSJjx5lhZQx4VnAn5Is6RkxojSSj+aNcDucdteBf6FRfAb
	 thx3WUgJqvRYteyKdIvdSXfK3nA4eaXPWU9J3Pp886cO7noj6JaSFWwws0pS03B0r5
	 IJl6khh/dMR56H0OGa4nxtF6FobfpAf08ZXtNL8drTN6Mwa3BPrWnJXoTITZjV4i0G
	 V2tFWBvetqBCg==
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
Subject: Re: [net-next,v6,01/13] octeontx2-af: npc: cn20k: Index management
Date: Wed, 28 Jan 2026 21:13:01 -0800
Message-ID: <20260129051301.376533-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128071235.3577206-2-rkannoth@marvell.com>
References: <20260128071235.3577206-2-rkannoth@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254566-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 37DB1ABDA2
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Index management

This patch adds MCAM index management for CN20K silicon, implementing
contiguous and non-contiguous allocation schemes across the new subbank
architecture with 32 subbanks of 256 entries each.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> new file mode 100644
> index 000000000000..30cc05c64487
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static int npc_create_srch_order(int cnt)
> +{
> +	int val = 0;
> +
> +	subbank_srch_order = kcalloc(cnt, sizeof(int),
> +				     GFP_KERNEL);
> +	if (!subbank_srch_order)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < cnt; i += 2) {
> +		subbank_srch_order[i] = cnt / 2 - val - 1;
> +		subbank_srch_order[i + 1] = cnt / 2 + 1 + val;
                                   ^^^^^

When cnt is odd, the final loop iteration has i = cnt - 1, which means
subbank_srch_order[i + 1] writes to index cnt, which is out of bounds.

For example with cnt = 5, the loop iterates with i = 0, 2, 4. At i = 4,
the array access subbank_srch_order[5] overflows the allocated array of
5 elements.

While CN20K hardware typically has 32 subbanks (even), the value is read
from a hardware register at npc_priv_init() without validation beyond
checking for zero. Could this lead to memory corruption if the hardware
reports an odd subbank count?

> +		val++;
> +	}
> +
> +	subbank_srch_order[cnt - 1] = cnt / 2;
> +	return 0;
> +}

[ ... ]
-- 
pw-bot: cr

