Return-Path: <netdev+bounces-94330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AB38BF32D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66A91F204C3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA51369AA;
	Tue,  7 May 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR8Sn0Yo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0186270;
	Tue,  7 May 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125831; cv=none; b=hmYt33qL0FuQ7eRfeSdPAwP739THCsq8yRaEmTCsLEb+mXjrQU1iRwJgSukutr78+vvibf4KX176ZvO+7uhzFDCkMZ9Ljc1FJrLS5idg23o+86jpkyPRg7Pw0t38bt3B/kUR0b09I1n4lq/Xqd27jBJ9L+Q63IM48iqBIlEa7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125831; c=relaxed/simple;
	bh=ymLusp9HvAsSRqbe7FKDrLxKZ+auGS8iJCWYfhctzYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HwCvQxG7vq7EVJskUzjCHiYNGuFJdG5KRu+jNI/IDPz98vKgnbbsc/ZWj4txlz5pcDVZyU8McblLltTrg4bGFqOzKJ75f2EbLzT+/q/rE1AB2awC9KbuuSotAKLEKAvY7cUT/fgj4eHAVtQp2SkPR6z3tP0tr9XrOpsFuJfzig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR8Sn0Yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6DEFC4DDE0;
	Tue,  7 May 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125830;
	bh=ymLusp9HvAsSRqbe7FKDrLxKZ+auGS8iJCWYfhctzYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hR8Sn0YoK09MgQrTevsmfd0NCUNi9hgJ74qVWYIwe/hCNwVANh2mJkpDakFpbfArw
	 oftRkWlrt4bA1AZ12QIjr4kv/2FZ0om7TZ3Yj4jfmwM8FxolsjVyjHECv+/l0mzTDO
	 fC/FBeaZvajB2z6C7FI5tPsF8faOi2NjpLoTUTi3u54Y04wexzx4XD85JTVlUdHE7K
	 xyeAnjtFYm7A99gmtu7Y19IoQ/gHJR5PIxXM8y9UXFHcDOibXTsKc8TJO3s4qYp3xl
	 C0D9AZF0L+3QOBsVp30UY5di6/OzOY1JI/65BbSeh+aF8u5V8Nwtsedeh9RsEV0OhV
	 4Ucwr/n2c3LPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD5C2C43614;
	Tue,  7 May 2024 23:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] lib: Allow for the DIM library to be modular
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512583090.28510.707010832764731977.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 23:50:30 +0000
References: <20240506175040.410446-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240506175040.410446-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jgg@nvidia.com,
 leonro@nvidia.com, horms@kernel.org, akpm@linux-foundation.org,
 talgi@nvidia.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 May 2024 10:50:40 -0700 you wrote:
> Allow the Dynamic Interrupt Moderation (DIM) library to be built as a
> module. This is particularly useful in an Android GKI (Google Kernel
> Image) configuration where everything is built as a module, including
> Ethernet controller drivers. Having to build DIMLIB into the kernel
> image with potentially no user is wasteful.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] lib: Allow for the DIM library to be modular
    https://git.kernel.org/netdev/net-next/c/0d5044b4e774

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



