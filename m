Return-Path: <netdev+bounces-40246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B383F7C661B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99C71C20EAB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666CDDDF;
	Thu, 12 Oct 2023 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYE+XUhF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE71DDDC;
	Thu, 12 Oct 2023 07:08:01 +0000 (UTC)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF790;
	Thu, 12 Oct 2023 00:07:59 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49d0f24a815so235831e0c.2;
        Thu, 12 Oct 2023 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697094478; x=1697699278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtqMm+gViV+ifOM9Gdykh4kz5GKCnQTh8ypheLKKH+8=;
        b=VYE+XUhF0EyGL33inn4PbsLxk8W/Y4m3IZcEwoOhbRZH0MLf6Pdf4ecGVTySF0ZLEC
         a6KwW7fQB0DKzqAOUGymQYqYwuNe0IllBJLnzCJ2KCqcgQ8JbL8jLDUd3Icm8dJLUn7b
         j6QsPatquVZvX6MspGCLdh+0TWDuIzaIxzuTvfmVVVrXTlwKV+tR8g+ifYh34ub59Nd+
         /8uYPoge3e5ZjOqsZSr3fvCb3FwoiXVS2PSDolnxpYwjK+/mVnXyYKHL4N5E6h9ehAdb
         2asqnzqmkaaTwaUJxoFvl4VgBRtmzbyYdzYO4es8Q3+QFyPPjzPk1sjrhfL1kxiY5uTS
         hAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094478; x=1697699278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtqMm+gViV+ifOM9Gdykh4kz5GKCnQTh8ypheLKKH+8=;
        b=uzYUGqOm3Js+JzsLa/4Xeo6lrCh3GBcoT/gAo3k3iMGoyJDfHtynt6p32WI2WrYfPc
         omjhM2gkPlpfxa8a22vJjW++xWqAcFah47OFW1QhmZr6ywwswaGwXd2ZSLlS1z4UZ+b/
         Gb49zo1BTcLnrpRgoGLEdA2JR1+WQZ2lVfti/iFszAWqFSw/VffxDqovorQbu8+SNJl7
         taTMCIWvQE1TCjl/EC12RSTabJGeICxE8n3/VROZEi2VdXd3ikbkrVqKGKalWUT0x3yj
         4PCB61zw8kXK0KgkY04yP13EiXW+e6+cZlxp+0PBI2JcXOgAnXaOwbpBJszbvpvfji++
         4EwQ==
X-Gm-Message-State: AOJu0Yx4+8UFwQJfA800Las14mJM909xOAVFq8Dj4CUu1maF7i36+fv3
	eiC4CViTetIKnqx5qO0qPr0=
X-Google-Smtp-Source: AGHT+IGiumwVQSsX2DMH4i08kpvW+D2PQJ35MnRFlrYprGxlWFNNHzCgnMvDfxdPk4C6zaAQf1WWKg==
X-Received: by 2002:a1f:df43:0:b0:48f:f026:27de with SMTP id w64-20020a1fdf43000000b0048ff02627demr14488915vkg.15.1697094478424;
        Thu, 12 Oct 2023 00:07:58 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id fe5-20020a05622a4d4500b004166ab2e509sm5970258qtb.92.2023.10.12.00.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:07:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id B4D1327C005B;
	Thu, 12 Oct 2023 03:07:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 03:07:57 -0400
X-ME-Sender: <xms:TZsnZTrFeokXq1b9T2-PT46uwi7wasMZx_pVTmxrWZS7sJDmQIFnLg>
    <xme:TZsnZdox5juxgmck8J44CFXyoomOWVAT0jg0MmFRQLRRrVKsz1wyJNOVrJMTtJ8rc
    oXq8I5E5FsPnX14nA>
