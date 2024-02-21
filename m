Return-Path: <netdev+bounces-73673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7EC85D845
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA1E1C21F92
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B269946;
	Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdUde/Ay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68536931B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519827; cv=none; b=EM/y9JC3Z4ME6rdO9LUOQmeirdh0AmDwmaoWCDy9S8W0Yx3xvKLRoAvt6A9L2JhAZjpK2X/WTCXgGiwQxKNSe9ZSA7Zby0eaNpJAwH+1MDodlld+ZZKR6HkFuxzjUs4lKNIHa/TqEqe8PA1XLG3Rq3P6J6OODS1DoBQK272kDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519827; c=relaxed/simple;
	bh=ewJpZ2nMUOKqPE+DlEznF/WGnHZNW/crdyWx1I0J+/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wko0iq8tZB1vxy9R0NkMxE/tbOeYXHt6YCG0EWUAs+nJcbo0gswAZUMtqaZCdglSNVQKCS7W2jBU2oj2rxj+8W738O3AfVMLbmvhiTLanTobUpGKkmGGADFn4MZRAeje2OMkaKdz6N8avpgweKkSE1Uli9wWii2rHhNN76MWABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdUde/Ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F39C43394;
	Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519827;
	bh=ewJpZ2nMUOKqPE+DlEznF/WGnHZNW/crdyWx1I0J+/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UdUde/AyaXvPD7vKnTeDu8ooL3x1X7+Otr364jQGPRCRy9kPRcIZ622Dh4zIFtQaF
	 xBOz/72jtxQJNW+runv+H2K2bFtMBq7oZhhzZSlqa5d5E2wMcni+GbohuXnWDjrlxG
	 8IEurWA60E2/GYR4mK3gjaXZqcbnYZCUyaCWFKRyfbvo6Efe7JohfWLfTh90bc3qb9
	 Hh8FH78KcbLO2k2qC9OIRiN7vP/djCOhZuhpUJLlv0pGDV9z7D3jsgcE4yx853TCAj
	 lFW925QSFXcOjVKSizFQ+byvtx/Oc8GqCMhtCrz17zJ0t/Tqj5OFE/QFSLHW23lfGj
	 ACTxpLkVf/a8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 227BED84BBC;
	Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Add framer headers to NETWORKING
 [GENERAL]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851982713.28838.5644868110027134439.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 12:50:27 +0000
References: <20240219-framer-maintainer-v1-1-b95e92985c4d@kernel.org>
In-Reply-To: <20240219-framer-maintainer-v1-1-b95e92985c4d@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linus.walleij@linaro.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 17:55:31 +0000 you wrote:
> The cited commit [1] added framer support under drivers/net/wan,
> which is covered by NETWORKING [GENERAL]. And it is implied
> that framer-provider.h and framer.h, which were also added
> buy the same patch, are also maintained as part of NETWORKING [GENERAL].
> 
> Make this explicit by adding these files to the corresponding
> section in MAINTAINERS.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Add framer headers to NETWORKING [GENERAL]
    https://git.kernel.org/netdev/net/c/14dec56fdd4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



