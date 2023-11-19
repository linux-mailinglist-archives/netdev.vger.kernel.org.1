Return-Path: <netdev+bounces-49002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BC7F0592
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 12:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3881280D53
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6551C3B;
	Sun, 19 Nov 2023 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Z21brXlv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E4CC6
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 03:06:36 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7b3d33663so39099907b3.3
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 03:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1700391995; x=1700996795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lC35LlGRba1t1btXoCyTf6ZENkuDHIsafoyDM0W8s8=;
        b=Z21brXlvAV3lh2J4HOustIYoXcslA/3MAnnJe8oNDynWXVZYK/f6HNTV7LBFMYFUb/
         Vz0xFIiyVrgQMSsRUt7CwLfjc9syR5LTDfbgWn3Lg6W/MgoMzZCYizZU4/ZYyEVhxTQj
         s3rp/EJCfK1R80kUaGTEUph1nZmsv7TefY/cb2WVT0BH/STBlxj00ejp+eOqlaY0/dKA
         W2eL4zn9saDyqEuJjjnl3iDPkUr3l8PUt9DnZ18/8Ou2/EywgET9FVpS+86flfdCxTsd
         jy6mu4BLa4cY7eYfeUNe+bt23RB4bnkgTb9FISf6yl4CV4/5/gAsHl1KP0iXc9zbgEbY
         5rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391995; x=1700996795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lC35LlGRba1t1btXoCyTf6ZENkuDHIsafoyDM0W8s8=;
        b=o2y3nZ+A1hUzLQ+sf3mw52sNSId3v6ulaO3cUphWc83I5pkVLil4vvh0eNayARe3E2
         ze6jnaVR8Dv7W5bw+rVShEv5xQJmcEiSE9x2znzN5qwGCiWRPPaIQ0KW9zhOeqDGUmKx
         eALAJfpqtLeoqSuFJ3kjPu/jZOfI305QhwVxtIg1IbxVUoKNiBWcbXSucXJ6xuidkxx4
         hqgtQ4dzl6rYThwT4BmaxWMN4Gqnd/gynZY8qwQL4UfHPq1WDpu2TyvFzPxYu4Jjp09g
         HI41CqvRwZKWQsdOWqinBXImfgt9eYPVPzVr0vdAVUNiW/GBKB3mIudZ/vukZHRcLAKQ
         bkAA==
X-Gm-Message-State: AOJu0YyZ7y9NNBu3kMY4uSvrIOAL/tX+LQWNHg3d/YOSi6IFPC5e6UIm
	wFvuUQ+sEPGoZp8xJ5NlIOiExJXMb8FFJXgMjDL/UpuzsFrcnBGroF4=
X-Google-Smtp-Source: AGHT+IH7Ex4dzK4QRBl1LU/4u0gminffm9iHvNZFZsoAKsez6q3T1ZkOcxtJ22VoqJz+4q6ceVpAPFuJv12Z2xYooa0=
X-Received: by 2002:a0d:f284:0:b0:59b:de0f:c23b with SMTP id
 b126-20020a0df284000000b0059bde0fc23bmr4611830ywf.46.1700391995387; Sun, 19
 Nov 2023 03:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093906.2514808-1-aliceryhl@google.com> <b69b2ac0-752b-42ea-a729-9efdee503602@lunn.ch>
 <2023111709-amiable-everybody-befb@gregkh> <ZVf3LvoZ7npy3WxI@boqun-archlinux>
 <e7d0226a-9a38-4ce9-a9b5-7bb80a19bff6@lunn.ch> <ZVjePqyic7pvcb24@Boquns-Mac-mini.home>
In-Reply-To: <ZVjePqyic7pvcb24@Boquns-Mac-mini.home>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 19 Nov 2023 05:06:23 -0600
Message-ID: <CALNs47tt94DBPvz47rssBTZ86jbHwaa7XaNnT3UbdxwY6nLg1g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
To: Boqun Feng <boqun.feng@gmail.com>, fujita.tomonori@gmail.com
Cc: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>, 
	Alice Ryhl <aliceryhl@google.com>, benno.lossin@proton.me, 
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 9:54=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
> In Rust doc [1], `Send` means:
>
>         Types that can be transferred across thread boundaries.
>
> but of course, we have more "thread-like" things in kernel, so I think
> "execution context" may be a better term?

The docs are pretty OS-focused here (I intend to update them at some point)=
.

`Sync` means that if you have a >1 pointer/reference to a struct you
can access any of the fields, as allowed by the API, from any of the
references at any time (i.e. switching between any two instructions)
without causing data races. Atomic accesses or mutexes can add this
property to things that do not have it. It really doesn't matter
whether you're going between different user threads, kthreads,
interrupt/preemption contexts, or nothing at all. It's a bit more
intrinsic to the data type and it says how you _could_ use it rather
than how you do use it.

And then `Send` basically means that any pointers in your struct are
either exclusive or point to `Sync` things. Mutexes cannot add this
property to anything that does not have it.

Note that this still never lets you have more than one `&mut`
(`restrict`) reference to a piece of data at once, this mostly relates
to interior mutability (when things are allowed to be changed behind
shared `&` references - such as atomics).

The consumers of these markers are (1) the compiler knowing what can
live in statics, (2) APIs that make things potentially concurrent, and
(3) the compiler automatically marking new structs `Send`/`Sync` if
all member types follow these rules.

When trying to figure this out for C types, the question is just
whether usage of the type follows those rules. Or at least whether it
follows them whenever Rust has access to it.

---

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> +pub struct Registration {
> +    drivers: Pin<&'static mut [DriverVTable]>,
> +}
>
> [...]
>
> +// SAFETY: `Registration` does not expose any of its state across thread=
s.
> +unsafe impl Send for Registration {}
>
> +// SAFETY: `Registration` does not expose any of its state across thread=
s.
> +unsafe impl Sync for Registration {}

I don't think the impl here actually makes sense. `Registration` is a
buffer of references to `DriverVTable`. That type isn't marked Sync so
by the above rules, its references should not be either.

Tomo, does this need to be Sync at all? Probably easiest to drop the
impls if not, otherwise I think it is more correct to move them to
`DriverVTable`.  You may have had this before, I'm not sure if
discussion made you change it at some point...

---

> [1]: https://doc.rust-lang.org/core/marker/trait.Send.html
>
> Regards,
> Boqun

Sorry Boqun, the lengthy explanation is just for context and not aimed
at you in particular :)

- Trevor

