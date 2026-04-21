Return-Path: <netdev+bounces-280094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDNRHotn52ld7wEAu9opvQ
	(envelope-from <netdev+bounces-280094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:03:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6543A690
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF7B3068EC1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934539B965;
	Tue, 21 Apr 2026 11:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD1347514
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772671; cv=none; b=qIZzMzbLPKTj0vvN88EQ9lrj2+s7hYwGH4IbeDo9GXgrA+E9jfjSGnK9Swt1/gpWkGKwGGljjgL/Zqvvxj3d8mVfCNwvzuQfcUqTdx4+ec6RB67Ecy0h1w25udFHv+jIMNcBJkgVG8dldPEnjjEDmicvW4hAIa7chIIzoYFPhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772671; c=relaxed/simple;
	bh=D2pg4QST6SQsj9Y0AlZ3xwmYOqacTuU/qi+aAUKUt00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJHX3Jkt4zq2UD5GAYMCpKv2f/BZlIv+vg9c9KPDAofuSfS9E7Uw8gCnFSiwEUp3lP2r3VRZNUxrXz2rTDRVI8dyUGR/WPcNoOiN9Tx9mANGcz5VVnH+qhT8HDFDFD5pJs6ZSrW+TveaprlvXs7qC0fGp23Exc5tiJ9d+0DjKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56f65f62b4cso1376482e0c.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776772669; x=1777377469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ji5jUeRQ9s6IdrcvkqpKzzaDEFKSxwSRUCTUPQc2w4=;
        b=qkKcGNHe0zZA9yuRWK2wVI7mdaQZ5tt4EPoTcqi9XbwfmKYzoaiWfGjPobWGO+5136
         lP/xoGpnken6xhLwmop56dM5y2QD1rwt9GlrkaFPa+FSg7HyPsUr/zNxw0g92AEtMjx5
         vbihkAwbrdLtbyVaqeDTY1pYCuLxwp2bi1Cj9qQQ+OYacwiqEEfXQzcWzVvQxpTkGNVa
         7zx4eNMHuzESrV73EzhXhmQHAFqFJtuVjLCHRmFWZgWzH32HAzVY5IRZNqgefWzwxrai
         FW8mITBMakogJe939fgkrODMaSrL0mFtZ5foFuH5COx/n20JpkPxGaSjUpSeMvvADqv0
         GGsw==
X-Forwarded-Encrypted: i=1; AFNElJ+xUqvRACVhVsQxRJmrGiQAfxhkW4yJCsmsiTaMEK2RPJxMvQM6LZYoQ814db0VylcXFiNdvV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8CnxIg1oi0A/CokbcUJy05NgKsHB6MYuOVDgiLNeagNMSJlL
	iRd0RsUmZLyE0gQwJIvE9lq6LO5osL8K4Xoq+dGPXTYFYfz19/YVQOw04Icl4aCa+UQ=
X-Gm-Gg: AeBDiev1HMJDRxe9t5eOQ41V3OUBHDHDM6G/xoKT66Y1AFjLiDTUq+wOY9Ik0qDaPTN
	NH+2WqdzOrZktMiPgzgU4vB8DnYnxZWwKhi+LyEjYObfkjNpT8SIQnPUlrChgaeSmwESCGrpubC
	W7rvfpPgMFu6iqH3ALYxjj6pxwIUtkfcVrcehdTEDeLBFbvOrhZUfS5wB9l7bKL4w7K3MKh/yix
	C8pncjJ1X7Nt0qAzDTbbJILvs6iIm448U6FckSBwELyRF/V0T3WPt7Rqf8jX4w26zkg/jYTUTi3
	5PZFpeyCO9F1LrIpu0OIeEE6sPdcJkHd15GYYtQp7Ojn32hxGonAFy4AhM04pSbqxqVYOCRNXYP
	q9s3FfUg/32NsIRMkJPrDjCp0Oe0O84Ik+jrrKrQJBSn3oJsEgBWqiTL6lFzLsK4OGVYXWBrUdy
	YTgMwK58y1RSCqDyuhiOmWd0Pz1guOiZSk9OHjz/q3X9WFYGqui/uf5SpDnLLRLeyxWdMhzkM=
X-Received: by 2002:a05:6122:4b8e:b0:56b:a673:27bb with SMTP id 71dfb90a1353d-56fa5875f49mr7405351e0c.8.1776772668626;
        Tue, 21 Apr 2026 04:57:48 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93253aesm7609743e0c.14.2026.04.21.04.57.46
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 04:57:46 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso812581241.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:57:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+RT+wVwrPB5Fxkr0xmqF9ntHDCz2uoWC3+2MzO764FHUb2HV87hOnSt+WOYp5/Mzw1gTHfHfs=@vger.kernel.org
X-Received: by 2002:a05:6102:f8b:b0:601:f386:9ed2 with SMTP id
 ada2fe7eead31-616f4d67f72mr7641295137.7.1776772665998; Tue, 21 Apr 2026
 04:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421021943.1295109-1-kuba@kernel.org> <c7506c225ce22a71c03abc2673823cf84bbb5b0d.camel@infradead.org>
 <aedkZ5bizasuBPI8@gondor.apana.org.au>
In-Reply-To: <aedkZ5bizasuBPI8@gondor.apana.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Apr 2026 13:57:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU96F_42faeqNzDwaXks7mFrLrkPSJB_QTwxEn9HmVWpQ@mail.gmail.com>
X-Gm-Features: AQROBzAVi0Fh-UpifM1LaPGNEDH0ax6I6xOmcEB0yUP_KKo8UOyxGmDNb2nIMYw
Message-ID: <CAMuHMdU96F_42faeqNzDwaXks7mFrLrkPSJB_QTwxEn9HmVWpQ@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove unused ATM protocols and legacy
 ATM device drivers
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org, idosch@nvidia.com, 
	jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu, 
	ebiggers@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com, 
	kees@kernel.org, kuniyu@google.com, fourier.thomas@gmail.com, 
	andriy.shevchenko@intel.com, rdunlap@infradead.org, akpm@linux-foundation.org, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,lwn.net,linuxfoundation.org,armlinux.org.uk,alpha.franken.de,linux.ibm.com,ellerman.id.au,gmail.com,blackwall.org,nvidia.com,intel.com,mit.edu,huawei.com,linux-foundation.org,lists.ozlabs.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-280094-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Queue-Id: 24C6543A690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Herbert,

On Tue, 21 Apr 2026 at 13:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Apr 21, 2026 at 10:26:18AM +0100, David Woodhouse wrote:
> > I suspect they don't have a huge amount of interest in the Solos any
> > more, or the Geode-based SBC they sold with two of them on-board. But
> > OpenWrt does still support them, and I even have one here (although no
> > ADSL line to test it with). They were briefly popular as fully Linux-
> > supported ADSL routers.
>
> ADSL is history, it only ever made sense in rich countries where
> physical copper cables were pre-installed in homes.  While rich
> countries have moved to fibre, the rest of the world won't use
> ADSL either because there is no copper cable to begin with.  So
> it's actually cheaper to just lay a fibre cable for a new install.

I am afraid the move to fibre hasn't been completed yet.
ADSL (VDSL2?) is still being used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

