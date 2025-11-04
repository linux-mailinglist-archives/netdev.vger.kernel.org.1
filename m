Return-Path: <netdev+bounces-235341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75981C2EC12
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 232B834C933
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C792264B1;
	Tue,  4 Nov 2025 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izwm14OJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D2224240
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219843; cv=none; b=N0JDN7uCiQrk3MiG7pTNaD/pRp4xaWJB/6YxaT0g4VrNlIUzNoJdQdszyc0RyskKgseBFNPIbhetrhyV7rIPHsQR+gNzKl/7NISGAba+ix5Fgb+IPwUbO7oOa/yASzNITz2hh3e0r5qTj1MENBiLTXNWZwUt3qcl4vtHEzBl6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219843; c=relaxed/simple;
	bh=ZrsefpLNJLsVwI4nAjSDixuY1Ba7VZjh+AKW7b/DfCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DeuYU1/vq9vLca0sZaa9IA81tl2SF+oAqQayeq4Z8HLqA5VhF7FpY3YmhV++ArryKZmCujz22yaoR8JPnySCIzUyXzyjZhCqqTco+q04P8KOMxhNWlwDNVrlb18AklAAPyWt0mFmdZtw+rTfn+tJmZrVElfSKOzTEHFjkjF+kLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izwm14OJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C69C4CEFD;
	Tue,  4 Nov 2025 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219842;
	bh=ZrsefpLNJLsVwI4nAjSDixuY1Ba7VZjh+AKW7b/DfCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=izwm14OJOi0IQzsZfmmN+viWluY5Mrmq2fDHhSXgSKshM82oVirNWpw/Q/t4iXthb
	 TtkL1Nr1FFPfKLFsEeM93FxZm2k+G9KlSvHuNArm4tFTZjmUbCS0LQ7C8oH18+2vXq
	 xuZGNZlm1soBRHZ7n71vh/6KgGiXEE+XoknpOpaYRRJAeKkr8ouTjxbV16qqExuoEF
	 Ilkbxax3hL4O85CIbeANqmGaW84rixSveiGoAOE25/l+ytGv3Pu59Zw5WIewUt0/Xv
	 dpx94+3QHsxGC5a0uPejNactv0YjT54NplfnacMBAPu4iYZXZ7te9iZBvXYds+oVgh
	 /Z4pzqcHM/W0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CFA3809A8A;
	Tue,  4 Nov 2025 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] hinic3: fix misleading error message in
 hinic3_open_channel()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221981724.2281445.12770085447089732789.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:30:17 +0000
References: <20251031112654.46187-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251031112654.46187-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: zhuyikai1@h-partners.com, gongfan1@huawei.com, andrew+netdev@lunn.ch,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 04:26:44 -0700 you wrote:
> The error message printed when hinic3_configure() fails incorrectly
> reports "Failed to init txrxq irq", which does not match the actual
> operation performed. The hinic3_configure() function sets up various
> device resources such as MTU and RSS parameters , not IRQ initialization.
> 
> Update the log to "Failed to configure device resources" to make the
> message accurate and clearer for debugging.
> 
> [...]

Here is the summary with links:
  - [net-next] hinic3: fix misleading error message in hinic3_open_channel()
    https://git.kernel.org/netdev/net-next/c/acbf1d0a9aeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



