Return-Path: <netdev+bounces-152584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57049F4AF0
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28D316D26D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92091F4274;
	Tue, 17 Dec 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBIQTMma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811161F4266
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438616; cv=none; b=lUNPPYHB9wppnlsFfeD/5xuCLUPzjEBr1dkwNmF8IRbvhkuSx8FBUYynxPMjusWNd+wCx5apTNV7XN/Oq3m33qHLIxjiDprtzg2RHguOyH023KsTbDKdhMIsBkNy0myGDhxlJwZwD+iqnVNoTlzreZg5fVHYGzSuSgzXKzo53gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438616; c=relaxed/simple;
	bh=fmHkTLnik/Jjq+BgqpND9uPHEISHW6l1eHpTgvIqQ78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZzl32v24L9WRErNpMJ6nzW2HK2cd1hXPdT6lP9iOkFQMdc6y7tEPLWsXqLVW+k1/rJysK4zyjxHTOzC7o/HcEDnGRv6+sGDnOq4zdeuCUkVCUh2tbYfalXfcdEh5MRjpyjlHKiZpyWUb7psZEqfJoP+8grMmHqTHLDCh6K92Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBIQTMma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1380EC4CED3;
	Tue, 17 Dec 2024 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734438616;
	bh=fmHkTLnik/Jjq+BgqpND9uPHEISHW6l1eHpTgvIqQ78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IBIQTMmaXmWVh0ynnXKxiIM5pkJPaXDXQJVQ5zE+TOdyRj21Y5vYcNwJmZdca3iI0
	 MTigKn3VvC3UyGdqLX6wWO2sj1RSpNgSYK2Xn436NC2JAAUgMVVUFDLpU1eQteGMzz
	 mhJM1fo+CXjpajc4KzlEcIjCgGefyyJ2da9TkfC6wGOytpfJfPJK5JuwVbx0hYZCzk
	 flJPWXyveSktPuLuTl17A0zVw+UvCYubzukR41mCV+Ft2twLpJIW80LiujVsHDoHur
	 TrEPqlAYoWk9DJx5S79l10XELQLFYdFrO+li5+pGJiP8QMu27IkgL3EF4GRnmF4ozR
	 U/0lXvkVBo7dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 745123806656;
	Tue, 17 Dec 2024 12:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Add drop reasons for AQM-based qdiscs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173443863324.879235.9281655275710794534.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 12:30:33 +0000
References: <20241214-fq-codel-drop-reasons-v1-1-2a814e884c37@redhat.com>
In-Reply-To: <20241214-fq-codel-drop-reasons-v1-1-2a814e884c37@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 14 Dec 2024 17:50:59 +0100 you wrote:
> Now that we have generic QDISC_CONGESTED and QDISC_OVERLIMIT drop
> reasons, let's have all the qdiscs that contain an AQM apply them
> consistently when dropping packets.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  net/sched/sch_codel.c    | 5 +++--
>  net/sched/sch_fq_codel.c | 3 ++-
>  net/sched/sch_fq_pie.c   | 6 ++++--
>  net/sched/sch_gred.c     | 4 ++--
>  net/sched/sch_pie.c      | 5 ++++-
>  net/sched/sch_red.c      | 4 +++-
>  net/sched/sch_sfb.c      | 4 +++-
>  7 files changed, 21 insertions(+), 10 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: Add drop reasons for AQM-based qdiscs
    https://git.kernel.org/netdev/net-next/c/ff9f17ce2e53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



