Return-Path: <netdev+bounces-47079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F717E7B92
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FCB1F209A7
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE409134C4;
	Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OowxffQf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC612B75
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EF4CC433C7;
	Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699614024;
	bh=5al1T1jdDu+2lAGbHeFM/Y4l/1eJyWvVGIt5NoilUG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OowxffQfbiB/ixXfRru7AMA7och/GvMwqYBHuWWYSmNUdT7f1Z1XlD4zXC8MrEDSl
	 WRQyi0XDZ/FFMqf667ZCLzIGLyH3GqNLqYiPoZSwAx1PJV3MC6wBPstAAY84Mv6qDh
	 3EUvVinlUVdJ+qeJhgrLMwmb64IJoGguh/sddQ1AR551axmbRKnBebtj3XpiliLTQ2
	 /K9ZQxj5kaTeC2MkcYrsS5Zy5HxemwVu38yLqNBux6UlUrRziyeSkHYVtSkWK//bwb
	 PdydxFO5f++VEwFGJgLn2qRIfMUM14CyqtElmAKIacuYMOwlMjg+bAxswCBkZ6VfKo
	 lhRynBQAMhIFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29593C43158;
	Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169961402416.16509.13586966017660246315.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 11:00:24 +0000
References: <20231110092749.3618-1-r-gunasekaran@ti.com>
In-Reply-To: <20231110092749.3618-1-r-gunasekaran@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, s-vadapalli@ti.com, nm@ti.com, srk@ti.com,
 rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 14:57:49 +0530 you wrote:
> Grygorii is no longer associated with TI and messages addressed to
> him bounce.
> 
> Add Siddharth, Roger and myself as reviewers.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: net: Update reviewers for TI's Ethernet drivers
    https://git.kernel.org/netdev/net/c/cbe9e68e1e0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



