Return-Path: <netdev+bounces-199244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1EADF89D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143B5164EC1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698DA27A935;
	Wed, 18 Jun 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY2LG2AD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E8279DDE
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281593; cv=none; b=VnuGsiWwIoFV8WWNBPgCfasL9uIuAdbP7ssy2c/HcVpKFPEc1CEeqhr9xtxUQQayYLhBXYANHJriB7m6xz1dIvWQDSUc2yRVUa0yEn63jDCNaO5iuDOLPbszFxdndSFL34lvUzyXD23AUiBs9b0rUjsSflhHnPteirtJKFdIbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281593; c=relaxed/simple;
	bh=lH+avAdVHpXfgPDZbgnaZRbvdR04Y2XlBJRUtgYUYvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NfwpcNXvGvUoCWrFyfNvfuip3Lzha2/svDOVzYmQLrbYjZ3mr6/cs4k6lf1O76zOwoFy47JKzCiJL734W0dD7LAMNcRIJA8DCtsiWiFMejxN+2NEzpGQ6IKV93fPl2JCk2cfoFwQ+uA19GWEskdCW5z6bbqG8jil63C0neU/5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY2LG2AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD645C4CEEF;
	Wed, 18 Jun 2025 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750281592;
	bh=lH+avAdVHpXfgPDZbgnaZRbvdR04Y2XlBJRUtgYUYvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WY2LG2ADHQMwoJN88aBtR1L/DTQcuDSkVoa/GZiqBow5WwBylUVP+yjchk+QN1xsn
	 3DddP6H9ZL8C8L5KiIsjM/5ZmQigI7X6Ucx3vq9IjGJ+f103StfuGX96R33LM6mJ5z
	 YyKgKMFNHc+FemStlcAt67QJJMeyUiZiZJgk0rhoTNtPmaedrtHmeda89eK9ugjfpL
	 dA7xH+kAC2IbvFAZYP5+bDlzaJDduQzO/e6tMvXkjypFwtCLpFSWmXvAoDVhldQX+I
	 +Tm2q6Wg7s+PR7tnoWA1bqr5qOEXsSmjARtASbJeD/myUCNQjkrTSRL0APhMHEi5xu
	 Kw7gScoQetmTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D293806649;
	Wed, 18 Jun 2025 21:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfc: Remove checks for nla_data returning NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175028162073.259999.11715713097590702178.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:20:20 +0000
References: <20250617-nfc-null-data-v1-1-c7525ead2e95@kernel.org>
In-Reply-To: <20250617-nfc-null-data-v1-1-c7525ead2e95@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 09:45:39 +0100 you wrote:
> The implementation of nla_data is as follows:
> 
> static inline void *nla_data(const struct nlattr *nla)
> {
> 	return (char *) nla + NLA_HDRLEN;
> }
> 
> [...]

Here is the summary with links:
  - [net-next] nfc: Remove checks for nla_data returning NULL
    https://git.kernel.org/netdev/net-next/c/a9874d961e8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



