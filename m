Return-Path: <netdev+bounces-17327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7781751463
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 01:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147DF281A0D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB11D2F8;
	Wed, 12 Jul 2023 23:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DC1D2F6
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 23:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80C0DC433C9;
	Wed, 12 Jul 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689204021;
	bh=zkasVwqLRc7W1UseZaCkfYhoC92bPsjC+N8B9QXHh84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDgL6nimw8l95lO/4ncH7p3RITSpEyYt4VGF4l8nkeTtPpKS39MyHb1TDH9WObXgL
	 rup931vGlIIodd0VmSsQZtLFeOUbN6qlL6X+vJOfhOEvpxhOKsR5M+p/2EFc7EBabs
	 zb2GWq03PD3MopbARDWyprZ341u6AbjjNK5DnmhwQohV0iri86CshscjvZKtmUM1y9
	 k2o2FXg1/CQMu2YRLurNjkZalnvKd3eONOTT5CAeyhft9bn+GtvEIFTgrog+jjEovy
	 qqUrv0+UfgzIY+J0U9YuAv5JlZqhEQtBnw8hWPNpEiYsjzEzqD2jjDWPDgW5PQQqUh
	 Lknhk/iRffmiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63375C04E32;
	Wed, 12 Jul 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/sched: make psched_mtu() RTNL-less safe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168920402140.16706.12261213766456286160.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 23:20:21 +0000
References: <20230711021634.561598-1-pctammela@mojatatu.com>
In-Reply-To: <20230711021634.561598-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 23:16:34 -0300 you wrote:
> Eric Dumazet says[1]:
> -------
> Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
> without holding RTNL, so dev->mtu can be changed underneath.
> KCSAN could issue a warning.
> -------
> 
> [...]

Here is the summary with links:
  - [v2,net] net/sched: make psched_mtu() RTNL-less safe
    https://git.kernel.org/netdev/net/c/150e33e62c1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



