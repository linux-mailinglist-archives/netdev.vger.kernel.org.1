Return-Path: <netdev+bounces-27241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549CD77B21C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E397281022
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D638F53;
	Mon, 14 Aug 2023 07:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341E7497
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F516C433CC;
	Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691997023;
	bh=anihsnWOgf0g4Ex//ybWavVAjhegPYEbK4XOyzahmCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D/Po6qgLnJSvnVMtNdGzjHTjFml7rHwH9ld3d+Zzxsz0odn4JOWWlXWkLiYYaMZ+Q
	 b2Oa4Ru9o13U6OnSssqYwekbZtlkpbjtC9Y+pmaPdypObrMAfbGI1mM1DqJEOEpT+i
	 hnRgq46dCAYF9XZ7sbyu1+7xzjq7NG/UmK60YtalanhDUBqzHFhk6F6K+MXWM+m6/G
	 8yqTjBTFwu5h+KvRlg+xRXPG/3RbWtAY2ETaskPCvfUjo2UeCc9LKgcFrk5iVQaJUw
	 RyZ9rWsqUEgr/hLVhcqLXfBQYCf/7DxBluTDskGaIa/Teaoba+EolC33MHc6qrOOVn
	 FTL26ni2siabg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42A38E93B33;
	Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v22] vmxnet3: Add XDP support.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169199702327.11756.207039418388322318.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 07:10:23 +0000
References: <20230810041304.15163-1-u9012063@gmail.com>
In-Reply-To: <20230810041304.15163-1-u9012063@gmail.com>
To: William Tu <u9012063@gmail.com>
Cc: netdev@vger.kernel.org, jsankararama@vmware.com, gyang@vmware.com,
 doshir@vmware.com, alexander.duyck@gmail.com, alexandr.lobakin@intel.com,
 bang@vmware.com, maciej.fijalkowski@intel.com, witu@nvidia.com,
 horatiu.vultur@microchip.com, error27@gmail.com, simon.horman@corigine.com,
 alexanderduyck@fb.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  9 Aug 2023 21:13:04 -0700 you wrote:
> The patch adds native-mode XDP support: XDP DROP, PASS, TX, and REDIRECT.
> 
> Background:
> The vmxnet3 rx consists of three rings: ring0, ring1, and dataring.
> For r0 and r1, buffers at r0 are allocated using alloc_skb APIs and dma
> mapped to the ring's descriptor. If LRO is enabled and packet size larger
> than 3K, VMXNET3_MAX_SKB_BUF_SIZE, then r1 is used to mapped the rest of
> the buffer larger than VMXNET3_MAX_SKB_BUF_SIZE. Each buffer in r1 is
> allocated using alloc_page. So for LRO packets, the payload will be in one
> buffer from r0 and multiple from r1, for non-LRO packets, only one
> descriptor in r0 is used for packet size less than 3k.
> 
> [...]

Here is the summary with links:
  - [net-next,v22] vmxnet3: Add XDP support.
    https://git.kernel.org/netdev/net-next/c/54f00cce1178

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



