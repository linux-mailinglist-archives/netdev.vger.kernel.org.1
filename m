Return-Path: <netdev+bounces-273250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fa9NdOXymla+QUAu9opvQ
	(envelope-from <netdev+bounces-273250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128335DEC8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C51C5300CA31
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9763D365A14;
	Mon, 30 Mar 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OgfI3Sy4"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A733644D3;
	Mon, 30 Mar 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884646; cv=fail; b=VomyJkLG+IeCcR6ATYXcjUA+sJfhKzeORqCOsF834x23IXA+PZVyVx3G0mmD5OVY0dS11MTvXpHnF4b9qpVQc6ycCbLjtzyJi9DTCaSzFwOwtU/eHuDD/vCk9Nv+OwPpkHu2ujp7k+dwzG30oIxe+S1rhBart/ynueQtcX/HDoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884646; c=relaxed/simple;
	bh=0GoGHrQ2fKuGNupQK3SQDNqgN7RkwmmGDqwvu82bw8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YTBNJ4o0GcAJnOW2Z/PGq+AJPLLG6H69r7EujVtV/J4b/4eBr/hl94G+TW1DGlGVUIDyZc4b4c+hS+seXHnV+preIs6eKkynSCYSGqp4DYDpQfMZamFpAT3QxWErJ35hFhY1NrANq54p+z8Mp7ZVo5SguiRLQUxO/KwEVVpM9MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OgfI3Sy4; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNnmBd80voag+Q/haaGAGS4R/1OmYLjLmnEwZMXcY2/oi+1kpIkmjXD/eEqo6/zIQzsUK0bpB/5LL1mT4aPRhDMf8gLsFGwFQEIjnbO4qUlJYO2C0gF4Inhmxq7sbjofu5uFcrIopwqGXwJ2UV0epfXGqaVGwIa+P7tRFvWEb8MBk3UDTSnM58oeCOmXvwP+SHMkF6XFyw7wFYyO6tDwps/ct5Le7a8fmUL1L7sNi7DusIm5ycT7t//Bz449xVMn71b66/B6LTZK4PNje7FkMg3egBNXazdC4fxsOMWMGl9vQYyY2xb2jjgpd1gQS+cXVFmIX5H/0RZ20NJWNB1nVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DDOyoPDu7wrm11eQwfPQNk5hzbb42X/z2/A8xSoOiQ=;
 b=FJUZLbykZfZ+dAy/Zkc/mcdL81PtZYgesoqZEMWsBx7PxLhueEBmn5YuagerYfH9ax+uen/awvYzdWdbxdnTTVj99yzYGGvTo0lWvGkQuH741VNJtV2L4wiRs8soYptZohpzZnPsatGRIrODF4bMniySQclf/nCfGQrFxeubogptClpa1CmlqlaQcGX0zYVBRqzpR7BkFUsRF478xH8fq856Jkm4WZfY4KZixiuzdLf4XtvBbuarWjahbTg1DwUZshh4qdoGsF42UPvLmv+WyyyPtSqvr2546w2OZWWUlF/WBM8F233fBSw0Lhol+p03Ut7ktuiWP4bv5PFoSLndGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DDOyoPDu7wrm11eQwfPQNk5hzbb42X/z2/A8xSoOiQ=;
 b=OgfI3Sy4pyWUSCneTerXZVhVGXcXyQoxPBZbA+l/mXv4PNSD22XqqNzW3ou20Ye7lvhZS8iJ6eg7f/1NnqXzV/+K8rCi+jmedvbSTxAzFK2WqzpzFB8A/zp3wQzoJdlZ0i22Fa/ewo5gCD5In4AOZD/NWmpMechfx5dl4AbCTDso3xve5nqm0EYDct5NDGYWJF/m/fBAv42WsSN77VqF2q0zKGT4xMu9rNldc0G8GJSDFKF2dNAJqHKLBVXkR3DJFYK5U/ga9Ln2WKBhXIod4WO0iKw7Ezq1cw+5+03aKxpmGDASrCcRSQNgE+dCpWOafvgBTDeRsd4CEv7Nb9UtOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:41 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:41 +0000
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
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v5 3/9] selftests: net: update some helpers to use run_on
Date: Mon, 30 Mar 2026 18:29:27 +0300
Message-Id: <20260330152933.2195885-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0160.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::27) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bc26ea-6f81-41b6-abb2-08de8e714d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YKepR0nmyXCVB/nY/1g9MU9Z2gEMExpY3FdajZCZquVHbdZ+5IIlwjvNnMtKbnnhnquai3avq15LcnQcAiXgbEmc4qaRyPUq6MkeY4U9f29+0Pqr9YpSwgISuc1t35PlXH5/z4aAn6mIg2X3/EkqU3rOGTFP+TaMMy1yEirhsMI8w9080t1S59WlgsDeMLKIl84Kubzjgsv0juOMtdarj1TsUBvYRE3Z3wsxU9mn4suLvJTsjjnZ62ZveNX2YQZhmTlsh2kccfCNxzeA+IzUDBm3cW7WwLnXgE0PVkZ8kv9jqECoE7kk4rdSiOq8FR9MZU99tDtA7qY/ytaNqXGqhM9aeZ4HLSt9Pl8gDLdUUsV9K+HhuQHlJUQLNTdRZMisLv/Clfe4VyIGWoxxWMtgMVHx1+y7H/LqhWJ9N4xvT4THPaYj5mKv+Y4Vn7GItNHkMV48acnJLe/Vzis8LRm2dQxmaVYIOuIvAwdTOLkSzAUHIwM9hB3YpFpgsqxxPZtgsl1yw1lxVzNh7DgN00CA8Ce0bUVisfHZt8l/A5KgO8kLJIhChOXm7iOPpvSule08W4gO7GXctO9VZrbfh0+dyiKEgwTab3lTb3l6G/0N5sESfYX0u2iqaxzUDBYj/TCCvjh/mYSfMJJCyqlD09Ujvz2KGqxluO0N4hlajFXVAusMWzzaTXVZzC9daJ63hNp1/cpuPl1zcoDBAmfcy0gEVsO1nqUmGbjxC1S1NPwlILw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2K27dqdtes/jYrkDlt6CieRum8iLjECci59UQdiqNj0kmgv2TZ/BGEB1Ns8?=
 =?us-ascii?Q?J+savKg/zV1nIIudk7ayJ4HT/L4HfY5v+/xtTgY0FIXAfcq5VfC5YHQs57TS?=
 =?us-ascii?Q?/mHoI+1XwfvvLaaDuXN4g6C680G4N+D/PPvqYr+waMypMl86BDt3rXFDH3Wm?=
 =?us-ascii?Q?m1Ypv9uq04UmtpJsT3wfaHD8cCpOhx+UqL60fLr32atayFHRD9nZSj0UYf4v?=
 =?us-ascii?Q?ArQ5uj9z01Zs8wu0mrQq3sGw61yKrQpnLeWVK+EQ+peS2+1rzYSkX0haUG00?=
 =?us-ascii?Q?GvtBhBcHAiYs2deAPmM0RemCoNAiCSFoqer0cCtSRW8G6qgu/iyaxNjDMznU?=
 =?us-ascii?Q?zo1uqyNfabGAbg4/Q/Sh2KU3AvdAy2f5WjvJ31m0HcVf1qpsseU7SOIoyt4n?=
 =?us-ascii?Q?cVCR3EUYF8qTc9dPB9F1D14u2knxZYnyHu3ezRi1KSXtm6voAS2xyLzcLcni?=
 =?us-ascii?Q?nIeBfT9KTFHERAU1kii0mN6WMLTht/8g2ryUHd7sPCEWEScJTd8swWCM+3a3?=
 =?us-ascii?Q?QEr6RqQguwm8rf90WVDxmsxPYad7txESsi/GhDjatCQUIV7gLzJmR4TVnHj7?=
 =?us-ascii?Q?VjLXZrBhbkv7N1hQyqfnFE/vzKb7e9Rb9F+vjttHphNjHhRDKyu3Xst89y15?=
 =?us-ascii?Q?YLy37UJAHibQcA555Nl+FCy1QbS9X+X8dSiy1T2cYOYIIWUJIo5+8O4DgwgO?=
 =?us-ascii?Q?LZxTyFiNO0x31nmR4AkOqIh6A+ra6ShHTmvbrNVv+BOP/dFfdqZ/fNG+Ugn3?=
 =?us-ascii?Q?0LlUjZarPzZpLuBwxHEsBBCfpu0+zYUeOE32XPfK+Zgld7jHHTaqLAc58vwB?=
 =?us-ascii?Q?1UtLMxFvPuf7SU7AHB3dp2Bq8sn/yC7xibQn/UHNZBbmlUWUOqy+WwPqy0c7?=
 =?us-ascii?Q?wBzucplZOwyEG1oiZ+4q3UVLPOz0FH8ShhL3aYEwjZHP6V2ajUzLsr+niLnM?=
 =?us-ascii?Q?yJeJMBkZFZQouqiPmWk132Yqb0HIwpMQPHyz1A2zCKhYIPrM+GNYmzw580gk?=
 =?us-ascii?Q?z/HP0QbFTFH0FaG0TfbvI7fCGHUvleWiXT66ub+ByD7YCqUrQ83mAq2VrdBi?=
 =?us-ascii?Q?NAbHBPZ7sdHxlwq23FBmWo+qlaRWSpQXqzqlqrOxdwsqBXA41heVdI9Daf7o?=
 =?us-ascii?Q?QrYGL7I6Ieo5MU8P7WjpCZqlxsYMkGZYBCEQi0LvunVKzZExa88YzVv7+Q6x?=
 =?us-ascii?Q?YZxaTNYfVAxFkdDUCoAfGAnS7yoXdWJ/0V4JMZ5y273OWhMfqkAC6SJe9CSC?=
 =?us-ascii?Q?OSggQRubzc5GduP0/vcWBscfbs09v7Zszr/Pf1KE0R+1uSbgtzVHX1soGg9K?=
 =?us-ascii?Q?s0WQUzpsIohVFgOiqwIxuzaGdyLixE/621jJlGGxQmtN4s7zCRc9vvVPUZh1?=
 =?us-ascii?Q?X/I82DWXWfaTUJ+W00ME28w7M2+oX4dtvbRr74qHF+9pclYt1oTdWD0iIK5j?=
 =?us-ascii?Q?1au0+mMVDBSpPfSsL+0qtqVnSAjxoK9mtT1briKG0pS1dtE9khd4rTSXlBkP?=
 =?us-ascii?Q?BSQ7GzURXvwnuM0sCTrcMZWfFtZtYiKDspcaD8UDVv/qXm4C509psYRHCRcl?=
 =?us-ascii?Q?fMfx3s1AmQPjk4iy4dEj/NOpph0NXl1RCRoDvxjunFL4sjqmeBl7auLlV3BK?=
 =?us-ascii?Q?w5NO0/Rkc0ikgQv0BlS5zqt95l69ulhzf6lY5ZdVNiZ2Wi4uzZpbF5WW6yD9?=
 =?us-ascii?Q?nExunU5dsSzaTF3MnKAUtlH5nq2O2ZQEQHSiweKwvrKjgthAV49fsMi9NBcg?=
 =?us-ascii?Q?3Mgi6ZJrUQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bc26ea-6f81-41b6-abb2-08de8e714d37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:41.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0L+bvnLg4iORJMR3WJ717Ivev0zqH1CGvoTK/w4mMMKyToDp+6vCQKzN9AQJhZZ6PU59QzBs/ZM46yRhQaV3DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273250-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,nvidia.com:email,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: 9128335DEC8
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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- split some lines to 80 chars
Changes in v3:
- added some more double quotes
Changes in v2:
- patch is new

 tools/testing/selftests/net/forwarding/lib.sh | 19 ++++++++++++-------
 tools/testing/selftests/net/lib.sh            |  3 ++-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 83249aafa669..d8cc4c64148d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -546,10 +546,11 @@ mac_addr_prepare()
 		dev=${NETIFS[p$i]}
 		new_addr=$(printf "00:01:02:03:04:%02x" $i)
 
