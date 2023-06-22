Return-Path: <netdev+bounces-12867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F4739371
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FB31C20FBA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE8DF63;
	Thu, 22 Jun 2023 00:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F3DDA2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 568A3C433CA;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687392021;
	bh=C5BkJXS6Vgw04VtsKDnyCQbmDTblMR1v9dWpWQr/0uY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIHRsngolwud2asdbOkq6gslIDQe9iPWOypw3fAtQLCqFWdqdNo68S+7OWGJnOKoR
	 x0LyBxRkRNWjtot7fHzqXH+isRfhNVo4Dks19oWl42QpoKyv73sQSorNDwxRBFCwCi
	 AL1s132ehdOKABA4SRVCeSpjQWyyagcBnmVFxTPkXME4EFcENg4hrCyrceUAMHTI4V
	 UoMmOP5sk9Xlu8KyU4fq/freTy483x4B/gnPtDrg/7a1YgwShRvqHXkmzGb76fkKeT
	 FqLTnIy/A+024/3dBVUpvtEF8jIdjCOrGjuLxJs9OpbeMeL7bC5BJmpMH8SCgLd8tU
	 SpuQAbJn0rNvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34BA8C395F1;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm: document
 VDD_CH1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168739202121.22621.9813816851269923496.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 00:00:21 +0000
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, bgodavar@codeaurora.org, rjliao@codeaurora.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Jun 2023 18:57:16 +0200 you wrote:
> WCN3990 comes with two chains - CH0 and CH1 - where each takes VDD
> regulator.  It seems VDD_CH1 is optional (Linux driver does not care
> about it), so document it to fix dtbs_check warnings like:
> 
>   sdm850-lenovo-yoga-c630.dtb: bluetooth: 'vddch1-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: bluetooth: qualcomm: document VDD_CH1
    https://git.kernel.org/netdev/net-next/c/6a0a6dd8df9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



