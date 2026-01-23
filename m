Return-Path: <netdev+bounces-252759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNAKIkFJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7011074019
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95C3C3018C02
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3052353EC2;
	Fri, 23 Jan 2026 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SEQsg8L/"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B0366543;
	Fri, 23 Jan 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162862; cv=fail; b=GXu5A9GCTzmjMTVD1EdA6JsVHgBoSXvcEVBXOD0FXyyyw8alE5woR5FnYaeELMdYbDc4tODCvoIDbr4mo1DuA978ygfh2PRyrOPDYndzi0BIkrre+kDGf/UbIeKm+8HgeDY07y+Kcvz6Lh7KLbECMk1/YYdKTb33Z/g85GDANgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162862; c=relaxed/simple;
	bh=s1XZncvgOh71GEK9Ajjd7vgKSOe7HtAgxYOsw3C+EyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAye1hDVkgeLVKYSze+mWJSXCnCe+ychGcRV5BX8PGWZoCZLfo0YI1c0o2r2w4haI0NIf+mMTOHpxueYVxXUXCKjOftLJMIAPZx2wjsXUSe02LCghvEqGxksYtB+LrxC6gTGphWPVw7PzmtwcGHtPwdu927eX0ec9DeNe7iZmVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SEQsg8L/; arc=fail smtp.client-ip=52.101.84.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEY+PsozfFOgBZYASr4tq7DqtzL9uDm4FAOOUwQIW79BAkPto6ma7D9njxWcqofXzgg+AuScPZD1qZ53RnoQnikKM2Lce1FL6/UineejKX5UWK6sqTJXjNd0TjFDkNeJEGHxU7PjdyfSwb68iFz+ajTUSF4I/IVdc7eNbqkcs+jmAutjAHThNzQC7/XZ+a+xtH4AgTT0fkRQ6vVc7PdmvelZvwzb/eXECJjZ4pu9TQz8YWMzH0wTbsLVlkyswl/t8c97tWWKHDPq34++f2+phVGaMrIIGOzJfD8eOYTfVwJ0Fgph5u4VqGhFC6PffAcq+i3Lpmnef/LqaB7MhoCy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=YuBXR3r8Ms1YSusJ7ySKXX1TEEQ2a+Sea6qSUQpJVmgBZGZBswdMRvxw9yHtYJ/VBLubRKqHL5gDx0+OGCgqFfLcZvAfvKeAxsM6QI7dIO/0AYG0LJNWjIiqV9FwaHXEwyS8fuugGc80VDW3/6Ywe1N75kFE9oNKWQAzy2cOglrTg+1OkCaQ55ygWa3CWEbgK/mLu2XSJCn01U9CCETItVtR7R/lx2W/giJn8qUH9nHl1wb+uH6UKkjbgE1fD8zJ0HKmp6XCBC3/o7bnYy5LG2yudCg67QDG5Kr493kc/ni58BOJYvQYcQsiXRwMzOXjCtBVVz+YSMfaKqak0jGdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=SEQsg8L/w3NNX8umG1VpoPrpT5zpfXLAuG0UicRmFcFopkcYs1jq3Os18a9PZSVUr5facHvHGUF2Fzsq0KTjhEd9xjWFe05cZeAyf/HO19dS+YefGjZ4+KHM/OauDDWhOFXQMBOS9Ozig0O4abj6rhFVfHYwPiQSTVGfqF6CgtometGVCnDKo7TWJMN71t5liwrieFrXfqUPTOHrunIsJL05EFp57s6j91siY8rXc58VFB/bSakD+sVkO3oDxc0shkSoa7q3FpDje7gYn8SZrYZPQ4LunshqvyXRl4DUihMXvedgQFkEp73evRnTN9b03bWNAhGAUxNVm72d1ktMAA==
