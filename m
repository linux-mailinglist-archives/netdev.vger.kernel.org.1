Return-Path: <netdev+bounces-62154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D0825ED3
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 09:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB60284959
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA084439;
	Sat,  6 Jan 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1/2hPlf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A882441B
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-680fa99a0a5so90996d6.2
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 00:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704528564; x=1705133364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRZMYz5tGg2CVHgwSa5v03Ysex5vkTLyHVYkZh3pAH8=;
        b=h1/2hPlfrm7u4tIs4tcWqVqPXUsYxZqIbAACmwU6XKvwnCbQwMTqDwDCf90kzUdmfe
         p9FrU3l8OR4RSs2zajmmJdkGdhLz5d6DTRO8detHUB1X+bIvwdhZp4dJjbdDV8V7cLQA
         SctmH9bjB4+TFHpjqiH7MxOwz4EWiaJlmLdg1a7lmzsQ6rk2J2k2i8PjqtH4AoiWxXvM
         wfjJBbvhQZJOEkP0CwKoYytfySKoF6Rp1t6beCIvnMLsx+dd1ws6zuf2DN1J8Wp8PFJJ
         CBJ3ni6YNssLUdaNOvqmYqw3spp2G5McAfP1COezQVsGDXQzQucAhfEsQKs1a/2fjYFi
         J73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704528564; x=1705133364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRZMYz5tGg2CVHgwSa5v03Ysex5vkTLyHVYkZh3pAH8=;
        b=I611B1gvnevUqc+ei17fAwpuB33HFpc0CgLPnG3C339oeqOgTIndHGuKWm427Dv0A7
         NtqDCMeUk4lmDM0BL1qMEIGUbwN3W8cQGPt0b/GjZIIx/tZWUm0xaseCp/8yrC7a4y6y
         zpfr9vMXz1lVtsCOEn0tDcuK5VlxOA2w3AEl69UttpRAOIEMmyt9lZBIQMfweGhJ7bLX
         7ChdBTuUtHXHus+EW5nFa2i0HRB/66y4f/OqLhPkUuY3UtpdCdO2XtLAom8fayOH9EiO
         M+Z1rzq4jAkLs/PltZCg9cq79HpBB1f4OaJVGeTjULHnF9ZxmWPgLVD8T/glpDidsyQN
         2d1A==
X-Gm-Message-State: AOJu0Yy1bwgVzGKlJuwPNhGqiIr0flytkacCHDjp6Bbsw08QWn7Mklhi
	dpaN4MFyPdTN8wWxbuFjLecwrF7eUeO4P0728L+btuLxXizh
X-Google-Smtp-Source: AGHT+IGNZn0m8paKocQJUSZlQN8n6Znw04sRBC6kbmYiF977qlVZtYqLlwEq8RxKSplwZDYkh/s5529DAMXE8kyNF4M=
X-Received: by 2002:ad4:5b8b:0:b0:67f:2254:1629 with SMTP id
 11-20020ad45b8b000000b0067f22541629mr677963qvp.86.1704528563895; Sat, 06 Jan
 2024 00:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104212439.3276458-1-maheshb@google.com> <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
 <CAF2d9jga9oc4OST6PMU=C9rz_NDrURCcLGx-1tP31U00z63vbA@mail.gmail.com> <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>
In-Reply-To: <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Sat, 6 Jan 2024 00:08:57 -0800
Message-ID: <CAF2d9jhnsubL-sw792ZviSXrFB826G-U8OktdEMN1NCe5zuj0Q@mail.gmail.com>
Subject: Re: [PATCHv3 net-next 2/3] ptp: add ioctl interface for ptp_gettimex64any()
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 8:55=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Fri, Jan 05, 2024 at 09:51:40AM -0800, Mahesh Bandewar (=E0=A4=AE=E0=
=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=
=A4=BE=E0=A4=B0) wrote:
>
> > POSIX clocks are employed in this series for syscall width
> > measurement, potentially leading to misunderstandings about
> > overlapping functionality. However, their roles are distinct and serve
> > different purposes.
>
> I don't see any difference in purposes.  The multi_clock_gettime call
> is a more general solution.  Thus it will obviate the need for any new
> PTP ioctls.
>

I disagree! NICs inherently benefit from bundled PTP devices due to
their superior low-latency, low-overhead, and precise TX/RX
timestamping capabilities. For demanding systems requiring increased
capacity, multiple NICs from various vendors are often deployed.
However, disciplining these diverse PTP devices across the host
demands a flexible approach; a general purpose syscall is not an
answer. The current PHC implementation using ioctls through exported
ptp devices (/dev/ptpX) provides a solid foundation that is per device
(/per NIC).

This series is providing another piece in an existing suite of methods
used for disciplining / precision tuning (along with adjfine, adjtime,
gettime etc.) This addition is to take that precision even further.

Having a general solution for posix timers is a nice addition.
However, expecting a general purpose syscall to eliminate need for
device ioctl is an unreasonable expectation.

Thanks,
--mahesh..

> Thanks,
> Richard

