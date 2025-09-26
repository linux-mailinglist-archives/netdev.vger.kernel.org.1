Return-Path: <netdev+bounces-226815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B78A5BA55A2
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7778F3833EB
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817A279DD3;
	Fri, 26 Sep 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVUuqNPI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA015278E;
	Fri, 26 Sep 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926412; cv=none; b=Qgh8PedZWXXHSXaQc+vf63eVC9B+i8K1dsLqHZ5J0kQsII/Sn+CYUMPtJaPLNoL603tqCNf9c9DoUCZaEW4Kq4Z2jiD/rPyI6UBtA4Gj4yZd/nndS0ZIH0gejAoLqBldQTKyF2MbSDWDG419RfY3N+nsGkjLhQw33UdWt9xplV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926412; c=relaxed/simple;
	bh=6sLDQBafqAscBpqWVedo/j/pnvSvSK0EgOm4sn/zlFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jf2ofCvccp+5WnKb51suZDuboKRXnBP0JnQ48wxBWO2HKpKpdeGUMqBdS8aGvbOCNJG2AE2pZ4NYHm4zkpg2TPzQF54DzyvGt2rO5mRkG5qUcuSDpAfUJVk/QiswVQfZREl7U2n8WtAteHQ8tp2dvjufMHjx0Yppm4QzY11yXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVUuqNPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16554C4CEF4;
	Fri, 26 Sep 2025 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758926412;
	bh=6sLDQBafqAscBpqWVedo/j/pnvSvSK0EgOm4sn/zlFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sVUuqNPIADbRIQSHs0+A7NNEEpK4hfl4E63wOBhQILnvf2s3EISix+K7WLty0E2Jn
	 Y15rE6JFspEuClwmbrbkULcp3mWD0MPaJxSYd7siPOepkUQuXqAkRsLczcjJGySjf7
	 dumbHBTBNLxH4h7/OZsMS1GSqd1lGZ5PCWZdJ9PUWO19IVRay0vJSRHDyhfaVGTYqQ
	 eBqCvFkQ1oKXR5POd6mawM8fmAg6CNf0U7FtsqCxqYCn26kDwDQwEehrdaHOwyoIM6
	 GULO7zr7/4oh7fzo4UB6Eb/8C+m8b9QniQ8o6EeFKRd/5ZKThadHrM/DnOx3VjJ5fY
	 HK8ZMJ/QHsSaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9239D0C3F;
	Fri, 26 Sep 2025 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ptp: Add a upper bound on max_vclocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892640700.83117.7979066365485641926.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:40:07 +0000
References: <20250925155908.5034-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20250925155908.5034-1-viswanathiyyappan@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com,
 syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 21:29:08 +0530 you wrote:
> syzbot reported WARNING in max_vclocks_store.
> 
> This occurs when the argument max is too large for kcalloc to handle.
> 
> Extend the guard to guard against values that are too large for
> kcalloc
> 
> [...]

Here is the summary with links:
  - [net,v3] ptp: Add a upper bound on max_vclocks
    https://git.kernel.org/netdev/net/c/e9f35294e18d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



