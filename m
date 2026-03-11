Return-Path: <netdev+bounces-266649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBS7Hl5vsWlVvAIAu9opvQ
	(envelope-from <netdev+bounces-266649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:34:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28072649EF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8759430790A7
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6D3191A5;
	Wed, 11 Mar 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HnEdIysk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eczk5gPc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE1250C06
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235667; cv=none; b=LnEYjcb6UFVbX69Kc0C0XDnf54LZI6vdOKo1VA2iK6z7qjCqX47gcXhd27WqOcWUGV1PSG4/3sq3YFYQ6kw0XIEvWoK/CEaBklmNqESnAK7hnzEMjev5ypBqkFGbj4boQ0lIuJ5dx+g3qXv9lyihHhGGVWAUCtGgtf/nTA7+oYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235667; c=relaxed/simple;
	bh=Qi0FNc6l3xlf4M5GgzFlPm9w48wQ+Cr9ucelOJJzMmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u49v9kMS36d+V9WYzZAWVWQUvpfd46tIzOal5OpzVjq3LF34zrWpoqD/ALz9R1d35XRU5OiFOwjeFkJ6Mv0dPloGX/EO17sEheTrdN7jMV2uTkgMF9Mc4fhHrnXucA+imegVqr8YvAu+v4oqveI8rr16UocOp+zbnynFaF8HQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HnEdIysk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eczk5gPc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C37E8EC05AC;
	Wed, 11 Mar 2026 09:27:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 11 Mar 2026 09:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1773235662; x=1773322062; bh=h6y0IFIVXWgpALqIzRmnvFlM8wDy3FmJ
	Mbqp1sSaMT8=; b=HnEdIyskvmZ5XGNeRiB4EwUnp5P4RX2xpRgnZtPgUd6h93+a
	HQQkMPVY/4unzt1Xm3lnNqA7Ye+M+yZBsiyPsAXvfBjyQUkeK8i6EqidM6Qi2Ab0
	7PkYUIMzZ3fP261lYbPBURLtYBQXTwZQZdc56GEJJ2Nl3YLtiGt+2AEuHoVX+OBM
	DO841qHKQ6P6by4VgWwV4qSoz0lc6ByT4Y1/xLvB5znR6enwMvxB2+oOQuW9TRb8
	oOobLFh0gQ42ggb+cg6zyUA98mFe/+PuEoZWM5EfYgIfCNMOShhJPAciywHtIbAp
	sW6eg1WlZmBKSV554BRf68evWAzcLyncGrglJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773235662; x=
	1773322062; bh=h6y0IFIVXWgpALqIzRmnvFlM8wDy3FmJMbqp1sSaMT8=; b=E
	czk5gPcBVHuZIWk750TImgYh0BtMlb6a7Iktq/VPsiweQqQXcalHGQJ9ft6Py4g4
	xauiWPQPyYrZvRZ839XRXUnr6c4334T+kKOZoHmuVLp615nnfo+qsDJYjxPbm1Lk
	1CP9NFJjUnLFSrRjFtlDr/OkbXtVWMT+fyQ/RX2I6JQ/bGNCKKMjnPTmkf6bGgXw
	Tkou51dSCpP6EKzQ+USk5h36Rbg35RhD2+pJslotlG6eznRfAk8bg0A4jUAqwEIs
	+9FKlES62ws6B7Qo6CjKNwRd0SlXFupBDsg/qgJXG5LcIFyH7+yhRKSvgZty2YDR
	QhNyJdgn1JuNjjlnLxgaA==
X-ME-Sender: <xms:zW2xaVxRufBks2oKgpiffxIjeMRh73aCmVZX8_qsI6i5XsVtEgx_cQ>
    <xme:zW2xabTD0p8ptosur6JxW-n0qN1m2IEV3Skim9N_zz7p6jUbn4f6_CZf8xY3qdFqy
    L-2YVB7dT6JdoiEbCfH5TwMqngDbChdFWPZiJi4bBK-NaegKgKhScY>
X-ME-Received: <xmr:zW2xaaJ0QX5ALypmAaYbdjIMG-TMwrjMYu5SrOF6DtKuU_ueAzrA76WnZcxv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegvhigrlhdrsghirhhgvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepihhmvhegsggvlhesghhmrghilhdrtghomhdprhgtphht
    thhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtph
    htthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zW2xaaVFclTXTxq4PYR7LQ_poXIIl-3O5cHtHYN8h_pcpaeSP0VNYA>
    <xmx:zW2xaWSn0HLgzHd0zZPrsNAeEnmnSeuSfqY_1_P3bbyLOslxe0B72A>
    <xmx:zW2xaaCj48Pqjl23Grc3LUEQd3oF41H6haFTGpOO7dMEcxDWSrNNcQ>
    <xmx:zW2xadKuvHs4xPSJhxvkvC92v6j8Xh4h62mkM8w5fjyifdrWanx63A>
    <xmx:zm2xaVdSXUdzt7gUa2UyNy2Aj8tljWXLSnDNdUpJ8nS5nBlgiqQq3GoQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 09:27:40 -0400 (EDT)
Date: Wed, 11 Mar 2026 14:27:39 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in
 xfrm_nat_keepalive_net_fini()
Message-ID: <abFty6McRkN8dtEe@krikkit>
References: <abBf_R81PYmafhWv@v4bel>
 <abCh2CgVS3Uw7W-_@krikkit>
 <CAHsH6GtYpoowPJe5VWMcm=CCdUernc1q-Sk6HznXxMy7LDAmrQ@mail.gmail.com>
 <abE1Q7BMvZ1l14jF@krikkit>
 <CAHsH6GtCAqJf1PTGjQppScME6h-dXCUFJMeJvmJsrSDkhSJa8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GtCAqJf1PTGjQppScME6h-dXCUFJMeJvmJsrSDkhSJa8g@mail.gmail.com>
X-Rspamd-Queue-Id: F28072649EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,queasysnail.net:email]
X-Rspamd-Action: no action

