Return-Path: <netdev+bounces-63537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB30982DAC8
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 14:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB301F21097
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B74B17584;
	Mon, 15 Jan 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="UZfqMlyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC659175A6
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-50eac018059so10891533e87.0
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 05:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1705327165; x=1705931965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7NdteE8c5eCDXc3NckKfNOqUEFZPx441zSmf11SMTA=;
        b=UZfqMlywYqzkTEGKSi67aMFMcsKIaA1IFcd3bmIE0V1FpwHagHEA6cN9awGvFBWS7V
         CLJEI5jNvCo2JTz0Uoq2pHVel/R9MRQ85CU3i0jjupoxFY/Plw1uTEC6Lbfgpc/fgrtX
         Ma7AGrmP1B3kgxyeqcBaK6Vy0h2Y7tKtL3UtQad40TLRQlOqD4/kJYYBEw69H29QE3dj
         SmlA8tAy51dOFYwz6ygn963kepqmW8vp16z9xdjdFE3+r8a7TLs4lBFJYTOzEJjp9wCf
         VQBM9OIhQZulRUoUaZnhcb3TJDt2BiugrXmd5HX1Wfva3VVCRDMimCdtLZRQtc61AJX3
         qQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705327165; x=1705931965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7NdteE8c5eCDXc3NckKfNOqUEFZPx441zSmf11SMTA=;
        b=BEuvaFqrVrmnKRz7mAymj4k+RCajeeI47CJHqjlZ1qBzo5RqqqFAvuYsWSrvqLEvFI
         nKyNccEJg6cVtqMQoRjrqvduUKyQfG8RspCbjXqOSNG3OEHyI7gMMV0ns4F4d85LRpq4
         SvH2SPTFWVk/Rlu6JR4quzJQciznl9xky51+qG3LzQiEUeF3bVSbkt9z2E0P72dU9WQS
         DZ6TcmwdytzrsZ0iRf9pKpO8aBQm1iGtQ9ZZz/KZMShJ+ptoKsJB0ULxI6IIvAun9W6N
         IHc3pi7KA1mi0VEwtqlOimHOJo7VKYuRQ8ilseJ/VQdASRx5c+e7JQQB9Ibi00+r0VkK
         YCBA==
X-Gm-Message-State: AOJu0Yz9TezDIyb9EqyiSs0+fnDSp7KKGpBBkTQaFxr6pBhrvuq1fOOa
	4ZQbu40Tn0B+rsDppLlUdDCMlm63bjkZottkc5QLc6uL7e3wr0z6I/slNA==
X-Google-Smtp-Source: AGHT+IFe6WmYvMkcGsEvng1OZJT2VnNr/t4IlTeGBW47nZ8CcGOgWP1sKckJhBqzGU+Sg4zWcaXrAz0VPbA5
X-Received: by 2002:ac2:58ed:0:b0:50e:3479:3846 with SMTP id v13-20020ac258ed000000b0050e34793846mr2406871lfo.68.1705327164953;
        Mon, 15 Jan 2024 05:59:24 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id b3-20020a0565120b8300b0050e8e746405sm271863lfv.69.2024.01.15.05.59.24;
        Mon, 15 Jan 2024 05:59:24 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 6177B602BB;
	Mon, 15 Jan 2024 14:59:24 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rPNUq-00FMpM-1j; Mon, 15 Jan 2024 14:59:24 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net] selftests: rtnetlink: use setup_ns in bonding test
Date: Mon, 15 Jan 2024 14:59:22 +0100
Message-Id: <20240115135922.3662648-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up of commit a159cbe81d3b ("selftests: rtnetlink: check
enslaving iface in a bond") after the merge of net-next into net.

The goal is to follow the new convention,
see commit d3b6b1116127 ("selftests/net: convert rtnetlink.sh to run it in
unique namespace") for more details.

Let's use also the generic dummy name instead of defining a new one.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index a31be0eaaa50..4667d74579d1 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1244,21 +1244,19 @@ kci_test_address_proto()
 
 kci_test_enslave_bonding()
 {
-	local testns="testns"
 	local bond="bond123"
-	local dummy="dummy123"
 	local ret=0
 
-	run_cmd ip netns add "$testns"
-	if [ $ret -ne 0 ]; then
+	setup_ns testns
+	if [ $? -ne 0 ]; then
 		end_test "SKIP bonding tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
 
 	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr
-	run_cmd ip -netns $testns link add dev $dummy type dummy
-	run_cmd ip -netns $testns link set dev $dummy up
-	run_cmd ip -netns $testns link set dev $dummy master $bond down
+	run_cmd ip -netns $testns link add dev $devdummy type dummy
+	run_cmd ip -netns $testns link set dev $devdummy up
+	run_cmd ip -netns $testns link set dev $devdummy master $bond down
 	if [ $ret -ne 0 ]; then
 		end_test "FAIL: initially up interface added to a bond and set down"
 		ip netns del "$testns"
-- 
2.39.2


