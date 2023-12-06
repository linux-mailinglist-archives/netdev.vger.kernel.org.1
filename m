Return-Path: <netdev+bounces-54267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340E5806619
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2C0B2127B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEEAFBF1;
	Wed,  6 Dec 2023 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsawhQ4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA83FBE7
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C219DC433C9;
	Wed,  6 Dec 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701836424;
	bh=AxK5xqBDUT44KxIo/AG3pwfrXhHcBsRIjRWsKWf6zLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsawhQ4o83eaP2eHa78PPWEkglBLLD558Y9YLJijNWP8tWMRWPd5/ern8BD50//sI
	 IsJu/Q5bYYJLlUwztBJ1txuU/sA30Wz2Wqt74ej2cieiDBtdtUX3ya9Rxg/R4sXwGL
	 990cKJrB6n5/B7yLe+q8uxME7puL39vfntoOGWmhikiBARAqVmke5zQ1XBaqhR63AK
	 NcgOazKTYheqsNJhdoeuEG2uOmCq/3AYySaocXDQp/VARtPGNM6xwUz+IP7J0m/Qnf
	 p3p2m3EPrDqj5QTX1eKs89UNpkebHbbKXMhbu2GqvRyU9Sh+vKJ79PV6Hm8EifiXzs
	 4nPBs4EfdJjXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA661C395F1;
	Wed,  6 Dec 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: mvmdio: Performance related improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183642469.10645.13461359609300512156.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 04:20:24 +0000
References: <20231204100811.2708884-1-tobias@waldekranz.com>
In-Reply-To: <20231204100811.2708884-1-tobias@waldekranz.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 11:08:08 +0100 you wrote:
> Observations of the XMDIO bus on a CN9130-based system during a
> firmware download showed a very low bus utilization, which stemmed
> from the 150us (10x the average access time) sleep which would take
> place when the first poll did not succeed.
> 
> With this series in place, bus throughput increases by about 10x,
> multiplied by whatever gain you are able to extract from running the
> MDC at a higher frequency (hardware dependent).
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] arm64: dts: marvell: cp11x: Provide clock names for MDIO controllers
    (no matching commit)
  - [v2,net-next,2/3] net: mvmdio: Avoid excessive sleeps in polled mode
    https://git.kernel.org/netdev/net-next/c/7dd12fe34686
  - [v2,net-next,3/3] net: mvmdio: Support setting the MDC frequency on XSMI controllers
    https://git.kernel.org/netdev/net-next/c/eb6a6605ff5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



