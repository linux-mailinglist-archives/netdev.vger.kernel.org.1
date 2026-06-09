Return-Path: <netdev+bounces-296796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AiTFNJleJ2oDvQIAu9opvQ
	(envelope-from <netdev+bounces-296796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:30:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3F165B57D
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:30:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d8oyUSN8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296796-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296796-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D82E5301EC0F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415D25B0A1;
	Tue,  9 Jun 2026 00:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6523EA97
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:30:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965011; cv=none; b=GHQQE9c/GWeB8oeJ5KLVBYpRQSeC8B1p+vE7rMu7tTEEHTGYdtrZVKXZCpaXAp32eQboodWRBgZ64a+l0i0xWj6CPo2dhon5q3BhjniIvg78e6MeR+dLj/BJ8+qioEuBHRHy0icYgCnQdsT5J7iidepTvjgs6YfiTiJtBhNZ4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965011; c=relaxed/simple;
	bh=L9GBOSrwBclkgj5LcHo04v/p5IXQixHqd9F+rLxoNNk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLkyOksW2LO6p0f+celRu9pQ92JQ8DaeKfQr1n8N0U6w+02fO3yy1TjAe8Hz+BpwN3yu6S5fILD2xEVXq73F40lGD1YV5Pa+TBycOYIm64DBPRLakZTO60grNfPUF9xjbfHwn70mw5rzbpEDne4xR1ufEdcjz8zOm25C7VqViw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8oyUSN8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50AE1F00893;
	Tue,  9 Jun 2026 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965009;
	bh=lXXMQlH25BeFvzNugC2BevnuA5yNUa7FXBwRIJ/a0JU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d8oyUSN8r6uGHxGDGdYGPO96F60z+YrUuqKiXSEb0sN7KLc5T7hXLtPCUKAF67Uzv
	 Ov4Krp2x80ZYiUfnaJ360OhRp/TKWypDAEirb6ohcPmUxdLEC2QxmcYEv/wDmdzRi9
	 VBGTf2lT5Ao0Ma3huEJfUp8qoeq6xYpSkUTqEHkd/qullrlVkV+vhn0qRdsHocJ0uy
	 RaZpjrXo/QL2aQiW5ZR2gM4UIjaBltWpPnabKZkKMGvkVqPN3d52G98AFIvsU0GHD4
	 PeuEIL6idxOxUGsjuKndfrFRyg2ITznPbbqpJWvt9FzVGwtl4ufDM99cLkt+qAXziu
	 yxkkk9pBwV0kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E83812FDA;
	Tue,  9 Jun 2026 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add pskb_may_pull() to skb_gro_receive_list()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096500840.1726280.2511374784577612737.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:30:08 +0000
References: <20260604144625.3860228-1-eilaimemedsnaimel@gmail.com>
In-Reply-To: <20260604144625.3860228-1-eilaimemedsnaimel@gmail.com>
To: HanQuan <eilaimemedsnaimel@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, security@kernel.org, nbd@openwrt.org,
 bwnie0730@outlook.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296796-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,redhat.com,openwrt.org,outlook.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:eilaimemedsnaimel@gmail.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:security@kernel.org,m:nbd@openwrt.org,m:bwnie0730@outlook.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD3F165B57D

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 14:46:25 +0000 you wrote:
> skb_gro_receive_list() calls skb_pull(skb, skb_gro_offset(skb)) without
> first ensuring the data is in the linear area via pskb_may_pull(). When
> the skb arrives via napi_gro_frags(), skb_headlen can be 0 (all data in
> page fragments) while skb_gro_offset is non-zero (after IP+TCP header
> parsing). The skb_pull() then decrements skb->len by skb_gro_offset
> but skb->data_len stays unchanged, hitting BUG_ON(skb->len < skb->data_len)
> in __skb_pull().
> 
> [...]

Here is the summary with links:
  - [net] net: add pskb_may_pull() to skb_gro_receive_list()
    https://git.kernel.org/netdev/net/c/f2bb34345444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



