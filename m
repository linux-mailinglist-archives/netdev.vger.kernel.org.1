Return-Path: <netdev+bounces-15055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53C745733
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B07F280CE1
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAAC20E8;
	Mon,  3 Jul 2023 08:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611717FD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92E19C433BB;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688372422;
	bh=1txSw2srHoolnewTEuF54cblhQjnp+V4SXu+ZkTp4+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJ6IQWNCIwhqKYpXbMUQLnpwU2wjb4ufpY6PmmOvGG4bODo12xZh9Q6fGdoTyVac0
	 rT0rH04E38HPjQiNJOqVUTWwjH69KhGsxYJ+CJQZ0+Kt0+R4iAYzpXHjJaeKYTEcex
	 /QCdQJ+e8MWml6qKyG8P/RirT9TDPSlyUHYJE/zyH5vFea8cqi5FIiT9ackFGI4Swp
	 CEZPPW9La4CvgKHXPTNwe66ahVY6hej00/3K19fmZlxlE/bg1b3TOqTbtGF9s7TTDK
	 cqTeYbH2IRGZl6qGvDvsLPi8G3A5X8QGX7DPUVO0ZZrPUorCR6zb+xmWn8Xej2D75Y
	 LzMdITR5DgCNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7351DC39563;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: tag_sja1105: fix source port decoding in
 vlan_filtering=0 bridge mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837242246.9798.5147519916489764756.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:20:22 +0000
References: <20230630222010.1691671-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230630222010.1691671-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 simon.horman@corigine.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  1 Jul 2023 01:20:10 +0300 you wrote:
> There was a regression introduced by the blamed commit, where pinging to
> a VLAN-unaware bridge would fail with the repeated message "Couldn't
> decode source port" coming from the tagging protocol driver.
> 
> When receiving packets with a bridge_vid as determined by
> dsa_tag_8021q_bridge_join(), dsa_8021q_rcv() will decode:
> - source_port = 0 (which isn't really valid, more like "don't know")
> - switch_id = 0 (which isn't really valid, more like "don't know")
> - vbid = value in range 1-7
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode
    https://git.kernel.org/netdev/net/c/a398b9ea0c3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



