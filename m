Return-Path: <netdev+bounces-29503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E88783857
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A781C209CB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC6139B;
	Tue, 22 Aug 2023 03:12:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EBB7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:12:44 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0FC187
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a1af910e0so1607701b3a.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692673962; x=1693278762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaJXlYYD+X1nizpRhqpp++D+SmFV706G2JsxeaBKDO0=;
        b=WFUG73Ue0N9vJwAyv6RUn1tEtuFW/6R9L5D5PaKhXNlM2HHkkNZ3OlLXRvmVK1wFuX
         jE7ghO7Hfj/qCiiPBs3s6/84f+1Qng8aZZRB+BQvRz7h9XKbutGothDsI/E/5uzKmUKD
         v87wPDbmafEXNJv9AffcQLF4RNn93LN/TjGquYdhzonbI0UCF43JrO4hwIWlid6bWYO1
         ElyjKC8+yC4BjFVwfG9FlWzZMi5MfIi4t+55AEhnhZqSB/v1R16nvpJQ/+X5DSWodPvR
         J1gcn53Yd8Mh9F0HD3CT0YXx+KC1/G0mNkcSE43UC8QaEaON3UFrIkteoUguyDqG4KuT
         6cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692673962; x=1693278762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaJXlYYD+X1nizpRhqpp++D+SmFV706G2JsxeaBKDO0=;
        b=K1ZQWlPeujOLJUceOkcjBoWGNy4SqWSftYm30q80tiqVJtXmEEudidWyrPHdmo+jxc
         KUCWAh+mFpqvkimW8uR9+S4Au0so5wsYdUAw8Lto82Sh3GHU3WcfjkSpUVBjSnCXhLqu
         Q9FDmnOncVzqdfXBW78hBdAJZHW0UuyJj0S6btK7BwySMZOJQGFgTlQXkGgnvyPvCLNX
         CZ5pCH5EXa1YgJtpPN7O4eoCEOuNHnEJnmUu8bivn0aGi+2/dkzsZk6mOUJp6rCkrEvC
         rGPSvyKiDTlcrC7fe4UiG5akvljyDK3EvRG0w7hmpwigy2L/sKijcx97gG6LiGJRmLBU
         e2EQ==
X-Gm-Message-State: AOJu0YzHRqDge6zAZMGBAC3HqrjVd/F6YDJZNUYoCqL32ewJ3WwYtRfW
	s0lgTZG53FohHncV9SjYTySOJEXKj5DFeA==
X-Google-Smtp-Source: AGHT+IGINtxOtT2scUIWkAixhZKktog/BmNfYlDI0eA3bPj2OCn7CMtFteMylAW5UsdwepyXti90xA==
X-Received: by 2002:a05:6a20:4d8:b0:148:6398:866c with SMTP id 24-20020a056a2004d800b001486398866cmr5491863pzd.23.1692673961764;
        Mon, 21 Aug 2023 20:12:41 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001bde6fa0a39sm7803601plb.167.2023.08.21.20.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:12:40 -0700 (PDT)
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
Subject: [PATCHv2 net 3/3] selftests: bonding: add macvlan over bond testing
Date: Tue, 22 Aug 2023 11:12:25 +0800
Message-ID: <20230822031225.1691679-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822031225.1691679-1-liuhangbin@gmail.com>
References: <20230822031225.1691679-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 .../drivers/net/bonding/bond_macvlan.sh       | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh

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


