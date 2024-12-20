Return-Path: <netdev+bounces-153546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533209F8A0E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69D9168BDB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337A2594A6;
	Fri, 20 Dec 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxpvlgio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF98134AC
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734661216; cv=none; b=CXDICVI3uZj9v6339F6Tqy9plyQpMvOFK1GBrqIewAx3RNDx1sasa5MMruOVfIS+VBLGL0ls0t1xKnTTAcwM1dwQhztnN5ApyfFBTNGWkcfsNtwQRiUx2q1MiXzNYhdQW7aTn0PwQ/zEUdkfNUhS/pX0EYg+RnQKbcXc+PTbJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734661216; c=relaxed/simple;
	bh=Jm4yH61p6WpzRw+yd1AOynvdwjr6OhEHJetgOxlmmrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qp+8PjJhxMcvmG0g7/5WmxLVOma6iiiKjFo1Mt6e06TQvBr3BNBtsJs9JFzW4kUZvv29YT0hNcCG31uF7a7K8uQ++n4qYir3T9IblIFSOmk1QzG/GfNEwpqnZjpWrM/oOvrO7HA4zCwmc6NnneGNuuLm1l8UigUy4WgHc8nDySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxpvlgio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4BAC4CECE;
	Fri, 20 Dec 2024 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734661216;
	bh=Jm4yH61p6WpzRw+yd1AOynvdwjr6OhEHJetgOxlmmrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZxpvlgiovtB6VT8/vfIa8DFIJG7FneXYF0bGkbJj1OoX+43sbD5QOxvdWStLkIQk6
	 6WmZwcd7RJq0UN+us2Z+eGD9BVQqJxu815Z/MTpQghM/FgM3iQMb0nmnvJDuMc2jeY
	 sezG+6QWKT8t24+QhpxKtBo5bIYNceKFMICbBw8X3ynzVSNbeeSOPr04ttB2hOs3Lv
	 RuRsWq4o1yrK0dc616zoAiPQPHMxQ/M2eHrJU13eyM3yoCaNkBmkwNcyK2SiWD28fA
	 7h5rGhMyK8d39WksQJRw2DWjGv7vM2HHTUrHJlhLSLMOL+vUGurZVRuN+kffETywmc
	 xnI7VisdYSlGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C943806656;
	Fri, 20 Dec 2024 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] bnxt_en: Driver update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466123400.2451213.11923692821302195238.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 02:20:34 +0000
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
In-Reply-To: <20241217182620.2454075-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 10:26:14 -0800 you wrote:
> The first patch configures context memory for RoCE resources based
> on FW limits.  The next 4 patches restrict certain ethtool
> operations when they are not supported.  The last patch adds Pavan
> Chebbi as co-maintainer of the driver.
> 
> v2: Use extack in patch 2
>     Fix uninitialized variable in patch 2
>     Use void function in patch 4
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] bnxt_en: Use FW defined resource limits for RoCE
    https://git.kernel.org/netdev/net-next/c/b1b66ae094cd
  - [net-next,v2,2/6] bnxt_en: Do not allow ethtool -m on an untrusted VF
    https://git.kernel.org/netdev/net-next/c/fac5472fc845
  - [net-next,v2,3/6] bnxt_en: Skip PHY loopback ethtool selftest if unsupported by FW
    https://git.kernel.org/netdev/net-next/c/36d1e70a90e9
  - [net-next,v2,4/6] bnxt_en: Skip MAC loopback selftest if it is unsupported by FW
    https://git.kernel.org/netdev/net-next/c/b45a850585ca
  - [net-next,v2,5/6] bnxt_en: Skip reading PXP registers during ethtool -d if unsupported
    https://git.kernel.org/netdev/net-next/c/bf2afe0f1493
  - [net-next,v2,6/6] MAINTAINERS: bnxt_en: Add Pavan Chebbi as co-maintainer
    https://git.kernel.org/netdev/net-next/c/73df38b097a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



