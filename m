Return-Path: <netdev+bounces-267083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCBbKVfLsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:19:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5A27331C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A43763013029
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F4366561;
	Thu, 12 Mar 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XNTtzGHs"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DC367F58;
	Thu, 12 Mar 2026 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325115; cv=fail; b=hIBIArAmi9kFAXVz5vuuq+UGBihzudxKYqpnHogPXW5w71CiBSABa97aNBr/6ax1zveAnQUPKd/ophXPlyTpIqSxQMgIeEMiRcKqcIQ38a3XjxPrG/KI32H220P8diSJFGcoTjbtYGsSEgFAQd1XKMO7QDrjuSfTJ9ciMkZ5Gic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325115; c=relaxed/simple;
	bh=F+XTs5h9Q1xkfLNIqFhXJPAwU05RZEIT+uIufnyzeGs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cLJ5EdLUu5wMqZNIgTW+Ateiw6Nv79d7yk/No9DO8crwWKMIFkqRg2Jj2Hdr3JgKZnXPl3tUY7Ddh4wv7MnPq6N0cs+mu5JDz22KvTZqwH3i8KCYuC+IbgApc8HjtnC6dkXSuTsTVNHRpiSA0n4UbHcBNGMLp4VuPbLf5I5GOOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XNTtzGHs; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngl7usOlWCe4W06yDWwum6+NW1mEiAdcqE9Dwyg/jSgrGMXSn0Q0mHXbDfxqVw+4CvV1hk/rhD6tEOIT57vHfrsqjGq90QK1vTtqD/Kyb7v8htq+iM6D9ai4BvdL8tDEvZjxvVbncgzwinn6178SMmKXpYwPJur//6Ocx+SGpzKaXNSDtxpINZc77FYdWJsSqdbXrZBCPhLOSVQxvgmuA4kQQ67BsDVVJmGGwT/+IPZ973WsVyWg2wofYJXdXZ0Ak+jzArA4bZphAFqji4usDMlWCVUleqj2KE+q8EySh1LHXnK62hdKLDuzdc4d7O39SQdKFEoxk3tPvNY23FgiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiheTwDbW4aWnhWzgSktMoFMsZNr/lKkt/FUnOoECtY=;
 b=O2WXd1JAhkYSOPYwe/KdpZa+dVwFE70lrY95dDDatuWd8gL742SoNOOp4mnkZtGldyO6mjJAGtuizDPc3Cbgx0+/5cCfwOE4gAi09EPQnKVnnIFOctyBo4OnftBaaATbUAevZohYE+G+iff6CLNLWfItd/Q5ofe2E8v02vESW4I1HtItddnLD/dz1sib1LlX6PhgQjS4ko1vUsUD1GZhYTG0r0VaFGaQlBNl4gMST+r4b1cjouFSTK9zLZd36jM/pl7y0DtVD/L2QbaQvK/Qcl6Cdd2Uprk0Pypdx6k9Mx2NHVUC1HLMxBN0IfBpQSemnEj3SLTSXcApJ6Tj9f+Hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiheTwDbW4aWnhWzgSktMoFMsZNr/lKkt/FUnOoECtY=;
 b=XNTtzGHshIAJM1XjtKvKGrqUu1YzCos4tXYhwTMVDiW7yRr0LckO1J/ruYl5Iy9Uiri1Zy/veQev1T08h1BihZ6H4n1ZpjBXG//GwmL2B94twCmYBnG/6GsbZBuXIX9LvruBuhGkOmSL0xjD/mDy36ygUH1hWL4Pn6hbfveucKRzTfZFuLQwpUPuXiTse8JOOOJzLkI24fJqTeIKcIhMH7Wa82JwtNwRGhiUpyY9FUq95UWafYWJPeaYSHEy+1/G6mTd8jjBxiHMKY0pDUuLLntVIciDiTEj8r2KEw1/lUQk3tpkutGdnYh7zrkYQEm/fuviHBp6pTCyNIfiKnw7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:24 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:26 +0000
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
Subject: [PATCH net-next v2 0/9] selftests: drivers: bash support for remote traffic generators
Date: Thu, 12 Mar 2026 16:17:31 +0200
Message-Id: <20260312141740.295353-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d9cf42-50c9-479c-3bdd-08de804239c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+c+CC0I9CfhT3dul5rBA/VZqj7PaA2/Ir5uniM7L5NKSLXD7arpUCX+YkTlooGRFwIlMZH0GiEw0bYIFlg64DSpdctjUFVXMzjihrsRYasp15ZhVbro9SDKZLmwCcM1xVf8MHUJxkwsp41VcHidYBdJrN4VQklhOibDd3sOn5POszoQXPhgpyfLn7xhcxDw+ORJGVgl8/HDlwTyT7XoHl/5PUNQQyUJ/U99PiwklTw9hP0rPri4xakAQvB/k4kIsocVFEffmwHeWDkg6aqKWgM9Lv1gLlNhM9rWCGPKdvtH+LDoNnSxHta2azdW2wb/K/zv6YOarMJE5SKaEZDVfmudKFj4VjHs+btUIaGLV2RUEfH5RDOvgDSOY4q6kRQsd2JmB7SXqW7O2vEOPs2PgT9RQ/nTFPPEXvPPAwC98bgIa9FeNtuEn7WFSd8Fn03mv7gpH6wiAPFgrBY9WkIUEmaP1/cPsWOAoukyLJz0/Nc3v2u2eoGZ5qNAmfLzQL1WcpF2CABCxj14JPdXMhicst6h/1WLL+HBdZlGtDnoRuauvzUeN0IG/MyGCQy15Ear51lAQXT5Kg5JGpHpIFvFvPZXVW9utI3pxINAFnbmVts7mIvsLIBQvJcRDFg4hThjBQ8i1e5CSxGbUnnTD718xs3umOc+scoaQCG/92mvebEqYQxwOy4hxjMZ5qnA5+IL0lbQgD9otMOQYpAXb01EJoMGgIXqvPN8RWqwJcpUpniDgs8F6y2r8u8gxN/W4JS/8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TO9Pn8Dmyv5EcHOYq+zBndDmCysaPARZCtOcpaUwff+OLMGRm+MvYtdujvGQ?=
 =?us-ascii?Q?kIPRuQY2n1T3w2lvGbI/WAVl+QDhULi/ntic1+A16DCJ1uuWrLgwSc5HuGUz?=
 =?us-ascii?Q?FDcqAoYoikB40nbJOSKAAiLZurMrCHWqDIeRbm74egtcfWyh5AQsi2gspydK?=
 =?us-ascii?Q?BQ8fjGLoK+pruAda8axM6azd3coo2ItMdAwgDcFhWe/wBwO0ilSvsDDQfn7H?=
 =?us-ascii?Q?NZNL6e+D2jJ2gRzYgzYJ8DtH78S7TPCvfdp9zKxbFeeWk5zwkt4wJCgZ9foB?=
 =?us-ascii?Q?xfiyjIdgdZA2xUJw0c/zo7LsRXOqrKx5H16HghjzPQr69ybnPtq/pgG6iwAp?=
 =?us-ascii?Q?qkrQl9JY2echxceXb6s/l74TjsyrH5aKIsWkBkd6WLo0ataUo9LmTElmMViu?=
 =?us-ascii?Q?0a0pBsU+tRthj1QhiSbzZlFAVpjTLZ8W/dh9gRonswmEcLy4z1Z97yqhbPCR?=
 =?us-ascii?Q?y3PeOWAAkN/R7BVMhF/zpEZXK8w9xTM7qklzfXr7UQoe071v3zeA5JTiVdfV?=
 =?us-ascii?Q?oOQ31EqabfNim3KzDKJJQmB6xs6Z4jVNv6DLf+fd/FBWfwKzCt33S5yClsEs?=
 =?us-ascii?Q?55vF3gmz/Wbjy+OdjGc2yE/iJ9QNq5UTTgHXzWfwXz6zdoCJgPES55IOYtl4?=
 =?us-ascii?Q?xwb26v0yTVis2b2FuzEwkocaY9GcuFbe/JQJRgTgNb84YDuHlJlrj80eWJAd?=
 =?us-ascii?Q?1C94pvn/Yiw5MTK8cK4owyAhn7Bs21V6KcnLKw5+hikW9LV3t2soNZjKUV0b?=
 =?us-ascii?Q?VkLmrxc1cObQR5eA/9/Sg+Ppn0QZjRojxR10kfPC7x7YAI9IIdz6JGowR73t?=
 =?us-ascii?Q?BvgszB+RAVou5pYdHJEKDwB5RM5/lvbimCN08drPldv/jgBg2n6boCRToWa5?=
 =?us-ascii?Q?HKoki6sxZM36y6EJRxgZXyXq+11bo6lvg/F6d/E8lDKTgsf8AmGM77h1Q185?=
 =?us-ascii?Q?JIC6aPAeJ4jAYbvAcexkhrDCLT0an89JhsmWJRvUMSOgO1qB8oJUU/20tcgB?=
 =?us-ascii?Q?K7q5Q/iKOPpRGTgEIMH/Kgs/ZgFws49vTHJoHXjGeEdos8EYbsp/5WO5Lk67?=
 =?us-ascii?Q?SemmbI5sG66vTzTMHbrVY31/uGJtQpahig+1b1lLlB0m5WAW8DmkPvop/kLL?=
 =?us-ascii?Q?4VczuN3c+5tWm4iL1MnNEyQJ3142Lwl5+zjASOtPOBDn5kiKZQ60n+l3T75F?=
 =?us-ascii?Q?YqGisbqwY+saVraMXxSfEzTW0V+Ip6xjR+ozq1A+ybKcJ4Ac+y9JxXGksE3i?=
 =?us-ascii?Q?1gaGFxhPw/XgpQA1FUnGqRtyzKRGITcm5zv/vhFBZ3fILPhSDeScfrzGylo6?=
 =?us-ascii?Q?MpYvBvJHuRnzHckt5YZNozW9IZV9fNY9oY4PcWgTCBvqKwG5RT54/drRIN+U?=
 =?us-ascii?Q?YsvoswXEFo/nIullI5LRFlIohiNkObpkemy6389V8cGRbbYYqC+uivhIZPBN?=
 =?us-ascii?Q?SmDdbP4w7CiK47uaZvvn4SyS/1VwndBdpl/2Rp3EEevlVAD4B7FNEtWlx7Fa?=
 =?us-ascii?Q?QgVLZoE09J1Ay75BbZXHM7/MUGTzid7GXJPci9LRfdsr25WNrFfIERB2MJbF?=
 =?us-ascii?Q?mY5URjSWMezc0cOb5VaVBRtMs+b0bCD47SgE2PFy0jGbsoTa/B8222zxYcT5?=
 =?us-ascii?Q?QAWtAtv0XlCjyP/3KkH71+WiViSpP1FlHAsvrXN4my3K/Yde0OlaDVepoajo?=
 =?us-ascii?Q?fm+BiJ6IVs2PaMkpUsK501dx7/9xR6ZByQ6ImuC0UBwZNaprQk+KS26iTlBz?=
 =?us-ascii?Q?ISNvgbV+3A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d9cf42-50c9-479c-3bdd-08de804239c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:26.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJmKXVbUlK82ZmuMcEdBD+/jMvf+2+OQIZWhCq8ihrJ/slncKxLKod4sKYZ6gniPyqypCS48uPIbGwaD49mROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267083-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,run_kselftest.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid,ethtool_std_stats.sh:url]
