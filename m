Return-Path: <netdev+bounces-40249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21047C6622
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A828277F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2BDF4C;
	Thu, 12 Oct 2023 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0GqTHq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CDDDD5;
	Thu, 12 Oct 2023 07:13:29 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8E290;
	Thu, 12 Oct 2023 00:13:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77574c5979fso40660585a.3;
        Thu, 12 Oct 2023 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697094806; x=1697699606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onIbXS7mX7OxdHiXd2X0ZIy8cdKHPNQxFa5d47QulWk=;
        b=Ze0GqTHqKUHD2hesSgSeWjgda0rsvYNRHHSlfkCxibok/jYwVRhBiuzqtLTi0ouwbZ
         4v1bTwCLZxL9i5zGzVaRlV+As5mXmvpb4ZANgJU0rOFrl9uDGmkWmSf+Uh6OplfaHVXT
         +tJLVD/35krFXbggbBawhWXCjVuDbo/6Fg5wMgwOZpXlhChWijsN+8ETllv9fZSwjlZX
         f19Kgob0APgHWPBZzfHR4chKTvR+jiuaRo37FEOG7m+XFainBx7IdCbfZwLdkx4BvqI5
         OKj9AI1xw+xQo+Ir1orj2BDRe7yJ3kxuNTB5B/FKmVTuCld3yoNh7yqoilAK6YEVXayl
         bZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094806; x=1697699606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onIbXS7mX7OxdHiXd2X0ZIy8cdKHPNQxFa5d47QulWk=;
        b=sbeL3HuSY5GHi3L6fLDjWpgmrxsjz3M3iWzw2pz2a9kigsMO00CHPVjqPEnZKozqFv
         WGEMayjSumIPKLq9WK0AO0SOn9Xakc4BXIGWkbXf+ATwVIM+RNHhkmgHgeyKX8Nv/O8f
         oEaS1Ds8ZFtpsi8mhT1Ri7TmpoxcUwuvtmqPCkUzAaNKj9dsMWUf87SIHgI8T9mDs34D
         DLRCMpcXWCaljR3oBL2Js0Yqh8JZqNkLE9vsGVCBL0GfbBzD/6Ix3xdPxZuwt4zNMfm5
         8eXs2977F6j2+3JQ1yGmVbDzPJWwt8oTtq7wvkQYhKnfBfKwdbS4drzC8wEln4rbdLs2
         NWow==
X-Gm-Message-State: AOJu0YxRvh4AftncpVve69wi3JqZHlZ9hjghIiPWkiHUr3Q2h92ETg9V
	WaGKJCgXicyc4IEaODQSCpE=
X-Google-Smtp-Source: AGHT+IFrQTBEZ0juUhNTxshwV6apRSItlTkGK93Zs3MXx46lv580Cya8pEExIaPHLWaLa/qanneySA==
X-Received: by 2002:a05:620a:911:b0:774:2915:d180 with SMTP id v17-20020a05620a091100b007742915d180mr22221832qkv.37.1697094806075;
        Thu, 12 Oct 2023 00:13:26 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dt53-20020a05620a47b500b0076cc4610d0asm5822614qkb.85.2023.10.12.00.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:13:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6D63227C005B;
	Thu, 12 Oct 2023 03:13:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 12 Oct 2023 03:13:25 -0400
X-ME-Sender: <xms:lZwnZd9Mmbka1YgQ2rvcRG7-aOIm2bqsD7jRRW8mMyYjJCyhAxkL5w>
    <xme:lZwnZRsx4Ei74XuXA3OgG2LrBFuX-gCOoMEcP3-chqHpARH60vRUxzzVA__lx598e
    pzPc9mxKbzemeCNmA>
