Return-Path: <netdev+bounces-267087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIm2MDjMsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:22:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F7273406
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBA5531D5122
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D56364934;
	Thu, 12 Mar 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K3E4a4iZ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27F366565;
	Thu, 12 Mar 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325129; cv=fail; b=BWH8ta4dlCzyk7IHzx9WJKjgT8ekKpHheQGRrtEvdP4ziccmKmd3SiK+MgQfS+z3QlDDgV+8sWYRmoVipU2naRpdD/v6uTn27msEqiWmobwO4WofX/OdXaneP5W3lm8aBScZ0/9iwMzxgpnjtK7AysoIahfZr5Aux0vFXNEzS8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325129; c=relaxed/simple;
	bh=DegH5KNDc3VT2fyPxx67a0WWABjfaV8TPebC4GO8O80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FmK9IMy/hB+ZDSLLc435z+e0IGS5tUkn3QAEl6OMDuNc24Lyeo5f4GcXkOqG4cDzlYzMj9+GRl8xcogxrbSizTEfDp4RK/3RWdrRbrOQRnDvMfO0OM6VzUvW4RVvlR5esQBdGnkLznYIHa4GahaoKlQ3VrYcKQ+JTImkFIaTUkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K3E4a4iZ; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpzlUhxka0vlG2cQd/F7F1HHWQRmUqIHoQNDcdvEN+F81M2q6WXtxfFsSN8cVpYaD+/zKZIu2As+7OYxPudcPEsgUclRzdnqT4s9DszHMBWsln9puaW3W13XV6ByFTR2eN9a6khoeS69fNhVXYxy1iOicApxJT59qa6T5TNUGLBFUBjdw5AmhTXiUyWApluADTbJzqCFhJQUvt3vz4WXW0idGQGhdNO+wGD7Mv8b6Uwhvy7VO8pPBrZzXZo0oymdQ0KTp2jAonv+u7J6m4EHQ//fVxfoozyIwifeCMmKtJoNONrawBtLg9i8ZRQBKTjsV/Y0IG9hqi+kvsxDNT86EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfFVYQoVcB882LWF3Ha+MI2vlLbjeaDvFGdvVoKSt24=;
 b=G4ap712pIsrupn83o5XL4of9So3+5wDuzKydMp7qdtrczekuxcnSHNHwKYnw206k7dMdGe5Uq7pRLeuQuHUZqlGomtlH9Ue3n7PIy6EZn2UIEg1SM+1VI3H4kvuPxcH1QahAht9LURLgLwk6f3sHCYfUxM+rHAXZ9bqqq8Nc3V3LdATRdbtD9rouv+Dm/xscdkJ3TU8+7evA4VLPbpX2bhtaUXX46XKkHvZQIaYDzCyQfPiAjKP3R30r3HMMSpKTG1XzD5uT5y4VnVXqsDAAcq6+Jjferc6jO59xPn//uaD4t8rf/yAVCfTWjGahwxidnf8dalTxVRTNo3r60/c6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfFVYQoVcB882LWF3Ha+MI2vlLbjeaDvFGdvVoKSt24=;
 b=K3E4a4iZ6AjRYKAvpwjodhTxN6WOqhSb0SlFNKtJfjfIauyGT17lPUJ7Zp5SEPDjOFhZOL87LsJ6gcdl8P6o0GBV/o56+dMWVjSgOfKngho3HxvcmbJA/nrsjDx4gDCmi9eMSCw639VrH7s2DID9ZhzAaYIENpQHkdlSog65BWN0VGDXd0uSu+i+uTNYbRx6WCxiRZ2zLMO9TgLFl/+WO8XAmN7uzUqPWz0c1T7B1WphmnjNQSKfDxESg5wuHYGcwWOZPXngceyBinH0wRhrGQGDbo+LsITf3GSbIiOizmUfqXywU1EBecm5i0NxM/qPpRc8YKpxNFUa0cm8RaIhAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:33 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:35 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 4/9] selftests: net: update some helpers to use run_on
