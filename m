Return-Path: <netdev+bounces-44796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B2B7D9E16
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716E3282441
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1020338;
	Fri, 27 Oct 2023 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHNtkG08"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C379CC;
	Fri, 27 Oct 2023 16:36:46 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570541AA;
	Fri, 27 Oct 2023 09:36:45 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da077db5145so1541059276.0;
        Fri, 27 Oct 2023 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698424604; x=1699029404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANlltqKVXvV1kClvao9Bs0A1YLzwLRoD3P1Nfh0Ygyk=;
        b=hHNtkG08oU8ZvGC/5u6PLfEFcgrkBLt3wwHNxwxLFuWyK9wQi0f3OqCBlqGt6hG4hS
         Lo5hJNyr8Z1qAFsfzUX9AeT3RYyUkJzmkMlbOlBoaatP2Pa1yp7Kr2Agvp2+35Kw6NJW
         niUAk/LJ2eNs2vkEE5qKi1t7avbEE5li0Xj5IuQeOD7IL4CjpxJVbODN8AOktc5JA8jY
         k60RxA1IybfQur41q79ZGiwcGxiqE4xzW5v93Xpq8ArKNeu17lpkfYSrIQLXZYE1TUa2
         ipXoSXvUO6cn1USylwFqYebJXkraHl2SR6lQArkZqKwOSCy7Eki/W0TIzqQAZPn8gWRs
         T0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698424604; x=1699029404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANlltqKVXvV1kClvao9Bs0A1YLzwLRoD3P1Nfh0Ygyk=;
        b=m1ZXUOoPTKyOCVh7CkhqTY3UPMTnJbaVUleCQ2yOM1m36jn/XLmMcspkXEZuvlexq0
         VdM22xRYxUKEib64MwRJGbv9NRZanmiBh/J2qScuo49B5MErp6bBD1XaN1BmepYwpTHb
         E1bOdX6Wjqxz4IcSGg16lLaVnHQNhmM1ZXKjdQ6wsdYyKoXvIl1T96VfAcyvhZIFNOb/
         JS6VVFiPZAgrL6ZpUgyBckdjSwiRG+4h/OGKEehbPAHSQuci6bptogsWXICuiYSTA8rT
         VkBIfNulIBV/duRU22SyjMxnLA4+hlJOZGrgdGaNtax41etw/GqQVM6/UGSb7jH8D49J
         +6UQ==
X-Gm-Message-State: AOJu0Yy/GHX1yWKDGx+Av/pAvZDZ38gQvWzeXnAvAp7/LS9FoHOEnSLi
	3mD7pFD5aNcUpqBLqGh0dIQQY2AidjWxCPPDQ0I=
X-Google-Smtp-Source: AGHT+IFa1YGKjkUM8STokaz2o05yBCsZG/4asTkJQNtltm//FAXLMZsGG+lQ8R1IbjD4MvV8D4NY4nj1PhgjkE4qAYg=
X-Received: by 2002:a25:744c:0:b0:d92:ce77:b52b with SMTP id
 p73-20020a25744c000000b00d92ce77b52bmr3219845ybc.47.1698424604514; Fri, 27
 Oct 2023 09:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch> <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
 <20231027072621.03df3ec0@kernel.org>
In-Reply-To: <20231027072621.03df3ec0@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Oct 2023 18:36:32 +0200
Message-ID: <CANiq72n=ySX08MMMM6NGL9T5nkaXJXnV2ZsoiXjkwDtfDG11Rw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, benno.lossin@proton.me, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 4:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> To be sure our process is not misunderstood - it's not about impatience
> (=F0=9F=A5=B4=EF=B8=8F) or some rules we made up.  We get slightly over 1=
00 patches a day
> (for us to apply, not subtrees). Longer review cycles would make keeping
> track of patches and discussions unmanageable.

Of course -- that is completely understandable. We are not trying to
change how netdev works. If you have some policies they are probably
the best for your situation.

To be clear, we are not the ones that want to upstream this code. In
fact, we have other items that have higher priority for us. But
Tomonori submitted this, and now we are being told that the Rust
subsystem somehow has to provide reviews within days. We cannot commit
to that, and that is what we told Andrew privately.

In addition, for Rust, we are trying to get the very first
abstractions that get into mainline as reasonably well-designed as we
can (and ideally "sound"), so that they can serve as an example. This
takes time, and typically several iterations.

> Is the expectation that over time you'll be less and less involved
> in particular subsystems? What's the patch volume right now for Rust?

Indeed, the plan is that eventually each subsystem handles Rust like
any other thing. Otherwise, it does not scale.

In fact, the sooner that happens, the better, but we would like to
have some consistency and getting people on the same page around what
is expected from Rust code and abstractions. This also takes time,
because it means typically talking and discussing with people.

For instance, as a trivial example, Andrew raised the maximum length
of a line in one of the last messages. We would like to avoid this
kind of difference between parts of the kernel -- it is the only
chance we will get, and there is really no reason to be inconsistent
(ideally, even automated, where possible).

Now, if netdev is extremely busy, then precisely because of that, it
may be a good idea to take the Rust stuff slowly, so that, by the time
it is in, you can actually handle any patches swiftly without having
to wait on us.

Cheers,
Miguel

