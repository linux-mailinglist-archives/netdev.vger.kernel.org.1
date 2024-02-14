Return-Path: <netdev+bounces-71654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1BD8547AC
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF5A28E6C3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AA171A3;
	Wed, 14 Feb 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5Ns38h/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69619199BA
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908426; cv=none; b=Zgi7O+Ju9L0jzKdppgm5E+oDPzFpHk0R3o4UxaduYghINnaJzCPzAeEbtsfKZp6d/EzfvHdI/NVZBCGhP+iem+o/0l0P1SeiDb33f+IUpv7crWdUrW6nE4JDpBj5Zby+Q4EvlLSXvDK6otckhYChseCof0cticcPQsA4CmsjQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908426; c=relaxed/simple;
	bh=ot48rQJGjiWAHqcqXAnAeqXXmvmicEkS8N0ez6N5r60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cv/SP3dhWpDCo3gSeQ3RMgRrTuvRDESu9DxNyKrnoqthOoNop9O/St3lD5g0cuxrgUReKcmX5WuhCEY+VJLpZ3TOBqMO1uISL/Y3ep4YrHt/7c6VabS4jwGFOflkkW42lP+DMcICKmoGqJfyGNb8KPRr9HEop8WOrIvIkslSlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5Ns38h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D91C7C43390;
	Wed, 14 Feb 2024 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707908425;
	bh=ot48rQJGjiWAHqcqXAnAeqXXmvmicEkS8N0ez6N5r60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5Ns38h/9UBaUGi5c34UEnh6UZSIuitAPLQt2/2pnXsnYIA1NEqrKS2XpInmF0wuw
	 OUpRuUPGg83qPx+bqBYVZ6iGZobiZztP32Njs4XWuyoytRlB7zTX046Y4s4IAr0ai5
	 Rj6Nm+TCjrtbgkgidJKy8BuYbcsTp6tidmmEQNh0lHKOhDa6WRHVhFmmxnsXU+sBNd
	 6Lj3b4MEIBHAosqyTjPUqqkWEnsbUzyu7j8A/+oD4Voyh+zDJLT4/X2YMmtxI4pXwE
	 BL0LYyER1Z/dEkE8wSd4+ZyXiWzEizBPV3G12361awaD9Bf/QzslYa01NBxMOLjqBU
	 VHopTM1N/z+jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDC73D84BCE;
	Wed, 14 Feb 2024 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: smc: fix spurious error message from __sock_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170790842577.10752.4092253084459431280.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 11:00:25 +0000
References: <20240212143402.23181-1-dmantipov@yandex.ru>
In-Reply-To: <20240212143402.23181-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: ubraun@linux.ibm.com, kgraul@linux.ibm.com, jaka@linux.ibm.com,
 davem@davemloft.net, netdev@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 Feb 2024 17:34:02 +0300 you wrote:
> Commit 67f562e3e147 ("net/smc: transfer fasync_list in case of fallback")
> leaves the socket's fasync list pointer within a container socket as well.
> When the latter is destroyed, '__sock_release()' warns about its non-empty
> fasync list, which is a dangling pointer to previously freed fasync list
> of an underlying TCP socket. Fix this spurious warning by nullifying
> fasync list of a container socket.
> 
> [...]

Here is the summary with links:
  - net: smc: fix spurious error message from __sock_release()
    https://git.kernel.org/netdev/net/c/6cf9ff463317

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



