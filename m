Return-Path: <netdev+bounces-85791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30E89C2DB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE842810B7
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C37128370;
	Mon,  8 Apr 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJL5ITCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645E128366
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583027; cv=none; b=UeOqV63HD4uoGaHj4Za23uoTpLtTS/aMSq99M7xeOMwZ2MjfOkDxcRlxo4ubStKKGalAIO+8oaebv3g+Z0tjbtScaqx9o3amMadNLD2isMwK+ij7yOuwtZJzf2bvuExAwte4GPhDdC4KigsDFf5QiqqUkIIgh3HTFNQ2X4PyfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583027; c=relaxed/simple;
	bh=xJBwVgikP1XUaMWt9dmwTggazzWT2VXiKgssWxijGLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svbs1y3DL68XoJHJgcI9YuJpO3DrX/3gLHJoinwRLDYFrSKNl7wzEETqW14ESijHd3mC82isplDLRgcCgrfNDER9N8Y9Sfs4anbJTFpnyqRrTHgwtkZFL9IcoxCHSv9BWWd9mmp+aQAnMLU9B6g2Jw1RJ0sjvyyz8Gv4g8cSi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJL5ITCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 027A0C43609;
	Mon,  8 Apr 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712583027;
	bh=xJBwVgikP1XUaMWt9dmwTggazzWT2VXiKgssWxijGLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YJL5ITCxpOfHsLU1huujBDWrbp2Z4Qng8GnwaSKMpjkYfH3sphLfHD61vivZlr3pV
	 nGSal/0FfM1O6G8UjX3dN1lHnlSSqxNfoJS0aVrb1MVISFytCmJQTf7js0lrpQnIc1
	 jCgddZXluvisfhJBP0BAePgS31jEqLOxnP/Uuq+bYvosk5q+2CxURn7JRKyL2fobzO
	 9XGYGCyFBtdFEFs/kagT+X/s8G3jRTZim9MKYs6O87AlmXGoqKieHoJHXndT7jgFH/
	 1d81udx0CKf/BeNPys7A1y9pMGYd6Hjms4A2f2bojceNPn8FP87WAk92Kkl3oT9eCr
	 XN7JpeO/h/e4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E93D6D72A01;
	Mon,  8 Apr 2024 13:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add support for RTL8168M
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171258302695.21343.3708141520167683167.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 13:30:26 +0000
References: <0f0d8911-4b36-480e-b0d7-636f72c7beec@gmail.com>
In-Reply-To: <0f0d8911-4b36-480e-b0d7-636f72c7beec@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, nic_swsd@realtek.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 7 Apr 2024 23:19:25 +0200 you wrote:
> A user reported an unknown chip version. According to the r8168 vendor
> driver it's called RTL8168M, but handling is identical to RTL8168H.
> So let's simply treat it as RTL8168H.
> 
> Tested-by: Евгений <octobergun@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: add support for RTL8168M
    https://git.kernel.org/netdev/net-next/c/39f59c72ad3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



