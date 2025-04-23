Return-Path: <netdev+bounces-185239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89420A996F9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B28E3BDFC6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77D28CF4F;
	Wed, 23 Apr 2025 17:46:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8926772C;
	Wed, 23 Apr 2025 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430419; cv=none; b=gAub/Jl08UKgNBmG0QOClgXighApO8GLDEFRrCkykSY/toF01sOvfylFgQyXz5G7eHvJf0APUy91U9+bUfT7inwZ59WF8ru7Km83/wTUSBrYQOJ4KUDw4TioRP+mbUd7l1rqa41GnCxl554cYjPMtcXfeGzVN8ZrffL6xIhw7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430419; c=relaxed/simple;
	bh=mUzTTN/4NXsdcyMh1iWWXDct71g5yfltXc88uy92cmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I34bsEBDf+hh1+w7SZRTxOUaGBvJP1OT8pjhRzwXc3MHxs9qGBcYyFe8c/EYh483ONzAWRd4X83P1HU/f0bKvjw493fEGjF9OuXI/UcYx4HqrZcoouj8OSccxkd+2Gix7nvlI0Xz4Jdtgsx+j2RMSsptL+UQK0pR+GkB+dVJiVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-873ac8037ecso60586241.3;
        Wed, 23 Apr 2025 10:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430415; x=1746035215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLqipjscszx2Mp0FY64qeFZMiD5TTEV8hZP6rO4hjpA=;
        b=TyLVeEkWhQLYwu5MoSI0oFjMp5B+FTPWyNz4nHIWpMUQ6M3O4uvTCXC2vBj3h6DtaF
         9ImT+gfVKc76fPxVcimeD64zJdtJIFETuItUB071U9d0Ah5rRq2qnFAZ0E+kz7zvh8fm
         uLrFvBCfHse/MSD2cu75rm7ffxzRfRR9Q+78wvs7x5p6UkjTGreuYUQGR5LvvHjKz37b
         5w2StymfYc17xWhCm+NRHX+eVhxU3MYAXg8KNY0SKlLuPUqTlUf5mgjCKHasnbXzj7I4
         IZxgvUq625W4DeU95IhQ7cf4XZtH2gsM81LvVSm9LhYlwbVsOTkT1fq+G4JJ6W3NrPn2
         NPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtqtwB737LFfEQQcuZGpxH48VN1MfRB3gjcPtAGwgnxt2d7EPoOKVgmikWjfDTLQx1N975/utw@vger.kernel.org, AJvYcCVLswJjEv6p5mfd8nwPmBEFuUcZvVEZnft4cY4V0gEu/T0wKxkfCWP64R7Q4rvYZaDR/THJxDGcWHDtSpoP@vger.kernel.org, AJvYcCWsl3XHT+9KlvUgfZVAa2J9jfvXb/cxS1NCv1tUdj9L7Clklua/kRx2mrI9+30w26R9Qc16sWAp7TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJ28/iEHafffddCedwvisGv+6fV3HLAjYDqnMl0G/1rn8fbVw
	8rnrQz3A0esQbhbH0RV1Wm8jYyOABLRGIQPw0tadi2ljyoizLaCkGkaTx2wKHl0=
X-Gm-Gg: ASbGncuEC7QgXRonJWM3sZc6zBvninXyv+E3aK1e5BMFexm9j0lmwdg1vqgXZ2ZzIGh
	TFsIzX73FHUXadhxBFpJPEPKGn6fc3Mnwvt96+ohPq8ipEDS7TzWTOIgyT/uXLapeGyAm/FARxM
	e6mAwVeoEgm7pf8Um5pdsTzi+TMKHB3WVgiftD8WifL3A5LwN4YgyoGKJUaGRBXIXWERQdox0Sb
	X3hI2MSvp0Yc3LXL7Gzqou06oe2jIDO7kNuBJ1vB7080f/fAhjH4HLUl5PZii9aC3Fv8KJgxLod
	Armd0no5ldBfnFa6RDiGz0o9qJjrpEWRqZxt0aZm+l4oRTapqmNWVlBUiB9StKXmKgSYjIcgG1y
	QwHLuB/A=
