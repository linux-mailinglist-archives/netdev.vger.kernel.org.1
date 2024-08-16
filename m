Return-Path: <netdev+bounces-119329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D095528B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDB0B21047
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EA1C232B;
	Fri, 16 Aug 2024 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyfmcazu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5604315D;
	Fri, 16 Aug 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844430; cv=none; b=iURNCYAimttKuLaOcSqOVckhM992JHolCandlF11CFR3yLmdVVNyfdJ0+6RtDwte5R6r1VkZkZJ26TgJ2uekeTYCmGfBAvMrBTzMNAXnuv5iCo1NNng3eZX8/7hyUt/l+A6MBBXGvsGr4zNciBte69SDH60HXVzGp6R5om1g0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844430; c=relaxed/simple;
	bh=KcdL87Sd/gwJZhYTh8zytqu9oGO7wtXrAA9NEcOCMmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Grtp43Y+ln9JXqnm/8CJuZRDELPL4yPMw7cVdzmIZQheN+qFKY346NXIVKXRnmcUNDODzGrW+iuMRE9RsNZtKhk0ttPC3E4JHXQIAzVSGdBLGn0IOK+VheW2nM9E9cafqeImOqK6mUDK0VyEvmnsp+G1ptwwc8InKKWnZgisEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyfmcazu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBEEC32782;
	Fri, 16 Aug 2024 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723844429;
	bh=KcdL87Sd/gwJZhYTh8zytqu9oGO7wtXrAA9NEcOCMmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PyfmcazuoW7isy8W1nW4VvPomHpgiP+9yIV8j2JWKbIWlJ+XzDC8MzuR464mGadE8
	 wlPJbrsVGOwtMscOmF7e8Lo+oH4556gL4W+pgG0Nwj3y89BcW/utmIeJg2mmOksUcF
	 q4BZ3a5Edl0M9lyuLDjLP4mF1kIo2xa5yODmmdnmWnC0Dmyq9lvllSalijn1qajiPx
	 w154L47G+RxfPlG7dkLAmP5f4O6YpUHgkQuwb0Ftw3soB1LIo81UMb3YYpet6xK+OX
	 /195R9DwUkj0kKgYux+gIfDX9sbvLzM3OzjqRPjpTP4Jnv/8PZ5NuoPhEuN/42cX8S
	 Igad4Ke7KGQkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9F38231F8;
	Fri, 16 Aug 2024 21:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/1] dt-bindings: net: mdio: change nodename match pattern
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172384442877.3634446.4340859401415164094.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 21:40:28 +0000
References: <20240815163408.4184705-1-Frank.Li@nxp.com>
In-Reply-To: <20240815163408.4184705-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 12:34:07 -0400 you wrote:
> Change mdio.yaml nodename match pattern to
> 	'^mdio(-(bus|external))?(@.+|-([0-9]+))$'
> 
> Fix mdio.yaml wrong parser mdio controller's address instead phy's address
> when mdio-mux exista.
> 
> For example:
> mdio-mux-emi1@54 {
> 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> 
> [...]

Here is the summary with links:
  - [v4,1/1] dt-bindings: net: mdio: change nodename match pattern
    https://git.kernel.org/netdev/net-next/c/02404bdb811d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



