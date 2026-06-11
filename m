Return-Path: <netdev+bounces-298391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Aun4A/c7K2oS4wMAu9opvQ
	(envelope-from <netdev+bounces-298391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:51:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F615675B49
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:51:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QztO8TxN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298391-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298391-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2B18315CF2E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B94D2EC1;
	Thu, 11 Jun 2026 22:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E683B961A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:50:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218236; cv=none; b=nFB6Y52i2GyD2tcdrCSUdVm2zBui+oJN+w7wS8UwhP7cVQtzYnqst0N1NKTLw1qh9ulxESJVYMqpbSgO/7s/zA5ivlsPNDVzU7+sDD3VzCt+s3yndrrymnVyvZGgftf2pRjKozEWTcpYoOGO38fXKP2yAQdEDloZaynzZwrMM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218236; c=relaxed/simple;
	bh=tIYvsNLSh8xuzsU6bPdxkLGYMA06dYPHs5opnfGFh/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NV250gB/9J5ckxWftYgEJQVWiC57MnXi7CLMZgelKVzt0kDlypENCuksKMvo/G1WNCu6nZ5r5lDrIUQOpNi9yyZcMmTWQDC0o+jWcLwpfGPcugOy9psd/G22NNepHcxwLMT4tUsE8LcRDjiqHTgXVnnlYnfbw+VttFMoJ4MD9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QztO8TxN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E2B1F000E9;
	Thu, 11 Jun 2026 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218233;
	bh=wyDtIwtvF041sYkQ4i3vJeqerIci+8sHT/aTtsYneJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QztO8TxN7V82vPhm9Wqhx+LEs9/4ZId9uXRA2/MQHI4/hNWI5GxkctGkhfPA8eypf
	 7aYy8KxwQ8i7+52wEnwCd20nCET5DG+ouzh6141VN9P/05tZ7cazzQNpibiDBnFXxh
	 n3OsURb71UfO4/jS5R1Ee935CLNF2qFObJUzl0Yb3RmUEVfY0ElyuNgQhqXRC0HiuW
	 bLO/LwoSpDz6a0YwpvmKmnuc4UtF/R4BUVbhhbcdSbJvVW8OIYLjywQjKk8AH98nfy
	 YYgk56zcf2GqxngZ1l/c6n31HimdtkgDqao7S3Z0uSQeZPHdbl9MDEukgmRc7rsiV7
	 odUIGTktEDSOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569183930FB3;
	Thu, 11 Jun 2026 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: move get_sport() callback at the
 beginning of airoha_enable_gdm2_loopback()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121823088.394849.13885828285639251256.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:50:30 +0000
References: 
 <20260608-airoha_enable_gdm2_loopback-minor-change-v1-1-1787a0f42b31@kernel.org>
In-Reply-To: 
 <20260608-airoha_enable_gdm2_loopback-minor-change-v1-1-1787a0f42b31@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298391-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F615675B49

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jun 2026 23:24:15 +0200 you wrote:
> Move the get_sport() callback invocation at the beginning of
> airoha_enable_gdm2_loopback() routine in order to avoid leaving the
> hardware in a partially configured state if get_sport() fails.
> Previously, get_sport() was called after GDM2 forwarding, loopback,
> channel, length, VIP and IFC registers had already been programmed.
> A failure at that point would return an error leaving GDM2 with
> loopback enabled but WAN port, PPE CPU port and flow control mappings
> not configured.
> Performing the get_sport() lookup before any register write guarantees
> the routine either completes the full configuration sequence or exits
> with no side effects on the hardware.
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: move get_sport() callback at the beginning of airoha_enable_gdm2_loopback()
    https://git.kernel.org/netdev/net-next/c/aeb62be4d3b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



