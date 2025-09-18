Return-Path: <netdev+bounces-224481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9471B856A1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A98C162A0B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F03112BF;
	Thu, 18 Sep 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIVwBAyw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06433310652
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207622; cv=none; b=Ycg75b/Cp8YXjJWF6A4QKlkOau+ufm6+n8w8HvieFCM3ueotyO3utP8C9C/8SHZLEO6tIl6g4Vl9PfahB0mPI+LUNcXvSX/m5ivPeVRrwXHy++L3g2FegXAXN3A0z2aNAh1ZzkpKmSjScJXFoG1vsOdJnTw3frUv9CilaLehgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207622; c=relaxed/simple;
	bh=gzWNt32MJBX83qnwTgx7up6ati7kE6YHOX3nPw21oYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kW1ceBokcaFw8AO3m1yMKuZ+0LZBbPziEm0jXBaXCUKIIsf652vAis41UXpzz4H+JewZqKvujegXFaelSqkI8PWK6Q4wK/980mxzDWY3n2REmL8GXmp9An0qk43PY9ULN/d0XPFPaRDo3eKI+kGp6LOGRUbvfHK4WRfpC1nbr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIVwBAyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABE9C4CEEB;
	Thu, 18 Sep 2025 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207621;
	bh=gzWNt32MJBX83qnwTgx7up6ati7kE6YHOX3nPw21oYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aIVwBAywAe0ETfJaqYdqHcGHFhCi6zOSGcL1b9Qj7CNjCnZf+OUfWxh39Y5s69LLJ
	 HVlZ/vQGvVyEWEp7U1gGboTWvAi4w+6CgYotZjnVmuMRa2u/2cdKMRosu5yNYOEm1p
	 LBnzpR8NERfJc+Jpm1t43372VCg0PIWhsxeFsotp5lTdH2QOVHADv/DlSG7WVKUY8G
	 kJm4lA9VcQTrZriB7KKFnk7zo198GwYcCneZCdfhwPQgo4NRhgo/iovBgPokPM5FDh
	 AfsB3Wlp6WMrAclyjDn9Rto1WgTxQ2MuZK0prJnr2cMw3JoySW8nQhgV1KAMW5iO6d
	 19XjYA3e6YHEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA539D0C28;
	Thu, 18 Sep 2025 15:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820762202.2450229.1131642865815096129.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:00:22 +0000
References: <20250917135337.1736101-1-edumazet@google.com>
In-Reply-To: <20250917135337.1736101-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, avagin@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 13:53:37 +0000 you wrote:
> Andrei Vagin reported that blamed commit broke CRIU.
> 
> Indeed, while we want to keep sk_uid unchanged when a socket
> is cloned, we want to clear sk->sk_ino.
> 
> Otherwise, sock_diag might report multiple sockets sharing
> the same inode number.
> 
> [...]

Here is the summary with links:
  - [net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
    https://git.kernel.org/netdev/net/c/87ebb628a5ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



