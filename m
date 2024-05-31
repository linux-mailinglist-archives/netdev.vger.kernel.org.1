Return-Path: <netdev+bounces-99611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FC8D579B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852FCB23D24
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA7A5C89;
	Fri, 31 May 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXW97PsS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6917545;
	Fri, 31 May 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117831; cv=none; b=oTs/W/bf2XHbbj/QM71duDl4DWnxkNN4dc8IzFFpOBwtDVxIzoGtRbsma5DPm+H5zbpI05a17dwZ7UVh6QMb/AMYpEcWndgQzqQjJZQ6uySnT/IyzYxNCkdW53xT3PbKTYYOLkv1/H8gtmZn33s+iPI7YDG84TLN/W480dQ+Rns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117831; c=relaxed/simple;
	bh=w0X7ZvxTXuag+5wWSwMpoObcm6tYak9x7e48Xv4bRkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iHeQFip85pPVjLM8/8rTaOpw8vGaRbeDJkNfZ9/LBz0vgrzDlug5AlaVNtHJSGMXbRFb30rrpehYUb7jqjoV/ei8ziP8bDy5UMF0NM+HGd/dEmqrWdORjRAYEmcCPwT7bYrCopCroY9N5OUEP+cUKC26kklN4qZtmZ7vJ6zFtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXW97PsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3A49C32789;
	Fri, 31 May 2024 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117830;
	bh=w0X7ZvxTXuag+5wWSwMpoObcm6tYak9x7e48Xv4bRkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aXW97PsS3G+z/wAHMX6wIt4TOvN877AcBk1MUTIORVj5mXtHyhbktu1ps/yvIWA1U
	 a6mZiQd5loLjfkMr589whFtKEVwop0szj0T13ThkvJzFkiVZjPC7MRvF6SX3of9VNJ
	 tHhy+hwSy9cR/RoylA0z+Ejr/FzVD42yOMrJu8MzUbV7FSQX6p05qB4AcmhIgR8TiM
	 E1m0dfAqfMH5zQK1x39J4osv5R8Nzqli8TQtcis8Kd8jJw2PQLxA2PN0HA8qJeTsQB
	 3rXQSsk4D5+G6KMe2ey7a3yzkpZvlxBmSEmhnWiyqux0XDMNHmmZA55/2a5EHenYGY
	 0WqIQrcQNCN/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 913EDC3276C;
	Fri, 31 May 2024 01:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethernet: octeontx2: avoid linking objects into multiple
 modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711783059.1907.3068035818325840874.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:10:30 +0000
References: <20240528152527.2148092-1-arnd@kernel.org>
In-Reply-To: <20240528152527.2148092-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 sumang@marvell.com, horms@kernel.org, anthony.l.nguyen@intel.com,
 jiri@resnulli.us, mateusz.polchlopek@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 17:25:05 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each object file contains information about which module it gets linked
> into, so linking the same file into multiple modules now causes a warning:
> 
> scripts/Makefile.build:254: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
> 
> [...]

Here is the summary with links:
  - ethernet: octeontx2: avoid linking objects into multiple modules
    https://git.kernel.org/netdev/net-next/c/727c94c9539a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



