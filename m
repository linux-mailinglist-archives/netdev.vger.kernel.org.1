Return-Path: <netdev+bounces-32178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A011C7934C1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 07:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80881C2095A
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C268653;
	Wed,  6 Sep 2023 05:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60385809
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 05:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBD35C433C9;
	Wed,  6 Sep 2023 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693977022;
	bh=JXjmVbDvWn8l3Jes31TsliihoIULtg5AyXFYDN1GYr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YNCnNfygIBjXHkgpquTL2FNWc8/E/Oo8zvXzl6MWYy3KMXDtGY/yHpk5aSFpSkGXc
	 mQt0ZZ/04no+cky02I6G+UfZZT1oJ+87owpjXJpOQJHXPnnOzjaiYD8wvxeptbKQ/q
	 /2GI4qFZmtKoE6Ij1ovw1vucP4n+45DYJctGPpGVFCcwmls9DsxN4FcbSBXnPU+oBY
	 WU4MankUIHN10ccUZRoi/65rFtw7MJPBrz33aXRS5gnHRipP35yLZH3VkvQhPDulwl
	 fFSXPKvOjrQ6BAiLSpV8Pto4vFbXtV7MrQBnfpRbvDdb7B9wzI0rxRjzIZYKn2rS5E
	 CyGeowQqQCpjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2176C04D3F;
	Wed,  6 Sep 2023 05:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: team: do not use dynamic lockdep key
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169397702265.22023.4219171939972539632.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 05:10:22 +0000
References: <20230905084610.3659354-1-ap420073@gmail.com>
In-Reply-To: <20230905084610.3659354-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jiri@resnulli.us, netdev@vger.kernel.org,
 syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Sep 2023 08:46:10 +0000 you wrote:
> team interface has used a dynamic lockdep key to avoid false-positive
> lockdep deadlock detection. Virtual interfaces such as team usually
> have their own lock for protecting private data.
> These interfaces can be nested.
> team0
>   |
> team1
> 
> [...]

Here is the summary with links:
  - [net] net: team: do not use dynamic lockdep key
    https://git.kernel.org/netdev/net/c/39285e124edb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



