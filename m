Return-Path: <netdev+bounces-247542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51DCCFB8F8
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B9930549B3
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A6287263;
	Wed,  7 Jan 2026 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMSQGL83"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C5280CE0
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748421; cv=none; b=HPhozopnjI8QTFKyWQnb8b8YaKR3Rf6E3L9f3/9cgbgz2mh0a8eDsbt8UDJNacXLoG/tNQWzo3a+aWcydt568Pwnls2CumVNhUkWOlklKLd7cq8qA0jtR6TKj1xUn6+VC1G0DONZyLOox7/KoSODFFgLBsdw1xxGrZVRKOkBnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748421; c=relaxed/simple;
	bh=F8TRBdEX0IKoosO6AWlc9pFWMhHrf5riuSD9UCdfoxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WQzcoVWVjdfXC6oJX9j/98sKntAVH+/P3YRaKpKy45RXpgccVfdXo42Uy+jtGMpAMCqYCjBuq7qBXrS8AMOdeENzH+9Jbt7fjSF/5Z5AJgTxO+QCNQpmiXVnAdzXkrWbXgIU2wJZvAGhcRF5cS6RttgZlSZl4GJQE9B/EjQJqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMSQGL83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA7C19422;
	Wed,  7 Jan 2026 01:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767748420;
	bh=F8TRBdEX0IKoosO6AWlc9pFWMhHrf5riuSD9UCdfoxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RMSQGL83BaOtl7R/cKZl2xOqO/EfeCuO/EC/4LLu2y64ALQttL8YDHWs95Le+HpSo
	 IrvXkNFF5uVLJHfiZDkH53C1qIlHr/rjs2SKiknra56c9fXOkp5lOdT6/eS7dD4666
	 z/lxIMDdEen88BAyTj1qJIKx19qazVu3D97NOzRzBIbfh6YC3ufYc4zpg7i8izyHTg
	 /nYPPz7sO2REVdPwHTGC3F3Gfi9VzPYHxtTDNofUOa0/TU2CUKsMWVBH8vu0X0Ll4a
	 kK63cU9SuLzQajsi9GjUvPioTCiDOxoFRXLvc2lPoJ5DoFKw+K1pkEpr5FQPw/UcY1
	 uyrob2oVIW3eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B74B380CEF5;
	Wed,  7 Jan 2026 01:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: libwx: remove unused rx_buffer_pgcnt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774821802.2186142.12690968741108457435.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:10:18 +0000
References: <F0907C8394B2D4A8+20260105071158.49929-1-jiawenwu@trustnetic.com>
In-Reply-To: <F0907C8394B2D4A8+20260105071158.49929-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.kubiak@intel.com, mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 15:11:58 +0800 you wrote:
> The variable rx_buffer_pgcnt is redundant, just remove it.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [net-next] net: libwx: remove unused rx_buffer_pgcnt
    https://git.kernel.org/netdev/net-next/c/d362f446334c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



