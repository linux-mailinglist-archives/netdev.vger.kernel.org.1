Return-Path: <netdev+bounces-37268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA77B479A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 39D1328183F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62215AC0;
	Sun,  1 Oct 2023 13:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981C2F27
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 13:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0B54C433C9;
	Sun,  1 Oct 2023 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696166422;
	bh=FnIePasQhhmc7IrL9A8wKG+W4nEtSF5xqNAHh3fCmcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TCM1Zkwj/OdHt6pWbc8ggZmIjjb9eXBJki15QObteLWZ/Ukn47FR2U36Wb3hyxNUp
	 1Sqf+kX5ro96MqGjMhZNqFH6gpOqtQKs/Gq2LdVS1HaI/yZqjui45t+4RdUCqhzI9R
	 xYhXeFL4gNEQyrn0Kbq3jMER6y4Yaht/YfALiAuF41nenHLByO5M+ENzo0v2f4oS92
	 axE2I8gBHggEpjwfgNYd0qj081lQEcv1xp8fgSC5c0bk01gbq0/JMqHWyIgjKZSnIT
	 OBmjVsq3ESe1/8C5xqXnHHuDrG5ukoXr2YdRDBD5cZ72+twIKdhAHuYKuse7WsxYb0
	 uiSn2Ty6JmMVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3A4DE29AFE;
	Sun,  1 Oct 2023 13:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-09-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169616642279.6903.15788617870560020661.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 13:20:22 +0000
References: <20230920181344.571274-1-luiz.dentz@gmail.com>
In-Reply-To: <20230920181344.571274-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Sep 2023 11:13:44 -0700 you wrote:
> The following changes since commit 4a0f07d71b0483cc08c03cefa7c85749e187c214:
> 
>   net/handshake: Fix memory leak in __sock_create() and sock_alloc_file() (2023-09-20 11:54:49 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-09-20
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-09-20
    https://git.kernel.org/netdev/net/c/c15cd642d437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



