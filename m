Return-Path: <netdev+bounces-265635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP4tDTT6rmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:49:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6DE23D114
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B1A2302E31D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F73BD659;
	Mon,  9 Mar 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hovbjNHm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z37Uzapd"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1883AEF22
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074590; cv=none; b=nUPEYVmH+IXQlLRNiSS6iSG7ArBiHLAqVU7QWkieWeACXtsjoSvQj57Ohf+7StJ1m0zVQ+XG6HzQWHHgPfUeQLakX165zqcT1tHkJn/NnWVum0LZLh95Ts+OtHnTKGLntvsKQ91MnBSnvMdzOIvvg5r2OmbEY9Vt7N2hK7ISwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074590; c=relaxed/simple;
	bh=aoJVFeqoy65Ou466KqPYDVjuu0oW7gGH2mOS+VmCwiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH4TDMPlUjQLv7Wc6XGOOsFo4Wz4gdYYxdeDigvIk48ctWv54Dk1sPCX2yDnxCPftd1FkO24Cm2xssR9P2CN1DWXvDr6143NNv3FD6N1kAWO6fFCdvEyw5Zc/eMKUng+XKDvqjuor5jgpMI8fOxSOTnAX1CBG0+a37MJmF4JSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hovbjNHm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z37Uzapd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66C89140013A;
	Mon,  9 Mar 2026 12:43:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 12:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1773074586; x=1773160986; bh=XTP7zkcWrh4eY3wJyZaEg5P+5ELk45hg
	xWqkDp3M8uM=; b=hovbjNHm2VTivKRNDbijQsaFqtAHUg+p0R1GIUQs3OTQrlja
	fzGtD2WUoQZRHt7GsFnLctn1Cr0ag9q4/ALqbhhXrq59bymeu1SrrZrUMCYepz6t
	DrBAgdDcf2eh8DdKKj/nSexxW8wf4fxqVTpuBolGwnNSYMCgsd91k3mAqKiHavL2
	q0LBArpTmcROtjhUGnTJx6QVJWPQGIymhVNrUACx13Zv/F54s14Ame4d6k3BLieA
	641wdDcp1/AoORdj4vW5VD53UfLZzFkn+IimiW9Y6yEQWf/EnOqMtT2SkXQMuMyz
	LEjLolmLRA3S+Uwgf8BBmi65djxwUn1W88JJlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773074586; x=
	1773160986; bh=XTP7zkcWrh4eY3wJyZaEg5P+5ELk45hgxWqkDp3M8uM=; b=Z
	37Uzapd4x3c278COL0tHzAEsq6mQDUfXagjDTZz5DcZhyZ+u0nnVvdtC1WNdVS6r
	eIb31zry5hFQgL0rwlZ+xBxdR+9ezVHa6W1U81PbYSd/6LSASygEu/NzmgdUqEin
	CEZGehVTy7gmbcyN6/ZkAKOZ1NZ/ebxto93spOnBWf2+m89CeAkA2YC4ZIhGcPhA
	EBq3QbNEhY4lSkA9innjDx3a3mRzG2EOM7yZDBbyEpv1p7W3jOR9Tw5rMhMTi9Ti
	dTCnRRHtfn0ZUmCrVU91+DhFKN8nr1t1dRCFGj071C3FkGVjbmAKdP7SDib6dZRK
	lsiy9nwLNDli3PM05nYdg==
X-ME-Sender: <xms:mPiuaX-EBZnIbbTRmiNG2S7fj0JvRmyBFsb6jT5My1BsFN9GKhxFgg>
    <xme:mPiuaSx_4PEQZAxseaKo30i9jgKsqUGN4_zCslVtmmx1CBbCNU8VeMGBHtBaEC1g-
    rBq6KYqPcWc6prSIJGnsu5JoXcNsqCX6mkndF5I62eIW9KBei2bxA>
X-ME-Received: <xmr:mPiuabNr9KZ8PLVUVVzb2a81kgRzE18FD3kEFpBuKjJporubfcHndJFTBC5K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggugfgj
    sehtkeertddttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshguse
    hquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpedvgedtkeevjeeg
    keeiledtgfekveduvedvgedvfeeuudffgeevkefgjedtkeeuffenucffohhmrghinhepph
    gvvghrrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsg
    gvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguthgrthhulhgvrgesnhhvihgu
    ihgrrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:mPiuaf_KwaYcecXWctvCG7LRnRYoPE6jUs0nCHVN4BaOy_8DQ1_sSQ>
    <xmx:mPiuaQ4XN4qRMbczGZiLK1yHz0z58MMNU_6bMC8hu7myy1LsneXFIQ>
    <xmx:mPiuad5iy511NqGz50dKaY34gukw9Njg86kWYfbPZrcYogewKEaUsQ>
    <xmx:mPiuaRrd1xV2ksy0AzB8b26CDR_DrHVdpgqexVj8f_62Eb_pbMcyVg>
    <xmx:mviuaUe5viLQqt6YiFohmbEjvJc5lf-_LGXjZbbjIYgaJr6JGId5u4g4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 12:43:04 -0400 (EDT)
Date: Mon, 9 Mar 2026 17:43:02 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <aa74lpn_cWQPv31h@krikkit>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
 <20260306115353.28f322e0@kernel.org>
 <d68d087152e11b2aa9948f84339a5e164a666d5f.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d68d087152e11b2aa9948f84339a5e164a666d5f.camel@nvidia.com>
X-Rspamd-Queue-Id: 8B6DE23D114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265635-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,peer.sh:url,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-03-09, 16:19:20 +0000, Cosmin Ratiu wrote:
> On Fri, 2026-03-06 at 11:53 -0800, Jakub Kicinski wrote:
> > On Fri, 6 Mar 2026 17:10:01 +0200 Cosmin Ratiu wrote:
> > > This short series adds support for VLANs in macsec devices when
> > > offload
> > > mode is enabled. This allows VLAN netdevs on top of macsec netdevs
> > > to
> > > function, which accidentally used to be the case in the past, but
> > > was
> > > broken. This series adds back proper support.
> > > 
> > > netdevsim was extended to support VLANs and there's also a selftest
> > > for
> > > the new functionality.
> > 
> > I think it's triggering the warning you added, in most of the tests:
> > 
> > [   20.973710][  T194] WARNING: drivers/net/netdevsim/netdev.c:1234
> > at nsim_destroy+0x128/0x7b0 [netdevsim], CPU#0: peer.sh/194
> 
> Right, it seems the fuzzing test adds a bunch of VLANs then destroys
> the netsim devs. It doesn't make sense to have those warnings anyway,
> it's ok to not clean up the VLAN filters from a device before
> destroying it, they're not a resource, they're a setting. I'll remove
> the warnings in the next version.

But the vlan devices on top of the netdevsim device should have been
deleted (and thus the vlan and their filters removed from the
macsec/netdevsim devices) by the time we finish destroying the
netdevsim device. So this warning just needs to happen a bit later in
nsim_destroy? (I guess just after unregister_netdevice)

-- 
Sabrina

