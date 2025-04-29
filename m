Return-Path: <netdev+bounces-186789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF0AA10F4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DC53B4ABE
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB123ED5A;
	Tue, 29 Apr 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="paxyRFFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQy+8siS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF753238177;
	Tue, 29 Apr 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941891; cv=none; b=h6g9ZDek3eJ99j6eDU2GwVm7dlNJe0kpdpnryKWu3qXJVINrhD/D0KA72P5p7XIGVRN0H92ca8M9PaYOzfrZWvx6zuNrBWnSK6zbpBH/Imj7QRmuj00f6HFNVBvKanalOcLmaJhv8w0PMFa9mC/w0T8lyojIkFpWNaXL1cUVRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941891; c=relaxed/simple;
	bh=l+QvsevxJ3gRe9UnLNb8RJ42TkYXK+H5ulz9N97rJSA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gy3Fn8KcYCPIRAeKbLP3FbQMlCPBPF1vvxYZwaHsdn8EtmE2vN0xXh6QO97PCZf1lGWV7qu3WzL7U/5TcKyhPYYb/DiPG6aw5nNE3hJdvEYdyDuHx3tcOu2t9sFiABHNUZxSX1PYOFSzJhmVloLz5ycp3d9PO+QkXUMM4PeSCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=paxyRFFe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mQy+8siS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9651C114016C;
	Tue, 29 Apr 2025 11:51:27 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Tue, 29 Apr 2025 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745941887;
	 x=1746028287; bh=5ypmnlG4bx0alFv7ufvPvstflAVmjqUkuICddIWF6ho=; b=
	paxyRFFeLAkloUjrgzbdChFKuIOtS9XvYGJQfD3vNY5xG7lDjeeQTEfIDi8uXUB5
	rymj8Vm0SSzImzcnUaf1ZE1M+EmmEpa75IGtEtZ2wcY1IR6nrABhCPBqBnV+7vKp
	MOwxwZ1fFh4i8TacUPm++YbZvU7+ayicG/JZLxPhw791lbT/XD8fwCxmkzTW14aM
	ixc6KcTIi+OG1e8tvNQ9ril/SdoQFWvyiMYbBhl9P6hYwFbzeRRVj63wJT7pgWlU
	uD+NaU0JaGlOaEu4BkK6EpBn4W4+IGDj97VowXeq7YTCIGMnfehFoCBAydRuz16i
	63WNa+JKyAt/xvhCtiC1QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745941887; x=
	1746028287; bh=5ypmnlG4bx0alFv7ufvPvstflAVmjqUkuICddIWF6ho=; b=m
	Qy+8siS/mVOZ2TLSq0bURzdaKsAQqR8qtcn2gGF9C0rnm3oa09iNHYFwg307fRUP
	SFwzlIXaXVwp9kEhrdIPINJ7jHcvL4QSvoELN7nN8zALYFVWcuJTVce7DEnnhXA9
	XJGYOKWPbOOdu0esr6m1sCeT0YVeb2uoAK4tzvAFWWPAU9MLugmPzA/GP5Fo56g+
	1mEJOM2s9EMfKbQb2FONwaImDXGZPenAgsJ+QqO56Ec5K67lRoa0w1mDY6tYRQ3G
	SqHzYCtoi7zY+5tpuXmOanUmnk9mxfgTjHleGFvXhbyVJqZTWH5eIPCFy5ChoiYI
	8e7DRcqsHxeFS+E0zpnTg==
X-ME-Sender: <xms:fvUQaHO7x2eyHUdrs5kTI01c76rfERSGTU1XETABEGP_O6jVqt9q_A>
    <xme:fvUQaB8-bnKgez5Hx42wdFdFHDNxYqY02tA7baDZtsp625ij6UQ3rjupcwvXsmJ49
    THUy2Lb8TIg_bZnqPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    feelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvg
    hmrghnnhesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsg
    horhgrrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghp
    thhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegsoh
    hquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsihdrshgt
    hhhrvghflhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgurdhlrghighhhth
    drlhhinhhugiesghhmrghilhdrtghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhho
    nhhorhhisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fvUQaGSltOKtWHbcE2uyE9z0IBLXu0I5jwXVEgLzHA0BVUTHLgUSIg>
    <xmx:fvUQaLuvlUgAA8ZKSNGlW-3vNCPYefoH1z-uXuHuvmgAm-f5ybix8Q>
    <xmx:fvUQaPeYRcrvFOiQ6qYoZJjxQ5hD_16Y3DNKmQVcUCNKga11vmzhvw>
    <xmx:fvUQaH2nql3HNYfFJycfFuN7Xl65OX_Nf0HKIeFF8deWFlnjFdOwvA>
    <xmx:f_UQaAOlsBuQO2PKhczH7Tl5sLEuTHbdCsKM-XYV3H6d6e1EyaO1AHQV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28D452220073; Tue, 29 Apr 2025 11:51:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T252c7cf41b12c3c8
Date: Tue, 29 Apr 2025 17:51:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, "Gary Guo" <gary@garyguo.net>,
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
 david.laight.linux@gmail.com, "Boqun Feng" <boqun.feng@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Jocelyn Falempe" <jfalempe@redhat.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Message-Id: <5c18acfc-7893-4731-9292-dc69a7acdff2@app.fastmail.com>
In-Reply-To: <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
References: 
 <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 29, 2025, at 15:17, FUJITA Tomonori wrote:
> On Mon, 28 Apr 2025 20:16:47 +0200 Andreas Hindborg <a.hindborg@kernel.org> wrote:
>      /// Return the number of milliseconds in the [`Delta`].
>      #[inline]
> -    pub const fn as_millis(self) -> i64 {
> -        self.as_nanos() / NSEC_PER_MSEC
> +    pub fn as_millis(self) -> i64 {
> +        math64::div64_s64(self.as_nanos(), NSEC_PER_MSEC)
>      }
>  }

I think simply calling ktime_to_ms()/ktime_to_us() should result
in reasonably efficient code, since the C version is able to
convert the constant divisor into a multiply/shift operation.

div64_s64() itself is never optimized for constant arguments since
the C version is not inline, if any driver needs those, this is
better done open-coded so hopefully it gets caught in review
when this is called in a fast path.

       Arnd

