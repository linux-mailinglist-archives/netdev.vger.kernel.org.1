Return-Path: <netdev+bounces-61132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA5822A80
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DB51F23FAF
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2A18650;
	Wed,  3 Jan 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="B8A0G8rD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com [209.85.221.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0C18B10
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f100.google.com with SMTP id ffacd0b85a97d-336746c7b6dso9247185f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704275331; x=1704880131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIa4kG4qt5bUO3xzFheVS/ahZwWAiFJ8Wb4M2t36nOE=;
        b=B8A0G8rDZCmLnLddzYBVAiJHS/Hn5aQ+UO69ZBGYx0/qtDE3m4tlmGtZtJuyrri0ID
         rIx1Udc7sNwjdDe3+62xht/VSL8QWeOteIs92LjY5SZfb19SlrNpdNzjgV/1aiS6DL2l
         EWinqJYPB8I+s0qio/lTmpxZhsKtqtYhTwPfZ6GlAz4U3N4fyqwgMv1LiyFvp9em+xCx
         f1z0BGtCvZjgQC0CLcVw8N/+XrqeOn7v9QMD1Om5RYqHBbix26VKhv2rud9qWtPxQeOH
         F+I1JnG3nhDLCeRxvPHZ7E7PeyQIMjXpipMrQVFfEuv33U3EFDpY87EbWrChi6KJkBHH
         S8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275331; x=1704880131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIa4kG4qt5bUO3xzFheVS/ahZwWAiFJ8Wb4M2t36nOE=;
        b=s5TumiatCeU6rhVqPqGYth8ejL/oTTjRv3f7qXsUT9VRFx04t/ZocinE1eRbei3GUn
         30vEr9956oyriAI+vauJcjh/yPgILln/TFHrENnuYDwhW3BLK0KEwhqStkKWvL1Yi9X/
         N/fSUFUPRxQ71JqRORRt3b+ia8NarKyVREXAIkJd+EMLtyiiiWhO9nx36CyJUNhvh96i
         h1OmEZBypowY6uUUQJGqvA7NT8vz7F5W6yWbpZMP3wDNtsrojyQR6QSxNgNxiM1vxijR
         g0pTvJjqAsEEMiUR/tqEGlHus9tMO+16WdkM4fWrqL6Y2WylewUqqxAY2h967cjEUEp1
         Xk1Q==
X-Gm-Message-State: AOJu0YwoM58IKvWTQjDnwztoXljQd6krEzNIlcwMHFlRNtBK+26R8Soa
	pnUQPSp1r2QP35oA6D9gW23RQKcC/rIR9UxxV06gN4pduWg7w8P7kdTHaQ==
X-Google-Smtp-Source: AGHT+IGdmnr6+p7hz/i8bGMCyMOVBhrXO1BjPKxOznQkdXBw0GXW8hPNnc/h3KYMKaqEwyVLMePlaUJcqj2B
X-Received: by 2002:a05:6000:1b03:b0:336:80c1:f6a8 with SMTP id f3-20020a0560001b0300b0033680c1f6a8mr10565041wrz.88.1704275331296;
        Wed, 03 Jan 2024 01:48:51 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id bs24-20020a056000071800b003374c867a26sm21924wrb.48.2024.01.03.01.48.51;
        Wed, 03 Jan 2024 01:48:51 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 09A6A6045F;
	Wed,  3 Jan 2024 10:48:51 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rKxrm-00A3cs-MJ; Wed, 03 Jan 2024 10:48:50 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface in a bond
Date: Wed,  3 Jan 2024 10:48:46 +0100
Message-Id: <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to check the following two sequences:
> ip link set dummy0 down
> ip link set dummy0 master bond0 up

and
> ip link set dummy0 up
> ip link set dummy0 master bond0 down

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 26827ea4e3e5..130be7de76af 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -28,6 +28,7 @@ ALL_TESTS="
 	kci_test_neigh_get
 	kci_test_bridge_parent_id
 	kci_test_address_proto
+	kci_test_enslave_bonding
 "
 
 devdummy="test-dummy0"
@@ -1239,6 +1240,44 @@ kci_test_address_proto()
 	return $ret
 }
 
+kci_test_enslave_bonding()
+{
+	local testns="testns"
+	local bond="bond123"
+	local dummy="dummy123"
+	local ret=0
+
+	run_cmd ip netns add "$testns"
+	if [ $? -ne 0 ]; then
+		end_test "SKIP bonding tests: cannot add net namespace $testns"
+		return $ksft_skip
+	fi
+
+	# test native tunnel
+	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr
+	run_cmd ip -netns $testns link add dev $dummy type dummy
+	run_cmd ip -netns $testns link set dev $dummy up
+	run_cmd ip -netns $testns link set dev $dummy master $bond down
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: enslave an up interface in a bonding"
+		ip netns del "$testns"
+		return 1
+	fi
+
+	run_cmd ip -netns $testns link del dev $dummy
+	run_cmd ip -netns $testns link add dev $dummy type dummy
+	run_cmd ip -netns $testns link set dev $dummy down
+	run_cmd ip -netns $testns link set dev $dummy master $bond up
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: enslave an down interface in a bonding and set it up"
+		ip netns del "$testns"
+		return 1
+	fi
+
+	end_test "PASS: enslave iface in a bonding"
+	ip netns del "$testns"
+}
+
 kci_test_rtnl()
 {
 	local current_test
-- 
2.39.2


