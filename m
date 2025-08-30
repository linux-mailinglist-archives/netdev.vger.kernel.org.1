Return-Path: <netdev+bounces-218451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B54B3C77D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D24E0300
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269125F7A4;
	Sat, 30 Aug 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/RESoA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0C257845
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521605; cv=none; b=gy0I32FZRZEE9CVNIOH9vv21q0Gti7HZGguaBBKfSEOG7+h3Q/MdCEf877sKtCeGtH5XOUcgWSD5BhfFhdsjMQOzne7Yo3M3PpGfJMPNywWerFQJGxhSr34rZeTBKDfQLNjvqKCVFyfGDg6LpDybHNm6fE3Ftx0nSHVjr7t4soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521605; c=relaxed/simple;
	bh=xvYcfHJ3W1k4NY8OgUVKhWUE4oXm032ZG56vbnS1PJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sILv72P2W/gIMbrG7vBblqNkmZTqC+FdTQosW/LfJHjHoA+cj6UJQK8EGnrcrSEpGnf9RfDeSWInNm6CVbkHmxhPouilq0ZQIeOmRWNrFvSst36oCcwAlZz82Ket08ZQcHwU+ub5MDnEc+/hLhIhgHAegwgj6U47kHtXtFUuojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/RESoA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA50C4CEF0;
	Sat, 30 Aug 2025 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756521605;
	bh=xvYcfHJ3W1k4NY8OgUVKhWUE4oXm032ZG56vbnS1PJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A/RESoA8bCU8wU26xqFo3pNIG8puQlrEcEtYpJ78KezjxyArE1VdTYVi+szLdD6GG
	 iadOkxu65+6kbYy864YksecGBTqyISYZVsm98W8DgzLAQsYuVmla5mCN9YcX/cgL2D
	 ey6m0DZZrW8HicshbbHPyTNVxm6JYfH83CbYRPYcfsbYfUWC8Vegh9nNmasLEgByLr
	 UY6xt9QiCN4A/44D7HMPh0mfC9QsT9pRGOm50wB8PCOYyGw/VxDJehTfZlibDLrxWl
	 N3CSGxv26+Wi5j7PM/SqLw7eySfNLuBgONjnlAszoGfZorhsHh9yctvZ8+fTSyJyRi
	 HZqC69Hlg32yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AA7383BF75;
	Sat, 30 Aug 2025 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] inet_diag: make dumps faster with simple
 filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652161200.2401181.4619730593741623159.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:40:12 +0000
References: <20250828102738.2065992-1-edumazet@google.com>
In-Reply-To: <20250828102738.2065992-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 10:27:33 +0000 you wrote:
> inet_diag_bc_sk() pulls five cache lines per socket,
> while most filters only need the two first ones.
> 
> We can change it to only pull needed cache lines,
> to make things like "ss -temoi src :21456" much faster.
> 
> First patches (1-3) are annotating data-races as a first step.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] inet_diag: annotate data-races in inet_diag_msg_common_fill()
    https://git.kernel.org/netdev/net-next/c/9a574257b968
  - [net-next,2/5] tcp: annotate data-races in tcp_req_diag_fill()
    https://git.kernel.org/netdev/net-next/c/8e60447f0831
  - [net-next,3/5] inet_diag: annotate data-races in inet_diag_bc_sk()
    https://git.kernel.org/netdev/net-next/c/4fd84a0aaf2b
  - [net-next,4/5] inet_diag: change inet_diag_bc_sk() first argument
    https://git.kernel.org/netdev/net-next/c/9529320ad64e
  - [net-next,5/5] inet_diag: avoid cache line misses in inet_diag_bc_sk()
    https://git.kernel.org/netdev/net-next/c/95fa78830e5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



