Return-Path: <netdev+bounces-128371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79749793A4
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 00:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB2A2843EA
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6D13B7BE;
	Sat, 14 Sep 2024 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw6RZ0Ca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CA18E1F;
	Sat, 14 Sep 2024 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726352462; cv=none; b=mTEjYn5bsfMXWPx2PEmRQWlG63tXY3BKI4xc3/LCFFVl2DWPkIrb96eGHpRkMCGABXR3bKjRUNRd8u4/t1LR8dqK34MFaA4DolpId5jnLiM+bf2o8Dq61PuGPWFXOIMAPxdYp2McI+fgqJA9TUNh+SEJFxW8moWMycEyvjZkPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726352462; c=relaxed/simple;
	bh=p7CxOhjrl3nQfmL/O6fE3qasLAJlXnRtQFjSq6H0T2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hTLa9jatt9hlbxibt9UcPPIEPhf265k9G+R1LUBMetIllKd4x3Zw4rIhB5XsKvLn6IxWe2dK0HnOyvc+uBESs+pnbrJr9HjwhMQmK8We9XF+NRCn/6nxxzQA6XP4UKW5aj8hcgsQHHJC0Ct9qWQMFD0pmzw0harRp205Q+C97n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw6RZ0Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96E4C4CEC0;
	Sat, 14 Sep 2024 22:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726352460;
	bh=p7CxOhjrl3nQfmL/O6fE3qasLAJlXnRtQFjSq6H0T2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cw6RZ0Cao6q+CqdBdk1wJgx6S1QUZspmrbVGr0ZxkyvYmT3DwKzyXLp95OPR3UwqJ
	 uVM8j4FOP5mbxa+A8YwsxE8WZnSkWwt8MMT336umt7nCGSkUT6Ah5Sy4sOYAvoFFw6
	 BB9C8bt9ssXW7yIXLVlUFzJlkPX7VF31R5fgrLA1X72+0P68sX+5CyT4qC2b24ZvZs
	 Up6dSbJ9m930FSoolI4rHR0fNDa+LMcG4RiXnVRryCosV/2C9L8GrXTG27UGFFpXxd
	 sRJimSFnax6GrIyZwU8PhYQvfeLNWyKJ8FtUh4sLZUMEO7q1S3cIxmTuew7IomU1kv
	 jQz2Dkofoa9rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D5E3822D1B;
	Sat, 14 Sep 2024 22:21:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] Introduce HSR offload support for ICSSG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172635246230.2644819.1539639253246657986.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 22:21:02 +0000
References: <20240911081603.2521729-1-danishanwar@ti.com>
In-Reply-To: <20240911081603.2521729-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: robh@kernel.org, jan.kiszka@siemens.com, dan.carpenter@linaro.org,
 r-gunasekaran@ti.com, saikrishnag@marvell.com, andrew@lunn.ch,
 javier.carrasco.cruz@gmail.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, horms@kernel.org, richardcochran@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 13:45:58 +0530 you wrote:
> Hi All,
> This series introduces HSR offload support for ICSSG driver. To support HSR
> offload to hardware, ICSSG HSR firmware is used.
> 
> This series introduces,
> 1. HSR frame offload support for ICSSG driver.
> 2. HSR Tx Packet duplication offload
> 3. HSR Tx Tag and Rx Tag offload
> 4. Multicast filtering support in HSR offload mode.
> 5. Dependencies related to IEP.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] net: ti: icss-iep: Move icss_iep structure
    https://git.kernel.org/netdev/net-next/c/8f88c072c2ba
  - [net-next,v6,2/5] net: ti: icssg-prueth: Stop hardcoding def_inc
    https://git.kernel.org/netdev/net-next/c/4ebe0599fc36
  - [net-next,v6,3/5] net: ti: icssg-prueth: Add support for HSR frame forward offload
    https://git.kernel.org/netdev/net-next/c/95540ad6747c
  - [net-next,v6,4/5] net: ti: icssg-prueth: Enable HSR Tx duplication, Tx Tag and Rx Tag offload
    https://git.kernel.org/netdev/net-next/c/56375086d093
  - [net-next,v6,5/5] net: ti: icssg-prueth: Add multicast filtering support in HSR mode
    https://git.kernel.org/netdev/net-next/c/1d6ae9652780

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



