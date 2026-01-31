Return-Path: <netdev+bounces-255523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLivJYWBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994FC423A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FA13300BBA9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FC738B7AE;
	Sat, 31 Jan 2026 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kEaGkSD9"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F738A9BE;
	Sat, 31 Jan 2026 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898352; cv=fail; b=il/ZNu9DJQFtw1g/BrfW8CtPay5xbwVbA8R17c8dXV6sqPxyEOjZJbdAKuF/3eOGLu2JJ3FgwzUzpMRh/yxBcVkNsK5XxBmxHvqmy8k+VEYbAi8OiSmtN4Ce+v00nsDtvJR+um2+dbfwz2fWxIdtKEh4TOcxrDEyzWn2pXIMvns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898352; c=relaxed/simple;
	bh=s8mm2HIoSI86DjpOcqXXKktRx1xet8N07feDn/HU470=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye7ecZFxM0usymBe3LO2JICa0cNcZzZt84ua9acnZxjjlTNIrEl+TWEEnbusgd54f/tKyxuAWbrpC4FC92id3WJ9EbtuM6J4LWt6jAX/3wMMbYO5W2aXqKB4tCvmbt9tyFOGFTJjibZSfrn+3fUs0DlIU1apggfhkHlzuPDiKjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kEaGkSD9; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hgjea6zO24fEmc9UTzIaLo5JwYLY4HJ/gstqkBbNEq0KnER4zMBeE4UM9+bYY19fj53e/Vqi0K9jJ2VU9gKOlg9XxfKHen6/4jHJqyZnj+vyTPVRHBJbpuxNKJ5CAckS5+z8gomEBR9r9ZIbJpFhGR30N8ObGfivMRMvWxSJ/kakYO3FWFlcHgjVr58uewWoBcaAr2YIDRWLA+4Kb5Gp+49y9uRUbf4Ie+0TtL/cd+ipoyuR3G7Ki5XyLEgz5r7uhvc9/Pv02Xa7nOadH+jFaH5jKnPomu5OgE6kItqKJbry1Z/4x0cCmZCsjuhhhysHqv/bFOn9fmBW8w8DfakgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcjR6FsJ1Gu8zpWYj/LvU7GgyirEXyCNSHqdiywGPqI=;
 b=VhxisHbFaakrIphsLSk8RwjCI9o5QCzREH8xj9dxQQ0XqDGAYFAmytvZwHYC9/bw16KmRSQp63qy6j2nDOiIcY6eYQHUnjzTyDEfXaRpgBLtAmnwar5+w6k1EfpSHO3EjMBO1bxGGcxTGPyL6YHTm1NfLkISD5eU64Yt1d+310QotZ3pZnNk+2psIKtUAA88BK5hzvx4hduRWMkIxA8W/TRQZi+nOocgpjJMYgBCBuUQ3KYkSnbYTa5kz76tEhiwcaLGzpH8iBGC9zwWIjzJFEgfnW5w8Yf9Bn36HNsyBhgwDi2vpiTkeHZ0xlW8T1/Z3KwE6FRmfFJDWNZy9CZh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcjR6FsJ1Gu8zpWYj/LvU7GgyirEXyCNSHqdiywGPqI=;
 b=kEaGkSD975DOMbWmON490TZCZX+BiTVlBenDwUuvQG2yWrwgQOpa/X+ZJElCJtlm6J3Sld0mWB/4aO1LyrIGaHa1s1lD42yU4ODp2K2/vkgJow6kvotGYYlPqIyxAEOcz61Ns+8Iv88i2EipN68jVOG4vgRJL3fbFCTk93DfCI7wt4E73NH7LMT/6FFJWKRqk1mh8W/wet6N4kyuZPPaZZF9g7jyu3edzTU/24zPXPphJCAS+wK7yMA4eXhoCvZbog90qK99d1OUgTiw/2I6fDP1HShxYQS7HY180BYkIUX/PKRgXuLXcYibfdEM7fbrNLY+6ezIwWry08mmzFKFvg==
