Return-Path: <netdev+bounces-40265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEED7C674E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBCF1C20C2D
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1E1548A;
	Thu, 12 Oct 2023 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoEoRUpv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C243D533
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 920A1C433CA;
	Thu, 12 Oct 2023 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697097625;
	bh=O882kTatJUIM5yahWX6nBR4fl+n08XtCK8x0rge5Tzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FoEoRUpv0D/OgBLUrBqYj0zvAa8cLdYa4aesDkNN/CeguSM7ockT2ygBguR3kffJk
	 RTuEpwLWJ9dvFLWJ8wjDbQG4dqK+gdzA/2qWoSSfQEqb5PwKgiSO0xlKoZ2zbkvz8w
	 QQuT3vMQm0rGns1FVYQ1/Recy/KMD+xqa1x+LntRTWrU4qrEU3/M9DYcOXBOjzP/9W
	 i/1X5aqRWQet/Umxi0ubGBgraESv73mqBgFQeKtsq7IpfrEkKoSFBhN2OcgBHsTh+t
	 Wz+iczAEVc4WNltH+Q7iE4OxhRUdULEp36nQKGnoFBrGRmN+POxWpz5G3ZXPYVlNzd
	 A1D36YHcjGwbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76684E11F70;
	Thu, 12 Oct 2023 08:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeontx2-pf: Fix page pool frag allocation warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169709762547.19292.7784236842180734581.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 08:00:25 +0000
References: <20231010034842.3807816-1-rkannoth@marvell.com>
In-Reply-To: <20231010034842.3807816-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
 linyunsheng@huawei.com, bigeasy@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Oct 2023 09:18:42 +0530 you wrote:
> Since page pool param's "order" is set to 0, will result
> in below warn message if interface is configured with higher
> rx buffer size.
> 
> Steps to reproduce the issue.
> 1. devlink dev param set pci/0002:04:00.0 name receive_buffer_size \
>    value 8196 cmode runtime
> 2. ifconfig eth0 up
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: Fix page pool frag allocation warning
    https://git.kernel.org/netdev/net/c/50e492143374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



