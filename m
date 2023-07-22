Return-Path: <netdev+bounces-20148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0175DD78
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F931C20A86
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F853629;
	Sat, 22 Jul 2023 16:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2F7F
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F95EC433C8;
	Sat, 22 Jul 2023 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690044020;
	bh=Y7GeYOtshSzqUyrTf4I582nLxTP2YgKdQur2hJ7RQdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QIYjuH0VEa+r3qK8kzycBJfhVJG4FjN3rLHMi1O3Wzu+5K1/+MXjZ/zqxzFFPkghu
	 d5t+VSQIoo+p2fAj8Mn+XMdXFH56XxmB6IvJ2LVQaC2UrdWI5n1z7sIK+6GZWO2/Il
	 lrK/1uGQDEvvNS6+q21UBks9ojEs5Mb0bMrIzRksEgrg89mRvXuBroRo79WKCMnDeZ
	 FCog7AcaJUBxzkjHBGrNrdgyZygJcrV/Qe2lGdN+FgjjJleFW1vvXlgefesRYGc79f
	 9qsIREfCDJefQpBvYR7eyfpUW9kD7EOopMstBNVun2Kdov8sHpBYzXyL6dHYvBsuAN
	 01cVvhH0bfivA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21133C595D1;
	Sat, 22 Jul 2023 16:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] Add missing SPDX headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169004402013.28176.6938405818275259219.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jul 2023 16:40:20 +0000
References: <20230722024236.6081-1-stephen@networkplumber.org>
In-Reply-To: <20230722024236.6081-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 21 Jul 2023 19:42:36 -0700 you wrote:
> All headers and source in iproute2 should be using SPDX license info.
> Add a couple that were missed, and take off boilerplate.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  include/bpf_util.h   | 6 +-----
>  include/cg_map.h     | 1 +
>  include/json_print.h | 8 ++------
>  3 files changed, 4 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [iproute2] Add missing SPDX headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=912f5de4aa8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



