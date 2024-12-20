Return-Path: <netdev+bounces-153569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E89F8A99
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D47A30B4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEF1632C8;
	Fri, 20 Dec 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWbMTgPA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1F86321
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665418; cv=none; b=WWtxVmYY6Flrw5CyNhXDYacBnoU/MOT7PDYhCsj6tfyRw3eII/DlLsFe96jeo3zEZv+toRqrw8LSrw5C6lNPgTPCX9cJgu2y2NlVzQ42kVz3BoyKBPNCtowCUWit+oLY/G0MCYY6Oul9NNJnVUIUv60d8BfZZOUixWKXwBX7SU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665418; c=relaxed/simple;
	bh=ZWU24SHSNXazHGlRU8mJjvCQv48+T5+nH337VsuItSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UZJOMWalJ+5gRmH8Cw5MT4CXi4XPgo8q9ab8V5Mk5v9F7DhnWEvYImadfTdacumPTSK0DbdGG2N+VHSQ0oAHToTUaUuFDLleshHsLqIfrdCPuCMtKvYQowidoIxCuM/X3F6ZacOTer9BqVrRQOw+2wnoQyfFbiFHyBdDxwk5cQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWbMTgPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FB4C4CED0;
	Fri, 20 Dec 2024 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665416;
	bh=ZWU24SHSNXazHGlRU8mJjvCQv48+T5+nH337VsuItSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWbMTgPAg2+Wvh97RAn0SnSa5e3a+LrwFzTX1EEwDhrIAfggzAT55wdfVSMjWJ8I2
	 qSINLnhMy9iTHfp5RpqLQ3Fp137DrXLgC7VE/6jZvubp4/hzFW9emPRkBSr/yk2dbK
	 xW17cOTdeFPyreiJKRpwXkydogIRX0y5e5e+NvA2+T2u0jTJ+XOP2AtHUhDOsLRYX0
	 ejGJ7EpLEwaeBzzva+g1G9NgUN6gLjF5Ts2WxaxSFtd4ef511Ike2iYUjmjrM4lJRD
	 cLg8ejXrtMx5U2gcEx7Pjs9czEVHXMB/MQ3qqep3KwLkjXKIUK6D9awB93IHlalBDg
	 mUZWSBxCJnDNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2B2F53806656;
	Fri, 20 Dec 2024 03:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] selftests: net: remove redundant ncdevmem print
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466543399.2462446.11929387199358280183.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:30:33 +0000
References: <20241218140018.15607-1-jhs@mojatatu.com>
In-Reply-To: <20241218140018.15607-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, almasrymina@google.com,
 sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 09:00:18 -0500 you wrote:
> Remove extrenous fprintf
> 
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next,1/1] selftests: net: remove redundant ncdevmem print
    https://git.kernel.org/netdev/net-next/c/6724bc65e59b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