-		MAC_ADDR_ORIG["$dev"]=$(ip -j link show dev $dev | jq -e '.[].address')
+		MAC_ADDR_ORIG["$dev"]=$(run_on "$dev" \
+			ip -j link show dev "$dev" | jq -e '.[].address')
 		# Strip quotes
 		MAC_ADDR_ORIG["$dev"]=${MAC_ADDR_ORIG["$dev"]//\"/}
-		ip link set dev $dev address $new_addr
+		run_on "$dev" ip link set dev "$dev" address $new_addr
 	done
 }
 
@@ -559,7 +560,8 @@ mac_addr_restore()
 
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		dev=${NETIFS[p$i]}
-		ip link set dev $dev address ${MAC_ADDR_ORIG["$dev"]}
+		run_on "$dev" \
+			ip link set dev "$dev" address ${MAC_ADDR_ORIG["$dev"]}
 	done
 }
 
@@ -572,7 +574,9 @@ if [[ "$STABLE_MAC_ADDRS" = "yes" ]]; then
 fi
 
 for ((i = 1; i <= NUM_NETIFS; ++i)); do
-	ip link show dev ${NETIFS[p$i]} &> /dev/null
+	int="${NETIFS[p$i]}"
+
+	run_on "$int" ip link show dev "$int" &> /dev/null
 	if [[ $? -ne 0 ]]; then
 		echo "SKIP: could not find all required interfaces"
 		exit $ksft_skip
@@ -655,7 +659,7 @@ setup_wait_dev_with_timeout()
 	local i
 
 	for ((i = 1; i <= $max_iterations; ++i)); do
-		ip link show dev $dev up \
+		run_on "$dev" ip link show dev "$dev" up \
 			| grep 'state UP' &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			sleep 1
@@ -960,12 +964,13 @@ ethtool_std_stats_get()
 	local src=$1; shift
 
 	if [[ "$grp" == "pause" ]]; then
-		ethtool -I --json -a "$dev" --src "$src" | \
+		run_on "$dev" ethtool -I --json -a "$dev" --src "$src" | \
 			jq --arg name "$name" '.[].statistics[$name]'
 		return
 	fi
 
-	ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
+	run_on "$dev" \
+		ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
 		jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 3f79bf1ec977..e915386daf1b 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -514,7 +514,8 @@ mac_get()
 {
 	local if_name=$1
 
-	ip -j link show dev $if_name | jq -r '.[]["address"]'
+	run_on "$if_name" \
+		ip -j link show dev "$if_name" | jq -r '.[]["address"]'
 }
 
 kill_process()
-- 
2.25.1


