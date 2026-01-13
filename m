Return-Path: <netdev+bounces-249296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BAD1684E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAFDF30434BE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63312E54BD;
	Tue, 13 Jan 2026 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li7xYAfL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA12DFF1D
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275226; cv=none; b=kvwn+0r9JePDErQjsoEm/QKz+qy4+wxo7MPCbjVTTadV/H90nZ+12TxAxBtbE1jXyiCoJPghv8xiIF0PCrA7gKdkFyZhb2XV2h3li+tuhAxDWTlvRVBz9dWdHw9N1hqYbdIrf14SM+imm5dsIUfufLUdykzvftk/OfrU49EuegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275226; c=relaxed/simple;
	bh=ghxWAxaKTKkmsVbsdzA11Urtk2Kgf2X5q1EQvWKdp5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F7JiDegMc3sDNt/rTn8mmYO7/zGLbATYg90AyYnNb6V+8RylHsik/e+Y0pXIftgzYD4vFHS37fm8dtm5UU2nkN+5jztEvL/PBOQkw77CygrhOUwlxFNv//3xFXlAUFDlGU9A5Bdnk3dJYv3lZHHjS/xUI6oMC3JLEykLdF6WeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li7xYAfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D29C116D0;
	Tue, 13 Jan 2026 03:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275226;
	bh=ghxWAxaKTKkmsVbsdzA11Urtk2Kgf2X5q1EQvWKdp5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Li7xYAfLKq1h2pWcxFbSNAgK6De9IgIq7XE6uPw5B18BgIh92EgPeK586rULxpBhT
	 huo1R6R9r9QB4KjLejwGr3iFCJXyFOwIE6tMK11Cau5C+ZKuLlc+4xMPRjWR5LXPIH
	 8hLsDtzC5da59pqsar153ZehL56Kicbb61+X3FdtVmT15Sx79C8Lds5Wqq8yn/IjBX
	 VfSlU70ah2r9N3+5JzHFp3SKgaWwyIe0JcuRhAugqkND2eV42DEAFqZbSKHcUCyDAC
	 s8oazh6uMMm434plZiMPHsjMvJmQmMU1C+EkvgGgSNn5mIWvCPr91KQZA7UXJ8cz1p
	 JAVJpb6rnoZpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5C2CB380CFE1;
	Tue, 13 Jan 2026 03:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] r8169: add support for RTL8127ATF (10G
 Fiber
 SFP)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827502011.1659151.15829911581216218944.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:30:20 +0000
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
In-Reply-To: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 vladimir.oltean@nxp.com, michael@fossekall.de, daniel@makrotopia.org,
 nic_swsd@realtek.com, olek2@wp.pl, fabio.baltieri@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Jan 2026 16:12:30 +0100 you wrote:
> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
> DAC). The list of supported modes was provided by Realtek. According to the
> r8127 vendor driver also 1G modules are supported, but this needs some more
> complexity in the driver, and only 10G mode has been tested so far.
> Therefore mainline support will be limited to 10G for now.
> The SFP port signals are hidden in the chip IP and driven by firmware.
> Therefore mainline SFP support can't be used here.
> The PHY driver is used by the RTL8127ATF support in r8169.
> RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
> PHY ID.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: realtek: add dummy PHY driver for RTL8127ATF
    https://git.kernel.org/netdev/net-next/c/c4277d21ab69
  - [net-next,v2,2/2] r8169: add support for RTL8127ATF (Fiber SFP)
    https://git.kernel.org/netdev/net-next/c/fef0f545511f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



