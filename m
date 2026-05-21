Return-Path: <netdev+bounces-290553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC3ZAOc+D2pzIQYAu9opvQ
	(envelope-from <netdev+bounces-290553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3545AA1AC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C81C3201A14
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD40370D61;
	Thu, 21 May 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBTCkE56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92437105A;
	Thu, 21 May 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379211; cv=none; b=u8gbyvlrp31IjC+cQD7++B/Ot/ilIXKoxemMa03lb3D1+Ng/3MJWCjP0QTnjVmNwFYrH6Ih6plUvaHkCNCbZwbCS25IvjRluffJqhTtplBDxUCYiI6FoFf4MvB/K7Nje56NRFFAkRGrvwvm8IelvU8MJ1DZ9kKI451HBbKz1DP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379211; c=relaxed/simple;
	bh=ju2uWccE12fiqVm7wE+fKfZwZ6h73RpNrbldnR/9OG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fUUgCGuDakKSF7slmFdg8YPAK9idIiS4meiYr4NCTX2ac3WK8wFu6N1fOpm2k+cJ2sDNJyWYVpIkqw9PeiVqJHKbmHJXnsVzfSm8WAQ+IzWTIuzwPsM+E1FddQzPW8djUPUW3EwvZpws1jRG6CrnJaNzM8R1hkPPmQC3eTGd02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBTCkE56; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF371F000E9;
	Thu, 21 May 2026 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379210;
	bh=vRbmhKzqEo/N7s1MY7vJImxIbVLPP2pirP6DywPqASI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YBTCkE56mBgtCGHZXIOednJ6a5ScxIALFh8Gf9Rt8KHlqTt2aCyq9ThLmbQrO/Idx
	 el6ichzL/wL8kLD7SrR0EV3LTNc3g+PCt0FdwzIZ4vVOXya2ufsb1e1axW2LoP1dRj
	 vLk0/e/bhH0dk6VBpEm1D8EQWs+9lcs+PPt+/c+aJlxvcaZI88o1GELP1fTxRqHKg+
	 SGvrUpF0Z8hKMXKTM1oTiYRoWHLbs1nb6v5bOw6Wzn+9p2YuB9ASFGpKC8QCr79QMW
	 zN4Nt/KMpEv47lCr5JIMqMJNh1VLCdQ2pxfrK+iMWt/hzrmfSkBPuqSRE60lV8E3Yx
	 vqmKcWkIGAfEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699B3930E0B;
	Thu, 21 May 2026 16:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/9] net: enetc: SR-IOV robustness and security
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937921988.398712.17366244673033381497.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 16:00:19 +0000
References: <20260520064421.91569-1-wei.fang@nxp.com>
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 catalin.horghidan@nxp.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290553-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC3545AA1AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 14:44:12 +0800 you wrote:
> This patch series addresses a number of robustness, security, and
> correctness issues in the ENETC driver's SR-IOV subsystem, focusing
> primarily on the VF-to-PF mailbox communication path.
> 
> The series can be grouped into the following categories:
> 
> 1. DoS and security fixes:
>    - Prevent an unbounded loop DoS in the VF-to-PF message handler,
>      which could be triggered by a malicious or misbehaving VF.
>    - Fix a TOCTOU (Time-of-Check-Time-of-Use) race and add proper
>      validation of VF MAC addresses to prevent spoofing or invalid
>      configuration from being applied.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/9] net: enetc: fix incorrect mailbox message status returned to VFs
    https://git.kernel.org/netdev/net/c/8c84c5ec4aaf
  - [v3,net,2/9] net: enetc: fix missing error code when pf->vf_state allocation fails
    https://git.kernel.org/netdev/net/c/5027266dea47
  - [v3,net,3/9] net: enetc: add ratelimiting to VF mailbox error messages
    https://git.kernel.org/netdev/net/c/4a995d37b537
  - [v3,net,4/9] net: enetc: fix TOCTOU race and validate VF MAC address
    https://git.kernel.org/netdev/net/c/c666fa632fe6
  - [v3,net,5/9] net: enetc: fix race condition in VF MAC address configuration
    https://git.kernel.org/netdev/net/c/f262f5d89332
  - [v3,net,6/9] net: enetc: fix DMA write to freed memory in enetc_msg_free_mbx()
    https://git.kernel.org/netdev/net/c/adb4599979cd
  - [v3,net,7/9] net: enetc: fix unbounded loop and interrupt handling in VF-to-PF messaging
    https://git.kernel.org/netdev/net/c/f8ae63de2a87
  - [v3,net,8/9] net: enetc: fix init and teardown order to prevent use of unsafe resources
    https://git.kernel.org/netdev/net/c/54362b017608
  - [v3,net,9/9] net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
    https://git.kernel.org/netdev/net/c/9e68817f12d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



