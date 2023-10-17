Return-Path: <netdev+bounces-41879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C67CC155
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66F1281D0D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89241771;
	Tue, 17 Oct 2023 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3dl12SZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90041236;
	Tue, 17 Oct 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43575C433CA;
	Tue, 17 Oct 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697540424;
	bh=+ylqmAC9HYbVfV5ircd/gmKrlKKR9WueEkigtzn6t+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F3dl12SZiD3NMsA2CPJPYiMt5SpeEa/lPUH/v2kyJlGUgenNzx1vMJeJd141RF4kD
	 3PmeRve8Aar/sdlRGakAq3Ovu9JuXRtLjP/bp2Irc1W6DP7lZha+7jRDjc37+PduTP
	 szf6k2SbcU9TgV+pS/H7/BLU3ycFdDi5/kGp1vWs8uff0aONLr2N0SiZZzI7bjAttV
	 HO5lIC8qdCnrzLHPkJpMOYnb1pG/f3NwE3rR7i+cwl6PUgBPErNGodIMmVObuXjVpd
	 sUf5UAwPanNYFqd0Ti/jPKWExeBOrD8cvGNXFtEcy7xGvKKDxAsq+FJ7bjHkXTcBsR
	 MBHjDROpidkdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D757C04E24;
	Tue, 17 Oct 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] I3C MCTP net driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169754042417.23145.5070726957751164458.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 11:00:24 +0000
References: <20231013040628.354323-1-matt@codeconstruct.com.au>
In-Reply-To: <20231013040628.354323-1-matt@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, jk@codeconstruct.com.au,
 alexandre.belloni@bootlin.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Oct 2023 12:06:22 +0800 you wrote:
> This series adds an I3C transport for the kernel's MCTP network
> protocol. MCTP is a communication protocol between system components
> (BMCs, drives, NICs etc), with higher level protocols such as NVMe-MI or
> PLDM built on top of it (in userspace). It runs over various transports
> such as I2C, PCIe, or I3C.
> 
> The mctp-i3c driver follows a similar approach to the kernel's existing
> mctp-i2c driver, creating a "mctpi3cX" network interface for each
> numbered I3C bus. Busses opt in to support by adding a "mctp-controller"
> property to the devicetree:
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] dt-bindings: i3c: Add mctp-controller property
    https://git.kernel.org/netdev/net-next/c/ee71d6d5f18b
  - [net-next,v6,2/3] i3c: Add support for bus enumeration & notification
    https://git.kernel.org/netdev/net-next/c/0ac6486e5cbd
  - [net-next,v6,3/3] mctp i3c: MCTP I3C driver
    https://git.kernel.org/netdev/net-next/c/c8755b29b58e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



