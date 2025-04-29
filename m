Return-Path: <netdev+bounces-186819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F80AA1ABD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B1A98087A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29562459E1;
	Tue, 29 Apr 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ojTqJkGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5a3pCnT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1A20C488;
	Tue, 29 Apr 2025 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951655; cv=none; b=H91cbdiG22wMfeLfhT0QzB+3zQs3jkSsYd0j6eH7zaII+qneu4AcHHPdhPvU1Ev9DN0bu8t1gOKrRzsgdmnnZLmVsMvPQMew6SuDccF+6XaUB8HuFAoHaVRKzUl7MihjAvdmd2vge+iZhqvwbB8yqNcIv7MKahFDiygullwM9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951655; c=relaxed/simple;
	bh=9crp416ZN4gjAOtJJD/F1uQjJEV0g1SLQ8TDby6Ko0g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FaVvTPShDk/s13JZRFyLWOam7uIclOOH18ZEVJdabGH2OVNo5AKiv8XJzRhdXHicB2B05u4bqWaTa2CwawH8nQo84/KuZBsFXvTQHSQSuLDq3brHYdJsPVgGTvl36fiTi51RNc+ZXXVxO9fRHjeqR9dQcQ5r7qjcCydgiIGyixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ojTqJkGk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5a3pCnT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4C4B2540197;
	Tue, 29 Apr 2025 14:34:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Tue, 29 Apr 2025 14:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745951650;
	 x=1746038050; bh=uiFqvtF8fHyhEpYWit3h1uAl9bL8bBQ5SX+JFo37p6U=; b=
	ojTqJkGkiH3Jnm6gBya4iyo7ch/Mar/myvNdO3yChpaIwCWV31BIHQ8H+EZtjwfR
	z/v+1KfLiS/ZGDj7WfKmszXP2OtQIbnGGaLyWqFKXJrKem2FK8ab0QzU2Un5LBiu
	a5R/HoqldYzNIvEJkjY/iCYwgNmPjxb0xNaEtlgMpgVnEytmxY6ti37eiFa5wDda
	2PnvHLXdEW+SFqsKeUwUjtTkd+C54VsRZw1p4iYBTsF6tFF6LydkgJBTnDy+n+IK
	yKVrVuC25MH5ZJ8N9IzgtSL7OefdNRrePoIt0pbIDTAy24FXs4RJAiWJhmiMhKTv
	NPFLZEjDswf2NA3l4Cu9yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745951650; x=
	1746038050; bh=uiFqvtF8fHyhEpYWit3h1uAl9bL8bBQ5SX+JFo37p6U=; b=L
	5a3pCnT021PA9+CQFGSamfrBzgutATzrmljPevqCUv5e9zi9BPhoL490ivLcpNpR
	1kWBj4Qod9ZFRX7KKg+bsBodJC+1tJMpf6+kceMHMtfetADXbfM2vl+LNWPy6K+S
	EvV5c1AFfsvbRXlAFXCZEUDi3VaKqFhefAmBpVLyD5ktFz4eNtfLmFOn9jNY50Cx
	e2znhv8TtM5JUT5Ms4dd2uWe5d/COydG5c1vp8z0+BSj3kwWZn03Isl5hASVomL5
	s68y5S9lIJFdoJQBte0spk9WMhKV5IuAIRsDVKC5D3/YkjinKh2iqDbBu35vjmFK
	rPAD3gnvB89f9yRv36g8Q==
X-ME-Sender: <xms:oBsRaGPD3xL67tIYCec6JGAk8F79QCKq12OIw4ksnFD4ZNhK4WYwTg>
    <xme:oBsRaE8_C1RMC28cJON3ELXsfpAdISauvSRyPl6yChxAcmaolJasBYio0YCaKbfFH
    7lJl1UJ2gpLMNv-ZXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeefledpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhmpdhrtghp
    thhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurg
    hnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhgvgidrghgrhihnohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishhirdhstghhrhgvfhhlsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oBsRaNRG37mhhEndxz3GzPDr24h0PqMCVL9pfyhf9HNs_MlwJHmUSA>
    <xmx:oBsRaGsMBya5nUyqELCVubK_HTCA_qFwKh1cnekHG3qZMJP1h8juKw>
    <xmx:oBsRaOcvEP_DJKM3FzZGzXz6A9VQhbHZUwReLeXx9AZQKXkvMcLRpg>
    <xmx:oBsRaK2LyCBwd-YZw-9uTWaVeAEAGYqOpHmzZnRc4XmWXPrYq37YMQ>
    <xmx:ohsRaJ-NLNGtRUh9Tckxp8R9CXIQ_xIZY6UZsIlsXQXG0bSJTvdXGaiB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 289532220073; Tue, 29 Apr 2025 14:34:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T252c7cf41b12c3c8
Date: Tue, 29 Apr 2025 20:33:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 rust-for-linux@vger.kernel.org, "Gary Guo" <gary@garyguo.net>,
 "Alice Ryhl" <aliceryhl@google.com>, me@kloenk.dev,
 daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>, tgunders@redhat.com,
 david.laight.linux@gmail.com, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Jocelyn Falempe" <jfalempe@redhat.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Message-Id: <2d89292f-b02c-47b1-9299-92c5f4ba4c9d@app.fastmail.com>
In-Reply-To: <6811092a.050a0220.27f104.5603@mx.google.com>
References: 
 <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <5c18acfc-7893-4731-9292-dc69a7acdff2@app.fastmail.com>
 <de778f47-9bc6-4f4b-bb4f-828305ad4217@app.fastmail.com>
 <1b9e8761-b71f-4015-bf7d-29072b02f2ac@app.fastmail.com>
 <6811092a.050a0220.27f104.5603@mx.google.com>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 29, 2025, at 19:15, Boqun Feng wrote:
> On Tue, Apr 29, 2025 at 06:11:02PM +0200, Arnd Bergmann wrote:
>> On Tue, Apr 29, 2025, at 18:03, Boqun Feng wrote:
>
> Would it make sense if we rely on compiler optimization when it's
> avaiable (for x86_64, arm64, riscv, etc), and only call ktime_to_ms() if
> not? The downside of calling ktime_to_ms() are:
>
> * it's a call function, and cannot be inlined with LTO or INLINE_HELPER:
>
> 	https://lore.kernel.org/all/20250319205141.3528424-1-gary@garyguo.net/
>
> * it doesn't provide the overflow checking even if
>   CONFIG_RUST_OVERFLOW_CHECKS=y
>
> Thoughts?

The function call overhead is tiny compared to replacing a 64-bit
division with a constant mult/shift.

What is the possible overflow that can happen here? For a constant
division at least there is no chance of divide-by-zero. Do you mean
truncating to 32 bit?

     Arnd

