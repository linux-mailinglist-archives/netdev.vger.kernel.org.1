Return-Path: <netdev+bounces-132468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15271991CC7
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D3A1C213AC
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE316130C;
	Sun,  6 Oct 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="pPrR9mPl"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709B54F95
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197311; cv=fail; b=FMyBpUDY3Ki2p4ClaUC9Kjpu7EAvPQQFui4MNvwkdpm9it6rk9m4ECZpZ4okNEqIGNPVLKAFu9Xhp557V3Xo8tcoaKC7Y8oolhqM9ky96dszqGkbF1DAFHVJNKb+iaGWSIcM13jx5Htpm4CAX994PBti+tzJSthwjjvU6rnt6b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197311; c=relaxed/simple;
	bh=JvphN2tHvGEP4l5B6iOwskSoRZwepwlt27mJn6Db2yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Blk3P5GL0pIQK+b+WOdxCqzdyBFv8qcCG3gwVsplO50r/hozbLfZWvte0wC1RFX30sWm/41BSUMhy9iLizTFJ8Rea/TIRhUv+fU3lbhhg4b4OxmdRIy/Mhab0Yzlqpk3uRUZpC7xpJ0llwhVaHMowTxDInsccsrbHFDSzH9fh7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=pPrR9mPl; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9A845340055;
	Sun,  6 Oct 2024 06:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2ZdXJocV17ySsK+AnCMrP3SXbaWAM7MYur0TQWfWdHcPLOXTUZG5b8dXuCXL5FieoZZ+oypA6hjJEKv/DCuwS72fMyDxvSnYCaw+A7nD/mvzeEK7Jxx/RhwfqMRYS9KGJjkspBW3YI3ktOqmQuaW1zOkukU8EqpHHIjQEo+inqLAClysDoodm6/sN+xyjKIBWVaVNh49pSaEh/PHx9icdS/qOxB4O8gpOxa7vleYhWm4bzZIw4+aJlBTCjAH3Sw0fSoG8v1Cp/jOyHkZvFh4W+NlPaTQX6SKV8QugH3mye1b8kkFOQ2v10hmkyYB4qB8TZXkMolxvqP/ayyKp+AGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+6xHYszBPQ1eYv4BVZFNZOqgd5UmAdnuIjA3StBy98=;
 b=KraoI2ntflIDDjhoUlRjJ5/TJiDJNNc9FOsrnSt9GbZzaA7iDG2y9cAJY7tqJViN8NAIEJMCG35SFWn8IFblI9kCpbOXSUez6yTlytWhIWNbpbxn5zx/HonGnHEnw+U/Z/bmsa3SFQuxfRyPHrYc743YXjvCF412+VUh4h4SESh40rBFPS94dMDm0N9joreJ6QI3tYJ9Ut9ZoSs2lCiRwjl8EvkasMHeNSBC5lb8dIaD4mao01sXAs9PaU4EKyuYi4PJ6TLRbE1voe5x7GgbBo3L5IRm1JTDI6/nba8rzD5GcLZBa+1qqttksXOZwjFKh8CucUpDZ8QwG3Ko8Db4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+6xHYszBPQ1eYv4BVZFNZOqgd5UmAdnuIjA3StBy98=;
 b=pPrR9mPlvmKbaw/fJARZRc5mJlGCpt68Kyt3vQMNfcoF7+KztGS8IVkIGqPQJOEb2zscsUNoq9nB7UV//G1ewHB1AcYHqfwze3tPYuqPGJzYUKni+3wvAUTUPx2N9/9Z9tOfss893SQBiphFz7y/b/jMd8Ixrbp5K3Y88QqasOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB6324.eurprd08.prod.outlook.com (2603:10a6:20b:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 06:48:16 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 06:48:16 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v2 2/2] Create netdev->neighbour association
