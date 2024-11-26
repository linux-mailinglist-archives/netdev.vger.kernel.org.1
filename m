Return-Path: <netdev+bounces-147356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3A9D940C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8097168376
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C018E35D;
	Tue, 26 Nov 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq1Ul6ln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3211369B6;
	Tue, 26 Nov 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612820; cv=none; b=MP+6vPjJTuJT0cDcnej0BSrLk9pjXNBiPYEPlo05RrXmB/S42qIXTtfDGWSmXsqXyxO15e6DoOK4X3RxprupUv4GLH0wY6GTbinjneIPVB0uy/FG2oZkek28C6BijvstF+Kn8jbuMu+vC+pDf9OYjEqCle8JTzCOQBE3kHAfzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612820; c=relaxed/simple;
	bh=U7n/SI5fUPd2Az9BoDV51BCYY+KeSeeSp7nFWQ/q+aI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F3nYNCiFwHr/ShFKsP6ZQAR+YUOU6liqPKqGJywucFwymy0kNNdjcEzHKAn5+sLSZzCuoLaq/VJkrqqIRiROgmJm4d9SpF3cMm0xhD5LkZIBetK2I2jMt3PhVeLyYukJqC0IFywP4dy3pwqdkIPhszXxw+QcX0aqNt88PAvfHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq1Ul6ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E07C4CECF;
	Tue, 26 Nov 2024 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732612820;
	bh=U7n/SI5fUPd2Az9BoDV51BCYY+KeSeeSp7nFWQ/q+aI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Eq1Ul6lnKBWRiRGsp0bobP+YIsFPdqPImMLsPamoHc3qARhLqo3ur81Ad23gvsS1x
	 evU8IxMttCAmtIXyNHZwZm0ms12DZHn9gOR/NzdUFVoCB1hWtzXU2gYL5zSrchlX3t
	 W935l8e10ub+nwMSmTDVAz0mGTuw0v1q/NIrgY6FyWp2squbWhFkiD437zmWLCz2jk
	 uh7w2sisvcwwxYeUwJSaobjwKfvvpeF3LbS5mAkaOp8kgfz4j1EKgpMXnM1r9qqdO+
	 /jSmMZWIQYnr3lrpb/bRftzDUeIq3pU84SPFusaK50P285TmpUcRlq7Vh26SmDlUWS
	 RErLUZOksnF3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFA3809A00;
	Tue, 26 Nov 2024 09:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/3] Correcting switch hardware versions and reported
 speeds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261283301.319179.8241614994129494508.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 09:20:33 +0000
References: <20241120075624.499464-1-justinlai0215@realtek.com>
In-Reply-To: <20241120075624.499464-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, michal.kubiak@intel.com,
 pkshih@realtek.com, larry.chiu@realtek.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Nov 2024 15:56:21 +0800 you wrote:
> This patch set mainly involves correcting switch hardware versions and
> reported speeds.
> Details are as follows:
> 1. Refactor the rtase_check_mac_version_valid() function.
> 2. Correct the speed for RTL907XD-V1
> 3. Corrects error handling of the rtase_check_mac_version_valid()
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] rtase: Refactor the rtase_check_mac_version_valid() function
    https://git.kernel.org/netdev/net/c/a1f8609ff1f6
  - [net,v5,2/3] rtase: Correct the speed for RTL907XD-V1
    https://git.kernel.org/netdev/net/c/c1fc14c4df80
  - [net,v5,3/3] rtase: Corrects error handling of the rtase_check_mac_version_valid()
    https://git.kernel.org/netdev/net/c/a01cfcfda5cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



