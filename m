Return-Path: <netdev+bounces-256314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHHvN9MEgmmYNgMAu9opvQ
	(envelope-from <netdev+bounces-256314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:23:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D597DA83E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84791305186C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466933A8FEB;
	Tue,  3 Feb 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBLpkqes"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317F3A8FE6;
	Tue,  3 Feb 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128440; cv=none; b=BPvDJ08RYJYipwXJobvRME2XKgeOaMVcRkekMN0nmyeZovqqYW/qIVngIknYKKq41bt55gWQDMlzTqgz3FJikyCHt1OS/Jmg2J5XaSOH5m+le19gHHbfTbdgqbx87S6SnUmAbpx5vn/isFsKrsXiTXEg7yiz3l5tte6HSv5bkb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128440; c=relaxed/simple;
	bh=bh7+IerRoy6AL9qQCND5lJKi+YgjZel6S467nOCTmzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a07gB91NfgzgSi4dcN5X9axHvX6jhcgHqL50Vuz6U0cQox2AYwsNqr8OQWZXc1M3uTZ7Qr+6F9MJHiKYjhakf3MqRuNWplh7kQgF4o+XRdv+ILdTwA6F3pPVrYHxouW+X95XEpDEzYgXIBgpDp/sWFKetZa61cgVGFfN2a9dkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBLpkqes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E06C116D0;
	Tue,  3 Feb 2026 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770128439;
	bh=bh7+IerRoy6AL9qQCND5lJKi+YgjZel6S467nOCTmzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jBLpkqes71HO/n5IeE6eAmpgINcqOttk0C0U0jGba4RUUBeCygc8B2vGJm+uwp9/4
	 +cP06DGBLAV2RMu1gHkLuUrMDOCfDfrz3uaRcWw386yWapF0f24O0QL1PHZZWvjaM1
	 mhfJhJNaKUjv3chl2jiyeysVSlC5Y17tUdZ7k3aS9YijcP9vxNMFy1iSkwLKDfYHgI
	 H6vH3zYRR66VZBCbsljg9LTJbfP1/kaZL3jn9wuf1tq9fZc6as5lr3MvwyP+pj2YHd
	 h7FfVu7Ujj9IY8fB+IRWpN5vCGSgyWBsuzHorMBPsB6O37efcIZ1vk5y4XNssIaENa
	 59wUokk/JOWPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90F973808200;
	Tue,  3 Feb 2026 14:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13 net-next 00/15] AccECN protocol case handling series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177012843606.1498169.6318995786040957061.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 14:20:36 +0000
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256314-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 3D597DA83E
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 31 Jan 2026 23:25:00 +0100 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v13 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> [...]

Here is the summary with links:
  - [v13,net-next,01/15] tcp: try to avoid safer when ACKs are thinned
    https://git.kernel.org/netdev/net-next/c/7885ce014740
  - [v13,net-next,02/15] gro: flushing when CWR is set negatively affects AccECN
    https://git.kernel.org/netdev/net-next/c/ab4c8b6f7fcb
  - [v13,net-next,03/15] selftests/net: gro: add self-test for TCP CWR flag
    https://git.kernel.org/netdev/net-next/c/6f74bc8b6e8d
  - [v13,net-next,04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
    https://git.kernel.org/netdev/net-next/c/100f946b8d44
  - [v13,net-next,05/15] tcp: disable RFC3168 fallback identifier for CC modules
    https://git.kernel.org/netdev/net-next/c/e68c28f22f46
  - [v13,net-next,06/15] tcp: accecn: handle unexpected AccECN negotiation feedback
    https://git.kernel.org/netdev/net-next/c/c5ff6b837159
  - [v13,net-next,07/15] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
    https://git.kernel.org/netdev/net-next/c/3ae62b8b4a48
  - [v13,net-next,08/15] tcp: add TCP_SYNACK_RETRANS synack_type
    https://git.kernel.org/netdev/net-next/c/f1eaea5585e4
  - [v13,net-next,09/15] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
    https://git.kernel.org/netdev/net-next/c/f326f1f17f37
  - [v13,net-next,10/15] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
    https://git.kernel.org/netdev/net-next/c/4024081feb87
  - [v13,net-next,11/15] tcp: accecn: fallback outgoing half link to non-AccECN
    https://git.kernel.org/netdev/net-next/c/2ed661248e2b
  - [v13,net-next,12/15] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
    https://git.kernel.org/netdev/net-next/c/1247fb19cafe
  - [v13,net-next,13/15] tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
    https://git.kernel.org/netdev/net-next/c/4fa4ac5e5848
  - [v13,net-next,14/15] tcp: accecn: enable AccECN
    https://git.kernel.org/netdev/net-next/c/8ae3e8e6ceed
  - [v13,net-next,15/15] selftests/net: packetdrill: add TCP Accurate ECN cases
    https://git.kernel.org/netdev/net-next/c/f85d9c45f1d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



