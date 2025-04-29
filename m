Return-Path: <netdev+bounces-186616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A45A9FE3C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B50146393F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F16EAF6;
	Tue, 29 Apr 2025 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0TKN022"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD50802;
	Tue, 29 Apr 2025 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886592; cv=none; b=QlrNQ2wrv5Ok5daPF31FcFjATFqylKq31iLoogIGAar1+TeQl6SqFc7/L/p9p2EVJCK77VEF/M/keQoyHPdIuj4+qKPhpgQHDC/dl2VB09T/jkUpfChZxPkxh/HIJ3GYJDJLgcPSf/kxGyleGbrKcxpdJPRKbm5k37/Xhq8sgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886592; c=relaxed/simple;
	bh=xLvpM+/YuRZqwaRcqxD1kjCWYPLCDIfbBOLIg1SMM40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxC9tWjktYA92hen0Dr6pIRHpSddQgn42hc8OPozoD4/3V4S130Okq31n8w13nWrTNJqElQhI8kS4THYq/amd2TjazlxpuOjYffI5ke5MGKqGqK0sfu3R+/n4oVd2fyHjAFhypUQ5J6N4CqJPyGjkTvBIOITlIMxJ9a7AqE9GtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0TKN022; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DB8C4CEE4;
	Tue, 29 Apr 2025 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745886591;
	bh=xLvpM+/YuRZqwaRcqxD1kjCWYPLCDIfbBOLIg1SMM40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H0TKN022OBo+yn8vkT+oPyNAhr90AwmTrpcYsory0cjH1Jc8N3vZ7z9ZFLCKPcjpE
	 ombPm2xswWQAHqZP7OJKpBZkEP06mqxGjtRgeNeQQz60Ro+EecpCkyxIQI+CmKogod
	 SPf7v/JOBZduqwm7DjZ0EhfZm7J8Flw7hiC1zwzyz5ZCzL1qjBWUm/QZyhqhN69MNH
	 Yhh8n3PVgHhapQ8LJ+FhPX3GJqWR0f4ajg7yCdno74nhmtiKeb3zrcLYILkghzBjv1
	 SNljoD0ABy+LMW4pa9i5tmnGT81Vb+7X4AMTgeC0f5ttURx9IJJYJ0BqKBq95APsYq
	 h29HxEULil7fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0A3822D4A;
	Tue, 29 Apr 2025 00:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ti: icssg-prueth: Add ICSSG FW Stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588663075.1088650.16999100387793787155.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 00:30:30 +0000
References: <20250424095316.2643573-1-danishanwar@ti.com>
In-Reply-To: <20250424095316.2643573-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: dan.carpenter@linaro.org, m-malladi@ti.com, lee@trager.us,
 maddy@linux.ibm.com, arnd@arndb.de, mpe@ellerman.id.au,
 andrew+netdev@lunn.ch, rogerq@kernel.org, corbet@lwn.net, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
 vigneshr@ti.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 15:23:16 +0530 you wrote:
> The ICSSG firmware maintains set of stats called PA_STATS.
> Currently the driver only dumps 4 stats. Add support for dumping more
> stats.
> 
> The offset for different stats are defined as MACROs in icssg_switch_map.h
> file. All the offsets are for Slice0. Slice1 offsets are slice0 + 4.
> The offset calculation is taken care while reading the stats in
> emac_update_hardware_stats().
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ti: icssg-prueth: Add ICSSG FW Stats
    https://git.kernel.org/netdev/net-next/c/0d15a26b247d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



