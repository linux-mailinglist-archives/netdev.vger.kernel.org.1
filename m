Return-Path: <netdev+bounces-195310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0CACF779
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 20:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1168516D396
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E816F8E9;
	Thu,  5 Jun 2025 18:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D120330
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149388; cv=none; b=AzNE3Q4KaBHkM3vEUaVlbAE+w7AAI41F61rgGA1zkoYd/e4SGYahbAct8Yik8mMxnQQEwNRAiCrnQzz6a/Vre/dVAZnBjehLhTbkQSZTDvGMekTH/DqmW3pXem38cuCSbDh7gBqZbnCEYY+uFBahX4yI5eQewF3lQ7bq2qvVHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149388; c=relaxed/simple;
	bh=oE42TNQ9vn1MVDyYe52LAO5KlhVGjCJEVpn7NksSNsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXDlssB5HSK/dBXpV8HiLBBAcsEYqFZlmf+8Xs1PoUaKT7LOvexVZJwqnyG7V5kxGTZyYIZAYlNQ+8dWHjUX7jA+F2SHf4kK86eO5mkngCSlGYc+9/B9x1YFwtq6b+l6u8OsdJZhGZGHMPFtxJKFt0IQbKWljzWywnFjLOr9Pro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52eec54acf4so435058e0c.0
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 11:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749149385; x=1749754185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOJnn/WmkgYtvn0pxnbVtjZ16lPc7Y6nB6FinPlt4ss=;
        b=EvYw6z6GYQnCj2HvhCNb3TFCQQ0iVRYWk2KsTyJRi5IBWIEsCHhF6g//zlupNuJUen
         Janm09oP7nNcTdtun96JAnQnqhyVA/9aj4sv3TLuko4LrDuh+pbMvwbufrlaa5W0nj/+
         lkU1udAYtvSoLIq3Ohw4xSEPPus3Z3gwOwbeCM1NCKhTBlhh6HpAyDNbNTXgoosC3I3y
         9BoJ1xaYRAHeTuZA0rBysu4IZNBDiOEZUHSJgZeDdbL/yf9t6wMdl+fJuN/rEoGJdp0I
         d+FnHmd30urn9z0x0duR6wyZlgIL7RtYjc0wG9kLu9Erl1PgpfO6Lf4IDi5nkJv4J+ti
         4W5A==
X-Forwarded-Encrypted: i=1; AJvYcCVLGBdD7HsY5NAZXaxW9ja9x0gr3BmBIdtiIJjs1V7ACa6Y3uNz1JAtPjc15eBZATNV4aSPNv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfuzApl5t2IS1+rpAB3Shr7kgV7bYkYVZr3HhKy1yjMXqRnB4
	5VM/h64uQAbhoUChquN3siq87mMojXNK4MQIryA/6wuvU4T7IXKjujQk8FRkDg1bdyc=
X-Gm-Gg: ASbGncuCD6AHn2XwRY5LZxBvdGdTNFTfUKXO5xaG8lIpO6pwyUV2G2VsQbYbUc0684b
	I9UaMhD0n9v+siFqZ7mbdRAElZjIKS+ju6nRClIedfSc7eTAwJm2VkxeZ2ZqigPaWWvS0AcPj5c
	1iyB+9gLUoG8JUCjgSyGQQWaDhbC6l0O99y+/fe4OuKt7w++LnGBJ1bAtbujJ8tDr2MfgGyvm9W
	6s/PRt75T/E6mlTnRdLvT1uCg5ZpOxXjwfMcZOYTDjR+kRHxHE9jb9Te/GJTnhm87dNkmqzpqsH
	lmH4LCr0N+qY6J8PADn2lPfSDfj/a9Dy1npr+VylHbk+/c+89y1qDxqY5/h15LmtLKKUcSNtmwe
	qXqB6qpikvXPmxw==
X-Google-Smtp-Source: AGHT+IFuxSQAU+7IjFIMT4tt8pbwPIch0RE7b+Vl9eEJyzXgMhnQL6i2PLy3VwxOMGdrMW4ycDXuBw==
X-Received: by 2002:a05:6122:1ad5:b0:52a:ee1a:4249 with SMTP id 71dfb90a1353d-530e4880ceamr905423e0c.7.1749149384648;
        Thu, 05 Jun 2025 11:49:44 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074ad8eb5sm12922140e0c.11.2025.06.05.11.49.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 11:49:44 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e58e0175ceso328277137.2
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 11:49:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4M/4yAq3ym4HukYqZLuXZlB3VYGA+MFV9EDVz1vYs2fX5wEHG1RMggei2zX1NskocOvoPo9E=@vger.kernel.org
X-Received: by 2002:a05:6102:4403:b0:4e7:5e6a:12f1 with SMTP id
 ada2fe7eead31-4e7729ace8bmr508931137.15.1749149384093; Thu, 05 Jun 2025
 11:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423103923.2513425-1-tianx@yunsilicon.com>
 <20250423104000.2513425-15-tianx@yunsilicon.com> <20250424184840.064657da@kernel.org>
 <3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com> <20250605062855.019d4d2d@kernel.org>
 <CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com>
 <20250605065615.46e015eb@kernel.org> <96f53bdd-13e4-4e4b-ab8e-3470782df3b2@lunn.ch>
In-Reply-To: <96f53bdd-13e4-4e4b-ab8e-3470782df3b2@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Jun 2025 20:49:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUk8G0MdoCA9ZyKDJNRC0pbcR0CpfLzpe347OBALADt0g@mail.gmail.com>
X-Gm-Features: AX0GCFtePyha1zT1Hdb0O3CK-rq8MXQIwwTCroIRabRMixSgg7kA9jiG33vO4jk
Message-ID: <CAMuHMdUk8G0MdoCA9ZyKDJNRC0pbcR0CpfLzpe347OBALADt0g@mail.gmail.com>
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org, 
	leon@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com, 
	edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com, 
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com, 
	jacky@yunsilicon.com, horms@kernel.org, parthiban.veerasooran@microchip.com, 
	masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com, 
	geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Jun 2025 at 16:05, Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Jun 05, 2025 at 06:56:15AM -0700, Jakub Kicinski wrote:
> > On Thu, 5 Jun 2025 15:39:54 +0200 Geert Uytterhoeven wrote:
> > > On Thu, 5 Jun 2025 at 15:29, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > On Thu, 5 Jun 2025 15:25:21 +0800 Xin Tian wrote:
> > > > > Regarding u64_stats_sync.h helpers:
> > > > > Since our driver exclusively runs on 64-bit platforms (ARM64 or x86_64)
> > > > > where u64 accesses are atomic, is it still necessary to use these helpers?
> > > >
> > > > alright.
> > >
> > > [PATCH 1/14] indeed has:
> > >
> > >     depends on PCI
> > >     depends on ARM64 || X86_64 || COMPILE_TEST
> > >
> > > However, if this device is available on a PCIe expansion card, it
> > > could be plugged into any system with a PCIe expansion slot?
> >
> > I've been trying to fight this fight but people keep pushing back :(
> > Barely any new PCIe driver comes up without depending on X86_64 and/or
> > ARM64. Maybe we should write down in the docs that it's okay to depend
> > on 64b but not okay to depend on specific arches?
>
> I agree. I expect in a few years time we will start seeing patches to
> drivers like this adding RISCV, because RISCV has made it into data
> center CPUs, where this sort of card makes sense. Its the fact it is
> 64bit which counts here, not ARM or X86_64.

And perhaps little-endian? ;-)

I am delighted to see people are working on big-endian RISC-V, which
gives people some incentive to keep caring about driver portability...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

