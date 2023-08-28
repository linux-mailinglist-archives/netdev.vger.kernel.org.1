Return-Path: <netdev+bounces-31016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE84578A8F5
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E90280DDE
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5576AB8;
	Mon, 28 Aug 2023 09:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13A6122
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6703C43395;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693215029;
	bh=DyjistNpfQlse3jCh5g2R74pkQlmRRv890yjBn+4RIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gWHjivKdsW5ws9PyRgXnlHtcMIsheDzQAhTtcSTAafbMgHSTD54+Mg0g1vyOrJYEs
	 OWjjBogoUPEhaMyJzJ9rr1w8rqlQZQlMMTKDbk7/fX+CHaqgXj5y1myozhXmufWa6R
	 IhBg/n2+uSB69ne5N6hmSYiktRibPO9VF1s5l0nS5Yhf0NErsCxuhApLL2XHLWRVWr
	 ezuB8d93yvMpyGZBifKsENBTxVxIc+96sNrO9kzUbTZF5rpI8lSIJ0Sh78BI2+EV44
	 X01QKzjet8Guxme/Jf7a/h5LAC1wj8Az3z2o+q2LgqHZ72NyZNd/ajHUm8oyIE6/w2
	 UaySH4g5OB9Ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B329EC3274C;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethernet: tg3: remove unreachable code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169321502973.13199.8379981419921280271.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 09:30:29 +0000
References: <20230825190443.48375-1-m.kobuk@ispras.ru>
In-Reply-To: <20230825190443.48375-1-m.kobuk@ispras.ru>
To: Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, lvc-project@linuxtesting.org,
 khoroshilov@ispras.ru

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 22:04:41 +0300 you wrote:
> 'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
> tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
> that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
> last iteration is not used later in it's scope.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - ethernet: tg3: remove unreachable code
    https://git.kernel.org/netdev/net/c/ec1b90886f3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



