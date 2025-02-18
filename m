Return-Path: <netdev+bounces-167379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D6DA3A07E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71C5160898
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D23262D1C;
	Tue, 18 Feb 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m30O0q28"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39523E22A
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890083; cv=none; b=qUrH8EBi4FqPoxuUvrri+mBOQxEhVVyMNCI+Fcjrx6KKi8Vc03L1D+AghtUXgaEAq7NRxt3hy+4uW6rqnqNPqJEwaOZmznBTcItaUuNcJI8Zlj6P1hlRtlCV1XMdtK7qd6wv4Z2iyqSVcT+gFafsIVIRW2xy2qsPupIgIj0y7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890083; c=relaxed/simple;
	bh=17D6bw4i0dUx7dPEsJxxF3xuxmoGRRpy8+L052M9McU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKO/UnxghaNQ4zNBlBz+H4avuR2O3QKve7oRSGbluf4DfsyaN3BPC1ja4Rf07BXBKDcSLgfGVdgvmLj1kGyN0OAqWzmsx1/XrMs6ZDlWcLGnRnfdLbxAOPDj0yX0W6RTKJlD8liv3hLXR6jySPtp+ZDLqUy2NQQ0MYzZen5KEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m30O0q28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B38C4CEE2;
	Tue, 18 Feb 2025 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739890082;
	bh=17D6bw4i0dUx7dPEsJxxF3xuxmoGRRpy8+L052M9McU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m30O0q28C2zUZ9/Pyz9dgzfIKn3oODb2pUhPfr5FiEI8LKJ1h+hmYK7kykqkoqrXj
	 VVhd7wjU5smqqcCTzA2KcUE2beYi3zENwhCWEgkdxiq4+jjeMt7ez0uWUYq/jddNc1
	 3h67M1g/RxxmxfDOTZ4uiBm2oN2fCdbvmI0o6pLUlNLSu6dfefQoPNh7mk1KNjVXho
	 92hFGGUfvKOkFwJf9XBfm2FN0uA+4wSx/ljZ+Q2BZ0hGWxqFUIEMMEbUrnpWOF1Z39
	 IX4XTW9p3/VTfnjxDPeaRPYZDS4Jn3GZeVaqFPWI5LYG6kA++pBpxLseFp7ITiieke
	 5qFzzIAWnWWSg==
Date: Tue, 18 Feb 2025 06:48:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: store addresses in
 dict indexed by ipver
Message-ID: <20250218064801.2b43ad83@kernel.org>
In-Reply-To: <Z7QK5BBo-ufND1yB@mini-arch>
References: <20250217194200.3011136-1-kuba@kernel.org>
	<20250217194200.3011136-4-kuba@kernel.org>
	<67b3df4f8d88a_c0e2529493@willemb.c.googlers.com.notmuch>
	<Z7QK5BBo-ufND1yB@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 20:21:56 -0800 Stanislav Fomichev wrote:
> > >  def test_v4(cfg) -> None:
> > > -    cfg.require_v4()
> > > +    cfg.require_ipver("4")
> > >  
> > > -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> > > -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> > > +    cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
> > > +    cmd(f"ping -c 1 -W0.5 {cfg.addr_v["4"]}", host=cfg.remote)  
> > 
> > Here and below, intended to use single quote around constant?  
> 
> Let's kick it off the testing queue as well..
> 
> # overriding timeout to 90
> # selftests: drivers/net: ping.py
> #   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./ping.py", line 13
> #     cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
> #                                               ^
> # SyntaxError: f-string: unmatched '['

Huh, it worked for me locally, must be a python version thing..

Python 3.13.2

>>> a={"a": ' '}
>>> f"test{a["a"]}test"
'test test'

