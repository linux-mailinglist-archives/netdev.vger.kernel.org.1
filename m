Return-Path: <netdev+bounces-32118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29E792D03
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195DC1C20A46
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1578CDDCB;
	Tue,  5 Sep 2023 18:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC9EDDA8
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 038B6C433CD;
	Tue,  5 Sep 2023 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693936900;
	bh=sxrm7GJYYpa53mKmtigjhDSiMnrnMSAQumGhA5aO1xI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IkuSqaZ3jsxxd5mBuTGiUsrl/p3vBXzC/Jag5WBoQBWGAwaqurUtS9d8lBn//m5EN
	 h+F5dmK+yf1kmNUq9ZgvoCfymFxcCLnu6uPfIv0RM6+PAnlFf96DKbSz3ICoRtQhYk
	 mRbLEa8ntb8Jl651VeMwv2B9dlmMNnQ0/AF4GYcX6o639p+p5G4uCN7QTAjWDz0a4O
	 /V1yWePTZZwErTF6hYnL5VozzCsVd91zaKIo/lxY+vFUOCDkqrGrRDN+uOVMQSelXY
	 EakmAIt8Hs3L4GYSGn9FN1idjqsq0qEKR9XsFMas7gNGBPiZMwT1lJXV2+hfZehVQN
	 mKSViMyyzySjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7155C595CB;
	Tue,  5 Sep 2023 18:01:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Fix truncation of smq in CN10K NIX AQ
 enqueue  mbox handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169393689987.22693.11325949462948037796.git-patchwork-notify@kernel.org>
Date: Tue, 05 Sep 2023 18:01:39 +0000
References: <20230905064816.27514-1-gakula@marvell.com>
In-Reply-To: <20230905064816.27514-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 5 Sep 2023 12:18:16 +0530 you wrote:
> The smq value used in the CN10K NIX AQ instruction enqueue mailbox
> handler was truncated to 9-bit value from 10-bit value because of
> typecasting the CN10K mbox request structure to the CN9K structure.
> Though this hasn't caused any problems when programming the NIX SQ
> context to the HW because the context structure is the same size.
> However, this causes a problem when accessing the structure parameters.
> This patch reads the right smq value for each platform.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler
    https://git.kernel.org/netdev/net/c/29fe7a1b6271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



