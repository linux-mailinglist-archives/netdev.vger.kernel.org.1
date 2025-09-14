Return-Path: <netdev+bounces-222888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1651B56C9D
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 23:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4573B331C
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683692E7F15;
	Sun, 14 Sep 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePz4Q1+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40612289E17;
	Sun, 14 Sep 2025 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886011; cv=none; b=qEchSOgHHpYndwtKIv4HQYzM59tnFfBFtyScyBoxLxMlybx1g1nWnyaWVDZkrqWUpYVVlV0trP4VAuqDyoyqFdtDujcMrRbeJpoo6hG/JC4peAIPiWOCI25yZUEFyFbqwe4RFnKRcdBh9puCdCrGPht3BM5W8pUURO+qilIixHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886011; c=relaxed/simple;
	bh=xX+KiBmWRI/Od1kzwgVXGY+PJx1aCaqfT7eEi4V6kSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p3wkxN2ZPjZE4PARXIv3ETi1GvgXGRmMPOc7sDuZYE3Obfkc6lyIVumrq+mir2ORozNG6B9V/9p3Q3ZRyq68xQRdxIxK5Oj7we9xiTeRl9IcTo251ld9Z8GRczGHxgzBhJszVbKxFPTvA3SWX2u8FT5KYQ7XYIzK1zW4rccZy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePz4Q1+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFAAC4CEF0;
	Sun, 14 Sep 2025 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886010;
	bh=xX+KiBmWRI/Od1kzwgVXGY+PJx1aCaqfT7eEi4V6kSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ePz4Q1+M98WvQ1ZBMjqqEAm+t2bw48u9GPKeqJRyc5eV+yfWU7cSZUB58a6qJeuO4
	 wvxrRIFdLd8mZw30sgGyzbDi98Fj3pd8LwgEl4O0wO9rTJkD5hDh/XN42w32QqxJey
	 T7i2CfTRcJhwh4P6638Fyi7Qbc9C1ysA6jozNIy32qHnT3mFDJfzQtLKiqrWwide1q
	 qT88w5cD3wWfoOJSHFSElDxUFAYJoarVscYK3zErVFYOnyZY1FSpCFXMMXUjeJVqxk
	 C4vwscxI6vQ5HSUXb+VA+ebP76En/H4/nTJZa7HjfLYK3ibJjlu8IokXNEZQiyrakV
	 rs78ieNtseU7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFA39B167D;
	Sun, 14 Sep 2025 21:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] amd-xgbe: Add PPS periodic output support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788601224.3557884.17634358592289970917.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 21:40:12 +0000
References: <20250909113143.1364477-1-Raju.Rangoju@amd.com>
In-Reply-To: <20250909113143.1364477-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Sep 2025 17:01:43 +0530 you wrote:
> Add support for hardware PPS (Pulse Per Second) output to the
> AMD XGBE driver. The implementation enables flexible periodic
> output mode, exposing it via the PTP per_out interface.
> 
> The driver supports configuring PPS output using the standard
> PTP subsystem, allowing precise periodic signal generation for
> time synchronization applications.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] amd-xgbe: Add PPS periodic output support
    https://git.kernel.org/netdev/net-next/c/5b5ba63a54cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



