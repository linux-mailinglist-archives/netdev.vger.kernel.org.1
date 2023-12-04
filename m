Return-Path: <netdev+bounces-53699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A427804282
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 00:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEF4280F37
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA532C7B;
	Mon,  4 Dec 2023 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaKmSWSv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632431738
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 23:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 548D3C433C9;
	Mon,  4 Dec 2023 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701732027;
	bh=eRg1RrzUhGyHvV5KV4bdFSzMnMMq3BNu7w6arDMW61I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AaKmSWSvmaN1M/I2WfYIe0yVB++LqSSiToHhk21ysgtUrRQ4HQ6iYj+sFU4z4ARLL
	 NvqPxtVOJQpfXmTwtzs6YjJ4qz4u8yAJ49emvgeCdDyasRivkYo7jd8mUPov7S9Tj5
	 ZS2IFmyjgyMueKgRenGF/HOhtgdsNYdlPnWFqB/CXEPBcNGgb7yNAK3VZn/Z/0ete3
	 FCQUUnz2o74BPvhvsBPo/w/yOqZSNQWIhWTmx2CuEkyABtg33SMf+Tu67Td/9aUybJ
	 HxbfwMX669iO63oLQI8UQjaLLwaq61WSjmfLnrSvM4yZ3XYHE5HDD8dGyGr4hNi0sG
	 Qd4TmACdokeqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EF57DD4EEF;
	Mon,  4 Dec 2023 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] tcp: Dump bound-only sockets in inet_diag.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170173202725.29919.17770538709502475956.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 23:20:27 +0000
References: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
In-Reply-To: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, mkubecek@suse.cz

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Dec 2023 15:49:52 +0100 you wrote:
> Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> that are bound but haven't yet called connect() or listen().
> 
> The code is inspired by the ->lhash2 loop. However there's no manual
> test of the source port, since this kind of filtering is already
> handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> at a time, to avoid running with bh disabled for too long.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] tcp: Dump bound-only sockets in inet_diag.
    https://git.kernel.org/netdev/net-next/c/91051f003948

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



