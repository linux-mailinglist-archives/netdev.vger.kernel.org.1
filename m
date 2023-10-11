Return-Path: <netdev+bounces-39947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A087C4F79
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B4C2821B7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320121DA26;
	Wed, 11 Oct 2023 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMV/ZQYl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D631A282;
	Wed, 11 Oct 2023 09:59:15 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FB92;
	Wed, 11 Oct 2023 02:59:13 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7cc03dee5so16440287b3.3;
        Wed, 11 Oct 2023 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697018352; x=1697623152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQbR9HXqUaZOVx7zCKLA9nx63LMEdkWSVsLjTwzrtdA=;
        b=IMV/ZQYlyVHJ8m3+vY4bs5OJh05Q3WHzXH8GnjE4nqmg5O84FwlSJRs5exI50n8umt
         5JgFIODh8iY9uG7oXbECMCKXphVYBdn4wTdW7kCAxOkftvAEpizp+YZ5AoDH71AV0vXs
         JW5j8BYwrIHYTV4zQKzlK5IfpUziC0xupVcj2XZ8tsKLb1sI9KzNT7lFiYwddRHpBpmY
         qckKv+k1kyg3fD8HP/tbRz/sDTolPnEEHSxIYjbIH1ZI9XCyojl/+dFcv13BSSqZKwfn
         nAxgzJd6+aQIa7bi/a4c41Ntk/NllumDtiZUuqwL/Gi2J0JlbXVd/f+4/x55vzI9HjoG
         8gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697018352; x=1697623152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQbR9HXqUaZOVx7zCKLA9nx63LMEdkWSVsLjTwzrtdA=;
        b=d8nOmLxS6RO3VFeeLW9KFr6kuufZZE9RiTvx/ynKid3scA59bk5aW1JMRZCnkdlspJ
         9/ZrTZMS9gkO2oIvCwVcMYVbhsiPeoRp9KT41bqjoDPNgIK3q+l5QhmC0LmTP2zD9W3u
         w1Lh31Dv+YrOFZL7FVvkbiFeX0WNfQNReHZKMyq0FeqCXXp5u2wG7EnregwY5Y0udNs2
         ImerWbhM5PLXod03t5d/FS9HRScHJ6XsiEPkXe3FXp4kwE2Oczttf6pP+GRdyIFQPFjT
         +sXCJy/gtfsTzqTHZ6Ubc6OpTDFh7Zb/AOsDFWsTgdKoH9ICVpb3dH2UHKxyfdRKPDFh
         u1Pg==
X-Gm-Message-State: AOJu0YxmAn/lP8iMFA49stAP2MlZNKUsyL8DTfiKWRBnk5gF/VO7hOm4
	EA2OPJIy2qjtpAjT1bztkfIwOx2t0ZNFOyHKc+eMjIMxp9sqKA==
X-Google-Smtp-Source: AGHT+IGdDQuCI6khk5rHYAY341aaAXtpLAGhxNDMmjVcNaGP4zMMbcOngMmWilsCHH7dycnCrElh+t4blzBDnjiNgk0=
X-Received: by 2002:a0d:d782:0:b0:59f:4e6d:b56b with SMTP id
 z124-20020a0dd782000000b0059f4e6db56bmr22124806ywd.5.1697018352671; Wed, 11
 Oct 2023 02:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023100926-ambulance-mammal-8354@gregkh> <20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
 <CANiq72nj_04U82Kb4DfMx72NPgHzDCd-xbosc83xgF19nCqSfQ@mail.gmail.com> <20231010.005008.2269883065591704918.fujita.tomonori@gmail.com>
In-Reply-To: <20231010.005008.2269883065591704918.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Oct 2023 11:59:01 +0200
Message-ID: <CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:50=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> What feedback? enum stuff? I think that it's a long-term issue.

Not just that. There has been other feedback, and since this message,
we got new reviews too.

But, yes, the `--rustified-enum` is one of those. I am still
uncomfortable with it. It is not a huge deal for a while, and things
will work, and the risk of UB is low. But why do we want to risk it?
The point of using Rust is precisely to avoid this sort of thing.

