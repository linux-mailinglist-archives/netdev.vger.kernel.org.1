Return-Path: <netdev+bounces-99940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2EF8D727A
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BEC281DA6
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A661D55D;
	Sat,  1 Jun 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekUiqYeo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0392E419;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280434; cv=none; b=ct7uJVPlFepP4bTqO+Y+7jzeWDRVpAIhl1ynhRZ137H0uACtmW9z7OU7keCs6Ly0GvzVpehkl9M1GSJJos8jHwPu2D/VbA8bXrIdGcdpFgi6aDOFxq+0y/6X6en3PohD7mlVLRKqMjczKep98CE48Jk8tu0Wn9vwEhQxIcWEUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280434; c=relaxed/simple;
	bh=XjnMD6a0hUkG1KgGrbiFtD6v/4f1oiwyGF0enDh1n+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fr0rIpGNcG+RHD0jWrW/HFLv0w8SDWheZM88N/PwVfyk443KSybIiZAQEXNrNqhuwUWadxp7WsGbGXIIRYQkXBtUTUZ/JeFX9MKMkc2EoIftIb1CC6r0Y/Aeqqq/uZ4ZqIHHmcMfuJmsLk+QSBv7DqNauaH+ZEMQunaDAnVXCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekUiqYeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39B61C116B1;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717280434;
	bh=XjnMD6a0hUkG1KgGrbiFtD6v/4f1oiwyGF0enDh1n+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ekUiqYeoHGfJo3C0gtOnWBgFwO5WDy79EAtDlmTBybfrdkz0BTrnaQqgS5DI6nHe+
	 tr40bK8/gYmLq/3R+zknufiq/iO38+j8o1x/evOOX0w6y9u+E/OOHGn+O/yIS9gbe9
	 eTqM/kyE5V7SljxiamDeR2UuVUJSQAds4yDhTTrk936UyFzbDmiTBnRccgWxFHG5Jx
	 iRw4FhjkZS4UUMIQkP3k9hfDGXG7fL4qwjuTFOIi+wDWuT56fnGneKCfvjwHiu6TgH
	 6H7+wnfvojc9m2RNeen6j1fnl/2eboAn6JCruSA9X4PgfDUALPipm0/lzhL/JdK83u
	 eQGsv+oB0tN2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F3DFDEA716;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v3] net: smc91x: Fix pointer types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728043418.17681.9343305042987013067.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:20:34 +0000
References: <20240529143859.108201-4-thorsten.blum@toblux.com>
In-Reply-To: <20240529143859.108201-4-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: nico@fluxnic.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, glaubitz@physik.fu-berlin.de,
 andrew@lunn.ch, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 16:39:02 +0200 you wrote:
> Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
> to align with the parameter types of readw() and writew() to fix the
> following warnings reported by kernel test robot:
> 
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void [noderef] __iomem *
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v3] net: smc91x: Fix pointer types
    https://git.kernel.org/netdev/net-next/c/6d9e9c36e1a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