2026-03-11, 06:00:03 -0700, Eyal Birger wrote:
> On Wed, Mar 11, 2026 at 2:26 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > 2026-03-10, 17:14:19 -0700, Eyal Birger wrote:
> > > Hi,
> > >
> > > On Tue, Mar 10, 2026 at 3:57 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > > >
> > > > Please also CC the author, and maybe additional contributors, of the
> > > > patch that introduced the problem you're fixing.
> > > >
> > > > 2026-03-11, 03:16:29 +0900, Hyunwoo Kim wrote:
> > > > > After cancel_delayed_work_sync() is called from
> > > > > xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> > > > > states via __xfrm_state_delete(), which calls
> > > > > xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.
> > > >
> > > > Eyal, I'm wondering why __xfrm_state_delete() calls
> > > > xfrm_nat_keepalive_state_updated(). At this point the state has been
> > > > removed from the walk list so nat_keepalive_work() won't do
> > > > anything. Am I missing something?
> > >
> > > I don't remember for sure, but I think the idea was to have the work
> > > run "now" so that when deleting the last nat-keepalive state it
> > > won't run in the future, and in general to refresh the interval and
> > > not wait for the next iteration.
> > >
> > > Eyal.
> >
> > Ok. I thought about this, but I'm not seeing the benefit of doing
> > that. Assuming we're deleting just this one state, the next run will
> > process all the remaining states in the same way, whether it happens
> > right now or at the previously scheduled time:
> >
> >  - if the next run was needed by the peer we're deleting, not much
> >    changes except that we're recomputing the delay earlier than
> >    otherwise (right now instead of when deleted_state's interval runs
> >    out)
> >
> >  - if some other state was the first to need a keepalive, we do a run
> >    for nothing
> >
> > So I think we could drop the xfrm_nat_keepalive_state_updated call
> > from __xfrm_state_delete.
> 
> Right. I think at the time I didn't think it was "nice" to have the
> work running long after all states have been deleted, and also it
> decoupled the implementation a little - i.e. if instead of a global
> work we had per-state timers (which one of the original versions had).

Ok, I see. Thanks.

> > @Hyunwoo here again I'm not opposed to s/cancel/disable/, it makes
> > sense to use disable_ in a "destruct" operation where we don't plan to
> > need the work again. But AFAICT this schedule_delayed_work isn't
> > really useful.
> 
> I'm fine with both approaches.

Ok, so:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Hyunwoo, if you want to send a v2 that does disable_ + remove the
xfrm_nat_keepalive_state_updated call, or keep this one as-is (and
then we can remove the unnecessary xfrm_nat_keepalive_state_updated
call in -next later), that's ok for me either way. Thanks.


BTW, patches for "NETWORKING [IPSEC]" should be tagged as [PATCH ipsec]
or [PATCH ipsec-next] rather than [PATCH net] or [PATCH net-next].
They go through Steffen Klassert's ipsec/ipsec-next trees, and get
pulled into net/net-next a bit later.

-- 
Sabrina

