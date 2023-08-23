Return-Path: <netdev+bounces-29896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B678515D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5621C20BF9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3BA921;
	Wed, 23 Aug 2023 07:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB746A920
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:19:24 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781EDB
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf55a81eeaso23747255ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692775163; x=1693379963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imfuNwQrvt8oRbEV7g7IR3XWoYzARFPysi3PTWISqfA=;
        b=E6FpOfR97jXVOJRQJwUqWUmiXjZyt2jciIKu+d5SGMWdS3mqB44h3QYQ4hZFN74+cR
         Yj8Iv7W88i363uQIod5Ulru2iIHtSTNc/e9JIQRxFfk9yYTz1R0LWyUG7UQeQNJdOARo
         F0M+WHy5tnPE2/d0g5WV6C8USX/TFoG8Ei8ZBTEcMGEy58PQI8YcK7VK+a4JC27HlTHv
         3RpJZkLBfCCdSgZ9M1rQm+0ouTX1wR8J9le3G5Ki7kJHBh1tQe58TtmvNxK6DRQ3P6K8
         gAlkO11UhGFXrHgjU2UfqHdSolOxJOSdLVPgeKSSNtSP9YZ8XOekifYQlcSgZy1IT5Vg
         6KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775163; x=1693379963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imfuNwQrvt8oRbEV7g7IR3XWoYzARFPysi3PTWISqfA=;
        b=FGi2NLtPplxhA3iXolzRrKjcM2menFQUeOTsHwuHLtFF+TkmafUBYDsr0g4d3ZQmO6
         RGHx7xb0SRrVeQXxlfj7TS4x2wBgbfTh87DRzEW2wAOrXoYUF/zfuIYPdmvyvMkiN8lv
         8xMhVtYeJbu3b8bUzlc5Sy3471MOfxnh74AJDcOddQiCGgUj5z7UNVZvfbEXpAfPr12x
         IWCVcC+iIdvjrweid15rkebqEoET+yLv8XXfk/baiLkm8g4ksMAMolmI3D3+eFA7M8YV
         5ekNR+LXaKUABkugilMTcSZGAvqDvqCvkOYXgg9UjYHkeACI8zzOQPcZuegTFzBzUbU+
         tuOQ==
X-Gm-Message-State: AOJu0YzByM0nLnbISYHalsgVKwkp5w87/xs0QmC9XamxLJBDclZ6DRfJ
	dAUuSu3MumnIjWqj5OKwJ5dEUG3dtHTbaw==
X-Google-Smtp-Source: AGHT+IG2BTbCsjPWVFwH5vakcxwrMToto7yHwvVyP99SJjM3HlCHLDwaTs5zcKFgnfDo3SO0qm7A9Q==
X-Received: by 2002:a17:902:da82:b0:1b0:3a74:7fc4 with SMTP id j2-20020a170902da8200b001b03a747fc4mr10269754plx.24.1692775162666;
        Wed, 23 Aug 2023 00:19:22 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001bdea189261sm10221212plb.229.2023.08.23.00.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:19:22 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 3/3] selftests: bonding: add macvlan over bond testing
