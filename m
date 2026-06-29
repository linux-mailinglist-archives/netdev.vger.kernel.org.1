Return-Path: <netdev+bounces-302518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QqJ4L3c1Qmpn1wkAu9opvQ
	(envelope-from <netdev+bounces-302518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:05:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB56D7D9F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:05:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302518-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302518-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D953021E78
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232733F8899;
	Mon, 29 Jun 2026 09:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A563CB90A
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723719; cv=none; b=SGjbaLonvbb/aVKulGTVnQsrw95L2npekG0+550bk7/XADz0cuxwm+P3wLW3Yls/Xi2GeMyUMrOSKiw3xXEHHcMAQBz01y5rdynBy38wstoIdiqP0kbhKEUJ7uPAnS9pvH1IlFKPzOOhLHoKXZX2EF0EhUt01CEvpoiEGN89ivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723719; c=relaxed/simple;
	bh=3VKl3iFU5RbwK3KYk3lekBeyfpcYW9UDaDcy6rBp9dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUo9bCklPU/ZI/WKqZ6hBhSI2xTiIcmEWqYay+5mCR+3lGTRP10yqax5vCv0xoI8B2yjdsvhcfy5VFrTfdF/5g0OIuG1SZ1+g1CRlNr8tF0biDtgLtEr5VL6cWKYU+nHjPUBbdCoCqix33ri3MYbyqRPfkhfVO2K5p0g+mD8Wpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-59ebf30a91dso1425533e0c.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723717; x=1783328517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWCa9Iijq4T0FbxC+lA9KqSW7TbKNleAvoiJYHgYTME=;
        b=rJFh0jEciGO58OyycrK9CNRIVG2kl7JyDfgizmzVhZLlUV40/Ug6Q3/Y2Kyr+4uc9P
         JwxFBrfBeda9Z9t9wnqm++JINaqSKNi/ucixM3NJdD2zRE6Rg2gEgXr6sQ3V9R8TcBfh
         ChVNw9OYDX82VYC/4SC4RvLxNEDbkpwaYp5ONOJn6rIHNQiH2bqKzN6u4WIDdZfCCLf/
         xi7LXjoCgbqsbLyUsuYKW9BuAknzg3ur9u5vy+nGhHoOiSS2yetvo4eZXBK9hzSsXyQM
         GF69ylNv63erg3VDdQp+xQDilU0ZB9sX8A8XkBu7+yOqkJ4coLFstFTofkLKecrAGsjE
         4gSg==
X-Forwarded-Encrypted: i=1; AHgh+RoKGb5YhkHqGYA2SkCtMJpw3dkRN9P9qXKMRvVC0WycD1YvqldUZo/OiO77HXZjQjAL838+yzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgHZ3jvpu8vf48fNulqLrjhQrKhYbiRkrsM14OqfufJeq0Tlk
	0z52Uft849qq2V/+2E1CqNPnKNfUzcK4qf297ZzClpckE9ZUUm8CAMN3JBjdl+zf
X-Gm-Gg: AfdE7clJHa1WNY7ySiRuXw81NjkedIDNiq+IOV+Z2kU8p9QRnDh/yiBupGHQW58GZdi
	ZPxBC/Oh8dJhsxNwjpcMx78n6JKNSWv5jfqXmG8Qhsv55JpL3CNS07uhW131C9Fh/hlKLBeC/8p
	ocdOg6beeR8tc/lJUsY21RFMqmOmnqXsmsT4wcA4ArbcPc8Jb69NrF83IwP/FYESmNUEHJlNlwg
	sW4M7+wQC3kx2M2hxl7URDwM9hanaBNE17KaupYMkdkKldchtRJ09xoKcgekC1jAEHbocRyusVP
	rHKN/MiSpwVk5K/lgkh3MMVQcxuw3S3iFu1Yc3nIkjSgZhQCqm2tlkwuAHy5PTPh3FobK2JIPN5
	6nB/mGpqXDWRr5wtKVugpJt6nfNxB/obk7i4QIHp99EloEKWQ8Zhh2iZxhrNNIEMfCzcDRD54fP
	KSOptxv/Bd4uCWN9QYx+NICql4Ap4dTvuOxvIx/h/fhuSm+nlTkg==
X-Received: by 2002:a05:6122:8709:b0:5bd:6a65:2822 with SMTP id 71dfb90a1353d-5bd6a652adfmr5709539e0c.11.1782723716709;
        Mon, 29 Jun 2026 02:01:56 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bda7531960sm1400598e0c.7.2026.06.29.02.01.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:01:55 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-738b39dad22so184315137.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:01:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1qyffBrLQW0Oh0sDq2p9kW6fRJ9AMr1gTytYW7879Q4X7e5VwxZsamV9eKCj823rEFLPLEsQ=@vger.kernel.org
X-Received: by 2002:a05:6102:2b95:b0:632:29a5:2b28 with SMTP id
 ada2fe7eead31-73433b204abmr8037345137.6.1782723714413; Mon, 29 Jun 2026
 02:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629054143.7737-1-note351@hotmail.com>
In-Reply-To: <20260629054143.7737-1-note351@hotmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 11:01:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMx1zAgnzkoYqDB8TOu7s93L4f1PoeXVpYm1n4=dESnA@mail.gmail.com>
X-Gm-Features: AVVi8Cfdpu83rU3NuQjfbLCIaCqIS0USSfuVxDZTaim0eb6Wn6uZrpMkmnArI4g
Message-ID: <CAMuHMdWMx1zAgnzkoYqDB8TOu7s93L4f1PoeXVpYm1n4=dESnA@mail.gmail.com>
Subject: Re: [PATCH v3] lib/random32: convert selftest to KUnit
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, 
	davidgow@google.com, visitorckw@gmail.com, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:note351@hotmail.com,m:akpm@linux-foundation.org,m:thomas.weissschuh@linutronix.de,m:davidgow@google.com,m:visitorckw@gmail.com,m:brendan.higgins@linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@googlegroups.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302518-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.com];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,linutronix.de,google.com,gmail.com,linux.dev,vger.kernel.org,googlegroups.com,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-m68k.org:from_mime,linux-m68k.org:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ADB56D7D9F

Hi Kir,

Thanks for the update!

On Mon, 29 Jun 2026 at 07:42, Kir Chou <note351@hotmail.com> wrote:
> This patch converts the existing prandom selftest (lib/random32.c) to use
> the KUnit framework (lib/tests/random32_kunit.c). Unlike typical KUnit
> tests, this file is directly #included into lib/random32.c.
>
> The new test:
> - Removes the legacy CONFIG_RANDOM32_SELFTEST from lib/random32.c.
> - Adds CONFIG_PRANDOM_KUNIT_TEST (defaulting to KUNIT_ALL_TESTS).
> - Moves the test logic to lib/tests/random32_kunit.c.
>
> v2:

The changelog belongs under the "---" under your SoB.

> - Removes the legacy CONFIG_RANDOM32_SELFTEST from lib/Kconfig.
> - Add const to arrays in lib/tests/random32_kunit.c.
>
> v3:
> - Changes from tristate to bool in lib/Kconfig.debug.

That's (IMHO very) unfortunate...

> --- a/lib/random32.c
> +++ b/lib/random32.c

> -core_initcall(prandom_state_selftest);
> +#ifdef CONFIG_PRANDOM_KUNIT_TEST
> +#include "tests/random32_kunit.c"
>  #endif

I guess that is the reason?

Any reason why the actual test code cannot be spun-off into a separate
module, so it can become modular?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

