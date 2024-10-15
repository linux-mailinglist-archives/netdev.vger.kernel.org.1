Return-Path: <netdev+bounces-135821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72299F4A9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E57B211CE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD77212D0A;
	Tue, 15 Oct 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTlqL5oW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406D1B3950;
	Tue, 15 Oct 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015235; cv=none; b=otr+zDnME0LfD0Gc2aS5COjSF0KhsaL8DOXj7thoxDWsRrYt1q8HJXc7JSxiQ097ePm54RYCBPAXRhccW1yZXHYCUofGBazGrbQodgRleTm6wZTPB2nu2a7VvKUmW32b1y8Cbw3I+IPEZ5M+ncmZDi6Eyn1J11gf3/0sfGB2KOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015235; c=relaxed/simple;
	bh=mSMrKigvl+eEBMjy+rKC6bAF+4lpFPvg+GAq87DtpfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bzpxurEh2cHN8LEtZuRtYK7Fx9E96CtQbaELEd2XgixT/rfiZkrem+uY+07kMKyl9lNjYWjZsaS45a6A6P21YI9rD9mNoNNemmIt9JKV11+mXLOknx/DaFl6cqjF2C/hnd7xmoYYiOOJqKNjBEThcL87WTRhrSPdfIDsrNbcIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTlqL5oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C8BC4CEC7;
	Tue, 15 Oct 2024 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015234;
	bh=mSMrKigvl+eEBMjy+rKC6bAF+4lpFPvg+GAq87DtpfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PTlqL5oWTlQBn82wy/zuoEGHqIh/453oPQbUBvHyIOgaAnx9NuxIXuNzBOZ/8uKXp
	 tzDLHTX6fLWjKV0e7W4b69DcLvJsuHfR38SiWkuxtLGlGZnpDYzvEO1RsNruTqCpDU
	 X+OcVk+OeHZ0HigIfjSFtTnRf5y/f4P6PZJ044zb0854jhJgzrzHSovWm2udijiPGf
	 uKXiq2e3GAHVY0KPWvfkVCwrY9WsrCdoj/poy/XJ+oWhn8zXAMUY7RmQGx3LRHvbO9
	 hU1clqKXgqdCkcszOIUp1SKi8BDOZubKEbpQlw4ckqMPLF5IFPXW45woUXoquD4W7P
	 82dmdL3YB5hpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF43809A8A;
	Tue, 15 Oct 2024 18:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: String format safety updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901523973.1243233.15115211719857915822.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:00:39 +0000
References: <20241014-string-thing-v2-0-b9b29625060a@kernel.org>
In-Reply-To: <20241014-string-thing-v2-0-b9b29625060a@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, morbo@google.com, daniel.machon@microchip.com,
 f.fainelli@gmail.com, jiawenwu@trustnetic.com, justinstitt@google.com,
 mengyuanlou@net-swift.com, nathan@kernel.org, ndesaulniers@google.com,
 richardcochran@gmail.com, olteanv@gmail.com, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 09:52:24 +0100 you wrote:
> Hi,
> 
> This series addresses string format safety issues that are
> flagged by tooling in files touched by recent patches.
> 
> I do not believe that any of these issues are bugs.
> Rather, I am providing these updates as I think there is a value
> in addressing such warnings so real problems stand out.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: dsa: microchip: copy string using strscpy
    https://git.kernel.org/netdev/net-next/c/26919411acfa
  - [net-next,v2,2/2] net: txgbe: Pass string literal as format argument of alloc_workqueue()
    https://git.kernel.org/netdev/net-next/c/d6488e77725e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



