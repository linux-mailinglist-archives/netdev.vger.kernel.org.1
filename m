Return-Path: <netdev+bounces-52909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213B800AC3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD571F2060F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894B24B58;
	Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgtB34HN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC724B48
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECD69C433CA;
	Fri,  1 Dec 2023 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701433224;
	bh=r5+SzKU9zczSRoMsLc2KT920PUqyCU5KZGvs9wZ04Tk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tgtB34HNWEu4yrvcSUzDhNwu5XN9cSY4NLKuY5A8dZ7sh5647TPmbFX05LyO/9JgM
	 a8XTzTgVioej19Z/BemV5alT0gLcv7DpXXtxvlaHsBazju7ZNTkZVn5PwHN2aS3PiR
	 4sC7ARSO5nfC3sYWA0sP5lAG6USLAF29jrRI4+geC7tWKqhB/mvH5VP+VmT3oYVQLo
	 jHZXugUhwSY3g7ct//QJzrhRb493Z/wFpfV5XqVegaFdricVB4kywRpJJmLazIBHje
	 RVFrpUNxODpxWSMDy/ijM1RG+B0aWo1kzUmGv5dXVO9PstPttYoTNSuH2e1E6C6gvY
	 j7haFk0biq96Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4DA1C59A4C;
	Fri,  1 Dec 2023 12:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] octeontx2-af: Check return value of nix_get_nixlf
 before using nixlf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170143322386.17347.11199094399378598033.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 12:20:23 +0000
References: <1701236508-22930-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1701236508-22930-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, jerinj@marvell.com, naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 29 Nov 2023 11:11:48 +0530 you wrote:
> If a NIXLF is not attached to a PF/VF device then
> nix_get_nixlf function fails and returns proper error
> code. But npc_get_default_entry_action does not check it
> and uses garbage value in subsequent calls. Fix this
> by cheking the return value of nix_get_nixlf.
> 
> Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [v3,net] octeontx2-af: Check return value of nix_get_nixlf before using nixlf
    https://git.kernel.org/netdev/net/c/830139e7b691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



