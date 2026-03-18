Return-Path: <netdev+bounces-268922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NoSFL5mumklWAIAu9opvQ
	(envelope-from <netdev+bounces-268922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:47:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E46652B8633
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E2143111E07
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34F4387352;
	Wed, 18 Mar 2026 08:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE038B7BC
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823323; cv=none; b=lY7AAMNk8MVIRI6Lstw3nyVaxpzPqyEOGzCk1xwYz58JAdgUMnr2I3yLNL/Q8fEIfDn5zQEIqGLhMzQHCnk1EiQ+paeUnY12u2TplGxjdyJaljdFtgabyIsIleSJ8m4FI8+kVHZU2sIZrItLHO91we0ohqFCKf/VG7OZeKkKP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823323; c=relaxed/simple;
	bh=1Q3Co6bxbshrYxrPl4jn/U2T1xBX3gjFWpDnRI8lYDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qK50CQIM+n64oBGzihEZKL/QWDYbZxa+EdiG9RP/mdE80Jg4H91TArGJ/o11jigi99tuPUSW9fXO8Z9YF5hQRO/CV/LuDpQVMPiiNDqTaBk5AzwD9OMmrrusb2evwIi+M5ULlBx9gCrRo6V76Mcn6hjCt/UgPe7XNNXb76CxWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5fff77ff69bso1508686137.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773823317; x=1774428117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqPUDw6RZ7tI/8SbuWaBeZ31o+A7cvn/glmx6dclWwI=;
        b=KwLRFJ6yt0JoUaMP/ZjMh011M2k8zpEnFolu9JgDiMRP49qsu2nuLbWnU5V3ToAEw+
         f8MFmm6y1s0y6UJ0TgrYM8j13rNFLvG1UaTXBAvahRXeDBJsVjaToGNX18Nwug6R2M2/
         SfXxrqcS0Z3EAr4CLoQMrobcSCJINC4b7HehekQr9GHM/5wA2lzT0G74P5NBLU7olgW1
         aI0GqPYjW0hgb4F/uvqUesXsi0Jdg9Wqh1IETSRAwlx4/86Wgg1MHd3e0bfIxwnnth9N
         vGBc+knmL+ZEyqs7EgNlocsalnCUbU06SPVWIHd8BafXlOtAzjoLJxPOUF2ft0cTicYf
         xrVw==
X-Forwarded-Encrypted: i=1; AJvYcCXUemIKX6pV8/2T2lNTBVGyjIWWG1T5XmNBE7+7V68r5v4ueoyiHgutC2mHeOl97PLLSqnzNbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaPr5rMcExMuRtDnq70eaYjClxIzKB0NVSFnAqutK5j/tz+//
	Dr01bChDGFyfdxHCkM/bdN2/kVLBHWDZE0vri0oxNeVJY4iNy6SbppDj5VhU7AqQYVk=
X-Gm-Gg: ATEYQzwazFb3Ls9pmIvDIabvi7dxvON/DcMGNvqsVSGKiIdnBiikruMViZwAIMdbKU4
	JsB8WTI0z8C+DRfgH8AMuTNiYhqspT/07JEvvDDDiipmucsPDqh5jPRKhlb2F28guqXe04Gs3dg
	i/QipTI/psLVSA4LyE9obhBwQc3muUcM3Rzvz+nd9grcyHWdRqWxGNgYY+srGVaiJmNwadzIiji
	D7DbD6+Ul4JexiI3rWd8EofYaDYDvCgdxzX+KyiDAWcw0aTbisbFFVYsJilu8/egd3k3Z68kxHm
	YeLEx9Hm3lHRUbiORL8ffDOJg++jxB8cf6Xgui2/nc24lYb59StdjNAKXUxrg9QBuN/KObWgr0B
	hm7fI+sH5sipSI0eMWUJU1cKPpRvf2Zy46RLpTHXs7EDF69pCMH8xTJGUNiHIQxaPeUm3VBqa9D
	qkRreRW/qj4Z9bs6CaQHg7dc40owvzKwX9dsKtvV98yOI+Siubf81GZXQXWe2I
X-Received: by 2002:a05:6102:cca:b0:5ee:9f76:1ab with SMTP id ada2fe7eead31-6027d0bb01dmr1167787137.5.1773823317471;
        Wed, 18 Mar 2026 01:41:57 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6027ee4bc21sm1013159137.12.2026.03.18.01.41.55
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:41:56 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-950cc286d86so955559241.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:41:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlCgRxY+48YPUSo5UZ13trZuwcDywKJWrWt7H8L8G7Xb/KlWSJ5K1RjvD6JQOXmEgLFwx5UZc=@vger.kernel.org
X-Received: by 2002:a05:6102:5087:b0:5ff:e39d:9f9b with SMTP id
 ada2fe7eead31-6027d159e7fmr1126209137.16.1773823315107; Wed, 18 Mar 2026
 01:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local>
In-Reply-To: <abkD-VLprcbbEbB1@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:41:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
X-Gm-Features: AaiRm52_MgNfiAr79FL-62Ac0xXnTx-AfzVYThIE_IN0tF6AadQcPRzCkdJNUOc
Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sang-engineering.com,chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,linux.intel.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-268922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.877];
	TAGGED_RCPT(0.00)[netdev,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: E46652B8633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andy,

On Tue, 17 Mar 2026 at 08:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 17, 2026 at 08:26:53AM +0100, Wolfram Sang wrote:
>
> ...
>
> > Thanks for tackling this issue! I agree it should be fixed, just
> > wondered about one thing:
> >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> >
> > Is it a possibility to use the lock in all code paths instead?
> > Because...
> >
> > >     struct list_head consumers;
> > > -   u8 flags;
> > > +   unsigned long flags;
> >
> > ... this change costs some memory on every system. Maybe it can be
> > avoided?
>
> How much memory does it cost? On most 64-bit architectures is +4 bytes,
> rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> +0 bytes. I expect that 64-bit machines will cope with this bump.

On all architectures with natural alignment of pointers and longs,
it won't cost a thing: struct list_head contains pointers, so the
struct must be padded to a multiple of 4 or 8 bytes anyway.
On m68k[*],  it will cost 2 bytes, as the existing padding is just a
single byte.

[*] Iff m68k ever switches to 32-bit alignment, there won't be an
    additional cost due to the change of flags here, but of course
    there would be a cost all over the place.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

