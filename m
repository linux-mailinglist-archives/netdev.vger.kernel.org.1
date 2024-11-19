Return-Path: <netdev+bounces-146069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C09D1E6A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977392821F4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395938FA3;
	Tue, 19 Nov 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyPwiOH4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36933F7
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984631; cv=none; b=BcZuepH0TYSXENE/pQ5PqZ7mM04p5L5s+1gJhdKNWmcde+UsWeUzT3pTjBjgfIO/FXe5UM+u6mz1sdWFU3ZqTg2I8QqQToSJjwOavyWXnRx1fyPjuKduZbaVkkrPA4z7J82vP/+5SH6EaBZvNxeJgoKwaIJ9TQhSIOyg/vKnAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984631; c=relaxed/simple;
	bh=Ha7SmjzU6kR5PF91UXf7/vsCWz9jCADUb7sKYfiQKOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKMcJVQ1BrS56NerGtoVz6WANnkMm2hI7U7W/n3iAP9UpbnBOF4B10DU0v7a/WRPOhJhdkBKzl1zu4wxZxPGG5XNkE9erjyZ0JgV4TqaspGdK0ROSbwAlYW4PNR7f45+jftYSWkLxEEeE6myRVhvHvWsTptqocOvQJU5K9nrodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyPwiOH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89230C4CECC;
	Tue, 19 Nov 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731984631;
	bh=Ha7SmjzU6kR5PF91UXf7/vsCWz9jCADUb7sKYfiQKOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iyPwiOH4DwAjUgaW0/QsMig8E5CmdC1IOhb16uDY9SB+WqGhYSKeWMeHo3JSVLIl2
	 xqtFGYKmxvII4BqSnJMJ03MHO7iKoe+cjmw6oCLLsfJiPrSaWlGkZaW/L+SSH6knwD
	 j1FQTg2LycmbBif2FcI+oWI9l6A9CfZkomFfBEFEw5rcnNLUi8DWTfvHNuS9ycsqNr
	 rUv5skuBLxqS6W0A2guirjx3ngg/yk+e6bRc/rQ5JFGIWEmNP9WRBKnDtUyTNGC/y5
	 ZAxLcHSvUjksmlzABrAYJBI6Afd7MXMB7Qxxkd6uBtwFRinElJMVqVXCc+KhqLnbV/
	 2CQymSQGBNqVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAF3809A80;
	Tue, 19 Nov 2024 02:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change
 PM_AUTOSUSPEND_MS to 5000
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198464299.82509.13521106386231402848.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 02:50:42 +0000
References: <20241114102002.481081-1-wojackbb@gmail.com>
In-Reply-To: <20241114102002.481081-1-wojackbb@gmail.com>
To: =?utf-8?b?5ZCz6YC86YC8IDx3b2phY2tiYkBnbWFpbC5jb20+?=@codeaurora.org
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 18:20:02 +0800 you wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Because optimizing the power consumption of t7XX,
> change auto suspend time to 5000.
> 
> The Tests uses a script to loop through the power_state
> of t7XX.
> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,net-next,v2] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
    https://git.kernel.org/netdev/net-next/c/a0c80d5108ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



