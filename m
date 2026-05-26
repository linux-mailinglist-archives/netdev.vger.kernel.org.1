Return-Path: <netdev+bounces-291554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAJcIZ1CFWoOUAcAu9opvQ
	(envelope-from <netdev+bounces-291554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:50:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFFD5D1520
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AA43011F37
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDA3B3C14;
	Tue, 26 May 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ffMa3uZy"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7D3B4EA9
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778180; cv=fail; b=Ycs5CtjqzfHYt7LbnuOzJTY35R/zNMvO6G8ECbJMYpbR87HJCwq2MLWdsVTbsR53mmCrIarqwpAfyG0TnfMI4VLuAB5tf+ltfW5y1oP4q9NxVTWAZzefFmv5MjybiWmu91x1Wp0svN5Pw2K5JSSKPasDoRiXe9M37OkxEDUaKJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778180; c=relaxed/simple;
	bh=C1+fsCPRSVOSe/GpUmp5IMNI8HLtZ/Gus0TG2F2XKrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/KVrLSwxFEFMkLEVbbtS3j/JSHlzGEm+P5iq8/M8XBP9pPYZ8mq4g8vI5WEFXiiq0kknHIAKhzOTi1ydWC43aFVZv/ujV8XQTi7domc2lcPiq6oAyWX9G0j8Q7sN7ogYnmVDqsNHoUQx7yoGJGaZgI+YxGLRxo2NrWf9AE0Zh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ffMa3uZy; arc=fail smtp.client-ip=52.101.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6rqt8NcJeHKcak4luxHc8Z7N/CCFwNaYp/i0T9QJH3Sgo+8GSFF6MI5sE+eJ2jwDMEsUpeXCs4Z6uBTS1tLXwdpACizCTRTYDVNUP69wzaZQX9GOVqMC1pSe2rf3zJm3rSJjlsUBMEoIR2QFeFpEMA3PpbUE0wRC+0kYPmjYcMZ0lxtFRcEh4LM/hPf2yQhaT+8GYZEA7cm4qNvExw3T3+Ed9aWdJsQfNYdmUBsnhokc0nTRApYGI8HBmP3DzdWN1nVlSCyJxntZq3ZrG9aN4GTTp2eRVF3cEsHlpKFJuUfkuMCPf8bEGT3Vrct/orKNV70qJyXy/9hsoVzRhxsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJQZ2dwzLr8UjZLE+LIc1wxkLr7nKaNheYee2CQJi1U=;
 b=YVHkcd9Vx9QM85emlOeB9d2DYGixi5E1CJG/Dz6KpPjwBG3PERL4nc382+m5pAJ7EVenNdEu2/5VVpfQwhf+j8ZNr5wViMpgz2LzGosUyjM/NpDQhQ0Q7N2yDW7Ha1QO5QzdPR7ZdRkpYTYdaqKTkXg9xVd7u+L11IUAH9WC7lgjSpLNPW36Q/ROkJ4N1OEdfDY7/Z3zMqNO1DHNVRehY0TMRm2cgjXJUVKFjM3+Ma7KDs8IIWP43wtMhjZ6KNF1h5V2rZgMD/fuJ0MYwM3PZTmE88LgyfTKILZ7UKrd2Oc4uKaIejpV6t0dro7waohDfSBV8KGIfCWCBdLFPygMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJQZ2dwzLr8UjZLE+LIc1wxkLr7nKaNheYee2CQJi1U=;
 b=ffMa3uZyjZ4jJRRqxTCAiaKqFNHUPnXU8L6Klhy2eAKbrHgM1qVL4+TTMifHqSBuURWQP2UcOXhyRr6yMl7Mf4uoF4EGIQWMclXUY7DBryx0Jfx8aDYrbN1ARQI2juMAN5Tt7I9Mba17Z0oYQyrKGyrjyp1g+1yyq5LaqNdbXaJiLrhyGg7ww9XEBJFUsFHuKgPCJzQUIlYlmCqRHvQfdOQAvwKSL11VgSsW9xBfmOagxqexyMa6DRSd8aB/qewfTCEEBvGvTUPbnTVNuH8MKwXgDyNdVa1vhhyyZXwPAiLQO2hTEeNNW22iX8J6A3M+TI8m9SFhs/Z3c0bDM1tuIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 06:49:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 06:49:29 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 3/3] selftests: rtnetlink: Add bridge promiscuity tests
