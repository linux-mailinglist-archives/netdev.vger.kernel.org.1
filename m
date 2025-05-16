Return-Path: <netdev+bounces-191213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481CABA653
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69172A24955
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC3281519;
	Fri, 16 May 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLeM8+7T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73B22F3B1
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437007; cv=none; b=YvuQBF6EsFqM0SUoobHnoQRgXXToqF4HCaaBVNBDMEeEwUp/LTBIv7mhXRb/UwyrhOyumxAEUU8XXkobP1Ipgl8saNNIv2cKO0yUKeeldv53ILaXfhuCcYE+X49ZekdP/Av7FakiWWlQ0PicjsPuOHAm3QOTByqo44u+2jirigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437007; c=relaxed/simple;
	bh=z/Opi5ZC12sMP+8+zT4EJukfd5SY4yv5ounQUh3d7Ic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D8axWPeOq6CLjXpxD/okbr77ZcnCWoq8xDCSVqDKbS3GA3fZipj8WoD07p68ktZwdJX2KPzo+rWZyanELUdEEpQmf+5GiwqLvviRTgQ1QH0B3t8Szp25yI/dN32afK2lXyDdPDDYDEFFIItMKwOydG2ukKJifSMGybEcqh5FDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLeM8+7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B511FC4CEE4;
	Fri, 16 May 2025 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437006;
	bh=z/Opi5ZC12sMP+8+zT4EJukfd5SY4yv5ounQUh3d7Ic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jLeM8+7TDitqqUHczbLl2AFvhreX3+oPzxjs7MiwzG99YVerjppXnax4Z1uhCUkS9
	 clY64T6ff9ikipmua5R+oXYYkQPbe1/bIClyr7ZyadgkH6gP/IuiVkr4ukM7WRIsWG
	 PlNRkKEG7KCbJtMyb3d7C8C16mS60MRRPSL3pIeY6SIHv1VL4GkrctU25q9F99xnme
	 9c409B7/EWlLOuafPT5Q0BaxNsoqR6BnHUIeqheOB3tk0Kk+tK1puwoFD01EQNGBvR
	 4QcTZYcpJH9Url96EEYL7Ey+fqCZ/+4Slon2j+0bhfcMgMVn3SuAFBjiu8A9smVaMJ
	 6ic+B5Uckx+lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD03806659;
	Fri, 16 May 2025 23:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: rfs: add sock_rps_delete_flow() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743704349.4089123.14141926227424572519.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:10:43 +0000
References: <20250515100354.3339920-1-edumazet@google.com>
In-Reply-To: <20250515100354.3339920-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, tavip@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 10:03:54 +0000 you wrote:
> RFS can exhibit lower performance for workloads using short-lived
> flows and a small set of 4-tuple.
> 
> This is often the case for load-testers, using a pair of hosts,
> if the server has a single listener port.
> 
> Typical use case :
> 
> [...]

Here is the summary with links:
  - [net-next] net: rfs: add sock_rps_delete_flow() helper
    https://git.kernel.org/netdev/net-next/c/9cd5ef0b8c04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



