Return-Path: <netdev+bounces-219479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D66B41848
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA93316567E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526EC2EA49E;
	Wed,  3 Sep 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AlAn68cT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEvgNggr"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF982E9EAE;
	Wed,  3 Sep 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887703; cv=none; b=iUCBIxyCYXPaRmMRPpJWGtA1uPuFNrek42smUdyd8xpleerE10D1KlNMN3s6OAtzawL7x9X82Crldvqhaav3D2qkZH3AylQFVCxz6whMV48HXdHdlEZA781A2W0LMygV8vNrHO61/3WFEE9wBfkwDqmEsYcMi6U+QoCKUVmExnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887703; c=relaxed/simple;
	bh=YDQvYYRYePGEkbmnqITfE3daRFS7pSl7/jVkS1aHYYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX1StW7Z1YBdjjVJ9bdGIHjOZENM7uD0PZrmZOS4ehd99O3y7U0IfaFhCONFvm0lC883UuzposVvUrLbbyf7nVfdYK2Up7DQUksY7wZ/RYvlmr9FPYbXn7MbfrS3g+D2eAaqhZ4xnl/1sNK9Ds6oEg1ZlIr9/Y4swmgCHqu71Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AlAn68cT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEvgNggr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DFE9EC02F9;
	Wed,  3 Sep 2025 04:21:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Sep 2025 04:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756887698; x=
	1756974098; bh=RamPT76eb1nCXOwlEEiEUWgYTl9dVawyqJagKv68tPU=; b=A
	lAn68cTiDVqU0IqotjoGZAlhzBf5IGZ3j247HA3HOoboQ18YQAuxq+jXOuRwUj8z
	GAzcHXk1TcH06cqHOb8Tn9BS1lMmeIxnWY0rqShb0Yt1W2iVQtpuX4f3typE2y1L
	r6gQX83JewVCKa7GI0uc80qbG4EGFCXq++XmdyWoGk4d5ynBn9VGvFmwbRxtraHG
	h9DeUU8pUqmYfTIPFCkl1W9DIA/8BKuI9zZVMnb9ILXNYj1jdJ+tg4R4OlK7zEhr
	HDIYenFrRgsD8RuWFqTRFh0Txfee7oWeNhwjtPjYQho2JeoZsusr4h1Nk1uIhmkP
	BPmlFY9GgPtCLWyfFlx0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756887698; x=1756974098; bh=RamPT76eb1nCXOwlEEiEUWgYTl9dVawyqJa
	gKv68tPU=; b=TEvgNggraN2B5hb/SCtd1DcmEXK09dFF9qB+Z/PLhcTTDmv9IHu
	UYUPmk7eIytQ6iXqOnBrMh3ebSzOR+b0zz3q5nGWU5ZE+t0cGAxAREgzESwjaoN5
	hCQQne8uguSCsywsGGfUmCyN1GIy/NNJS1hEznvvQCOoz+vs1+JHeFrPCjleYvSJ
	GCkvJQuk6xNn1v2jErA78nQf8D/CeqOjMsa74VOx58m5Gpxq2F3c0w5M99lSYh9o
	QeegN+vAqfcXQ46fjFPqgAYEeYl2FSVbMg46TK6J6aj5HogunoLXFbb5MSFTjqfI
	YcQ59/XBm/vQnNdwth9GCMr5eKCpt8zrzlQ==
X-ME-Sender: <xms:kfq3aB-WUxv5aaSFffFfjySs9eT5lXia7Q3O6kJ-tjHvnYFPGrGRNw>
    <xme:kfq3aDOo-HtqHDxSpwSY9OoSH_ktVfrvTdud-x2rTwsPRRGt8IMcqbc5ZG9y9QlhJ
    ecMy_QcGuMQO26B3Co>
