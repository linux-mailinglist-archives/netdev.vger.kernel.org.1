Return-Path: <netdev+bounces-254819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAViL1Fre2mMEgIAu9opvQ
	(envelope-from <netdev+bounces-254819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:14:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31DB0CD1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 412D5303853A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3247385EF5;
	Thu, 29 Jan 2026 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="rFJWtAAg"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023097.outbound.protection.outlook.com [52.101.72.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2026CE32;
	Thu, 29 Jan 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696039; cv=fail; b=FvRm20WVgChF6wzXDV3U+eyfGt2uqW+tBqM6Tk8jG7bS8tQ/RXBFuZc/x1H6+k1eCgF9k8VGUSsCkXlVfMMCkUE0FHpyqKT4FKDvB9mHnnDDg2/eW7A9CiOcZdfIopa7jTZ9pyEbjZOhoSUBmZPQXD/Z6aEG2i87urg8rUW3HCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696039; c=relaxed/simple;
	bh=aF27avC2cWLvVf1ZLLmaha93ryg8yBqyxLMO1TGNdtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RmJQ3qQdJ77m6wQLwGY992i8mzahyNZtYlRf4a1eJuMxtm7B8q6dM7QoSr7EW5cNJJWcDsqm0ssn31K3mnukXkOQTSacde6U9AwcZWYd4EM4717AbAUXx/nyh2Zp370QUtZ2SbIB0XMSzwTPwtPvYZYuovd/Gbsi//d2k4TGPRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=rFJWtAAg; arc=fail smtp.client-ip=52.101.72.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJhN1FY5vy0IjfZyW95SSDo8CjdCnXitmtehzy1ldupM3ccKHMoZcReEt4AcY7YySXh2QOZbxHQ9kptZZNNIEsrRPvS1TDkfUJBgqUz2BZoBY2v6AtgkqK6e97NJ3QyL3HgESLYzJKjxMSmFnL5ai2H/cTVMWQe9HBADTa5KVNnabUaFSIlniJBx4dHnT6WIw6m8xl6ffflPxVP7hmd5oRIR7Y5aM2g2mcW0b8xuBgdWeysLZQvK2xzJNiU1KzLE4Mn6kph7eGDDZklkcnPPicCP7IuFRN2g4Y+IWe/Od8p8srOb0/I6FzmwvuaMNp67TIcJbNAkAD2Cn0ITot5iDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ersp46l+1Yc2mshzKSHqCk/9sdREOubyry+2lUGIpNk=;
 b=rDA1av1oQGSdhAo3oBZp1zRxAPaGLVt7EEToXPG4h5K0hJcfjLVgErcAK1RHRXVn3J1MpwLrIkqpSZIxJ9W7bm1EX5AMb5z609aT3nQS0AE7jVpNM2EA20gUy2vttYB3/Z04+gksPg6VtvHrD0i+XmtpqfYZWIp8HJAj3rRrHYNGyTCP8kwhq2w0EO77E+d9tCgP7AOMf7VC0wSuolF1aqfNkrn9EhmWSJRqlfxlS8+fKdrMMVw/iHndVozPBmvlGziS2Bpy2S9NthczYSb5YZquYnP9EJeWRkNsymfT2Xkp8DaqMZK2Fx8TNYKp454u1LspiUMAVMKl9d0GSaGaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ersp46l+1Yc2mshzKSHqCk/9sdREOubyry+2lUGIpNk=;
 b=rFJWtAAg7szNWDI3gehgyNmNCr2Tl1adhMU6rXoziaPbGrtI40Ifj0tTbcusJAG92L+fUMGle8CUK/MRJf6EN1jG1P/ZlWKfTLEyPF9DhJztbjHfgorvk9qWPNMR1ZrPzBMv3IMvyau7kKMgMbHs26KCYMVyFTnINF2YksOFUe4hf9c96GyoLvRkpNR5LOmM0LLMRejiFJ6qdls7G3KoPv2CLTtw6P3s8LK5xwXXapuP9h46mqaea5qb32Tm+Io7o3VVkI7RNmv/qWhhYe1dbV4zqOaTWgCzCIbSHTY2hnucU6I2SDR4ap6NjMaO6auneJZmunXj8H4Ml4XpO8U89A==
Received: from DBBPR09CA0039.eurprd09.prod.outlook.com (2603:10a6:10:d4::27)
 by GVXP195MB2030.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:16::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 14:13:52 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::ff) by DBBPR09CA0039.outlook.office365.com
 (2603:10a6:10:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Thu,
 29 Jan 2026 14:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 14:13:52 +0000
Received: from llp-tremmet2.phytec.de (172.25.39.70) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 29 Jan
 2026 15:13:51 +0100
From: Teresa Remmet <t.remmet@phytec.de>
Date: Thu, 29 Jan 2026 15:13:33 +0100
Subject: [PATCH 1/2] dt-bindings: dp83867: add binding for
 ti,output-impedance property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-1-8deccd658d16@phytec.de>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
In-Reply-To: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>, Benjamin Hahn
	<b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
	<j.remmet@phytec.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|GVXP195MB2030:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8ecaf4-a233-43d3-b07c-08de5f40a14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnBxeTRWL2tvM3gvbnJUWHlmYjJMb2RkQ0JCMDU5bHpmcHZnQStYZzA1V3Zw?=
 =?utf-8?B?K1E4WW5nN1pONHNtNE45Q0txOEpvZ1lKMHd5MnRyU2FDYmxSNnB4Q0x3WkpN?=
 =?utf-8?B?WVRCQXBLTHZrRmthWjUzQ3orcFQ2UjQ1RVdUb3dOeW5WRE1oK0szMjA1NkVX?=
 =?utf-8?B?Z296c3ZCNnFVMGVyRGxrQ2NSMkIxZHpQbDRKK1NlZkx6blZiZVJGUXhLeTlC?=
 =?utf-8?B?d2FvT29UdXNYdmJWaTE3YUFBZG12cDRtQkFCTGREVzY1QlkvTmFsSDF0N09q?=
 =?utf-8?B?eWtoajlaYWY4L040RDllNHFQdWd3ZjVabFU2RitNVXIyUjJpVFRBRzkvOWtI?=
 =?utf-8?B?Y2xFMGw1Q0tiTUtoenJiUzdXb2E2TWlSdXVYTUF5YTVURWx6OTBnWlZaWGoz?=
 =?utf-8?B?d2ttdzlWK2tGSEZ4QzV4bXorYS9DMy83em5KK2pKbnYyRDdNUm9XamIxemZx?=
 =?utf-8?B?NlRLVU9BNTdEQXovRFVYakUraGVDUVZyUHJ2Q0c1d1YxaXVkOEU0VmNmVURX?=
 =?utf-8?B?MVlEMVE4MVVDVFpHUkFWMkJiR1ZUZWo2Y21OUTZ2ODRpVW41Z2NvWmdOV1k4?=
 =?utf-8?B?WGo3T0t4VDBxbVR6dWdsSWdHUFNvZnZCSks0RmNXTWJEU3lQaTEwOHpZNFFS?=
 =?utf-8?B?MStJSWFJbGVxbkdNYVpnbWw4TkxaSFZQNWRUZFlPcE1UeUJMaktuNCtreE5i?=
 =?utf-8?B?ZUhnMHZzWEZVUHUvSWJJaU0rMVkrS0FvUm9abVAxSGtlbzJlSjZrOUNWYmdB?=
 =?utf-8?B?RlhOaEgzNFE5SDYxOEszVVJ6dHFGNVlBbFhra3FYZy80Wmd6MDB4b0dRQlVP?=
 =?utf-8?B?Qk4vMXhOUVF0OFd6YUl3YU11NWFUZzVFRWdtdHhPN3Q0NzA4aVd0Y3pCNG9D?=
 =?utf-8?B?R244Z0ovK05aSUk4dU81YkhNVVhZcTJ4Rzh5WmVzcEcvUEJNZDBwL1dwVFpt?=
 =?utf-8?B?ejlDTWhkU3l2bG1KWTd5cTNNNEVPMy9JUllqTnV2S2lxNkN2V2I0Y29HYVZa?=
 =?utf-8?B?Tml1RUpaMWJmRDNualI0cUVST2dHL2s0OUZhSWtrSXU1QXFPYjNJNWhhR1Fn?=
 =?utf-8?B?UTZKM1VWSXgxOGYxL1R5M1JCQ01sdTBmY2diSEZ0U0FYbDlQMUpld0FIZGg2?=
 =?utf-8?B?VDdUZ3dIZzNURkFiY3d3ekMyMWJhdnFBdFRWVVVvSkxmYVNTWExTMkJPeDlN?=
 =?utf-8?B?SGxsMGtYTkRGbzk0eHV0VDU0S2Y3M2w0dnJpdU1FcUk5M3hSSE9UYXVsUlp3?=
 =?utf-8?B?Rjg2cVh3NkttV3MrYmxvTGEzMUc2ai96THpNb0tpNFJXWktXNkNTMUdYaVVo?=
 =?utf-8?B?MDBCNmhjeXFwZWNaMGUycitjeUpiSitTZjdJcXFLRUxmQkVtN1RBRW1YOUpt?=
 =?utf-8?B?cW9mbG1GZjRwRW9kOEhJNERCNmtDeHZLc2ZpRitMejkxWlphZ2p5Wk9YSnZ4?=
 =?utf-8?B?QUpyUGp0SC80Q2poVkZLUWtHNEcwbUxDbWtzc2tlUFBwaktuQnpPSzlKaUlY?=
 =?utf-8?B?NzEzUW1EN2N6RE8zcmJMNHBxb2J5b2pjd3hJL2NTM1hLWllnSVU3WndGSjNJ?=
 =?utf-8?B?OW5Fa0NEd2Y2Zy81Q3RzRHdKZ1ZKdFZJSzhOUmNtQXY2T3ZpYXN4SHBZUGFw?=
 =?utf-8?B?dlZSdk1mN2hLTGt2dFh0SmlJWnQ1NUJKMW9CclBKWXl0MW9CNHd3YjhMeHNR?=
 =?utf-8?B?ZWVybmFQZnp2RmJ6b1RzbjhxZjBiUlk1ZFRlWTBZaFVuNEFWMG9sc1hSS1Q3?=
 =?utf-8?B?ZmxVM0lnRW8yV2tMWUpRbUpacXpWbTZqa0NOSE5TMHhkZ0dEaDZrWWhQclpW?=
 =?utf-8?B?VDZFcHRqU1JyRyswaVI5K2hiQTdkcUFtcEN2SzBpdUNMSkVxblNPNy9uVVVm?=
 =?utf-8?B?ZStUc2RscFY1K3h4d09XSXpacWw5cnIrMjhhL2QyMzUyYmFrS1U5NDlyQXdX?=
 =?utf-8?B?cmtPVW4yRXYyZzRBa2VqUDJzQXZFYUloYmtvZTRCdW9EQm1GZmdpUmcxeGVr?=
 =?utf-8?B?WWZubVRvU1R3RGIxb05maGJhamhKMXYrM1g2aGVyRjczVFozWTBDbE5Uc3NY?=
 =?utf-8?B?Z29HdERTSTdZdVZMOThXVG1scVhlN2ZKUi9hUW9VdlJGMFhZcFBHTGVRNmZ4?=
 =?utf-8?B?eEpYbTVrcjZzV2UrNGUvaWxwKzhjZkZrMGVpbnZSODZ1Zy9qRGNETzRiWWdl?=
 =?utf-8?B?OGowangxbCt3RTNwSEU0MWFDMFl3aHEvMjJFZ2d2Nmc3Nzg0cnVJbzByK2VW?=
 =?utf-8?Q?cQs7oAZwfOXr6LKnZJLc5iCwUuokANIcL2HxHd/hoU=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 14:13:52.1322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8ecaf4-a233-43d3-b07c-08de5f40a14e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[phytec.de,quarantine];
	R_DKIM_ALLOW(-0.20)[phytec.de:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phytec.de:email,phytec.de:dkim,phytec.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.remmet@phytec.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[phytec.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B31DB0CD1
X-Rspamd-Action: no action

Add an optional device tree property, "ti,output-impedance", which
specifies the output impedance using a raw register field value from
0x0 to 0x1f.

0x0 corresponds to the highest impedance (approximately 70 ohms),
while 0x1f represents the lowest (approximately 35 ohms).

This property allows the impedance to be configured through the
device-tree to any required value rather than being limited to fixed
minimum or maximum settings.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 4bc1f98fd9fe..a8d8bfb68bee 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -52,11 +52,20 @@ properties:
     description: |
       MAC Interface Impedance control to set the programmable output impedance
       to a maximum value (70 ohms).
-      Note: Specifying an io_impedance_ctrl nvmem cell or one of the
-        ti,min-output-impedance, ti,max-output-impedance properties
-        are mutually exclusive. If more than one is present, an nvmem
-        cell takes precedence over ti,max-output-impedance, which in
-        turn takes precedence over ti,min-output-impedance.
+      Note: Specifying an io_impedance_ctrl nvmem cell, ti,output-impedance
+        or one of the boolean ti,min-output-impedance and ti,max-output-impedance
+        properties is mutually exclusive.
+        If more than one is present the priority order is nvmem cell,
+        ti,output-impedance, ti,max-output-impedance and last
+        ti,min-output-impedance.
+
+  ti,output-impedance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      MAC Interface Impedance control to set the raw register value from 0x0
+      (approx. 70 ohms) to 0x1f (approx. 35 ohms).
+    minimum: 0
+    maximum: 31
 
   tx-fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.43.0


