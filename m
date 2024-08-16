Return-Path: <netdev+bounces-119340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54D9553BF
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3021B2232C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5F146D45;
	Fri, 16 Aug 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDcXnPl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCE12F38B;
	Fri, 16 Aug 2024 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850447; cv=none; b=f8mF8rVTEtUzm87maokcV/JWhlDo6dHzgSpnKmOFtlx7ZVAiEbvCkztRmXOcLkxJEbXNegKzrrekzEASq1O9o+NoDJDP2Q6eVMO5C/uBThvSGsYjlzcaHXtpCXsD4fhoDwbJzl27P2odV74cWiPm8cwCNMLbewPBwOvt4QDJuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850447; c=relaxed/simple;
	bh=offtjPPV1MN9rXBR1DpCRt7+52oDpWp++saRALUngKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=okFs+fsUkga2GrjpnAWLx+PXNc8P9LxMXY/t6jYVMgTEbyd+A7iVodrh8RbbZwrYvNvVL6iXsvADrildr8QislXmZaJteQArWs+LKjiPlaSmGuZhyLO89kTCp0n58nawae4ky9IvMVK46OK0zudCCwS5/kJ4Ne7o0cGXKaVpJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDcXnPl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E6BC32782;
	Fri, 16 Aug 2024 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723850446;
	bh=offtjPPV1MN9rXBR1DpCRt7+52oDpWp++saRALUngKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uDcXnPl2SWiNEC9IYQImmvYNy1eU4q4pMyNQK62XtnbLU9Bi0ccL3s3YVzmnihTnE
	 6wzVT9VE2eLX4RNVrvpiDmhA6bDgef7Xzh7Y+wt5XAh3RLii/N9TsJUym7dav4Ff7P
	 PuZ0Dl7hsYX2es0P959bDptLfKRl7/Hc2YpcswvGW5+wtmBzIx8vmPDyLvqX2bH+zu
	 xx4VGY7EVTJ2Gvg/ViuBFmJMXb+nRaQmdzH4lNU8sB1XYvWEHZOfwqjUCl4rpkc0cG
	 Hj5swyE2vvYQxqQXLyKiD0lIVRgGrDnXk0LlbmmyLsx1gC4RbBlkwEaxmpMxCP02ke
	 xRCNEwbD27yDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC938231F8;
	Fri, 16 Aug 2024 23:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: lantiq_etop: remove unused variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172385044541.3653439.15852472460227607509.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 23:20:45 +0000
References: <20240815074956.155224-1-olek2@wp.pl>
In-Reply-To: <20240815074956.155224-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com, u.kleine-koenig@pengutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 09:49:56 +0200 you wrote:
> Remove a variable that has never been used.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/ethernet/lantiq_etop.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ethernet: lantiq_etop: remove unused variable
    https://git.kernel.org/netdev/net-next/c/1f803c95693f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



