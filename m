Return-Path: <netdev+bounces-273254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN+pK0qYymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:35:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992935DFBB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6196530370A6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173FE36F41C;
	Mon, 30 Mar 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KufxLA5c"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1EB36DA15;
	Mon, 30 Mar 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884654; cv=fail; b=Odib4PKuH0xLc63nSEBl+X+F/rNx6bsy+mPMYhdj15BYSFltQYP2VCTIpd0JevtekPAfoYwSRKxrQNR/Xbn+R3nbTTlmXpKZ38s420G0WIAF/OxwUz62q795hVrJIuaXtmorzt9ow0CEdZeviglsVo5zcrQb4u0muaezwH+FPQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884654; c=relaxed/simple;
	bh=2IBuZNVlc6obR7fOIgIENZADAGIlWPBWm0+5O9cMSPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVc5v/kMRUJutN6JWVtrHGnBMITlBDPJri/DbM4PE5ozi8zgEfraGfgdMjp/RPazl2bcCo02moi3Exf2WKbMYiAhIjNesbTnuMOlOeVMXkxME9w3iXZVNQZ/RduBly7fobLhONJxw/unv5GI768o6RbfDTqLnXxWMDhIT5E1l98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KufxLA5c; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbGBuMbWojtuPAL/oW28DfV2C3HqQxOR3XdX1w7Q4X6eMP74LU1+juFJwZ6EAYIuzz5XTDeS6GVV6UbrlRDZXZXVm2Fn1PgnwOqf7ab55JcxgPVnDqF5xFCys2mdQnIIylAAebn4rymKDJMf4imjH/gkHMqeYe64HWprsQP6NfrS/ikoq+euNpGHdKF5DUPJb+AO2ADTgnG1y4MsnisM2Fs7maWjf3PxEpIITOz+lQFcHiZrVydlU6Z9tsHl7uFGoZ0IhV0b8JKBJUtUwWUQTLeT2b+s2FqjIHfNDDP/rycLxxdn91H3Cr4bus72lA3fB3Ps5WesHle57GVCNIXKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzZRUJTmBH8C+syJy/ShqYdXiOV1Ucng4fbkLyjVOZI=;
 b=tUdiYFqb8siEyMC/C00wzzGqMqBDIAhhKiGdDBeGv0HPaHKDwBvD7VNazbKJnRCN50UyeG4N4zM0TyrSPCoDmQtmfVmBSxTzU9rr+KqPiZIvBcouZXFBSQ4Suzs7nVVdCxN1JSi0tmeaSeNM5OzKlLwMB92zcXgK6yZHGWUXrIwALR3TevvUS6i4RNqyyfHURba+YuA8nO965+b/vt6D+2d+8CbCW5PCSvCMwE0UBvScKy2jZzpZ422wS/MIoA3Y5yVe8uRlsd0F1jvbcLccMraaQimhQB+FH6llXJ+sGjiIvM/G0sb4FmxelagDiMJ/itfjI/HpBXOzVn3wKt8ADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzZRUJTmBH8C+syJy/ShqYdXiOV1Ucng4fbkLyjVOZI=;
 b=KufxLA5c1jGx38yXNPXhziogI0ih78TlUTlk5sFlWJKXDCUrn5w/6phuB2LTpNV8e7L4tWctR23K7iLQBKAomA0yzhkns5zGwQUnbovYQCeGg41CG4ebwynpOktub615nlzX908DtO2s1CjIdAyHSRMwP56ivJQrM4fgb2aB20zfIllfwHzv70q9+0Wf5ZcpgmkvHdmBq6dAUKwdIQVkOx6Kgpy+pEL1NrT+kFaVuvwHYpLfT+SyWVU/u84Y5+N6OLkoYl94I5Ag9EodblMFC9O7O7mmCCCWU0Ws4JGzpWK/3POa1MTzwf7raxz94WFYZkwFtJUOV+PE6TXpq6VPFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:50 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:50 +0000
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
Subject: [PATCH net-next v5 7/9] selftests: drivers: hw: move to KTAP output
Date: Mon, 30 Mar 2026 18:29:31 +0300
Message-Id: <20260330152933.2195885-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DU0PR04MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: c553d7f1-d82b-44f4-4ce5-08de8e7152c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VA5xTaNSGc+wGMBRVFD/wl+S6tkqI+98A4RchEgqF+qJf5tnoTUXhbAS0Hvg+Jm/nndHTjT3A4iRsYB9srIJDZKIY4O0PJjrJs7l/hlqT0jfl2Tzd/tCjWhF3D9BPckkBBrXz0nOKTy/TF1WuouwcU9ZCLA9vGFB+WtfPWfefYi8zmL2D+2bfJ4aGOWKOUBGoQWJhgyuBpx1a8OrEag3lmRv4iwKeuEENUJT1aRl9j7NUAcgDwyT4gSHnaPzhWj5PbdzoDKBCCVouEjnkx9FJVql6jKLqja+O3frkrv44JuMFnz6iCf/jGvojf8yYfVRh8MV0cd9/XTtyPKSATGF33o8gAWR/8Ww4/u4pS7J7IBb8dsYs+Pa/sk69uVNs9lcsYDaojfNapzgvb8N85f0zRFuTUer7ThSt5cyYEA2DDYEGXhvxjW9h3Pt7Id1ErdF6RymhiBW2yrCVSsb0VR2VgvNN33+qB9B1bAPAcd6rtfSwzDtV+KioVeMQINXtEYh9oj3RqDpmS2sVK9Mcd9stPOeDYifp1UFW5+MjhFyeWsQbpvnrMwOGpawT2/QMVqOlNKZrKjm+M2+f6Lw1DomONg5dwPfPoHznnJbplGv5yD4G0TLbiIJz16devb7gI/UtlMrXUfs1oaDBmQe+1BApKwDDYFEbMbB45lITjPJEiX6u2KFigI9GbwV0NGPWm4jtXAPmnznO5uDk5LH8eLNZEdYqqHcUH7e2IPb/3iL9Fg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PNW0e9GJfu+ZUEuYKqaVx+Xmc9yKbs8hrASxSZjXGtsNUuShMIi2jrAat2T?=
 =?us-ascii?Q?TerBrA0aUha1U7m8VHY5Vug109vbygke9TzBXpBjnNDNRC98HcTnis2568Sy?=
 =?us-ascii?Q?AGJMT2R4eRpBM6UDlHLUjh/zlX5aHdUlp5TwkR/WRjqxLVNdw7eSwCs0i8Zh?=
 =?us-ascii?Q?uKVOMbie0O+376RlIfghmPN5CUpbjfYDj/lFfyr6RMAv41lcyYaiNuYHqvHI?=
 =?us-ascii?Q?hGZFm5ly36Q0IxLUHYSgrSPYPe8L/6oc1zUXC3kUb/lSXUaoPDXxu8GH0y2Y?=
 =?us-ascii?Q?Lrch1CShZwBqeCSY40L6OFdfx4lrLs7GWkXI4NUI21XZwlphsjvItB2DHL9j?=
 =?us-ascii?Q?D8PAkTR+otVEgC/2IEBudQsBi91QaquarBaUbA5Bowurm0uBkaGCgW0vmdBX?=
 =?us-ascii?Q?fSv4mn5kNJ2gUIC9Bkwre5nkwjtQ6GfcaaZjenAR1XpvEuzz7KX7sYFfnlij?=
 =?us-ascii?Q?OlAYjuOW+b6eRcGuX3UdJtnwUM2bZCNT5kkol4De24yXqWCuoxjIu93Ecu1p?=
 =?us-ascii?Q?autatsYacAVEhL9LP2YkQug4B1kM2Telkv09nEz7JwM71fU8iOsA9Exsx01b?=
 =?us-ascii?Q?8IUHxjTBDHQzKHsBV5HclOD1rOroHgWSsbWwx5WrA/zv7nH13FNCHMMUjxIx?=
 =?us-ascii?Q?LDlDx4mh32KDxTsYsCKodACbSiRdmziGqyYXbFdAMtdhGScaa4Jb3cG2tgch?=
 =?us-ascii?Q?B0GLQ5Eo0W//vF5hp6MiITOIVWbycHNl2bOMmqaT6q0Nvxm4TI15Zsy4676H?=
 =?us-ascii?Q?6SyBjVJSlBc12k4At9HpjyUVD7b1d9CStYg370slNIvSWj5N7iUu4+J+TM0T?=
 =?us-ascii?Q?chPo9xT8wwiVD8GU2a4G47KQjFjFAa1k4W/bDlXinWnJNbtFG2k9roItnKuL?=
 =?us-ascii?Q?vO2HshEpLIWfpWtgQIyx+PUciyamz6VusZPS1CnximkCrLmrkHlyfrZc+Cv0?=
 =?us-ascii?Q?ggp7JTPNjMGROopzIvt/xYCZtwVx8vT65poJDPchODI5oFD8xoknn95X4Spu?=
 =?us-ascii?Q?uGYHneIat7MLSGEGhGKwIkQRCdMGOuQCIfBre31V2qJHDaSJjNwIPmx0sfw9?=
 =?us-ascii?Q?PNPZk6TcYA8z98TJNxPWRRLAsr7CpbC4RdfUU6Af2b+koFpdBIL/qxj2Qpsw?=
 =?us-ascii?Q?Sw1BXsx6jSXkul3FZ3s5GQ5unxazDS8Ot44qKsrefwuKrkTAfqDNGkzg2IvT?=
 =?us-ascii?Q?KPwu0X0SQdsKGl84h8RN+9BNLvc//TCimP+bwIPg86YqaJRD0lLzX0ToG9PG?=
 =?us-ascii?Q?bDgZk2vQG5VCZFFH4yA1X6kGLS0lAYqmb0dFYoRmiTMyIbqBbrQyGNkUcivQ?=
 =?us-ascii?Q?L5s+LBKrgTyd7F40HO2SWdkfe05MltaRkTGCoHlnh+fjHbOEedCSWIGaZ6Za?=
 =?us-ascii?Q?f81Oe4ZffEW8ARDmTqpMAOfGbUL+8z0+Ox9FZN8uVhlzJZ2nztqlOXE7tsB8?=
 =?us-ascii?Q?wttt+tGv/6GLysH/YJTGDoDAE07dxgk0HXUv1H+9+a9+bnM3Y33ZN+njISEu?=
 =?us-ascii?Q?VSAohsYA+P0kZtDR3kUrQs3FelMzBVqdLwKxROIm8E9ZHT51tdHgu85q5UsU?=
 =?us-ascii?Q?xw4oRziE1SJ4rTcJNREGC2mHbEJZPSM4BmY1sooMZQNCIepSaMfqGJ0mhCdB?=
 =?us-ascii?Q?9RfeuD7z49p0NxvbBy8RJJlPthQr1RlVDB4Zx/vdULp8Pjp80He3pStsy/8y?=
 =?us-ascii?Q?zUE6wfAakY4B8U92gk1Hh2MN8pNr1h5omLyvoUUIL3/P9e3LcWgRyUcwEv9V?=
 =?us-ascii?Q?gSXUuWdppA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c553d7f1-d82b-44f4-4ce5-08de8e7152c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:50.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVSLVHVc/5M4NpecrKn7Lj50miaMAd6lCp5HD283uvKnvBRUXfkqkZGj6AegMPnbzmf1vdMoS90IXhpKTB526g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9372
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273254-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_rmon.sh:url,nvidia.com:email,ktap_helpers.sh:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 5992935DFBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the ethtool_rmon.sh test so that it uses the KTAP format for its
output. This is achieved by using the helpers found in ktap_helpers.sh.
An example output can be found below.

 $ ./ethtool_rmon.sh endpmac3 endpmac4
 TAP version 13
 1..14
 ok 1 ethtool_rmon.rx-pkts64to64
 ok 2 ethtool_rmon.rx-pkts65to127
 ok 3 ethtool_rmon.rx-pkts128to255
 ok 4 ethtool_rmon.rx-pkts256to511
 ok 5 ethtool_rmon.rx-pkts512to1023
 ok 6 ethtool_rmon.rx-pkts1024to1518
 ok 7 ethtool_rmon.rx-pkts1519to10240
 ok 8 ethtool_rmon.tx-pkts64to64
 ok 9 ethtool_rmon.tx-pkts65to127
 ok 10 ethtool_rmon.tx-pkts128to255
 ok 11 ethtool_rmon.tx-pkts256to511
 ok 12 ethtool_rmon.tx-pkts512to1023
 ok 13 ethtool_rmon.tx-pkts1024to1518
 ok 14 ethtool_rmon.tx-pkts1519to10240
 # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- patch is added in this version so that ethtool_rmon.sh is converted to
  KTAP output

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index f290ce1832f1..ed81bdc33536 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -11,10 +11,12 @@ ALL_TESTS="
 NUM_NETIFS=2
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../kselftest/ktap_helpers.sh
 
 UINT32_MAX=$((2**32 - 1))
 ETH_FCS_LEN=4
 ETH_HLEN=$((6+6+2))