Why cannot we use one of the alternatives? If we really want to catch,
right now, the "addition of new variant in the C enum" case, cannot we
add a temporary check for that? e.g. it occurs to me we could make
`bindgen` generate the `--rustified-enum` into a temporary file and
compile a fixed `match` somewhere or something like that, for the
purposes of checking. That way we avoid the UB in the actual code.

But the best would be to work on adding to `bindgen` something like
the `--safe-rustified-enum` I suggested (because we already know the
maintainers find the idea reasonable -- thanks Trevor for creating the
issue!), even if only to validate the idea with a prototype.

In short, what is the rush?

> I'm not sure about it. For example, we reviewed the locking issue
> three times. It can't be reviewed only on Rust side. It's mainly about
> how the C side works.

We have never said it has to be reviewed only on the Rust side. In
fact, our instructions for contributing explain very clearly the
opposite:

    https://rust-for-linux.com/contributing#the-rust-subsystem

The instructions also say that the code must be warning-free and so
on, and yet after several iterations and pushing for merging several
times, there are still "surface-level" things like missing `// SAFETY`
comments and `bindings::` in public APIs; which we consider very
important -- we want to get them enforced by the compiler in the
future.

Not only that, when I saw Wedson mentioning yesterday the
`#[must_use]` bit, I wondered how this was even not being noticed by
the compiler.

So I just took the v3 patches and compiled them and, indeed, Clippy gives y=
ou:

    error: this function has an empty `#[must_use]` attribute, but
returns a type already marked as `#[must_use]`
    --> rust/kernel/net/phy.rs:547:5
        |
    547 | /     pub fn register(
    548 | |         module: &'static crate::ThisModule,
    549 | |         drivers: &'static [Opaque<bindings::phy_driver>],
    550 | |     ) -> Result<Self> {
        | |_____________________^
        |
        =3D help: either add some descriptive text or remove the attribute
        =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#double_must_use
        =3D note: `-D clippy::double-must-use` implied by `-D clippy::style=
`

    error: length comparison to zero
    --> rust/kernel/net/phy.rs:551:12
        |
    551 |         if drivers.len() =3D=3D 0 {
        |            ^^^^^^^^^^^^^^^^^^ help: using `is_empty` is
clearer and more explicit: `drivers.is_empty()`
        |
        =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#len_zero
        =3D note: `-D clippy::len-zero` implied by `-D clippy::style`

    error: methods called `as_*` usually take `self` by reference or
`self` by mutable reference
    --> rust/kernel/net/phy.rs:642:21
        |
    642 |     const fn as_int(self) -> u32 {
        |                     ^^^^
        |
        =3D help: consider choosing a less ambiguous name
        =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#wrong_self_conven=
tion
        =3D note: `-D clippy::wrong-self-convention` implied by `-D clippy:=
:style`

And from `rustdoc`:

    error: unresolved link to `module_phy_driver`
    --> rust/kernel/net/phy.rs:408:23
        |
    408 | /// This is used by [`module_phy_driver`] macro to create a
static array of phy_driver`.
        |                       ^^^^^^^^^^^^^^^^^ no item named
`module_phy_driver` in scope
        |
        =3D note: `macro_rules` named `module_phy_driver` exists in this
crate, but it is not in scope at this link's location
        =3D note: `-D rustdoc::broken-intra-doc-links` implied by `-D warni=
ngs`

    error: unresolved link to `PHY_DEVICE_ID`
    --> rust/kernel/net/phy.rs:494:52
        |
    494 |     /// If not implemented, matching is based on [`PHY_DEVICE_ID`=
].
        |
^^^^^^^^^^^^^ no item named `PHY_DEVICE_ID` in scope
        |
        =3D help: to escape `[` and `]` characters, add '\' before them
like `\[` or `\]`

So, no, it is not ready for merge. Yes, those things above are
trivial, but fixing them is also trivial, and after several revisions
it has not been done. And this sort of thing should be done before
even submitting the very first version.

Cheers,
Miguel

