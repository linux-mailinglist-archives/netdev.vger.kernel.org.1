Return-Path: <netdev+bounces-41987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36457CC881
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E337B281B4E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E1947345;
	Tue, 17 Oct 2023 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPi/yX8p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B4450DE;
	Tue, 17 Oct 2023 16:13:52 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7B9E;
	Tue, 17 Oct 2023 09:13:50 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d093265dfso37804916d6.3;
        Tue, 17 Oct 2023 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559230; x=1698164030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWcdweTaVrboA/LpHqjRF0HvWvzRo8U19JEiXoOPdT0=;
        b=VPi/yX8piJlgn/Phtq1FY0uEFx6b84B6r9OARGcI1R2W6P2KbjVY75TD13XZCTjBPO
         kZ7B3q5uJaHFTGfKUbYG1prZ463JnrB90eKK5+go0LcevB6VpYjxXpi/3bJAr1Av/DkW
         sdB/sQLN1qE5af+NjYMKG63nSU9Xk48T8XND3H5quXfL5H5lN9T9NpUfkE3ugYHkhjib
         URQlKDzOME7Dkw1cVYJc16+z9J0lXwWeVlM3t6iiHOxCvvuWxQXtegghT//PZGQ9LfEf
         dzyqi8pC+PFhxLxX/p3UnMMhL1Q8YYJuAcm4vmuEYuyjf5weCVYMJp1mvD9r71X1BkWg
         yX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559230; x=1698164030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWcdweTaVrboA/LpHqjRF0HvWvzRo8U19JEiXoOPdT0=;
        b=dWBb3HalaCI4GAqdr7rrxUyE5hihM/ZwPOsHfpfp9FZvFhkUS1UtEroW++Qmk5yElh
         gDG9ld9NO2kk0choMVgJE6jBbcQQFxX74h0j3ACMqZ77pLJZqRm1oukXzrC+tMpTEiTo
         o6ornYMhRZG6vz6hYK9eFfaRFHMUC8wDY4P8I8Dbr5jtnTPlcF7/P5lvtekKeLdlGIYv
         we5QBTLBaV5VwTTP8tXNeQz6N7peOQ154WR5omTZwE2EitN9wpZXnc+F7OzPEi7/cb/D
         MqvYmBGSc6XjfVdeyeyBHsAfxEBtBpNTxr167Wo2X5PZE0JxCSSsHaEVW1JaXTCGnE98
         j8Vw==
X-Gm-Message-State: AOJu0Ywqu+gN73LWi9HmrgqVPyZ00Po7Rrbih/CnWzrZdXecJrlRmLph
	r2oy3nqyq9R+I04JpTPfbnc=
X-Google-Smtp-Source: AGHT+IHA1jl/Hk9zfrS2Vz08vJq4KgtQ8Zb7uX1uG8UYVE3sb/9j+kn4/Ak1XVQxyelUDKJmdOz/WQ==
X-Received: by 2002:a05:6214:224d:b0:66d:5b9:9276 with SMTP id c13-20020a056214224d00b0066d05b99276mr4024120qvc.25.1697559229892;
        Tue, 17 Oct 2023 09:13:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a2-20020ac81082000000b003f6ac526568sm725592qtj.39.2023.10.17.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:13:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0AB8A27C005A;
	Tue, 17 Oct 2023 12:13:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 17 Oct 2023 12:13:49 -0400
X-ME-Sender: <xms:vLIuZQOtor8dgqZsF7-WM44XXOrkz9IWEyCtBNhoL_kyx4fK2wYmVw>
    <xme:vLIuZW94biCFB2fUmWC0sa44hz9JxP7QFxLtG1fXCWkL9ajDxESh6HVTcrYFL8-qq
    S1TxXwK00XDpaP_EQ>
X-ME-Received: <xmr:vLIuZXRZ8U7tMii63iuQe2vv78miqzTRbiUg4MHEK7I89YYKtTIvdXYOvPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vLIuZYu69MbUQErxA8L7w1oEhKxic6BJziFw7cdtWgClX-NF4B30RQ>
    <xmx:vLIuZYcTNFSubvYgw9G6J6zuarA4EYvlpZ4IWpkp0iUJODncSQ10ZA>
    <xmx:vLIuZc02Ejc_JBf9cTtiXtqe-P-ZikPLVm1lczqyb5d3OY7fkqTXLw>
    <xmx:vbIuZfyGOS5bPwbJgTU-pgawZoluepqL-bndR2K28AOKf7dFacqlzQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 12:13:48 -0400 (EDT)
Date: Tue, 17 Oct 2023 09:13:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZS6yuhrr4UveXF_x@Boquns-Mac-mini.home>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
 <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
 <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
 <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
 <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
 <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
 <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me>
 <2023101756-procedure-uninvited-f6c9@gregkh>
 <0f839f73-400f-47d5-9708-0fa40ed0d4e9@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f839f73-400f-47d5-9708-0fa40ed0d4e9@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 02:32:07PM +0000, Benno Lossin wrote:
