Return-Path: <netdev+bounces-186835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F188BAA1B57
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538614C8453
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419BA25E45C;
	Tue, 29 Apr 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4v/7B+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191B242D80;
	Tue, 29 Apr 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954885; cv=none; b=Oja0RwVxSFmoOe/oVAtQPYkzhaM65MNRt4hDQaZDARJpzngjjRGdAKyFhrEcVaZ7mkJFMjzZH2wYgFEIq+gvlSC8pC7HD7xvkPVSId2I/CyrxO0Kx81RTwN3GYBYZ2APE7VJOOoAgwM9egx86YVyGxk4l+zTW1H2DKr5bmpEHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954885; c=relaxed/simple;
	bh=QK+O2pC90MzZairg+A6PeUbYG4h/PtcWsHfStCXSPMY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1lcRYi98QBjbjt0+CPZEZ6tCHa0hCAWL3sFZYY2I/yoRnvieIsQVmNyC5ywKDvwrxYfB6O/YSTG+NBsrP+MqazUhvUZVQrgxnDcegBexxgQG/KSeih2zu/8E0epSh5q8x26BFJmPCAI6t51BfILFfqeI72aM7GpyGCPtGPTkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4v/7B+c; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c559b3eb0bso391629985a.1;
        Tue, 29 Apr 2025 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745954882; x=1746559682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lfi9kluYEourkOMoCM+SrB+AFs1UD6ZT9elag5E5mv0=;
        b=C4v/7B+c9UMH1kNen+t75a0bPWeyiUdN9XIXZ4LugPbBVewdR175WIGCDp5m8OijGU
         E1h/bbr+8XaY0Rvng8vID+N2d2paoubPLBD1B0Q8rcGOmKXGCFLr6F74RoMK2MLYJs5N
         AB31ZGMKjHs2pG0bsf+PnYxpvvV5Ef41qEv32WE1oboFI9ChotZQna1CYTJ+u5J56pk3
         6F9jDN8QSs2QNPJFwMysXFH1TCHtHZgaxA+IoHJYgKNFVK8gVOHe/25mCcsnQdoZs/GN
         COhITf5HZClhY8gZW9+J8psBJbTRFA2Nq7L86wmIJMnSMgBX7iXxCS7UfJChD/EyIkMI
         YDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745954882; x=1746559682;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lfi9kluYEourkOMoCM+SrB+AFs1UD6ZT9elag5E5mv0=;
        b=svAo/NPZdJV9SmRvV0qjPqqB3tVI1DDfpj2euOL5dRSgCP2tXaCfZbs+LioWS51dnb
         iqI43QlcijDq0ZN6HgNo07UCf5F62W8cpGDphHkQ7eh+ib8wXDQL7MyKZnLDV7oZ3Qgf
         Kx4nQ6gCBopq1Aa8dscgYWL81I9Ex9WylmR+l4T8KGHSsn4A3E+QeQ/717FMXA4szb8I
         fiozm8wovKperDJyzI893rS/U9aIKTCB8NbT/QInncApRJ2abhTjGN/gK3fqzUeePn0p
         jC7x5xlBiBm8mi+AiC90sQcotGDtRIqJRrRPWRPohiLtsDlrOK1vc1x4DdHYFnoCpQ/v
         aTzA==
X-Forwarded-Encrypted: i=1; AJvYcCUb9CZmRdyECq484+06JvtZ4mSXg6imQ9/1G8qVBoEuRFF4W9QKgsnnoTWuhbAdbXoHezjgxpkdjIXTxuEG7mA=@vger.kernel.org, AJvYcCWF3LN14H4cfAOzLEjO30jblXLQANJHSQejjMfKIRRcIKjcy7CKRcKtm2PRzDH0Yq72+5BrE/0mB/YCqfE=@vger.kernel.org, AJvYcCXr4XhQZgG1ebd0iKf1qCaGNITMZ1kFLUmapNMWULjvc5iNKRBimdqIHdONJk8wxrXMOWd5zm14@vger.kernel.org
X-Gm-Message-State: AOJu0YzemAG03SHHt0szFucyc7xNcUhTSWt6dQV6OWhmWL09M3tsLn+4
	OspJODKzXMALFhzn7mClj7/KjLQRZ1+SKy95+oIpcRfrLq+KVSTg
X-Gm-Gg: ASbGncuny2GdGlqjsqXQaE1ZHjzg6OCZUoQTfdr+y3Pdr4IN9q7u4HuoI/BiOL3E2GC
	NaB4jKCaiZj92K6rx2kxb7fj14qNLfZS5XBUQCuIoAnE7cdrMVQIexsglf6/wcjiBUKXSb4RrVe
	L4lxER9srY6PUroQ/EzGS56e2W+BU6/CujpAVIKYP77w9McwOm2KSiHP54szgzhISjHX7neBFXv
	i3s/OPkH90T1XooGR5+QJU7jO9fi23pk8EMUicHE3ugprYfnpdE8S2icrkujvDlji/Xa/rqq6+L
	+m1TNJ5QcIynGO5m+o1BoRjh0szmVw8GCBIypNpCXsGxGasE9ahpAzSeJYNyV/Obt4goTXnem61
	b/zX144Xa7vTqatffC2pjvRFHWBJNSCY=
