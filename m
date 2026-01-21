Return-Path: <netdev+bounces-252013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDpmFOcbcWmodQAAu9opvQ
	(envelope-from <netdev+bounces-252013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:33:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5415B500
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7074064D520
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C64C9000;
	Wed, 21 Jan 2026 16:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850F4C77D4
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014696; cv=none; b=Sjlb1u71dK4sOHVccO+ktlm7qRsCb9U8U+fkpkcQxk9ctkpT0habOhKZpSURQvzJbEKw+agh94hr+2w+AyY2IW1VTwQ8l/pia1kfE3QL7K/vdxAKdY980QEDvxcOn1AbuudLjJZ1QqmOOoKA7KxVgThM5Ua0aBlU7OrIXMkge8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014696; c=relaxed/simple;
	bh=b3ogj6jd4gJyBPweVAwHafFvv24RTzuF9Yh/ufegu6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFz1LVsCHwT3OqcVUNXLmugEa35JcHd6y9z0zDTE9npa0kEUuPtV7lJdx8f53CScBmt+uqNRo1HPU3F3dEaEhEdI/cMgP1Y9lAw+hUb0o3vljuBT+21z8CsWyMPnRUC/8aoUNLmNnO+huhtFtWY5XlFCQBjLgGOcBzIiBwnO3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-947fef8ebf4so750338241.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014693; x=1769619493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOHs6ISbQt2/MtdrNsjI0sr5MDVl1C3NbAZup7ReLuc=;
        b=IP4l916kEnNubCYvtn4Fl8iHDY1BI05CRMnP5/Qw9ajadNX4oVLOlB7S5dPCcU/Npi
         4FWKcbUVkzvtpboJzHLOTN04uNvUPGuGsVkmnTGKMDobrF3MYJdzfkQs/3XxUFAMdUmA
         8/BHbov8wp7F7E6V3r2TOZJ7PxGk+SQzmKzxpmVwqULYmtWMLUtvU35PMQW9GRndBpTy
         xl0RAF1umTukytG5CYFHOhEYKxvz1R6yuDaKbI4utA9N5QRd/KX3NoAMbbVkQd/iSrPM
         WbnFDDXLPBTfB9NyQFjt/N2Pwkyr0WeDcw7miF7MHWdccSn6V4DFDTjN7NwoYdpO3XX0
         VMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVtgAu72zI1YN78qV5bnEUSsdE8pTaVYrtBUV08k6MzQbMb5i14LmggNRAtQ5OsXr9EEhVlyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlT21lXZ6qL2fduXL8Ln/HFP7vtlc+ZzBqfQe3DL49pP/FasfU
	+kPBQbstHNNemNUUisWYBPc6vXUAKkzwy6/b+nKWTBqgmy7NTd/lr4GOAKOcaDAX
X-Gm-Gg: AZuq6aLYfGtosO+NX6oBs6RNWkYhFNzqYJyO91o9b5nDq/JB1MaBgHxFcXAQtqjGCCb
	+2eLTu8dh8c8lWYiC0CcY6LwF17TUiGcetH4tJ2vXRgeO+U33Vb8I1+XvGSIoktz/CPkUQZIkSL
	LdgXImZYCizh7fPievK6pVDWfoCuFwMi8OD8Mp5B+Sfu8quvtmD4jvkoKX7vlsQa9THxFxbPP3D
	5UV8wR1UkTi/VaxYCIi5zAb9dER7dETTw0lqa4+Qg3vMloPOKZHoc4DJSkca3XQCce7BkfCti7v
	moEivZB0Hk/qNYGi/XiCpjcrJo9P/YcxSssaDV5EbZRZJVaXERyzwwIFadiDilhASYPzxIF30Ix
	9jq8tjgfFgNIR340va0mBb3C8wVjGbev31W6zn7X8c0J2f4hwTjoexjszElj+4h2b/mAd9Z7z0S
	wWbiIUjYSAll3QxFKuqwQ8RRKUYthvfAVeG9H81BylmxcWOexoHBy+
X-Received: by 2002:a05:6102:d87:b0:5f1:5be2:114b with SMTP id ada2fe7eead31-5f532eef721mr22643137.20.1769014692977;
        Wed, 21 Jan 2026 08:58:12 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d03eaad3sm4777153241.7.2026.01.21.08.58.12
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:58:12 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5662c2937fdso29842e0c.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:58:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtDOLF3i15fXVBGjtjzxWMjMvIoTFwXzWzovlnIZT43rGRrEp3Usbk2diZYZtlnwdzaYJcrSw=@vger.kernel.org
X-Received: by 2002:a05:6102:b12:b0:5df:abc1:e6b5 with SMTP id
 ada2fe7eead31-5f532eb9f05mr16958137.17.1769014360523; Wed, 21 Jan 2026
 08:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
 <20251212193721.740055-4-david.laight.linux@gmail.com> <CAMuHMdV3WAxshZL9gw4+NeovX-9FjUZrk+coUAA7+=y6GmPECA@mail.gmail.com>
In-Reply-To: <CAMuHMdV3WAxshZL9gw4+NeovX-9FjUZrk+coUAA7+=y6GmPECA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 17:52:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUo_Xow2YwMaDzPUW8w-3O12nqguzvoR6ij0X3R+syvOA@mail.gmail.com>
X-Gm-Features: AZwV_QiSJroxALjrxdsqpeoTTwWrxn5dVEZ7lcW3LOyG_OvHN9voWIpFHqxAP7E
Message-ID: <CAMuHMdUo_Xow2YwMaDzPUW8w-3O12nqguzvoR6ij0X3R+syvOA@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Luo Jie <quic_luoj@quicinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andreas Noever <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252013-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,rasmusvillemoes.dk,vger.kernel.org,bootlin.com,huawei.com,melexis.com,intel.com,quicinc.com,infradead.org,kernel.org,davemloft.net,linux.intel.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[19];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EB5415B500
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 at 17:50, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 12 Dec 2025 at 20:38, <david.laight.linux@gmail.com> wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> >
> > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > not be used outside bitfield) and open-coding the generation of the
> > masked value, just call FIELD_PREP() and add an extra check for
> > the mask being at most 16 bits.
> > The extra check is added after calling FIELD_PREP() to get a sane
> > error message if 'mask' isn't constant.
> >
> > Remove the leading _ from the formal parameter names.
> > Prefix the local variables with _wm16_ to hopefully make them
> > unique.
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Oops, just noticed  commit 2fb6915fa22dc552
("compiler_types.h: add "auto" as a macro for "__auto_type""),
so you want to do s/__auto_type/auto/g.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

