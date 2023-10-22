Return-Path: <netdev+bounces-43284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2423E7D22EF
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DA2815BB
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFCB20E6;
	Sun, 22 Oct 2023 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/3PztOK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407F15B0;
	Sun, 22 Oct 2023 11:37:47 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C77EB;
	Sun, 22 Oct 2023 04:37:46 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a389db3c7so1912226276.1;
        Sun, 22 Oct 2023 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697974665; x=1698579465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpneJp36dT4i16hqbyNdS9co0yw38waSAZJjrgbl2Xs=;
        b=j/3PztOKEP8c9SCwM2/tZbHxvPHliGpjRQu+KR1alI8jCJSgMQUOjORLC1WwblKEDx
         hOVBfKul4FNIJd8FHXmxKdd91V/zwkoiUGePl0+yutWS7b3kR1aIAhqWARh5O5Gb88mG
         ua33tE7T11Te7mgVEnkHC3YhtirD0JhZ1O6oBLG8HHD0uZQF5l2GzIlOpOuocmPBhU25
         LyzxOSxeaKk4ZqP5Mt1haX0+q3Mo9Tb2iaUpkTzqul3a3WGBEctUvoX0oFJFnZnIi57x
         eddL9VboShfW7beoVRFXpUigTw+iFX4t1wm0ShR7gxDa2jYlXOJeTzQpA8IQ/XyFyLkf
         9RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697974665; x=1698579465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpneJp36dT4i16hqbyNdS9co0yw38waSAZJjrgbl2Xs=;
        b=FVXxq1tMJYx/QkxJl3Rr9AVCZoeH/ZKkhgKQvWoD43zjgDHgSOLJ+1wGVz0Ux+HHJn
         13iPNpSTRIiUQzhJCFuTs2xlWjo8HBjgNt4bZbSR9BIB/GAhBgFAwmfgvdLIrIrFHFUz
         skUORI6THa73KDILbCXM+igAfLQpD98J4yoGeSU/9Bs9F+k+xeKTmUzbCJ/wtmVHQwZ3
         LL2pEYv0ngorH9XQGgdNUIjdp2qL/G7cyl326vWfJhIgLDV+IodZK044nX6BOL38Lk9F
         A6iaw25eRWfjxseqxtigEjWbvWHYXShurk4YzW0CDil7HyqMsphbxVlK5Lls2sj6aOiF
         dN9A==
X-Gm-Message-State: AOJu0YyUm0rHeUwfYOK8cDKL+U7vckYSV43s6F/X5Yzza64g2PkrQwdZ
	yuOHp14xaGpTSIkYnwVEu1iDarthqhgyTszdB03+ZwfR0WEW2ZMN
X-Google-Smtp-Source: AGHT+IEfzJRwRQHPNcT3S20/z0CmvS8Ra0Nk4dxw6xrw45+P7EX6ksONGqh+S4N29oyVqXueVA9f9vkyn1PzVue5F1A=
X-Received: by 2002:a05:6902:507:b0:d9a:53cc:e58d with SMTP id
 x7-20020a056902050700b00d9a53cce58dmr7498296ybs.10.1697974665232; Sun, 22 Oct
 2023 04:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
 <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch> <CANiq72nOCv-TfE3ODgVyQoOxNc80BtH+5cV2XFBFZ=ztTgVhaw@mail.gmail.com>
 <20231022.184702.1777825182430453165.fujita.tomonori@gmail.com>
In-Reply-To: <20231022.184702.1777825182430453165.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 22 Oct 2023 13:37:33 +0200
Message-ID: <CANiq72mDWJDb9Fhd4CHt8YKapdWaOrqhJMOrQZ9CDRtvNdrGqA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, benno.lossin@proton.me, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, boqun.feng@gmail.com, 
	wedsonaf@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 11:47=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Agreed that the first three paragraphs at the top of the file are
> implementation comments. Are there any other comments in the file,
> which look implementation comments to you? To me, the rest look the
> docs for Rust API users.

I think some should be improved with that in mind, yeah. For instance,
this one seems good to me:

    /// An instance of a PHY driver.

But this one is not:

    /// Creates the kernel's `phy_driver` instance.

It is especially bad because the first line of the docs is the "short
description" used for lists by `rustdoc`.

For similar reasons, this one is bad (and in this case it is the only line!=
):

    /// Corresponds to the kernel's `enum phy_state`.

That line could be part of the documentation if you think it is
helpful for a reader as a practical note explaining what it is
supposed to map in the C side. But it should really not be the very
first line / short description.

Instead, the documentation should answer the question "What is this?".
And the answer should be something like "The state of the PHY ......"
as the short description. Then ideally a longer explanation of why it
is needed, how it is intended to be used, what this maps to in the C
side (if relevant), anything else that the user may need to know about
it, particular subtleties if any, examples if relevant, etc.

> I'm not sure that a comment on the relationship between C and Rust
> structures like "Wraps the kernel's `struct phy_driver`" is API docs
> but the in-tree files like mutex.rs have the similar so I assume it's
> fine.

Yes, documenting that something wraps/relies on/maps a particular C
functionality is something we do for clarity and practicality (we also
link the related C headers). This is, I assume, the kind of clarity
Andrew was asking for, i.e. to be practical and let the user know what
they are dealing with on the C side, especially early on.

But if some detail is not needed to use the API, then we should avoid
writing it in the documentation. And if it is needed, but it can be
written in a way that does not depend/reference the C side, then it
should be.

For instance, as you can see from the `mutex.rs` you mention, the
short description does not mention the C side -- it does so
afterwards, and then it goes onto explaining why it is needed, how it
is used (with examples), and so on. The fact that it exposes the C
`struct mutex` is there, because it adds value ("oh, ok, so this is
what I would use if I wanted the C mutex"), but that bit (and the
rest) is not really about explaining how `Mutex` is implemented:

    /// A mutual exclusion primitive.
    ///
    /// Exposes the kernel's [`struct mutex`]. When multiple threads
attempt to lock the same mutex,
    /// only one at a time is allowed to progress, the others will
block (sleep) until the mutex is
    /// unlocked, at which point another thread will be allowed to
wake up and make progress.
    ///
    /// Since it may block, [`Mutex`] needs to be used with care in
atomic contexts.
    ///
    /// Instances of [`Mutex`] need a lock class and to be pinned. The
recommended way to create such
    /// instances is with the [`pin_init`](crate::pin_init) and
[`new_mutex`] macros.
    ///
    /// # Examples
    ///
    /// The following example shows how to declare, allocate and
initialise a struct (`Example`) that
    /// contains an inner struct (`Inner`) that is protected by a mutex.

    ...

    /// The following example shows how to use interior mutability to
modify the contents of a struct
    /// protected by a mutex despite only having a shared reference:

    ...

`Mutex`'s docs are, in fact, a good a good example of how to write docs!

> Where the implementation comments are supposed to be placed?
> Documentation/networking?

No, they would be normal `//` comments and they should be as close to
the relevant code as possible -- please see
https://docs.kernel.org/rust/coding-guidelines.html#comments. They can
still be read in the generated docs via the "source" buttons, so they
will be there for those reading the actual implementation in the
browser.

Instead, `Documentation/` is detached from the actual code. For Rust
code, we hope to use only those for out-of-line information that is
not related to any particular API.

For instance, the "coding guidelines" document I just linked. Or
end-user / distributor documentation. Or, as another example, Wedson
at some point considered adding some high-level design documents, and
if those would not fit any particular API or if they are not intended
for users of the API, they could perhaps go into `Doc/`. Or perhaps
Boqun's idea of having a reviewers guide, etc.

Cheers,
Miguel

