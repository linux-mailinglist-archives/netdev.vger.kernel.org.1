Return-Path: <netdev+bounces-56613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A907180F9F9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BCE1F21481
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B164CD8;
	Tue, 12 Dec 2023 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPfMD2TL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD694C93
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 22:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F14BEC433C9;
	Tue, 12 Dec 2023 22:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702419024;
	bh=/cBV2LgiMa+Px0IjSNDt4F5OXTW6VUiS5uxEbUPmv1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LPfMD2TL9hSlI27wjB0hxG4MYvGnPcpeP0jbihQONdoFBXctnn14k1m7yc5ULwFou
	 /PtrTPunWRR9SOgsKFECqtz9K8DSiPaezccXWomufDP+gvC4s4J9cSqILPQnUdhNdC
	 S51nH2k5iNI/awZLnAJ4LpWiEcQLSL/1gGMlJhCeON11fb7+lc6oeEslHvgn1lQQgW
	 G5Y03oeewti/WyCQz9rP+9sk5zwWx/mznJ1ptdbQ51mAnNs39RQWS+LYHsWHyEatmX
	 g4tA0L7Eh+DpE5t7Z7CFjkeCnreysNuuYroA/wLJ9wiLKiytSwiUnT0/4uFmf9bWl/
	 GT2jxHMefE02g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D21F6DD4EFE;
	Tue, 12 Dec 2023 22:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] net: asix: fix fortify warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170241902385.2523.3221472990711527162.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 22:10:23 +0000
References: <20231211090535.9730-1-dmantipov@yandex.ru>
In-Reply-To: <20231211090535.9730-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: kuba@kernel.org, l.stelmach@samsung.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 12:05:32 +0300 you wrote:
> When compiling with gcc version 14.0.0 20231129 (experimental) and
> CONFIG_FORTIFY_SOURCE=y, I've noticed the following warning:
> 
> ...
> In function 'fortify_memcpy_chk',
>     inlined from 'ax88796c_tx_fixup' at drivers/net/ethernet/asix/ax88796c_main.c:287:2:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
> 
> [...]

Here is the summary with links:
  - [v2] net: asix: fix fortify warning
    https://git.kernel.org/netdev/net-next/c/2a6264480020

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



