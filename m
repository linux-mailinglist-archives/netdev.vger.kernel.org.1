Return-Path: <netdev+bounces-61055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF782257D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8EA1F2299F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01A1774A;
	Tue,  2 Jan 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJjsmtaa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318E17740
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 23:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B526FC433C7;
	Tue,  2 Jan 2024 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704238153;
	bh=u0MjpuL2LRbgaDrM37UMSAtafXNWxtSoQQhVY08Yqrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJjsmtaa3EBld9Y9xI2z0GttBIxlNNqDb66juv0tn+6OgE74P9k4YWzaY3ja6cxbU
	 94dtGz9BKCKxsIdyBfCvHgEytxrGq20wMwimGTvMq6S9EFu6BDQw2xh1QlAUJn1nqL
	 iGzJea5A1MmJnLLd8JmBT7Qw0/yyeIT7cFk6Dsmw9Lf4JCKelQIlntZPvzOnCHf1ty
	 1XSSRdlheQMx9jNw8Q9cC0eq+X1xmeJ9HluMrlBivnqed6hC5KWk0QNwfKtj//F/Y7
	 Sso11HODxpkedqMAZAlXmSfjwz+1zsIWsKxzqREFhXb1uTv12sEAzuAq3F3ZyyolRo
	 /QV4aUCxBazsw==
Date: Tue, 2 Jan 2024 15:29:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ivan Babrou
 <ivan@cloudflare.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 0/4] af_unix: Random improvements for GC.
Message-ID: <20240102152911.20171dee@kernel.org>
In-Reply-To: <20231219030102.27509-1-kuniyu@amazon.com>
References: <20231219030102.27509-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 12:00:58 +0900 Kuniyuki Iwashima wrote:
> If more than 16000 inflight AF_UNIX sockets exist on a host, each
> sendmsg() will be forced to wait for unix_gc() even if a process
> is not sending any FD.
> 
> This series tries not to impose such a penalty on sane users who
> do not send AF_UNIX FDs or do not have inflight sockets more than
> SCM_MAX_FD * 8.
> 
> Cleanup patches for commit 69db702c8387 ("io_uring/af_unix: disable
> sending io_uring over sockets") will be posted later as noted in [0].

Could you repost? I tried to revive it in patchwork but I think 
it keeps getting Archived because it's more than 2 weeks old :(

