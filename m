Return-Path: <netdev+bounces-41614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8BB7CB71C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C722AB20F61
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342303AC29;
	Mon, 16 Oct 2023 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcZihHWR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A993AC10;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AE6AC433D9;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697499625;
	bh=/FgU5kDauKM9IPPi0zHSJGKdB5YjioF3gz7ynJlnTT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hcZihHWRQhtb73R16oYrbIzoBEccDCEXbdHSGFSK9lXjIF0WGUUDSZcDUmLrdka9F
	 c5iacHL538krCp6Yw3dhB7KuLAgbq7AWKYd477LouE5H5hHalQPRSNzKqYJGAymKFI
	 p5BhQensqb7D78UVnAdl2y6h+mVlzJPLNgW5PQGxGHKT3/zJGD2mlvyzY2HgXaKcRf
	 VY0p+h/3aVCpGp8CtSTQw6HMu6mZ+Kpcot5z+PXJumRc7tpr18a56Z5f9YMXCf5vct
	 FzcAlkXlAB8bMwt9YP5oq1Kn3p8h/AnIUnTOSW9UIA0D2Bx4Q/lJ3NMqjFVzn2ZX23
	 nrM64+vX8vzlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D77DC04E27;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] lan78xx: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169749962517.28594.16918982789792723022.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 23:40:25 +0000
References: <20231012-strncpy-drivers-net-usb-lan78xx-c-v1-1-99d513061dfc@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-usb-lan78xx-c-v1-1-99d513061dfc@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 22:30:54 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Other implementations of .*get_drvinfo use strscpy so this patch brings
> lan78xx_get_drvinfo() in line as well:
> 
> [...]

Here is the summary with links:
  - lan78xx: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/2242f22ae509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



