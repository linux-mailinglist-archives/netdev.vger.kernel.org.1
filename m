Return-Path: <netdev+bounces-24614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E5770D12
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8DC28279D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22291FA8;
	Sat,  5 Aug 2023 01:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A915AE
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EF49C433B6;
	Sat,  5 Aug 2023 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691199024;
	bh=XF0d6nqQFz/aBE/jSeAghsuJeCG17PUR8q8QOst62vY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sP+8UgSjDAtF3i7wBbTcVQ7GXhDhuP9TzOB7jABNkP9oBA93CzmNcciXUy/M81ONg
	 3w+vU1ZBekI97zHcOGM6hZJnAgmkGQBmngoQ5QC9LjGjlyDBFyC35/x2YhvShRueNf
	 enUK9QScaYlcKC0gKB06WgdRGkDfSvmC6vyGyf7Tb+Qx32hJE3+fUARBbG+DKxGKug
	 bffO+BIt5Q3joSXO8A++pBQ1XFlsnoLvfSPgSy8NwGjXvPw8Fxdc09dlsQ9B5Ea2lH
	 981w96x135ZJrEe8taTkdGroLciw8tN0x8jYqav77v+SFLVVjinb6xvfIfyG0kcFvH
	 nfyzqOxOgf1PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 181CBC595C3;
	Sat,  5 Aug 2023 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: move marking PHY on SFP module into
 SFP code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119902409.19124.4276860432667821030.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:30:24 +0000
References: <E1qRaga-001vKt-8X@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qRaga-001vKt-8X@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, frank-w@public-files.de,
 davem@davemloft.net, edumazet@google.com, ericwouds@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 03 Aug 2023 16:56:24 +0100 you wrote:
> Move marking the PHY as being on a SFP module into the SFP code between
> getting the PHY device (and thus initialising the phy_device structure)
> and registering the discovered device.
> 
> This means that PHY drivers can use phy_on_sfp() in their match and
> get_features methods.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: move marking PHY on SFP module into SFP code
    https://git.kernel.org/netdev/net-next/c/f4bf467883f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



