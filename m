Return-Path: <netdev+bounces-251489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKKrJJIpcGmyWwAAu9opvQ
	(envelope-from <netdev+bounces-251489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:19:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFC4EF77
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BBCE905C69
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC0B42E01F;
	Tue, 20 Jan 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p2KvMF4B"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC427436347
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916224; cv=fail; b=e5OFXxv9BjxxGR/svLbkajCxLOIBq15laAfZwQkgxEo+sSN6wOu4GUo+QVzdmCKwyXYqksc5WeOQgeRsmOSOEntfLX5ftTzlTtBEU6zBtLhsXmyc4L2MIFfSwwfEjrML/76Orvb1qnrj7PLfuVuoeknazwpHEXOWKoqf8mZXIGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916224; c=relaxed/simple;
	bh=lp8TRzCbryobFOw5wbUQ80LQoTuBHFyGP4rk6EEqqqk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=po4gl/+tfrjBY22G6YfAnbjVCRQE3vZSG7jykmak04eUJcmTIzeBouFTzl6ivmW7wsj1U1jmmYPbJSYGmbDSlJI7SW8uXqzGGrM/IBPleCikkvKLW7bYx8LvNeJ+pW1aONdPIbA+AC35p8/nkhiyqp5FQ1PN1YQqIGkcXb2+8Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p2KvMF4B; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtcgQ/N30oAZVUJjPV5AONfN7clfqbZd2Pukz1fT7L0hdrKSNQePYMGmz/sKs28CaTWGKtk4jRRbf2gfzaqTnA/SOgIT1cCqasCiLD3m6jL340xBzhI+exSpuXSS83unJczICkMMbwz4iSlveijNUSYgHC9dkpVzNKrNF2r7fzDzVxXNP58ijAC8BXtWJCnmm/vtxHautoHIq6yvsqtQT0NY1/EauW3PuBQ1yIpGzlPAV7VzH9u27lXUW6RY2kCloP4JV41GEEEIbyO3IlYS0RwNfO1MA4r2d+qkkpnwF21fxuS3TzszwTYqECYandoHzFtonj1GZeoEcoCu1iSVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp8TRzCbryobFOw5wbUQ80LQoTuBHFyGP4rk6EEqqqk=;
 b=nOEmpqdCbXtrhTibdnAYIaxghz2lcWgV5s200uXhWnJVl5AFEOTLM5GMFluYSUrtjcxUzzEOG7RddH8BkY9Ubcbxnfxq1DJBuvz2DnWb2SAI8Q1bUvb/bpg0gRp4xNyRfavdr2w3ZPjU6BhAgxcN9Z4zf9BQ9ckqy9QipOUCokDE1oHYsugDwaKtO7CPpgyAMvrP19rFFj8uvIMCqmyjItqT61DdvGAfAFW9bnH/FzBf94XSPninusbklQL4BI2vYGU7JX1NpwzR+Y2gviN3G11Sw/dWf2XBNqIOIY9nW7DLqdTnp19TFBm7GIR0L+y82pZzpp79t1IIgsdiQ8epew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp8TRzCbryobFOw5wbUQ80LQoTuBHFyGP4rk6EEqqqk=;
 b=p2KvMF4Bf9bbORQay8pd3hKI2hdPJ0M6FvR6AdyCWIIiXeNzYi1ER29M3eSPWktTjPP7jswsdw2QnHGPCmBAH0bV4qZiWDytfz7ryyyOP7+lmOetm0k1f7kQHhPxOTTs9yMfRFILExn/MIlNl/5QI3h4S2P1ck2diQuzgf6t0e7Ha8I/hoJ+/q8JmDbKxp45a47LGeSVUqhkxcUGRPqpJOuZfMCUo2DnMB6qexfUIZH/kDmnrbHgypB8WX1F7ICf3DYq/iIDDH+hmuMUJFcZu51KoYm9Y1xeZm1/FKUWWbaqlZcHwcTTjy7xl2zCMjv8cIptabAVVemnC+lzkWoBsQ==
Received: from DM6PR01CA0005.prod.exchangelabs.com (2603:10b6:5:296::10) by
 CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:36:59 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::af) by DM6PR01CA0005.outlook.office365.com
 (2603:10b6:5:296::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Tue,
 20 Jan 2026 13:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 13:36:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:36:47 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:36:40 -0800
References: <cover.1768820066.git.pabeni@redhat.com>
 <e3738b0f-a18c-48ff-993d-eb8a1e989dd9@redhat.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Simon
 Horman" <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, <sdf@fomichev.me>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <idosch@nvidia.com>
Subject: Re: [PATCH v4 net-next 00/10] geneve: introduce double tunnel
 GSO/GRO support
Date: Tue, 20 Jan 2026 14:30:11 +0100
In-Reply-To: <e3738b0f-a18c-48ff-993d-eb8a1e989dd9@redhat.com>
Message-ID: <873440iexn.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5333947f-46d4-4987-a7c8-08de5828fca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yWciT5XKkUH16dmm/2dJdsASBUScAKIFARKPAZLuZueKpZ4BWRLFvFnrhUM3?=
 =?us-ascii?Q?mvj/bEZXruD44T62tARz677hUlL+47NgTNix78Z8Po3pUKZ2H2lZWruSNDIz?=
 =?us-ascii?Q?VB1GM5oJbGEez9/oF5dHq0qPiqEqBxmFTNhAejNhdtS4ZzFn8rRtfMsS+2rq?=
 =?us-ascii?Q?ZwpTNSXl5DoWjcQ5GE13PTQdpnpBRhJKblMnBjsHje23sCQ8AajVff0OkeK6?=
 =?us-ascii?Q?Ym0ORYbwtDujW8iTDILO9nyPH/dKWc7X7RDfLI5edhp/BAJBtGkrcj8ZLPgw?=
 =?us-ascii?Q?3QSV9r1+Uzd7dg/FEdpSpVKsbVQRzoWF7KlUzFFqZ0gHS9ddEFtnnWTztaji?=
 =?us-ascii?Q?AkVPrO2shNxDPEG28BgW1qrTxcxuNCJMIBB/AcBUBYpslWIV0++Hd3f+Ei5c?=
 =?us-ascii?Q?gB5NaQLoBz1l0G3/kQ2hehbMQFbP3tDEQcGpiJXxsRta+DvLwqszLNfTy1T7?=
 =?us-ascii?Q?ZUjIhlrOIt3njqYxi1NJ6e0Y0otP92WOFyF+k6W9hScV3E1IIAfjPucHrgbD?=
 =?us-ascii?Q?/eQgp78sHOex6zo5gMKinV6HvdaVwb8Fre+YR9ISi6e308LWmStzjN4Xo5gl?=
 =?us-ascii?Q?cVwBg6MZ7RjPEXUEEZ6jvP1JXP9MvNrKKK4z8QjDPm9ncbzFzBrVRM2a2dVf?=
 =?us-ascii?Q?kGoD4BsB+ZrS/0VsNx0cOBpgyDwS81WcS09Rg1jgNUPpBhDNQY3sGo3zpP/+?=
 =?us-ascii?Q?1hX4ktC4KZKOJHStE7dV8C8K15oFIIL7ZD2dCRmfWhTZ0Jy7SoQOpqXRvPkq?=
 =?us-ascii?Q?slicXzlVXcYgpKsrqVi7VOBBI+QhRfHvYlKXz941O2BJBC4wxsOp0vtG5VP3?=
 =?us-ascii?Q?Bktxe04Bkivw5AUGv57QrakqnsFa647ORyT4+EVGCKkULgn62GuNrnYRTQI8?=
 =?us-ascii?Q?KxayVNXa5bmQIMZoRsvUeG6cDd3h5Gb4FDjUk2xfFc0s1FHE0C4kkcVV4zha?=
 =?us-ascii?Q?87EMEmtMekScCn0UN2Ku9lqlsS1A0SNgZsfBFmR5xUmWQTmKuxyFiNw4F0Gq?=
 =?us-ascii?Q?OPbXqXnITEvrjYk+btZpkQFn3knVQijZdrEZv6QJyzAhDE8uMWO3EW1g81FY?=
 =?us-ascii?Q?I2ziNHiiDHp6KnFZ8i4c/uLiOlbP2HvF/SdHfnplsMxPa5HntMQWt5f5+Z0I?=
 =?us-ascii?Q?ZxMdQdUoDgu/ZSiGDIQEEHyeezyIt4HMlL7XAX8b6bLzxyRwX9qx6mYfdtcg?=
 =?us-ascii?Q?ThzhUHDrEBpdQp3xWkcMdhKvM/5eKfdSooujt1fGC1631om71z4o4zwCX7C3?=
 =?us-ascii?Q?UWzAlf3bUVEOWc1dnV51sCFxQ104JV+l4rva3CJXHUFUSCdyvqbAYxBUM3uG?=
 =?us-ascii?Q?NAxWijntyy2Vheaw0uNVxc2ynKsxCXVqgZigoZky1+qeg2PgJaQb05RrD/PC?=
 =?us-ascii?Q?BlangWr1DerySis3Hx5IkBolkyJCKi8z4FX4TQLpy4KfMWn0AnzWVv0Wufas?=
 =?us-ascii?Q?1KiYvrBM56xLXiOAarOHZ61zeT3NusyCOmXa015NIxcG1uooJFmDxzYbgVPk?=
 =?us-ascii?Q?VCv/2srg/zucJOXb2w8KGW79U19PmrDJap0ft6c2CGZ5g9ZqEF26SULVLNjL?=
 =?us-ascii?Q?q4MI3OYR/0/bWLxTDRjNibd9nmpzp4AKUijldH918al6zyevwL4LGMHHUhBl?=
 =?us-ascii?Q?wtoMFHej/cpdvrXEaeCuemYSDkSjQnLGu+Vg8DokzAlk9saJ9JAeb+0Kt2qD?=
 =?us-ascii?Q?K5u3hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:36:59.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5333947f-46d4-4987-a7c8-08de5828fca8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251489-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0DFFC4EF77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Paolo Abeni <pabeni@redhat.com> writes:

> It looks like the last 3 patches did not land on the ML. I have no idea
> about the root cause. I'll wait a bit more and I'll resend the whole series.

FWIW I didn't get the last three e-mails to my e-mail either. It must
have gotten lost somewhere along the way.

