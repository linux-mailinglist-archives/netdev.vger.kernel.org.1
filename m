Return-Path: <netdev+bounces-38053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59017B8C78
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8EFBF281741
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3F21A01;
	Wed,  4 Oct 2023 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iaw06bIX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C81B29D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88C79C433BA;
	Wed,  4 Oct 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696447225;
	bh=ZMqZ+G5ZaetSrujKc1irQl51D6U6eypwDvFON5Y4FdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iaw06bIXLjm87sPpq6Uazp4EjaJ7nBtz3lp5XGbpbzw6c7pPK+Dik5ZpLLHDilMW+
	 tpg24y2BbbrJgwwHjD/pVWJwJQwwWxfHwiLs3tw+a2FMU+M9MU+nrArqfN+BB5CY4y
	 nv9sUrIvCbMPGEOQR3Ufdv9LkvnvCth1S5CDdctgEfIWM/PfQjKh3CZueNr74MTiGg
	 2M1WvzycCglyCK6uALVWyFQXm8VtEMaaHoCYMTkszslLOI2gLkt7jetobvzJFAw+kS
	 VCCKWtrY8gQhswWPwRwL1Exjo3yM6RL40nvPN02VSfzenZ5tINmvhpTd8pRY8fet1q
	 caZPp7QZDYm4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F62EE632D6;
	Wed,  4 Oct 2023 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: appletalk: remove cops support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169644722545.5036.15571525046137185436.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 19:20:25 +0000
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230927090029.44704-2-gregkh@linuxfoundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spdx@vger.kernel.org, prarit@redhat.com, hch@infradead.org,
 vkuznets@redhat.com, jschlst@samba.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 11:00:30 +0200 you wrote:
> The COPS Appletalk support is very old, never said to actually work
> properly, and the firmware code for the devices are under a very suspect
> license.  Remove it all to clear up the license issue, if it is still
> needed and actually used by anyone, we can add it back later once the
> license is cleared up.
> 
> Reported-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: jschlst@samba.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - net: appletalk: remove cops support
    https://git.kernel.org/netdev/net-next/c/00f3696f7555

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



