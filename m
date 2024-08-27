Return-Path: <netdev+bounces-122518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50822961920
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB74284E21
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E471D414B;
	Tue, 27 Aug 2024 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omOtMN+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5B1D4146;
	Tue, 27 Aug 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793637; cv=none; b=F59VOu0c1sSCW8hW9v33TM0sdpSXKUkm2pV2G/OxB73PSowT17M8Cz6D93eOt9LGkeycG1Y+gU1+/hYsJQl+YfvuTxo+QrHK3T1Dy++ZItTqvcG56z6ButjDJ+NDt3FqCirTi5KVYwlWRG2aWRxQzF8p7M94vY1SK4D4JOanhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793637; c=relaxed/simple;
	bh=+tsj6bnyEkIk8TOHzIkdxGhgeupA+opYHqnok/LTeLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kcth07S/HFIAuKZVp14ALtGhuskiOtpqqEvCq22ehngzqJinI0HcjNRvs6YduXeRB0YdVnyyqi3JMXrSbHJZA5yWg6NVByTAecw24O87THyu12ZCkYMx8vvFkEXEiGtxmBCqenPtPpXW+BsCnrWTRRiViqgVMJMEH9YpBtOr6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omOtMN+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B06CC4AF68;
	Tue, 27 Aug 2024 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724793636;
	bh=+tsj6bnyEkIk8TOHzIkdxGhgeupA+opYHqnok/LTeLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=omOtMN+ANRKY8kwXG0csmo+HDIRruBqEKSi8ZmNznZJHGdSFa0Z2Rxwuz6LUK4B8f
	 vwr98GDHo521aDv/IczT6/BbIPYCaSv/VmRYCthleCH8WZqqnY4M3JDO0xkqy7WQpu
	 xtJYBLUhu6qRKxHUpvX860FtAdiotkXtAIV32jALv5MJ4KE5zB20BbSPoqyoXT+8jv
	 28hDQ2rPiyJ9njlClO1oCyILr3etn2MQkk7BslM/240TJ/gSbjVn2emI/k7YfsK39B
	 czTdBsWJV/WHhXEfQlAjNeONr9kB8+KA4eDz2gHHxv42YfBeLoaTPKRhNUExSbjkFa
	 j4kTXkUHtK7tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFF3822D6D;
	Tue, 27 Aug 2024 21:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: liquidio: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479363650.765313.10251890332797058438.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:20:36 +0000
References: <20240824083107.3639602-1-yuehaibing@huawei.com>
In-Reply-To: <20240824083107.3639602-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Aug 2024 16:31:07 +0800 you wrote:
> Commit da15c78b5664 ("liquidio CN23XX: VF register access") declared
> cn23xx_dump_vf_initialized_regs() but never implemented it.
> 
> octeon_dump_soft_command() is never implemented and used since introduction in
> commit 35878618c92d ("liquidio: Added delayed work for periodically updating
> the link statistics.").
> 
> [...]

Here is the summary with links:
  - [net-next] net: liquidio: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/0eaebf738e6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



