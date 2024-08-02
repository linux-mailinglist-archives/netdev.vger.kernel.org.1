Return-Path: <netdev+bounces-115177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E089455E2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B8DB23094
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125FEED8;
	Fri,  2 Aug 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ainV7AiN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE7E56A;
	Fri,  2 Aug 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722561032; cv=none; b=U6n8K0LdBQrqmb49ZwNzLPuVnpdkfUypJ90osgCF7CzK0xTrmdPL73vOCXYrlCXo6QnP+YUvPkBdavMU3E0iYYI6w4WJsDBzlmFNHNSTENiAajjIABxvHjB1mDhsoI1Zahk4ojUVX43dVHKt+f55qhyVRFudHxt8CWxavH9IkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722561032; c=relaxed/simple;
	bh=E5e2POvOL6qn3J8W+q331lIR2/1JZgTxpC6ohlXGN1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uYDQAbkh6m2pOwFmmzw8CrtL7KaijJlO87nXgBwD/m2+8JNfdVsXZp+Bw2yg8OhwDr0LvCEWorDRY1Ov+PdoZO35kT39HGwlJQ7PhJK2Zi4f5lEPdkLyTNoFLlBB4PzxARM8FSSWbr7O109rrMpR+svcQubKsYG/BJagyDLYX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ainV7AiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27075C4AF0A;
	Fri,  2 Aug 2024 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722561031;
	bh=E5e2POvOL6qn3J8W+q331lIR2/1JZgTxpC6ohlXGN1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ainV7AiN56lMhfd16H36s2ALlptj5jqcxEI93R9yt1fYcxiIIlvBz3VmfrAmvjE7F
	 yhFB9TWfCbjp1B+EgEMAKlk2l5+kl988hAIEo2p4pp6BK544fDGaC+x3lF3OEiaRX7
	 3XARjeyDlL/0dkHVN2fNKwAjKR1NPWjA/krL0pZZoaCsnzURSo3jz4iyo/BL2pkWmy
	 pz/t0RadMLmhCuU3mZGKvw+3IjLZMNqNhH1CqXEGSTNcudmKhQUgdgrLQsIcwxxeAE
	 hSEiyK0hCoeRJCTVFpLE4gyDRYNH4H1zuQPY6uOM27FVtXDzUw26CWkurnjgJM3UDi
	 n4qX12o+gcpPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12642D0C60A;
	Fri,  2 Aug 2024 01:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mctp: Consistent peer address handling in
 ioctl tag allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172256103107.22370.6605828738753325393.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 01:10:31 +0000
References: <20240730084636.184140-1-wangzhiqiang02@ieisystem.com>
In-Reply-To: <20240730084636.184140-1-wangzhiqiang02@ieisystem.com>
To: John Wang <wangzq.jn@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 16:46:35 +0800 you wrote:
> When executing ioctl to allocate tags, if the peer address is 0,
> mctp_alloc_local_tag now replaces it with 0xff. However, during tag
> dropping, this replacement is not performed, potentially causing the key
> not to be dropped as expected.
> 
> Signed-off-by: John Wang <wangzhiqiang02@ieisystem.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mctp: Consistent peer address handling in ioctl tag allocation
    https://git.kernel.org/netdev/net-next/c/5fcf0801ef5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



