Return-Path: <netdev+bounces-110315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFF592BD4C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088F628C1C2
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF37319B5BB;
	Tue,  9 Jul 2024 14:44:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073511586F2;
	Tue,  9 Jul 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536255; cv=none; b=m20QthHAy7yoz/pm9vHUzoYr1LSwKv8vZ4yUbm8TVq2oxaJkntAnYOlywcHRF8qsFVCNQ51MKcIoDJsSCCISqEDjQ2rFUPT6b8az1dLfT5R4s6mremOYZ31XB7+ddt2j4AhJHRknj/dNBU/GHJM937SecpYk8VQJnut7fh3c+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536255; c=relaxed/simple;
	bh=4nymYfpCEH3VOG5rTBF3JeJSijHLIZCPgT+Tzq0RvH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KW/O+Fpal+7KSJ1VR4n4Ti46xHsfqgSP5bHDqruTemg/VeBu5qTnsZeFQzUwt4YK2Tge7ZXTHC8RTTkSNu6+o1sMP5wZQMDDE/kuC3eFGRJn5yhFVYT6ybILo51SIcfWhuThHkFEbkIjk+Aqmkdy+WEvtlS/911AuyXezeXWryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77bf336171so825158066b.1;
        Tue, 09 Jul 2024 07:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536252; x=1721141052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDkcHpsjalb3kFOBZY0JVFCIARpGdSbE/KpMQJNy3ns=;
        b=do403gMQKPBDttgsJJrwDyCZPPNUkUv0NpL0KKHd3Gd3zVDxlm9fTu20vjnLhxF9Gw
         VDDSG4pGKgziSSUt4DKpqFnaZiur1bFVfMKI/VSPYvZ0+bmSYy4sc4VPbftpiaEAUna0
         YTebXXjVE4TPUzdVrG4ClNUaWXMwVIsrPnaEBeo2cHyL1x+XAjUEoTTLWpShVVkM9Vx9
         tlUjTBLeeO3OByzxv5gEEnvIaLjAqE4NI+n5p5Jqn14ZcG7PR7hER2hq1aLJsraj4p9N
         pwvYGskvtHu0b83agfSApmylPwDJVgwwymUIv9Hc71U9dBovtRr4f1LYS1kMu8mvEBWJ
         acrA==
X-Forwarded-Encrypted: i=1; AJvYcCVLv3jlOuARB/bITYxHl196wxvVBWWSXePiAxyJ2TnG5CR0vEooOJ12fx0shTuMQvCzG/V8dmYWmk7Gh4OMLKAQprWIF3MoblzG4S9k5etZn2PXtEg4hX/h8WJugSfq5TSmhvvF
X-Gm-Message-State: AOJu0YwMGznu2torGCaGQK6GJeyRZKnON6Uq7LiKso8hnt+RA5sBaadI
	N+uUovuWL/mPekcBiTJ0Hz7Qfc37SvaaoOslH4k2fJnAH646xgSB
X-Google-Smtp-Source: AGHT+IEqMTgaS69QPQLyYI0G6nv2Ttr7MWPOepxNFYRWKJ872BwwkR4gXjbjhSfRdKiCM3pcmIqH1Q==
X-Received: by 2002:a17:906:2e93:b0:a77:db39:cc04 with SMTP id a640c23a62f3a-a780d2189a0mr173938966b.11.1720536252124;
        Tue, 09 Jul 2024 07:44:12 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc86bsm83092966b.31.2024.07.09.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:44:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] netconsole: Fix potential race condition and improve code clarity
Date: Tue,  9 Jul 2024 07:43:58 -0700
Message-ID: <20240709144403.544099-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset addresses a potential bug in netconsole where the netconsole
target is cleaned up before it is disabled. This sequence could lead to a
situation where an enabled target has an uninitialized netpoll structure,
potentially causing undefined behavior.

The main goals of this patchset are:

1. Correct the order of operations:
   - First, disable the netconsole target
   - Then, clean up the netpoll structure

2. Improve code readability:
   - Remove unnecessary casts
   - Eliminate redundant operations

These changes aim to enhance the reliability of netconsole by
eliminating the potential race condition and improve maintainability by
making the code more straightforward to understand and modify.

Breno Leitao (3):
  net: netconsole: Remove unnecessary cast from bool
  net: netconsole: Eliminate redundant setting of enabled field
  net: netconsole: Disable target before netpoll cleanup

 drivers/net/netconsole.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.43.0


