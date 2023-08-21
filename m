Return-Path: <netdev+bounces-29263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358078255A
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7424A1C2084F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CBC1FC4;
	Mon, 21 Aug 2023 08:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756E1FB5
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 08:25:33 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABEC98
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:25:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso399874166b.1
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1692606328; x=1693211128;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTjyGjDn7FR4rNP/HiS2y8fZxOAYS0TnmBweHywrLnA=;
        b=W4ythoIMPLNwEpMA4OIPrOuM9vdiZrV34OZAzRqeOZsfG2LII0Ntsn7ErNzpnGXEeg
         hF0wXajueQf/16MifmoNzVgRYIu0gNz2Rr+c2RjC9pvtZTVGzlEki6qX7mteJmS/3G/w
         RFH9tFCavNPCSKWjSslayABajNw4dzNFWIoSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692606328; x=1693211128;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTjyGjDn7FR4rNP/HiS2y8fZxOAYS0TnmBweHywrLnA=;
        b=TWEnHmYGTC1xaPj7O4OXVKNrLdKIpO6HrwT6J3HkUDjNvHp6vDry3wIrv8jIxRdQNb
         RDIfgF+KPjH42hXVKxrATF3YARVHBYfKya3tKABrBqVG68/VCTa9u6iq3H3ZvlmkEGSA
         Bmz2W4Wz1DKNjp5vUb0GX0nsPnfTrU24pi5k50XChbgCpLOMJ93Ubi6FrZmbqxqjm8gn
         lVJbdrGHpG0Rpat5Q634IJnQFo1JEfoq2ipU2aJ+o/dM2XRLKQb8G/iEzb7H2S0fWaMa
         NSe8edai9ePgptoay5DP4u2rzcvOhEIig4rDehWi32aklnTrjF+3KHkjLIoRZT/49AR+
         ePHA==
X-Gm-Message-State: AOJu0Yw6p/VzERHn5LMt9++MZaioVDBKtrst2Wwfp+USwQSh6n7Fsxkl
	0QC6g/U4QhlKQkXy3gZEfIPqBLRzRYjjw7zMxLWtUK4vcvmG8O4t4p4=
X-Google-Smtp-Source: AGHT+IFUmnx6nraPGnUDo5beiTquYATCETTO3Q7FN2/gQsHMYiF4KorRhYGPH+yT2tCdAMSdNBIrpqYsxazUKLFI4qM=
X-Received: by 2002:a17:907:2c59:b0:993:a379:6158 with SMTP id
 hf25-20020a1709072c5900b00993a3796158mr4485421ejc.17.1692606327733; Mon, 21
 Aug 2023 01:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Cacheux <paul.cacheux@datadoghq.com>
Date: Mon, 21 Aug 2023 10:25:16 +0200
Message-ID: <CAKnb4FpNb80J1y-ifs0xZ9GV+oq9x2eoEjWj2bpd1vXCkbftSQ@mail.gmail.com>
Subject: Question: backport of "Include asm/ptrace.h in syscall_wrapper
 header" to stable 5.10
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

