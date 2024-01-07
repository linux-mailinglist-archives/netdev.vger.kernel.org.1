Return-Path: <netdev+bounces-62244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CD82654C
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 18:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D91281C7B
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FCD13AEA;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S63NyWqo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE18134D3
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20C91C433CA;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704648624;
	bh=NDjPvYoP5koUHq0lIbolPzllniXnpl18Y2w+1BxV7wA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S63NyWqoSK3mugNUQD+AMwHM/EEiqcvU52bfZgg5ku/qXMupwU3j8iF/tZ5gxM0/J
	 Kjrz8qmqP4YbA6WKPDNFmfYFUDpnXhmyonzJg8pbgbk+zyKM8rw9hpIzYyh5lviRF+
	 7VBGuSW7/LBKDB9CkzaCD9MoLcqRq89iG2PdXI3ddnVUI3aVuFOoA6Y0jV7S2NIbhl
	 YHJTACVIIsfAA6632eg8VxQ6IzP7i73vR+uKZQy+3W8gi8WPTQsiQloGzSeVyUVCNs
	 ICcUWvXz+N2Ybl/CtGrEab3JKPqpIJ+EtmQAKw4C6WjB6K/6RHI+tebPPlx8lNV9O9
	 rRpa9rTwPnmzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07FA9C41606;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ip: merge duplicate if clauses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464862402.7815.14326611212167764570.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 17:30:24 +0000
References: <20240104003127.23877-2-stephen@networkplumber.org>
In-Reply-To: <20240104003127.23877-2-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  3 Jan 2024 16:31:28 -0800 you wrote:
> The code that handles brief option had two exactly matching
> if (filter == AF_PACKET) clauses; merge them
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  ip/ipaddress.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [iproute2] ip: merge duplicate if clauses
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=43a0e300dd86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



