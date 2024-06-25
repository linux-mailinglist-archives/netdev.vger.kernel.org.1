Return-Path: <netdev+bounces-106486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA321916960
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6C91C208ED
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83715FD08;
	Tue, 25 Jun 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWBbI3Lf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859C15FCE7
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323443; cv=none; b=Q0zGPIENEh1wiAcd8SICKjBt8qPrAy1QWrBXyCp8jvjC+yMTXsl0vEAwQwPcjs05eLHMn2/toMoUqvmws4CIUxinjhFtg8JcuCd/IslHKtmm4UUrvSS8uzgk2zpuumcyQ6Cj25/Oj4O1kdAa/bZVM3ylpqKNsm33G36jV0xcXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323443; c=relaxed/simple;
	bh=Q1D3Y4tgSntq4QmiV8NZlu2nVMkg3YogUxCywizvy/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlYngpGdCA2bEMiHSUx/dfBSh630Hf2g4VUO4OFlWHZcmpxCFbAUysCFYQbjTe6XvGtG+u5QV9MlhRPIxlPzaNA4qhmqJQeu8bYx7VLTYLqto+qQd4CTC4mQXhmhna2TvRLr4gvHYXDRtoDKj9DQc/5AzSy5pHUODl7PhxODN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWBbI3Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7706FC32781;
	Tue, 25 Jun 2024 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323442;
	bh=Q1D3Y4tgSntq4QmiV8NZlu2nVMkg3YogUxCywizvy/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWBbI3LffVR1IZizAuD+b51csVl6Pvh1LtaC0YdpO363tsGz3Gbf9mpoUX7bggqML
	 svwTZTavhWI8rf2XkRhDGCoXXa9CXsyPRwFoDDEM0r03avtZgNk6aIyTB23u5T1YM9
	 UqIkcDC5XaofEVTB3k6qCZDbzXoOkDnSapJjKI6ZKqc4Zicw7Xs8b+PBUDY3VnwYSA
	 YptWtgTIgEyREByNwC8CiftjTpddOb+ClkyOOOZxPy8Kw2GWSXztvwN/r09xdlTBiR
	 1UmZi7iM5pczfK1AN21oEPz/7IXM1jmsum+FUW6ziw+eBRrae/DEqb1wsDVzOhcjZq
	 qI1eAMPkaPL1A==
Date: Tue, 25 Jun 2024 06:50:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
 <ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
 <michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: rss_ctx: add tests
 for RSS configuration and contexts
Message-ID: <20240625065041.1c4cb856@kernel.org>
In-Reply-To: <877cedb2ki.fsf@nvidia.com>
References: <20240625010210.2002310-1-kuba@kernel.org>
	<20240625010210.2002310-5-kuba@kernel.org>
	<877cedb2ki.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 12:42:22 +0200 Petr Machata wrote:
> > +def test_rss_key_indir(cfg):
> > +    """
> > +    Test basics like updating the main RSS key and indirection table.
> > +    """
> > +    if len(_get_rx_cnts(cfg)) < 2:
> > +        KsftSkipEx("Device has only one queue (or doesn't support queue stats)")  
> 
> I'm not sure, is this admin-correctible configuration issue? It looks
> like this and some others should rather be XFAIL.

TBH I don't have a good compass on what should be XFAIL and what should
be SKIP in HW tests. Once vendors start running these we'll get more
experience (there's only one test using Xfail in HW now).
> > +    cnts = _get_rx_cnts(cfg)
> > +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> > +    cnts = _get_rx_cnts(cfg, prev=cnts)
> > +    # First two queues get less traffic than all the rest
> > +    ksft_ge(sum(cnts[2:]), sum(cnts[:2]), "traffic distributed: " + str(cnts))  
> 
> Now that you added ksft_lt, this can be made to actually match the comment:
> 
>     ksft_lt(sum(cnts[:2]), sum(cnts[2:]), "traffic distributed: " + str(cnts))

ack

> > +    # Try to allocate more queues when necessary
> > +    qcnt = len(_get_rx_cnts(cfg))
> > +    if qcnt >= 2 + 2 * ctx_cnt:
> > +        qcnt = None
> > +    else:
> > +        try:
> > +            ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
> > +            ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
> > +        except:
> > +            raise KsftSkipEx("Not enough queues for the test")  
> 
> There are variations on this in each of the three tests. It would make
> sense to extract to a helper, or perhaps even write as a context
> manager. Untested:
> 
> class require_contexts:
>     def __init__(self, cfg, count):
>         self._cfg = cfg
>         self._count = count
>         self._qcnt = None
> 
>     def __enter__(self):
>         qcnt = len(_get_rx_cnts(self._cfg))
>         if qcnt >= self._count:
>             return
>         try:
>             ksft_pr(f"Increasing queue count {qcnt} -> {self._count}")
>             ethtool(f"-L {self._cfg.ifname} combined {self._count}")
>             self._qcnt = qcnt
>         except:
>             raise KsftSkipEx("Not enough queues for the test")
> 
>     def __exit__(self, exc_type, exc_value, traceback):
>         if self._qcnt is not None:
>             ethtool(f"-L {self._cfg.ifname} combined {self._qcnt}")
> 
> Then:
> 
>     with require_contexts(cfg, 2 + 2 * ctx_cnt):
>         ...

There are 4 things to clean up, with doesn't cover all of them
naturally and complicates the code.

Once again, I'm thinking about adding some form of deferred execution.
	
	ethtool(f"-L {self._cfg.ifname} combined {self._qcnt}")
	undo(ethtool, f"-L {self._cfg.ifname} combined {old_qcnt}")

Where cleanups will be executed in reverse order by ksft_run() after
the test, with the option to delete them.

	nid = ethtool_create(cfg, "-N", flow)
	ntuple = undo(ethtool, f"-N {cfg.ifname} delete {nid}")
	# .. code using ntuple ...
	ntuple.exec()
	# .. now ntuple is gone

or/and:

	nid = ethtool_create(cfg, "-N", flow)
	with undo(ethtool, f"-N {cfg.ifname} delete {nid}"):
		# .. code using ntuple ...
	# .. now ntuple is gone

Thoughts?

> > +        # Remove last context
> > +        remove_ctx(-1)
> > +        check_traffic()  
> 
> I feel like this works by luck, the removed[] indices are straight,
> whereas the ntuple[] and ctx_id[] ones shift around as elements are
> removed from the array. I don't mind terribly much, it's not very likely
> that somebody adds more legs into this test, but IMHO it would be
> cleaner instead of deleting, to replace the deleted element with a None.
> And then deleted[] is not even needed. (But then the loops below need an
> extra condition.)

I'd argue with the "by luck" but I see your point that it's suspicious,
I'll change it :)

