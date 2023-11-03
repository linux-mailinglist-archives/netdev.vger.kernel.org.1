Return-Path: <netdev+bounces-45875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D997DFFF4
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65706281E11
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7211188;
	Fri,  3 Nov 2023 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgPoyoNF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDD8C0F
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B07E0C433D9;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699003223;
	bh=yA1Z5LbFevrJzj3K8hlToA6slOFPkbuUQioyDJR2e9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SgPoyoNF/FJSYL/YHt/nj3KiDPIYTqMrO7KCj2k/Nf3wNJhQl2qobD4f1Esr2uNdR
	 jU+yoYNHo2bO+4uVd+r7FpFm72eZxANwT+LgReXw2eKfCAZTF94UM/7O7p+MwMsgUu
	 +gu8zz9LR6W8+74IZDz/HKEDRn+rJJzlmyb5IqZbIrGm796PN9T/fvZ+YlkogqCiLo
	 FBSrsP1qoFcS3M4Ka6Bjku3VO3/+qGPZMqhPnJ8eMNxq4nl5OUUgDonZJwJyzPdxQ2
	 1GpxNPegXPmPloUG4VjiQWDM7XWTiQaup5clsAb2O2eOdDd2n70iXVKBD5q57elWHu
	 p760mFShxqJDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 926E4E00087;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] selftests: pmtu.sh: fix result checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169900322359.11636.17151225482098820636.git-patchwork-notify@kernel.org>
Date: Fri, 03 Nov 2023 09:20:23 +0000
References: <20231031034732.3531008-1-liuhangbin@gmail.com>
In-Reply-To: <20231031034732.3531008-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, dsahern@kernel.org,
 linux-kselftest@vger.kernel.org, po-hsu.lin@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 31 Oct 2023 11:47:32 +0800 you wrote:
> In the PMTU test, when all previous tests are skipped and the new test
> passes, the exit code is set to 0. However, the current check mistakenly
> treats this as an assignment, causing the check to pass every time.
> 
> Consequently, regardless of how many tests have failed, if the latest test
> passes, the PMTU test will report a pass.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] selftests: pmtu.sh: fix result checking
    https://git.kernel.org/netdev/net/c/63e201916b27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