X-Rspamd-Queue-Id: 3CB5A27331C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set aims to add the necessary support so that bash written
selftests are also able to easily run with a remote traffic generator
system, either be it in another netns or one accessible through ssh.

This patch set is a result of the discussion from v1:
https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
Even though the python infrastructure is already established, some
things are easier in bash and it would be a shame to leave behind the
bash tests that we already have. Version 1 of this patch set also had
patches exporting standard statistics in the dpaa2 drivers. Those
patches will be submitted separately so that they do not depend on this
set.

This support is based on the requirements described in the
tools/testing/selftests/drivers/net/README.rst file.

Mainly, the drivers/net selftests should be able to run on a interface
specified through the NETIF env variable. On top of that, variables such
as REMOTE_TYPE and REMOTE_ARGS define how the remote traffic generator
can be accessed. Patch 2/9 parses these env variables and constructs the
NETIFS array that bash tests are accustomed to. This is with the
intention of enabling already written tests to incur minimal changes.

The second patch also defines the TARGETS array which will hold the
necessary information about the target on which a specific interface
is located.

For example, a net.config which looks like below:
	NETIF=eth0
	LOCAL_V4=192.168.1.1
	REMOTE_V4=192.168.1.2
	REMOTE_TYPE=ssh
	REMOTE_ARGS=root@192.168.1.2

