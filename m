Return-Path: <netdev+bounces-59611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71C81B816
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A0528950B
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508B12721A;
	Thu, 21 Dec 2023 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GgfzQ5Xa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36F1271E2
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu4glbhB3j/cE1E1r8McUbIGevfBKp31HiiDcFU3gNdi06fi6+5ZB85iG/LjdOvW+vfcr2nk0eF4q5QYjzmimF87KPTx+LICcfDbDpxFoAsfwB0wUXXxQ3Q2seIKDU2KcLFSQqH9/jE7UQ5fCiABXDndKoNgMafSAqF98b2l2j8sF4ffcMa72eaRWF4GHyrD8vI0ke2S2gMP/YsfTlhQqqzc3ckkUTvy5neGR/14+RV055ZZJM16OaPq59wnGrFzFyoz07+1L6O6m3NNBThqP5z5g6tRcjix5OEaAeaEGHdh9zqHPT16jFRAunXbcjqTDRGkOsW+/9eBFurWhFu+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kwxUxqDxyXxTnogSJU0Vm33ykF96R/nBAcpFwTcfdU=;
 b=cNkxMF5FF2DqjGQ/vJGMcrxsgZaTTqS/rjR1yX5dqpbR5I+ieBcb1tEWBKUhUVpB0J58OQZ4ZLP0K2c7AGh0lG7s/VdQCgwLjK8OF0DZPTPVfNixi/uuqB9YbprnvjoEmuiS8eYBF2z2pOqK2edL+BQOvpX6P+4C1/zO8mcLH+Mo8tHsUBeFn/7V+sfjRVsD0GqQZQDFUPnzwv9n2G8xs/Lruv2q/VjhLx39uSvxgw824RD3kyTgPC58F/HKkSj1lDGN+0PtjtT6lw5oko2ATTH8FK46rAIaiOlhv/3WlTWD1bQcvto18mF1xM3dtTbGJXsygSOY38JsgDv7VWKWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kwxUxqDxyXxTnogSJU0Vm33ykF96R/nBAcpFwTcfdU=;
 b=GgfzQ5Xa5STDwFVgIqiWOkgzzpAK8nnbK8Kyk4uDwMp77RVDxiOjCap561m4Zhvy4GFeMYh50jq9SFBN/LdkpBkr+smtBj8Zi/p+IAmESaBKhpX7FQ8yzG65ndJTVixYL1l/qWihtqC9LnVjf1vfFtjWJbEsRr0rdJS3E/tPuZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 13:25:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 13:25:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Subject: [RFC PATCH for-faizal 4/4] selftests: net: tsn: add tc-taprio test cases (WIP)
