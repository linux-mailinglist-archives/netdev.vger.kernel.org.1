Return-Path: <netdev+bounces-184555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DAA96312
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A983BD0A5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE5238C15;
	Tue, 22 Apr 2025 08:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6C190472;
	Tue, 22 Apr 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311457; cv=none; b=f/nkNC9Pc3C3eQSigEh+Ez3iEMBOS93daA7+GJIw+7BPBHLQFFpxrJIyV2Vbaw0bua3H3Wka17ZjHJgwil6HVw9+UlGfPOdm3b3ugcO4M8KtnCPrwlk9GtMsA2dK0T7yLHPYJyzBYYfEN4cg1vHeY5TIJuuKMfOO2xUV4ydcmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311457; c=relaxed/simple;
	bh=d3vMkZUgF1qGZvdCTBm7Bb2MO67cZCqhiB7dVZXff7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fflLLKmhQO9p8pYD8lZBXZu540D9jYzWVRvloOr1vhKR3Q1aj7KmudF/9Ukjd5oHwtcGbgBkR+6jr0UmMZkZxSWomcJENhg5LOktjUpS2ALVenShzRuRVoaw3VQsSqFt6a6wUvPPfYHbn77npW51C2XpiXi639phepR2YE7Azi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1702233241.0;
        Tue, 22 Apr 2025 01:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311454; x=1745916254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLaMluqDEwjyr3+Ikq130BwnO35HxC0ThAvpH6TmcJU=;
        b=C5Qyjm6DW+n1mautQR+o9B/+7tOw3oLILI3f1NpWKjO08W/xVIfeB0plsw0CDje4vs
         jCe4FEBMrMTLvvFd15Igy+t7h2LAi3X8Qr6omOujpf+Anad3UF/rRrxnno4fU7AM8bIn
         r5fKjLAyV5K+rSoc6ANC8rG+eefCD2BcMVlyAWzZTNYGAIFhVK59w/buAgF9dpfrEYd0
         Yw6W5TtAF5t+xTQbNH4l+0uRiIZ5ozaMC5tbmW/DEMRmFPWRQsZX6rYPOq7vkC12OeA/
         zX0aZTDwJfqY+ANXlY/McwBcAtBJqMZzgLZW9O+xLoN4+GwaxvzveYDlT2stwgGjdirS
         pYzA==
X-Forwarded-Encrypted: i=1; AJvYcCUOXnz3Mt2nI+K+figv98dVb6Po42DcUH3cNMaxB9iGXGNa2zY7nxHTETUbuj14y67LrVp0u2I1@vger.kernel.org, AJvYcCVTSfnHHWP8cWa6ep84ei7s82fP/1TbNPGcSHR2nrzH4WQRe1TyKzk5mG7BxvcM5iZShO+zbuWJh/s=@vger.kernel.org, AJvYcCVtMNeIiG5LRsjfP5I/vFhIYpbN9eIEOCO0yNiqTp4bwa5T4KNaHvHVjqQLFA6IbrtI56zgVfoQs1d27WAu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OGJHL8V4cCQZTY1s1EaQg86sNU04PilkVcLc7XFpBYL4Dwbv
	Iiy7ksM97DItlLgq9iqOY19r18bNzaWPIrWRlTOa0NRZY/JKIHODttJefuaI
X-Gm-Gg: ASbGncuFjIHIJRIEchYJqla1MhTWH0eV9e2S0OsvGULcTqAtvl2JBS8bpnt2uYPxnGl
	Z2NlT+Z4zKFXF63Wnm3jb8qbREewPymHZ5S+Inau8RAGGEwiFXK4QG9ybVaYK9USMUJZ2+mgsg0
	3Kh8Kum5+F65HbhwrYwBH4bjwT51wiQgDRHLQ45jLVx43XD/8yKXJRBtz4Xei/ep+kC0ZJhl9ZG
	X0wZHMG3Fz56eDLTz6X4i32BH2T2qGMcuvlixnVsWZxZ0IXgG32p3bg7uONbaOOgOud7Z+Kwei3
	4oEgulXeI/OepfEIQ1dXvSHQplemdR1JXMbKSjZgB6nNgBq8oJ1JhZl2LFwzIjSuuX//23B6D4G
	5g7t9dgQ=
X-Google-Smtp-Source: AGHT+IGHjwtajK+eESnZcNJv/Xcrc5PPMvqynRq9MQ0CFLdghjl4CA3+//ryDafi5O9y073O90WCdg==
X-Received: by 2002:a05:6102:53ce:b0:4bb:dba6:99d4 with SMTP id ada2fe7eead31-4cb800d8a62mr7419001137.7.1745311454063;
        Tue, 22 Apr 2025 01:44:14 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7dd84911sm2133955137.4.2025.04.22.01.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:44:13 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5240b014f47so1859268e0c.1;
        Tue, 22 Apr 2025 01:44:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgsLcqOZ6qig0Nyx1yEz1ZQjjBG2RMAXT29vXcAMPOgEPFhtdJIeZqgPhoKE1r9AR6Ab+rHGNZs+jIGU1J@vger.kernel.org, AJvYcCV54AhY9zdZZtSpsQXZJgX/7vEcfCQ1EmzT7lIdR9KPY4FsKR7nRgRalQn0keIegudMBPw59DafJZY=@vger.kernel.org, AJvYcCXk7N+IiJZcFo+L9hOFe4RZCAfIyNwtdP5NgTUogaqmaa7OiGERKxy2B8bwolG11SlkVRKvdLgl@vger.kernel.org
