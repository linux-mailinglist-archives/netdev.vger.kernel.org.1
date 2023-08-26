Return-Path: <netdev+bounces-30848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E58789344
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD011C21097
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226339F;
	Sat, 26 Aug 2023 02:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4437F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D7FC433C9;
	Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015825;
	bh=aCPmorHEzmuNMlACKHkRCeQ3VlgK3bOciB0e5LmnkMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UV2F4XPHJjzxKj6SQMMX27DYRSiu0sb4gDYJ7YdJJ/K4q8NtdLCawPSk2BaPCzV0R
	 3rVPbAe5DDuKPfmee0r06kI5Z6OuwgZtKYMtLuyg3S9brxaXPPXEl2+YEYgl4wv/Rs
	 afLs8diJStXQWDoLXb6q5Bp2Wiua2Rp7K7JNdT6l3nC5YKGhQzOL+YscCeQlN5SNtV
	 1DznlI77yscZWchyhWqgrHX/tZtZRdTkrC1g9Wteeb+0crvNlo+TDFOtFQAvllFxYE
	 Y+XmiVVUCWPKj/3Z8aX21cW5pvGCA+32zgzr0WyJvVaXvVM9ZzIsa0cwFBGhF/SYYu
	 HxLwGabvvHpMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B2DE33086;
	Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_hfsc: Ensure inner classes have fsc curve
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301582540.16053.12855800252256693122.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:10:25 +0000
References: <20230824084905.422-1-markovicbudimir@gmail.com>
In-Reply-To: <20230824084905.422-1-markovicbudimir@gmail.com>
To: Budimir Markovic <markovicbudimir@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 01:49:05 -0700 you wrote:
> HFSC assumes that inner classes have an fsc curve, but it is currently
> possible for classes without an fsc curve to become parents. This leads
> to bugs including a use-after-free.
> 
> Don't allow non-root classes without HFSC_FSC to become parents.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_hfsc: Ensure inner classes have fsc curve
    https://git.kernel.org/netdev/net/c/b3d26c5702c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



