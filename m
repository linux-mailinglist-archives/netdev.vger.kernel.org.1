Return-Path: <netdev+bounces-210309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB667B12BDF
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D1A189F8D0
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6B28934A;
	Sat, 26 Jul 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5Xy4W/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9D289342;
	Sat, 26 Jul 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555199; cv=none; b=TfABGJPZhaJ+thxKEXTpg8Z466JJYt+TaaNSbCLSaALKa5uKM7fQJ9JwkclSPY/wmWxTJqDbKRc1Y5T9EAnj9vPkrx7NF8iWe/Eh+RY+r9mJcNTnKosp4ZiHb5PIKMH8c+3IFmy3Wa83kfO6VJv0c9XSsy8KG24BbAn44Svbg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555199; c=relaxed/simple;
	bh=vmslO4NUDaYt3BkRpA1q7UYt1qlRBGzRZEWB0XoQF8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nLdpssu4kB3K+4rK0seF0AlEOgyyxgJNeKg4WxAZQAV/jWR2XJz3LxvthWeqRwRlHT1G2sau7rq6A95VKTZFDXgvpIAK6yCQugS/bJGg7KtY2+e3G3caCp4H94KSJkFuoo1cHNvBp9yJNh+Iqdbs9jAALj4OZlRzFGNxExTmtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5Xy4W/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEBBC4CEED;
	Sat, 26 Jul 2025 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555198;
	bh=vmslO4NUDaYt3BkRpA1q7UYt1qlRBGzRZEWB0XoQF8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t5Xy4W/bc4koonSqu2RqylwPaHkOWR7BJ2KalcJnxAOvNY096Vw3jeWngxNXEvO0I
	 nkZhVSDBt0CVei+ApEMmpP/qDkXO2Arkkrossy7Rxl31xoQT4zRb+A9ej6xnLbES+7
	 FuPg9+PA1YM7eXg5SlzsGG8tAXcnyMO4uZ0nB3UHeHe6WpgKzxP0PXTjD6L2tjDNcw
	 73JPOOq5CQF/MvGcli4dm/6+2zVC3yYQxnL2LV69YzQDLiqqjSXmJkycgg+J0xL1vy
	 CaZ45zkQSKZBjE4SZOcGeVj36z+vMIYpOD4uce/bGXnToMyILZIWNWMA3/CApe6UuT
	 sDeXER+S0rGKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D69383BF4E;
	Sat, 26 Jul 2025 18:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] vrf: Drop existing dst reference in
 vrf_ip6_input_dst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355521600.3664802.16927293699051686141.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:40:16 +0000
References: <20250725160043.350725-1-sdf@fomichev.me>
In-Reply-To: <20250725160043.350725-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 09:00:43 -0700 you wrote:
> Commit ff3fbcdd4724 ("selftests: tc: Add generic erspan_opts matching support
> for tc-flower") started triggering the following kmemleak warning:
> 
> unreferenced object 0xffff888015fb0e00 (size 512):
>   comm "softirq", pid 0, jiffies 4294679065
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 40 d2 85 9e ff ff ff ff  ........@.......
>     41 69 59 9d ff ff ff ff 00 00 00 00 00 00 00 00  AiY.............
>   backtrace (crc 30b71e8b):
>     __kmalloc_noprof+0x359/0x460
>     metadata_dst_alloc+0x28/0x490
>     erspan_rcv+0x4f1/0x1160 [ip_gre]
>     gre_rcv+0x217/0x240 [ip_gre]
>     gre_rcv+0x1b8/0x400 [gre]
>     ip_protocol_deliver_rcu+0x31d/0x3a0
>     ip_local_deliver_finish+0x37d/0x620
>     ip_local_deliver+0x174/0x460
>     ip_rcv+0x52b/0x6b0
>     __netif_receive_skb_one_core+0x149/0x1a0
>     process_backlog+0x3c8/0x1390
>     __napi_poll.constprop.0+0xa1/0x390
>     net_rx_action+0x59b/0xe00
>     handle_softirqs+0x22b/0x630
>     do_softirq+0xb1/0xf0
>     __local_bh_enable_ip+0x115/0x150
> 
> [...]

Here is the summary with links:
  - [net,v3] vrf: Drop existing dst reference in vrf_ip6_input_dst
    https://git.kernel.org/netdev/net/c/f388f807eca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



