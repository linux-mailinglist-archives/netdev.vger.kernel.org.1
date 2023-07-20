Return-Path: <netdev+bounces-19453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A402175AB9A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F697281D83
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F393174FD;
	Thu, 20 Jul 2023 10:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC77174D5
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98A0AC433C9;
	Thu, 20 Jul 2023 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689847221;
	bh=kI7QNuEAZe5hsZGSYU4LFc9o4hX+RTJ60091wATYuFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tk96alwFbFBBiABRLOVJcRUqKDIGrN3/mtZdO33gPxf1vwP+KWN9eJ2kptc4SqKoU
	 ZqHi8o81ckNwKjupf+InMTXwKAjzGa6gIIMjT2/7DkGkvNYa3LIQ/qGHpR2CrZwcWN
	 kqE9om5xE02iXhBdH406l84gyPusSd2kgQhOak0yKL0IOJXMgGf+ayL66WJImT1ibN
	 0vtC+3wbQrYAjp3aQ/Y7obWxG5eOFD9pER5letRkXSEBcLfcseLx+y1QwVuBDMQrgw
	 UZycPO19BW3kGLqf/opcnEXMaLlVceXwFdIn3PA+sIznjGvJ1lGfZv0Xuar0e4PbtJ
	 I5v5tGzFMHeiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7581AE21EF5;
	Thu, 20 Jul 2023 10:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: Fix JSON pointer references
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168984722147.11486.18313899802299137410.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 10:00:21 +0000
References: <20230718203202.1761304-1-robh@kernel.org>
In-Reply-To: <20230718203202.1761304-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Jul 2023 14:32:03 -0600 you wrote:
> A JSON pointer reference to the entire document must not have a trailing
> "/" and should be just a "#". The existing jsonschema package allows
> these, but changes in 4.18 make allowed "$ref" URIs stricter and throw
> errors on these references.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: dsa: Fix JSON pointer references
    https://git.kernel.org/netdev/net-next/c/cf3e913bf41d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



