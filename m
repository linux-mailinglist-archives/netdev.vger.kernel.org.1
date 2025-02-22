Return-Path: <netdev+bounces-168730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F0AA40548
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 04:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5023B871D
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 03:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294E41FFC41;
	Sat, 22 Feb 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beMgBMXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D21FECCA;
	Sat, 22 Feb 2025 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740195011; cv=none; b=AvS5zrXDvF3c98E/gRtbS7vQj/OXYFGWffa3/1f/f3uMtVpBcEMjwepV1R1LDEtHeh3JEy8lcF81VRkXbkYZ0U71yxW8oJBv8UUni30DKuUZpRfqKrXitKaWtygyigz5WdzzWDTWDWxpWQhQyHz3VbOVgkBjuWML2hpXcb/0Gy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740195011; c=relaxed/simple;
	bh=LvHxA7Jof8KdmS9QjcNsAFD6oimlu1jYgF80NuH5rAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XYw+A1dsKD0UdHgdTwiccZ2UFO7XsXDa03jikKxMQ1BKdCLUFpnLOdZUbFAUKdakguEHa3uODNwAAEpdFRe6PiyBWzQZKG9eBTY8F97cmsuSxy+iWcCNaaUYIOO0eE1nk5EpmEEiyXrM+GtVdmo6L2A+9Yoi1p9aoOB8C1vLvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beMgBMXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721D3C4CED1;
	Sat, 22 Feb 2025 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740195010;
	bh=LvHxA7Jof8KdmS9QjcNsAFD6oimlu1jYgF80NuH5rAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=beMgBMXTwmAJoQ6KLaxNscEMNABtl/P0naicy9xC6ERc7iFTDtpruvPdmEI7ZbHL4
	 R7Zx1gZfjfzYv4XcogE/VWKJHx1Gqz6qojNFPpxmfIaEOB0oUxTco326Dmp2JBu2ZP
	 SgquTocbT5u6On1bmW21iHyiV7+g3ZVsrusbKZfPugA0v0CakukT53Z6hzD5bLmSRX
	 Zwp5ITImgdccn1ZfqpWcpXMlzpt/BvPfv1r5MoF/NBfL8xgu+QVlxzWZ4zo8EORbTV
	 p5gt1buW3xwQeKZdD83VnwzIWpZV8TgWG3uE7A2jgkkS/UiBddB/M59GBEgcKtAYcR
	 Z71c6QE5cOThw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE076380CEF7;
	Sat, 22 Feb 2025 03:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] mctp: Add MCTP-over-USB hardware transport
 binding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174019504120.2279798.1941572582766631045.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 03:30:41 +0000
References: <20250221-dev-mctp-usb-v3-0-3353030fe9cc@codeconstruct.com.au>
In-Reply-To: <20250221-dev-mctp-usb-v3-0-3353030fe9cc@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, gregkh@linuxfoundation.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, spuranik@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 08:56:56 +0800 you wrote:
> Add an implementation of the DMTF standard DSP0283, providing an MCTP
> channel over high-speed USB.
> 
> This is a fairly trivial first implementation, in that we only submit
> one tx and one rx URB at a time. We do accept multi-packet transfers,
> but do not yet generate them on transmit.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] usb: Add base USB MCTP definitions
    https://git.kernel.org/netdev/net-next/c/dcc35baae732
  - [net-next,v3,2/2] net: mctp: Add MCTP USB transport driver
    https://git.kernel.org/netdev/net-next/c/0791c0327a6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



