Return-Path: <netdev+bounces-269525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEKdFj8gvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:11:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F32CE7C6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75074321F508
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D7F3EC2E4;
	Thu, 19 Mar 2026 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAxPb4dZ"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CA3EBF05;
	Thu, 19 Mar 2026 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936271; cv=fail; b=Sbo7T9nTBx8b9ZzK65ZOI47vVCVf5m5Z1653A4Gv+zwJu+jFutv77SuBpNVi2IIMxNYbLpqFmHiJpWpBaJA0qa27LCTqc9igynep3N0K/H6xtYgqw5xNrNrzSCJCtwOvuaZates5simZUORgSLNLCNeX9JHZgGuHMcqUmXpM80s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936271; c=relaxed/simple;
	bh=h54S/SxNqe4Z0XBSw6KgV2Ijqr3EWg6fF9gZ+LgYQLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xy0P/CW+eX9RDnF38isATIAbhaKYcPKHTYbGNbf+ZUoXYFY+6Je8Q/eq/w5NzQTTDcrJxnklACC3Xa1naGvVdot3h0a1Ij+G7nX3mp2vS0x7OrePQzbzIWeW8zPBRv3EsKKax6Z1ruxAEZl23dIpgLdBCvAjUkTuHu3+2KPgWsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CAxPb4dZ; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFTEghnamBXEstMAVpfTgRSW4bwbCInmShhk5eO7Kn/zZGp5EnNEH2doqzIQoIFkXcjCeE3NtCzvWliBMyFSqNv5uGq6yCHJClZtlnNmmeVvPNUYkv2yHKbW49YdLU4Jj0bZfihAq4bDJc3bwPn8vn0zx3/OhC7M49UBxj1IwrsMg+gPCj+xvgTLH7IwUpXl0Ga7kUHrN7KoJbYzf+QuH50LdXQ0Qe5CBASw9qsJjzI8dsoXBFeCwQ42wWLH9I5CaoEVmBJ9DWt79E/icu/N4h8eJ3PeqKY/DLDRpdoF/EZmKQOh/xIeR0zkAqzoVz24PMiwy6XdUyy0mqoXALDUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGr/+DIq4niOGiufQ3CGYBqIGYvR4fE5Hg+0+YEu5vI=;
 b=HvUqLFBT2N9gBF/9ZL9Vb4+3D9hX+JX5f/2zAB2zgWbQ06GsSX2VPOfpewm8y5q6HX7qW4nPBAhDpDrwKu5COLCiSK+WhjXq48F9nZPqTm2/YvCZ2Zaq3vPyqeeYugRmo8cwlVPTtrS+pSPUE0a5iOw2/kgRsS2pbZk3JMQ9ZB0JXlz38w2CKO2ZZc9HEsdCzTqlWjSF0NeCwWPzguJSvZIq/ZW8S04nYoPzfxi6LoR4VbIbZhGy72l/qgCob4W+FU+0tdTuOIhdBNPQWg8VxLaCDc/ImMBhHzwUMAQEp8ilY0Zoox4Y0b97AUJIRTxJcRpGkbdxMLVPk2htIo3UzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGr/+DIq4niOGiufQ3CGYBqIGYvR4fE5Hg+0+YEu5vI=;
 b=CAxPb4dZtGrkkPNGSgnJvVu3HNZqcCa+EmENSKgtoz9vEG+c14lOYBDDnHho5LCDw+lSWwBdI5uFtDGeVgQ/KweuFMpVPu6kVo1x9jloRzOkArlwvYJA3cIVQeBoumUn44j6R6mUB9+eIUxA/3R7S1Y0izrkMCImhA+srWtEZnH8lR9Mkj/UsWM7z9/1l3wLiax/94Abmjx9TashAytQoHlw82TOw3SW/m64GpEswmHjpJ27dCJTMzI0kGFOL0U35V3LE7tnvnJj6poCJWr5GONapr6EVyzwq6mMhxRWO0eb5QALIgzcv+j92bNutjjAGdQVsDlSaeeXJ6BuxKnJ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:16 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:26 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com
