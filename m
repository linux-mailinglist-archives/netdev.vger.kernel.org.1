Return-Path: <netdev+bounces-201348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E6AE9150
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24481C25A84
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39EC2F430A;
	Wed, 25 Jun 2025 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy2J+UdS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC42F4306;
	Wed, 25 Jun 2025 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891826; cv=none; b=XUvYrbrX9DKjIaAFJnNl0KLmvCWBhsnL1IZobhlqJpaX3lvnB40hvB/6clggpg4T7VWlR6QCgxX95uf0S2t7oFeAYrr7GFJyfIxlo+dv1/NsxO8XOyKW7CcMearon7XTRtbzm4uKNKBNQ2MyX6RdN/YFQKdkL7ik3KM7kXACS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891826; c=relaxed/simple;
	bh=TWD3IjvLadwqGZq5SwsAcBzOFtYxvR6H7QSP2DE4LpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OaHHXX8UslxSftr7Qk8RWNIuAMHqKpwAnRqpFSC3XQnsF19HPBv8Gtgj2DgCJty7+y03OxbTkXzjSBo65Z4/m6Fx1hwuDRIg3cUbEuWRzaokgJmcaf2H38vPng8sB4woSOSROn4oYg5r+0VHcHNB2LmyddHu/GwA69znUHtLZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy2J+UdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D7DC4CEEE;
	Wed, 25 Jun 2025 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891826;
	bh=TWD3IjvLadwqGZq5SwsAcBzOFtYxvR6H7QSP2DE4LpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fy2J+UdSPE8hmG2acIrglp9vOBoFQEHkKwhdfNnIgvQ7yJewh7+P2n5pTGLEwmaOJ
	 es6bLosr3H/uexj1vrLuKLXN6GEOOngVfN5YgrS0burD0z41YjQelzvrB/nG/jHMJ7
	 WMLiLpPJaA6/4SW7N8IydAxdoV2AMZR62R7r+mcz4wwlCpRIDOmzXlsnuTRYfe75Nd
	 c1UscZ7rIFbK5iOSVUdSlZkbXYqmZfKkVHM9D8O/s8A1SF30L0l3KwhDlbWDMX1axb
	 lhb/wA4g7Q8oogt5N0FLO7q63ZozlphgJvRbCS1v0r0uFKKQBHCHIepoGun84ZNFti
	 xV4n833H9U/0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2F3A40FCB;
	Wed, 25 Jun 2025 22:50:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Remove unused functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089185249.646343.240059286231797798.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:50:52 +0000
References: <20250624014327.3686873-1-yuehaibing@huawei.com>
In-Reply-To: <20250624014327.3686873-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 09:43:27 +0800 you wrote:
> Since commit c54e1d920f04 ("flow_offload: add ops to tc_action_ops for
> flow action setup") these are unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/tc_act/tc_csum.h   | 9 ---------
>  include/net/tc_act/tc_ct.h     | 9 ---------
>  include/net/tc_act/tc_gate.h   | 9 ---------
>  include/net/tc_act/tc_mpls.h   | 9 ---------
>  include/net/tc_act/tc_police.h | 9 ---------
>  include/net/tc_act/tc_sample.h | 9 ---------
>  include/net/tc_act/tc_vlan.h   | 9 ---------
>  7 files changed, 63 deletions(-)

Here is the summary with links:
  - [net-next] net/sched: Remove unused functions
    https://git.kernel.org/netdev/net-next/c/4b70e2a069d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



