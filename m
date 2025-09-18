Return-Path: <netdev+bounces-224457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679B0B8545F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F2016B7FA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E530C115;
	Thu, 18 Sep 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB8/eMHz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396C30C10D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205820; cv=none; b=rkn96vew21hVwpx1PraGQ9g2CpTsMlukYBuyCKcXBpwoHDFL+zcZHmrbp5NQ0fqcnA6iJfGYsFCh5rMIwMMdgcEEvnTt3JaCmb0TElxkqkc/WrtsKDas4XI95wYU/BcKpTAHmtvZfTCOc7ttr+UbQl29jhCNRpjDmW1yyM84gys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205820; c=relaxed/simple;
	bh=FKe7vzazVCUY2TlUqN/aTil1n/r2GxrskeIPvcMPnQI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6d3+Nqsq/O/ZRz6oaqjhWCitmVVi/l3xD4MxJhRsirPp5N+FPCy0qSiEKJww55C5GReWjfoUAxkfnEaVhNB2Brxf7kb+RVFKLe4NySeXkHpIOlS2/zjqJeNXiDJ7fuLlcdQuwZBXrosM4mTdwOswJg44Uc8mLXKbWMjvuuPTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB8/eMHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60453C4CEF7;
	Thu, 18 Sep 2025 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758205819;
	bh=FKe7vzazVCUY2TlUqN/aTil1n/r2GxrskeIPvcMPnQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oB8/eMHzPjrLVmjRuHsFF+RwigWr7eQDhugbwrOd5xPeoj36/YLJaweulyErF3qe2
	 caYFAfjmxWbKYiNOdj//6W4BAAvW37ack6SviF6ms3lbYSHsD9gVwAtbYlPN45isp3
	 PbPq3Q0Eas0swYROZAH+uF0CdnMj4Ejm6qE+kWPg60HpVk7IxyGoJMIXki3kUbU10x
	 oNET6tpi8UFedCpaTTrapIdhdlPOPlHe/UTkK5car0OXGBJzje0tCnvEbgjDCbGr3h
	 fiwAZ7h0fdpSpFv+Ex23aLh6zpWqippvRPf1jUU2QbKvI2THaocnyVtq2fxpMpAHRq
	 pALmZO1noIiYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB739D0C28;
	Thu, 18 Sep 2025 14:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] psp: rename our psp_dev_destroy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820581925.2438890.3462400880104466202.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 14:30:19 +0000
References: <20250918113546.177946-1-edumazet@google.com>
In-Reply-To: <20250918113546.177946-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, daniel.zahka@gmail.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 11:35:46 +0000 you wrote:
> psp_dev_destroy() was already used in drivers/crypto/ccp/psp-dev.c
> 
> Use psp_dev_free() instead, to avoid a link error when
> CRYPTO_DEV_SP_CCP=y
> 
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Closes: https://lore.kernel.org/netdev/CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] psp: rename our psp_dev_destroy()
    https://git.kernel.org/netdev/net-next/c/672beab06656

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



