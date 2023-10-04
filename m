Return-Path: <netdev+bounces-38129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F57B9864
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E2311281DDD
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F2262AE;
	Wed,  4 Oct 2023 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEmpmqIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244B1BDEE;
	Wed,  4 Oct 2023 22:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C0CC433C8;
	Wed,  4 Oct 2023 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696459829;
	bh=29qFIdltgl6F0PKskAEDQDppIMvIB/Uobyguual+LQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LEmpmqIlpgtWsaiXKVqzHc4G0I3TbO96VrUbSHaL0oeWWqWihAN0y2vaYQLoL/5pc
	 FqNWOByLj+tTstlBaAf7AJIdyl0kUY3fsr884/RytG+u+Z76Zdfg31ZAcqDy31ROMY
	 /fQxpefVfwO1lB/rxR8torCl0v5e/h643xIYz3B6X6huf67kwEpC2j2MN0nVwWxMdi
	 lRvVtl7X67gGmOnKFhhGiyLSm6Tngrq8Ax2K253XVVSZoy11zewSd/qMDUKQS86/e8
	 mM4Uu77Ng8b30wBFUDDDpC9XREAzQ+7ms7bRJHCyBz/3/MrHdpC+I0RGs/Ropu1LR/
	 S5P2QKs+M6hFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78DADE632D6;
	Wed,  4 Oct 2023 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645982948.18987.9169162380776342631.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 22:50:29 +0000
References: <20230929181042.work.990-kees@kernel.org>
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gustavoars@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Sep 2023 11:11:44 -0700 you wrote:
> Hi,
> 
> This annotates several chelsio structures with the coming __counted_by
> attribute for bounds checking of flexible arrays at run-time. For more details,
> see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> [...]

Here is the summary with links:
  - [1/5] chelsio/l2t: Annotate struct l2t_data with __counted_by
    https://git.kernel.org/netdev/net-next/c/3bbae5f1c651
  - [2/5] cxgb4: Annotate struct clip_tbl with __counted_by
    https://git.kernel.org/netdev/net-next/c/c3db467b0822
  - [3/5] cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
    https://git.kernel.org/netdev/net-next/c/157c56a4fede
  - [4/5] cxgb4: Annotate struct sched_table with __counted_by
    https://git.kernel.org/netdev/net-next/c/ceba9725fb45
  - [5/5] cxgb4: Annotate struct smt_data with __counted_by
    https://git.kernel.org/netdev/net-next/c/1508cb7e0752

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



