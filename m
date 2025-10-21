Return-Path: <netdev+bounces-231036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D8BF422A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1529218C4B7F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8231E231E;
	Tue, 21 Oct 2025 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msxF5UYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA51D516C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006030; cv=none; b=DtyvVtmk++2q8xN1G/4yC85BVmQAbmnzvqIEbdEBwzjGwhxE8MPCKhK/r278dzOLUeqUjPsPnLlXGBlXzOhjehgdz94sLky2Y9pZXTAeak6N3XUsEaxmqXZNeVfYDPgw5acq2PXHG1fau7nAAlRBbfRb78rNmVWv7hVfQJCucQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006030; c=relaxed/simple;
	bh=eH1o5ZHQXyG/2xk+4ugRPrKfsNggQS1i6NP/OkLPnE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uYq3zsCS2dL9FqM8TkkMkAVQTM9iOVfsx179ggtU91zQZdKSv7FN0YKX8NLhGxF5a2OzdE7hXVx2My3wGdiG2aWchmgUbav+8Rlee/wK9ToezG4vNP5T2HX0v32PF8Lz1NHoF0ZeMrazcngYEO/+1vQq0aD4sbeqvbMjvcCEto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msxF5UYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573A6C4CEFB;
	Tue, 21 Oct 2025 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761006030;
	bh=eH1o5ZHQXyG/2xk+4ugRPrKfsNggQS1i6NP/OkLPnE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=msxF5UYpoPgDptK0NbxSeTyD0VL2e2uF+gunRrcI+AjwGG5i0s1JoSsqNVYgMO38m
	 kGDB1B/cND0soUR+7Ee3fw+N17+PFkYKC8IOR/FFtmKnAuu3yqk03DXiCb02vpfGTl
	 Qbhz6xyCHQ7A3WPar+OBZqxZvLrX5b3tzPyfv02s8eAnl3DahuPeRWJt2Z2wWuDoLU
	 5O8EqupWSOvEEkWrGQPQnb0YOtOw99QKsRMm5vEcicGh5tyz7PsSuceInSfUmKwOuS
	 PzRGUnLfiyi7qCqQB9ayVJctYPQFWfcPsJiN0jDHqpAqG4kM1IvxI0v5vkAwDeJTHe
	 Qoo+DPVOjL/vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC63A4102D;
	Tue, 21 Oct 2025 00:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: phy: micrel: simplify return in
 ksz9477_phy_errata()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100601199.466834.7936384476226718457.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:20:11 +0000
References: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Oct 2025 12:35:20 -0700 you wrote:
> ksz9477_phy_errata function currently assigns the return value of
> genphy_restart_aneg() to a variable and then immediately returns it
> 
>     err = genphy_restart_aneg(phydev);
>     if (err)
>         return err;
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: micrel: simplify return in ksz9477_phy_errata()
    https://git.kernel.org/netdev/net-next/c/3dfdc98d1dc2
  - [net-next,2/2] net: phy: micrel: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/ba397fde5e99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



