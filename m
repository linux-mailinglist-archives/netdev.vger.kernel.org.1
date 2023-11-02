Return-Path: <netdev+bounces-45716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B947DF26E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079EC281C18
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48F11724;
	Thu,  2 Nov 2023 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfUgaVpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAE1B273
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91504C433B9;
	Thu,  2 Nov 2023 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698928223;
	bh=9ZFkjK8joE0DrTuUP9Z7RKa5d1tIRR1miySEmmgwcuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MfUgaVpVKEFN+0GmWGjWYx4+7kOWPQvrDi02LZyCGLvaYJaKKo81Uba2TI+tr51tD
	 6jbxtliQrV3IFK/Vsl7/cyan87Id7QBEuWBgT0GW7xlWKbQFRKSCp2tytNMBdyKEan
	 wnMbeow0S0ceBMsFnllzI+pZsJ3/uqHeEphYMl6UKun/MoqYHSrlwaPM6uDnFysk0F
	 1tky3ErYda/wUfOzmammznqhx86+E4QOxEtEQer1B3Huhf+Xg1WUhHKilCO6xAKlCz
	 1Qd9gTXLFNVtwKwK+PS5NLbvwQViwjCxlPE1PigtVC2h9F4vYtC761zZ4K9hGoSz6q
	 YLzzyKp03fBiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 772C3EAB08B;
	Thu,  2 Nov 2023 12:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: r8169: Disable multicast filter for RTL8168H and
 RTL8107E
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169892822348.20787.14826789912068070095.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 12:30:23 +0000
References: <20231030205031.177855-1-ptf@google.com>
In-Reply-To: <20231030205031.177855-1-ptf@google.com>
To: Patrick Thompson <ptf@google.com>
Cc: netdev@vger.kernel.org, hau@realtek.com, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, nic_swsd@realtek.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Oct 2023 16:50:14 -0400 you wrote:
> RTL8168H and RTL8107E ethernet adapters erroneously filter unicast
> eapol packets unless allmulti is enabled. These devices correspond to
> RTL_GIGA_MAC_VER_46 and VER_48. Add an exception for VER_46 and VER_48
> in the same way that VER_35 has an exception.
> 
> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Patrick Thompson <ptf@google.com>
> 
> [...]

Here is the summary with links:
  - [v3] net: r8169: Disable multicast filter for RTL8168H and RTL8107E
    https://git.kernel.org/netdev/net/c/efa5f1311c49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



