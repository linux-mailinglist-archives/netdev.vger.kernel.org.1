Return-Path: <netdev+bounces-135785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2B99F390
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E30A1C2264C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B971F76CA;
	Tue, 15 Oct 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="FVoUfgdE"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526001F667D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011593; cv=fail; b=fgziS9VvY5/Gk7sP3tN5ioGHjZTLsFVqg7B6noHCiemGNXJcaZ/W37JJ0dcDZ3GKjw5MYc8NaYnkkTeJfLeQF/KNAZ2aFdXAkHy+IXr78WzQL/r/yj+wu3Sm9lAndPyyATw/GV6KVbeWQSyTkEp+qRieb6tpZuM++e9Zm27fke4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011593; c=relaxed/simple;
	bh=KLcviuSR7qOU6Iqfm4dXaNmdM6pWgpDZBAub0TQeAzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U6AZ5Swf5JY+XELO+sQKYvM5O8YlJ4nAfVP3SMh1UTJSdpBrDgxmMQetfwRJWh6rtKDn59/2WdZnLf7RGL7Bsb1eSu2fGEkAVbvudfGJVsHJdVbGoGksFsFFdEovJp0ONu0LRHGainzP3sSO5hNBfSnM9OjmgmMdny5xjlkKyDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=FVoUfgdE; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AE2001C005B;
	Tue, 15 Oct 2024 16:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG7G60D21D/98NdHvbIhhCh+5fPROhlkWVvi1KpqRDGerd2iEc6ATC0GbOHjz4KJCpHymJfkAGcFHJ1RN2r58B4cnevTFrLg8NQLHUCrDLxHZagQLO+Lo24zZIAAAHxnGlDAeE9CmdHIbLhDz3/1CIB/lzkVUoF2/8I8xfVOmY6xdhn7x8BHO38irkzZTBQKj/shkEKUXasxYksmWlUWkBc+t58PIA77q/TiOxUuiNNTasTMFZEWC3F6QnamSjmYuXMc56xkL7uXnqus9ouj6ezIDLryPpRq9+72etX5Fv0qWyKVpnSSJwjYq0EHdaKLMxZT4nJaGIAnIuQoJ6WHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/LbQSB2dkWbqfmG31+kNjxECzuQ7GZ3Ffhkit2kWdk=;
 b=LaaraZB2//Hdkp+xEVd5s704mvpHQ/wtq1oMnWXO5iHMwJCgaHJrMtTYBSoC6rrBvvlL/MU8Ti2acqXpR6VlGW3GCxXOLQ0BWRDJ4DeHpAwgq8eXZYYWwIywUq7teIlmN2OJjHB/mkuA/BBiQf44xFekF0WXw8ud2dRxF1pUTuwXUllCXyf/mLPQ/hd1gpADH6ggLSmeW6Qsegzm0/Z4PqOXiKfrhzjhnyB/KQYbKtT0lFibdnk4+qGSFAFmBkFRfBx/Mg8HtB1OsWXuZXvaQFeu6FUnTBwf4MHge1VyWWD5q/zKGmtoAoD+Y74f3It4QkTLytDftpkXuTyn8BS30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/LbQSB2dkWbqfmG31+kNjxECzuQ7GZ3Ffhkit2kWdk=;
 b=FVoUfgdEsVIzw/sKcKVuu07BdQe4B7Wj3k0JB9qOVFploNqzkX70/32o3Sj107V5jG/iX9/e8N91a4BUi3rq31vXXmX8CsvWZC4uX8MNPKJqXbrYz3eRmsNpLufedAz1gylHMmNY9gfZ+9KVUhJXxkqefF3Zu/9Q2p/k7qUQWCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:59:42 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:59:42 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v4 1/6] Add hlist_node to struct neighbour
