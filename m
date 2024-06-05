Return-Path: <netdev+bounces-100883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407708FC747
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37B6287809
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084C18FC64;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3uE7tQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C718FC92;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578630; cv=none; b=dx1KkHbBdNHLyevRtgaSFbQQ6eM8MujU8oPjZpz1Ne7IbH92Hzbvlhvh95f+wRrML0fYWlE0Jf2n67jT3ZBNrHkOUUCZkMLR/xj/h4mmEbZ0SnjkotM1d24sR66oYhKO4+SWr8gG7qJj1Q83GayjzvBMapC5UcuT26b8ci8tFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578630; c=relaxed/simple;
	bh=RPLabVS3C/7mEMiHt/tS8eJuahEqOCcV0aM85nPJOqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mY9zUPphzpqXaSFP8RF7nd9tCS2ARc//bZpLPXLbCEy5+Gl5tfmjM0TarpxyoDdnRkDhYCB6EY7r1VUpbPHuQOB0FINWer91LNVJdG/e/7MBoJGXBgSxGWH2SVKq/r5GMs0h0TsZ4zn7oTHXRLySNA6+oA627zpn9DkE6z02Ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3uE7tQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0403FC32786;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717578630;
	bh=RPLabVS3C/7mEMiHt/tS8eJuahEqOCcV0aM85nPJOqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N3uE7tQdTjfanFZf33PnTRFQVLac1rWwQ984iZYlkUhxVMJmXdpCrhcuXO8Ab83b7
	 4pfNHnJX+Shcid0tUn7OeL4zt7+8hwGngk5Sn+2mFG2sZ8LpizDYNmts+rVK1eE28v
	 IP5uqy1zNUQpFzKw8yXCDRLpMj8MqN2Z5RGrodSSuqoKead8kI0p1lFvcuS65SMFj8
	 cDjkEqMhcd27VpKK3PdecUq3kWxWo5xKsdss/qIu+QYAq+FPlRXTP9+U8EpcEQH+f5
	 ioEqfLdjvphWCJMIP/o+koE3jmBIXTcws12iGH+kurUW/AXgjYzMFK3iUp0HCHiFPP
	 2B0Qml+Dzr4pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB398D3E996;
	Wed,  5 Jun 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bridge: fix an inconsistent indentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757862996.24611.14667741399171136250.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:10:29 +0000
References: <20240531085402.1838-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20240531085402.1838-1-chenhx.fnst@fujitsu.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 31 May 2024 16:54:02 +0800 you wrote:
> Smatch complains:
> net/bridge/br_netlink_tunnel.c:
>    318 br_process_vlan_tunnel_info() warn: inconsistent indenting
> 
> Fix it with a proper indenting
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: fix an inconsistent indentation
    https://git.kernel.org/netdev/net-next/c/cdbdb3c62af5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



