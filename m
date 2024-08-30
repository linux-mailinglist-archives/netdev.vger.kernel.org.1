Return-Path: <netdev+bounces-123624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAAC965CE2
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B66E1F2397B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71836165F05;
	Fri, 30 Aug 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaAOKgaL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C415381C;
	Fri, 30 Aug 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010229; cv=none; b=jsCa/V0nV4ih1Gz7iXmap/m+fmxn3KF8351GaLn/MDLSWeHPEaVHZ9wZVpZSu3dYqnkqPcrMQsO5hCyrJxL66lVxhpBchHmsATp7xS4HCg3yvdXAyKnLBSh6wfJAG/TfncyW0VT2He8h/QkOTKmP7ikoMuADeeoA3ltbhQjqEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010229; c=relaxed/simple;
	bh=+6guHM6Zp+RScAQS0bqYVs3RgHM8a2uHtWCFeVLwaCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YGv6DGuWpmDyGqSulUS+Xonn6ZEn45sf28JHiTPvqV1Z7GUkpsWy1uIbPs9HjDtu7p6mx+WM3xQtvaNkIhhz+PIKMCVuWlj/me/cHNgLI0MBO9gVyotY4JO8XGV5sr5B1bCA1KNHUJTvDGFs3WAAqUKwZjM2QyQkcVh+N42wbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaAOKgaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C342BC4CEC4;
	Fri, 30 Aug 2024 09:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725010228;
	bh=+6guHM6Zp+RScAQS0bqYVs3RgHM8a2uHtWCFeVLwaCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gaAOKgaLo8PsDHOmo+6IcXS7Q7tRBh4OQ33nRYvN53QvCuVqdXNoM5vZujfJ2UcfA
	 sktKtzeIU6Cc9VCPRVgdEiR6n+Yc+RT+s4HJllBIac8Xk2jonrnN41nxEDB0eH3mDE
	 oMH6g3Td99p6OYENXXTRJtdGYVaID4aCBC1BUU1hRfzEQXggncnYGPCz1nEmfSJbrW
	 axex+dmDXwdTOCVsDT/v2dk1fYMQs9xetGEatqGs0oMs2lvhme+nBEjdDR4oO9qqDD
	 DiZndFPDjwnMnytp29xbXEIsb9Y2Oj52F9QMzUUsKzZFMdEh/Roqd6BF2VApi9J2dp
	 JCPZjLhGaGBsw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 442713822D3E;
	Fri, 30 Aug 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/6] net: phy: add Applied Micro QT2025 PHY driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172501023026.2524815.3187095953778741594.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 09:30:30 +0000
References: <20240828073516.128290-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240828073516.128290-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, rust-for-linux@vger.kernel.org,
 andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
 benno.lossin@proton.me, aliceryhl@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Aug 2024 07:35:10 +0000 you wrote:
> This patchset adds a PHY driver for Applied Micro Circuits Corporation
> QT2025.
> 
> The first patch adds Rust equivalent to include/linux/sizes.h, makes
> code more readable. The 2-5th patches update the PHYLIB Rust bindings.
> The 4th and 5th patches have been reviewed previously in a different
> thread [1].
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/6] rust: sizes: add commonly used constants
    https://git.kernel.org/netdev/net-next/c/4d080a029db1
  - [net-next,v8,2/6] rust: net::phy support probe callback
    https://git.kernel.org/netdev/net-next/c/ffd2747de6ab
  - [net-next,v8,3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
    https://git.kernel.org/netdev/net-next/c/7909892a9fbb
  - [net-next,v8,4/6] rust: net::phy unified read/write API for C22 and C45 registers
    https://git.kernel.org/netdev/net-next/c/b2e47002b235
  - [net-next,v8,5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
    https://git.kernel.org/netdev/net-next/c/5114e05a3cfa
  - [net-next,v8,6/6] net: phy: add Applied Micro QT2025 PHY driver
    https://git.kernel.org/netdev/net-next/c/fd3eaad826da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



