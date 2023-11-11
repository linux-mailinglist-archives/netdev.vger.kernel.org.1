Return-Path: <netdev+bounces-47188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0857E8BC5
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2661C2088D
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0391B29E;
	Sat, 11 Nov 2023 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BB1B26D
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 16:56:15 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA492590
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 08:56:13 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so3132967276.0
        for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 08:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699721772; x=1700326572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwwoOXURM/XkMeLQZZ1XVxVX6BHNcznodyMHwQybpnQ=;
        b=vo+I6yGa+gaV9LNKVbItJLoKaj1pyXeRUyNT9t/VhdCw+/cXB1hQ7V2VG5gjoSjEPb
         6esgWaGunevJfPjkjW70ZyEWhBKAJg2c6GuaDZyUVR8QAefVLFIOS8XFgEbqbK5fWcQF
         m7CjdaC0sA7WjajGaHXVsfc7dlzHV8XzFDY0ND2zHB5znw7E0lFKpUrqMdxPMmhtRJJf
         cgt7LDz5JQ+TSkRKPDkb65QPSyVXZ847aMh++QScTQSFoMNHunZ2SvRQvbUgY7FyFD/w
         UCq29WryEjCX9WzKkbWCmS4T9SfrIQ3jAsp5P4L3u3JGVWs2OxqoVh4Ks0iQC79dXVoG
         ovYg==
X-Gm-Message-State: AOJu0YwysgJWTb6z0thDdHkrOC4+T7r+ClauvC/nuIRmsv36e/wKJ571
	iYfBPINkDZtYrm04j0se0x3REytVN9lOXQ==
X-Google-Smtp-Source: AGHT+IEFjMVoT5/WAJnkze2RXrnkOs5Pej4OB3Gn6mFrWWk5gOZ5ZswXcsQ3+F+O9NCCbU3xJZgPNA==
X-Received: by 2002:a25:50cb:0:b0:da0:2757:eb7 with SMTP id e194-20020a2550cb000000b00da027570eb7mr1937918ybb.37.1699721772139;
        Sat, 11 Nov 2023 08:56:12 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y6-20020a256406000000b00d89679f6d22sm524398ybb.64.2023.11.11.08.56.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 08:56:11 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so3132960276.0
        for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 08:56:11 -0800 (PST)
X-Received: by 2002:a25:ac21:0:b0:d84:da24:96de with SMTP id
 w33-20020a25ac21000000b00d84da2496demr2066562ybi.33.1699721771621; Sat, 11
 Nov 2023 08:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c26af87143b645cc19ce93e4624923ef3f25204d.1699707062.git.aclaudi@redhat.com>
In-Reply-To: <c26af87143b645cc19ce93e4624923ef3f25204d.1699707062.git.aclaudi@redhat.com>
From: Luca Boccassi <bluca@debian.org>
Date: Sat, 11 Nov 2023 16:56:00 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnRkkyAgG1Cg83su11_dyL35AZnrsW4QhQ1ks=+WCHYC9A@mail.gmail.com>
Message-ID: <CAMw=ZnRkkyAgG1Cg83su11_dyL35AZnrsW4QhQ1ks=+WCHYC9A@mail.gmail.com>
Subject: Re: [PATCH iproute2] Makefile: use /usr/share/iproute2 for config files
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Nov 2023 at 12:55, Andrea Claudi <aclaudi@redhat.com> wrote:
>
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

Acked-by: Luca Boccassi <bluca@debian.org>

