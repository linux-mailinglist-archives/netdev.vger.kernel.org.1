Return-Path: <netdev+bounces-86827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAAA8A0628
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA34B24A4C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA213B2B1;
	Thu, 11 Apr 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRQntbqA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9D13B2A4
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803828; cv=none; b=djGai4ElsgKPsWVYX44teLWKd1kxkJU1sSXAcHayluuNRoUsePKVCl6Px/DkxRHe4rhU7gXWxHJ6dd99zLIPVSqwq3Awmzw6sUnkUQ61Qb7ZV3263VevarVkvEw3NXyHenStqTWWRzH2iMMvYwPRYQQyY7PEaoU+qaxjFvyUpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803828; c=relaxed/simple;
	bh=Wm/q2SD5lTYB+9FymW/ER/yEwl5LxOU70fSkQ8s246s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gTG1vl7vyjKleeU5bxqzx4K5en/wlzNS72s8NyzbPMnJjBGU3Htd3KHl5hkuCcBu+tXrF51OnCNznYpWtP3RM5ZQWdZjJa3hWNMyMCOjKD0vVevmZTZgazMWHNP+SkDnd8+N5bdXz93dzKgmn8GCSsBvOkJqEN0Xi5Vs57WCV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRQntbqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD96FC433B2;
	Thu, 11 Apr 2024 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712803827;
	bh=Wm/q2SD5lTYB+9FymW/ER/yEwl5LxOU70fSkQ8s246s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WRQntbqA+pO4/DwP+lbZTtRR5PBCd30Qghy/UH7FLGgfcTc+SxjSWCF5mJ8MwAkWW
	 gheUV3gTOsCmN9jBxisdojbTTiLhALbSiEOyeQxM6Tj3XjDjReHQNn/AIDXUMI5v3F
	 nv59cHjN0qrhCnrfiU3i/Dr2JFqR+qFISW1q6+ZZZ2wR299zeXoCpv9UWneBMjUqP5
	 qd2Bs7LKKzNkyFkORCdQR1fj9SELhpnLE2BxfM84IShX6qauQOLCeyGVsoEgkPDCDN
	 YNozzIhsTQ+avMpV/Tov7zvf/Rgc0lCAYu/ezrjbKPT2i3b5yQ20j4gbU7/thtYbke
	 drPPrOuJc9W/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2307C395F6;
	Thu, 11 Apr 2024 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: fib_rule_tests: Add VRF tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280382766.28291.232108864811790202.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:50:27 +0000
References: <20240409110816.2508498-1-idosch@nvidia.com>
In-Reply-To: <20240409110816.2508498-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@gmail.com,
 liuhangbin@gmail.com, gnault@redhat.com, ssuryaextr@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Apr 2024 14:08:16 +0300 you wrote:
> After commit 40867d74c374 ("net: Add l3mdev index to flow struct and
> avoid oif reset for port devices") it is possible to configure FIB rules
> that match on iif / oif being a l3mdev port. It was not possible before
> as these parameters were reset to the ifindex of the l3mdev device
> itself prior to the FIB rules lookup.
> 
> Add tests that cover this functionality as it does not seem to be
> covered by existing ones and I am aware of at least one user that needs
> this functionality in addition to the one mentioned in [1].
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: fib_rule_tests: Add VRF tests
    https://git.kernel.org/netdev/net-next/c/7e36c3372fd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



