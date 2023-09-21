Return-Path: <netdev+bounces-35594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55A7A9DE7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C311BB21417
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42736182C3;
	Thu, 21 Sep 2023 19:50:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C41773A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3B48C433C9;
	Thu, 21 Sep 2023 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695325852;
	bh=E6x7SzGWbNo4DVxdtDEQxsEliE9ytgunUOU+75zgppQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGmuBVxVTBUKU4Nn+v9hddHoGZV/TmWRxwB1p9pd5CCMsqLV2SuyeURylf9vkJ8B0
	 cBLCGhXStWgsP6B4lrJwCOuM+ATssYsm2B2uKtJUNyrI88sN3qYwOwBQ0vbFcXxgvJ
	 8Zj4/4W1U9dRsv7Boeh8pKuUTA4dRxfVRGbWaBIOpWEuLHoVtJEv1ppwkA5ruGq201
	 L+L45aUj/BOaJ+4eaVdMENdwISZXcaQgiYrTXRdxVbxiYQfkmPGWAH7XCRStndd+5D
	 KJPyJl6NoXX0XG+Y+KXX7b1VWFMpmpjoXCh/zliKnpyamFzGkCRLch8UzyiXaFZbK8
	 bvvS9akocUuXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ACCDE11F5C;
	Thu, 21 Sep 2023 19:50:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 6.6-rc3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169532585262.6364.13276493763831033599.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 19:50:52 +0000
References: <20230921113117.42035-1-pabeni@redhat.com>
In-Reply-To: <20230921113117.42035-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 21 Sep 2023 13:31:17 +0200 you wrote:
> Hi Linus!
> 
> The following changes since commit 9fdfb15a3dbf818e06be514f4abbfc071004cbe7:
> 
>   Merge tag 'net-6.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-14 10:03:34 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 6.6-rc3
    https://git.kernel.org/netdev/net/c/27bbf45eae9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