Date: Wed, 23 Aug 2023 15:19:06 +0800
Message-ID: <20230823071907.3027782-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823071907.3027782-1-liuhangbin@gmail.com>
References: <20230823071907.3027782-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a macvlan over bonding test with mode active-backup, balance-tlb
and balance-alb.

]# ./bond_macvlan.sh
TEST: active-backup: IPv4: client->server                           [ OK ]
TEST: active-backup: IPv6: client->server                           [ OK ]
TEST: active-backup: IPv4: client->macvlan_1                        [ OK ]
TEST: active-backup: IPv6: client->macvlan_1                        [ OK ]
TEST: active-backup: IPv4: client->macvlan_2                        [ OK ]
TEST: active-backup: IPv6: client->macvlan_2                        [ OK ]
TEST: active-backup: IPv4: macvlan_1->macvlan_2                     [ OK ]
TEST: active-backup: IPv6: macvlan_1->macvlan_2                     [ OK ]
TEST: active-backup: IPv4: server->client                           [ OK ]
TEST: active-backup: IPv6: server->client                           [ OK ]
TEST: active-backup: IPv4: macvlan_1->client                        [ OK ]
TEST: active-backup: IPv6: macvlan_1->client                        [ OK ]
TEST: active-backup: IPv4: macvlan_2->client                        [ OK ]
TEST: active-backup: IPv6: macvlan_2->client                        [ OK ]
TEST: active-backup: IPv4: macvlan_2->macvlan_2                     [ OK ]
TEST: active-backup: IPv6: macvlan_2->macvlan_2                     [ OK ]
[...]
TEST: balance-alb: IPv4: client->server                             [ OK ]
TEST: balance-alb: IPv6: client->server                             [ OK ]
TEST: balance-alb: IPv4: client->macvlan_1                          [ OK ]
TEST: balance-alb: IPv6: client->macvlan_1                          [ OK ]
TEST: balance-alb: IPv4: client->macvlan_2                          [ OK ]
TEST: balance-alb: IPv6: client->macvlan_2                          [ OK ]
TEST: balance-alb: IPv4: macvlan_1->macvlan_2                       [ OK ]
TEST: balance-alb: IPv6: macvlan_1->macvlan_2                       [ OK ]
TEST: balance-alb: IPv4: server->client                             [ OK ]
TEST: balance-alb: IPv6: server->client                             [ OK ]
TEST: balance-alb: IPv4: macvlan_1->client                          [ OK ]
TEST: balance-alb: IPv6: macvlan_1->client                          [ OK ]
TEST: balance-alb: IPv4: macvlan_2->client                          [ OK ]
TEST: balance-alb: IPv6: macvlan_2->client                          [ OK ]
TEST: balance-alb: IPv4: macvlan_2->macvlan_2                       [ OK ]
TEST: balance-alb: IPv6: macvlan_2->macvlan_2                       [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: add the script to Makefile
v2: no update
---
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_macvlan.sh       | 99 +++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 0a3eb0a10772..8a72bb7de70f 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -9,7 +9,8 @@ TEST_PROGS := \
 	mode-1-recovery-updelay.sh \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
-	bond-eth-type-change.sh
+	bond-eth-type-change.sh \
+	bond_macvlan.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
new file mode 100755
index 000000000000..b609fb6231f4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test macvlan over balance-alb
+
+lib_dir=$(dirname "$0")
+source ${lib_dir}/bond_topo_2d1c.sh
+
+m1_ns="m1-$(mktemp -u XXXXXX)"
+m2_ns="m1-$(mktemp -u XXXXXX)"
+m1_ip4="192.0.2.11"
+m1_ip6="2001:db8::11"
+m2_ip4="192.0.2.12"
+m2_ip6="2001:db8::12"
+
+cleanup()
+{
+	ip -n ${m1_ns} link del macv0
+	ip netns del ${m1_ns}
+	ip -n ${m2_ns} link del macv0
+	ip netns del ${m2_ns}
+
+	client_destroy
+	server_destroy
+	gateway_destroy
+}
+
+check_connection()
+{
+	local ns=${1}
+	local target=${2}
+	local message=${3:-"macvlan_over_bond"}
+	RET=0
+
+
+	ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
+	check_err $? "ping failed"
+	log_test "$mode: $message"
+}
+
+macvlan_over_bond()
+{
+	local param="$1"
+	RET=0
+
+	# setup new bond mode
+	bond_reset "${param}"
+
+	ip -n ${s_ns} link add link bond0 name macv0 type macvlan mode bridge
+	ip -n ${s_ns} link set macv0 netns ${m1_ns}
+	ip -n ${m1_ns} link set dev macv0 up
+	ip -n ${m1_ns} addr add ${m1_ip4}/24 dev macv0
+	ip -n ${m1_ns} addr add ${m1_ip6}/24 dev macv0
+
+	ip -n ${s_ns} link add link bond0 name macv0 type macvlan mode bridge
+	ip -n ${s_ns} link set macv0 netns ${m2_ns}
+	ip -n ${m2_ns} link set dev macv0 up
+	ip -n ${m2_ns} addr add ${m2_ip4}/24 dev macv0
+	ip -n ${m2_ns} addr add ${m2_ip6}/24 dev macv0
+
+	sleep 2
+
+	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
+	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
+	check_connection "${c_ns}" "${m1_ip4}" "IPv4: client->macvlan_1"
+	check_connection "${c_ns}" "${m1_ip6}" "IPv6: client->macvlan_1"
+	check_connection "${c_ns}" "${m2_ip4}" "IPv4: client->macvlan_2"
+	check_connection "${c_ns}" "${m2_ip6}" "IPv6: client->macvlan_2"
+	check_connection "${m1_ns}" "${m2_ip4}" "IPv4: macvlan_1->macvlan_2"
+	check_connection "${m1_ns}" "${m2_ip6}" "IPv6: macvlan_1->macvlan_2"
+
+
+	sleep 5
+
+	check_connection "${s_ns}" "${c_ip4}" "IPv4: server->client"
+	check_connection "${s_ns}" "${c_ip6}" "IPv6: server->client"
+	check_connection "${m1_ns}" "${c_ip4}" "IPv4: macvlan_1->client"
+	check_connection "${m1_ns}" "${c_ip6}" "IPv6: macvlan_1->client"
+	check_connection "${m2_ns}" "${c_ip4}" "IPv4: macvlan_2->client"
+	check_connection "${m2_ns}" "${c_ip6}" "IPv6: macvlan_2->client"
+	check_connection "${m2_ns}" "${m1_ip4}" "IPv4: macvlan_2->macvlan_2"
+	check_connection "${m2_ns}" "${m1_ip6}" "IPv6: macvlan_2->macvlan_2"
+
+	ip -n ${c_ns} neigh flush dev eth0
+}
+
+trap cleanup EXIT
+
+setup_prepare
+ip netns add ${m1_ns}
+ip netns add ${m2_ns}
+
+modes="active-backup balance-tlb balance-alb"
+
+for mode in $modes; do
+	macvlan_over_bond "mode $mode"
+done
+
+exit $EXIT_STATUS
-- 
2.41.0


