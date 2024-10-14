Return-Path: <netdev+bounces-135174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7A99C9F2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040251C22AF8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D26319F46D;
	Mon, 14 Oct 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzR9jm7Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FF19F420
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908425; cv=none; b=bJTejdZJY0XxBxGYBXl1qJ5Bfe5QHXb8PaDeh4RA4gQbrogZrls0wnOOpIw1okQACqoeG3j63sZmojgzcv32hEENAg0ZY7m9RFGp+8df3XpxJN9Sj5MKfCRKZlF15nBD8LofEswE3WLmZgkYiSC4Taxzn8C6QYE+zzeU4d5cbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908425; c=relaxed/simple;
	bh=LXznAmCG16MFaKwR0xSK9WbwyaZwpTuvLJl+dTfbRuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C9wnuC+ySjDfIpkpC56kxY6lx1uoy2ZABGuwlG9atEe179xOXRNH+nxS0tinCOI1P6uuIorT/r5xw4y8UhonozI4kvbRDwCrqMlpxs94jF0UT38nuRi7FBbH/FjCCLuMSRyNosPV8nsVkqc3oImw2fEQN0xeZznLgmzgTkgvpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzR9jm7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E98C4CEC3;
	Mon, 14 Oct 2024 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728908425;
	bh=LXznAmCG16MFaKwR0xSK9WbwyaZwpTuvLJl+dTfbRuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzR9jm7QEKM0PlZtLXfOvYmC/9JK8AMVC8eQEbpYqlcQXmcYuekuCDgFkprEhS2Xk
	 GIpzTwnvJ5dLAem+t/lU23il1ighuNU6eMjwSYNZfQ3FqA06kOg3V4C5kWMCU8pIw6
	 e0EBXrw4aHg1902O68Jq7utATo4m5DPEOOj69gljgY1ekyL/lh+oV+y7u9WBEiOxEB
	 AsZ7LSQDV0vglt3TIZyhdkSp/WorE0UXdF9n67UNEiRdZXK5OBqwlyL6s+yViY1LYn
	 EYnM+X+q/hukLdrOL79HXJZ7RukVRHiwMR4gqofUluQDKX3DKrl5liMsoxKQ11POxt
	 NOidDi5gW+qjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5D3809A8A;
	Mon, 14 Oct 2024 12:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: enable SG/TSO on selected chip versions per
 default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172890843000.494844.8256084079732573006.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 12:20:30 +0000
References: <5daec1ce-1956-4ed2-b2ad-9ac05627ae8f@gmail.com>
In-Reply-To: <5daec1ce-1956-4ed2-b2ad-9ac05627ae8f@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Oct 2024 12:58:02 +0200 you wrote:
> Due to problem reports in the past SG and TSO/TSO6 are disabled per
> default. It's not fully clear which chip versions are affected, so we
> may impact also users of unaffected chip versions, unless they know
> how to use ethtool for enabling SG/TSO/TSO6.
> Vendor drivers r8168/r8125 enable SG/TSO/TSO6 for selected chip
> versions per default, I'd interpret this as confirmation that these
> chip versions are unaffected. So let's do the same here.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: enable SG/TSO on selected chip versions per default
    https://git.kernel.org/netdev/net-next/c/b8bf38440ba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



