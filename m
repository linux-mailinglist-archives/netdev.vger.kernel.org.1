Return-Path: <netdev+bounces-24611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6D0770D0E
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CC328279B
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6353015B1;
	Sat,  5 Aug 2023 01:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6911380
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB631C433C9;
	Sat,  5 Aug 2023 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691199023;
	bh=4JusKdeAWG5HGiqzk8I3zyf4j8sqEa0zfMFm7eyONpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mtWW8uBDeerJ9m9hoOvGwLVacNN5WcYnAn7KdnITFSeqvlJWaXQv97SjgjgDahP4A
	 GqcoFZCUEXxY42gGm3eunRdoh6/RF1rFhmSEwVQDK5nQ2pIAjFdwAUp+1DfroJuuVU
	 xfxb4PzT46W6q3VO3df8vx5pfXpXcfr0l144nMirMfVdGPPO30cS0ZEcZVwpJZxpJK
	 VwPNHirQYWuBC/ZS+WK9EzrhV+fNUNrE2qMTYYrEMVF4qyQH/pHWiJ3gj1mqETw+EF
	 rFax5WuyAksZ2VdIKJuiCuYR0bpMFhkZFOZskNxKirj7YdTTm0wyEe5U7cfD7YTpsr
	 MAF3IMdSVOzcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B216AC595C3;
	Sat,  5 Aug 2023 01:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dccp: fix data-race around dp->dccps_mss_cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119902371.19124.17779999821877955473.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:30:23 +0000
References: <20230803163021.2958262-1-edumazet@google.com>
In-Reply-To: <20230803163021.2958262-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 16:30:21 +0000 you wrote:
> dccp_sendmsg() reads dp->dccps_mss_cache before locking the socket.
> Same thing in do_dccp_getsockopt().
> 
> Add READ_ONCE()/WRITE_ONCE() annotations,
> and change dccp_sendmsg() to check again dccps_mss_cache
> after socket is locked.
> 
> [...]

Here is the summary with links:
  - [net] dccp: fix data-race around dp->dccps_mss_cache
    https://git.kernel.org/netdev/net/c/a47e598fbd86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



