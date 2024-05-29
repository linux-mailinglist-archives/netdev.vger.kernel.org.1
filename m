Return-Path: <netdev+bounces-99009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5798D3592
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA450287038
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160614B076;
	Wed, 29 May 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaRCdd3a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD51BDCF;
	Wed, 29 May 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982230; cv=none; b=FIewkDddMAYUU+jhl9O7ve5nM8j94pdeMlYjBE4bJqivftPCP9/pCWCo7EeKz+bKUFuUeQm8Rve1hs2F9PrWNHGBH4eCBMr3aEjBcpkLRSSzwxEALLXwlP8UlI/g1evFQV3iEnyCB4vvFiWXD6bA71MhFVI3iymYNIS9sQ3YPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982230; c=relaxed/simple;
	bh=iGJBYC0HS9WohGDJgHX+IX1VimUcl63tvEKfwQTFOLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UZv5wvARTJ2KOBp0DFwMXj77D27/+4XN0W8EHKxZAoeSL6WxontS8HacHtaDUVPWjtPUtUpz9zy62bJ9NXRajG4xsTt8Hafhj9ekmVuHPHBOLwJIvx9ACbzF4taW5lXRp8CRGktM27emS7NEcDv1IaAB+sOiHQSFviD93ly5BQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaRCdd3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2143C32786;
	Wed, 29 May 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716982229;
	bh=iGJBYC0HS9WohGDJgHX+IX1VimUcl63tvEKfwQTFOLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HaRCdd3aUptqszMAFpDNjuPVQW4EdDUIJdM1lbP1sbDyN14I8+s0hpFOEd/L9+/mh
	 f8tYyfxiuNR8f6ZZDYwgnzjVy1o9Tb+KucSc99IMyWzZr+8L7BolGmVvF2LAQ/W1O5
	 VnWnAbLmLMjLn3dkv6Pn2LMYZJZq6LutIJDtTWPd0OqDQsXcki42uy3p3suaEZInbF
	 vURY9/WxqUgpM6CNdqWIB9pP2TAbQhNoevrSjJBGi9kJrrRelHSqA5tZ6CofP3N0gx
	 Hf7tq1+ooTXxPt24jBCbBQox1zFmKmcFIGtFpGFY/DBedynXvyqUM+AsfX28Bp/gsG
	 ZgiDHrMT1Smgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1ECCCF21E0;
	Wed, 29 May 2024 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] MAINTAINERS: dwmac: starfive: update Maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171698222979.5082.5782691130195774110.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 11:30:29 +0000
References: <20240528015120.128716-1-minda.chen@starfivetech.com>
In-Reply-To: <20240528015120.128716-1-minda.chen@starfivetech.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel@esmil.dk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 28 May 2024 09:51:20 +0800 you wrote:
> Update the maintainer of starfive dwmac driver.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1] MAINTAINERS: dwmac: starfive: update Maintainer
    https://git.kernel.org/netdev/net/c/e9022b31db80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