Subject: [PATCH net-next v3 4/9] selftests: net: update some helpers to use run_on
Date: Thu, 19 Mar 2026 18:04:05 +0200
Message-Id: <20260319160410.2515105-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7628d3-3960-498b-3b4a-08de85d131f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AJTuptRXHYXD/0uzYD46qvwADdcqjTZk45/5Q5AJIaO5zQDJql0Szon1ZYhrmv+T5n3LBGxQVJhhovmdMomvAlbXKr0om6np1X8BxfP/dsjp/WXFTjYtt0JPPMZyPGVaWeeUB7cOjVBtkiMKLurz42Inm8USF0WTeHFzu9RKUImZrC+YI3E27fEtvlqNjVhnjx8Ehkj+RtSaHrH9+cceZ+yLwZft5CjLjlMWre0GygeD5LFqis8EJ9+BB3NpQHi8tf7gYpCzKKNusgQOK/MXqy5msD5UKjrx6rF3JF6Nx4pB+jtuptbatHVAiGmYnISk8vEdBJkauVbSQuhQTwwXgBn8MD4WgtUxmLO8jRcdSB5qHSG8c5mJVyHaxiGboEWe8bHTjmxxnwbyeK9Rr0z7LPL8fKaZmZNOWLEFYVwz/FHdxECdB4C937EdyS0GN2Ir1i6Jt0F451eqUr4svFROTg7FDaGF2CW4yiP+NEWrV+M/O78mKYCT8x5Zs97SKaKHzpp8aKnG88+nJs/BySei5r+eEqH4ARzeGRFmJNa0tk6y6IJMVkkbFWCoGsmqVrpxqLMOmcgw8XCCKhqLotceFmj/bbVSKgEQ50UM73fYxvtJjyNpAW8YmBWiOnd9Q66Wt5L423IX4/+SwEV0wvnYKpodT9Vqx/VRl3FG9mShr3RnVKecXeUpZ2f2yAd4IL0J2YAUPAI7QTCZBewa9kbKgBJp5yKIXD3+wiBiF2FB1e0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zVe9mAya9J3g+9nvh5qKx9/Af9cYs8TIEpBbLRuTCrFPi7eUtpyfSQKdaLqd?=
 =?us-ascii?Q?klm54imxeEaDKDt54DCxVuk9qZyp/jk9YqJ+OOjbl1dBjEMJKuhVvzoGSBpp?=
 =?us-ascii?Q?1v5g/C2kKufvMeS3LnzAE6i2DoylVAs6iC3NmOyxcC4h+GbDMuzpejvAraQb?=
 =?us-ascii?Q?zfM/jOlVfsmj36ZBas3kmTLcpSTgEWkVZv4hGS5dH6ETxzDrq1FXnPvMOcro?=
 =?us-ascii?Q?/tVBux5NUhrdUkldMnRezGoFhKzd9HrlGiQvu6r/tT3KITk2HFNJSYqIQw2d?=
 =?us-ascii?Q?Hg2YysHMYgHUCN3LQp/KZZ/GWgJI2Us2VDQbEsQATX5VlyvdtfkYv79lESQd?=
 =?us-ascii?Q?gyEx+ZvucJa3ubjhWZlAprkzPCJ5VOKrdoZopAujF5r9Gcof40kSMkC9JiZM?=
 =?us-ascii?Q?jsSxGqCdrm6C1jQ2drtQsXrhxvXGxnlbNLrzPN7nLxOfpMtrPw2teSpQuf9h?=
 =?us-ascii?Q?6JFAy34AoRWsunFn5nmivzts7/tduJaOjga5SH/XWmyM1Q5/oQvqNqh8u76S?=
 =?us-ascii?Q?EqFz3rZeJZtgsVbSlN/ZxVHGsx3fjzZDgjNg9k8LAHBQRLzSAGAQwU84TRDn?=
 =?us-ascii?Q?S0aq5dgpINbPrGG5p6ZY1KkNmguU+ZGdqJVWb/C1fjuHpAomoruASlRB/APX?=
 =?us-ascii?Q?YIEulgSjJ/xJY/aHUttpMEGPDiNlfG1pd/LPJc/GLjLYa/yLkEydPEjDMzkr?=
 =?us-ascii?Q?gBdc6R0HH6QqAL4z9u0Ut+6To4hxDVyMpkGmT/++ARGtqf3UAAdBE7yXqvyX?=
 =?us-ascii?Q?MWP+8QUDiy/+15B1Pbo21GbHFbTKxbqcNp8pITjUwNQcO4sWGGdK1bQ2Zrpe?=
 =?us-ascii?Q?COcdft2bYKpCfL0HqCDFSDNHD/7hAe4ts61aEzRcX90/cu20G/bCYtetqJjl?=
 =?us-ascii?Q?8CCsasWYPVpBfKREWNDwcI070G9DNCKPn2N3tJ4Bq8NyXxtH82L6Wi9LHyFc?=
 =?us-ascii?Q?kl9ULNexUY4ORe5VB1HZZmeKFqjBOj04/zDfejdng0p+Ps4LKA1HmfDvah/I?=
 =?us-ascii?Q?HFouRhkgGHjvNb4HGJOibExQg2hrrtA41X32pldqqELvsDEnCeiAINCDSqhL?=
 =?us-ascii?Q?9cpolFCNSmgA8Cn4JlH3gcBLf6gFAVf8OsiYNmzb2hmhc69NaDyV9yemz5Wn?=
 =?us-ascii?Q?ZI6ZelGpSE1P5jHyva7dNKJ6l7prtwi2OOu5GacG52hrlxfRry/26gGQws46?=
 =?us-ascii?Q?BB0+kjcfXduAMKalBZVuH8O4TBpvOEO5A41mZdgepqOOwVD/Ubge4wvuDrRX?=
 =?us-ascii?Q?vuWi8KUht5JJq2fDU6Q2xttUy72Q2sllUFmt+Y/ZagzITOrxknehlUSGVCQn?=
 =?us-ascii?Q?7knNu4VaOqJfJjv89bysP7JDcNFPPyXurRY/M9BDk/VDOIUO4ZJDs94wgcgq?=
 =?us-ascii?Q?3GBOPJmIGw1zHw4ee+zQIVMe+I7aVrRgm3VVxw8cqaJ8dMj7iKl14dfsy0JI?=
 =?us-ascii?Q?4my1hjcYSULYYPJYmrixCvnODLYqM35aRuPaF166ohaeoLf9x63ZkWCcCx6v?=
 =?us-ascii?Q?tIog59+NOeWg3su53Ha80Gm7AidE6g3sH/Zbt9J8BOb2wu/pssLRw4MMiV4t?=
 =?us-ascii?Q?6RWZlkhKsNBgLmsD2IuGgs6hAgK586Tq+sZ25YPwWaXLvAz3ldoCeRapngRk?=
 =?us-ascii?Q?uFtLjtDXE0q7mHY6+L9BpRL4aHc+sNlte4jq+Ip0nfI0AUjUdqzPFGNae78l?=
 =?us-ascii?Q?mI/syItmLTgl8vYp1+qm23jFzx+ltY4ArCJNW7AmTOu1c/+06C9Gt2yLoaNq?=
 =?us-ascii?Q?cOiROb/akQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7628d3-3960-498b-3b4a-08de85d131f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:26.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74Bwo46xo3esdrP6BYGLhNkmhKiAUO2EPb/wwN4bkQBq+iLLMacxNNu2ICgDn8bsLDuivJ8Sytzjyy7ZX7OKAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269525-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.953];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: B24F32CE7C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update some helpers so that they are capable to run commands on
