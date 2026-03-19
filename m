Return-Path: <netdev+bounces-269527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLY3CFkgvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:12:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2292CE7F8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA7132E4DA2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557313ED12C;
	Thu, 19 Mar 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fXOGR6Tz"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25273ECBF7;
	Thu, 19 Mar 2026 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936275; cv=fail; b=d1q3u025b0LkCKYLH41K/2/wfrFx0MHMxf3wxPdaG1ZaxvNANgJ92mV04K70j2pKTJ+PzvjTrU1lLj+1p1jJIHj4gsUsUlNuaTPKcMTM3nyJ/sL4Rj+zZrcET4JxHaPSfI1IpwCacb9N/kxnO6d5K66dpGC8zsRLZSOaSWmjnH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936275; c=relaxed/simple;
	bh=uRN4awtiloXMzofhqpag/kJyJc86Iq0ie2XO2yYKyBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZa63nyU3m0UWOMhmD0dbPDP6ZeDMLu+mk577Hi6yDtyFDc6oNRaHzYXsOiBfWgfE5/41CCFRBXBng12+VPXW8AOHtuHbC1dHfUlYhUjCxz6aSJqXqdmGBUFsPiTotaAuIQjeTkBQNGN2NErHVawZHMYy79FzdnKOzLYAdg2bZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fXOGR6Tz; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChOtXR0uQxcjmlv466P9x2OYtA5mMz9qX7JLX+Iq/JkjQDyxYXv1KtwmQct0LrZ7zg6pmk7pyxzHJfI+yvkj9i7Br4YKgZH+LGyrgLGtsaUEVilryBbHIfCz27uLrfIAz5MQRuzimFxU5Lz+s4nxepAjP4pzPbkY6csrfy7lYAVJUsqO6VE6oBUaFF5jUFrieV3HKUYwSp0bIQyRc3j442GnS9ikvmWyJ1euKSS7Ew0sGUfslVilU9YRZwYkkDDQrbe3nb3EIeVy6i3o+/TJuXMxkOD1UaAlvWnLXCE3bnJPpxD23pYFpaoO6OOcpDUBVIMUDcd2apIDAbiBLUltgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLNFpChBmNXBoOYUkPsPWZuoGVv4A17xyTH3Rqd7jIU=;
 b=VICyFwDTYtfgiMw5ZEzHq3G5vDpiwkt+HAzgH41xBBW6KU4my2wndlfxHGQgX5+yEzjPqqdo7/VOV3V4OK9uwLpMXzbB8qUC7YZslIHiYYYCFqdWkWobOOaU377pYvUVyzCpEN+vzo4+tHbHtllL54GzHwUvCGV7viTRu8YR+Me0EdcD4yBd8rlWRQOByAHIiy+S6xP31xVad8ivXCfWxhDBz3/WE8/KYutrmxAhkQmobD58GAyAVg8NQaFcp4ltkceZkRM0+K271HIV0eeZgn4GqHj3ZWeMfMzx2xtMZjlKRIcWFxSlVxPLuKshyXBJUye+8yaztCGJXbci9cN2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLNFpChBmNXBoOYUkPsPWZuoGVv4A17xyTH3Rqd7jIU=;
 b=fXOGR6TzeEaJ3dbEG76EhmyRnPwIv5wvcsU1xeOWYfSCRXoxn5ObF1cFVzk1RC8A0WT+xa5KNKG1offUXRr+XOhYfmyF8i8SNfr6JNJA+GJg3H9CfDRpMyKbzJ6wczo53YLRmaszwEn3n2h9Q/mcuNB+ILdwD97e19upE/AYi1rnxdMHZUWY8Z8/2YWZzEciI4IHYRNmLbdSANboE2We2R9XExo1bQRDvHe6pN5t3STtNzZc+xY30zF/e4pRvDT9cAIjsEzFFBSEPKBCEthgVLSR2814AVtnLRMv+eWqmMHbV4BaEpP/a5fy9sI4M6Om/c8T7hWsmMOwM+f6TJxBWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:21 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:31 +0000
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
Subject: [PATCH net-next v3 6/9] selftests: drivers: hw: test rmon counters only on first interface
Date: Thu, 19 Mar 2026 18:04:07 +0200
Message-Id: <20260319160410.2515105-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: c3abf011-4116-4027-303f-08de85d134d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vgCzTDGFS2AeMcY6ySbfjBWZeXI1LeGrW2gChoGXyNjpCbcKEA46aCV9txextM3189iBEy28YgdUZby5ovi5I5UO5R5lcIjQqAFVzM0TcL9nOQIrU0XDTrzNMC5yttB19+k615UZRrw9T4I5FQm3Db5JpSJ7yJxKS4pW+4sE39+3aB0ywY43TyXAhFGUsHx0+DcVXo/Qi37VIsPiXSdbG+j3/hsek4xubtJ7MsHfpRjJXqe8NcF93vdIrbEHEkT7GYje3PbeXrLyjCm1sZ1U8DGf8CJS+Dv+wN+4+nuyphCokUPXLfPEJUTtEZkf4xgEb4MsQzYcJeBbILPkpI2eyWCMzatcbKlaz3zvAXb7qbpC0v1bm8rzeKZskG475xTmKoN2ZhziVc1eJu2ahhDcrNo7d8mIpAedNJUwcf7312+G74q0ZDDNIjVcpc3ZBtWbqsTprZbfPKgMWqxOK9XJYPVWjMCW1b2gYw7wh2lNveXyimdHbb6z1JVT+yY0qwOYuAlOJ8YSzm6YFKhyySOHElsSvrq8YtORmRSgh43ysofCQzoVK44R48ZW68+MpEgs29rsfnPuH4fB2dO35iadq4i/ky4yahxfIiLLM+hwKxzDTfNUQkBPrXQRY4EuOf/+KHfzqB0dN0e8aVsTQgcbgiA3+ZpYAYRPjKA5YvTUaCypfJnnRsNTv3CUO0HiOTaedD+YYEX4f4KSCPm0opAGWOjF3PyPt/ytaDdDTjjqTMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0jnxxGNnNAKr2327MpstzdsQ3Hi7k5lTRu1spec1vllrpYD3ssqp0TGajHf?=
 =?us-ascii?Q?OeCYPuvI4e/aWMarg8X6tLe8DHwoxTuzfrHHq7mIlNbiLl7ZkFkQgAAlNBt2?=
 =?us-ascii?Q?BFjUyUQ222Mr0+nw8o9iupG6PhYAzlTCi+KmIPBVM6w9iz12dq0JpoBEgLmr?=
 =?us-ascii?Q?ODCJqqRsaNY5l+/LF5cKT1mmQaoR358Jd6xJvmMvs5DmOvCFk1qxyhPEa/lC?=
 =?us-ascii?Q?shQJmHF3YZbRRX2K4LprlYFe/3NvRn1Fq5LTItZlizalOwhYEdUuovSBGyCv?=
 =?us-ascii?Q?2cUpgJmDMM9uOObsrgOd6xSEtNQSmjnzfDiRZ+y2DcqpwElRi9514qlgZPxe?=
 =?us-ascii?Q?yiSPiasJ3Hnu+IVEokcPv6AnIZPvFGNIYzzV4onbRZrxuGpNHaRgTqT0Qo3H?=
 =?us-ascii?Q?7QkGLWgo659/6TUjobrHoGFnOrsvbSlhfLmHMKXUIUFZZISl6ZYKkoMvea1D?=
 =?us-ascii?Q?YBADdk6pv6TxZDmqQSA4mbiVJnhjrm4UgAPO1gto/UNxYbND2qbsvzmPPzgX?=
 =?us-ascii?Q?CCNO9R9eQwaQhog2QaUT4QR0SWwy1+7EQYO84au6INDWxkkZPJVm3WxePR9A?=
 =?us-ascii?Q?KRYLNsP5WEstP8FI4QVaQ707uQHCt6StHXHHWCQSsoBa7NyFE5nf760b6Cp2?=
 =?us-ascii?Q?2KfHb11amT3Y08KUTsye0VuwY8qiwsrVDSNfFz7kbRF1b5PtY/5/CMD1fbmr?=
 =?us-ascii?Q?UhgW71Xwg+P99wBG/lDyv+4J+B1j6lZNBTmIk2XeMpDiWCcwPLxPLOA/xDNx?=
 =?us-ascii?Q?bDfRmLgqp7EmSESDEnAyFlEpXLJXVKlGB2c/vgOVSlF+N95QSaVB34Od088d?=
 =?us-ascii?Q?4FVPnh4ZnG8K5osNIwLSE4aJqsvfymLKaoyyvq4iq/VwUOCDmZlQBv1qk+kt?=
 =?us-ascii?Q?ozwFdJgYS2Ke/tU5ikKdObtD+7RKHqrerB35hvH5suI8tlP+W4pHWjoj3Dag?=
 =?us-ascii?Q?lxk/mk0yfwT83oOBVGWdyCwdaVweRzuA33CehuDdLxTow74IU9l4YtfbmHNr?=
 =?us-ascii?Q?dJk54ADy6JPM3txDz+DZcqB27fdlW4wenZT6+g3jxfEFYna7t3q0w6v5CXjg?=
 =?us-ascii?Q?A4U47IqtqBJ7lOdMc+o1NzDkQ+FzjypG1iCg9iFo8KpWm9ob/Njv7FJBEyFN?=
 =?us-ascii?Q?VG60fKCWv+aMhZDFalreYHox50Kr974g+nk+hmM0hsVorn2AjI/OCM0+LTuJ?=
 =?us-ascii?Q?aUAFb5mIzF1Nx57YIxAVPBk9VzwB30ZI2hA2opQplMBwY7bxsq2q9uF7hxVi?=
 =?us-ascii?Q?iPXwUEAON+vfvc5MV5ZgQ17SSZolrml90Qi39jpI+ielyogeqYGPb3XnaS9R?=
 =?us-ascii?Q?5naFX6FZqHtywNTFQCGjD1UBEzL/tryo85EW+fUejHd4gf8N4qtNfUkkWJLv?=
 =?us-ascii?Q?ChytTXlGjOQ1Ij5A0WubceePYzrkRqJPSv65cNA4aZg9Og9FFAG10+cmQCE7?=
 =?us-ascii?Q?xujTbKqds9d32tpPbkAXngQeQKeNlyWH425ay1NwjRE6IsNFkSeytNl5/iLH?=
 =?us-ascii?Q?yApjJK7OL/btwayzpD9zYLfCATtp6K1dz96jXO5CMZWqQzSjJP+/znRR0T0G?=
 =?us-ascii?Q?G0dKV95UCBUpQZhDz+gG4M9gcYmxefRNgdAhK3nx122WTc7/QpZOFPfzmxyP?=
 =?us-ascii?Q?xGeAP9uTZL3wq64h4yup8rv0SA/MQJgpMAfxTuQ5mfP4TrXgKEFu3H9YcDVG?=
 =?us-ascii?Q?1bs3ykGpWvZUbITnIq2Oez1q40WD9t7Cil7NZDS5lVltAtzTqIB9r8lg3ezk?=
 =?us-ascii?Q?+GExNny7Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3abf011-4116-4027-303f-08de85d134d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:31.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r02a1KY5kZnLNzpm/vz5Lq6bfwFOms1DImneFLObVOdgVCsJHuSgMGqx7dG2PACAdeHsUCPjqSqcbJYbfX0D1Q==
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
	TAGGED_FROM(0.00)[bounces-269527-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.958];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: 7A2292CE7F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The selftests in drivers/net are slowly transitioning to being able to
be used on systems with a single network interface. The first step for the
ethtool_rmon.sh test is to only validate that the rmon counters are
properly exported on the first interface supplied as an argument.

Remove the rmon_histogram calls which intend to test also the rmon
counters on the 2nd interface. This also removes the need for the remote
system, which should be used only to inject traffic, to also support
rmon counters.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 417627e7a592..636429018b6b 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -106,13 +106,11 @@ rmon_histogram()
 rmon_rx_histogram()
 {
 	rmon_histogram "$h1" "$h2" rx
-	rmon_histogram "$h2" "$h1" rx
 }
 
 rmon_tx_histogram()
 {
 	rmon_histogram "$h1" "$h2" tx
-	rmon_histogram "$h2" "$h1" tx
 }
 
 setup_prepare()
-- 
2.25.1


