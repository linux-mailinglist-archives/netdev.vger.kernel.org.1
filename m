Return-Path: <netdev+bounces-23589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781476C99A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC11C21211
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DA63BE;
	Wed,  2 Aug 2023 09:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEB63A3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6993C433CC;
	Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690969221;
	bh=FBBL9+tJkGHRFnkoEinohSYS2cAKuA1dAftMpfPbhzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dx0WB3xtey32WkEdoiknOTNzn6iFRtcvpz1iqA+t6SmPRuPOS80Z9HsH2+NHoswpN
	 Jl3XblJPbTn08DB8F5puNHStWSL7mXeGq7LfpskOuw1VLL6wBcvXycp2RwDUBwm7Mj
	 04rNtxPICCglqA7/skRR5GgOjnZ5mRpo528eSsNfnr3X/jujfUpIAC9j59nXPGed8Y
	 YFUHVenzvVezuu3ifrNeTtBVx0BQ0/zwYK5aYbO5X+N72/Mv2NN8FsDXBUyIAtquJD
	 Wtepk2Dgy6rMOQ1iSxWRfPa/xZxgRXnrc11FSNeDasrPPxx9joQDGxqnnN24hssm4R
	 ZGoW2VFY1Hytg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 900C7E96ABD;
	Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169096922158.16759.5782706555046601595.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 09:40:21 +0000
References: <20230801064815.25694-1-ante.knezic@helmholz.de>
In-Reply-To: <20230801064815.25694-1-ante.knezic@helmholz.de>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 1 Aug 2023 08:48:15 +0200 you wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
    https://git.kernel.org/netdev/net-next/c/745d7e38e95d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



