Return-Path: <netdev+bounces-47887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5F47EBC1B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3281B1F2612C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7A64C;
	Wed, 15 Nov 2023 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dvmh397f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248A647
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:37:35 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F0DB
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:37:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280260db156so89608a91.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700019454; x=1700624254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/QBZe2+6bMTLewBclWwKvpLZbgt0kFnZgaUS+b0RhY=;
        b=dvmh397fbs/P0b6Nx5mzAp6uC50gH8/48O5nfPZW93TTCnt+i2IVsP37UGrUH1Xaen
         xC30gaW4+frlaejtu3jt3T/BNFoh9cv10rCOrPO2VWi9i5F1H/ToUrbfTjUbP5NM670Q
         7Yhqv1r8j9cT3EMeTGESsd/YpLaY0OsnU1F1Kf9aXtwMvKq1yIwcmD69oqWT4OaP3ebD
         JjbEwzo7V+C4YlIjzDpVzrHfeoW2S3iZMjMpoPRkDOsSg/VSb1ab03SZfWX9XP+jWotD
         WSkQKIjePvKas3YnjOs7GbgVu2itRdnTh710S0lWYKZpQz2mraKKFtFTzbXUHrwkqoya
         hP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019454; x=1700624254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/QBZe2+6bMTLewBclWwKvpLZbgt0kFnZgaUS+b0RhY=;
        b=k7wZzNjJ4JnxfeuyVEL6o7dhtQXE/j1muQ3yILeuRvqGSP02PEpkeeUQ+3k0IgZwtW
         Hl2DGxbGSMvCi6+pcaLCq38O7xopBV3+xZ7uYrWa10DrONGko42szECgNZY+Ud3C9gKP
         w9wK+yv6VWxszVGPtvfIlBR69J1lsUJakqkhfjwnYmQ8jDON6qorThhuyps7n56n2hoq
         R0mihSiyQQAKYwwzHiyWHF87K6k36E3Tmyyg3Ao9HZG51DtpFt94sv8uwnSoI+6BLtuu
         KPslc8qIIEHxC25DT7e7KloaPfNL3HUVA39AoIMHRu6XHlWq7bc7SZs4i+u2ezN+bUel
         RomQ==
X-Gm-Message-State: AOJu0YyiQhuaia71SmtxAXlzpmaSoMNntg0R8hy4hIr9wgH9rUgyNJZZ
	DkoMImnpaYc49UI2pzLgVHwbGw==
X-Google-Smtp-Source: AGHT+IHZclxHbCsYf1DHJ9BQl6IvqfMLBxN2DrD9SUcqAjV9xXHUtE1+GzKtb833Y42I+WXTYfF/Ww==
X-Received: by 2002:a17:90a:1951:b0:281:61c:1399 with SMTP id 17-20020a17090a195100b00281061c1399mr12065578pjh.3.1700019454275;
        Tue, 14 Nov 2023 19:37:34 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902db1000b001c9b8f76a89sm6423637plx.82.2023.11.14.19.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:37:34 -0800 (PST)
Date: Tue, 14 Nov 2023 19:37:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Luca Boccassi
 <luca.boccassi@gmail.com>
Subject: Re: [PATCH iproute2] Makefile: use /usr/share/iproute2 for config
 files
Message-ID: <20231114193732.31926e3c@hermes.local>
In-Reply-To: <c26af87143b645cc19ce93e4624923ef3f25204d.1699707062.git.aclaudi@redhat.com>
References: <c26af87143b645cc19ce93e4624923ef3f25204d.1699707062.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Nov 2023 13:55:41 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> CONF_USR_DIR was initially set to $(PREFIX)/lib/iproute2, then moved to
> $(LIBDIR)/iproute2 to honour the libdir user config. However, as
> reported by Luca, most distros use an arch-dependent LIBDIR, which is
> the wrong directory to place architecture-independent configuration
> files.
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

Since revert patch from Luca is merged already, please rebase and resubmit this.

