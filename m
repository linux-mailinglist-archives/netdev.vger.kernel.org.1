Return-Path: <netdev+bounces-48509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86447EEA57
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DEF281137
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B1652;
	Fri, 17 Nov 2023 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUZcgwo/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E87384;
	Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 517BCC43391;
	Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700181023;
	bh=HlypnzxeE3S9lFFNCAPZqir+lGEfON+V4ihvlsSuaB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CUZcgwo/BdCJXTHjVctNu3MZOGJd1/HCRmPM9ZqC+UnMm9FXsQf4wzrwntzL/SYPR
	 4lSyyRw60HMadKhEnTOt/svDNZHQAghfwcEgi1RmiRss/0H1pzPcH6IFpxOK940G/f
	 tyvn9WPVNn78WtvIcNqmn2HiFJSzlJ0zn6WqKExG8XbyA4+0OFbsrTbnGqQc/+WtYd
	 ZffCjMi9ECydsuxcnaQRJn7kz7ywYye6iEkD+r2+oqLVUGTNbr2pKy91yc5W9rkIRE
	 PZq/nL4aNjxnaTwLGtUN8Wy6mDhbrx5+CkIhoj4hhX2uQyvmDQiLLkc1FFVeyPeD7a
	 xYq2PtCqwepOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 307A3E00092;
	Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170018102319.11691.12519242645299739953.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 00:30:23 +0000
References: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, sergei.shtylyov@gmail.com, magnus.damm@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 21:04:48 +0000 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The Gigabit Ethernet IP block on the RZ/Five SoC is identical to one
> found on the RZ/G2UL SoC. "renesas,r9a07g043-gbeth" compatible string
> will be used on the RZ/Five SoC so to make this clear and to keep this
> file consistent, update the comment to include RZ/Five SoC.
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
    https://git.kernel.org/netdev/net-next/c/7c93d177d913

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



