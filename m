Return-Path: <netdev+bounces-59126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB370819682
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 02:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385801F267AE
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C927C121;
	Wed, 20 Dec 2023 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UMzs563K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47928F71
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cd82917ecfso2867281a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703036873; x=1703641673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhP0/KeAkEXkYbNZIC9cYiWhoMF1Ptz+Mj0ZXLXOzVQ=;
        b=UMzs563KxTD+JAD70Cg49Kw0b3kwetoLWt8oVcCFs6TwRThoOcToifhTIzeYDVurcr
         A4+36+nvqh+DUjIQTp0nEQdRBOiFmr5CU+fdEMGQdIkmMxARy9fpi7aEWNCQHky0G1wu
         wkQE2B++aSUZ1sdXXKSKrj5xzh5oixYP6qtKJsb28fqr9p06Fbz+QVjqn7gxgQ6tBAmQ
         vQ83hEEWA9UrqnHaR7EgsZ8UAVpKrJSxaJa9oIMXHjiSbOoKxDu/6u3MJ2EcdLLKyUZk
         ggUk8l7hHZj0l7CZTN3kbIl0fr3i1UPrlEm6dg1evkBSXjKFM6hHU+14Kbu9lXZ5gJvW
         4vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036873; x=1703641673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhP0/KeAkEXkYbNZIC9cYiWhoMF1Ptz+Mj0ZXLXOzVQ=;
        b=R4nA9RjDU2HzNRYKCI0zCsMPShJYpWluAP/EC1GnARqG+3r/UvqY4/sS9IRP4zYp2A
         B2u5psv/JAcczr/AMq7fqVZXlC6/BRDUfblx1XOC4p7Azd2mB/6iCkcGJlbNaT3l3rTQ
         IaRojanSrarP0wJXaXTEmMpaU4boJzpO8pbVOZBz6G8DuiPlZcIVVYNWKyrnQxiT+lkZ
         RWI4bK2gkFokdEYf3gTRYNg71DodiRmusYTDElMLQSEJjf3jcecIDn3oK/C2noHB3bSu
         7eG4/zdL5kGaLmeBxeJxFe6Ax4IoMwK/8+szelLpjONXvhmdeVnHu6FSyVSwmjOl9XOF
         qQLQ==
X-Gm-Message-State: AOJu0YyCl/7LG5EF6yyJk3+OlOUVZSNQoJ0KV22oYS4lbzbvjv+JF1E2
	eDe3x4OND+I5RoSimerSoBIpVw==
X-Google-Smtp-Source: AGHT+IHRH1ES13uStC+Ujo4x+yM4O0KcqOWMrCspH2ByaznxzzFMHcctOfCJBesEVUXKABDzgs67Cw==
X-Received: by 2002:a05:6a20:5492:b0:18c:90b1:7bdf with SMTP id i18-20020a056a20549200b0018c90b17bdfmr24664723pzk.53.1703036873115;
        Tue, 19 Dec 2023 17:47:53 -0800 (PST)
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b006d93e9c50a9sm1165243pff.110.2023.12.19.17.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:47:52 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 4/5] netdevsim: add selftest for forwarding skb between connected ports
Date: Tue, 19 Dec 2023 17:47:46 -0800
Message-Id: <20231220014747.1508581-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231220014747.1508581-1-dw@davidwei.uk>
References: <20231220014747.1508581-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect two netdevsim ports in different namespaces together, then send
packets between them using socat.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/netdevsim/peer.sh   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
new file mode 100755
index 000000000000..942526640d59
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,123 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+NSIM_DEV_1_ID=$((RANDOM % 1024))
+NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
+NSIM_DEV_1_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_1_ID
+NSIM_DEV_2_ID=$((RANDOM % 1024))
+NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
+NSIM_DEV_2_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_2_ID
+
+NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
+NSIM_DEV_SYS_DEL=/sys/bus/netdevsim/del_device
+
+socat_check()
+{
+	if [ ! -x "$(command -v socat)" ]; then
+		echo "socat command not found. Skipping test"
+		return 1
+	fi
+
+	return 0
+}
+
+setup_ns()
+{
+	set -e
+	ip netns add nssv
+	ip netns add nscl
+
+	NSIM_DEV_1_NAME=$(find $NSIM_DEV_1_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_DEV_1_SYS/net -exec basename {} \;)
+	NSIM_DEV_2_NAME=$(find $NSIM_DEV_2_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_DEV_2_SYS/net -exec basename {} \;)
+
+	ip link set $NSIM_DEV_1_NAME netns nssv
+	ip link set $NSIM_DEV_2_NAME netns nscl
+
+	ip netns exec nssv ip addr add '192.168.1.1/24' dev $NSIM_DEV_1_NAME
+	ip netns exec nscl ip addr add '192.168.1.2/24' dev $NSIM_DEV_2_NAME
+
+	ip netns exec nssv ip link set dev $NSIM_DEV_1_NAME up
+	ip netns exec nscl ip link set dev $NSIM_DEV_2_NAME up
+	set +e
+}
+
+cleanup_ns()
+{
+	ip netns del nscl
+	ip netns del nssv
+}
+
+###
+### Code start
+###
+
+modprobe netdevsim
+
+# linking
+
+echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
+
+echo "$NSIM_DEV_2_ID 0" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	exit 1
+fi
+
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
+
+echo "$NSIM_DEV_2_ID 0" > ${NSIM_DEV_1_DFS}/ports/0/peer
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 port0 with netdevsim2 port0 should succeed"
+	exit 1
+fi
+
+# argument error checking
+
+echo "$NSIM_DEV_2_ID 1" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent port in a netdevsim should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_ID 0" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with self should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_2_ID a" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "invalid arg should fail"
+	exit 1
+fi
+
+# send/recv packets
+
+socat_check || exit 4
+
+setup_ns
+
+tmp_file=$(mktemp)
+ip netns exec nssv socat TCP-LISTEN:1234,fork $tmp_file &
+pid=$!
+
+echo "HI" | ip netns exec nscl socat STDIN TCP:192.168.1.1:1234
+
+count=$(cat $tmp_file | wc -c)
+if [[ $count -ne 3 ]]; then
+	echo "expected 3 bytes, got $count"
+	exit 1
+fi
+
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_DEL
+
+kill $pid
+echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_DEL
+
+cleanup_ns
+
+modprobe -r netdevsim
+
+exit 0
-- 
2.39.3


