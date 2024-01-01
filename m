Return-Path: <netdev+bounces-60746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BA6821529
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 20:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A741C20A0D
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292D8DDCB;
	Mon,  1 Jan 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqN1tmmC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10712D530
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C8B6C433C9;
	Mon,  1 Jan 2024 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704136224;
	bh=mebX0WUAKuwCftisADP4Mzt0K+8TQ2SIGYdkwdDbZIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hqN1tmmClOu98vL1xbTEoHuwEB4iDBhbDRNq0yDcb7ShvhtGVBpJ0e7iVzqL77dQb
	 LDGlDv+zTrOMOTWzM9E9WFDNJ/fvgqR7gH0N6RBjLd5Gv+S8MByFMKMJd4ouAbDnWX
	 clHtHJmjFNkJbDrBlRn0iEKptTvpIpWnhYz4ZdO1sayB3bbvT95biY7I+O9NXYGoJu
	 cKWH6+M2kUZXV9FBHoGSiyyKmqmA/lJEOUXj9PYHiusOmoTSW1q4wGokZxlva4Uyvs
	 iN8Mo7y3XAvXDnF2ikWGvSTXBwtvvDDzYvh1O7AFSlt/HaFCHlGhf3Hr2DxodEKq8c
	 IoSiBgG/56Feg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85061C4314C;
	Mon,  1 Jan 2024 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] rdma: use print_XXX instead of COLOR_NONE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170413622454.12705.16311353183841924815.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 19:10:24 +0000
References: <20240101185028.30229-1-stephen@networkplumber.org>
In-Reply-To: <20240101185028.30229-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, idok@mellanox.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  1 Jan 2024 10:50:00 -0800 you wrote:
> The rdma utility should be using same code pattern as rest of
> iproute2. When printing, color should only be requested when
> desired; if no color wanted, use the simpler print_XXX instead.
> 
> Fixes: b0a688a542cd ("rdma: Rewrite custom JSON and prints logic to use common API")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] rdma: use print_XXX instead of COLOR_NONE
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9b578bbaded6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



