Return-Path: <netdev+bounces-106590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7FB916ED9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF131F212F2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CC917624A;
	Tue, 25 Jun 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVqJQg2X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419717623C
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335211; cv=none; b=oNvDJ4CQIA7nzuwQ8cLk6NoGDrAuXGmxP5ypmNyG3NrJV0g/ni3FmEgjiqsoLR/jzx7rKWVUoioG3NvkcfQzhJRYNiBAusi6jI4LWk2U3pj66l56iTD2T7cyD57qtMosinRD/+/RvLS2aWWGlZpMou0eB6Mix983I6n38MFZR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335211; c=relaxed/simple;
	bh=hnpS8hlXytXiaVpQysLyEqRZht2k8jKUqVFbs6cEB34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGhBo7QrVevEHXY0yLrjDRlpISTQ7z/iYB3eIlcPCPP8dWSHijOLQBaWmU336M4yJgGsPVBS4X0h5gC93T3HxkX0caAlnHjGLfLrsjio+sUXHnj8JunS5JNm0xvOaEtK1ctIdDaisNxMcGkY19L1tPOm69fM3js8WYL8oF6Liaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVqJQg2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE48C32781;
	Tue, 25 Jun 2024 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719335210;
	bh=hnpS8hlXytXiaVpQysLyEqRZht2k8jKUqVFbs6cEB34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WVqJQg2XYEesTbt8HsEdgWn0LMjibVhdA7BXLGl3mIehJNLdaNZc3VrUUEnOqoWzr
	 MRdnZUMTfuOJ+qhlkp+9QRKuiRbY8hifwQtFcAr/GrlzBq9/U0IrZHMOcNxNKtyrug
	 xANqN216gcee2ndSKdFMI9tf2rpqkKaXDZcVjg+oguZc/KB5NxyAINs5el/mBQxIyJ
	 VfwbLVhRBadFD3eMvdKy0ZJnjotyWGJ0DnZLxstdCcjx5fkH+o6sfx/8SFK8MeTdbx
	 2LpggD7Vpk+RZqwe42FJiSG5IiWHBA8t8YM318Wlhq4j97Fx2Z0T+BIn1SlSYEMxzQ
	 n52s0GsqlA7Iw==
Date: Tue, 25 Jun 2024 10:06:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
 <ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
 <michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: rss_ctx: add tests
 for RSS configuration and contexts
Message-ID: <20240625100649.7e8842aa@kernel.org>
In-Reply-To: <8734p1at4e.fsf@nvidia.com>
References: <20240625010210.2002310-1-kuba@kernel.org>
	<20240625010210.2002310-5-kuba@kernel.org>
	<877cedb2ki.fsf@nvidia.com>
	<20240625065041.1c4cb856@kernel.org>
	<8734p1at4e.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 16:43:55 +0200 Petr Machata wrote:
> > There are 4 things to clean up, with doesn't cover all of them
> > naturally and complicates the code.  
> 
> Yeah, you can't use it everywhere, but you can use it for the ethtool
> config here.
> 
> Re complexity, how about this?
> 
> import contextlib
> 
> @contextlib.contextmanager
> def require_contexts(cfg, count):
>     qcnt = len(_get_rx_cnts(cfg))
>     if qcnt >= count:
>         qcnt = None
>     else:
>         try:
>             ksft_pr(f"Increasing queue count {qcnt} -> {count}")
>             ethtool(f"-L {cfg.ifname} combined {count}")
>         except:
>             raise KsftSkipEx("Not enough queues for the test")
> 
>     try:
>         yield
>     finally:
>         if qcnt is not None:
>             ethtool(f"-L {cfg.ifname} combined {qcnt}")
> 
> This is mostly just business logic, hardly any boilerplate, and still
> just uses standard Python. You get the setup and cleanup next to each
> other, which is important for cross-comparing the two.

TBH I don't really understand of how the above works.

> Anyway, if I don't persuade you for The Right Path, something like this
> would at least get rid of the duplication:
> 
>     qcnt = contexts_setup(cfg, 2 + 2 * ctx_cnt)
>     try:
>         ...
>     finally:
>         if qcnt:
>             contexts_teardown(cfg, qcnt)

Are we discussing this exact test script or general guidance?

If the general guidance, my principle is to make the test look like
a list of bash commands as much as possible. Having to wrap
every single command you need to undo with a context manager
will take us pretty far from a linear script.

That's why I'd prefer if we provided a mechanism which makes
it easy to defer execution, rather than focus on particular cases.

> > Once again, I'm thinking about adding some form of deferred execution.
> > 	
> > 	ethtool(f"-L {self._cfg.ifname} combined {self._qcnt}")
> > 	undo(ethtool, f"-L {self._cfg.ifname} combined {old_qcnt}")
> >
> > Where cleanups will be executed in reverse order by ksft_run() after
> > the test, with the option to delete them.
> >
> > 	nid = ethtool_create(cfg, "-N", flow)
> > 	ntuple = undo(ethtool, f"-N {cfg.ifname} delete {nid}")
> > 	# .. code using ntuple ...
> > 	ntuple.exec()
> > 	# .. now ntuple is gone
> >
> > or/and:
> >
> > 	nid = ethtool_create(cfg, "-N", flow)
> > 	with undo(ethtool, f"-N {cfg.ifname} delete {nid}"):
> > 		# .. code using ntuple ...
> > 	# .. now ntuple is gone
> >
> > Thoughts?  
> 
> Sure, this can be done, but you are introducing a new mechanism to solve
> something that the language has had support for for 15 years or so.

Well, I can't make the try: yield work for me :(

#!/bin/python3

import contextlib

@contextlib.contextmanager
def bla():
    try:
        yield
    except:
        print("deferred thing")

bla()
print("done")


Gives me:
$ ./test.py 
done


I don't know enough Python, IDK if we can assume much Python expertise
from others.

What we basically want is a form of atexit:

https://docs.python.org/3/library/atexit.html

The fact atexit module exists makes me wonder whether the problem is
really solved by the language itself. But maybe there's a deeper reason
for atexit.

> Like, it's not terrible. I like it better than the try/finally aprroach,
> because at least the setup and cleanup are localized.
> 
> Call it defer though? It doesn't "undo" there and then, but at some
> later point.

I like "defer". We're enqueuing for deferred exec. So another option
would be "enqueue". But I think "defer" is indeed better.

rm = defer(cmd, "rm example.txt")
rm.exec()   # run now, remove from internal queue
rm.cancel() # remove from queue, don't run

?

