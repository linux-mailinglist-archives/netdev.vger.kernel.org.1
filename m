Return-Path: <netdev+bounces-280809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIpgAWBN6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:48:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A5A455182
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1492630DD536
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A538642A;
	Thu, 23 Apr 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="F1BIYOj3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0YtqhYA"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B5340273
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962276; cv=none; b=S+bY64KMqfnmuqEUM1BmPIj32v+PaXTDPRnkzVc2VKw4bVgTrk9//OM/q2hzguO0aHPBRyHBqVMJtAeeVUV0Tb07BJFg8UI6whCkhxZ4fH8F1e6899HSHQjDI64ub69uaUGO1CF+IKGezfOzrEwmdlhaA8FecvgiBO4sc9XJZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962276; c=relaxed/simple;
	bh=FSEWBj4fFqu3Nn9siAXEe6p1IfvOfizKym0a9mO/lGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDi1Oi92c+hinBU/kFDgoGTUUzghzc3yqQ4ZqaE8B3PYlUuIeFkVQRvgpkvaAHlDL8EbP1mbWCkJr0a5UvJO6e4dovzp/YluEebit0FNJbaSRUbrzRDAtLFfzMEoGJZSQ78QvoQgfgeFn/1MKOBH7pHFH3Z25f98DuNtRPpx0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=F1BIYOj3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0YtqhYA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CCB32EC045C;
	Thu, 23 Apr 2026 12:37:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 23 Apr 2026 12:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1776962271; x=1777048671; bh=yDAOtbPObxQs4ZtUp+LInDRv3kUzn4uU
	faSPy/DdJmE=; b=F1BIYOj3nnHNEx4Y78dd8wD86Di8jslq5FmSl+CKvsXDW/Wd
	9fh1nvfaw13AwObtEsBojAeM++KMN3jocswb647lqkqV5Ti/dL2yDSxa4vgNDpNU
	dwQ/zBZq4RgtfIKR6KJQi/OhRp/sHNPrLKkqgrbNg7oIWVQLb5S6/JEvWROJURoy
	+T7CaMist6X+IczDmnUdJep0+DDkTi+i2MznzyX0eIc5us0RIi5se1NqLLcUi5kB
	csPUYrM2k1VGsIPYfE1NrZs2Pb7fjBb5oGL33MkwY07Bmtji4MuiwHRnNoc7p2In
	Yl+HSz5+OV68YYbJAvM1MCWU5o9dToYxpc2Whw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776962271; x=
	1777048671; bh=yDAOtbPObxQs4ZtUp+LInDRv3kUzn4uUfaSPy/DdJmE=; b=a
	0YtqhYACimzeJurlZZzr8cL6/ywvWPYpxqA2JPFAjnrrtkq/3DBifm3Yjcchz5Q9
	tv7GGEtpDho+pdAEB6q+K9sYL9nuzonER72nm4qEzcoQiyhGF2X30FOK6bl+Z2jk
	C9fKjwLCbGJI3qnMjvyosvrrqUoEKC/LG8mB1zB6Es4BDO01x4aVevPQyiqP6hIy
	AOJbulSVXO1eit75ONsPIfva/ZX+krT4CKzspqNnQO86tbdE9jdLOaFHGeZ1GbXx
	BxkcYCeVK8Fg+CnjU09AB3FORtk88tgyUDiA+ihmMnawuea+VdBIb6gA3AvssyRz
	jbE2iGZnBXclqHtP2UwQA==
X-ME-Sender: <xms:30rqaYVf1K0-bZLOxIh0eCJxJlu53YeSxOQ3XhNMMNWSKHNdafKLPg>
    <xme:30rqafIJjmhju__FtMAhvMT5KiOY_NMXn5UT9NsTvq6cn1EPAkk_T-AIRBB15-jMW
    Vb_y1vYMKdSUi3Eg6WYMbRmbelfx04ICMhHedlA5KD8EIFjhkdSaQ>
