Return-Path: <netdev+bounces-22222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B533E76699F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B551C21816
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618901097F;
	Fri, 28 Jul 2023 10:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819011185
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CAD5C433C9;
	Fri, 28 Jul 2023 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690538422;
	bh=ZIcz/QLug4MnlRNXI4CQ6phjwPWDIizZBNVnXkgRYWE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SgqvEM5JS7Fi6F7g6KpyoR1eSK4KPZRUOyvBMBoTDiTfxVs9cJjfig2iiYPYIECAj
	 jPHq0H8MQQM/qMlX/3WYnBjg1m4Smv61CoomLHQgntHCdh03e2FJk/VPz7+ns0aI89
	 FGSAmq4tM9rrgOWnkTHqiTz6l7IF8MU15IcOnG5nH2/KcKQV8axMFi7Eqh/V8j27K2
	 0uD6Qtv4r1wxr44neXUAyUtOapVrkNi+ITpGv9xIycBaL8ZBw52UpRdzc5xh38nmLe
	 hxfxjLFDRlSVMbNwj3PDAcUQArnhjODZtb8GSxu73qnxNzjVI+zveqqDCYJfbYuIU4
	 UPh3l/5R/XnAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E0D9C64459;
	Fri, 28 Jul 2023 10:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay
 defaults/range in schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169053842237.6578.2445331118496951237.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 10:00:22 +0000
References: <20230726070615.673564-1-eugen.hristev@collabora.com>
In-Reply-To: <20230726070615.673564-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
 krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Jul 2023 10:06:15 +0300 you wrote:
> The range and the defaults are specified in the description instead of
> being specified in the schema.
> Fix it by adding the default value in the `default` field and specifying
> the range as `minimum` and `maximum`.
> 
> Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults/range in schema
    https://git.kernel.org/netdev/net/c/5416d7925e6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



