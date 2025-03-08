Return-Path: <netdev+bounces-173140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B7A577FD
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0156618996D8
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001251953BB;
	Sat,  8 Mar 2025 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7MimtaV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA0194C86;
	Sat,  8 Mar 2025 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405218; cv=none; b=t2nqFa7aq3OGnTWTGllkRfdi2RvNF22HWdDrtvT+uSh2mBoRjHEBcIOYwjLg1huXk0wk7Vg1s6EARl8vYhdBCqKz68SAayOaZ08Y2XwgkymYLcMiF/513ju3mB2wGT61+vTsNneY/l3zV7xfuaniLf6kSkK1lZ9Cuq95+F993zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405218; c=relaxed/simple;
	bh=nnK9GgQQvApGvGiUehqlLs+ig3NFS4kx+7YOpbqlyk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OwJ172LpVZh+GQjkicwMyRzrTGhCXXkEoRG/ukW/fZ/uVShiYulH8XXS0J4VrH7dhk3iSvk6j1UL3JkvHCQj/ANqZYr5e/CWHYvXwKAoKdkRwiQj5F0LK/Zvzan+hDrorTy/fHctCJOYyFuGh3VWb77q24frYiVmNpxY7LdvGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7MimtaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A281EC4CED1;
	Sat,  8 Mar 2025 03:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405218;
	bh=nnK9GgQQvApGvGiUehqlLs+ig3NFS4kx+7YOpbqlyk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T7MimtaVMIm7WOvAm3yWbEZgfGtq4jJECDUm9oNdvj2h4pP9OZRkDGrPyJ0a848YT
	 t4i8xmDUTkYcpIIOb8uP0Tz7X7Vqxxh70Z4sXNOVYCWq3LHIzwhrR8nagSy1StnRSB
	 hFow9sn592hThsSf32dK8lIb6EOw8X6ox2LChzj8CuWEuc9sb4LalVZAarUCio6ab+
	 lRMFzAkQD0m0n8JsuBEPhTsnc2VJ55jxAEw2D6tmAY28+c4rSybunvpTuF/xT2facm
	 F6rS31d0RJgdRyRwIdQtYT8Xsni+0KVpWPA6hR0oQ8JbucNivYHj4zxpn5KKYtlxvF
	 +JyNFLC4AVblw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE9380CFFB;
	Sat,  8 Mar 2025 03:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: convert to use netmem for DQO RDA mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140525223.2565853.15946733400929396674.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:52 +0000
References: <20250307003905.601175-1-hramamurthy@google.com>
In-Reply-To: <20250307003905.601175-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, shailend@google.com, willemb@google.com,
 ziweixiao@google.com, jacob.e.keller@intel.com, linux-kernel@vger.kernel.org,
 almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 00:39:05 +0000 you wrote:
> To add netmem support to the gve driver, add a union
> to the struct gve_rx_slot_page_info. netmem_ref is used for
> DQO queue format's raw DMA addressing(RDA) mode. The struct
> page is retained for other usecases.
> 
> Then, switch to using relevant netmem helper functions for
> page pool and skb frag management.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: convert to use netmem for DQO RDA mode
    https://git.kernel.org/netdev/net-next/c/aa3e360701c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



