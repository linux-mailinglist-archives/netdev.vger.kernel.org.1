Return-Path: <netdev+bounces-79722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D534387AFA7
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE1E1F2BCA1
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF478296;
	Wed, 13 Mar 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhNpFhXH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D178273
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349829; cv=none; b=um13rxywikHwNcnfmxm9sMs6QTteSsYuFV6S4ppBsFPz0GHYPX2pdYTQGUpVHaPcuIahTkW2TuM++Q2YIyF7FMo1J0suDkI27KGx3C/IHUHndi8c/xpHYU8WeyD5GdkVgnt5n20KqmiugWl5ko/0d/QP+ZHNn/fM6z+Z8Tqmtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349829; c=relaxed/simple;
	bh=YSI1ZkeG+jQ78/jWn35N2JUL2sM71jOcBzjFswvwMAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oe2FadORwE4FNSc+w5fXS+p2bH8c1pp2M3fNFKgyCiu7Ta2s2AfCfgktx8dF81VBEs6nG40m8f4JDOChDiGah+9aMir07J7fXUkUPyAhW8b4NMu6/vWxF6jWkl9OnL8lWSfo5+bq7OXBIYeMg0tCrFrIzBl8bZ0dDHHJ8F34dWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhNpFhXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6246C433B2;
	Wed, 13 Mar 2024 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349828;
	bh=YSI1ZkeG+jQ78/jWn35N2JUL2sM71jOcBzjFswvwMAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EhNpFhXHej3t173XSe2sBdGY2GKt/hlmMG1ltvlMj9L1zvvF19Wz8MkZhvOKYE1Eq
	 1gsMTPzJRykN/inCYtdG6N75wMLGR/LEZnmcZkefYaVZ2uGHCrPZOnANYz4huVsEpq
	 bLUY2o4erq14lqK7mMCBTVEBwoEUjRhFWRwg4qJbOd+zTz4K4qxZRzrSnOKbtBMSC+
	 jlTIOBLsn8jRkHP0ffDWFjhCIQJxZmtb+SR/IjLp7id4g8r9sSHKGPXcbKRrUT1Bmz
	 Y8Tl7hVE5E3cGWrxL5xQ8pHyysbBSBSJ/Hu4U6/Mfy8EFu95Yxanr14ffAvPlMBoTN
	 +ntt4y9v4SwBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C094D95054;
	Wed, 13 Mar 2024 17:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: fix typo found by Lintian
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171034982856.13122.386503104325664882.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 17:10:28 +0000
References: <20240312222422.2494767-1-luca.boccassi@gmail.com>
In-Reply-To: <20240312222422.2494767-1-luca.boccassi@gmail.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 12 Mar 2024 22:24:22 +0000 you wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  man/man8/tc-mirred.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2] man: fix typo found by Lintian
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f31afe64d6d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



