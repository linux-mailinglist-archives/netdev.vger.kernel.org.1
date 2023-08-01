Return-Path: <netdev+bounces-23096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9E76AC88
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A21C20E07
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837F1F953;
	Tue,  1 Aug 2023 09:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E8611B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA15AC433C9;
	Tue,  1 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690881022;
	bh=dw8oakLHQGDkU7B9S1BWn8SU4Uu4ZDNcJDCgAAEA1dE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JpxsVwySf2r416sxemD6flZMlJEwOjmvmOggFK6yLwtu9s38hCGmtu9f+aYm3I3jq
	 izlPkSgxNB2JfHDHG7EkaU2D6YpfzcdY/sbpDKA+tIecLBO9inWxDwoBkCPtXsuz3U
	 Im57JuzpR2HDsPFgkaDYuHVmAKD/f4iSUUXsa0GLKN3uRoEl5ROKjCWfbgqhIomXiU
	 JH3IVHZ24zz7WqW+TcaqBTZmvG5G/V9IA1mdz7EFZJiwcY+adSalgMqSoE7tzDjrQ3
	 I7qwtTPZmGrJ+prUUpOO6iIyesT+Aja/Sb/Nxv3wF13Yb3zbe6fSo8wsw66hkcW9QD
	 6dl3iUrOBioYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC45FC43159;
	Tue,  1 Aug 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net/sched: improve class lifetime handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169088102269.29981.8993797516983290352.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 09:10:22 +0000
References: <20230728153537.1865379-1-pctammela@mojatatu.com>
In-Reply-To: <20230728153537.1865379-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Jul 2023 12:35:32 -0300 you wrote:
> Valis says[0]:
> ============
> Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> tcf_result struct into the new instance of the filter on update.
> 
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the
> success path, decreasing filter_cnt of the still referenced class
> and allowing it to be deleted, leading to a use-after-free.
> ============
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net/sched: wrap open coded Qdics class filter counter
    https://git.kernel.org/netdev/net-next/c/8798481b667f
  - [net-next,v2,2/5] net/sched: sch_drr: warn about class in use while deleting
    https://git.kernel.org/netdev/net-next/c/daf8d9181b9b
  - [net-next,v2,3/5] net/sched: sch_hfsc: warn about class in use while deleting
    https://git.kernel.org/netdev/net-next/c/8e4553ef3ed5
  - [net-next,v2,4/5] net/sched: sch_htb: warn about class in use while deleting
    https://git.kernel.org/netdev/net-next/c/7118f56e04d4
  - [net-next,v2,5/5] net/sched: sch_qfq: warn about class in use while deleting
    https://git.kernel.org/netdev/net-next/c/e20e75017c5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



