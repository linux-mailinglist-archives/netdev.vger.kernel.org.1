Return-Path: <netdev+bounces-48943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE27F01B7
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ABB280EC0
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEB1944D;
	Sat, 18 Nov 2023 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu3YXKGQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A46AAD
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 17:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6DD8C433C8;
	Sat, 18 Nov 2023 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700329834;
	bh=IjGq9Tn6TCqQNGvgrILNi0oe9NtJ7Ce9pw/XAhPlbk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gu3YXKGQkXMHj6zHyt6QoI8/cobanh1hErh6uCU3IomnWb6UNz6RhrjKm3Tco/wNu
	 wG7yz4gJtFlzzKCxTjG/fDVynwRdvNK4qgnE1dmWDiK8bhJQzE5WevboeYMl3SY70R
	 Dyqd4tRZI5BjrI2at8hmh5jkoVvEQk3Nn9UUTsrKFdlwz68gSps1KQqHfiMX1g5ZAX
	 dVfIG33mUkhe2nQMocF0r3gJBM/eZceqKR3OdHn8nO/D0rlaBZ0v+q7NzzPGMjG6RG
	 NLZ28TKN1DS+taow4gC+9Rs6fpbswXdfdi74susgDIzdywX9mOxQkeBbY9Aj9Z9T6W
	 vTey93ykapcKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6ADBEA6303;
	Sat, 18 Nov 2023 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170032983380.21361.9610627559571808432.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 17:50:33 +0000
References: <20231115175932.127605-2-sw@simonwunderlich.de>
In-Reply-To: <20231115175932.127605-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed, 15 Nov 2023 18:59:27 +0100 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.8.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/6] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/e4679a1b8a73
  - [2/6] batman-adv: mcast: implement multicast packet reception and forwarding
    https://git.kernel.org/netdev/net-next/c/07afe1ba288c
  - [3/6] batman-adv: mcast: implement multicast packet generation
    https://git.kernel.org/netdev/net-next/c/90039133221e
  - [4/6] batman-adv: mcast: shrink tracker packet after scrubbing
    https://git.kernel.org/netdev/net-next/c/2dfe644a1ce0
  - [5/6] batman-adv: Switch to linux/sprintf.h
    https://git.kernel.org/netdev/net-next/c/69f9aff27a94
  - [6/6] batman-adv: Switch to linux/array_size.h
    https://git.kernel.org/netdev/net-next/c/c3ed16a64c0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



