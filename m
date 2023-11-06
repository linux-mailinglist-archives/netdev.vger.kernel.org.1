Return-Path: <netdev+bounces-46232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D63F7E2A92
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F23F1C20C04
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887492942D;
	Mon,  6 Nov 2023 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KZKo9BNA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43115AF2
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 17:03:29 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289B125
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 09:03:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2809fb0027cso3437996a91.2
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 09:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1699290208; x=1699895008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ben4iCbN53nMVOf/bR/i9r0kIFtgFbYHJJnd3HQamaI=;
        b=KZKo9BNAj1gnB+t6GP4PI7Jf/HjulCIBKIDEEuyCEEpZOunjvMEQVgR8IVhrUy5rAT
         tDXkZJuTXc7F9vesJ3yOeV54Dv+p34uln86hZ7hni9kwWYZFej5hiqKsTusA7wXUsXM6
         a6D1RCSP6VRRbnA6RHiD06W2MeK7Sg9VMaMJ04ycAmN9KZ2XiglCotLpBvmksCcoCf+q
         GAp/9JP0V/ZhJ3nK66xKKfo+zJHkQy+52tyqqy0KBapG9KUYIkz1o/Q9123XqGoeyEuA
         oxh56otNIf+4AOU+zMLQKjt7SijXzsRY82cDGAk6EA1BK8inNHr2BWPA0OHbIEaIMJcy
         0Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699290208; x=1699895008;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ben4iCbN53nMVOf/bR/i9r0kIFtgFbYHJJnd3HQamaI=;
        b=fZObhwSFsuZkcjVK2d4eZvV/jg6KgTaEDmvEhHjRFG4Kdd1KIzFB0uaXSEO1W31H/M
         6Cyj3UnZEYnnjjUUH7XlJ7f4dZj2/8m6lhHD7GZaweVu35FKXjOiks2lroA8w+OSYUhc
         /GcaMnBw7/5/cqlivMpISHFwis1pGLFWxyTCw+QFxFDFm086qVD36iA9mhIHOOtjiu74
         E+a/UhtEBL+9r29h31NUh/J3mOtrsY1FfyTyVEZHaRqoeC2frUAKotP1wv1G18FMxlui
         /KMytvJzziOI7WTfph/jQa0Ebqz8AN0HRgELeAMbrQAhx1ASxYsjq5H9bktp0xeNWuXu
         H6Vw==
X-Gm-Message-State: AOJu0Yz0PJVWqPBAlLQu1QPNgHzDeXlLHjkfmilkZbGrMfTMv7EXzI/h
	hFvplMmSM322yAihjxHhEDQejR/KrglexNOZtWw=
X-Google-Smtp-Source: AGHT+IEoBVbWUrL6c1QOluncxudI83jsWTm3jKeZTE/RXGHmikCwU1Lk4vxO/HHuVoAWbULdcWR/0Q==
X-Received: by 2002:a17:90b:4a50:b0:26d:17da:5e9f with SMTP id lb16-20020a17090b4a5000b0026d17da5e9fmr10267650pjb.1.1699290207788;
        Mon, 06 Nov 2023 09:03:27 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a199200b002810810cc80sm1743382pji.37.2023.11.06.09.03.27
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:03:27 -0800 (PST)
Date: Mon, 6 Nov 2023 09:03:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.6 release
Message-ID: <20231106090325.07092c87@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Update release of iproute2 corresponding to the 6.6 kernel.  Release
is smaller than usual. One notable thing is that support for kernel
components removed in 6.3 kernel was removed from iproute2 (dsmark,
cbq, rsvp).

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.6.0.tar.=
gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Allen Hubbe (1):
      vdpa: consume device_features parameter

Amit Cohen (1):
      bridge: fdb: add an error print for unknown command

Andrea Claudi (5):
      ss: make is_selinux_enabled stub work like in SELinux
      ss: make SELinux stub functions conformant to API definitions
      lib: add SELinux include and stub functions
      ip vrf: make ipvrf_exec SELinux-aware
      Makefile: ensure CONF_USR_DIR honours the libdir config

David Ahern (2):
      Update kernel headers
      Update kernel headers

Eric Dumazet (1):
      ss: add support for rcv_wnd and rehash

Fran=C3=A7ois Michel (4):
      tc: support the netem seed parameter for loss and corruption events
      man: tc-netem: add section for specifying the netem seed
      tc: fix typo in netem's usage string
      tc: fix several typos in netem's usage string

Ido Schimmel (1):
      bridge: Add backup nexthop ID support

Jiri Pirko (7):
      devlink: accept "name" command line option instead of "trap"/"group"
      devlink: move DL_OPT_SB into required options
      devlink: make parsing of handle non-destructive to argv
      devlink: implement command line args dry parsing
      devlink: return -ENOENT if argument is missing
      mnl_utils: introduce a helper to check if dump policy exists for comm=
and
      devlink: implement dump selector for devlink objects show commands

Mathieu Schroeter (4):
      Add get_long utility and adapt get_integer accordingly
      Add utility to convert an unsigned int to string
      ss: change aafilter port from int to long (inode support)
      ss: print unix socket "ports" as unsigned int (inode)

Maxim Petrov (2):
      ip: fix memory leak in 'ip maddr show'
      ss: fix directory leak when -T option is used

Pedro Tammela (1):
      utils: fix get_integer() logic

Ratheesh Kannoth (1):
      tc: Classifier support for SPI field

Stephen Hemminger (16):
      tc: add missing space before else
      uapi: headers update from 6.6-rc2
      fix set-not-used warnings
      bridge: fix potential snprintf overflow
      ila: fix potential snprintf buffer overflow
      Add security policy
      uapi: update headers from 6.6-rc4
      ila: fix array overflow warning
      uapi: update from 6.6-rc5
      tc: remove support for CBQ
      tc: remove support for RSVP classifier
      tc: remove tcindex classifier
      tc: remove dsmark qdisc
      tc: drop support for ATM qdisc
      ssfilter: fix clang warning about conversion
      v6.6.0


