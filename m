Return-Path: <netdev+bounces-158652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA5A12DB9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DB116632E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295441DC99C;
	Wed, 15 Jan 2025 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8yxRWF1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232D1DC996
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976626; cv=none; b=hd2cDP0fG7GAA8hUE06Ry8tW47VxIhBwbmj8h4lYiihAQ72A1etcCigcXyBj9vmcSXNmQDhnG77KTEc7BYdMJfKLQSPwYL11xHO8t4WTTirv8sUQp6Ih01jojK0nQPCVA/MAvTgaWyf3ElBzAS6U14GrXqQPimIwOuu/PnTShVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976626; c=relaxed/simple;
	bh=LE8fA2hAMhhDI5KwgEq05/0LGmnaeWzG7l9oulZaTgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dqXO8Z9S16K2lDsKcg2VTp1QRwDxzwSnePA1RY8P82sMYp4pqP+sSuTEav2ST0UD2iLj2rmjxFinZV9x1oCVbdd4UvPSyy08eQ7a9xcOFJui/b7xPv5oj6o8JUmjS7JGXraHGC4tK90PAAlW6KnaqrUxBBqxGK2KbBSf9BVLKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8yxRWF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D10C4CED1;
	Wed, 15 Jan 2025 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976625;
	bh=LE8fA2hAMhhDI5KwgEq05/0LGmnaeWzG7l9oulZaTgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P8yxRWF12yA+CipCEyGIzKRv4g5Vac+F7zE50cg22snFi5j0Jzw+R0LlAaq7GM8xs
	 0hu70OOCza20MDg9Of2KKGaLlUIACrqeaG3dSmH8T2fUWUgdGI2Iy6pw44BjTcpQbC
	 7ake8LkLQaVusqCkJ9FjYGLYm+II0P9kFKI8qIk0FDtqcTEB1JByFtJvyhl2RM3aJS
	 Y4auUQTxemzxvGUjmo1AvO7xaIlxNxhcfWTgyNML3LK3Y/DPZJF0XSyw8Wg9bHPKwC
	 qTSmNipXmZ7rIe0Lr1a6A1zv13pgAW+vwBoqI0MFRmJbcS9kG4N7KFtV7Un/8Bi+MU
	 q9j2EyvkM0Mmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB7380AA5F;
	Wed, 15 Jan 2025 21:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: phylink: fix PCS without autoneg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173697664846.885620.3750328889492102157.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 21:30:48 +0000
References: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
In-Reply-To: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, lynxis@fe80.eu,
 alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 claudiu.beznea@tuxon.dev, daniel@makrotopia.org, daniel.machon@microchip.com,
 davem@davemloft.net, dqfext@gmail.com, edumazet@google.com,
 ericwouds@gmail.com, florian.fainelli@broadcom.com,
 horatiu.vultur@microchip.com, ioana.ciornei@nxp.com, kuba@kernel.org,
 Jose.Abreu@synopsys.com, kernel-team@meta.com, lars.povlsen@microchip.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 madalin.bucur@nxp.com, marcin.s.wojtas@gmail.com, matthias.bgg@gmail.com,
 michal.simek@amd.com, netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 pabeni@redhat.com, radhey.shyam.pandey@amd.com, sean.anderson@seco.com,
 sean.wang@mediatek.com, Steen.Hegelund@microchip.com,
 taras.chornyi@plvision.eu, UNGLinuxDriver@microchip.com, olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 09:22:15 +0000 you wrote:
> Hi,
> 
> Eric Woudstra reported that a PCS attached using 2500base-X does not
> see link when phylink is using in-band mode, but autoneg is disabled,
> despite there being a valid 2500base-X signal being received. We have
> these settings:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: phylink: use pcs_neg_mode in phylink_mac_pcs_get_state()
    https://git.kernel.org/netdev/net-next/c/0f1396d24658
  - [net-next,v2,2/5] net: phylink: pass neg_mode into .pcs_get_state() method
    https://git.kernel.org/netdev/net-next/c/c6739623c91b
  - [net-next,v2,3/5] net: phylink: pass neg_mode into c22 state decoder
    https://git.kernel.org/netdev/net-next/c/7e3cb4e874ab
  - [net-next,v2,4/5] net: phylink: use neg_mode in phylink_mii_c22_pcs_decode_state()
    https://git.kernel.org/netdev/net-next/c/60a331fff5e8
  - [net-next,v2,5/5] net: phylink: provide fixed state for 1000base-X and 2500base-X
    https://git.kernel.org/netdev/net-next/c/e432ffc14b17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



