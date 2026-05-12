Return-Path: <netdev+bounces-287334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIG+APqqA2oO8wEAu9opvQ
	(envelope-from <netdev+bounces-287334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E252AE73
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B2DE313DD4D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654D3A6412;
	Tue, 12 May 2026 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="i/I63BnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tDlsu8m6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E353A4F3A;
	Tue, 12 May 2026 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625040; cv=none; b=XDNJ5lwMzSKcjxQf1vN1oUiQkpW7BT7vkXUmaGyeARtqteyG6KY36+gY+828P6WrH9fJN03DV/olN0WydLqiuVdq44D97PBRqTGjWItbKT3acx/ZE81y67fKXZ1p2ME9amQ9O9Dwi1+ZTTR2LqXCS9N8GkBqKsicxOHg5ZveN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625040; c=relaxed/simple;
	bh=ouh/3IkuTVth6iPTaBCVibQ/K23G8lJXGlEzu8iAxzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6r8F202TGRd1Yf7zqRvMKp+rvYo5zj6zdKmutzE2zPDtza3bsLOVol6xI5pcHgYHRxWIMduURxalpIp5AqeMyqriro1/CDwatcFp/OzZmdVH+JCkWEN8TRfTK5YkCCFLec0P0xuuad/Hlghy8RjXnMplbEPgIfbgHSD+kvxQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=i/I63BnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tDlsu8m6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95C407A0125;
	Tue, 12 May 2026 18:30:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 18:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778625035; x=
	1778711435; bh=S2TZUe3kivvQUfT3f+FWPu+63xgMztReJ8CH0fDXXTQ=; b=i
	/I63BnHTF7AlrxZXyQOupfq4iC+omEUoDsGVMrw7GdXClGiMTmNQpToHNj+OBHBU
	nPFcJ8xNhAJTrDeZ28DzZhARRUcBTbfvPpCnnCXk9ezFoEFvEzqI9GlXBKDKOTEM
	z4nBT6GnW3x9sC6EVv/cK+5T6cRlnM4yHCepATcba67GPFMViQiEzqzDiy/VYiQf
	o1+8p5iGKO1BafTqj64f5bvlox5gCSrYrs8WF6obEdP2cpwhjliFtEumPwpdbaxZ
	bqng+zv1NUP2Q9mKMakkTfrD8JEMpGE3fphWtO1ljjj/xg1ek2H66zCymaL8xdHe
	5p7+vWzutBwDL9AWmY1ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778625035; x=1778711435; bh=S2TZUe3kivvQUfT3f+FWPu+63xgMztReJ8C
	H0fDXXTQ=; b=tDlsu8m6NN/XLIugNGjQ4UFzrxtiRxNgTKLsU8D2EnRlm6xXigD
	46L4jQwn4EEOcTdKJUO84PIz7b/D0ueyZckHE+oqlG2vuPT4IGFDS81tt9SQvHUh
	JnD1tkW4D48UixcnNIlW1FC0CXg/eK/bZxfINGk92KiWzYayVJcb6dZfjOxbJItk
	J3QcjHXi0ABqYBSeKT5E6JVrMNq4vDBfbQjT1zSttmJUaGtFofAV9xs3Sl8NaaOp
	RRK5O/XlNp0Wvezj7ukoY0sgAxYW/6L2EVjcRR/3eYkVp7FCvE8zbyGfDKREEOMH
	Q+CpSt+fWUqtbXClL+4RoenQ9vZm9bkkBJQ==
X-ME-Sender: <xms:CqoDaj2CWjPrOlTAJJOozt2XpQJVaOVaqUXCckqzJ3lvD08eG3cWaA>
    <xme:CqoDajp_dlen6iRLSzUORZvuXKWwMYVjtrmCmBROCVnK986ItKREAyrLzjPZUkuR9
    4fXGgOq8XTqYRLjU6zUkrwTp-hSvejSUn2_1CgDobnaNJeTRR4q9yU>
X-ME-Received: <xmr:CqoDajLexI9AGH2Ms5EABHTnkXmsPMYIWaQdDD8hTgkA1EgHMkh6wViBgWaUMotjffikb8qT9HxuFiX4reoCPoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeftddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejkeelveelkeefgfeuheevje
    eukedvhedvueegvdekleeghfelgeeivefftdeuudenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgv
    thguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CqoDavRYinOo1Cjd16u0ODbg8okWo0Nz0gC08z_srqQwcyStlPDhhA>
    <xmx:CqoDarMlXOBEh3XgEcWlLDbSmvjnaiYyW-c8myEJXHYOaV8BvyAsVQ>
    <xmx:CqoDasVdiZ4AzBL090UcqboJylCQ6xkNaNLvZaBZRcWtZINk29x8vA>
    <xmx:CqoDamgMSK8-KnKSVJk-VGY9gW4Tw3WOxkFcF6J1V9orp5BRG4rXFw>
    <xmx:C6oDatr5BaJKcwGMl3LoU-bj-5YfLRqz_PnqsG2G4OmDQ809vc1aPhNi>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 18:30:33 -0400 (EDT)
Date: Wed, 13 May 2026 00:30:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	john.fastabend@gmail.com, bpf@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, daniel@iogearbox.net,
	jonathan.lemon@gmail.com
Subject: Re: [PATCH net v2 2/4] net: tls: prevent chain-after-chain in plain
 text SG
Message-ID: <agOqCETGrzQccEGn@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-3-kuba@kernel.org>
 <agMKcBrJYK5UIcsZ@krikkit>
 <20260512090342.15779c9a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512090342.15779c9a@kernel.org>
X-Rspamd-Queue-Id: 811E252AE73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287334-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-12, 09:03:42 -0700, Jakub Kicinski wrote:
> On Tue, 12 May 2026 13:09:36 +0200 Sabrina Dubroca wrote:
> > 2026-05-11, 10:49:18 -0700, Jakub Kicinski wrote:
> > > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > > index 2608b0c01849..3bfdaf5e64f5 100644
> > > --- a/net/tls/tls_sw.c
> > > +++ b/net/tls/tls_sw.c
> > > @@ -789,21 +789,33 @@ static int tls_push_record(struct sock *sk, int flags,
> > >  	i = msg_pl->sg.end;
> > >  	sk_msg_iter_var_prev(i);
> > >  
> > > +	/* msg_pl->sg.data is a ring; data[MAX+1] is reserved for the wrap
> > > +	 * link (frags won't use it). 'i' is now the last filled entry:
> > > +	 *
> > > +	 *         i   end              start
> > > +	 *         v    v                 v            [ rsv ]
> > > +	 *  [ d ][ d ][   ][   ]...[   ][ d ][ d ][ d ][chain]
> > > +	 *    ^   END                                     v
> > > +	 *     `-----------------------------------------'
> > > +	 *
> > > +	 * Note that SGL does not allow chain-after-chain, so for TLS 1.3,
> > > +	 * we must make sure we don't create the wrap entry and then chain
> > > +	 * link to content_type immediately at index 0.
> > > +	 */  
> > 
> > All this wrapping with extra "hidden" slots is so confusing...
> 
> Yes, always takes me an hour to swap the context back in.
> I was hoping the diagram would help.

I've more or less managed to wrap my head around it due to the
previous patch, but it still takes me way too long just to check the
logic makes sense.

> > > +	if (i < msg_pl->sg.start)
> > > +		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
> > > +			 msg_pl->sg.data);
> > > +
> > >  	rec->content_type = record_type;
> > >  	if (prot->version == TLS_1_3_VERSION) {
> > >  		/* Add content type to end of message.  No padding added */
> > >  		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
> > >  		sg_mark_end(&rec->sg_content_type);
> > > -		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
> > > -			 &rec->sg_content_type);
> > > +		sg_chain(msg_pl->sg.data, i + 2, &rec->sg_content_type);  
> > 
> > Probably a silly question: why do we need to chain the content type?
> > Could we just drop it directly into the right slot of msg_pl?
> 
> Good question, IDK either. Maybe anticipating the need for padding?
> Do you prefer that as the fix, or follow up in net-next is fine?

I'd go with "make it a bit more straightforward" and remove the
chaining. If you want to retain the hunk moving the other chaining
(for wrapping) around, go ahead. Not sure it would still make sense.

> > (I'm also a bit puzzled by the "last_filled + 2"/"end + 1", because
> > that would leave an empty slot between the last_filled slot and the
> > content_type? and maybe even overwrite the first actual message chunk
> > if we had filled the message?)
> 
> Incredibly confusingly the value passed to sg_chain is the arrays size.
> So it's entry target + 1. IDK if that answer your question but it always
> confuses me. I even added it to the comment above but looks like I ended
> up removing it.

Ugh, right. I read all this stuff last time you sent those patches,
and a bit earlier as I was reviewing patch 1 again... and I had
already forgotten when I got to this. Thanks.

-- 
Sabrina