X-ME-Received: <xmr:kfq3aBpjxxaS4yPMFuHAugas5MwMqjiBFVdJ2MKBnJ4vP6O0VbL8M4jDfOTJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrmhgrlhhlrgifrgesfigutg
    drtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopegu
    lhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kfq3aK7bXYVtFsCWsdyAkinfnbnBYIUr8Vg5ONdQvHngMxJensJuPw>
    <xmx:kvq3aJEkPbV_1wwC4ZG4PgqDosqghvkrAB9oOa-1bEtnJTzdmJeqkw>
    <xmx:kvq3aM1f-ayVOIrtGu6AeaMA11VlZaU-3xsll2lgtHTrLVopoiZiPw>
    <xmx:kvq3aGo3WmdM4rrhBvDZ8m6z4ByOPcL1WtZA8LejXWtpata-i0d_rQ>
    <xmx:kvq3aJpeYqPYkiMpm4yLwGdyYDKv1p3YS2oFtO6gNFwjAslk9M9T7lin>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 04:21:37 -0400 (EDT)
Date: Wed, 3 Sep 2025 10:21:35 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Message-ID: <aLf6j73xSGGLAhQv@krikkit>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
 <aLcWOJeAFeM6_U6w@krikkit>
 <0ba1e9814048e52b1b7cb4f772ad30bdd3a0cbbd.camel@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ba1e9814048e52b1b7cb4f772ad30bdd3a0cbbd.camel@wdc.com>

2025-09-02, 22:50:53 +0000, Wilfred Mallawa wrote:
> On Tue, 2025-09-02 at 18:07 +0200, Sabrina Dubroca wrote:
> > 2025-09-02, 13:38:10 +1000, Wilfred Mallawa wrote:
> > > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Hey Sabrina,
> > A selftest would be nice (tools/testing/selftests/net/tls.c), but I'm
> > not sure what we could do on the "RX" side to check that we are
> > respecting the size restriction. Use a basic TCP socket and try to
> > parse (and then discard without decrypting) records manually out of
> > the stream and see if we got the length we wanted?
> > 
> So far I have just been using an NVMe TCP Target with TLS enabled and
> checking that the targets RX record sizes are <= negotiated size in
> tls_rx_one_record(). I didn't check for this patch and the bug below
> got through...my bad!
> 
> Is it possible to get the exact record length into the testing layer?

Not really, unless we come up with some mechanism using probes. I
wouldn't go that route unless we don't have any other choice.

> Wouldn't the socket just return N bytes received which doesn't
> necessarily correlate to a record size?

Yes. That's why I suggested only using ktls on one side of the test,
and parsing the records out of the raw stream of bytes on the RX side.

Actually, control records don't get aggregated on read, so sending a
large non-data buffer should result in separate limit-sized reads. But
this makes me wonder if this limit is supposed to apply to control
records, and how the userspace library/application is supposed to deal
with the possible splitting of those records?


Here's a rough example of what I had in mind. The hardcoded cipher
overhead is a bit ugly but I don't see a way around it. Sanity check
at the end is probably not needed. I didn't write the loop because I
haven't had enough coffee yet to get that right :)


TEST(tx_record_size)
{
	struct tls_crypto_info_keys tls12;
	int cfd, ret, fd, len, overhead;
	char buf[1000], buf2[2000];
	__u16 limit = 100;
	bool notls;

	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
			     &tls12, 0);

	ulp_sock_pair(_metadata, &fd, &cfd, &notls);

	if (notls)
		exit(KSFT_SKIP);

	/* Don't install keys on fd, we'll parse raw records */
	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
	ASSERT_EQ(ret, 0);

	ret = setsockopt(cfd, SOL_TLS, TLS_TX_RECORD_SIZE_LIM, &limit, sizeof(limit));
	ASSERT_EQ(ret, 0);

	EXPECT_EQ(send(cfd, buf, sizeof(buf), 0), sizeof(buf));
	close(cfd);

	ret = recv(fd, buf2, sizeof(buf2), 0);
	memcpy(&len, buf2 + 3, 2);
	len = htons(len);

	/* 16B tag + 8B IV -- record header (5B) is not counted but we'll need it to walk the record stream */
	overhead = 16 + 8;

	// TODO should be <= limit since we may not have filled every
	// record (especially the last one), and loop over all the
	// records we got
	// next record starts at buf2 + (limit + overhead + 5)
	ASSERT_EQ(len, limit + overhead);
	/* sanity check that it's a TLS header for application data */
	ASSERT_EQ(buf2[0], 23);
	ASSERT_EQ(buf2[1], 0x3);
	ASSERT_EQ(buf2[2], 0x3);

	close(fd);
}


-- 
Sabrina

