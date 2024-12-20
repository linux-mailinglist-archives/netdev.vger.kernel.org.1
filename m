Return-Path: <netdev+bounces-153804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920809F9B4B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7E07A154E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F42236EB;
	Fri, 20 Dec 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYXztb2n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B24222D44
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728414; cv=none; b=UYQnndVBVVWx+Bf/Op7tSM0pLiPw1k4hHcjVuv7NNKukFNIa4GoMBA5STEFGb7KY03cgnHZwmdY/xSYQHiRozN6ruVkhUF9wNLdgeviubQOsNMamoPXwvyOExY2LceSgzLx7x+avWZnxt8NAA5+U4pnNtO3QRJspmaDCwANUrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728414; c=relaxed/simple;
	bh=SOXkqMEmAu03o0ChSNj80svlqls47kB/7zH7ztB0UjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E6lbtD0Rn0s93PEB/Ghhp+i4YGRm//OjD/FqiEHqBoIw7V2mfyZrlMGSVdmdnA0+dyV17yzcLwfQWnFR5I+Cw+TrYhvcvgWa2MhwpoGlxRCGKUFqIlw/MAc9WYe3bLCfDhLvADXxDUZ3Lotzlj3Elo8SUTjORuWBaFV+eYXHuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYXztb2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EBBC4CECD;
	Fri, 20 Dec 2024 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734728413;
	bh=SOXkqMEmAu03o0ChSNj80svlqls47kB/7zH7ztB0UjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bYXztb2nT1Z2tojwtGWGXXLl0p4sTHmCA5xPRJK9UXIQSyLh8Kfi+B17dIYv1GvsO
	 pKanLY8FmdMlbf2XopyUAfZpt9+hLw9LrrGebnV7MLAuQzdfRCUpLXEtE2LxPhiy68
	 S99Ix0sZ/o9PvxTAn5wVm29CjWilZq2pUKMBHZACTpsCKxoFGyvVB9qd3JCKEV+l33
	 wdmntvpDctbGiVTom7a7uObZKzHCdCOmpwd95Z0wgZUhsIRVmuTGQkeHYezDS8wMm8
	 0MYiwbN3NtH7HbEKXIoyNS6RLs/lPISn3sCT+YL0m11aJroAGiaNfbnj/BL6mGVboh
	 jByEEYXce1PTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC723806656;
	Fri, 20 Dec 2024 21:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] netdev-genl: avoid empty messages in napi get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173472843153.3019277.8963909942881596835.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 21:00:31 +0000
References: <20241219032833.1165433-1-kuba@kernel.org>
In-Reply-To: <20241219032833.1165433-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jdamato@fastly.com, almasrymina@google.com,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 19:28:32 -0800 you wrote:
> Empty netlink responses from do() are not correct (as opposed to
> dump() where not dumping anything is perfectly fine).
> We should return an error if the target object does not exist,
> in this case if the netdev is down we "hide" the NAPI instances.
> 
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] netdev-genl: avoid empty messages in napi get
    https://git.kernel.org/netdev/net/c/4a25201aa46c
  - [net,v2,2/2] selftests: drv-net: test empty queue and NAPI responses in netlink
    https://git.kernel.org/netdev/net/c/30b981796b94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



