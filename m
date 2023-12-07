Return-Path: <netdev+bounces-54935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D1808F9A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3731F21136
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CC4CE14;
	Thu,  7 Dec 2023 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR2sLRZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38553125CD
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AF72C433C9;
	Thu,  7 Dec 2023 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701972642;
	bh=wn/rZxaQ6CPwgoghWVPT2OqAL9b44Y+FKEXiemEFjYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BR2sLRZBFK/Oivcp9YQ3xIJYkQucj47JQmP2e3RZ/1Lld5zrh1W6LjKmfbA9WjX6+
	 w/rfuAZE+Nb6YwV7qiuADkII9fWUVf95m/jR1a3Wk+sWKTctXhNvLSBUxX1wZ1en2a
	 8p3tn4BUg7sutTI5c48bw0z//nDVw43F/FwOWqRLM242jSZdYs/FS9fsp425oY8j/Y
	 drRGWy6Tr99X1XO9Vp34L84ODZgKsthegMRXT0L8LkcRDxAEN6GAtFCXHGfacGag22
	 WSmJ1L2gx5/HATBGnB4vZcgmeaH7hejwdpBk/em88MvR//x1X0s6EoYpjDnBOZZ1xS
	 +2kNvagFMbspg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7089DC43170;
	Thu,  7 Dec 2023 18:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid protocols
 for xmit handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170197264245.15422.7349743280865094840.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 18:10:42 +0000
References: <20231206071655.1626479-1-sean@geanix.com>
In-Reply-To: <20231206071655.1626479-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arun.ramadoss@microchip.com, ceggers@arri.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 08:16:54 +0100 you wrote:
> Provide a list of valid protocols for which the driver will provide
> it's deferred xmit handler.
> 
> When using DSA_TAG_PROTO_KSZ8795 protocol, it does not provide a
> "connect" method, therefor ksz_connect() is not allocating ksz_tagger_data.
> 
> This avoids the following null pointer dereference:
>  ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
>  dsa_register_switch from ksz_switch_register+0x65c/0x828
>  ksz_switch_register from ksz_spi_probe+0x11c/0x168
>  ksz_spi_probe from spi_probe+0x84/0xa8
>  spi_probe from really_probe+0xc8/0x2d8
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dsa: microchip: provide a list of valid protocols for xmit handler
    https://git.kernel.org/bpf/bpf/c/1499b89289bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



