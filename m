Return-Path: <netdev+bounces-31076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47B78B406
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89E1C20914
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913012B9A;
	Mon, 28 Aug 2023 15:09:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFB12B8A
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D51BC433C7;
	Mon, 28 Aug 2023 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693235378;
	bh=8N3gBm94S4M4Md/pS/5ZEK1w30bqe5VSsHjkuVKdaQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZAq4XyiwyR1/zBQaOL9+tgV6pcORaUD1xSrxrx8MfeqZAkGv0mTjxVt80I3DyVm8+
	 cWwwM5JXJDA02DlewLwJkL1OGOX8kcJGx473Yp8I/DbdouBCXM+7zSCsm0erlxDL/x
	 /xjGE8T0KVID54BpDCx9gf6QQj82fjEL+j5uur5ICZU5CQZmwzIcxoa2LGIbclD3e2
	 CB5yRWlBr67hyYubJJZlbVP4/ylJ5bSh/HZma6JlTEmgXxE/crrtqjoTjvPxFwLBQI
	 0z40wDQQMzi7CNbQ5T4oLualMnSVBAEUParj/wgyXxDRmnpyyuL0gVMcbQ0s6fIiEP
	 8GmOQTGwgxGWg==
Message-ID: <874ad143-ad59-803f-6511-f4de7bd34f57@kernel.org>
Date: Mon, 28 Aug 2023 09:09:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] ipv4: annotate data-races around fi->fib_dead
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>
References: <20230828121515.2848684-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828121515.2848684-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 6:15 AM, Eric Dumazet wrote:
> syzbot complained about a data-race in fib_table_lookup() [1]
> 
> Add appropriate annotations to document it.
> 


...

> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 21839 Comm: kworker/u4:18 Tainted: G W 6.5.0-syzkaller #0
> 
> Fixes: dccd9ecc3744 ("ipv4: Do not use dead fib_info entries.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/fib_semantics.c | 5 ++++-
>  net/ipv4/fib_trie.c      | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



