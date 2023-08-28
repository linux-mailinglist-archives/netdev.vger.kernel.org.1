Return-Path: <netdev+bounces-31122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41678B8E6
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0871C20443
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44F14017;
	Mon, 28 Aug 2023 20:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F41428C
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6E6FC4339A;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693252823;
	bh=mVb12YlTB6xVrBKuueakgwHjYap7/xn1tlPXAoVeLh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=REUtadEdIKVwoDCJ/a1eUZkU83UaCBIfV2VMcN0SNO0fZjsvHR5Y7AUxuTnwYQ98B
	 GJ3p6H8VamIr89XSQeew2xtU/3OGyjMnBol2wbYogiUvH/8I+yRAEX+dTxFub11xKN
	 qTiDuxIVEXG6N2z56dErThkHom8jSe1xl7NUWqfRCVX+osReQFJ/fkAKiu4miVCuck
	 UByd5jMsS7KfpJGB9t3xIYA4HoteaKWeL520eEEYKxO4yxaUOT0CqSNBeIi/EoIOB5
	 rxUGSGSj4JUv4eYNIRu5cQfIEjm/IXI4jTaCKtDWlf0EbNs8fzVLLOokQPFVfiw2uv
	 Ly0YPT6+rnBlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E8F4E33082;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: add vendor/device ID pair for D-Link
 DUB-E250
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169325282364.23387.4944546099448167756.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 20:00:23 +0000
References: <CV200KJEEUPC.WPKAHXCQJ05I@mercurius>
In-Reply-To: <CV200KJEEUPC.WPKAHXCQJ05I@mercurius>
To: Antonio Napolitano <anton@polit.no>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Aug 2023 01:05:50 +0200 you wrote:
> The D-Link DUB-E250 is an RTL8156 based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Antonio Napolitano <anton@polit.no>
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: add vendor/device ID pair for D-Link DUB-E250
    https://git.kernel.org/netdev/net-next/c/72f93a3136ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