Date: Tue, 26 May 2026 09:48:18 +0300
Message-ID: <20260526064818.272516-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526064818.272516-1-idosch@nvidia.com>
References: <20260526064818.272516-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e70094c-82f9-48d0-f548-08debaf2ef6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zVsO2KiU0h8nFMxowCyADPX1k2nKj2ClIKxQ5qTmGYBgPbn0kMhVSJI/R0SRy3bu2ADGhODW7gWa57SJ83VoyYD8K5T5De0Undgf30JxcGVoH2rfTO4V3LqQqVGDxFtLNEmhvaDp6M+fXAxk1PKsMFZ6ohP9sNvRGpOWcBrAfU5nK+rphNEYVslnqbLLEPSgm6g/5FftIUC/o/1Dz1EfYp++crtol66hbFB6EnPqk23uPLIm9GUuh4r9eeQ2OJ4Wh0VY+rcegWr9L+upHKDQcZ7AReiqh9V5dGq137oRgQzmMLkvtucDiKnJSfv4PTqIRlu1ME2x/fdkb2VRm0ybkn2OUjpg7wKm7yuQmmp6CcLE2Z0XVJbfOYyIg+b7oZx0UoVkNL3raXKcMOo76hgIrraNgoxVsjqT2DJD/Tb1ECyV/jBflRmroYIjYugO0D5nTWyA7QyZqfwxyN6gAi/DGMr+8R6/DKORQLx5HLs76v7yBG3u34KZRTBXzq8y29T36YRgNJcRFJkOd99GDNViyNcxAy8O+CMy4vhE+7C5VWMv2elXTPpgFAOeMgKguWY4dz1wdgDU/LxF5l+fPWTmaFf0NihwtSwFr2breh5T2kIepWyN+0W8Bpnjp+0tLiNeQI6lbgewVgivz/jt1g1U/CFQKy5TXG6mwvr5iVbg5boeHZqGiOWmUBWRw2n7YvfR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9791C23FVegzOZzxaYN1GoVErHtly5TctuIaISaIHQ0AMRdmoScsZ26NFBr?=
 =?us-ascii?Q?d9SezAu8bl9uHUrg2Uhdj0U5HzwoTKEBaryFEqpszKzdVL9pkIdBaxriu7rc?=
 =?us-ascii?Q?ThhR7UxZL0Ch1FPZgxmgL/ibD6coOvOQtfCFpKsbuINSxlK5GECs3gPrNYUK?=
 =?us-ascii?Q?r+KDWA1+eHlhwIHEO3jueUm3A6vIR+HTajHS5XWu0c9mVzppxFG2VDyQEFpF?=
 =?us-ascii?Q?hXT+HuCMno+9bBfdGXZB5g4D07hTV7AcgG9f2QSekwRlyP9P8CNzojC+mOe3?=
 =?us-ascii?Q?KY7QqFGJLAe1/e/Q22mM5RdcDx7v6Rj3BjBrw3uBW0CnCymIDxkG/clp3GWy?=
 =?us-ascii?Q?7/Y9ll6E6ix8mLWLK6307CQwTNU0dQJFVj7WhfiIb0xQxCX+rughxGcyKEU1?=
 =?us-ascii?Q?AOpvHClgBJzQSAQn9O+9Hf/jKQ3jlMgvzw0nlXxBoZDlq/mdxie4vgUNCiI4?=
 =?us-ascii?Q?NUe5i578cIaa9vSmgpYbPggt4NBqhg3kyoErn2iX3t/Akp0a3BLH6joPeeGJ?=
 =?us-ascii?Q?RZI930tgirdz4Zaun9RJcnG0a+vRDIrs/tU5rCMle001tK8rOhkF2Y8vd881?=
 =?us-ascii?Q?JYO6InwdfBxKx0S1kr8GVTXw/C1m/l4TP+bSoXyV10rIXhedFk0sMa0aeC6W?=
 =?us-ascii?Q?+QKeVV4VZ615gQ7nyUlhMN4w/Ho7j+dELeMjELstkG/o9npLG+YB7bahlCDj?=
 =?us-ascii?Q?PEeNG6MLGL8hs0M9mzuo9RQH3+duqjfXs+d/j1M+hRV+k/m3q2pHSi1//112?=
 =?us-ascii?Q?T1q9ZI2rrwvRQqRURBYkDDHeot/+PD0L6xX2f7yiWDEz2B3ZvXnjN2vD9D4Z?=
 =?us-ascii?Q?ksr9dtexABsLLpUQczTKrFhdKqbDVoAOku/Wbs7GGnRVomrXWO6zYiCCZ2E0?=
 =?us-ascii?Q?zq6SZnyyb22+nmpd4jhbzg3B6/e2Ca6HXFZW5ZLEYBN1htyVHBy/ZKanpAw8?=
 =?us-ascii?Q?IjRgFj1u8wV1JbtM3Cc6aXesk5ee/HpjTKILAwKZYROJ0uQAzYbUX0OHCNLM?=
 =?us-ascii?Q?Vf2CKOnSd+mpPLFUP/FM1Y6AOiSlJy1Z2em/MXZAEfoDqTtarK6BfGOUxu36?=
 =?us-ascii?Q?dD0qSQs7tWJOyrVk3MRYW7KIJyQUHlurjLqrlufRJeVVpLVTlfKCh9S1UY3b?=
 =?us-ascii?Q?e1RSavttg39Qg9rpESINzz7RQWQo+o90Q7eVdTFiaoepYaeZVnEkn2Xx9QUh?=
 =?us-ascii?Q?zENtF84y2UaYISewg8Ic6roUZMVIFT+6cABSep+44/VdcxExvUdFMc3PWVdX?=
 =?us-ascii?Q?USknlx8VjiqVGWc6ZwUy3sIB8PGcbOwfxeDu6aPe4j2TziJdCfhRwlceOvlG?=
 =?us-ascii?Q?4TTaucNq6HyMv8tZSgDQ0vh2uIybRO6RxGIsBqmMOu7P3YTKsVholK1bPpmt?=
 =?us-ascii?Q?qHr/cLeKNgfC7x5O5tlh74s0i8XeztYyCTlFEr4gtTRV230R65LAoQaFhI/U?=
 =?us-ascii?Q?aJbtvMEK69O6Z9wBJLO/J+4e14nZU/GR5PPaZgKyp8SVXYqq7tGZxVVJUyd/?=
 =?us-ascii?Q?gqCYXvmoEQC4ltY36SzI27PZhALdb+4G3o03zGNOrpwGc+nGOnczkEOa1xgA?=
 =?us-ascii?Q?yhnAneB7peEiC+ADkvT7hOOTAbfGwXUq/Kmk/HGEiJZKahGa1ucbb708Icfq?=
 =?us-ascii?Q?hfPcJY+LEXuCLc1QKk8iIbxyAfytvlD9+39zTwjG8AnQYXK08XNQBIAsShNL?=
 =?us-ascii?Q?VnLtElX6GH4SKIJxGFHZ+xYDeIvcD5NXTvmG6+DRUdixENlI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e70094c-82f9-48d0-f548-08debaf2ef6f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:49:29.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcbfYGumUK/iczolF/cq/Z3tWZcOm5ZPb/h8pB6bHdgliQiBOQ/3h4n0TWDo8IKecD5vTxmxuhFredZVvMi8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291554-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: DBFFD5D1520
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add two test cases that always pass, but trigger sleeping in atomic
context BUGs without "bridge: Fix sleep in atomic context in netlink
path" and "bridge: Fix sleep in atomic context in sysfs path".

