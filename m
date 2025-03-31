Return-Path: <netdev+bounces-178286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318BA76652
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B337A2C8C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF72101B7;
	Mon, 31 Mar 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDVvCj5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEF21018F;
	Mon, 31 Mar 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425397; cv=none; b=PDn293XhyPzfgyAGRVhkw7BT2UcBq/3CUcuOhCTu2iHSXjTAyXWg3Ozo3UL7CYJ/PzNoyTuHWSCuerUgroxFb40c47QFHlA/JtZemU1uwOY/9bWlM+bLFGIyymSc9sKnEXahktWKTFbdoLLA7HeoE3eIRti25ruVVeJQC7SfSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425397; c=relaxed/simple;
	bh=/3b13lnPo/VYYO5b8/DZBpSBqhUe8AUyzzqrPS115y4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dW1RljuyHjK0VAKw1EN/Ohcmbi9kGzM9duQqU285qlxj6TjNusRHkdLkMUivSgesRilmNf8CpEKfo878B+ROxXGS/Hopbi0l5D5s8EgnUgrBRfg7cJFwFzUBYeqJ0jaRBQZQIIoq3S7SK9wlrnMFqVTaRHeMogHYNCUwXxUQtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDVvCj5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932D3C4CEE3;
	Mon, 31 Mar 2025 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743425396;
	bh=/3b13lnPo/VYYO5b8/DZBpSBqhUe8AUyzzqrPS115y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RDVvCj5/xkXv1t1Ca4h1QZRQILbJUXwrVvcO23QaHASjf8gIwRJlc3etiQ5PhjKmZ
	 o5up2sndbFopyAA73otGTA7LPrN8lcwa4Wzj2xlyrAk4pmSepuD4CItmPJCoVl9zh7
	 3uvy1D5eG3WvxI9NePoW97NelfDkECWRXzI/hLwfzQTnUkvtCG6KV8kGeJOREcsR56
	 EF5kzhaD0NXtANtazcIvyoMAxn9VuHroFMHbdSfBjQ4J5axIlQx7+rFopdvQpqTgSq
	 hkUi9hOZ6GEHrBRKRRLIVjSw8NzDkwUOuKZHSFB2GLMGMab4M9H3UrU1cJZTl452eo
	 4wLnXQaiLaGtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C98380AA7A;
	Mon, 31 Mar 2025 12:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v4,net] net: phy: broadcom: Correct BCM5221 PHY model detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174342543327.4138497.3469603996591738687.git-patchwork-notify@kernel.org>
Date: Mon, 31 Mar 2025 12:50:33 +0000
References: <20250327062942.3597402-1-JJLIU0@nuvoton.com>
In-Reply-To: <20250327062942.3597402-1-JJLIU0@nuvoton.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, kuba@kernel.org, linux@armlinux.org.uk,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 giulio.benetti+tekvox@benettiengineering.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 michal.swiatkowski@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Mar 2025 14:29:42 +0800 you wrote:
> Correct detect condition is applied to the entire 5221 family of PHYs.
> 
> Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> v4:
>    modify detect condition
> 
> [...]

Here is the summary with links:
  - [v4,net] net: phy: broadcom: Correct BCM5221 PHY model detection
    https://git.kernel.org/netdev/net/c/4f1eaabb4b66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



