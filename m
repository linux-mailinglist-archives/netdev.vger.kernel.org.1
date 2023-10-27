Return-Path: <netdev+bounces-44715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A667D951D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD958B20EF9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7A179AE;
	Fri, 27 Oct 2023 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8MeObKh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BD17995;
	Fri, 27 Oct 2023 10:22:20 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B0D7;
	Fri, 27 Oct 2023 03:22:18 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a877e0f0d8so26233967b3.1;
        Fri, 27 Oct 2023 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698402138; x=1699006938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUimdieKLG+M62dOlv5hBr5/sjxwlb4xGdM/2myVnSg=;
        b=Q8MeObKhAOBolrgb/Kyn+YxrNfUx4rq5NCZ20W66AidLRoYcXk+kx5PvGUurom54sH
         mcbThOOZQNuzfAoQkOou+aFVRTTIQovGqs1ci+XmXomtt+nw/ak4zA0ZqyupOvjhiYPU
         ft/m3MaLueOtGMIKXy0stbSyv8brwUvd/sU7V+ISheXtiDeX6W9MCbeh1qUx/TbfPK1c
         vZPWBtBMwqRZdgiEipCVPisQ/gN5/93bj0yA97xt5UE5JrGFMO10ZHk/lONbAciYqjqL
         g/Uro1oY1SfDycbppc2X5r9NNX195/R0MBXlO79hk/KMPmJXyAp12tTB/wm79NOE8YEX
         cAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698402138; x=1699006938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUimdieKLG+M62dOlv5hBr5/sjxwlb4xGdM/2myVnSg=;
        b=I8FT7RFWq1T41EJXlbB/0ikiAX4SuEUa0cj/fX2bHSiSHg0ZCihS5OWnzTynlHJ7f9
         xQyObTglagixbiuNrI8w04lwtNA9yoddIaq+HKMppsY25KbQt0EYgAiBD6allAfXFqIo
         Fozf5ZRxGrrC5TSnDJ0uCBIYG95RtOsIcrEnWQGsho6VMnoqfG+NGly5J8CtStS1p0jQ
         U2nMolfrswwXbUmVl1BDEsePfiBT51HQ9i4tiGLZl4Oe48M490L0QQI/TfKOe2Q+WiYh
         ssYpGw3fgMEq5j7WkkRFik5eZhl1h4gcDE2lVv8ghSJ/QrrVVqGSwC1Ft1203lzSCLCb
         XuBw==
X-Gm-Message-State: AOJu0YwfBwvU9dh1sgTvB0NBj6o3/UvI9+3vChWsSfzd9nWAt7rgvLLQ
	7wG8S377tCcJ/HoPxsjNMNc3PbReW7X98WKn8+E=
X-Google-Smtp-Source: AGHT+IFbQcMUqtdd/5umB7MX+VguykQvxErRfw4GIJ+N8z70QYTkx/8+FqSZVlnPZ2SZ6GT3w8X4McFzd2090itwCpA=
X-Received: by 2002:a25:3c9:0:b0:da0:4076:49d with SMTP id 192-20020a2503c9000000b00da04076049dmr9843512ybd.15.1698402138076;
 Fri, 27 Oct 2023 03:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch> <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
 <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
In-Reply-To: <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Oct 2023 12:22:07 +0200
Message-ID: <CANiq72nwy6n1_LXGxq7SU6wFmoci_aE2qn5qyzuW7jo8mqTvQg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	benno.lossin@proton.me, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 4:47=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> It should also be noted, patches don't need reviews to be merged. If
> there is no feedback within three days, and it passes the CI tests, it
> likely will be merged. Real problems can be fixed up later, if need
> be.

Passing CI tests does not tell you whether abstractions are
well-designed or sound, which is the key property Rust abstractions
need.

And I hope by "don't need reviews to be merged" you mean "at least
somebody, perhaps the applier, has taken a look".

Cheers,
Miguel

