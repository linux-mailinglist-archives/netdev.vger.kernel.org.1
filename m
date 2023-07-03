Return-Path: <netdev+bounces-15058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C2745739
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841D2280CEF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAA20EF;
	Mon,  3 Jul 2023 08:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB421873
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A82F1C43142;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688372422;
	bh=GxeUVIJCdFCWArdj/M4O9jXoh7JeOWj98dzpD1mHQg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OUfJyuohTDrVlmpyrYvbOYvE0FLVMJz905MMdG9twjO96iYdG/cqgcKAX9mIguWlm
	 SgV/kng3mKDGR4wcmmwzeMeXkw48SthqPmZhwdCYamGij7GO+0fRkaq6+ezXHsU5cJ
	 Iln8AdXyTjEiSo4VsMSExXEsotRshrbB6oKZvzhABQFcnZTK6LEyU3D/p0Xd3S6Yrq
	 GDw3cvPAYUtn1m9jf1Z3fmDHZ4uhRmHymZ2WYqd6xAC9P85F2REJds22JErns5v2Tb
	 9z3cDesgsei4P2M8zZDgsnJx6imBC3Wh/DF6SEvn5xIw+34xlFbKGZpZQgK3Jx/QHD
	 mRHue2udqnxCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84F04C6445A;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples: pktgen: fix append mode failed issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837242254.9798.3607363050710533802.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:20:22 +0000
References: <20230701143737.65471-1-mars14850@gmail.com>
In-Reply-To: <20230701143737.65471-1-mars14850@gmail.com>
To: J.J. Martzki <mars14850@gmail.com>
Cc: linux-kernel@vger.kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  1 Jul 2023 22:37:37 +0800 you wrote:
> Each sample script sources functions.sh before parameters.sh
> which makes $APPEND undefined when trapping EXIT no matter in
> append mode or not. Due to this when sample scripts finished
> they always do "pgctrl reset" which resets pktgen config.
> 
> So move trap to each script after sourcing parameters.sh
> and trap EXIT explicitly.
> 
> [...]

Here is the summary with links:
  - samples: pktgen: fix append mode failed issue
    https://git.kernel.org/netdev/net/c/a27ac5390922

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