Assisted-by: Claude:claude-opus-4-7
Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 63 ++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index c499953d4885..ace3a99023ed 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -24,6 +24,8 @@ ALL_TESTS="
 	kci_test_macsec
 	kci_test_macsec_vlan
 	kci_test_team_bridge_macvlan
+	kci_test_bridge_promisc_netlink
+	kci_test_bridge_promisc_sysfs
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -61,6 +63,14 @@ check_fail()
 	fi
 }
 
+sysfs_write()
+{
+	local val="$1"
+	local path="$2"
+
+	echo "$val" > "$path"
+}
+
 run_cmd_common()
 {
 	local cmd="$*"
@@ -680,6 +690,59 @@ kci_test_team_bridge_macvlan()
 	end_test "PASS: team_bridge_macvlan"
 }
 
+# Test that changing bridge port flags via the netlink path does not sleep with
+# the bridge spin lock held.
+kci_test_bridge_promisc_netlink()
+{
+	local dummy="test_dummy1"
+	local bridge="test_br1"
+	local team="test_team1"
+	local ret=0
+
+	run_cmd ip link add $team up type team
+	run_cmd ip link add $bridge up type bridge vlan_filtering 1
+	run_cmd ip link add $dummy up type dummy
+	run_cmd ip link set $dummy master $bridge
+	run_cmd ip link set $team master $bridge
+
+	# This causes the bridge driver to sync all the static FDB entries to
+	# the team device (which supports unicast filtering) and remove it from
+	# promiscuous mode. The call to dev_set_promiscuity() can sleep due to
+	# Rx mode inlining, which is a problem if the bridge spin lock is held.
+	run_cmd bridge link set dev $dummy flood off learning off
+
+	run_cmd ip link del $dummy
+	run_cmd ip link del $bridge
+	run_cmd ip link del $team
+
+	end_test "PASS: bridge_promisc_netlink"
+}
+
+# Same as kci_test_bridge_promisc_netlink(), but the flags are changed via the
+# sysfs path.
+kci_test_bridge_promisc_sysfs()
+{
+	local dummy="test_dummy1"
+	local bridge="test_br1"
+	local team="test_team1"
+	local ret=0
+
+	run_cmd ip link add $team up type team
+	run_cmd ip link add $bridge up type bridge vlan_filtering 1
+	run_cmd ip link add $dummy up type dummy
+	run_cmd ip link set $dummy master $bridge
+	run_cmd ip link set $team master $bridge
+
+	run_cmd sysfs_write 0 /sys/class/net/$dummy/brport/unicast_flood
+	run_cmd sysfs_write 0 /sys/class/net/$dummy/brport/learning
+
+	run_cmd ip link del $dummy
+	run_cmd ip link del $bridge
+	run_cmd ip link del $team
+
+	end_test "PASS: bridge_promisc_sysfs"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.54.0


