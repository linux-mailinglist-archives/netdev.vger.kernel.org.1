Return-Path: <netdev+bounces-31036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D478B018
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA821C208FC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB911CB2;
	Mon, 28 Aug 2023 12:27:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774C11C97
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 12:27:51 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08663E1
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:27:51 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44d60bb6a96so986035137.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693225670; x=1693830470;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mD8rjBVWRUnVFIrMO4cA1ZPhi9N2+KrE61nTEBLn+r8=;
        b=w2wX8EBOtv0qHfJ40DEvdYIUkVY21B1Li/gT5HMgGkzlmFM75fFKNc3D6dVlQ7YQv2
         b/ZNO4vnByOP/dUANkhAq+6bRSPeVB/bw5kbGpEOq4x/eu/DLbBVwFpIFNKqbRNQiLsj
         TxrxcHFIvd6bp0TkUSeVXXvZ/PO296+4OgMQqPnUYGvnTbG82lXs/qdTPLXgQ+V76fj+
         J7pvLOKe3GgKu+mB/iowEbK2UwyxT5qZkChG4+MAZHMA39GzTYxrSIbGrkscdXFNntac
         hkQO6hnYR2s9VWJ9nJMouraPmYAhyK7GYNH5ZtuIWf/6BRD1cYITQXg0RwcLzu3OzL7X
         cOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225670; x=1693830470;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mD8rjBVWRUnVFIrMO4cA1ZPhi9N2+KrE61nTEBLn+r8=;
        b=AKsBSd6zUHREWz3yw/78/yoW1DFx2dvHuxvR40RrwahLWs2hUdepVRF4Yul0XaalEq
         cgUN8kN9FHLYMYErYsOSyRLzZCYkDvTWBUjtjNTuJG/N8618fMmMTcNAUhSLHDCYRaby
         +S92wHqOJ2Hv4SBrgw2ol+zZlp+4v57SlRHEXEHbyXATOiehwoNDcV5Iv4zSgLJGAunm
         boZA1PpwKGZ7WXoG39sWLFFItQFa+UUkvsI8khGIi7LD1JgOe77liE06Gwxo8sup5NFd
         bDze18BsF9ubBBu+RJFCvVpOpw4fXwLBgPKlmTNswHV6iA9UaAvY9u3PjgpWFsJ+DVcB
         z3hg==
X-Gm-Message-State: AOJu0Yzv/bw9Nt36wUq1nHPquOVohGAoMAFmljCAQhaKjuQ/9v5Jwp5U
	KHUh/3ZRHTU08faa5ItNGyyS5qZa33gi31J4TPSjD7JtTYqUV2+bkIQ=
X-Google-Smtp-Source: AGHT+IF0RiZ0dNfm1hl6bCcyi1b7qOZTEPlRkMEvYAZgrIt+/7pxC7vY4qFsDn3YySHb9VtQ1bv6mghrSZupPrXVSTg=
X-Received: by 2002:a05:6102:3bc4:b0:44d:4aa1:9d3e with SMTP id
 a4-20020a0561023bc400b0044d4aa19d3emr19174288vsv.0.1693225670012; Mon, 28 Aug
 2023 05:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 28 Aug 2023 17:57:38 +0530
Message-ID: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
Subject: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18 [-Werror,-Wfortify-source]
To: clang-built-linux <llvm@lists.linux.dev>, linux-stable <stable@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[My two cents]

stable-rc linux-6.1.y and linux-6.4.y x86 clang-nightly builds fail with
following warnings / errors.

Build errors:
--------------
drivers/net/ethernet/qlogic/qed/qed_main.c:1227:3: error: 'snprintf'
will always be truncated; specified size is 16, but format string
expands to at least 18 [-Werror,-Wfortify-source]
 1227 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
      |                 ^
1 error generated.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

