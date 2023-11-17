Return-Path: <netdev+bounces-48686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32EA7EF3C3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C0B1C20445
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A481328C0;
	Fri, 17 Nov 2023 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xR0UUElR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F368BD59
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 05:40:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so9252a12.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 05:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700228429; x=1700833229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbIdPz9RxKQrSbi01FLY0JWxLd7QT7QIjlLlTRp9Ecc=;
        b=xR0UUElRBfJ3icepXtDnsMSpm4/qIvn7QIj0wrt6UP5smFqQfAaZSKDWkmgUaWRoC1
         L+GfM9el6Py21gpiW4MVU4CCgmDRzYPfRHrsI1jD5NdlYhOY0A3AmRWcj7MT4zwuZ7eP
         mvfU7KUIpba4t3zaklPeOwE935cZIS3k/L+qjrFW1dDKHsbMJiEHBCyfzQnp2x/t5Hlw
         LYHFxpocdt5gnMxpBzuUHup/mEKnPyzCwdCvMIrnie5flaWoq8paDkMDMc04Njhsdrut
         FwJgDkB/g1rbXjdQZWz2vMVuY9IoC/AmmolUXyOUmed1xQmpy4sAR3aTneKZDa+B5IWE
         PFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700228429; x=1700833229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbIdPz9RxKQrSbi01FLY0JWxLd7QT7QIjlLlTRp9Ecc=;
        b=bMMN/tgsEycHD1eN3V2bFw8JOYGCMyYEoVHHodDrfFiOvpFouuc1xzTKHNSVi6OPvO
         JhhHy4rC15hBW9+LMfVfi4nefXVccRTt5hA8RRpWbHOzOsnhHaTSGPN1LBb7zEImJkWy
         TIcfUUFIGDFdzUI774cSM3Ha7Rkfxil3etppHEVIGc9EBvY6TQ4w1ewa8kJj+0yfS80R
         d8jBhlVxaMNrDh+uf6LRONSCuofkhXgHssX+UQzF/fTn8HW+GxkFazYa5LNzzn8HJq0P
         kxFN/yhkbMGtknPsmkfwOOgN+1ejJH6/YjWZw/gnJ1StNU+YRh43Dox94uIQG3PIGioL
         jg2w==
X-Gm-Message-State: AOJu0Yy3ZcTnkBgLV8h6ZhXjyd9uteB6vnNYIdMj7ZiIxtiTWpng4ub/
	Qo09ab+u1YV1JthY9ZOdXd0HRE2Bq0Xw6WyP1SPLEQ==
X-Google-Smtp-Source: AGHT+IEupSlEu1yzsALFByjjXXmELNtFN4kBR/UiW3iIGKQMhu6Tj74chMJP4rSMVBj9CeSBaNOjE6wgrikuuGVIfOw=
X-Received: by 2002:a05:6402:3886:b0:543:fb17:1a8 with SMTP id
 fd6-20020a056402388600b00543fb1701a8mr113570edb.3.1700228429224; Fri, 17 Nov
 2023 05:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
 <20231117104311.1273-1-haifeng.xu@shopee.com> <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
 <76411980-e06d-43d8-8f63-b9a032e21b43@shopee.com>
In-Reply-To: <76411980-e06d-43d8-8f63-b9a032e21b43@shopee.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Nov 2023 14:40:15 +0100
Message-ID: <CANn89i+y1xzAH+m8W_nSyNXkTsJJOpf5NaF=_bEUA4YAAsTp0A@mail.gmail.com>
Subject: Re: [PATCH v2] bonding: use a read-write lock in bonding_show_bonds()
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 2:15=E2=80=AFPM Haifeng Xu <haifeng.xu@shopee.com> =
wrote:
>
>
> dev_change_name=EF=BC=88=EF=BC=89is either used in  dev_ifsioc(case: SIOC=
SIFNAME) or used in do_setlink(), so
> could these net devices which need to change name be related to bond=EF=
=BC=9F I am not quite sure.

You can change a netdev name with

ip link set dev OLDNAME name NEWNAME

This is generic.

