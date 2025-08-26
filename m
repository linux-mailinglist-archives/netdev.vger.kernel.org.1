Return-Path: <netdev+bounces-216739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394D6B35037
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0370E3A65C9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA042253EB;
	Tue, 26 Aug 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE7Pmlry"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D991FF1C7;
	Tue, 26 Aug 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168199; cv=none; b=ea03HkPleDH57cFFDshynB4/hY/3rnN0V5AbA1jGSCmjIW6FDf5cD1OyHwh0UTMa2Zlobc4NeE5Kh0284JZ4WUjGy1gAMsz+xae559k6KB9yCM3og9YuDzJ5Hyea0PUISgbH71qJiVav+cIN6J3KLWjkyz6+gl4/bwDWhSF68aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168199; c=relaxed/simple;
	bh=Yse/thwhn2Srhe30lLjXKl4D6noX1iGTCnOLBmeyXFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a68UFM0qenD+d8AqECMLcm6lygurXUYrKq0yWe24ucSGEUKaurp6NbZna2o9n19Y3kHjhqb92z7ZEp2fivcbQZwwcssuHQrNW4VjMjH1reDkA/ww6h4aAu97pLFzf8PDG8vp5BS7CQtsjCqqmV/YDjPSLvtkHqhmRcXKBm8B0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE7Pmlry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2024C4CEED;
	Tue, 26 Aug 2025 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756168197;
	bh=Yse/thwhn2Srhe30lLjXKl4D6noX1iGTCnOLBmeyXFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eE7PmlryHzweOrTITLFQYxC8enyDc8zI8Wg9ppBbL09uf729VRpZbY2zXVxfajXGP
	 GLAbpn6Wzh7QpCXyARXSsB69KrKUrtWhg8/2KampaxvKtEYBMyE+HsJl0ssap9fFHN
	 xrKagRi3X4ik32WX8OW82t0XUG63vpkxlcJezAVjx2lmU6bfVwoXSBDINB5PspNH68
	 KweoScPN1EWHBvVleoBVaWNIMpGkOWTVCka1FNmhu8VM+AWopayg8T1SqbxK38kkVn
	 x8XhQpW7kfWkqtsEE+jV+nW8lW9JpIJjBnEd0fwdPiUNtL0JQLMHt1Obn7QuIdMbVp
	 NT68M6A9tdlfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5F383BF70;
	Tue, 26 Aug 2025 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dlink: fix multicast stats being counted
 incorrectly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616820575.3605658.9920051738919720855.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 00:30:05 +0000
References: <20250823182927.6063-3-yyyynoom@gmail.com>
In-Reply-To: <20250823182927.6063-3-yyyynoom@gmail.com>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 24 Aug 2025 03:29:24 +0900 you wrote:
> `McstFramesRcvdOk` counts the number of received multicast packets, and
> it reports the value correctly.
> 
> However, reading `McstFramesRcvdOk` clears the register to zero. As a
> result, the driver was reporting only the packets since the last read,
> instead of the accumulated total.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dlink: fix multicast stats being counted incorrectly
    https://git.kernel.org/netdev/net/c/007a5ffadc4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



