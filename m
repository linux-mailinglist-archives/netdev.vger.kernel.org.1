Return-Path: <netdev+bounces-127674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217AD976011
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB001F23965
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68433188CDA;
	Thu, 12 Sep 2024 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qldQ8c97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39680188A1D;
	Thu, 12 Sep 2024 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116041; cv=none; b=feQ7/knnz/ei/5SDAr7gqIvhu3ylbrXKL5IGE+81FPucX5K7kaH4VD6hycdi/XUz6GvkVYMLGmO/wjW/E8wqZ1rgM+vOTeX9wW04a3kdMh1fSz0b5Csz+wfEfRO4X3+2sQTZ4u/D+p+wyM2JWD/xKgixEa4aTEOK/XnYAl499Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116041; c=relaxed/simple;
	bh=tBsh/iJwjoN+p4Zef+hkQBecRmEQZ+LHbAZVofoTLOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tCGLFau4Wezu3dpz1qbOy51XhACBqjpNktZHab/0NYW72pZmOXGe3iA7GdmJ1cGOpyHoazCo7PRBKe3gpCAXcU/LAU2h5ijSQ1atyO3AStsCcPH+UR+nOK/0G4Re4PEAERIqoiFJ2zJjPlZKqdN2Lkmx0+vZh5wCy0oUlyZq0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qldQ8c97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3D6C4CEC3;
	Thu, 12 Sep 2024 04:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726116040;
	bh=tBsh/iJwjoN+p4Zef+hkQBecRmEQZ+LHbAZVofoTLOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qldQ8c97DVfPRq9YxbFgOKVpp+eoXdRjsKhxzZYjjyxAf/cVznEJyIHdtDB0amJKZ
	 hC6MhyBuBy6PXxqpYAMi6vJjsQuqoxcrFBc1QMSRvftQlVeRaf6F5ktxC3IE/ys/Yd
	 558NoqPkQhmZXcFDAPveZRuUNBZZc/b7eJpadPpEQqW1wsWVXTcDLEqSRUKh59vMCk
	 dhBKqvMDYAeCWQrVCfThRgdzSe/5rEvugHFK5Q6xjQvawM9v8ulP2A9qzB2t12h7pz
	 giM3KJEMwwrI1NOAQol/w6gHs0ssLKAqdbCNwhCpJs1Yypl0zYSh018mJIClcwpoAW
	 hNaQRq1gEX9qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2683806656;
	Thu, 12 Sep 2024 04:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 00/14] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172611604180.1162260.8588009974357818564.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 04:40:41 +0000
References: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
 linux-doc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
 ruanjinjie@huawei.com, steen.hegelund@microchip.com, vladimir.oltean@nxp.com,
 parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
 alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
 rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
 Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
 Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
 linux@bigler.io, markku.vorne@kempower.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Sep 2024 13:55:00 +0530 you wrote:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.
>   Link to the spec:
>   -----------------
>   https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> 
> [...]

Here is the summary with links:
  - [net-next,v8,01/14] Documentation: networking: add OPEN Alliance 10BASE-T1x MAC-PHY serial interface
    https://git.kernel.org/netdev/net-next/c/b3e33f2c54c6
  - [net-next,v8,02/14] net: ethernet: oa_tc6: implement register write operation
    https://git.kernel.org/netdev/net-next/c/aa58bec064ab
  - [net-next,v8,03/14] net: ethernet: oa_tc6: implement register read operation
    https://git.kernel.org/netdev/net-next/c/375d1e0278cc
  - [net-next,v8,04/14] net: ethernet: oa_tc6: implement software reset
    https://git.kernel.org/netdev/net-next/c/1f9c4eed9c11
  - [net-next,v8,05/14] net: ethernet: oa_tc6: implement error interrupts unmasking
    https://git.kernel.org/netdev/net-next/c/86c03a0f07f4
  - [net-next,v8,06/14] net: ethernet: oa_tc6: implement internal PHY initialization
    https://git.kernel.org/netdev/net-next/c/8f9bf857e43b
  - [net-next,v8,07/14] net: phy: microchip_t1s: add c45 direct access in LAN865x internal PHY
    https://git.kernel.org/netdev/net-next/c/18a918762fab
  - [net-next,v8,08/14] net: ethernet: oa_tc6: enable open alliance tc6 data communication
    https://git.kernel.org/netdev/net-next/c/f845a027de66
  - [net-next,v8,09/14] net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames
    https://git.kernel.org/netdev/net-next/c/53fbde8ab21e
  - [net-next,v8,10/14] net: ethernet: oa_tc6: implement receive path to receive rx ethernet frames
    https://git.kernel.org/netdev/net-next/c/d70a0d8f2f2d
  - [net-next,v8,11/14] net: ethernet: oa_tc6: implement mac-phy interrupt
    https://git.kernel.org/netdev/net-next/c/2c6ce5354453
  - [net-next,v8,12/14] net: ethernet: oa_tc6: add helper function to enable zero align rx frame
    https://git.kernel.org/netdev/net-next/c/afd42170c8a6
  - [net-next,v8,13/14] microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY
    https://git.kernel.org/netdev/net-next/c/5cd2340cb6a3
  - [net-next,v8,14/14] dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY
    https://git.kernel.org/netdev/net-next/c/ac49b950bea9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



