Return-Path: <netdev+bounces-116949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD494C28D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1180B1F24B83
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA461917E1;
	Thu,  8 Aug 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuHKWcp4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B81917D9;
	Thu,  8 Aug 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134044; cv=none; b=KpyYsvlsUhzEVfslmFCE7scN7eaCjuz8HtdeI21UgDDZKTRS/XK4bnGpcJ7uaM++EI+mJHrudghsMgD8zd5Rs/1Ik0zA4d6WA0KyShJyllpn9vA2CWqD09t50cJarhJgRUHoHBtJ0B6fw+4Qd/fcOaA8ZE3FfSv79lWiaoa3s7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134044; c=relaxed/simple;
	bh=PLkT+hDPeySuV8G/5CLVB9oTnsFLOVJzYmUZMSzqqps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WyPuD1T6nuGFLnRod4OdoVITqaOCyhoWtS7DFJkLaB7ojgOyflLSfFa4oC2CN7lEly3m1i8cRe8aNQbn+LOiTtIpq7YAoSidAzWC622RLQwTgz+KYF2mLLzfwdkXdVYd6pD0IjafPMH8l8CcmeZMYQLEnBxIsin8jQFSstOX4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuHKWcp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D51C32786;
	Thu,  8 Aug 2024 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134044;
	bh=PLkT+hDPeySuV8G/5CLVB9oTnsFLOVJzYmUZMSzqqps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EuHKWcp4TdEEDB+1g1dUtm/Dw9GWFSJ5Fo1Tsi3Um1jpGyJoEwckym5vcB93smE6U
	 SPHVF+vQyH7GeUhnt30lby5/xmIOoys5ojjoNcRuxmytd2UGKbYxSpx3pr6a6szuv9
	 Z8DCQKpqOUYSubthlrBmQ67/Y2O8BrBUvuNDRuqmKCzq4exhwZIA5WvfPnqvmgrCaS
	 48Ky06T9AzSrapdQ/Jznc+u6TWT/GgQCzwbvfdIQ2CL7D90TugbztIsjKRwbHA8bZ6
	 hn9kI6V1mCiI3YZwemm4lhnqULpdvmaIs8KjI61OWYK1dp2LIEG7zpjc9jn7Vza9TH
	 VfAfWKC8wjy3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9927D382336A;
	Thu,  8 Aug 2024 16:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: pse-pd: tps23881: include missing bitfield.h header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313404324.3227143.10060649623719044778.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 16:20:43 +0000
References: <20240807075455.2055224-1-arnd@kernel.org>
In-Reply-To: <20240807075455.2055224-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, kuba@kernel.org,
 kyle.swenson@est.tech, arnd@arndb.de, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, thomas.petazzoni@bootlin.com,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 09:54:22 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using FIELD_GET() fails in configurations that don't already include
> the header file indirectly:
> 
> drivers/net/pse-pd/tps23881.c: In function 'tps23881_i2c_probe':
> drivers/net/pse-pd/tps23881.c:755:13: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
>   755 |         if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) != TPS23881_DEVICE_ID) {
>       |             ^~~~~~~~~
> 
> [...]

Here is the summary with links:
  - net: pse-pd: tps23881: include missing bitfield.h header
    https://git.kernel.org/netdev/net/c/a70b637db15b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



