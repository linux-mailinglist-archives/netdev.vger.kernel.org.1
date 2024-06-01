Return-Path: <netdev+bounces-99953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3758D72B2
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B208B2119B
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C82405FB;
	Sat,  1 Jun 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0z4uMV+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BF3BB21
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284030; cv=none; b=V10efo1Astz15DdDEEamQKlczUnvVVAFUvWDM4JE0D8OXd39ftR+x2HdlzJjrZpdvE6siosFYYYpHBoshb/O6TzDOSlG4RsdXDkYWUNPbSyHggP31DPptwjaLVH+hK4AEsR22VRJ1i5EgiVIOaKJDjEfs4y3ifwSQYznFYa3pls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284030; c=relaxed/simple;
	bh=d7PiAtcZozhaN9bwr2mqN7yRM0RF7CCeIZmZFvY9iqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eP7WF+IM3vpOn7a4MePABiuxFZsx44oEd92BzG93f/9TlXDY0Z/8ZOMkx1tpxP++7POmfZomhwLMXLT6Jiht0bNQYiCb8hicKg6bf9ADhrpkt327pVQMo8Tdyz/Ew+hDBQtEEPxDCQuwkpDEEB1XjnpEMZ+gKWt4fA6LlskRF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0z4uMV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFE11C32786;
	Sat,  1 Jun 2024 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717284029;
	bh=d7PiAtcZozhaN9bwr2mqN7yRM0RF7CCeIZmZFvY9iqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B0z4uMV+0aEKvQrO7EP1Tp7XhNVEIZ5czqv/bUmLXXdu90oF1kZOS77wH7NjrgGw4
	 0jFMz5KwVMTjuEeTuitaMOiMpZb0ZGHsYSEieWhldj/u6YwIzCJaJprk/ZBYKxeXbu
	 cjDcbmC5uCSIJuKMaJAy9Fm3aUikiTZc/J6+t2mlplF4fsTbqBT3w4y34fRgNxtoGm
	 jAxyeOXime/YnrtCcDIdLBNB1xMAdmHDGAsD6D/qWWmohfxs+Qy1cuHQ5rDLWRT2WW
	 YjakFrp18F7Zf8ReSGF4Os4v5fXpQMhBCooj4zjLBleyjNQX5rGk7AEEfRV4BbR0RI
	 IB36D+rPc+tZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FBF3DEA711;
	Sat,  1 Jun 2024 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: ethernet: cortina: Use phylib for RX
 and TX pause
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728402965.13922.13440746352997363236.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:20:29 +0000
References: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
In-Reply-To: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ulli.kroll@googlemail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 15:59:59 +0200 you wrote:
> This patch series switches the Cortina Gemini ethernet
> driver to use phylib to set up RX and TX pause for the
> PHY.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v4:
> - Drop the register setting in .set_pauseparam(), just call
>   phylib and let .adjust_link() handle this.
> - Link to v3: https://lore.kernel.org/r/20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: ethernet: cortina: Rename adjust link callback
    https://git.kernel.org/netdev/net-next/c/a967d3cee86e
  - [net-next,v4,2/3] net: ethernet: cortina: Use negotiated TX/RX pause
    https://git.kernel.org/netdev/net-next/c/15c22101db71
  - [net-next,v4,3/3] net: ethernet: cortina: Implement .set_pauseparam()
    https://git.kernel.org/netdev/net-next/c/dbdb0918da67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



