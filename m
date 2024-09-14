Return-Path: <netdev+bounces-128276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AC978D09
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB94285C06
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E3179A8;
	Sat, 14 Sep 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiO15BHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9161FFC;
	Sat, 14 Sep 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283439; cv=none; b=hlep2BgmwdxZua2FCgH/WRgIpcixHKq2Gki/N9IVvm5+FOftz9agN3kEyXg0jxPdJ5qgjbVedcI/z80yW3McLBsPvN+q3+Ow7SPqgJrdvL1OuG9/CCf61BhOp8rqp/9PFY5S7kSlktRiFImlCfmoERqS/5SoDn2+eJcb3bXJqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283439; c=relaxed/simple;
	bh=eHQ44i+Gni5WUzeMWQtDPB/p0hd0eqry3TWWbC9OSuo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pNSjSUulHp61IMDnfHyvFcR7TwVwkMewqZ0IdN4udRDchbrxA34f6t1p0gg7MTofRfjQw12nQmEuerBhxSX2yUjN+gExf7erWMyA+HxaBrHMuy4QB6U2CPxlcIPAiuvU9G1g8M+QAZJvyB+dNtzhL2BXISPBDeVJyGB9XthAphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiO15BHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6735FC4CEC0;
	Sat, 14 Sep 2024 03:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726283439;
	bh=eHQ44i+Gni5WUzeMWQtDPB/p0hd0eqry3TWWbC9OSuo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DiO15BHr7NLh5UFNaPTGOp70irNBf6EsVwwnArDtvmJtfgE7VT5sX83Y9PnhKJIRr
	 hKfSnxiyKlqkvWFOvzJjOjiEWPVEIIfHHvQqk7tBhnjb3SLSROHpwQ2X06Do9xT+I9
	 GnMjY+vk/kJTiamvjvYZEwpPksrqT5M3wBCTrimmXvKcnUYjbtZejOs/YxuTssx6qi
	 ZqV9Qs3G6QHiQUm+2JJazxW/EHavrsU6qsmX/7FjNxiflSw/TlyqgFKySKsMFS3k1S
	 pefdGZ0mVnTawIqY1hHSt2fdiRA1hDx7XlBueQBLVuAa0ZaAoSuSlmrn5g57HyBoN6
	 LTeVbBoMoW1fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1D73806655;
	Sat, 14 Sep 2024 03:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: enetc: Replace ifdef with IS_ENABLED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628344049.2438539.12184710803069184190.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:10:40 +0000
References: <20240912173742.484549-1-martyn.welch@collabora.com>
In-Reply-To: <20240912173742.484549-1-martyn.welch@collabora.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@collabora.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 18:37:40 +0100 you wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is built-in but fails if the driver is available as a
> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module and follows the kernel's coding style.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: enetc: Replace ifdef with IS_ENABLED
    https://git.kernel.org/netdev/net-next/c/9c699a8f3b27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



