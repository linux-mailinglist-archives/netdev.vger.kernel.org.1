Return-Path: <netdev+bounces-40842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E91787C8D13
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819EDB20AC0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195CA1846;
	Fri, 13 Oct 2023 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHScMKBt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642802B5DA;
	Fri, 13 Oct 2023 18:34:12 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB1A83;
	Fri, 13 Oct 2023 11:34:10 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a81ab75f21so13040607b3.2;
        Fri, 13 Oct 2023 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222050; x=1697826850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhAI2VdLXTYJFZcSYW7Y2lJryl/mHQRV9xRHqb4iE3g=;
        b=MHScMKBtGqVobGO2qrviDXBrbqfJ0/4U8K42dCVA8/SBjXZO9AvZ5xOg3VsCQQ9cU4
         GGsuGCCze1EhNHh/tYELBxNR+VkRxBW5RrMh2wqAs/9+Z6vYVOLqN0ydBn37nb2gT8+Z
         oaXcgLtVfjgzA1lJjWfkV/glJMoG98p+YyTrZ3eEeyYh+Y0PChX8+X1sOQZb4Ax+ipYD
         Xl9Kym3TK/I/jUGRDMdz9F9UyXQzNlSUuDrzcuzAbuerjYRFvBV+8hZ+Xqv2VLnsjUvk
         JuNbtKVfqFafcZe6gJkEK7L2RWJ4+57mu0xTK0bhRKKmhbliHEjAumkOEPmNiBsOcIpv
         4ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222050; x=1697826850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhAI2VdLXTYJFZcSYW7Y2lJryl/mHQRV9xRHqb4iE3g=;
        b=JKRn3INo2xKKqyxcJCLb5vNMcpx+pK0t276uWz13a0DQEb/JY/b0W/KMgeELzb7oBd
         b0dfZDb3zDSq0O7Ou/Zx1RFp1M4ypxTHlYUzNsLsHel7YlZ/PIv7eJ2El8VyjLlg3d8D
         cTF5N2nOU+8Cu8oMR1RfyVO/cGB1xgCc3xExJrlS+/UGkjIl8gtqlUnlxfl9eu7b4w38
         VdKm2p60qT9ubTco9oMoh5swZQD8H5xtMr5yaSOzPIaoqqoHaoF5eE9rfOO+JH7zgzmn
         5YCThK3gpbOoHBibxc5Ki0sKv3+3wxCdlG1jX3D2BoDSphkELIxlFOuHFsgoNEP9hKYv
         I15g==
X-Gm-Message-State: AOJu0YyO7tclALG+ATz4XVr/qYwLVaOalR817OJjCzms0CbtKiEHeKeT
	2XEdgP1cR96X92omB23YMWg4j0KR339NVkHV5Hg=
X-Google-Smtp-Source: AGHT+IFMmDWNUvKvbKmtftXbzmXXMkA+ztHO85dK2UkvyagpP20YZveoBqr1h5/TfT9SUxWS4bX0q2AQzfK5cCDZJio=
X-Received: by 2002:a81:4f82:0:b0:5a7:c906:14f with SMTP id
 d124-20020a814f82000000b005a7c906014fmr11580157ywb.11.1697222050134; Fri, 13
 Oct 2023 11:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com>
 <20231012.081826.1846197263913130802.fujita.tomonori@gmail.com>
 <CANiq72mgeVrcGcHXo1xjaRL1ix3vUsGbtk179kpyJ6GAe9MMVg@mail.gmail.com> <20231014.001514.876461873397203589.fujita.tomonori@gmail.com>
In-Reply-To: <20231014.001514.876461873397203589.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Oct 2023 20:33:58 +0200
Message-ID: <CANiq72=JQseA6JFy7g489Wwk8kc7-xk2GLVVJC8+T9eMNxvitw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 5:15=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> I meant that defining Rust's enum corresponding to the kernel's enum
> phy_state like.
>
> +pub enum DeviceState {
> +    /// PHY device and driver are not ready for anything.
> +    Down,
> +    /// PHY is ready to send and receive packets.
> +    Ready,
> +    /// PHY is up, but no polling or interrupts are done.
> +    Halted,
> +    /// PHY is up, but is in an error state.
> +    Error,
> +    /// PHY and attached device are ready to do work.
> +    Up,
> +    /// PHY is currently running.
> +    Running,
> +    /// PHY is up, but not currently plugged in.
> +    NoLink,
> +    /// PHY is performing a cable test.
> +    CableTest,
> +}
>
> Then write match code by hand.

Yes, but that alone is not enough -- that is what we do normally, but
we can still diverge with the C side. That is what the `bindgen`
proposal would solve (plus better maintenance). The workaround also
solves that, but with more maintenance effort. We could even go
further, but I don't think it is worth it given that we really want to
have it in `bindgen`.

> I'll leave it to PHYLIB maintainers. The subsystem maintainers decide
> whether they merges the code.

Indeed, but the "no `--rustified-enum`" is a whole kernel policy we
want to keep, i.e. we are NAK'ing that small bit because we want to a
solution that does not introduce silent UB if a non-local mistake is
made.

> Thanks, but we have to maintain the following code by hand? if so,
> the maintanace nightmare problem isn't solved?

That is correct, but that requires extra work on `bindgen`. What we
can ensure with he workaround is that it does not get our of sync (in
terms of the variants).

If Andrew prefers to wait for a proper `bindgen` solution, that is
fine with us; i.e. what we are only saying is "no, please" to the
`--rustified-enum` approach.

Also please note that there is still the question about the docs on
the generated `enum`, even with the current `bindgen` proposal in
place.

> btw, I can't apply the patch, line wrapping?

Yes, I just copy pasted it in Gmail to showcase the idea. I have
pushed it here in case you want to play with it:
https://github.com/ojeda/linux/tree/rust-bindgen-workaround

Cheers,
Miguel

