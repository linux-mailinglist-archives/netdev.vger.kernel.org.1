Return-Path: <netdev+bounces-85394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7C89A941
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 08:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA611C20F99
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 06:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E9208C1;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m50SwoLu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14B200DE;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383829; cv=none; b=Gy95tUEmgOC9fTBL1cbjycTe5L/25jy6UyRwp5MUYo0P6QgwKGIK+zlosWlfRlaFkXIHBMv3pXVgmz9OcR6t1kolEGdaOD2T8PgFG25zQTX3OXtR6iTwEYRUVMdOGrA94XPJIgUqmBNWolxs/trY6BLZuDnUPKn4KSOQYW+bIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383829; c=relaxed/simple;
	bh=75ytIHuAAClVGUT3oTXe7avG47ILWXJbTniLJymRhwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m6Vf0elcsW+hS6+crl08pNC+blF5XaBPIH+6N5wMFsXRBW4Y6rQPRiQtwLWxsQhLQNprTVpxxaVLyoQxRtlsLxi98IjLwOSDLJZ7s2EUOo10D3wLVZ3i417rTR9/cBgYky03QYy6vAiyUrXEXvmz6tF85yJFUqJ3vbHl8cDWtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m50SwoLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46FF1C433C7;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712383829;
	bh=75ytIHuAAClVGUT3oTXe7avG47ILWXJbTniLJymRhwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m50SwoLuftzKEcOTq3+KdI48Vl/mTNTi1WiXsp7v7cyDfyxX3e6/TJK/yKl7dw3D3
	 37t5jbkGdn88Zz3aG/HJU6/ey81MMhB+zbMfy++Wqq/IUsyU0/jHq+TZyuutbV0jdz
	 oKGO/xNEWtdlDyqR1ENr1ac9Z7/N5N/N6XZyivATrquJl5dB+XmOQdcdeID5Gu2U0j
	 Bo6uSwPxBOafVOt4jZAlqK4uXsMJURc1iW6bjcZP4dQLoHFW2VhgNMZ+p+nRQVzAqH
	 jRLw41V8QfPkDjaWIf8o+OBJCWo+vK5uZfdA3x6BCZqM3sz/KBN4jlKVuhDCBXI9md
	 v2OG4mz7q4nvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3483CD8A105;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xsk: validate user input for
 XDP_{UMEM|COMPLETION}_FILL_RING
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171238382921.24936.7626242183115948286.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 06:10:29 +0000
References: <20240404202738.3634547-1-edumazet@google.com>
In-Reply-To: <20240404202738.3634547-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Apr 2024 20:27:38 +0000 you wrote:
> syzbot reported an illegal copy in xsk_setsockopt() [1]
> 
> Make sure to validate setsockopt() @optlen parameter.
> 
> [1]
> 
>  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
>  BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
>  BUG: KASAN: slab-out-of-bounds in xsk_setsockopt+0x909/0xa40 net/xdp/xsk.c:1420
> Read of size 4 at addr ffff888028c6cde3 by task syz-executor.0/7549
> 
> [...]

Here is the summary with links:
  - [net] xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
    https://git.kernel.org/netdev/net/c/237f3cf13b20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



