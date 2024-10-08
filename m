Return-Path: <netdev+bounces-133033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808699453C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321561F22237
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF6192B91;
	Tue,  8 Oct 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q31b5xb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87C16EB76;
	Tue,  8 Oct 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382831; cv=none; b=QwtITHUrDrnL9vhfHgqITB6OGML0u7Md3Yffkaf1AWmosNdaQsledIH66hGAEZY/hDLrMjgYZU3TCopR1PGlGx0lTbVcDX5Pjy2YuCQB48DHWJZZYOHCz2H7giztrawUcZXUeKKsZKhEJn/mF8wKZvNOLzX/pHfszKRp7dVrzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382831; c=relaxed/simple;
	bh=kLi+2f/IPLjUmv/ri1Lmwen9Td/rsABcslFVqFuImKo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pxa9qxyKHXgD3jZ7JdL8Sn+sNGaTBr4eiFZ0vW4NThW4QR8DQg8oILyvOXY1yw6RLaEcchSxYIEcHLXfR2tbbL2BWtya+OS2in0ucCh0eWqP2nEYIY17WzlBZqHrQf9NLKYBVTJ1bruFdqVFfg/9u+F0K+G3rfblgFMp4XPTHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q31b5xb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62CEC4CEC7;
	Tue,  8 Oct 2024 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728382830;
	bh=kLi+2f/IPLjUmv/ri1Lmwen9Td/rsABcslFVqFuImKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q31b5xb39mG4jassUDPkVLpwImy1wum4qzSx4laNP9oiB7DL99KMBqYB9LJazRtkg
	 nSIZuFSX+vA5pZhimXb/E+K+ARi8glIn3wMVm55EtQV4QBKM4+ArKPk09IX0dai6ey
	 fte2qx586YcdBeh3trb3NmCRmXEgyHHILpJ4mgja5KT3Tm8ZnCLJrER2KqqNDUit0W
	 /vV5YN8nqeVSWXE9H/TRurfaU0Lgk2vYo6qZR/kcCaDOmjk0J7E+7I/nMq/DzDW2J2
	 TR+gBri7ZUyKYhNOzoGXGTiRPMHRYK6X8Xjc0iityyfB+xayKawhPuhzpYNXRl350r
	 KCujo4yKGU19Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343163810938;
	Tue,  8 Oct 2024 10:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15] net: sparx5: prepare for lan969x switch
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172838283503.481683.11330764068159767637.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 10:20:35 +0000
References: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
In-Reply-To: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 horatiu.vultur@microchip.com, jensemil.schulzostergaard@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com, horms@kernel.org,
 justinstitt@google.com, gal@nvidia.com, aakash.r.menon@gmail.com,
 jacob.e.keller@intel.com, ast@fiberby.net, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 4 Oct 2024 15:19:26 +0200 you wrote:
> == Description:
> 
> This series is the first of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
> 
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] net: sparx5: add support for private match data
    https://git.kernel.org/netdev/net-next/c/1d00c0804852
  - [net-next,v2,02/15] net: sparx5: add indirection layer to register macros
    https://git.kernel.org/netdev/net-next/c/5ba3f8460393
  - [net-next,v2,03/15] net: sparx5: modify SPX5_PORTS_ALL macro
    https://git.kernel.org/netdev/net-next/c/7a03df01457b
  - [net-next,v2,04/15] net: sparx5: add *sparx5 argument to a few functions
    https://git.kernel.org/netdev/net-next/c/f68f71f33f62
  - [net-next,v2,05/15] net: sparx5: add constants to match data
    https://git.kernel.org/netdev/net-next/c/d5a1eb484594
  - [net-next,v2,06/15] net: sparx5: use SPX5_CONST for constants which already have a symbol
    https://git.kernel.org/netdev/net-next/c/3f9e46347a46
  - [net-next,v2,07/15] net: sparx5: use SPX5_CONST for constants which do not have a symbol
    https://git.kernel.org/netdev/net-next/c/559fb423d5f2
  - [net-next,v2,08/15] net: sparx5: add ops to match data
    https://git.kernel.org/netdev/net-next/c/048c96907ca1
  - [net-next,v2,09/15] net: sparx5: ops out chip port to device index/bit functions
    https://git.kernel.org/netdev/net-next/c/20f8bc8755a7
  - [net-next,v2,10/15] net: sparx5: ops out functions for getting certain array values
    https://git.kernel.org/netdev/net-next/c/beb36b507170
  - [net-next,v2,11/15] net: sparx5: ops out function for setting the port mux
    https://git.kernel.org/netdev/net-next/c/b7e09ddb673f
  - [net-next,v2,12/15] net: sparx5: ops out PTP IRQ handler
    https://git.kernel.org/netdev/net-next/c/8c274d69093f
  - [net-next,v2,13/15] net: sparx5: ops out function for DSM calendar calculation
    https://git.kernel.org/netdev/net-next/c/a0dd8906824b
  - [net-next,v2,14/15] net: sparx5: add is_sparx5 macro and use it throughout
    https://git.kernel.org/netdev/net-next/c/4b67bcb9094e
  - [net-next,v2,15/15] net: sparx5: redefine internal ports and PGID's as offsets
    https://git.kernel.org/netdev/net-next/c/8cc4102363c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



