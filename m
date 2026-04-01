Return-Path: <netdev+bounces-274203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF+iMqhVzWk5cAYAu9opvQ
	(envelope-from <netdev+bounces-274203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:28:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6399A37EA67
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F114C305BB86
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22347D956;
	Wed,  1 Apr 2026 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZqMHihu9"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBB47B439;
	Wed,  1 Apr 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064179; cv=fail; b=YAtzpgzJJfybRYMc9GKbgHgU8/N78enVm8P+sFCId7XzqjpL2CMy6A9XfPr7bMb24TqhLco/L2xCPl7vm6xDt32to/dDPb9IXf+i9i4hB4gznLGU//h97EvD2bOpARE1ahCEvCTjZ2Kyjuu7M8dN8605vXBdT6jAmLUPuNIQBUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064179; c=relaxed/simple;
	bh=NJfSMGmLf7S2//6YNOriCbqGKs8uZMAoaFQ8XrAa57w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UmFoZ4mVDKUXi7oOwW5DTy0UpcfDY6KU5U1erTsi5FR/+Tyy7XCYdm6fHeuWN7eIqLjNAQfxKA3z8EFerct3O91Tyx7dcz3H7srLtb93SVk3efYVYn4/id/n+ISWik/Uu5z2AF9NYrUwYbgzgJnX667XhBryca0lcNl5C1VrXNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZqMHihu9; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/NBDhUyyLcAyXLkmDHs6MpaRW0rxswwnjoVva7RTMnsFewWvF7IswZCg9S1Ni0M/a45sUcAZgWr88jz4Sl1P9JzCIBeByo2H0FoVMKtjImmRJ76tW9DkfK1pY5OQZcPwPZt+eLvgZKik5JxBqfjmPH1W0PcaEHLtunSX7t+QYHHYYp9AO3LcVt6uVKfi5DERw9PpfpUUckEfZlvys5gNxZ5iNFFUkHyD35HYBH251J+mlk69B5dBT++CH8W5frtgkKDGFZF4XvfRNnqiaTx+xW1lQD6DyY2/YDvg9V6ctgaEsRBaIJDKcQdpZYQ+wYOF+XUK+YScflBHThp+IYtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kxlgIkWOyfvxeHPyGqAipsBF5a1ef3DnXQcS63ijxA=;
 b=WlAgnf4LiyP97FG1/4ldFFhJzqRy/ZCDsbYprKzz0PSOQ0cytOybp7uMJmT3SQc1aiRho0O9kVu/M8DdITuC5xZfPMT/AiygzkvlVuMKZe5Yp7nOQfCm9pAyrG3FpuImeLbVuDTu5stN3R3EIdbGEuYyQ2dqpa4LT+Bnp850qBusQWjW6VZDx02VoO6ttHfkiMaWVsbib6oeri4cZ/o+XxmXSG3GduWx3adApTwHotjbTlG/2vkUR3vjUnUbEmhRoHdNzcX9FTn114qZIamD+oFN6LYfom547ua2XKqo8ib1KZvKB0sV1Z2l17BNoKqgOkBvCXGwxeJ8Wuuoah5sEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kxlgIkWOyfvxeHPyGqAipsBF5a1ef3DnXQcS63ijxA=;
 b=ZqMHihu9MAuXic0zWL897eQD/o0y1JizIwBtcUPDGXpVUj3p9jcWJ31xmWl4CQMhGUVc8lezsoAL2RRkTFl+H/eeLce/cjq46ZId25E3I6cvN/R01N/pxIci8JXN0+fE+m2EiXufEepAFH1pz2gMGMnYusNymcLpTq3I0dIhUGT+jLEZw6MprfO5eoQdmNU9v0nFIcKVqEeOPYkJjcoi3ZFKjk1nHoQawqtVL8zpxzKDuIG7ZuH+do+iYf29sMZR4AFQvQVXLaoTee7vF92Ys48EWYywRgMwnXB2Qh+m+2JxSYd2mvlusbwsbFHQ3sxJfZLkme4T3WnpeJvz5v+i7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:22:55 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 17:22:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: enetc: fix bogus TX ring consumer index after reinitialization
Date: Wed,  1 Apr 2026 20:22:44 +0300
Message-ID: <20260401172246.1075883-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
References: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 64415459-fb2a-4bf6-8671-08de90134fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|19092799006|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dqK4trx/RwNx8L0JEs9H7pAZ0wYDBIOV7tezASsjrb17cm7fuIjdeF0a9Z4xuRBtv02ro8k7cTbm13fVMRWk56nJ/py9lu4pD/fzBhqphj1KuOvGOBE+Zs5YTP3vSWLYv7KOBxmH5ZFdM4Nd7yXwmvhY2S4DFkr23Y1IzVo8igUQct98Flnd6zSDr+dvOrRB2zdbnGW4SixfSs6LtzLzP/zVx+0gLHd1NDezIjJnxwRre9uMTqH1ESbP+VX8Q5c2mSSJ9nPwANMTrrefQ71ZK8QZTh/4EIDz6s6oy0tIqyoPWHTBPxUlB5ObS/O0JQcQZ0PEyflHQlSpjwziomi8ID8trMG8vU1xdYTPyHoWxKqJTDSBDkFAe/YhAVxJ1UTqXkOWNCksrW6QC6LtB+O8BvrZ527uz4vvxg2sySRSJSE2cRw1wLADKEmaAbTEGk7CzYIjFXSZbS25K8CyZCZFSyPHQZiv2zAaY02rX57tuJHthHdmY4Z86xnUKT/JzTsSTxL/qnKNt2R7ZYNmcrv4KWi4ME2OyzskIYIm8JNLjqFrz7TB573W8SEVV5CnEbAkFsALZ0fKG1cgTX1CbnapOkfzYdjFE8fmoewBIK1rZ2ubJCUKkDAsaxMxuAmKuiVpkZzk5nm/SbPi7TNLZ9zOHsJurlm3Rz0hyG+ZlcYetcOapmmTC/FylKj0DNqnV4ymoIGVFcHyJWWHgExb7qe5vF6gDvr7tb+xE9F1NI0qQ1M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(19092799006)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2VXdOxmQ8Jh1GRMTmq+9MH6YviJ9yUMHifrxgS/++yAiXUkBXC6lPFEBJzX4?=
 =?us-ascii?Q?QA0bv+8izO7zpdlDSi6lhIC+0Cg6LuHdc8rm1EpICamcfdTy78gU0pPUcYII?=
 =?us-ascii?Q?CpUGKe9wo5Wo7lVZkWHyi+0lPVyOl/lfw4opzftzrqWUIcEz14nSfI9r1BWB?=
 =?us-ascii?Q?CouXOSmUNKf8KGrRRU1FGC2QbZHTgSTAJkHObbXGJ4vw2TzHB/VbwerDvzfZ?=
 =?us-ascii?Q?dDFcc9Y6H0TeJpdk1qBSnp4Uwkvayd47J+L9DU60mSSSsc8rhYk5sDWSIP1w?=
 =?us-ascii?Q?cDe2z6uxUninbYouE3P2S3KsTLFsObRD9fgOSWa5Jot/17QCymc+0N9mL9aR?=
 =?us-ascii?Q?PFmyJihfp1SnAGcWXKs1O4yNbZUCj/JD/57Xh3WNQVlDCMGZkBHg51WsvEO4?=
 =?us-ascii?Q?zN2Xlt24p7jbx53x9ZHxTphm/BGZJnEKFba3avrIS9ELsPBjZU4vGq+GeEi0?=
 =?us-ascii?Q?1l46EvDZ+u5vLHBe6WxbJFjzhxOYtQpY//dRlRDuLb8XscNmPb4vzT6vDRtv?=
 =?us-ascii?Q?UQ8b7j/oeuaCkjqcZh0FeoWnEwmtL3TcEIl6sebWUA13jYb9Ozghjcy2Ip2e?=
 =?us-ascii?Q?4TkHNp/uZy15R/a+EyoL6uItKr6RL7O5BzWry1CsP73uMdfWbHi9zTaMUVqp?=
 =?us-ascii?Q?vAUw2/Jf38iEgyI/wlJSfNW6a8YoWwoPAiBnQVsPxVD9UdKeBv0duxLKkWMK?=
 =?us-ascii?Q?5w1wfi+cXIvPZOSNAydR7kAgwu/kuMCu9lShhTjEA+ZQckxawocvDDrjTepo?=
 =?us-ascii?Q?DWOVE+oi7c0hMYu9qHxTbJRelS5yGoIKMZESbCTyHqarYl1MTw1jRCCEN6RR?=
 =?us-ascii?Q?f9lNUAwOkqwmgKbEYfTcbKnjQQIE6z90mXfExQn7PYqkNISpPS77i6oHacyf?=
 =?us-ascii?Q?TAhXQXElvLQA52VdOrsrc12EA6y49V752QRkLoDTe+TSmevBTuUWqeSEfTaw?=
 =?us-ascii?Q?jrk/TpYGenDMR8xZ1hLT313BZwf+mHg/7oM/AWMYtvF7dhammzsSzK6M1Tbr?=
 =?us-ascii?Q?pjgEhaTqo2yQwSqHT5b7aZKWbeXyCOdoZ9+aYQlV3tZeF9gLZgUURMdi0OWy?=
 =?us-ascii?Q?5V2uy+fnPb7qgDf/gly8uqa4WN7U1EGc/2tB13DqFAS4Sa15yISUiQFACQDZ?=
 =?us-ascii?Q?hFiObLeckEi9vk9zcsDD1EZiB6SZwKLvnO0yPJw6rFUmxAio8qzdWd6las5t?=
 =?us-ascii?Q?OaOdFutbv1Nu9WybPeXamJesa7y62eBDLmo6XzEMcU/6IdzUTwi7Zklc9PhI?=
 =?us-ascii?Q?OAOGllhLFPQyM3bppYh2hDfhR5EqCjHsGgd3+2KmMNWIsg1gfJdYumnOTegR?=
 =?us-ascii?Q?3lnrOjF9vxAUiTzFBnhf04LDNP9h4A2D9LlQhjvGAWililm5/idK8vLD0C1u?=
 =?us-ascii?Q?e4L59BIqayVWX5e4ArsP/pHwG2cT9xqO5EvQWuXlYNw+4x+n5KNY4MasnXJZ?=
 =?us-ascii?Q?Y+n8QG+5jWNBHvjWYxWpmoyRakB7O7UH2KWmNdMCnx5v1S53Vf/g4Fo2TS5Y?=
 =?us-ascii?Q?oQksh9MmQUxLUlxEvRlS9fD4gAOQCMOodv774xLqQdEdRu0ScfSd4xA4V5jp?=
 =?us-ascii?Q?LQxHSaTJ/TE3VqcbcWFU3beYA4GeTeHkiY646QKCLZrzB+pU7ICVjchKyMEC?=
 =?us-ascii?Q?SOZPLs2vXiSzNKPrLxx0ul3f5o2m9RblAFWXgupoFWNDdgIvBVol1xqOzrt9?=
 =?us-ascii?Q?8bPOTjFySGnT6pyNvmbTzQHkfmWcve8UpsDwZqpKcnvDF1+r4yidcf0GwsOQ?=
 =?us-ascii?Q?dLpfnr0hpDnbjDzWCQmHfb5BHnsj671Rh2FFP02FpXFBvhbR7TDudEc9bq7S?=
X-MS-Exchange-AntiSpam-MessageData-1: zbH57dr8xz7d7qspab9TZxL0JO0yhP4bBq8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64415459-fb2a-4bf6-8671-08de90134fa5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:22:55.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhywdDGfNRjWn/MeU3Oqthazr1ptK+l0N6gUQoXmYPkrrO8hlGT+CwWMFt6qvgr9tfums4hCaGo/vQO8Rco3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274203-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6399A37EA67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TBCIR (Transmit Buffer Descriptor Ring Consumer Index) register has
the BD index as the lower 16 bits, but the upper 16 bits contain this
field:

  STAT_ID: Status identifier. Incremented each time the BDR_INDEX is
  updated and an error status bit was set for one of the processed BDs.
  Clears on read.

If there was any transmit error prior to the ring reinitialization and
this is the first time we re-read the TBCIR register, reading it will
give us a value with non-zero upper bits, which is saved in
bdr->next_to_clean.

If subsequently NAPI gets invoked and enetc_clean_tx_ring() runs, this
will dereference the &tx_ring->tx_swbd[] for the bogus (and huge)
next_to_clean index, and will result in an out-of-bounds memory access.

Other places like enetc_bd_ready_count() do mask out the upper bits, so
let's do that here as well.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a146ceaf2ed6..c9cdf9d11212 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2593,7 +2593,8 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 
 	/* clearing PI/CI registers for Tx not supported, adjust sw indexes */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
-	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
+	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR) &
+				 ENETC_TBCIR_IDX_MASK;
 
 	/* enable Tx ints by setting pkt thr to 1 */
 	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
-- 
2.43.0


