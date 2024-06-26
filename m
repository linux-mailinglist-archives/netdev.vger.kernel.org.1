Return-Path: <netdev+bounces-107018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B494918818
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4335D28414A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A3C18F2C8;
	Wed, 26 Jun 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/HAROh+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001813BC02
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421252; cv=none; b=tXEu1AHFxBlXcak+ziuT/9cM9qMxiljzPn2VSdt5Hg2Po9FtE2Qe/Sy6a5v2tmsN3YMf7B3b7Fbbms51ynX/N7kLrFNcHU/dAP8QeGRWisW11j3xap0q0PgydWfU11WzDGc6eWf+VJJMOuxVN7dQHVpyG8kFKgxWF64Mn++GIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421252; c=relaxed/simple;
	bh=l849LGc110ooq5p68Sj2HscsjhqWlOuZoqdG9s5ybdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFg2UqXTZD4a8OnA8/Q5BS1DyHDBl10H9N/l8OQrs6plsyBLCN4ltH4kASfKIkNNVZeBEILZJo04YOg1+FBE/c2eJTDafx+NvZVeIuSIdqtqj4f7T3NC/EUWPDqk2it4zCgWH2+uw3YW2pCSXlNKjCjKqlWxbXl1NB/M9SOybNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/HAROh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCF7C116B1;
	Wed, 26 Jun 2024 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719421252;
	bh=l849LGc110ooq5p68Sj2HscsjhqWlOuZoqdG9s5ybdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f/HAROh+XimbMs9Pp36+32JFY7j15XY6MNhrNnktzOS5Ir4IZ826pkFWsPVs0crB9
	 MmLXv6tNyoiPdmOK7WDBd7+PYIfV8aAVHFriNGXaTVj0wqnlxUCL+Ru3xokv+9bemO
	 i/MPOGGRWiUvDifWbvDEm+M2xIWKbhBgpL+2sQnH17LmvngePIOX8NUUZJmi4WhDKM
	 uy9xbgue4in7zdXdnzvaBz5colLtlLV2iGhbZ0PzOqLZVst5TyHEw16YadmPjx1NnC
	 Xz9jhWtekuuW/qYfuLGtRrlE2u9EJYsggtumCLicZZYbvYR23onmOmc6Ue0/WUKyfD
	 8LHVqYefaK7ZQ==
Date: Wed, 26 Jun 2024 10:00:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dw@davidwei.uk,
 przemyslaw.kitszel@intel.com, michael.chan@broadcom.com,
 andrew.gospodarek@broadcom.com, leitao@debian.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v3 0/4] selftests: drv-net: rss_ctx: add tests
 for RSS contexts
Message-ID: <20240626100051.767c4e9d@kernel.org>
In-Reply-To: <f81bd29b-7f5e-781d-df05-da34fd539888@gmail.com>
References: <20240626012456.2326192-1-kuba@kernel.org>
	<f81bd29b-7f5e-781d-df05-da34fd539888@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 17:50:20 +0100 Edward Cree wrote:
> On 26/06/2024 02:24, Jakub Kicinski wrote:
> > Ed, could you try the tests with your device?  
> 
> Don't seem to be able to get them to run:
> 
> # Exception| Traceback (most recent call last):
> # Exception|   File "/home/ecree/kern/linux/tools/testing/selftests/net/lib/py/ksft.py", line 134, in ksft_run
> # Exception|     case(*args)
> # Exception|   File "./drivers/net/hw/rss_ctx.py", line 70, in test_rss_key_indir
> # Exception|     if len(_get_rx_cnts(cfg)) < 2:
> # Exception|   File "./drivers/net/hw/rss_ctx.py", line 55, in _get_rx_cnts
> # Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
> # Exception|   File "/home/ecree/kern/linux/tools/net/ynl/lib/ynl.py", line 1029, in _op
> # Exception|     return self._ops(ops)[0]
> # Exception|   File "/home/ecree/kern/linux/tools/net/ynl/lib/ynl.py", line 985, in _ops
> # Exception|     raise NlError(nl_msg)
> # Exception| net.ynl.lib.ynl.NlError: Netlink error: Operation not supported
> # Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
> # Exception| 	error: -95
> # Exception| 	extack: {'bad-attr': '.ifindex'}
> not ok 1 rss_ctx.test_rss_key_indir
> 
> Cursory investigation suggests this is because sfc doesn't
>  support netdev_stat_ops, we're still living in the bad old
>  days of ethtool -S for our per-queue stats :(

Ugh, right, the standard stats turn out to be key in a large number 
of the tests we end up writing. Perhaps unsurprisingly :(

Fetching stats is done only in _get_rx_cnts(), so you could possibly
do a quick hack there to parse ethtool -S, just to test the test.
But maybe that'd just lead you to another gap..

> Much as I'd like to fix that, I don't see a prospect of the
>  folks upstairs carving out time for it any time soon...

Sadness. Makes me worried that they won't care about maintaining
the Supported status of the driver either :( (Which is not to say
that implementing qstats is a requirement there.)

Anyway, thanks for giving it a go. I'm fairly confident now that
the failures I see are a device / driver bug. So we can merge
the test and let the various drivers address the gaps.

BTW, while I have you, there are two more bits of work:
 - get + dump API via netlink
 - set API via netlink
are you planning to work on those?

