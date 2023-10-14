Return-Path: <netdev+bounces-40979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA7B7C9471
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AA728255F
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A358D107BC;
	Sat, 14 Oct 2023 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl6xh3M2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C711C8E;
	Sat, 14 Oct 2023 12:00:13 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BE83;
	Sat, 14 Oct 2023 05:00:11 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-579de633419so35512897b3.3;
        Sat, 14 Oct 2023 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697284811; x=1697889611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOP0b4aW5YAzBzy0C10evmGG4rIf4zardkvlGQ7xE18=;
        b=kl6xh3M26Gbp6WjhdyF+GrCLpM0lHxVMjurGGgGr7ltVq3GKVDDK52pQN/3UHaWFox
         x3RvosfyU5QhdIYLiu4iJMrqXQexziMI9FnL/6P/1n8TPk4U0X8ZqZME0uJuMrFv+hOE
         xr3QvD/PWdecuCAVX/O+9XZhJnTE5D1zrYnO5udYhVCbj5MPhcD1ie4jBtvTeT4R3Z9z
         OoGfbA3D5+EKerCVO0Q7rOZxkYcKdZ2zmsOp76n0cGpGfZVZEciHuFv0dB0ayaee0H38
         48MFjCQ7JUJgppldeCGS6KHqo5CUBQydT9KIfcHEHPsSvDsfsZ4denf4fZPhrk/n679o
         IPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697284811; x=1697889611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOP0b4aW5YAzBzy0C10evmGG4rIf4zardkvlGQ7xE18=;
        b=ofC5Rqz2wiFVCWCcxA8OChOuJkhYGrRg5oJ79nvVCgwaCeQvn8HI63XVwMg79HvV4S
         htBQ5ERmmVxfuE7cAARKtNEpHsKbxyAwEznAyAnACKHbSVevQFfA+Jq+8CN2jeYcRF2j
         1VDE/sX6KJ/lj2yP1fviK7w52wbPQt7im9vjNru44S+Wa5O4mMmfegGa9FMv+//p1GuK
         KXsywj82xQuxVG8LrfY+4L64700/8dNIBWlN53YwsXv5RLCIihjJw36NbA18QxfRzjnw
         cyF4xuFyk6tCDzPqFoy1QL0oytIa0MxhIhV1c611otkNZwuqtdhofz61IjmQjNpvJQKV
         2QHw==
X-Gm-Message-State: AOJu0YzI9hW3RCzaP+LUN/FBOMljrQp0UogGBzpmwslFe+hsRAIvMssE
	GV6mBsE9AteSoAuihv9eGxWVcQWxIyTFrM5TmMk=
X-Google-Smtp-Source: AGHT+IEQIBALh5ra1rYCQ6cLi0pFIT9k6bmYsyXFoQ1mC+UGCG9Tg0zg9Lm2dtedQjCKwIlVCf5hD3eHAgf/ozFxYLg=
X-Received: by 2002:a81:b711:0:b0:5a7:af86:8d3b with SMTP id
 v17-20020a81b711000000b005a7af868d3bmr14778080ywh.37.1697284810885; Sat, 14
 Oct 2023 05:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home> <20231013.144503.60824065586983673.fujita.tomonori@gmail.com>
 <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me> <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
In-Reply-To: <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Oct 2023 13:59:58 +0200
Message-ID: <CANiq72kC-04zFPZ0c9wc=9MGRek4QnU_7o2E-H2VJjdCf+6GFw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, boqun.feng@gmail.com, tmgross@umich.edu, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 11:53=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> I'm not sure the general rules in Rust can be applied to linux kernel.

Benno and others already replied nicely to this, but I wanted to point
out that this happens with C compilers just the same. It is not a
"Rust thing" and what matters is what compilers do here, in practice.

For instance, you can try to compile this with GCC under -O2, and you
will get a program that returns a 2:

    int main(void) {
        _Bool b;
        char c =3D 42;
        memcpy(&b, &c, 1);
        if (b)
            return 43;
        return 44;
    }

Similarly, one for Rust where LLVM simply generates `ud2`:

    #[repr(u32)]
    pub enum E {
        A =3D 0,
        B =3D 1,
    }

    pub fn main() {
        let e =3D unsafe { core::mem::transmute::<u32, E>(5) };
        std::process::exit(match e {
            E::A =3D> 42,
            E::B =3D> 43,
        });
    }

The `e` variable is what we can get from C without an unsafe block if
you use `--rustified-enum`, i.e. the case in your abstractions.

The critical bit here is that, in C, it is not UB to have value 5 in
its enum, so we cannot rely on that.

Cheers,
Miguel

