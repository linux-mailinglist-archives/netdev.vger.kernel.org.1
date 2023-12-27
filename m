Return-Path: <netdev+bounces-60387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45781EF7C
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1F41C216BB
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A14502C;
	Wed, 27 Dec 2023 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oboqmo+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8F45947
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 14:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 442ABC433C9;
	Wed, 27 Dec 2023 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703688022;
	bh=JmUOK66tVH4tMIHUIvGTsfsQEGsY+FkwMryVcR9+hnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oboqmo+Aoha6CWyCFwqcdY0P6BrOCj6iU3850LniJbxbmhouFYmPdfFIRnIlpgizs
	 qiqzfK6Peso6YNGwkgsitMnrj9niTnpVN0KyJYj/LWad7jbVTdRBwtiVrI3Fsx4KdZ
	 5i4Gnc2tO7m7mtHVxS+7ddp9c060HW5t934tIFXbW/ufOWOlUigcjM/DWuBS6LF84o
	 6R/ShSW+5ANUfD6BDV4NoaY2ii99Ir8n0Tf0mEthDXdbQvAhtHE//txxlzWlZW+u2B
	 mK0ear5NQ2OdZ/LNjDHLTddY4LTGUg1fMqGdHLjSyRvykUpPHQuCLf5k+6ii5oYf7A
	 24cTTvLDQgPMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B1BAE333D4;
	Wed, 27 Dec 2023 14:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: pktgen: Use wait_event_freezable_timeout()
 for freezable kthread
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170368802217.12538.6939830762538253852.git-patchwork-notify@kernel.org>
Date: Wed, 27 Dec 2023 14:40:22 +0000
References: <20231219233757.693106-1-haokexin@gmail.com>
In-Reply-To: <20231219233757.693106-1-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Dec 2023 07:37:57 +0800 you wrote:
> A freezable kernel thread can enter frozen state during freezing by
> either calling try_to_freeze() or using wait_event_freezable() and its
> variants. So for the following snippet of code in a kernel thread loop:
>   wait_event_interruptible_timeout();
>   try_to_freeze();
> 
> We can change it to a simple wait_event_freezable_timeout() and then
> eliminate a function call.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: pktgen: Use wait_event_freezable_timeout() for freezable kthread
    https://git.kernel.org/netdev/net-next/c/3fb65f6bc7dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