Date: Tue, 15 Oct 2024 16:59:21 +0000
Message-ID: <20241015165929.3203216-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015165929.3203216-1-gnaaman@drivenets.com>
References: <20241015165929.3203216-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db612de-30b8-46e0-f4df-08dced3ac344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B8/9A/JutDtmHQAGFwflAh2u4fh+U7X7LyocGCahAlVkZUksfkMmQEf5emjh?=
 =?us-ascii?Q?Bp99u6tVp6jQGCiDNGSiphuthu8EPscK4tchuWFT0BK3ceYaFepy2mgs2OkT?=
 =?us-ascii?Q?+l2OjBgCYShkApGfJOEZuz7oh6r0HEJ6r0JOnymjuNHgIkTSGIWcXERX+AO3?=
 =?us-ascii?Q?V+gGE1iszY/sL5+Tytx4/MjgjDSmuqjaNOOlLLEdGI//EHb+b5+Aahu/NVLj?=
 =?us-ascii?Q?qfbTjGdK3v1N+K22yARuFrCRmxsGjR1ibyiikiLzP3kBsYaJXFtserfA2dQk?=
 =?us-ascii?Q?SuL3IiRql6BrWxb44fzvi7r6pWsKry2S3adYu22+ssYfgNGLsrKcJfp7Bbmy?=
 =?us-ascii?Q?XKwk2ZYvSiIIZUGztljVwNbtR07OXkqsnIiFegQfanDR636LpaKgMlZoWaar?=
 =?us-ascii?Q?OTnY5f7p275ba5B+mIFqnzi7euOyGEIoglhkUxIeW4XQOrPNKqvD6kkRTJeb?=
 =?us-ascii?Q?wkHoVW9rJZl5Le4POESghBwcRXH8ShJsjX/49M2g1kuLryeRuAgHgoUnhUhK?=
 =?us-ascii?Q?iWBF6U/QOc6qH7mKMVtqRvoazM/5ZhbDIeLOn1jfQs76lOEXXscpiy8b+JK9?=
 =?us-ascii?Q?m9DgxxYDF0bsyCMurCsjbywh7TNcbQMJ29sChjuZ3C8dgkXXl0U5RdI1WgAr?=
 =?us-ascii?Q?n/h/ZmEO2EzLJ4CQ/JPbzrGXxIinuWu89MMz44YHMVLYswJoP/wOdLyd8VmI?=
 =?us-ascii?Q?Xhkf0miEOPmuyTgzB+67V2eh08tR9DwvAvoZvufpmnnGGdHIrie0it66vQgz?=
 =?us-ascii?Q?QeEtb2fou05IoBW/Pq45YryRbBsNG0hHV/a9wuvdZ0LS3B/7CXT/zQpB0RPZ?=
 =?us-ascii?Q?W11rSpv8p+bfUczQntCP+ID77uzYA6s4J80t3we2JF9ZjVAMoeeT19JYNSa9?=
 =?us-ascii?Q?SGCZmvle/wrBGyEsCFEn6+tuKJ/fBtwaCwCaTjUEemWVqWeFMIrUEJxaRJD6?=
 =?us-ascii?Q?OggTI+djEKKWh91nfyK8wEYRsHJ3K3TYHV1/Ud5Jnr4lXrKKQYC3p5I7H8X+?=
 =?us-ascii?Q?u2CrjyQabglWOgI3KZGJ2dao0IkJ3BTcn4igeb0ltzSdpn+pYWcNmncI6etc?=
 =?us-ascii?Q?Sgv0oT054gDyzz5o0FElo4/WtmtmIfRIHn/KrETCXMooqpyQv9Hu40Ie+tq+?=
 =?us-ascii?Q?4EVTAfRB+i0nAIFSdF8FqJaaqtL51PgS+kWdRi3LOnqcUXCBBPIreDsFWQAZ?=
 =?us-ascii?Q?bZQeCL6YWkFwQkchyr1Rwi3c/Uig6eQbyUjEjBIlCCYm+YA9XXNd8a4CbdyB?=
 =?us-ascii?Q?7EdQq+FS/19ETwtBRgcTeID9SqtExAp4J5RlE+4mDP9pNMTJzwu+CpETceto?=
 =?us-ascii?Q?ahy7aE0CnDLyVnKtJc7D2cnq2FN8lB2LH2FKUHyTTVUSOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tT/Tzny6EqrIlx/eJ3DCPPQRjbHwnG+StNFdjBvvIY0xZ0b5BJ+927ByfMdT?=
 =?us-ascii?Q?iDcvZIjlAFTqEp0q1n40J8yXZ4e09TyiJpLOd3Cr5DybIqTLGsQymSbyjZL2?=
 =?us-ascii?Q?k3CngwCbS5it0aXvN5LASlCjLCx6q0xEx+rggwzfcz8TR+NQ5Ojb8mRqpwwV?=
 =?us-ascii?Q?kLoPqBhwVSQKTcNipa/7aAi0Dz2V/IicUQWBEiOGy4EONIxWGUo5qvtin38l?=
 =?us-ascii?Q?HBB+qPJbAjaQQcxvVthD034M7yVyW3p0UtvJgJPmmwdduNulaWUSz6ArhXPj?=
 =?us-ascii?Q?9qWYxBMRDFVoReFqPg8svLC+j/IbSZXwhErH51p6M9nxW973d/cOteoDb2L5?=
 =?us-ascii?Q?CJsCZbckuCkk/28EEoBcJ+UY0Ido06p/0rPwA9uzGzDTPIg9gGIY6UiE7Eh9?=
 =?us-ascii?Q?nShCNG2HWM5h7f0yrpGDS/QpmfYX0L70pqseM7pyh9+VWUTbGp7+D0r1+pOb?=
 =?us-ascii?Q?XJheEawX9VjvT/eGHab9cZPgI3jqspWkBucVoZzSEAehVVn12huhG5YK/saE?=
 =?us-ascii?Q?Ua05wxow/gGZ80KZFe3iKKUv2npSIwhGaLXwxCeoMQFOGUQKjIGsIlWgXaYH?=
 =?us-ascii?Q?4Xwflu6mn1h/nLG7ITZbjS69IH6e7y7ZJ0w4+kOLNJg0a6t27eKCh3EgxFVd?=
 =?us-ascii?Q?Vc+uAE8qEp98aSPE0NFDwvgWJZoJK8cPD2xAFRUvKDxV1d3bddsIYok1OlMU?=
 =?us-ascii?Q?6hj4gcXOqRi5WHjAoAqJXLLkRaDRFX8nA9IvtMncD+TyCFYuN+j6j6Eg5bhk?=
 =?us-ascii?Q?38C+Dg/dS7GNauDZYFErEN5+swNwm4bRFIdVOhwCsXFR47+YLoZ3PxtCdUrA?=
 =?us-ascii?Q?v3mGWVcwOVh3wPdwYWllZOaH2SryDwqaqU5St3dtPH77ZyADtRA0E7cGELmu?=
 =?us-ascii?Q?jV4GHzk1HA+2v0Sl1x18CEb3RgJ9OmT/Cr6kDyz8kKE8UbCGAZK1JJQmeyIf?=
 =?us-ascii?Q?QXXff3JNd6xFSa1/cYhd9dY9O39QsLza0uuVXkjvxfxCxsJxP+vQBfr1Tirb?=
 =?us-ascii?Q?el0Be1ctLZJ960Ac9PlfaqLOYTfnI2kCWD6mvw+oPZapNkhMh1kT9Kips9x3?=
 =?us-ascii?Q?NZvfQEGDoa9TFg3Fe5F3eseyuVuXulLLDJThZWupX1jJRBcjkA5RTvuIsL+c?=
 =?us-ascii?Q?25gOHut14ky/pcwufFB4GApUdAPGUAXuwn8oOI7BgJ84kfK4wsap76onJOEu?=
 =?us-ascii?Q?XWO4PokqywjHkhKLxpmLWNfvuqOsJlf+j2X05yEZ9/MiycyE5c5tdsK1qMjR?=
 =?us-ascii?Q?hSQ/MutBVzZxiLt52jXU5HhDSambQlrBs3l4tYcNplbLNHb3+fhIjEcRCUP1?=
 =?us-ascii?Q?iZGamz+fu7MAZxltUVdkSgwMvGtF7BxEnQGizmFUQlnmk3xS3X/bT6H0pZk2?=
 =?us-ascii?Q?b+Pbe0vDK7augfZbzthdzo2N7yNNqHKanZDG/Z/JDlCD6U2qAvPDpNQ+BrdK?=
 =?us-ascii?Q?b/mbWN84rGUl/Yh8YhnY3+qPfyM1dU5U6SGYHMMmVIy5VO7B1fB0sCEYX/P3?=
 =?us-ascii?Q?Xbw31QPzSC1uRe3A96OE1R8xjvAj3hCpfJGjnESaa1N6jRSXpj5OEyFXwGt7?=
 =?us-ascii?Q?OEIYuOYnbWC6iwxcosDhsNK2SJDplFmQsv6Ef9IjSTVXV5gK6vUOGkp+t5n/?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5PXdWS/zaNe3sbTEiQDBmfkqEZRHLg6cx5wUBdk/bG/GGYHqiMnYkJPlxfWGu1V73VomhpYDeV6QzKyjhlxtxeQup/K9RO65Hs1cankkCOxMGjPMQOnz3+hsuHr+WpspHLIi+hw9AhKDUif/y9JXhguKdLSG0EaYGD3Aoo6JyqiAcdvAYUqhr5eRblK7rqnYjgnPkf6ql9aplbfzotbvm35QlWiZA19RSHaR9cPcWjP4lkXilKZVr8WKLrbAKWROBOozMR7xnCmjBRa8PQ2JnAcsGd6HjwCYL4WKK0k/WUpre8jTEMzC43CjotRH6uDjXVyDUB5JvNdDyyZewNh6heQSoCixeRXCQApoHnwxnDEzWLDk4vvT25rFSzCRnxwWCl73TawQegOdNCiu39KnGbDXg0MaWiAwuIvHkJsAzN7Ln6nwoFgzsoGDxJwvynC6AExKMHa70+e+gyEGEliFAU/ptUH9BJTWGbXkjKupctLvh3J3rSFRLgbno2vgSNS7jPRpPKR2s5c1/qFZGiYJXa7VEZc0cdMgeu6YryCCU+x7CAQjNCtFvUZMhdDzFCWzVX1bi+nCmwVFwsvDp/kkfZVGheJUuDd4cCL1oN6pIPARxCQdH1eSBfzzERy2e55
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db612de-30b8-46e0-f4df-08dced3ac344
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:59:42.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4tMtwC/vDtRqk1O13vpIDjvN72YOps5U5kqTJeXQPyr232S2RMPPM7dDFO4ZzRHYbM7fAgYneUgpi9GEBVVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
X-MDID: 1729011584-zERSm_HpY-JT
X-MDID-O:
 eu1;ams;1729011584;zERSm_HpY-JT;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a doubly-linked node to neighbours, so that they