Received: from DU2PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:10:3b::25)
 by PA4PR07MB7182.eurprd07.prod.outlook.com (2603:10a6:102:fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:31 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::8) by DU2PR04CA0020.outlook.office365.com
 (2603:10a6:10:3b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7894C1C0030;
	Fri, 23 Jan 2026 12:07:29 +0200 (EET)
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
Subject: [PATCH v11 net-next 03/15] selftests/net: gro: add self-test for TCP CWR flag
Date: Fri, 23 Jan 2026 11:07:09 +0100
Message-Id: <20260123100721.42451-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|PA4PR07MB7182:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4dbb822-afee-4608-4f2e-08de5a6738a2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?KXKG+UOH5hIXDFPDikHyhFm/UMljjxTQ2ZhG6Y/0Y9yxpbbgXWQXrUs+BJnq?=
 =?us-ascii?Q?OQjqMUbJa/B/ceJ+DpgP3AvW64ztph6YCzYbFdAhZA/YscUfXnGJHrHrmWjK?=
 =?us-ascii?Q?pTxJNVJGSEV4onM7BM/hRhT2uNGn1pXlLpnk/CsFhno1vjuvEtL42gEFKxxA?=
 =?us-ascii?Q?s+JEpZZR/MGoJprfvAqTZzDVPt4mx2xgaTHGM8EP/A/qtigd/s7ejYo6i/Ro?=
 =?us-ascii?Q?9DCX/uNvCK3NAlGfg6L3C5njfcJiB2Z1Ec9Q63QQPn5YS/pW1vPfFFEzjoBQ?=
 =?us-ascii?Q?Rz+oHZQENQ3QKhX9in2mtEi5Pd/KHw54Y+e/W2zVv/7381f0RiDpDaH8gfym?=
 =?us-ascii?Q?4TLJgZpwRTTh2Rlf4SBmYiW6CjI4rotnbg9v22HhAKruspFw+AYzUeHKSKYB?=
 =?us-ascii?Q?ORt7XdF3PFQElQd4BsU4pppb9p1mIwVf9lTwCElU0qQM97gTQnoIfgFfLr+G?=
 =?us-ascii?Q?Sjqiy+ESN9xPVizAOmJmEvl4O135iu6PuR/VL7vGHg1ccR4/FhLTvCCUHUrk?=
 =?us-ascii?Q?NPxUCyjqKYkthyJsdE5tB6RGrPmGxhpdwsYaCBjlryrn+B3X485Kb8HGPFzt?=
 =?us-ascii?Q?9ob2qZWEsgZpVbiy1YMq4BYV9IgL10GFdSr+JDvMwXcAmoAByeVHcr4lSa09?=
 =?us-ascii?Q?AAx0WbHOIvdH6YEAQDhChlrQYB6KaygW8ReYXulM8JiuFk9TnqEnGMTu7IkU?=
 =?us-ascii?Q?MmuGWSdm1ZDLg+hvOS9AZxDmJK307YbMAwQVtLscnp+IFjYUivyKfRc7KoRm?=
 =?us-ascii?Q?LQ6LDaQXC487DkVNBgbdgNFywAxs1JgY0u1khP9tF6cJ6PqcVUJ87TBMC8nK?=
 =?us-ascii?Q?JWJD6wN2cnlakGECvJ+36Y8bKtQTFJDtS8+u6hS+OKLThWWOpD6h7Oe9RHvS?=
 =?us-ascii?Q?2EHYpulK7Q8GlMNEtg2ieeKbH5HV0rjp+Cs/O+X+ryNtOSY2Ny0ZYsTaFvQe?=
 =?us-ascii?Q?3BiHWtshqabpmfyNuGlbnm208cYimQXGytbkVe+7X7IzGPnVDzi4RDuHANcl?=
 =?us-ascii?Q?Yanp18W8eUdMeGXVoPkLP/G9IzEi+xmJW44IQmkWpfx/ILB13Dt5HdR/Sja/?=
 =?us-ascii?Q?Mj85SHNapr8IMvjdFNuOBikvh8w11zyrFCtTJlyL7STw/6t+xy10xiEpRSv7?=
 =?us-ascii?Q?oplhpkz8gk+iKK0vJOMsrAsneV7DyK/kDqQKWeoMJ3kIk17B6ZMoypZIxzfC?=
 =?us-ascii?Q?OspUvFUVOrJvMOh5kQ0ftJQrEIfc7GkUwOYXqYlJDO6qYg0/ukSwAZKE5894?=
 =?us-ascii?Q?r8RJ+JXXNYBLbZ/T9uY3xkckn5F8hFFhSjQGofAFRuhDG7I6FbwKB5bYD2KM?=
 =?us-ascii?Q?MTz3dq4r4aU40/7RNHe194ujToJC+7T2Cmqcq30xXUEEZX0/sa8oWeKpT0q1?=
 =?us-ascii?Q?0hncUcafsK6tApZ+VEZbWsj0KekdXvi2ho1Ir+GpeNw++wv4wDWHAMndgaLt?=
 =?us-ascii?Q?1kwNzXc6RRYuny4zo7k7SD+R/4WQ65va3ytoMuGmM4bje0l8l1ah9Yyorme8?=
 =?us-ascii?Q?wxgJ0/zcrTCDh8b52VfSV6Q8QIKfxEiNHDsugSATUZvrSd+pHeFomci8XtUu?=
 =?us-ascii?Q?4XWk4iL8l+iAaTWYP0+elKqpqT6BiEwzHq7AXrYksLptocj5FwEDN4IDCh05?=
 =?us-ascii?Q?oniN/H6YLpSAqAm3Ki9a6zJdrDnG8PtWOfnN8cfdLuMxzf3nMuqxEh9zTCDF?=
 =?us-ascii?Q?jTw5HqPQef2i0VTSMzUoNHdmJnQ=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:31.0434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dbb822-afee-4608-4f2e-08de5a6738a2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252759-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7011074019
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, GRO does not flush packets when the CWR bit is set.
A corresponding self-test is being added, in which the CWR flag
is set for two consecutive packets, but the first packet with the
CWR flag set will not be flushed immediately.

+===================+==========+===============+===========+
|     Packet id     | CWR flag |    Payload    | Flushing? |
+===================+==========+===============+===========+
|         0         |     0    |  PAYLOAD_LEN  |     0     |
|        ...        |     0    |  PAYLOAD_LEN  |     1     |
+-------------------+----------+---------------+-----------+
| NUM_PACKETS/2 - 1 |     1    |  payload_len  |     0     |
|   NUM_PACKETS/2   |     1    |  payload_len  |     1     |
+-------------------+----------+---------------+-----------+
|        ...        |     0    |  PAYLOAD_LEN  |     0     |
|   NUM_PACKETS     |     0    |  PAYLOAD_LEN  |     1     |
+===================+==========+===============+===========+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v9:
- Add missing comma

v8:
- Rebase to the latest tools/testing/selftests/drivers/net/gro.c

v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c  | 81 ++++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |  3 +-
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e76c618704cf..3c0745b68bfa 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -17,8 +17,8 @@
  *  Pure ACK does not coalesce.
  *
  * flags_*:
- *  No packets with PSH, SYN, URG, RST set will be coalesced.
- *   - flags_psh, flags_syn, flags_rst, flags_urg
+ *  No packets with PSH, SYN, URG, RST, CWR set will be coalesced.
+ *   - flags_psh, flags_syn, flags_rst, flags_urg, flags_cwr
  *
  * tcp_*:
  *  Packets with incorrect checksum, non-consecutive seqno and
@@ -360,32 +360,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 	fill_datalinklayer(buf);
 }
 
