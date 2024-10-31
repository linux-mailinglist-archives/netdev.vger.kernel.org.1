Return-Path: <netdev+bounces-140593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA19B71F5
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3278C285C02
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D4128369;
	Thu, 31 Oct 2024 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNU2Caeh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D3126BEF;
	Thu, 31 Oct 2024 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338244; cv=none; b=aYWLg/Zhx4NuVqD5hLlg6kjD7brEhGcjNW143h3ddR2SvCJAgUviPVTTN520xeitmJP6qtdFPHenyIeIv3ZO2nYOVKAYQjiTMyyyi9uzSUODjZNyQ+a24YiWQd/9BZTxu3rfL0M+BaCyfl8jgLLyah2M//027psrjap3eYd3j6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338244; c=relaxed/simple;
	bh=3AkpnkAU3IsEbaxp6htaiE1AJG2SN4xBnZhnxjmpP9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lysy0Z+3hi4ZGlZ6wspvmPizesbI2MFAjJ7hzvy2QYWkHxRHviwHfx1sdIE/91E7ceEnxcEUVT5EqNqhlISwWHsXXWMcVprwlHZn++W6aSfSK0AJrfpaYXOaDy1dmYX08jqlpN8XDpH6zHliN7xHhiZOLd+lTAefFxo+rshSyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNU2Caeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B39CC4CECE;
	Thu, 31 Oct 2024 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730338244;
	bh=3AkpnkAU3IsEbaxp6htaiE1AJG2SN4xBnZhnxjmpP9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNU2CaehVVEg+dPDVPghUoByiNpjPgY4MVhFlXIPtruAemCLLKzf9UeVDekXytMa0
	 SEJFYU7X/WCWN31WskhkRPGkFu2fHbGjIxjiFLVYW+mniu/iOoQR5qeBWodXiki9y5
	 iqM4XZ/Mnlo8otKGMjLi41ToXGlrfymo+H5eaDrwH0sRWpEM21SdUTPRrkkBM6ygzY
	 r5uF0wiPv/wGfN7d6iDny5sQdF8F7/mi5j92vfVU95VeUeiYNSIVzsGCfPOb1WWZp6
	 qmjDMM/2569KPibfsxzqs/33NUcyFboeJmDpgR3TRF/xDac3txPlqNAxfTlHwEzH6D
	 yuKxRGnUNKK8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34180380AC22;
	Thu, 31 Oct 2024 01:30:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15] net: sparx5: add support for lan969x
 switch device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033825198.1516656.6226177365029071964.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 01:30:51 +0000
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, horatiu.vultur@microchip.com,
 jensemil.schulzostergaard@microchip.com, Parthiban.Veerasooran@microchip.com,
 Raju.Lakkaraju@microchip.com, UNGLinuxDriver@microchip.com,
 richardcochran@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 steen.hegelund@microchip.com, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 00:01:19 +0200 you wrote:
> == Description:
> 
> This series is the second of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
> 
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] net: sparx5: add support for lan969x targets and core clock
    https://git.kernel.org/netdev/net-next/c/1ebaa5e18915
  - [net-next,v2,02/15] net: sparx5: change spx5_wr to spx5_rmw in cal update()
    https://git.kernel.org/netdev/net-next/c/9324881cef51
  - [net-next,v2,03/15] net: sparx5: change frequency calculation for SDLB's
    https://git.kernel.org/netdev/net-next/c/728267dc46d3
  - [net-next,v2,04/15] net: sparx5: add sparx5 context pointer to a few functions
    https://git.kernel.org/netdev/net-next/c/ead854c46359
  - [net-next,v2,05/15] net: sparx5: add registers required by lan969x
    https://git.kernel.org/netdev/net-next/c/199498490cac
  - [net-next,v2,06/15] net: lan969x: add match data for lan969x
    https://git.kernel.org/netdev/net-next/c/7280f01e79cc
  - [net-next,v2,07/15] net: lan969x: add register diffs to match data
    https://git.kernel.org/netdev/net-next/c/69b614251784
  - [net-next,v2,08/15] net: lan969x: add constants to match data
    https://git.kernel.org/netdev/net-next/c/c1edd1b23e90
  - [net-next,v2,09/15] net: lan969x: add lan969x ops to match data
    https://git.kernel.org/netdev/net-next/c/d8ab8c637049
  - [net-next,v2,10/15] net: lan969x: add PTP handler function
    https://git.kernel.org/netdev/net-next/c/24fe83541755
  - [net-next,v2,11/15] net: lan969x: add function for calculating the DSM calendar
    https://git.kernel.org/netdev/net-next/c/5d2ba3941016
  - [net-next,v2,12/15] net: sparx5: use is_sparx5() macro throughout
    https://git.kernel.org/netdev/net-next/c/b074c5e6c542
  - [net-next,v2,13/15] dt-bindings: net: add compatible strings for lan969x targets
    https://git.kernel.org/netdev/net-next/c/41c6439fdc2b
  - [net-next,v2,14/15] net: sparx5: add compatible string for lan969x
    https://git.kernel.org/netdev/net-next/c/98a01119608d
  - [net-next,v2,15/15] net: sparx5: add feature support
    https://git.kernel.org/netdev/net-next/c/207966787b71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