Received: from DU7PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::17) by AS2PR07MB9055.eurprd07.prod.outlook.com
 (2603:10a6:20b:546::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 22:25:47 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::b7) by DU7PR01CA0048.outlook.office365.com
 (2603:10a6:10:50e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.13 via Frontend Transport; Sat,
 31 Jan 2026 22:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via
 Frontend Transport; Sat, 31 Jan 2026 22:25:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6EC61238FF;
	Sun,  1 Feb 2026 00:25:45 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v13 net-next 08/15] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Sat, 31 Jan 2026 23:25:08 +0100
Message-Id: <20260131222515.8485-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|AS2PR07MB9055:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca7b66e1-e584-45e9-79d9-08de6117ae5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SYjFbzNosaWuFvaWU9hY7aigOHCJuXhhVjF0LY95JnThR1N7NuWKCJ9zk+Cx?=
 =?us-ascii?Q?/H24N4WobWtGWkjKy9msUEsDZ5ujMgAPhBCtj+dWaRnwrmaxS+eELUnR7Qrb?=
 =?us-ascii?Q?karTCj/H12nubf0tjSWx8RG8Vh5G8EHEpt1leK7cUmOCIF4MqceO+rcPfaa2?=
 =?us-ascii?Q?tWWIgViIgvLfte3bFAikB3aF88Pr+YXWcYEnji0lCvTZzA+tXBG4KiOSBmSo?=
 =?us-ascii?Q?VHlvLIKsRuSiPD7n0MsSen55hdY/O+XpKBaWCrYjcpC6wdmH9OWCuDh61jXp?=
 =?us-ascii?Q?PBV5jWClh0gXUkiASydfWcEMSLNBscdAQvxi8gKgK4USvZSBC78aUg7WwFxU?=
 =?us-ascii?Q?W8kpd81k6coUhL+tsrKjLbQr+hNSdw2WqEnMGovDcUN/cTlz+Lfyls4ABT5Z?=
 =?us-ascii?Q?dFgwBDIoASc7ZanLy5FGmHqdJR0eWIjQRdwkebHJMW/yiRaen1Hjs2nWFOQM?=
 =?us-ascii?Q?jRG+IKq+hx/YDWx5wu6KXHl5u56xsrt7H9qLiFEK2aL+q7+heRfkA+yEX3BW?=
 =?us-ascii?Q?hWBNIBQ+jcT1BOWTleqC0f2CrN3+SDrzD0LDZy3VTvkbNRfk8z98i3RlZvGd?=
 =?us-ascii?Q?YW+2hpEDdgSTLZmdqXilx68aCN2OQQcPfxC1CO0I/aQzwIgmIRHMDoJ6iH21?=
 =?us-ascii?Q?aiYpKGeGx0G0SyEdcblcXLhLvh1SpUnS+BWToh9W9mK9O0eABcwyGggNG3Ly?=
 =?us-ascii?Q?0kOArEOTvF7eOlCIH09YtYj2yIfPaYoRevZes+XucbAvxOXGbJLTcK9yd0vW?=
 =?us-ascii?Q?slQByazZcY+HmHX+0Z29xtLUpB7Xgucx9TFKlcKNGFIZbNNsBm5pW8Th0LL1?=
 =?us-ascii?Q?CfvPZDxZ23UCNh/b6E6wtaJDVjdq7EFiKeNs3dJcdDVf0kI/wvmBpdfLvfM3?=
 =?us-ascii?Q?yPtFTRcLUPDLE25QgdclrGyquPvOdy/JZ1DCRK1ezoLIepjclct7xgAUtctL?=
 =?us-ascii?Q?aH79T48DmDKa7714m+4WINPOO+/GGU51pkg5hDKTVcIWxnVXtJv7R8coITY0?=
 =?us-ascii?Q?iCvNc86Di/yvYQOVHfA/sJBnC7n8nNqL2s+QUUvoqAd3TUzqNWB8WVtNYMQz?=
 =?us-ascii?Q?gdT73QdQjEc3fbUJ8ELFFI5IIIQGfI/KSeOktZvFw+K9t+FvByeBfluOB85v?=
 =?us-ascii?Q?iHryqMxFQpAtGgPfUcNuiPNkVxL8bornOymjs6ulUQCBiGDxOwg9309donZX?=
 =?us-ascii?Q?fr5Qk2dXm/wXlIzAlk3CwzqM35ktDjEaJmMEjsIRNbW6XQ0ZJfjy95dCX5Sp?=
 =?us-ascii?Q?b6sltyuPbD15nC3o+hPnijoyVf5epNwuMF2J9BIvuZKBUdWuM/P0a/ari2jc?=
 =?us-ascii?Q?vfxHQFH+Rkm7ys3Q3UAJ/HXpzoZVjwv8iCAC0sNlJNrdIuhxjgxP6bQqcpgH?=
 =?us-ascii?Q?64rUacRKEp9cL3NtPaX3XrKDsKZBNHUBHn2kbdltS8+8JWHqlZfVJ5AFCin7?=
 =?us-ascii?Q?Is5NlKjYr0zGDLMLFrUV+NSCsygIhHlyfUiF6VBg7twSGJxmJWUjyCEG6/w9?=
 =?us-ascii?Q?O54YeCaPaXPEHzMMeTSgDjwz5LcXtnKAdOfKEs6rTjxdZPpY7S2k//O3AA8a?=
 =?us-ascii?Q?kLqWPw1qNmF8ijL2keYkwGL8JkiB1yfAtyI7xE2xcoQXJFN+AnK9laSvWHtE?=
 =?us-ascii?Q?PMFWJBVPEi7inf51QNOEghT1YtzwRnr8uULZIQTIKhrQkDvr0VtdDs7UltUg?=
 =?us-ascii?Q?pvIUuPwz9q1l+vZsv8UOPBzfScA=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xhzAARSz1WI695mMkcdpco8vMMr1PUJHHEFivzTfVa+4CfYfPrNKxJ+2AoJkHIibRqoW1IujH+sjCUsvH3EGjoA/B2gkatklLiQcodDGMbVey7MjX2XvUIi0A/IHQFcAXZEEU8VdS4/KhyjhwoaAd64D+U16Bm1Qg49yHPcgllhApaAhsaJSNhDPYMgEt6YozRRMa1A0JDx1hFIiBpBfMVrlmMlRolrjGzEaVOBILFozKZElXVi1vkmzhqWq2QzYZLeFZqaNCsd4nA6MMkU92dc/W1Y55ZczSU2IHuYZDo35KyMYDdsg2VkYF3TONS7GsKgF4NWdCE92sIXvzbxCk0jZ/1fqFjJ217tkKiIfY+Xg2wVv8afAXF1O7pAkjKt95EiGo1nmHj0pDb9vE1T4DT5qeoFoO06rVMSs0RV83zfGVbAkSfRmxZjOEr3HhoVc
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:46.9688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7b66e1-e584-45e9-79d9-08de6117ae5b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255523-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4994FC423A
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, retransmitted SYN/ACK did not have a specific
synack_type; however, the upcoming patch needs to distinguish between
retransmitted and non-retransmitted SYN/ACK for AccECN negotiation to
transmit the fallback SYN/ACK during AccECN negotiation. Therefore, this
patch introduces a new synack_type (TCP_SYNACK_RETRANS).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v6:
- Add new synack_type instead of moving the increment of num_retran.
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ea9ad0a3e634..ee71cd7df670 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -541,6 +541,7 @@ enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
 	TCP_SYNACK_COOKIE,
+	TCP_SYNACK_RETRANS,
 };
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 				struct request_sock *req,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b28596655d73..a1596fe8dd9f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3929,6 +3929,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4614,7 +4615,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
-	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
+	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_RETRANS,
 				  NULL);
 	if (!res) {
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-- 
2.34.1