will generate the NETIFS and TARGETS arrays with the following data.

	NETIFS[p1]="eth0"
	NETIFS[p2]="eth2"

	TARGETS[eth0]="local:"
	TARGETS[eth2]="ssh:root@192.168.1.2"

The above will be true if on the remote target, the interface which has
the 192.168.1.2 address is named eth2.

The values held in the TARGETS array will be used by the new 'run_on'
helper added in patch 3/9 to know how to run a specific command, on the
local system, on another netns or by using ssh. Patch 4/9 updates some
helpers to use run_on so that, for example, lib.sh is able to ensure
stable MAC addresses even with the remote interface located in another
netns.

The next 4 patches, 4/9-8/9 update the ethtool_rmon.sh script so that it
can work with the kselftest infrastructure and the new
NETIF/REMOTE_TYPE etc way of working. Beside updating each ip link or
ethtool command to use the run_on helper, the patches also remove any
testing done on the remote interface.

The last patch adds a new test which checks the standard counters -
eth-ctrl, eth-mac and pause - and uses the new infrastructure put in
place by the first patches.

With this patch set, both tests can be run using a net.config file and
run_kselftest.sh as shown below.

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
 # TEST: rx-pkts64to64 on endpmac17                                    [ OK ]
 # TEST: rx-pkts65to127 on endpmac17                                   [ OK ]
 # TEST: rx-pkts128to255 on endpmac17                                  [ OK ]
 # TEST: rx-pkts256to511 on endpmac17                                  [ OK ]
 # TEST: rx-pkts512to1023 on endpmac17                                 [ OK ]
 # TEST: rx-pkts1024to1518 on endpmac17                                [ OK ]
 # TEST: rx-pkts1519to10240 on endpmac17                               [ OK ]
 # TEST: tx-pkts64to64 on endpmac17                                    [ OK ]
 # TEST: tx-pkts65to127 on endpmac17                                   [ OK ]
 # TEST: tx-pkts128to255 on endpmac17                                  [ OK ]
 # TEST: tx-pkts256to511 on endpmac17                                  [ OK ]
 # TEST: tx-pkts512to1023 on endpmac17                                 [ OK ]
 # TEST: tx-pkts1024to1518 on endpmac17                                [ OK ]
 # TEST: tx-pkts1519to10240 on endpmac17                               [ OK ]
 ok 1 selftests: drivers/net/hw: ethtool_rmon.sh

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_std_stats.sh
 # TEST: eth-ctrl-MACControlFramesTransmitted on endpmac17             [ OK ]
 # TEST: eth-ctrl-MACControlFramesReceived on endpmac17                [ OK ]
 # TEST: eth-mac-FrameCheckSequenceErrors on endpmac17                 [ OK ]
 # TEST: eth-mac-AlignmentErrors on endpmac17                          [ OK ]
 # TEST: eth-mac-FramesLostDueToIntMACXmitError on endpmac17           [ OK ]
 # TEST: eth-mac-CarrierSenseErrors on endpmac17 (not supported)       [SKIP]
 # TEST: eth-mac-FramesLostDueToIntMACRcvError on endpmac17            [ OK ]
 # TEST: eth-mac-InRangeLengthErrors on endpmac17 (not supported)      [SKIP]
 # TEST: eth-mac-OutOfRangeLengthField on endpmac17 (not supported)    [SKIP]
 # TEST: eth-mac-FrameTooLongErrors on endpmac17 (not supported)       [SKIP]
 # TEST: eth-mac-FramesAbortedDueToXSColls on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-SingleCollisionFrames on endpmac17 (not supported)    [SKIP]
 # TEST: eth-mac-MultipleCollisionFrames on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-FramesWithDeferredXmissions on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-LateCollisions on endpmac17 (not supported)           [SKIP]
 # TEST: eth-mac-FramesWithExcessiveDeferral on endpmac17 (not supported)  [SKIP]
 # TEST: eth-mac-BroadcastFramesXmittedOK on endpmac17                 [ OK ]
 # TEST: eth-mac-OctetsTransmittedOK on endpmac17                      [ OK ]
 # TEST: eth-mac-BroadcastFramesReceivedOK on endpmac17                [ OK ]
 # TEST: eth-mac-OctetsReceivedOK on endpmac17                         [ OK ]
 # TEST: eth-mac-FramesTransmittedOK on endpmac17                      [ OK ]
 # TEST: eth-mac-MulticastFramesXmittedOK on endpmac17                 [ OK ]
 # TEST: eth-mac-FramesReceivedOK on endpmac17                         [ OK ]
 # TEST: eth-mac-MulticastFramesReceivedOK on endpmac17                [ OK ]
 # TEST: pause-tx_pause_frames on endpmac17                            [ OK ]
 # TEST: pause-rx_pause_frames on endpmac17                            [ OK ]
 ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh # SKIP

