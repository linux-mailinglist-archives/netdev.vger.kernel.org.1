Return-Path: <netdev+bounces-22734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C45768FEE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC70D2814D2
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A011CB9;
	Mon, 31 Jul 2023 08:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A658478
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A724C433C9;
	Mon, 31 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690791622;
	bh=D94/uDM8VUf/iGPEsn5ahoMjiZ3Iz7JJ22L+8EoN1p0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EyD+FtGw/uK+xmEOJtKgpmCQIXNZyuUxxRcgBtktxBTQDclVs0Rg8FyLWJ/0DiXFy
	 JtHY8DQKjWLII3BcXpo/eORdLjNSeAt0QbvlrFNV5vnm3mip+RWO/S9flD6nd89xPe
	 2rdiADXYrzuLRmANArdd0FDlhQFtRbs86xUkp4AI92R6NEUfzs9kELkM1dTDFKitxf
	 gMvUPiL7+9/FmoZnTepwWnxGuuGfHa7csN3XgBLWpHye5XaiT2Gh+XozyIR65nGr4f
	 u4O6hUUGtFT3lHS9z3TqnwpD+VMxoWv4CfsQfpoGGroVTr5E/0Mnj6B0c9y8wKxoE3
	 goN4ZQ9U3rqvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D755E96AC0;
	Mon, 31 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: mediatek,net: fixup MAC binding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169079162218.10005.10651716865931454338.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 08:20:22 +0000
References: <20230729111045.1779-1-zajec5@gmail.com>
In-Reply-To: <20230729111045.1779-1-zajec5@gmail.com>
To: =?utf-8?b?UmFmYcWCIE1pxYJlY2tpIDx6YWplYzVAZ21haWwuY29tPg==?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lorenzo@kernel.org, nbd@nbd.name,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 rafal@milecki.pl

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 29 Jul 2023 13:10:45 +0200 you wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Use unevaluatedProperties
> It's needed to allow ethernet-controller.yaml properties work correctly.
> 
> 2. Drop unneeded phy-handle/phy-mode
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: mediatek,net: fixup MAC binding
    https://git.kernel.org/netdev/net/c/8469c7f5472f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



