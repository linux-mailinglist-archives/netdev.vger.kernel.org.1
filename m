Return-Path: <netdev+bounces-47144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A787E83C5
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8628126D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F01D539;
	Fri, 10 Nov 2023 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azbcYI++"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194D3B7A8
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 20:31:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25538131
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699648285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zpaE/XCHk344Bp4YuTu5n/kwevdmkDIqtAUrtB9dsAs=;
	b=azbcYI++0f49VTqRaRe1ID+dWF0IeoC9LHz7nI9LiqiMI2aAV/aCABbC8TQ+tNmPn8FPO3
	coT6wRz9XbP+0H5Vj3VJbpEDd6rPqOl7qsFl4kg7r1syEOIzlPlgxjkrwaRcNRTCOh8tRa
	H1ZyPPW6hAE0KzkXFfZrL1OHfmiJAG4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-fD1fBu1YPFeS9y9zkpZMrQ-1; Fri, 10 Nov 2023 15:31:24 -0500
X-MC-Unique: fD1fBu1YPFeS9y9zkpZMrQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41e172143c3so53897461cf.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 12:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699648283; x=1700253083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpaE/XCHk344Bp4YuTu5n/kwevdmkDIqtAUrtB9dsAs=;
        b=W6Ex+a5+rH5BplEC1JCsXG2WAxfF2S1f5D1+PLsqgbjh8aPS62IzQFYeX0vmE02HXL
         bYDUv/iz3sIgGMeiDV+HX8XtYlvyXzOoyaK2EBg82tYaI7ouRswatIq58ZyNLBdalCe4
         tF3hare163R0tViqOLI0z33B/OHKhTGHbUGDLZevnWOB2psSatRaFtQEG8o50HYLlAu0
         x5yxyTDKCZhQA+6bCzDGtxwcBV0A4LsNdzunbEhC8zZFp0jEyT1dlellNrADBNihG5Z5
         JBQQ+bHbKzYagOCZPbV9zLtEfaUFA50FuNOx8AOrPV1g6OQGB8pphOMzyHQzi7J5itpJ
         xx8g==
X-Gm-Message-State: AOJu0YwR7j4Ja36/z0TWC0763Z0d7sPrqyl7z/3YL4kftHkaf9Y58CFC
	xCDCL/w2j3/8ocoCGfGZ+6PI5d17NX1YO+b0Kkqd5rYYr3DrzYq+URbYq0n0hY216qqyxg2QH/Y
	US+q0QEZTFOQtbkWL663w4A7f
X-Received: by 2002:a05:622a:58b:b0:41e:9ef9:38f8 with SMTP id c11-20020a05622a058b00b0041e9ef938f8mr391824qtb.17.1699648283533;
        Fri, 10 Nov 2023 12:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr3E6RMT2LId7xSQb1uXVnZbGA+7qKHSZcfFA869vhe6kXDNiaZOclt7whdntAB7hUAEH92Q==
X-Received: by 2002:a05:622a:58b:b0:41e:9ef9:38f8 with SMTP id c11-20020a05622a058b00b0041e9ef938f8mr391799qtb.17.1699648283258;
        Fri, 10 Nov 2023 12:31:23 -0800 (PST)
Received: from localhost ([37.163.221.15])
        by smtp.gmail.com with ESMTPSA id kr25-20020ac861d9000000b00421a0b66bd2sm75201qtb.4.2023.11.10.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:31:22 -0800 (PST)
Date: Fri, 10 Nov 2023 21:31:17 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: Petr Machata <petrm@nvidia.com>
Cc: luca.boccassi@gmail.com, netdev@vger.kernel.org,
	stephen@networkplumber.org
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours
 the libdir config"
Message-ID: <ZU6TFWw9UuBkRazb@renaissance-vector>
References: <20231106001410.183542-1-luca.boccassi@gmail.com>
 <87fs1dyax9.fsf@nvidia.com>
 <87bkc1yaqa.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkc1yaqa.fsf@nvidia.com>

On Fri, Nov 10, 2023 at 02:54:16PM +0100, Petr Machata wrote:
> 
> Petr Machata <petrm@nvidia.com> writes:
> 
> > luca.boccassi@gmail.com writes:
> >
> >> From: Luca Boccassi <bluca@debian.org>
> >>
> >> LIBDIR in Debian and derivatives is not /usr/lib/, it's
> >> /usr/lib/<architecture triplet>/, which is different, and it's the
> >> wrong location where to install architecture-independent default
> >> configuration files, which should always go to /usr/lib/ instead.
> >> Installing these files to the per-architecture directory is not
> >> the right thing, hence revert the change.
> >
> > So I looked into the Fedora package. Up until recently, the files were
> > in /etc, but it seems there was a deliberate change in the spec file
> > this September that moved them to /usr/lib or /usr/lib64.
> >
> > Luca -- since you both sent the patch under reversion, and are Fedora
> 
> Ugh, I mean Andrea, not Luca. Sorry!
> 
> > maintainer, could you please elaborate on what the logic was behind it?
> > It does look odd to me to put config files into an arch-dependent
> > directory, but I've been out of packaging for close to a decade at this
> > point.

Hi Petr,
the change in Fedora iproute package is in response to 0a0a8f12fa1b
("Read configuration files from /etc and /usr"): it moves config files
from /etc to /usr to make room for customization using /etc/iproute2, as
described over there.

What I tried to achieve with my patch is to have a single location in
/usr for iproute files; but I agree with both you and Luca that storing
config files in an arch-dependent directory doesn't look right.

However, even using /usr/lib doesn't seems quite right to me. According
to the FHS [1]:

"/usr/lib includes object files and libraries. On some systems, it may
also include internal binaries that are not intended to be executed
directly by users or shell scripts."

A better location is probably /usr/share [2]:

"The /usr/share hierarchy is for all read-only architecture independent
data files. 
This hierarchy is intended to be shareable among all architecture
platforms of a given OS; thus, for example, a site with i386, Alpha, and
PPC platforms might maintain a single /usr/share directory that is
centrally-mounted."

And this is exactly our case: read-only, shareable, config files that
can be overridden using /etc/iproute2.

Luca, does something along the lines below work for you? If so, I can
test and send a patch fixing my own stuff.

diff --git a/Makefile b/Makefile
index 5c559c8d..ec57bd4c 100644
--- a/Makefile
+++ b/Makefile
@@ -16,11 +16,11 @@ endif

 PREFIX?=/usr
 SBINDIR?=/sbin
+DATADIR?=$(PREFIX)/share
 CONF_ETC_DIR?=/etc/iproute2
-CONF_USR_DIR?=$(LIBDIR)/iproute2
+CONF_USR_DIR?=$(DATADIR)/iproute2
 NETNS_RUN_DIR?=/var/run/netns
 NETNS_ETC_DIR?=/etc/netns
-DATADIR?=$(PREFIX)/share
 HDRDIR?=$(PREFIX)/include/iproute2
 DOCDIR?=$(DATADIR)/doc/iproute2
 MANDIR?=$(DATADIR)/man

[1] https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s06.html
[2] https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s11.html


