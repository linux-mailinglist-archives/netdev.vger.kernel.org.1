Return-Path: <netdev+bounces-206934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4609B04CFC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8636D1AA3CEF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764781C84DF;
	Tue, 15 Jul 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svnbboMj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47C239567;
	Tue, 15 Jul 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539407; cv=none; b=Tdwl+1LOucpocfUqPORjO/vUQ06GkXSvhV5roKeT1vehJ8OVRXy2335n+pJFs3WYr9JKUp8eF+Nd+qZgB68nI6BG8vEgOTqxSvfbsoUUu1BYZ05sWf7r8PRV+bTQJGHuCrGYMB5fT1Si3l0IxZwDMKDGu4A2SuzSbAcYBLKDh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539407; c=relaxed/simple;
	bh=9Vz+b5iFtjY5dEJRe0302Zp/g1f0YHUeToEdiuiiTLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UQc2mfl4sJoubMPzRxT79ahTGpOUEvq7e5RVOp0Dotpbigu6roxDcvwvqtBCYwOY3GaFwJDxykQVACd5bIj081NRwvTGEziq+7spDIZqL/2QbZh71r8shI2mRduj6o6n9HWPuamgDWEBaa8ealvxIXv8ygcgnpqFTNwWMFnliEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svnbboMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BDDC4CEED;
	Tue, 15 Jul 2025 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539406;
	bh=9Vz+b5iFtjY5dEJRe0302Zp/g1f0YHUeToEdiuiiTLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=svnbboMjqHQDhzc45b2IpFsLnGtQfBHvSZPDqLfepYUmyZr3E1LVrQYO6sSB7jaT0
	 ES4eRrWSDZ7rXKQNNpWn5/n7YIgxToori2YXcZmkDGdH3Lo45YQyulSll/8xvaPNSE
	 L2KhW6hHgAI/lFYuGlJ7Fqx7lPsisXG5ijadWCQl+iT1kJoZuo4OffYFvFtqggRcTS
	 pGHKWui1Ror/LTxjM7LKBaOfNV9F3b+lTHSvU8EczucvJDBFME8bZFqKcaWsR5Ko2R
	 TwnH9o/I2ljAIvumS5HrEn7TP0JPm0h1TfFPesYly/9vIyURtHULGsart+2YWId1+X
	 oAw4fyBB7JDEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC1383B276;
	Tue, 15 Jul 2025 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: thunderx: Fix format-truncation warning
 in
 bgx_acpi_match_id()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253942775.4037397.6464344303980348898.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:30:27 +0000
References: <20250711140532.2463602-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250711140532.2463602-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 darren.kenny@oracle.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 07:05:30 -0700 you wrote:
> The buffer bgx_sel used in snprintf() was too small to safely hold
> the formatted string "BGX%d" for all valid bgx_id values. This caused
> a -Wformat-truncation warning with `Werror` enabled during build.
> 
> Increase the buffer size from 5 to 7 and use `sizeof(bgx_sel)` in
> snprintf() to ensure safety and suppress the warning.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()
    https://git.kernel.org/netdev/net-next/c/53d20606c406

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



