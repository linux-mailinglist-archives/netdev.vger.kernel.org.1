Return-Path: <netdev+bounces-45009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5AC7DA7B5
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44600B2111C
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5415AFC;
	Sat, 28 Oct 2023 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDg6HiLv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B7156DB;
	Sat, 28 Oct 2023 15:16:23 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8EC93;
	Sat, 28 Oct 2023 08:16:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579de633419so25364367b3.3;
        Sat, 28 Oct 2023 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698506181; x=1699110981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl2EZQt0v62lf9puLkPgAagAGGv4WSoiTTHS5Tlax74=;
        b=RDg6HiLvoJddMkftxnCI/UweadUi7+f3RHJ5NPEibWMphN1ERazovKAF/SZfDihO2i
         YIs/u2mmkPYxI2FullE4ogkNSptiqwU2TWAURCmJ93gAF6/0zh28JU6HEgmzvfM+y4A1
         aEIRI2u15gdAz2WLPIiARYG9dcSdK37Bj9RtBWuru4zU+xIiQ2nhPnVvfEV7WHZ3ec6Q
         kp+xUxHZ03HAmTkFmIYXcWIWsskkJhoxbPSGA2iurlliY1uP9r9ZweXX3tv2E9XMztsK
         SBC2Fem33WkADmmt+5awKfJHdapwAZyJBGrjlLl+FDwfckn89VM9WvWnsmT1i+BQc7KA
         upMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698506181; x=1699110981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl2EZQt0v62lf9puLkPgAagAGGv4WSoiTTHS5Tlax74=;
        b=sChcb7zx2RIdGYz6NOqfTCpBoprHDwmpYCD3Pt+p2U1N1bxvVNP3K7mchACPSCH6vA
         Giqp1IQnRI/1qp4DF0LY6y/XGpUHhnXg6r13cpBqYe5QAUZlnqj7jV/CFGSAxRJ9yeax
         KHO3u+ktqYNDHWAzSP/FAc9OYMzP3uftwpRs330WH4jwPJN7vrZRE0mCfFsMaKKH6SQP
         6Detaykm9vUmd0VZEtQOGHUro2FfYALLOKz+tBKv2XlY6fzxqGktMCHoeZg9VIn0ba7o
         KU9kS44LWkDUIzw/NzNyiuJj/tNxWAp/zREfF9B03/Tey1sNXYaZUt5WNhyYpuEuCGmH
         1F+w==
X-Gm-Message-State: AOJu0Yz2igRfXHVn+5tsBGMl05u7Dxh4zH+ZaV+0TC4mC27fPdyAPX/d
	HeXdYy18MJHvTEtPS5U+NreIynHOhRoLdv9TLsY=
X-Google-Smtp-Source: AGHT+IHdX5USwcAHq9iwj4NFFlDWYhm1NF39qGD4b17eYr9XeC332vcie2FfbQSNzYhs+LSbDENuQ1g5JosMezSHY5w=
X-Received: by 2002:a81:af18:0:b0:5a7:bbd1:ec21 with SMTP id
 n24-20020a81af18000000b005a7bbd1ec21mr5102231ywh.0.1698506180904; Sat, 28 Oct
 2023 08:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com> <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me> <ae1987a4-b878-498a-a06e-2db16d9f2056@lunn.ch>
In-Reply-To: <ae1987a4-b878-498a-a06e-2db16d9f2056@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Oct 2023 17:16:09 +0200
Message-ID: <CANiq72mOt3yvr_07Gbjnz80ExODYoNvXbqERmCOpZYFmGmAVRw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benno Lossin <benno.lossin@proton.me>, Boqun Feng <boqun.feng@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 12:40=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> After the discussion about mutability, i took a look at the C code,
> and started adding const to functions which take phydev, but don't
> modify it. Does bindgen look for such const attributes? Does it make a
> difference to be binding?

I think you are referring to the `const` type qualifier, not the
attribute (which the kernel uses too).

But yes, it makes a difference in the output it generates (if we are
talking about the pointed-to), e.g.

    void f(struct S *);       // *mut S
    void f(const struct S *); // *const S

Being const-correct would be a good change for C in any case.

Cheers,
Miguel