X-ME-Received: <xmr:30rqaQB9n695_XcFQFt3HkV4OK8xjiOj3R8kAEFajbFJnT6UB4m_c-5u9FG_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgeduveejjeeugfevffegueefkedugfetudejiedvteekffdttdejudef
    ueeiffdtnecuffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhl
    rdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepkhhusggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrrghlfhesmhgrnhguvghlsghithdrtghomhdprhgtphht
    thhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifod
    hnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhho
    fhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehimhhvgegsvghlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:30rqaXfuwlpudIkyEil9u6usfA2njVUmQO9rN2FNOupzPGydlwWtjg>
    <xmx:30rqaX2iclDLgHjwDAigqvk7OnhWdGOI3fZQM8YrozJpWRY8k_fIeA>
    <xmx:30rqaWgzqYFqvBOXGPeXP9kIh3NnOHhkVhphS2KyTmX97K1i9n_4Zw>
    <xmx:30rqaYlPIZaYb1JhcAMfSEsR-si4Asxshzmd2MqP16sqHQtQN9RimQ>
    <xmx:30rqaS-PaKETEwkwfAQ0UV4hF3mwpt9uSrG4XyFY2IWQLZyMRYWY-kMy>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 12:37:50 -0400 (EDT)
Date: Thu, 23 Apr 2026 18:37:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Ralf Lici <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <aepK3XXc8IFemb1Z@krikkit>
References: <20260422123242.530882-1-antonio@openvpn.net>
 <20260422123242.530882-2-antonio@openvpn.net>
 <20260422192050.7c4ca760@kernel.org>
 <7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
 <9221605c-ad31-44f9-b3b7-db2237f75eb7@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9221605c-ad31-44f9-b3b7-db2237f75eb7@openvpn.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280809-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 78A5A455182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-23, 15:43:31 +0200, Antonio Quartulli wrote:
> 
> 
> On 23/04/2026 14:16, Antonio Quartulli wrote:
> > On 23/04/2026 04:20, Jakub Kicinski wrote:
> > > On Wed, 22 Apr 2026 14:32:42 +0200 Antonio Quartulli wrote:
> > > > +    /* Prevent adding new peers while destroying the ovpn interface.
> > > > +     * Failing to do so would end up holding the device reference
> > > > +     * endlessly hostage of the new peer object with no chance of
> > > > +     * release..
> > > > +     */
> > > > +    if (ovpn->dev->reg_state >= NETREG_UNREGISTERING)
> > > > +        return -ENODEV;
> > > 
> > > AI review suggests wrapping reg_state read in READ_ONCE(), I think
> > > that's legit. Also nit: I think > or != REGISTERED would be more
> > > idiomatic than comparing >= UNREGSITERING ?
> > 
> > Agreed on READ_ONCE. Will fix it.
> > 
> > As for your second point, I am fine with "!= REGISTERED" as that's the
> > only state we should be accepting new peers in any case.
> > 
> > > 
> > > If you agree make sure Sashiko doesn't complain about anything else
> > > once it's public:
> > > https://sashiko.dev/#/patchset/20260422123242.530882-2-
> > > antonio@openvpn.net
> > 
> > Is there any way to get earlier access to these reviews? (at least for
> > patches somehow related to me/ovpn)
> > 
> 
> Dang! sashiko reminded me that I should swap cancel_delayed_work_sync with
> disable_delayed_work_sync. Will fix that.
> 
> 
> As for the second remarks..It has convincing arguments, but I need some more
> time to think about it.
> 
> Sabrina, do you have an opinion?

Sadly, it seems possible.

I wanted to add rcu_read_lock around everything ovpn_peer_add() does,
so that unregister_netdevice_many_notify() gets stuck on the
synchronize_net() call after setting UNREGISTERING, but
ovpn_peer_add_p2p needs to be able to sleep [1].  If we move the
ovpn->lock from ovpn_peer_add_* to ovpn_peer_add, so that we check
reg_state and insert the new peer without being preempted, we should
be ok. But maybe submit that to netdev as RFC (not directly a pull
request) so that sashiko tells me how wrong I am?

We could also wrap all of ovpn_peer_add (including the new reg_state
check) in netdev_lock, since we can't move to NETREG_UNREGISTERING
until netdev_lock is released (then I think we wouldn't need the
READ_ONCE(reg_state)). But I don't know if that's an acceptable use of
netdev_lock.


[1] maybe we should add a might_sleep() annotation directly in
unlock_ovpn (instead of/in addition to the one already in
ovpn_socket_release), I'm already getting a bit rusty on the locking :/

-- 
Sabrina