X-Google-Smtp-Source: AGHT+IEv+oy+QRnhavYgic1PP/exJ6mBalecu936ijvnpINiH2bdODZ2XMZMVH1b+YWZb9R4rXwKKA==
X-Received: by 2002:a05:620a:404d:b0:7c5:e226:9da2 with SMTP id af79cd13be357-7cac76ca6ffmr45538585a.47.1745954882220;
        Tue, 29 Apr 2025 12:28:02 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbd21dsm770844485a.42.2025.04.29.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 12:28:01 -0700 (PDT)
Message-ID: <68112841.050a0220.17967c.3236@mx.google.com>
X-Google-Original-Message-ID: <aBEoP88kw6J3rP3I@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C96E5120006A;
	Tue, 29 Apr 2025 15:28:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 15:28:00 -0400
X-ME-Sender: <xms:QCgRaAN8G0PZnjMnTUhymqAWGKlxU1vrldDPD-9T1iBSB5BAgE9jYg>
    <xme:QCgRaG-b2HjwvMYV3z4EoaufQAKxSylGhTAWh0K2H1PpKNk-Q4htoEDYsgKTLd4y8
    clwSbODQ7i7CpWvkg>
X-ME-Received: <xmr:QCgRaHRAlJOhjGZMb6pzdxaDP_GVvXMfprVjOd38wS47r6sY5UK5YtFDHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehfuhhjihhtrgdrthhomhho
    nhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehmvgeskhhlohgvnhhkrdguvghvpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiug
    grsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QCgRaIsV20_Jj4g_5Qq0NkVIUHVgG8GGvhAvmPb449CLGkadnh2_eQ>
    <xmx:QCgRaIfSCnjOELVnTGMjUFmObY2cuTC4dd2NBN_x-RbWo2hsP7q-5w>
    <xmx:QCgRaM2JG32dkefv30tix-hXepnUg_hXSA59RJf4xfsUue8HP5TRBA>
    <xmx:QCgRaM9rIUS4ibl60KRSRyP_AuNw0OlQYHNS_zEHEoY9b2Akrygv7Q>
    <xmx:QCgRaP-tm_ZPiDeW5hGtRPH6Vz5uuAICFJjapoIKpmaCSF9ia8aL2ESH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 15:27:59 -0400 (EDT)
Date: Tue, 29 Apr 2025 12:27:59 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,	rust-for-linux@vger.kernel.org,
 Gary Guo <gary@garyguo.net>,	Alice Ryhl <aliceryhl@google.com>,
 me@kloenk.dev,	daniel.almeida@collabora.com,
 linux-kernel@vger.kernel.org,	Netdev <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,	Heiner Kallweit <hkallweit1@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,	John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, tgunders@redhat.com,
	david.laight.linux@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
References: <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <5c18acfc-7893-4731-9292-dc69a7acdff2@app.fastmail.com>
 <de778f47-9bc6-4f4b-bb4f-828305ad4217@app.fastmail.com>
 <1b9e8761-b71f-4015-bf7d-29072b02f2ac@app.fastmail.com>
 <6811092a.050a0220.27f104.5603@mx.google.com>
 <2d89292f-b02c-47b1-9299-92c5f4ba4c9d@app.fastmail.com>
 <681124ff.050a0220.13a0e7.2c80@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681124ff.050a0220.13a0e7.2c80@mx.google.com>

On Tue, Apr 29, 2025 at 12:14:04PM -0700, Boqun Feng wrote:
> On Tue, Apr 29, 2025 at 08:33:47PM +0200, Arnd Bergmann wrote:
> > On Tue, Apr 29, 2025, at 19:15, Boqun Feng wrote:
> > > On Tue, Apr 29, 2025 at 06:11:02PM +0200, Arnd Bergmann wrote:
> > >> On Tue, Apr 29, 2025, at 18:03, Boqun Feng wrote:
> > >
> > > Would it make sense if we rely on compiler optimization when it's
> > > avaiable (for x86_64, arm64, riscv, etc), and only call ktime_to_ms() if

In case I wasn't clear, nowadays Rust compiler supports optimizating
constant division into multi/shift on x86_64, arm64, riscv already, the
optimization is only not availabe for arm32. (It's actually an
optimization provided by LLVM I think)

Regards,
Boqun

> > > not? The downside of calling ktime_to_ms() are:
> > >
> > > * it's a call function, and cannot be inlined with LTO or INLINE_HELPER:
> > >
> > > 	https://lore.kernel.org/all/20250319205141.3528424-1-gary@garyguo.net/
> > >
> > > * it doesn't provide the overflow checking even if
> > >   CONFIG_RUST_OVERFLOW_CHECKS=y
> > >
> > > Thoughts?
> > 
> > The function call overhead is tiny compared to replacing a 64-bit
> > division with a constant mult/shift.
> > 
> 
> Just to be clear, are you essientially saying that even in C,
> ktime_to_ms() is not worth inlining? Because the call overhead is tiny
> compared to the function own cost?
> 
> My impression is that on x86 at least, function call is 10+ cycles, and
> multiply is 3 cycles, so I would think that ktime_to_ms() itself is at
> most 10 cycles. Maybe I'm out of date of the modern micro-architecture?
> 
> > What is the possible overflow that can happen here? For a constant
> > division at least there is no chance of divide-by-zero. Do you mean
> > truncating to 32 bit?
> > 
> 
> I was referring the last part of Miguel's email:
> 
> 	https://lore.kernel.org/rust-for-linux/CANiq72mMRpY4NC4_8v_wDpq6Z3qs99Y8gXd-7XL_3Bed58gkJg@mail.gmail.com/
> 
> Regards,
> Boqun
> 
> >      Arnd

