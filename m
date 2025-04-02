Return-Path: <netdev+bounces-178925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFFA79917
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB71718E5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50FC1F8739;
	Wed,  2 Apr 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvLOcdmE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFD1F8725
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637207; cv=none; b=NUMu+stXV9IiuHkojeUT/wikeb90H1WJVZMUENk58n6HhNrHAjHJAsfF27QeJC0awoRIo8wuj7B+joCT1FxN3Qo27JdcfAJSP3cHWUXTaHPsswUTpVfQMBm8h1GnL4RKbhp0eK+37juO8nu04mlbkyFCjnhB9MSndTWfq1sAt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637207; c=relaxed/simple;
	bh=Bt2+ylCDCULSGt5nLv1shq3mwylcM3/US0MV5+Bai3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UECkeKzWtbvRW8p7ePMdPZ8PQPZnYG8faOYFTdt5VNUg+lth8kgiyKvrizLiZI4Nqjq/P1YmJqe5WNKVO0D1JMiCqKQGf+VhsHUj/oqe03YgqYNd5myu8oqzp131JhUFgJtg0ZKp0E8Dw/ir11eEZAw7Hjiu0/1VmTTWny6GCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvLOcdmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E755C4CEE9;
	Wed,  2 Apr 2025 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637206;
	bh=Bt2+ylCDCULSGt5nLv1shq3mwylcM3/US0MV5+Bai3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NvLOcdmE4l2qunB8uuJ67ncdOG2IEdK1AwwNhnWxwLXiqL94NF+4TigyAPrOZy1YT
	 vDJ3LbOECt9UgC8XXj5OvqBe0fcCZQm31/xokCwbvm3sAGteCFu0zIiDPqDM/rR1M2
	 v/4LZTTy4Mb88mCNliHqFch2PmGR+caOGMBrNwGP7EoGz3XgeV9ml3YgP+3KSoFoD9
	 dFR8w7ugtKdqGbrOZqN9CzANKTsVaMgI5HthfVlnpg7dDH3pd+rk9DUau5/xeHIweV
	 G90Hz8FJOGqrNDDXMW1S5yKGvixVSYrS+vTy3W6icjUTxF1BJqaSyXU6hCkEFEtaD/
	 515vir6l/KUqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B76380CEE3;
	Wed,  2 Apr 2025 23:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix qid report in
 airoha_tc_get_htb_get_leaf_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363724274.1716091.6235443928429080409.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:42 +0000
References: <20250331-airoha-htb-qdisc-offload-del-fix-v1-1-4ea429c2c968@kernel.org>
In-Reply-To: <20250331-airoha-htb-qdisc-offload-del-fix-v1-1-4ea429c2c968@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Mar 2025 08:52:53 +0200 you wrote:
> Fix the following kernel warning deleting HTB offloaded leafs and/or root
> HTB qdisc in airoha_eth driver properly reporting qid in
> airoha_tc_get_htb_get_leaf_queue routine.
> 
> $tc qdisc replace dev eth1 root handle 10: htb offload
> $tc class add dev eth1 arent 10: classid 10:4 htb rate 100mbit ceil 100mbit
> $tc qdisc replace dev eth1 parent 10:4 handle 4: ets bands 8 \
>  quanta 1514 3028 4542 6056 7570 9084 10598 12112
> $tc qdisc del dev eth1 root
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix qid report in airoha_tc_get_htb_get_leaf_queue()
    https://git.kernel.org/netdev/net/c/57b290d97c61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



