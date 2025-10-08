Return-Path: <netdev+bounces-228165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74404BC3865
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 08:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5541F189E630
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 06:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73112EBBA1;
	Wed,  8 Oct 2025 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9t0ryE3"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823229BD89;
	Wed,  8 Oct 2025 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759906638; cv=none; b=O4UWlNdCvCNCdJXIiGuwsGe25+NsjlbKo1fUJ5rnDD+Fbl21531AnMc/9Ms4h5xgjk9sJc+kbwrEyBR5aKCpAwa7C+0ypZtTCXyWDYQ6o7x0xyJgsTyeebyH+qCTJoRTp7kvhfyNgzorQewNPnq5uskTrnGhqbmGlKdPJmAETpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759906638; c=relaxed/simple;
	bh=xIJzu8bCInZxOvWCc+eRHB4R0uR4CLyv2cRk2eV0j2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu6kmVa8MVnR3Pzs8RHlOrd7Dvn6W5TLdt1zYGrXguyPWW7cgKcz3O0oenAWTuB/ZKUMF59fmdBc5PelS8QW/9kogcBHgJ5GGvKDROyZJ3G/qJbutKKcYzahNCLQW1KujW3EhWHIeatCc3Ngf/jiqr7pEtLOArtdNxA4T7YtQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u9t0ryE3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDA83140020B;
	Wed,  8 Oct 2025 02:57:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 08 Oct 2025 02:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759906634; x=1759993034; bh=eBqKBuvwI3M6mT5BUHVjwKfL7oQ7mVkdytX
	FO/7hTMU=; b=u9t0ryE307EL/K1ECX34WksP93TLL1iTzyfrCkSQdnnEDDX6zBv
	e64mr3FbMAehqFViwPHVWEMLSTiC0D1wKI5KbnMVTYKFrnagJQBOhMD/ml8KGLOk
	f7ViVZFXOLXLNgdeXmqQLOg9kYhSVhB2Wa2vxenFn7ipbeThNSXEyNFX2Mo/KUxM
	SHuzYEXo30JxDnk1evDwEqvJB5CTTlL1RbDdtEkuZMMEJptX/V6dtcZVDd4CtlE0
	m/QEMwf2jTQKc0nkKHZbMs74qlc5vi4DEUzQ8v2Ic1PmBAcPSqyBIm7eBPaoa0Fa
	mJR6n/E98uz6w9wzW5YQcYYBglptXBaSb6A==
X-ME-Sender: <xms:SgvmaDBYj5knfooFUgZ0Xdt6dZh5YYtAIpARyQBWy9cuMq9AYmof6A>
    <xme:SgvmaMmt-EdcQcG9ON4wsQePa5b4-xxDkxORcwaTpiFXJwfyOunOv9LOgIKICF0k_
    bc0om3yvIrGrVZ6TaG5pZVUIWwXx_Oi21UX0VdOAG8W_ojOC7w>
X-ME-Received: <xmr:SgvmaJNsbvB5HVEdg_xoULhQML7qaLgajCSsq9vrMvQr-yQulohg-5Lf6hz5AYKXXRTH7VmdwiiWyWPP_BrUjNSn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilh
    hlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthho
    peguvghmvghtrhhiohhushiisehprhhothhonhdrmhgvpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SgvmaB_EFv-_prX83d0R36TOEWoDzMXeUK3ZNfMg9D29J5m4NmBl7A>
    <xmx:SgvmaDHEOVMNdxME9_nxqmo3nMUFZfqtaxFpW6-gAd_-ESZoD2aCtQ>
    <xmx:SgvmaIifenO_S7FaPe7x6qIBAow2HmjA9UR1-dld21VRyMSYhbCi6w>
    <xmx:SgvmaAvfZOFOoIAeJGpugJyg879JQzK031WJMUGeAGIEmbHM_whTzQ>
    <xmx:SgvmaMpUt5lBCAZszg_0aLeemy9eDT-fE_VFZ6dg2Y9wxzEJo_dPhqbQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:57:13 -0400 (EDT)
Date: Wed, 8 Oct 2025 09:57:11 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Dmitry <demetriousz@proton.me>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv6: respect route prfsrc and fill empty
 saddr before ECMP hash
