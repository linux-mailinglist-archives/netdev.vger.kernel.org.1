Return-Path: <netdev+bounces-260671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UALyH14wnmk/UAQAu9opvQ
	(envelope-from <netdev+bounces-260671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:12:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C1618E1A3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4969D309F6AF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB9355023;
	Tue, 24 Feb 2026 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sPzxhZxZ"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021089.outbound.protection.outlook.com [52.101.62.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53735B137;
	Tue, 24 Feb 2026 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974676; cv=fail; b=pYbocCX+arIJoMpUMStHpc5E1Z25VcRHj5euU4lviaDBxr/cmCcTBgvZBEsGPMdRJrOeWCFcX+/gsj6jbUWGcYjRpEMBVbskiA9+V2hJIxh6pQPVq9Uk/uBDiQqvFmDHnhTDj8LtaxndfoNmgLZFUgc3XzPYxfBDpusFw8KpTDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974676; c=relaxed/simple;
	bh=roOieSuX6uSfna8UeDFrQGAt4ALCWwbuX7jhvNCvxFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/6pZyFZ1juyFvSn8xGFPzvQ8AwwrcgPnKH/Jg85THFK61DqVba0t4xAR1VR32LWuWDOcvDX2GRkmzXkxKpCCUWwNk/4EFfFkkHkt7MjSOTTU3fzrBogix5FYBAXUIL1CKSYteLEaBN9AI5nCsSBjRmM+5F+tcKcmmuEUzGppTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sPzxhZxZ; arc=fail smtp.client-ip=52.101.62.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0dbykHuq3vKDozPfUzJyIXmPZ282E+GFFdHbyZ0wbMK2ZRKV6kbBIwl6s2agzey0YZDfedu2tSRBW6BAMkZNHFx9lB8SV7IcyZmVpHmnGb5EW8SGQdXVMpcRzqescQSpVmuQwoxxLg5fbOcWAwQH++MdE3fVWjj8vsq5HO4P4I5Z3lnq2vOC0CxvsSKS6YUo64nGggEnWTjKlutrmvzp5F4w1TSlBxJ+jr5eonsNvN3QyBPf3k4bO5tFBVYlr9tQ+mUENRH8LbzriS0oa4sa5sef9AutQpAZ8RrnIzSFX1Te/g1P8X5D2APzT9SFhJjNEj9OBCLlJsHhwN2QzwAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HDQCl3GV8QZIEjD53uqi+aRkpWQjQgs0EQVHRv7hYk=;
 b=EHJkNEXHLpxyTJTDZ9EYPCj0Uo5hghvsrA73wNg2+E6rlmbAnrULUZzacWeodC9vcd7SfkQkVj6jUoaOq5p24J4U0wOpzlvaMEAAEw9cJR6UyVeDGKm2aP9SVZhZOpojh5pF2WWVldMLPF0I0NoKaBuBa80bATBRXOErCv8cSalN3jhMAV/IkJaR+9vCRnChCJU7QXR1HN2+QMOGo0mGvcG15GjNsq9PGYCctJWwZ8GsUj+61n7zMCmT5Q5T2qsvKMcnZO7hQ+Q6/0W1QglNVD2w5K87wp5hM6xGs/ZD2Gd1wean7FAxuz9W9r/QR7OMnoE2h+VeiaGEea9NhbhqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDQCl3GV8QZIEjD53uqi+aRkpWQjQgs0EQVHRv7hYk=;
 b=sPzxhZxZBMyMKcyX+M2Ngt9yStrDCLPn5FY3wha+PHxGWqTocHQR+hFayQAV9X9T1NEe6LaHBmcbp1a5SPES7o5fcYHquA+GJ8Aglpkltnhtf4oxa7ns/5W/ZFFPr5mnnwB6ewDsjJJmnhFLwu0TuTt3Skes3ZX+fQLC9Q3Tt3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8567.prod.exchangelabs.com (2603:10b6:930:c2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 23:11:11 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:11:11 +0000
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
Subject: [net-next v31 2/2] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 24 Feb 2026 18:10:52 -0500
Message-ID: <20260224231055.393329-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
References: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:930:4d::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a63d93c-3a1a-467e-de3d-08de73f9ffe2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|52116014|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jy301pCFqgsNRJyc5dNgTRT0hWMtqtiAbHn8Bt3KMPfXTCl/OQKHex11Rokq?=
 =?us-ascii?Q?aXori7ThF3MVciEk0m05yuiIa5ZTUB/8Wp5pgbTIYjw9ObdDemH6vMdvD8ok?=
 =?us-ascii?Q?JVHjddtfT/gZOGQcaVRz/quWIsptVJ+px0EG/ESRvheJqgmEsiwKy+fLPqGj?=
 =?us-ascii?Q?Cc0LZ5xKje3Yp+HYMKpCQgQnSbGnOBIEEEYQV5qtZW9SPLe8nRVP320CbCV/?=
 =?us-ascii?Q?czMJlAjtn+kqpO5YpH8C2UoniwBWKkULyf2atJJ3ta104NMK/NYlMpftgYd6?=
 =?us-ascii?Q?pmg8YTjPNNhMdnwq2DJKplXwvKbzgGvDStT+PXQdlm26MfS2oCuPDD8kBMMc?=
 =?us-ascii?Q?v0/0rE+HHKidPcGjOkmKQC9Wpn+FYJiC6XvIcY3A6sgQYBK6RPo6wBSxhaNN?=
 =?us-ascii?Q?oGHlxEsZtn1WDr6LKSFNKvK0cAQeLb4msLelJU7Gd00lYZuOn2Cxom8nvs3q?=
 =?us-ascii?Q?IBntKfjyvS1FXRZO+YjrcX5W96WfX16ug+tN8PBDlzetCMMGyGmEpNmh0px2?=
 =?us-ascii?Q?eiEMmN7ZTSb6omArnkbv/tSQlgvVveqbmad0o9uZxqG3EuQzcVGb5Cesakcl?=
 =?us-ascii?Q?h0USTsV8MfI3wvWHvpuBYzJ7tQs9KpUigpM2ddHnvx2QNcYEeBRpBVnzSNK+?=
 =?us-ascii?Q?dAq+2k7zhpp8jOZi1sIBm0UGCzhuN0PMPeiKwEBwNHbRlV4fdX+SZSPIbRDA?=
 =?us-ascii?Q?jkJFcmgjlDiCldxUdgF2VwP1jrw2bwO9ciRHw2YXuH5sANfVcXLIUXMZsrbn?=
 =?us-ascii?Q?jmIj7ahOs2lMypDnR46JWQHXXOxZWDBYDknD9aCQCZaAajP/CmOUUQMsOcv7?=
 =?us-ascii?Q?kCaFFOPxmFhfxTXH2N6hm1/45SdVEGzUCu8toE4sZuLSW+tRCyO5/CGVv+K+?=
 =?us-ascii?Q?UwG6bKLc8A9pnH5OUKA4aX3850O5XtEvtd5xOoldLDSvGWC8qpdZDk2ZwnoG?=
 =?us-ascii?Q?WpV3aefxrTBfEkWMEIo9gjCq5BLl1VmuAt8mQFxW1i8yCuMLVV9VfkPVE9C7?=
 =?us-ascii?Q?1Iwt5ZEwtstYmVKDEu7Su6nTiIWYNYhuJ+sFVOx4P5/dE8hUgbLEAEpB6XRp?=
 =?us-ascii?Q?zxP6uRbge4FOBH6s5PSCwTHjQ6hfPPGkf18I464MBS7K2ncneQ2ZIK4g0G6N?=
 =?us-ascii?Q?JV/ccQaT/STNjiLYoQSB8+MvF0i+PVvMukB1Olh4I94jpXibDZli5GlN5Ho+?=
 =?us-ascii?Q?qMDwXLgmUA+tyHgdQcd0i9R+ZUi3/UXJNAeN61lKAgD+wwHGEhQIxKczmdNZ?=
 =?us-ascii?Q?mIjqf/xes1FsP5iFVDboc1Hc3AQeOW+EE0Q9edKdFBqyzk/zzTQDxvB9utFl?=
 =?us-ascii?Q?2dqb4nm7b7zB9j6E6UhzAQsTfbN89ShZ0wDwsEn0/TAHb6L6Ih1va/tFt0am?=
 =?us-ascii?Q?Tu2aHDq0dHa+O1n/w94QBXy655Z8fAHCmwlilZrbfN42W+l1b1snvhsjvyxB?=
 =?us-ascii?Q?N9N3bngjdezzd1cam79YFYoqw9rd0D4ge/q5HdeoIeixaOWPyDagbZI1GrRw?=
 =?us-ascii?Q?7yxySIxoh6I8qFxd/kjTHPjlWCYHaHy5Feh1tdhpumX406o24P0bMAPfYvKj?=
 =?us-ascii?Q?7pkky6Q3H7LRq+f8jtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(52116014)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMZ4fePGrzj/700981OMq+iC0R4WhL8I4YYejzS4MdrfaeCxIoCVBAM2rBxQ?=
 =?us-ascii?Q?3YEhPhX9RYmm6+1qdPGyr9fi4iQRNbyPwP7walSo/MfmgEHC2l8Sf5MqjfxC?=
 =?us-ascii?Q?fY1RSAzfypPL8YWy+MvwAIjDFF+YOraAK1+xLSvhkomno1TXqyf29HHrPF0P?=
 =?us-ascii?Q?aaaYRXUzRTwv9Wyvdvulm6pZeOrXde4tkMsBP2Qng7S8e95+oXNiHieo8Ul/?=
 =?us-ascii?Q?HT2OhzHhx5vSdyvQaYRUqVhndENMYzTLq5mNhPoNF1GRFKTBnJ13F4xyZt6i?=
 =?us-ascii?Q?No+VqhDFRn8zzp8RD8bsR8DA/KvaemlFJGWgfJtcL8V+v1AOlt4sOOooYhlW?=
 =?us-ascii?Q?srvZ66P+22/kBlL9QqZOd5MwvoKAjSh/DAtEqknhLHQhtkoQhATXrQL0wwpm?=
 =?us-ascii?Q?cyu2nVqRswaj3jCNQjqPbPqlHiTMRS9sNW/0jZHGg6ICCwXzciO45EGzVaAG?=
 =?us-ascii?Q?AS8Koxfx0iypJf6XGEvRNyroCMshAaoYeuQSuuyg6ISrRETPbzzJ/eadOmMa?=
 =?us-ascii?Q?YPngXBDoKStdRmueKj2Ld2MQ+2t6IZhDqEZXeYQgNCjFyCyetbi+gK3Gq+cN?=
 =?us-ascii?Q?IaahWE8JITnBofWROnTzS7M1rNg88EeS6YP4svdOfVl21tzf7WlQ2QGNUcjg?=
 =?us-ascii?Q?qG+Fbm4RNu5gt3St4M/n95s4weus3OstY8bbc6LTo42kxxJjfTrLRPXUgayV?=
 =?us-ascii?Q?pIbFNAcaNk0Z2Lyfwao6YRuIqkZI5udh1xKHPHEqJG7nhQjpLc797kaKFkai?=
 =?us-ascii?Q?CgFZbXyBU3XlcK64nIWBE1IqAieUbRdz30w4xLdl/u8AtX2Iy+OZfYzJ1Zyc?=
 =?us-ascii?Q?Rx+G1sznJPZ9Y9Z/rlguhFzbmPOLmNhSob9pMdHyO8/lxX4mR1qp2UFKBLrH?=
 =?us-ascii?Q?NmG+Wa3iN5B6tefByIN65Z52TsTA11kqdhEdr8yvFlLP5yZi+Zed3j/tpbiR?=
 =?us-ascii?Q?xrg3yqWytwiw1Gj39/8DVMg853KyOqmM/XMepOOJJCfzeWBuY2ooxsnDjRPx?=
 =?us-ascii?Q?mn6Lhz8xUbrYYxp6i9L02eTNroTou1fSAu6NLybvAHEaT0+aKLRqAha1O1ok?=
 =?us-ascii?Q?KuTkP0w+kvTH3JA7/NveiI4DF5iZjKtKft3onepS8FDt6EVAM74vgMmO7olZ?=
 =?us-ascii?Q?5LtSKlMDlJg/vI3BAuLKzWZc+3Do1sgw4FVcfyt5or3M2ADP0sk+EsRsXqaW?=
 =?us-ascii?Q?vP/Uy1Q8TVqVJQMBXGsp5yWPWQWW+7UyfkISd+Qk9m4mGflnamJVISAWZ8Wh?=
 =?us-ascii?Q?VmaZppAEPtlksDZOn9oW6RsYdFE3xD4HX2wXq/V0UvWG8ThSzGZoO7Njo750?=
 =?us-ascii?Q?qI55kqP+BtBJIjBettASXIjcaZ6keCV9trmo65XY9OGWJ/vWQIXdvcFWEMRh?=
 =?us-ascii?Q?UKsLBF+4fshnfY4eqVaF+q2+PkHg0PwEcKYXS1bsWe+nYGDq51ZZ5O25Os+Q?=
 =?us-ascii?Q?pOU9Rf8kMZYzORpYcewi6iR5Ked/B7a+Ean2Qjmz3v4Ua80UNN14NopEAgI7?=
 =?us-ascii?Q?mAdocqtMS+5JAIzAWrwH3/Nd/3ALuUn92ENgBSdYft4DOrrmnIe4G0nlx4YI?=
 =?us-ascii?Q?OQhKZ1QESIjpwX/bxudjxEbLVi2U4/4zCdlToakNtlbuUU2vlQJh+5cUqYqF?=
 =?us-ascii?Q?sH3RJgOxHZWkmEx97M05CiyXhFf+IpG5/yIztLmb9Q+HLd9oSb8Tx9pjjmz7?=
 =?us-ascii?Q?Zo17tSIlte9dhV0FYx3GKMKeAIzc++MbaHr6mAkI5AVGyU/olbwSrU7DHGbK?=
 =?us-ascii?Q?3sOd1v3W/svwBX+6KkRUVjdPouNm5v60GMYym/lh9EubkUOYPx/Tw9wpYxlR?=
X-MS-Exchange-AntiSpam-MessageData-1:
	+UbG30ql2jaXlpu2QetRlAh6NfvuWA2K0jWj7i/gDFjFzjo1uMZBqtgo
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a63d93c-3a1a-467e-de3d-08de73f9ffe2
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:11:11.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuCivu35eUAyphbaaeO2xlfhJR40f8msQ/voqS739d/8k8FjfS5w8SG9bLH1nkxVLbVlG3z6EeefeA+Rgm0Yya3WL8HfRsy/45nbbLpEtYwSKNjSviAQ8DrJI17CVWFP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260671-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[os.amperecomputing.com:mid,os.amperecomputing.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperecomputing.com:email,oracle.com:email]
X-Rspamd-Queue-Id: D4C1618E1A3
X-Rspamd-Action: no action

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SSDT and reference channels specified
in the PCCT. Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

This driver takes advantage of PCC mailbox shared functions
management. Unlike the existing Type 2 drivers, the mssg
parameter is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox,
already properly formatted as a PCC exctended message.

The driver makes use of the pcc mailbox buffer management helpers.
These allow the network driver to use common code for the reading and
wrting from the shared memory buffer to the mailbox driver,
attempting to get a single implementation of the PCC protocol for
Type3/4.

If the mailbox ring buffer is full, the driver stops the
incoming packet queues until a message has been sent,
freeing space in the ring buffer.

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Bringing up an interface creates the channel between the
network driver and the mailbox driver. This enables
communication with the remote endpoint, to include the
receipt of new messages. Bringing down an interface
removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are
cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 323 ++++++++++++++++++++++++++++++++++++
 4 files changed, 342 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b8d8a5c41597..e90d8d5abbaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15293,6 +15293,11 @@ F:	include/net/mctpdevice.h
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
index 000000000000..d8fa54068bd3
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2025, Ampere Computing LLC
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
+	size = pcc_mbox_query_bytes_available(inbox->chan);
+	if (size == 0)
+		return;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(pcc_header));
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
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	dev_dstats_tx_add(ndev, len);
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
+	len_sent = pcc_mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
+	if (len_sent == 0)
+		netdev_info(mctp_pcc_ndev->ndev,  "packet dropped");
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	outbox = container_of(c, struct mctp_pcc_mailbox, client);
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
+	int mctp_pcc_mtu = MCTP_MIN_MTU;
+	struct pcc_mbox_chan *pchan;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+
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


