Return-Path: <netdev+bounces-223784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9146B7DF86
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88CD37B3DE7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADDD2D3EF8;
	Tue, 16 Sep 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzKXiUnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5F2D3EE1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066010; cv=none; b=eE06pPtyKkxpWuTjYFHYeIrVQMWP2w4bASIVRFFwh4n/TZIeOcgtS0eX6DxUOCEpNvxSo+7feeZ1FYXjjnKq+DK/4cxjRB4+cNSWKXOU4I/8qczvdF2HZ3EmXoUfNkbbBSony8NVGrQG4PNLqY0/z2V+zdDFImagHaL8CBkGmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066010; c=relaxed/simple;
	bh=SK8G8TNhgxfpxMGXypMixPb9qahHeZ3FAslQFqZczhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t8gvJHL5Tsd98rdaCxl3sn9E6flj7OfekZ0wb8hvucSwXj29x+UTyC/Fc0SrHwyJEK1Yy5U8/Tfow6aOB2FuVSkLjj5FTLAijOtwKLwRdu1awDscvgHMoDLOjn6zj/WFnPW3YgNHsxzBGjhbPCwAFu/zKLQM5kInv71fFX3E5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzKXiUnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA40C4CEEB;
	Tue, 16 Sep 2025 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758066009;
	bh=SK8G8TNhgxfpxMGXypMixPb9qahHeZ3FAslQFqZczhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dzKXiUnSKyDMEY6ffrne/MvAeYoQ7G7fJ1ssAmeD/UEH+WfdCH7bnsPA4I7fpSwD/
	 KRXgZBCAaClaLDWYniz0zGQgRd7gjC8X+whmFDdNBVkkCIRFMmb6rc9lSrT/6grP8B
	 umqaSN1Wzw37/V4KZ1Dt6HXKZofEDKuaPRTN/FDF7ajBYhVcpl+2DPgaNVILmXQOzC
	 QKohvVupSTpJyyAwS+ylKQnTopAVp18T+d08FGwyc9B18oPPHZEl82GW6+6MeF9mF2
	 fUZLhrliYjgDmO/fNjbBEFy1Ozo6NC5R3PIWMeUnMFJiUWZElRDAFJyfAxjGAk/IkU
	 y+OhyK9uB95wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3739D0C1A;
	Tue, 16 Sep 2025 23:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvpp2: add support for hardware timestamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806601039.1401398.1578142169316390884.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 23:40:10 +0000
References: <E1uy82E-00000005Sll-0SSy@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uy82E-00000005Sll-0SSy@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 marcin.s.wojtas@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 13:10:18 +0100 you wrote:
> Add support for hardware timestamps in (e.g.) the PHY by calling
> skb_tx_timestamp() as close as reasonably possible to the point that
> the hardware is instructed to send the queued packets.
> 
> As this also introduces software timestamping support, report those
> capabilities via the .get_ts_info() method.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mvpp2: add support for hardware timestamps
    https://git.kernel.org/netdev/net-next/c/3ea308da69b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



