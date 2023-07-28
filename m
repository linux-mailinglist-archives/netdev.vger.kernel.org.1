Return-Path: <netdev+bounces-22141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D058176628E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F65B1C217A4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D144420;
	Fri, 28 Jul 2023 03:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9F03D67
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4617CC433C9;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515623;
	bh=VJYDwUS9+6Cjn1ob/0UEv4RryqzUZciTJPp+xDvs3lI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zhyg2uI8T/xtaPP6M1vZtICFZaezN/6gTopP0O8tpNznQWqLuqKUnVQYaYm0mFFp3
	 ygxUirAsZAKPgCrwoe6FrawFcUZeRl3tf+rhHMGrgPKy5JaxUW/6avcxj/SEAo3ovH
	 BP/M/3umJ7EK0/1EqDnezB1V4GqS9aCTQofsOj5GHjRpI4Xq2d5oLvmSgPYcv3uFcY
	 8RllsMVVbC8faquVBMMdrBqdw4qwVM0K77OlKbKzaUg2kO8xncQ2SXkHXlGI224s8p
	 7sK62vYo1poJOaCJACWm65+epK3wDx6DuIvzWNXWWPg6jwvUi1VwzBNulewXRRFxCK
	 DWX623R2dsbTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CE4FC3959F;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/5] nf_conntrack: fix -Wunused-const-variable=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051562317.23821.4219034803296005345.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:40:23 +0000
References: <20230727133604.8275-2-fw@strlen.de>
In-Reply-To: <20230727133604.8275-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 wangzhu9@huawei.com, simon.horman@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu, 27 Jul 2023 15:35:56 +0200 you wrote:
> From: Zhu Wang <wangzhu9@huawei.com>
> 
> When building with W=1, the following warning occurs.
> 
> net/netfilter/nf_conntrack_proto_dccp.c:72:27: warning: ‘dccp_state_names’ defined but not used [-Wunused-const-variable=]
>  static const char * const dccp_state_names[] = {
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] nf_conntrack: fix -Wunused-const-variable=
    https://git.kernel.org/netdev/net-next/c/a927d77778e3
  - [net-next,2/5] netlink: allow be16 and be32 types in all uint policy checks
    https://git.kernel.org/netdev/net-next/c/5fac9b7c16c5
  - [net-next,3/5] netfilter: nf_tables: use NLA_POLICY_MASK to test for valid flag options
    https://git.kernel.org/netdev/net-next/c/100a11b69842
  - [net-next,4/5] netfilter: conntrack: validate cta_ip via parsing
    https://git.kernel.org/netdev/net-next/c/0c805e80e35d
  - [net-next,5/5] lib/ts_bm: add helper to reduce indentation and improve readability
    https://git.kernel.org/netdev/net-next/c/86e9c9aa2358

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



