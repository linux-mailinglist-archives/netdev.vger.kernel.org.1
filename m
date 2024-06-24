Return-Path: <netdev+bounces-106180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE1915108
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444EEB25315
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3219AD5F;
	Mon, 24 Jun 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPEfy6VL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115141428F4
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240637; cv=none; b=C8jnNnBx1NiWRU4lT8nNLDqtyKHMl2/aA2Ys/ps7WZdDMp9aU+BLWL4hIofQmIL2xHkrKTKuI1Gr466Rl6wyz2Q7wfh9ocOn41TLElrxte1si4MzPo/HmPREIe2r0GB2FREC8LpmO22TJq5fnt87r7ECoBr1N3fHO4ynbks0zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240637; c=relaxed/simple;
	bh=LDe4BFq1F/KLx8Q4aUixL/v5EkQsMwpvKdBAYRRLYb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1+bjA87nqTPI1k1QEIKrp7KcQITRsmHSzUtaXz84+okuZEds4q9H1ulKzQGhE+dLfnxovxUwuqmDeCh+egktVzy8DgUbI2PArRILC38tu5g0/XldWRR6mZv5/monhzi3I795qpuqcWDpb0fvtWLhvXWkCIPedxDfCLe71YIiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPEfy6VL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5C1C2BBFC;
	Mon, 24 Jun 2024 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719240636;
	bh=LDe4BFq1F/KLx8Q4aUixL/v5EkQsMwpvKdBAYRRLYb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPEfy6VL10Ylq+uhf5rwxfNvUnW8PpvniFeUmR3TRWdoNvfGEJcNY0n/YLSqE6xoN
	 bdlkI7QQ0OT+Ab4v4WUTXkMt3V9GSa+4E1bDJRgwqb+fjltcQsNll9ceF0HWYWEBOQ
	 2eHhITNaPgvWiYg4JaNzepWPCmndmaRdk93oTxZIVa7xvXKryu4Qv8mRPNuat0o4i5
	 JpNKugs4VsiYkokj2haT6WBS4rLFuHXqNoFm2+eJTNonxx3kFQab4D4lHedv9GJiea
	 KkseMBvTczdzDVDXYZVBHkJO1eAIEjWWxJK+8Su/+nCIoeaTK6c0lOAZogZPxvY5ru
	 RHIcU1gRwcF5Q==
Date: Mon, 24 Jun 2024 07:50:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for
 RSS configuration and contexts
Message-ID: <20240624075035.037041e3@kernel.org>
In-Reply-To: <6677d6e5e646e_33363c2944d@willemb.c.googlers.com.notmuch>
References: <20240620232902.1343834-1-kuba@kernel.org>
	<20240620232902.1343834-5-kuba@kernel.org>
	<6677d6e5e646e_33363c2944d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 04:03:49 -0400 Willem de Bruijn wrote:
> > +def test_rss_key_indir(cfg):
> > +    """
> > +    Test basics like updating the main RSS key and indirection table.
> > +    """
> > +    data = get_rss(cfg)
> > +    want_keys = ['rss-hash-key', 'rss-hash-function', 'rss-indirection-table']
> > +    for k in want_keys:
> > +        if k not in data:
> > +            raise KsftFailEx("ethtool results missing key: " + k)
> > +        if not data[k]:
> > +            raise KsftFailEx(f"ethtool results empty for '{k}': {data[k]}")  
> 
> No point in printing data[k]?

It can be one of many things which evaluate to False: None, False, [],
""..

> > +
> > +    key_len = len(data['rss-hash-key'])
> > +
> > +    # Set the key
> > +    key = _rss_key_rand(key_len)
> > +    ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))  
> 
> Probably too paranoid, but in case failure is only for some randomized
> input, is the key logged on error?

Will add!

> > +    data = get_rss(cfg)
> > +    ksft_eq(key, data['rss-hash-key'])
> > +
> > +    # Set the indirection table
> > +    ethtool(f"-X {cfg.ifname} equal 2")
> > +    data = get_rss(cfg)
> > +    ksft_eq(0, min(data['rss-indirection-table']))
> > +    ksft_eq(1, max(data['rss-indirection-table']))
> > +
> > +    # Check we only get traffic on the first 2 queues
> > +    cnts = _get_rx_cnts(cfg)
> > +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> > +    cnts = _get_rx_cnts(cfg, prev=cnts)
> > +    # 2 queues, 20k packets, must be at least 5k per queue
> > +    ksft_ge(cnts[0], 5000, "traffic on main context (1/2): " + str(cnts))
> > +    ksft_ge(cnts[1], 5000, "traffic on main context (2/2): " + str(cnts))
> > +    # The other queues should be unused
> > +    ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
> > +
> > +    # Restore, and check traffic gets spread again
> > +    ethtool(f"-X {cfg.ifname} default")  
> 
> Consider save and restore state at the start of the test, in case
> default is overridden at boot.
> 
> Not important, but this also repeats some of toeplitz.sh. That has not
> been integrated into net-drv, and the .c and .sh code is more verbose
> than this python code. Perhaps can be replaced entirely eventually.

Agreed, I went with "default" because there seems to be no ethtool
support for setting exact indir table :(  I deferred exact restore
until we have YNL support for setting, which should be soon.

> > +            ethtool(f"-X {cfg.ifname} context {ctx_id[i]} start {2 + i * 2} equal 2")
> > +
> > +            ports.append(rand_port())
> > +            flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id[i]}"
> > +            ntuple.append(ethtool_create(cfg, "-N", flow))  
> 
> Need to test feature ('-k') ntuple and skip test otherwise or set?

Will do!

