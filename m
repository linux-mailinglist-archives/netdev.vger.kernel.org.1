Return-Path: <netdev+bounces-44896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2023C7DA35B
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F602B20CB5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC99405DA;
	Fri, 27 Oct 2023 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpeZFl0G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD78405C2;
	Fri, 27 Oct 2023 22:22:45 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDEF1A5;
	Fri, 27 Oct 2023 15:22:43 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7dd65052aso21388927b3.0;
        Fri, 27 Oct 2023 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698445363; x=1699050163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT8HpClbh1ze3v74LLdHftNfC04KsUKjpTPSc7WRHD4=;
        b=GpeZFl0GGRWDCOiFOg6VK1R8Ba/5KgvZvTYhgJFOpyqYP6/35pp8yZREYbf1SIkKHC
         rybqSY3TRDbkb2+xnh88wWNQ04WRMP6+lMdQo5d/vS8DPIAB5oQJ73wihPC02NS7W/GB
         W2crWrsKPZCXOneHm8YG+38oRx1WReKSd0d8PoA7fbxRmO6K/LSeYDV6FwNREZizoJLK
         5YqKvu4YNjaoIQ6aFO98rh9DQxI+/BRRDO8HD8muEUWMZRJ6Pu4gkhSmFU3fiYAsBjvZ
         GuQfksQS3HkY6dUSp48jpCQuSFfAYOX0a7hzHGJz7bbQMubf+HNbsvai8fmPSUJyqe8i
         e6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698445363; x=1699050163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT8HpClbh1ze3v74LLdHftNfC04KsUKjpTPSc7WRHD4=;
        b=pwaxt9SNXRmZQ+36SnbBGj10jLIxv0TN3V4GPkl0BNsnXCUSlVfuL4bOQYbVo02kIT
         8TrFEV2yM0M/GildX74yZ74C8aTdQGTkVYSpfGsJ5Ugjd9RXB29QYUSTsUpJwrf3ULcj
         PnsFi3VmiieUQy7QbgAFPW/xeWJw4ud3u9V09r+ufpxrEwXUZgWf3VEW1Y7ftlcDHzS9
         XQWoN+rjDhZeTfZCEHgMlRbHBLf2vbRlFsC/gorYuxUXIS17DM1KZ1EXVeGFZiANCh+d
         U4Ub8b1K7H7CrI9+16Ic5SAD/JfPyZnbpkZ/t0x7B2oAmgRboXLQFD2lMqdZp2hbGfxM
         ocyA==
X-Gm-Message-State: AOJu0YxNQiCpPs+qQ3bDp2rw5ZdPUxH66LO3Mqz4/kNdSHClOlTvvFza
	Ng6JjG6+6GjwtIHVdE/7zsw=
X-Google-Smtp-Source: AGHT+IE0P0wqJFFihuUQ2bhdzhPE9IOUIaVSpggBuX51n//cmwaF4ZTRzcUoKL3a09QR/IiWtjp6+A==
X-Received: by 2002:a81:e70b:0:b0:5a1:db6a:6459 with SMTP id x11-20020a81e70b000000b005a1db6a6459mr3911305ywl.40.1698445363103;
        Fri, 27 Oct 2023 15:22:43 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j145-20020a819297000000b005a8d713a91esm1160064ywg.15.2023.10.27.15.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:22:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 357B827C005B;
	Fri, 27 Oct 2023 18:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 18:22:42 -0400
X-ME-Sender: <xms:MTg8Zd0Cj2FU1AxJrWYnfnbseFO7OagCzoEr7TT4uawZADNDpPormw>
    <xme:MTg8ZUHiKJgy-s155uRBwkqUjJUnntuKgRmgxWxCiSNN538uY6TuMoAXAbDjGlpZ9
    6DCC0xpAkDHgefgcw>
X-ME-Received: <xmr:MTg8Zd4T-23SSvRHNIpW1xoy9FMLpmKTtqS94btZxwjDEe6G5GZQqclnH6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:MTg8Za1VTIGTT8afjEMr9Qy1UHce1qIONWeiT_G73W87_c5ZCf-VTg>
    <xmx:MTg8ZQGtOeCw72pY1-zNpgFoQdwDAdbxUhLyBFYo1w8UmGlokS7AEg>
    <xmx:MTg8Zb8r0CViotvXPaCX1p5YX5BmnmRHcGdgrIgytCpnr87P2Tj7KQ>
    <xmx:Mjg8Zb1-A8xdsB_WTYfoidSo_1SNpRq2QfyH0PaqvhcdDzqN14BGdA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:22:41 -0400 (EDT)
Date: Fri, 27 Oct 2023 15:21:51 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZTw3_--yDkJ9ZwIP@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>

On Fri, Oct 27, 2023 at 09:19:38PM +0000, Benno Lossin wrote:
[...]
> 
> Good catch. `phy_device` is rather large (did not look at the exact
> size) and this will not be optimized on debug builds, so it could lead
> to stackoverflows.
> 

IIRC, kernel only supports O2 build, but yes, if we don't want the copy
here, we should avoid the copy semantics.

> > 	struct phy_device phydev = *ptr;
> > 
> > Sure, both compilers can figure this out, therefore no extra copy is
> > done, but still it's better to avoid this copy semantics by doing:
> > 
> > 	let phydev = unsafe { &*self.0.get() };
> 
> We need to be careful here, since doing this creates a reference
> `&bindings::phy_device` which asserts that it is immutable. That is not
> the case, since the C side might change it at any point (this is the
> reason we wrap things in `Opaque`, since that allows mutatation even
> through sharde references).
> 
> I did not notice this before, but this means we cannot use the `link`
> function from bindgen, since that takes `&self`. We would need a
> function that takes `*const Self` instead.
> 

Hmm... but does it mean even `set_speed()` has the similar issue?

	let phydev: *mut phy_device = self.0.get();
	unsafe { (*phydev).speed = ...; }

The `(*phydev)` creates a `&mut` IIUC. So we need the following maybe?

	let phydev: *mut phy_device = self.0.get();
	unsafe { *addr_mut_of!((*phydev).speed) = ...; }

because at least from phylib core guarantee, we know no one accessing
`speed` in the same time. However, yes, bit fields are tricky...

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 

