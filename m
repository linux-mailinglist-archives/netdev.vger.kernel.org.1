Return-Path: <netdev+bounces-241739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D53C87E42
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFC352162
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72193770B;
	Wed, 26 Nov 2025 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHKbll8/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE7FBF6;
	Wed, 26 Nov 2025 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126039; cv=none; b=iN5pEBb+c+3DnZbv2fjdlUMzqs4DQAbbNzVCj0r2TwPOgkdk4HWq1XHO0oCYQkEYgbkcKFR5Zq/TjKEADohn6aV+M4j3Alwxqiq6nAt3jOcpMvCBfB8I/afkRSESQ0G0TVUrcy6kf5g5KXAjYoto7lmIUDkIqHUbN68VuHB0tmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126039; c=relaxed/simple;
	bh=so6/0hADVphgyY3Xzb6VCo5Vw9FFc2ZLjPJWCawckNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f+H42zMAZ5ia9zcKksFJE8JiptiJPgu3HpGp/npmmZQP4kXk51ED6lm62UFPvLzB329dpxBDYfTBgXQTJDQeTT08om4pkFQCYtA8Lo8YfpNISRm8EwZK2LpBp4XemVfnx93HLrVFKGUg5syPOH5YPILFRW441PiUJwH97krjMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHKbll8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08787C4CEF1;
	Wed, 26 Nov 2025 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126039;
	bh=so6/0hADVphgyY3Xzb6VCo5Vw9FFc2ZLjPJWCawckNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RHKbll8/WdS3FTgzIW71YUvh4EHuGnHRPPbEH71fVunlz5YhCCCZMf6/nlc9hFGF6
	 IVnT6LbctrAKk4ROK6LvmwRjh+Ipj/ZQyu/0ZHOPt5k2SEPuQvHJ4Df3E6Uwkajm32
	 sx7aFES2m/f0ZRGLQ96pPu10eOtKJD/3CxzZfdbWRWDvBRyYcrDawLZJUM0j1yevkb
	 2iK34i3eHd/NwKGbDCWgXnBT5WJNLbSpQfLl8oYOr6Tqbfrw5svpkMsvI1heYCBwVo
	 +i7X2gQxigC1J+SP62iE5Z+8Yrx5fQlOwCokxcsL4jc0+L3lVROhLW2WMphjBT/HKZ
	 qW5GaI5/peH/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71ACA380AAE9;
	Wed, 26 Nov 2025 03:00:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] team: Move team device type change at the end of
  team_port_add
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412600124.975105.14229748246152064964.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:00:01 +0000
References: <20251122002027.695151-1-zlatistiv@gmail.com>
In-Reply-To: <20251122002027.695151-1-zlatistiv@gmail.com>
To: Nikola Z. Ivanov <zlatistiv@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 02:20:27 +0200 you wrote:
> Attempting to add a port device that is already up will expectedly fail,
> but not before modifying the team device header_ops.
> 
> In the case of the syzbot reproducer the gre0 device is
> already in state UP when it attempts to add it as a
> port device of team0, this fails but before that
> header_ops->create of team0 is changed from eth_header to ipgre_header
> in the call to team_dev_type_check_change.
> 
> [...]

Here is the summary with links:
  - [net,v4] team: Move team device type change at the end of team_port_add
    https://git.kernel.org/netdev/net/c/0ae9cfc454ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



