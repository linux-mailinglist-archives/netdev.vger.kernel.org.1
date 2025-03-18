Return-Path: <netdev+bounces-175664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B1FA670C4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44DD16BAF2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F6206F3E;
	Tue, 18 Mar 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVo06fBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F21EB5F8;
	Tue, 18 Mar 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292599; cv=none; b=J4oLn1i7EgOqh0bYYel6ytQlTS+SQJM6G0D/xUcpQWrMtT7QXP1vNcIvQG8JhRG9rUpllaLph2KpLtwuehg/Yzo2/fMssFz0Vjr/aM3EC3bWmbuUJwhneds+x3W5kn9BKV63O1dJ8j3LAvG+9T9YrD1OAfYXk6W9J/edf9WKfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292599; c=relaxed/simple;
	bh=C3maJ1IGMFjownQSFkIvyjueS0L51aE8ntpupS0+5oQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+FXHaiQ82L46Nl5AlA6KHou/toPyBBiD5sWMVxoOpsKyrRRsuxn2QlnonaNV2mGlhffe6EUXjv1stSOmymO1JUA77UDcAk/Qmrp2swm8u8miOVlsukxM86upH9EQDedwmvPI/DLSfQhgYk5jws8/JdI4ul/tlMHgw9oFRZQNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVo06fBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DFDC4CEDD;
	Tue, 18 Mar 2025 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742292597;
	bh=C3maJ1IGMFjownQSFkIvyjueS0L51aE8ntpupS0+5oQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVo06fBhI2lsM6JVLzi2odfprQRfiE8wKaEbQqRLfHpAaripiriIEx09ry5uzsptD
	 Lyr2HVXtfhbyc/sJB4K9yk3cgYRUeipXfVU/F330y+2sOpG4DoAVAsduXdyyAGtDSK
	 y0UEt1nZHSyjQhNRjcitwJqcfaECKheB37I5wS9QDlieb0HZaLadIXIP/oyDmVX2Cc
	 thcuJxD5yX4xd4UhkuOP7wcHecEKV6nnhJKY3pfkPuYV38zgh1jkYfF8hj5BMxPT8w
	 3W3tT7TSiKXsb0g5O2Ek0UiEblL7ZxxqY9BFK/2ejsZkgXYOLvT0dmtKjWtwDcEcVU
	 G/48f/7Pgye+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBCFD380DBE8;
	Tue, 18 Mar 2025 10:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] qed: remove cast to pointers passed to kfree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229263277.4111172.9454452389571676376.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 10:10:32 +0000
References: <20250311070624.1037787-1-nichen@iscas.ac.cn>
In-Reply-To: <20250311070624.1037787-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 15:06:24 +0800 you wrote:
> Remove unnecessary casts to pointer types passed to kfree.
> Issue detected by coccinelle:
> @@
> type t1;
> expression *e;
> @@
> 
> [...]

Here is the summary with links:
  - [net-next] qed: remove cast to pointers passed to kfree
    https://git.kernel.org/netdev/net-next/c/f5825e79b2b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



