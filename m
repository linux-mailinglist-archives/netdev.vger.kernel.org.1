Return-Path: <netdev+bounces-60917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA07821D8B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903541C22252
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3AC111A5;
	Tue,  2 Jan 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8/mEMfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF810A14
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8E46C433CC;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704205225;
	bh=APWJIS7LuHb1VbnKTAq5lcT7cUpNn8U92ZBHiHaPNmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e8/mEMfiMoU6We88640+qQYUcRy8suLASozw4Al0jQHwkVuG5xJRmP1/aSDoHiDP8
	 ygokYE5MmXwthGAaJqYHqHT5wGNu5mrQ7HwFLnhXqriM0iY4prbb2vLA9I0CvXqd3Q
	 yewISKIRX1ijBOpIsuS6F4pTIQTSNpkipmoQulg9BwDCDqN5cbGqHrg/335YGjNdoQ
	 iFTn3NIzpVy/tC1L6Rk7XO4nE163hfL8UW76NkRc9hqyvMX2HfgOaSpSUfkGu7OPxZ
	 a90N+VmBUmuDT4CKNqT8Xr5nN360BzXoSmTXgnQ22RVdwDPM2BtmtO3WGjfkONga7w
	 wextRqsareqbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B45B4C395C5;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net/ps3_gelic_net: Add gelic_descr structures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420522573.14312.6915625426262054321.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 14:20:25 +0000
References: <2e4bd247-e217-47a6-a7e3-20375d05ff25@infradead.org>
In-Reply-To: <2e4bd247-e217-47a6-a7e3-20375d05ff25@infradead.org>
To: Geoff Levand <geoff@infradead.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 23 Dec 2023 16:28:20 +0900 you wrote:
> In an effort to make the PS3 gelic driver easier to maintain, create two
> new structures, struct gelic_hw_regs and struct gelic_chain_link, and
> replace the corresponding members of struct gelic_descr with the new
> structures.
> 
> The new struct gelic_hw_regs holds the register variables used by the
> gelic hardware device.  The new struct gelic_chain_link holds variables
> used to manage the driver's linked list of gelic descr structures.
> 
> [...]

Here is the summary with links:
  - [v1] net/ps3_gelic_net: Add gelic_descr structures
    https://git.kernel.org/netdev/net-next/c/3ce4f9c3fbb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



