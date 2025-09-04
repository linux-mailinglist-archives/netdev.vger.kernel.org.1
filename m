Return-Path: <netdev+bounces-219971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11CAB43F78
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6731CC2A14
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D11311C39;
	Thu,  4 Sep 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL3yW5WO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF830E837
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996829; cv=none; b=f0Y2E4uFTV1WfKdJKViMRfB1Qkriuece2/oClmujPkIyyXtySykmLvF2BMnMfC8bBKAihAmHgQmI/sY49J1m4trWgfRFO61cWvkpXH1W86aXw069GSgs2DnsxjiA+qIl49spswh/l5C+cTBmoMiAqyi2QYyWZ/1RyfS5r4whPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996829; c=relaxed/simple;
	bh=iRpZbWTTVO6pnYK2nmAaWkaAuh98yany+tbMCO/q36c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FmHLCu3yPxPfptQpOF/Y3RWgoiwlCe4dhXXzuFF74FS7OS0nd3g+yOptlQeesMGiWE6QfAZtLlilNSpnAX/pIbvvIBEqOiJPdPLBGeTyKETZ+TFuhD/5qZ2bMY17uShManAbgtY0xSdDUBnWCNRPssIkgbLxvZbn64EgYBx0gU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL3yW5WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4ACC4CEF0;
	Thu,  4 Sep 2025 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996828;
	bh=iRpZbWTTVO6pnYK2nmAaWkaAuh98yany+tbMCO/q36c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BL3yW5WOCjIlGNjv5+xRt+a5YHRe311pSGMylirFZZF2zkFFBsIaj8GDsS+eOk4lR
	 Rkp0Jc0uz4c1YPwxnHwN3hMgNvQmH3esN7yoYlRTTrGTB5NDt5UkuefKaRiBV4r6ue
	 CeTz49pWkbOdJ4aGlPi8biD0Z39D6TOnRo3sn8kPLyQbOA+fLWOSQH7egMmLr7zy5j
	 E8S38YqHKrizVkdRcwTSWP9w2Sv/AZJCKsii+QXqajF2axDh3E6GWfg9FCqSFooAcH
	 sEF0JIdybzx+Hc0sXqH7ObZetMeVuMvhVGfYP8RPBWtxzXdags8aD6yFDWZ1crETI0
	 c41Xt+HyN0+8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE40383BF69;
	Thu,  4 Sep 2025 14:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add Sabrina to TLS maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175699683349.1834386.2234858409679400209.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 14:40:33 +0000
References: <20250903212054.1885058-1-kuba@kernel.org>
In-Reply-To: <20250903212054.1885058-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 14:20:54 -0700 you wrote:
> Sabrina has been very helpful reviewing TLS patches, fixing bugs,
> and, I believe, the last one to implement any major feature in
> the TLS code base (rekeying). Add her as a maintainer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> cc: john.fastabend@gmail.com
> cc: sd@queasysnail.net
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add Sabrina to TLS maintainers
    https://git.kernel.org/netdev/net/c/6a989d37302a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



