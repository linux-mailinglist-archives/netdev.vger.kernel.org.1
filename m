Return-Path: <netdev+bounces-186189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8435A9D66B
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F441B882E6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CE2957A2;
	Fri, 25 Apr 2025 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqVIGp/V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347122068A
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625165; cv=none; b=hCXOqwgg0xX48vcx1v1RUpx+896iOFK+du7dPBQfsdbJ5RqJsMpqFc/t7T2cZVi+6OqztmwqrUN7q9PBhDtzCS0B8wuvtYtNQglCavU8UYUTzzhTWn4eSArn6yhywNiH7nyy0ozbmK5gbjbXGtnNnj1KGjwJNhZA8cBmC/PbXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625165; c=relaxed/simple;
	bh=ixy5+p45G730MNFC6bhENoSitpORnyfcUdOHwdkdUH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1bUsI8BXbdRerS7VR4DDyhk38SiDYj70UyTWsvTBlmMSvQMDCF2Q7pAgeqi7uQPr3lXgfHTQDnUgRD4/6dhfsVfY4l2ZTHn+g6WbVQszutB95wvRWt4AqDlDGh/vs/+itzzREjctgMExqHwTang3hnojUu5wMFW6I/19zJRY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqVIGp/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFA4C4CEE4;
	Fri, 25 Apr 2025 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745625164;
	bh=ixy5+p45G730MNFC6bhENoSitpORnyfcUdOHwdkdUH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mqVIGp/VAUsHCS8PIksPKTDcyVGiZDpoMOeahpd++fszgUQVtAk8CJQwESJ7SkS73
	 DKImKpBf6VNyvIxK0FF3apNVYkzAPfTkq1r9CBV5FoGN8cF0WjdFT2/n8z3XIooFKT
	 B/maT00W+JLUrnYHlW6QQAXgH1NVv3DMR+rHmHsP6miLyebjLOWxHCyFmkOg1MXDrZ
	 xalxkhtvmysDpR8PGCN/DxMfBa0XY8MvPX1FsASk8vpxOeMbTh8p/VTezvvpRrRrdk
	 1ouhc741ZPWZQAjJw/e7/uCxATR+2PYx2v0tI8sqLnhxZdmqTrQQXGJ7r7RBm9HtGv
	 aBA7Js8+kpXpw==
Date: Fri, 25 Apr 2025 16:52:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 22/22] selftests: drv-net: add test for
 rx-buf-len
Message-ID: <20250425165243.27421a0b@kernel.org>
In-Reply-To: <aAfMqE_m6QFTph_k@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-23-kuba@kernel.org>
	<aAfMqE_m6QFTph_k@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 10:06:48 -0700 Stanislav Fomichev wrote:
> > +def _do_bpftrace(cfg, mul, base_size, tgt_queue=None):
> > +    queue_filter = ''
> > +    if tgt_queue is not None:
> > +        queue_filter = 'if ($skb->queue_mapping != %d) {return;}' % (tgt_queue + 1, )  
> 
> if tgt_queue: should work as well?

Ha! I'm glad I'm not the only one who would fall into this trap.
tgt_queue = 0 is legit and actually used by the test.
So we'd collect the data for the whole system if test asked
for filtering just to queue 0. This breaks the test when queue 1
has large buffers, queue 0 small and we want to prove queue 0
is not getting large ones..

> > +
> > +    t = ('tracepoint:net:netif_receive_skb { ' +
> > +         '$skb = (struct sk_buff *)args->skbaddr; '+
> > +         '$sh = (struct skb_shared_info *)($skb->head + $skb->end); ' +
> > +         'if ($skb->dev->ifindex != ' + str(cfg.ifindex) + ') {return;} ' +
> > +         queue_filter +
> > +         '@[$skb->len - $skb->data_len] = count(); ' +
> > +         '@h[$skb->len - $skb->data_len] = count(); ' +
> > +         'if ($sh->nr_frags > 0) { @[$sh->frags[0].len] = count(); @d[$sh->frags[0].len] = count();} }'
> > +        )  
> 
> Why do we have @h and @d? We seem to check only the 'sizes'/@?

:o sorry leftover debug, thought i deleted it

> > +    maps = bpftrace(t, json=True, timeout=2)
> > +    # We expect one-dim array with something like:
> > +    # {"type": "map", "data": {"@": {"1500": 1, "719": 1,
> > +    sizes = maps["@"]
> > +    h = maps["@h"]
> > +    d = maps["@d"]
> > +    good = 0
> > +    bad = 0  

> > +def nic_wide(cfg, check_geometry=False) -> None:
> > +    """
> > +    Apply NIC wide rx-buf-len change. Run some traffic to make sure there
> > +    are no crashes. Test that setting 0 restores driver default.
> > +    Assume we start with the default.
> > +    """
> > +    try:
> > +        rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
> > +    except NlError as e:
> > +        rings = {}
> > +    if "rx-buf-len" not in rings:
> > +        raise KsftSkipEx('rx-buf-len configuration not supported by device')
> > +
> > +    if rings['rx-buf-len'] * 2 <= rings['rx-buf-len-max']:
> > +        mul = 2
> > +    else:
> > +        mul = 1/2  
> 
> And similarly here? (and elsewhere)
> 
> def pick_buf_size(rings):
> 	""" pick new rx-buf-len depending on current and max settings """
> 	buf_len = rings['rx-buf-len']
> 	if buf_len * 2 <= <= rings['rx-buf-len-max']:
>  	  # if can grow, try to grow
> 	  return buf_len, buf_len * 2
> 	else:
> 	  # otherwise shrink
> 	  return buf_len, buf_len / 2
> 
> old_buf_len, new_buf_len = pick_buf_size(ring)
> ...
> 
> (or maybe its just me, idk, easier to think in old>new comparisons vs
> doing mul*base_size math)

I'd still keep old_buf as base_buf, because for per-queue 
it's not really old as it's still active on remaining queues.
Otherwise SGTM.

