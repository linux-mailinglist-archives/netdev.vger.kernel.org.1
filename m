Return-Path: <netdev+bounces-39415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4D97BF116
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F58D281E7E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622684416;
	Tue, 10 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKQw4vyv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E715AE;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1F38C433C7;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906225;
	bh=vQzSiuCATAwGdJtH0YWDno7u/yoU+dljPFxsH6KnWEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZKQw4vyvQg/56URuiDdMtGNwa1kC6xvdq8mx95Z+2idwtWwWPhG+Qtd61evsbkzhc
	 C+y0GI27nPRu5VwACcGlA0vQg+gt8jp5D40xxO37CmIMU8Y80GKhXKURY3xDoowJdj
	 DHpu0uxR2JtBDmNWyTSA2Tzn8siGVLDX+IEQkPXVzCWDrCeXiJ1i5JgqSs7Y0AsL0N
	 PTTWXORP2V2825kn43Hrt5mw2mq+lF+k5BlvIOP4M4zkktRHciXS5Zjg7Zz8LUkigy
	 Z13zYvKT3vZSEFEtyCApFCUGYGSi3JciDKc46+HPNhTmhmRPLWwU1Stp0xQF/ictlU
	 3NXdLxZUpdgrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86743E11F49;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] liquidio: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622554.548.4115453314058639791.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 21:55:06 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as rep_cfg is memset to 0:
> |       memset(&rep_cfg, 0, sizeof(rep_cfg));
> 
> [...]

Here is the summary with links:
  - liquidio: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/a16724289af0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



