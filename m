Return-Path: <netdev+bounces-254291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDXtNG8femlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:38:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20FA2EBA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A00E3090941
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF73361DB8;
	Wed, 28 Jan 2026 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Y2eeHZN4"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCB35EDC1;
	Wed, 28 Jan 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610899; cv=fail; b=Gr8y4aP/GSv4Sl+mJylUA0Uj7uMeeyhdxzUgzKV2ra+28FQHxcqMawMzqIAvWqOaB5FTEPKQ0a/h2lvesr2OxwLSKgYgcZVJPjYVBSf88GafXvhYDpQ8pMTJEuGC4tW9hwy/C/YpFOzT2FqPG5zmBONbycIXG68RCWSz9XGXv2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610899; c=relaxed/simple;
	bh=52upW29ex2VBlQy6E9EIY9SdWpmj9Vjkrq8gztD6Rjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/+jB+rs2r05K9EUF4xkLOISDXiVj6HLuYmxCOh2lxXVpApWarEiOnEgprRMOzQ9ALPQK7r4w1d8mAnILQxMZdWo57ceScg1/KXtNpV9ZX1ydJhNSYy/3E29D4zxKblXA8d6MuLEVKm5TWiOPcsZefbjvjSGepG9WO68LJR0FDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Y2eeHZN4; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keKU2+qrrU5N1D1phe9o2+lqKtpjfVQpXE2S5BD5Rm0UKGCcLZKi+WsvHljFkAP5OhBEdm72+UnY6CfpcPf/e9RD7T28MHBnwBulzczwMEU4Aya9YvbQtyUTTTdIFGl9jmbJtI3gexGiOBcI1jqKwWIWBUnudzqCCYzr1LTemIERKII4Qvh+wq9WCzntv2b6OG+sJLR5pX8iK7/jQSZZJxSSIMkuYfunILJqQ9Bar8YJvOh9N9u5eYXj+bPggStth2/xqGYb3lwrSbhZJe1glImcmxsJ8NA3blgYd40V1uP69wyiqxm/e8tMtb7nsnLO1InL8Bg55rRgOhCSjzcBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H9oC1V0O+DQRI2nhe44c5T1amcsvp38oL9WYYjROCw=;
 b=ntwR7ugkVexN562K1ZqM9u/hWX37CyQD/QaTuKcIYpx0mYH262cVZ82gcdG6OktJTX+6L2A/j4goZByYRt5aoK5EeixQ0bnSrMfqfMih3EXOezFPyaF3BNQomksnx2XJwVeF4Vg7ZGkEYqWupUQWRHI80vqdIu/z9gxr58Bkjbq7FbquuZidDo9Gxo9lDLrRv2emVx6Puj+uFm1tDCUKQgj0ngZW4vWGpc2zPPvzyC4kbFXveMRzu+N46yeGqfLw1msPIxZtlXKWftadJqk0/3N9AumK6vHiZHIgoAQtYyvmG1WPSe5kAB3HrJkNMUVVPD9ZyyPHz33jkyBKNWi1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H9oC1V0O+DQRI2nhe44c5T1amcsvp38oL9WYYjROCw=;
 b=Y2eeHZN4ACjqLSgaS8qUPaUNO6uYCY2+c9wWHDcQn7DjG51G3x13yRgxk+pTFVLWQ0m/E8VsTxFgkRcwegREl9Uq/Tu9vri2ZbYQopHh+mIAlnjDrY4R6xDJVD6O87dk4X0mQbydg68tR9hq85I4OUQVE1/6ZK+z92g5kjht0lmk8udjoAmPGQ+9Ft7vkPcDxkRg/M71QEbdf60SZFYEubnZtW9LR/cRbMRO/3gXNOHhnVsx7t8jx+UMoYk9yhHS9J60YJ4JodLY10O0YVqw0bK49qeOoBhWkeX7U0EmtwFqjVnpx3wUndp40adpcPDvw8Uw2ITh07bTjcVKliGoaQ==
