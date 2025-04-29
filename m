Return-Path: <netdev+bounces-186792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E966AA115A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048C21706D3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC4245007;
	Tue, 29 Apr 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hrjeGXfJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idUuX08I"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442B244675;
	Tue, 29 Apr 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943087; cv=none; b=IxEq9HAncYOO2VjjnhFkj/nhiZmDrRkPUxh0lLr7Ri5Ml9v8uARavrt5f800YqkamZV74M/FwV+BzvaWxPPy+2PPb/p9eHPIsGxiSWWOuBN/pWxSH3S+QULh2iFejNpQDvakMxlM+7PzkLqlruTbfL0/RFppvIA5Aox73R/sDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943087; c=relaxed/simple;
	bh=aI4FF+Sfq4fMUsrJompbg1DSOfAVfkZ8HgqsklKZbKQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ellhlbYyKRTGYE3qhbVrO5SfMUbdgpVemoXpFToy5qjOt4BMH67jzK3yt0IC2oCbeOKRAUsw1PRxBwEsHxcGoGHUKxvP0IT1wpimiKUQyOH+vBoldxAmAl1kBxQbjqgFX/p43lcHXLzXoqBQdqqEwAEbVkNuLZTmFuFKPA7eRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hrjeGXfJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idUuX08I; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22D191140146;
	Tue, 29 Apr 2025 12:11:24 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Tue, 29 Apr 2025 12:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745943084;
	 x=1746029484; bh=YXrpQhriJ7deAXwAidsiUMu//ETuSEsyn6WCKxZHkNE=; b=
	hrjeGXfJwhk0k2W6dDDP4JmwbST5ryB4yzGnimysf634OcVcIWcZgGkHpAZC15zm
	t1wzTRzAsNgy4rPg+mokyiD4nGEkH+yJkbOJgCD/uU8IpZmVF7ixXPm4YBaeQGp4
	/pudEe+WZWfG5FC3wYUh+f4b/dTLjngbvKnSx23qbHvTxM9sO4+Y7yOStUZxZWmT
	QbVLVh/DaA4VIoGx2/kpm2KX3Pz0Tb+fyI4gPQSgnAxOidgbw9f0R1q2Sc5z7BvV
	16D+sXugtSrP4zgE4+VDpkaPY46hm+WsidH2AI3FLV3HDWTMdL/Wc0IWK8kozrI9
	dNxDslaJAKIG6M6gaP//XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745943084; x=
	1746029484; bh=YXrpQhriJ7deAXwAidsiUMu//ETuSEsyn6WCKxZHkNE=; b=i
	dUuX08IxNX52gLCgHsNztTAaORMjrOcmT/JBLfhfudb1R/Uka/ecLK266ymqO0ek
	sONweXY0NiylkPOhrrIVxfaQyK6ib0+YKQqCqydd18kduF/pzazTBsE9Euc35Zvm
	Ak/1dVFXJSukgeIi2gznz1Iy+mpyJRIz1j4fe6xugB1QAlVQT02Tf30Z5jf+1dC6
	rCjnMq3N0feGsCBAu5n+CVwSkNgBuNjejyx7KrBo9QZwlO7zgBauSrWqviaZ8uQe
	IUc6U2RuA8LC4M3oi5IZglJT18nPCH/m09IfIgksoZ8imtlH7Q7rgleZqu5mgItW
	AtYEx7fTAk+pYZ04H88sQ==
X-ME-Sender: <xms:KvoQaEXRHwiwjYVCvrxkzMwkJ-qb1AIiZpuTwk2QFcNDK3FiqTT9oA>
    <xme:KvoQaIk0IhVHwXHutfHti_pCgrvdqNXX4Ilv62CE1kC4CZyWS_5KkTqQWG-9cPZX0
    koK_03LYWAIJV7hlpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegvdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:KvoQaIbMb-67ArV4bBmc2RpjktTOTu2htrFS6x7nBBLLoPBrqRFNWA>
    <xmx:KvoQaDXlxfsNBzWEWfpPNn3WkaOwuRq4RBCZ-ytnDwHWkj-vfedZ4g>
    <xmx:KvoQaOn5T373t0x-2P-2e7XQANiqF-W8m12-kAvVwRxe0hW7oLmFmQ>
    <xmx:KvoQaIdaR5R0z0FBDuuYkYeVQx-TKjcCbhOvTNzIIr1fVQm-9tznPQ>
    <xmx:LPoQaDEXiVpsVfzjGXrThLlIq64MGOCNelqa1sQJPTmCey1SlPnmck-Y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BCBA32220073; Tue, 29 Apr 2025 12:11:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T252c7cf41b12c3c8
Date: Tue, 29 Apr 2025 18:11:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Boqun Feng" <boqun.feng@gmail.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
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
 david.laight.linux@gmail.com, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Jocelyn Falempe" <jfalempe@redhat.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Message-Id: <1b9e8761-b71f-4015-bf7d-29072b02f2ac@app.fastmail.com>
In-Reply-To: <de778f47-9bc6-4f4b-bb4f-828305ad4217@app.fastmail.com>
References: 
 <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <5c18acfc-7893-4731-9292-dc69a7acdff2@app.fastmail.com>
 <de778f47-9bc6-4f4b-bb4f-828305ad4217@app.fastmail.com>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 29, 2025, at 18:03, Boqun Feng wrote:
> On Tue, Apr 29, 2025, at 8:51 AM, Arnd Bergmann wrote:
>> On Tue, Apr 29, 2025, at 15:17, FUJITA Tomonori wrote:
>>> On Mon, 28 Apr 2025 20:16:47 +0200 Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>      /// Return the number of milliseconds in the [`Delta`].
>>>      #[inline]
>>> -    pub const fn as_millis(self) -> i64 {
>>> -        self.as_nanos() / NSEC_PER_MSEC
>>> +    pub fn as_millis(self) -> i64 {
>>> +        math64::div64_s64(self.as_nanos(), NSEC_PER_MSEC)
>>>      }
>>>  }
>>
>> I think simply calling ktime_to_ms()/ktime_to_us() should result
>> in reasonably efficient code, since the C version is able to
>> convert the constant divisor into a multiply/shift operation.
>>
>
> Well, before we jump into this, I would like to understand why
> this is not optimized with multiply/shift operations on arm in
> Rust code. Ideally all the dividing constants cases should not
> need to call a C function.

I think it's just because nobody has rewritten the
macros from include/asm-generic/div64.h into rust code.

The compiler could do the same transformation, but they
generally just fall back to calling a libgcc function.

     Arnd

