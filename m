Return-Path: <netdev+bounces-82342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B507488D55A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 05:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25118B21EE4
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 04:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67EC249FA;
	Wed, 27 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjLW1/AY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07C241EC
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512575; cv=none; b=F872KCld357DkxTd4tGjyKw2gNuRWZi/bBCEWEa04dqMNfYDOONAaa4oVvyj1DddeAN3k+T7osJhjL4FNHvytEmNoG/AHx1gx8ZUbTCWXIlT1ZhRsDWFoy+t3UG4FL91zY1C85PDEUHE1itx1lL1uw850D1CMfDKWMTdfgm4Q8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512575; c=relaxed/simple;
	bh=xr7ZedN21d+IrgNuQIJbeY8FbsfyIp9LcnmMozCPHoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hSt3O1v4Cqm2qlZWp4HIIMgHryQATzI5oVqavWFCQwE9HkY8800mJKGo8GDRZvZflGsOt715EFI05h1XGrwOd/Ao5nm46FcWULtM+2jeCTr7uuePc5Gbd/6ggYVXLTPTBUuU/XgsROVYCZ/PBaXMj1T8w/et7kX0Ey3/wtUqVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjLW1/AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53370C433F1;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711512575;
	bh=xr7ZedN21d+IrgNuQIJbeY8FbsfyIp9LcnmMozCPHoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NjLW1/AYdlbF+yLVjG1FYsG3ERyAiwk0DwMjh8UAsykdOwz4xoOy47WMigxJAYKTJ
	 t2ig/wZxRcGjjCFbpDMGi1Fp/5UXPifJBaLwgWkZTNpibNhgewrJa2J1XZu/Blg1pU
	 zJPQsANgPRsZg4Vu3S+TaktV895FOlKMHyvZzlCA4D2sy9BgPFfgnyoa4o1sHQjWgY
	 2A9d9bPFToQTMOKdsxs5J6ZSTphh3abLW8jxgNlXJdGcSx4uie3J5bFxlVagJhVI5h
	 +q1jD1npT8fG7uvXHslZL5rNiSK8YoMx7868W5X7riLgXig7Dl6S3USBV5Mfe6sN6t
	 HqGhwOZDBR3AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45BE5D2D0EC;
	Wed, 27 Mar 2024 04:09:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2024-03-25 (ice, ixgbe, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171151257428.29046.8286657405383973543.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 04:09:34 +0000
References: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 25 Mar 2024 13:06:44 -0700 you wrote:
> This series contains updates to ice, ixgbe, and igc drivers.
> 
> Steven fixes incorrect casting of bitmap type for ice driver.
> 
> Jesse fixes memory corruption issue with suspend flow on ice.
> 
> Przemek adds GFP_ATOMIC flag to avoid sleeping in IRQ context for ixgbe.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: Refactor FW data type and fix bitmap casting issue
    https://git.kernel.org/netdev/net/c/817b18965b58
  - [net,2/4] ice: fix memory corruption bug with suspend and rebuild
    https://git.kernel.org/netdev/net/c/1cb7fdb1dfde
  - [net,3/4] ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()
    https://git.kernel.org/netdev/net/c/aec806fb4afb
  - [net,4/4] igc: Remove stale comment about Tx timestamping
    https://git.kernel.org/netdev/net/c/47ce2956c7a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



