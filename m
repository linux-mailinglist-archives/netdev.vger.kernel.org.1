Return-Path: <netdev+bounces-99627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2158D5863
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710C12834BC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC954DA0E;
	Fri, 31 May 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2tXaJoq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B228DC9
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120229; cv=none; b=KrV8sCcAR04SRNylcmaD6pP1d0YHiquJauP0VHQdBjHSoEu5tbvFyGqcGeKOvDGyS741kgWUcK9VALKS3ItvfMKvNrZLjrCeX3muoHnounfka10ba6hoTQ0TCzicYywsAv8+/Umz4Zsz55fLc1PrPUXmJnbgf9lvqXCY+bSpKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120229; c=relaxed/simple;
	bh=vL0ijEHkhF2PYN7GLDKtQg6L1vNS5krca9S0lPcFPow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jR9zNyUP4vRTcspH8auHIDEjKX5ok/7xbF91ICOv25194JmWCYTJtnmrnx4DtlK0Rr2sWlEYpGfO59KOdeZ/Hqj5uSzWngyE2nXt47IfYzxCSd9qQuuELigls0XzU+rkQI+FP1EfKIhjww2AgDA4Um0F68+UhSNv7UBj+N3sME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2tXaJoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A648EC32789;
	Fri, 31 May 2024 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717120228;
	bh=vL0ijEHkhF2PYN7GLDKtQg6L1vNS5krca9S0lPcFPow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A2tXaJoqXao8Ddv7aUYUV2T/6j/g+0syaODStdy3wgUkRnRP4jEHCOunfzi0nsE2U
	 mtpo5IK8NXt5v3pezjYEe7EAyhIpwBqyZjqv6fm2UHalOtSpvZACQenDXa54yIHuts
	 893AJzk2XknoCaWYfBndzthW+ZbusjsuW5BpTYSooZ20Wl+huwpIjxwpc3f3+auycr
	 7lffhNBKTuNDvi9iRXL5X6pg8Vc9lj+AjZUtyybUCjdd0lus2tSVUpD9tqB949GJzj
	 IzYMOf/n+Erh6FTyPCoCiyvq9rGbVFm0yTWCZI1SmQqYAxoZLCDj/9/AvugenMm9yl
	 Sbr+V8K0piGRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95501C3276C;
	Fri, 31 May 2024 01:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: make the attr and msg helpers more C++
 friendly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171712022860.25058.9366825218870905611.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:50:28 +0000
References: <20240529192031.3785761-1-kuba@kernel.org>
In-Reply-To: <20240529192031.3785761-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, nicolas.dichtel@6wind.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 12:20:31 -0700 you wrote:
> Folks working on a C++ codegen would like to reuse the attribute
> helpers directly. Add the few necessary casts, it's not too ugly.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: nicolas.dichtel@6wind.com
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: make the attr and msg helpers more C++ friendly
    https://git.kernel.org/netdev/net-next/c/ccf23c916ca3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



