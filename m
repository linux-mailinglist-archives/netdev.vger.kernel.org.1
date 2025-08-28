Return-Path: <netdev+bounces-217528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E1B38FB8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B073B1B99
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05AC17BB21;
	Thu, 28 Aug 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrL0frHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BC16132F;
	Thu, 28 Aug 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340408; cv=none; b=K7BlXnpimiSBOfBP2ktqpCtxVMR1GPfk8wmQRTNzh6zgUOtw3WQUx0qpOsB9nW3d7uyYT3JwBkWdDGgl/4USmGYHTCAqg8Bww/87hEyhHXDUGVnbF3ypjMgv3q13OKIrC2Fl6CJk5k6cmCRR5u0dmJV3c8uBdhgkoyyj6VyXDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340408; c=relaxed/simple;
	bh=U16tI3Hso30MyKo/dJKDDeDxE3hJmBCpW0m0ttlzvws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HWyCPJSmWvaxPDurvhAZt4g1DUB0211LQiQpoHdQ9HFvUsAxvJUbxvyqxV7H5jH0BSlqYQ7Hx3cYfh55n8LTRepFNle6qrvEomnHqTu8hQu2Pz6Xs2KXbsaW82AtLaKZZ27nOKhlnhxByV9z65gVjGmlFL/boqHuyAfkpWWmmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrL0frHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33B5C4CEEB;
	Thu, 28 Aug 2025 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756340407;
	bh=U16tI3Hso30MyKo/dJKDDeDxE3hJmBCpW0m0ttlzvws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PrL0frHAl4XPaAEBifs0a26rrJn+Ybcu6UDottqeREbysApPKRnNtBv/wgYDcJdSO
	 YK7meByTeRR73QEcKr72kVMawZ0bsbv7CGUaV0imRHteWP3yjQnaN3+fATFyFistwF
	 ijK7A36L0ColE9wzOycY6Z6BFg8ZnKnD3uXmn8CNOznHiSfn8IPrXpTZWm88GHJwZ/
	 HuzrKmhg2OCO8eNpkjcyc+qzqNOv9t3ecMbn6CLrSBsy0wCHwihTl/IZxHLVpeBOLH
	 6JLpucVyCWc9B1MlxXUOBWuCuPnOzTlBvcVZUUvMHTmWdXmMCAzRf5WEBtxS9CeXVe
	 JBjgpspFFn3JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED7383BF76;
	Thu, 28 Aug 2025 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: support for
 TRIGGER_NETDEV_LINK
 on RTL8211E and RTL8211F
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634041499.884225.3255332121320642813.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:20:14 +0000
References: <20250825211059.143231-1-olek2@wp.pl>
In-Reply-To: <20250825211059.143231-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael@fossekall.de, daniel@makrotopia.org, daniel.braunwarth@kuka.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 23:09:49 +0200 you wrote:
> This patch adds support for the TRIGGER_NETDEV_LINK trigger. It activates
> the LED when a link is established, regardless of the speed.
> 
> Tested on Orange Pi PC2 with RTL8211E PHY.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: support for TRIGGER_NETDEV_LINK on RTL8211E and RTL8211F
    https://git.kernel.org/netdev/net-next/c/f63f21e82eca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



