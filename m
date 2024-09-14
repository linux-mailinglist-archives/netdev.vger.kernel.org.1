Return-Path: <netdev+bounces-128270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5117A978CEE
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11671F257A9
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E923CE;
	Sat, 14 Sep 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaojS8nG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284318EA2;
	Sat, 14 Sep 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282835; cv=none; b=EMF0VjCPv9C7A2ysVXeomVoM27ehRYGDBRDJqr6uBMG90zCN+Xl4eT9sOgfbhgADmHeyTs3f5jgbpOTUqCZ9SVWA88WW+ttts67JuVtJ7uHMA+DU8PZeKtSRZ88syOR5yKlGQo+kq4NyN+Dqk0MlvGLvr9RVf65pw1Ln8cQ4eVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282835; c=relaxed/simple;
	bh=vdjolh7I7BGGXQqO/aOAeiLLTNhqGa31sBVBIzGf9vQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGqR5HaPkGtthYCYRR+LVTIE5U06PCaC+5SNSDPks5iegVgnV6DJTdtivArnUmSRBjGW1aXJqzqMjKiXznsrnHUuH2Sw9xxP0p+HxWlrUVNIWUPNyTAmOJQEMkznmwtvcOtplKIw/LMsL1tH2yxOlNJEB9jkh6Dlo1A/nUYE+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaojS8nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ACDC4CEC0;
	Sat, 14 Sep 2024 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726282834;
	bh=vdjolh7I7BGGXQqO/aOAeiLLTNhqGa31sBVBIzGf9vQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RaojS8nGh8g6x7ounBShSkZAYPj8h0JutSvZxWxGp1B6R43OfhLzJuu72RoiUN7gH
	 7QGzOG22LR26ryXGQGDUse0uOd3tutFio1M7lIwjVm4DA3ogHO4zfmO0kbSI9feIF8
	 gfxhujXaxbixBQW0qN7oV0IoO8/3jVKpbGJt59Mrp/csqlfVWTNyKakZQpQ38+EUHd
	 q7MEO459d4DkPkwi6CO9dLliGHRdAAuwUIXzg+yji1KfNiv8sPo2YPBUfOhIkrVkQD
	 fhHDhNWJXXM1vc/msnPZzsvPGUCg5agibV6RoMbukXpOKDZBQm08isHtPhD7t1u8sp
	 tEOlHcFk1OO9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C333806655;
	Sat, 14 Sep 2024 03:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2024-09-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628283574.2435669.13261947732320394840.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:00:35 +0000
References: <20240912214317.3054060-1-luiz.dentz@gmail.com>
In-Reply-To: <20240912214317.3054060-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 17:43:15 -0400 you wrote:
> The following changes since commit 525034e2e2ee60d31519af0919e374b0032a70de:
> 
>   net: mdiobus: Debug print fwnode handle instead of raw pointer (2024-09-10 12:24:17 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-09-12
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2024-09-12
    https://git.kernel.org/netdev/net-next/c/ef17c3d22cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



