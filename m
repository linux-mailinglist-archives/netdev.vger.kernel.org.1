Return-Path: <netdev+bounces-16208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C08274BD02
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B802819C0
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B42523D;
	Sat,  8 Jul 2023 09:13:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86128F0
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 09:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8181C433CA;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688807593;
	bh=Z6PwUAEV5VmXzx50S7lh194Y607w3WMVqJasRBZovpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VbdF2b8YrIp89dV2LR1bZr4L3aWspMNJOG6ZXIPftDA3V9otVHMOF8oWKI4e73fic
	 TEogcCbNHd5uNy9pyaC/XRCA7kTt/rf2W3xYnaLbw9DQqDL4VUTlpFBGQFAzRUSLx6
	 AbJKJTlitE5bec+2TKx5C/Vnif0sUKr/C4kU/PdEDTSEQfCeERmlVJT69aEUmHjcBI
	 uVBxt/GXQD6Tf6WHXxB6ZDmzvUWWPfv8qeLaPyS35X8sNh7uByXgs80nDukcRzd6xy
	 P+jcLVaTzPu9F7IYziMkfFP9sRYEGUnBFTDB/Nl3oN0mRKiQZL3wi7MC57A/hHJzKX
	 4FG3tVRLFE8LA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBC8AE53808;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev
 in icmp6_dev().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168880759376.30427.5739144454086850037.git-patchwork-notify@kernel.org>
Date: Sat, 08 Jul 2023 09:13:13 +0000
References: <20230708014327.87547-1-kuniyu@amazon.com>
In-Reply-To: <20230708014327.87547-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, wangyufen@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 7 Jul 2023 18:43:27 -0700 you wrote:
> With some IPv6 Ext Hdr (RPL, SRv6, etc.), we can send a packet that
> has the link-local address as src and dst IP and will be forwarded to
> an external IP in the IPv6 Ext Hdr.
> 
> For example, the script below generates a packet whose src IP is the
> link-local address and dst is updated to 11::.
> 
> [...]

Here is the summary with links:
  - [v3,net] icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().
    https://git.kernel.org/netdev/net/c/2aaa8a15de73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



