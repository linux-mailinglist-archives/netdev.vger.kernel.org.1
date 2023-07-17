Return-Path: <netdev+bounces-18199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9E755C17
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADDF2811CB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1DE8464;
	Mon, 17 Jul 2023 06:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EE1FCC
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CB6AC433C9;
	Mon, 17 Jul 2023 06:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689576619;
	bh=xxR4b48SYorrV6cf6YRJcpNX4D/WfbVD+dQx1ktaGk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RYd2oxHk/b/qhhUu7JqwrkPuxeTbEQxlrDhpkww3kwvnrIbMJnIEICYUFrGQeBpVA
	 d7b4JD32U/XgMOqLUgmXrBsKtIsQkg/ZVehm2Yg/vmX2Y7h/fW2V4AlUyQaVhaDtB3
	 eI661a2ranMhiakPOc9NL0iuCM3mImBIvjSlptV22GwiYarXSKgzwGkOMdqS6NGwJe
	 mlJ/Fx8CSqmGWJYK1KXQccZMMWo428fK/T0tcezO81HUt6paC6wpvl3ir8jZbAB9qz
	 zdDpf7ix/BiKAXCrhJ0yEoqyxT8vu2L2vUg9884hdYkVvILxG5ytYMsS8bt3Eq7MVH
	 Zdtxr098emB/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 423A2C561EE;
	Mon, 17 Jul 2023 06:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dsa: microchip: correct KSZ8795 static MAC table
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168957661926.28493.6331448129276612171.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 06:50:19 +0000
References: <1689295582-2726-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1689295582-2726-1-git-send-email-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: m.grzeschik@pengutronix.de, o.rempel@pengutronix.de,
 woojung.huh@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 17:46:22 -0700 you wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>
> 
> The KSZ8795 driver code was modified to use on KSZ8863/73, which has
> different register definitions.  Some of the new KSZ8795 register
> information are wrong compared to previous code.
> 
> KSZ8795 also behaves differently in that the STATIC_MAC_TABLE_USE_FID
> and STATIC_MAC_TABLE_FID bits are off by 1 when doing MAC table reading
> than writing.  To compensate that a special code was added to shift the
> register value by 1 before applying those bits.  This is wrong when the
> code is running on KSZ8863, so this special code is only executed when
> KSZ8795 is detected.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dsa: microchip: correct KSZ8795 static MAC table access
    https://git.kernel.org/netdev/net/c/4bdf79d686b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



