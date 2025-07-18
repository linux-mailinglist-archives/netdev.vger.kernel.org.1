Return-Path: <netdev+bounces-208079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33233B099AA
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DB77A3B83
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE7191F91;
	Fri, 18 Jul 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwpzHDbn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683A146D45;
	Fri, 18 Jul 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804589; cv=none; b=gGIS6iOCEmSsZhdDU/TGmtociJWufK62adEKOGZQA+WNUAWPWGGVec7peAiKBEf0LSsyL1FNF/DgBCsmh0iwCYeYJ+Y/ruddncoJTs57+gTWTkz97jsjZt2UzqNB1sVVtPmqINNcKG1Z+hWDFFNh75O6IJpbAAYYvhp4IPTDR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804589; c=relaxed/simple;
	bh=zlBeCbSN8/dcw+bg39PqFe6YPjDYYzZltm4Jhf++RMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4kvRDlFcAFeBLRq+4OOudPRHl0pDZHIbSTE8AZdGour+W3f2r4i79MFnQGpa4E4yR08WEti1TDJRt7vHppblyq2wX10XsBixCuWztpzfpHNOjcRxrx4gqHDhLFOrAoBEtxsPavmBYextSMyzqzF9rFg+QOg9Rt5WQ2tHOQNuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwpzHDbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543F2C4CEF0;
	Fri, 18 Jul 2025 02:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804589;
	bh=zlBeCbSN8/dcw+bg39PqFe6YPjDYYzZltm4Jhf++RMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FwpzHDbn6DIxb/soJYs5BcMtElg457RjRkq6YYQWADyxc/ZS3KI3MV/qhs5rfLszW
	 1PtcY73gMCm3cUURJ7lwOBY0q9IAtv4BZP/DyE0i7E9o53HV9GAZqk5dhaxyMkRDIK
	 5rhDRY6CRBmN4sKwiMaHr6gewbfIqWl6d2DNXx44xgljeNaNuZupxtS/d7x+Qct1VE
	 aSiTTQGrhZSTTcAyQ0nfM8+nMCLMvvyxBIPQB/+ZcuqkaJod7oUy5/k4P6IFH4FRQJ
	 hdQahlY2BlEJFbRncCtx6PYY0e90QfU7Z99E12EyS8iKNdttPj3InuQE5v8c0CNrW/
	 058ZBAPKtku+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ADE383BA3C;
	Fri, 18 Jul 2025 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] et131x: Add missing check after DMA map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280460930.2144612.10439503396784467047.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:10:09 +0000
References: <20250716094733.28734-2-fourier.thomas@gmail.com>
In-Reply-To: <20250716094733.28734-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: mark.einon@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mingo@kernel.org,
 tglx@linutronix.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 11:47:30 +0200 you wrote:
> The DMA map functions can fail and should be tested for errors.
> If the mapping fails, unmap and return an error.
> 
> Fixes: 38df6492eb51 ("et131x: Add PCIe gigabit ethernet driver et131x to drivers/net")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> v1 -> v2:
>   - Fix subject
>   - Fix double decrement of frag
>   - Make comment more explicit about why there are two loops
> 
> [...]

Here is the summary with links:
  - [net,v2] et131x: Add missing check after DMA map
    https://git.kernel.org/netdev/net-next/c/d61f6cb6f6ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



