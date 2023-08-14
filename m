Return-Path: <netdev+bounces-27302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828DC77B67C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C071C2089B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17AAD52;
	Mon, 14 Aug 2023 10:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0178DAD4C
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7278BC433CA;
	Mon, 14 Aug 2023 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692008420;
	bh=omhiaIQCg1QJmj1eyUWrDni6tEobovW0oR5SWPfgMZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FccaP32qoBPyWAm0mX+PvRxblQDj3E+pjW9DaOKPlTywOzlkAUHZr+dFbk3TEGseq
	 ypqUpnzuMBTO9qLaFnTMWaB73HnzJdkEpUtrxdCcdPdHSwJKmLc0XXWjR1uqvvxlia
	 IPF93UAd7UZ+AM7Kz/aIMGK2hVG4G+Y7FGmIOirZsYYqjRM5cpJEhKuyQsbTEID4Mx
	 gWgy1oEdJ3xIehX5y2ZIqyk4syjD1G/xIEqKxcq3Q90/Zp+SKoDnOLYrVk1GynmPJc
	 8TwXmixtKm0k6UU5tIrPsIxgLYB/48016XzTkiwXLOLbXMOe9Q7+ce/a5cIkYlEh7x
	 HIcp7hfsIb8Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51113E93B34;
	Mon, 14 Aug 2023 10:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: mirror_gre_changes: Tighten up the TTL test
 match
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169200842032.6338.4956098548156030129.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 10:20:20 +0000
References: <3ea00504d4fa00a4f3531044e3df20312d472a39.1691769262.git.petrm@nvidia.com>
In-Reply-To: <3ea00504d4fa00a4f3531044e3df20312d472a39.1691769262.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, mlxsw@nvidia.com,
 idosch@nvidia.com, jiri@resnulli.us, mirsad.todorovac@alu.unizg.hr

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 17:59:27 +0200 you wrote:
> This test verifies whether the encapsulated packets have the correct
> configured TTL. It does so by sending ICMP packets through the test
> topology and mirroring them to a gretap netdevice. On a busy host
> however, more than just the test ICMP packets may end up flowing
> through the topology, get mirrored, and counted. This leads to
> potential spurious failures as the test observes much more mirrored
> packets than the sent test packets, and assumes a bug.
> 
> [...]

Here is the summary with links:
  - [net] selftests: mirror_gre_changes: Tighten up the TTL test match
    https://git.kernel.org/netdev/net/c/855067defa36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



