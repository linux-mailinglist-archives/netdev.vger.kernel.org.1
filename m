Return-Path: <netdev+bounces-134035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC2997B1D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BB41F24D71
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0F18950A;
	Thu, 10 Oct 2024 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHO5MKUU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26257188A08
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529834; cv=none; b=tIvjDk2xJZvhjEeJlNGkD+Ugx+XYEa9xMGl81km7+ozZNP4XVEWeY2Os81L6v0OEhl/jpxLzbDMABuuFIB31KUzJrL2zy28L5eGjL6rcrsm+aA0PsiI02nuishX+9li9RBAj/S47N9a7XpnQzgXL1YKQPDZx25GnY4CxbuSHvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529834; c=relaxed/simple;
	bh=ym8yB+PbaebpTgYe3nohQPLvaltrg8hXm+sQ3CESbgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s7URVBjAxxXm/PBS9V6DCvQsYFQQ+PrU8+VwALwE3YZJZcrGS3aKqBg2SQZOsMz4IQoSeSliDUwU2oQI5c3suGblkpfAUeorZa4I9DYUz8dHSqT9QfZZjmSYMaioJbJDFYqSGy38bw9u40FgMjJG2ZpBtAAAcWlfDQ3vuV9XLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHO5MKUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B9FC4CEC3;
	Thu, 10 Oct 2024 03:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529833;
	bh=ym8yB+PbaebpTgYe3nohQPLvaltrg8hXm+sQ3CESbgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bHO5MKUUdcUEkuYAzlzzYiiusxd+CuEv5xE6eZ8l/PMljI7RxUY0yrNVG1eXV3DbM
	 l2NIRfN6hAQDon2iMWTpf/8KJBhxWpsD1qBxnEd/mJWwXPp/scgFBIJsbe/VO3yUHt
	 yRwXufrRzhuAEO0PslGUXzNIAHZOHh2QuVIBoelWdwG81Ais9SyWDrNhTKFYkMSCTB
	 +xOaTJmKxBUBVukCSE2poiISqzi7KG5cgRGXFaGB8yKWZIbXAXPoyCns/nhJi6svMY
	 DGV9ZMbhia8MyZv000VJPMBvwqbeBdgjE3y3xfX1cL+HObLh6VUnarBqIX5IlSML0N
	 gYbJtf5RtniDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B573806644;
	Thu, 10 Oct 2024 03:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12][pull request] Intel Wired LAN Driver Updates
 2024-10-08 (ice, iavf, igb, e1000e, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852983773.1551072.1843645309200205281.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 03:10:37 +0000
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  8 Oct 2024 16:34:26 -0700 you wrote:
> This series contains updates to ice, iavf, igb, e1000e, and e1000
> drivers.
> 
> For ice:
> 
> Wojciech adds support for ethtool reset.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] ice: Implement ethtool reset support
    https://git.kernel.org/netdev/net-next/c/b699c81af068
  - [net-next,02/12] ice: add E830 HW VF mailbox message limit support
    https://git.kernel.org/netdev/net-next/c/59f4d59b25ae
  - [net-next,03/12] ice: consistently use q_idx in ice_vc_cfg_qs_msg()
    https://git.kernel.org/netdev/net-next/c/a884c304e18a
  - [net-next,04/12] ice: store max_frame and rx_buf_len only in ice_rx_ring
    https://git.kernel.org/netdev/net-next/c/7e61c89c6065
  - [net-next,05/12] ice: Make use of assign_bit() API
    https://git.kernel.org/netdev/net-next/c/8d873ccd8a07
  - [net-next,06/12] ice: Use common error handling code in two functions
    https://git.kernel.org/netdev/net-next/c/5f4493f06e81
  - [net-next,07/12] ice: Cleanup unused declarations
    https://git.kernel.org/netdev/net-next/c/ac532f4f4251
  - [net-next,08/12] iavf: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/cb31d19a0292
  - [net-next,09/12] igb: Cleanup unused declarations
    https://git.kernel.org/netdev/net-next/c/c3c50d4c62a2
  - [net-next,10/12] e1000e: Remove duplicated writel() in e1000_configure_tx/rx()
    https://git.kernel.org/netdev/net-next/c/0cab3b0f8306
  - [net-next,11/12] e1000e: Link NAPI instances to queues and IRQs
    https://git.kernel.org/netdev/net-next/c/c6b8cd699128
  - [net-next,12/12] e1000: Link NAPI instances to queues and IRQs
    https://git.kernel.org/netdev/net-next/c/8f7ff18a5ec7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