Date: Sun,  6 Oct 2024 06:47:43 +0000
Message-ID: <20241006064747.201773-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241006064747.201773-1-gnaaman@drivenets.com>
References: <20241006064747.201773-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: d239fed3-b445-4f6f-dbc8-08dce5d2db39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGP48KOss6jwWzQsupsxTk3TeOuRrsY5v4nNGLiIVmRFyArVY0t0U3k/Kb5Z?=
 =?us-ascii?Q?nAEAP4yIaxEvTIlFwejRJozgk2fKX5tcp7c3Osf+bEbKxOSpnFnSngngjSEt?=
 =?us-ascii?Q?vS2utOQUY44Q1TlkO6WfAwlFNeqKv/tSveDbbvdFX2+oVWcrHzoi/hrpK0yS?=
 =?us-ascii?Q?3wzcWkOcvE00Ifon1xGlg5qVTnw+leTA8F7kwwB/j9MEnMk/gTkFxfj0zekv?=
 =?us-ascii?Q?MnfN4UVmZskn1hLjiXA+e7sfVqNkGidjmozN79KTeW72BjfI5xKmIHZZbI2b?=
 =?us-ascii?Q?txw+Kw+d4z8/XbODFRz/Fg3A3gz3Ahj48zkVKIxr9ndUfz83I0UapEAs7HHt?=
 =?us-ascii?Q?PMz/kX7BM3D7nXPFFLlomlMANAX2Ckv9jm8IdQq9I4QvkWbUiGfOwpsAzBVl?=
 =?us-ascii?Q?RYYQZrCExAObWbAy5LhBiIYefVz0s5HxCjk7KDA/gWTZSrjTyV7uDKtBl7px?=
 =?us-ascii?Q?hYwyWNCpxMllTJcdMwxmS/AqGqylRb2U3itt8z67dROCEquu5rAFFFaaNNdx?=
 =?us-ascii?Q?0ExWnjqOwvpiZKiyGE/2LizvjWczQn3hhiDhYcsqUyWMfGZtIfS1qP2Wkuk8?=
 =?us-ascii?Q?6V0hDPDz9tEZ6v39tCVDVvrJTXuPoc3ebC349yTdp88Pbl53T+EGpEpVcMTo?=
 =?us-ascii?Q?emVmTwTz304fYkpJZXb7FkoniUflvN6fFGJv24YjZ13TtFdiII7GE1mjxSG1?=
 =?us-ascii?Q?qHYNaaUW3OGd3zPMUdVFGAC+Y8ZQyqreDKlv7V/Bp9ScCJZDdYMtTURV1os3?=
 =?us-ascii?Q?a3ox4fmhEGYsytWWH+cisxxqUh+d6fdoEn60IvEoIlyBCqFf4+2MhcCXCOnk?=
 =?us-ascii?Q?0aypya5JxFRPaWJmc+UWZAg38xM4wMjEsJ/iWxjZWEEROxsJKn+CR2Mzr2bY?=
 =?us-ascii?Q?lYmbkmENBp7rjuIRen3eG4owD5xo4/vC/+TduZ+pIdxudWv2RirVE/ykflvY?=
 =?us-ascii?Q?a1p/GK0kEJMJg1PmxxYhB0wtmXDf0g8y9Ohw8htRIODwnPlvrUYxK150nmc9?=
 =?us-ascii?Q?lhl1EoDxt+PBlFqfGWMTIzu7HTAu7iCPSfiAtGMO8mlEmC+ha8gLdoTdcrf7?=
 =?us-ascii?Q?whCnb7BsLLWHV3fLYdIsoTZUa8QEgINFaMUQNfsAhEHUC52pJrDzIZAoyG3J?=
 =?us-ascii?Q?7MBWopd1IvmohgzI6Epz/I0AG0rPI1qIRZ3NiFxerx1Najxf26OqazU0vp99?=
 =?us-ascii?Q?+FBXUtW3YU6YKkMeB1k0nGB7rDTzzDafYw4Jrre+qZ1jW0MtzdNaFs6Ryik/?=
 =?us-ascii?Q?WUJ/jigoPIWtQ7UpVSlfQshHAkgSIFApw/SKJLEl98M9y0rq3H8cVQ+f1ICJ?=
 =?us-ascii?Q?Bcq3UyeWTHxG0nWER2dAKjNkexKrbOZPVhzeLsn/uAXZTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dh0/tdPt4ID1EoKIXyQudbdi4enezgKsxmJ+M/LHdUsIwgUDTn9bu0x33Vsf?=
 =?us-ascii?Q?1VeWhPOrZ9ir2UwdKxFysbL4ItJES/ucvRmE1KrTkrRM+xPQoevuBePwMUk5?=
 =?us-ascii?Q?ZD9+gfD68jNjCo84TK2KbpgiSHI8cJjd92IB+DLIwjon/wxJo7DmQ8EVkih9?=
 =?us-ascii?Q?pkc0maoN+i8u+CWMmgV6/e3I6WJ0qABjmcBPCNlBYiblyziSJ8/1igYlSBnY?=
 =?us-ascii?Q?HmgxF30RX1Rectbk/isNAGaWCjdehj6pL+Sjk4YL2fgZi7HMnBiUhk1Lo8v6?=
 =?us-ascii?Q?CY7g4p3TO1FRzmv0vvoqrQ89fG1UDR7k4KzTnSCI7/NRiQxYc9mo/fvHm87z?=
 =?us-ascii?Q?LFRZifDJIiKGU5Y7JK4SIHUwCb4HmsZz/U5PRMY+7ScyMbgod2R/yepmo521?=
 =?us-ascii?Q?DNJYVcDAbMZ5p0vZXC3ywT+zGscd0ArEEsopoim+MUeZCZovWM+2lNvPs6/a?=
 =?us-ascii?Q?BR+RZVZ1vsziPddlIp/1bOANqHxOVp3oxCSlVYjAecnD6qWLugmo+xYhmPRO?=
 =?us-ascii?Q?rtIPmVD0P9iFYL7RWtvXzrye3l4GUcdDjZhPHnnR8IecoEf7u3cHKrJXTbjg?=
 =?us-ascii?Q?vMLXHVhGLSG3a8DjrV2otcsMd/fR5lzMqK8TsZ1UJC8BId11CppZ6L36xzwP?=
 =?us-ascii?Q?ccx6rZv+h0HJd4brI5J8yHHN1Zonlk+q9wRhzO36VJ5Gev9k6wKEHSwlp9Ol?=
 =?us-ascii?Q?Vtw0NQe2NpRt+5Aebc2Tc9d2WzZe6PGyZ3seJgPMLZ7D9U4+VAr/y9Q3CANc?=
 =?us-ascii?Q?HOIscTr/lfkW2hydMLNgjt1pDEu3ni+bVU1UDjAjEFeosJwGuxshck8sOtYn?=
 =?us-ascii?Q?QG4xUsubZIL5Ix79jT8KJpV0BTRAvF7m3tkbuUXc67HJ9hmF7ADRGMeJrkfK?=
 =?us-ascii?Q?b/oRgIyRlhXQQc122zFQBD/dICJ5+5F/B8oZt1Q82Crm3iDU/YspMSS29nxn?=
 =?us-ascii?Q?lwsh+4ulYESJXdAPBW8dB/IDnkUA5IrG7Ssq3BGnnwnFMF0gn/8ElC6yYNFj?=
 =?us-ascii?Q?aAJB6tMgKiwlr2gmktVsCqDDjIlZohk0cLYN393VMcCzZqXh0Q2O95BM3q02?=
 =?us-ascii?Q?GtgUJlZ0/qnnkNA8ufc6ZYHrbTWAXBZGSMruLUaRwnfQU6HAhv7HuVHnjfWD?=
 =?us-ascii?Q?GnKqYwf2fy1Dkh8LhMJeoyJyU6ottNPrfeEmgyRzA7JDQK1DfzVisew5wFrT?=
 =?us-ascii?Q?9NOuxvZD56MFWL5TP9nAMPHxRn9bbZ9CgIj/9hvHrMbelY21bIH6D97jeBNF?=
 =?us-ascii?Q?JB2qlbSchDG40DY5TKXzbHtxQItf6LUh3PZq99+hZB/zizO9SZIta7rZ6blt?=
 =?us-ascii?Q?8gEb4cpSsGDOfROuzP1kcKYY4DsQRfPT6UbQoNL+wL3h+/bI3OYadS/ZI1Po?=
 =?us-ascii?Q?iE9I3aOigg3UBGhb49O4hETD7YNJBRrTDr2sulzLf4FmGBSnnn2GpK6Ikdid?=
 =?us-ascii?Q?bL8QFVY6ci2uPCF/Z1oUMHC6klt3P4VFUkvqxoQ0fjslI4QEWNGsOpRHF0n0?=
 =?us-ascii?Q?mjgYM8VNBpbe2otaxTUpYnQ9abbrrMFXpF2nWb3MVTEVR+GVrhHW/4EWLdM+?=
 =?us-ascii?Q?vixdz/I5QnRFE01rE1XEvy/WEyrDUfRXOucVDC0YvoDNIqtvQlebKQjwuSQ/?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zWTCukFrAF+avADgZ1WpSmTAp5UaL5H2HH76HFcXc2PuDz2w4GxLb7dK/5KQhmf/BKNpI89SjQ2HYPqUgGLyk5bDrCJhqYDeheZDEevgE4p553Tz+idYhFKcA8GuVh8aMTzbylbs4Btzqub5fRVX9G9qeiAE896r8CBCwET2hb1cw1/L+0tAf7e4V5RxoLTgl03HTXcE1D+FMvHIXW/3ffy0QT5eSc0oLOrxi1nP0T/F/ssIikbeeKOlUq75F+nEQ6WnZPRwfsAKbO1pxoXOKWi9lCQrygiHMUkh5mS8PWV3J4+UbrKFLnsLi9rnz49e9M9A5iEA1AXm6vwu0d502KUH+/KQPn1CcV1n7w52y/oHKxITwAsSlz6WS6QAZ760Da5gR8zRvSDyKuHv7LVLYJc6iBcTTlMS6x7yDehpffP6Ji6opH0TKMbhhdBAqPIla/fECzLjJWkl1+X+onYbeuZv5sYPEc/rETXcS2KuPUzE9kEyelhrKQmPwjoqXZmh0KZA99e6YGnOf8QhB5QXUOQLT7tmYyH8hkg++5hoFW1gUKDLmckaVsdpa0lf93Z5e6um2rqR9MDDgJfwQFM25r2fnXacIgFsZ9q2uJeGsgnLL/2nhjPUydCjUTa2kt9+
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d239fed3-b445-4f6f-dbc8-08dce5d2db39
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 06:48:16.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pUyy8WzMcgEwTGJopYhGznHr7QDDRXvazmH5hWifw43joAmgjtrw0aA2VH/6mhY8Po/BdEBdbbHOjtePMQvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6324
X-MDID: 1728197298-KoP6iQgRSDeU
X-MDID-O:
 eu1;ams;1728197298;KoP6iQgRSDeU;<gnaaman@drivenets.com>;18cd01b0b368a0fec4275fdb61cf0c87
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   6 ++
 include/net/neighbour.h                       |  10 +-
 include/net/neighbour_tables.h                |  13 +++
 net/core/neighbour.c                          | 102 +++++++++++++-----
 5 files changed, 99 insertions(+), 33 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a..510c407d7268 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,3 +183,4 @@ struct_devlink_port*                devlink_port
 struct_dpll_pin*                    dpll_pin                                                        
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
+struct hlist_head                   neighbours[3]
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87b5e488325..071b89c56e07 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2009,6 +2010,9 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
+ *	 @neighbours:	List heads pointing to this device's neighbours'
+ *			dev_list, one per address-family.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2399,6 +2403,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 5dde118323e3..dee5c6337fb5 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
+#include <net/neighbour_tables.h>
 
 /*
  * NUD stands for "neighbor unreachability detection"
@@ -136,6 +137,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct hlist_node	list;
+	struct hlist_node	dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,14 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_DN_TABLE = 2,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..ad98b49d58db
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_DN_TABLE = 2,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 86b174baae27..608f001e320f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -62,6 +62,20 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static int family_to_neightbl_index(int family)
+{
+	switch (family) {
+	case AF_INET:
+		return NEIGH_ARP_TABLE;
+	case AF_INET6:
+		return NEIGH_ND_TABLE;
+	case AF_DECnet:
+		return NEIGH_DN_TABLE;
+	default:
+		return -1;
+	}
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -213,6 +227,7 @@ static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
 		hlist_del_rcu(&n->list);
+		hlist_del_rcu(&n->dev_list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -355,12 +370,65 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 	}
 }
 
+static void _neigh_flush_free_neigh(struct neighbour *n)
+{
+	hlist_del_rcu(&n->list);
+	hlist_del_rcu(&n->dev_list);
+	write_lock(&n->lock);
+	neigh_del_timer(n);
+	neigh_mark_dead(n);
+	if (refcount_read(&n->refcnt) != 1) {
+		/* The most unpleasant situation.
+		 * We must destroy neighbour entry,
+		 * but someone still uses it.
+		 *
+		 * The destroy will be delayed until
+		 * the last user releases us, but
+		 * we must kill timers etc. and move
+		 * it to safe state.
+		 */
+		__skb_queue_purge(&n->arp_queue);
+		n->arp_queue_len_bytes = 0;
+		WRITE_ONCE(n->output, neigh_blackhole);
+		if (n->nud_state & NUD_VALID)
+			n->nud_state = NUD_NOARP;
+		else
+			n->nud_state = NUD_NONE;
+		neigh_dbg(2, "neigh %p is stray\n", n);
+	}
+	write_unlock(&n->lock);
+	neigh_cleanup_and_release(n);
+}
+
+static void neigh_flush_dev_fast(struct neigh_table *tbl, struct hlist_node *next,
+				 bool skip_perm)
+{
+	struct neighbour *n;
+
+	while (next) {
+		n = container_of(next, struct neighbour, dev_list);
+		next = rcu_dereference(hlist_next_rcu(next));
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
+
+		_neigh_flush_free_neigh(n);
+	}
+}
+
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
 	int i;
 	struct neigh_hash_table *nht;
 
