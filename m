Return-Path: <netdev+bounces-29233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84F7823CF
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2671C20864
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581941389;
	Mon, 21 Aug 2023 06:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE7EBB
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39F77C433C9;
	Mon, 21 Aug 2023 06:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692600021;
	bh=IQexr8EWxKqc4TDicMS/qVCPp3Gs6AN4mzYMMDbG6tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ay4VU7ZqWYCdjdEg8BOTWjjYzss07I2YJot1Z9g/WYGsqACqyCt/Dz+7fry/Qgc9y
	 uaK3ICJDMtsjrzKv9sjjnasS7Ib9P13/3Jh39XA0YVEJBLeFXjIxib9lt2VDUPHYOM
	 9sPJFh0NUsofRAQEHaWQY9IrmeUITnh/SP8OqH2kdc3VFn9ztacYh8kDduJDvcCcVY
	 DmVdueUqLDuhS7Dm7fjBxelpoB0GX7P9movneFziiJYL4RF3NfzMVOyeKt1pqXNym7
	 I81zBEBZkbOE6/UYcM3JIJIoxWLtZJwJKH2KvtUfmDsDrISLdgtUQaBZTMtqp4vSFd
	 XiMeM25AtRfog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FF1CE4EAFB;
	Mon, 21 Aug 2023 06:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] IPv4: add extack info for IPv4 address add/delete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169260002112.17307.3697580665455265338.git-patchwork-notify@kernel.org>
Date: Mon, 21 Aug 2023 06:40:21 +0000
References: <20230818082523.1972307-1-liuhangbin@gmail.com>
In-Reply-To: <20230818082523.1972307-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@idosch.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 16:25:23 +0800 you wrote:
> Add extack info for IPv4 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> No extack message for the ifa_local checking in __inet_insert_ifa() as
> it has been checked in find_matching_ifa().
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] IPv4: add extack info for IPv4 address add/delete
    https://git.kernel.org/netdev/net-next/c/b4672c733713

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



