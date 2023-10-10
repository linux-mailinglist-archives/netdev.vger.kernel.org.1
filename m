Return-Path: <netdev+bounces-39503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950DF7BF900
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E3E1C20993
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8CDF69;
	Tue, 10 Oct 2023 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSaeTU1t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F46DF64
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB7CC433C7;
	Tue, 10 Oct 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696935022;
	bh=a9Ixs+pZD+1syOpUkOXG7aRBfv3sf5X967JIZ271tuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gSaeTU1tOnUOR9T+UKd+U2lkBtPvMhM1q9tzG+Ll6mf2yhLB6QrcpiJrFs7OChbD1
	 9qqIOBQ+8S5C2S5fefv38743sDtJKAJjY9L/GABVJQhOCjFzekOEgUgOijja3VIQp1
	 R98kF8AT7nzRQ7xpo94y6LZDarszlNISmSQbLOXpof8WrSuTfWUV2AA7ovYcu0eLpR
	 mVdFcBM8CZry6qRioTqalnfVY1FgSKHZMFTI+WmZ4gFE+eYuToBUZNaBrbY1CVmCeB
	 yG6ZdnUbsjAqLx8rsDFfvWfBlGCoHYSjttXlIxg12Di3pt27ION3Ig7Q7nD4HvqUlQ
	 waTGZHCWPXg8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F9A4C595C5;
	Tue, 10 Oct 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] atm: fore200e: Drop unnecessary of_match_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169693502211.11220.8874004135364112002.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 10:50:22 +0000
References: <20231006214421.339445-1-robh@kernel.org>
In-Reply-To: <20231006214421.339445-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Oct 2023 16:44:21 -0500 you wrote:
> It is not necessary to call of_match_device() in probe. If we made it to
> probe, then we've already successfully matched.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/atm/fore200e.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Here is the summary with links:
  - atm: fore200e: Drop unnecessary of_match_device()
    https://git.kernel.org/netdev/net-next/c/f0107b864f00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



