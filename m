Return-Path: <netdev+bounces-15422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5B747878
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92C61C2098A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE377486;
	Tue,  4 Jul 2023 18:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9B6128
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01CF3C433CA;
	Tue,  4 Jul 2023 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688496622;
	bh=10gurLQ8aEgGE0CIExcSlH/8KjmglWm/++axqieklak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GAwrv0TPtnKjMEgMNxjeqJ9tPkVICgI15f20rtJz+CHqN95H+a5fOLy7Oqhz8HAqf
	 sts0uSzyyiai98d129urQyOaew9a7+SR2SqzZ/0FBjEXNaYXc5zedU/lUv5Pm+v1tn
	 BJsWmpRKh+lZ626wYA0RpUdoP8Gt3/uYdyLjG5Xgw9mLrU+nDRKBh5lmXnzusxiVo2
	 bkh5Vqf3+j66ZLBDCVSXBlB1j73X+SMwQ6Dy1tspKo55UzCT8v+vvKmHrUw3RRma1H
	 PQdVMgwa8io7YE1SVO4Xywbn9gqr+K79s1hffpF4gEOAzjlJarMLzidoyImpve7GsN
	 pRGnmLoeFNy5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D54DCC691EF;
	Tue,  4 Jul 2023 18:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: Replace strlcpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168849662186.30545.14650541055140387280.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jul 2023 18:50:21 +0000
References: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: davem@davemloft.net, linux-hardening@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 dsahern@kernel.org, rostedt@goodmis.org, keescook@chromium.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jul 2023 17:58:40 +0000 you wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Here is the summary with links:
  - net: Replace strlcpy with strscpy
    https://git.kernel.org/netdev/net/c/ba7bdec3cbec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



