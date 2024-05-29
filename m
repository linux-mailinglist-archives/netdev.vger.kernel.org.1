Return-Path: <netdev+bounces-98959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D098D33AF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC911C22B76
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732216E873;
	Wed, 29 May 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFPrX9eX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263716ABEB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976229; cv=none; b=Dw/ZYl5FZ3a2KasMK9qlgxc2bCm0EmLxTsvljanGnt0vtuqppLLmHG13FS9hgCOb+1+uytNrtZOrtizl1UpCBTqc5H9lnloMoivyeAoiNPdtJb8C2Z80ZihGNnrxgROC4nMf0T9wAX8tRiF1ncWZDuJkJEUGGk0asOfRfs2Y4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976229; c=relaxed/simple;
	bh=gJPfDX/1R89HNnTsnsa45Mav2rz07h/4uZ1oLxMp8oY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gPvn76/nKhkdrWqkctRkW2TEBSp/v0oOcURrvdnz07xWHcmSURJ4CV94O0wPtaZtaQ4w1sT1Yz3P1CvEE5YdaUeDSVSPzNTMyNDofJSZm9JIbYgzjf6YYa4OI0x3lYLPBdVVKbsB0439OdR3J3+BArihBgGse15+lE14ZIQD2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFPrX9eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21409C32789;
	Wed, 29 May 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976229;
	bh=gJPfDX/1R89HNnTsnsa45Mav2rz07h/4uZ1oLxMp8oY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EFPrX9eXV3p1SvQhUiqXwAQHbznplVewYTaPOUQtic6NGHOQQ+7QhTEgbaRMCHxZd
	 AABWhQRNUR9xrWcOebcxIOCvmMRg4eJhpMzUdB83PfB7IxQnWaru5QRYd90A3hLJWA
	 bJArhanDhy13ZJz1Izs2uj7+mguGiFXB0lLIgPx1TiJjbC2PVE2SpFRhI3twgM4bkp
	 sXFWrjeaBAuIQ4c6MZa87R1wgrLSaoyBa89+L3KYpflbibRqxXXPcq3WLFVPqzKl4C
	 7ab7T2I6mCZm6a9ItOLnttq90jCyzDjzeYAz751z8hw1h7C4Tbfjxmavrlqy3kAa62
	 3fJC9i20gHvWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DDC8E6C362;
	Wed, 29 May 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: ethernet: cortina: Restore TSO support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171697622905.17150.13034737417147144191.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 09:50:29 +0000
References: <20240527-gemini-tso-1-v4-1-1f8103b27d44@linaro.org>
In-Reply-To: <20240527-gemini-tso-1-v4-1-1f8103b27d44@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ulli.kroll@googlemail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 27 May 2024 21:26:44 +0200 you wrote:
> An earlier commit deleted the TSO support in the Cortina Gemini
> driver because the driver was confusing gso_size and MTU,
> probably because what the Linux kernel calls "gso_size" was
> called "MTU" in the datasheet.
> 
> Restore the functionality properly reading the gso_size from
> the skbuff.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: ethernet: cortina: Restore TSO support
    https://git.kernel.org/netdev/net-next/c/2942dfab6304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



