Return-Path: <netdev+bounces-156936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13C3A08533
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399F5166A59
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0C02046A5;
	Fri, 10 Jan 2025 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIiXWpFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69170200BA8
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475019; cv=none; b=BfzH9jUrUhdmGiQytYTKGC41c7wOe95B2ENalf5YIj5OmhXJps3Syfjp2Ia9VJL/yuZSTKVQnQj8nPXV+T2YIONb3MG0hJWyJNop2hrD9BSb1Ybue2cla4dXqLAAn1QJKSTPLod/0fagwtr0VopM5aRO5xXwNpdtDBB/Ajmlf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475019; c=relaxed/simple;
	bh=/UfjSy26N43zxKwvEPoMtjVD4dvWfID7zkifgoxTJGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsgLRX/H46/At6+zKQ3T2chC33rFLbw6I9c9u5oVAaPdg1MS+ufhymZdU6PqK5qiiBfZgSnlW57ygnUk4XsGDW/Ge5NpajhjJp6jZwITUKReyQxsYaw1ERl5n2iAbaBU39i04Hiri2jJ/3ovfAclX/5AeiixDhM+Ds64pCHin5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIiXWpFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BDAC4CED3;
	Fri, 10 Jan 2025 02:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736475017;
	bh=/UfjSy26N43zxKwvEPoMtjVD4dvWfID7zkifgoxTJGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tIiXWpFRxg4j5fSLylVZkk8ZNSxprOzNTrJOuTd+uN4MWlFnMT7uUH0RwGIEGNzqo
	 bAJSd4gRPT6wljapplUtHrv2PeWVxKUITSTyichdALgJiv83P3LdAiaVRqZkYMSO8T
	 SMR+XFctoqjyZoU87TD+1CO2awRrJ9ZHgY6a4UCRfm6F2RRxtJjRazX279zJc4o4Ey
	 9UREd44FY8DW08ZLueUYDISzFkJKdtq78PqC8SWDvp/mVXzkurTrgI+QTlGY3wdIwN
	 VfnwTFasG833YS89hFbnNHLVTtiqkaMisV3z2CyCVSom9KX0wY7Z2D3aZzUywKxe+A
	 XHhd9qmn4WV1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB630380A97F;
	Fri, 10 Jan 2025 02:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: micrel: use helper phy_disable_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173647503949.1577336.10301718061902104380.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 02:10:39 +0000
References: <5e19eebe-121e-4a41-b36d-a35631279dd8@gmail.com>
In-Reply-To: <5e19eebe-121e-4a41-b36d-a35631279dd8@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: o.rempel@pengutronix.de, andrew@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 7 Jan 2025 21:13:44 +0100 you wrote:
> Use helper phy_disable_eee() instead of setting phylib-internal bitmap
> eee_broken_modes directly.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/micrel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: phy: micrel: use helper phy_disable_eee
    https://git.kernel.org/netdev/net-next/c/25cc469d6d34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



