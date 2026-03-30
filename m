Return-Path: <netdev+bounces-273255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CMYLnKYymla+QUAu9opvQ
	(envelope-from <netdev+bounces-273255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:36:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C735DFF1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2127303ECFE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E8371894;
	Mon, 30 Mar 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5PxpMIt"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1F371067;
	Mon, 30 Mar 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884657; cv=fail; b=fBU1rBacBxJ0HOjjCoSH7qfVznYqTxIvEcV37mjYs882b7tj6KQVL3qlQisC/xnb2nqJNVwZNA+8Vstqr46tRz4AkDWaw2V6b0SMRq7yxGDgVZrw/AtcluxpsIoN7X/A57FlrXX0mmUDB4V0Qlr3zp6SpzZmucnBE4KNbqg3Bhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884657; c=relaxed/simple;
	bh=N6+AyKfszX3ej9xSrvQUD9qBHBHmQOwYCXePwyEJ1OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRQ6yOuI8gFxr2bbGDWqR0/1gWIcDmvTPgyLHG+NKihzwA55U/s5DNKqeWZXJTpNU9eFfmhvn1HsKOWfPsYgpqVc5/ZH5TSbbny/m6kjZ+XP5BvBA2BEJbNCmViPiLLuyUOZieDyOh4kxegTD90MY+ioFJhD4nFX9sd/2MidpnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e5PxpMIt; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mopv2+Kzab03xwpVGgiIqpkz/kCeqfjaW07ypJgWrL7qDi9qhh3p7nCSiHH9uwvTX3RNfLpPZE5Psr1iRqlnhOXx+EiCj8PCJ+l/f0Fw+SqTtrc3k5SpzpUKNzPj/PFT10+gZM9qXHA8Er881Lx73Wwmlvo32AFOS/Gy4tNowbE6uUj8yqTIV4eDdGvVYAa3IcKcD18417BMFQLbyw9A+sv6ndoO8Y4zshjF8jbP7AKbwVzsNrOdNvLUpjF+vUsKnQjHw+rjNj+8FvgSAx8nql68iZ0OSL20GF3gaH3RXUCTZZkTRBnXIkgV1P6PST+0+sZYfEEuDuWKroGSjAa8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykhCU1u9p+b4wtD/xkjWx+TTMT9nSPhI7PzV+Oy5syo=;
 b=pU4nQmOAbMZDWfIp4ucKvNiJMrtQh0H7N/Qjbd2z8E9IDnem3XMz0ipNAygITVuLIQD4bggmXQ/ndm8Bwu3jn8vUSNwkktw3uLSfRNmGpBVUxEsmhRiLaGtXl6HGJAK7fA/8cIgnfBs4H3srOSCZ4sjkqKZzM6Ele5lMglFynRlghg/Z271wvRz9rVmwvlQzdg/4INugJZK/FRzj9SZR0/08i1LpNuMWV3259A5LiCSzAt6V3P9L2XsncONqo20UZOhY6GbeWVNs9JWXwLA//oNsth7Bmt6IUyYoou6qFEpLSNX1Cncl5rNrECYUrHZPBgm/Ppis0YMr2Ji+gXUpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykhCU1u9p+b4wtD/xkjWx+TTMT9nSPhI7PzV+Oy5syo=;
 b=e5PxpMIt7KoqhUFENcV3kdgeHr1ymw8H/WKRffBUv79BkBKMS6dr02bM++0RwELjnc/XdJjLarqX0GEUPfTiUtLtNPoio7mQdqJGeZidIUGD/4dOA7B5cBalbmRfvgojDcSGg1mno6orei3XZjY4jIe1lfMrV8gaq/bSyfxCc40JYuomxXc1Lw2pyizBjsYe0uU/0VXIvDOvLIazFlcEa6/PAE1B/uFbpIOJbVhwrNNzGuqKlsD17gWfvHThmdXPDQALcGrEI3RpS56fgq02StPkBsGhpMMLLq0lnWHNiLFAZJvJ86S+5vs/dgJiL5Lsehqw6IiqSSbill4HWXKesw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:53 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:52 +0000
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
Subject: [PATCH net-next v5 8/9] selftests: drivers: hw: update ethtool_rmon to work with a single local interface
Date: Mon, 30 Mar 2026 18:29:32 +0300
Message-Id: <20260330152933.2195885-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::36) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 419b2781-3739-4174-c683-08de8e71542c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	50Ot4TSBlvJElQ06+gN4cTcDJu86/qqYRGCykLgsHMF3AcnsQNKfuK3+hZ3J+2mXCr8rH8q2kHLGpJjz11bZbDRWvIGQu9+HK5P5BzZFtT0JwuPvVS4b7WCXrkoSW9rLoXN88GydnSQ5xdOEgnGodvG3BsT9LkVpRyBZ7cBbbQ2yAqQqAQOKagfmKBAyoVtdjWnkwNatNVYcRjjhOzzVfAsbKmpAzaggj+n0AVYuznb754jvcvmtyLorYz/+0cUPkNVlin5TcuG3Motm245Vz4syW1Q9wRURhTHhsBxccm285fhnvFJTp2d70f8hw67IblFOSEz2rYwsuHu5pGi20POkLIhMooreofq+8bskWQA0rQtVj0jE6OMu4HPhWqNkvj8gCo3B+jxOMU9AHzXSAvznUuJ03Ap/ygcJR1H1gsste0ZsyScPRKGKy6cNSkIdxTsojh0AnVXFIR9+EhNdAb2GeHoCZ5/7iKjT3w3Ec4yEKJaqZBIOxzIV6ZACOuu+esWTBWsEZfkzl7BTTlmpZC5iuLH03Y8ijRGbGz5XMLILAp8zQOM1IqNai9A5rLuWLhQU6sR9UsuPjWk6+SI5rfeFyo/PxuYGYfKnHQFj+H6+wpq9tFaJCUZMw3Ug4kwauHGMoj7rYpoJN6d+hRQa1Zbc+s86aZ6iw0EwtzurRZmedy0Cl8HRVHd0wxKvgY1LHl3vziClF0GDh9kwgsb0EhhTjpqhjCoUrSCPSc18ofg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kA0ZfkPSz9q/oydhdCo4EANJWLc2xqo3FHDaD5GT+vkai/+5bOFxpDs1m0ro?=
 =?us-ascii?Q?ZfXZ2K0QWSI3Mg+DzPODyqc4JXEu4liOzB1fpfRbh3PkbDhITJFRRZEfxMGC?=
 =?us-ascii?Q?LwW+Z8/RcVEE/gE7WV7chBS8kG7OrttZKB31o4xM8vFH4Koa2aGxvzfUEl49?=
 =?us-ascii?Q?Rvh/5TXao0UAFzkAUufWp+ucNahyUilMbAIX8vXkV2qJPXXQ0DZlL/7v7tvl?=
 =?us-ascii?Q?bWW10gUkVgszZ+jY6Zzikv8xU+tTH0sQzC3TsBD0Q+/VnTvevh7KQpfi9JNl?=
 =?us-ascii?Q?s2IzE7EJZxFsGTrh5aq0GKZNtNp8qfcaxMCniaUFx67Yf6bnw42DnyhvPKpg?=
 =?us-ascii?Q?udSXutpnBPVTBExgo6BQ17i6K2xecbNbIyLh7mm+jWBmi/yT7e0xs2SoMo6o?=
 =?us-ascii?Q?XMjFC95On2fBzp7v70NLFoiV9n47k9aD3ptt0lp6I9aILP+c5kH1HyjG+/TW?=
 =?us-ascii?Q?QvTwIyjlCueYprizSCJK8ksDk+12azEoP08dYZaGC6XRoIhbJ4RRLDJZxLRt?=
 =?us-ascii?Q?mmKCb/N59kXZnyUgRIKAtrlmxRg1bxbj9EGTQMqPD/WupEFGu7mCJ/rnq38C?=
 =?us-ascii?Q?/xQX7pP7WAGndikxmeWKtwb6Z95mkzhSZRt5PhcS2MZOFAYQxHE41PCHTw/h?=
 =?us-ascii?Q?Eg8Sa/WFD7ROIRTa6rFjYfqVVTybrMjCtKSKt6jj6BF2aDGR4dk0Jj9Bdu0m?=
 =?us-ascii?Q?3gHM5vJjY6Q2sr4Bs4sBEmvh49Nl1s3r+MqjjbX9nZ110D/XJAPGuW2HkkXz?=
 =?us-ascii?Q?LG6ntVkxBiwOgpBGTjWw1DS/9cFWUlNjh1hIUoeH0pHrTBWIZHL8dLFrcnWZ?=
 =?us-ascii?Q?Hih7QZD8Dc29+F9pQDe88a2vatrWvMtxP9Fe+2uih2Y/X8m+KI96zWAFDnSi?=
 =?us-ascii?Q?V5sZg+0bB0ktRQEeZfL6U6MHz3mkfhzoukxjBRaxFIXY+nAWAm1KWo17KkQr?=
 =?us-ascii?Q?+ee5i+s/MNN2fHanXpE2qGTk6JganvnPLbs1YC35WxoC8P9UbqUEndzSaYuM?=
 =?us-ascii?Q?dCuwtOjYZABJbaIBpNN7hyLmeGRyTpHZBnBJVKYGIRIZPaw2F6re/AhA8H0u?=
 =?us-ascii?Q?919+KaI0BQi+FGp1GIyTJ2K7OR5/ZK71bGzdjvIf5LNlROrta4trTiwpCvNP?=
 =?us-ascii?Q?tApOp71Z63csVti1tGRs1f5c1fMQ56wmYm9LeRmLqL2oVkiwP8h4hSYMk2BM?=
 =?us-ascii?Q?imS19fU4Ir9oibXA6exgklz3e+jVTfr12A9G96B+PNqluxkzWhcZWxK/iz++?=
 =?us-ascii?Q?sHRalicdpOtNB2oQsL3xMdezCKpnFDHLuGFYAsKUEGiICr1alBOwygKq10pX?=
 =?us-ascii?Q?jHc1OVnM1YzTv8lhUtRf1URlNlIUIJ5VYK5pvrishBlScAXWE6JrpaAQcuyW?=
 =?us-ascii?Q?juQv5yyvELor6RsA5AdQF5GHva1NONEFzyEKI/9myjNQZ7/B1+vmfUcbM9vV?=
 =?us-ascii?Q?k6aIDGdYo7cAR1vQqDxmYcBWtGXKZgGkUpfvTcyRJTHYj5qnsq9UeHpoQPN7?=
 =?us-ascii?Q?infOGWf25KCKzOqGKGpSCqUax0OzDbd/Bq5m0EiGeYTwa9eUPj+dtPTsQlT7?=
 =?us-ascii?Q?6WVxGDbaU9Hz3336jtfy5yl3bSdUFFGchlz2zmOAOu+UnePHBUmgK3ZhblpJ?=
 =?us-ascii?Q?lcTL4TL2mgzE3xiz3pgPmZ6uNmFqjnbnAdxBuWDFAwS5nieCGNxJ1QNZLEpG?=
 =?us-ascii?Q?aEOSHxHHf/RMXCGps1hUVLj3B6w3DFwnhVfjv7Wy43Dcy4vACidDNj0/fvZ6?=
 =?us-ascii?Q?JIM8JV6now=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419b2781-3739-4174-c683-08de8e71542c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:52.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iDoLUicAr6cGE8fxwW7mN0Q7bvFeV8g/+6PpnZQpEiiuCfkYDNioFWXkXQ7+hwNncFHidfxsQHs7q5HDA3DOQ==
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
	TAGGED_FROM(0.00)[bounces-273255-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ethtool_rmon.sh:url,nxp.com:dkim,nxp.com:email,nxp.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 7B7C735DFF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch finalizes the transition to work with a single local
interface for the ethtool_rmon.sh test. Each 'ip link' and 'ethtool'
command used by the test is annotated with the necessary run_on in
order to be executed on the necessary target system, be it local, in
another network namespace or through ssh.

Since we need NETIF up and running also for control traffic, we now
expect that the interfaces are up and running and do not touch bring
them up or down at the end of the test. This is also documented in the
drivers/net/README.rst.

The ethtool_rmon.sh script can still be used in the older fashion by
passing two interfaces as command line arguments, the only restriction
is that those interfaces need to be already up.

 $ DRIVER_TEST_CONFORMANT=no ./ethtool_rmon.sh eth0 eth1

As part of the kselftest infrastructure, this test can be run in the
following manner:

 $ make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw" \
 install INSTALL_PATH=/tmp/ksft-net-drv
 $ cd /tmp/ksft-net-drv/
 $ cat > ./drivers/net/net.config <<EOF
 NETIF=endpmac17
 LOCAL_V4=17.0.0.1
 REMOTE_V4=17.0.0.2
 REMOTE_TYPE=ssh
 REMOTE_ARGS=root@192.168.5.200
 EOF

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_rmon.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_rmon.sh
 # TAP version 13
 # 1..14
 # ok 1 ethtool_rmon.rx-pkts64to64
 # ok 2 ethtool_rmon.rx-pkts65to127
 # ok 3 ethtool_rmon.rx-pkts128to255
 # ok 4 ethtool_rmon.rx-pkts256to511
 # ok 5 ethtool_rmon.rx-pkts512to1023
 # ok 6 ethtool_rmon.rx-pkts1024to1518
 # ok 7 ethtool_rmon.rx-pkts1519to10240
 # ok 8 ethtool_rmon.tx-pkts64to64
 # ok 9 ethtool_rmon.tx-pkts65to127
 # ok 10 ethtool_rmon.tx-pkts128to255
 # ok 11 ethtool_rmon.tx-pkts256to511
 # ok 12 ethtool_rmon.tx-pkts512to1023
 # ok 13 ethtool_rmon.tx-pkts1024to1518
 # ok 14 ethtool_rmon.tx-pkts1519to10240
 # # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/net/hw: ethtool_rmon.sh

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- set DRIVER_TEST_CONFORMANT to yes
- update the commit message to reflect the current output
- split some more lines to 80 chars
Changes in v3:
- none
Changes in v2:
- patch is new

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index ed81bdc33536..2ec19edddfaa 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -8,6 +8,7 @@ ALL_TESTS="
 	rmon_tx_histogram
 "
 
+: "${DRIVER_TEST_CONFORMANT:=yes}"
 NUM_NETIFS=2
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
@@ -27,9 +28,11 @@ ensure_mtu()
 	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
 	local current
 
-	current=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+	current=$(run_on "$iface" \
+		ip -j link show dev "$iface" | jq -r '.[0].mtu')
 	if [ "$current" -lt "$required" ]; then
-		ip link set dev "$iface" mtu "$required" || return 1
+		run_on "$iface" ip link set dev "$iface" mtu "$required" \
+			|| return 1
 	fi
 }
 
