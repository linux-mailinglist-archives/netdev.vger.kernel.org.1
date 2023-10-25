Return-Path: <netdev+bounces-44126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFC7D6717
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E7A1C20B51
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F999224F1;
	Wed, 25 Oct 2023 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Ftm80K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60C219F3
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB84FC433C9;
	Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698226823;
	bh=M9v/QfcahXGt7MoCY/1fFrdWgi6pHX9v0Gl8MznBkCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a3Ftm80KvXGnrQkLo0+8QENQajpG8aGNb+0Uk6uHqf6zvHFFcpdKy/FhPpw/cmf/i
	 6WyFWVugcKP2X9tn77tlluBQzg9KAsIaNeohAaGD2hI5/BSshamLvHJgQ0LG+WtUSY
	 hdaETBLdOiNXPbbwIsAOXB0Ek7QepmgOBTx9t18ytImZnMZJMicNNTrRYNesrDiLrV
	 8PrI9rAHOVnz69trQoaJAtvBvi/8lh29bT733mFr1Xpq/CKWwuReJGBD5XFFa+jV3v
	 S31krZfQWLsXnmfbliLwYDi91C1TUn40qFlY2QlhlccgljDLXI5A8x6XO/uA6VxGjZ
	 G10v+zR+XHzcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95E29E11F57;
	Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv6: fix typo in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169822682360.18837.1022880287063370632.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 09:40:23 +0000
References: <20231025061656.2149-1-wangdeming@inspur.com>
In-Reply-To: <20231025061656.2149-1-wangdeming@inspur.com>
To: Deming Wang <wangdeming@inspur.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Oct 2023 02:16:56 -0400 you wrote:
> The word "advertize" should be replaced by "advertise".
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  net/ipv6/esp6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: ipv6: fix typo in comments
    https://git.kernel.org/netdev/net/c/1711435e3e67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



