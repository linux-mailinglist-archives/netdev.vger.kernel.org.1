Return-Path: <netdev+bounces-193800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD7AC5EBF
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A404A51E5
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF31F0E53;
	Wed, 28 May 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aknFcMM7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F991F37C5;
	Wed, 28 May 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395222; cv=none; b=O1KTnlFmoS2yu5Kuc+EFAaCKHUa52yhJ1/7NWd3CpNxsr7dOb8w5JolH0oZ4+3z3AEav8ACtCnUUSLMMl9doSwBq7s3obno9yTvbCM2Xw58HjMtRRgwStdZrabuquoT2xc3nbx9JxjvIuXL0By/BY5IjS9lCPFGH+n5gVBTZp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395222; c=relaxed/simple;
	bh=cWtikoc+JDZDC8VaxuRgImIVHGXFuGrBqKszWEYqTI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z2mQsPYs7GRkye1D20sRnmNhdsVkrI6hDeRYYaT9/UO8vNCUA2Ahzt0F+YLak4YOTC+FKeMw8u2EhUDL2fzxlbR5b3YYtNlufWMwGlNPaI2VRR3hczzY/UbW9361S/eeoj94RDuIrT0mLGUfdhJkIPh2Q8C/YsuCwhv4DX4BOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aknFcMM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19993C4CEE9;
	Wed, 28 May 2025 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395222;
	bh=cWtikoc+JDZDC8VaxuRgImIVHGXFuGrBqKszWEYqTI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aknFcMM72s4NonO+y5VHKivkM96ay5+S76a4YFfihEtlLdOV+wkpDFXJ3tW77COuv
	 9/IJsRPlmUkN+jD5ueA1xizqXfPDXWNy2OLZ588Jz477zJc9UMNmh+kYL4rL3359S/
	 pt6PNlfmoJDPG+XKROqXyiEo0LAEN3K2iRCXDUIx1JN/5Fl0XVk5i/kD6U8OyPUYbk
	 ayR7GyyHJ4kQNoPnRW2C2CUrgsQosEoU3vEbIpY01sK+dUyLK/uoL6E278LmPwF3Z4
	 D/WdqpCirx9zqE6iMU+//dRGivQYB4r3JlwU7aZ63e4vApWbwWnzc8Yv3B8l1xVP7A
	 LAKBBzSAVBtUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C73380AAE2;
	Wed, 28 May 2025 01:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fix up const issues in to_mdio_device()
 and to_phy_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839525499.1849945.743853526912527332.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:54 +0000
References: <2025052246-conduit-glory-8fc9@gregkh>
In-Reply-To: <2025052246-conduit-glory-8fc9@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alobakin@pm.me,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 May 2025 13:21:47 +0200 you wrote:
> Both to_mdio_device() and to_phy_device() "throw away" the const pointer
> attribute passed to them and return a non-const pointer, which generally
> is not a good thing overall.  Fix this up by using container_of_const()
> which was designed for this very problem.
> 
> Cc: Alexander Lobakin <alobakin@pm.me>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Fixes: 7eab14de73a8 ("mdio, phy: fix -Wshadow warnings triggered by nested container_of()")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: fix up const issues in to_mdio_device() and to_phy_device()
    https://git.kernel.org/netdev/net-next/c/e9cb929670a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



