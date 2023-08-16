Return-Path: <netdev+bounces-27877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37F77D816
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B61C20D72
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6771845;
	Wed, 16 Aug 2023 02:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F017FC
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AD52C433CA;
	Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151223;
	bh=uo0dS05ehuNtp06FSMaefF4U3nuAKbJE2+PrD/C9v8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tp3+KEOIUn1JbfzyR74BmpoqRjdwfkIGmw+HIhF8KrpB2YJuLxiRD5dAnta+ayLn7
	 yQLqSsPz86oaH+gotC8y8nT6NBFUuvlATSnM2zUzzJYWtAjgd29ncgzbKyzkb47JoT
	 zTdLfiOWiWaq8LPiLUZ5NrKxWVgUjFE+8VEF52iHsnel2zbAlBNbYLbenZz9a5z+4k
	 ZtsdSLHzRhYg5RAt6LqrMZcT+FQMwhL8jsUOrmnuXXOubYlii+QfoKoEFqO5iOGM3X
	 +vsljbAiRlukOYwH1MBsF/Nk1rdjqruZLr8xziwQfgGdenF563Pd8hUX07XmE6MWgd
	 uqi+dvrSXosNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6087BC691E1;
	Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] nexthop: Various cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215122338.15326.7689857909989223047.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:00:23 +0000
References: <20230813164856.2379822-1-idosch@nvidia.com>
In-Reply-To: <20230813164856.2379822-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, petrm@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Aug 2023 19:48:54 +0300 you wrote:
> Benefit from recent bug fixes and simplify the nexthop dump code.
> 
> No regressions in existing tests:
> 
>  # ./fib_nexthops.sh
>  [...]
>  Tests passed: 234
>  Tests failed:   0
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] nexthop: Simplify nexthop bucket dump
    https://git.kernel.org/netdev/net-next/c/23ab9324fd26
  - [net-next,2/2] nexthop: Do not increment dump sentinel at the end of the dump
    https://git.kernel.org/netdev/net-next/c/db1428f66a8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



