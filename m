Return-Path: <netdev+bounces-227964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB68BBE30A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF89F1898140
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77A2D1F64;
	Mon,  6 Oct 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhOopDo6"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620D2D1F7B;
	Mon,  6 Oct 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757417; cv=none; b=RqEUFRisvT92pc3yUQ+ka31syoJEBYkcUyxWp24Qn/K+Cpaf/P68dABimuosj/kK2xx3cV5KqBvt4YiRaBn+zi5zFUmRrK9iHy+cY7SY8P8BJJ/zqNFDFeVAgIjMQc2bvtNJaj1bBiTqRMh4eW+fYTOhRgWKLdsWHJ6sg7THH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757417; c=relaxed/simple;
	bh=ldZ6ZgVaPGWhx0Z8wK74yN++j5mjCqvwbRgE1RzMiZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1ULIuw4Oy7In1gijCH7hP20jqcl5ZzzZMLAROAU3rLzdsDdMmrEQBpPjOMkDZylYnCy2tq5KM2AQgebUyitj62qakeKCSn26dkwu7vio7MZ2VV/zZKSXE037gDuMd87nRTMm2DpRINgFdoaHui8Zuzq21mIyouEO5adWY/G9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhOopDo6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 93EFC1D00154;
	Mon,  6 Oct 2025 09:30:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 06 Oct 2025 09:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759757414; x=1759843814; bh=9Er25Kd2ILGUTjSaojxcUAIlBwBd/yvlRQ1
	/6RThMGI=; b=vhOopDo6S3myENtCAXRNjhYSJ2w5UukaRVVwGP3jwsmfJSA4PSM
	+lKT6JCwmYqS71yYsKhfx01Gq2UVwlga7j90hy75zo7i/O8ffHL0JP4yk8Ryhrkc
	g5FaOTgSI4byzayjM49YbAa87UAs+hXuuJprc5tf2T9PossFzSk3viDHyFrA0HeY
	qbATjVljNs7tPMSvceEiuxD8XTaQPLoeqCcv09z5gHiImuXx4UAUXH/LCixCRF3k
	w58nONV2Z/Wf1jdSm4G1m5BYG1W1QRR2sFZT5uk4MN/k2tARh9K6qIav44J1L0Eh
	a9aNY3HZouQNDmUK5NoIj/+jgZones7B0Vg==
X-ME-Sender: <xms:ZsTjaIkWEgiZT1PXBbN8FZ6fdTeXhbyE9Y18WRL-ICvC0EWaaiQ0SQ>
    <xme:ZsTjaMxjy1GpoTfxmywO-FvKzQYACeLSSUI3ZfUh9-hwo85-YxrSgJyTzuwkgba6O
    Hc6oMkzTzZSvbMjvq3em_d8utGPAmatln6J9Ob7H0HySeZ2tjs>
X-ME-Received: <xmr:ZsTjaK710vjORanLgy1c5conHFe3nRXViKa6M14iaT5CPYTPgKYSwh6uvYj2Z0hpRnPK4-s_MbbeD1FxwdlAJzNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopeguvghmvghtrhhiohhushiisehprhhothhonhdrmhgvpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgr
    hhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:ZsTjaEWlluzN-PKtDTQQ6k3rxj20EiO1gAF-f36OCCdliFvCVngVMA>
    <xmx:ZsTjaKJYQw9KZdPhrYkI0DWugjAQIbKGHHzYGXMEFzIQ2O-23W2KNA>
    <xmx:ZsTjaOsvcqqFkFnZFoLiYa7AGUVkHzqtTtj4n4Yc4aXBSZ5xNfVvQg>
    <xmx:ZsTjaPLB9ZOmlV-a3GXBRfb4GjlP0yWFMhA27MJVZgbmRRCvpZubdQ>
    <xmx:ZsTjaIcuDtLCzWB-e4YxjlfZ2VSYcVUBgEiPJTKCs9y0ILMVNH7eSwdd>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 09:30:13 -0400 (EDT)
Date: Mon, 6 Oct 2025 16:30:11 +0300
From: Ido Schimmel <idosch@idosch.org>
To: demetriousz@proton.me
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv6: respect route prfsrc and fill empty
 saddr before ECMP hash
Message-ID: <aOPEYwnyGnMQCp-f@shredder>
References: <20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me>

On Sun, Oct 05, 2025 at 08:49:55PM +0000, Dmitry Z via B4 Relay wrote:
> From: Dmitry Z <demetriousz@proton.me>
> 
> In an IPv6 ECMP scenario, if a multi-homed host initiates a connection,
> `saddr` may remain empty during the initial call to `rt6_multipath_hash()`.
> It gets filled later, once the outgoing interface (OIF) is determined and
> `ipv6_dev_get_saddr()` (RFC 6724) selects the proper source address.
> 
> In some cases, this can cause the flow to switch paths: the first packets
> go via one link, while the rest of the flow is routed over another.
> 
> A practical example is a Git-over-SSH session. When running `git fetch`,
> the initial control traffic uses TOS 0x48, but data transfer switches to
> TOS 0x20. This triggers a new hash computation, and at that time `saddr`
> is already populated. As a result, packets with TOS 0x20 may be sent via
> a different OIF, because `rt6_multipath_hash()` now produces a different
> result.
> 
> This issue can happen even if the matched IPv6 route specifies a `src`
> (preferred source) address. The actual impact depends on the network
> topology. In my setup, the flow was redirected to a different switch and
> reached another host, leading to TCP RSTs from the host where the session
> was never established.
> 
> Possible workarounds:
> 1. Use netfilter to normalize the DSCP field before route lookup.
>    (breaks DSCP/TOS assignment set by the socket)
> 2. Exclude the source address from the ECMP hash via sysctl knobs.
>    (excludes an important part from hash computation)

Two more options (which I didn't test):

3. Setting "IPQoS" in SSH config to a single value. It should prevent
OpenSSH from switching DSCP while the connection is alive. Switching
DSCP triggers a route lookup since commit 305e95bb893c ("net-ipv6:
changes to ->tclass (via IPV6_TCLASS) should sk_dst_reset()"). To be
clear, I don't think this commit is problematic as there are other
events that can invalidate cached dst entries.

4. Setting "BindAddress" in SSH config. It should make sure that the
same source address is used for all route lookups.

> This patch uses the `fib6_prefsrc.addr` value from the selected route to
> populate `saddr` before ECMP hash computation, ensuring consistent path
> selection across the flow.

I'm not convinced the problem is in the kernel. As long as all the
packets are sent with the same 5-tuple, it's up to the network to
deliver them correctly. I don't know how your topology looks like, but
in the general case packets belonging to the same flow can be routed via
different paths over time. If multiple servers can service incoming SSH
connections, then there should be a stateful load balancer between them
and the clients so that packets belonging to the same flow are always
delivered to the same server. ECMP cannot be relied on to do load
balancing alone as it's stateless.

