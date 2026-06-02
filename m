Return-Path: <netdev+bounces-294333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SVH8FxQhH2o8hQAAu9opvQ
	(envelope-from <netdev+bounces-294333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:29:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AD63113E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:29:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B+Xa+Y4u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294333-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294333-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4F0830193B0
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411533909A4;
	Tue,  2 Jun 2026 18:29:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD73909AE
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:29:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424976; cv=none; b=tMpiSKgrf5XT/G7n5f84d1Q3sHDHN5KGMXWKAN3AF56/GGdI8JIuBgnz3vIf+8DuCu8AS0OR4CyUi+r/q/VpK37dPB4iFGiq+jOEqJYrZCDIh3RwTU6d625M5OY4GOc5EJcjlhxveMUZtmkgPu6Zk4o0oK3ERBG2heAc/X8IVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424976; c=relaxed/simple;
	bh=cOAykZWhRsL1TGyL1Ic9FrlRU9AEw0MeRR9PTO45Ebg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R31FcTeWzJtNfS78UFUB90sDjH9cDChrDGIa8MlT0RL7GhTTY91RJxbgEuTV1X+0FRwKc6h9gvVgwebLi7AQK3vldsdkh1VUYN/MhF7UVwiYHrMkmTiF0hy/xOx/Jyo/DWnxrjNIK2xFpjXEBP/rFRSPnoxm9hwMEsCifl6GejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Xa+Y4u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEBC1F00893;
	Tue,  2 Jun 2026 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424975;
	bh=Brx1uKf/6SqXt1lkmg7kU/LgJ8uxseX3gupdvVmfdOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B+Xa+Y4uZHkbtWE5QsqdetqF+prKN6NT6gxPjdRlvwzYO5w7bLsumQVr92TfJmiiE
	 eswYYB9NMVdBRnerS9F3zgK4SF7w8B8gA2e1RRoDXwMQGZB04l2Si7/XMU8zC3EBSX
	 cqEIB+0N4+ch6pZx05Pr4X7fZNL/OjrJLfxHfz8O/WMkSW2uP8CwTw3t7X4s+VyUGu
	 xKjT0/zLlAiOWOso1VAecIKsf+uwh1wqsnvLe9gmxPu6F+Y1DdXg8yL+6fdNu2mqkf
	 +cdYfMcCJhKnhi66D+xWJrZ1UHVVd43Fa/UV61k/w0cWeWcseOCAscNhYq8v9yMhy2
	 oWu2zrgdERF4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198603811A6C;
	Tue,  2 Jun 2026 18:29:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: change bpf_skops_hdr_opt_len() signature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042497665.988310.15642495418915987528.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 18:29:36 +0000
References: <20260601093819.469626-1-edumazet@google.com>
In-Reply-To: <20260601093819.469626-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-294333-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C08AD63113E

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 09:38:19 +0000 you wrote:
> Some compilers do not inline bpf_skops_hdr_opt_len() from
> tcp_established_options(), forcing an expensive stack canary
> when CONFIG_STACKPROTECTOR_STRONG=y.
> 
> Change bpf_skops_hdr_opt_len() to return @remaining by value
> to remove this stack canary from TCP fast path.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: change bpf_skops_hdr_opt_len() signature
    https://git.kernel.org/netdev/net-next/c/ceac8dbce6c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



