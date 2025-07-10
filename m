Return-Path: <netdev+bounces-205644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA104AFF75E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20AF3BB43A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE323281368;
	Thu, 10 Jul 2025 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmMRlX75"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324B28134C;
	Thu, 10 Jul 2025 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117589; cv=none; b=l+Qr62SDMy7ItxCakwlzeAw9A5z+/iLUpnmOF1t/wpyUtLl63CjQXlzA9FotaU/6n0yR/5qQyD+hMxEp466lPhb2Gml5Q2lXZpqFeSSLhhlKdfOay9622OvbzZrLZWDP3LQnbSGkGi74hrTdRFagV8VlZtLFJro3vPGkZzl0d7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117589; c=relaxed/simple;
	bh=y5UuWEGLf+ly566xqWaqO5gL56qvLAjYHdgMwg7SsQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DquY7u75zg610xXWBj4lGsDxpULJlQ7Ko8Wt1P371/YZSQoKnP9AJhIJXZ16Jt/XfyfNyGhYxtg874wISBSIv5iCq0DcMAvaWHc83Ujfs8vCU4rxCPQtECAknD32KgftmpkX0OJmUTHI8VXJIsgLm7z20mMFnxzihcrYDk3Iksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmMRlX75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D65C4CEF6;
	Thu, 10 Jul 2025 03:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752117589;
	bh=y5UuWEGLf+ly566xqWaqO5gL56qvLAjYHdgMwg7SsQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RmMRlX758+QpPaFnCOJ6fr5AtADwz4I0G1mnursHRkVsvF3yqpP9XGD7A2TXloIq4
	 InSkbB18r3pvmOJS5oL036KHJnuuJTzjY5z2BtpUqSJ5Dt8XLv0z7Brfqnp5njIewP
	 ME6qV3YsD7YpqlmHttb+rYmrq57GbY/5XULAZc3zjCdod0Ju1p+rBanFZImUqgIfpR
	 F/n5K6q8YSiAOCYRd9bQVwNOWhf1C9QUnsSr0+LHYIBch7z2rCUwcVvuPCWoAEmv35
	 7CO4i9g7k+hIcsomSU1az3HKvTXPPvOTxAsE2ZLKvurtTyLe2PEondca84tSeqiSid
	 ACUBG4W4Q7Agw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE56383B261;
	Thu, 10 Jul 2025 03:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211761149.973534.17143599338508690586.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 03:20:11 +0000
References: <20250708211506.2699012-1-dhowells@redhat.com>
In-Reply-To: <20250708211506.2699012-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 22:15:02 +0100 you wrote:
> Here are some miscellaneous fixes for rxrpc:
> 
>  (1) Fix assertion failure due to preallocation collision.
> 
>  (2) Fix oops due to prealloc backlog struct not yet having been allocated
>      if no service calls have yet been preallocated.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] rxrpc: Fix bug due to prealloc collision
    https://git.kernel.org/netdev/net/c/69e4186773c6
  - [net,v2,2/2] rxrpc: Fix oops due to non-existence of prealloc backlog struct
    https://git.kernel.org/netdev/net/c/880a88f318cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



