Return-Path: <netdev+bounces-196347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDAAD4579
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8453A2D7E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149D286890;
	Tue, 10 Jun 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG9O+xJe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0C2951D8
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592801; cv=none; b=gbZBRFOW12ORzcpjxDqIEnO684c7kNg3RO+RfZdRGjg7IXsxIn3agbKrWdUFtVwnim9zuwdFHzXY+g25Peku27P2zh/1htn0++LfvxZ3L//a8PT03P/U+zPbs6StapJgzWZ3h+P5AaeZnl10hx1vPU4hwcV6PO+LqfcnCvNWAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592801; c=relaxed/simple;
	bh=cgLYwlUtABaObpLO1Wyx0+JnpzApJP0a5qdJLPTxUbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=snheEo3QV+H2DamnOWUU9NN1B5E8Mx5FC/jpdJqGwVSdCCsTamTZXykcDzXnhnNWHVi7ZfeFsbIun6C0ejX2dE3xcfEHY9CvUd0e4gJ69x+bkBguttk8taaKwq4iaMb/5DCbIFDFTUw/g5PcETa6s4gbqBsrL8GfNUIvHiruoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG9O+xJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFC0C4CEF3;
	Tue, 10 Jun 2025 22:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749592801;
	bh=cgLYwlUtABaObpLO1Wyx0+JnpzApJP0a5qdJLPTxUbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hG9O+xJeqPDXZKTvcBrgJKwRJB3oc3zgLfe8GteVftg5lOuEpTIk8tHFxrTPv3lYs
	 78AjjJbWoNdwEyOWQvySaL963eLTva/sTEv2XLbo+qvmRUCu4sIhAecloGigQRSJ2E
	 C5k1thNhLQdCJI8pdopjCf68C+qx76Gkp9H0UC0WtEJMJ0VTikt0wSODDfgXpsVz5x
	 46E0g6tmEG/7bKbdUYGYyFgeevUJc1F8m8Qg2+N1LXOHlVLy4DmnKhjeGfbWyudPbi
	 NYvHEKtQk+d5Rrvv6bN2zDXAtdVgiXBhQQwQ+YZrDFAUX4jN/pbpeZRKIaYRi40WVe
	 wo20t8XPIdOxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8338111E3;
	Tue, 10 Jun 2025 22:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove unused sock_enable_timestamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959283150.2624817.5849009263057753146.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 22:00:31 +0000
References: <20250609153254.3504909-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250609153254.3504909-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 kernelxing@tencent.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Jun 2025 11:32:35 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This function was introduced in commit 783da70e8396 ("net: add
> sock_enable_timestamps"), with one caller in rxrpc.
> 
> That only caller was removed in commit 7903d4438b3f ("rxrpc: Don't use
> received skbuff timestamps").
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove unused sock_enable_timestamps
    https://git.kernel.org/netdev/net-next/c/561939ed4493

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



