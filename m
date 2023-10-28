Return-Path: <netdev+bounces-45007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9957DA7B1
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DD01C20986
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634A15AEB;
	Sat, 28 Oct 2023 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeEZI6xD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE6642;
	Sat, 28 Oct 2023 15:12:06 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03974C0;
	Sat, 28 Oct 2023 08:12:02 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7afd45199so25559917b3.0;
        Sat, 28 Oct 2023 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698505921; x=1699110721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAIcFay2mJQ/MIHPS/30VW7e6mQ/ldNPB7+UODDmJtI=;
        b=SeEZI6xDm2h634oUFni404ELNV2s14PfER1jGXz1szvA5+RaGeJFDiLCiEdEqvDjMV
         eYhPs/3E0r4HwzZZ/nVOjO5w9aPoGpWXKJnF0Ta4oIf+pzJXb4h6nvwfOnLR0DULCgrm
         o69O7HkWNbB+fx8YEaGstFCuCxcL4nNtv/LWRksueMtciEnppywDF6sk81sJcq6cQXC2
         qRiR3B9VS9fgiu5iX5cxesYHVgBQko8Vt3pGR2t225AekfqHW2pRB8x5vxoF1mHV4LNs
         1xmN2+UeoDsEV8O9DaRlFe00THrkqsee0BY805wvojRr2YGlOnl67zNDxInzY/hvKMGs
         OdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698505921; x=1699110721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAIcFay2mJQ/MIHPS/30VW7e6mQ/ldNPB7+UODDmJtI=;
        b=QxPznv6SYAn1lw6Oz/Y/yswnDBrnAa89XGiSlrqMX3m4VmHAUf7S4Wf7+ZYlpJKtoB
         f2+Zu9KIBe4+Y1/JhIxPaSNEJ66nbj9nUBAM4a/kBzFCSXfnvuOj5Qn5SVkp/jSni5LS
         tOga8PKX3VZNBAWu0HWu8akrDamb032yeqEYt4e+86TfAvz7RehAk0IZXzIFCrnTKT5i
         bswVOUiO+CmaTBB2rNQiaJeiYKN/NScWikLbiNPS8lWTHH3Eo20HoepVlU0t+Lv7JAfi
         b6NNTfvTWW9FRCPygkausaomj29/HWDS2kWHmT3lt2iU/lJvVg1yB4PQYLzzU6rDpcWg
         lDBQ==
X-Gm-Message-State: AOJu0YzB2GpjmhLlGxoHuqZu0s/tuRYCdaCJt2Z0X6fHVoHWivvbAjFS
	GFp83uCFmyPV91VjabHS+WqmIEeX1WF1teyu+q4=
X-Google-Smtp-Source: AGHT+IFy5UgsARBoD+eDXpWYeQapwrjHE7Hx01EtgKzxq515XyOaHQbS9Yb+k7p2CLPFMIhZYo5MnRCVyBxftpby8/c=
X-Received: by 2002:a05:690c:f13:b0:5a7:d133:370d with SMTP id
 dc19-20020a05690c0f1300b005a7d133370dmr7080914ywb.16.1698505921160; Sat, 28
 Oct 2023 08:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch> <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
 <20231027072621.03df3ec0@kernel.org> <CANiq72n=ySX08MMMM6NGL9T5nkaXJXnV2ZsoiXjkwDtfDG11Rw@mail.gmail.com>
 <ca9fc28e-f68a-4b80-b21f-08a3edf3903a@lunn.ch> <CANiq72k4MFe2qL5XrweObo-bxT9qPA6+GAF4bSwLzyQJRX-mJw@mail.gmail.com>
 <1e8b5a62-047a-4b87-9815-0ea320ccc466@proton.me>
In-Reply-To: <1e8b5a62-047a-4b87-9815-0ea320ccc466@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Oct 2023 17:11:49 +0200
Message-ID: <CANiq72=Ugc4bqJCQxnAOw1f3gtD-a_aYdrjbCp4A0aX2hqDaVA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 1:41=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> We have it disabled on the `pub mod code` in error.rs line 20:
> https://elixir.bootlin.com/linux/latest/source/rust/kernel/error.rs#L20

Thanks Benno -- I checked the `rust` branch, and forgot about that one.

It is an interesting example though, because it could have gone either
way: we were not using it for the same code in the `rust` branch -- it
was an aesthetic improvement for consistency. In fact, if we do the
macro differently, it would not be needed.

Cheers,
Miguel

