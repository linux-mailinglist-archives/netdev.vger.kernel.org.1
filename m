Return-Path: <netdev+bounces-123569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B3965534
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D3B1C22637
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F061FCE;
	Fri, 30 Aug 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvBb/eDi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C794D8AD
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984425; cv=none; b=DA2Udjvdn+irW6/MkYYsxgplVkeRD/5maviKMdWo4WUzhvPVUpjnZGcu8SfxUPJ+eyG0bUo9q11CbVYtFrJjl53gmmi6DYgh64qt9UCa2mVEGwZ9/6QEfWlkcQV9C67HWJrFI3LCJXrj8l0Doe6iRlKO2J0XY2dnfaUsX9N5NSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984425; c=relaxed/simple;
	bh=/nqu1AnK6XIKAU1ghwX0OljVLxUevN1MgXMgPp7ta0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lZE4CUwppSfiJExAYWqqFhH5e2j1S+p21g1I5gbI/pXrOVeqxDAeT5oYFnJg5ymqyccwtS2JFNooxQKt99gSouNhVvfTUdxa+0BR9vPnSFRrXLq7AeLVLJjfeHGpW6BHnTbiAfyjiLCGHkV8rksDIdedq+pP7tYczjnCflNqw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvBb/eDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDDDC4CEC5;
	Fri, 30 Aug 2024 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724984425;
	bh=/nqu1AnK6XIKAU1ghwX0OljVLxUevN1MgXMgPp7ta0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GvBb/eDiMLrev/KBWPtYMf9EWbCBBHQorrvkJjYPHewZkVGO8FbCHeXzcS43H1GeH
	 DO8pvNW6NSeNQqLJo7VqoVeMLVvmsiMBexuHGf+1xrFU7JGO1XvclQ/Tv5qUWKICzT
	 E4+7TdM29Vd0ndYmagXHFCemMqawuyAXLPCVx6fs6sCUM+dzJHI8cad44RdT7fnSdI
	 p1I064qbQAezhkbu/AW5MHSRAr0q2J1Pt812zrRS6p557tX9Bzy3tjRxiS+oQcMaXX
	 /7mN6itMI1MP9ucDslYV7/6Tx22tsVULcki9SIWcda7Zr6kwmbz6RLxNEWVv2gOu5X
	 gBaxDfNeXUxAw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85CD63822D6A;
	Fri, 30 Aug 2024 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2024-08-28 (igb, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172498442654.2145060.17904868299157014678.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 02:20:26 +0000
References: <20240828225444.645154-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240828225444.645154-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 28 Aug 2024 15:54:40 -0700 you wrote:
> This series contains updates to igb and ice drivers.
> 
> Daiwei Li restores writing the TSICR (TimeSync Interrupt Cause)
> register on 82850 devices to workaround a hardware issue for igb.
> 
> Dawid detaches netdev device for reset to avoid ethtool accesses during
> reset causing NULL pointer dereferences on ice.
> 
> [...]

Here is the summary with links:
  - [net,1/2] igb: Fix not clearing TimeSync interrupts for 82580
    https://git.kernel.org/netdev/net/c/ba8cf80724db
  - [net,2/2] ice: Add netif_device_attach/detach into PF reset flow
    https://git.kernel.org/netdev/net/c/d11a67634227

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



