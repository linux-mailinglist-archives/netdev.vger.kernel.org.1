Return-Path: <netdev+bounces-40834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5F7C8C0C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A97C1C2112C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50996219F6;
	Fri, 13 Oct 2023 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig6F6w0R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141D21362
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1C4EC433CA;
	Fri, 13 Oct 2023 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697217024;
	bh=xqeFoQE3iu+uoS2r2YFa/syUmjvYkTtyqOzBVU1tBvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ig6F6w0RedRYyf6f+WXw6MYCmLQbYMN3ERIM8Pi0MlAbQwKjbmubOXMeZS1lXQvK5
	 u0PMTRaS9f48kqUxB07IFyNGXaMsxefEl+ArkvOL6rtM2xma/Rbkb4IERbrR5yOYUL
	 W4saUROq3l0YjlxuH6ujSAxfvBJXRQpNyJVpd/Tmh1icVBpvxEcasuh0AkV0jSeDei
	 wUMq6yB/Hj9PfrThnzqfmTvLCextTz6MzjrfCf553z9BC0VouH3fxFraDYkeQZd0Oc
	 DAS3it3MpNdENZulKOS53fD/kaXoaXr4faDQSMg1d6u9vAwwbbjNlAvOIP/PLG+7JA
	 g1v4Ke94GqHrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84F3EC73FEA;
	Fri, 13 Oct 2023 17:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Fix listen() warning with v4-mapped-v6 address.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169721702453.23617.16807645525327344015.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 17:10:24 +0000
References: <20231010013814.70571-1-kuniyu@amazon.com>
In-Reply-To: <20231010013814.70571-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Oct 2023 18:38:14 -0700 you wrote:
> syzbot reported a warning [0] introduced by commit c48ef9c4aed3 ("tcp: Fix
> bind() regression for v4-mapped-v6 non-wildcard address.").
> 
> After the cited commit, a v4 socket's address matches the corresponding
> v4-mapped-v6 tb2 in inet_bind2_bucket_match_addr(), not vice versa.
> 
> During X.X.X.X -> ::ffff:X.X.X.X order bind()s, the second bind() uses
> bhash and conflicts properly without checking bhash2 so that we need not
> check if a v4-mapped-v6 sk matches the corresponding v4 address tb2 in
> inet_bind2_bucket_match_addr().  However, the repro shows that we need
> to check that in a no-conflict case.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Fix listen() warning with v4-mapped-v6 address.
    https://git.kernel.org/netdev/net/c/8702cf12e6ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



