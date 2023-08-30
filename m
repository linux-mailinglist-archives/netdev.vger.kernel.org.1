Return-Path: <netdev+bounces-31446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CF78DE93
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F541C204E8
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5058749A;
	Wed, 30 Aug 2023 19:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79F748A
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 19:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D078C433CA;
	Wed, 30 Aug 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693422623;
	bh=oREmiQeexmG67xEOOnOu9rR9wfJDQ33GOmOFyto5/5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PGpceakjV4WpWjlrvH2K7fwr1CPWYSfokZDVX5p2zZ/znR/FRmnjzoUjvGeAStDGT
	 h5qGVKu9qyXE+FFXRL3VJKsZAK0zt8+bbMZ9/KRHNDfYVFi5SJOH2kmJWqe62+qFr7
	 AGz+ycxFcKZX2+DwlvB9qTkN+FbUaHfYvLp1XXIlKZ/OzQPqvipiDPkFJjGtUqanf6
	 FarNZ3TZJzO7tsiFwWeJW4oB2of8ofg1woGkHqpUIaVw55qIZjci/X09Nh8+hmBPWz
	 0zZJT2KlWi1cDuacvdaFWkLfJvOqPeUUmUE17p04z3s0yNRieStipUdH833TNOUazR
	 v2QRytMxWiEuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D39AE29F39;
	Wed, 30 Aug 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/1] tc: fix typo in netem's usage string
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169342262317.25071.14337036719848362412.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 19:10:23 +0000
References: <20230830150531.44641-1-francois.michel@uclouvain.be>
In-Reply-To: <20230830150531.44641-1-francois.michel@uclouvain.be>
To: =?utf-8?q?Fran=C3=A7ois_Michel_=3Cfrancois=2Emichel=40uclouvain=2Ebe=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, petrm@nvidia.com,
 dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 30 Aug 2023 17:05:20 +0200 you wrote:
> From: François Michel <francois.michel@uclouvain.be>
> 
> Fixes a misplaced newline in netem's usage string.
> 
> François Michel (1):
>   tc: fix typo in netem's usage string
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/1] tc: fix typo in netem's usage string
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=865dd3ab1580

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



