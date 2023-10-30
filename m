Return-Path: <netdev+bounces-45201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A87DB65B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 10:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E261C2085C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBCDDBA;
	Mon, 30 Oct 2023 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD23SJwE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E57DDBE
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:46:07 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF313E;
	Mon, 30 Oct 2023 02:46:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso2956839b3a.1;
        Mon, 30 Oct 2023 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659161; x=1699263961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qt/HOKHOh/EIoMj31tq2KB1WSLaylYnzKSJxpWkse0=;
        b=jD23SJwEnddN5MaIBuuG8VG7+j+LFBd/vtZRwXSiaZNYVll10lYCCNhbTlAiXcYxCy
         U4UMTqEXckD08yqndiSJxQkEz0QZEFsLE3PaPOiJVTAGQLgC4accOpszW02/uIUtBKLn
         ti78ocK2FBpnrHFYzK9XFEt8VZolEBpLuOoslQKZ+dh1TuC+40ZpgKcnFRf+FQo9UlsS
         sb2fNTDwPaxgaIkc7tzkKgLGTeRCvKSDVcHXyhQ3Xki9tUPsDyzxq5/HalC8eA3zAnvB
         2LhpHjFMj/YFYYnKm2S8ZkH7btvyWWmcI76oyzCk7e8h+k6ktQTU1gczFnfqZG0UKBQm
         Qgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659161; x=1699263961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qt/HOKHOh/EIoMj31tq2KB1WSLaylYnzKSJxpWkse0=;
        b=tu6hmXPYckI4AO7Xpjucw/aqw/uUAihIYS8LMY9o6EYBQ3NolV9brR+Ul9O1cmqAAM
         LEySYfHR6BCMToAEVp0JGWeTgsy/6nkDqAKY9mnP2rhno3xWKB/fu3kUsX5hWrAcTSYq
         AqjGWPC4ml8oHw671mfWpTu3zM7NsFVT34DSo+q5Z8Z2XvvENz4qkI/VkgtXHRoZKV1d
         6al0iiIndn4dDvPtx9V0S2f/gE7TJ8zr9i6/Jvk2Rh7Ukhc3tsKuVPOZdyvo8sFfq4kb
         cKXuE8ZqHrTL1ZcL8sADePtW85zURIYOsypMbnlm+gK/crz/yG6Lx9QIV3mMBtL0ao87
         2qMA==
X-Gm-Message-State: AOJu0YyvJrlyQMKFXpzUI8VyQVvILKwla6n6eHNAua3FbIkwJHps83Xk
	zLwzc4s3WdBSetJXXOo8C9BHnqy+JI7Owop0
X-Google-Smtp-Source: AGHT+IHda227dLb5xvfoFxbvKZx60NqI4jMh7xM9cDab5JG8z2312iqgR4pl7TYWDcAcsMxCp2YbcA==
X-Received: by 2002:a05:6a00:26ec:b0:6be:c6f7:f9fd with SMTP id p44-20020a056a0026ec00b006bec6f7f9fdmr15652504pfw.11.1698659161182;
        Mon, 30 Oct 2023 02:46:01 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r17-20020a62e411000000b00686b649cdd0sm5528142pfh.86.2023.10.30.02.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:46:00 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: pmtu.sh: fix result checking
Date: Mon, 30 Oct 2023 17:45:55 +0800
Message-ID: <20231030094555.3333551-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the PMTU test, when all previous tests are skipped and the new test
passes, the exit code is set to 0. However, the current check mistakenly
treats this as an assignment, causing the check to pass every time.

Consequently, regardless of how many tests have failed, if the latest test
passes, the PMTU test will report a pass.

Fixes: 2a9d3716b810 ("selftests: pmtu.sh: improve the test result processing")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index f838dd370f6a..b9648da4c371 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2048,7 +2048,7 @@ run_test() {
 	case $ret in
 		0)
 			all_skipped=false
-			[ $exitcode=$ksft_skip ] && exitcode=0
+			[ $exitcode = $ksft_skip ] && exitcode=0
 		;;
 		$ksft_skip)
 			[ $all_skipped = true ] && exitcode=$ksft_skip
-- 
2.41.0


