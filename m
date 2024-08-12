Return-Path: <netdev+bounces-117633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97494EA44
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9979D1F22483
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D295516E86E;
	Mon, 12 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBH/2iao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA31C3E;
	Mon, 12 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456229; cv=none; b=ubcixqUyMtWfL9qJKath+bxqxj8zBRwGiXhfdqVZ7XcXEdloDiDxmVPrfxw5i+lqcol+9ARxSwZYDkSom4HeIbfGasEVK6o5IuCYjc+wmcWosJ2qQKQ4S9xj7TN2/iMxiwhkDSMySwrTBm1joKRUu/MH3Gs7oJc85fGDpsrLqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456229; c=relaxed/simple;
	bh=MYBtALNqE1+wtCiCgWVaHfF+79nSGs92HIGmmIMgdsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q097ukfuLpRxv4vXBE30ulAf4g4ENXJSl4YEvRR7ojrYMDN5pRDuZ531ajGIsSiUeY6C1G7JFaz1JNwnvX757FCiOvAViHkTVm7UZwJ7c6dfryva/n6WDcKyw3tU2cXh+kH1jtSYvuAk7t6VRYno4/xycvD8QEd5aA2bjg8N92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBH/2iao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7638EC32782;
	Mon, 12 Aug 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723456229;
	bh=MYBtALNqE1+wtCiCgWVaHfF+79nSGs92HIGmmIMgdsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dBH/2iaoLQs8571mOYBnm/TUPVLkQ/LRwrXL+xbj+UCxms9782o6RXvSjqdPnSOVg
	 9HR5mVU2N4oMP5R8fGKgIYsBKWMkBAjNyjIn87cpGTOON1hQHplpIlhNj4Om9RAY2U
	 67CYyHaDUSN57VQjavQyxwZFqHBhM4jmiqP800d0J03NzP+uI4yjxVUrjhKUmrTWMz
	 Gj+GCS47j9PMbgREZPbVGDAgl5MKK8zOwQspYOKep53XMBxIXtln+voyhf/BkNLa9L
	 Vv5sJX+dRODukotJiFWRNy1PC9O3TalvDbzRZ0eigecOiSSSFoJxV4dYML99anJfI5
	 8yVsEkt2cVXLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF39E382332D;
	Mon, 12 Aug 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: axienet: Fix register defines comment description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172345622824.970779.7153126498272358936.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 09:50:28 +0000
References: <1723184769-3558498-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1723184769-3558498-1-git-send-email-radhey.shyam.pandey@amd.com>
To: Pandey@codeaurora.org, Radhey Shyam <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, ariane.keller@tik.ee.ethz.ch,
 daniel@iogearbox.net, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 9 Aug 2024 11:56:09 +0530 you wrote:
> In axiethernet header fix register defines comment description to be
> inline with IP documentation. It updates MAC configuration register,
> MDIO configuration register and frame filter control description.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: axienet: Fix register defines comment description
    https://git.kernel.org/netdev/net/c/9ff2f816e2aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



