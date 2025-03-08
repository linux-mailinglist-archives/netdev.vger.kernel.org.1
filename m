Return-Path: <netdev+bounces-173143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24923A57815
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5594E16EA9E
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79C17A306;
	Sat,  8 Mar 2025 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfL4VVEE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BEE182CD;
	Sat,  8 Mar 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405804; cv=none; b=WTGR8Rj7qxA9SESV2EfXReAdaKQlQjuZTl2loFi3Oj/PcAJVLXWq2N6mzSbPWK1IkG7QKbPvhnI1MwlQ+1gF1055Nudh3JZf/jhs5g9L95EULRfpo4mwK9N42UUMgvp2ib5WziF/8uye6KFsKz51DCwp01n9Sa4+qW0oz39BoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405804; c=relaxed/simple;
	bh=EpIWs+rSWHdG6XRUVJzl1QYMYMZZDU3itzGxtLtT0n4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ufgxc66tXoI19MiEPQJUVE5jA5JJ1I5pJhI95hT7TtE5ZOAy/T4HjlOESlGweLLow8gYHoopiGsjEQgTPy9ayGEU8HNTZf4Pir5PqM851AlmZDHuha9mxB0dWUFB9Q5gtnwoAwFIr+BlV3X8y2xsaKccUrXEFoea7tdU2wa8FQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfL4VVEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CE8C4CEE0;
	Sat,  8 Mar 2025 03:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405803;
	bh=EpIWs+rSWHdG6XRUVJzl1QYMYMZZDU3itzGxtLtT0n4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WfL4VVEE+e4UzPcTle8X4v3rC9c4LZayg8BdFP9RzRz9uryPYWq2/w8YKJLYUbAIF
	 aXnJILkVgMVhlk1QW2UtbCtqaOW7H/7JtKN5kwS5QxmSky0s3Vrddn1K1zo1U1I6UR
	 ZDM3UTfibmAT/qOo1LO2YdD2y170BiGgZ2VxtMZeV+kbhfKcfr5e1odRImF6ECCSJp
	 EhmkNN1PtH+Z93my8WNrlARvN+0pkFtWAUl16aRf5JfNNgzMJjEUKa0YYVlaEGJE+3
	 QCRAuWciCW6CNl2/4XeKJXpYU7f1wInvkINh03loMfbG4WZ2nCSlNunzMZF2f1R0Zq
	 ORUDW78WLGlYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F84380CFFB;
	Sat,  8 Mar 2025 03:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 1/1] net: dsa: mv88e6xxx: Verify after ATU Load ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140583674.2568613.16273319782055135359.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:36 +0000
References: <20250306172306.3859214-1-Joseph.Huang@garmin.com>
In-Reply-To: <20250306172306.3859214-1-Joseph.Huang@garmin.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, joseph.huang.2024@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@roeck-us.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Mar 2025 12:23:05 -0500 you wrote:
> ATU Load operations could fail silently if there's not enough space
> on the device to hold the new entry. When this happens, the symptom
> depends on the unknown flood settings. If unknown multicast flood is
> disabled, the multicast packets are dropped when the ATU table is
> full. If unknown multicast flood is enabled, the multicast packets
> will be flooded to all ports. Either way, IGMP snooping is broken
> when the ATU Load operation fails silently.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/1] net: dsa: mv88e6xxx: Verify after ATU Load ops
    https://git.kernel.org/netdev/net/c/dc5340c3133a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



