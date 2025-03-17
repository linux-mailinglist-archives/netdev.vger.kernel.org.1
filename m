Return-Path: <netdev+bounces-175446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A448A65F4C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B318189ED54
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A01F3BAC;
	Mon, 17 Mar 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9YFjfiu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF3146588;
	Mon, 17 Mar 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244001; cv=none; b=uK0RIYDW3xJ0tnALfM/g05077XGFFBABIjs30pxUU7SlRUlS4YhSFrGPoEPddzhYejbRh4ADL0zs+4xjX2uWfbXpbD0CtDc1ZEeEyzrY3i4XTx/3dXUIONSaxUvdxlghwjW6ynWySsCJ2wgujXAw1OXaG6gYo8xcwdW01RvKdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244001; c=relaxed/simple;
	bh=6zE4h3dSYoJiBk6zDiq7fsC7lJDhKuGhyzEFC7rx7XU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N3g6IFwWZbuwuxqfAK9F7LmYdNhS63FZSRejof65SCssA0NQN9G/fpFY5PkIuklmE7IvDCSyQw161lBBtl/mP8mICqAoPnBZxR56OgyB+irlG2V90xN6qOZzoh7/mb6ZoP9IIzphP60owufdEsdeyd3PvlXlpdR+7igaDo81rkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9YFjfiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABEDC4CEE3;
	Mon, 17 Mar 2025 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244000;
	bh=6zE4h3dSYoJiBk6zDiq7fsC7lJDhKuGhyzEFC7rx7XU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n9YFjfiu8M6kURBh1g5UUuBuaAPNpjz4uxJgNoaZMwqxQEIO5MLPPN4HsIqbTfEkY
	 utjs8tQeGB1HOhbPEe0sqdee+OPWpikIbKtRNdv1aMbhOP7RP9MO/S0BaCluXP/iXs
	 PCD3YbNP/qEQKcvEaibE2EcVN4NzSNXVQneFPUAmilyY22g0lPkx5fVrlmgURao+uW
	 /JKzeDZBRBAJz4fwdI/d1EWojeKbM+JDHN87HXPz8dzV04UlpmWbATU+ZXghE9cHSo
	 4sbreHOti6hTqPv8grSgBycxTKGsGCkNlovT2MhgTwBvN+GyC5m6OrD2NMD66wfFpB
	 eTMP8gaAtl7Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7143B380DBE4;
	Mon, 17 Mar 2025 20:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224403628.3906420.5710471338716429698.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:40:36 +0000
References: <484336aad52d14ccf061b535bc19ef6396ef5120.1741601523.git.p.hahn@avm.de>
In-Reply-To: <484336aad52d14ccf061b535bc19ef6396ef5120.1741601523.git.p.hahn@avm.de>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 leon@is.currently.online, kuba@kernel.org, oliver@neukum.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Mar 2025 11:17:35 +0100 you wrote:
> Lenovo ThinkPad Hybrid USB-C with USB-A Dock (17ef:a359) is affected by
> the same problem as the Lenovo Powered USB-C Travel Hub (17ef:721e):
> Both are based on the Realtek RTL8153B chip used to use the cdc_ether
> driver. However, using this driver, with the system suspended the device
> constantly sends pause-frames as soon as the receive buffer fills up.
> This causes issues with other devices, where some Ethernet switches stop
> forwarding packets altogether.
> 
> [...]

Here is the summary with links:
  - cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk
    https://git.kernel.org/netdev/net-next/c/a07f23ad9baf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



