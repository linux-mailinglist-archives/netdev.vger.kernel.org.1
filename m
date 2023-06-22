Return-Path: <netdev+bounces-12869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C353F739374
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21AD1C2102B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208EFC1F;
	Thu, 22 Jun 2023 00:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC1DDA4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A0A0C433C8;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687392021;
	bh=/uMLt2E1rz9exuqGr5hQn1iG0P4+0/KdRlRethHTB4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IBB0vPirVqsC388SKFlL7nZP43HWMnizxH2Ko6+kaOyVC3+yLciavVzzheGiENssf
	 E9BoMWlS/s3hk9VG3JyGRCQn7jW0Dnm8gxVY0IUIXCsZ1Z2iSxLwpFeYrde8DwdXlz
	 CMP7datQeInUbXiCxNMwy+fjcJDApODgKstKXjXcPXmICcg5v+qzo046rmFfBbJvCB
	 9HbkRlmzgF9Im7TxGV2N6KVKbbisHzYB3gMMxJK9kKR7fFKFw5uefdHSWFfMOuUkXE
	 hMZROMUOlBwST3MhiqEmx3sJQMxTvskf20I5CtcBlC96SYpgMNtpuw6ucR4GmF0Jy7
	 i3P6GqJah0rbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29973E2A044;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: micrel,ks8851: allow SPI device
 properties
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168739202116.22621.14381446710922927523.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 00:00:21 +0000
References: <20230619170134.65395-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619170134.65395-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, marex@denx.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 19:01:34 +0200 you wrote:
> The Micrel KS8851 can be attached to SPI or parallel bus and the
> difference is expressed in compatibles.  Allow common SPI properties
> when this is a SPI variant and narrow the parallel memory bus properties
> to the second case.
> 
> This fixes dtbs_check warning:
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: micrel,ks8851: allow SPI device properties
    https://git.kernel.org/netdev/net-next/c/1ca09f5746ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



