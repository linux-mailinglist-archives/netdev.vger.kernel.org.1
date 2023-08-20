Return-Path: <netdev+bounces-29174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF7781F2D
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EE7280FA4
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136C63D6;
	Sun, 20 Aug 2023 18:13:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942B63D7
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB4A7C433C8;
	Sun, 20 Aug 2023 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692555210;
	bh=6oZyW6H5QJF1fTAT7pR2cWt5eszPlMTmdBNWBx2H1B4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZYw4w22sxdbV4y5g+iFq+z8O3iHfjXny+9G2HqUG3vpnspAn0/HPaAt0HXUJPxiSI
	 TAMuD+082+/AAlKsC6ARn4yzfUi+5lIGcfIgy8Bf/Li5nlaT4RYD6kJ7kyBD4v7Hsk
	 bVhe64mDHMfWYrlX/hZUE+j45tmZo0C1FoVe3D8j5arKB2ko+oR+02I4HM4U7UG7mZ
	 NqHupOPn5jNoG6qDpdylwx6R5w3IJ4xXp+OTBwUrK34jez31/ycu8zpAt45PKDHcBI
	 efw1M10QDUToUMlYwnxPKMOBrbmeiCF6+3G+m2XrysjeZ6AsK186U8y0SIfstJVgat
	 BcAAiLruRFCeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFCDDE26D34;
	Sun, 20 Aug 2023 18:13:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: vrf_route_leaking: remove ipv6_ping_frag
 from default testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169255520984.4244.11212825295564570400.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 18:13:29 +0000
References: <20230818080613.1969817-1-liuhangbin@gmail.com>
In-Reply-To: <20230818080613.1969817-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@idosch.org,
 mjeanson@efficios.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 16:06:13 +0800 you wrote:
> As the initial commit 1a01727676a8 ("selftests: Add VRF route leaking
> tests") said, the IPv6 MTU test fails as source address selection
> picking ::1. Every time we run the selftest this one report failed.
> There seems not much meaning  to keep reporting a failure for 3 years
> that no one plan to fix/update. Let't just skip this one first. We can
> add it back when the issue fixed.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: vrf_route_leaking: remove ipv6_ping_frag from default testing
    https://git.kernel.org/netdev/net-next/c/c4cf2bc0d2c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



