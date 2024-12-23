Return-Path: <netdev+bounces-154105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F039FB436
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4421885D9E
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7A1C5F3D;
	Mon, 23 Dec 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlVkDw64"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653631C5F31;
	Mon, 23 Dec 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979814; cv=none; b=uC5OuIyI4jYmgH01S5nY6rLbZMJPttU39dOd56A55MLI4YdMN2ClFF6jzeTEbeaHa5o+5ozQG8KVfmZEZhUYE8lYGe7CSXEGGY1FqQ0r8krfFhkVzRX6GR3FAmLktFo2k9INeK/vSOyat6RNEtCv+SxLZ5NU405kUYOfRceKbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979814; c=relaxed/simple;
	bh=c3XHQikZKayR2pLk9uXxawQU0/ldNzFFVqDCX3L4EgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNgESywXvq8R75UNMe09oN18Xh8I0aY48G+L6fNeSy/JfpTqpwG40ZFxLTpilBh1N6+ecZa4cHtY7Lh9qYgyB9pILPnpnm6Ru51/IfMhKgeJwfPsiuR9vDUkwXnUp9Bsx82A3USTOxVWqNDD44bvSYTiqPY7aDLSCbgarN8axu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlVkDw64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F6DC4CED7;
	Mon, 23 Dec 2024 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979814;
	bh=c3XHQikZKayR2pLk9uXxawQU0/ldNzFFVqDCX3L4EgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NlVkDw64t8KuM32HWXdYq4m62djR813FHv/GN0h5GQXYuS0C96CbprveeulzXZ/Ah
	 9UkHyW9bbkaeXlkEEKgMnfMhvQ7bagqOHovwY2IvwLCIBIIY2Ybr7KA9BrGB40uqhQ
	 RZ0FqTm5cVWc4rsm7ZzhBHmDua3qRAGWaAgwpJjkYQk6ggCBoh+ZrvTnT104j1qn84
	 n4oVgI27Q62tphPcKM2G8imoKYkXoQxvCW2WPGokavGtesv0Cft11+x3o0cq7lJYAU
	 1udNKssqnekh47dMNyWyoXrmuH0Th7+oMLi7m/ski1bVz+wydNaMz2vOw2r8rTcBGV
	 KBxnmxVIDzrzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFC3805DB2;
	Mon, 23 Dec 2024 18:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix power on/off issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497983225.3929264.13777694556549930869.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:50:32 +0000
References: <20241220170400.291705-1-kory.maincent@bootlin.com>
In-Reply-To: <20241220170400.291705-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 18:04:00 +0100 you wrote:
> An issue was present in the initial driver implementation. The driver
> read the power status of all channels before toggling the bit of the
> desired one. Using the power status register as a base value introduced
> a problem, because only the bit corresponding to the concerned channel ID
> should be set in the write-only power enable register. This led to cases
> where disabling power for one channel also powered off other channels.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: tps23881: Fix power on/off issue
    https://git.kernel.org/netdev/net/c/75221e96101f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