+	i = family_to_neightbl_index(tbl->family);
+	if (i != -1) {
+		neigh_flush_dev_fast(tbl,
+				     rcu_dereference(hlist_first_rcu(&dev->neighbours[i])),
+				     skip_perm);
+		return;
+	}
+
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 
@@ -379,31 +447,8 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 				np = (struct neighbour __rcu **)&n->list.next;
 				continue;
 			}
-			hlist_del_rcu(&n->list);
-			write_lock(&n->lock);
-			neigh_del_timer(n);
-			neigh_mark_dead(n);
-			if (refcount_read(&n->refcnt) != 1) {
-				/* The most unpleasant situation.
-				   We must destroy neighbour entry,
-				   but someone still uses it.
-
-				   The destroy will be delayed until
-				   the last user releases us, but
-				   we must kill timers etc. and move
-				   it to safe state.
-				 */
-				__skb_queue_purge(&n->arp_queue);
-				n->arp_queue_len_bytes = 0;
-				WRITE_ONCE(n->output, neigh_blackhole);
-				if (n->nud_state & NUD_VALID)
-					n->nud_state = NUD_NOARP;
-				else
-					n->nud_state = NUD_NONE;
-				neigh_dbg(2, "neigh %p is stray\n", n);
-			}
-			write_unlock(&n->lock);
-			neigh_cleanup_and_release(n);
+
+			_neigh_flush_free_neigh(n);
 		}
 	}
 }
@@ -686,6 +731,11 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
+
+	error = family_to_neightbl_index(tbl->family);
+	if (error != -1)
+		hlist_add_head_rcu(&n->dev_list, &dev->neighbours[error]);
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -969,6 +1019,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->list);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3092,6 +3143,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->list);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			} else
 				np = (struct neighbour __rcu **)&n->list.next;
-- 
2.46.0


