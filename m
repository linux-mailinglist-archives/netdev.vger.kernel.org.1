Return-Path: <netdev+bounces-94155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0148BE70B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EEE286493
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF9160883;
	Tue,  7 May 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+risDEu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB046160785
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094627; cv=none; b=tDPU1ldEv0pAjuTMNbDxGAPYdotrNXI6GIDIWMk0TXiEV8xEC5TaENqNlFsVGWsgxX0fbcm0PzM5iYkdZULBnGg5ZDMkdHyXaO741ndxloV2Wk/4b+BihqtXn5Ku/Q3Ap789T5aNNyBrzBF7ECH63YFT9BiqJEraq7tGv1H7ivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094627; c=relaxed/simple;
	bh=gwLsmrabydKy62LW73AWvaBrCtfv7ubdojpR32G9XpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RRZWmrzw4mn2EwvWW5x5zdI6PwP/AjLko9akzJTYkhT0JkHrKPKcUElv1h2erAAkEn+R/nMH4OkJMRB400BFQ06W0jZu1Q5/e5lVWwzBQQECCPZNMxw0+jXe4GQCr2s9WFuzdAyDBARIrsHTvQQx0B6oJ+C6z5WtSfdBDuJxIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+risDEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E10C4AF63;
	Tue,  7 May 2024 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094626;
	bh=gwLsmrabydKy62LW73AWvaBrCtfv7ubdojpR32G9XpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l+risDEuHhiaZka7pgaPcFTrPGdmpBf9jdwp/mXWu/49SO6OOOhfLKw1twoRzGC3J
	 ftrzr3gBo5w/YtdrS1N+TjpRWnLoJmISelWiLsme0XDH4/zAi6i7H41EzPSu/4Hf8D
	 4qrU6e9zVSx6dq5m4zxXyXR/8FCRxgUQva7YiGUVSm/2GBJ8RTZDuHv5H5x2O8J4mh
	 BCd2Jwil3g75y0XvJEeZCfUhWiB+rkpG06XCMyEDK7VMoolGceHLI76wSwhRKPJDG0
	 +dVb2wTtYpXY0gzLGyoxMxyE3AxWTjFlEX0LyV19TiI0aygnhMO3O8BBei0IOdsLom
	 GUMJ3DjczrTvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 756BBC43617;
	Tue,  7 May 2024 15:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: Add missing options to route get help output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171509462647.5784.11456276308659081497.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 15:10:26 +0000
References: <20240506184255.1062-1-yedaya.ka@gmail.com>
In-Reply-To: <20240506184255.1062-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  6 May 2024 21:42:56 +0300 you wrote:
> The "as", "to", "connected" and "notify" options were missing from the
> help message in the route get section. Add them to usage help and man
> page.
> 
> Note that there isn't an explanation for "as" or "notify" in the man
> page.
> 
> [...]

Here is the summary with links:
  - ip: Add missing options to route get help output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c9eab8973ccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



