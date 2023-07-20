Return-Path: <netdev+bounces-19370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351A75A8FF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E291C212E2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5A174C1;
	Thu, 20 Jul 2023 08:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D741174C0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 963B9C433C7;
	Thu, 20 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689841220;
	bh=SZMnz0g+43iH369BweX+FzezZVtB1lGKnxwglQG4d7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qrf6o+v9n6cyRQw9xj24Pn7q4aobwSRpaWB94Tc+XWBuMMCzUGiIQZEc41PaYV0QH
	 e5j4nS1a0eWlJXTSmxqkGh+M2OONLA6WYNxv8DTlVKM4qxjmany+OQg+oe0Cpa6Pss
	 Fjpf+LjjXZts7GEk6iE88FUCxTlXXE/zrGLZF6kDuOEwZjcYWH0P0AproCKQEjHC4d
	 9lalX+Q0WHYBoIckhHAVsdgbjh3o0kk2xMvV6LW/wQFYuWoi+WF0GUprTlk2qLsk9i
	 SnodMgusTfxe17LXNzXJ0o7TYXrpZoPoIfup/3Z7lHdUyVDXdliVoAjAJbgIZu60pn
	 eg1vF7I0sMV5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A798E21EFF;
	Thu, 20 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: handle the exp removal problem with ovs
 upcall properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168984122042.2934.17630490414309506101.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 08:20:20 +0000
References: <cover.1689541664.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1689541664.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, pshelar@ovn.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 pablo@netfilter.org, fw@strlen.de, marcelo.leitner@gmail.com,
 dcaratti@redhat.com, aconole@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Jul 2023 17:09:16 -0400 you wrote:
> With the OVS upcall, the original ct in the skb will be dropped, and when
> the skb comes back from userspace it has to create a new ct again through
> nf_conntrack_in() in either OVS __ovs_ct_lookup() or TC tcf_ct_act().
> 
> However, the new ct will not be able to have the exp as the original ct
> has taken it away from the hash table in nf_ct_find_expectation(). This
> will cause some flow never to be matched, like:
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] netfilter: allow exp not to be removed in nf_ct_find_expectation
    https://git.kernel.org/netdev/net-next/c/4914109a8e1e
  - [net-next,2/3] net: sched: set IPS_CONFIRMED in tmpl status only when commit is set in act_ct
    https://git.kernel.org/netdev/net-next/c/76622ced50a1
  - [net-next,3/3] openvswitch: set IPS_CONFIRMED in tmpl status only when commit is set in conntrack
    https://git.kernel.org/netdev/net-next/c/8c8b73320805

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