X-ME-Received: <xmr:TZsnZQNuJUqENS2m7T0R_KUzEyh0kbUqjbAPdRY1Ki_kj2QMrwTMI-_QSp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheelgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:TZsnZW71bXwq7UGH3qMYFSQDW5LQXSmmqvxFZkhmzCQuANV5Fs5cyA>
    <xmx:TZsnZS4Y_qYWKZuv1PErObtQWHVOLNPdtbrKAZKK_8EOlsSPussK_g>
    <xmx:TZsnZeg7OBP1cDkWSzN8QTUN8XinxEXkjZJ8EifIGhTxOvJpObiVmQ>
    <xmx:TZsnZfvsa6cXhvCK0jbSbC0h_J_cJJx5xPuiG13A5SgwKV_TvTZwUA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 03:07:57 -0400 (EDT)
Date: Thu, 12 Oct 2023 00:07:55 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <ZSebS0pQfoF4eTsD@boqun-archlinux>
References: <ZSbpmdO2myMezHp6@boqun-archlinux>
 <20231012.145824.2016833275288545767.fujita.tomonori@gmail.com>
 <ZSeTag6jukYw-NGv@boqun-archlinux>
 <20231012.154444.1868411153601666717.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012.154444.1868411153601666717.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 03:44:44PM +0900, FUJITA Tomonori wrote:
> On Wed, 11 Oct 2023 23:34:18 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Thu, Oct 12, 2023 at 02:58:24PM +0900, FUJITA Tomonori wrote:
> >> On Wed, 11 Oct 2023 11:29:45 -0700
> >> Boqun Feng <boqun.feng@gmail.com> wrote:
> >> 
> >> > On Mon, Oct 09, 2023 at 10:39:10AM +0900, FUJITA Tomonori wrote:
> >> > [...]
> >> >> +impl Device {
> >> >> +    /// Creates a new [`Device`] instance from a raw pointer.
> >> >> +    ///
> >> >> +    /// # Safety
> >> >> +    ///
> >> >> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
> >> >> +    /// may read or write to the `phy_device` object.
> >> >> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
> >> >> +        unsafe { &mut *ptr.cast() }
> >> >> +    }
> >> >> +
> >> >> +    /// Gets the id of the PHY.
> >> >> +    pub fn phy_id(&mut self) -> u32 {
> >> > 
> >> > This function doesn't modify the `self`, why does this need to be a
> >> > `&mut self` function? Ditto for a few functions in this impl block.
> >> > 
> >> > It seems you used `&mut self` for all the functions, which looks like
> >> > more design work is required here.
> >> 
> >> Ah, I can drop all the mut here.
> > 
> > It may not be that easy... IIUC, most of the functions in the `impl`
> > block can only be called correctly with phydev->lock held. In other
> > words, their usage requires exclusive accesses. We should somehow
> > express this in the type system, otherwise someone may lose track on
> > this requirement in the future (for example, calling any function
> > without the lock held).
> >
> > A simple type trick comes to me is that
> > 
> > impl Device {
> >     // rename `from_raw` into `assume_locked`
> >     pub unsafe fn assume_locked<'a>(ptr: *mut bindings::phy_device) -> &'a LockedDevice {
> > 	...
> >     }
> > }
> 
> Hmm, the concept of PHYLIB is that a driver never play with a
> lock. From the perspective of PHYLIB, this abstraction is a PHY
> driver. The abstraction should not touch the lock.
> 

Well, usually we want to describe such a constrait/requirement in the
type system, that's part of the Rust bindings, of course, for some
properties it may be hard, so it may be impossible.

> How can someone lose track on this requirement? The abstraction
> creates a Device instance only inside the callbacks.
> 

Right now, yes. The code in the patch only "creates" a Device inside
the callbacks, but the `Device::from_raw` function doesn't mention any
of this requirement, if the design is only called inside the callbacks,
please add something in the function's `# Safety` requirement, since
voliating this may cause memory safety issue.

Type system and unsafe comments are contracts, if one API has a limited
usage by design, people should be able to find it somewhere in the
contracts.

Regards,
Boqun

