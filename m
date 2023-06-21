Return-Path: <netdev+bounces-12458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A387379C4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACB81C20DAA
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C617D17F5;
	Wed, 21 Jun 2023 03:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C115BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFE75C433C8;
	Wed, 21 Jun 2023 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318820;
	bh=kIQtz9Eg6xo2Q6gKhfYrZttxKJ8I2teKzoggQfft2+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tg9uuv6vZsv5q1MvFUBuUObbzC1yY17D5u8pEUuPptSQ0TBuy3Ay4LGbprGEm68/G
	 WdHGE7aMbpVkeEInyAS9ujbjJlmCvSY+8ayqlnDQ6dQN7aZcvcFGn8oHvkVHcFOPPQ
	 QTcxy87aihXdJiwF5opvuxYqGLokcMBbzU7Y3aOrxxcYejKOdrIEJs1IH4rsUj6FO+
	 p4GmUCNE9p0Jd4xBl9eUvzKHXfZV+5qvyw0P/eHPGu0EphCUvSekRGPm2DTyyXnBZi
	 hleZnsHihDWxzDevopXQN8bGPRRf9PIH+CafAt0vEAxeLCZ1jo99Py2d/CHMb83n5X
	 ya8lEKih4TpmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1264C395D9;
	Wed, 21 Jun 2023 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] Revert "net: phy: dp83867: perform soft reset and
 retain established link"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731881984.8371.5821575043669064961.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:19 +0000
References: <20230619154435.355485-1-francesco@dolcini.it>
In-Reply-To: <20230619154435.355485-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
 geet.modi@ti.com, praneeth@ti.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 17:44:35 +0200 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This reverts commit da9ef50f545f86ffe6ff786174d26500c4db737a.
> 
> This fixes a regression in which the link would come up, but no
> communication was possible.
> 
> [...]

Here is the summary with links:
  - [net,v1] Revert "net: phy: dp83867: perform soft reset and retain established link"
    https://git.kernel.org/netdev/net/c/a129b41fe0a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



