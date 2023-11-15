Return-Path: <netdev+bounces-48121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110277EC9D3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE50281195
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3233BB49;
	Wed, 15 Nov 2023 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F7173A
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:39:18 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5b499b18b28so81419087b3.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069957; x=1700674757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qrq5hz+xS8PYwkoLEO2NL6G6XH9H3SVuEgYS0PdC2wk=;
        b=wm9oTvwPbYE3M2bgCpnPKaxaYGeuhWxTZU+UAICV5qUEo7Y56J7hwfa/m9kIxMgAgt
         SgyocrqD3uPixHXPagI6B6Z4Gz/LL4mPotwUDJ3ercDZmheB+QQaAuVbMvtoagDrcaq3
         6wYEzlfZ6AIOZa1ObHmejK3oXsWR+bbPOZJlVruh+CNz2Q2C/m5o9BiVEbDX27CltQb3
         r+IEPjSALH693dQU5VkYVhfSQXy8BDV3OwBCVTF/vtj02RxlTi0GDdDC9ORayI/Ugtji
         hkBA1iFgZXcb5kRAw00xeaKFtfG1WKjKDNfRLRsbNkUBx420oM6U1WAl7MlhsaU3hvPX
         GD4g==
X-Gm-Message-State: AOJu0YzoKHJ9fpZ8vpUPd+H3r4BIFdAKEJFGaip/PXZKHuCyePZTWHQK
	7vEKrwcYd9QrpLUbL8xDW8zCT8Ty5dlrHg==
X-Google-Smtp-Source: AGHT+IG0r99T6hHZeKZHGpgC3MFLBhj8vloWYbA7uMq+UdiZUhiWTleko+icaRI8DlZj46OxU8z/KQ==
X-Received: by 2002:a0d:dbcb:0:b0:5b3:2acd:8d83 with SMTP id d194-20020a0ddbcb000000b005b32acd8d83mr15383762ywe.22.1700069957362;
        Wed, 15 Nov 2023 09:39:17 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id s205-20020a8177d6000000b00589b653b7adsm481631ywc.136.2023.11.15.09.39.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 09:39:16 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso4640347276.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:39:16 -0800 (PST)
X-Received: by 2002:a25:c287:0:b0:daf:84dd:ab84 with SMTP id
 s129-20020a25c287000000b00daf84ddab84mr11459470ybf.47.1700069955932; Wed, 15
 Nov 2023 09:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71e8bd3f2d49cd4fd745fb264e84c15e123c5788.1700068869.git.aclaudi@redhat.com>
In-Reply-To: <71e8bd3f2d49cd4fd745fb264e84c15e123c5788.1700068869.git.aclaudi@redhat.com>
From: Luca Boccassi <bluca@debian.org>
Date: Wed, 15 Nov 2023 17:39:04 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnT2YN++vvUhordyRYCgj-F3kN112sZZXvZvH-ge_nwJwQ@mail.gmail.com>
Message-ID: <CAMw=ZnT2YN++vvUhordyRYCgj-F3kN112sZZXvZvH-ge_nwJwQ@mail.gmail.com>
Subject: Re: [PATCH iproute2 v2] Makefile: use /usr/share/iproute2 for config files
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 17:25, Andrea Claudi <aclaudi@redhat.com> wrote:
>
> According to FHS:
>
> "/usr/lib includes object files and libraries. On some systems, it may
> also include internal binaries that are not intended to be executed
> directly by users or shell scripts."
>
> A better directory to store config files is /usr/share:
>
> "The /usr/share hierarchy is for all read-only architecture independent
> data files.
>
> This hierarchy is intended to be shareable among all architecture
> platforms of a given OS; thus, for example, a site with i386, Alpha, and
> PPC platforms might maintain a single /usr/share directory that is
> centrally-mounted."
>
> Accordingly, move configuration files to $(DATADIR)/iproute2.
>
> Fixes: 946753a4459b ("Makefile: ensure CONF_USR_DIR honours the libdir config")
> Reported-by: Luca Boccassi <luca.boccassi@gmail.com>
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---
>
> v2:
> - Rebased on commit deb66acabe44, changed commit message
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a24844cf..8024d45e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -16,12 +16,12 @@ endif
>
>  PREFIX?=/usr
>  SBINDIR?=/sbin
> -CONF_ETC_DIR?=/etc/iproute2
> -CONF_USR_DIR?=$(PREFIX)/lib/iproute2
>  NETNS_RUN_DIR?=/var/run/netns
>  NETNS_ETC_DIR?=/etc/netns
>  DATADIR?=$(PREFIX)/share
>  HDRDIR?=$(PREFIX)/include/iproute2
> +CONF_ETC_DIR?=/etc/iproute2
> +CONF_USR_DIR?=$(DATADIR)/iproute2
>  DOCDIR?=$(DATADIR)/doc/iproute2
>  MANDIR?=$(DATADIR)/man
>  ARPDDIR?=/var/lib/arpd

Acked-by: Luca Boccassi <bluca@debian.org>