Message-ID: <aOYLRyIlc7XU7-7n@shredder>
References: <20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me>
 <aOPEYwnyGnMQCp-f@shredder>
 <MZruGuax8jyrCcZTXAVhH0AaAMOZ-2Gcj5VeZO8xy8wS9FqwA3EMhPFpHLZs67FAKCu6z3GpEVeArSX2qGdSUqsysI-0o13dKK1ZmUhK_l0=@proton.me>
 <aOVIAWAxpWto8ETd@shredder>
 <willemdebruijn.kernel.3a8157265761f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.3a8157265761f@gmail.com>

On Tue, Oct 07, 2025 at 06:25:47PM -0400, Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > On Mon, Oct 06, 2025 at 06:31:10PM +0000, Dmitry wrote:
> > > If the 5-tuple is not changed, then both the hash and the outgoing interface
> > > (OIF) should remain consistent, which is not the case.
> 
> With git fetch over SSH, the process apparenty explicitly changes DSCP
> (by calling setsockopt IPV6_TCLASS?). Which triggers a dst reset,
> which that may trigger a different path. That is WAI, right?

Yes, but in this case policy routing does not match on DSCP. The reason
for the path change after the dst reset is that the initial route lookup
is performed with an incomplete 5-tuple (missing source address and
source port) compared to subsequent lookups.

Dmitry already verified that specifying "BindAddress" in SSH config
resolves the issue as in this case the route lookups are always
performed with the same source address. This indicates that the DSCP
change itself is not the problem.

> 
> Policy routing can explicitly specify different egress devices for
> different DSCP settings.
> 
> Is this the entire issue? The original message states
> 
> > In an IPv6 ECMP scenario, if a multi-homed host initiates a connection,
> > `saddr` may remain empty during the initial call to `rt6_multipath_hash()`.
> > It gets filled later, once the outgoing interface (OIF) is determined and
> > `ipv6_dev_get_saddr()` (RFC 6724) selects the proper source address.
> >
> > In some cases, this can cause the flow to switch paths: the first packets
> > go via one link, while the rest of the flow is routed over another.
> 
> That sounds as if the OIF can change in between the rt6_multipath_hash
> and ipv6_dev_get_saddr calls for a regular socket, without such
> explicit DSCP changes. Does this happen?

I'm not sure what you mean by that, but any event that triggers a dst
reset can result in an OIF change as subsequent route lookups will be
performed with different parameters compared to the initial route
lookup.

> 
> 
> > > Only with the fix does it
> > > respect the configured SRC and produce a consistent, correct 5-tuple with the
> > > proper hash.
> > > 
> > > Therefore, in my opinion, this should be fixed.
> > 
> > Note that even if the hash is consistent throughout the lifetime of the
> > socket, it is still possible for packets to be routed out of different
> > interfaces. This can happen, for example, if one of the nexthop devices
> > loses its carrier. This will change the hash thresholds in the ECMP
> > group and can cause packets to egress a different interface even if the
> > current one is not the one that went down. Obviously packets can also
> > change paths due to changes in other routers between you and the
> > destination. A network design that results in connections being severed
> > every time a flow is routed differently seems fragile to me.
> > 
> > If you still want to address the issue, then I believe that the correct
> > way to do it would be to align tcp_v6_connect() with tcp_v4_connect().
> > I'm not sure why they differ, but the IPv4 version will first do a route
> > lookup to determine the source address, then allocate a source port and
> > only when all the parameters are known it will do a final route lookup
> > and cache the result in the socket. IPv6 on the other hand, does a
> > single route lookup with an unknown source address and an unknown source
> > port.
> > 
> > This is explained in the comment above ip_route_connect_init() and
> > Willem also explained it here:
> > 
> > https://lore.kernel.org/all/20250424143549.669426-2-willemdebruijn.kernel@gmail.com/
> > 
> > Willem, do you happen to know why tcp_v6_connect() only performs a
> > single route lookup?
> 
> I did not fully get to the historical reasons for the differences.
> From v1 of that patch:
> 
> "Side-quest: I wonder if the second route lookup in ip_route_connect
> is vestigial since the introduction of the third route lookup with
> ip_route_newports. IPv6 has neither second nor third lookup, which
> hints that perhaps both can be removed. "

I also wondered about the second route lookup in ip_route_connect(), but
the one in ip_route_newports() seems necessary as it will perform a
route lookup with a complete 5-tuple, unlike the first.

Thanks

