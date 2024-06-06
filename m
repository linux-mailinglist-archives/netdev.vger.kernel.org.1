Return-Path: <netdev+bounces-101419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1368FE7C9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2862858F4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6BA15FA7D;
	Thu,  6 Jun 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsfWG6xK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50262A1C2
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680630; cv=none; b=IkBfKrGGTOJaYIfPdxDDPAy+46iNif2EZ9PdFZEChE2baqhucH3V8vtGrdNf1odHet0Mth3uMdp2Lzf8xA2NZdnklNPgSxfXrjkKukFIpafGfdE+8LJyMbwzWRAludXKs8Ja3x28pg8jpB1ghmTGExqDteExAPx9dSABPGpCB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680630; c=relaxed/simple;
	bh=EF8YMWuTx+L1/JkF64ZUufZd4ZdPlw6TDFAnMue46MU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PHSRm8THQuwgYC2ORAz3Jg40tP0/53tLHnEPSARK6sGHhztWdcEEhKUz4lAVzrPDFD+W+w/q9EOKjBIG+/T2rEe9zy9JjHapqY79IYbGb4WxGjQNTaG85RM7/ltcRWx+MQpmWkAwd18MsjAaAuTw60XeVbWLesEA1hrGU2F40Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsfWG6xK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18395C32782;
	Thu,  6 Jun 2024 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717680630;
	bh=EF8YMWuTx+L1/JkF64ZUufZd4ZdPlw6TDFAnMue46MU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KsfWG6xK4ZBEiIqseEgl7rX/K/GKgpUQwz/i8jrCrNJVnuIayOAnfBo4WBGWutios
	 Uytya1H9OsudDyNbv9BpbQItqbntc6Hw89UP1HL3b2BPNaDvQ6sSO24pEDhY6CSQBh
	 /6I5zm3ncTOLxgNJsmLgakABpKqmXJ3Ore3cBtK9ApDs13KqkDbt8FPk44t4RJpDlx
	 MBQ5xA5VQDJETfttkulwduxl19NMqBFfamtknydeECfkRssfNv/sxG2gG64RlOG2YW
	 2IPbzjAoTXAynEpJkmF8to6FozXjtB0Poms0Xu0N4ad/07Sk2UUsMoKFtSRLQ/kQ+h
	 fWyFM/D2Kp4aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05DA8D20380;
	Thu,  6 Jun 2024 13:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tcp: small code reorg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171768063002.13251.11653732250767367212.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 13:30:30 +0000
References: <20240605071553.1365557-1-edumazet@google.com>
In-Reply-To: <20240605071553.1365557-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  5 Jun 2024 07:15:50 +0000 you wrote:
> Replace a WARN_ON_ONCE() that never triggered
> to DEBUG_NET_WARN_ON_ONCE() in reqsk_free().
> 
> Move inet_reqsk_alloc() and reqsk_alloc()
> to inet_connection_sock.c, to unclutter
> net/ipv4/tcp_input.c and include/net/request_sock.h
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tcp: small changes in reqsk_put() and reqsk_free()
    https://git.kernel.org/netdev/net-next/c/c34506406dd5
  - [net-next,2/3] tcp: move inet_reqsk_alloc() close to inet_reqsk_clone()
    https://git.kernel.org/netdev/net-next/c/adbe695a9765
  - [net-next,3/3] tcp: move reqsk_alloc() to inet_connection_sock.c
    https://git.kernel.org/netdev/net-next/c/6971d2167282

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