@@ -52,15 +55,17 @@ bucket_test()
 	len=$((len - ETH_FCS_LEN))
 	len=$((len > 0 ? len : 0))
 
-	before=$(ethtool --json -S "$iface" --groups rmon | \
+	before=$(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	# Send 10k one way and 20k in the other, to detect counters
 	# mapped to the wrong direction
-	"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
-	"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
+	run_on "$neigh" \
+		"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
+	run_on "$iface" \
+		"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
 
-	after=$(ethtool --json -S "$iface" --groups rmon | \
+	after=$(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	delta=$((after - before))
@@ -95,7 +100,7 @@ rmon_histogram()
 		fi
 		ktap_test_pass "$TEST_NAME.$step"
 		nbuckets=$((nbuckets + 1))
-	done < <(ethtool --json -S "$iface" --groups rmon | \
+	done < <(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ "$nbuckets" -eq 0 ]; then
@@ -120,9 +125,8 @@ setup_prepare()
 	h2=${NETIFS[p2]}
 
 	for iface in "$h1" "$h2"; do
-		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | \
-			jq -r '.[0].mtu')
-		ip link set dev "$iface" up
+		netif_mtu["$iface"]=$(run_on "$iface" \
+			ip -j link show dev "$iface" | jq -r '.[0].mtu')
 	done
 }
 
@@ -130,10 +134,10 @@ cleanup()
 {
 	pre_cleanup
 
+	# Do not bring down the interfaces, just configure the initial MTU
 	for iface in "$h2" "$h1"; do
-		ip link set dev "$iface" \
-			mtu "${netif_mtu[$iface]}" \
-			down
+		run_on "$iface" ip link set dev "$iface" \
+			mtu "${netif_mtu[$iface]}"
 	done
 }
 
-- 
2.25.1