different targets than the local one. This patch makes the necesasy
modification for those helpers / sections of code which are needed for
the ethtool_rmon.sh test that will be converted in the next patches.

For example, mac_addr_prepare() and mac_addr_restore() used when
STABLE_MAC_ADDRS=yes need to ensure stable MAC addresses on interfaces
located even in other namespaces. In order to do that, append the 'ip
link' commands with a 'run_on $dev' tag.

The same run_on is necessary also when verifying if all the interfaces
listed in NETIFS are indeed available.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- added some more double quotes
Changes in v2:
- patch is new

 tools/testing/selftests/net/forwarding/lib.sh | 17 ++++++++++-------
 tools/testing/selftests/net/lib.sh            |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index fb5aa56343e1..f76de37d0caf 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -530,10 +530,10 @@ mac_addr_prepare()
 		dev=${NETIFS[p$i]}
 		new_addr=$(printf "00:01:02:03:04:%02x" $i)
 
-		MAC_ADDR_ORIG["$dev"]=$(ip -j link show dev $dev | jq -e '.[].address')
+		MAC_ADDR_ORIG["$dev"]=$(run_on "$dev" ip -j link show dev "$dev" | jq -e '.[].address')
 		# Strip quotes
 		MAC_ADDR_ORIG["$dev"]=${MAC_ADDR_ORIG["$dev"]//\"/}
-		ip link set dev $dev address $new_addr
+		run_on "$dev" ip link set dev "$dev" address $new_addr
 	done
 }
 
@@ -543,7 +543,7 @@ mac_addr_restore()
 
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		dev=${NETIFS[p$i]}
-		ip link set dev $dev address ${MAC_ADDR_ORIG["$dev"]}
+		run_on "$dev" ip link set dev "$dev" address ${MAC_ADDR_ORIG["$dev"]}
 	done
 }
 
@@ -556,7 +556,9 @@ if [[ "$STABLE_MAC_ADDRS" = "yes" ]]; then
 fi
 
 for ((i = 1; i <= NUM_NETIFS; ++i)); do
-	ip link show dev ${NETIFS[p$i]} &> /dev/null
+	int="${NETIFS[p$i]}"
+
+	run_on "$int" ip link show dev "$int" &> /dev/null
 	if [[ $? -ne 0 ]]; then
 		echo "SKIP: could not find all required interfaces"
 		exit $ksft_skip
@@ -639,7 +641,7 @@ setup_wait_dev_with_timeout()
 	local i
 
 	for ((i = 1; i <= $max_iterations; ++i)); do
-		ip link show dev $dev up \
+		run_on "$dev" ip link show dev "$dev" up \
 			| grep 'state UP' &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			sleep 1
@@ -944,9 +946,10 @@ ethtool_std_stats_get()
 	local src=$1; shift
 
 	if [[ "$grp" == "pause" ]]; then
-		ethtool -I --json -a "$dev" | jq --arg name "$name" '.[].statistics[$name]'
+		run_on "$dev" ethtool -I --json -a "$dev" | \
+			jq --arg name "$name" '.[].statistics[$name]'
 	else
-		ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
+		run_on "$dev" ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
 			jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'
 	fi
 }
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index f7c54d05758e..14f262a593c9 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -518,7 +518,7 @@ mac_get()
 {
 	local if_name=$1
 
-	ip -j link show dev $if_name | jq -r '.[]["address"]'
+	run_on "$if_name" ip -j link show dev "$if_name" | jq -r '.[]["address"]'
 }
 
 kill_process()
-- 
2.25.1


