Return-Path: <netdev+bounces-20636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD457604D6
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B13D1C20CF5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AD57C;
	Tue, 25 Jul 2023 01:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5748137B
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29EDEC433CD;
	Tue, 25 Jul 2023 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690249220;
	bh=tRJ7pi7m6oxSZCtNSktxOKtGb9f09IoQYhzAxWhnuwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bUosHlXqfE14xOp4j1aYvCcMG3Sb7UvD3oMlXox++byFhpzeVZXHKHvSOF7DA/jFV
	 FgZ8U6FWnDg5mRDu6fDrsOX2iMPfmOVuNfGSO2C87tb11IXsFAu4mW5bfLsJ9mM6tK
	 cXLYJsRFrVFP6B7wN9JMLDka+HVxMdRbDPc7RsSz8FYqrPowOL2Vpmqm9TS91S9pfe
	 cbxdvtvSum21jCbpIt6DxFZk1FW62NyZlfU0HgyWPyY6NMbShf3LyaeKr57zsuS03k
	 MVaZ6F/z+N9s31cH+CQXJLDEZJyEosHrbpmInMtj/3chrTj83dyTAHIqr2dOlntpVm
	 2O3/RUNMuUg9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05DB8E1F65A;
	Tue, 25 Jul 2023 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] bridge/mdb.c: include limits.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024922001.19916.13245513401353287660.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 01:40:20 +0000
References: <20230720203726.2316251-1-tgamblin@baylibre.com>
In-Reply-To: <20230720203726.2316251-1-tgamblin@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 20 Jul 2023 16:37:26 -0400 you wrote:
> While building iproute2 6.4.0 with musl using Yocto Project, errors such
> as the following were encountered:
> 
> | mdb.c: In function 'mdb_parse_vni':
> | mdb.c:666:47: error: 'ULONG_MAX' undeclared (first use in this function)
> |   666 |         if ((endptr && *endptr) || vni_num == ULONG_MAX)
> |       |                                               ^~~~~~~~~
> | mdb.c:666:47: note: 'ULONG_MAX' is defined in header '<limits.h>'; did you forget to '#include <limits.h>'?
> 
> [...]

Here is the summary with links:
  - [iproute2] bridge/mdb.c: include limits.h
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9d82667cc9d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