X-Google-Smtp-Source: AGHT+IE+gjuwIY1FsGyjscWq7LtFgQq7O+yKZ8X9hbDn0qAWEGwtA48+ObWTnEd63Ov1+kbdpwE6Ww==
X-Received: by 2002:a05:6102:15a2:b0:4c1:801e:deb2 with SMTP id ada2fe7eead31-4d37bed5052mr213141137.7.1745430414838;
        Wed, 23 Apr 2025 10:46:54 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87764777674sm2894884241.24.2025.04.23.10.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 10:46:52 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-525da75d902so53099e0c.3;
        Wed, 23 Apr 2025 10:46:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJUlHc5yj/t8cOmysbqLaTGSyJl64xCd2DlinA0G9VxHHpusY/QAIjT2dGO8Z2AngqQAf8hjxlZ2k=@vger.kernel.org, AJvYcCVi7xK4z60PdOc+vV897S2k6p4YdOtvuMr9AZk9wBUMYtNc1XcZyadxsAbOu7O0WK5EiYX00UQ0@vger.kernel.org, AJvYcCWzsZSMeRkCNdJLHx7to7hlCZ+PEGaRdwC5SnHQ0JGye28uRgGXEXDg5AJjOjEI4FF6WlKuizts7Rf+We52@vger.kernel.org
X-Received: by 2002:a05:6122:2a02:b0:529:f50:7904 with SMTP id
 71dfb90a1353d-52a76b54183mr283580e0c.9.1745430411699; Wed, 23 Apr 2025
 10:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597382EFDE3452410A866AEB8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B01823415CB7FCD3BC27B8B52@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdV9tX=TG7E_CrSF=2PY206tXf+_yYRuacG48EWEtJLo-Q@mail.gmail.com>
 <PN3PR01MB9597B3AE75E009857AA12D4DB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAMuHMdWpqHLest0oqiB+hG47t=G7OScLmHz5zr2u0ZgED_+Obg@mail.gmail.com>
 <aAjthvTuIeUIO4CT@pathway.suse.cz> <CAMuHMdXuawN0eC0yO40-zrz70TH-3_Y-CFSy6=hHCCMLAPvU5w@mail.gmail.com>
 <aAkVcaRrMmqXRSFz@smile.fi.intel.com>
In-Reply-To: <aAkVcaRrMmqXRSFz@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 19:46:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUkhJm++zitVRQdSHJUo9McjYGeVz4Frv2sct_Can+aw@mail.gmail.com>
X-Gm-Features: ATxdqUEiZpgKy-OUmSil13Kt3gOTH1qjKd6FZI95GjTyFDCgENU6kR4WqaMubEM
Message-ID: <CAMuHMdUUkhJm++zitVRQdSHJUo9McjYGeVz4Frv2sct_Can+aw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Aditya Garg <gargaditya08@live.com>, 
	Hector Martin <marcan@marcan.st>, alyssa@rosenzweig.io, Sven Peter <sven@svenpeter.dev>, 
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

Hi Andy,

On Wed, 23 Apr 2025 at 18:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Apr 23, 2025 at 04:50:02PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 23 Apr 2025 at 15:39, Petr Mladek <pmladek@suse.com> wrote:
> > > On Tue 2025-04-22 10:43:59, Geert Uytterhoeven wrote:
>
> ...
>
> > > The problem is that the semantic is not the same. The modifiers affect
> > > the output ordering of IPv4 addresses while they affect the reading order
> > > in case of FourCC code.
> >
> > Note that for IPv4 addresses we have %pI4, which BTW also takes [hnbl]
> > modifiers.
>
> Ouch, now I think I understand your complain. You mean that the behaviour of
> h/n here is different to what it is for IPv4 case?

Indeed. "%pI4n" byte-swaps on little-endian, but not on big-endian
(remember, network byte-order _is_ big-endian), while "%p4cn" swaps
everywhere.

> > > Avoid the confusion by replacing the "n" modifier with "hR", aka
> > > reverse host ordering.
>
> Not ideal, but better than 'h'ost / 'r'everse pair. Not giving a tag and not
> objecting either if there is a consensus.

That is worth as much as my LGTM ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

