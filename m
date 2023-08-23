Return-Path: <netdev+bounces-29842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C241784E76
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 04:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6406C1C20BF9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF015A4;
	Wed, 23 Aug 2023 02:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4910E9
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A21F5C433C9;
	Wed, 23 Aug 2023 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692756025;
	bh=NgzV4+XM3XsGzxwOsUENSuJiQJDHs1xS49RClfCdVZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iMqLLAv0xWXM8rrFv5E++SCD+Xix33Afvx8uOqHRCZIRDTiO8hWx8J4HzbqUD0aB1
	 ErCP2UUgLutLFaDeUJrEvVOu6SpCu8SjhH+mHO7jfPhMsC2MRg2HZjiztv8J78hCIo
	 Xwe/GMjxsBsk2qN2tbrXIthDm/L4Q/SUBd/kKZ1VnmFCpgGvhE+qpiVBsK8CaGSF1k
	 PCazid7m6JCJ6itdeg6H2p8Zb8QGHQEazFyqGHietUhAYJIGBPDnWRP4Y0RxGaZxaM
	 DDE4DeLKVT8jGQjfZvHGIucnV5ZBCjgZNRq7hhMz5YMmzIi/L9+if0yIb2SpejWq1e
	 0GO1ulCdo2mhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8289AE4EAF6;
	Wed, 23 Aug 2023 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/10] netfilter: ebtables: fix fortify warnings in
 size_entry_mwt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275602552.4956.7525189385907152255.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 02:00:25 +0000
References: <20230822154336.12888-2-fw@strlen.de>
In-Reply-To: <20230822154336.12888-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 gongruiqi1@huawei.com, GONG@breakpoint.cc, gustavoars@kernel.org,
 keescook@chromium.org

Hello:

This series was applied to netdev/net-next.git (main)
by Florian Westphal <fw@strlen.de>:

On Tue, 22 Aug 2023 17:43:22 +0200 you wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] netfilter: ebtables: fix fortify warnings in size_entry_mwt()
    https://git.kernel.org/netdev/net-next/c/a7ed3465daa2
  - [net-next,02/10] netfilter: ebtables: replace zero-length array members
    https://git.kernel.org/netdev/net-next/c/a2f02c9920b2
  - [net-next,03/10] netfilter: ipset: refactor deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/e53314034b23
  - [net-next,04/10] netfilter: nf_tables: refactor deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/6cdd75a4a66b
  - [net-next,05/10] netfilter: nf_tables: refactor deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/7457af8bf994
  - [net-next,06/10] netfilter: nft_osf: refactor deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/6d87a4eae89e
  - [net-next,07/10] netfilter: nft_meta: refactor deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/ad156c23d65c
  - [net-next,08/10] netfilter: x_tables: refactor deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/06f7d3c3f82c
  - [net-next,09/10] netfilter: xtables: refactor deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/aa222dd190d6
  - [net-next,10/10] netfilter: nf_tables: allow loop termination for pending fatal signal
    https://git.kernel.org/netdev/net-next/c/169384fbe851

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



