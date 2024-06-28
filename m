Return-Path: <netdev+bounces-107788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B091C590
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CBF1C223AE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5B1CCCAB;
	Fri, 28 Jun 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN5wXxvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E43398A;
	Fri, 28 Jun 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598994; cv=none; b=WxgLlTz3t0TgGgUZ/DkVDEft4kWHcbwGYLqQX+AJizWeM95ikDa26esPUiECIQVEf0dqWmlp8ezgpoxdDLr4CtIXKW3EqdO9/bAWpTYXf435kWEkchKXIxdLYWTzZ9yfckTMPkxsbf5fAztgPOJk1XgqlmU/aV9L/FYu5RHntO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598994; c=relaxed/simple;
	bh=VgqlBTVokuVUyDFkGjbbMofGXQspC+XA7a9T4ZARWe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aaEEuOgmZLWj9PMXjWXJ8+N6yZkjO64sYfCFJO7rOM0IKgla+8do1zGQyvR0advfdTpXG5jf6vNnwMBKmUayl3RrfdoCxok19VMc1Mg/M82Rr7A4o7GKNScdiCRSVwIW82jrjjXZUmGsEEt08nSSOobmFe+O65gFeKZnmbSqzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN5wXxvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13932C2BD10;
	Fri, 28 Jun 2024 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719598994;
	bh=VgqlBTVokuVUyDFkGjbbMofGXQspC+XA7a9T4ZARWe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kN5wXxvkrLRMEck+E8HtLC7NtGLRbDAur+LnnBPIRdlixQAsPqBF88BFxP/qV2su4
	 nqq47yOVWobYTPIB7idw07wp9dW0mZlwER3UJIOZqbjs3CEdJkF2+8y2uP9/f4GCVb
	 S0WV14cyxdwr48QskLZ9ZLcC18ukTytwXHSoUYOqzQqgD7eosdz9Aqlm7t6jA9JqZX
	 GujIDnRZaRUaPWa5+iymviQSn9dXP09GL7WppVh2mHocRsP810xm4Zhm+vHrSf7c9W
	 4dPrcF2atHmdEQwIfWL6dC4DIJlLr5j5Gxbk5cVW9zi2IubEpVylbHFpamq2S1UHXG
	 lnVL/5bjEFR4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 005DEC43336;
	Fri, 28 Jun 2024 18:23:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-06-10
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171959899399.26186.4428567024757990549.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 18:23:13 +0000
References: <20240610135803.920662-1-luiz.dentz@gmail.com>
In-Reply-To: <20240610135803.920662-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jun 2024 09:58:03 -0400 you wrote:
> The following changes since commit 93792130a9387b26d825aa78947e4065deb95d15:
> 
>   Merge branch 'geneve-fixes' (2024-06-10 13:18:09 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-06-10
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-06-10
    https://git.kernel.org/bluetooth/bluetooth-next/c/f6b2f578df8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