X-ME-Received: <xmr:lZwnZbCC1xmJSbEBxxUgaJ5kAUVK7N_TAndBQMwwAnvAiSWfmKfidpZ2mg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheelgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:lZwnZRcxUP-3scd8_ZffukJOtMgVVd6uA6boWH6vdefTAz3hqX7GGw>
    <xmx:lZwnZSNVtzBrb1T7sVPtL4RYDloK11MjnJDOEp5sUZrZRy6MeuTvXg>
    <xmx:lZwnZTlOt8vLg-3jlR9oT2VkPM8YRVoe3SGdwxFgshVJ5qsyHEMT0A>
    <xmx:lZwnZeCn_3JlasWF-KjYnrDXvBtcv4UvcoH3DFLPhUtU2AiSImnNGQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 03:13:24 -0400 (EDT)
Date: Thu, 12 Oct 2023 00:13:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <ZSeckzvOTyre3SVM@boqun-archlinux>
References: <20231012.145824.2016833275288545767.fujita.tomonori@gmail.com>
 <ZSeTag6jukYw-NGv@boqun-archlinux>
 <20231012.154444.1868411153601666717.fujita.tomonori@gmail.com>
 <20231012.160246.2019423056896039320.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012.160246.2019423056896039320.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 04:02:46PM +0900, FUJITA Tomonori wrote:
> On Thu, 12 Oct 2023 15:44:44 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
> > On Wed, 11 Oct 2023 23:34:18 -0700
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> >> On Thu, Oct 12, 2023 at 02:58:24PM +0900, FUJITA Tomonori wrote:
> >>> On Wed, 11 Oct 2023 11:29:45 -0700
> >>> Boqun Feng <boqun.feng@gmail.com> wrote:
> >>> 
> >>> > On Mon, Oct 09, 2023 at 10:39:10AM +0900, FUJITA Tomonori wrote:
> >>> > [...]
> >>> >> +impl Device {
> >>> >> +    /// Creates a new [`Device`] instance from a raw pointer.
> >>> >> +    ///
> >>> >> +    /// # Safety
> >>> >> +    ///
> >>> >> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
> >>> >> +    /// may read or write to the `phy_device` object.
> >>> >> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
> >>> >> +        unsafe { &mut *ptr.cast() }
> >>> >> +    }
> >>> >> +
> >>> >> +    /// Gets the id of the PHY.
> >>> >> +    pub fn phy_id(&mut self) -> u32 {
> >>> > 
> >>> > This function doesn't modify the `self`, why does this need to be a
> >>> > `&mut self` function? Ditto for a few functions in this impl block.
> >>> > 
> >>> > It seems you used `&mut self` for all the functions, which looks like
> >>> > more design work is required here.
> >>> 
> >>> Ah, I can drop all the mut here.
> >> 
> >> It may not be that easy... IIUC, most of the functions in the `impl`
> >> block can only be called correctly with phydev->lock held. In other
> >> words, their usage requires exclusive accesses. We should somehow
> >> express this in the type system, otherwise someone may lose track on
> >> this requirement in the future (for example, calling any function
> >> without the lock held).
> >>
> >> A simple type trick comes to me is that
> >> 
> >> impl Device {
> >>     // rename `from_raw` into `assume_locked`
> >>     pub unsafe fn assume_locked<'a>(ptr: *mut bindings::phy_device) -> &'a LockedDevice {
> >> 	...
> >>     }
> >> }
> > 
> > Hmm, the concept of PHYLIB is that a driver never play with a
> > lock. From the perspective of PHYLIB, this abstraction is a PHY
> > driver. The abstraction should not touch the lock.
> > 
> > How can someone lose track on this requirement? The abstraction
> > creates a Device instance only inside the callbacks.
> 
> Note `pub` isn't necessary here. I removed it.
> 
> No chance to misuse a Device instance as explained above, but if we
> need to express the exclusive here, better to keep `mut`?
> 

If `Device::from_raw`'s safety requirement is "only called in callbacks
with phydevice->lock held, etc.", then the exclusive access is
guaranteed by the safety requirement, therefore `mut` can be drop. It's
a matter of the exact semantics of the APIs.

Regards,
Boqun

