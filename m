Return-Path: <netdev+bounces-14518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049B742402
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FE61C209D4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F115C9;
	Thu, 29 Jun 2023 10:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD614AA3
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89DE8C433CA;
	Thu, 29 Jun 2023 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688034622;
	bh=udn/kroFIiA/+ehceJF3IsPrL5f9Q4ftK928gC2DcRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lhVAmcPvXRaK1KqGRLeDhlBHlO7yvtK0OeG2ndkZjvnixxt19bXijRBaUql1fv6sb
	 xf6c/ATMZskv/7pW5q33R7Qd4OztiFs5eygxvDCL4ymoylGNgwYtpRM+peq8KETGaI
	 2seTt4Qsbrzedk1ToNNZsZd1zrobUciXoqAlrVCVH1+3nsaekJUB6HZbiXNo2WF1sV
	 X8DqEnGIIq+ubIUtnNaB8lCekgHM5E2o+19i9T63Ep1c9L3p8Be+/M+n5rO0nuAkk6
	 17/CAxGfNszvk9p/vLyjemahBC7g/o98FSLyGhIoddo5spiu2uQDp31gqpmw6+uxLS
	 DHXk4Kegi7FLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AF79C395D8;
	Thu, 29 Jun 2023 10:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net/sched: act_ipt bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168803462243.21104.11301825635547481433.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 10:30:22 +0000
References: <20230627123813.3036-1-fw@strlen.de>
In-Reply-To: <20230627123813.3036-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Jun 2023 14:38:10 +0200 you wrote:
> v3: prefer skb_header() helper in patch 2.  No other changes.
> I've retained Acks and RvB-Tags of v2.
> 
> While checking if netfilter could be updated to replace selected
> instances of NF_DROP with kfree_skb_reason+NF_STOLEN to improve
> debugging info via drop monitor I found that act_ipt is incompatible
> with such an approach.  Moreover, it lacks multiple sanity checks
> to avoid certain code paths that make assumptions that the tc layer
> doesn't meet, such as header sanity checks, availability of skb_dst,
> skb_nfct() and so on.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net/sched: act_ipt: add sanity checks on table name and hook locations
    https://git.kernel.org/netdev/net/c/b4ee93380b3c
  - [net,v3,2/3] net/sched: act_ipt: add sanity checks on skb before calling target
    https://git.kernel.org/netdev/net/c/b2dc32dcba08
  - [net,v3,3/3] net/sched: act_ipt: zero skb->cb before calling target
    https://git.kernel.org/netdev/net/c/93d75d475c5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



