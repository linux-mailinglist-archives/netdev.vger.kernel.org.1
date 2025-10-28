Return-Path: <netdev+bounces-233367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C031C1286E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83F0F4F4415
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC04230BE9;
	Tue, 28 Oct 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfG3H6hP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9A22D793;
	Tue, 28 Oct 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614457; cv=none; b=appHLCo4mKcelg66RAscZIj+kZU/+x4oGH+blvu3NCh7FdOO6wMQ19CvxW9bAuoNhsuiBlnoJG/wRYxUoSjc9qqHZAYdYLhyC0oMUTDN5L44zE2CCx1iZSeXxXnWE0v2J8MhdJ8vGZpxjI2qFDLeHNTb3dZqCFcnLEZ7cMqtZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614457; c=relaxed/simple;
	bh=lRrk/qkBm1h7C+JoIkXVUKryc3+0BACXREYCcqtsPm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yfml5YCJP+zkF7nQhhaOOqflP5YJqq+wF7QRwyTaAeon5yuqmCTPO/nam2sLORijUjAxa7sr/xlcteFjBgd4SJtWCRtVsOxIP/UC4KydXzoOXrz8aKy6deqzGZ7WyMxp/8rXAuSy5V6q3gchfDDO19jVsJKoLN1zWr1zvDrjum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfG3H6hP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9872CC116B1;
	Tue, 28 Oct 2025 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761614456;
	bh=lRrk/qkBm1h7C+JoIkXVUKryc3+0BACXREYCcqtsPm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfG3H6hPfDCb7wFpAjjyCrAhxGs1rg4dtuqXj/LAWROrypreDJEqCPmHfuFwaeJps
	 vhg1pJreGoIGlycF7wkSZqA6UOy5HBZHag1kDGocx3NK3b5P5hsgL1QlP6Fly3Y/B7
	 Vb7Lu6HrRPExkMf350W6z9hZk5JWCz0Qo70XvRX0qMxUX/O8ErA7azYA2tGWLUf8nF
	 QFuwXldgJrDQbphJ5HMGkW1Txm67uzHlVyXro0+tPYv2gyJBMVzsP+Dukkl+1w3+Pu
	 LRAsARC/Vx+cUjKuW92GbZOkRsQrAb8DAzXjtCqrRC8lnacTlvZuyuoPesuvh+Y8zs
	 VhJfD5UqTdu0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0739D60B9;
	Tue, 28 Oct 2025 01:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix a copy and paste bug in probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161443475.1651448.9171671482434229190.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:20:34 +0000
References: <aPtht6y5DRokn9zv@stanley.mountain>
In-Reply-To: <aPtht6y5DRokn9zv@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ansuelsmth@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 14:23:35 +0300 you wrote:
> This code has a copy and paste bug where it accidentally checks "if (err)"
> instead of checking if "xsi_rsts" is NULL.  Also, as a free bonus, I
> changed the allocation from kzalloc() to  kcalloc() which is a kernel
> hardening measure to protect against integer overflows.
> 
> Fixes: 5863b4e065e2 ("net: airoha: Add airoha_eth_soc_data struct")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Fix a copy and paste bug in probe()
    https://git.kernel.org/netdev/net-next/c/05e090620bac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



