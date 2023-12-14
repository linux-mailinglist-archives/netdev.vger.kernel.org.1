Return-Path: <netdev+bounces-57517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31B81342D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5ED280EEA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E625C08F;
	Thu, 14 Dec 2023 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+RJZv5r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F15D8EA
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 15:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00082C433CA;
	Thu, 14 Dec 2023 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702566625;
	bh=zdcPAZnAA+fnlDDoOYRTGowddn9N6RX9Wu2qUUDSKFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U+RJZv5r0gLIx1b3cdJt/uFDST4E6gp7GYxQJeBvkUc2GzO+4DjPNLFelmqSpuwWn
	 Z0b1KPzxRPu7M4knGDGvD+M3hfJ3mxnvw/LPHA+Rn+J5ayq6MHVO3w7mjFgAU9xqut
	 wx6ziqUtWJ2fGWpgUoqcZ6tyekdhUTOpygbSA/pfBBLlr+erR+L/8U2lq7hfNOSUT7
	 ebgCoiHesHIsOvd1F6fDdEevhBF4xvdPuQs7QH2ur0Y1aqcZ5QvtwPchHQDSoVDs0q
	 KZa3yvx8QSqHHxT6bgjVGbc3jLx+jsn91tktRCTIKouLnDSv6z0QXB9qQpYiTrNO6i
	 aI+jcgLBnOcdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9BBCDD4EFB;
	Thu, 14 Dec 2023 15:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mvpp2: add support for mii
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170256662488.26207.4155748684872594821.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 15:10:24 +0000
References: <20231212141200.62579-1-eichest@gmail.com>
In-Reply-To: <20231212141200.62579-1-eichest@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: maxime.chevallier@bootlin.com, mw@semihalf.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Dec 2023 15:12:00 +0100 you wrote:
> Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> The description in Marvell's functional specification seems to be wrong.
> To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
> we need to clear it. This is also how U-Boot handles it.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mvpp2: add support for mii
    https://git.kernel.org/netdev/net-next/c/1b666016d0ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



