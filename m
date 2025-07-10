Return-Path: <netdev+bounces-205627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62517AFF6E8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B001F1C84138
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA427FD4A;
	Thu, 10 Jul 2025 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q++L3HvK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80527FB3B;
	Thu, 10 Jul 2025 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115192; cv=none; b=JyiXIzaHMVxAt8lHC7m8omLDNt+rR2kYrmbH1lH3IuAnN7SYoUkwQYKq3yCKM+tuC7lT2cFTSbKjtooQXD8O05jdaRK6yn7xzjEwwSE8WvJyB5StL96xLEfe1kRVUlGHM5+hMnlm+gj6VPbnsHu47AXMpP3MsZyu38k+nL58US8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115192; c=relaxed/simple;
	bh=XlIm7sMWC74eV76KTvuApJR0mWflLtRpZOV17D85BBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TfPEvullgdofx/KDyag+Ugg2IzUt1HeXm5tSyWupjJR1wE8PBBL/Qmg9W+xWvzT6HMPx0nX++AW34wHw4vdShNP+rCv1byA5XR3FNYUTXGitTHbVw0tRSTbTqDfn3ciF66M0Z6J9RQA/OqUcZnAQLaUqO5HwscFgnnua0E5p66g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q++L3HvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF1C4CEF5;
	Thu, 10 Jul 2025 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115192;
	bh=XlIm7sMWC74eV76KTvuApJR0mWflLtRpZOV17D85BBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q++L3HvKYEuOnz+C4PIXTE1SU/1UkwyjCPpTRC1NLH8BQP04BXGsbRUx3OEYoEVHy
	 zBTCV/CW5U9dtMxMOgLkLxU/y1KjX/l64Td5IKywnYPBZ3XOQkQPEj9vbGW7sW/gg4
	 6p0xnND+B3V7d3BZS7bIcjQC0MySyQ/8N2EyVApz03SCGkVMjwHuM8NQVBtsjpnJLb
	 bpAVXQRqk6XHoPa6xzwABWZ+OO2dOO+Bq06ok/7yifoANvt+8LnDIR7hefQNnTHHbf
	 003UIry1KnWDCn5os73ySNde4zx5XfSjzPEso4Z+JA9XgxZDRVThYui/cTPs3CzjhW
	 GKypERNEeh1Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED6383B261;
	Thu, 10 Jul 2025 02:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] skbuff: Add MSG_MORE flag to optimize tcp large packet
 transmission
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211521451.965283.8119309405484666271.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:40:14 +0000
References: <20250708054053.39551-1-yangfeng59949@163.com>
In-Reply-To: <20250708054053.39551-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 almasrymina@google.com, kerneljasonxing@gmail.com, ebiggers@google.com,
 asml.silence@gmail.com, aleksander.lobakin@intel.com, stfomichev@gmail.com,
 david.laight.linux@gmail.com, yangfeng@kylinos.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 13:40:53 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> When using sockmap for forwarding, the average latency for different packet sizes
> after sending 10,000 packets is as follows:
> size    old(us)         new(us)
> 512     56              55
> 1472    58              58
> 1600    106             81
> 3000    145             105
> 5000    182             125
> 
> [...]

Here is the summary with links:
  - [v4] skbuff: Add MSG_MORE flag to optimize tcp large packet transmission
    https://git.kernel.org/netdev/net-next/c/76d727ae02b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



