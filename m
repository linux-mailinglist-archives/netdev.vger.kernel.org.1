Return-Path: <netdev+bounces-40999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB57C9538
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61FFB20B24
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C63134CE;
	Sat, 14 Oct 2023 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffdcZ0F8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B312B9E;
	Sat, 14 Oct 2023 15:53:19 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A4EA2;
	Sat, 14 Oct 2023 08:53:18 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77409065623so186886585a.0;
        Sat, 14 Oct 2023 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697298797; x=1697903597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9peboo+D4MfPUpcMfd8wK67q6dlDtGIK+d5KVAHuWPE=;
        b=ffdcZ0F8/h8XV/6Vh/RG/QcDgYZCwfs4wvftgdKYmRCH6NxWV8ITdgcMKTMArK2SlW
         JHMq+CzJbhD0bPC6rMC8VFP1s054OIzi/JCsRXjXGRGt2YXbQzyQjheWyrT6JVVsIUwy
         +ZEUdS0V1XSXhxWtY5XavTROxEFcalFWHoSlTZivhOYcnCaU4hjOqIC02jZxpnuJoPQU
         ezCH8ESXJpbqs5rSS6+JVTQGAm0/hxOOn7iz005NhWtMpIUvm9wYoCKOR7QWADypm9Rp
         Q4xzdI8HVKcmnVy08NE2vs0Wlilk/M7hThnjtUv3wJepwZqiLcsD1I8fTyO1fvIalQeK
         VXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697298797; x=1697903597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9peboo+D4MfPUpcMfd8wK67q6dlDtGIK+d5KVAHuWPE=;
        b=asny9tfTrpjWRhyi8ilzmk3C31KPRqbey95LlnyoaKJLSaE+Fdspa96pSyk1xUWwQR
         Np7+P6ezlzjZrgaznjlhD+dlHqFepUmi1Nw1/FQFShmXZ2OncHgtG8NSK6UtkKLMFCuU
         vS+VlX/fUKwt93va22U4vO7sRue0qlYq/A+labGPbbybG5WXXNMXxHuJk8DL6MRyWmuv
         Ljfzx9J6LzY1QIozzy3Xv6UQ1D74EPZWzlokme0wEsNbP6efpSnQ4C/dOembDiJ4EIfl
         KbY6Z6Tri+BrYvouctvxyO8MNjpXnhsyqQK2VESXVmow6cvShns++9IdhDeMo8Vn0/hB
         O9Kw==
X-Gm-Message-State: AOJu0Yzzirpa606qbGuZj0c+mqc7a3OBuHGXLaA/Ul7jcEBgZ4Z2EyPP
	iqI0K55Zxz+C/qczrg4YKbQ=
X-Google-Smtp-Source: AGHT+IHr3jHgrj4bnxLzioOSeaE5Y0lDcWWx+vmnnPueav9BjesXmcW9Bp7Q3NeDzX4hGp1VRIjofQ==
X-Received: by 2002:a05:620a:cfb:b0:767:8373:a890 with SMTP id c27-20020a05620a0cfb00b007678373a890mr24260477qkj.45.1697298797411;
        Sat, 14 Oct 2023 08:53:17 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ou16-20020a05620a621000b0076f21383b6csm1546972qkn.112.2023.10.14.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 08:53:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 78AC227C0054;
	Sat, 14 Oct 2023 11:53:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 14 Oct 2023 11:53:16 -0400
X-ME-Sender: <xms:bLkqZaxIWxvCtBOjjP_A-1UsyiPVQ2Glhq9Bt6E4pSGZXAYUs98npA>
    <xme:bLkqZWSVrhf7k0GbFTEP-OA725e6Y1LaPumBygeNOF6vUoBXgDOx5oRVEnGBOMiLc
    7kgLYRGanKj8oHmTA>
X-ME-Received: <xmr:bLkqZcXLHVdAzCRmsUHNkRnKwN8mfAHSkxkjWGaBubSgWazXafEbMfhsBmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bLkqZQgtQtHbbkqULVfMXZlPneRQjnKLQcOOn0yD_rxuUBlHwhpyjg>
    <xmx:bLkqZcAgRj1GClOurjTIPy24mS6gVEPcz4zQzaK00nYccSIm4lWpSA>
    <xmx:bLkqZRIOL0qiy7iBnAPh25qjTwyovTYNoNqDxXpL1o7XVGGSwGgr-A>
    <xmx:bLkqZY0vG8d1-SNoEfWsCEhH0aR8gkx1hIHpRfMwJ94w1KTBPPi6Zw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 11:53:15 -0400 (EDT)
Date: Sat, 14 Oct 2023 08:53:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu,
	wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZSq5aY9R66vwcd6k@Boquns-Mac-mini.home>
References: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
 <20231014.162210.522439670437191285.fujita.tomonori@gmail.com>
 <4791a460-09e0-4478-8f38-ae371e37416b@proton.me>
 <20231014.193231.787565106108242584.fujita.tomonori@gmail.com>
 <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 02:54:30PM +0000, Benno Lossin wrote:
[...]
> >>>
> >>> Boqun asked me to drop mut on v3 review and then you ask why on v4?
> >>> Trying to find a way to discourage developpers to write Rust
> >>> abstractions? :)
> >>>
> >>> I would recommend the Rust reviewers to make sure that such would
> >>> not happen. I really appreciate comments but inconsistent reviewing is
> >>> painful.
> >>
> >> I agree with Boqun. Before Boqun's suggestion all functions were
> >> `&mut self`. Now all functions are `&self`. Both are incorrect. A
> >> function that takes `&mut self` can modify the state of `Self`,
> >> but it is weird for it to not modify anything at all. Such a
> >> function also can only be called by a single thread (per instance
> >> of `Self`) at a time. Functions with `&self` cannot modify the
> >> state of `Self`, except of course with interior mutability. If
> >> they do modify state with interior mutability, then they should
> >> have a good reason to do that.
> >>
> >> What I want you to do here is think about which functions should
> >> be `&mut self` and which should be `&self`, since clearly just
> >> one or the other is wrong here.
> > 
> > https://lore.kernel.org/netdev/20231011.231607.1747074555988728415.fujita.tomonori@gmail.com/T/#mb7d219b2e17d3f3e31a0d05697d91eb8205c5c6e
> > 
> > Hmm, I undertood that he suggested all mut.
> 

To be clear, I was only talking about phy_id() at the email thread,

My original reply:

> >>> >> +    pub fn phy_id(&mut self) -> u32 {
> >>> > 
> >>> > This function doesn't modify the `self`, why does this need to be a
> >>> > `&mut self` function? Ditto for a few functions in this impl block.

so Tomo, I wasn't suggesting dropping `mut` for all functions (I used
the words "a few" not "all"), just dropping them accordingly.

Actually this is an excellent example for the fragile of relying on
implicit requirements ;-) The original intent got lost track in a few
email exchanges. 

API soundness is not the sliver bullet, but it at least tries to bring
a common base for handling such problems. Again maybe you now can
understand why we push so hard on "tiny" things again and again.

Also of course Rust is still somehow immature, so if you have an idea
but cannot express in Rust, feel free to call it out, we can work
together to 1) find a temp solution and 2) push Rust to improve. That's
one of the points of the experiment.

Regards,
Boqun

> That remark seems to me to only apply to the return type of
> `assume_locked` in that thread.
> 

