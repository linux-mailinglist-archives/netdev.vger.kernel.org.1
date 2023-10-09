Return-Path: <netdev+bounces-39071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129EA7BDC53
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E3828157E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE3DF59;
	Mon,  9 Oct 2023 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxqNPfbu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32963D5;
	Mon,  9 Oct 2023 12:39:21 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423191;
	Mon,  9 Oct 2023 05:39:20 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f6e6b7600so53073997b3.3;
        Mon, 09 Oct 2023 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696855159; x=1697459959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buviZqx51oNd2Z4jLGI0Fl8Tgqz9IDykJ9/bMw8Cxjw=;
        b=AxqNPfbuJfv3KHAEK4O7rVmNaD1CZtImLhLTS7Y5VSuo8BtizdPu0facKdh3SjKPds
         6QhISEC8gy15GnbhGq2XM20+9vtRyC8HK6zvZr11Jca8q4laUF2koJE8IV+vYLb1P756
         D8bB5UqcRHzK2PZd2Q/yLw8Jo/z20sZGzmk9cWiyWdWNBhzNBLvOAU+Ts1CHBXxk74E0
         xp/UAoLYS6M2Gf5ExJM+taCliBBzfdbbrg/MRAt7GRYrFHc4t4t5T3H2tKkaAOZ346TG
         XLFXsEc66FOTwd/5oD7tuBWX7GS25aUBFe1bd0zaB4t+sXegxg0XBdZ9u9VYysTSNA7A
         PeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855159; x=1697459959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buviZqx51oNd2Z4jLGI0Fl8Tgqz9IDykJ9/bMw8Cxjw=;
        b=osr4MVWePkUJMvi5uFCbpKggLhlF/ZZNXhII3RADlBcsMOqXuPp3ZAYR/NqX8xK6n+
         DDJB9F0J0jwtge78yAU49LjjMQEFTXm76jy3v7fRKA8CRgfw/3/jKx49coLdn71t6bZb
         TWoqENIkFDoqph6mKVDDaK9zIxxOGWjKMfEwGZ/seEWb3Qv3g4Q8yWS0aPqIl8IbaHxk
         S/4752QbBK0oVGLtZf/5zHeJEjfrsU65XlKAw3VM9KkIvHaKxk821kwdu7bg3dowauIl
         eGvFWt9wtACdP+tZPFgGwX9KxA0qtvmevSzGmWUMf4a+joGw5EXnfmQRX0WBZ0K4KTZI
         Z9jw==
X-Gm-Message-State: AOJu0YycDpvN2KXIEAFEbcLRwvaBcvByYskSwfcWABTL324c5+R3lt1e
	AHdeu5nKVH6bWihcgp1SahanTR7VleJujDwVb+iNnxxXN3Da4Uc+
X-Google-Smtp-Source: AGHT+IEp/R7kSAlSo1g86o+7vJfqg9TcZqameH0RM7SwsOTNqLOAs09bjjVlRG0aIgTKaK8WepdEo6mLBsE+QGSt5/c=
X-Received: by 2002:a0d:df95:0:b0:592:60e9:97cf with SMTP id
 i143-20020a0ddf95000000b0059260e997cfmr15569454ywe.12.1696855159408; Mon, 09
 Oct 2023 05:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com> <6aac66e0-9cbd-4a7b-91e6-ea429dbe6831@lunn.ch>
In-Reply-To: <6aac66e0-9cbd-4a7b-91e6-ea429dbe6831@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 14:39:08 +0200
Message-ID: <CANiq72m+hGUyok5ex98rDMWQpoGC+fMn1hxk6ScLUjhBu-G72A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 2:54=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> This is described here, along with other useful hits for working with
> netdev.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Off-topic suggestion: the `.rst` file could be linked as the `P:`
field in `MAINTAINERS`, perhaps with some tweaks.

> I don't know if it made the wrong decision based on the missing tag,
> or it simply does not know what to do with Rust yet.

How does it usually determine the tree otherwise (if the tree is not
in the subject)?

> There is also the question of how we merge this. Does it all come
> through netdev? Do we split the patches, the abstraction merged via
> rust and the rest via netdev? Is the Kconfig sufficient that if a tree
> only contains patches 2 and 3 it does not allow the driver to be
> enabled?

Ideally, everything goes through the subsystem's tree whenever they
feel ready to do so. The idea is that maintainers get involved and
handle their Rust code as any other code. Trees like Kbuild, KUnit and
Workqueue have started taking things, for instance, which is great
(and we appreciate it).

Having said that, I would recommend caution -- I would wait until a
few more people from the Rust subsystem give their `Reviewed-by`. In
particular, I would wait until Wedson has given it another look at
least, since he has had the most experience developing networking
abstractions.

I mention this because what we are trying to achieve with the Rust
abstractions is not just functional equivalence to the C side, but
also to make them "sound". In Rust, "sound" means the safe APIs cannot
possibly introduce UB on their own.

Moreover, as I said elsewhere, I do not agree with the
`--rustified-enum` change in the series, given the UB risk (see the
previous paragraph). If we really want to go with that, then we should
be very explicit about the fact that we are placing an assumption on
the C side here.

Cheers,
Miguel