+TEST_NAME=$(basename "$0" .sh)
 
 declare -A netif_mtu
 
@@ -76,29 +78,28 @@ rmon_histogram()
 	local nbuckets=0
 	local step=
 
-	RET=0
-
 	while read -r -a bucket; do
-		step="$set-pkts${bucket[0]}to${bucket[1]} on $iface"
+		step="$set-pkts${bucket[0]}to${bucket[1]}"
 
 		for if in "$iface" "$neigh"; do
 			if ! ensure_mtu "$if" "${bucket[0]}"; then
-				log_test_xfail "$if does not support the required MTU for $step"
+				ktap_print_msg "$if does not support the required MTU for $step"
+				ktap_test_xfail "$TEST_NAME.$step"
 				return
 			fi
 		done
 
 		if ! bucket_test "$iface" "$neigh" "$set" "$nbuckets" "${bucket[0]}"; then
-			check_err 1 "$step failed"
+			ktap_test_fail "$TEST_NAME.$step"
 			return 1
 		fi
-		log_test "$step"
+		ktap_test_pass "$TEST_NAME.$step"
 		nbuckets=$((nbuckets + 1))
 	done < <(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ "$nbuckets" -eq 0 ]; then
-		log_test_xfail "$iface does not support $set histogram counters"
+		ktap_print_msg "$iface does not support $set histogram counters"
 		return
 	fi
 }
@@ -139,9 +140,16 @@ cleanup()
 check_ethtool_counter_group_support
 trap cleanup EXIT
 
+bucket_count=$(ethtool --json -S "${NETIFS[p1]}" --groups rmon | \
+	jq -r '.[0].rmon |
+		"\((."rx-pktsNtoM" | length) +
+		   (."tx-pktsNtoM" | length))"')
+ktap_print_header
+ktap_set_plan "$bucket_count"
+
 setup_prepare
 setup_wait
 
 tests_run
 
-exit "$EXIT_STATUS"
+ktap_finished
-- 
2.25.1


