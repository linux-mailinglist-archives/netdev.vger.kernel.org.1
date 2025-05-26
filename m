Return-Path: <netdev+bounces-193466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D0AC4247
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E6D188FADD
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2889E213E61;
	Mon, 26 May 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2cbTdHv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A82110E
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748273407; cv=none; b=EjvYjTRJTtX9IUULKh7PY92m8nr1o3hX/ZdnFcm8GadDdxP4qPqLN7YSUdnmoLeNZ58bcy69gK+pfwMjtZy7wlYZBSs9YRTlR27gpJOzwJm1lwgCgqFGpBhEGj1DYEuSxXHXVTuX/qiUiNX/YSfvDgycsYnbK02cSuDxmV6wpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748273407; c=relaxed/simple;
	bh=BBzNsVtJakp6Yv3+F2M/dc9GLSAu0OF+M+35ZrpszIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aVn+fmO5Pru0m5jZkQ96ob74IsOpH6J15msyyr+vQth6rURqlDKNiLA10r7grwUvimGrfQ/Cj6v3m6ez9wnzAMst+y2GW0DDsTYBGvjjvTI6V+nfLE7tYye+4Y0+SE13iHDHQtCHP+qBclJZUKVlLnGMcQKXYVgdyynFD2BwPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2cbTdHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7873FC4CEE7;
	Mon, 26 May 2025 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748273405;
	bh=BBzNsVtJakp6Yv3+F2M/dc9GLSAu0OF+M+35ZrpszIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V2cbTdHvhfZlEZpQPnp9np9KuC6szkP2Qc0oVoxqjT8A99jLqhZxzG7+Fs6yeFZgo
	 RcrFvSAz0VuUWbgXe8gjDB2bwe1GN6LV19iByprbWG23lOXcamsiqPhuPCtxc3nZdq
	 TuxvvkMqyMPYyptlaalLXZ3BK8zogVzqxYWoktPJE3RwfjX7zByFgp2gR6AMeNebTH
	 e3xv/JO3CKJwSV3ZvMkrgd4AIkjGUmNRzutTQCkXU0ddFHsO9Xf6dYflra42/C78Vb
	 HIo/5CNSHwKbMJxIdv1sxIrROUsAhzUYJ8/7/pGRigIbBZPBKZjmEB+oJyFM5ht+bs
	 O1/nCr4TRso7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD83805D8E;
	Mon, 26 May 2025 15:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/9] net: txgbe: Remove specified SP type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827344000.959287.77588324328583821.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 15:30:40 +0000
References: <8EF712EC14B8FF70+20250521064402.22348-2-jiawenwu@trustnetic.com>
In-Reply-To: <8EF712EC14B8FF70+20250521064402.22348-2-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, mengyuanlou@net-swift.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 14:43:54 +0800 you wrote:
> Since AML devices are going to reuse some definitions, remove the "SP"
> qualifier from these definitions.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  | 12 ++++-----
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  4 +--
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 26 +++++++++----------
>  .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 +++---
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 14 +++++-----
>  5 files changed, 32 insertions(+), 32 deletions(-)

Here is the summary with links:
  - [net-next,v2,1/9] net: txgbe: Remove specified SP type
    https://git.kernel.org/netdev/net-next/c/893e4656d462
  - [net-next,v2,2/9] net: wangxun: Use specific flag bit to simplify the code
    https://git.kernel.org/netdev/net-next/c/78cafb1bb7e9
  - [net-next,v2,3/9] net: txgbe: Distinguish between 40G and 25G devices
    https://git.kernel.org/netdev/net-next/c/39709fe4bacd
  - [net-next,v2,4/9] net: txgbe: Implement PHYLINK for AML 25G/10G devices
    https://git.kernel.org/netdev/net-next/c/6f8b4c01a8cd
  - [net-next,v2,5/9] net: txgbe: Support to handle GPIO IRQs for AML devices
    https://git.kernel.org/netdev/net-next/c/343929799ace
  - [net-next,v2,6/9] net: txgbe: Correct the currect link settings
    https://git.kernel.org/netdev/net-next/c/c0f2e5113e2f
  - [net-next,v2,7/9] net: txgbe: Restrict the use of mismatched FW versions
    https://git.kernel.org/netdev/net-next/c/d84a3ff9aae8
  - [net-next,v2,8/9] net: txgbe: Implement PTP for AML devices
    https://git.kernel.org/netdev/net-next/c/182af02690fb
  - [net-next,v2,9/9] net: txgbe: Implement SRIOV for AML devices
    https://git.kernel.org/netdev/net-next/c/cdae5bccab29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



