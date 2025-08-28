Return-Path: <netdev+bounces-217564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C107BB39110
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7C03AC5C4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722551F3D56;
	Thu, 28 Aug 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph5F92+F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBDE1F8AD3;
	Thu, 28 Aug 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344599; cv=none; b=dRD3IkH4UKydmJ5g0xLPApWPzp3kCtQUtDqeZYePpbKDak0w77VQKqJgk5kryoK8IVMEVn9LwobzuJjeIwALiePU8PbpQSeRIxPdThtqjwfmUxc05D7hJwch70lr37LHPjDGHrJhGJwWBnEndV7Xnix9dCF6VHGYwXpJgKQA0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344599; c=relaxed/simple;
	bh=ZJ8FH5AlMtomirtQ7Df11JMaZi0hiqnD1BCDV2wLtSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anHkLsHdeIHMsvcyE5gJf4Y10IgfO1ci+XjzMGQeFPWRyNt5Yj6CrrForJaJlvq4d1OIuC3yaRYNhSsXyAtjMzDzSHHWpFk9mPfjWqfAHTwQRVBfCusMFNoz5asaNmsbbwbgnaSwRGilrwrrTKJlCL4ClVN9segxCyKQKXiXGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph5F92+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9FBC4CEEB;
	Thu, 28 Aug 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756344598;
	bh=ZJ8FH5AlMtomirtQ7Df11JMaZi0hiqnD1BCDV2wLtSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ph5F92+F9ld334fEijMfhvEHSWv2tOUsHU2uYHVWt0SSPNZqWjODBXeW5W40qZga8
	 HEOUnYi0swF0zE23yeNjqRQtofhoN3gfpptGBtzU8EI8T2y0SRbO93ufOzsiJLPqX1
	 Dh7cBviDMJY3BOXfSBNS3Ha6ap1EYGFI7lpL41lXsHmibWXX2sldd/jcdq9/63tKtU
	 /9saz3PgbHWlfORPdTHg6peqeCSUkmwGpv9g2cYtED2EUGMBOwd6E0Ph3ViwqYvGv6
	 VGSL83igXbDX4vFW8x9h+ZNcd9U1l7SKjhHCDD8hDiT/dnJsovDCkL34P5ykK5/kxX
	 4k2Wp1U2Xo8xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5B383BF76;
	Thu, 28 Aug 2025 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: iosm: use int type to store negative error
 codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634460600.901795.14804733174752334010.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 01:30:06 +0000
References: <20250826135021.510767-1-rongqianfeng@vivo.com>
In-Reply-To: <20250826135021.510767-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mail@maciej.szmigiero.name, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 21:50:19 +0800 you wrote:
> The 'ret' variable in ipc_pcie_resources_request() either stores '-EBUSY'
> directly or holds returns from pci_request_regions() and ipc_acquire_irq().
> Storing negative error codes in u32 causes no runtime issues but is
> stylistically inconsistent and very ugly.  Change 'ret' from u32 to int
> type - this has no runtime impact.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> 
> [...]

Here is the summary with links:
  - net: wwan: iosm: use int type to store negative error codes
    https://git.kernel.org/netdev/net-next/c/f0c88a0d83b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



