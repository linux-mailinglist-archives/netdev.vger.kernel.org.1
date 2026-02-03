Return-Path: <netdev+bounces-256133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFGUFpOGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:24:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77563D4A0C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7454630142A6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830D366833;
	Tue,  3 Feb 2026 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JIifO0y+"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67659366566;
	Tue,  3 Feb 2026 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096170; cv=fail; b=HB2j6pFPtJBQmE+7mq3aNshp4M5a82bOvIDFjaX+YUMRLermkOtrRWU+auP+saaQsVBeJ1Hu89eWQrWoVDo10BY/K00rIhBxdKC68/6ZNv/puRW7p20dl3eW6tD7R/J5ZqiUqCT4OyUpqNasjPQIOKhQIst8MFQcmT5/M3D1XtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096170; c=relaxed/simple;
	bh=eYQFgteCc08PaVDFVn8fC1DOblQYkwCrr/WS7Cc0LbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6XtP64bwfKVj4zIxNcBH52/gZgw4U0+zzIBoXGFLp5Hvu9HTNS/VZqfD4J/YRpgbPxLwAmZwagq3vzVrG9lFK5dcPm0nB/ImQHncD4O9b6vCYWGEZM8WvZCmeYLLS0+3DsHYOhyAEC31AeJYRhd5mnglekVVg+4DSr6m5r/QxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JIifO0y+; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daTlfRQx0Dfxmk86RROtXbR++pcNaE94PEeXk6VAOgLdKBMamjIzme3O51J1XSMeEbEK7RzC5LY9czO10uHMVvdAo4nSr0tcluRB7fiBTQBOOZYbjDNSYpRkNAvmJMocuhBcj04FJLiODqGgO4vZs4rS6wATvUSoiwnoQFmHtq/AygiWgjuN8hDbHXOVUzGP+QgTWg5dXE9czqwTGj61I0CAFrBfQXEUMSSFGqXA0Fi67F94YuuEt/pwN84Mf2hrdLYtL87vyG+Z+GkqJVJrmiVf8/r2NARAc8vv3I6CFAdQCQKJPLTfldRoLzNy40KDFKVrmkKUsmUJ7YtP15jtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loEcpA30K/RpAx1FvaU/7LJtk6s0WHOLoUZLSHrgrjw=;
 b=vi8D06LLLh/xqLMb8bETBGyS4QphRHOKQGK5VXLaC8U3xnQusQfpzjMgnhM6d+Z3LgvEd9Li2a7/+ryxRo8+/N+C27Ovf7fHPkVtTNW466wyuHE9cYJbzWlulE6Fha+HsOsal3+pEPzCUbQe+Um7ADXNelS6HC6p+X9UK3zKRPJ3rwL2/tXv2svC4AEiw6v6hUVXRHmNzQIygYrtD851lwsIDtguKv7a9kP9IKqfoTDEJqguswlgGFwgVGECVJzx0h/M+9YeaT+PMmvEtObOIsoacYwXG+Vnfat+UV2vEOIz452JdnS6ZzzJ4Qvc9AHLOO3dXnKWCgnZHiyWX/fqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loEcpA30K/RpAx1FvaU/7LJtk6s0WHOLoUZLSHrgrjw=;
 b=JIifO0y+bdQkAmb6ae/vAdfQPHaD1W6+rDV3LWfYla70TLKlDJfgMhHBF9pxaLM6FrefixFRmYOf+Y8ncihb2yif7RY7U7Yn5aeMmICz3kmTL306aHFUotGKgFG9b7RH9/JGQsRAT53qEWz7QYHvLSh+d/WTnc7cTDJ/hZYX93ZvGgMY5PstOQ8pUku/cWDbN1QGECWmW7LQzD6+lki6bvxmkCghQzCT0qHfomiZKemuOaQQBNL4Q2JVmDGXo8r1x3FDEZ6Ky/1J+p31DDE4BojBOVSb5Bru+qngTAc40LWz9ss02rQdMDRblWTW6bhoamnKH3vIxnFi6jserAaryg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Tue,  3 Feb 2026 13:23:20 +0800
