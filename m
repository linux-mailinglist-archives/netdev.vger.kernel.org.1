Return-Path: <netdev+bounces-280340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHGHA4N96GmsKwIAu9opvQ
	(envelope-from <netdev+bounces-280340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA574443213
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2D9307BC9C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0913491D0;
	Wed, 22 Apr 2026 07:42:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449F361DA6
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843772; cv=none; b=jMFJMGI1Dr4Qll77Do+rfHTGP+Q9RGDXPc8T5AZuy9TuuZXn2XELH+C4NN3nE0c7zXvWGpfIpZEFRsOW9clIc9fEKK6hrfROd3HJ6OVc3eYD8maOhDNEjLUXvmVxO48tImyZLmrhFsOzBQMkuJkG5WBYLM7vGSF0LwA0DImRcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843772; c=relaxed/simple;
	bh=fD4N6YiOk3Lw0qJqPZrZNHLLHCdobA7HmjYpR1mnjZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct0o5NMM14UEf9GaocLQnxNZcnLPq6jud98e7HvsSsLMvihS9a0O10cvnQmyZJAkKpyO4BTjGc3gVxWHnBhfpBeNEmzRnIGFmudGBOleaOlhsavSeZNtM5F6XcMtZdFOaRAH2XMp3MNRoQic7ma2AtSsbNqhYSZD+/eIhssCKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d93355337so3212310e0c.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843770; x=1777448570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4Rnr8wLv+N1gA5zZXLnYHFvuENgvXtTyEDrjuG6/M8=;
        b=XUR4wKqCCYoyP74ypM0rfT4Vv3/KXw4stP/oDYc0HJNzXdAdBl/kBGGPs6b10fqENZ
         qNwjWpE+iWfhSeL057zqwXsQkQ3CzkeqX79DxzMYu5xDAOkArSs4sLIUZ0oljXrdH6hi
         5qtnX+RXoAQr6NdjvThO+CsSDXIzp6SBA4gog6NG/PQHVR4v4fhHTlAc5q7HJ6xqYozc
         Eo3bSqTrg2Xki2L9Pd5utg5cdzv2zA2xLzJ8i2nXIheusuJvPwtCue0cybiP7GhddhRT
         PW/eldwJML4le2KcwFJlFkxPOib7ZL6uGfRq7p/RCX+VqWSNcVatkCWVmyfulvBQy6X/
         bNEg==
X-Forwarded-Encrypted: i=1; AFNElJ9klvl+yZZk7q9MSditPuhX7VEzcCrGdiqX+eRtkTZVlzV1REbJa4HGZdTaq9XhaGqt11qjQdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnhkyzrOwp8BY+8zFMvJjI9wNtc4omQq3m9H/VFfWzPEeCPH9
	gQQ/fEkoSwPF+XgEPtnOvA5TDHwcwcGBschk2DCYf8kCpV+PlAk7psfwUbXZchwUAqU=
X-Gm-Gg: AeBDietXWL6qPKYLDLtD+rD3QvLjJRmhg/KmBiLOaILCKXTE3Woak7Oevs0E8zX+cjv
	RA+kogg9ZuGGXw2XJfURuW1vnweDi8j7EfuSpy4vumseAX9A+qyFgwlfzoK7642Mx7ExfGr/F2+
	i3VvoZkdFRGJggU1Bn7hekwEJ887yfs3unCCz86yB3F2OObmnPaX6rvDjId8ph1rJYUNRvk52Hk
	ZV+b7ATKgCOjWbBo0jJHtC8aYZqVjubfxaQAZZu76QknU0Vzkw9cDf9DkXHog+gJ43jgOv6rqiM
	hkQJWUitqbfmY9lR2hB2KXxZ6OTBzvW7EuK25V93x43VfUz7nW348G1pRM2Y7ItoYKKkrF2QQ3F
	b+l/e/wWReKB2/2+tJmEeL/R++ci2IDrhQPGEt32weFMqYEmk+I446YdQ4pVMsQOWF0HhQCFmDC
	gV7w5DEDuPl8QwuIlu9DO070viMWk3HzObFucPixrYLvRqhhFNVqjRMAR9XpB9CCyMGJ9SCjY=
X-Received: by 2002:a05:6122:4903:b0:56e:8afc:de8c with SMTP id 71dfb90a1353d-56fa5878d5amr10850649e0c.3.1776843770486;
        Wed, 22 Apr 2026 00:42:50 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589097ec5csm7426928241.4.2026.04.22.00.42.49
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:42:49 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60fa13bde2dso3338941137.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:42:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/sPMsCqYelxbjLt36/PtfqrxFqr6QV0k8j+5bWDAGdQhmiglHttw4UgE89Mq7P46F44jv6MoA=@vger.kernel.org
X-Received: by 2002:a05:6102:5716:b0:5f7:2568:abb2 with SMTP id
 ada2fe7eead31-616f4b4be78mr10527273137.6.1776843769367; Wed, 22 Apr 2026
 00:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 09:42:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUizJDoOhe-2LmrsxA_9KO2s8dhA5Phvg4hiwM2ktcWmg@mail.gmail.com>
X-Gm-Features: AQROBzBnXX2THXUxNwhNfRNuDrFyV8eZ0eJfo6hdqIs4FC65H46_PpGDjaFPLYE
Message-ID: <CAMuHMdUizJDoOhe-2LmrsxA_9KO2s8dhA5Phvg4hiwM2ktcWmg@mail.gmail.com>
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-280340-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: AA574443213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Tue, 21 Apr 2026 at 21:31, Andrew Lunn <andrew@lunn.ch> wrote:
> These old drivers have not been much of a Maintenance burden until
> recently. Now there are more newbies using AI and fuzzers finding
> issues, resulting in more work for Maintainers. Fixing these old
> drivers make little sense, if it is not clear they have users.

Thanks for your series!

> These are all ISA and PCMCIA Ethernet devices, mostly from the last

Only the drivers that depend solely on ISA or PCMCIA are drivers
for ISA and PCMCIA devices.

These are not:

-       depends on (PCI || EISA) && HAS_IOPORT_MAP
-       depends on DIO
-       depends on MVME147
-       depends on ARM || (COMPILE_TEST && !PPC)
-       depends on MAC

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

