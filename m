Return-Path: <netdev+bounces-31766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75817900AB
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 18:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF371C2090F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53232C155;
	Fri,  1 Sep 2023 16:25:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546BC154;
	Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7CDFC43391;
	Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693585515;
	bh=V8XH4cIvHWrSs/u5pfHFkWBm7960Sk/XsLtEUa1DSQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BzksYAGVttU96YQgR8k5uPURSLS9LxrDL3vCUmVWVd45VRtBL/9kKNPEEGelVZhxc
	 Oc/b4siJEVLM1MxOshBWjoNsfwpV/l5oYYAlrdYh8JJWyRWPW55lIZtKj1rUPixmP5
	 I3QIn7BAV56Jw4ujVvpUR+GqHQH9eU8LgHFpqAQaE1eK8kCFgQhtHk0hJH7B8A18Ci
	 GqfEXh5Qx6Iw6MmoeBeILSTb9jQuOVFf8FUDPolZBe9kvmn8N7D6b0q6Dtuj8cKbPS
	 GQIybfMcQcwTtqXXSwbdaiTR3re0BpZE9MKbAdCwWZeu5iafX9qtUdTXs61O4Md7MD
	 pMwVI/9NU8lZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1CF0E4509E;
	Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] Add support for Allwinner D1 CAN controllers
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <169358551565.8276.3801944999733958707.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 16:25:15 +0000
References: <20230721221552.1973203-2-contact@jookia.org>
In-Reply-To: <20230721221552.1973203-2-contact@jookia.org>
To: John Watts <contact@jookia.org>
Cc: linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
 wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Sat, 22 Jul 2023 08:15:49 +1000 you wrote:
> This patch series adds support for the Allwinner D1 CAN controllers.
> It requires adding a new device tree compatible and driver support to
> work around some hardware quirks.
> 
> This has been tested on the Mango Pi MQ Dual running a T113 and a Lichee
> Panel 86 running a D1.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] dt-bindings: net: can: Add support for Allwinner D1 CAN controller
    (no matching commit)
  - [v2,2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
    https://git.kernel.org/riscv/c/6ea1ad888f59
  - [v2,3/4] can: sun4i_can: Add acceptance register quirk
    (no matching commit)
  - [v2,4/4] can: sun4i_can: Add support for the Allwinner D1
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