can be deleted without iterating the entire bucket they're in.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  2 ++
 net/core/neighbour.c    | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index a44f262a7384..5f2b7249ba02 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -136,6 +136,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct neighbour __rcu	*next;
+	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -191,6 +192,7 @@ struct pneigh_entry {
 
 struct neigh_hash_table {
 	struct neighbour __rcu	**hash_buckets;
+	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
 	struct rcu_head		rcu;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..01987368b6c5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -217,6 +217,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 		neigh = rcu_dereference_protected(n->next,
 						  lockdep_is_held(&tbl->lock));
 		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -403,6 +404,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			rcu_assign_pointer(*np,
 				   rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -531,7 +533,9 @@ static void neigh_get_hash_rnd(u32 *x)
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
 	size_t size = (1 << shift) * sizeof(struct neighbour *);
+	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
 	struct neigh_hash_table *ret;
+	struct hlist_head *hash_heads;
 	struct neighbour __rcu **buckets;
 	int i;
 
@@ -540,17 +544,28 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 		return NULL;
 	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
+		hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
+		if (!hash_heads)
+			kfree(buckets);
 	} else {
 		buckets = (struct neighbour __rcu **)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
 		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
+
+		hash_heads = (struct hlist_head *)
+			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
+					   get_order(hash_heads_size));
+		kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
+		if (!hash_heads)
+			free_pages((unsigned long)buckets, get_order(size));
 	}
-	if (!buckets) {
+	if (!buckets || !hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
 	ret->hash_buckets = buckets;
+	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
 		neigh_get_hash_rnd(&ret->hash_rnd[i]);
@@ -564,6 +579,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    rcu);
 	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
 	struct neighbour __rcu **buckets = nht->hash_buckets;
+	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	struct hlist_head *hash_heads = nht->hash_heads;
 
 	if (size <= PAGE_SIZE) {
 		kfree(buckets);
@@ -571,6 +588,13 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 		kmemleak_free(buckets);
 		free_pages((unsigned long)buckets, get_order(size));
 	}
+
+	if (hash_heads_size < PAGE_SIZE) {
+		kfree(hash_heads);
+	} else {
+		kmemleak_free(hash_heads);
+		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+	}
 	kfree(nht);
 }
 
@@ -607,6 +631,8 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 						new_nht->hash_buckets[hash],
 						lockdep_is_held(&tbl->lock)));
 			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			hlist_del_rcu(&n->hash);
+			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
 	}
 
@@ -717,6 +743,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 			   rcu_dereference_protected(nht->hash_buckets[hash_val],
 						     lockdep_is_held(&tbl->lock)));
 	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -1002,6 +1029,7 @@ static void neigh_periodic_work(struct work_struct *work)
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3131,6 +3159,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 			} else
 				np = &n->next;
-- 
2.46.0