-/* send one extra flag, not first and not last pkt */
-static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
-		       int rst, int urg)
+#ifndef TH_CWR
+#define TH_CWR 0x80
+#endif
+static void set_flags(struct tcphdr *tcph, int payload_len, int psh, int syn,
+		      int rst, int urg, int cwr)
 {
-	static char flag_buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	int payload_len, pkt_size, flag, i;
-	struct tcphdr *tcph;
-
-	payload_len = PAYLOAD_LEN * psh;
-	pkt_size = total_hdr_len + payload_len;
-	flag = NUM_PACKETS / 2;
-
-	create_packet(flag_buf, flag * payload_len, 0, payload_len, 0);
-
-	tcph = (struct tcphdr *)(flag_buf + tcp_offset);
 	tcph->psh = psh;
 	tcph->syn = syn;
 	tcph->rst = rst;
 	tcph->urg = urg;
+	if (cwr)
+		tcph->th_flags |= TH_CWR;
+	else
+		tcph->th_flags &= ~TH_CWR;
 	tcph->check = 0;
 	tcph->check = tcp_checksum(tcph, payload_len);
+}
+
+/* send extra flags of the (NUM_PACKETS / 2) and (NUM_PACKETS / 2 - 1)
+ * pkts, not first and not last pkt
+ */
+static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
+		       int rst, int urg, int cwr)
+{
+	static char flag_buf[2][MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	int payload_len, pkt_size, i;
+	struct tcphdr *tcph;
+	int flag[2];
+
+	payload_len = PAYLOAD_LEN * (psh || cwr);
+	pkt_size = total_hdr_len + payload_len;
+	flag[0] = NUM_PACKETS / 2;
+	flag[1] = NUM_PACKETS / 2 - 1;
+
+	/* Create and configure packets with flags
+	 */
+	for (i = 0; i < 2; i++) {
+		if (flag[i] > 0) {
+			create_packet(flag_buf[i], flag[i] * payload_len, 0,
+				      payload_len, 0);
+			tcph = (struct tcphdr *)(flag_buf[i] + tcp_offset);
+			set_flags(tcph, payload_len, psh, syn, rst, urg, cwr);
+		}
+	}
 
 	for (i = 0; i < NUM_PACKETS + 1; i++) {
-		if (i == flag) {
-			write_packet(fd, flag_buf, pkt_size, daddr);
+		if (i == flag[0]) {
+			write_packet(fd, flag_buf[0], pkt_size, daddr);
+			continue;
+		} else if (i == flag[1] && cwr) {
+			write_packet(fd, flag_buf[1], pkt_size, daddr);
 			continue;
 		}
 		create_packet(buf, i * PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
@@ -1068,16 +1094,19 @@ static void gro_sender(void)
 
 	/* flags sub-tests */
 	} else if (strcmp(testname, "flags_psh") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_syn") == 0) {
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_rst") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_urg") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* tcp sub-tests */
@@ -1239,6 +1268,12 @@ static void gro_receiver(void)
 		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 
 	/* tcp sub-tests */
 	} else if (strcmp(testname, "tcp_csum") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 1bb8af571456..cbc1b19dbc91 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -17,6 +17,7 @@ Test cases:
   - flags_syn: Packets with SYN flag don't coalesce
   - flags_rst: Packets with RST flag don't coalesce
   - flags_urg: Packets with URG flag don't coalesce
+  - flags_cwr: Packets with CWR flag don't coalesce
   - tcp_csum: Packets with incorrect checksum don't coalesce
   - tcp_seq: Packets with non-consecutive seqno don't coalesce
   - tcp_ts: Packets with different timestamp options don't coalesce
@@ -191,7 +192,7 @@ def _gro_variants():
     common_tests = [
         "data_same", "data_lrg_sml", "data_sml_lrg",
         "ack",
-        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
+        "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr",
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
         "ip_ecn", "ip_tos",
         "large_max", "large_rem",
-- 
2.34.1