Date: Thu, 12 Mar 2026 16:17:35 +0200
Message-Id: <20260312141740.295353-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b852b9-6be4-4749-0f0f-08de80423f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QrtVZuG6A4i24Q5MRIeM4URoRCR33LEMw/9s/vcUfzMgitSDJSmrRHd6y3Dm5jZH+9ltlrEpyJmeHVcV/HUusHNVsXF0e+uaPtplCMhZaXpeGW84WDb+1Ik9YFQE37z4qFqbtvJlX0F+kKpy6Pe4MDGGvknVZwARASwnOiIx8c4Co+BxcqW/mfkGR+DEaxP4iZeSqDNuzqDMGlzgZEVA++Qa82ECjauO9ju19stlxiw2ub/RQHOZftRo/zl7cxcYv1rzIkHDIIQ1s8qvb9Tjqfv2MRpoI7mkP8Erh7yBb53KvCIL5r2zX1ycd3HOOC/WpjmdKXF3jkFAgJRfeVW5tJktJwqh305lnLgmuFBtVvL/+7M8yQde0nDbMARCaWt29+63e/x1HABdNg6wrbrq7s234XwzPezN/WC2+yK+qNKaU61yOXMNybOuUiK8e2g8LeidkTDzae1VbYyArjC+tjF3+Si+hZ+dPwNYDv6VC38ixqd0VQ8RDdrppB6flHt5oSxCpqV0l5/5G6mWSxMfRzqlnlOXLe1NAlZ+wvsphLWEeHYl4o0P+KsYg7srPFLKANF/PWzoFoTSnpgPokTD5BHRpTeNORO8szvklsHKYuqkugnTGlPZHqKN7RaoVh5Vd+6aJtk8Gkf+IU+LR7flgz5HTMQnG/FnPkTvLZsPPw0tDCgzKK9qAaDwgyrENHNP9FFwgct21WaMlLRk4mGXH3Y97/PHnDQdnJhG0okvrAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6WGaA9WAojAy4U4TTXwgiYSQQNf72gv90mrWhSLivMaJoUbnEsQOhuOStl2R?=
 =?us-ascii?Q?fuJ6R6Z+5GOxgIq0f459RIg5rHD+g9I9s7K6z4t4x1bCrirSawCwhSCtBN2D?=
 =?us-ascii?Q?CDWHZf0KNDaLA+uOqwWYy7NWM5EJhY2KLSMWXV07A9DLh1/qMeO/Z8h6N+aE?=
 =?us-ascii?Q?6bibsHdoPMiiu/gZSJYHSwldd7xPV0vMuKVRXRUTaY9hh/Sm/dhS5bZobAOZ?=
 =?us-ascii?Q?PfZpyRouFmAFzwAYQxfANIUx8HNG2QAOg4fRKznny3ktMWxTrDS8AJRHBosl?=
 =?us-ascii?Q?2LYWa+UTCvowqa5uyjcSqKvTEH18zXQ/mCFANPxMX+0J3hTMzTkXOZZ4bnY+?=
 =?us-ascii?Q?uGfMD1LbKBWIwki2OuzKgO4nQX3bYRsYVJASyJeCIPRxMckca3GmwrlFpGnw?=
 =?us-ascii?Q?wpYSmrL5EwB/tJ5kbdPgIMGrNKhW6Ck/fEOYlKK0P9Et9ClpOpaP7VrUI+Ls?=
 =?us-ascii?Q?wE6CpnsMT2eVTtfsUMEcMPHgpEQZyIigwne9/kpHgPhUsQbcF0kUub2sf7MY?=
 =?us-ascii?Q?tNbgTfnztuE2My8d+gIf0JRUhO2WtKznhMITw/VkPOh4Ck0nG8iR+ZJBDHau?=
 =?us-ascii?Q?HW0PEI1HXVahtoYkL28rxtEMKQI7RcZkQxM9SkFax+PrEC3udVoTDdL56PYD?=
 =?us-ascii?Q?+yJBaP6XGWCQ2HdNmvJNXzjsrH2zf93AEQfUM9cb8xBlrc7IMe5DRN1AG3pj?=
 =?us-ascii?Q?tBvMiVDHwz73mDPYqLIUpwxUuTn8Kh8HRsLReaYglOi0beDhFLtfgWWPi9ci?=
 =?us-ascii?Q?C3cIcqwlEhQShqRms0tZADOWUyHvNPq4xJCGIso+q20DPrSV3zz/e20GsDx6?=
 =?us-ascii?Q?OQFjJ3HnFeyRfec9QMB+ZGChjOfStU9XUTZuSz+1rUeJ7OjPyKAcaYJWC9TQ?=
 =?us-ascii?Q?CKFLeP60MlaXZsL/FeEtps/iSLzPTDRLE04pqJk+7veHfcm0b/Qa8Y6E7QsQ?=
 =?us-ascii?Q?ixts/Luz7EpkJGDHxg267nb+vAIz8/TKJcvTMBpRl8CaFmDRfaSIRpOQr0Hn?=
 =?us-ascii?Q?93b1ug7JHjLHdsb8Bl9uOoRunjSsM1VRhItU1W/WAgCJEcZ3L4rcDXofmKO+?=
 =?us-ascii?Q?cLu/ZI+vL84RZeXVcWFASNwTduMWE67ysOzNhjgzDrhs54p50ad3NF55djTS?=
 =?us-ascii?Q?CBxqaDPNhWQjssX1gUGVLI/D2FMx4sYEbTtiAIdw4z+Qqe3PluYbFDOqPVa2?=
 =?us-ascii?Q?qdjx+zkIfn1XR86N2ej2P8RH15W8VDDRtZB/pvAQIKahEko9MLJ+nYOTIBNC?=
 =?us-ascii?Q?/t8OMdLjvLEwqq2L85T/pUA4Tf1IL7t8nvgSDsGmvbXMLqwbCpbqTJD/Xo7w?=
 =?us-ascii?Q?y7MWstIPAiroDVeMWTI/KiKuj8u+u3aKE+DvVIGt2meB20in0c6Jzb9zuOBL?=
 =?us-ascii?Q?pYEUtmauWOjbLQYOa0khO302PMa8i4S3vWL94cNHgNuHRBCWfBNVllpCR48K?=
 =?us-ascii?Q?gZPVbpTSAuzhgy7iBlO45P8QK2/4kFoiCUZaxnestu5xYDds8KCxTN6YYmUD?=
 =?us-ascii?Q?343bz/30qOOv+1Pe2ed/9g9HRv4VwnNxPdIoP8R0PYJxGgic6KFFUy3S98lG?=
 =?us-ascii?Q?v1O1hb++oQSduUKW6tT2b725Ug8bWjMbECbnErBHlq2K7bo/z98WXRTo4U3q?=
 =?us-ascii?Q?9q9QyzWud8ra3cyO4uK5yIDENiPjrP1TwrWkD2CY79B5cyaIjhosMJi52upO?=
 =?us-ascii?Q?yz/K3hN6PX12zk6nCaHrB6PWZEia1WGpdNnUzEFFuJ+vsnuX5ufp2PVkE3wy?=
 =?us-ascii?Q?qHqE5J/IDg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b852b9-6be4-4749-0f0f-08de80423f9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:35.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95LBbpfspkRpsibDgXvrozbGJxRnfRqU0GOkex9MEqsURUjFWSdVE8Jfp1PkhvPYW8QhL9ErFpGJEfai0whBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
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
	TAGGED_FROM(0.00)[bounces-267087-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: 6C0F7273406
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
Changes in v2:
- patch is new

 tools/testing/selftests/net/forwarding/lib.sh | 17 ++++++++++-------
 tools/testing/selftests/net/lib.sh            |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 25b354da4d23..2a4b22ecd302 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -517,10 +517,10 @@ mac_addr_prepare()
 		dev=${NETIFS[p$i]}
 		new_addr=$(printf "00:01:02:03:04:%02x" $i)
 
-		MAC_ADDR_ORIG["$dev"]=$(ip -j link show dev $dev | jq -e '.[].address')
+		MAC_ADDR_ORIG["$dev"]=$(run_on $dev ip -j link show dev $dev | jq -e '.[].address')
 		# Strip quotes
 		MAC_ADDR_ORIG["$dev"]=${MAC_ADDR_ORIG["$dev"]//\"/}
-		ip link set dev $dev address $new_addr
+		run_on $dev ip link set dev $dev address $new_addr
 	done
 }
 
@@ -530,7 +530,7 @@ mac_addr_restore()
 
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		dev=${NETIFS[p$i]}
-		ip link set dev $dev address ${MAC_ADDR_ORIG["$dev"]}
+		run_on $dev ip link set dev $dev address ${MAC_ADDR_ORIG["$dev"]}
 	done
 }
 
@@ -543,7 +543,9 @@ if [[ "$STABLE_MAC_ADDRS" = "yes" ]]; then
 fi
 
 for ((i = 1; i <= NUM_NETIFS; ++i)); do
-	ip link show dev ${NETIFS[p$i]} &> /dev/null
+	int="${NETIFS[p$i]}"
+
+	run_on $int ip link show dev "$int" &> /dev/null
 	if [[ $? -ne 0 ]]; then
 		echo "SKIP: could not find all required interfaces"
 		exit $ksft_skip
@@ -626,7 +628,7 @@ setup_wait_dev_with_timeout()
 	local i
 
 	for ((i = 1; i <= $max_iterations; ++i)); do
-		ip link show dev $dev up \
+		run_on $dev ip link show dev $dev up \
 			| grep 'state UP' &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			sleep 1
@@ -931,9 +933,10 @@ ethtool_std_stats_get()
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
index 51d232552e37..c19c2048f2df 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -518,7 +518,7 @@ mac_get()
 {
 	local if_name=$1
 
-	ip -j link show dev $if_name | jq -r '.[]["address"]'
+	run_on $if_name ip -j link show dev $if_name | jq -r '.[]["address"]'
 }
 
 kill_process()
-- 
2.25.1


