Return-Path: <netdev+bounces-20588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789977602B0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3328D2816B1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE0125CC;
	Mon, 24 Jul 2023 22:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496012B6A
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE4A9C433C7;
	Mon, 24 Jul 2023 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690239020;
	bh=eEMemLorZAF7Ne9GYcNEdHseycGkH61JwDQ7FqvIxtg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qDDGjOvYB3Br2RR+MbJt7iKdwM9grZbPsxLHPNsCoGpZy0SLwt99JmkT/ZG3NnPU2
	 w7R6SYedCvy3hOEf/+88U2lJDnn44FsqQD0JPxhqjUNDr7ArM0X4thtVRY+xJxnofb
	 vbBUTwgNl0LwUCG3TS2ts4V0y9YhSW/cUF1jIuiVoSc+M5pvWGI+J3zLQuuxFq54yg
	 q4uLkobyktcKyV1CaancG/Lw1PZcza08EoNQLOiWpwvGeMmeQtBRnPM2xNyrS4sra3
	 65IxoDgnNqP5w0th0y8EVQrWTtr9CV03cx2bXAJpypE65aWZfIEVMJ7TOJfhliwuT/
	 T2CncbmNoqriA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1D7FE1F658;
	Mon, 24 Jul 2023 22:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] atheros: fix return value check in atl1_tso()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169023902072.4968.733436083997639294.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 22:50:20 +0000
References: <20230722142511.12448-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230722142511.12448-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: kuniyu@amazon.com, chris.snook@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Jul 2023 22:25:11 +0800 you wrote:
> in atl1_tso(), it should check the return value of pskb_trim(),
> and return an error code if an unexpected value is returned
> by pskb_trim().
> 
> Fixes: 401c0aabec4b ("atl1: simplify tx packet descriptor")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] atheros: fix return value check in atl1_tso()
    https://git.kernel.org/netdev/net/c/ed96824b71ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



