Return-Path: <netdev+bounces-41625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84417CB7A2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C181C20B53
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4617CB;
	Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1YmxdHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A715CC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C08FC433C8;
	Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697503823;
	bh=GVimcZInfACJ4G3M2c9SGSipYI9l4u0FccQnYFecCZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P1YmxdHqF7mDBB/cMVp0VKGijfxUwBHQWLOWackgys0RHbKlBdFo79Xr2znibchOt
	 X/bwTE6pVSDr+enDC1n5q2cLZYiqMVBiWCugKTF0F1uJKrrVy6OV4khu+IZSGpRbUA
	 mN4hpEmJJ8nMn4B3RR4AoBPA5n6Ov/V+meNXwpOMcYsMAoplneCaOoMZvpTTCi2BLo
	 tnNKMw/Yq1cvKYYoQRizzMIaD/NeOTUQyCImuVhQvG2HguDFOLclzIwEZREipbBUbH
	 dAP91ATCLQN6JXHp2fIMGuT9ZXUl66UJd4/m2MYQVDx+an78to45kmjOSD8L2XzihJ
	 QBKjDqR7B9nzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22CE3C04E27;
	Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stub tcp_gro_complete if CONFIG_INET=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169750382313.30000.3811795701309387527.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 00:50:23 +0000
References: <20231013185502.1473541-1-jacob.e.keller@intel.com>
In-Reply-To: <20231013185502.1473541-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kuba@kernel.org, davem@davemloft.net, arnd@kernel.org,
 aleksander.lobakin@intel.com, rdunlap@infradead.org, netdev@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 11:54:50 -0700 you wrote:
> A few networking drivers including bnx2x, bnxt, qede, and idpf call
> tcp_gro_complete as part of offloading TCP GRO. The function is only
> defined if CONFIG_INET is true, since its TCP specific and is meaningless
> if the kernel lacks IP networking support.
> 
> The combination of trying to use the complex network drivers with
> CONFIG_NET but not CONFIG_INET is rather unlikely in practice: most use
> cases are going to need IP networking.
> 
> [...]

Here is the summary with links:
  - net: stub tcp_gro_complete if CONFIG_INET=n
    https://git.kernel.org/netdev/net-next/c/e411a8e3bb2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



