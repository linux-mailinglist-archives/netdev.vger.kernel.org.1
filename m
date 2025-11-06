Return-Path: <netdev+bounces-236427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E82C3C1E4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B78B735196A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735429ACC0;
	Thu,  6 Nov 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRljxcDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCE29ACF0;
	Thu,  6 Nov 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443645; cv=none; b=Fa4/nMo+dDQNqCt5GMJT++eE87WkkfuXjkKqAwbGRJtF4NiedzgPc9yyd9fd0izmZTsEA3OGofAFf7ohBrW6nOzHEkV98ozmwmYJWScuV4WMA3D3IaVFjGk5wD4hJK8eJ3wWiWinOyjRcJWWzGUOZn+Wo2fb4BW/NKRulucJ6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443645; c=relaxed/simple;
	bh=eT2q8erGB+/KVnsBfN98cIr9uTO+vnVu1FxePouL63Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kHvakSFxzKdFn+vFwKY7Amod7vEwajtAqSGps6aL6adW0BYeXBLx/V8JgFM48GMXUNjow6HiJDyykWviiUXIFfdwUupDdo9DWNXrERIXEiW4GpP7cDA2dzeOqt2o7UOWy29fHYoNk7PZ7EU/dgbhyD69xWQMNXdZcL/38WZPcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRljxcDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935A4C116D0;
	Thu,  6 Nov 2025 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762443644;
	bh=eT2q8erGB+/KVnsBfN98cIr9uTO+vnVu1FxePouL63Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BRljxcDAHVolP8ZOWC73Imo0SzT53rLNqbAG8HNd99rVSY/2gdgKDH9GF3xZMDOHP
	 o27ddZ5xwDdXJ2mgzczWZ34Gd8q7szaWu81o58n0m4a/aApo1ZpBDculUcEdKYXaqY
	 TuBXesMiP/wJnIbNS+OCAUn+G6OoFzU2y81L1mMis7Mw/gElilt3D0Eueo3UfF+PqR
	 xgwpQbqR1QpF9Mnu2dJvfyLImKqKptQqdH1HZWKFcMUGvNKj6iXYyR2415bwsukHM6
	 Fpsm9I8QubQnmmH7/TPqCtcfteD5Q15PjqaYk9oW5plZBiQ9FWsQGk+CxZTXW6sQ0C
	 lZiRf5E3ul5PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE439EF947;
	Thu,  6 Nov 2025 15:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: bridge: fix two MST bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176244361750.255671.13047904965376024193.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 15:40:17 +0000
References: <20251105111919.1499702-1-razor@blackwall.org>
In-Reply-To: <20251105111919.1499702-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, idosch@nvidia.com,
 kuba@kernel.org, davem@davemloft.net, bridge@lists.linux.dev,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 13:19:17 +0200 you wrote:
> Hi,
> Patch 01 fixes a race condition that exists between expired fdb deletion
> and port deletion when MST is enabled. Learning can happen after the
> port's state has been changed to disabled which could lead to that
> port's memory being used after it's been freed. The issue was reported
> by syzbot, more information in patch 01. Patch 02 fixes an issue with
> MST's static key which Ido spotted, we can have multiple bridges with MST
> and a single bridge can erroneously disable it for all.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: bridge: fix use-after-free due to MST port state bypass
    https://git.kernel.org/netdev/net/c/8dca36978aa8
  - [net,v2,2/2] net: bridge: fix MST static key usage
    https://git.kernel.org/netdev/net/c/ee87c63f9b2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



