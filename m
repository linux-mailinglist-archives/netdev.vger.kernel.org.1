Return-Path: <netdev+bounces-44649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403747D8E29
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA07AB210FA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894255CBB;
	Fri, 27 Oct 2023 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvo5n6Jl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2F7612C
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2292C433C9;
	Fri, 27 Oct 2023 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698384627;
	bh=4CWjoHhCr3X2E7xAcEv+eOauN9xR9PQxvGnRuz2M7f8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rvo5n6JlM9HkL9tiR+YtYBZ8lPs+RHHIi0KI1Vi/29KjTcfOxA0s2CFZr1Kk3Y6Be
	 MRR/kaTyZxgB+8oS2X6GtY68YMPIehmu0rLdQq4c0A8W2maXBwEwmTq3iigujAsFy0
	 2I+BT31EfZ8YT45VBR4SZAlWRz5T/i2wQA3Tx0Tieou+aqYfzvWtwDyP0SJmITdIWQ
	 /E2yN5wQiDkUv4D0ThQzW30pl4NzX19jmE+HWgXQLh7WoZrGTn9dUscIVSJvS8QZq9
	 Mp4vedvUz1sP5zQmuY6Xa2IpSt/poUBrNjLdgRBZ6OQU/smRloj1ixTQNLgtnh05dt
	 QlCQVeLp9/r4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA816E4CC0F;
	Fri, 27 Oct 2023 05:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] MAINTAINERS: Remove linuxwwan@intel.com mailing list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169838462775.19664.12297909147407168362.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 05:30:27 +0000
References: <20231025130332.67995-2-bagasdotme@gmail.com>
In-Reply-To: <20231025130332.67995-2-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 20:03:32 +0700 you wrote:
> Messages submitted to the ML bounce (address not found error). In
> fact, the ML was mistagged as person maintainer instead of mailing
> list.
> 
> Remove the ML to keep Cc: lists a bit shorter and not to spam
> everyone's inbox with postmaster notifications.
> 
> [...]

Here is the summary with links:
  - [net,v3] MAINTAINERS: Remove linuxwwan@intel.com mailing list
    https://git.kernel.org/netdev/net-next/c/cc54d2e2c58a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



