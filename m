Return-Path: <netdev+bounces-214803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A910B2B57E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5388E1B27F83
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F41624FE;
	Tue, 19 Aug 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tACfbk8b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BC1662E7
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564007; cv=none; b=jE5av5+M5fIbbboB+JbfE16jvKK9dZCvH4rHSNO31MPRzSkRTloGKhHHCqSNE8iwOz+ulhRaKRaJ20UH3LYfZ+Fn5Q8CB24LO7J29sE0647f1V/lwWcI9z3mD93nPkstKU5JnvsWqH3Z8ZP4bTFNgs7FAPCCknPpTkPYtaYJVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564007; c=relaxed/simple;
	bh=CBbi+YaO6OmAhgDIHYKXkC6mlmCWzXn8QzPEEydRvN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Frx4zrv893he1qfiJIVRqohp93INz1BUv8tatDPMAt8sBxO0XI1jluUzxy5uIR3mUSCHuIE09uvhjAfg7W1In3j94giCYOXkY+92uFgUvkoZj6m0MD44w4WJEVflqMqwy33FW3yQusqiX08puX5r3xX5LHq7ILXR0JYkuQS1sUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tACfbk8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AB3C4CEF1;
	Tue, 19 Aug 2025 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755564007;
	bh=CBbi+YaO6OmAhgDIHYKXkC6mlmCWzXn8QzPEEydRvN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tACfbk8bmZ+UzFayclRHigrirunhm2TrmEpb+6Mx8LOAzPP1D6Kz5TjUP+nZWBi7s
	 LCKV9mNpKgHy/XhYwOB6fsjd/z3AVuyYZQpi5/5nTtQAVXuU76kQx+Nm2WP7IQke8Y
	 0LAqlxZUIgk00V6u6BUe4p3azWzfImcciO4FM36P8WkX+B4hv3AYQ5gLisGzYZiLv6
	 fJldOgQlHNA07EQYcPaZ7f2pv4gfwQbgD3ctMy67NvIc/gFkiq+pZfe9MndXOAcfdZ
	 iZ1ZFlR3o6Str9XCn6Bffww3sS+Xyd8SwiufudsTtIo5c4pmKReHX/b0e3ddKMUhLI
	 FDSr35/Sj/Q7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08E383BF4E;
	Tue, 19 Aug 2025 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: dsa: Move ks8995 "phy" driver to DSA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556401773.2961995.12073892625067457494.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:40:17 +0000
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
In-Reply-To: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 23:43:02 +0200 you wrote:
> After we concluded that the KS8995 is a DSA switch, see
> commit a0f29a07b654a50ebc9b070ef6dcb3219c4de867
> it is time to move the driver to it's right place under
> DSA.
> 
> Developing full support for the custom tagging, but we
> can make sure the driver does the job it did as a "phy",
> act as a switch with individually represented ports.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: dsa: Move KS8995 to the DSA subsystem
    https://git.kernel.org/netdev/net-next/c/60cbe71fdba1
  - [net-next,2/4] net: dsa: ks8995: Add proper RESET delay
    https://git.kernel.org/netdev/net-next/c/ccf29cb84972
  - [net-next,3/4] net: dsa: ks8995: Delete sysfs register access
    https://git.kernel.org/netdev/net-next/c/d3f2b604a1f9
  - [net-next,4/4] net: dsa: ks8995: Add basic switch set-up
    https://git.kernel.org/netdev/net-next/c/a7fe8b266f65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



