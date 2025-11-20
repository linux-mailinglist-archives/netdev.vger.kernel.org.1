Return-Path: <netdev+bounces-240367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B06FBC73DAF
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C6233529E9
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69629331222;
	Thu, 20 Nov 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8OTfZGn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B78331212
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640049; cv=none; b=uj2tBAoETuplWuMb5IZMY2uNyJxu18waVfULxAq4fc23pXcTs6Yvs8QrjfLNR51yfutftf+wSMpR13FAt2KPBxrPyPCnfrSD3Dbwa9taQkmXNtrFpGE1mAJOTQAN5cyhjM5VifqQchPA/h9FFadam5qs1f17f/sx+fEFdzVBZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640049; c=relaxed/simple;
	bh=hrpfl3+6RTyo6PK63HjV3JOoV42ZU4Lb9vAW+nPIy4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i2e60g9+8gbLz5fouiPLFc0mnGPUNJA9MpuiXKEy1u8b54oH2dJGjQ9jwGvBcJz5u8CtYjZFB+rilmmWU8cG29W4wk09mvHvMPa4sPewp60R7XOc48uvDdXxlhoZHkxJ62TEAHXWJTBTDMSCBLHFycVUgkJ/0SeinfVoHlFLfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8OTfZGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D635DC116D0;
	Thu, 20 Nov 2025 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763640048;
	bh=hrpfl3+6RTyo6PK63HjV3JOoV42ZU4Lb9vAW+nPIy4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8OTfZGn55V3CgjATnT8AafijJPpe2QKSQETsXmGXQN9PinvUQ0w1sp9IF+MoB2LG
	 bTWYbp/4bu6Javy88RM9vTCvl1jYQAC/5x6Uf9dygmjTtGpA3V+KwtNWw581vJfYFc
	 Qw0AF4wUEQAVS1OxfZeJXK9yxC6SItcvgcP4hgx7I9eLcxtrAQyXGZON82Lcp9kmmY
	 1O9iBPHq0WXkX7unS537liEop7+ndeN1+QomI+wkcpYrJ9lsn7Zl+/Al4+9gqvtjpR
	 xBh8tRwhpaX0T1JRiKWN7Kxtkg09fYlcijd6IQ5z34H2NWkzRf9dLqWVjWrzINcetM
	 EykyLlAcEer0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0E39EFBBF;
	Thu, 20 Nov 2025 12:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] TXGBE support more modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176364001400.1592828.13106374979415290182.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 12:00:14 +0000
References: <20251118080259.24676-1-jiawenwu@trustnetic.com>
In-Reply-To: <20251118080259.24676-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, jacob.e.keller@intel.com, vadim.fedorenko@linux.dev,
 mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Nov 2025 16:02:54 +0800 you wrote:
> Support CR modules for 25G devices and QSFP modules for 40G devices. And
> implement .get_module_eeprom_by_page() to get module info.
> 
> ---
> v2:
> - adjust data offset for reading I2C
> - use round_up() for DWORD align
> - declare __be32 member
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: txgbe: support CR modules for AML devices
    https://git.kernel.org/netdev/net-next/c/354d128aa721
  - [net-next,v2,2/5] net: txgbe: rename the SFP related
    https://git.kernel.org/netdev/net-next/c/dbba6b7a47cb
  - [net-next,v2,3/5] net: txgbe: improve functions of AML 40G devices
    https://git.kernel.org/netdev/net-next/c/57d39faed4c9
  - [net-next,v2,4/5] net: txgbe: delay to identify modules in .ndo_open
    https://git.kernel.org/netdev/net-next/c/c6e97daec549
  - [net-next,v2,5/5] net: txgbe: support getting module EEPROM by page
    https://git.kernel.org/netdev/net-next/c/9b97b6b5635b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



