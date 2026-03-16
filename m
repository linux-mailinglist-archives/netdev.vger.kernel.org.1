Return-Path: <netdev+bounces-268019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLdkMI1/t2kmRwEAu9opvQ
	(envelope-from <netdev+bounces-268019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:57:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C642947F1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C5A43006162
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE04B3254BB;
	Mon, 16 Mar 2026 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="offBpIvr"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022096.outbound.protection.outlook.com [40.93.195.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8663242AC;
	Mon, 16 Mar 2026 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773633400; cv=fail; b=gk7MG4AV2pc2IHNMCLvFWYJlGodG8AkG2/Pu3aAF46FBqhqMw/UigDsD8i207zEdXZJEk+Uw7vK/xogRFZPA50MzIwBHFSbj0qdTmAO95QFaK6GY83Q+1RG5Srj1SlG2FuzICUXg1HiMBmuVa8ge4gfbXHOu+AHdVc6pYWvasiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773633400; c=relaxed/simple;
	bh=5iAKmkIyAsWEGZv5dYHqI1dsDh8EC1/h5uXj9OWa6Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQRMd8cMzjdNnWFq6hokv0Skjvg/pdKAD1m398ePo50EPUvgW1bG6Us8kLoeh9eNf3jA5u8Nd0sxNhGewn9R1ZzBa1iDpUb5c9LHTASchHUe2nrjnHyTfjqMQ84O41hQDBOqzpGtPq9sjNKnDaa0Bjb0szJReqXntdpPgcmc3N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=offBpIvr; arc=fail smtp.client-ip=40.93.195.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6Rfi29Wh5c5oimsaSc4z6ssC1OOe7guoF2xpEqOmbt0oxEPvTqq5vHiVr6CwfUhX0SzOKVRYk42ig+8W3pjxjve0HAi4qLVZvsYnKW+1BWs+hpnasBStfJNyfSSk3selJFJu2LW14GSCSmiff9iRfI87suFKd7vKx7DTL/rWirsRGmiNSjETrUOQ0mw9OmiQp3CbpVXHyrK+BLJI2NpBrYkfjzxrk+e740yeg8qTPWH4UAF022nicCcv2O6gccfnQsMO+JG239LXYzutyWlcF37acvqhXD8F46eh8x7sQN5u6qKuVau1cVrPi4s9Aw8vL7gylcwGshiULKuOScoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPFrY8OezRrKrjplSrIcPCAEKHMB7oXK+rmMcNJ68Qw=;
 b=A/0q5ggL9tHdZbHXIQ5bgqcPeATvU6Ke0v8vOQy8+IpB84Jamh8ETLqrzkXjVAdvARy/pJn3F5nPBW2DEysM8Ifx3jlvS6Ct6iKBhImk3F8ADbLlc4hJHixVgvLLEycD1CzqSQPlAD9RhfSLkwoj9OCO3uEQBx64NdfysiKR/g8Ip8y7UX+0zljODkmTqJKw4i+UDdrVICbeTF2bYGeekwhuGFlZbmQ1llUogdHIgDLbbbqq8KNwGG+Uq5TD3UTJ5qdYSUKmF01pgDWiSUirvOzpfAxdo2BTnOSzX02EW99tHypli/D8e1LF/s7v3D6TnUBm+XzurxUL5Yv5IGUvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPFrY8OezRrKrjplSrIcPCAEKHMB7oXK+rmMcNJ68Qw=;
 b=offBpIvru7cEZz6qI2TRnyDCN9poRUcTNgHZ70GRFE2IAMgSqu1fOmg9CZFk3hgcS0JR7AokCuUjjpDo5hNFhLt9d1KXgXU0I15Xcl7aLsqFkB30PDOaPeo8oc9u8jX4LtDmvEWIRnJfB1Itj8wn65gt9wYOTpDfMNi0FkZUJ6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA3PR01MB7942.prod.exchangelabs.com (2603:10b6:806:315::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.19; Mon, 16 Mar 2026 03:56:31 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 03:56:23 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [net-next v33 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Sun, 15 Mar 2026 23:56:25 -0400
Message-ID: <20260316035626.363698-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316035626.363698-1-admiyo@os.amperecomputing.com>
References: <20260316035626.363698-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:930:cd::8) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA3PR01MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 50784a17-e321-4854-b537-08de830ffd9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|52116014|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	t95FA4HB95VM8bTRgrSvVH23PD2lCfWElwsx/mwaz49BI+bRd1vrSYD84lPenHzxCPTXKC5unj38dkKaH+htbNNonTpxA4l3NMw7O95g8NMKeYRw4VaMrJlb4eZGX+SJO3CjIMnvgeozDYttO0TIekM1WrfgElQ+6JivhayW2WF9IbvJqth5dIfjmP1gpjXzt7j687dhnOgJ9NLdM9dckV6LYrT1Y7OCyx4smhfG6Y5K2IwUaRqC08ocDlZ9CgeOqT70a7H1pqpnPuIGS/H7IL4bQ1RP+yeTMptj2hwutPTLaqwASWGb2SZX20nxkiJ0xwXEEfaq8vRbhXrRXzDE0w66iU+KG7dm0OziXfuwXOcno12hB0b7f2Oh+e3uYkVaF/M9qBYVCSeGgh/Y6zCpmZZq5YXepKBvYJ5biaP3ozuZax2uG2RLMWpnDdTl3f6C4ToAVLZ/79i5TkuSod7jHxFNmpvBHRcc0ULVxbbcDSuZBfsnjYD7X6ulQE9BYqlqOEvjra7kQip5TdD0T/0T8Y5hFTK2zkSc/IGyqLnPtXcm66dC3ZcWn4pVHiGqS/c/RYh+w1DNc+0KMpLcihdPXTqPKzDr1kYRimgTSnl3qqWO3IPdpriDWoFDRblKfjJCiB8DFHkh18ZO8RyXH8+6A8+0qHFRRdAQpo1ilgLt3KQ4xq3glZYWHfKXTJ3vOo7EJpyknHjydvJICo+IhT9kJLaq+/DZ6EIpUwXfbUd1Sys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(52116014)(376014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?phQAU88XD7lJwEX/pDVA756iTQPO4rN2C5Vy+jId2Oh3rylf456r7J/hIpSP?=
 =?us-ascii?Q?kchW6EJqKkwTwcSNTNI238XwJPXMA25niDtn2AeksLyJGM25cwWT+QZ5SgLw?=
 =?us-ascii?Q?VGRKW1Twy0KZP9iNk0dpeorFT9s5sx3xG8uBleW4CIRgSmcthlmYRki1dc3A?=
 =?us-ascii?Q?jUjKAXD8GMT1GmORvPiQrUIfUYpAb7oWLDanrpLcTUwV56ip5ektPurDegom?=
 =?us-ascii?Q?8McdxEBLJktZDqnn+zLTt1lb80hqLYRT81YoOPLKwH6cpvESz9p0SgN37ZLp?=
 =?us-ascii?Q?pt5sjjfEktb5dBNh7hAWodW293MhliaWxxi/g/b7VGmnyHuj9/N2DJqGmb19?=
 =?us-ascii?Q?OV6TKSOBLEj2s+ha38r4MS3APqJDT9TBCvLuAki9qjr42wS9QDHwguczJH/U?=
 =?us-ascii?Q?V5tb7xYLPQlWVFgQLOjHvD1wCDZ63VmjG5Qq8Pa2EGQ2JEQBbZFdVbV1HIGd?=
 =?us-ascii?Q?hyeb1qQsEtMpnDy6QXFvE7ajOwbMmFAcCFlVG3H2zuv/qqxIk7L/FfmTkklT?=
 =?us-ascii?Q?LQI971YI9xOb6DqINJ0yBoTe0Ey6Yk9HUEvaOg/CXMYOJks3q/zYGDb7uGVV?=
 =?us-ascii?Q?7qAHMB091VEnc/91iuzpOkeLTVyokKPcC3/kHGKY9idWnwY0e47IsVLGa6qH?=
 =?us-ascii?Q?53hP/yKJql5qh8kHIFJaf7Eq7ux/I/FaTZDpxcV3Z6Biclx9GPqrG/rfpbzA?=
 =?us-ascii?Q?ZF/2q1in7dcml53dT74va6QrCYQDGl6qJ0hkr01X5cTfUM8xZVQrFfr7mwMt?=
 =?us-ascii?Q?ZzOQvAlUGBddktRkz46M3iXg50e/gBhF0oXL8MUj2up7fJD3DBjraNFw0euN?=
 =?us-ascii?Q?zYZidhCefixXkfvq7pKINNVw3ofZOnc/nOEM/xdLHLrnz5CwGe52fs7PrY2R?=
 =?us-ascii?Q?HF0J1CaBIMXhuOHvpxDRkmSbnLPh1TTIrTAaYFvpNKf+ugsj7JDG3S4utYbJ?=
 =?us-ascii?Q?dMlNNYkAEMsSGRZmXvi4MgLVO7nmUBAV6HINdo3M8Qxbh5+KzKU6uKiyCnVJ?=
 =?us-ascii?Q?RqFKuG0+oMFrNY8BDifMx77I50rPu7zJcq3x8s0Gd39kfcixN7p726DWRBzA?=
 =?us-ascii?Q?zcvMp3ppJuPRQpezbI8ymu1wKwP9tgY4Rd09h44iN2xu8Av4Ra0sjCgn/yw+?=
 =?us-ascii?Q?Eta6c9zJGyIfJyizKfKEaAOyhwi6rl6pXu8XWGYiN6X2U3QoaoEUnW9EpHjN?=
 =?us-ascii?Q?C1e+3G80NsBXXWYw9AozAPQ50i/KBUWIQ3Wit3+CGsDRXIXmh+axxQpn1tDQ?=
 =?us-ascii?Q?5M83cthtcE4ogSpM8FMRZVk+iSSxbSsia03eGCXdvW26pJmSB3GGhEBEiN9M?=
 =?us-ascii?Q?o4BfH7qLxKTdoL3cQDpJIoFPdABJddyCIuemJM2trrgfxLEk4+WgJ1UDpzn6?=
 =?us-ascii?Q?g7xvpGBat2lBYRLjXEq3NXUeE4hVsdT/9TGj6XRUN4uvb6EFIGgRVUqlfkZX?=
 =?us-ascii?Q?30okrDUG2tNRS5SIrosXzoue+NpRHKVOlh2feOIkOyMSga71LU+mJKrbtoIu?=
 =?us-ascii?Q?HQ9Kc5Ckz5BVz5IflIxD4Ap9HU2a+v8NYOW+s9+cqLe4DGMNFjH/bgw4TfLM?=
 =?us-ascii?Q?oCVpCM4ko5pRoybntpfYcSsp7cxTPV28hZetymPzjZQ3g6VZQ9z0l7Q1JwcL?=
 =?us-ascii?Q?1V6MNSheMa2XY4tpIsZL1P/NO5YerjQ8MEvByl+H2km0b8nB3AhWyrickoue?=
 =?us-ascii?Q?l+K6waEpmbnKGrlQmth/U8CYElIO8upfdYyz9qyibGYl6mQwg1WvLtIb2p3R?=
 =?us-ascii?Q?uF+8b3UQoOhb/IPB+cnSxjYqqGCr/Cx84tp+Ak6Cw1wIgM1xgBhnhbpMt/th?=
X-MS-Exchange-AntiSpam-MessageData-1:
	r1SzfRktD6Mr7uEsfTFYxsDEtOjmPQlyJEYVRgY3vaMEGDH/2tsYiMlj
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50784a17-e321-4854-b537-08de830ffd9c
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 03:56:23.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsDxsg9IrGwK4/K2WDLDklcUrw1Sq9rZmaDT10qxj9IDlWSl+yJt+o2LyS64uFbUSAsf+h2D8aFE8Xda1d4FzsOQzeJK9Vzz9rk49p1KC7NCtX4L6sN3XX7lfTg2oKl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7942
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268019-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,os.amperecomputing.com:dkim,os.amperecomputing.com:mid,oracle.com:email,amperecomputing.com:email]
X-Rspamd-Queue-Id: 43C642947F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries in DSDT/SSDT and
reference channels specified in the PCCT. Messages are sent on a type
3 and received on a type 4 channel.  Communication with other devices
use the PCC based doorbell mechanism; a shared memory segment with a
corresponding interrupt and a memory register used to trigger remote
interrupts.

Unlike the existing PCC Type 2 based drivers, the mssg parameter to
mbox_send_msg is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox, already
properly formatted as a PCC exctended message.

If the mailbox ring buffer is full, the driver stops the incoming
packet queues until a message has been sent, freeing space in the
ring buffer.

When the Type 3 channel outbox receives a txdone response interrupt,
it consumes the outgoing sk_buff, allowing it to be freed.

Bringing up an interface creates the channel between the network driver
and the mailbox driver. This enables communication with the remote
endpoint, to include the receipt of new messages. Bringing down an
interface removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are cached in the
mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 365 ++++++++++++++++++++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ff6f17458f19..43bc37f859d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15288,6 +15288,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..77cd4091050c 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DSDT/SSDT that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..0a591299ffa9 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..4c74f82eb04e
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2026, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/hrtimer.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <acpi/pcc.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+/**
+ * mbox_write_to_buffer - copy the contents of the data
+ * pointer to the shared buffer.  Confirms that the command
+ * flag has been set prior to writing.  Data should be a
+ * properly formatted extended data buffer.
+ * pcc_mbox_write_to_buffer
+ * @pchan: channel
+ * @len: Length of the overall buffer passed in, including the
+ *       Entire header. The length value in the shared buffer header
+ *       Will be calculated from len.
+ * @data: Client specific data to be written to the shared buffer.
+ * Return: number of bytes written to the buffer.
+ */
+static int mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
+	/*
+	 * The PCC header length includes the command field
+	 * but not the other values from the header.
+	 */
+	pcc_header->length = len - sizeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
+
+	if (len > pchan->shmem_size)
+		return 0;
+
+	memcpy_toio(pchan->shmem,  data, len);
+
+	return len;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+	size = pcc_header.length - sizeof(u32);
+
+	if (size == 0)
+		return;
+
+	if (strncmp((unsigned char *)&pcc_header.command, MCTP_SIGNATURE, 4) != 0) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	memcpy_fromio(skb->data, inbox->chan->shmem + sizeof(pcc_header),
+		      size);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
+	if (rc < 0) {
+		//Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+	int len_sent;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	if (!skb)
+		return;
+
+	len_sent = mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
+	if (len_sent == 0)
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+	else
+		dev_dstats_tx_add(mctp_pcc_ndev->ndev, len_sent);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox, *inbox;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	inbox = &mctp_pcc_ndev->inbox;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int initialize_MTU(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct pcc_mbox_chan *pchan;
+	int mctp_pcc_mtu;
+
+	mctp_pcc_mtu = MCTP_MIN_MTU;
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(pchan))
+		return -1;
+
+	mctp_pcc_mtu = pchan->shmem_size;
+	pcc_mbox_free_channel(pchan);
+
+	mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+
+	mctp_pcc_ndev->inbox.index = context.inbox_index;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.index = context.outbox_index;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	rc = initialize_MTU(ndev);
+	if (rc)
+		goto free_netdev;
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


