Return-Path: <netdev+bounces-206775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D89B0457E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B783BBCB3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25125E813;
	Mon, 14 Jul 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtVbdgtp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FA1D5CE5
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510707; cv=none; b=rUJsCJSRUUDZM3vPZM0TVHCrNyUxOLJaNIOSx/atePM6sUubKsoSB+8HYQgdgSSsinbmo1GW1+rpjr7mLXoNkB6JShUUo9xGGbCL4Csc6zu7cbqJkL1QKBrm/1/Kqyp13En0BOnpBd0PSQM6c1ShF/rXCxFFYIBW+6FOpZijH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510707; c=relaxed/simple;
	bh=P0Hbrg2R1NB9cpoicizmJRacC/UIulyX/QKNhRJsRO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGWGJK6cNi0z6KnYQmDHrCzCp8M3Ny1S1+Xvv+AASSATzLdajjOnXdIw9mcGjDAnmcKm02eDkjTa3txM4OWhLsLZzNNTKhPGzfn+bUwWCzRCBsFPAuefuCAWFf7y/5wyBToDi25Rf/469UMTgTa5e3p4Waunzg1k9B658LhguxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtVbdgtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499F2C4CEED;
	Mon, 14 Jul 2025 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510706;
	bh=P0Hbrg2R1NB9cpoicizmJRacC/UIulyX/QKNhRJsRO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WtVbdgtpFQM+DPvNx6k05QvCp9n2jJvRv9wKq3RCVj9XCRaCKWn1zQSskiMQxCUmF
	 T7ArL2z5gtABDGKzxg+588xQhmCD2/pVFQpbQUicVHfPcTfFPSTpD6Wst5nEA6zzkI
	 YrBSehi3znxo+PT2q2TB1rePGmbhQw+IausXeZm2kzdgte2QdJ6ILHbgN+qQWeeXkO
	 V1bNa5/CSD2hbyijVNNsddAzc32N+9RhB3shDQRg5wpuA+NycoZFPgIcTbGACICElk
	 +ijLxCg6+2KL/ox5DJufE8OWxXYTj1R3kttC/aAi9jgv8hz4JCQvd8MCv9DsHDWmJH
	 8gGfqO2LoMNMg==
Date: Mon, 14 Jul 2025 09:31:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 11/11] selftests: drv-net: rss_api: test
 input-xfrm and hash fields
Message-ID: <20250714093145.01d33070@kernel.org>
In-Reply-To: <5d8d0616-9cd0-4bf6-b571-e88e4364b35a@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<20250711015303.3688717-12-kuba@kernel.org>
	<5d8d0616-9cd0-4bf6-b571-e88e4364b35a@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 17:05:12 +0300 Gal Pressman wrote:
> # Exception while handling defer / cleanup (callback 1 of 1)!
> # Defer Exception| Traceback (most recent call last):
> # Defer Exception|   File
> "/root/devel/linux/tools/testing/selftests/net/lib/py/ksft.py", line
> 154, in ksft_flush_defer
> # Defer Exception|     entry.exec_only()
> # Defer Exception|   File
> "/root/devel/linux/tools/testing/selftests/net/lib/py/utils.py", line
> 157, in exec_only
> # Defer Exception|     self.func(*self.args, **self.kwargs)
> # Defer Exception|   File
> "/root/devel/linux/tools/net/ynl/pyynl/lib/ynl.py", line 1106, in _op
> # Defer Exception|     return self._ops(ops)[0]
> # Defer Exception|            ^^^^^^^^^^^^^^
> # Defer Exception|   File
> "/root/devel/linux/tools/net/ynl/pyynl/lib/ynl.py", line 1062, in _ops
> # Defer Exception|     raise NlError(nl_msg)
> # Defer Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Invalid
> argument
> # Defer Exception| nl_len = 84 (68) nl_flags = 0x300 nl_type = 2
> # Defer Exception| 	error: -22
> # Defer Exception| 	extack: {'msg': 'hash field config is not
> symmetric', 'bad-attr': '.input-xfrm'}
> not ok 8 rss_api.test_rxfh_fields_set
> ok 9 rss_api.test_rxfh_fields_set_xfrm # SKIP no input-xfrm supported
> ok 10 rss_api.test_rxfh_fields_ntf
> # Totals: pass:8 fail:1 xfail:0 xpass:0 skip:1 error:0
> 
> Also, after the test runs I see inconsistency in the rxfh values:
> 
> $ cli.py --family ethtool --dump rss-get
>                 'tcp4': {'ip-src', 'ip-dst', 'l4-b-0-1', 'l4-b-2-3'},
> 
> $ ethtool -n eth2 rx-flow-hash tcp4
> TCP over IPV4 flows use these fields for computing Hash flow key:
> IP SA

Hmm.. I think what happens here is that the test changes the config 
so the subsequent runs will pass? Will fix.

