Return-Path: <netdev+bounces-251740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFuIMtlDcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:11:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C4650437
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C55934F92DF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E33314AC;
	Wed, 21 Jan 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgkenn1K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D027FB28
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965019; cv=none; b=TOnSwh9Hc4kB1pKJXSLqEkaWt4E6iZL1GenSYGlVsa/MYQsCdox5GlNIDQoqdv87xY0hTWWiStHx+1JsHpQbHAExcOl93AvINDLS+8AJ5ryUttjbCwkoy4qFPQKe5/CI+4qxx/EFEBsL8gCTbNjnXdyE+rNGIIgZVoeQd1nVidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965019; c=relaxed/simple;
	bh=3VTwJZ4911ZPoVYCNM6vAt2rLjlaUZ1X/YoOJItfOEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XziTkpdpJxlIsxq6Sd1AYd+OT+xWKQytS4zdYbT+y4M+vWapzqWkU2AawmzF+cpTP5AjtAu1DLEAHSNY+PzeQv6RWob3+oEesCi6+nQfSF1DSPIJoO/eB30a4+/C6is+goBeRMbW12k5uCnhJJ75Lyx/v4e/1jV+zhikh1m+4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgkenn1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73718C16AAE;
	Wed, 21 Jan 2026 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768965019;
	bh=3VTwJZ4911ZPoVYCNM6vAt2rLjlaUZ1X/YoOJItfOEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgkenn1KSBwi0yJvValNtMjDF7/ptsM3/df5yHhq3x6Q3PGMb+PosVzsinAHaZcX6
	 idtVgrJOdCfbu951uOWjUwbyIV00JdcVST96gbQO66Zx2FdJPmaM3Pxwf2mO5tPv13
	 2j2fxkm18G5d+AZBJxLHuYmHg1hSvL8qNqcFuWCSkJ+kC9qV6biwDMpyP4ZwyA4h5L
	 NYFElggT5BWcpxAQtWpWtZ9Q9qqiAZ0kFNQLR624kqUnUv58Wuqw5aOYj7BHVvUICr
	 4FqjhaPWA/lMK8xcLtkeM/VCaSqmeuXs76sTzOI6hAbP5U6DyiyncFbBt7EpfdOASy
	 81Ar7Hk7KNj5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B0D380820D;
	Wed, 21 Jan 2026 03:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_rate_skb_delivered() to
 tcp_input.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896501663.707355.4363649836721876878.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:10:16 +0000
References: <20260118123204.2315993-1-edumazet@google.com>
In-Reply-To: <20260118123204.2315993-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251740-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: 31C4650437
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jan 2026 12:32:04 +0000 you wrote:
> tcp_rate_skb_delivered() is only called from tcp_input.c.
> Move it there and make it static.
> 
> Both gcc and clang are (auto)inlining it, TCP performance
> is increased at a small space cost.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 3/0 up/down: 509/-187 (322)
> Function                                     old     new   delta
> tcp_sacktag_walk                            1682    1867    +185
> tcp_ack                                     5230    5405    +175
> tcp_shifted_skb                              437     586    +149
> __pfx_tcp_rate_skb_delivered                  16       -     -16
> tcp_rate_skb_delivered                       171       -    -171
> Total: Before=22566192, After=22566514, chg +0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_rate_skb_delivered() to tcp_input.c
    https://git.kernel.org/netdev/net-next/c/670ade3bfae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



