Return-Path: <netdev+bounces-22491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B6767A7D
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06DC1C2194B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966487E0;
	Sat, 29 Jul 2023 01:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577617C
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7A15C433C9;
	Sat, 29 Jul 2023 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690593020;
	bh=h/3E4lMDDrea6z0ElDjSkB9lDs7GdPe9NL5bLA3NufA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tx0Id81M49TZ5utFx84Hy8Yvw5Ffglhhc42IKmfgZG8RCwo0kfKX8fq4/EAqndwGI
	 XcebHmHf24xxa+aSnZy1/PqT4/vrxoyCwAVXCFkVn+43sYxvVtPMy1OWdIvu41ia42
	 v7eRPU83W3cDfmBRCPKpwVUbsWdI4XN9YAI9zY7e+ZAwMXNPvhWi8nNJbmHHnRFqQx
	 S0uyJaBJe733PDAlnb1Q3OMiOUeHPrmOf5kYgfR0x+bu3uGyUttuj92epJ7DMkNvnt
	 PEyrTvTbajVhrdM+5TLDzneGfeZDn+4oZn3MuG7dUzMhQ25LVDLGQCHZBDBJ7nS4wP
	 X853M6SM6X88A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88054C39562;
	Sat, 29 Jul 2023 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: sched: cls_u32: Fix match key mis-addressing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169059302055.26009.7250721497179348984.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 01:10:20 +0000
References: <20230726135151.416917-1-jhs@mojatatu.com>
In-Reply-To: <20230726135151.416917-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org, mgcho.minic@gmail.com, security@kernel.org,
 torvalds@linuxfoundation.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 09:51:51 -0400 you wrote:
> A match entry is uniquely identified with an "address" or "path" in the
> form of: hashtable ID(12b):bucketid(8b):nodeid(12b).
> 
> When creating table match entries all of hash table id, bucket id and
> node (match entry id) are needed to be either specified by the user or
> reasonable in-kernel defaults are used. The in-kernel default for a table id is
> 0x800(omnipresent root table); for bucketid it is 0x0. Prior to this fix there
> was none for a nodeid i.e. the code assumed that the user passed the correct
> nodeid and if the user passes a nodeid of 0 (as Mingi Cho did) then that is what
> was used. But nodeid of 0 is reserved for identifying the table. This is not
> a problem until we dump. The dump code notices that the nodeid is zero and
> assumes it is referencing a table and therefore references table struct
> tc_u_hnode instead of what was created i.e match entry struct tc_u_knode.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: sched: cls_u32: Fix match key mis-addressing
    https://git.kernel.org/netdev/net/c/e68409db9953

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



