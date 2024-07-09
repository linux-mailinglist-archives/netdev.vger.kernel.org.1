Return-Path: <netdev+bounces-110409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B892C348
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EE11F241E7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47FC17B037;
	Tue,  9 Jul 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOjKgQci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CB2AEE1
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549831; cv=none; b=LcLrldob16xytA0sbglUUB3V2lXEQiLf7aNWMjACEWmvop1XEP0HX1LTFnKQbDMXWiHk3f4MYzOCy/awEp6DuL6blP31Xs717Kybd5riMl51Kxue/ClP9vvXBHhJpYbSBYWKt2QSYuLGy2yzCULcSmFH+0lrk8KCGFWwQ/ccm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549831; c=relaxed/simple;
	bh=M/ZIf1jgIHB/GyBafrpFrLo9Auv18aRbUSqfbCnDlqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FJ151LPJcD8ShOy0bj3BLYBfLoqUDXceFE8zd7xWWBzf4JOaOYjfcvtw4Ke5/taBQMP1Kx+58kSCjqdtu8AYJazS8U603JzNBeB+huVM3hQKzSue8t1zsNl5ICiGBbCOljbXIbpG8RIfIFRjUo5/MwjnnR2N3Vu2MBJ+TC/W32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOjKgQci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AD6AC32782;
	Tue,  9 Jul 2024 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720549831;
	bh=M/ZIf1jgIHB/GyBafrpFrLo9Auv18aRbUSqfbCnDlqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DOjKgQcieM8do9hzgOXYC7UsRZ/i2qubcZbsZr9axtSH6y7zEbHL2xQC8rE/iQTk7
	 HfrdKQ5rP/Vi/FvtolrsGOacZPKgeNe1S0yl4P0YVipp3tGxUFQWLGbtB/osfexWID
	 P8HwhKeS53IQtG/0CQ2KEwzHKObstxaf2XFl1GTrSD9rQbzXVjRS2qwpNNqLpFa8tl
	 lID0iwk0vpHFvYgNUXFz8cP+SvwZrdbMQ7Jn7RRDPPBG8Lrrw3emszyY3I92p9IIYk
	 po8rqVHyKLvsHLFxYOIrAO6XI05sRUvUFQdyYXCfLwyYa3+M/D3CC8eggHV6VWxr/B
	 x9iGGl3OMFDiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26524C4332D;
	Tue,  9 Jul 2024 18:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: tls: Pass union tls_crypto_context
 pointer to memzero_explicit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172054983113.16059.14526676315148408878.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 18:30:31 +0000
References: <20240708-tls-memzero-v2-1-9694eaf31b79@kernel.org>
In-Reply-To: <20240708-tls-memzero-v2-1-9694eaf31b79@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kuba@kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 przemyslaw.kitszel@intel.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jul 2024 08:27:19 +0100 you wrote:
> Pass union tls_crypto_context pointer, rather than struct
> tls_crypto_info pointer, to memzero_explicit().
> 
> The address of the pointer is the same before and after.
> But the new construct means that the size of the dereferenced pointer type
> matches the size being zeroed. Which aids static analysis.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: tls: Pass union tls_crypto_context pointer to memzero_explicit
    https://git.kernel.org/netdev/net-next/c/0d9e699d3421

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



