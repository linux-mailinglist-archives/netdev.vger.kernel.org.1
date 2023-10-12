Return-Path: <netdev+bounces-40235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB877C65A9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DA828275E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28572B771;
	Thu, 12 Oct 2023 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QobPIjka"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E796D526;
	Thu, 12 Oct 2023 06:34:25 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD22A9;
	Wed, 11 Oct 2023 23:34:23 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77574c5979fso38934185a.3;
        Wed, 11 Oct 2023 23:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697092462; x=1697697262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnPej9WTSmU/9E4yllQBRLW8QKhVLr43fnZz3gaaSWQ=;
        b=QobPIjka8cbxGzUgixJIB9UrjcwU3AQIxT3paa7GbxuanRdG93Ev1yvE6p0r79ERU4
         A645mtrY+VqqyyF0PbeFA2Vpt0d0J2IEAVZiv34WG6ROwo+uY+ESi1WT1JAO4Zb3zbuO
         MKwK6AOAsoCFYhJuyPhMRQ2pPEkdxJqREJGY5KhD17TCT+jQbatVrOStOVk5TuD7HBaE
         qWiGMR/jS6qTJ+JmoUs+ikSmuxlNlVgtrgkcyvfX/76dekl50+Zu6+pV3+pbeNJ4S+T7
         +qJWoMmqqDJA397uOngRm/HbiQouKdvJFSn8oBoCJySY3Kdgp9K4PAYAO2ALFmksbg9U
         ka7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092462; x=1697697262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnPej9WTSmU/9E4yllQBRLW8QKhVLr43fnZz3gaaSWQ=;
        b=CPQ2mh7Ifu8yodk7DL5/6l4zrfB8MMRJQTQ8fNtk50IgN8nN2EcYEg7vzJCYWr+vqo
         67qjaE/OQ7pbl0GZ5OKqtRSHqiMpXl5/WajNa9o+wwK1WHkMQj8iPumixIm6/bRLUIL4
         81fXUn4rSV66A1S8LtRqOPtvevkMaf0rpza6BGiDjCCzmBmsvhTYse/fQ6yKL3EKE/qt
         qvM/LLTumSvXWGCzOu+QtKoWOG/dmEAE3okx/e2furm0u5u4vQwjhaGBYssFYp4hSL+n
         XLKDChtiiCd/53vf7OuMLx+uxDGYVevCfROd6VVXqmKqsg3PhVqrZWzRT5fDE8xsi7ym
         QMOQ==
X-Gm-Message-State: AOJu0YzUwXRK+pCs4gs3LY9xSgYilsaNuu0CTz7PaxYm/Mp9T40IGdNI
	q+0Ol0VNmumdA3E+lmMhUyCe+mce4jU=
X-Google-Smtp-Source: AGHT+IFqlalCbLgRQQs7ylG6MSioQ9L+vQgEmjA3vJk/vtzbUX/t7At+JvmTLoZzt7V28FqGvvQrsQ==
X-Received: by 2002:a0c:d985:0:b0:66d:476:8940 with SMTP id y5-20020a0cd985000000b0066d04768940mr4348428qvj.46.1697092462204;
        Wed, 11 Oct 2023 23:34:22 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p13-20020ae9f30d000000b007756c8ce8f5sm5754262qkg.59.2023.10.11.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:34:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4B1AF27C0054;
	Thu, 12 Oct 2023 02:34:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 02:34:21 -0400
X-ME-Sender: <xms:bJMnZTt4FJnQoNQX13vcigpFXITcUuIkvHuCGTZzhVh8KpA1jFoEDw>
    <xme:bJMnZUdPFtpNt9Ey7hS595SydIFZRWY1dji-y27DMmXUS3CbGiwWNgSTr_2wELYf3
    dMTq7NPJAnldwjoCA>
X-ME-Received: <xmr:bJMnZWzjjYUWgjDPI-A25znZUu8cBGU0VFsb2bYBYUyogiUjT_gn_K8F0H0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheelgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bJMnZSNJMOwitLyrzLsDHjgIscVTFWkwE77ROhdg_PcAsP0JIbJPDg>
    <xmx:bJMnZT9azPR4T7IBTMcOBdEdbvp3w0m--LaMkhszayT1fePTw16NQw>
    <xmx:bJMnZSWjESneOws2-w7aOBXv5ECza1BbPUomLhD22msStPH2LXpTOw>
    <xmx:bZMnZTxiTE01mYTJQs7IlsYRkogcTYxTg_uzRjVck7hP35Oghse8uA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 02:34:20 -0400 (EDT)
Date: Wed, 11 Oct 2023 23:34:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <ZSeTag6jukYw-NGv@boqun-archlinux>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com>
 <ZSbpmdO2myMezHp6@boqun-archlinux>
 <20231012.145824.2016833275288545767.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012.145824.2016833275288545767.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 02:58:24PM +0900, FUJITA Tomonori wrote:
> On Wed, 11 Oct 2023 11:29:45 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Mon, Oct 09, 2023 at 10:39:10AM +0900, FUJITA Tomonori wrote:
> > [...]
> >> +impl Device {
> >> +    /// Creates a new [`Device`] instance from a raw pointer.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
> >> +    /// may read or write to the `phy_device` object.
> >> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
> >> +        unsafe { &mut *ptr.cast() }
> >> +    }
> >> +
> >> +    /// Gets the id of the PHY.
> >> +    pub fn phy_id(&mut self) -> u32 {
> > 
> > This function doesn't modify the `self`, why does this need to be a
> > `&mut self` function? Ditto for a few functions in this impl block.
> > 
> > It seems you used `&mut self` for all the functions, which looks like
> > more design work is required here.
> 
> Ah, I can drop all the mut here.

It may not be that easy... IIUC, most of the functions in the `impl`
block can only be called correctly with phydev->lock held. In other
words, their usage requires exclusive accesses. We should somehow
express this in the type system, otherwise someone may lose track on
this requirement in the future (for example, calling any function
without the lock held).

A simple type trick comes to me is that

impl Device {
    // rename `from_raw` into `assume_locked`
    pub unsafe fn assume_locked<'a>(ptr: *mut bindings::phy_device) -> &'a LockedDevice {
	...
    }
}

/// LockedDevice is just a new type of Device
pub struct LockedDevice(Device);

impl LockedDevice {
    pub fn phy_id(&self) -> u32 {
        ...
    }
}

Others may have better idea.

Fundamentally, having a mutable method which doesn't modify the object
makes little sense, however we does need a way (other than the `&mut
self`) to express the need of exclusive here..

Regards,
Boqun

> 

