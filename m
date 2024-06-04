Return-Path: <netdev+bounces-100422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A6C8FA800
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971F51F27139
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FC13D2B5;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1t9aoBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F325632;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466433; cv=none; b=SaYLsSHTA0lWcSor4SsXyvDgD8PLQUhgDTnhCzRe2cIGzD29R/I+0J112Et25UyGHxXhWCO3hRMPSPtyR/XuniL8QFOrySFCHntov0cUEuJiJ+5OJ+5LhvqEEWqI4ahs2D/+k4aFYd7GgtD+fbRD509r/roJSMIWrfIZV7DeD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466433; c=relaxed/simple;
	bh=VlPmuCMSS41nnG86xnqiPUpBL7ffxHTwGbEAIFlPW+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K3oHNYDuah7QTHr1XO79qD4pKcslqOzf32k+EuXgYaJ37NFFunb2v7bF4MJ72N82z15Y8YGsxQYu+hwPvMdCKJsC4q0ZcD2Mmglr+MX2Oo4nk6suJ4bNZWVr4IRYye+/IT9z4qSTSsdWyjEYis6Ufa+kbSxoy81xKniWeTCpC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1t9aoBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 886B5C32781;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717466432;
	bh=VlPmuCMSS41nnG86xnqiPUpBL7ffxHTwGbEAIFlPW+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r1t9aoBhdAIq8SHm/C667+0Rqhk5W5FjGHfrmj4K9NOMYv04IWsXWHPTj77pm9y71
	 kYyPkLfw+Rea5+02kjmYazdRLntsrSOPbDgajEBFH5aByOD1DotkMYKuygH2Yspf61
	 iJxseZWnrfMwTPC9SBsafOC1TBEye7LSsbcnYIwoSiQMxwvJfs+pj/hQD7uOvqsKh1
	 8cCOoqFsshmdCuBJ5Ugjv6gqymLvNfsMvjIQwliyOnkZiujsqjmPz2lFqZ774OAKzt
	 K8KQz2GecT5m6HWmdiz1OiPp9lQJKQf743ESYYE44IHOOLx+iKWPrUEds+2w2HbsWw
	 00yPeYbpokbpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78B66C43617;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] lib/test_rhashtable: add missing MODULE_DESCRIPTION()
 macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171746643249.10384.12007567109924337171.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 02:00:32 +0000
References: <20240531-md-lib-test_rhashtable-v1-1-cd6d4138f1b6@quicinc.com>
In-Reply-To: <20240531-md-lib-test_rhashtable-v1-1-cd6d4138f1b6@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: akpm@linux-foundation.org, tgraf@suug.ch, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 May 2024 18:35:43 -0700 you wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_rhashtable.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - lib/test_rhashtable: add missing MODULE_DESCRIPTION() macro
    https://git.kernel.org/netdev/net/c/c6cab01d7e20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



