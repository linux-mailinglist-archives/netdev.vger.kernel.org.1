Return-Path: <netdev+bounces-259187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH/JEW4UlWlYKwIAu9opvQ
	(envelope-from <netdev+bounces-259187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:22:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1647152823
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BAE33068F29
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1502E3360;
	Wed, 18 Feb 2026 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+AsTbqV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2682566F5;
	Wed, 18 Feb 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377629; cv=none; b=lMDGyH+jQf1eadq2Gz1O6CevgT73z7+kuOogyzpsSAsutm0MY6x3Ck+ynX2Y1HTjeR4D3ApF9THbnfLmRuiIkdutVjKdq84uVEDFNtbiRn/HHBaxyKO5njTYg6z8kE3ZjWFQJGE7Z5mBGTz54LKruByS2nzO9WCuutUYUEFbzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377629; c=relaxed/simple;
	bh=5HJKVWMzu30Szhzrip5v9/qgKLiQydX0FsZ9zdkx4Cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ARXdW1yeIUw+JgmHThXCw4CiLPp0ZUIDXF5Y/MsPaIdtbYIHLbc9Y1Ip3GSq6JIobN2rLpI2G14Osj1Y7W3Ux3Q03ev2Go5NUhcu1RVRK8OXlgMYOGExhmTvmSrwaoruLyxqYA7UX5rbHUStXIA389bWbFXdDu3VdmLbg7L7lQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+AsTbqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947A3C4CEF7;
	Wed, 18 Feb 2026 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377629;
	bh=5HJKVWMzu30Szhzrip5v9/qgKLiQydX0FsZ9zdkx4Cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W+AsTbqVd1RLE6OLYJ+PniYU7D1LVUws1WqjU6A00PxaRkm9q9j+U84/QjH4PedSj
	 mrmWPr9sPl3/olzksoUxvVM4X2xjMuvW32j/kM40I2o2+KzEINk+GyZL8sFgWFyVaZ
	 YhMiMteShdLSLi+wpdC07UNPiiYLx7JiX2R3QB5DakxvTjy9lxMTsyWhdkIZpLHCnZ
	 oHMXVzyr6EM8wv0CjmUq6W7lGesA1lwsmMLlfzLIuJ11/yD05oFtvWCTLY4JO0TwYA
	 JP7MWlZqMiyzs1N6dklv7hQSAh1Rl6YM2Lb4jchywfFLUg1ArrYs20S0u2DxvSjm0u
	 3VeWPTMBICF3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851203806667;
	Wed, 18 Feb 2026 01:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: tc_actions: don't dump 2MB of \0 to stdout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137762107.765825.9932056227407403951.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:21 +0000
References: <20260214035159.2119699-1-kuba@kernel.org>
In-Reply-To: <20260214035159.2119699-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 marcelo.leitner@gmail.com, jhs@mojatatu.com, dcaratti@redhat.com,
 linux-kselftest@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259187-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,mojatatu.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tc_actions.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1647152823
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Feb 2026 19:51:59 -0800 you wrote:
> Since we started running selftests in NIPA we have been seeing
> tc_actions.sh generate a soft lockup warning on ~20% of the runs.
> On the pre-netdev foundation setup it was actually a missed irq
> splat from the console. Now it's either that or a lockup.
> 
> I initially suspected a socket locking issue since the test
> is exercising local loopback with act_mirred.
> After hours of staring at this I noticed in strace that ncat
> when -o $file is specified _both_ saves the output to the file
> and still prints it to stdout. Because the file being sent
> is constructed with:
> 
> [...]

Here is the summary with links:
  - [net] selftests: tc_actions: don't dump 2MB of \0 to stdout
    https://git.kernel.org/netdev/net/c/32b70e62034a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



