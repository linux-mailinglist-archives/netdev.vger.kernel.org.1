Return-Path: <netdev+bounces-92451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358B8B7718
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6098C1C221BA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8117167F;
	Tue, 30 Apr 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4LbiwIG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74110171650
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483832; cv=none; b=JCadqfLuVB0S5LEhoEzlaOM4+H7ieJBWuLZCSb6GG+Q9YzdwKNkCBgyypUM6VepEnd36f6YRlgdkAD0X5OxeNoWWRDQx8k226+Az79o1muW8g3IV5FoUn30o+I899nZZse8XAKaGQRcwOsckjAJvlJQvrnvPh3tj0747OSo3I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483832; c=relaxed/simple;
	bh=YQG1g7LjHRcl/WO93CNwDoXSTWHkgXrJg5gQaNfhZhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JVfP0S1Z+h9Bx+LVyfh7Im5+84LWULeOhHEEGm8vj4d9P9CggfryFA/9bfqUtY6HNA+NCrYMYeoXY7SdEHnn92+YBXOWDEcXgrg+Y9ScTG8WoOjzCGcLPFzrFFuCiEjFOs9cBBHEgaow6hrMKz7CjQ+QF7/Gg6jS/crzed7OWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4LbiwIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07AAFC4AF1B;
	Tue, 30 Apr 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714483831;
	bh=YQG1g7LjHRcl/WO93CNwDoXSTWHkgXrJg5gQaNfhZhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q4LbiwIG4esRdiRZFQpqc+nBgXDZcl+oAknOH8Kuo+GuJUyxDf34l7Lvaxy6WrxaG
	 peAZ+OqoZ/4WGiF2/PxtCqdpDf1QInMaMgZtKIPgo1CLDX5KPS12sxE1yxuQwwvym5
	 eb5FBno3kakayuSUj7A/v9oymTL+RV1o7Eeu7OJ67AUxEIUeaX31DrebBFIQGlVJ+K
	 9HDnSeLatcCoXGMhQsw92G1qYRaZmNDBsk+ZQRwBdJXXSXeceBLOpEyVPMUCFhtSjp
	 BQHuPVAzlFc1qzkv1QOFFYV1i/UqTcLBadZRNrRBfuqE/mfgR27qmTDkGmZee4vi/6
	 f+yCP4kW3bO7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E686CC43619;
	Tue, 30 Apr 2024 13:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: allow use 2500base-X for 2500base-T
 modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171448383094.15823.512737302587788960.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 13:30:30 +0000
References: <E1s15rv-00AHyk-5S@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s15rv-00AHyk-5S@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Apr 2024 15:51:07 +0100 you wrote:
> Allow use of 2500base-X interface mode for PHY modules that support
> 2500base-T.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/sfp-bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: sfp: allow use 2500base-X for 2500base-T modules
    https://git.kernel.org/netdev/net-next/c/8a3163b6714b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



