Return-Path: <netdev+bounces-137392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA399A5FD5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031311F218FD
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D31E1027;
	Mon, 21 Oct 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUlgG2kK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C395198E6F;
	Mon, 21 Oct 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502423; cv=none; b=GZtPhRn/68ihMdm0hqLxRNbVDLUFkTmm1J/wlUABdyxF7yzIwvt1NIDpIfZyzEgYiC3xALABdPw/r5bVv1JceT7E3//d1ghwMR5MiZ+Tv2z86+xKvotFpaSekENfqDvQ+5mcdgUHOkgVLaaR9v3L5V/OGJ7ACZtJp/cX4+YS5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502423; c=relaxed/simple;
	bh=seaquORoS5AkXRzcY9g8QWa1F9h31Z6RPMQ3WgHrMiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ns+v9zPt07XhV3oI7ry0faEYjUGrn+u3u851Iz0bbZ7Zcpl+lnE/NGFecad/t+0cn+d4SR//U3Lf8+tz0jvDMzFzEc9M3SoOfyhU1mvxF2JuoOpcBlh0o6cCaSLonkaDvtuw7jEe0xonn3QJtmK1w/oz8Hdthx0+DKmbJcVHkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUlgG2kK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE5EC4CEC3;
	Mon, 21 Oct 2024 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729502423;
	bh=seaquORoS5AkXRzcY9g8QWa1F9h31Z6RPMQ3WgHrMiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TUlgG2kKSv+XmpQ9nNGpsgj4Jc0kb0Yzoal/B9zJ4v0eX4+sTghSx/Ty8XtgQkAEB
	 BTaoI+RL4NqZI7m8SPhLWThU+Oo0M0T2gC+ldh9w8/31nDbGIndLSiSfDUGBALS5kY
	 TrMJ5lSQRs9bbG+ygFMiL1xqq6Ww5XKR2NDhm8ly+6Me+L659GJ5Y9V/VdiudNyw7A
	 dhL8iSK/sfM8khnAQPkcznLsQggC0uNrxCRBPUBMCzuI4uEQ/zQN4D6zbO0mxblpD6
	 2U+sYKjmuoPrQIZcGemYK9RStY5J45ndvx75j9sTuRpcrWOugo7g+HsZFieThRUk93
	 DnXlnFteOxAIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFF3809A8A;
	Mon, 21 Oct 2024 09:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] fsl/fman: Fix refcount handling of fman-related
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172950242900.181020.3714375774039373979.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 09:20:29 +0000
References: <20241015060122.25709-1-amishin@t-argos.ru>
In-Reply-To: <20241015060122.25709-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: igal.liberman@freescale.com, horms@kernel.org, madalin.bucur@nxp.com,
 sean.anderson@seco.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 09:01:20 +0300 you wrote:
> The series is intended to fix refcount handling for fman-related "struct
> device" objects - the devices are not released upon driver removal or in
> the error paths during probe. This leads to device reference leaks.
> 
> The device pointers are now saved to struct mac_device and properly handled
> in the driver's probe and removal functions.
> 
> [...]

Here is the summary with links:
  - [net,1/2] fsl/fman: Save device references taken in mac_probe()
    https://git.kernel.org/netdev/net/c/efeddd552ec6
  - [net,2/2] fsl/fman: Fix refcount handling of fman-related devices
    https://git.kernel.org/netdev/net/c/1dec67e0d9fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



