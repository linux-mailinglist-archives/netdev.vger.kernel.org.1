Return-Path: <netdev+bounces-115442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51870946627
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C486283256
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB7960B8A;
	Fri,  2 Aug 2024 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjMdVF9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C31ABEA4
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641443; cv=none; b=f2UF2LV3aVaVD3wvGoec9r28p7KCdz4Tk+CqgQYNFWpAHH/BZVOw3MR4WUy/89cN+kiI2JjYrBlGy/JMx2Ze+ZcxGwaeSlYcvU2CYwEijRb4SEaPJwPzF8YiaXnl9UfNm4Od866a8v1Ak/HXMNbqVHXpBoBwM5/iarmpLRIDYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641443; c=relaxed/simple;
	bh=gYuH4e0FMWmA4CYeBzWP9EdL3aAWDAJr5ahO1M/djTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cET2cOaXNZ/4ONeFRe51FlSkhxtgN0SV2sotPlka8WrcrIpG4477YYoXCx6PbrOZEKHSvIB3fmPTXibRb1gPVpH3dQpKAlfmKqthLOgNNIgnDol43Arj1xEaRqC0covczx5X2z7fpo+c+zw+ACIZw3jnLOUD76dI7QxCZ8xe1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjMdVF9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A97FC4AF09;
	Fri,  2 Aug 2024 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722641442;
	bh=gYuH4e0FMWmA4CYeBzWP9EdL3aAWDAJr5ahO1M/djTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QjMdVF9OpBdi81SnA2Y7NWCDPGvoqWv96Txlog7uKR1XbeOuIkhhiRvWHdXPl19ru
	 o4uPK4n0jHEtIt72RRCDU74I2o+w+v/NVY6IK4Vt7/4ujRdRluZmbYslsphLlxJ6GZ
	 HxCrQvBkPYcR+HFMGJBgjWeWK6EA/drf+dpmsL08p+ofu3ROYesPVPrIqqKXMJ21jq
	 ajopOuOguj1xkSWymvR/CHD2KqpzYbGd+ZBYGmIFbBHWyiZCO8Wl2s5OT8wWc2w8Ho
	 oy00hd91lFJb2dHpZEMhciLXqcQmsN9ntl4C9BynK9X+h/phHre/P0rJ8R53gI3Jce
	 gs0OmctLBwQLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AB86D0C60A;
	Fri,  2 Aug 2024 23:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: update status of sky2 and skge drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264144256.25502.4511619597742860481.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:30:42 +0000
References: <20240801162930.212299-1-stephen@networkplumber.org>
In-Reply-To: <20240801162930.212299-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, mlindner@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 09:28:42 -0700 you wrote:
> The old SysKonnect NIc's are not used or actively maintained anymore.
> My sky2 NIC's are all in box in back corner of attic.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: update status of sky2 and skge drivers
    https://git.kernel.org/netdev/net/c/eeef5f183f1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



