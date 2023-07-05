Return-Path: <netdev+bounces-15611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD8748B30
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAB2810E5
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4613AF7;
	Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9121134A7
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63E81C43395;
	Wed,  5 Jul 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688580023;
	bh=h/ra30O4s+hWWkmTlKDYomJOF1pe0BSaSd1cWrc7xIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D1jyc+CTDI3cHTMTEPQ55IBkGANKvuQcAWdFIfnJHfQiNCiF3hQ7e7rzr02lagmag
	 4j8OjZo8wW5nOibCRUtZzoAe/55y/GnO2nTuXjN+ASULUh1X35UXAbpzH2X8sx/gBK
	 DaQ8Utt99iOUQgUWeYc9BjUtAfWxgY9H0VVFSMO+L2RYVuetKXj333D8jF6+lML+I9
	 4E4s1bnsHHKOaS60wqqGHhrRU0ZhIFk1AtjsfDg68thDCUe1C1EgO945kzoGlNpp7F
	 0mKN9KsLOuPcqa+6qKUfkWFehsHmQg2ju7yDc46RJ646+N57qiuTa0hXAIEpiFB+iW
	 xLfnWgi05NLHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A839C561EE;
	Wed,  5 Jul 2023 18:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] tc/taprio: fix parsing of "fp" option when it
 doesn't appear last
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168858002330.7518.203942230628793682.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jul 2023 18:00:23 +0000
References: <20230705105155.51490-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230705105155.51490-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  5 Jul 2023 13:51:55 +0300 you wrote:
> When installing a Qdisc this way:
> 
> tc qdisc replace dev $ifname handle 8001: parent root stab overhead 24 taprio \
> 	num_tc 8 \
> 	map 0 1 2 3 4 5 6 7 \
> 	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
> 	base-time 0 \
> 	sched-entry S 01 1216 \
> 	sched-entry S fe 12368 \
> 	fp P E E E E E E E \
> 	flags 0x2
> 
> [...]

Here is the summary with links:
  - [iproute2] tc/taprio: fix parsing of "fp" option when it doesn't appear last
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e848ef0ad5d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



