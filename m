Return-Path: <netdev+bounces-304103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Y2IFA5DRmpoNAsAu9opvQ
	(envelope-from <netdev+bounces-304103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:53:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935DC6F63C9
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:53:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lWOYqJcT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304103-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304103-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5746B304A8FC
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEAE386450;
	Thu,  2 Jul 2026 10:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336528F5;
	Thu,  2 Jul 2026 10:40:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988829; cv=none; b=Or2ndP2aQ7B2OlJWbkdmNtRd8i9iVxMA1+UVVxBHvhalLeaVhwdmfV9I7I5rNS6MLLAOBUXMDYpj3AHML7iNyR3Nr0sDvrGYGAu0wofn/96xalucPyF01eh4BQVV+Dr/1My0AcLjLbQWyUU90DfX6wC2wvxQEzzPMr0XpY+p74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988829; c=relaxed/simple;
	bh=ES8cj/orM4NXXZMvj/sxRlVF2TccpkoaMsHEZyjwu/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UIxSU2Db5kW/3cvuG9pmLCj1T3wfWcMrf5/czSe8rgdC3jx9j8FDRFBOkBxhD3EpV76SP6MyHRQzfPhhEDt3SjDovL2GzvGqvsVw3Jqld29wTjcrr/K5GDg7q8WW1PIe6M5DAM8DX5HLEQuZsVG8H32rlX8xf0XF99ilIw3el3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWOYqJcT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6104F1F000E9;
	Thu,  2 Jul 2026 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782988828;
	bh=595aEYbItmYoIcHU9S1ZQN86v5EGSuTLO5+D2/okL8s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lWOYqJcTHnNxayIJSB6fOQNAsZTnI8jqf5wHkONvZQWh6jW3PXaR3R9JElCr8G5Kp
	 KMpnhWSpCYTAn0TcoqP5+UKDuFEcSPVbZHujRmmY2zlu2mkFpxmDyMX1GjVlyumr1d
	 Njegwv8Dsdz+I5tjVr0bfUJr4pHXvBUnlJM6YBkpyU5pEMVynpR2cy3C/oWcfqBrfy
	 QFMBlHS0J+zm11xSieynLKzI2o85Ym5qWNNN2QEVs2a8r+g0mxVF66x3WoVBPkW3tc
	 dWRsQV2utxn/I4lQ3cAZggBdRfWmZ1pJ0iNCekrBn54oszf7o8xZlOvsLwKoDZvLE6
	 Q9t2JB4ELCmGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93975392721B;
	Thu,  2 Jul 2026 10:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: convert UDP getsockopt to sockopt_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298881139.1583217.15443135093169536299.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 10:40:11 +0000
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
In-Reply-To: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 shuah@kernel.org, sdf.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
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
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304103-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 935DC6F63C9

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 07:01:25 -0700 you wrote:
> The leaf proto_ops getsockopt callbacks have been moving to the new
> getsockopt_iter()/sockopt_t interface.
> 
> I was trying to get SMC into getsockop and retire .getsockopt, but,
> I found the best approach is to keep converting other protocols.
> 
> This series starts the same conversion one layer down, at the struct proto
> getsockopt path, beginning with UDP.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: add sockopt_init_user() for getsockopt conversion
    https://git.kernel.org/netdev/net-next/c/b5997f911eec
  - [net-next,v2,2/4] udp: convert udp_lib_getsockopt to sockopt_t
    https://git.kernel.org/netdev/net-next/c/f99d7065a4d4
  - [net-next,v2,3/4] ipv4: raw: convert do_raw_getsockopt to sockopt_t
    https://git.kernel.org/netdev/net-next/c/9588d5da17ce
  - [net-next,v2,4/4] selftests: net: getsockopt_iter: add raw ICMP_FILTER coverage
    https://git.kernel.org/netdev/net-next/c/f4d5e3a5c7bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



