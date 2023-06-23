Return-Path: <netdev+bounces-13241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02C73AEB6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED4A1C20EC1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0508F621;
	Fri, 23 Jun 2023 02:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB3380
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC53BC433C9;
	Fri, 23 Jun 2023 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488020;
	bh=PH1I+IpazSV4xFaKCZSGb8SEvl3+aqZtPainRKeUzdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bF0RNZrk88n6EhAz5tWZCbJCTwPrFmK14q55zyI3e5raHwgHx/a0jMKl1rIqvT3Nb
	 WRcv3HyqD3Pbm6ha51vxT+tpY9XaXMBNkJlT7VEo1+3SvIU7SIgzS3Fc43QGEkWGDV
	 JNqzRAYSywKgHG5tMm28yKZ1Ra0gfAKSuPChFlodq/Szv7WMQCuqJ5EhH79rue0eUM
	 0S6+FMmqRMVM9+iyB0G+PcLyOQlEoGKbgfBnyKJJ5rcSjTeIJmlceLQ9FnMB8rvP6O
	 NvcuoAFzOVYUuvFeT7z4C1twmKihFDS+N4mz2rTYHRJP4SuJRpAmf5CjvfNRnSJ1QA
	 sJHFb5LQqEJgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC6A5C395F1;
	Fri, 23 Jun 2023 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748802075.26940.1079680476499603039.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:40:20 +0000
References: <20230621154337.1668594-1-edumazet@google.com>
In-Reply-To: <20230621154337.1668594-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com,
 johannes.berg@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 15:43:37 +0000 you wrote:
> syzbot reported a possible deadlock in netlink_set_err() [1]
> 
> A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
> for netlink_lock_table()") in netlink_lock_table()
> 
> This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump()
> which were not covered by cited commit.
> 
> [...]

Here is the summary with links:
  - [net] netlink: fix potential deadlock in netlink_set_err()
    https://git.kernel.org/netdev/net/c/8d61f926d420

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



