Return-Path: <netdev+bounces-103685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D39090D4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096961C2129C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3141974EA;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjuNH7Qp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2CDDDF;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384435; cv=none; b=tPOXRCUcLxEnKRXyhmiUOtlK+N2ZEKE1uKNbF0uNgJzqc4anE+yLWUhNr7e50C6P3kOO1IFyURXHotqe2gKluhQzg6UAsyuBUa4wDT1utv7fQilxRu7WkzZHx4/0oQvK53b3PCLyCzhl5xQ0+hz0q1X/PpFTg1WlWMdOSDwj5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384435; c=relaxed/simple;
	bh=I1pahDc43KhXSDhbubXfPSzmxs7edlK0S8v9NiUrnNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dkYImxX9pcqMKgyTDCUZhbzbPKyht3LStyyVFycFmaQyJvRzEO4o3mbbjC46Qzn1vEZ2uXsZjqlzTmGUrFgk8TRu9DVA/ftuasK4mrDoVpeLlujo+q31FJxcb4KyEBKeVo25iWna+oUeHDkcHJq7gDQc7zoQPF6HsP90AOfsGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjuNH7Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26C7DC4AF1A;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718384435;
	bh=I1pahDc43KhXSDhbubXfPSzmxs7edlK0S8v9NiUrnNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZjuNH7QpiPpsQ4kezsHwZ006hvXZxFvKREnzdndYduzl3BsMR533JZ3wMtKoVRJYt
	 2dDczpofhZ3nZII1YFDogIZazt6Yj1hAKCXZNprCkefRqaJIUNXNe/V0SPPf4NDdB0
	 ubVZ3Km8QviVJ/iwf0HFGq+AJga6zbrazt+WrRpJknduIiqFI/Q0FJ12s8RKC5AFlv
	 qNyFh313lG6pu26z/qdSYCXeUGtjt/AqrOq6Z90d0s9hYmUijuYvrauP6F/1BIpL29
	 TDRkcR0NSbrxL1hdRXyAH/DhanN9ipgUaYyQaE85NLj2HOQg+CynvsPEANuM+2l6bI
	 IpnLCuczHJa4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03360C43616;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: btnxpuart: Update firmware names
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171838443500.31311.6625085900814188876.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 17:00:35 +0000
References: <20240614084941.6832-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240614084941.6832-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, amitkumar.karwar@nxp.com, rohit.fule@nxp.com,
 sherry.sun@nxp.com, ziniu.wang_1@nxp.com, haibo.chen@nxp.com,
 LnxRevLi@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Jun 2024 14:19:39 +0530 you wrote:
> This patch series updates the BT firmware file names in BTNXPUART
> driver, while maintaining backward compatibility by requesting old
> firmware file name if new firmware file not found.
> 
> A new optional firmware-name device tree property has been added to help
> override the firmware file names hardcoded in the driver.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] dt-bindings: net: bluetooth: nxp: Add firmware-name property
    https://git.kernel.org/bluetooth/bluetooth-next/c/3a8decfc6350
  - [v4,2/2] Bluetooth: btnxpuart: Update firmware names
    https://git.kernel.org/bluetooth/bluetooth-next/c/2c4d9d8e879b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



