Return-Path: <netdev+bounces-95634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A18C2E6D
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8119C282EE3
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030015E81;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3wEqGDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946C12E6D
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391030; cv=none; b=nlBqfq2wiWXn4jxasj3+7OO5Jc2TSwyAhoY4jyPTOj/5xkGyXeM3O4O3qnTgW8+qkuNeX5+gNI9hiPAwUThT0CqjSIUJ+b9vHIydGoOoZArt9CbzakhvZtYbC+HmVyBH6Ika3n0X+yMjIls4tI6nDs5PneCIGQsAVMtYECVM+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391030; c=relaxed/simple;
	bh=DhQEninhMlCW+OKC6s4F0yxIX4Nxk+eSME1mqDhLE0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IBj9csLvO6TdLixVHDY/G3A5jmSgnh/sbU4JUimzIG5jsUyU1hsOnPLQKAUsPozJtv/AVaD8dA8daCUZcMdxpMKbWSNjt5kRZl25GzAVDxuN2FtF0W4EuBZnZpy0tRPm5V/iaLW+h9OZTjpbAqGS9kKluNAUr9N2BzupUVmEpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3wEqGDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16202C4DDE3;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391030;
	bh=DhQEninhMlCW+OKC6s4F0yxIX4Nxk+eSME1mqDhLE0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h3wEqGDASTHQXmhA8ztXhE3o3YVDFBceTp8dQy6PgseKSSXcHUKYiffESNnQYpvd1
	 17rq4g3amOaxIEbn1b/DebJJbEbgsD7ymneKZmyhoVwjNPeoC941NbxuGuO7NO/RVy
	 uBBbBSblsbvtc5SXKi5Mf+T+yvR8vXLs1YBkaxeLCS0Si/9Bq7Fj8yo62fSQUN/rZT
	 YLdk7Y4Q9Ha1WhDCiL9daK+u6CnaLBmgZq1Ge7yQC5WDvFEdvN4CEaeQlPNgj4zFuT
	 brzc6hPg8biYtMf3Nc8vead6mWMQ5NjakZhIHF5zKNt5hILNtMt8MBZkYmjdUrzMDg
	 vlhKR8r8Wt9sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CE36E7C114;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: silence clang build warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539103004.31003.15728296406600592225.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 01:30:30 +0000
References: <20240509151833.12579-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20240509151833.12579-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: michael.chan@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 15:18:33 +0000 you wrote:
> Clang build brings a warning:
> 
>     ../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:133:12: warning:
>     comparison of distinct pointer types ('typeof (tmo_us) *' (aka 'unsigned
>     int *') and 'typeof (65535) *' (aka 'int *'))
>     [-Wcompare-distinct-pointer-types]
>       133 |                 tmo_us = min(tmo_us, BNXT_PTP_QTS_MAX_TMO_US);
>           |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: silence clang build warning
    https://git.kernel.org/netdev/net-next/c/38155539a16e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