X-Received: by 2002:a05:6122:3c44:b0:520:61ee:c815 with SMTP id
 71dfb90a1353d-529254ff048mr10359604e0c.10.1745311453748; Tue, 22 Apr 2025
 01:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597382EFDE3452410A866AEB8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B01823415CB7FCD3BC27B8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdV9tX=TG7E_CrSF=2PY206tXf+_yYRuacG48EWEtJLo-Q@mail.gmail.com> <PN3PR01MB9597B3AE75E009857AA12D4DB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597B3AE75E009857AA12D4DB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Apr 2025 10:43:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com>
X-Gm-Features: ATxdqUE7mMMNjQJXGhijqI3kY1zbATKtnGoK226m5ymri0gv1G5LUPASpBBxpD0
Message-ID: <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
To: Aditya Garg <gargaditya08@live.com>
Cc: Hector Martin <marcan@marcan.st>, alyssa@rosenzweig.io, Petr Mladek <pmladek@suse.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sven Peter <sven@svenpeter.dev>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Aun-Ali Zaidi <admin@kodeit.net>, 
	Maxime Ripard <mripard@kernel.org>, airlied@redhat.com, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, apw@canonical.com, joe@perches.com, 
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, Kees Cook <kees@kernel.org>, 
	tamird@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	Asahi Linux Mailing List <asahi@lists.linux.dev>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Aditya,

CC netdev

On Tue, 22 Apr 2025 at 10:30, Aditya Garg <gargaditya08@live.com> wrote:
> On 22-04-2025 01:37 pm, Geert Uytterhoeven wrote:
> > On Tue, 8 Apr 2025 at 08:48, Aditya Garg <gargaditya08@live.com> wrote:
> >> From: Hector Martin <marcan@marcan.st>
> >>
> >> %p4cc is designed for DRM/V4L2 FourCCs with their specific quirks, but
> >> it's useful to be able to print generic 4-character codes formatted as
> >> an integer. Extend it to add format specifiers for printing generic
> >> 32-bit FourCCs with various endian semantics:
> >>
> >> %p4ch   Host byte order
> >> %p4cn   Network byte order
> >> %p4cl   Little-endian
> >> %p4cb   Big-endian
> >>
> >> The endianness determines how bytes are interpreted as a u32, and the
> >> FourCC is then always printed MSByte-first (this is the opposite of
> >> V4L/DRM FourCCs). This covers most practical cases, e.g. %p4cn would
> >> allow printing LSByte-first FourCCs stored in host endian order
> >> (other than the hex form being in character order, not the integer
> >> value).
> >>
> >> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Reviewed-by: Petr Mladek <pmladek@suse.com>
> >> Tested-by: Petr Mladek <pmladek@suse.com>
> >> Signed-off-by: Hector Martin <marcan@marcan.st>
> >> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> >
> > Thanks for your patch, which is now commit 1938479b2720ebc0
> > ("lib/vsprintf: Add support for generic FourCCs by extending %p4cc")
> > in drm-misc-next/
> >
> >> --- a/Documentation/core-api/printk-formats.rst
> >> +++ b/Documentation/core-api/printk-formats.rst
> >> @@ -648,6 +648,38 @@ Examples::
> >>         %p4cc   Y10  little-endian (0x20303159)
> >>         %p4cc   NV12 big-endian (0xb231564e)
> >>
> >> +Generic FourCC code
> >> +-------------------
> >> +
> >> +::
> >> +       %p4c[hnlb]      gP00 (0x67503030)
> >> +
> >> +Print a generic FourCC code, as both ASCII characters and its numerical
> >> +value as hexadecimal.
> >> +
> >> +The generic FourCC code is always printed in the big-endian format,
> >> +the most significant byte first. This is the opposite of V4L/DRM FourCCs.
> >> +
> >> +The additional ``h``, ``n``, ``l``, and ``b`` specifiers define what
> >> +endianness is used to load the stored bytes. The data might be interpreted
> >> +using the host byte order, network byte order, little-endian, or big-endian.
> >> +
> >> +Passed by reference.
> >> +
> >> +Examples for a little-endian machine, given &(u32)0x67503030::
> >> +
> >> +       %p4ch   gP00 (0x67503030)
> >> +       %p4cn   00Pg (0x30305067)
> >> +       %p4cl   gP00 (0x67503030)
> >> +       %p4cb   00Pg (0x30305067)
> >> +
> >> +Examples for a big-endian machine, given &(u32)0x67503030::
> >> +
> >> +       %p4ch   gP00 (0x67503030)
> >> +       %p4cn   00Pg (0x30305067)
> >
> > This doesn't look right to me, as network byte order is big endian?
> > Note that I didn't check the code.
>
> Originally, it was %p4cr (reverse-endian), but on the request of the maintainers, it was changed to %p4cn.

Ah, I found it[1]:

| so, it needs more information that this mimics htonl() / ntohl() for
networking.

IMHO this does not mimic htonl(), as htonl() is a no-op on big-endian.
while %p4ch and %p4cl yield different results on big-endian.

> So here network means reverse of host, not strictly big-endian.

Please don't call it "network byte order" if that does not have the same
meaning as in the network subsystem.

Personally, I like "%p4r" (reverse) more...
(and "%p4ch" might mean human-readable ;-)

[1] https://lore.kernel.org/all/Z8B6DwcRbV-8D8GB@smile.fi.intel.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

