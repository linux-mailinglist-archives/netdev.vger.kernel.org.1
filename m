Return-Path: <netdev+bounces-133624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0A99687C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797FA1C224E0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB819258E;
	Wed,  9 Oct 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1aPEKLP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7518191F89
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472836; cv=none; b=Rx81T47ksHNs76kwhb4VPb5fTChZHFhJ5knwEM0AQM/eXFqYg1qsi1jOhJ8PWdXAJQNgwsthvnJ5mjt94aodaDfdlTXxlXmTKJhvVcsiQVq4bF6Ewpu/C9LEsw2mI08dzGNUHLEXG99tSMgjH87bKQjm/kyyt9JBAFNzqEWgMp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472836; c=relaxed/simple;
	bh=xaSEJ3dD1rU6zIl94O2EI/NrZsUS7PivY49japQdM6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oqwUSlg/uCWsC2C2l7KhJ11zbWCC4CR/h2r4X9Z0DNqCEIvZYU2JXxpoKWsrhPnVbDfDJNYWcxAguz8ACVbTkq1WQI5DQ/ZRKrvxH4NsPoLEXDHPH+ZYaOd5AeSe+OlgaclY81RMdIiR9F7mt2hxSg+z0s9iKa4Oa2c8KXR2V20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1aPEKLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7782AC4CECD;
	Wed,  9 Oct 2024 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728472834;
	bh=xaSEJ3dD1rU6zIl94O2EI/NrZsUS7PivY49japQdM6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1aPEKLPrraWDfdq78spXaxl/+bFzdtXSd+vGgTcOY3MGJe2gOIcwzFFoOj3lc2qR
	 FBF+7gZGLK5cwOqeakq6v5YDEE388UGcP2cW86pDZ7ki1Ps789PgFX5XK3PVICbtRn
	 2ziy+O+rTQjoL7eFmU3S4uvsfzvHlW5fUtks0WZzbFu9QRi8d8fHJgX8pldEO3bev1
	 27IgjH08w1OKmAX9MRx6svik7ZzckL/Tq7hFtN7zphUjprkbi4lY18Mb0KH+edmPuw
	 llpGeO5fGSJDiX5cWKXpd/ZJN/A9yDLB3gtEzekawnaoLR+Srb0HKRp5TchhkqHvnB
	 uoDo/06vv9Yhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD63806644;
	Wed,  9 Oct 2024 11:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847283848.1228916.5224777219371155033.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 11:20:38 +0000
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
 kuba@kernel.org, jiawenwu@trustnetic.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 mengyuanlou@net-swift.com, netdev@vger.kernel.org, pabeni@redhat.com,
 olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 4 Oct 2024 11:19:57 +0100 you wrote:
> This is the second cleanup series for XPCS.
> 
> Patch 1 removes the enum indexing the dw_xpcs_compat array. The index is
> never used except to place entries in the array and to size the array.
> 
> Patch 2 removes the interface arrays - each of which only contain one
> interface.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] net: pcs: xpcs: remove dw_xpcs_compat enum
    https://git.kernel.org/netdev/net-next/c/e30993a9ab00
  - [net-next,02/13] net: pcs: xpcs: don't use array for interface
    https://git.kernel.org/netdev/net-next/c/0397212f9306
  - [net-next,03/13] net: pcs: xpcs: pass xpcs instead of xpcs->id to xpcs_find_compat()
    https://git.kernel.org/netdev/net-next/c/4490f5669b06
  - [net-next,04/13] net: pcs: xpcs: provide a helper to get the phylink pcs given xpcs
    https://git.kernel.org/netdev/net-next/c/f042365a26b0
  - [net-next,05/13] net: pcs: xpcs: move definition of struct dw_xpcs to private header
    https://git.kernel.org/netdev/net-next/c/accd5f5cd2e1
  - [net-next,06/13] net: pcs: xpcs: rename xpcs_get_id()
    https://git.kernel.org/netdev/net-next/c/135d118bfd01
  - [net-next,07/13] net: pcs: xpcs: move searching ID list out of line
    https://git.kernel.org/netdev/net-next/c/7921d3e602fc
  - [net-next,08/13] net: pcs: xpcs: use FIELD_PREP() and FIELD_GET()
    https://git.kernel.org/netdev/net-next/c/f68189181061
  - [net-next,09/13] net: pcs: xpcs: add _modify() accessors
    https://git.kernel.org/netdev/net-next/c/ce8d6081fcf4
  - [net-next,10/13] net: pcs: xpcs: convert to use read_poll_timeout()
    https://git.kernel.org/netdev/net-next/c/d69908faf132
  - [net-next,11/13] net: pcs: xpcs: use dev_*() to print messages
    https://git.kernel.org/netdev/net-next/c/acb5fb5a42cf
  - [net-next,12/13] net: pcs: xpcs: correctly place DW_VR_MII_DIG_CTRL1_2G5_EN
    https://git.kernel.org/netdev/net-next/c/5ba561930390
  - [net-next,13/13] net: pcs: xpcs: move Wangxun VR_XS_PCS_DIG_CTRL1 configuration
    https://git.kernel.org/netdev/net-next/c/bb0b8aeca636

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



