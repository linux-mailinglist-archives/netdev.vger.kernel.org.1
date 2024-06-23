Return-Path: <netdev+bounces-105929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B6913A42
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041151F2197E
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00171180A88;
	Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh9z/1Ul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135155C1A;
	Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144030; cv=none; b=ZKQc8iCAkW+2qOVdAAGdKc4zkUoTZiBwqVzXR4zQXSF7Gy0F/46DCi4D8BuKpjscLS+/MdRtH8LeEdLPDi05WAKgo+tpbxf0UWTOG5OE6qN5bFcUERgw8sqHBbbL6C1mqI35wys1VEc3qRrvTvnTsaQo8Zv74USUy0Ve8C5jkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144030; c=relaxed/simple;
	bh=mAN44LwTX3XKIAEy4qNZFAmyTgjXBNzHHu7xGgTUnqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qB5vRGXkUjRknRdhyifxpVJXpgEC2q9Fvg5V9FfpljmlU7MFal0dzJO/OqugR5+1nGRSpKDkD99x7ZQFCdkSVrIAYuFbWAkUpSFVASApdBg++W8pvhAP6mDxD37WF1aMcG98LihjNT2gMrr/NP4uza2RaWEmGGDcU0AwNEhDtYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh9z/1Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 533B4C32782;
	Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719144030;
	bh=mAN44LwTX3XKIAEy4qNZFAmyTgjXBNzHHu7xGgTUnqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nh9z/1UlpjX8JpDF34aLyT2iVr8v8V4BlO7GwBSzwCJa6017lGcMS/fi1GhgJlrts
	 P4YzUxGBARbwYPYyR/O+vIm4CiGAD6Ya4rbPgChAZ0CJodUqYqcFYnyJ243tP1rs8n
	 uqPhCXt+BXHUbeY9l9aqF5mFpSPXbavokzhv/8GKWcGx7SD6mwiQaVL6F3mdfLa0WI
	 WyHw+uL+TH82dXwt/9VCsVYWFnygwCjZqIIst1HjhZwaujLvMfG4oBzKw6FySNeXRP
	 7uYYwVlTeQ9IbTGSX4BjYENQRXR/10NZOv3vdxDNQ6pJc/JrH+W1eMWXUsXqquxVvg
	 jsaeAl1mBGkQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AADBC54BB3;
	Sun, 23 Jun 2024 12:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] dt-bindings: net: fman: remove ptp-timer from required
 list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171914403023.11613.628899711265897409.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 12:00:30 +0000
References: <20240621170000.2289596-1-Frank.Li@nxp.com>
In-Reply-To: <20240621170000.2289596-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, madalin.bucur@nxp.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 21 Jun 2024 13:00:00 -0400 you wrote:
> IEEE1588(ptp) is optional feature for network. Remove it from required
> list to fix below CHECK_DTBS warning.
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: ethernet@f0000: 'ptp-timer' is a required property
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [1/1] dt-bindings: net: fman: remove ptp-timer from required list
    https://git.kernel.org/netdev/net/c/8a67cbd47bf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



