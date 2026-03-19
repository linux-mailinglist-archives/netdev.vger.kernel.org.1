Return-Path: <netdev+bounces-269524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC/hNNQgvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:14:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 740032CE897
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3622B304612A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E43EB816;
	Thu, 19 Mar 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKf/61Ne"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B93EAC83;
	Thu, 19 Mar 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936269; cv=fail; b=E6hUZ2WCaxkfEVU0Ws1yBsB0lrKtsrCBs6ZjqSbk2ruZNB7/5u2H7lwlHO1Kvc3lV+pMAB2Slpva6AS+tuOlKSltEFDzcM2BGvnlyvWGtKeoUtq7r30sGZH4KqeemKRBvSEO06Rr7WvwA3xOCuBupy2fRWWttM6UrvFDUJrqr84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936269; c=relaxed/simple;
	bh=f8mZXdJjMm4VAdfGkbLsztIxSPFGmr8vt4q7ZIPwcxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRi3y8EKaqpzNim8UsAzE5YjVv7rsnMv6YhmvznYrAkX6TwPOtT6bKaDnhvcXDXGkj+0pKHCePPBfnO96s+rKXHzC1IRIT9mY/4oNGhR1OZzZz3bl8D02uHWciVDU8w+0xtvIN0/fRZCE0qLkhGlbjk9U6Y8Nctmc+DTr17qLSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aKf/61Ne; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH+y+f0sBEhyMot1apwistIz1TKdPQ5LHLS50mPDZ7FX/fFVG7m/44RiJut2rX3lK36JeoU8e3FEQmNU+r6sr/+o54ju2GHCLeueovKEMla3CWt+Ls9TOH76UFe50EPNc1hSh9UxHfb6sLxFYZK4y9SMRU8JVjUvE3cmquGT/mIqZgyILEVM49v1y/tZ0Arewjf68Y9G2K0FVskB5RyJGX8dIIpB1RrRYZDRGiwn3E2Pa75N/ekE6hNl4Wvi80B3UWBaqZ+smrDY61eQGok8Fpz/zEqdCjvTRxn/bWwjVLaPjxA/aJbiFHpGYEM0M/0n163kqav6g7wXvGdSn7toDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA1a565/id/3DHc5YnZgjQcKrr0F/1Z+cZoFvp3doHQ=;
 b=sHaFTaC2FnWA0VTFHialoPDJByRO9OkXC5ZXyb4GOwgBE/ern/DN+TxGNB0dIqdw9u1+hGR6MLj4t3FSBo1YrcOO+VWyY8WThoRrs/uju0L4Uv/Zzo/Rsm11Js1Z8BSQlK7JpQ5iavonXGNiJ9YQ8xPnI3+ic2lWcDAvYLibMkgbwQtHcgSPgTI5kBiBqobjydZrHrxwVqyghDrBBDOe+OurkXxskJYhy7T1H/LCBJgceYGVzbfKuTEVOtTpDVYejEMcPvDr/z8Dfzd4E6YDKlqlq9/75+RxPPip77hazY/I+uZAUM46XPFq/aD2aUr1vklId+yHCgHWjo40hYFcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA1a565/id/3DHc5YnZgjQcKrr0F/1Z+cZoFvp3doHQ=;
 b=aKf/61NeMkF4629uiVdVnFSfZtVsBdw9t5U5xUla4qwLrY+YQuJCHv4jiCpEEbsxLAK01hwDHNZN4bCfPp+Jj6BKLwhw5FNmWz8mbVU9BUBi9VViYiUVdBOtGbb0ZMIDL3mxCAokdhWiOm5GcL31+eZPjklZnXCQIQZcxOoAf3EIRFvrUJIAJu37fGb4EIHeK8JXD8wc1/Rkimu9XoRHPoon0th7/7pSJbLnj0vjNK+n7bgIXIr/PwnZNu+TJIHg9BH3XObNYEDXHXQY3hIWNKN/akrjZThycTe9xEgF2TT2Kt+57AWS5PpOzDrBlqKoWZLCJr6Fv0mzD7GdPZUeJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:13 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:24 +0000
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
Subject: [PATCH net-next v3 3/9] selftests: net: extend lib.sh to parse drivers/net/net.config
Date: Thu, 19 Mar 2026 18:04:04 +0200
Message-Id: <20260319160410.2515105-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: a22c38e1-8ffe-460d-2490-08de85d1307a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tN4HxcfB7UVkHQWqxnFOAFYzTqhl8V95xM3cjRNkQ7PZkQhFYxS7hpm73/QKR3F3VlpoaeQf65g9xUdn43YdKFqtrMNLuQAIV7sxFgnXhtJg5GSlNKZsQid9PIY8Tn/cJF56hWGAVo5jNnIK5xK2aLFa4jA1eweUHP9wphIdMY2WJbDO3bv+konnm4i5FdXeqZqE/byHkdAgOEcARKjb3wKKiduV/PmbUmYDRKutlOsGg73F7K4jxZDEJqBl6mExHIAhZWLNNdnw0yupSv50eKEXyaGFjcW7p/mmabnTjHrdA0zHeRfdpIkTvE8QzdOJv3GLu//jezJ+YINmxd3tzrk1JlhvY4Ph4WkTxFzfmdCFlLCh/+nMN1+CoCmDG9s/pxt++VQ9Z0jvFM+lLOy/JfI4RiOzJ93CtKYb5LOuDOnLmwqsC6EIKB0huViDwPs9em9LKi8feHBQ5AlavkvkQr4HWtyT/Sp9c/PES/+NDfLQpItZGxjElf0qQgEhpiNga18qNUFQ4zcmUqZjnY2Z8JevbPF/g3wM71oY3YS2d76GwRuekCK6P0D8UMMDoW67b3w8RF34AZ/syeK8m7CJZl9PTcSrlyP/6yWGY9GINEV23zzcdHW2RNsrKedO8IScOYk+i2Mh8N9Ek09idv9PiNGMu7Y6fwBiUidmR+KQM5OS3pG03VfJ6zktJC/IKRag4+I7ggyXGN9SLnNlUewFmyk+QNrut7z5vjLg1az9b+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1oOv0TizDL35HNFj8F4o5PRy8BV1LGuinEbX5H8f8Q5Jcc+UKm8X3Wfx4iB?=
 =?us-ascii?Q?86MN6wGos50nrnjipLccZD/EwNpVqLDiH1SYG2R8Wt/+ZhRSsz1k/3qkUtxe?=
 =?us-ascii?Q?+xPAM76eRCq8CBBIokdPasfie3+BUcW7uEIAp2nVlkGbcs92gOzhov64KY5i?=
 =?us-ascii?Q?OKHpCcz6T/+Nt3tmVWsYLZpzA2P6TrHTfXmySEyNL1gATa1duk6UUoTNBvBd?=
 =?us-ascii?Q?Ga5YdmehRTGY0aeiDm+adsT0tlO76oKV5WyW2Su7VPlpP3YYrOtMRRkxvXYZ?=
 =?us-ascii?Q?Sxx8RZF5DOWAfs31kMI1qv1JTeHYUjFcZbX0Dq46xKH7476HTGTAWf9xeqvy?=
 =?us-ascii?Q?P8EAcbCtxcJd9s8kLcyqV+iRhqioLRv0DlJ1c4ltRZRd+rOJ+ueoJOdFnxSQ?=
 =?us-ascii?Q?oS0rI6srF7unm16eAKnwSTWHCZol1kEQIxvyu1P51S3Mb0oBQFtV6No6tNUm?=
 =?us-ascii?Q?LPqYM6lTb6o8HyiExuMvcm+L4Wv1ir2hKiTTEIu5dj0LVscQFL0zR4BBUlNw?=
 =?us-ascii?Q?/Eb89GSXrtOas2dmwhROa63KWtoLxlCxR/uCsEJRdbnOFveSRCJjkouzMCai?=
 =?us-ascii?Q?C/Lnet00KT/aqgjZ/jGnpSpO1Wx6tNZIMvCDCNtd0GhpmYwkTDx1frfyxwWF?=
 =?us-ascii?Q?+201bBUoMRr107aZkxfCrA8ZjXQ1maBPrwojss0HCxSqWzlJZEVJTonUWgQV?=
 =?us-ascii?Q?f/eMySJO3vhNIffvo9x/9/ilZViM+RyPZRgrEkEqWVjwShdeGwQiDwubH8Pm?=
 =?us-ascii?Q?28qJLTsmaky3Kn7IsoJfJosuftZbt/ni3iNV51T61HcMqKnWxIthc8Vqxlyg?=
 =?us-ascii?Q?OblcH/iiP767YekS6CDdXHvHnHyJmYZ6Frfc8rLPKhJdVDsRG4vY/wAkjxKM?=
 =?us-ascii?Q?qtODFATr0yrxmK41VLfQypalgTZd+HD/wZsj4yhktVE+PPfvhIk7bRIQihtz?=
 =?us-ascii?Q?ykUDd9STJ7OOdMOO1Kz7OyKj4buxOAFOsa/qvtcYJ7YwQ3y90vH34IjIF41+?=
 =?us-ascii?Q?8xKw0c5BWu9Yjz59Xh5kiJXffLzM/kTKPUu2KiPkdD7k6KWIZpXvIMecU/lc?=
 =?us-ascii?Q?XPE9AD5ftzp8eyELvemkQgyd8wTkaIG5gn2At7J4g4laoX8DoOwmxYsl42EM?=
 =?us-ascii?Q?MSzlnK5HDFbTA5PA4HVxRbQQ5faS4fOmM0ZRbXWj9ePgLzRgSSghXAuEbPtI?=
 =?us-ascii?Q?5owMOmai22Me3T1ibru2KBoBAkXBoqBLHfmdudqy8Wf3MBq7H+nAbYiNsJdp?=
 =?us-ascii?Q?W3S1E7/ZcQLRujGSpkpmEbIriALs38I4tHVys0Jxpzo62CC0p7bwJJ+8jOsM?=
 =?us-ascii?Q?5q4lm91gNdo7LS2cPHQyH5AZHLo6t0gLwssqwATXkCIOCYHsxuP9aREpEH6b?=
 =?us-ascii?Q?9RIHkgxPUKZV0mg4PjNOMTZL5vfEX1u7wuw8JSJdbwKcRb/Zi6Ji6v06Ela/?=
 =?us-ascii?Q?GYiJ5AwYqQAM8eGfJIKahtLyIblZoleUDgV+/7l2ufSTVT7QGiOuW1ony1Ie?=
 =?us-ascii?Q?T9eHY+1VpAGeRvTbP4sq1H/gHZPzMtp4NnS/Y4tEYGUwMJ3LhwVUJlrwt8hI?=
 =?us-ascii?Q?IuK0BFDMsSCfX7sxVUvA/ZXQxV6MMwBeOUUjY4njZVnqV0kF93YJ1zxV3DBu?=
 =?us-ascii?Q?DrqQZLrHj3V8qkWiJfNKgwLvmGqiaXMqyxykLvSspatZl1HK5K+Xuz38J7in?=
 =?us-ascii?Q?4oDjYlMYjl509yyxQ+RAc/y4bICJ54AkEGb/RPalhg+4ZVxQX2QcFMZxVQiv?=
 =?us-ascii?Q?RByufK0oTw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22c38e1-8ffe-460d-2490-08de85d1307a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:24.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kugp5gfZ4qQbB3PcxyeEufqHSBq1mnOKrow8phHqwGX91NOAKfoqNE8pWirA7KGZAQU9zjl37jYqKsPLlfEZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
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
	TAGGED_FROM(0.00)[bounces-269524-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 740032CE897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend lib.sh so that it's able to parse driver/net/net.config and
environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
in drivers/net/README.rst.

In order to make the transition towards running with a single local
interface smoother for the bash networking driver tests, beside sourcing
the net.config file also translate the new env variables into the old
style based on the NETIFS array. Since the NETIFS array only holds the
network interface names, also add a new array - TARGETS - which keeps
track of the target on which a specific interfaces resides - local,
netns or accesible through an ssh command.

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

Since the TARGETS array is indexed by the network interface name,
document a new restriction README.rst which states that the remote
interface cannot have the same name as the local one.

Also keep the old way of populating the NETIFS variable based on the
command line arguments. This will be invoked in case NETIF is not
defined.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- s/TARGET/CUR_TARGET
- this used to be patch #2/9 in v2. Swapped the two patches so that the
  run_cmd used in this patch is defined earlier, not later.
Changes in v2:
- patch is new

 .../testing/selftests/drivers/net/README.rst  |   3 +
 tools/testing/selftests/net/forwarding/lib.sh | 130 ++++++++++++++++--
 2 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index c94992acf10b..8d8d9d62e763 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -26,6 +26,9 @@ The netdevice against which tests will be run must exist, be running
 Refer to list of :ref:`Variables` later in this file to set up running
 the tests against a real device.
 
+Also, make sure that if you are using a remote machine for traffic injection,
+the local and remote interfaces have different names.
+
 Both modes required
 ~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cf40cb766c68..fb5aa56343e1 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -3,6 +3,7 @@
 
 ##############################################################################
 # Topology description. p1 looped back to p2, p3 to p4 and so on.
+#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
 
 declare -A NETIFS=(
     [p1]=veth0
@@ -17,6 +18,26 @@ declare -A NETIFS=(
     [p10]=veth9
 )
 
+# Array indexed by the network interface name keeping track of the target on
+# which the interface resides. Values will be strings of the following format -
+# <type>:<args>.
+# TARGETS[eth0]="local:" - meaning that the eth0 interface is accessible locally
+# TARGETS[eth1]="netns:foo" - eth1 is in the foo netns
+# TARGETS[eth2]="ssh:root@10.0.0.2" - eth2 is accessible through running the
+# 'ssh root@10.0.0.2' command.
+declare -A TARGETS=(
+    [veth0]="local:"
+    [veth1]="local:"
+    [veth2]="local:"
+    [veth3]="local:"
+    [veth4]="local:"
+    [veth5]="local:"
+    [veth6]="local:"
+    [veth7]="local:"
+    [veth8]="local:"
+    [veth9]="local:"
+)
+
 # Port that does not have a cable connected.
 : "${NETIF_NO_CABLE:=eth8}"
 
@@ -340,17 +361,108 @@ fi
 ##############################################################################
 # Command line options handling
 
-count=0
+check_env() {
+	local vars_needed=("LOCAL_V4,LOCAL_V6"
+			   "REMOTE_V4,REMOTE_V6"
+			   "REMOTE_TYPE"
+			   "REMOTE_ARGS")
+	local missing=()
+	local choice
+
+	# If a choice has multiple comma separated options, at least one must
+	# exist
+	for choice in "${vars_needed[@]}"; do
+		IFS=',' read -ra entries <<< "$choice"
+
+		local found=0
+		for entry in "${entries[@]}"; do
+			if [[ -n "${!entry}" ]]; then
+				found=1
+				break
+			fi
+		done
 
-while [[ $# -gt 0 ]]; do
-	if [[ "$count" -eq "0" ]]; then
-		unset NETIFS
-		declare -A NETIFS
+		if [[ $found -eq 0 ]]; then
+			missing+=("$choice")
+		fi
+	done
+
+	# Make sure v4 / v6 configs are symmetric
+	if [[ (-n "${LOCAL_V6}" && -z "${REMOTE_V6}") || \
+	      (-z "${LOCAL_V6}" && -n "${REMOTE_V6}") ]]; then
+		missing+=("LOCAL_V6,REMOTE_V6")
 	fi
-	count=$((count + 1))
-	NETIFS[p$count]="$1"
-	shift
-done
+
+	if [[ (-n "${LOCAL_V4}" && -z "${REMOTE_V4}") || \
+	      (-z "${LOCAL_V4}" && -n "${REMOTE_V4}") ]]; then
+		missing+=("LOCAL_V4,REMOTE_V4")
+	fi
+
+	if [[ ${#missing[@]} -gt 0 ]]; then
+		echo "SKIP: Invalid environment, missing configuration: ${missing[*]}"
+		echo "Please see tools/testing/selftests/drivers/net/README.rst"
+		exit "$ksft_skip"
+	fi
+}
+
+get_ifname_by_ip()
+{
+	local ip_addr=$1; shift
+
+	run_cmd ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
+}
+
+# If there is a configuration file, source it
+if [[ -f $net_forwarding_dir/../../drivers/net/net.config ]]; then
+	source "$net_forwarding_dir/../../drivers/net/net.config"
+fi
+
+# In case NETIF is specified, then the test expects to pass the arguments
+# through the variables specified in drivers/net/README.rst file. If not,
+# fallback on parsing the script arguments for interface names.
+if [[ -v NETIF ]]; then
+	if (( NUM_NETIFS > 2)); then
+		echo "SKIP: NETIF defined and NUM_NETIFS is bigger than 2"
+		exit "$ksft_skip"
+	fi
+
+	check_env
+
+	# Populate the NETIF and TARGETS arrays automatically based on the
+	# environment variables
+	unset NETIFS
+	declare -A NETIFS
+
+	NETIFS[p1]="$NETIF"
+	TARGETS[$NETIF]="local:"
+
+	# Locate the name of the remote interface
+	if [[ -v REMOTE_V4 ]]; then
+		remote_netif=$(CUR_TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V4")
+	else
+		remote_netif=$(CUR_TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V6")
+	fi
+	if [[ ! -n "$remote_netif" ]]; then
+		echo "SKIP: cannot find remote interface"
+		exit "$ksft_skip"
+	fi
+
+	NETIFS[p2]="$remote_netif"
+	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
+else
+	count=0
+
+	while [[ $# -gt 0 ]]; do
+		if [[ "$count" -eq "0" ]]; then
+			unset NETIFS
+			declare -A NETIFS
+		fi
+		count=$((count + 1))
+		NETIFS[p$count]="$1"
+		TARGETS[$1]="local:"
+		shift
+	done
+fi
 
 ##############################################################################
 # Network interfaces configuration
-- 
2.25.1