Changes in v2:
- 1/9: Convert jq to the --arg usage form
- Patches 2/9-8/9 are new in this version
- 9/9: Use the new run_on helper
- 9/9: No longer checking that each counter has a 1% tolerance against the
  target. The only upper limit is UINT32_MAX.
- 9/9: Check that both the error counters and the collision related ones are
  zero since this is the most probable scenario (we don't expect errors
  with the traffic that we are sending).
- 9/9: Removed any checks performed on the remot interface counters since
  that is being used only as a traffic generator.

Ioana Ciornei (9):
  selftests: forwarding: extend ethtool_std_stats_get with pause
    statistics
  selftests: net: extend lib.sh to parse drivers/net/net.config
  selftests: net: add helpers for running a command on other targets
  selftests: net: update some helpers to use run_on
  selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
  selftests: drivers: hw: test rmon counters only on first interface
  selftests: drivers: hw: replace counter upper limit with UINT32_MAX in
    rmon test
  selftests: drivers: hw: update ethtool_rmon to work with a single
    local interface
  selftests: drivers: hw: add test for the ethtool standard counters

 .../testing/selftests/drivers/net/README.rst  |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/ethtool_rmon.sh  |  55 +++---
 .../drivers/net/hw/ethtool_std_stats.sh       | 187 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 138 +++++++++++--
 tools/testing/selftests/net/lib.sh            |  39 +++-
 6 files changed, 379 insertions(+), 44 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

-- 
2.25.1


