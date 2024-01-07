Return-Path: <netdev+bounces-62245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B7582654E
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 18:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77553281D53
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B817B13AEF;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDLJeMIu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4F13ACD
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E17BC433C8;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704648624;
	bh=t6zuhul29o4QJA925639dXkFUZaedxUWQxTtSZ9ozMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SDLJeMIu+kyGsDmk3cCN9bA1xPUdbizkPTHoz7zF9Adk/NsBwIX7bYSDZ8L3ecsLC
	 lLZa8ygsQ10VEkFQ3iF2YTrucDjrfiqUcDjYWop2s9CG3PAjXNb7XH/qeZFqOLUyhn
	 o7YJMuorLyEXAg1HWG7UY/kWHU2n5diTLrjZbmipnzQKDC32WV2wqkPxRrrEp1UOdI
	 kT5Tv4YsofucRUXFPg8bxImnwIfWj4soyQfBBgAVDMDAeNDBMJBHUPXVFyQoPI83kY
	 HhAGMajpXfV6Mzz2Ev2iYmL9sjuBixr8YIXn/g5LLwssjNGhpcPvAy1EKroUMBA7s0
	 n61Ne/Xwa+8Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 004A3C4167E;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2 0/6] rdma: print related patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464862399.7815.11969178755055314734.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 17:30:23 +0000
References: <20240104011422.26736-1-stephen@networkplumber.org>
In-Reply-To: <20240104011422.26736-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  3 Jan 2024 17:13:38 -0800 you wrote:
> This set of patches makes rdma comman behave more like the
> other commands in iproute2 around printing flags.
> There are some other things found while looking at that code.
> 
> This version keeps similar function names to original
> 
> Stephen Hemminger (6):
>   rdma: shorten print_ lines
>   rdma: use standard flag for json
>   rdma: make pretty behave like other commands
>   rdma: make supress_errors a bit
>   rdma: add oneline flag
>   rdma: do not mix newline and json object
> 
> [...]

Here is the summary with links:
  - [v2,iproute2,1/6] rdma: shorten print_ lines
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=674e00aeaba7
  - [v2,iproute2,2/6] rdma: use standard flag for json
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=22edc0cf37cd
  - [v2,iproute2,3/6] rdma: make pretty behave like other commands
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f962b24a5a33
  - [v2,iproute2,4/6] rdma: make supress_errors a bit
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=6e0d4e91a554
  - [v2,iproute2,5/6] rdma: add oneline flag
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=27a477ba80da
  - [v2,iproute2,6/6] rdma: do not mix newline and json object
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=a903854bad1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



