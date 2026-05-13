Return-Path: <netdev+bounces-287493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LoEJYhDBGp0GQIAu9opvQ
	(envelope-from <netdev+bounces-287493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2033530948
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB84D30AFFDF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B5F3E5A2A;
	Wed, 13 May 2026 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="dEoBU4oL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SCdjyKsc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185B3E5A01
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664287; cv=none; b=hTdRApQ5qKEZ5Y+UpOrIV4JrvEq8Y4C4UhxUM71KwZlOWxZtjRW5fpYKxehBadUlM9Hm9ljyhiy1TKt4np3Gak3ZoZjx0yEKmCx43HYdIXe+kncTfjvGWMj3GZwaotIBgesacts63H7DbIkHNOQ1Mj1nwHKREcgpBwH5Mt3S4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664287; c=relaxed/simple;
	bh=3sDZx8wJDH/MgYRXdLpJuwCeABozDmK5MVT1YStA8RU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YiUuObbbwiBH/dFEaeTa9+hH2rD0/XPD8FojiuZU+MNCVdDFwNvFscIKd/s1dkUaiEgNZQ9KQCXNfJzC+fxqqw2/srPZ0dXd1T2S/xEHegIbp+u56dA5aQJWgaUdS2EH8l1Orh0CtFst7wzAvh8iEgd641kcIAg7chroY0GXJv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=dEoBU4oL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SCdjyKsc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E8261D00132;
	Wed, 13 May 2026 05:24:43 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-10.internal (MEProxy); Wed, 13 May 2026 05:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778664283;
	 x=1778750683; bh=SMEJVBMFIpAxx0lGrFUPHaoARljfZ7a9TItOum/BAIE=; b=
	dEoBU4oL25FFcb3KkvjTUWHX/qb1yNsiC3Cdn9SucIGrdHAHnjZBXgrGR8OuOsDr
	z80sxaTH1ouzzPYa1TwBCIdlE+5Ljhz5v75uO2zumvZrAbHS6zxaQD6E39jGlvP0
	mu9j6r2pmGoKOPP8vF8jzIozGgfzU3wdLI7C4M9EkO+hQq6n9ezGbZZK8NVh+tt2
	lnQ8RBRzoiNIvCgrysbSRHuVt1a6BEJdbydPbxKs9ltfeSKCYoCLFaxWhelNyYNn
	ugpL6Uyk3RuGF4ywjZCfE51bxlwpMnYfRZFgtp+cs2sAshXBeRKGVG7ckO2Z3oSY
	D5bJaNKUE2BDSYEywmJWkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778664283; x=
	1778750683; bh=SMEJVBMFIpAxx0lGrFUPHaoARljfZ7a9TItOum/BAIE=; b=S
	CdjyKscZ+7ucKLqkk1DTfPTZy1DxF3GKuK0nreqICx7O/V5UYobZNb+aUJyHxg7d
	SssyU1uVp1n4wBafsqJRQoItEOe64XE456sd3D8YUgUEijdXrxMT3wU7FrxuIn+5
	4+JJ9/PTx55GESjC1tQfNev1mFi7Io99uIfg/lS3khI0wgVWJV1DwYdIGv4uzH58
	V/RrggUfFZPeun/dBGrWBz1TJ94EShTXdM4P36yC8Zbn70OZi8rQW9327VbT7kNM
	UHQwyMW5A01z+5p6BYLZo7W2Bt3hsMOlMaPvvft19+5H6UNdcigQt+Ir/xSrjC1Z
	UnFtdlzAhgH2TTkE9kAJA==
X-ME-Sender: <xms:W0MEao4Ee6B9KaIdexKaMmunEBEz5IVJAkxaAVvuHJQQpMQwXCGEsQ>
    <xme:W0MEaktY7wz8HWs9fmkkvV3n_PNIdI8zDbe3Stb_THGCJWrwJrpCWcgEKYIugji1y
    CszoRp7XjSPuWUm7eTQoBKdtZ6MAFUrUhX5t3ctC5UvQvlRAJzwLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrg
    hilhdrihhmqeenucggtffrrghtthgvrhhnpefhgfevgeeljeegleeiffduheegieehtdff
    tdetvdffieelkedthfejleejgfeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgt
    vgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhnsggprhgtphhtthhopedukedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdr
    ohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htoheplhhutghivghnrdigihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtfhho
    mhhitghhvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruh
    hijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlvghmsgesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghp
    thhtoheprghlihgtvgesihhsohhvrghlvghnthdrtghomh
X-ME-Proxy: <xmx:W0MEalE-jgBHZDVrnmq2YFjA0moSuMwMsS2LhzkaiJ2FltEKV-w8Lg>
    <xmx:W0MEamQNfgITZ5DiNFNtwxP29K8GNoBUnUD2bfjK3IN2dJPL5tzUhA>
    <xmx:W0MEatQnxSIwbk2f9Q_zikQKcB0uOmJfwwy6NIvZgRsSM5SgSgEQ7Q>
    <xmx:W0MEahdG0KGdv7E_NAjtwbErmhCL1VuigzpBv4YL94pMB31iKBn3iQ>
    <xmx:W0MEalaTIUtoM58yKXPdWI1_498wrbCTYbKQEd83i0QPIRs8BJu9Os5W>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 029F1C4006E; Wed, 13 May 2026 05:24:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 May 2026 11:23:22 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Gal Pressman" <gal@nvidia.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Xin Long" <lucien.xin@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>, "David Ahern" <dsahern@kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>
Cc: "Shuah Khan" <shuah@kernel.org>,
 "Stanislav Fomichev" <stfomichev@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Simon Horman" <horms@kernel.org>,
 "Florian Westphal" <fw@strlen.de>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <35cf30b6-f3ac-4af3-816b-53511625d916@app.fastmail.com>
In-Reply-To: <6bd88b37-4aeb-4783-8b92-62b38fe8603d@nvidia.com>
References: <20260512165648.386518-1-alice.kernel@fastmail.im>
 <20260512165648.386518-3-alice.kernel@fastmail.im>
 <6bd88b37-4aeb-4783-8b92-62b38fe8603d@nvidia.com>
Subject: Re: [PATCH net-next v4 02/12] udp: gso: Simplify handling length in
 GSO_PARTIAL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C2033530948
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-287493-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026, at 09:53, Gal Pressman wrote:
> Hi Alice,
>
> On 12/05/2026 19:56, Alice Mikityanska wrote:
>> From: Alice Mikityanska <alice@isovalent.com>
>> 
>> Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
>> MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
>> and fix the checksum (apparently ignored by hardware anyway).
>> 
>> The mentioned commit started using msslen for uh->len, but still uses
>> newlen to adjust uh->check. If the formula for check is fixed, newlen is
>> assigned but never used before the loop, and newlen is overwritten after
>> the loop. This makes msslen not really necessary, as we can reuse
>> newlen, if we don't adjust mss before. The adjustment of mss can be
>> simply dropped, because mss is not used anywhere else below.
>> 
>> This brings us back to one variable, drops an unneeded arithmetic for
>> mss, and fixes the UDP checksum.
>> 
>> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
>> Cc: Gal Pressman <gal@nvidia.com>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> Heads up, this is going to conflict with this fix:
> https://lore.kernel.org/netdev/20260513074349.2152146-1-gal@nvidia.com/

Thanks for the heads up! When I submitted mine, your patch wasn't on the
list yet, so it's rather the other way around :). Anyway, let's combine
our efforts, since we are fixing different aspects of the same area of
code. I commented on your patch and suggested to base it on top of mine
to avoid creating a new bug with the checksum. If my series doesn't get
merged in this iteration, feel free to cherry-pick this commit, it's
pretty much independent.

