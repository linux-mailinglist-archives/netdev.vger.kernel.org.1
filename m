Return-Path: <netdev+bounces-43768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EB07D4ACD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A441C20AE3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543D134BD;
	Tue, 24 Oct 2023 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLNyr0IM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6410969;
	Tue, 24 Oct 2023 08:48:28 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A9F120;
	Tue, 24 Oct 2023 01:48:27 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7ad24b3aaso43753977b3.2;
        Tue, 24 Oct 2023 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698137306; x=1698742106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GOGtyCurxdqhUDkc/2ztUItYkUDrH0lly0fN9/AIkE=;
        b=YLNyr0IMMKcFeyjzOIUshbFeRYwY902rxjgt7TKlth5pt1zS1fO8+ysBdGn5LHlCjm
         BQ8fEaj93Ao/Xirc1UaPBZNIjMRZaXZxYLqaLvEBCW+Nc+WAxaozJ47n7Brdvd4gU8+m
         Bh/ukzZ50h9QD+ElW1zPqMxU+Co4OF/JO2nexXvFODwj+4kS8n/cc1GKVEnLDb7nZBlF
         RT0HXxDPFjQzBmP7jg5mHh2X0rjcIuYZuhA+9qujPUKZ9Zin9Zdp5eSUZFx3CghBIhIu
         2e0PN4QJmOKi2vEEJn9GM069+g/ApSwdZh6/fMHwuv6H+t4sbYHb7KiNUqjy5GFtx7y6
         GddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137306; x=1698742106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GOGtyCurxdqhUDkc/2ztUItYkUDrH0lly0fN9/AIkE=;
        b=WeHnr/FuHkm7+zrbt5jlAil4MvH+GA5vwTRVQtX3l6YEe/cB9Xo/TWsrQzG7NsIR+m
         1mvxdWCEvjOxF1eAct/W+wBAi5XDtIJ7v7c6wxLcLBIjOKZLwSdEzv7LHndo0xyuTBls
         Wswpr599eFQmWLznJl4Ppj7ZVzUgEt52HlkJZIELu0/ZsrvhdvUCca8l96/NNicohxMN
         bNeO/3XOMoEvhM1kZbASaoIM1sj6hdEVc1Iv3hS7Jh/R1VCm3CGuuLgtcn7UMCrPCuGm
         8AmWojDX2h1+wgK2r/oxZIrhyFqKgJN3MS3Xnl3wEp1BETYsM1Iy4SnL/6pT9wMNWicS
         hHBw==
X-Gm-Message-State: AOJu0YzgoYrxBuVxldMovMDkOcPc+7cEYQjqs6JlojbWRMRiQSu6UL7t
	Uqjw6fKn8qphQ5L/7Plweesn7rDM+0vLeHVCkxk=
X-Google-Smtp-Source: AGHT+IFjeDO/GVsokzPqU9MghWmCcagptc2RLP+Lr/TRgbQ8v8fxezcUyB/Z/oOqtbzFoB07AAsO3n0rSTsYlAqkOG0=
X-Received: by 2002:a25:aaa9:0:b0:d9a:c61e:4466 with SMTP id
 t38-20020a25aaa9000000b00d9ac61e4466mr11583153ybi.61.1698137306349; Tue, 24
 Oct 2023 01:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
 <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch> <CANiq72nOCv-TfE3ODgVyQoOxNc80BtH+5cV2XFBFZ=ztTgVhaw@mail.gmail.com>
 <20231022.184702.1777825182430453165.fujita.tomonori@gmail.com>
 <CANiq72mDWJDb9Fhd4CHt8YKapdWaOrqhJMOrQZ9CDRtvNdrGqA@mail.gmail.com> <798666eb-713b-445d-b9f0-72b6bbf957ff@lunn.ch>
In-Reply-To: <798666eb-713b-445d-b9f0-72b6bbf957ff@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Oct 2023 10:48:14 +0200
Message-ID: <CANiq72=mBGvLYWaX4knG3DxVkaxCJ_d3382KxMhVgn7xFiGrjg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, benno.lossin@proton.me, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 5:34=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Oct 22, 2023 at 01:37:33PM +0200, Miguel Ojeda wrote:
> >
> > Instead, the documentation should answer the question "What is this?".
> > And the answer should be something like "The state of the PHY ......"
>
> Its the state of the state machine, not the state of the PHY. It is

I didn't say it was the state of the PHY -- please note the dots above.

> already documented in kernel doc, so we don't really want to duplicate
> it. So maybe just cross reference to the kdoc:
>
> https://docs.kernel.org/networking/kapi.html#c.phy_state

Yes, that can be worth it for simple 1:1 cases like the `enum`
(assuming they are properly documented in the C side), but we still
want a suitable short description (e.g. "PHY state machine states"),
like Tomonori did in the version he just sent (v6).

I wondered about the docs of each variant, too, but those should be OK
too, because `rustdoc` does not create an individual page for them, so
one can always see the link to the C docs at the top from the `enum`
description.

> > Yes, documenting that something wraps/relies on/maps a particular C
> > functionality is something we do for clarity and practicality (we also
> > link the related C headers). This is, I assume, the kind of clarity
> > Andrew was asking for, i.e. to be practical and let the user know what
> > they are dealing with on the C side, especially early on.
>
> I don't think 'early on' is relevant. In the kernel, you pretty much
> always need the bigger picture, how a pieces of the puzzle fits in
> with what is above it and what is below it. Sometimes you need to
> extend what is above and below. Or a reviewer will tell you to move
> code into the core, so others can share it, etc.

"Early on" in my reply is referring to what you said earlier, i.e.
that initially abstractions are minimal.

In any case, yes, using complex systems typically requires knowing a
bit of what is going on in different parts, but that does not mean we
cannot make self-contained documentation as much as reasonably
possible. We want that using a particular Rust abstraction does not
require reading its source code or the code in the C side.

In the example that you mention, if the reviewer wants to share code,
then it should be extracted into a new Rust abstraction (and possibly
the C core depending on what it is, of course) and using it from the
driver, but also documenting the Rust abstraction.

Cheers,
Miguel

