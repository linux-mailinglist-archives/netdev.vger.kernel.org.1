Return-Path: <netdev+bounces-132920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D0993B9A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBB8B22714
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F310E5;
	Tue,  8 Oct 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3/Iob4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A64125A9;
	Tue,  8 Oct 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346229; cv=none; b=tyGJ26HOSzJwMOP00nv6Z+rWWIAvYDRfxdaDaxVrFA5wLyMpyMyiU0AvtfFt6vergmDLl6Z4UnkjCmpb9CDOILesu1rclX/2iuVbpVCF7u1DCad+831oldQVsc/IIN7zO0JjuXQ0fQJmt4eb9fJTTHUJsrhtVjUyCUKA8u/Hxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346229; c=relaxed/simple;
	bh=Kk09PQS3oCuPtKtIE6S8+QHxHgkBjgANzah9mz6hZ94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FbUfm8Q2WGWKPa+z3PAhVoemmOM10IISRf17ruO/f4GgiLpzl1KYHeLUaoSZ0iNpCL2ulJqFBH09hbn4XC6X9xThZLI0I0sbkroef4QWHaY3VFh3MrnO0lwRjhwQGxVSmLyl3eQ2ngeq4Kg4dkfRGxyD6pgklySi8R8E1qDdTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3/Iob4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA02C4CED1;
	Tue,  8 Oct 2024 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728346229;
	bh=Kk09PQS3oCuPtKtIE6S8+QHxHgkBjgANzah9mz6hZ94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K3/Iob4m2WNsuCaLCK+v6aAhMGeqiGPVSuEtTEYOxsMvMOcl+UGdPBGhthZxvbvi8
	 KC/K8gcrACZVT0HrIOafzamx0+qlV1LLQ1pNIvl7Ukq8arFkKwmVGFqLy4/rOkicMF
	 SPV+GpsGm3WeE3a/DcLup+TeN/agRp1bAaI5zvHUucnyUWJtHOdEwtJfnbj3NU9gn2
	 4zP9Wl2PteCZcftKayW4Qr/h2QGKt7szqHgGLltrcazbou2RwhcyN5vME35OLT7js6
	 F7I9l8G0Cc42yrVVWqkz38FFeg15XSwyzc2XynMri4nXlIyV8w8aEb3zhzzGdIjyiv
	 hbpKDTJxntkaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714973803262;
	Tue,  8 Oct 2024 00:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: realtek: Use proper node
 names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834623298.25280.7456124815652757089.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:10:32 +0000
References: <20241004-realtek-bindings-fixup-v2-1-667afa08d184@linaro.org>
In-Reply-To: <20241004-realtek-bindings-fixup-v2-1-667afa08d184@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 04 Oct 2024 10:08:50 +0200 you wrote:
> We eventually want to get to a place where we fix all DTS files
> so that we can simply disallow switch/port/ports without the
> ethernet-* prefix so the DTS files are more readable.
> 
> Replace:
> - switch with ethernet-switch
> - ports with ethernet-ports
> - port with ethernet-port
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: realtek: Use proper node names
    https://git.kernel.org/netdev/net-next/c/7651f1149ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



