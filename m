Return-Path: <netdev+bounces-204106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0454AF8F17
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E1B483F0A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDDF2ED149;
	Fri,  4 Jul 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czXRBwSk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3A2ED159
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622582; cv=none; b=Koua9oj/zX2lcSHfyaKKma+0ZiE9WdfQP3IjKoYx4fatj227+rvgsLLfO18R9sBme2x9pUQk6HzfPqvtRsgjTGZ6Ft3njRvsiyiZRICy/7YvdO/pGYz7Yn9WhEd2half898jahX35JkPhl/KoFn7sPYsDBQ6mDLqkzt1zzLeXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622582; c=relaxed/simple;
	bh=hjkzQGP69/TcghSKUvqwK1pJ9werthnhntu4aG51WMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RgdfY3Ggpa7zXvWB3bzJq9/sImu/YB3H3MCz9DAP9Gj19ry6q1qohgvxEFXq1EsWMRjIHDz2C6nP0TLroNKrJoRpZBKDsjHEChS+RnASUiwJdLGfT6hSb4TQ2GnygaHWEUsZF0D0hFBX3RvX22/ncz+/yqAiFlh0RxQ1AShlAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czXRBwSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61AAC4CEEF;
	Fri,  4 Jul 2025 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751622581;
	bh=hjkzQGP69/TcghSKUvqwK1pJ9werthnhntu4aG51WMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czXRBwSkjL9+i+bNJV9uHvpOYQLO++KSX4+OTUrPWL2fsrGAlw3h7WP7mRpAW8Na1
	 a+vSUvsp0JMOoV/tBfkJpK/eJglIkBQV1WKHwCGC7xXr8lgCsoqLo7XjrXJKwjDdhb
	 P6QsHJNaQRbwno1oqEiNhjEJ/YqBmyzX6RWufuV3dFNypkfSDuRogO8IB6TUNFPP6i
	 LTZZ4VTv6K6309ICEzyaM06hiD6CtWBXd5ue01w1DKy8W4mPwPxHIJW7Ay9+vHbWVZ
	 mLYUuv03TnWGJp5hWdXbuv2pAETkvCHwUU8khTvwLE7iZT5s9gt4VuS8qKzZh2EN0W
	 b4jwra+1A7xMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF25383BA01;
	Fri,  4 Jul 2025 09:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175162260576.1797013.6792489669982214101.git-patchwork-notify@kernel.org>
Date: Fri, 04 Jul 2025 09:50:05 +0000
References: <20250702064822.3443-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250702064822.3443-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, michael.chan@broadcom.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
 kernelxing@tencent.com, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Jul 2025 14:48:22 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> I received a kernel-test-bot report[1] that shows the
> [-Wunused-but-set-variable] warning. Since the previous commit I made, as
> the 'Fixes' tag shows, gives users an option to turn on and off the
> CONFIG_RFS_ACCEL, the issue then can be discovered and reproduced with
> GCC specifically.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: eliminate the compile warning in bnxt_request_irq due to CONFIG_RFS_ACCEL
    https://git.kernel.org/netdev/net/c/b9fd9888a565

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



