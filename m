Return-Path: <netdev+bounces-251732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK/aFIg/cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:52:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F26C0500CC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1560190D3ED
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8F34A76F;
	Wed, 21 Jan 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aaw27CZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2228134C
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963810; cv=none; b=SGi+u8eVT4sDZIN0SWI9AVN82IssKcUjUn+3ccK+FnqJ3Jcqmx9dnJCUjMdxgLOfnnWMSKTbOkzdo5W7pRrggaXKlEgKcedHY7JDoFXm+uKwHvnL3l8x6fjhJ5MjN769sGPn/cBySDRPAmv9/cROITi0X7KOY9OYeabXwG8TUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963810; c=relaxed/simple;
	bh=2JaN+w2hJp25XWBIqkwpIilI8onoMVBu0DQ/tamnXjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Am5Q8PLMVJ2M5Es1O0SGR9XF6smclFp0mLQVgSJs2PLq93LxnwXnPvEzfekYvg9jWl1Q90MqB1wUzAk7FyR69Yq2V7B40EHWShs86laDS0TDjEXrmsw8lP6oOStpV/UEV/4zw+SwoO6cqQugkLLkOwsMJlBb65PXjyHHdpk+uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aaw27CZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5322C16AAE;
	Wed, 21 Jan 2026 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963809;
	bh=2JaN+w2hJp25XWBIqkwpIilI8onoMVBu0DQ/tamnXjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aaw27CZT5UkPSVnaeTaerLZxGSJKqgyHmVmXbZ+EWv07lO4PvvSkGB8s2dXIC/27O
	 /hYEZPbp/+SwbwW7EeBvGXI48kOjw5yREkgC9cl727606FRI3hCdD5vmlWi9gcfbh7
	 2Y8spWgXiYZIxHJ4ZsoGDvQ8PCK9V0IxTqobufFt95HjvATNNKJIDfO52y8JvweY+8
	 v53Q6fmyc9CypHyP/b9blfk+mP411NDBEHKrevIPwzmDn3HPjzNciZF7wQ7DuGhd4f
	 98v5wKXuvddn/zkRbdAyNdz1L6pGoPaTu3ex1WlwchFc9NjMBpPz3Si4KII0ku1b9v
	 j+F24LD1Gv/tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B950380820D;
	Wed, 21 Jan 2026 02:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: annotate data-race in ndisc_router_discovery()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896380710.703462.8842807403305053561.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:50:07 +0000
References: <20260118152941.2563857-1-edumazet@google.com>
In-Reply-To: <20260118152941.2563857-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com, rocco.yue@mediatek.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,googlegroups.com,mediatek.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251732-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F26C0500CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jan 2026 15:29:41 +0000 you wrote:
> syzbot found that ndisc_router_discovery() could read and write
> in6_dev->ra_mtu without holding a lock [1]
> 
> This looks fine, IFLA_INET6_RA_MTU is best effort.
> 
> Add READ_ONCE()/WRITE_ONCE() to document the race.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: annotate data-race in ndisc_router_discovery()
    https://git.kernel.org/netdev/net/c/9a063f96d87e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



