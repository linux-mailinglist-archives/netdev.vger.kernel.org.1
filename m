Return-Path: <netdev+bounces-93161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68968BA534
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 04:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C282825C0
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A918B14;
	Fri,  3 May 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idscnH+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508817556
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702230; cv=none; b=IfWp7NHFaz1pbhOPcdMz951eMQB+asGkOdpL0FqaVFjQQJWIjXJvO7hl9GcTpiHA1ogfV1i6UritvA4ctR9BwXZ7SW7OOjkS9Yb8fjw5ClRGoqHeAHcb9gI20NoSbHNlyorLnX8+P1mb8obxf2iKTPh0X6egZ4AZvH5kgLGDZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702230; c=relaxed/simple;
	bh=cYy93JBJpnxQ7kyxBpUYExw9ft2n8+XjPady7mTsLnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bYNE61Sv6WdJFXlYCckGKJxq3QTxMzyWghYEc3sSIpbegvq5x7hcgM7C4Szr9px/wkZInevmXJVwz8GWmHVHxqzkLHjnQzatKWcRSFOje5FBa8kTJhk4wEdM9P8oyDli+cRg0dt6jFoPzlB5ddgFY/x7YdY4ONMri50H5Z4fJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idscnH+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE73C4AF4D;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714702229;
	bh=cYy93JBJpnxQ7kyxBpUYExw9ft2n8+XjPady7mTsLnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=idscnH+xAmDtVx0Yr/r/2KqVPxCnMD1O480kOyjQvr+IhDW6UEYdUgipJZfd3DxU/
	 lSQMjoLSMWKvirV/qaNJIW+dltnJ/MXKvDrLSjEqN0w2jbWijsvxhKXrkMC6Zner6V
	 mAmT5q8mN2rJYk9pKEeewVi5ACh58VXR+//P/5Tq7tinW7BLv8Ayd/vo+b9l/0n+2k
	 YWp1ohBeaQrz2N/9V+5LxjQDtJ+RQWsGodyLx49eeT8snDtxs14kaTmryqH1/OqF4k
	 FdxOn2ypsMZnlBtSVfcBPJi7SOgB4BK7To+MtQ3/X4XfP8TPje3DKJSmBOL9bJFIbF
	 IzFH8nGWLe0Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9283CC43337;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: sch_sfq: annotate data-races around
 q->perturb_period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470222959.28714.2320235939792435256.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 02:10:29 +0000
References: <20240430180015.3111398-1-edumazet@google.com>
In-Reply-To: <20240430180015.3111398-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 horms@kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 18:00:15 +0000 you wrote:
> sfq_perturbation() reads q->perturb_period locklessly.
> Add annotations to fix potential issues.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_sfq.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net_sched: sch_sfq: annotate data-races around q->perturb_period
    https://git.kernel.org/netdev/net-next/c/a17ef9e6c2c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



