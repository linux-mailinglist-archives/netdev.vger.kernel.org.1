Return-Path: <netdev+bounces-12461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789C7379D1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C381C20DBF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751F523E;
	Wed, 21 Jun 2023 03:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAC23B7
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60F3BC43397;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318822;
	bh=cHs6l9Wn/trqdIO7Zr4Fcl4039VfY2j7Men0yugCZeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HF6mOMwqZ2gY6bVO7ezyp68CC2wQ/qhiqRzVwiGcoqm34vx84Yl8eys8BQ5Fxr80A
	 Y77PKy1/YWCzD306jd/HuY8W7FzyUlv291JoMV4vfbh7npiSDVe9JsQW78hxUyjKXJ
	 De4oEeIdbZMpQ9IBEBIgycIpfFPezv4GBh68pnXsC1RXBzFXE5xBEP4O6+VXLpFeX4
	 6Jlvpf2/JlqGRheHGqJwqmWBtHWLMecM83p50T03vTiR1NUqBhtd/jOYf2rlfBCu1J
	 2G0E5K/C95kQr7YnvK7lNk3FEW6LJ9Yk1zJCoAGC9KHa+gHb5yanTNnJFm367F6MX9
	 P4ktl7g7SVOFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 333F5E2A036;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mctp: Reorder fields in 'struct mctp_route'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731882220.8371.6776678967932751934.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:22 +0000
References: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jun 2023 11:33:55 +0200 you wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct mctp_route'
> from 72 to 64 bytes.
> 
> It saves a few bytes of memory and is more cache-line friendly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net-next] mctp: Reorder fields in 'struct mctp_route'
    https://git.kernel.org/netdev/net-next/c/066768b7305b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



