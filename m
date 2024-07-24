Return-Path: <netdev+bounces-112776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9993B28C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DBB1F2145C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21F15746B;
	Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWGiuUjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230461CAA1
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830832; cv=none; b=HNAlRkgHdTXoPTsGCuiewssBH8yLIstatocvsE9+fdGuxjcCR/cULGMlF9UyndI64PiPBfpFC4Ib4UQalyU3PaWetRb2dv/bwb87AL9y1G/c1AlscYZU6rCbnw7RoHApVMBFNp2Tjn/Jeg3IsaMIFp5PtK8Ws1vb+1ofIoV0ptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830832; c=relaxed/simple;
	bh=VMBLQF9fpvcLF+NmKW6V0F/TyNADfnJD5sPplKLGk64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWVisH4MGXGo/Pdsv43ro+Bkt1FGRUgY8I/w76w9ogPtvfv5w/MeYlxDoELRW80WpFcbvKgmuPbCq0gg5peJgjkzfJq0OA2Uvh35x4XrV/kYynDj2fjbx7WOqjuwOZl+BIwn+hDbOBEWD1AO2y42o3Q9DcA7l/HnGaqBIypWzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWGiuUjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECA9EC4AF0F;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721830832;
	bh=VMBLQF9fpvcLF+NmKW6V0F/TyNADfnJD5sPplKLGk64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rWGiuUjj15fOXcVLi+BXcrxsDKiz6a8HRrSL8Eg9UgMX6z02N6KA3hHZiM+axNoVu
	 YMdDdsaWL/l7yN3H2xsk6MWs/54sPlxixPjPYGVDZeldKuByfVIYiFOkrVhuxKl/Xr
	 Z0jzSSaZD4dL0C9S54YzPXRgwIxVaxUNqs7ST9qgSZHyZhCLj/F5KZ/L8C4xr4X7Tl
	 QNIbBE309Q6/YtmutABo1SxKwgt8G3iEGzRihsk3yGHwH/Hn1AJHpADN3wQInt+iVI
	 45FwWwBoBm444DgDejOVAukCIvAicG1Rl+w6Tyyx7pURa7QzAXhLBmuussLSHNLTmZ
	 Z+I9EYXE6ig7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB0D3C43613;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: make Breno the netconsole maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172183083189.11114.15173570443484218502.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 14:20:31 +0000
References: <20240723223405.2198688-1-kuba@kernel.org>
In-Reply-To: <20240723223405.2198688-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, leitao@debian.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Jul 2024 15:34:05 -0700 you wrote:
> netconsole has no maintainer, and Breno has been working on
> improving it consistently for some time. So I think we found
> the maintainer :)
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: make Breno the netconsole maintainer
    https://git.kernel.org/netdev/net/c/7c938e438c56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



