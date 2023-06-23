Return-Path: <netdev+bounces-13250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650D73AED8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B746C1C20DD2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1147438A;
	Fri, 23 Jun 2023 03:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86917F7
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 557DBC433C9;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687489222;
	bh=o4vaiix31FGXLHehkhTx3OLu9WuRT75FIaWxmy6Kuow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i1zC6zZuUxAS7w6RwO5Xe+yiXCC4OlIxXjqPy82BmWiQfkPNt+aSJVE9BqmtvqfFm
	 iXToBOzG3sQcWMTvqzmW70xp8/+IfLyqgUu6LqSJtR7EGG4tVqiDl4whTw5ImAffdj
	 014on6tLxpTplBZq1caLG7fZFHEmByssiDz1RtVVAkdh3FXKG63FJZHyi0gPByIfd5
	 KArqlGX3V8nB97oAxlKR3mmeAjF+oeTpG6BhORlnbqKun5PdOP4ARO5Dww5ljvfuaD
	 cTquQFJub7At86Ps+DuwaXuBehskquinnFq/kfqpJznI73X9mB3ClI0la8LBzscqSz
	 Oj09YKl8Zn+Mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 336B6C395F1;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] docs: ABI: sysfs-class-led-trigger-netdev: add new
 modes and entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748922220.4682.2842456110616074957.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:00:22 +0000
References: <20230621092653.23172-1-ansuelsmth@gmail.com>
In-Reply-To: <20230621092653.23172-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, lee@kernel.org, linux-leds@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 11:26:53 +0200 you wrote:
> Document newly introduced modes and entry for the LED netdev trigger.
> 
> Add documentation for new modes:
> - link_10
> - link_100
> - link_1000
> - half_duplex
> - full_duplex
> 
> [...]

Here is the summary with links:
  - [net-next] docs: ABI: sysfs-class-led-trigger-netdev: add new modes and entry
    https://git.kernel.org/netdev/net-next/c/2ffb8d02a9b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



