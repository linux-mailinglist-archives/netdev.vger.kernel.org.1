Return-Path: <netdev+bounces-37266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F17B4780
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BF709281B66
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54FC171BB;
	Sun,  1 Oct 2023 13:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAB15AC0
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 13:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62141C433C7;
	Sun,  1 Oct 2023 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696165229;
	bh=jxexDSoTCPqVD3y64QYOzbtN9SFeMaNafBFS+DFMyR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hTtAeYBMG75O7yoDp9uzzFy4Elz+a6DzvMvLPXDljd7z7VDHFXsGOZRQfZ2vnANdj
	 8hbJUbZTiwXDd4i2HxfBxaF6OotbFkjZF7YaudXVmhGdeY2pRdsviZdd25fc7zq4yM
	 KI0gZwJo2X5Ls9nQRBZMR4N0Q1PPvU0Q1gg1cUbURQveFKaFCOCSR0B6M0EYrIEVaA
	 HnWXhm001ECd/AuVRQNYhrUZlQUTs/50t2pW3w9tYzRvUIgfAi9+7TIG++FnB7DNSa
	 EN+HV8ijbCZls8DiNrGwMR/VusbX/Q2Wx1sIKBDcbt4HbJeLFbii2r0Y6aZXBc8zh0
	 NjRL9Dp90GPPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BE96C691EF;
	Sun,  1 Oct 2023 13:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atl1c: switch to napi_consume_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169616522930.29918.9573037295555946176.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 13:00:29 +0000
References: <20230921005623.3768-1-liew.s.piaw@gmail.com>
In-Reply-To: <20230921005623.3768-1-liew.s.piaw@gmail.com>
To: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 08:56:23 +0800 you wrote:
> Switch to napi_consume_skb() to take advantage of bulk free, and skb
> reuse through skb cache in conjunction with napi_build_skb().
> 
> When parameter 'budget' = 0, indicating non-NAPI context,
> dev_consume_skb_any() is called internally.
> 
> Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: atl1c: switch to napi_consume_skb()
    https://git.kernel.org/netdev/net-next/c/d87c59f2b00d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



