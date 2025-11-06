Return-Path: <netdev+bounces-236529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8092C3DAE0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 752F94E5CEC
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838833CEA1;
	Thu,  6 Nov 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqOa0gIg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7827CCEE;
	Thu,  6 Nov 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469453; cv=none; b=CwVew4ch1aOnVJra9eAyzsbzk248W8ahygVxF9dJrf5UTgojCp76Nyld6X69RkbgKxMd0fq29fNr+mYgXGCpDDhDnx/xmNBptAT0rgPt34ZaE++MuuK8s2YvQpzaZH2gtVKmmWsErkzfdhHUCS5kyn4rQxzjUwHIeZSDYMCDVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469453; c=relaxed/simple;
	bh=WzRrllIQtbo+UJwad6wYd5Ami7Uha4tPFk5HLA8MubA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rkHPRAH9wvHtjF+vB7gpPsB/rxowRiwIv3nUBo/KcLkrD+y9RYi2UJmlw6g0PefcRBE2fbT8BAITTVfiRuF+CnSIYZd+4V8IhNJyvHukuILrBaaoUKwHwiEcdirz7HFA/bTmiIfRS36VWRi6y3t3lKxSLCbcnt2eQjxwRyLW3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqOa0gIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7209EC4CEF7;
	Thu,  6 Nov 2025 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469453;
	bh=WzRrllIQtbo+UJwad6wYd5Ami7Uha4tPFk5HLA8MubA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dqOa0gIg6Mx/iP6+eMqN2y4hYLXmgbA+I4ChYOU7CYDJJxra3ykstpEKtVRhO62uW
	 7DUIXPoqQ8hVGE0SZ+tba83MIeUACNhJrzFIN2ooV1II3rWipJUBgnbT8w21Pw0lZR
	 +87yAYvnvpwlGxS4S/kxS15k7A7QTqfHQVfzWPqJlYtf8U295yh5c0PTScMgXHQKtn
	 2Q4yMX0kiSqWdJ3G1J3j42m8z28S60sRsiuqaeHPm+9F63qVpE3xFCuMvDwjWq7sbL
	 qE1rLtbShTvryBFvJbWCFRY0aGWpwgOFXDNSyZmtxzTFGDArB9YjT0t8tBoImPmBMu
	 eipWvqnFme6XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FBA39EF96E;
	Thu,  6 Nov 2025 22:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/12] net: dsa: lantiq_gswip: Add support for
 MaxLinear GSW1xx switch family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176246942627.378775.17231043041165490395.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 22:50:26 +0000
References: <cover.1762170107.git.daniel@makrotopia.org>
In-Reply-To: <cover.1762170107.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andreas.schirm@siemens.com,
 lukas.stockmann@siemens.com, alexander.sverdlin@siemens.com,
 peter.christen@siemens.com, ajayaraman@maxlinear.com, bxu@maxlinear.com,
 lxu@maxlinear.com, jpovazanec@maxlinear.com, fchan@maxlinear.com,
 yweng@maxlinear.com, lrosu@maxlinear.com, john@phrozen.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 12:16:57 +0000 you wrote:
> This patch series extends the existing lantiq_gswip DSA driver to
> support the MaxLinear GSW1xx family of dedicated Ethernet switch ICs.
> These switches are based on the same IP as the Lantiq/Intel GSWIP found
> in VR9 and xRX MIPS router SoCs which are currently supported by the
> lantiq_gswip driver, but they are dedicated ICs connected via MDIO
> rather than built-in components of a SoC accessible via memory-mapped
> I/O.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/12] net: dsa: lantiq_gswip: split into common and MMIO parts
    https://git.kernel.org/netdev/net-next/c/322a1e6f3d68
  - [net-next,v7,02/12] net: dsa: lantiq_gswip: support enable/disable learning
    https://git.kernel.org/netdev/net-next/c/a7d4b05f9d74
  - [net-next,v7,03/12] net: dsa: lantiq_gswip: support Energy Efficient Ethernet
    https://git.kernel.org/netdev/net-next/c/9ec1fc0bf2b0
  - [net-next,v7,04/12] net: dsa: lantiq_gswip: set link parameters also for CPU port
    https://git.kernel.org/netdev/net-next/c/3e5ef3b1709a
  - [net-next,v7,05/12] net: dsa: lantiq_gswip: define and use GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
    https://git.kernel.org/netdev/net-next/c/0c56a98560c1
  - [net-next,v7,06/12] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear RMII refclk output property
    https://git.kernel.org/netdev/net-next/c/e836824116b5
  - [net-next,v7,07/12] net: dsa: lantiq_gswip: add vendor property to setup MII refclk output
    https://git.kernel.org/netdev/net-next/c/319fd7e9d446
  - [net-next,v7,08/12] dt-bindings: net: dsa: lantiq,gswip: add support for MII delay properties
    https://git.kernel.org/netdev/net-next/c/bea0c1778611
  - [net-next,v7,09/12] net: dsa: lantiq_gswip: allow adjusting MII delays
    https://git.kernel.org/netdev/net-next/c/cdef8e47b638
  - [net-next,v7,10/12] dt-bindings: net: dsa: lantiq,gswip: add support for MaxLinear GSW1xx switches
    https://git.kernel.org/netdev/net-next/c/e1bb4b36a7ae
  - [net-next,v7,11/12] net: dsa: add tagging driver for MaxLinear GSW1xx switch family
    https://git.kernel.org/netdev/net-next/c/c6230446b1a6
  - [net-next,v7,12/12] net: dsa: add driver for MaxLinear GSW1xx switch family
    https://git.kernel.org/netdev/net-next/c/22335939ec90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



