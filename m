Return-Path: <netdev+bounces-27978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644D77DCE5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C72528183F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98078DDA2;
	Wed, 16 Aug 2023 09:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09BBD536
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B9CAC433C7;
	Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692176424;
	bh=uSTcWjLp4N5Cr2xu7REm/FfCqnACkJAtZHC0YXdrgfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FIKeiF99zAbPeA6ONApwkHBzK3OJYJBCCUA+qLDi6gI8BvxVqtY5wsNKE4NP1fOgT
	 FYvJmvSsdmX/OwH92a+moUWhggcJMqEvHJHJDJRyhKMBph2KQhVZOjad3dxhG8Bh2l
	 AegSanqlW5lDCrk1A4hfU3BspnN/b3amTcJOZLjjpDLW5SPos48Oota969spj8r2e6
	 uZwx6onaU0aZeZkvdQOl0K3fbiCwpl/RqtNTcsPT9qxKB3RI6MPJRIMmB0wcmLwNZw
	 186m8IKkxg0BB2L+ypeeFxB3o/zzsZKOY9EEBhirpwdMQpss2xoXvUdmr8cvbkNhRT
	 7TVhYv+TLBOFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D93CE301F2;
	Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] nfc: virtual_ncidev: Use module_misc_device macro to
 simplify the code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169217642405.25260.12605539730482511857.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 09:00:24 +0000
References: <20230815074927.1016787-1-lizetao1@huawei.com>
In-Reply-To: <20230815074927.1016787-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 15:49:27 +0800 you wrote:
> Use the module_misc_device macro to simplify the code, which is the
> same as declaring with module_init() and module_exit().
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/nfc/virtual_ncidev.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Here is the summary with links:
  - [-next] nfc: virtual_ncidev: Use module_misc_device macro to simplify the code
    https://git.kernel.org/netdev/net-next/c/61a9b174f461

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