Message-Id: <20260203052329.1085444-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 1699ce47-9aff-4b01-8ff5-08de62e442f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wRVsONFxN+KkBlj1oli05fxS03Ph6gAZN0PwG7voZpZLJmEFJ0ga5JsXZKOX?=
 =?us-ascii?Q?vhSQqfqqoKrxfLUr7Ann4CI5VhfsxWFnQxsNX4qp2lRebu1/KzRbdCVUeu8H?=
 =?us-ascii?Q?5XrfAb+jkSZQ8fKX7FVOPXdasQUvJz2XLyCT5QiB2z2chIH0UC6Yj3VaW0DM?=
 =?us-ascii?Q?+aaw6pf6L5vNuK6OyOtgcb8VRU2sSpMvHI475UHxTyu6PcECgkHZK7RzT7jl?=
 =?us-ascii?Q?xeMRDIaVmCUwhEkB/EGsrxMZEmP7zqhAXXqrJ+zjtkxZVsS0hL4Ht4CfWf+v?=
 =?us-ascii?Q?T4MZuzmZe1mJw/tMhOo9CRyUAD0CwJB7r4r6s0NUjfYuvBA6y6k22Lkza9AW?=
 =?us-ascii?Q?YRr+lFcxz7OUebK2sRfSWljr0k4SXs0G5DMRv0qTsptOyQBeRhlOdxkCmxNt?=
 =?us-ascii?Q?CvjsTszsA2k4OPolDfpTvmsB58R2ngRjjeA8FSy/vWxqJtpMvhImF1s+UmVv?=
 =?us-ascii?Q?DgMhpq1e2+U25yQ9i6fQUg2NfLOgPQByAKfJ6+b6keZc42WExhg13XBH6hCS?=
 =?us-ascii?Q?Q3uzptnALDyohfICva4L/L/L11etK+azpGfyEUcgUK9r5VjpeA3jg0ZS4SAO?=
 =?us-ascii?Q?q0XLgHbj5g4OBfGa0STKzKMTi0sYJMclRBQCynt3fJoKg8fbzU1DX69PImGq?=
 =?us-ascii?Q?n4BMyhVv5xoNqK4HDMCWLGPK51mVWVPsVIl+IgZoQR4RKPI62eZli4r5OhOA?=
 =?us-ascii?Q?/Wp4ZZ0/DHioDlnYvV7S5cKq4956FBWYvydDe5hyFU08VrAtsUW8tXmkSN+l?=
 =?us-ascii?Q?7HLngk3I79LJRkgxChUvfr0DI3sIXbIAgR8IfjsRmN7iEFU/x42jOf0t/H67?=
 =?us-ascii?Q?HhgGpWvscDE6ZUcv8cCr+cnhJg/HFS+FdRH0+HDp6HyclEM3W1iV31k7fp/E?=
 =?us-ascii?Q?YRBrCZeDWLw++/qq+4VRmXbr/rskaQ1DbcjcH377NA5WdxgQI9I8W6FhBUmP?=
 =?us-ascii?Q?eruuZB56y35HQpSvQxsuC14/BrpDG0YRXXiUdfAjZKCQS1LTJ4dBgVcnM80W?=
 =?us-ascii?Q?3CwwhY5zUnBceekrX6tRf+FUr0STFUehf92+M4mlRAgZCWpulHPCTD3gpnc4?=
 =?us-ascii?Q?sxD2LQWJOppH6MEA6yUbuhrl2Hxhoet945TB+oc4okAcfJzyIpsZdPuzuCtQ?=
 =?us-ascii?Q?101EM35BAwuSPSZKMjEKbfGaNOKQB20RhXHbo9wpHyoUx8pEuu3bZ9i72Ae2?=
 =?us-ascii?Q?E6W43+Q6cpFFL7jy0EBXA2tFGUeshJhvPOxItInv+W0E8/9SbTuRb6vADkdW?=
 =?us-ascii?Q?ltN0mPQfOmuC0ROW7jDJlOxN3KCeB/QVRx1eP2S5ZlHBlHo5RzK6I+U9lpEn?=
 =?us-ascii?Q?S/5a+h4xEoxAbKS1R0/tVXKUpbYtDzNbV1tTh+R3Z7x1/LQC5R++5DVX9tYD?=
 =?us-ascii?Q?RIBbMib0okuGIWJiuyz1BJk68BKyzL+N0wAvsoBHHDgZx5cg/rJo0LOEbykj?=
 =?us-ascii?Q?VFDuZEEsjfuCPVdBTW8q+Q61DeMAlwVhW0KaL9aAI2mpy3q8l1tMyGmzquXm?=
 =?us-ascii?Q?MDcCnFWftoSSLTRGjc+NYZUyfichKgDeZp/Igt9DUqN9zIn21z9s75scmwGY?=
 =?us-ascii?Q?AEvHqcaJnO2fsw2UtCpYLc+mKws6pcAXs8dhizyG3/5S6w0LzRiwS7QeKNtM?=
 =?us-ascii?Q?xItnmpDcq1PZPKIHj++kq5Aiu4OeOVGsXEa4TjyQ+XK0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hrRoPptu0GiT3kppRhkjDYRlOo+GtSKvjrzupLWGrkQms5GBfg5GfKtJdpe?=
 =?us-ascii?Q?PJIKLw7pH8G/u/jnwr1ymJ1JK0LYf3wpReFB9TeAwKgngw0mb6Uj8k/i10Jp?=
 =?us-ascii?Q?DensmmH44MOx/wJ0j2jQt/icHspfYpXsDzS/LVZQaE2voGWzSdLgpZ1KNoOu?=
 =?us-ascii?Q?c0IiT5RNM5Ubc1s0hUpJY/EzJmWw1wISodie1it65VO1mv1nu1JNFOyjveyn?=
 =?us-ascii?Q?pZ29FSadLTmN0w1zd73OD9wAAvcJx94Ut9nhB7pYKzNNIUGguooT0nalXRsh?=
 =?us-ascii?Q?dsjt2HxY3Tsk+UumZqKiiFZUZAXI+rNFm7GH6HBBMc3n4PUrClaC1uoVOOJI?=
 =?us-ascii?Q?waek7zUzhfq5l8bC8Ebsw/JXPecOqmV1/pe1Q9Yfg3mCRbUoQrtnFBqeQJq2?=
 =?us-ascii?Q?W8hRAkw/MdWhD/stylCUygvPOBb0CDBsFJdErHGLDFIyLuTZvC5BAPU+7ebO?=
 =?us-ascii?Q?c4cDYYKf7xFM/WAXWXo858n483LmlgPgstbgZxJI12d2ev0ed84w9g117An7?=
 =?us-ascii?Q?A+KN4cYmMq4sz4GTqHwwflu/BDBo08XrwXf18Kz1LJwDWh6Dt2ZU6m2BUhJI?=
 =?us-ascii?Q?wB7LS/WgPMJNguEUR7X7JUJPgy6vb2FmF1vCIF7drUKF5fZP0eG0smFa9VVd?=
 =?us-ascii?Q?oeZqWMQ8LoMbRKkU/lt8mu/Ky6LxsAY1ROE/MN8LlHqavGcTlSdvAnz6/sTG?=
 =?us-ascii?Q?IkEjL8go6tPsd5TqI+y52JlHG0fPeIqq6Lk0vcks1FA2qJ/93SQ+CUrfgad2?=
 =?us-ascii?Q?q+7uKnRrcf1eXw7IvT46aq9rxuAJ2tnx4RDOE3wbvcsyNATxVI4agLudC778?=
 =?us-ascii?Q?2qcRWsbj+TuJZj9apbqA04t/zdOZNFljlrmO3Id3HBsS3WfyJODNB0qso6C2?=
 =?us-ascii?Q?jn/eROkCkdKOlzlpzUsREaCQ9qsstegcoTRgoXA1Faaae//znAZyreTa7L4V?=
 =?us-ascii?Q?dqs00AVSWSpOeiGZfVQmRPNI9sEfTHwN85rwza6kXN5zwF7G3laRgWFOKCJZ?=
 =?us-ascii?Q?SDMXG4XRw1xBmFt8+KJQ/83sfiNpyU1a2+pBhYu0vIgzszm0TePuIRlC3Atk?=
 =?us-ascii?Q?S05PrItcHk2YbNibe5FsoiwxPY9AWh8rExMx9AxY8M0vBewNKYt9rhmIVFiV?=
 =?us-ascii?Q?n/9yXg6PMKSzU63aeH9en7OybW9aogesviZjE2YrxfO1pZh1LfuASTqF5qPa?=
 =?us-ascii?Q?XYvnZ0rr9ILobKxRUZH2kHOz6bjm5RkY0RDiR+TKHA/Q3FmHxndDVNCLg/mF?=
 =?us-ascii?Q?jCB9jpZxl857BvohJnXa7Cnu2Egcezz8Fxz+/j744RBZKGJEH5OI55vZhPe7?=
 =?us-ascii?Q?MeOe46CjPt9HkfkXH4B9zsBiwMPVdtDivh/GUcgflfpBkIZSG3rq5A0m2MMP?=
 =?us-ascii?Q?wRfz+RVh1MK2pnj5aisQyOYLKX7YqmORMvcY8+zmo/YmVVhNtWqyRFUXEZ2S?=
 =?us-ascii?Q?mJrCfJKUEynhsBMQbUNKTD8MYyb65VPuu8d8SB7VZ14YBxPShHgvjfYcnCdQ?=
 =?us-ascii?Q?kfw5FUrXELprQKFmPdQL8uTn7r3Jio7r2v1LT67Ff/UP3V4CA0lFBF6wEeuS?=
 =?us-ascii?Q?wX/7N9nX3A6gpp+3iONZvQ4vWJZAuU5KTRfpfcd41onVzWoQSGPgDVsaLjXu?=
 =?us-ascii?Q?SSdIIAeohx2M/1rkBNJu1uwVWVCLoqSujb4pz5BJVyuNgFFrgkSm61ry4SE6?=
 =?us-ascii?Q?f2ObiDRr4w3NDC0iTrGpmJDCy88yKgB4cV8BbH+lJe/KTKje?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1699ce47-9aff-4b01-8ff5-08de62e442f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:45.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByRF22avVuGH5En4sdt+SjwWXEZOiseKYFW+dbwYPCgVIrVqtxqpcYa5aFhWZyx3pSe9jNnMViy4SNmrkXQEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256133-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 77563D4A0C
