Return-Path: <netdev+bounces-224362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED6B840A1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB377BE4B6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39A2E040C;
	Thu, 18 Sep 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iof7L387"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78CD27E7FC
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190818; cv=none; b=Muwn7LZ9G6qvPb6NtMviE3AKdxUjGUiPUgUU0vVJmdfAKrR1THlf1k1Jo5x71W5QinchxeHSdpZfVEwa8rEIqJii/S4H7I3EdP4CWW7PH4xiKlKtDSSOwQ0u5LJFLgLa4WQgiNs8SbUbxHNr/S+y4/KRR41fM32GLPW/Gk7erNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190818; c=relaxed/simple;
	bh=pREYdj7nvkNdpges0cXDiqZPr8+LSXMzC4W3szojw50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LivzoP0sT2IHhC5UT+w15ixUybYREd2Z2UbP32HaBYAHzMw+nr6uEOrBIYzUIl7rPH8EnKYhHTZutagacLcm7pdE9rdQrbIt+p6MT8hopQGlW0Ib839pxPpfAB7U3PtPrl1u7U9RdVyiD/8Adsh6od1OJARfo2bavBh+mivdWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iof7L387; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06ECC4CEE7;
	Thu, 18 Sep 2025 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190815;
	bh=pREYdj7nvkNdpges0cXDiqZPr8+LSXMzC4W3szojw50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iof7L387+nbnpsTlZlwOkyD9E/8c9cqaOwPHZd62+deF5lu6yIHB9GxUZNhvU+0i6
	 kqT7Bi3z8dWf4Nm+KAmg2MuSBr0KHDcqDddAZZJiN8d1BrJrr/9cKeJqafZ9/TpabJ
	 H5HpVrrs4q2FURR7fBsqO1LvX/ZdnfoEbKz42CsYIfbPSJj3x6hKQ0D3UcZQWw5P6r
	 6Tyn19z5Xj/oTlNBB7wB1Bk0TiO3nehEhFx/xUkkmVsBpPitt6I4aOL/0XlBP38FM7
	 ioeZ/sscjQmcwF4DloPAv2hnj3pRspu738/Js3PnuKZwZQoBfaYuLHYiy19Bap6nQf
	 wWwtwLWgcQtDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFEB39D0C28;
	Thu, 18 Sep 2025 10:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/9] eth: fbnic: add devlink health support
 for FW
 crashes and OTP mem corruptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175819081475.2354627.7445984699761115470.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 10:20:14 +0000
References: <20250916231420.1693955-1-kuba@kernel.org>
In-Reply-To: <20250916231420.1693955-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com, lee@trager.us

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Sep 2025 16:14:11 -0700 you wrote:
> Add support for FW crash detection and a corresponding devlink health
> reporter. Add a reporter for checking OTP memory health.
> 
> The output is not particularly exciting:
> 
>   # devlink  health show
>   pci/0000:01:00.0:
>     reporter fw
>       state healthy error 0 recover 0 auto_dump true
>     reporter otp
>       state healthy error 0 recover 0 auto_dump true
>   # devlink health diagnose pci/0000:01:00.0 reporter fw
>    FW uptime: 0
>   # devlink health dump show pci/0000:01:00.0 reporter fw
>    FW coredump:
>       5a 45 01 00 04 00 06 00 00 00 00 00 4d 01 00 d0
>       .. lots of hex follows ..
>   # devlink health dump show pci/0000:01:00.0 reporter otp
>    OTP:
>      Status: 0 Data: 0 ECC: 0
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/9] eth: fbnic: make fbnic_fw_log_write() parameter const
    https://git.kernel.org/netdev/net-next/c/e6c8ab0a1129
  - [net-next,v3,2/9] eth: fbnic: use fw uptime to detect fw crashes
    https://git.kernel.org/netdev/net-next/c/7fd1f7bac2b8
  - [net-next,v3,3/9] eth: fbnic: factor out clearing the action TCAM
    https://git.kernel.org/netdev/net-next/c/504f8b7119eb
  - [net-next,v3,4/9] eth: fbnic: reprogram TCAMs after FW crash
    https://git.kernel.org/netdev/net-next/c/6ae7da8e9e06
  - [net-next,v3,5/9] eth: fbnic: support allocating FW completions with extra space
    https://git.kernel.org/netdev/net-next/c/a8896d14fc0c
  - [net-next,v3,6/9] eth: fbnic: support FW communication for core dump
    https://git.kernel.org/netdev/net-next/c/5df1d0a08483
  - [net-next,v3,7/9] eth: fbnic: add FW health reporter
    https://git.kernel.org/netdev/net-next/c/005a54722e9d
  - [net-next,v3,8/9] eth: fbnic: report FW uptime in health diagnose
    https://git.kernel.org/netdev/net-next/c/6da8344f92df
  - [net-next,v3,9/9] eth: fbnic: add OTP health reporter
    https://git.kernel.org/netdev/net-next/c/e6afcd60c26f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



