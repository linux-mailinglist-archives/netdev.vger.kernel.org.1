Return-Path: <netdev+bounces-306836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XqizIdMkUmqAMgMAu9opvQ
	(envelope-from <netdev+bounces-306836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:11:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C523C7415B8
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:11:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lpbzz/Nb";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306836-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306836-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFCC23012D0A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50852379C21;
	Sat, 11 Jul 2026 11:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23665381EB3
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:11:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783768267; cv=none; b=AV0HL9/+8wQkrm5HPNC9eEQr4T63YYqn0O/2v9TPeF2K5ufOAd8P4R0sJ1Z4Amhe53ywwOZBXe/TedFI6nAEQRvL7w6vc31y3Fqd7lX04pAfqSS/oE4vHr5+XBaOh4zi7xpIHMdTIZydUdLRU9fSeuKP06YtTVqeY1r4TZaQmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783768267; c=relaxed/simple;
	bh=zjOxW5l4bIeUY4SnH64iLLSHBgxuk953M0w0dn9Htd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/TBKPUqTzaMSVhjEvXGpS1bcW6iQDMNBWr7d9DbSbPmM9cA5oVk0SVDeS60VbAGpumCmWpDEX7RNb5K7Ej212mLXf1+TC3JoM4HKyO8cL2Kuy+QxBVKNniFlQHmQ7ikNBJg8MUKhcYhouyTQhSdXaCjf+0pSrWlHDZAzi7spis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpbzz/Nb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837D61F000E9;
	Sat, 11 Jul 2026 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783768265;
	bh=tC+0py2GERM7GxkFY6bPyjWfJG1BOXzXxa3JNE338f4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lpbzz/Nb+kSxcfx2RuNe0Dj5mQaMRq2tfboZpjzBDIEVv/+vJZbbP0fvMJSOa4HXU
	 LiTFXL5emkK5t3xgKJlcrGTaeef8fDjuau+kV/ggOaaGzl/QgjeNu1tf+4xcHXUjeJ
	 S9iCa/15XmawaSGJMT0qWACiS4tNxVygd9WHEuM1peIO691/LISMYZneUGiy2KSMsH
	 YykBNKmk/lqpdyaAdRllt6BIH5YCIJDtuqk2nWYdBNI4tdIobHHlFu++Adq7Jua0oG
	 Tz/HFPWi613+oIVybTFai+s/5+r9ClAVUBWjbNNRiSMzvElJkK8A7cUQRjZQByxtAg
	 9HsZn4aB7bMaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1539244F2;
	Sat, 11 Jul 2026 11:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/14] net: Support per-netns device
 unregistration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178376824253.1081492.342715946787706363.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jul 2026 11:10:42 +0000
References: <20260703001009.1572444-1-kuniyu@google.com>
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
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
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306836-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C523C7415B8

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jul 2026 00:09:11 +0000 you wrote:
> The biggest blocker to per-netns RTNL is netdev unregistration.
> 
> It starts within a single netns, but it can eventually involve
> multiple namespaces.
> 
> There are three types of such cross-netns devices:
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/14] rtnetlink: Lock sock_net(skb->sk) in rtnl_newlink().
    https://git.kernel.org/netdev/net-next/c/5ecbbb179e0c
  - [v2,net-next,02/14] rtnetlink: Call unregister_netdevice_many() only once in rtnl_link_unregister().
    https://git.kernel.org/netdev/net-next/c/49c26d4bf1da
  - [v2,net-next,03/14] rtnetlink: Add per-netns rtnl_work.
    https://git.kernel.org/netdev/net-next/c/c6cfaf97837e
  - [v2,net-next,04/14] net: Wrap default_device_exit_net() with __rtnl_net_lock().
    https://git.kernel.org/netdev/net-next/c/2b12ec257849
  - [v2,net-next,05/14] net: Hold __rtnl_net_lock() in netdev_wait_allrefs_any().
    https://git.kernel.org/netdev/net-next/c/0fa296dd520e
  - [v2,net-next,06/14] net: Add per-netns netdev unregistration infra.
    https://git.kernel.org/netdev/net-next/c/af3634d4ac65
  - [v2,net-next,07/14] net: Call unregister_netdevice_many() per netns.
    https://git.kernel.org/netdev/net-next/c/d0008553a70a
  - [v2,net-next,08/14] veth: Support per-netns device unregistration.
    https://git.kernel.org/netdev/net-next/c/d7fda2c776b2
  - [v2,net-next,09/14] bareudp: Protect bareudp_list with mutex.
    https://git.kernel.org/netdev/net-next/c/a278ea7ba32a
  - [v2,net-next,10/14] bareudp: Support per-netns netdev unregistration.
    https://git.kernel.org/netdev/net-next/c/f1de92507a91
  - [v2,net-next,11/14] ipvlan: Convert ipvl_port.count to refcount_t.
    https://git.kernel.org/netdev/net-next/c/acb351b5a899
  - [v2,net-next,12/14] ipvlan: Synchronise ipvlan_init() and ipvlan_uninit() for the same lower dev.
    https://git.kernel.org/netdev/net-next/c/aabbdb8c76d7
  - [v2,net-next,13/14] ipvlan: Protect ipvl_port.ipvlans with mutex.
    https://git.kernel.org/netdev/net-next/c/35add1093e2f
  - [v2,net-next,14/14] ipvlan: Support per-netns netdev unregistration.
    https://git.kernel.org/netdev/net-next/c/00a40d809207

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



