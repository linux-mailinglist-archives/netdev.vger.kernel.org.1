Return-Path: <netdev+bounces-298881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yLhSGWq3LGrhVgQAu9opvQ
	(envelope-from <netdev+bounces-298881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:50:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B830167D7A5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:50:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CuWFs7B6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298881-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298881-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2490531672C2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417E3612EF;
	Sat, 13 Jun 2026 01:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A83321F5E
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:50:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315431; cv=none; b=sr/9wZZkN7uhGoOuJVwQjQG8wm5EBBpZCjI62B1m57yUlEIGNpdEdqOBdTms/13d4HM6Tz6eXG431f9b0YX0a9/DwpKU0hhAMh6WqiAzmEVpXmZa+RdypJIN3c/e/cL37rmS6EoIo5go0gv7jIMtp9unfriIpdvRnWCGjA4cr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315431; c=relaxed/simple;
	bh=D0o+4EqzOsyDI1OHbMU21YQPgUdw5SXQzuYz9CoU6lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eraNppOSyMMZK/3cpoaJhtcs9LCBcqqQ8ll+aNv0tAA9UkUD7xLWZCdU1fdBDgtT/4z+c7JxK1dPy6o/ExbC4BCgtNouOzk70CYjQRS4J/L885G2T60HVQ61CustaF1lLQozwS3780QXawWLL6iCbziOVfguUHJHVLaiytusvmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuWFs7B6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBB31F000E9;
	Sat, 13 Jun 2026 01:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781315430;
	bh=yfFVSi5VQ+oMujF+C2XqNLWZlfj7wSuOOPFGSc7Ctgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CuWFs7B6u6AJtbNhuW6J28VONnQgecGEwKl38zeNxJmGRPxRrJRHZROS96MDnq6ps
	 T3iqm3EoyvQqiKQSwtMUSeu2cH/mgTGGpYffFi9skTT9Jjqxdjn711EMiYxyGCfslQ
	 Of2vkdKevd8xBWpxY4Gq9QussHiYkZojrXvyuHON5YivMiM558iWYfloR7LDzNCB8G
	 2ohQ4WSbn9Ff8X1qTcABrQFFHIhXkTrqNqEx69uePx2b9w7ETqoO7yX+C5urYB5SZd
	 LiAfAi38Dmhm6H+zcSnR2qEBksJ9GfXxA7WXo4JLdlWob4xiG3u7gCGFpR+GZLg62i
	 fPWm0UWMrdkCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AEC39E9607;
	Sat, 13 Jun 2026 01:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v16 net-next 00/10] psp: Add support for
 dev-assoc/disassoc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131542638.1328827.9465112348226250569.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:50:26 +0000
References: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
In-Reply-To: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, daniel.zahka@gmail.com,
 willemdebruijn.kernel@gmail.com, dw@davidwei.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, weibunny@fb.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com,fb.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298881-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:weibunny.kernel@gmail.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:weibunnykernel@gmail.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fb.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B830167D7A5

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 16:31:08 -0700 you wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> The main purpose of this feature is to associate virtual devices like
> veth or netkit with a real PSP device, so we could provide PSP
> functionality to the application running with virtual devices.
> 
> A typical deployment that works with this feature is as follows:
>      Host Namespace:
>      psp_dev_local  ←──physically linked──→ psp_dev_peer
> 	  (PSP device)
> 	       │
> 	       │ BPF on psp_dev_local ingress: bpf_redirect_peer() to nk_guest
> 	       │
> 	  nk_host / veth_host
> 	       │
> 	       │ BPF on nk_host ingress: bpf_redirect_neigh() to psp_dev_local
> 	       │
>       Guest Namespace (netns):
> 	       │
> 	  nk_guest / veth_guest
> 	  ★ PSP application run here
> 
> [...]

Here is the summary with links:
  - [v16,net-next,01/10] psp: add admin/non-admin version of psp_device_get_locked
    https://git.kernel.org/netdev/net-next/c/1c88a4664779
  - [v16,net-next,02/10] psp: add new netlink cmd for dev-assoc and dev-disassoc
    https://git.kernel.org/netdev/net-next/c/06c2dce2d0f6
  - [v16,net-next,03/10] psp: add a new netdev event for dev unregister
    https://git.kernel.org/netdev/net-next/c/0ddb69e2406e
  - [v16,net-next,04/10] selftests/net: psp: refactor test builders to use ksft_variants
    https://git.kernel.org/netdev/net-next/c/89ed478a6c90
  - [v16,net-next,05/10] selftests/net: add _find_bpf_obj() to search hw/ for BPF objects
    https://git.kernel.org/netdev/net-next/c/b9d51f2e133c
  - [v16,net-next,06/10] selftests/net: rename _nk_host_ifname to nk_host_ifname
    https://git.kernel.org/netdev/net-next/c/593e22f6524b
  - [v16,net-next,07/10] selftests/net: psp: support PSP in NetDrvContEnv infrastructure
    https://git.kernel.org/netdev/net-next/c/1c1c2e5b1fe9
  - [v16,net-next,08/10] selftests/net: psp: add dev-assoc data path test
    https://git.kernel.org/netdev/net-next/c/43cf629700fa
  - [v16,net-next,09/10] selftests/net: psp: add cross-namespace notification tests
    https://git.kernel.org/netdev/net-next/c/5280303605bc
  - [v16,net-next,10/10] selftests/net: psp: add dev-get, no-nsid, and cleanup tests
    https://git.kernel.org/netdev/net-next/c/50d3bdfb84c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



