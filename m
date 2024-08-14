Return-Path: <netdev+bounces-118285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650F951269
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C45B23E9B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037A49650;
	Wed, 14 Aug 2024 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHsLBaGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF81C680
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602638; cv=none; b=E2y1xNT592Ou3Yu47O2eYsPwmLYMJgjpkxpWgChX6bBIo9OVC5x61idDOytZRhghFTK7Vn5S3QczQ7CIJn4pJHlIX0m61zOA6S3okVPM0XrrdGZwin5Pd6qav8uckRzH8Xymog4MjonNo+6IHr1PA3O75Q1xoYx4YVU2+N69YAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602638; c=relaxed/simple;
	bh=b/0nCSWcts7zhFkW6ZmmAx0JBYDNjhlIIKvcUs/hrGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8yws6+QAtwd+1cN1mJCo9zyeQ+326E2libBqzSJevohpHhdGrnooFLmcR8jwGPbG4nWEyYhPzE2D2Ur+ONUXZ4jqrJqamePr6NSBu9wxLwTBmVxw+QU7jCDCagt2NenCiZUWxyhUGFR5znu9M+9Y4wOp6rYr6CEHD/XtVt95s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHsLBaGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BE4C32782;
	Wed, 14 Aug 2024 02:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723602637;
	bh=b/0nCSWcts7zhFkW6ZmmAx0JBYDNjhlIIKvcUs/hrGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XHsLBaGse5IOdnmVk6AbOTbg1jDG5CpYAv4YR76L4eha+0X+fsjrB6CHQtfX0pf/M
	 I9rluZaRDLF3UiNrDW5uG8W4xlTiXtkioLtqtwGpqkCmA4zseicckFq8Jv0Jnbn90N
	 /KFVIjPMhodZd0tUs1WJ40ypA36+CZD8mJMkKNL5OiYVUjjcvFaodWSPG6q8fZ4jCw
	 c6mWcp7f6Agr72Z79EHrF+cp86R5R1+KpoQzUbhmAWNLXyKktzhukiEJVVl4+G8OHN
	 HqGbmXf8I4GUdMgWIwv+damgsyVZtDbVNM0vVvNEZ7x+CS6cnkahZynH21EXfAUdfF
	 yJUOMRJNOy29w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2CB3823327;
	Wed, 14 Aug 2024 02:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: microchip: ksz9477: unwrap URL in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172360263624.1842448.969911821179362586.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 02:30:36 +0000
References: <20240812124346.597702-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240812124346.597702-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, kuba@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 12:43:47 +0000 you wrote:
> Keep the URL in a single line for easier copy-pasting.
> 
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/dsa/microchip/ksz9477.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: microchip: ksz9477: unwrap URL in comment
    https://git.kernel.org/netdev/net-next/c/712f585ab8b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



