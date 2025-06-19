Return-Path: <netdev+bounces-199613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB5AE0FB8
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F5817DB3E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD328DF0F;
	Thu, 19 Jun 2025 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOPkelJ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44828DB53;
	Thu, 19 Jun 2025 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373393; cv=none; b=UBaxYbSSQ1MCC46r91Qew/BqU4ORUP/4c98At5GKQ8XtgekdGhzO3/ENeliPPlJrKtlggEEcHSZKHJ0Dl/NZPi/V78GW9R520oEbg1BshsEtQ3tEf+eWp7EpgyQpf+fyNYCuqpKi1pdXFBt7KKc/CWWHewhh9PnIw2BzMUZRXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373393; c=relaxed/simple;
	bh=kqhaov+O4vdMOPoApugRrrxkIyXQeyou5roEoq+LvPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLlqypvPUTPRgTGZnQS8LHNtVAUDRZMySQEFM52ihnTgPZ4WTi+8pEc5+J5++QWSs2Re3qLcD3IPYkcdMMB9wxb8IgHBra/DCwk+WedVN7nhcl/HAsQpvJFrmWHcNExwaH9MRdivls/P68x+uxHjmrA8KOwoGXl84PscdoBRkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOPkelJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A14C4CEEA;
	Thu, 19 Jun 2025 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750373393;
	bh=kqhaov+O4vdMOPoApugRrrxkIyXQeyou5roEoq+LvPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AOPkelJ3nqBIZRmKbU5CgeeHhtOfHe4YP+hg7BXxGNJiIbzTM9vXn3jhVCgaVY8+3
	 BJ6NEP/RPhrVffvzFBHSC152m5gboW423VNA3xlnGEw2gkZuP63DVBV7HySSQW5M4Z
	 zT5V3pdRr3GHJM9bUbYT6MIiVraBVCooQgiFWEP3Dx/R6kpJkRcJ45r2MbpE1fzwnf
	 g82kZVFHlItK7cHKKxQ4Q29m137QxFXLRt8T2Qz+i/TEymUTpn+ytEwS8TC7awIgnG
	 5heEMViRKQNeGNvbgkZ/90uO0OdnXqBn5zObJqh0ZEbB69sjttMvW6BUoLfAXf1lQe
	 WT0Y/4SBzKyaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E6E38111DD;
	Thu, 19 Jun 2025 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] net: usb: Convert tasklet API to new bottom half
 workqueue
 mechanism
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037342124.1010622.12736703136854141830.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 22:50:21 +0000
References: <20250618173923.950510-1-jun.miao@intel.com>
In-Reply-To: <20250618173923.950510-1-jun.miao@intel.com>
To: Jun Miao <jun.miao@intel.com>
Cc: sbhatta@marvell.com, kuba@kernel.org, oneukum@suse.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, qiang.zhang@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 13:39:23 -0400 you wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the usbnet driver. This transition ensures compatibility
> with the latest design and enhances performance.
> 
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> 
> [...]

Here is the summary with links:
  - [v6] net: usb: Convert tasklet API to new bottom half workqueue mechanism
    https://git.kernel.org/netdev/net-next/c/2c04d279e857

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



