Return-Path: <netdev+bounces-20613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADE7603C5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01982815E8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D2804;
	Tue, 25 Jul 2023 00:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F008622
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2219AC433C7;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690244421;
	bh=AaHPCjNTPsxbN6hR0FPnXRlIegVUMqkvsXO5A3t+MfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bxhheRdGzrhDQT+XqyR4jSG8CCm0uPIzKdOQrGQBq4WCHkoyNtd+U5FN+VO539v/o
	 AyKasWjmArPgbf5a53pbPnInT//J9tWaFg13aPk7s9C6QsIQhca4gRmi5hdnIRtVnM
	 rmmj+6SRLDcUV1V7EOt0ffW3iAiknY63Bw23KsRwRuK2cuwJ/tjI6KddK9exw81iUL
	 rg6BdNK+tDhmmN4ZHNF42vzBjy132u9OnBMxQd2hmkA+QCRNzOEJpKDgjgvmQ7SXZD
	 3yJC8xMGwxr9+upFzZuwtcVBCZe/IXQQkUzgFm+Jsz4eg+jHD7XvRMJmfX2XCMlSqh
	 nNiXDrmqdITvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07B79E451B7;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: Reduce chance of collisions in inet6_hashfn().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024442102.15014.10192763972225845991.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 00:20:21 +0000
References: <20230721222410.17914-1-kuniyu@amazon.com>
In-Reply-To: <20230721222410.17914-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, aksecurity@gmail.com, benh@amazon.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, trawets@amazon.com,
 samjonas@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Jul 2023 15:24:10 -0700 you wrote:
> From: Stewart Smith <trawets@amazon.com>
> 
> For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
> table with a hash over the source & destination addresses and ports.
> However, the IPv6 hash is insufficient and can lead to a high rate of
> collisions.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: Reduce chance of collisions in inet6_hashfn().
    https://git.kernel.org/netdev/net/c/d11b0df7ddf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