X-Rspamd-Action: no action

Currently, the processing of XDP path packets and protocol stack packets
are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
confusing and debugging more difficult. Furthermore, some logic is not
needed by each other. Such as the kernel path does not need to call
xdp_init_buff(), XDP path does not support swap_buffer(), because
fec_enet_bpf() returns "-EOPNOTSUPP" for those platforms which need
swap_buffer()), and so on. This prevents XDP from achieving its maximum
performance. Therefore, XDP path packets processing has been separated
from fec_enet_rx_queue() by adding the fec_enet_rx_queue_xdp() function
to optimize XDP path logic and improve XDP performance.

The XDP performance on the iMX93 platform was compared before and after
applying this patch. Detailed results are as follows and we can see the
performance has been improved.

Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
BD ring are used to receive packets, flow-control is off.

Before the patch is applied:
xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After the patch is applied:
xdp-bench tx eth0
Summary                   409,975 rx/s                  0 err,drop/s
Summary                   411,073 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   700,681 rx/s                  0 err/s
Summary                   698,102 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   211,356 rx/s                  0 err,drop/s
Summary                   210,629 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 255 ++++++++++++++--------
 1 file changed, 169 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7bc2eac01e6e..aafde4378f65 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1666,71 +1666,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	return 0;
 }
 
-static u32
-fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
-{
-	unsigned int sync, len = xdp->data_end - xdp->data;
-	u32 ret = FEC_ENET_XDP_PASS;
-	struct page *page;
-	int err;
-	u32 act;
-
-	act = bpf_prog_run_xdp(prog, xdp);
-
-	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
-	 * max len CPU touch
-	 */
-	sync = xdp->data_end - xdp->data;
-	sync = max(sync, len);
-
-	switch (act) {
-	case XDP_PASS:
-		rxq->stats[RX_XDP_PASS]++;
-		ret = FEC_ENET_XDP_PASS;
-		break;
-
-	case XDP_REDIRECT:
-		rxq->stats[RX_XDP_REDIRECT]++;
-		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (unlikely(err))
-			goto xdp_err;
-
-		ret = FEC_ENET_XDP_REDIR;
-		break;
-
-	case XDP_TX:
-		rxq->stats[RX_XDP_TX]++;
-		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			rxq->stats[RX_XDP_TX_ERRORS]++;
-			goto xdp_err;
-		}
-
-		ret = FEC_ENET_XDP_TX;
-		break;
-
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
-	case XDP_ABORTED:
-		fallthrough;    /* handle aborts by dropping packet */
-
-	case XDP_DROP:
-		rxq->stats[RX_XDP_DROP]++;
-xdp_err:
-		ret = FEC_ENET_XDP_CONSUMED;
-		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
-		if (act != XDP_DROP)
-			trace_xdp_exception(fep->netdev, prog, act);
-		break;
-	}
-
-	return ret;
-}
-
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1843,19 +1778,14 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
 static int fec_enet_rx_queue(struct fec_enet_private *fep,
 			     u16 queue, int budget)
 {
-	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
-	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
-	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	struct net_device *ndev = fep->netdev;
 	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
-	int cpu = smp_processor_id();
 	int pkt_received = 0;
 	u16 status, pkt_len;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
 	struct page *page;
 	dma_addr_t dma;
 	int index;
@@ -1871,8 +1801,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
-
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
@@ -1903,17 +1831,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
-		if (xdp_prog) {
-			xdp_buff_clear_frags_flag(&xdp);
-			/* subtract 16bit shift and FCS */
-			xdp_prepare_buff(&xdp, page_address(page),
-					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
-			xdp_result |= ret;
-			if (ret != FEC_ENET_XDP_PASS)
-				goto rx_processing_done;
-		}
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1962,7 +1879,167 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	}
 	rxq->bd.cur = bdp;
 
-	if (xdp_result & FEC_ENET_XDP_REDIR)
+	return pkt_received;
+}
+
+static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
+			 struct xdp_buff *xdp, u32 sync)
+{
+	struct page *page = virt_to_head_page(xdp->data);
+
+	page_pool_put_page(rxq->page_pool, page, sync, true);
+}
+
+static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	struct xdp_buff xdp;
+	struct page *page;
+	u32 xdp_res = 0;
+	dma_addr_t dma;
+	int index, err;
+	u32 act, sync;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		page = rxq->rx_buf[index];
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
+
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
+					DMA_FROM_DEVICE);
+		prefetch(page_address(page));
+
+		xdp_buff_clear_frags_flag(&xdp);
+		/* subtract 16bit shift and FCS */
+		pkt_len -= sub_len;
+		xdp_prepare_buff(&xdp, page_address(page), data_start,
+				 pkt_len, false);
+
+		act = bpf_prog_run_xdp(prog, &xdp);
+		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
+		 * for_device cover max len CPU touch.
+		 */
+		sync = xdp.data_end - xdp.data;
+		sync = max(sync, pkt_len);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			/* The packet length includes FCS, but we don't want to
+			 * include that when passing upstream as it messes up
+			 * bridging applications.
+			 */
+			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
+			if (!skb)
+				trace_xdp_exception(ndev, prog, XDP_PASS);
+			else
+				napi_gro_receive(&fep->napi, skb);
+
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, &xdp, prog);
+			if (unlikely(err)) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_TX);
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			/* handle aborts by dropping packet */
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			fec_xdp_drop(rxq, &xdp, sync);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
 	return pkt_received;
@@ -1971,11 +2048,17 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
 	int i, done = 0;
 
 	/* Make sure that AVB queues are processed first. */
-	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(fep, i, budget - done);
+	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
+		if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
+						      prog);
+		else
+			done += fec_enet_rx_queue(fep, i, budget - done);
+	}
 
 	return done;
 }
-- 
2.34.1


