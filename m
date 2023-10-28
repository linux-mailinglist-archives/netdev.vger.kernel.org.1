Return-Path: <netdev+bounces-45008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84737DA7B2
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2600281FA2
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C5E16428;
	Sat, 28 Oct 2023 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9YsdZ4p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9C16427;
	Sat, 28 Oct 2023 15:12:08 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1907893;
	Sat, 28 Oct 2023 08:12:06 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7d9d357faso25061727b3.0;
        Sat, 28 Oct 2023 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698505925; x=1699110725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgkovPbag4N2FzRvN4wxyt9pyUUwilKc4XB9v7N3WAI=;
        b=E9YsdZ4paID7ReJ9iTcb7hnwvlp3N9vpyxoNjjrirKtZ6h+1Ik/0nYKPaI8cpvDAmX
         xuRH9vOlpYNrq+8Z6u4mgJGpTUXi+fbMv4/03JDQhEJQSJD127MY/hKRnAjhRYbJFveU
         EWunB0AHm59a90i6zRtZvXha6Br3dVOVqpKcNz82TZqNPo2ByztFvY3iKrrS5HvRpsNx
         L0bm38jpCocXRFsqLM4hw1fbC/XhOEhm0ZTVxkorGw4SIkF+JfUDmsxqPpQxbyRyqe2u
         Hvqz1nXEnGJe7igPE6TEumTX/SXkPuF03OAKk/LtFf7wS5qssYX4rKXSLK76mSJ/EkqD
         RRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698505925; x=1699110725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgkovPbag4N2FzRvN4wxyt9pyUUwilKc4XB9v7N3WAI=;
        b=nAKJLhOAVPASaq/NqP3xFNrRGLy7UUywCYsvXLf/vfnJqRQ2Cubnc1qArrr4xVG1qE
         3g39KtHuCuISR9LtIcysHKf0po8KJdPDrnaiislA0tnrASrihR52VPzs8PgyvmxZiB42
         J9onrR77WGcLosapjB0BcdwihJ7M621iqjt3gG5AmX5WiytufXbOj4DmLE4VfmLkhWVu
         3chhPWKN5BCRbw4bnxvIbVAxanumDhmLAg2KMyFZPz4h02z6LQcxncII8CHGeu7rW59s
         /+S1XFhhj/VHPmAtmYrlNFNNdk0YmFOFS4Vo9mrmB4cgnc/LaJeExu/wC9hLbHG6SL3R
         YLVg==
X-Gm-Message-State: AOJu0Yy7aXu6yGx+und4L39kYeMNAGly5vqCxNKKOG9EPK3qf0ogh+uN
	b8xsomeYSh51Y9x6a4HPI/jkY0Rmmxxg2eIzmgk=
X-Google-Smtp-Source: AGHT+IHVvAOPlhU8oznPAY1HVmbS3cNagiZPhGLdoyYtYnRSrm1VYSbWurMhm0gAK3/9rTJ34NexYcn8WIq/EI44TP4=
X-Received: by 2002:a81:5756:0:b0:5a7:a817:be43 with SMTP id
 l83-20020a815756000000b005a7a817be43mr5667000ywb.6.1698505925155; Sat, 28 Oct
 2023 08:12:05 -0700 (PDT)
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
 <ada8d010-52ac-46c1-b839-8d3b3ed59ae1@lunn.ch>
In-Reply-To: <ada8d010-52ac-46c1-b839-8d3b3ed59ae1@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Oct 2023 17:11:53 +0200
Message-ID: <CANiq72n-AoPjd4=3FqNM0YeE48rQzYHsYLQpqWjBb+mh4FWQMg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, benno.lossin@proton.me, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 5:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> I would say this is not a technical issue, but a social one. In order
> to keep the netdev people happy, you are going to limit it to 80. But
> i would not be too surprised if another subsystem says the code would
> be more readable with 100, like the C code in our subsystem. We want
> Rust to be 100 as well.

To be clear, we don't really care about 80, 100, or 120, or tabs vs.
spaces. What we want is consistency, and it was decided to go with the
defaults of `rustfmt`.

We may want to tweak a knob here or there in the future, but it would
still apply to every single file.

> Linux can be very fragmented like this across subsystems. Its just the
> way it is, and you might just have to fit in. I don't know, we will
> see.

Yes, but that is an artifact of history and the tools used at the
time. We can improve things now, thus why it was decided to do it
consistently for all Rust code.

Cheers,
Miguel

