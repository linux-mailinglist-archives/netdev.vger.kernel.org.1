Return-Path: <netdev+bounces-220692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E069B480EC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 00:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11DD17FF86
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ACA2C11E6;
	Sun,  7 Sep 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bmcDx3v0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BAN1UwBT"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29492BE64A;
	Sun,  7 Sep 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283224; cv=none; b=ovdWVSie2Qn3YDLExAha47Lt9BWmEJToipdU/O5bdHx2XX7ogroMnrbDlyeIFz/zhkIusD/jL29IHtK9nNHesSCulo0D3U+Wrb+nj4wbJCtIw9YZcsxD99LKHav1WFshPgtFNE6WLiB9MstnlWlgDo/hlyNDr5kfXyEUF6FcbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283224; c=relaxed/simple;
	bh=4T1t4KuD1Q2QDSSpnR6A3GUjSlzURYNzAIn06Y6AXSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGrW7MjUe9eRUYctnt6/BPe1W597au7NFiHGtkUVJRh7aR3JozgGWp1zDf5oifrsMYHqBUghopgjtRG1YEJsARkuyiP3pI3mXtmrdOHhfPqIAyfNLWROd8Or57Rmy5muun86HoQRJ/8VG1qJvg9aTBD14Z15rSP9MOgPyn5fVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bmcDx3v0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BAN1UwBT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ADF1EC0093;
	Sun,  7 Sep 2025 18:13:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 07 Sep 2025 18:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757283219; x=
	1757369619; bh=ip7nO8F2H6Y29dT8CjYPQzDSOjOANiwrV+fhMGJx33U=; b=b
	mcDx3v0oi4ED/4obUnQD+eBl7MlIwKJT13sZmON27QZgoggd98tmc9FaYVBS8/7F
	Aphlcs268PCm0hbf1b9CA7BSawm2d1BmdHwKmK9+Or1roCfKcKRPB/OpM/pPLQJW
	fRViUHJ/v2JCOXtNeFocUtTPta5xwM/khUFFkAoETcxhbaiFXv9hz7AoOsPfWq/w
	LBQiq/zsLmlMF4/XsnQtNTfUvVUrzVY7qUle+eEB66dT6jPZntjO7Q4IIu8Pn+A0
	NhvVAA2bNx3SGCmXLFyPG91Bi1z1vw2j6BotfE7A5yCxhOPNHz052KtbJOsWDQaq
	ILn/Mre4meS7IgkremR1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757283219; x=1757369619; bh=ip7nO8F2H6Y29dT8CjYPQzDSOjOANiwrV+f
	hMGJx33U=; b=BAN1UwBTG1aG5/UMfNR4qCPeK6NHlf+BFfmSG66PPkO42USeHKU
	P3Md/a56tNP13+RAlzgvXrpy+zVhxsubwE2M+5wmoa1f2LQE+dco1kH3jC1NFEUU
	T6GlBBtTQtolKWMv7UfFe75MFC/SO/Qi8u9HxLyXm+6C8RErShLWQYyyH+EXBxAq
	Csmd5Owq7ZZtV5CbTZZt/aiRubd6pBmLNpxYmZoDteUjDXkn1MNMNxn77SRyPmXw
	HBdv265xDXUeYXPwIAGM/ru/rKnhdnJ1JqWysSRvWf3abFGlp9IDmqDP6HJhkBPX
	YMOvBFyQeabLb0bYzD5p2oU6C0PDLwfmrKw==
X-ME-Sender: <xms:kwO-aEkPffz1xEP8zOuTUQC7JFu1aKk_VistRLBRFeP0prS6PD3CMA>
    <xme:kwO-aBX7NLy9vIyhVUOqilDYLVCKO_npApb7LUlOPCiMYlSR2KsLL1ZOjJXW8T5-w
    f1KJxG3132ztaH48Tk>