> On 17.10.23 16:21, Greg KH wrote:
> > On Tue, Oct 17, 2023 at 02:04:33PM +0000, Benno Lossin wrote:
> >> On 17.10.23 14:38, Andrew Lunn wrote:
> >>>>> Because set_speed() updates the member in phy_device and read()
> >>>>> updates the object that phy_device points to?
> >>>>
> >>>> `set_speed` is entirely implemented on the Rust side and is not protected
> >>>> by a lock.
> >>>
> >>> With the current driver, all entry points into the driver are called
> >>> from the phylib core, and the core guarantees that the lock is
> >>> taken. So it should not matter if its entirely implemented in the Rust
> >>> side, somewhere up the call stack, the lock was taken.
> >>
> >> Sure that might be the case, I am trying to guard against this future
> >> problem:
> >>
> >>       fn soft_reset(driver: &mut Driver) -> Result {
> >>           let driver = driver
> >>           thread::scope(|s| {
> >>               let thread_a = s.spawn(|| {
> >>                   for _ in 0..100_000_000 {
> >>                       driver.set_speed(10);
> >>                   }
> >>               });
> >>               let thread_b = s.spawn(|| {
> >>                   for _ in 0..100_000_000 {
> >>                       driver.set_speed(10);
> >>                   }
> >>               });
> >>               thread_a.join();
> >>               thread_b.join();
> >>           });
> >>           Ok(())
> >>       }
> >>
> >> This code spawns two new threads both of which can call `set_speed`,
> >> since it takes `&self`. But this leads to a data race, since those
> >> accesses are not serialized. I know that this is a very contrived
> >> example, but you never when this will become reality, so we should
> >> do the right thing now and just use `&mut self`, since that is exactly
> >> what it is for.
> > 
> > Kernel code is written for the use cases today, don't worry about
> > tomorrow, you can fix the issue tomorrow if you change something that
> > requires it.
> 
> The kind of coding style that (mis)-uses interior mutability is not
> something that we can change over night. We should do it properly to
> begin with.
> 

Agreed!

Sure, the bottom line is that kernel today works, but that's the bottom
line, right? In other words, nothing prevents us from a more reasonable
API with some future guards (we are not rush for anything). In fact, the
ponit of Rust is when you do abstraction on anything you should be clear
about the semantics (exclusive accesses, lock rules, etc.), so that such
semantics can be encoded in the type system (or unsafe requirement),
this is the bottom line of using Rust. Of course, there could be cases
where Rust cannot describe correctly (or easily) with the type system,
since kernel is a complicated beast. In that case, we can either 1) tell
Rust to improve or 2) make a sane work-around and move on. But no excuse
for not trying hard today if you're using Rust: if you don't have a
clear mind about the abstraction you're writting or cannot describe
it clearly, then you probably have bad Rust code, and bad Rust code same
as bad C code is what we try to avoid in kernel.

Also, for countless times, I heard people (usually maintainers) complain
someone about "no you use this (API) in a wrong way", "not future-proof"
seems to be a root of problems ;-) and having some sort of future guards
benefits everything.

> > And what "race" are you getting here?  You don't have threads in the
> > kernel :)
> 
> I chose threads, since I am a lot more familiar with that, but the
> kernel also has workqueues which execute stuff concurrently (if I
> remember correctly). We also have patches for bindings for the workqueue
> so they are not that far away.
> 
> > Also, if two things are setting the speed, wonderful, you get some sort
> > of value eventually, you have much bigger problems in your code as you
> > shouldn't have been doing that in the first place.
> 
> This is not allowed in Rust, it is UB and will lead to bad things.
> 
> >> Not that we do not even have a way to create threads on the Rust side
> >> at the moment.
> > 
> > Which is a good thing :)
> > 
> >> But we should already be thinking about any possible code pattern.
> > 
> > Again, no, deal with what we have today, kernel code is NOT
> > future-proof, that's not how we write this stuff.
> 
> While I made my argument for future proofing, I think that we
> should just be using the standard Rust stuff where it applies.
> 
> When you want to modify something, use `&mut T`, if not then use
> `&T`. Only deviate from this if you have a good argument.
> 

Right, so if the rule for C code is 1) working for the current users +
2) subsystem requirement, then for Rust code, there is simply an extra
rule: Be clear about the concept model of the API, and use Rust
abstraction correctly (mostly it's API soundness). Again, if you find
Rust doesn't work for your stuff, we are open to discuss, quite frankly
we know there could exist such a problem and are interesting to learn
from it (or throw it to Rust language community ;-)), but ignoring Rust
rules is not a good start.

Anyway, I just saw Tomo's v5, thanks!

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 

