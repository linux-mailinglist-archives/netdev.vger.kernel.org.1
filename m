Return-Path: <netdev+bounces-244110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D65CAFD62
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C443C30E92DC
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188E32142A;
	Tue,  9 Dec 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syUKd9KB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76226320CA6;
	Tue,  9 Dec 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281203; cv=none; b=RhsN3Yple97XqeJoCICV5oM2dyJZ6t/bTM1E95EG3MVxsDpFPUzUB+C/g9MC/BqZcgilXe08zIDfJaOTm8B/hyWDuxWiilR9EsZxz02SquaDGzCrPF/QYvMs1BuLLpGMNbh3EA30Xmzgrlw2x47/naA6oYtIEpkp4Cf5yR/o4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281203; c=relaxed/simple;
	bh=HNP0eAAS3dej7Rg/amu3m4v9LMoP6OJ8ZFPK+G7P4xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0avy8gE7ISO4FrDh4uae8rQ4Nbj4kR8DToGDGg9dSBWHft1L5yv3UCzpN64LGW6hfF8d1kP0f7rpDfq7Nt/UbNmR0lZkO2M4+tpkYFuqsLLco+CqbFjxpJgQH8i4Z5DrcbYWxokF5stWE9zsyOIO9qEe15gPZUPmCBHam8fFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syUKd9KB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1203FC4CEF5;
	Tue,  9 Dec 2025 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765281203;
	bh=HNP0eAAS3dej7Rg/amu3m4v9LMoP6OJ8ZFPK+G7P4xk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=syUKd9KBKHETiTzYW7oZI/Zp+OYTLkg7CXGBFFFtkrz861ktEAY4z+qMlDk0+kZR1
	 otmnUDZkkN+/wiBwthvDobHjGIKnyTHqBXsEdEzZHxrb19Jd1806M0fnwyOzZ836Pl
	 5UAvyx3+Xt8VQyvsUTHdM1wqMWbePbNcyzik1Ys5y/Dp5ysigbiQPLpIqNgRomlmar
	 9XFGxpfvM5leQyulBmVMJ83xPhj9zcfnHHqXWWAjajxFNNV/DLyWhChquC2c+H/g+u
	 wbhGzkI3HgA3tozey6Yo4AcxRVgXPllpXrVFE2HUdkUPDYQVg2uIOWMFPtaXFgiue8
	 cUAfurkE+ZNag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787AA3808200;
	Tue,  9 Dec 2025 11:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: select CRYPTO_LIB_UTILS instead of CRYPTO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176528101827.3919807.17827620499389499440.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 11:50:18 +0000
References: <20251204054417.491439-1-ebiggers@kernel.org>
In-Reply-To: <20251204054417.491439-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: matttbe@kernel.org, martineau@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, geliang@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Dec 2025 21:44:17 -0800 you wrote:
> Since the only crypto functions used by the mptcp code are the SHA-256
> library functions and crypto_memneq(), select only the options needed
> for those: CRYPTO_LIB_SHA256 and CRYPTO_LIB_UTILS.
> 
> Previously, CRYPTO was selected instead of CRYPTO_LIB_UTILS.  That does
> pull in CRYPTO_LIB_UTILS as well, but it's unnecessarily broad.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: select CRYPTO_LIB_UTILS instead of CRYPTO
    https://git.kernel.org/netdev/net/c/e9e5047df953

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



