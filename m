Return-Path: <netdev+bounces-41100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816637C9AE4
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 21:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF25A1C208F5
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19325F9CD;
	Sun, 15 Oct 2023 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWLBRT7W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D9259B
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41B21C433C9;
	Sun, 15 Oct 2023 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697396423;
	bh=6OZacGS05uBy2LONS8wfI4sS26PvJ4rlgCfhbqwU8cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KWLBRT7WGU/uAMsgA6DWHyiWmkDy6KY6gW+afK7q4QZ3GfX6dGJw5tSkcmNGEcaaO
	 yIilNmFMOWWz9KBXKCstoORz3Y7W5uCB5iOugczdnF1audmxduGRFQsUjarAi4/VJI
	 qjXBTcgGfeENsM2Ju5A1URQnbJBXKD4IJf6bd2+Wur03ERlCO/apgYFJ3vM3A9nUxs
	 Q06PdFgIpDXJA+HOWYIHkbYptEKTzcEdU1v5DyQPASpbs/oMMEAB9X4TQTGPNc0QL3
	 n9AOxgU1q0dsCEdWxa7nxkuW6dSB0dPYMjbmQxWiTYdxrPsVwOx565iKxNP6GH+s3D
	 lpftOnnQI8OiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25C97C691EF;
	Sun, 15 Oct 2023 19:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169739642314.10768.3860423285266903424.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 19:00:23 +0000
References: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew@daynix.com,
 jasowang@redhat.com, willemb@google.com,
 syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com,
 syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 11 Oct 2023 10:01:14 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Syzbot reported two new paths to hit an internal WARNING using the
> new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.
> 
>     RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
>     skb len=64521 gso_size=344
> and
> 
> [...]

Here is the summary with links:
  - [net] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
    https://git.kernel.org/netdev/net/c/fc8b2a619469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



