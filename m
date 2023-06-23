Return-Path: <netdev+bounces-13242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD273AEB7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96151C20E5A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F919B;
	Fri, 23 Jun 2023 02:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219538A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 034E4C433C8;
	Fri, 23 Jun 2023 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488021;
	bh=U1S4kMTKlboqMNgvFIFlstaH/q6vnUqTVf4ASdt4z5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2+l+epXJM6F+jjCQWxlQ1rlGNxGmX2A4f1E/ZJP0qG2Mq5NQ8XZXEr3RPSmnFHcI
	 p8NptjpHdU+MzbFoMINVw1iBaYwbS2f9xUDGBCdFBwwfq6ZWnc6/LOjt1kO5ueZ4r8
	 FuMnYRX5G/eODSJLtv+EzZZLAL3e0yZ7NiJ3DlSl/nbYy85lSVXVu5sR882u0k+/ZQ
	 H5f59sxC+B+enexCQw17thhs6Ksm8YdLes7hJSGDhKATk38Yk1ru0o6epUSg2RzAVC
	 j+YtYze90PEq1xLC/AUO/tj4vxiSbcBnu09MQjMdk/XW1HAW8R07cCE9MEhda6QFj7
	 31jGhZsDE0Dpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA465C691F0;
	Fri, 23 Jun 2023 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: do not hard code device address lenth in fdb
 dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748802082.26940.3034994837016078786.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:40:20 +0000
References: <20230621174720.1845040-1-edumazet@google.com>
In-Reply-To: <20230621174720.1845040-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 17:47:20 +0000 you wrote:
> syzbot reports that some netdev devices do not have a six bytes
> address [1]
> 
> Replace ETH_ALEN by dev->addr_len.
> 
> [1] (Case of a device where dev->addr_len = 4)
> 
> [...]

Here is the summary with links:
  - [net] netlink: do not hard code device address lenth in fdb dumps
    https://git.kernel.org/netdev/net/c/aa5406950726

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



