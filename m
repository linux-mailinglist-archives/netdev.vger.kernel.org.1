Return-Path: <netdev+bounces-239494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB1C68BB1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 0BBD5289EA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3533B947;
	Tue, 18 Nov 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtIjXzbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A6332ED3;
	Tue, 18 Nov 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460645; cv=none; b=Su3LhPLyt15J/5Eg7wmw+ZMs+Hxr0y1CXgmchE4b4zgZ4ysRQQIo8viHPV/gPys5+cyzP/6aBqwarUZiWmivo695+1GqFpuo4fDSgr9QjQUFkLWqb0zn4Iu9sxEp73PmgYfIa8M2HOBmDM+DKxGrQVqR1gjQDfzncBcVPoW0iA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460645; c=relaxed/simple;
	bh=b+pZBV7epkHUl8mBX3MIDt42yUoTMnfx2I5N3DhgATE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A49E4AH92s4i0ypv8iuQYRHYEE3q+cobRDSSE8JKhplBDCkxLTck1gqLboZdDmkfNNXU0ZvuTvjNpGQqafFqRHmk5RZHnmrUuAQKKqU4GgwKh9wiM6fLq9ckh6BerAW/Ap8LRaLbi5uipjwUTwfq9cuq1GXQTWK8ShQ3J1UZE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtIjXzbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7580C4CEF5;
	Tue, 18 Nov 2025 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763460644;
	bh=b+pZBV7epkHUl8mBX3MIDt42yUoTMnfx2I5N3DhgATE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rtIjXzbzgyy8I3kPhTEMa3ltWVLtGSjFxyDOdqFwsQQrUXnGe1n7a4Bmo8rxpvlqA
	 17K2RUJjR5aGxuErQmPscJepT4oLRKvoeY68gBNSpCAl+Znhkw/Y/61HZXI61M6ALo
	 koh07cOdrHj09YrbgmZbJFnboR6sa3i1RfHpNwjX5I5YE3525bIaXvgPCpcc7nIJ+7
	 v9Jpr/9WHlTZqiKVNHm4NeqWnPiIyJlSdrkSbD3Pz4APWktX7u4wOPrBsRrKJTg6pa
	 TLW4Be90dLSe59Tre+1vaAzc0RYyqWsxbYsal32hGI6mWxRWJjq5ApSS5RJoWvnnjI
	 9/WjtsxaFVcHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4A3809A83;
	Tue, 18 Nov 2025 10:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Disable EEE RX clock stop
 when
 VLAN is enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176346060951.4077292.1388526029829048727.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 10:10:09 +0000
References: <20251113112721.70500-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251113112721.70500-1-ovidiu.panait.rb@renesas.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, boon.khai.ng@altera.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Nov 2025 11:27:19 +0000 you wrote:
> Hi,
> 
> This series fixes a couple of VLAN issues observed on the Renesas RZ/V2H
> EVK platform (stmmac + Microchip KSZ9131RNXI PHY):
> 
> - The first patch fixes a bug where VLAN ID 0 would not be properly removed
> due to how vlan_del_hw_rx_fltr() matched entries in the VLAN filter table.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
    https://git.kernel.org/netdev/net-next/c/d9db25723677
  - [net-next,v2,2/2] net: stmmac: Disable EEE RX clock stop when VLAN is enabled
    https://git.kernel.org/netdev/net-next/c/c171e679ee66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



