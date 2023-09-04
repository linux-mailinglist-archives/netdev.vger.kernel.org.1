Return-Path: <netdev+bounces-31909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63417791587
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E17E1C20837
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F137E;
	Mon,  4 Sep 2023 10:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3917FD
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 10:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3F3DC433C7;
	Mon,  4 Sep 2023 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693822336;
	bh=doRiq4l8tf2FCaarMnaIoeaJQ+kjcSEKEnMTTn8NG5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D68GdFh/pnhlQTNDvib5n5S2BbA5Zx1LCZ70lwziHcMwImZsG+funzaszabFa5+9+
	 nCxpxW24b3/kduRERvpsZtPXS7HADXQnwyAHb12FCEJIv8ErVeEcl+bCVSjzfT89AY
	 q29npPBhChPT20yK+xSq0ortkYcmY5rBISU7reQFTfiqG6lxIAnOQPbfTdJQZsSHSi
	 3usjh+f0Qz6qXTV59feW1LYHKP+njCg+ZUhjuCx/CBjp/DO0TWlPuGXeMR54/Wba9z
	 +tFMPF7Jy3NyqVxeQi5koqNZHeXcy4IXaCqwY7UvOqfnDrKm2bM4IvZye+DAiRhEln
	 ncCdvFKfMC39g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9C10C0C3FD;
	Mon,  4 Sep 2023 10:12:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] af_unix: Fix msg_controllen test in scm_pidfd_recv()
 for MSG_CMSG_COMPAT.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169382233675.16998.16382040577067342952.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 10:12:16 +0000
References: <20230901234604.85191-1-kuniyu@amazon.com>
In-Reply-To: <20230901234604.85191-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, brauner@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, hca@linux.ibm.com,
 aleksandr.mikhalitsyn@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 1 Sep 2023 16:46:04 -0700 you wrote:
> Heiko Carstens reported that SCM_PIDFD does not work with MSG_CMSG_COMPAT
> because scm_pidfd_recv() always checks msg_controllen against sizeof(struct
> cmsghdr).
> 
> We need to use sizeof(struct compat_cmsghdr) for the compat case.
> 
> Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/20230901200517.8742-A-hca@linux.ibm.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Tested-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] af_unix: Fix msg_controllen test in scm_pidfd_recv() for MSG_CMSG_COMPAT.
    https://git.kernel.org/netdev/net/c/718e6b51298e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