Received: from AS4P190CA0058.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::7)
 by GV2PR07MB11828.eurprd07.prod.outlook.com (2603:10a6:150:2fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 14:34:53 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:656:cafe::c7) by AS4P190CA0058.outlook.office365.com
 (2603:10a6:20b:656::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 14:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.0
 via Frontend Transport; Wed, 28 Jan 2026 14:34:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id AAE9023656;
	Wed, 28 Jan 2026 16:34:51 +0200 (EET)
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
Subject: [PATCH v12 net-next 07/15] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Wed, 28 Jan 2026 15:34:27 +0100
Message-Id: <20260128143435.15708-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|GV2PR07MB11828:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 109d7c8a-94a2-4b93-bd40-08de5e7a6690
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?62bnmJGbq4VqIGgpEhnPfjkGTGOwjI+yIppNOGqZj8QjE93Ahjr4Q/mYmBjs?=
 =?us-ascii?Q?Ijmb7kMBQrTMpGt8lIZ2Yn6xQepFwcIarsIC243DOZ+1H698v9Ur5PZ8DxvF?=
 =?us-ascii?Q?RMy38Ouys9IQdKFvuiD51iKtJXbbf/MrMgJzvCMz6xP4eDHgKttL/8kRAtvF?=
 =?us-ascii?Q?PytM1RfiTXW8O+cnKzHB9Y+S75D1fsLpBtWzFJAIDhL4D6mwSUQgp/OjKHHO?=
 =?us-ascii?Q?B6j3Kv+p6VAgjrEa7EtfqoeI7tWHXevRD6GVG6ahVDj5eP5VMjGh1VAfx/tJ?=
 =?us-ascii?Q?KfWjsNhO2VcM1oZPs47f6hGhk7S2hLUvO3p64KkB+oU6vgAYAyUUh+oSiJKx?=
 =?us-ascii?Q?d6nMK/wuEnyAe+QN6e5Z2myKFYo5XmhZYqiC5iRGB6TXMaJMCjELoU/1ORcs?=
 =?us-ascii?Q?X0eJxGw+tXIeRK9QLw1vAa0f5TSyUvprQb2bf1ZKwq4WxW9ZxV8lVAKA28EH?=
 =?us-ascii?Q?qOArNN6OMR5H73P2cvDhZNBbo0LzG5/X6SnjmfcweVnYQkbdgl9S1giinhh8?=
 =?us-ascii?Q?cPssi6fR0aNqu5Kk8pl3WJ+gJr3YdD9OCzP83FttKW1cPvv3PdowtqAcF0ir?=
 =?us-ascii?Q?voZGbreaR6U6SF5BzEGNRao9yemc9qty+NbA369BeDzzcBdNMswPVngcBf0M?=
 =?us-ascii?Q?M1utNmSuFArkk2CSrvLO8ryKLEADRRZXU5rbPo9+KMvFOpjiEKZ8fvvfngwf?=
 =?us-ascii?Q?PibII88wwGABjFSNufa/w0wR9syJ828ZNEmbkMEBCW3Y9Qq26KIot9dqDZWX?=
 =?us-ascii?Q?E+7NsCk1uZKBfQ9b2kKU3+n+XfTG0/0E6gksi9iCCtmucOM7nfjTSm1hei1K?=
 =?us-ascii?Q?8ht4pV28zE6chMHNo/0ruLcHWiGSLLOaBirTfQyFxJzKQiLXIggXYTbTHZUR?=
 =?us-ascii?Q?n9LGMzY6OKoTuc3lht8J4fLU4VJo7bS3NK2VOdgzVxODfulvZZNyf+uR4Zhe?=
 =?us-ascii?Q?FHV1scNGTEF/DRjHYpRpYMcF+FIMQDwijNOmZ5wFHvDrMzVpdozWA0oTFBDH?=
 =?us-ascii?Q?pNbdlAlsluF1/RXNGY48O1vbE6Kohl0EEaB10f5EgjqstktjLj7D7plyfQgs?=
 =?us-ascii?Q?891caUcqgAbJ6tiFpsYp1kt8YEXdgol71pK9RRHHEZoUBKIb3GlpAt3cd7pR?=
 =?us-ascii?Q?ytdN/eqwWL3Qfx9uRXSDMKCYfLP05p16xSQemll5Xx2j564CepKQ3bd8H+Ki?=
 =?us-ascii?Q?s3uHkTES1oqyvKrSDVmUmsyzGcWguXYGF4mEVRZgw9ZZUCRtKnWt3l5BFOJ4?=
 =?us-ascii?Q?cLbrPRfX4zbsywKhYBHgH3GFLdvZ4DfAPTJaIHd6Ghdndhf3A+SwKT6EZY99?=
 =?us-ascii?Q?DpH5EHH+gIr3mQEUDI+o8pp9NXlTDTc3VUYXgCF6iAnMzHN4oYeYZ/IeGmRu?=
 =?us-ascii?Q?0oCPYGFAS5Fnm6/OGuX/lWYwHeX+5hlJNlB2h+vvEyYOVH6BSMlC1X5U5c7m?=
 =?us-ascii?Q?Ng1gPBPNU2Llwigq+adUnp/P/7qjlH+WSKm50WDXWqSef+jQGadcnMo1uKRx?=
 =?us-ascii?Q?8dTiuRMhBQQrZ6JoY6155+959YjxrNGsYhPlhYsMxxmQqoSK4SxcDnq0UWAI?=
 =?us-ascii?Q?SFyofNitA4HpwhHnGM/xef85S2UfpYhxcj+qD0TKRXCS1UUsVG8+Ynud7kfd?=
 =?us-ascii?Q?geC4mWrfKpjE7hLyMiM7qkkPOT+i2RzTDFej0yBLHF8znohyj7MEkcwcj5JP?=
 =?us-ascii?Q?CzbFhW1DSGYf+DkrVWySsiwFrtg=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 gChIyKpnNnePTz9JEBcyACuLc10AjdKLWsfNLUsKmJjfq8mmLqCej/eiKC6Y22daUc/55PckCurbkQpSqOG8PkdNfJueJtFBa5DWWXJCj9O+lunLx9XKUrOeTkrO90rVxY5wv6dMM/T5OdVi4ZZbIA9i/swaPZO3oSS+yclZO3iZBimEDTOnPHFZ1JyfxF39Dr1/1Ha/9+OW0Qf1NjQ0X0+0piftMxRFg8H9CkZ7KbmUQvQXcpqWFlT+9qJ2GWucuBJMya7N8gZ82BdYjOAdtxg9deZndaBueTS3yzm3Is0POO9fvmORt9zws8gf9WIUReqYpPAVVkPiW0Pb78c1Lw3U1z6RwtK8u4XbOVhJGjwsCYIzbjTCTT7xhgi6fjUtfJuHTvergP/12PDt/lcVjL9ecorVb2wgBnRXy2IhWEnrwC3IN153bMjmV+oSjAS6
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:53.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109d7c8a-94a2-4b93-bd40-08de5e7a6690
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11828
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254291-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7F20FA2EBA
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on AccECN spec (RFC9768) Section 3.1.4.1, if the sender of an
AccECN SYN (the TCP Client) times out before receiving the SYN/ACK, it
SHOULD attempt to negotiate the use of AccECN at least one more time
by continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
the first retransmitted SYN (using the usual retransmission time-outs).

If this first retransmission also fails to be acknowledged, in
deployment scenarios where AccECN path traversal might be problematic,
the TCP Client SHOULD send subsequent retransmissions of the SYN with
the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commit message

v5:
- Update commit message and the if condition statement.
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 597e888af36d..b28596655d73 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3606,12 +3606,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback
-	 * As AccECN uses the same SYN flags (+ AE), this check covers both
-	 * cases.
-	 */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
-		tcp_ecn_clear_syn(sk, skb);
+	if (!tcp_ecn_mode_pending(tp) || icsk->icsk_retransmits > 1) {
+		/* RFC3168, section 6.1.1.1. ECN fallback
+		 * As AccECN uses the same SYN flags (+ AE), this check
+		 * covers both cases.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) ==
+		    TCPHDR_SYN_ECN)
+			tcp_ecn_clear_syn(sk, skb);
+	}
 
 	/* Update global and local TCP statistics. */
 	segs = tcp_skb_pcount(skb);
-- 
2.34.1


