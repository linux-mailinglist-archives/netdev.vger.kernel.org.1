Return-Path: <netdev+bounces-117947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F794FFE0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53CAB25457
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA613B791;
	Tue, 13 Aug 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLGbrDc5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8913B2B2
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537839; cv=none; b=EJBY0DSh0nT1c7UmQCeII0S7X4KtBFKa05S/Of0EGqWS/HDnaJ48jNirymCLO/+h4Zg9vozNEWuUlX867uiLVQ/NSKcdalr7MxVrY/AFrN5Eq5/f3otaqGrHEFZXCxf5lVsKhJuN/3ohQeVwbr0qNZ0Tj/rWAnLpinnvNZ7Qmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537839; c=relaxed/simple;
	bh=FjrnECvIBgO1m4IrXXWmovGM6dVcRYE0tL/O3sjtjvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DvNUBsuDnMYDqLb/f5sZ3cLGw9UBsrqosHsEM5EEcf/seP7tlWmyq7CbUjVwTz27ZIYdojlor+TTEfxMewKu8SQtRtnaLticWe7Ee8cCKX/N3W5TfLF1LDsPKPtwwte6M0jhpHrDAaKxZnZecPMZIX5bfYunpNBLMGFu9FEkUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLGbrDc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC78C4AF0B;
	Tue, 13 Aug 2024 08:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723537838;
	bh=FjrnECvIBgO1m4IrXXWmovGM6dVcRYE0tL/O3sjtjvI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLGbrDc5noxiCZGDq6pY6W1YFZYGTQDGyN8rlx3Ab2wyfCodAiZmHZsgL4eTW0zwx
	 /JR8gk7Xid234fa2oV92hw7M9H+308WvFQYe8ck3jgDJzQlAU5DZKGXy8nPrxyPVxy
	 tJ+30rlNcuNEHxEmpgTnGDxkPKTZgPQKLM6vB6hZ4JqLjmjth3Y9TI01JKP5nYUHT5
	 QXERaRbog5xQv3cr0WJ4+wlEqvYwi8JYS7AYZs3KG2xMQ1uf1nzmFEupnlJuguBWpN
	 frnm23fh7lFRVk/mX252qRWjRNdX9UdRAmRzqZFGAdjw7VlspbEl+Rtvw4Om3QZBfx
	 nb2d4I8e+cNkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC43D3823327;
	Tue, 13 Aug 2024 08:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v17 00/14] stmmac: Add Loongson platform support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172353783792.1555347.8584775681524586543.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 08:30:37 +0000
References: <cover.1723014611.git.siyanteng@loongson.cn>
In-Reply-To: <cover.1723014611.git.siyanteng@loongson.cn>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, si.yanteng@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  7 Aug 2024 21:45:27 +0800 you wrote:
> v17:
> * As Serge's comments:
>     Add return 0 for _dt_config().
>     Get back the conditional MSI-clear method execution.
> 
> v16:
> * As Serge's comments:
>    Move the of_node_put(plat->mdio_node) call to the DT-config/clear methods.
>    Drop 'else if'.
> * Modify the commit message of 7/14. (LS2K CPU -> LS2K SOC)
> 
> [...]

Here is the summary with links:
  - [net-next,v17,01/14] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
    https://git.kernel.org/netdev/net-next/c/12dbc67c3b0b
  - [net-next,v17,02/14] net: stmmac: Add multi-channel support
    https://git.kernel.org/netdev/net-next/c/ad72f783de06
  - [net-next,v17,03/14] net: stmmac: Export dwmac1000_dma_ops
    https://git.kernel.org/netdev/net-next/c/005c0f071bc1
  - [net-next,v17,04/14] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
    https://git.kernel.org/netdev/net-next/c/393ea68bf154
  - [net-next,v17,05/14] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
    https://git.kernel.org/netdev/net-next/c/0c979e6b55f9
  - [net-next,v17,06/14] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification
    https://git.kernel.org/netdev/net-next/c/324d96b46520
  - [net-next,v17,07/14] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
    https://git.kernel.org/netdev/net-next/c/79afc70002c2
  - [net-next,v17,08/14] net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
    https://git.kernel.org/netdev/net-next/c/c70f31636813
  - [net-next,v17,09/14] net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
    https://git.kernel.org/netdev/net-next/c/849dc7341d1f
  - [net-next,v17,10/14] net: stmmac: dwmac-loongson: Introduce PCI device info data
    https://git.kernel.org/netdev/net-next/c/0ec04d32b5e7
  - [net-next,v17,11/14] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
    https://git.kernel.org/netdev/net-next/c/126f4f96c41d
  - [net-next,v17,12/14] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
    https://git.kernel.org/netdev/net-next/c/803fc61df261
  - [net-next,v17,13/14] net: stmmac: dwmac-loongson: Add Loongson GNET support
    https://git.kernel.org/netdev/net-next/c/56dbe2c290bc
  - [net-next,v17,14/14] net: stmmac: dwmac-loongson: Add loongson module author
    https://git.kernel.org/netdev/net-next/c/930df0990d06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



