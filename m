Return-Path: <netdev+bounces-299985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9vrCyjTMWo2qwUAu9opvQ
	(envelope-from <netdev+bounces-299985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A37695A4C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:50:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ll4MBcOH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299985-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299985-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E222E301665E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05763F23B7;
	Tue, 16 Jun 2026 22:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68173A7F4B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650213; cv=none; b=o5XNU8G8wutHMYvB2AiySMf0KbpRrh5Kabrt6jXGsiVMk7ttQEzG+V5MvQsoGReU75FX2lBR0looRVbIR0gvOONJsioLoCHiSXCC0xWrsMkOCwBdkxe9QCOZpb6XKNlYvohO8gLpDwK9RYt6RHD/v3nH2FivzG9/TGb4UwYBvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650213; c=relaxed/simple;
	bh=3mQjbqjhWkcH6zTyJZsjuXLyMP3J8YXQdMFYW2elx10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vw22ZugxSOf5VWyPlPMlziCPFradvGpFhSJBXbsGitj69bXKF1PEUxixJcO/hcDgC437oNwGD3ADJXvynBgEDMlksxhoqZi+blNfZxb9NtErlkXqzJbEv3FyEErUFfFJ3on13HL+MaP0eMC2AabS6vR6AgVdfEZb+d7PGGsu8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll4MBcOH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5CD1F000E9;
	Tue, 16 Jun 2026 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781650212;
	bh=HUnCtpHGZm+thAAPgmOlVd0e0hbDwbzUPPm+bmRPHQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ll4MBcOHUFOrxG1MuAfL6PUzpJz8tYv0hjPXMU8DoqLsMDkb5NrxExqPqvYJBvw1O
	 4GjtnGpWWqQ7xWQlG1v/RdCVMaW9lTzvOelk2kAs5v7Fib2rBy4EmUcuvYlULQYOJq
	 RZpnQW+dp1FpV85yLGzv2QX/ZwH1Ja7/54375CLhCF1lGY4jO1sv8Vd1QY3CLaz4qb
	 cF1T5DbcFI6JSrBbfei4SeZxnqKrVE8VyN322ZreY4rCYhl2Vmkm92hnaHuJg79R4/
	 MRU/tI99vRWe7JVhPnOrd6Q2Wl+Y4SXQ1itN4R5sWWRVOrXehvsvj0mSeG2NBhxLmN
	 PWNL9OBs9QFaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199463930C2E;
	Tue, 16 Jun 2026 22:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ipv4: fib_rule: Move fib4_rules_exit() to
 ->exit().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178165020689.1270198.450287651539968178.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 22:50:06 +0000
References: <20260616191359.4142661-1-kuniyu@google.com>
In-Reply-To: <20260616191359.4142661-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-299985-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,965506b59a2de0b6905c];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98A37695A4C

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 19:13:48 +0000 you wrote:
> syzbot reported use-after-free of net->ipv4.rules_ops. [0]
> 
> It can be reproduced with these commands:
> 
>   while true; do
>   	ip netns add ns1
>   	ip -n ns1 link set dev lo up
>   	ip -n ns1 address add 192.0.2.1/24 dev lo
>   	ip -n ns1 link add name dummy1 up type dummy
>   	ip -n ns1 address add 198.51.100.1/24 dev dummy1
>   	ip -n ns1 rule add ipproto tcp sport 12345 table 12345
>   	ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 198.51.100.2 peer_port 54321
>   	ip netns del ns1
>   done
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ipv4: fib_rule: Move fib4_rules_exit() to ->exit().
    https://git.kernel.org/netdev/net-next/c/d954a67a7dfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



