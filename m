Return-Path: <netdev+bounces-45021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2A7DA8C6
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 21:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FD7281A45
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB1F17721;
	Sat, 28 Oct 2023 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bojhys2E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B617156F6;
	Sat, 28 Oct 2023 19:06:37 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BCBEB;
	Sat, 28 Oct 2023 12:06:35 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6711dd6595fso2266746d6.3;
        Sat, 28 Oct 2023 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698519994; x=1699124794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4inrKF7iMBJLKovSIdfYDwDQaT3Q4Zg4Ueq4qFLHybw=;
        b=Bojhys2E3Xw9QnphBJZ+UsCtmGo+q8I9I+tQ0zBCYMzmuan5Fv3LLuU1O1mdvLwEHY
         3SddYhOahsPSakqaD+TWz/NOCGN76zXwKWaSF6LZEfYe4QKAD+7ohhnEKKZRshmKkeL4
         1KqdwLwoaK0u05FOLsEImQ1lRFrx1oP5wSM5WZesv6VQyOfb10/OKp+RH2qk4AIIfPms
         ARw7DPyRfRsE8/xmunwTR+UkXMHuU8BpzxarGEUN25EsBBs8Os0aPT3ROTj4D3p5x3ZU
         dOd9IpNrnNjh994Lug0jPtzKL9ekuJtikqMKYTBoWElJqvdm9VOOaNvD1FwYjkKzzptd
         J4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698519994; x=1699124794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4inrKF7iMBJLKovSIdfYDwDQaT3Q4Zg4Ueq4qFLHybw=;
        b=odUK7CqqdNYrMH3ruuZWxWr5AankQgvEDgYZDjdgnkYKqaBOyRtUtqthZR5O94xITp
         LRp9osGdQ5uiYC30w4YD+q5mkRVt9amrSN+qOmOQ31iXPgcW7HzAWaeNiVt3kicUjz99
         sLFSZ2mDEO0lgtgqfsQUHElqurKjvGgXRE4cggbvnA9Pn0kzyxiN3YEQuzE3E60D/Edh
         hYjD3Of+Vt6ICqjzpKsqpHsI1cymD+pZfi5+ChZz4PBLMtgqhAmliJz7QTA2JlbKwEJ6
         IxRuQb1PVOvYkn8IeJ5CyQOzq5NR26G/ug91plrGBMIDj1R6M5xa8tPotvsCPEekEcuX
         PyUg==
X-Gm-Message-State: AOJu0YzEsXs2L98nC5hBwX0DLX2lALDrzXFYQlA1gvmMJ7a1TVnVHPew
	iKsM7dJBXeUzuw3PZjaTbv8=
X-Google-Smtp-Source: AGHT+IHIKxj1HftcMfT8F+/O04lVbAi+4X08yIPnCLQfaNBcb+k5XPc7PUAmXJvEcK3BMYTqfPHr8w==
X-Received: by 2002:a05:6214:21e4:b0:671:25b2:7dbd with SMTP id p4-20020a05621421e400b0067125b27dbdmr1730780qvj.3.1698519994645;
        Sat, 28 Oct 2023 12:06:34 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a9-20020ac84d89000000b00407906a4c6fsm1821492qtw.71.2023.10.28.12.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 12:06:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id AEB6727C0054;
	Sat, 28 Oct 2023 15:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 28 Oct 2023 15:06:33 -0400
X-ME-Sender: <xms:uVs9ZYHNXIk0YvCV1Nb0VZxsCi6kCNfBGvF47_Qd6caEO1qm-N35OA>
    <xme:uVs9ZRWCB3ZZJ_gVHjQZghxPJeOBd4_FoYa4KlQhkxZo8BJdDPypsNnZ7U3sCeNtG
    Sh_IbKkV3LUaswyXQ>
X-ME-Received: <xmr:uVs9ZSKZzRiyd7qPhnt_dCCU1jL1gY8Vu0k0jX-pQkA6ciXkyRGIosr87Nk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeigddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uVs9ZaErWjPkj8noWunfpujizktmE91D8Wjk_01KBRWyyiDt0mX5Jg>
    <xmx:uVs9ZeX9RvNyQh2z1QEUDOQ8Z5oOK6W60Ngv4emAcW3dUxnfgxtkXQ>
    <xmx:uVs9ZdN0WIOe8FA5gmf8j87NTeis2hMBrqqzQGiteU-sM65klO6sFA>
    <xmx:uVs9ZZG72cqG5lZ-zqEytq1LKfgMaG4q_wB5_YGFPa_i5aYztFeajw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 15:06:33 -0400 (EDT)
Date: Sat, 28 Oct 2023 12:06:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, andrew@lunn.ch,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZT1bt8FknDEeUotm@Boquns-Mac-mini.home>
References: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
 <f0bf3628-c4ef-4f80-8c1a-edaf01d77457@lunn.ch>
 <20231029.010905.2203628525080155252.fujita.tomonori@gmail.com>
 <91cba75f-0997-43e8-93d0-b795b3783eff@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cba75f-0997-43e8-93d0-b795b3783eff@proton.me>

On Sat, Oct 28, 2023 at 04:39:08PM +0000, Benno Lossin wrote:
> On 28.10.23 18:09, FUJITA Tomonori wrote:
> > On Sat, 28 Oct 2023 16:53:30 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> >>>> We need to be careful here, since doing this creates a reference
> >>>> `&bindings::phy_device` which asserts that it is immutable. That is not
> >>>> the case, since the C side might change it at any point (this is the
> >>>> reason we wrap things in `Opaque`, since that allows mutatation even
> >>>> through sharde references).
> >>>
> >>> You meant that the C code might modify it independently anytime, not
> >>> the C code called the Rust abstractions might modify it, right?
> >>
> >> The whole locking model is base around that not happening. Things
> >> should only change with the lock held. I you make a call into the C

Here is my understanding, I treat references in Rust as a special
pointer, so having a `&bindings::phy_device` means the *entire* object
is immutable unless the fields are interior mutable, for example,
behind a `UnsafeCell` or `Opaque`, examples of interior mutable types
are atomic and locks.

Now since C doesn't have the "interior mutable" concept or these types,
so when bindgen generates the `bindings::phy_device`, none of the fields
of a lock or atomic is marked as `UnsafeCell` or `Opaque`. That's why
`Opaque` is needed for defining `Device`:

	pub struct Device(Opaque<bindings::phy_device);

`Opaque` basically does two things:

1)	tell compilers that the underlying content may be modified (of
	course in some sort of serialization) when there exists a
	`&Device` or `&mut Device`.

2)	only provide `*mut bindings::phy_device`, so accessing the
	underlying object has to use unsafe.

Now let's look back into struct phy_device, it does have a few locks
in it, and at least even with phydev->lock held, the content of
phydev->lock itself can be changed (e.g tick locks), hence it breaks the
requirement of the existence of a `&bindings::phy_device`.

Of course, if we can define our own `bindings::phy_device` or ask
bindgen to automatically add `Opaque` to certain types, then
`&bindings::phy_device` is still possible to use.

If we are OK to not use `&bindings::phy_device` then Benno's proposal in
bindgen is one way to work with this.

Regards,
Boqun

> >> side, then yes, it can and will change it. So you should not cache a
> >> value over a C call.
> > 
> > Yeah, I understand that. But if I understand Benno correctly, from
> > Rust perspective, such might happen.
> 
> Yes, that is what I meant. Sure the C side might never modify the
> value, but this is not good enough for Rust. It must somehow be ensured
> that it never is modified, in order for us to rely on it.
> 
> -- 
> Cheers,
> Benno
> 
> 

