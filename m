Return-Path: <netdev+bounces-18204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E310755C77
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B8628115E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F7848E;
	Mon, 17 Jul 2023 07:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3F8BF1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 630E6C43391;
	Mon, 17 Jul 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689577823;
	bh=kvQ4q466Bpj6b6ubZR8+sRx3jIO1KBUpvlufwnQcgfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VqNtVmevieTksEJLCI1ucCRZ5wR5oQ7LZObSp49ZaP/tUW6nhJXgvMoeiyvReazaA
	 I6cpZsDfZ0Yh7RFF62LXzZ03M8UjpoRgH29vtXhBGm3XXvlCgEfQkpR7VqGv7GceoL
	 WuLWajg7sU2SeUV8HNjz/RW1je0DekG7D136S7o50eMK+UYx7G2NySrr3V1ghaIQPN
	 /KDkA67CS5QCE5CKb24dY824TKTLMveJibcINdj5yUaz/ZsPZQi62eW6Xs1UXEH5Gm
	 7b+IWTVGxYrYHaGQtMq5B8sS2eE9F8Db7MjmMrq5voOSvABX/FVNXm4YL4y3mJhq5b
	 vZ2+wRoL3yCEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 367D2E270F6;
	Mon, 17 Jul 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v9 00/11] Brcm ASP 2.0 Ethernet Controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168957782321.7157.4637717042830143680.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 07:10:23 +0000
References: <1689286746-43609-1-git-send-email-justin.chen@broadcom.com>
In-Reply-To: <1689286746-43609-1-git-send-email-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, sumit.semwal@linaro.org,
 simon.horman@corigine.com, christian.koenig@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 15:18:55 -0700 you wrote:
> Add support for the Broadcom ASP 2.0 Ethernet controller which is first
> introduced with 72165.
> 
> Florian Fainelli (2):
>   dt-bindings: net: Brcm ASP 2.0 Ethernet controller
>   net: phy: bcm7xxx: Add EPHY entry for 74165
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/11] dt-bindings: net: brcm,unimac-mdio: Add asp-v2.0
    https://git.kernel.org/netdev/net-next/c/27312c43472b
  - [net-next,v9,02/11] dt-bindings: net: Brcm ASP 2.0 Ethernet controller
    https://git.kernel.org/netdev/net-next/c/a29401be8c69
  - [net-next,v9,03/11] net: bcmasp: Add support for ASP2.0 Ethernet controller
    https://git.kernel.org/netdev/net-next/c/490cb412007d
  - [net-next,v9,04/11] net: bcmasp: Add support for WoL magic packet
    https://git.kernel.org/netdev/net-next/c/a2f0751206b0
  - [net-next,v9,05/11] net: bcmasp: Add support for wake on net filters
    https://git.kernel.org/netdev/net-next/c/c5d511c49587
  - [net-next,v9,06/11] net: bcmasp: Add support for eee mode
    https://git.kernel.org/netdev/net-next/c/550e6f345687
  - [net-next,v9,07/11] net: bcmasp: Add support for ethtool standard stats
    https://git.kernel.org/netdev/net-next/c/649315346729
  - [net-next,v9,08/11] net: bcmasp: Add support for ethtool driver stats
    https://git.kernel.org/netdev/net-next/c/7c10691e1f5e
  - [net-next,v9,09/11] net: phy: mdio-bcm-unimac: Add asp v2.0 support
    https://git.kernel.org/netdev/net-next/c/9de2b402d818
  - [net-next,v9,10/11] net: phy: bcm7xxx: Add EPHY entry for 74165
    https://git.kernel.org/netdev/net-next/c/9fa0bba012c2
  - [net-next,v9,11/11] MAINTAINERS: ASP 2.0 Ethernet driver maintainers
    https://git.kernel.org/netdev/net-next/c/3abf3d15ffff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



