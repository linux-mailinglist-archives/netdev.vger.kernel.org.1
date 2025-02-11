Return-Path: <netdev+bounces-165014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F187EA3013A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D857167831
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E461CAA75;
	Tue, 11 Feb 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4LHJvei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08751C5F26;
	Tue, 11 Feb 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239207; cv=none; b=mcPpioY06ceF9kgyLuE6/LmS1X2PLkIMvzhgeFIEGU7YUDtXB4pfQlTEN/fghXwoxdZi5SwXBweR1EZ/oIyaGaTk7LUo3S6oiBIL5CUzcVGwdmM74/FZdolEXdsGv484UAx0J0pgf6hKwIN7IDecl3PHSMyz95zZGaaUAAdmQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239207; c=relaxed/simple;
	bh=atbq5gGaQJhG/f9qRXyS6T4mf5Vi8I+Sp3R2VsFrCR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dvL5yEHo5OhlwkAlKBcvJ3VE+7JA/DCUbDSyDWdb+Hidd53xAsBU6JnUL3oI//Ihp0BvtNwsj1fHVp+ECwibkV8Y51vjZhBVjdi3PxlAfyPY0XUEEwXrrOvLNgLdfhu9WVGvtpWQR44C3j+mu8CtI2b8QPmIt/77WX+EkDD/dMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4LHJvei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C59C4CEE5;
	Tue, 11 Feb 2025 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739239207;
	bh=atbq5gGaQJhG/f9qRXyS6T4mf5Vi8I+Sp3R2VsFrCR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b4LHJveiJwR2C5B2I263dkH3Qtyocai0kZ3Av1LcP/MyXAykK8h1Ios3iKFBI+Co9
	 cr4fjzqdDk+2QJ09f/O4WmpQMboUPcbGui/cMHa/pmrKvhQGLqPiF3h5RUX86enEt9
	 9awX7ORzDjL06eQapJ38wg9SvUw+7QqDeQlJ+qQw6ouCNOe5BaXTWlY1zz0jHtckIi
	 aPQjMj6fyp6wQ1txNXdaQ0LLM4XxeVg7tkPXECxREn/mbX9kenUg69+C4XQ00ZJSVT
	 Y6SEhiQvA097Uq88PU5j/rAbCQ34+udkuLoGtWeUl50eDm2Bgk+Bvn1w3/SEdrJsDo
	 ihWmSSVsr5pLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3C3380AA7A;
	Tue, 11 Feb 2025 02:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83td510: introduce LED framework
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173923923552.3912925.4342744972876594638.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 02:00:35 +0000
References: <20250205103846.2273833-1-o.rempel@pengutronix.de>
In-Reply-To: <20250205103846.2273833-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Feb 2025 11:38:46 +0100 you wrote:
> Add LED brightness, mode, HW control and polarity functions to enable
> external LED control in the TI DP83TD510 PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/dp83td510.c | 187 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)

Here is the summary with links:
  - [net-next,v1,1/1] net: phy: dp83td510: introduce LED framework support
    https://git.kernel.org/netdev/net-next/c/5b281fe7e396

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



