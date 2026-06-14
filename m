Return-Path: <netdev+bounces-299225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g8lACZixLmrB1wQAu9opvQ
	(envelope-from <netdev+bounces-299225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BA9681386
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:50:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nrMeJRKQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299225-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299225-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB72130078D9
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4534938D40E;
	Sun, 14 Jun 2026 13:50:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE73347C7
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:50:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445012; cv=none; b=VSiRZpLG6HRIvVQJil9xpxXKlvLl+L1h2VUzDLWGYnLc6GjrXZ6f32s5ach8LPEAydWYTZnQo7TOuMv+hpI3oXxkTwEp6krg1WW1fFGXm4sPomzNS1+GpXX0Wz2P1jSr6EKch8XgagPggb8vEXC17wG8PZCniGEFOGr3HeEQPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445012; c=relaxed/simple;
	bh=4+mZE/E6T05gexUv3Dnj0zVCLEjTC8P/XNMrYXYREHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m+2RAN95YCFepCkdiufFbLJa8x2GOx7Zy2T1+/OplknhrJT8d2G94xTGhBA/3EFVOUTxrqoPu+joxJqj567ycsM6GYm4IwIBgLghOmwPlLGuxuTyEuSdFm9nVwq9V1eTc11c/H3q9QTcvKCiPvdqySRJSrLQQy9MCMLBP1dc3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrMeJRKQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34F51F000E9;
	Sun, 14 Jun 2026 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781445010;
	bh=pxVe8/F5ORiaNi5rXu0gftBOroN3fHt73PBrl8iRB1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nrMeJRKQSZ6OZf1EVx7g6+pfyeKdY+Aclg+iqvJeI5snfxT3ILrqphfC5aI9rLkeu
	 WGi0twwnqY1bqSCCIYjfRQbzRwtFCL1lybPlSiDHYqSzbibSIO/LeStZSKaTpzZdy4
	 u7BeP8E0udiWiJ1fUO98vmCMRx/ddqnRP8aCHKPf4cZh+S1e9dXPFJMA0Z0YOvMYbT
	 MNUcwAaVIhhTCMrR9eq0KIHOECeUhHuo4R9vnHdOz3Ukg3XwDQrrloD7JcvLYP4IV1
	 guCRbSkejDVhlWpjPZSXbrHdtXBxecmEQVlrESstMvosVIoqRA4HqXRQl0UWzyeHYO
	 WoeRjDfN5gKgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09B63A55FAD;
	Sun, 14 Jun 2026 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/11] BIG TCP for UDP tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178144500664.1791255.1546612273413595096.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jun 2026 13:50:06 +0000
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com,
 willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org,
 razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com,
 andrew+netdev@lunn.ch, horms@kernel.org, fw@strlen.de,
 netdev@vger.kernel.org, alice@isovalent.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299225-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[fastmail.im];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,isovalent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69BA9681386

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 11 Jun 2026 21:29:44 +0200 you wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> IPv6 BIG TCP doesn't require stripping the HBH in all various
> combinations in tunneled traffic, adding BIG TCP becomes feasible.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/11] net/sched: act_csum: don't mangle UDP tunnel GSO packets
    https://git.kernel.org/netdev/net-next/c/9bcb30b389ec
  - [net-next,v7,02/11] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
    https://git.kernel.org/netdev/net-next/c/2319688890d9
  - [net-next,v7,03/11] net: Use helpers to get/set UDP len tree-wide
    (no matching commit)
  - [net-next,v7,04/11] net: Enable BIG TCP with partial GSO
    (no matching commit)
  - [net-next,v7,05/11] udp: Support BIG TCP GSO packets where they can occur
    (no matching commit)
  - [net-next,v7,06/11] udp: Support gro_ipv4_max_size > 65536
    (no matching commit)
  - [net-next,v7,07/11] udp: Validate UDP length in udp_gro_receive
    (no matching commit)
  - [net-next,v7,08/11] udp: Set length in UDP header to 0 for big GSO packets
    (no matching commit)
  - [net-next,v7,09/11] vxlan: Enable BIG TCP packets
    (no matching commit)
  - [net-next,v7,10/11] geneve: Enable BIG TCP packets
    (no matching commit)
  - [net-next,v7,11/11] selftests: net: Add a test for BIG TCP in UDP tunnels
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



