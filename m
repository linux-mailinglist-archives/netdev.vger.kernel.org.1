Return-Path: <netdev+bounces-99958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578528D72C5
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871A51C20AC6
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963147A48;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXEmrWYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD544366
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285232; cv=none; b=FJseabcy7lwksvIdikvcuFuE/vkjvG8whAVZ0XGfA86ILgUEfEVj7qE3Ne1e4T36tZcE0+FTDT5sNPuIxqqB4pD2LXAcL5gGPuzQ5jyrczLMyWaw3r/GDuOyOgDGb9pqXnlYuYaJ7TEyUTfvenwPtyEO992NNPnCP7SxawB58mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285232; c=relaxed/simple;
	bh=exeNFgNbIkZMF0ox1a1jHkYneqSudUmFfbtTOvhPWMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B7fi5E2risFCdkPqM+DcBD5nBDsS9atg2WGaPiUqM7OfVz3gD44FR1gIfe/baw+BRWwj1D7HRbJ6f5Sp1f8yXHyZrNDIoJgb+1WyomAYxuRoZ/CgvmCQlWAzAIDnOEoqYFCLTCqOoTSa2wResusBBMTeRMi8U3SgPolLl3MSqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXEmrWYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D873C32789;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717285232;
	bh=exeNFgNbIkZMF0ox1a1jHkYneqSudUmFfbtTOvhPWMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XXEmrWYLhuleilDRio8Iiws+FNZRttVMKX2i181EQrI+Icqgh9MlPaOW0p+H2ozv5
	 n9q2ThXoBA4k84KQL35ZK25WCvAix/HVxAiBuUOxLONSv6FCqalxQSHoxpYATOD2sq
	 yZaq7wkbHPxJG0pmerfkv8UYCQh+33F1WRG688CG5JsfZC2jhRTKlnSZQQlKw9VrM0
	 SVat3m+uLcVRMihnhr/s798XFS/t8zsdc35C1JzdIMiG4bIOKIF19zJv68qKRHbkCW
	 KnkSUQfVK/Ng8aBwKZEarfEoyDxSX167Zw36lkKYZczvuvrKTTOxlwnssP1ZsMh097
	 CYnDwl4auZeLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18082C4361B;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rps: fix error when CONFIG_RFS_ACCEL is off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728523209.22535.5422031228181558437.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:40:32 +0000
References: <20240530032717.57787-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240530032717.57787-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, kernelxing@tencent.com,
 jsperbeck@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 May 2024 11:27:17 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> John Sperbeck reported that if we turn off CONFIG_RFS_ACCEL, the 'head'
> is not defined, which will trigger compile error. So I move the 'head'
> out of the CONFIG_RFS_ACCEL scope.
> 
> Fixes: 84b6823cd96b ("net: rps: protect last_qtail with rps_input_queue_tail_save() helper")
> Reported-by: John Sperbeck <jsperbeck@google.com>
> Closes: https://lore.kernel.org/all/20240529203421.2432481-1-jsperbeck@google.com/
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> [...]

Here is the summary with links:
  - [net] net: rps: fix error when CONFIG_RFS_ACCEL is off
    https://git.kernel.org/netdev/net/c/8105378c0c02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



