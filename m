Return-Path: <netdev+bounces-50252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86C7F50DA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 20:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC251C20BB1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E31F5FA;
	Wed, 22 Nov 2023 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9w0cEbG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E665E0DD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 19:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F75C433C7;
	Wed, 22 Nov 2023 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700682026;
	bh=QlcMnjt7vW+bKpCQFosQstirt/CuA/GeyI9SEkZlL9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S9w0cEbGVFNb7/5KEJYi0zVw0RZgEWcNjvaz8qykKSaIuhNPxHrmT78GpQ0G72HK1
	 oPZYzozhdjQ3nw54qDLUei0qz4PxnhMZQbz+07eftlSGzir4t+iO9fSuZGSTBdsynN
	 xzyFxMZ2qkzeA8l4TcpFVatrWNtLhKQ9J9AySMomp/q07GwCtWB2C0uJX6/LijdSLl
	 h/oxxdalx2/SzRro7Ds7WAxFM7kwAEx3bDenx+3yNJjWER40dGY3GFs7TtJpN+FO54
	 HFRPxU7YNgFDecQXO/V1mGa17/sRBjyKnTGwvXEb8SyJhwT57scdmgZ6M1quSEU8kj
	 yzpk45R4Q371g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9973CEAA958;
	Wed, 22 Nov 2023 19:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/5] Change parsing in parse_one_of(),
 parse_on_off()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170068202662.20203.769731586488523917.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 19:40:26 +0000
References: <cover.1700666420.git.petrm@nvidia.com>
In-Reply-To: <cover.1700666420.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: dsahern@gmail.com, stephen@networkplumber.org, netdev@vger.kernel.org,
 phaddad@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 22 Nov 2023 16:23:27 +0100 you wrote:
> Library functions parse_one_of() and parse_on_off() were added about three
> years ago to unify all the disparate reimplementations of the same basic
> idea. It used the matches() function to determine whether a string under
> consideration corresponds to one of the keywords. This reflected many,
> though not all cases of on/off parsing at the time.
> 
> This decision has some odd consequences. In particular, "o" can be used as
> a shorthand for "off", which is not obvious, because "o" is the prefix of
> both. By sheer luck, the end result actually makes some sense: "on" means
> on, anything else either means off or errors out. Similar issues are in
> principle also possible for parse_one_of() uses, though currently this does
> not come up.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/5] lib: utils: Switch matches() to returning int again
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=60254925ccab
  - [iproute2-next,v2,2/5] lib: utils: Generalize parse_one_of()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=256e0ca4b84f
  - [iproute2-next,v2,3/5] lib: utils: Convert parse_on_off() to strcmp()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=5ba57152d27c
  - [iproute2-next,v2,4/5] lib: utils: Introduce parse_one_of_deprecated()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=2b8766663d3c
  - [iproute2-next,v2,5/5] lib: utils: Have parse_one_of() warn about prefix matches
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=bd5226437a4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



