Return-Path: <netdev+bounces-112930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6693BF1A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9381F23062
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8660196D8E;
	Thu, 25 Jul 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBUbNtzI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4272746C;
	Thu, 25 Jul 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899832; cv=none; b=izDli2N/6s0JVf+3rF9QNS3ZF5UMM8Vw7scJk5f++YH+UtNmB/WSmGIA3LTnJwTTJ7Lj0ns+9NNrzmGZ4PX+1+GCZIVhh9S96+7DrTX8DOs03zdcJUVwOE7aHGxG5raEIEYlViGMxE6x+aieqzxyR1caNuMeHY4iSmRrD+GNKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899832; c=relaxed/simple;
	bh=YkNQ0V1qk2PdVvo308FU3kSLrtEtNftLerz9oE7dXK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hlPkT/J8eDcq/trY24GWvHqn1my+MXrZYzMYl2nCuhFqzdbrj6pxosZFWjT+kVkaB/9D7mooGaKYf6ChVQgCCrMsflui6b+Totzcg+cpLAU8MJtMEpdxW59c3R9EA9QEp08ArkAHA09eabblyqtIpXiH8gvhgN3wOvRhxfPewPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBUbNtzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B45BC4AF0B;
	Thu, 25 Jul 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721899832;
	bh=YkNQ0V1qk2PdVvo308FU3kSLrtEtNftLerz9oE7dXK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nBUbNtzIgLm5N5gAAgerb10vnpa/HYKzng5SBBkr4VlUT9gG0fod/AsISeOtEfswg
	 hosdut7ZIY+QAeYQbk+x/U6facKkH16opmer0Ba1P/d2ZP9pb7smvd5F6mZTUNarkL
	 6gqN3NS/Z6ct9deaZAjIPFTEIB+VSoDbLHyWMfJrlTw64rVlJuNgjzs5iftAiVYDI4
	 d/EDsT1OCD1rq/7YhiCPn4GZI4LnmLQu1Km3OpMwRyha/xNlBnJBcccc7oibUWyusv
	 NjnNaNfRn54TOzU5TcWj09RuITO7anfc8ga5vMisZy5jeeKDEn/YthPusBbEpBGYV6
	 tWG6em0kRXYhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00128C54BB2;
	Thu, 25 Jul 2024 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mediatek: Fix potential NULL pointer dereference in
 dummy net_device handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172189983199.31991.12505677109278779843.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 09:30:31 +0000
References: <20240724080524.2734499-1-leitao@debian.org>
In-Reply-To: <20240724080524.2734499-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, leit@meta.com,
 dan.carpenter@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 24 Jul 2024 01:05:23 -0700 you wrote:
> Move the freeing of the dummy net_device from mtk_free_dev() to
> mtk_remove().
> 
> Previously, if alloc_netdev_dummy() failed in mtk_probe(),
> eth->dummy_dev would be NULL. The error path would then call
> mtk_free_dev(), which in turn called free_netdev() assuming dummy_dev
> was allocated (but it was not), potentially causing a NULL pointer
> dereference.
> 
> [...]

Here is the summary with links:
  - [net] net: mediatek: Fix potential NULL pointer dereference in dummy net_device handling
    https://git.kernel.org/netdev/net/c/16f3a28cf5f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



