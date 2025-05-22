Return-Path: <netdev+bounces-192514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6FAC02FF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0701BC1B11
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813281531F0;
	Thu, 22 May 2025 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3WcdxmK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3A175D5D
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884607; cv=none; b=bxDywUhJay7bBCRO10NOo7y/z5NXqBLH6bkq3KEu+KBQ7Xi13vKqe6RDW3KVho5B78VwTuozc5sPofDMYcy4Ki8Ninv5G8HXMyJC6cAkRCsZbI7vHAPy+SgwWf5F8NiQQ8FOh8Je2K45YONQiPvVONctGTOspM2kDJM3pbdMzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884607; c=relaxed/simple;
	bh=oiHit6LwMzBHLNEZVRfD7UUG4z+uuPtzqXf+7wuEJgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I2nJYcjnIwsgDLgaTZxnZ9lnhOswpnYzjowQ0ISG8IXpC50Wynrly7onUDvRJH4oFhFYlUTR+atdwOMtTQMpdR5+pG0cayTPuOzmC2q27i1OTxPlunQCTfCIyUl5nv7Lv20HPQywP7Mdt+JvZso/qe2w06c96rNE4eRxyNtY1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3WcdxmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4F3C4CEE4;
	Thu, 22 May 2025 03:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747884606;
	bh=oiHit6LwMzBHLNEZVRfD7UUG4z+uuPtzqXf+7wuEJgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I3WcdxmK71MWNitwltst5FIKN5JD5b0rhjn2t38q0B7u1dUd9y6DUW58P7i7fqZtH
	 qCNkcVTv241kv737EpRew9wAnxcLoTZ9vqPaNVBqtAlYc/W9LLc45T2wCAO1FZgv7U
	 LHB9DG12VjWBko/0ISrEt4XPWxsgpmiZqhWhEN3Tz3QZbgDE2cOBBwq94sqxkkXweA
	 FUO+enuLpisIDIRBbnNNf5tfpMDCTIG4y0kvQj7qy8/T4Xkiqb+LIpTB3lrmfI25si
	 Lf3gFVwa+mPbu9vW+pLsmF2ucCZFCTyWsgo/oOdsO7WooWSjTqD0XlZqIE/+bICule
	 VdoQH5zMplakA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00E380AA7C;
	Thu, 22 May 2025 03:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: libwx: Fix log level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788464232.2365353.14063450865740404177.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:30:42 +0000
References: <67409DB57B87E2F0+20250519063357.21164-1-jiawenwu@trustnetic.com>
In-Reply-To: <67409DB57B87E2F0+20250519063357.21164-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 May 2025 14:33:57 +0800 you wrote:
> There is a log should be printed as info level, not error level.
> 
> Fixes: 9bfd65980f8d ("net: libwx: Add sriov api for wangxun nics")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: libwx: Fix log level
    https://git.kernel.org/netdev/net-next/c/d42d440746f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



