Return-Path: <netdev+bounces-279008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLYTOFPH4GmjlwAAu9opvQ
	(envelope-from <netdev+bounces-279008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3F40D5A0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3BA300F9D2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871639B977;
	Thu, 16 Apr 2026 11:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFC38D6B1
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338536; cv=none; b=P7ZNipI5TGbuuQU6dEzTMOQ9veOfSx/MqUrzTkmniHOn6K6HatzfmTvCLEQHEZM3o7dSYnSf8GUYNniL3WWTakUbvMwlWItjV9sbop0mOFNP+tXfbNX9wxWWOZjMPFkEnHIyE06I2id6fmCaE5hPqJBpGeCU5O2GtlyHxbvWJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338536; c=relaxed/simple;
	bh=FSgVIzpnraycKQsxAztrNgNSM9On/XU1ftEj+pCL/gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDPAc3tjApAs6PildSS0pVIfDl8NXTZMqTJP+ecRUqIqU4mcD3pxv+irXINwOCw5tgUOcNNC7VbqcaafJKfDXyy5MXys0flbh5g0W8lIvtaBvQthevkUJ0HyWlBopiEyLwIrFxdBKmMfr45cZ38o0XBOYOqAXzJp/cD0Gword4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a857578a8so3049435e0c.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338534; x=1776943334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
        b=F2oKU6s3HfDH3NqBe/keLskwroAziN8WDTZ1fcrmXaGBigiSJlmW+5hWG7igMvQrr0
         2rzawKkTR0ta6b1pBve5DZ1ZDs9rrpjzIhZogaP5JTOy1ShCYugt417JczkWbh2C2vPK
         xEiOpDw4OQBXNWNOGCZunvQfs6J6eHURsjqbK2hgdf2pUoa0dmitPq7Aks2YNWvdzIHS
         OiWAeodou8tEFpYBnJLG1GNHk2wCdPKqI9v1h/+PQy8da9/Hi8p/NnaxB1T6e0TvZqOE
         8GD16DdSr6UkyC+5FK4AnFRM2yX8xvVxP9y9v+aANMxNT9CQr/vR7vmkYyznsAFBcEEw
         SGZg==
X-Forwarded-Encrypted: i=1; AFNElJ/PruFJBIuwV19/v6KprwIoVP1pZIMlsgMDgwic41fm2I4LYbH5SjbR9pQvjv7g3Qdl5SCW1+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGb/s9HvuBGin/mxc5Nrj+I4RGgFofhLyQJaH7BooVzM0EP7Yw
	C30mFa/iZ8uKr+4H+sIXj2yMR1ukea2hcKfTY7KGpxA7zU7MK20rv+0TVKYqVVZy
X-Gm-Gg: AeBDieurzVK8NgdhojrwEOFgkpHpxUbAKzMZCkaF4FIqNdVTCpSLaZw4VDO4VSbyIQW
	NIK21iPlbJCc6v343RKEERkrDjABUpPPZzzTf3rSw+Vf9xKkrTTBcAlrHkR1ia2Q335YUEjEtdi
	/v/8SNITVmn6SZEUG8p2DdjXiYcWyb2rp4iNBv2Bue6w2tTXjFpPe1UWD4iAenKyKDlelRavZ8K
	vALOhZxc8S+k5oW2oMbA0yVkmOVsA9AqeMd0epux536IOaTQN7LDscioM2KcSqxPVQ6xz05n2wU
	vMPO0KRTI81zefxr2wepudR8XrYm82WNkqDkxAOQe2VVBYxBN+DLkbFFodBDVV1jqBxDxpjivTJ
	2HTJBjP2k0hQKOH+JduFySBeXMHoApFh50nfAI11NznNwNWpSB54dLTLMxXTDTCXnzIa0/dBCRk
	+kUI16sZLY0YaRdQ6qTxsMxtifcT92heUCgtxJIaoePN4+ptNCX+rey2tlb3ciuT7n8EqiE5e37
	rI=
X-Received: by 2002:a05:6122:62e9:b0:559:5ef5:b196 with SMTP id 71dfb90a1353d-56f3bcfd5bemr11922205e0c.13.1776338533993;
        Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89e282d9sm2769445e0c.7.2026.04.16.04.22.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5637886c92aso3304239e0c.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:22:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8CPtv8QFXu8eO4w9MZhc6KVVgbw2T1RIO2xhKFVeFS7bd+RHHzeyQpVyZ4VDyZhaE0ceJd+Zc=@vger.kernel.org
X-Received: by 2002:a05:6122:788:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-56f3bca6059mr11244615e0c.9.1776338533353; Thu, 16 Apr 2026
 04:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120317.910770161@kernel.org>
In-Reply-To: <20260410120317.910770161@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
X-Gm-Features: AQROBzBwwjc8yd10cT00Tu5Dl2qrCYQStWr3Lcobhh8coMrpPeCH9vhBSNokYJk
Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
Subject: Re: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-279008-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 62E3F40D5A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 at 14:18, Thomas Gleixner <tglx@kernel.org> wrote:
> This has been scheduled for removal more than a decade ago and the comments
> related to it have been dutifully ignored. The last dependencies are gone.
>
> Remove it along with various now empty asm/timex.h files.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h       |   15 ---------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

