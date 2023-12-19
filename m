Return-Path: <netdev+bounces-58773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AFD8181B2
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 07:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55194B22D7D
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E651847B;
	Tue, 19 Dec 2023 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfwsN0X6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289BC144
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b9efed2e6fso3309207b6e.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 22:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702969063; x=1703573863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HjHG5FTRvUUZdzIFd+y9ga11kaRqJbdRYv3LxEBJtgI=;
        b=EfwsN0X64YBYHubW2RupsU7YknHdC47+KvRaOYazUbQVaGZR+sLXz8REk/Voucm1La
         WfOiw+4a087PU71XD1PBep1zBo4WN7xr3G7WK//J20pcw+xaY4n0CiK4n39nUmUd6/c3
         gHpQox6B5NhUcH5MuerXc74UKLXpJYfJpGL7V1tr0Exwn+I6kyugpTC2P0FvfoUNV73d
         /F4ktevDt9eWnlDm1GTMEMIwq0RE3CwS2gA5blWEtAP0Oo3Nr90gqI7JpHoXcHLYVr58
         FOKRutVju7vZ1oUpkOhkBThgPCUmNcKbgHFjMO5JTdRDAaWDxCdeoo+lYk5iDOw2rg7m
         3/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702969063; x=1703573863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjHG5FTRvUUZdzIFd+y9ga11kaRqJbdRYv3LxEBJtgI=;
        b=q4nN9jyLsvzsCRdv6qqloKawehBbRKBCx/6+ZGxRqrQRZ8wXVtl6oROZVhfpN+BkOT
         Q4EhGE6h+92t/O1EptOAL/V9qkdxBce5962McHS/BlTKvBoAm0ARyQ9pelr8hfCiStnT
         Xrx9fV4P911Ua7kBeb0ww5xn2l2S58xGEwp2OSHxzN5NZmhFVSbt9fUYCy96iF2oJY8T
         8nf0SGfS6FJnZ2g/TXdDRQQY8r1TOBLwvQj1m5oLsTlARBmMP6XJIUYPsYlliG6Fdy31
         d8VFKZYA9amiYs3iJd7VyaU7BAJGwukWo+EkN/MhLiKGR71zvVyGIdLSdFWb+4uRypbB
         4MMQ==
X-Gm-Message-State: AOJu0Yw7kI8Zuu74tjF9cFHz8C+tk1RMFWBHFLQyRYxEQoRd3Fg6ryKt
	Y6mN2hHQrOUt9CXehYgzuZlStDVRlugCdnTPeZE=
X-Google-Smtp-Source: AGHT+IEPxdzLqbI3zqgaXTHq/R44MAK1XCELTWEzuXLsaYLwbrV1Piv8t3c8a64E6SMLL0k0DLh6oQ==
X-Received: by 2002:a05:6808:1294:b0:3b9:e48f:d64f with SMTP id a20-20020a056808129400b003b9e48fd64fmr23076533oiw.71.1702969063600;
        Mon, 18 Dec 2023 22:57:43 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x28-20020aa79a5c000000b006cdd723bb6fsm5304741pfj.115.2023.12.18.22.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 22:57:42 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Daniel Mendes <dmendes@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	David Miller <davem@davemloft.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] kselftest: rtnetlink.sh: use grep_fail when expecting the cmd fail
Date: Tue, 19 Dec 2023 14:57:37 +0800
Message-ID: <20231219065737.1725120-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_cmd_grep_fail should be used when expecting the cmd fail, or the ret
will be set to 1, and the total test return 1 when exiting. This would cause
the result report to fail if run via run_kselftest.sh.

Before fix:
 # ./rtnetlink.sh -t kci_test_addrlft
 PASS: preferred_lft addresses have expired
 # echo $?
 1

After fix:
 # ./rtnetlink.sh -t kci_test_addrlft
 PASS: preferred_lft addresses have expired
 # echo $?
 0

Fixes: 9c2a19f71515 ("kselftest: rtnetlink.sh: add verbose flag")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 38be9706c45f..26827ea4e3e5 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -297,7 +297,7 @@ kci_test_addrlft()
 	done
 
 	sleep 5
-	run_cmd_grep "10.23.11." ip addr show dev "$devdummy"
+	run_cmd_grep_fail "10.23.11." ip addr show dev "$devdummy"
 	if [ $? -eq 0 ]; then
 		check_err 1
 		end_test "FAIL: preferred_lft addresses remaining"
-- 
2.43.0


