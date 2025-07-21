Return-Path: <netdev+bounces-208722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B74FB0CE67
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FB66C171A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68863242D66;
	Mon, 21 Jul 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNccX721"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1323B60A
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141800; cv=none; b=jJ4Rv5U7U5eBWdnF2Ea0449mowzKwJeD8STDtSXRoimT1VpLl9VmDtn3Mh3kWrJzv4CxdBVcXDTVyVDXLCjuUe0v/NupQW47np105qUuqjqigC+H100y6jyL4nD/NgbUt2a9dTaSxsdw2vyBNv5R5FAKnO8wvmyE1uxdEUIOYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141800; c=relaxed/simple;
	bh=hcLHfHeVLYEBulcreLkJKlZClUjuWKibDGa/WT66NyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r3NJDGNmea8m+1IetLpP5b/FSRxTqH1J3pxdMcoQ6sZ7tFU6tdW+zeh1rMM4y4OqAFTas9Z8olzDEkehvDz++t2HKCxJ8zIFj4Z5EK7HyIXdaEc4Hh2mxPa1ukNGo0i124amP6iDRuV/QZvLfTMTMAFwROgwBh9Q3Af1OOL1FXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNccX721; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C05C4CEED;
	Mon, 21 Jul 2025 23:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753141799;
	bh=hcLHfHeVLYEBulcreLkJKlZClUjuWKibDGa/WT66NyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MNccX721lutnibpAmsfW9Md5S3yN7SXzhGueASxoppXyWe1KggXH5qk/B7e+puuZa
	 a0GtV5y50zr+o0S2H1BZCA1+y/ohE2d9r++22O9Wm0YuJX0YYuGcWBv3416hB9y3BN
	 Quv4+fBLzazhUYQzV7arZiz8JUroYh9xNChRpgtrnWGJ52HM4uZUaX2kZpc3fIHF6X
	 oZ/S/+/GwEFuoSBwgPQu96HrtDPe5tWKL7Mj9hrYMzgnwh6By4GDpeo8fk21pI9ZVH
	 EWlwB9wTB87rqWn2pibq3t0LyIxOWrSrVFOsfxwnR/YyTTYRb7cKD4lqAJX4X5fIuP
	 0EfI/DUvABTjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC88383B267;
	Mon, 21 Jul 2025 23:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] amd-xgbe: add hardware PTP timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314181831.233941.11056669545563636031.git-patchwork-notify@kernel.org>
Date: Mon, 21 Jul 2025 23:50:18 +0000
References: <20250718185628.4038779-1-Raju.Rangoju@amd.com>
In-Reply-To: <20250718185628.4038779-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, Shyam-sundar.S-k@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 19 Jul 2025 00:26:26 +0530 you wrote:
> Remove the hwptp abstraction and associated callbacks from the
> struct xgbe_hw_if {} and move them to separate file after cleanup.
> 
> Adds complete support for hardware-based PTP (IEEE 1588)
> timestamping to the AMD XGBE driver.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] and-xgbe: remove the abstraction for hwptp
    https://git.kernel.org/netdev/net-next/c/7564d3247aec
  - [net-next,v3,2/2] amd-xgbe: add hardware PTP timestamping support
    https://git.kernel.org/netdev/net-next/c/fbd47be098b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



