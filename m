Return-Path: <netdev+bounces-56157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C4A80E074
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1391C2144F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E539B;
	Tue, 12 Dec 2023 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbhA7Ddi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0362E99;
	Mon, 11 Dec 2023 16:49:48 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77f320ca2d5so379772385a.1;
        Mon, 11 Dec 2023 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702342187; x=1702946987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqLY/u4bvnBwh4bnY6OxwjJDU9FT7fMClax0nElNopo=;
        b=KbhA7DdinYjb2F89wkZ0lglCpd5K4qt+w04PZFdYqwzXgu04DjFRH7ODpQOpiLruf+
         pprQE8PzJZVyskRIfMNAO/SJobLTrUQKSmCU27ylUKiKJL9SuLzmgrD8H5xphvS2awoL
         hDmgOKgNTV/pbyfGK6GlBvdkwaSvCJVSFiqsd3T9rC/wn36YFmneV8ZA33P9P9/AjC1R
         qaSOuO6vQ5KvsetE6s3M/ECqzH19X8BsDfFH62NhU8lXKRpBWo22ngUy1cmcNOVs3Low
         AWJKlun7Q9EREo3I/D326WxKTc2LIpprjHga1ddRBySPlbLjha5aALFIK1kMbNH2Ex6Q
         H89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702342187; x=1702946987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqLY/u4bvnBwh4bnY6OxwjJDU9FT7fMClax0nElNopo=;
        b=R2p+7eAMgZVumrdK1uClR10x7ss/MrS4o0mHrNX/5m/BG6C14FTyC1aVoZo7gx95Aj
         JuUA3VyXQn0P9VeXmL354wH+x3B3r3oM6PGn9apoPIXrN1k/BRhcJ9uvh7zsvyw6J6mk
         L8kUQwqskv9Yj8Sw4eVmdWKSfWsVfyvQWlqu4CKAZdAMYCYz6Yx7R4y3VMCOiQT2EMHH
         hajoh9ufHkPE5N5iXvUE9GoBjtH7AoiLuEvOANZI9Yba8IuWFgM3e6oE5QBeYICSjRbK
         onRsWszI7jrkitzwyTcaZdswLJjgaThGHJHQl2k/sjk2wxJ1Cl5k1yFkg6ZeT8S+EVXB
         8Cjg==
X-Gm-Message-State: AOJu0YzfkBPe+7FcRm+U95xTOwpcP5tyoRFLLaojwGTZuVHFAgFUH2aG
	rJkQq4QvUy+9PVwjOs2HIXU=
X-Google-Smtp-Source: AGHT+IFQwfihMHJtYIz93PxDCAlJP5Q7EprZ6W+bVsK3qL4XaGTZn2/VKLBUd4n90HuFAN2oxUtuwA==
X-Received: by 2002:a05:620a:6007:b0:77f:2f54:f990 with SMTP id dw7-20020a05620a600700b0077f2f54f990mr8573162qkb.67.1702342187079;
        Mon, 11 Dec 2023 16:49:47 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ov11-20020a05620a628b00b0077d7e9a134bsm3336384qkn.129.2023.12.11.16.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:49:46 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2AEB927C005A;
	Mon, 11 Dec 2023 19:49:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 19:49:44 -0500
X-ME-Sender: <xms:J653ZXgWsN1ZxbmnLYwet5xXCveCp6NwwoTc25C9xT12X_EtGQcyaA>
    <xme:J653ZUB9v6YKPHiuu9P4IAfbBA4JH8tfya_j7t9A1JEmKrSGZMK716yUzkJk3ACMh
    xnCR2DqEHkyb0Q8ag>
X-ME-Received: <xmr:J653ZXEscPg8BPAbm2WiWGU7FsOzWFG6YtW1zUrwffkFnpGJsKJEf3_J330Ptg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:J653ZUTev8rRUAhs34lQ66jFe8ZwUQNy1BySx04BJRg54MaNznxmdg>
    <xmx:J653ZUx_VtCo04U9lr56zgOQONBxAmYK9E5KkBoUOr5CPWAY3zxMug>
    <xmx:J653Za4XKS5xf3dPVN8MWXFDxmA7_v3_AhCNsHKQxRuOFzP7AmAxyA>
    <xmx:J653ZQcYWU5jts4OA3Byh4h78pLVft9-kjumgLz8NoeUZrWcfaHiOw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 19:49:43 -0500 (EST)
Date: Mon, 11 Dec 2023 16:49:39 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXeuI3eulyIlrAvL@boqun-archlinux>
References: <ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
 <20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>
 <ZXed8cQLJhDSTuXG@boqun-archlinux>
 <20231212.084753.1364639100103922268.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212.084753.1364639100103922268.fujita.tomonori@gmail.com>

On Tue, Dec 12, 2023 at 08:47:53AM +0900, FUJITA Tomonori wrote:
> On Mon, 11 Dec 2023 15:40:33 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Tue, Dec 12, 2023 at 08:15:05AM +0900, FUJITA Tomonori wrote:
> > [...]
> >> >> +    /// Reads a given C22 PHY register.
> >> >> + // This function reads a hardware register and updates the stats so
> >> >> takes `&mut self`.
> >> >> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> >> >> +        let phydev = self.0.get();
> >> >> + // SAFETY: `phydev` is pointing to a valid object by the type
> >> >> invariant of `Self`.
> >> >> +        // So an FFI call with a valid pointer.
> >> > 
> >> > This sentence also doesn't parse in my brain. Perhaps "So it's just an
> >> > FFI call" or similar?
> >> 
> >> "So it's just an FFI call" looks good. I'll fix all the places that
> >> use the same comment.
> > 
> > I would also mention that `(*phydev).mdio.addr` is smaller than
> > PHY_MAX_ADDR (per C side invariants in mdio maybe), since otherwise
> > mdiobus_read() would cause out-of-bound accesses at ->stats. The safety
> > comments are supposed to describe why calling the C function won't cause
> > memory safety issues..
> 
> (*phydev).mdio.addr is managed in the C side and Rust code doesn't

It's OK to rely on C side to give a correct addr value.

> touch it (doesn't need to know anything about it). What safety comment
> should be written here?

Basically, here Rust just does the same as C does in phy_read(), right?
So why phy_read() is implemented correctly, because C side maintains the
`(*phydev).mdio.addr` in that way. We ususally don't call it out in C
code, since it's obvious(TM), and there is no safe/unsafe boundary in C
side. But in Rust code, that matters. Yes, Rust doesn't control the
value of `(*phydev).mdio.addr`, but Rust chooses to trust C, in other
words, as long as C side holds the invariants, calling mdiobus_read() is
safe here. How about 

// SAFETY: `phydev` points to valid object per the type invariant of
// `Self`, also `(*phydev).mdio` is totally maintained by C in a way
// that `(*phydev).mdio.bus` is a pointer to a valid `mii_bus` and
// `(*phydev).mdio.addr` is less than PHY_MAX_ADDR, so it's safe to call
// `mdiobus_read`.

?

Regards,
Boqun

