Return-Path: <netdev+bounces-90927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169628B0B4F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88C0282FE3
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87715FA68;
	Wed, 24 Apr 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jhnet.co.uk header.i=@jhnet.co.uk header.b="ij4igqMZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1DylUVG"
X-Original-To: netdev@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4715CD7B
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965988; cv=none; b=IoHk3rEte0na7xRdBlCl+EO94jo9oURilIaLKaIItt9jqrgqAv4mKmgGZXse+EwzMhx3LWJv02DMKhoyCIsJz9cNm/XUFJOoYpY8+4TZwzmfaEp0IeZXhwsZ9RxlLbMfYh0Yzj1hRDFHIMBTGXrYoBjYa6GnWpaXp9aNdSxnYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965988; c=relaxed/simple;
	bh=TEHxFKafK23g6aXSzMDOEMV8RtnhYn8arzPvLSfAD4Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=t5CaAT5EwZ3mWx7j7ZYc/aRHYAqi3kH0EanKY1o9avSYTONDrXzEGO7Q0xP3CQQtSFg/3SG0070FuZfCRG27MRTysjPXG3b9ICg3EL0GdUjkJqoosim3FnpFHyGuWun0eh4J+SWX/W8EEjJN1HU+BR0TY5pF99aHMpfB4OLt78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jhnet.co.uk; spf=pass smtp.mailfrom=jhnet.co.uk; dkim=pass (2048-bit key) header.d=jhnet.co.uk header.i=@jhnet.co.uk header.b=ij4igqMZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1DylUVG; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jhnet.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jhnet.co.uk
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A49AE1C00124;
	Wed, 24 Apr 2024 09:39:45 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Wed, 24 Apr 2024 09:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhnet.co.uk; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713965985; x=1714052385; bh=414/eXSmA0
	CMXLXh6gk5vhHdxpOPdGn+769sLQlhqDI=; b=ij4igqMZHPsViKiXhSSvVZ7KWg
	y3HjEw9du94FuelgJSyOzSSyhJC7TP1+/k7Ao9IhCwIVzzfDcryM9ZV9t2v8gvju
	gVkE17HY0NZxrFNlpemGAJ46/sOd+SxQz3+CP/lfVa/QIDk0rWauzNHLdMLTJarp
	ZuUdveZUczf6r0gjZrkRhEn1scKh+caeC0iPZNEPAw8YJoOkjsP2UjrAOjvdw9Ep
	71qEA+Cw2IcXRu9vhVqSdGR6ThwRzolakgMf+/GH9gXTYK4TbkdaFRAHvLH59Kfd
	04oujHZMW+LhG7lvz+eWJLjyYroxyhuslH82tYAyS4ic4/P/vjmhOjjwCjZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713965985; x=1714052385; bh=414/eXSmA0CMXLXh6gk5vhHdxpOP
	dGn+769sLQlhqDI=; b=Z1DylUVGiCLtDrOaUV0seLGYHwrf/o8yu3ck77z9IqUq
	42f01IZiD6WnagpyKICOFDAlg5GkMQ3cokWwkeBNl4sZHbt8yS/pxs9uFzMCoWBd
	C3pCdBA16GbNgSJmSB6qaSuCc8KgEw2WY6KSQEtemLEaWptCqRf2cmyRlQnv6sVt
	pxkZiYORWflh5+F8w+RSrsnt/xsGd21J/Vc+pzNRCojobzSCtr8nytXvJSAw4x2x
	Ozsb7UDSblobuUUAQuV9LWLqztyUHr8aBt7rExewa9zxiYbadJl4FWE/oHEjcIlB
	i2A0JQFbB3eKJbLPwSfwtWY+z0yQB5EqVrtVA9oraQ==
X-ME-Sender: <xms:oAspZujk7goy6Bl33XYVodJOe_kpTgRZp-OVe57LlxGJnw8iiwnrOg>
    <xme:oAspZvACNsecCbyEJx5B-vSPgVqMGlgoG1xu8zp_gtIOBvKitOz_i4JMNM8HDExBL
    DFz69rT3jq-AXLNbHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    nhgrthhhrghnucfjvggrthhhtghothgvfdcuoehmrghilhesjhhhnhgvthdrtghordhukh
    eqnecuggftrfgrthhtvghrnhepieekuedttdfhjeekgeehgeeiheevgeehvdekjeduudet
    gfelkedtvdetfeelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhgrihhlsehjhhhnvghtrdgtohdruhhk
X-ME-Proxy: <xmx:oAspZmE4QyXVQcuX023_hCuRajEtsRSkEVGHkBG3nmoxTYBaVkyp1g>
    <xmx:oAspZnSTlZ7dRacPDzpS3b3r3pSxkds0iHKdC2elgRtmznoeunRaFQ>
    <xmx:oAspZrzEXatW1z_hvpOWLTctZARzuTCiubhmdmNU3j7VspLHx6cvag>
    <xmx:oAspZl5I5Bv15E2c4UY944wPiqgMfSk-DJawzDQYOk8s-C4eve34Iw>
    <xmx:oQspZr8bnh5oR7zeoJzeMC9rODbXvu9Bky8IeRmAtr4_1bWkN5A4KRhD>
Feedback-ID: i43d949b6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D44B52D40087; Wed, 24 Apr 2024 09:39:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <005e8085-e36b-4112-be95-8d3475d0c524@app.fastmail.com>
In-Reply-To: 
 <CANn89iJDxA5nCTiw9SzHVfzhz2F124Z_PMEf_oJz3DGAp=UeOQ@mail.gmail.com>
References: 
 <VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
 <CANn89iLO_xpjAacnMB2H4ozPHnNfGO9_OhB87A_3mgQEYP+81A@mail.gmail.com>
 <VI1PR01MB4240EBA3CE9986FC6A0A9C7DD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
 <CANn89iJDxA5nCTiw9SzHVfzhz2F124Z_PMEf_oJz3DGAp=UeOQ@mail.gmail.com>
Date: Wed, 24 Apr 2024 14:39:24 +0100
From: "Jonathan Heathcote" <mail@jhnet.co.uk>
To: "Eric Dumazet" <edumazet@google.com>,
 "Jonathan Heathcote" <jonathan.heathcote@bbc.co.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "Jonathan Heathcote" <jonathan.heathcote@bbc.co.uk>
Subject: Re: [REGRESSION] sk_memory_allocated counter leaking on aarch64
Content-Type: text/plain

>> <<<garbled HTML email here>>>

My apologies for the email mess. Corporate Outlook is a bit of a disaster. Replying via my personal email rather than jonathan.heathcote@bbc.co.uk...

>> I'm very sorry but I won't be able to give this a try until Wednesday next week (I'm currently working part time) but I'll give this a go first-thing. Thank you very much for your swift response!
>
> SGTM, I rewrote the patch to remove the not needed
> preempt_disable()/preempt_enable()
>
> I will test it soon.
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 
> f57bfd8a2ad2deaedf3f351325ab9336ae040504..bae62604c5ffc8a3ecbe3e996b87c9fb25914c0f
> 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> ...snip...

I've finally had chance to test out the patch in 3584718 and confirm that it fixes the problem for me. Thanks very much for the swift fix!

Cheers,

Jonathan Heathcote

