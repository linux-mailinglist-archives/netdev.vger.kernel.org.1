Return-Path: <netdev+bounces-94859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066B78C0DFD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5241281A72
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3014B071;
	Thu,  9 May 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUKRQo7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7414AD3B;
	Thu,  9 May 2024 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715249447; cv=none; b=t/k6kTNWWs3umfYNzq2tm2SSyuHcEJVHmf61AeNskkQoExezxI//cfMzhu+/UgQhHGJcg8iTfxnjKgrPt3M0Stdp4lamNziGDL/rSuTkgqkQWMVO+vdopeUdhXKIpF/eLKS0/oeH+YVJTy30pw0cvw13L4+4kLeSLDZe6EJc59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715249447; c=relaxed/simple;
	bh=EXtXbepvP4iR59x5J74rICFVtzzQQF1iiGPwONJRT4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YOD0sZ3DoE6JnvNphSYxWdPp5gjSott1kWiFL9huIsgjheSZ5V7tXBTXjKCTQ0V8d4EBGgALvCi6uWWAfmLorgZiiMts8PriCFKgSlpYM6++SDYrKfP8sNBkbqYRnkyBvYHEny9ee0r/SntwcFN3KYa3Ybc0E6t+fsT3MEtWM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUKRQo7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77913C116B1;
	Thu,  9 May 2024 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715249446;
	bh=EXtXbepvP4iR59x5J74rICFVtzzQQF1iiGPwONJRT4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SUKRQo7i1biPOgjkYxhePyIHeFImfUW3yHsVr70wUfUi9kY45xiIzus4ET7nhF/2s
	 snUPlI4+0euN81e2ieAd3lHqKmK+pvLb4WFsp20sYQuNZHPWpvm4rAdI2Y6GMWBKhD
	 amPkZ2HDJxamcGdWakb+uHatCAJIS6Kk6ewKq5ppHNgw6ETYhzJHghTyyYDluD89oV
	 /bLb0xfvOI2hJJwd4Z3Fc/pX94WDHIaBnG7/83+lj+ZLxKRPK2BkDjSuBxD8SVG6T7
	 K9bJxFKtfq/xE58/G48Gj+XvIn2wAWWM6b8rS9VkeQuBxKro3Glnf+Cgr/IVMscNDB
	 eomzHFSwqxaCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C14FE7C114;
	Thu,  9 May 2024 10:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: dsa: mv88e6xxx: fix marvell 6320/21 switch
 probing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171524944643.18591.2478308617241575951.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 10:10:46 +0000
References: <20240508072944.54880-1-steffen@innosonix.de>
In-Reply-To: <20240508072944.54880-1-steffen@innosonix.de>
To: =?utf-8?q?Steffen_B=C3=A4tz_=3Csteffen=40innosonix=2Ede=3E?=@codeaurora.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 May 2024 09:29:42 +0200 you wrote:
> As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
> be filled")
> Marvell 88e6320/21 switches fail to be probed:
> 
> ...
> mv88e6085 30be0000.ethernet-1:00: phylink: error: empty supported_interfaces
> error creating PHYLINK: -22
> ...
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family
    https://git.kernel.org/netdev/net/c/f39bf3cf08a4
  - [v2,net,2/2] net: dsa: mv88e6xxx: read cmode on mv88e6320/21 serdes only ports
    https://git.kernel.org/netdev/net/c/6e7ffa180a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



