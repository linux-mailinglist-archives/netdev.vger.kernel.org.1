Return-Path: <netdev+bounces-149950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48219E8311
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAA5188491D
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9DA932;
	Sun,  8 Dec 2024 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD8dCPQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582092595
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733623219; cv=none; b=AkP+4zlNV3tdYXRyB+UQvpbzHtYlw6mKzveGgFp9Lh+Mk/MSx77j3Cy+IGqSVSkrnqeeoTzijAzfUWAghKtj32/JDJhU0BO0wD2Q7bpjFsS+VUPb/637nXKCQjPU/ruGZosdlpufgpAu1G0hYjBxBA2fOmz8ntHhslP5iJSRt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733623219; c=relaxed/simple;
	bh=FDvzHK5dr0tpZ+L52+096tJtxhwp4GWAM+rvod2xda4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldiE8sPGQNNnNct7E5OTjA4W2+dWE3FNbjrgVLKe4ZT/KUhJOHk05hPE0+S6SLoUNSNzVljiJ0aQXUzbF9jbi0F/389VbTcS0v8v/6RLzdPGA1FPUJHpS5PsnAMvTHktF0ks8E59zZ6DPSXS9S/w78SteASFs+Cqs2iObrRPid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD8dCPQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D87C4CECD;
	Sun,  8 Dec 2024 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733623218;
	bh=FDvzHK5dr0tpZ+L52+096tJtxhwp4GWAM+rvod2xda4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RD8dCPQ5J1odGjPGgls5DBu+hsGTgAfj5IvKyNU7169S/rjTU72WfPpFb4oraxCo1
	 AtgjfXM4lAL3rbuzmrAu/wQaKfKAcGJYu9VCb1rurXpVRLO2g/InqFIBNXNRiHGXtR
	 4lI2Lgq1fKW+KhAWBXYW9DYk/7BNgrDnXQ4Tce8i2lpCNA5i7DoNNNBIdaUteqbg5j
	 L2rWXAaTsYTXpHFZ1W+8yf7ENC2oFcMZddyXf6avQEXyGpjmGEvguOhuWkLaOQ88gQ
	 C+hNUjTMe8df0uCC3mSs2tl4/8bUA4ONBPKb/fdPhFnhYxBc4MXZda/XLkKtqEU4K6
	 /jXtFz9xuK+uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F6E380A95D;
	Sun,  8 Dec 2024 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: net: add negotiation of in-band
 capabilities (remainder)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362323373.3131871.16932382585953200042.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 02:00:33 +0000
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
In-Reply-To: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, lynxis@fe80.eu,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 davem@davemloft.net, edumazet@google.com, ioana.ciornei@nxp.com,
 kuba@kernel.org, Jose.Abreu@synopsys.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Dec 2024 09:42:07 +0000 you wrote:
> Hi,
> 
> Here are the last three patches which were not included in the non-RFC
> posting, but were in the RFC posting. These add the .pcs_inband()
> method to the Lynx, MTK Lynx and XPCS drivers.
> 
>  drivers/net/pcs/pcs-lynx.c      | 22 ++++++++++++++++++++++
>  drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
>  drivers/net/pcs/pcs-xpcs.c      | 28 ++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)

Here is the summary with links:
  - [net-next,1/3] net: pcs: pcs-lynx: implement pcs_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/6561f0e547be
  - [net-next,2/3] net: pcs: pcs-mtk-lynxi: implement pcs_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/520d29bdda86
  - [net-next,3/3] net: pcs: xpcs: implement pcs_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/484d0170d6c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



