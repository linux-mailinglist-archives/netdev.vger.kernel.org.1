Return-Path: <netdev+bounces-32763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7879A484
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9932811D0
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4203D76;
	Mon, 11 Sep 2023 07:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863633C29
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 07:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CD5EC433C9;
	Mon, 11 Sep 2023 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694417450;
	bh=WM/Let72K1wMRwb05Q5dSJO19Qx8XAwYxUcOvPl3aVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IgyOQQajD2aHRq+JcNAxxLIAdTPiOJX6tiHAxrlsa/rOl9CZR0ygkhFiIHha48PVv
	 UIZXBTDP8hQXPZsLuPn8RA+UYWAkaMmgSWMx5OnprjqiZilRA4h5oIwnnHWb+OzdBL
	 Zmgd0YK4F/pe2bD4A0z7QMoFxuqW2VTY78NPkIXtnN6W+yEFJP2nIQRCHa74k1UdXM
	 zqP7h+38qAKbPABBzlXRAkl98My7qmL6PcVKHsV0f5G0mU+NTRTbiunGe3LemNR6LX
	 KH02KHr55lzk/GAuZExTu5FWqOlIWgFlK5n3JuHEC9KprIqWiWD0LbJ8qRWRhkA3f+
	 b2n5ZJmFyRwfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0510C00446;
	Mon, 11 Sep 2023 07:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: fix handling of zero coalescing
 tx-usecs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169441744991.31104.1654820093252613008.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 07:30:49 +0000
References: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
In-Reply-To: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, nbd@nbd.name, maxtram95@gmail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@axis.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Sep 2023 12:46:31 +0200 you wrote:
> Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
> coalescing timer but currently it gets programmed with zero delay
> instead.
> 
> Disable the use of the coalescing timer if tx-usecs is zero by
> preventing it from being restarted.  Note that to keep things simple we
> don't start/stop the timer when the coalescing settings are changed, but
> just let that happen on the next transmit or timer expiry.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: fix handling of zero coalescing tx-usecs
    https://git.kernel.org/netdev/net/c/fa60b8163816

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



