Return-Path: <netdev+bounces-198594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C0ADCD15
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CFD18898E3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6628C5A4;
	Tue, 17 Jun 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSWSeLSJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE892E717B;
	Tue, 17 Jun 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166401; cv=none; b=Nw4jsjTt+1Mi5V7R+kRL2FAAquBSWgckw6/pXTwzGxslznlHBFWu4cQCgNPvwFf8rSQugoQlFkiQO4oUjrO6qfmGg8BvVJreoUueDnwQGFFjgn0/MyUiqa9aTITAO6VgZ3C3gcdGiPF0giQRRscGxiSA2mB4GmFuUKXPRBx+g8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166401; c=relaxed/simple;
	bh=rT+q1cuJk4X808ltKP0mkhT3jOCWnDD6rLSYm7eJiSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j6njA9hPTqDfuwQDUToL5tFoOjw/5UFOkxgjxDWIGwjmm7qxS47mUEC5AwkfRreXwfAYKCL/sNh+qmZDRBZMXF3+ghhgAnpOVo2ZMtmbNF54a+0ISbYOGwEqU8QsEC6VOgVIEcpWbRUvZG7SMnscrTn7NOsJ0+uAP60MO+L3uZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSWSeLSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AAAC4CEE3;
	Tue, 17 Jun 2025 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750166401;
	bh=rT+q1cuJk4X808ltKP0mkhT3jOCWnDD6rLSYm7eJiSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OSWSeLSJ6MXSVQhDACyJSWXbm0jojPUBCKBQR149UO1tEgpfAM2kRGgx0dwZeJz2D
	 3IqjELK5sY6fK6ZPiRamigQDDhtW0Lczth9VK4E8vfwGCSOh4rV7wr1DaErBPtUpYj
	 gUXn4kZyrCYiYR5MDR5HbzpksmN+KGsNScuxPifEpgQJ3tvms+jvD/JvykAB3u+pJL
	 PhI/TysnqJq8COWLyDCFPap0d98nxzivib/5zohS/s1hB/60yDzNMPqtxY7yZgHGQ0
	 OupkFIyU41Z0r6eTpKYxHG8DllzpJEVRCjVg1sEjj4slZoGHjgAkRvtJUPwnyek6aW
	 uYd8YSjGtr6Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF25380DBF0;
	Tue, 17 Jun 2025 13:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: Add c45_phy_ids sysfs directory
 entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175016642975.3127577.11877299160287159944.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 13:20:29 +0000
References: <20250613131903.2961-1-yajun.deng@linux.dev>
In-Reply-To: <20250613131903.2961-1-yajun.deng@linux.dev>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Jun 2025 21:19:03 +0800 you wrote:
> The phy_id field only shows the PHY ID of the C22 device, and the C45
> device did not store its PHY ID in this field.
> 
> Add a new phy_mmd_group, and export the mmd<n>_device_id for the C45
> device. These files are invisible to the C22 device.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: Add c45_phy_ids sysfs directory entry
    https://git.kernel.org/netdev/net-next/c/170e4e3944aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



