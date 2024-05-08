Return-Path: <netdev+bounces-94515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9F8BFBD1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704EC1F228EC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693281ABF;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgBsK7Nb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249E76037;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167227; cv=none; b=cmsfo3j8xsJE6Zw5Ichl5tAikpo9CBshXlnkPqLL5FUBEKTM2AiRcyL2dstdRbiT6fs+uvOtPgj+sTDEFsxfwVHV0i6YqWtR28yqxAhWyoILYAoEs5mPWsQyHq8MNZp5HVxYpNtdV5We8giy04GO6ZZAhdYgE3aAF/ObtUwMsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167227; c=relaxed/simple;
	bh=4i5lrERt82jQr6FrOTmqjbLe37nW9zgVFH6lNri8JKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DfQE2l9l+0MryOzQMAzracWGqUA6q+G19oNKRRnFYHukbSSZmO8Jx3fIKKq6VCRqXB5rz9cLA6E4BoxudVeSWd/JCEqBixKyUS0MXy31tzrzgajoeEwEj8/C6OXjK+7B6+Qe/NoJjgIfA3jDKHzPjy7ZshLpm6nyx4U+WpX+Q0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgBsK7Nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D972C3277B;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167227;
	bh=4i5lrERt82jQr6FrOTmqjbLe37nW9zgVFH6lNri8JKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgBsK7NbMuRiljZDc8OPJRx24tAlYKlxjjJkPPxZsw00nyBQd2rt1HHgnNbfChIQg
	 wu6Xg9Z2mW63zWNqtGFb3TPlMm/UIPyBm8YiO0UPDsn8vDRRnm9mHh//Sv+9XsdasA
	 U7s8knwQOG/DQjvmU0p58Pd1ieKV2cGMXELRGNVUw0qmVnvDPQmflxbgzcV+La0ksr
	 WOU3V/ZckseLnrUTHLDTVhOxEVKe4Lgywe8Aeqkep0z3eYSnmD1YSZsh5csGPpTYAL
	 UZedc7weh/HoQe/j4rB29DrdFe9w8yprIHNvYYjFlTvBxX2DhKOkfeUqGqhqQ5yFUp
	 L40fR9Z33Kpbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57ACCC32750;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: phy: marvell-88q2xxx: add support for Rev B1 and
 B2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516722735.3007.9265134168041671372.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 11:20:27 +0000
References: <20240506-mv88q222x-revb1-b2-init-v3-1-6fa407c2e0bc@ew.tq-group.com>
In-Reply-To: <20240506-mv88q222x-revb1-b2-init-v3-1-6fa407c2e0bc@ew.tq-group.com>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dima.fedrau@gmail.com, eichest@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 06 May 2024 08:24:33 +0200 you wrote:
> Different revisions of the Marvell 88q2xxx phy needs different init
> sequences.
> 
> Add init sequence for Rev B1 and Rev B2. Rev B2 init sequence skips one
> register write.
> 
> Tested-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> 
> [...]

Here is the summary with links:
  - [v3] net: phy: marvell-88q2xxx: add support for Rev B1 and B2
    https://git.kernel.org/netdev/net/c/ab0cde321adc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



