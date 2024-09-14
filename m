Return-Path: <netdev+bounces-128289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44771978D57
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83501F257CE
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AF4AEF5;
	Sat, 14 Sep 2024 04:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6ftL7aI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA64AEDA
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288242; cv=none; b=Mzi99m4Eg40qxwWFxAwPGK9o2X1rM3lYAwVDVvVcuenxhL2Jpl6cLiokdravaAPd94d58pyn8xEbXLKkClbynRKd+Ru4zlFS6giZr5H3aqZp2E6H8j7hulE4LP4WrpfNFYv474bari3t9XuPiFeEaroUoHIgBacecN2lEdTlTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288242; c=relaxed/simple;
	bh=EOEQiPa9JzgjyE2T7e5qIcCS5O315/C7fyMKNclj6Og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCiytU4bkev1tI+av8iKLvCDWkCIgUBbFeQodFFUOxk8gcO+Yome91/ElgH6rFUf7hCpShl/+AAlU2ss27pFgBgZx9nh5FYv1XTGp5MeMYX1bV8WZ/tt1ULTOqJt6veltgmhg7OcYBeMAclLBc6jU3kkggMpyEEAIiX2prTcqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6ftL7aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D913C4CEC0;
	Sat, 14 Sep 2024 04:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288241;
	bh=EOEQiPa9JzgjyE2T7e5qIcCS5O315/C7fyMKNclj6Og=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h6ftL7aIkAxoGX8UD/BzcT7sL4ze/V9Rwqxws3RG6smFVzO4ZJv5XQGxa2qQGM+kR
	 peVWAbh1vuRRqq6680c+g27FQ91s9AlvbHKQVsS9EZRdxvG3AAS0DRTolRZ4wSBUnC
	 ZBkR02RNCgZHLZUCmu75CcJeSx0/Pl/EtXyoBb2QfotlfD257pm2teuYoNNbylj/Hy
	 l8XCTfMMGwoCVEGx9smy4to9SHoYKBpBa22uFr1+n69RJPejjvnFFsbNjjWQZpKZpd
	 1w+aspWjkuRU8N+zuDVesTgttdxgKht6DFly7JwDODrAvwHvUf1C2xGsOQ7e/SfJhc
	 RZyPahfjCA/pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED32D3806655;
	Sat, 14 Sep 2024 04:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next,v3] MIPS: Remove the obsoleted code for
 include/linux/mv643xx.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628824251.2458848.1377145599961685216.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:30:42 +0000
References: <20240912011949.2726928-1-cuigaosheng1@huawei.com>
In-Reply-To: <20240912011949.2726928-1-cuigaosheng1@huawei.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 naveen@kernel.org, wangweiyang2@huawei.com, sebastian.hesselbarth@gmail.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 09:19:49 +0800 you wrote:
> Most of the drivers which used this header have been deleted, most
> of these code is obsoleted, move the only defines that are actually
> used into arch/powerpc/platforms/chrp/pegasos_eth.c and delete the
> file completely.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [-next,v3] MIPS: Remove the obsoleted code for include/linux/mv643xx.h
    https://git.kernel.org/netdev/net-next/c/1b8c9cb3151a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



