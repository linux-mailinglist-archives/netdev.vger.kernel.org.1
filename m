Return-Path: <netdev+bounces-35190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E517A77BF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7091C20AB7
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4A154B7;
	Wed, 20 Sep 2023 09:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EACC8E2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFF96C433C8;
	Wed, 20 Sep 2023 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695202826;
	bh=vAfq2Kjos4AL2tqYc1Pqjb1PW2feaZFHafhkuYx3jyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j3JcGU7pSa6QPeS4z4JGf/CChHqZpr+l7PRD1hqPHu7H+cO6k1MqfKEfXdyTfbsa+
	 vdfqHKPMLbzxGuliQ9ItAVztu6nbOn07ubOTILvEeNLc1OYsSicsZpZtve2a7sg4vw
	 4fFHOY4hUD+icCYMQtL2jFXQvABBIKwhBC7X+3ulOWqdW99/aFaegWe6247xPTmvyg
	 0IjZyXd9reZro/KNfOnt2DWvaxjEQNfHpHtVEAF0KEbo8jBS6beH/k3EIwH/zmEy57
	 qXCRPmqu/RCNC/2U6AJVtLiQ6MFux5q7D3eApt8PhaF6R5k9w6gZReoNFd7XSk7fom
	 IJ+nGjGE+wpHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A427CC561EE;
	Wed, 20 Sep 2023 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11][pull request] Intel Wired LAN Driver
 Updates 2023-09-18 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520282666.15537.8525913267479543878.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 09:40:26 +0000
References: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 18 Sep 2023 14:28:03 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Sergey prepends ICE_ to PTP timer commands to clearly convey namespace
> of commands.
> 
> Karol adds retrying to acquire hardware semaphore for cross-timestamping
> and avoids writing to timestamp registers on E822 devices. He also
> renames some defines to be more clear and align with the data sheet.
> Additionally, a range check is moved in order to reduce duplicated code.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] ice: prefix clock timer command enumeration values with ICE_PTP
    https://git.kernel.org/netdev/net-next/c/40326b2b4296
  - [net-next,v2,02/11] ice: retry acquiring hardware semaphore during cross-timestamp request
    https://git.kernel.org/netdev/net-next/c/097c317afe0a
  - [net-next,v2,03/11] ice: Support cross-timestamping for E823 devices
    https://git.kernel.org/netdev/net-next/c/88c360e49f51
  - [net-next,v2,04/11] ice: introduce hw->phy_model for handling PTP PHY differences
    https://git.kernel.org/netdev/net-next/c/be16574609f1
  - [net-next,v2,05/11] ice: PTP: Clean up timestamp registers correctly
    https://git.kernel.org/netdev/net-next/c/be65a1a33bde
  - [net-next,v2,06/11] ice: PTP: Rename macros used for PHY/QUAD port definitions
    https://git.kernel.org/netdev/net-next/c/64fd7de2469d
  - [net-next,v2,07/11] ice: PTP: move quad value check inside ice_fill_phy_msg_e822
    https://git.kernel.org/netdev/net-next/c/dd84744cf5ea
  - [net-next,v2,08/11] ice: remove ICE_F_PTP_EXTTS feature flag
    https://git.kernel.org/netdev/net-next/c/12a5a28b565b
  - [net-next,v2,09/11] ice: fix pin assignment for E810-T without SMA control
    https://git.kernel.org/netdev/net-next/c/5a7cee1cb4b9
  - [net-next,v2,10/11] ice: introduce ice_pf_src_tmr_owned
    https://git.kernel.org/netdev/net-next/c/42d40bb21e33
  - [net-next,v2,11/11] ice: check netlist before enabling ICE_F_GNSS
    https://git.kernel.org/netdev/net-next/c/89776a6a702e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



