Return-Path: <netdev+bounces-83448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3189249A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DCB1C2167F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA8013B5AE;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIioiUzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF513A403
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741829; cv=none; b=DPqz83r6vr5yRRBBkrW/XPdnVe7q5RS6DvNb0kzbgvna7HcDU4jxpaICfth2r2+ADBbaU0tYuMht7GAiXplRQtQB+UAKCPIOFuftDllUZFicu9jPEGoT0LP+BWpZI/jeyIK7Op+TsZqZQZ4fvPq2BkFCfpiShB9F0/E3RUp6l3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741829; c=relaxed/simple;
	bh=EHQh4yZu1jmvCKG2caFvvwqJKl5Z8h6Vf86rVmA4ijo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bkLIryxLoDSL8HK+J2TK21SKweELgjJK4f+birBezL760GABp8CjihSLdkmOX/B97twEXjiHzdexcoPIgTAKlJ//ivlmsZC/37p0We/AbbAQS0PQzIgVEl3I6e6sBsicnDKhhesRwD7tk2dEe6dkmw58Il2llYFa90o9oarx45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIioiUzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A299C433C7;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741829;
	bh=EHQh4yZu1jmvCKG2caFvvwqJKl5Z8h6Vf86rVmA4ijo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YIioiUzB22/aDGdUv05l45m7kZgoGUOUS0/d1z/qIjnuwJRCdgMMArWxSwEl0ouGH
	 2vp9F2ULJSVvQqGAd34oPYE8JXFvuMkLgsy3LmuyZDFhi9JTSUgvqDny8yt/rl9D/8
	 Qbyo1UtnG1QBuoK1pB2tCHSUce01GlDim5JTTPasGcm8fBgKkIAkHkyKWnvC8xWGRr
	 cE2hKhZjM5YbtHTxWJiu3mPKpgwRgYu5Lhz15ltG2Nm7rYAaugHlnkcicCQlTqu+NM
	 0kmdVLz94a+KEv2x8HCVLPNk2JGnf4RCkT2R5Maxl4bri33FQdI0Wdja6SaXRU+Y3w
	 hmYPMY9UeNlmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A604D2D0EE;
	Fri, 29 Mar 2024 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] r8169: skip DASH fw status checks when DASH is
 disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174182910.31276.13437986035960030239.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:50:29 +0000
References: <20240328055152.18443-1-atlas.yu@canonical.com>
In-Reply-To: <20240328055152.18443-1-atlas.yu@canonical.com>
To: Atlas Yu <atlas.yu@canonical.com>
Cc: nic_swsd@realtek.com, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 13:51:52 +0800 you wrote:
> On devices that support DASH, the current code in the "rtl_loop_wait" function
> raises false alarms when DASH is disabled. This occurs because the function
> attempts to wait for the DASH firmware to be ready, even though it's not
> relevant in this case.
> 
> r8169 0000:0c:00.0 eth0: RTL8168ep/8111ep, 38:7c:76:49:08:d9, XID 502, IRQ 86
> r8169 0000:0c:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> r8169 0000:0c:00.0 eth0: DASH disabled
> ...
> r8169 0000:0c:00.0 eth0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).
> 
> [...]

Here is the summary with links:
  - [net,v2] r8169: skip DASH fw status checks when DASH is disabled
    https://git.kernel.org/netdev/net/c/5e864d90b208

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



