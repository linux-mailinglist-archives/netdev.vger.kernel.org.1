Return-Path: <netdev+bounces-32026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B57921B3
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1190C280FD4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EF6FB9;
	Tue,  5 Sep 2023 09:56:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4763B5
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 09:56:39 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19E18C
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 02:56:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a65f9147ccso199417266b.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1693907796; x=1694512596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTjyGjDn7FR4rNP/HiS2y8fZxOAYS0TnmBweHywrLnA=;
        b=OATPpKqMMiBrG97XYMSbTprpQ4PHwnJaEyhBZPZ6o3kLRlQ+7v//r4Q331Ia9GImAk
         AGq8KL7aSL9RNNxA7ryqtiyZLGHn7V/4q/ZBtmpHWBZoNdWhASd/YrlYRHKIvvDT3cQc
         n1oSbigmUBucPTRa+s7JiPjrzDqKJCFXEqs40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693907796; x=1694512596;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTjyGjDn7FR4rNP/HiS2y8fZxOAYS0TnmBweHywrLnA=;
        b=k2HWzQpCUZn5r8b2wDLd9bsMJdE1X3r6GjrHBL2CPGPzn23jhpyqZ39yT4FsG34PHT
         LSggCPuooWPVhVPvVuAM6+krOHr/7m5GGfKJx/izpVLF1aORnSBJJWsz800y+un3yEMw
         4GRIZKIIruVNV6rXMCxIXoENCUnfBhypoKDnr7bOW6071lyfXmV/dLuNg+HUpkUKsl9e
         Eu6FjRLHCQEHJtUBw4V2gPbO0CxJzgIbewkQT9aSSMrj0T7klJQZxJg3HtuucKeSRA6z
         DM9h0vu7XINnhRGIKaJmU8CemuqxwAW4/Lwlz+bJmvSK/gwF7u7Ix6/NcrVN1mvhvocS
         06Cw==
X-Gm-Message-State: AOJu0YwOz+r0Ht4/XwWQI4f/oLKHpvKdAjkoY0Zs6LvT0HL3Zrx7gXA+
	98ijELTx7xsBR9UYCiCwTUgKlOywtcwebOZxdWmWZuApWJXvU2/GsfNS2A==
X-Google-Smtp-Source: AGHT+IGWTo3/qRz7gEG6LGGVugw8C7bYumwHK/mVdDJbegfLrbGs9icdB7hajmg5pDwj3U8sPL5gO9iMvrMWkqFqifE=
X-Received: by 2002:a17:906:76c9:b0:9a2:2635:daa9 with SMTP id
 q9-20020a17090676c900b009a22635daa9mr8136103ejn.6.1693907796267; Tue, 05 Sep
 2023 02:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Cacheux <paul.cacheux@datadoghq.com>
Date: Tue, 5 Sep 2023 11:56:25 +0200
Message-ID: <CAKnb4FrAY0WX2pYnoKK-=PoR3U-aHC3jrLjc5YYyVHg+j7jwPg@mail.gmail.com>
Subject: backport of "Include asm/ptrace.h in syscall_wrapper header" to
 stable 5.10
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

I'm currently playing with attaching fentry hooks to syscall
entrypoints and facing the issue reported and fixed in [1][2]. This
patch was backported to multiple stable kernels including the 5.15.y
branch [3].

I was wondering why it had not been backported to the 5.10.y branch,
and if you could queue it up for backport ?

My understanding is that the BTF format was introduced in 4.18 and the
BPF trampoline in 5.5 so it would make sense to have this fix in 5.10,
but I may be wrong.

Thank you very much in advance

Paul Cacheux

[1] https://lore.kernel.org/all/20221018122708.823792-1-jolsa@kernel.org/
[2] https://github.com/torvalds/linux/commit/9440c42941606af4c379afa3cf8624f0dc43a629
[3] https://github.com/gregkh/linux/commit/a88998446b6d7d8dae201862db470abe1b5097d2

