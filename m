Return-Path: <netdev+bounces-272632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJFXGLTPxmndOwUAu9opvQ
	(envelope-from <netdev+bounces-272632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:43:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C833491A2
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CFF3047533
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBA41161B;
	Fri, 27 Mar 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqLTMAvv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F953FEB1D;
	Fri, 27 Mar 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636974; cv=none; b=cRzp1iyhu/WADzJ04ZF61ROC0gN7xqe3RWKkmUgWJGgtePChXEDs3dfswKLgccmQL0mAeWo359uSxj/esR6W/16fIKuXA26WOy6s4Zg90HvYV2L/hn3LRr07LEs4YB+gjC8UZtHFdlVN1e+sVyySu1jxduyFIjJWvkS6DwgIQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636974; c=relaxed/simple;
	bh=R9AHAajVl54S43rOD25tNtqd/iHB1Qz12wrBG7w2KjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvNEyi7e2PVFgCDNz8V+QLbUnz3NOQ1Vs7PUVa0BkcD5KzJulfu/C1iOeIHFMuZcMIS88MU9z6CgmScGee27GaMpfe1B9rXJUYWai0ZGQYS+YZF0qXY49EPN9ZaWxWmWR/5lxXdBRjVctSq1kW4q1g0bqIHth7JrI9wmi+epF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqLTMAvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC21C4AF09;
	Fri, 27 Mar 2026 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774636974;
	bh=R9AHAajVl54S43rOD25tNtqd/iHB1Qz12wrBG7w2KjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqLTMAvv7+jnfJ63kHoj5u/xRq7KjteyBcy3HIl1cnYvAHjHZ1OWSG0NmwwBvb/fd
	 dup5UeymFe5k1FgaPMpKPS1CWFV2QefCBH69aiBilkovEgPOC7G+mJHdKietEf93mn
	 z+D5DefKb0R+UjekRh0OhALTi/xJwUwgIy8DpuYwcGTN9n+tm/uHO9LVguwZYokkoK
	 tnQuwnG/Tf+S+rzR3bpRe5cvXOYdNDZqK+J4SPMytGZ+3SUK2+mrVQra/5ismGlbII
	 czayvkG45XiAzqxbhUAC5z+eA4cRh6ytBdF/EcuGtNZxJHtyqSJi2FR5/EBnlhtMp1
	 Wd10Tu3oCjHYw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5096CF40074;
	Fri, 27 Mar 2026 14:42:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 14:42:52 -0400
X-ME-Sender: <xms:rM_Gaf53wU_w_vFmN1XR_9VmQF1e9TTRE1rM87oww0jbqKn3zQiTvA>
    <xme:rM_GaXPvT0Z2HQrHgUaQNVTRIVrWLOwO-BgCrV5k8GRfnE72m0QIvotqSXTp_orHj
    2gOytGhfi8Tw5WrIjza2Ip1_8Tik1hvjAcSmd5zwH2MmvzdFnQ12Q>
X-ME-Received: <xmr:rM_GaVKjAVbZbK7E0hlnUpPhDxno_FwWS3alvOVgDWol-eNebJPQxgRTTLinzpUhbU8XuI9F0parELUQLiuRtIH53yHFxQQe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgfdvtdefieetieefueetudehffevieffkeejvdetleffledvveetgfeufeethfeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddqudej
    jeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrghmvg
    dpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehm
    ihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepfhhujhhithgrrdht
    ohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegrtghouhhrsghothesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepthgrmhhirhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:rM_GadFLMzx4SKFk_EBd2q_cYZurxddg5M3RCp3W13r-KO2-pIw_3w>
    <xmx:rM_GaQwrMngO9IeycAuAvKlG4TKJtWiPzWRRnEJy5iLXeqAcanIiVQ>
    <xmx:rM_GaRzM6IaacdY8NVZgpSijNYfeYjtBiBd74AMcjNC3_VfJbdwB2A>
    <xmx:rM_GaeYlxRTqqcf4hORjoZECWHFuqZSzQ6j1M4n3MsRaTFYdYieCxA>
    <xmx:rM_GabyudvqMVVB43xhTcrM2BV1ORfwR7f7w1i5eNFfiIaXHwurbBMl7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 14:42:51 -0400 (EDT)
Date: Fri, 27 Mar 2026 11:42:50 -0700
From: Boqun Feng <boqun@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>,	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,	Tamir Duberstein <tamird@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,	Yury Norov <yury.norov@gmail.com>,
 Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>, Yury Norov <ynorov@nvidia.com>,
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
Message-ID: <acbPqjBE8mqbiVkv@tardis.local>
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
 <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272632-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,gmail.com,nvidia.com,kernel.org,protonmail.com,google.com,umich.edu,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tardis.local:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B5C833491A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:36:52AM +0100, Miguel Ojeda wrote:
> On Thu, Mar 19, 2026 at 1:17 PM Gary Guo <gary@kernel.org> wrote:
> >
> >  rust/kernel/net/phy/reg.rs           |  8 +++++---
> 
> Tomonori: are you OK with these changes?
> 
> >  rust/kernel/num/bounded.rs           |  2 +-
> 
> Alexandre: are you OK with these changes?
> 
> >  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
> >  rust/kernel/sync/atomic/predefine.rs |  2 +-
> >  rust/kernel/sync/locked_by.rs        |  2 +-
> >  rust/kernel/sync/refcount.rs         |  8 +++++---
> 
> Boqun: are you OK with these changes?
> 

Acked-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> >  rust/kernel/xarray.rs                | 10 ++++++++--
> 
> Tamir, Andreas: are you OK with these changes?
> 
> > -    transmute::{AsBytes, FromBytes},
> > +    transmute::{AsBytes, FromBytes}, //
> 
> Nit: We should take the chance to expand this.
> 
> Thanks all!
> 
> Cheers,
> Miguel

