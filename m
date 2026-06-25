Return-Path: <netdev+bounces-301813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x1FUJwWAPGowowgAu9opvQ
	(envelope-from <netdev+bounces-301813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:10:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2CC6C2149
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:10:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RA4fsZWB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301813-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301813-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A288F30841F6
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFC36A36E;
	Thu, 25 Jun 2026 01:09:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683AF36EA84
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:09:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349752; cv=none; b=Y4vDRc63jOC0nPU5/plZ3roWTP8aRT8wtsHc+c9YfEspT/LH2x6bZ77dX0oWYLXDb+DTyb/DAPeU0fPnkdkVazAyO6aEKVkEBFfYrxn9xd9CnmieA1hPKMu8ukwVaQBxmwqkqZ2F0plm+R+hAsdXPmGBvVOfr/f3792jRTsPbko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349752; c=relaxed/simple;
	bh=ZkpXOYZCCbniGiULM2JcZKLGb8v4UvA8NQhL2Gquzy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e7+/LlmNdhlG9eoPAsEMMNBhl/wXJOgjpW5SAIfaSf2ex5GlERM5aKAd7LN20y9zF5uXwUrzLPwrBqGrgZ4pWdRct0OibSDMhhuuJu3DSv3VzpuHJFdYF3O9coZTkdfdyPFzXk6DD7kvwbOaPrWBvvK9igrbI7tAEu6gmjYJvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA4fsZWB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175611F000E9;
	Thu, 25 Jun 2026 01:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349751;
	bh=SR00w6A5zWYfAEbQPEd3oeGOwxQRYDWbhdXlng9kzSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RA4fsZWBhKQH+pZEDRRvOwuEaEU1/nCJImq0Nc5swcASjXbxlET8hsMugm9oPGc/o
	 h7DmlD+wjHPH6RdI4KJtCbjibTw5l66awjIkIMF6+g1zcFXn8K41eb/4est/xTGnId
	 KUdXMy/CZuSuuot3TBJZ43f61Ku0sDlgOWqgMJeG3H48ebvejO5bik4QkKLsIWS4fZ
	 9mIuKUTBwhRXvKcZPBNcMguYOuPW9Mldzcu0w9y56fns4B23j6Umy8T6r8oTHS519b
	 2TO902i6fFmui35Z7CXv+HP5FAZ4yYox1qbdp1nnfGvfhdhQspf1LAMgJh3+aO3taX
	 TALqNqVzaumZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398F3AAA0F5;
	Thu, 25 Jun 2026 01:09:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] airoha: fixes for sched HTB offload support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178234973905.3045401.18000176756611441601.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:08:59 +0000
References: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
In-Reply-To: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301813-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA2CC6C2149

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 13:37:12 +0200 you wrote:
> ---
> Changes in v2:
> - cosmetics
> - Link to v1: https://lore.kernel.org/r/20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org
> 
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
>       net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
    https://git.kernel.org/netdev/net/c/bfcce49c4aaa
  - [net,v2,2/2] net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels
    https://git.kernel.org/netdev/net/c/788663dd28e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



