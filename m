Return-Path: <netdev+bounces-45220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA97DB8E7
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B795EB20D16
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB38D27F;
	Mon, 30 Oct 2023 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhrCL3zP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25912E6B;
	Mon, 30 Oct 2023 11:23:04 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD8D9C;
	Mon, 30 Oct 2023 04:23:02 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a86b6391e9so39736227b3.0;
        Mon, 30 Oct 2023 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698664982; x=1699269782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYcwPuCj6ZjWrRMk4wpMbG2eJVuQUb2O34FbZTj4cac=;
        b=BhrCL3zPhOTns/d76sXT+A5rKgGTXiwSWKkv9G+MyVVXJPCpsuqvsA4THfYCvSXJ/E
         46ZkXoj8IZ9JrOfUJZrGA+wiQ/mvcdAUQJIBhoevOInnzTY7UWwxcSQ27soNOzC5fCQK
         d+/QbxK9OT/6sddvoheV22ThCmBtmo0t3FKqT2d1twMw8w+EFq9PrSW5JT0vYrE9HF92
         mbNQo58ftHhbayRZZJSb+e/ozLSxWX+3+QrdSecMS3XBkqVlXzO/L3U7OBc/Y4e1SHG6
         lNd1UYyIeUJWfIqyj/kXp3MnY3l/e6Oy/KiGIUkcvXJVv7qK59gXTaxjZkFsPtp0tGiv
         pE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698664982; x=1699269782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYcwPuCj6ZjWrRMk4wpMbG2eJVuQUb2O34FbZTj4cac=;
        b=gOi2ZMzv4EJWepHSZkcYOQrYhmn601ihLYcB6vsealf2qVnlJbrwFcDvZLoifWnU0I
         kv8NW++a6mL1WtmjDwZFqhDuKrGFr4Oryw4fHclpZqjjrK8O2AB1jAQdSuWKTIOj+PkF
         tK+mJsgW77u173VHGa/GNPDtqG1YRJ6WU6Y/Vb2dRvIBvqkvbRwbNZ1BGBBVBcjbUNnR
         UocB6BobbOR8DXoyBymrmRpjsQywi1rqMPXUlCH6tYK3tyzEU3wFoaaklxmCs6tBoBeX
         Gv/2juXc+KJ1/UTZJ76YNv/welYhgeAZQEkM7m0J65tra1dUpXgdAp1/YUYLEMR+g8G+
         gryg==
X-Gm-Message-State: AOJu0YzEQdbvl7UYgb3B9SDyIElQFqif7oBI0hX8TjnfovV5bbHVrm4s
	nrpnHjHtP04bzjjDAmCGfRX2qCWUf3otctP5JKo=
X-Google-Smtp-Source: AGHT+IFM1NVStxEwcQ82oNWT4AwZkEkJo6WvYDolhd5dgpQ+rCrmjze4o96cmiWwiOCK683kOyudtMLHPnfLBh1yeG0=
X-Received: by 2002:a25:8e07:0:b0:d9b:9f55:b62d with SMTP id
 p7-20020a258e07000000b00d9b9f55b62dmr7492774ybl.61.1698664982036; Mon, 30 Oct
 2023 04:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux> <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
 <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me> <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
In-Reply-To: <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Oct 2023 12:22:50 +0100
Message-ID: <CANiq72=D6P+x99Ur0jKnR+7DoE=vS0X1jnphZ5E3i-Br6tsh3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benno Lossin <benno.lossin@proton.me>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	boqun.feng@gmail.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 8:24=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Please could you help me understand the consequences here. Are you
> saying the rust toolchain is fatally broken here, it cannot generate
> valid code at the moment? As a result we need to wait for a new
> version of bindgen?

Benno has already replied, but to be extra clear: no, it is not
"fatally broken".

`bindgen` is just a tool to automate writing some things you would
otherwise need to manually write. It currently generates some methods
that take a reference, but we should avoid creating references in this
case, so we would like methods that take a pointer instead. That's it.

In other words, we could simply write the methods ourselves. That
would be "Option 0" (which would be like Benno's 1, but manually; or
like Benno's 2, but in Rust).

Cheers,
Miguel

