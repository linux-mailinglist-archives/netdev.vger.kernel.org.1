Return-Path: <netdev+bounces-31533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA678E9A2
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85B11C208F0
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878FF8BE6;
	Thu, 31 Aug 2023 09:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2D8498
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B0FAC433C9;
	Thu, 31 Aug 2023 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693474827;
	bh=KXo/YBq6BJFIJUoJy9tJTJDU+Y/228TBLaRYndV3a6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qe1+E8EWoCF29GmaUm/8kKatkuDtM/OUSCbpILvF9pV0yDY0S15G+7qItxSGZz+om
	 NUqtr5cuJa1rA+MrtShxaFVOGSkDKWIbFwrdQuhbe+ufEHzg8EZGXHylEhGrSXWORA
	 yfEFAXg3hFGP4il8HFK181cCtw8EK/m6CR3jQ2IbCNVJQFlK+dem9TbAevBzkoMixM
	 82HJj42jpT3dpyiElt3e3tbhVsvg+CTNlQYxToI3CaRLuxRZ2kwUfm0yCSI+WRSWeJ
	 BqzbkfrfKsenOKB6LNhM10HP1a/X4xCh1Xgk3mVnAE3hXUUaixCtYADgm5MEW5KIaL
	 5DCvts0vRPckQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F37DE29F33;
	Thu, 31 Aug 2023 09:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: fq_pie: avoid stalls in fq_pie_timer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169347482745.21305.4489281873039852777.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 09:40:27 +0000
References: <20230829123541.3745013-1-edumazet@google.com>
In-Reply-To: <20230829123541.3745013-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 29 Aug 2023 12:35:41 +0000 you wrote:
> When setting a high number of flows (limit being 65536),
> fq_pie_timer() is currently using too much time as syzbot reported.
> 
> Add logic to yield the cpu every 2048 flows (less than 150 usec
> on debug kernels).
> It should also help by not blocking qdisc fast paths for too long.
> Worst case (65536 flows) would need 31 jiffies for a complete scan.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: fq_pie: avoid stalls in fq_pie_timer()
    https://git.kernel.org/netdev/net/c/8c21ab1bae94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



