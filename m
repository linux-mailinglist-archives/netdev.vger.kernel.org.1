Return-Path: <netdev+bounces-200408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B313AE4E0D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779033B5CD9
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6BB2D4B57;
	Mon, 23 Jun 2025 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptEy5oFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756962D12F4;
	Mon, 23 Jun 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709981; cv=none; b=PpilK95NF6w83OIEu67xOpM6V9QcaPDWNUO5eI0BT8usitVwYIVdjnCmWn4Za8+CCRh1pREVne/ZixEyKaJQEAU6PH6dPFajHEXnbR+QRBfspaQryUX6ue15iXKmBhOj8Cui7oAQQR+76DGbdZjTWmXy6GEVDpTIV7RjUfEghZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709981; c=relaxed/simple;
	bh=9+JDx6QWgUTXG1BF4D42+O53MQeLmJgUcCobkGA3twU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lfITfs/BmHHob+p+ITQEgTSVveC1hUUDqTFJcYH2S9VrfHPeSbkdsdE6YHklXEydlUZs1FPXioNcyrVQGVaSXDkMdRY6fuYafbr46DIpaock/xysGUYsfmW49QUbNz8fX9P3JzmW+ms/VNa/Z5PZCLvwSNzKst/+uNdj5PIcXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptEy5oFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4136AC4CEED;
	Mon, 23 Jun 2025 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750709979;
	bh=9+JDx6QWgUTXG1BF4D42+O53MQeLmJgUcCobkGA3twU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ptEy5oFSod82IjZBf8NDr6qTAxQq8KnBa+jgiyPwf3mE0J1MT2K2YJ6GGtCz2wz/Q
	 CWuOaiYiszTI6SzVIm+FzteMNSW41fT3QF8chG70KFT1MaNigwCGhq81m3eA4ErLds
	 73FSrQ8OoUSQ0GTCpfK0hvWYN0AfkK0r5wXS2n1TrW0Z8vP0NI/sQixCCMDdJHrjht
	 AfcMVkwaI7GNWJXanym0+3ltOiY3gOZ59WwK+okPW9uUKAVWq0vp4quWVrArAbbn95
	 nLNPhnr981WO1GxIrNm2iofxZfX++MXFdMHUXgfZZ2XlaNENSP3V2xSnQ2CVP4zHqR
	 gB9d5r9H0Yg/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D239FEB7E;
	Mon, 23 Jun 2025 20:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: pse-pd: Add missing linux/export.h
 include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175071000625.3285687.12745921546977020249.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 20:20:06 +0000
References: <20250619162547.1989468-1-kory.maincent@bootlin.com>
In-Reply-To: <20250619162547.1989468-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de, andrew@lunn.ch,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 18:25:47 +0200 you wrote:
> Fix missing linux/export.h header include in net/ethtool/pse-pd.c to resolve
> build warning reported by the kernel test robot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506200024.T3O0FWeR-lkp@intel.com/
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: pse-pd: Add missing linux/export.h include
    https://git.kernel.org/netdev/net-next/c/96c16c59b705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



