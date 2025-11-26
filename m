Return-Path: <netdev+bounces-241744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB94C87E57
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61598354E16
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528C30DD36;
	Wed, 26 Nov 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSx9XBXF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1430DD12
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126064; cv=none; b=nUNpBW7xbZOr3wrQWjpmiIPli76baxfPBAvyrIPLNcPgS92fNhJUjZo6DKsDzYBna4Ejbqdkk+iOGRslVBEMmC0fuu4DhNG1JYC6ljP4FwtAU7LE+C2Yft/1HbXGuyY8aMRp13ORF+z1SaaPq40HWSAurvvAtDfDK4csRhQ2RH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126064; c=relaxed/simple;
	bh=p2Z/Am8wzTtPOUyq+dWDUj1ATG3Z+6lYg0Yi/G3qAhw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8+/mEzQEpHYrwpz4dwRyvwEgI61wcVVCuGPLFDJuPq3xzEpxH+yevJiUTHlfVilspLNyuGZzy4xQkyv9L7gb9GHr7te1JLN0ovdMA1XclogYjpxgXYOjhNlNPuN6Dquy5a5neqaUz1u/K8Q+zzA509ZMyVhnFuA+zBRFXFOrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSx9XBXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CDEC4CEF1;
	Wed, 26 Nov 2025 03:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126063;
	bh=p2Z/Am8wzTtPOUyq+dWDUj1ATG3Z+6lYg0Yi/G3qAhw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nSx9XBXFQ4MfzuxXJ2ApOMufkEwWXW1ai3yYptISt6dGGDH1SNvv667YTwdD18ed/
	 Mz/FLrD4DOVRzoBaBWOmo9PPpvWr1LReaCFHqx4mUsMnCDiBpOjGLrvqscxDG8iJ9z
	 p6xaiDMX+AOiu8H7prwqPz/2NANyeJRcQYnvHdNgE4bfWT9/5Km/WqnO7RM+b7WnCN
	 impgIwr5+8gNXHgOU2c5bDVWcu+9/2ywNSQFePKW74qYEa25DVXAX/tVnK2O5OeE3f
	 GfVsGoix5R+QMZEKkeOOiSIDP8hY72f/yflh8kEBoDVVX1BQEZQQwGr4D6HoVXTDMj
	 9Jf9FPGEc/M0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB527380AAE9;
	Wed, 26 Nov 2025 03:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] Improvements over DSA conduit ethtool ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412602574.975105.13077434845161530446.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:00:25 +0000
References: <20251122112311.138784-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251122112311.138784-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 13:23:08 +0200 you wrote:
> DSA interceps 'ethtool -S eth0', where eth0 is the host port of the
> switch (called 'conduit'). It does this because otherwise there is no
> way to report port counters for the CPU port, which is a MAC like any
> other of that switch, except Linux exposes no net_device for it, thus no
> ethtool hook.
> 
> Having understood all downsides of this debugging interface, when we
> need it we needed, so the proposed changes here are to make it more
> useful by dumping more counters in it: not just the switch CPU port,
> but all other switch ports in the tree which lack a net_device. Not
> reinventing any wheel, just putting more output in an existing command.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: dsa: cpu_dp->orig_ethtool_ops might be NULL
    https://git.kernel.org/netdev/net-next/c/eba81b0a6de3
  - [net-next,2/3] net: dsa: use kernel data types for ethtool ops on conduit
    https://git.kernel.org/netdev/net-next/c/8afabd27fe46
  - [net-next,3/3] net: dsa: append ethtool counters of all hidden ports to conduit
    https://git.kernel.org/netdev/net-next/c/f647ed2ca78e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



