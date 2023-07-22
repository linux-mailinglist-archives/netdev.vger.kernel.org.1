Return-Path: <netdev+bounces-20092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F375D92B
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 04:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFCB1C2186A
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7D79D4;
	Sat, 22 Jul 2023 02:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC86107
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:41:33 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B562708
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:41:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9d16c1f3bso2146256a34.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689993691; x=1690598491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKBuHrFziFMYx3iHFey1XW1QJsz6lmgGfn3Ef/8JX2U=;
        b=MZfJHUedDexWglKVvRM3OLEsl04K3fb5sxaJdK/3fEus9fRLLUz0MhDoiffNizskue
         KVTOPcOcVMHGfGFYs/F9jYt6KdLaTHF8WGhUIno0AIyVu+JST026jeMo/7h7tDQTubVa
         URfhvAHiO+2K6/WAVj+5ppIepSp9TmQ15h6HAezTUqC2hVe+Etq52r6cGrJ1kLqcFcCW
         VrEocbyaI79lmse18IJWBWpwPDFppB5xPCAOwxjXnrkDvtwDGcXVx6tn1vnlx4TB/Jjg
         9XzJN9+aSsz6OjwPwsnDb7mEeBFt8oHwIdGt/tqHDg1ayIi9Qe8nKB7vfNtxiycnjQAP
         RpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689993691; x=1690598491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKBuHrFziFMYx3iHFey1XW1QJsz6lmgGfn3Ef/8JX2U=;
        b=YinulYWDWhl1NEdI4NsQPRYENn4kOW3a8EiXFntg5fkyWv1cLPu67G/wYdCR8kvs8h
         yEYcZQtOoJtrAwd8jw6wX3gmngs08cSwi6YhMK3AxRPUH6ujWGKWsRc0C0fhRPzDd9Yk
         hNCdxEfxM8DUeBlA/bO49cIwnJzcZJp1GJgVOgu27YFntb3Up2FZzU3gFbZ0CDOkKxeA
         nAXFeXRGxUIc4qe/4K4GrRmWIxTkK7u0RrKfbdVSxzdEtTcmglrlj4K/hkkYIXPf5TuO
         SvLp5vCtERC8NjBKNikrwjiRKmUNEaS2iGn/p657zA6zJu9OQ8I9XOm4liMTxK3jN2OM
         i9hw==
X-Gm-Message-State: ABy/qLZMwIv/oguoGHLD8VWsV7dvTE5tSLgbdRMM2biFbSL+0C7/+k66
	vfMHk6SxoUcihpuiAlFEzp1UmHwojQNv1/I+2WDXeQ==
X-Google-Smtp-Source: APBJJlGEdem6JZsSCDN9uqsR0YHdcbsSIzWsJBGkmVj40gbKlJ+TlZlkhCPsyQ7Q9XjJ1pFMhnFEHw==
X-Received: by 2002:a05:6358:6f1d:b0:134:c37f:4b63 with SMTP id r29-20020a0563586f1d00b00134c37f4b63mr1877880rwn.2.1689993690844;
        Fri, 21 Jul 2023 19:41:30 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b0054fe7736ac1sm3765391pgc.76.2023.07.21.19.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 19:41:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] include: dual license the bpf helper includes
Date: Fri, 21 Jul 2023 19:41:20 -0700
Message-Id: <20230722024120.6036-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The files bpf_api.h and bpf_elf.h are useful for TC BPF programs
to use. And there is no requirement that those be GPL only;
we intend to allow BSD licensed BPF helpers as well.

This makes the file license same as libbpf.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/bpf_api.h | 2 +-
 include/bpf_elf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/bpf_api.h b/include/bpf_api.h
index 82c47089f614..5887d3a851cf 100644
--- a/include/bpf_api.h
+++ b/include/bpf_api.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
 #ifndef __BPF_API__
 #define __BPF_API__
 
diff --git a/include/bpf_elf.h b/include/bpf_elf.h
index 84e8ae00834c..ea8a11c95c0f 100644
--- a/include/bpf_elf.h
+++ b/include/bpf_elf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
 #ifndef __BPF_ELF__
 #define __BPF_ELF__
 
-- 
2.39.2


