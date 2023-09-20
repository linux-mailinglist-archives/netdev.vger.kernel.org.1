Return-Path: <netdev+bounces-35114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5627A722C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2464B281046
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3B23C6;
	Wed, 20 Sep 2023 05:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798515A5
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:37:51 +0000 (UTC)
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 22:37:48 PDT
Received: from corp-ob09.yahoo-corp.jp (corp-ob09.yahoo-corp.jp [182.22.125.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945394
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:37:48 -0700 (PDT)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2110.outbound.protection.outlook.com [104.47.23.110])
	by corp-ob09.yahoo-corp.jp (Postfix) with ESMTPS id 61F2419FB185
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:28:49 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZpezaVsdwPzq7uo6GRK6kAr4J+hRwfiGd7A+4aLVoRo15pXfkwzmvQRIy8/4RBeYl0PRMZqcEUvhT/GdNuAdWc+oXo8V7unnz69NEtrE4wtoxedd1XBdJzmI0TFv484VnRy+7+h4clDpPQSv9H2ObKsjGk0nf1CoTFt2KM9Idu5liPKbqmppulw7cwfZU2RjGmmZSTYl92dBJM0Z9G5Mn6o6TktHfE9ORnqrfFvLsk+53WwXOSTJzAiCH0WpzNsWvdzZZQpfzX5FY2MQWVGhABu5cQ2Ctlo2RtQFHvZhlFQMJLp+jF0Ju6GmNdDW3kKNNkOFp5LhKwde0QXBs8okQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP5oSMI0JPFWI2fQFR3p6K5T5de+7PuY7Vuc+yFl3as=;
 b=NyBsV0LmQeDbjtAfUL/LwVbOIF+GTuwThLY7f/yWBxFPk9v+Zl1ckkVBhEqPv9JwfZByRPbTD/TnZzfCS/7KcgsgeVZsfL1sVPBa2yG6xVtaqghw+R7FT9rbzWGkfkpxjx49LB+XGHoL0NJqMTT/CuOJCP/BQspGY4+gnorPVMknbQxcY0d6aHt5wEidpzE1nlHZsLEIwJ7/VG1/cp8Lqe+dr95KcTCZj7CLLAASeFee80XzhFTO6mIZ5hWXDxz7ysp0+75sPURDIEn+J8WmibME7x2oAAz0k2f5sbjp22PyVkHO5htbmrWjAVx4be/PsHm932XaoDshp80cdGGdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yahoo-corp.jp; dmarc=pass action=none
 header.from=yahoo-corp.jp; dkim=pass header.d=yahoo-corp.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo-corp.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP5oSMI0JPFWI2fQFR3p6K5T5de+7PuY7Vuc+yFl3as=;
 b=gWcbvZ/CNSS6dR7VZ9+ENWm2mcQFHc7nGUcgr9BABQgKfiI87TM92C+pv3tIzMgSTfM886ILjZbF7pjo7Y8BzhSnm1H7vPXbYRoT4p4eR3p8Kxio3w1NjfCp75ZBbrPKkc8DZeUYbAnkfCJr6BJi5ol6la8n/LoIpe6QZXbaF6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yahoo-corp.jp;
Received: from OSAPR01MB7168.jpnprd01.prod.outlook.com (2603:1096:604:146::9)
 by TYYPR01MB7710.jpnprd01.prod.outlook.com (2603:1096:400:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 05:28:47 +0000
Received: from OSAPR01MB7168.jpnprd01.prod.outlook.com
 ([fe80::4de:4762:7ba:eb1c]) by OSAPR01MB7168.jpnprd01.prod.outlook.com
 ([fe80::4de:4762:7ba:eb1c%6]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 05:28:47 +0000
From: skakishi <skakishi@yahoo-corp.jp>
To: netdev@vger.kernel.org
Cc: skakishi <skakishi@yahoo-corp.jp>
Subject: [PATCH net-next] Improving `ip link show` output in iproute2 for PF/VF association
Date: Wed, 20 Sep 2023 14:28:27 +0900
Message-Id: <20230920052826.22211-1-skakishi@yahoo-corp.jp>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:404:15::13) To OSAPR01MB7168.jpnprd01.prod.outlook.com
 (2603:1096:604:146::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB7168:EE_|TYYPR01MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: b60cda29-4929-4351-a632-08dbb99a76e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R7owToRRpohOBSzmNCFbA+Y4bUW7wEyd2ODa4thmV3NDP1Ja8LJsHzBZJi5nyArJtYVAPiCwUUb2CYa8BC66Y107V7mO1T68A3oe3yreP4WEfAjyjrO7pyvCX0ZijSf8HU7rE3ucoHCO8LDpSW5XrA88+foZjtoZ0ofMlB3C2XypT/SIQL2Dn2BPaLbm44n3E5aQVPjjhgrWRavrIqawxonTpKXqSYnTgtqhSk+HuX9r4hrUKBcnqXV15AV8yZC9TnGqkGLSGkDeLPPX6EWp45uWGB85jxsem7pHoGD8nZ+qcpBmwPIcMk9WmbOITmUT2HmcPbd7f3L3KDtdtfAVeaffyQfCQTlruw+vB0OJHmUqbm+fUhDsLGOWFpWHniPKybTo3Pg+Y/19sJGC7ToLzJLAi9qeSklmsIUjVUMEya5tHV0domp8H1Cy6c9bBLRkA8Fjw65EZYqqVtE8dmSgQfAFj7dNDFpH6r/nEgfij8dqLI3UH4gjzGzZsPWIrhPv5NWOM78SoRbJsR0aNpCtYUmgcF//ImUULMtNe17jsh/hpioDyxe1fZ18zSSLAjaHcvhpcQ2Lj/A+CnkBXOtcSn/O7NWvBBSUUBGEBTD7ajSkAuJZKLZCoSoTzqcXPiBlyrY/h8UFHot8yhbl+sS7Qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7168.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199024)(186009)(1800799009)(6512007)(6666004)(52116002)(36756003)(86362001)(38350700002)(38100700002)(82960400001)(2616005)(1076003)(2906002)(107886003)(6486002)(6506007)(26005)(478600001)(4326008)(83380400001)(5660300002)(6916009)(316002)(41300700001)(66476007)(8676002)(66946007)(8936002)(66556008)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1nNAQ9h9kVFAnE+vHAOJziJEAOI8WR9e7Z9cv/cDARWkAfPxFEZ+aY0ZbTQ?=
 =?us-ascii?Q?A2cUHJtoK9AcuK0jFiFLW2H5vvL5vSdSzw/QuDgkF9GjoCFyQaAs2KDDEfpe?=
 =?us-ascii?Q?mItNalS8LxipOLZzcs699p8GHZD7l7jqYL+g0mhBeAohsvecOpakYYgLVfV3?=
 =?us-ascii?Q?IIQawo8tQ6dzFDqAMm39i1aUNso6mew2Vd/H/DWnGU3E/j9JSdKKxU96S4z2?=
 =?us-ascii?Q?OxuYiHVpgYxr6EuNB5rRe63Ae8XYeG87VVDPOVtXosrLGFy1oOAyODqxxJXz?=
 =?us-ascii?Q?IRgQMdXn6HkRJTdkSNbvrciTsgPoWt8dL2P/MgF8ITzrZzC0IXCTjj1kqU8U?=
 =?us-ascii?Q?imKQ2RuwOB9qq4Bb5PdObEPN4ys6RK7tKj5LAwElcvtMMdNqsMBvVj6oDV8l?=
 =?us-ascii?Q?y86oIy7fdykrw5gCXm2x9abXf8bbZfpJ3wsjDm+2+c+iMkKRhNvHeDqPTs18?=
 =?us-ascii?Q?/EoYGcuVDPE5oRU/KeIuoQu1zL19yS+H9nn/Wb3LVZNww16JmLy48jhW+Xej?=
 =?us-ascii?Q?4g407NutWBDDvlNTwBn0sH3/uj5PGT8rI+o/ARyreWYOUB9CSuNj3wcmwHPK?=
 =?us-ascii?Q?c3oWYdYZsPFwIvhOU4ei5T7SEzt41tn8aa0NPTcno2rVy0NLGaVCp4nS92gY?=
 =?us-ascii?Q?Gd2l1F0ELFKMdPTCubKj+rZA6OR4Vw3UyIUKnUaaSmQ75vWyGiSiTgC/SrU1?=
 =?us-ascii?Q?GbND6FvynKD1mt8/QYobTxNIpflexNxtQezk/Zw31gLWzD+DkCs50YADrEv5?=
 =?us-ascii?Q?GRxSF86cybo3NDpnheZpiiI7PxilfkN/leHkBHtcPn1w0w/ADK872hCF9GOi?=
 =?us-ascii?Q?vl6Ey+Tuz6ocwimrKyYEyI48SYnRxcs4ULVMAWN4hR4tgRmOk6RzUxxYGyz6?=
 =?us-ascii?Q?OpKsyQaSHer3DVtBop7LHS7uz76NJXwyj4zN96sC6Fi/utCZcxLUfmVlhX/5?=
 =?us-ascii?Q?GuhXm4UZSSIv9jHXPhXKeSRY3ptt8lA78d6xpLiKqAhjPEJkZvrkdHabSf1B?=
 =?us-ascii?Q?YqLcMnF4EfhJ6DOx6nu1w3okZWRP6QuRy7lQ5rfIWtqJIIQyU6ljgaEGjtt2?=
 =?us-ascii?Q?O5VuILjr30gCGjhdKnPK/Dv7wG+KtSoamFtHfXMFuSP/gOwHK+qkKtF/+qvk?=
 =?us-ascii?Q?UwSH3g3ILfCXt22oqjiWT5UnXKTiK7ooXf9bJsVCea3HvUfVonZ/DiE63ao0?=
 =?us-ascii?Q?TG+KpauWMY+BLIIX+Yw8xuDtrlHo+8e7meuGUTTKkjr6bWJ7wrvUOSQ3+iHn?=
 =?us-ascii?Q?Bu6vnOZyuMAW6BU8ALVDjkf/3reN6cGrhgEfCUmIEN6NKs788DQZVj35ytRg?=
 =?us-ascii?Q?T+RiYc/FGi/QjKYxnMKwCOGOHz1OclvJNCqYXlQ58eiLYBnYk25Ym8fzDza+?=
 =?us-ascii?Q?J6PVORsrnIwu6qTOZRwDu6oQ33uRET88Ey61+2IglQa7k9BCZseAM42kJFIM?=
 =?us-ascii?Q?zT7RO9IMkbvhSjXfhXIOm29//r09sD5UMmgRk6hSPUwNESdU+8RnooqU40hY?=
 =?us-ascii?Q?0g5qy6tBP5OoqyWXdptKiwivqvN0yWHeEEzsH3Dw7eyjT6w1xm2UyuNuqqzq?=
 =?us-ascii?Q?CTEEwWLMBC7GbIGokij2YFNFnHRT4/U/dQ57OGKk?=
X-OriginatorOrg: yahoo-corp.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b60cda29-4929-4351-a632-08dbb99a76e4
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7168.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:28:47.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a208d369-cd4e-4f87-b119-98eaf31df2c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKKc4yfgkMz8zE066O0lCvsYnNVcrC3qPu2lng2VEuTKZ5yzLDHh7/SlD6/zPULwWau/PoAexuFvpLckHhmn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello all,

The current version of iproute2 does not display clear associations between
Physical Functions (PFs) and Virtual Functions (VFs). To address this limitation,
I've added the following enhancement.

Proposed Changes
When the 'detail' option is enabled, the command will display additional details,
including VF IDs and their respective names.

For non-SR-IOV legacy mode:
$ ip link show -d
...
1: enp6s0f0np0: ...
vf 0 link/ether ... name enp6s0f1v0
vf 1 link/ether ... name enp6s0f1v1
...

For SR-IOV switchdev mode (including VF representor information):
$ ip link show -d
...
1: enp6s0f0np0: ...
vf 0 link/ether ... name enp6s0f0v0, representor enp6s0f0npf0vf0
vf 1 link/ether ... name enp6s0f0v1, representor enp6s0f0npf0vf1
...

Technical Details
I've taken the additional data from sysfs.

Current Work Status
I am actively working on implementing this extension.

Request for Feedback
Do you find this feature useful?
Do you think getting data from sysfs is an appropriate approach? Are there any
alternative methods you would recommend?

Best regards,
---
 ip/ipaddress.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 8197709d..d48fc04e 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -19,6 +19,7 @@
 #include <arpa/inet.h>
 #include <string.h>
 #include <fnmatch.h>
+#include <dirent.h>
 
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
@@ -347,7 +348,76 @@ static void print_af_spec(FILE *fp, struct rtattr *af_spec_attr)
 
 static void print_vf_stats64(FILE *fp, struct rtattr *vfstats);
 
-static void print_vfinfo(FILE *fp, struct ifinfomsg *ifi, struct rtattr *vfinfo)
+static const char *SYS_CLASS_NET_PATH = "/sys/class/net";
+
+static void print_vf_names(const char *pfname, int vf_index)
+{
+	char vf_list_path[256];
+
+	snprintf(vf_list_path, sizeof(vf_list_path),
+		 "%s/%s/device/virtfn%d/net", SYS_CLASS_NET_PATH, pfname,
+		 vf_index);
+	DIR *vf_dir = opendir(vf_list_path);
+	if (vf_dir) {
+		struct dirent *vf_entry;
+		while ((vf_entry = readdir(vf_dir))) {
+			if (vf_entry->d_name[0] == '.')
+				continue;
+			print_string(PRINT_ANY, "name", ", name %s",
+				     vf_entry->d_name);
+			break;
+		}
+		closedir(vf_dir);
+	}
+}
+
+static void print_vf_representor(const char *pfname, int vf_index)
+{
+	char pf_device_path[512], vf_device_path[512];
+	char pf_link_target[256] = { 0 }, vf_link_target[256] = { 0 };
+	int found_count = 0;
+
+	snprintf(pf_device_path, sizeof(pf_device_path), "%s/%s/device",
+		 SYS_CLASS_NET_PATH, pfname);
+
+	if (readlink(pf_device_path, pf_link_target,
+		     sizeof(pf_link_target) - 1) == -1) {
+		perror("Could not read PF device symbolic link");
+		return;
+	}
+
+	DIR *net_dir = opendir(SYS_CLASS_NET_PATH);
+	if (!net_dir) {
+		perror("Could not open net directory");
+		return;
+	}
+
+	struct dirent *net_entry;
+	while ((net_entry = readdir(net_dir))) {
+		if (net_entry->d_name[0] == '.' ||
+		    strcmp(net_entry->d_name, pfname) == 0)
+			continue;
+
+		snprintf(vf_device_path, sizeof(vf_device_path), "%s/%s/device",
+			 SYS_CLASS_NET_PATH, net_entry->d_name);
+		if (readlink(vf_device_path, vf_link_target,
+			     sizeof(vf_link_target) - 1) == -1)
+			continue;
+
+		if (strcmp(pf_link_target, vf_link_target) != 0)
+			continue;
+
+		found_count++;
+		if (found_count == vf_index + 1) {
+			print_string(PRINT_ANY, "representor",
+				     ", representor %s", net_entry->d_name);
+			break;
+		}
+	}
+	closedir(net_dir);
+}
+
+static void print_vfinfo(FILE *fp, const char *pfname, struct ifinfomsg *ifi, struct rtattr *vfinfo, bool show_details)
 {
 	struct ifla_vf_mac *vf_mac;
 	struct ifla_vf_broadcast *vf_broadcast;
@@ -541,6 +611,11 @@ static void print_vfinfo(FILE *fp, struct ifinfomsg *ifi, struct rtattr *vfinfo)
 				   rss_query->setting);
 	}
 
+	if (show_details) {
+		print_vf_names(pfname, vf_mac->vf);
+		print_vf_representor(pfname, vf_mac->vf);
+	}
+
 	if (vf[IFLA_VF_STATS] && show_stats)
 		print_vf_stats64(fp, vf[IFLA_VF_STATS]);
 }
@@ -1343,7 +1418,7 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 		open_json_array(PRINT_JSON, "vfinfo_list");
 		for (i = RTA_DATA(vflist); RTA_OK(i, rem); i = RTA_NEXT(i, rem)) {
 			open_json_object(NULL);
-			print_vfinfo(fp, ifi, i);
+			print_vfinfo(fp, name, ifi, i, show_details);
 			close_json_object();
 			count++;
 		}
-- 
2.39.2 (Apple Git-143)


