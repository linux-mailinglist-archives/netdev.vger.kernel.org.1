Return-Path: <netdev+bounces-307342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MMxMAGOhVWqVrAAAu9opvQ
	(envelope-from <netdev+bounces-307342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE6750690
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=SCfFzWvB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307342-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B64830CD2B6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1C381B01;
	Tue, 14 Jul 2026 02:37:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201123815CE;
	Tue, 14 Jul 2026 02:37:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996655; cv=fail; b=rxNs5E4bmpfEsMlZ0AyJo/+UEpNpL9LByiGw4D2UuW0kqBmUyhoa08y6t//PGYuagjRKKLEvhmcd4rl2fDYIoYDJAbnzQgUh8cqdV/e2hBAR7/TgAWcQI8uhaisMa+in5i59R665CvPDiVcWGaMOqpxBo/NPQqi2vxsfXLD8l6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996655; c=relaxed/simple;
	bh=5duLO6uMprPcPIv4W1WL5kXtgmqsmdQvdGD12Mp93RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VkN9YJQxzDqZwN/rI17beKfhrSbJ0CKu38A0O++vQSDG1GrkV/WeGbbMlX5q5aYyF4ArlnPJWlrvwhFrRuyyI5scqVKADuExBgPEjCOaPi9KcEV4kQ84xsJTbWXVxAvBJpUsyh6wJCzMbF43BA6Lkb35XX6oS9y+cOvfhR13reo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=SCfFzWvB; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKCAbID0q0FVw/tcRmKP50nzxPs1eXiKAanAHywb87iK/9ztRmOMV3VcRRq3hWnaFefPO2gsnFEibtiWWRBhYYLvvmfnH+1/2H6ypYHqibYGokwV0yRLx6dM183PVrPNNosN2Pc2S8N2mNdJOTmOKhyLHRUxUDEoEon4c4MiOa6PwRRlojvK+Yrd1XO32CfkI1dGi2BbJvx5WdEW0OxP8l+/iWMVhu3mOPMCDiBjv9BwPkd4lGwwJaUthsRtAiJCFdrLMW9JaVNw7bVz+JcqcZsa6p/6iOFMRhdsIA6VmuH9cy4NHZdbXl65dKhCUON7+HysmuP/7aKlWbZQXduERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2n7GZUXdGw1/OWHBpHnTodAyxpIGd+3rVzE9jcvipM=;
 b=QfuTAIwe3/mH1Hw9v7IBcvQTewAKV3a0Ac+5YQq1e6FEaSobWYcpT56/5fV1F9yS8bpVUtmBnTGMXGqu8qFfba2DwqPUxX2xUmeBEKzT1nsFYDhwHUV/iKChZkARl45z4GuGWnhDUbkWSFXLv1tMKCQTc4B208KCz0DqzD5geNqg6Ao/9PMA4yG9eFMLhWrYkHSRoIVaMAZMEHaMYG0jmiqQfVjO1vpZJKAoTky3JzlSVaPLJS0AtnfziD3iZohBoS3rjq+hZ53AJ+k5pw2hDTWA+Z7QpcfP9efU6kgMwA8gklYKBI00UKpxulI5y6zoQTMkrqyDzctcH7cWTnlcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2n7GZUXdGw1/OWHBpHnTodAyxpIGd+3rVzE9jcvipM=;
 b=SCfFzWvB3hsUfBfmqjBl4Nfv5mbP0CO4dDciuI6rrGZDaEwRsrV2uvOQlsNmnyQJvAgZxTdF1r0WWebU9iUqnb9QYjxj0J/9Y/A+5vbvtF+NEw0oLp1N9Af9r8K7mqtyNNP8IjlNqVJneEezss9aBwZHwQp0cy/scf6Tx+4MoUE16e2E+/Bw3BaDBRpyKDt0WwJH384OwP4n/irX/rXPUvhw917lKyXyAlGanSzzUqFxLAuFdyb7G2YTUuxfXD99D6xOBpqAlgLFiT0geeRJGnyda8oLYdJVMvw9wlrVsyLbHd+R1EavVypIZvKvC2FGk2Lj8qPmpJv5GHazYWpnKQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM4PR03MB6032.namprd03.prod.outlook.com (2603:10b6:5:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 02:37:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:37:18 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/3] net: stmmac: fix l3l4 filter rejecting unsupported offload requests
Date: Mon, 13 Jul 2026 19:37:15 -0700
Message-ID: <20260714023716.29865-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM4PR03MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7d915a-d32d-4686-f9d6-08dee150d2b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|18002099003|22082099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	37JKDl4HPBiJf3NBAN9kHX+AgSaMq30uqqYIi1cecAKhuhtZ52fbOC0YSn8pL9Gvqu+ltvXTTpVGb3cFcn/gt0PXeOeQGsv+XszVr/9oD6dMKV5XMKCRSUlN6Cl2N1IwjDcKGmqWQ7hOYi/Z/g/IbvXXecUyKE8TjDV1JcB2FDIxVEJYiZMmocFKjbAxI4abna5FWGcxUkJdEJoczfrznCGcTRDMAj1zQbwUbhISHNlRfWxsfNTTzmkcZ15sQHwO0OZ+wRvBDTKQyBL5EtihSL1Sinumv19aLoEKiBDVuxc2XrbPFDaNB/edxpwHNoAMs1MjMk2NL54HohULFtmzWIqZXCwdwbP+jdFE+q2pzYznd5zgumjHwbD16dy4J/I3pjucYloPp8ksOGJA/ypTIRclmjJ02XG29guJm1E2wvnFAsewM0915iBe3vL2d08KpMyFd/d4smocwyaraSFnBygoS/P2i0q7fSnuq6fdmjde2Q+FWvtZaFYf6hO2WvbcuG8ziwuUBcx0kDKavkyrkNO1kqYtuv+vlznEhviISJ2e+pn4woR4ojPuDSwwDJeLQfi5w0Wbtj392/OfEBIBnOiTAbwL/9XMaDOvXsqhot8jODWCwMt16fq76JKETsB6d3AMHUP+0xqyGh3iUgjk6ke8YHCiIATtMurq06SJams=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OR40yoiuKOgOPFe+Ct6d0FjCHwDMtKsAwyq7kpjUi0ZWqcVOPj6aQkvoQ3Hp?=
 =?us-ascii?Q?+Q/D/4W4DUeGREj9ShdQ1YCofnrnKpYUcEWbWMKrMIBj6a9h0Ej+1rSrcMfE?=
 =?us-ascii?Q?kl4JafLm+hsVRash+OV59aftLNqm9dgnnOM1EouojGFDjVDE81/hEzuR2Oyz?=
 =?us-ascii?Q?UVeBzb3GOwKwg6X/9C7hYRweNhcmtxkgfVjlxicwS4ivKNaCxfKK0WSlBGwR?=
 =?us-ascii?Q?+NbO7sAcUwdcwOehshlbk7ivyZ1mxfkVx/tcL1YR62IzfzxHvQM89ZyH9gph?=
 =?us-ascii?Q?9BB52y2yawxveJegPwR/b62SASlfR2zGdGnhMLZwHccu0ELCh5CSxlCLutd3?=
 =?us-ascii?Q?2mgiDo+W9DYz96eNa1xNOatSeejLEygGx1axbj08njAAwC3ESg1qC8E42+yV?=
 =?us-ascii?Q?IjSmKFrwqkHtchFWTSpc2590d+o1/FZ7odm70IcdYcclF3SGkV0NR1mgLPZ8?=
 =?us-ascii?Q?v0VYmAiEY8W+wNGMfYNIDWZEM2vmQGlskpFmvon2lTh9s9lljelRoF2C06qa?=
 =?us-ascii?Q?XQqn5/6hOvGfRytRk6LV2W6MPVlbQOjWDOGMaLHAgkoO5rFsZNECCA8B4hyq?=
 =?us-ascii?Q?onYEnGzrHC4mSTszbMw4mQwYORDVU+B8ZsUjmdsh1wkoK9YXRvtU+zj06w5j?=
 =?us-ascii?Q?RnDXDh91MW3FTLmF1iYvus/J+jbK90RPkMLt0fliNF5FeCicJvDCaJoOTiCQ?=
 =?us-ascii?Q?/kRW3LOS7QPF+ogTBy3Upon9RHfuxkP0HtzOdHY0KSNUIW0hS1DuOXS6TwBj?=
 =?us-ascii?Q?D8OYcIGZs5M4c7czEOIgBtvzgRWIZAmFhTgHGJbHi0JZ8/rCB31TAbFSLlrP?=
 =?us-ascii?Q?fyZWwCM72DX5TpOLstZEYbWjPw7a1eUxPRG60/iQWXp/F5Nn+TA+eIkth+4w?=
 =?us-ascii?Q?3epebJbCCB3kW/nHKESsBUKBcJ5buI/zvMdvO6MphK1bNTHXBXLllNabMMjH?=
 =?us-ascii?Q?ZwEIXsuhyx6tD+363NsIYjfMcyxV3Ro3YN1JRG+ez+iv2oc/MTOuNm/+wla5?=
 =?us-ascii?Q?XZpmFeLrU9oN/aN7NlK+/zrZr9TkGzI8DrVMwKyLqVmyrgUHaRwgiTS9oFKz?=
 =?us-ascii?Q?9HxbAgEYY661FMQMU036EhK7mZZg0KI5dM8v0nc0oO4u68HY9WaUoyikhALS?=
 =?us-ascii?Q?8jN1zOMo0NqOktnQeHGuS8Bo1ewbSXD+SdiXLrTFREMVT9I047YEBMXiOdI5?=
 =?us-ascii?Q?wWkn7i+d47Yt8b72S2f8kXc8EXuRT9Apcts7iVklkw3ZEOHReumI04HbcuHx?=
 =?us-ascii?Q?rUj12cgQPWgaei+u67FznKp3gy0OSFf6x0TCpk5qTM9sAJ3kXWYv6DY7aA5x?=
 =?us-ascii?Q?kjjIxSRaAmy/19c38B1L0A4wtUgyRfPovxn8V9FElo2rCwetguzTO/uMAKQc?=
 =?us-ascii?Q?22jKuDsf2gLfZwQfCAEtzu9Vgrf7X3YMJ2S3//2hqDLeD8RbPUh8gzzk42w+?=
 =?us-ascii?Q?mgCOMZDSaV4ghKKzfiNznTXxq4BI0JasCagqfMepWa9zuCuF9x3epXa+HdFG?=
 =?us-ascii?Q?Ovn09YBdgTgYXFbiRqCvlJ9XIaRJ6yk5KJ8m+jyFCsclc9IJJPgFWFwFVhr0?=
 =?us-ascii?Q?/UojetFUiy1aA+V8K8YnCcCTA1ZamVwZECUVIAoT644Lgj5NLQ539c7UiWMX?=
 =?us-ascii?Q?MvLj1GtUD4l1CgIw8BJlUG1LfNNDEKzmEBtMtJ1B7/H7dpY4F5Ul+9Z3zdQv?=
 =?us-ascii?Q?h8J+nthJZfWXDY8kmdEp0VVRREIdc0tkQXZEPYgUyt8JKCtfE5DFS3laVJvN?=
 =?us-ascii?Q?SnLQCX27g3KFSIrVUENrpvRk3CeKhhchQfbKWfJCuI0+jqUGzPh2vakF5oIl?=
X-MS-Exchange-AntiSpam-MessageData-1: IAbDMk3qohG2NA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7d915a-d32d-4686-f9d6-08dee150d2b0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:37:18.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+AMRPViq+0GbQCHhlmB3gKJJTtzAP6+nXGExkdIr3tQA4MJn9ZsNJAVsEtEDnr0HoCGNZN3ex90/Jq3VvfAEUActatTjqONfv5ljRqpRrU/P7iabQFBQuzOQHleGaZS2VuSPCUIQkU/7xU3e5s6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6032
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307342-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ACE6750690

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The basic flow parser in tc_add_basic_flow() does not validate match
keys before proceeding. Unsupported offload configurations such as
partial protocol masks, non-IPv4 network proto, or non-TCP/UDP transport
proto are silently accepted instead of returning -EOPNOTSUPP.

Add validation to return -EOPNOTSUPP early for:
- No network or transport proto present in the key
- Partial protocol mask (only full mask supported)
- Network proto is not IPv4
- Transport proto is not TCP or UDP

Each rejection includes an extack message so the user knows which part
of the match is unsupported.

Also propagate -EOPNOTSUPP from tc_add_basic_flow() in tc_add_flow()
by returning it directly rather than using break. The break was silently
discarding the error for FLOW_CLS_REPLACE operations where entry->in_use
is already true, causing tc_add_flow() to return 0 (success) for
unsupported replace requests.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d78652718599..1f8c9f47306b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -446,6 +446,7 @@ static int tc_parse_flow_actions(struct stmmac_priv *priv,
 }
 
 #define ETHER_TYPE_FULL_MASK	cpu_to_be16(~0)
+#define IP_PROTO_FULL_MASK	0xFF
 
 static int tc_add_basic_flow(struct stmmac_priv *priv,
 			     struct flow_cls_offload *cls,
@@ -461,6 +462,37 @@ static int tc_add_basic_flow(struct stmmac_priv *priv,
 
 	flow_rule_match_basic(rule, &match);
 
+	/* Both network proto and transport proto not present in the key */
+	if (!match.mask || !(match.mask->n_proto || match.mask->ip_proto)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "filter must specify network or transport protocol");
+		return -EOPNOTSUPP;
+	}
+
+	/* If the proto is present in the key and is not full mask */
+	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
+	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only full protocol mask is supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Network proto is present in the key and is not IPv4 */
+	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only IPv4 network protocol is supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Transport proto is present in the key and is not TCP or UDP */
+	if (match.mask->ip_proto &&
+	    match.key->ip_proto != IPPROTO_TCP &&
+	    match.key->ip_proto != IPPROTO_UDP) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only TCP and UDP transport protocols are supported");
+		return -EOPNOTSUPP;
+	}
+
 	entry->ip_proto = match.key->ip_proto;
 	return 0;
 }
@@ -598,6 +630,8 @@ static int tc_add_flow(struct stmmac_priv *priv,
 		ret = tc_flow_parsers[i].fn(priv, cls, entry);
 		if (!ret)
 			entry->in_use = true;
+		else if (ret == -EOPNOTSUPP)
+			return ret;
 	}
 
 	if (!entry->in_use)
-- 
2.43.7


