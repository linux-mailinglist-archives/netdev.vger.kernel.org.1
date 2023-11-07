Return-Path: <netdev+bounces-46315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D795F7E329D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 02:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D7B20AE5
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D1F186C;
	Tue,  7 Nov 2023 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAK539jz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B41FBC
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 01:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1B0FC433CA;
	Tue,  7 Nov 2023 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699320626;
	bh=H4pDQxWkp5teIpIYzScbH/jaYUOZ2Xl1aSkT9O3wTz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eAK539jz26ECR1uWw+2Rg/LRgr/LXUV8lUAH6MMe89CsnmZeWkWI7vAj0ZDozaT4v
	 eLBFDPUq1OLe5r9jB5HVLvUJcv37g6uCvFUf5bbTQ2Wf87lXnrPzjkbvjQBJwO0NHa
	 cak3Ufl6xmbI7Hd1zbJrad2A11G9uT6wAHbh2nEcoL9yi2F4i4pqNdwfchRY5Mi4Oo
	 CvpX1QhxYXkebI6Uk7DE2I7bfOu08HGj/BUTHaCqpja2eaSVVdTeKPKvVkwKuf8zr9
	 fbXk39PP4l/wZYlNuUXWfPxCWlxpvM3ykoL2FSxO7TAEghCiM1svwdkft3I/0A8v7s
	 BZmPyM1CD7Rig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFD64E00095;
	Tue,  7 Nov 2023 01:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tg3: power down device only on SYSTEM_POWER_OFF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169932062584.409.5464148023088638222.git-patchwork-notify@kernel.org>
Date: Tue, 07 Nov 2023 01:30:25 +0000
References: <20231103115029.83273-1-george.shuklin@gmail.com>
In-Reply-To: <20231103115029.83273-1-george.shuklin@gmail.com>
To: George Shuklin <george.shuklin@gmail.com>
Cc: netdev@vger.kernel.org, kai.heng.feng@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Nov 2023 13:50:29 +0200 you wrote:
> Dell R650xs servers hangs on reboot if tg3 driver calls
> tg3_power_down.
> 
> This happens only if network adapters (BCM5720 for R650xs) were
> initialized using SNP (e.g. by booting ipxe.efi).
> 
> The actual problem is on Dell side, but this fix allows servers
> to come back alive after reboot.
> 
> [...]

Here is the summary with links:
  - [v2] tg3: power down device only on SYSTEM_POWER_OFF
    https://git.kernel.org/netdev/net/c/9fc3bc764334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