Date: Thu, 21 Dec 2023 15:25:21 +0200
Message-Id: <20231221132521.2314811-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
References: <20231221132521.2314811-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 312016be-a38f-40ed-93c4-08dc02285585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iDHv4rw5i0QRi+2oboz5ooZqBNbqzQcflGY8LoL9N1A1dcA5yuUAKHrxKvn1Ji9zl52w97EarOuu+1RW7Hu+hWQddYobqBueaTwKptW2P8x4FaSMjMwELBRgR1uliH1uOmSmwGySZ3SDNrxutMGF4Tm/O6DmgJpFcUAu9dMipffZ87apQ1Y3gAcOXK3m1CxatpiH1JRduXVHPS+xQH10DeY2KO2FwxHv89WDr5RraY9WGNWBmUCjDjCUw1t9ESU1FoQdF25sQ5CS9qDQRuqC+jVoKtTjmX9aw+cTGgjLZT2YNHeHAYa6cv26gR8QA61+y9AhAOaRNm5A/M3jJ5ETCL+86QsVckbE2XBFOUaBxV9JIosIb59z4FS6bXKbFI8Sl3+vAxsHSl+opV9igUfhh5M15aQnbEhFkCuj3nyHO1biILOoUnpqSJnCLGq86Ov3xCYDJFtUHOe7iS0h30rLlBvBEiRzzHF3q3eE3uKli0U3FJSHyhzrYPFo5Uqlpa2o0EjCqbDjm9mmlfkxVWmo+ONmjQzo+rBiPe0hPj1nbewZxodmRpANGmuI/5laZNWBDv0spgp2wutRNvX2LWjuN4CMJLZ56wkv7owqcGFJTsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(6666004)(478600001)(38100700002)(26005)(83380400001)(2616005)(52116002)(6512007)(1076003)(6506007)(4326008)(8936002)(8676002)(2906002)(36756003)(5660300002)(41300700001)(44832011)(86362001)(38350700005)(66946007)(6916009)(316002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iyDqRrdtJKeylUCNbma/rdtfuDN3A/hhqcYQwyXQll3EkDp8icD2Yd983sq?=
 =?us-ascii?Q?PPJWkPYaZ8/9x2ElpCVTk+84mufUXkzljL3zqrufwiYejElKJTFqYcWv6pui?=
 =?us-ascii?Q?V0TKOHsKVZ5McQaVOG7Y+r0fw1p1GqETBaZtkEGjSNOmNRJODeblOJefiUkh?=
 =?us-ascii?Q?NLq1la4mdxfx9W/BEcUwXgr+KETVgBAM5epBUhPdFkNeJDr2dxO9TktBy09c?=
 =?us-ascii?Q?tjRJRbKrD8mctdowDhZAzewqKdzc6z2o/bo0kdu1AAGdEY5SThKJ3OTjQjx5?=
 =?us-ascii?Q?S/gvB1SEYhRroHUjn4Lt+iJ47gV+3mkKDuoOkxvFgZjPBEpLyFrGvkIzyb0j?=
 =?us-ascii?Q?gED/nJekdOrAYBry9WiWjocSRhAAxgdqMKJerb3BCH2Uh/E9PfB0a0uOkK+U?=
 =?us-ascii?Q?rKDXQTlijFdcBFPTvfbD93wlaXQtf7v/qyxsnRRXn46ZWj35glubIzUYB49Y?=
 =?us-ascii?Q?jiT4u1gZ8cyexPNAPVGzgcmywKlvQcI9cz7bmU0gcy3vKZifvE+YCGt9IZ9p?=
 =?us-ascii?Q?1Hjd8qjfNXHCF9YgUduyeBYQGlTbIe1Sso/uebC3Fz+n0LAOz/mGKLDa3oTV?=
 =?us-ascii?Q?I7OQZ6NC8xGUPWtacclFaXQO/qjYCzOPBmJmqHvzLTmTX3QGO/Vxwm3Tp/kq?=
 =?us-ascii?Q?Qr1PIy6rbSIipK5xeidZ9nKoSqw62MXh0i2uQOY6VfAsnwmbEN4zPEGZ4kHJ?=
 =?us-ascii?Q?SjUg22xosNkSrbRf/bcG5pldrfWVZiq8OUpG9WMs+WsFy9xXYiTtzZcjZubF?=
 =?us-ascii?Q?J8VCJyiV8PtS0c0EHmTS0dEy9k8GZABfcbWltus3J6+Jv9jE1sFMrJQnNDbA?=
 =?us-ascii?Q?lpKCEs+YXx7XmO3WbM8RRUjKdBSB4uPI6O9jL3l3S4tKqQoqkBx0zmB+uifo?=
 =?us-ascii?Q?Dxb8ziy+SnLTYpnegqHergVKxMrmSGM0W9RRux2ZQoe9hsgTk8RM7j1mxx0I?=
 =?us-ascii?Q?KrtXgIssgMKRWkIS/FFzp7lYe9gFdeCP23Sonx2JXWA1C/oDIeW3nKqOWktA?=
 =?us-ascii?Q?rP9++KQT0JGBTs013B+kFw1Cex3/2trTFI9j1mARPmLkTW93fw6J2oZ7mFWT?=
 =?us-ascii?Q?Q6tIBwUafQISAKEMnw9dADULnOcMBCief2uG6jrXs8h57zbjeFlVcCnvW+e3?=
 =?us-ascii?Q?VIKIQ+HFFzWn1/YGZLX1lSx+3PTFF0qouJOKgOIJcpTMiTL/0+Ma/OpkwPYY?=
 =?us-ascii?Q?khiQTUGKzQ0GDWBmE9g/wyhUpPQqmzPmY1h2ISYh8TMhPYLQJzzUGaHWO8cF?=
 =?us-ascii?Q?zOgXo0qRg1kKci8n8EDxxOb+CA2rlEjkKDiIkMK+4bRCvo6Etwks2+nsD9AP?=
 =?us-ascii?Q?uUsU8UrtmYf1r1xUXKoHmi5FKVVxHZL7dlLERaHChS/OkFHw3FESXkHvr1Fm?=
 =?us-ascii?Q?WNEUTZYd5kbbBAgaqUTJwy1vjBbzsHD3cTL+rtEY279qcjsa/1KcSPCq8PUw?=
 =?us-ascii?Q?9G15Q0Q8GJ7Er7WePMZYVOTx+byWpvZr8hNJK8q/jXk0JNZzbl+OS6f65s4t?=
 =?us-ascii?Q?D25uzmLaqSg0gzNcg38WaIz5Li/tTWJLnklBTEatauGxa3zBSl+GHYmNfE9s?=
 =?us-ascii?Q?Er4auKpUDdLGJEFZFDWTW1vFYhhXbREgZBIp10wB9awMHrL0CSLcBP00wDd4?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312016be-a38f-40ed-93c4-08dc02285585
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:25:43.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wnz5gKgdmMMLIBnHuiGsdm4clsuhYZOwywUKnxX/2odC7WomNberDgzTWRtM2muMCnSxHbzq4goaS21PrrdPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9236

Obviously this is unfinished. While we were discussing about tc-taprio
behavior during schedule changes in particular, it would be much better
if the tests could slowly build up towards that complicated case, and
make sure that the simpler cases work well first: a packet gets sent
when it should (when it's sent in band with its time slot), gets blocked
when it's sent out of band with its time slot, etc.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/tc_taprio.sh     | 143 ++++++++++++++++++
 .../selftests/net/forwarding/tsn_lib.sh       |  42 +++++
 3 files changed, 186 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/tc_taprio.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 452693514be4..8e8ed75a3aac 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -97,6 +97,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	tc_mpls_l2vpn.sh \
 	tc_police.sh \
 	tc_shblocks.sh \
+	tc_taprio.sh \
 	tc_tunnel_key.sh \
 	tc_vlan_modify.sh \
 	vxlan_asymmetric_ipv6.sh \
diff --git a/tools/testing/selftests/net/forwarding/tc_taprio.sh b/tools/testing/selftests/net/forwarding/tc_taprio.sh
new file mode 100755
index 000000000000..387cc0860d4f
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/tc_taprio.sh
@@ -0,0 +1,143 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS="in_band out_of_band cycle_extension"
+NUM_NETIFS=2
+VETH_OPTS="numtxqueues 8 numrxqueues 8"
+source lib.sh
+source tsn_lib.sh
+
+in_band()
+{
+	local basetime=$(clock_gettime CLOCK_REALTIME)
+	local window_size=$((NSEC_PER_SEC / 2))
+	local cycletime=$((2 * window_size))
+	local expected=1
+	local isochron_dat="$(mktemp)"
+	local window_start
+	local window_end
+
+	basetime=$((basetime + UTC_TAI_OFFSET * NSEC_PER_SEC))
+	basetime=$(round_up_with_margin $basetime $NSEC_PER_SEC $NSEC_PER_SEC)
+
+	tc qdisc replace dev $h1 root stab overhead 24 taprio num_tc 2 \
+		map 0 1 \
+		queues 1@0 1@1 \
+		base-time $basetime \
+		sched-entry S 0x3 500000000 \
+		sched-entry S 0x0 500000000 \
+		clockid CLOCK_TAI \
+		flags 0x0
+
+	isochron_do \
+		$h1 $h2 \
+		"" "" \
+		$((basetime + 2 * cycletime)) \
+		$cycletime \
+		0 \
+		${expected} \
+		"" \
+		1 \
+		"" \
+		"--omit-hwts --taprio --window-size $window_size" \
+		"--omit-hwts" \
+		"${isochron_dat}"
+
+	# Count all received packets by looking at the non-zero RX timestamps
+	received=$(isochron report \
+		--input-file "${isochron_dat}" \
+		--printf-format "%u\n" --printf-args "r" | \
+		grep -w -v '0' | wc -l)
+
+	if [ "${received}" = "${expected}" ]; then
+		RET=0
+	else
+		RET=1
+		echo "Expected isochron to receive ${expected} packets but received ${received}"
+	fi
+
+	tx_tstamp=$(isochron report \
+		--input-file "${isochron_dat}" \
+		--printf-format "%u\n" --printf-args "t")
+
+	window_start=$((basetime + 2 * cycletime))
+	window_end=$((window_start + window_size))
+
+	if (( tx_tstamp >= window_start && tx_tstamp <= window_end )); then
+		RET=0
+	else
+		RET=1
+		printf "Isochron TX timestamp %s sent outside expected window (%s - %s)\n" \
+			$(ns_to_time $tx_tstamp) \
+			$(ns_to_time $window_start) \
+			$(ns_to_time $window_end)
+	fi
+
+	log_test "${test_name}"
+
+	rm ${isochron_dat} 2> /dev/null
+
+	tc qdisc del dev $h1 root
+}
+
+out_of_band()
+{
+	:
+}
+
+cycle_extension()
+{
+	:
+}
+
+h1_create()
+{
+	simple_if_init $h1 192.0.2.1/24
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 192.0.2.1/24
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.2/24
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 192.0.2.2/24
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	isochron_recv_stop
+
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/tsn_lib.sh b/tools/testing/selftests/net/forwarding/tsn_lib.sh
index 189bf27bad76..e72a18a1dee0 100644
--- a/tools/testing/selftests/net/forwarding/tsn_lib.sh
+++ b/tools/testing/selftests/net/forwarding/tsn_lib.sh
@@ -5,6 +5,8 @@
 REQUIRE_ISOCHRON=${REQUIRE_ISOCHRON:=yes}
 REQUIRE_LINUXPTP=${REQUIRE_LINUXPTP:=yes}
 
+NSEC_PER_SEC=1000000000
+
 # Tunables
 UTC_TAI_OFFSET=37
 ISOCHRON_CPU=1
@@ -18,6 +20,7 @@ fi
 if [[ "$REQUIRE_LINUXPTP" = "yes" ]]; then
 	require_command phc2sys
 	require_command ptp4l
+	require_command phc_ctl
 fi
 
 phc2sys_start()
@@ -251,3 +254,42 @@ isochron_do()
 
 	cpufreq_restore ${ISOCHRON_CPU}
 }
+
+# Convert a time specifier from 1.23456789 format to nanoseconds
+time_to_ns()
+{
+	local time="$1"
+	local sec=${time%%.*}
+	local nsec=${time##*.}
+
+	echo $((sec * NSEC_PER_SEC + 10#$nsec))
+}
+
+ns_to_time()
+{
+	local nsec="$1"
+	local sec=$((nsec / NSEC_PER_SEC))
+
+	nsec=$((nsec - (sec * NSEC_PER_SEC)))
+
+	printf "%d.%09lld" $sec $nsec
+}
+
+clock_gettime()
+{
+	local clkid=$1; shift
+	local time=$(phc_ctl $clkid get | awk '/clock time is/ { print $5 }')
+
+	echo $(time_to_ns $time)
+}
+
+# Round up value to next multiple, leaving a specified margin
+round_up_with_margin()
+{
+	local val=$1; shift
+	local multiple=$1; shift
+	local margin=$1; shift
+
+	val=$((val + margin))
+	echo $((((val + margin - 1) / margin) * margin))
+}
-- 
2.34.1


