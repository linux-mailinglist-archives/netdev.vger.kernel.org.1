Return-Path: <netdev+bounces-42482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E18A7CED7D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E92280C57
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CA38C;
	Thu, 19 Oct 2023 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3rHQYZ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBE65A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD12FC433CC;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678424;
	bh=0PxS4uA3ElaDTkF0lXh7WZpLTWAleyDM3bZoYQrilXE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p3rHQYZ0Xholfq0CVWUixqukQjoDZmwxUcrbWSVQGxve63+nqC+ZZzbtVjOyZEioD
	 x7w4Gu105nBzwNA+BbIfDU6TT0dxoBnvi1LHh/iBFIA7vA2M1HlVN/uI8j2/BbywLD
	 12yS9nQ078giGjdAgfQKXjWK0QJpvKr7/ZXxXn5y0+/j/zX6dth2hz4Gsjkm6gRrei
	 eU90Ni8OJQB6osYtdvCUFYFi8VOenWG0H6ptktmvkHXHBxQZRGJk4X6+yWbnK9Emmr
	 fDqIVyR5Z47flGLzVOeuHn2ehQzrrEQZ3h+t0/u6PqUyr3lwsT3OydUIBYsywepVsn
	 4l7hbIz3KJA5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6105E00080;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: fib: annotate races around nh->nh_saddr_genid and
 nh->nh_saddr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767842473.18183.14522783202897780354.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:20:24 +0000
References: <20231017192304.82626-1-edumazet@google.com>
In-Reply-To: <20231017192304.82626-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 19:23:04 +0000 you wrote:
> syzbot reported a data-race while accessing nh->nh_saddr_genid [1]
> 
> Add annotations, but leave the code lazy as intended.
> 
> [1]
> BUG: KCSAN: data-race in fib_select_path / fib_select_path
> 
> [...]

Here is the summary with links:
  - [net] ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr
    https://git.kernel.org/netdev/net/c/195374d89368

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



