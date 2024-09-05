Return-Path: <netdev+bounces-125716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCFC96E5A5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 00:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371FA1C2371F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416C19E7FF;
	Thu,  5 Sep 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlaAuTt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA818F54;
	Thu,  5 Sep 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574232; cv=none; b=Tu3K/xoBd8rKda4x2BK191dMy5PxghQKAigZCWsH1a4z+jqqOV1X9pIEddvoMqomnapDdOi9QQj0jsgOxKBed761XsSWCw6Jh9PXhVE+un7cs8QyPiynWxz7GPmeGxvC8zCRIWNWorF8VJi1nLEyjwuzsTyIOQZSZLTQe4B7zpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574232; c=relaxed/simple;
	bh=5WeUaool5XelhNtSrzbPgfN+tE2/bfbks0TdybwodkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WsfZvnGc4kOpqE4cuH0/394T9S9hK7vZJF9Zl+84jGUNcoEPJI7DI84HGeefX7ijyII4USi1/h9QHeBQstPjX54uOrHGc8XtYTBcrDHrX5KkcPyga1/ncumMTLHDRD5IoWUYxqQzh+2xRVZTmrA6hlF9pWVuPCO6+ehaVufknqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlaAuTt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DABC4CEC3;
	Thu,  5 Sep 2024 22:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574232;
	bh=5WeUaool5XelhNtSrzbPgfN+tE2/bfbks0TdybwodkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WlaAuTt/RJxbMF7lcDMZ4yIWtjT8LiCzXCuxpMqVK9ynk5KtdpDaG6WXyNfNoYVA+
	 YT7rOlfnOSFwPWfQuXDwCwqM3Y05lKfV5l77eQ9MtRGK3ma/5RmQSq2KzVRglDkdkM
	 2bFOY0Jne/2TxsI5/HFFDkB1wQBsQXgMWrMX8Gl7wR/HpWTEejYTCOV+6A/DKG+OhZ
	 dM/OZkExk8awf0rtToM38p3sU5rKMC1lxING48S50CEZLaN1QCEO5GhRl2sFA7oZqa
	 LYF5NBFqU2X9Dil8uOfNSSyMJHY+xie2rY9Jysiy/EK00AY6Q4EfIdsbJRWeEGLGK0
	 YzSg5Tod4J8Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6D3806654;
	Thu,  5 Sep 2024 22:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tools/net/ynl: fix cli.py --subscribe feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172557423298.1859883.15275534702846034273.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 22:10:32 +0000
References: <20240904135034.316033-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20240904135034.316033-1-arkadiusz.kubalewski@intel.com>
To: Kubalewski@codeaurora.org,
	Arkadiusz <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, jacob.e.keller@intel.com, liuhangbin@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 15:50:34 +0200 you wrote:
> Execution of command:
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml /
> 	--subscribe "monitor" --sleep 10
> fails with:
>   File "/repo/./tools/net/ynl/cli.py", line 109, in main
>     ynl.check_ntf()
>   File "/repo/tools/net/ynl/lib/ynl.py", line 924, in check_ntf
>     op = self.rsp_by_value[nl_msg.cmd()]
> KeyError: 19
> 
> [...]

Here is the summary with links:
  - [net,v2] tools/net/ynl: fix cli.py --subscribe feature
    https://git.kernel.org/netdev/net/c/6fda63c45fe8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



