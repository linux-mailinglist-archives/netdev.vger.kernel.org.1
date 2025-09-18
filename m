Return-Path: <netdev+bounces-224645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D14B874EF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36497AEFF0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE182FF643;
	Thu, 18 Sep 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttuu17Z6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D02D0C94;
	Thu, 18 Sep 2025 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236413; cv=none; b=Bwikx1+p2x89WPnmng5Yp9th/LfClJPUekmaKDy6YvbF4YU9ld8VCcVMp5fK7w0uSv/NxLSTWF2BGRbYmKgWLEraU00nDIRz/VaX2z9bRgTDO4OHdAgs3K/gJbc76J2gZhkh0uGwMjy/+GZ9A6kdwfKTGYba13DbnQumq3N90lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236413; c=relaxed/simple;
	bh=105+uIrZkp6sYq6I8RVsLwvaVqaw324FP820a8j7Sp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cs24GtxedJCZq511cPpRIguXNYcI973/oEnZX0gLCH3auTjukta88xTFI5Nx7SEmz7hJkB0U2k9DrSueaAdvwm7ieabmVatMDBzwvvDteTe7P/op6s3KLnQ4PlgXPbecbNTu8bgdwO6hDdU5ClHCbRWE8EcvcdwNXHeJD3OH5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttuu17Z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D069DC4CEE7;
	Thu, 18 Sep 2025 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236412;
	bh=105+uIrZkp6sYq6I8RVsLwvaVqaw324FP820a8j7Sp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ttuu17Z6PrS2qFmdevl8TXGALCzKOF1C865rSoBUB9GRcTKp/cX7uwQDaNo+2CKd3
	 7hmGnaCiYZdwFO5Vic7/fh4xd4d/eO74sveed1bXpxMOLSfZbsvERx7Y8GVoKBnVqY
	 9ZaxWfN2c2zu2c80EnL9Lppn52utq43vfSVPJKBqzUq5q4vFuoRS1C6dN+2/1QD3ne
	 5Jkt/fDH3KLW4ElaobjdvOTZWfiDh2Hu36WHsV5Z6zbMc39q64x8nLx12u5EelOdo2
	 Y6tulpgwfdMPLrNq4la+uIb6mSoujKZJ6aLLtKxTnie7vh/RFmSqQjhyd47//3BVkh
	 blIHYzJjRdThw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEAB39D0C20;
	Thu, 18 Sep 2025 23:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: microchip: sparx5: make it
 selectable
 for ARCH_LAN969X
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175823641275.2980045.9948655412326093035.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 23:00:12 +0000
References: <20250917110106.55219-1-robert.marko@sartura.hr>
In-Reply-To: <20250917110106.55219-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr, benjamin.ryzman@canonical.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 13:00:24 +0200 you wrote:
> LAN969x switchdev support depends on the SparX-5 core,so make it selectable
> for ARCH_LAN969X.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/ethernet/microchip/sparx5/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ethernet: microchip: sparx5: make it selectable for ARCH_LAN969X
    https://git.kernel.org/netdev/net-next/c/6287982aa549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