X-ME-Received: <xmr:kwO-aFS5RQfJVG0dQVhVIKM6-gbplaKu_kG4iXQeGdpHFP5D1oNEwHI-uWLl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeifihhlfhhrvggurdhmrghllhgrfigrseifug
    gtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohep
    ughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihhsthgrihhrrd
    hfrhgrnhgtihhsseifuggtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kwO-aGCuGDa1Jbkommw4soIW4f8NK18MpUX_5EXB1tULsFjtEV0C4A>
    <xmx:kwO-aFvGLGZO26lHZwT19YO9rNE9-Sqshi8HrcHmaMUK6xxq8ti1wg>
    <xmx:kwO-aM--lKBfE1xWNWPv454iHnlQDcIWFPgmp1IJYX8SywKDcc-B1w>
    <xmx:kwO-aER3tQm_MIbRogKGEw5eaISYKNflHc-A47bsJryfRx2-FxiRfQ>
    <xmx:kwO-aLiaDFnSFvK2uwwa27tyccyp67NMyEH7AukTAA5susRmcFPEZ51b>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 18:13:38 -0400 (EDT)
Date: Mon, 8 Sep 2025 00:13:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Message-ID: <aL4DkNijXKKx2LVY@krikkit>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
 <aLcWOJeAFeM6_U6w@krikkit>
 <0ba1e9814048e52b1b7cb4f772ad30bdd3a0cbbd.camel@wdc.com>
 <aLf6j73xSGGLAhQv@krikkit>
 <00d28a79b597128b33b53873597f7ba2808ebbe6.camel@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00d28a79b597128b33b53873597f7ba2808ebbe6.camel@wdc.com>

2025-09-04, 23:31:23 +0000, Wilfred Mallawa wrote:
> On Wed, 2025-09-03 at 10:21 +0200, Sabrina Dubroca wrote:
> > 2025-09-02, 22:50:53 +0000, Wilfred Mallawa wrote:
> > > On Tue, 2025-09-02 at 18:07 +0200, Sabrina Dubroca wrote:
> > > > 2025-09-02, 13:38:10 +1000, Wilfred Mallawa wrote:
> > > > > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > Hey Sabrina,
> > > > A selftest would be nice (tools/testing/selftests/net/tls.c), but
> > > > I'm
> > > > not sure what we could do on the "RX" side to check that we are
> > > > respecting the size restriction. Use a basic TCP socket and try
> > > > to
> > > > parse (and then discard without decrypting) records manually out
> > > > of
> > > > the stream and see if we got the length we wanted?
> > > > 
> > > So far I have just been using an NVMe TCP Target with TLS enabled
> > > and
> > > checking that the targets RX record sizes are <= negotiated size in
> > > tls_rx_one_record(). I didn't check for this patch and the bug
> > > below
> > > got through...my bad!
> > > 
> > > Is it possible to get the exact record length into the testing
> > > layer?
> > 
> > Not really, unless we come up with some mechanism using probes. I
> > wouldn't go that route unless we don't have any other choice.
> > 
> > > Wouldn't the socket just return N bytes received which doesn't
> > > necessarily correlate to a record size?
> > 
> > Yes. That's why I suggested only using ktls on one side of the test,
> > and parsing the records out of the raw stream of bytes on the RX
> > side.
> > 
> Ah okay I see.
> > Actually, control records don't get aggregated on read, so sending a
> > large non-data buffer should result in separate limit-sized reads.
> > But
> > this makes me wonder if this limit is supposed to apply to control
> > records, and how the userspace library/application is supposed to
> > deal
> > with the possible splitting of those records?
> > 
> Good point, from the spec, "When the "record_size_limit" extension is
> negotiated, an endpoint MUST NOT generate a protected record with
> plaintext that is larger than the RecordSizeLimit value it receives
> from its peer. Unprotected messages are not subject to this limit." [1]
> 
> From what I understand, as long as it in encrypted. It must respect the
> record size limit?

Yes, and the kernel will make sure to split all the data it sends over
records of the maximum acceptable length (currently
TLS_MAX_PAYLOAD_SIZE, with your patch tx_record_size_limit). The
question was more about what happens if userspace does a send(!DATA,
length > tx_record_size_limit). The kernel will happily split that
over N consecutive records of tx_record_size_limit (or fewer) bytes,
and the peer will receive N separate messages. But this could already
happen with a non-DATA record larger than TLS_MAX_PAYLOAD_SIZE, so
it's not really something we need to worry about here. It's a concern
for the userspace library (reconstructing the original message from
consecutive records read separately from the ktls socket). So, my
comment here was pretty much noise, sorry.

> In regards to user-space, do you mean for TX or RX? For TX, there
> shouldn't need to be any changes as record splitting occurs in the
> kernel. For RX, I am not too sure, but this patch shouldn't change
> anything for that case?

Yes, I'm talking about TX here.

-- 
Sabrina

