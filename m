Return-Path: <netdev+bounces-141301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD19BA68E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04611F2147D
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B265187553;
	Sun,  3 Nov 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5sGKsW0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFF187342;
	Sun,  3 Nov 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650220; cv=none; b=FvnMs5rtNMwHjbFtWtv4gO5vVc/3CY9y49wpzVU6SxTjZ9anxXvsbUw66czmgigan7w3HMXN2GeGQJ+5DyqYxGnVLqR5gFaxSV4qIwL2/eI9sjGKh0m76zkoBKaujqbGLsWSoelpLOO+mI79S92EnBX0+XF/qKn9z+Xb0Zpeqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650220; c=relaxed/simple;
	bh=h5SwN9QtlupBN2TmSX7ULAcRqNku5r5cgGPMrZqzkY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cK2uBTY2ouDbhBa/VXrLsjMA3/Gen+GArEQNd+BZ9Dnb4qVES7aD7m3dw7ccnbJrpSKq5evHMxU0kWLDPSSPBIt42RF+XiGGd4xh+I2uSVGclg7nWidMNXcmGWyeg7jznwlGHK1tK/BGjRIME5bL+1XSng1OcCvHTxwT1PXdJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5sGKsW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C827FC4CECD;
	Sun,  3 Nov 2024 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730650219;
	bh=h5SwN9QtlupBN2TmSX7ULAcRqNku5r5cgGPMrZqzkY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V5sGKsW0r/fTuvNfOt3Axwvzy3KK4d+o0XCqlHKjqDFS7+z9O1ZvQ8FAI9NVeIHIw
	 x9qsRV39NFfqrzOCX4fAXroZsfNDHW7IEHFxzrgWPlKAAt866COkxx+lHqDOtuP8Nb
	 t3ot4hRY9telHFHctjS1rj0EM9vWx6vm7uk7y6fZbbT59pheuVxYWv2zkHS7tU/XbD
	 cmBJuMfjrMpp84LC0MNEmJnyxgSDB0JPYQk4RUeTOcZ54XkqgGI7VleTW7rsgfZp+G
	 6tvnP9uy7dPyCaI/USwHZw8xi50KZFihbhr+IXkPIoag/PopZS4oER3ZngnyRFpi8X
	 oLvS4Eyak7PnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7107D38363C3;
	Sun,  3 Nov 2024 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: wwan: t7xx: Fix off-by-one error in
 t7xx_dpmaif_rx_buf_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173065022826.3205552.17881311291289594759.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 16:10:28 +0000
References: <20241101025316.3234023-1-ruanjinjie@huawei.com>
In-Reply-To: <20241101025316.3234023-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ilpo.jarvinen@linux.intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Nov 2024 10:53:16 +0800 you wrote:
> The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
> allocated and mapped skb in a loop, but the loop condition terminates when
> the index reaches zero, which fails to free the first allocated skb at
> index zero.
> 
> Check with i-- so that skb at index 0 is freed as well.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()
    https://git.kernel.org/netdev/net/c/3b557be89fc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



