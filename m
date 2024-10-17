Return-Path: <netdev+bounces-136426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D69A1B49
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BEA1C21F01
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146031C230E;
	Thu, 17 Oct 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="at25psLP"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487171C242D
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148712; cv=fail; b=JtGEwF4n53fxCMskTv0yx3eU5dhqaadj5sw7p7OLoWzOXbEb1VnFmtKVm4a1ZJqp2aTJYrnaLTJlpF2GScTQZffTxAKp7J97h7XXn3NZew63KtyxGMBelbuUxVr8MIaB9tP846Onu9jh4Z0++kvf3/WviHFC9pt1ShwZwEjg1Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148712; c=relaxed/simple;
	bh=4YvQTxKZBaVodELexDPT9uT8Gx/1T1Cjkks7MA3KavU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfGUgwgVBLCZaZFbR1yQi266x4Un5MBwtovIIIWl0TNRVT0QeAYp+xg+RhfNwioj+3o0SDNNUbuMj2dmhIRFZb5mnvRrmtA+R2l8jYobkrXO9U3/BdL9R5oBEknCYjzOvTN34LA77l1ogokmNDb5iftb1PtQTlj+TOhKmqd0KNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=at25psLP; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from eu1-mdac22-2.fra.proofpoint.com (unknown [10.70.45.127])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ACC58600BA;
	Thu, 17 Oct 2024 07:05:05 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C159E6C006F;
	Thu, 17 Oct 2024 07:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXOswnqY9E81XoZnqZxW6krwYrVlKCC7PW2rf0Muef2wnHQL74I4+okX98jKJB0z18+Z7fNLw6YdEFxn0UfG8pC3Cmx42KQohp0c9UmZHgSDgXLqOdA0XGwBflcuYdyZ0UQmieHzuWNRLemKGcP0hZvItLWg6lT3bOw+2LnhGbKE1TyCX6P7ja4aFs8B0ODG4X4u8EmnRKvWtzKnNdPjjaIcxU/D5E8TCo10c3bzdk9TnXiTkTtgZCbsNXhSfEV4W99qlz5Aj9A+CW/nu2brP8GL4jIr7IGi2tfHDuF26o5TAwrbss5nHb4F30clHh7bdp5ccHD5/t+7XdAeuko1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ct/U2sGKPu9Fp3ZIOrKbIUtB5s4HKMUL0/BjL6y6pA=;
 b=bcAXpJatb560MocOF5pGwAqZ0pAZDIY78+RbmxcyTs/+iqPTWnX2oOf8+3h+YriwI+/aBhURe8jxRtZi5ZjG+ZVqSmWPkfo4A2l9LFOojDygYfBVOm1s6hYCBsC/T1tGi6HWN1RMiE4bBL6he92QWyNndprA9wg2vmoOJ/XdYavxJix0/V7N/bu6ZRe8ihvE6wIXQEW7BzJBgu/Fy/lP4J695rxPVPsjZHkDUbodn1a6+20jsGNwIENDrMf4l3cCdoYmbgTkTihzT9lwTx6QLebqKSn0/JYBsPSQjoWnONQfTaJ7SxW1l8lKjpOBS1/FRgV4eEBrD1jepRrzwVZTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ct/U2sGKPu9Fp3ZIOrKbIUtB5s4HKMUL0/BjL6y6pA=;
 b=at25psLPI0qOxlZdrbFo9eTEvDzJAW6qBn4UHZTm8YtQgR2uJ0hfY49GB9RbCe82+kVh3uVSqEFbKn8oBPXf5KCpLhRKA36djlmS17PQPlBwE/3wI9esyvpl7eR6EwYXEhScRuTlal8/nV7ZPOmUH2KM3/I7Q+H2Tx37sX658Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 07:05:03 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 07:05:03 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next v5 5/6] Remove bare neighbour::next pointer
Date: Thu, 17 Oct 2024 07:04:40 +0000
Message-ID: <20241017070445.4013745-6-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017070445.4013745-1-gnaaman@drivenets.com>
References: <20241017070445.4013745-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM0PR08MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8466da-2596-460a-a60a-08dcee7a0586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pRK0II/iIoLQammkdrQwhvRnROIoVedb5UKvNtjy2auoHdLBCRKG1pz2up07?=
 =?us-ascii?Q?5qzb3e/Snt2Xvh4+WqR2NWDNcbt61zxGXD7WqsYprgzxbEP3z0yWzYImAqy3?=
 =?us-ascii?Q?jhhatEX/d1VgRDT9Y+iKKJSZFEmE9zV3l1sfFJe+pZOWLGERk2Qr4pJ8OHm7?=
 =?us-ascii?Q?ObULEgC/NxMLzE9FFVxNB+zIBo+g/fyZjyTXSu8T9kDwN8TSmt+mDwUmx2uX?=
 =?us-ascii?Q?EViJKuZm91O11YAnX8uMqT8YKW3KTU0aOcHhuRgX1ExW088yXUHZUHFajrMo?=
 =?us-ascii?Q?S3e91US0NTHPiahvuNVw/fyL+bKu8Tu5fA1Zohhqvx3+YabiEi+HkoQdO1lE?=
 =?us-ascii?Q?3NebngR7l+Nolmw/0IVSBsA7jIV4h/V79cDfsGfYrvgbep3mQoDjpxB7w5bf?=
 =?us-ascii?Q?Ol6UgSrc00qOuZOsE/lVbcP9VequMYd0ywlQkclW5EVQkYxLlV7QEEKz0VDF?=
 =?us-ascii?Q?hCqcUy81gJyRNOu01OnZOIviYxSd75WZRcmVEefaB+NROGp7ayM8mW/dobSE?=
 =?us-ascii?Q?8hGxZCL+/fRnkt8vQwrfYPRv93zVFNKggQhvHagTY/4OkT5N8uErzgf3dnoq?=
 =?us-ascii?Q?oWI5JlbruSVi2x9Ef5cQEd17mz5H/hEfrvKr0i6AVRB3P3VUO2a5qvj3df2c?=
 =?us-ascii?Q?f/uMyRUxxILwkD7EphenY7xdSFtYoEPBC2Px6Gb2cEHY6Bzut4rjAjOliPU0?=
 =?us-ascii?Q?j4vYdTl5BnaGsOg8sFE5lMFGWpJr+64YZFCO1eg1OyX8D7Xwm7oSPe0BWSlU?=
 =?us-ascii?Q?uZCsUbQRPdy/12EQiF4/qwMoYOZCuD5jFtpJIj3GAgLRUUF7bBz/HlGhanqQ?=
 =?us-ascii?Q?YiDXwB2j2dVPQalghQC4CYUNCcVj2K1Xn2Xo7rayEs953kJK8BDis7LvmtBl?=
 =?us-ascii?Q?Y6L5hyaJVIqVbe/abnKwZ6/pPQqnPqxn/i6lQncunr/SzICT9NhvRF4I2zet?=
 =?us-ascii?Q?TRL8MtKtjevdeznAsLcluEdWjcQVWb7F2despnSF62LRIzolXhOpO/dVY6VS?=
 =?us-ascii?Q?a5l7tRu2q0VMW5fnu1zr0fwqB1gYiR/o0QbPmZAcSJ0wAN6jYXF4DWQ2UdGx?=
 =?us-ascii?Q?OuNH/WzrUBln4SnOynFXFFkMf3mF14NmYDTMehpt1HYcTQrUCE4EQJUdHWIm?=
 =?us-ascii?Q?tbV+YN6Ot+rW0NLpTg9rqoYURBD/Kvpryezhrb09HRp0tRCJe84iw5h0ZJ3n?=
 =?us-ascii?Q?HkiXIE3rUOJC+BYIhUpzPJWphCTs7kYe20ETYdSq4tSwcFlEYcs8BFr30FAr?=
 =?us-ascii?Q?JZniB+Esinga1Ghoe60kVwyWLEj6hYq3bI7wPdacOYO/vdWgY8c6Wog6qQq7?=
 =?us-ascii?Q?zMVbYQb+j9XEIWAXNl03Z7RUT/g1DkqT4qH9PmzchJgqW7LAw2V6rFv/0z3S?=
 =?us-ascii?Q?yiJs2Os=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KVkgZqUhuriX7sDWYsKv+7Aq0NMPmpYh4axC6HMNQHdl4Nl5U9WdKIAn6gIt?=
 =?us-ascii?Q?EogmoTWng8QF2L66LAf5ZDTc+JZrk3YaGF+fdjxGv7IlQ+aI76Z3ufgpOO4M?=
 =?us-ascii?Q?9LV79TLvKM8rmfcXx2nSACfu10GUcXhiyxK0YWDzwyoudpp18pLUJuUMT8pT?=
 =?us-ascii?Q?F/fkDDiMKYTb5fhEvGtWXOwx9CB8pG1asUDLF6KY3RQRzOJ4yUnv1Xk5JNxO?=
 =?us-ascii?Q?UNhJSTgr1DtAvb7TtFLreMXG/PpUBGv2NEBHLhR2nHti0rK+4m6sJYCGyLC2?=
 =?us-ascii?Q?tKqW0frxUF3eSbFGGFITqBpJc7SlgsPBdCv3msmw5bMDnF0dwB1DurwbKKuV?=
 =?us-ascii?Q?g7VenCGH6/K4GJxaA/DaIHa3R6Rs/KO+gAvL8g4by8iivcZr96NxuJvb67d6?=
 =?us-ascii?Q?Ahn0QnT4fdsI0+uEsS1eaCoP8noY8JpgF3yC2TI2jcC2xbpAYYPVhJP3LWvN?=
 =?us-ascii?Q?H94yyJ8ruoh7CYSplH25LfnrMIpyetMv809bFKbqmVHYgS4Wwv3KSM2AoCyI?=
 =?us-ascii?Q?sZA06sKx/KkTXxPvASP7ZhweFABPjEbWQvHVsUB5s5fZxpV1GCN9aQOfFJsK?=
 =?us-ascii?Q?XKCEi+FRlxj8UgwQ0uUCHgRlQPk7x4SF4izxL2y4Ocd0q1ceaAPVq9vdyvmW?=
 =?us-ascii?Q?msXC43kUhlrk3pdLNz0vHDDFf6MqwGRKoZmovBedJ8g6YeApGA5GxAp5K0GE?=
 =?us-ascii?Q?tplt9289GdLlgwLrrQpz84lb34n/FAZjlMdiysaMolFBmsblzV8YBXMfstFa?=
 =?us-ascii?Q?UN6Va9zmIYUXly7skglQ3lByn8Nmfuq1xopYn4SYpHK86QvIQSi23vj9vJAp?=
 =?us-ascii?Q?F3D5CZwu/gFY0cAJvVoZSvwkHys5TDiFxJ2WZapGyQ1i2/RAPtp46PKMg3nE?=
 =?us-ascii?Q?Ntb1XzIj/T3M0gdZGHR+hb7a9r+pWMY/Vq+Y83f8r4KpZojnzbFecwzJx1Tr?=
 =?us-ascii?Q?axQY6rcb/gE16zGFhwKbcDWeYiWQiDbI48UdLe9pON9tXT/8KUJ044nkX20u?=
 =?us-ascii?Q?5jXr1Qnn06JPDHNNtSHqLR7Sf5TcxQ6rd/bLLGmk/0+gqoTsrR6IhmBju+F9?=
 =?us-ascii?Q?A1RFFnF3xngyoYi4En7wdHlP+FhXPtHA2X55Uj9SbwUvLtqljuDIS7Qe6W9X?=
 =?us-ascii?Q?S8KTGBtFiaQ8forelIv68Zv5CHb467f55B4nspAxy++LkeqRcw2ZAC5GqZyw?=
 =?us-ascii?Q?Zu8ucuPhbOrpCGdQy2QeaFdPc5TC44uB+yE47Dv443P6GK5wabYgMs+Cb+eV?=
 =?us-ascii?Q?zxsenCSIWM5iFCtKVNwKdN9abvhSZVK8hxhcx0z/I75/j+D+js2ar82ZGCrL?=
 =?us-ascii?Q?qLOFwlJ/+h4xDH1YFlmST00xJCKDHuEIXucoSBgHpgSZAx8wgW/oSSTjg9Uv?=
 =?us-ascii?Q?Jo85rojsTmC6aUIYodG807cyqG2ZdEdOtp9Chwn3HfgjlVZxWLDK/EM+yWb7?=
 =?us-ascii?Q?Bbij08N9sFzq3RIgTOSPESUPcx16tLI1gRUViisFladgqaMlFL3AxHgyiV8U?=
 =?us-ascii?Q?iYas4pMOIrTdljLfi7kE98xBC/1CTPcB7xZWFRaIm0Ii8ouOu6E2rN7XryA5?=
 =?us-ascii?Q?src4STNWD0gOg2qfYLZLAmM6U12AA3davjatbGwf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cc5WZV/oTEIokeD162cz2ebNJnAlV24DGJJqQGfJYp2Hf07ZiuayC2XQbbC36YPpqtMzMfqCz8JWkFrIsRVymgNa6iNL9g6qzqOneNKBEUyk2yAbmKnG7Cl/BLXIelT4vAYP03sur5qfZL8DbrEK+6/Euyea8ZGCOaoDa0ml58gzhmdidRfOKM30DzkDiY1cwkAjlzrfxLf8gpUUKzemwKi7wMMmT3Lv7krRoawGpXHscF4OdKdaLK1AElLJG3aO9GoZi2f/25ZvGA0Xj2K5xEh+C3rJsXckAy4JdYDTwp4yiDNTyfIRwh2Xs0LWNuL27b3Q0rfBjmSt2D1LqpY+C23DAxQuQaWBbBGcYC/X0pmU4LKJh/0aBnPR/DAgSbrup+Dlf9LKR5ko1aARtEZmYbl4i6/yhGmXcig2vRu6DZXMC7hMlXlZfiHZSY5oIa2lsA3Kgx3IYBzQcXHEfkFWHgH96vB4XzvVUGBjCNg4A3ek1Rj5YdGreriokKHD5CmL5wM4+44qilv1EXkjKdzzkAITydqUlcra7UF7OR3s3ESalnFh4pR9yxQfKaWWDbUqEaluD985wWJ6n/QNxM89kkzyGdmQusJTNm1EFNe/x1ZrdfutJ1By3RHAGHmshOgb
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8466da-2596-460a-a60a-08dcee7a0586
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:05:03.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZjVM32lGxU9pwSoVOdB7RUAZSpcWfKB0bAlFuvV06h12elHwMdyNek8fjhOC5mdUwRNXopSHmBL7RtFOzDe8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363
X-MDID: 1729148705-2v3JimaQR17Z
X-MDID-O:
 eu1;fra;1729148705;2v3JimaQR17Z;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove the now-unused neighbour::next pointer, leaving struct neighbour
solely with the hlist_node implementation.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   2 -
 net/core/neighbour.c    | 132 ++++++++--------------------------------
 2 files changed, 24 insertions(+), 110 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 96528a6cd74b..61c85f5e1235 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,6 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
 	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
@@ -191,7 +190,6 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
 	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a1dd419655a1..1c49515b850b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -205,49 +205,24 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
-{
-	bool retval = false;
-
-	write_lock(&n->lock);
-	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
-		hlist_del_rcu(&n->hash);
-		neigh_mark_dead(n);
-		retval = true;
-	}
-	write_unlock(&n->lock);
-	if (retval)
-		neigh_cleanup_and_release(n);
-	return retval;
-}
-
 bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 {
 	struct neigh_hash_table *nht;
-	void *pkey = ndel->primary_key;
-	u32 hash_val;
-	struct neighbour *n;
-	struct neighbour __rcu **np;
+	bool retval = false;
 
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
-	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
-	hash_val = hash_val >> (32 - nht->hash_shift);
 
-	np = &nht->hash_buckets[hash_val];
-	while ((n = rcu_dereference_protected(*np,
-					      lockdep_is_held(&tbl->lock)))) {
-		if (n == ndel)
-			return neigh_del(n, np, tbl);
-		np = &n->next;
+	write_lock(&ndel->lock);
+	if (refcount_read(&ndel->refcnt) == 1) {
+		hlist_del_rcu(&ndel->hash);
+		neigh_mark_dead(ndel);
+		retval = true;
 	}
-	return false;
+	write_unlock(&ndel->lock);
+	if (retval)
+		neigh_cleanup_and_release(ndel);
+	return retval;
 }
 
 static int neigh_forced_gc(struct neigh_table *tbl)
@@ -389,20 +364,13 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
 		struct neighbour *n;
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
 
 		neigh_for_each(n, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev) {
-				np = &n->next;
+			if (dev && n->dev != dev)
 				continue;
-			}
-			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+			if (skip_perm && n->nud_state & NUD_PERMANENT)
 				continue;
-			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+
 			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
@@ -531,9 +499,7 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets;
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads;
 	struct neigh_hash_table *ret;
 	int i;
@@ -544,33 +510,17 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (!ret)
 		return NULL;
 	if (size <= PAGE_SIZE) {
-		buckets = kzalloc(size, GFP_ATOMIC);
-
-		if (buckets) {
-			hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
-			if (!hash_heads)
-				kfree(buckets);
-		}
+		hash_heads = kzalloc(size, GFP_ATOMIC);
 	} else {
-		buckets = (struct neighbour __rcu **)
+		hash_heads = (struct hlist_head *)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
-		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
-
-		if (buckets) {
-			hash_heads = (struct hlist_head *)
-				__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
-						 get_order(hash_heads_size));
-			kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
-			if (!hash_heads)
-				free_pages((unsigned long)buckets, get_order(size));
-		}
+		kmemleak_alloc(hash_heads, size, 1, GFP_ATOMIC);
 	}
-	if (!buckets || !hash_heads) {
+	if (!hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
-	ret->hash_buckets = buckets;
 	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
@@ -583,23 +533,14 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
-	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads = nht->hash_heads;
 
-	if (size <= PAGE_SIZE) {
-		kfree(buckets);
-	} else {
-		kmemleak_free(buckets);
-		free_pages((unsigned long)buckets, get_order(size));
-	}
-
-	if (hash_heads_size < PAGE_SIZE) {
+	if (size < PAGE_SIZE) {
 		kfree(hash_heads);
 	} else {
 		kmemleak_free(hash_heads);
-		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+		free_pages((unsigned long)hash_heads, get_order(size));
 	}
 	kfree(nht);
 }
@@ -619,7 +560,7 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 		return old_nht;
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
-		struct neighbour *n, *next;
+		struct neighbour *n;
 		struct hlist_node *tmp;
 
 		neigh_for_each_safe(n, tmp, &old_nht->hash_heads[i]) {
@@ -627,14 +568,7 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
 
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
 			hlist_del_rcu(&n->hash);
 			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
@@ -739,10 +673,6 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
@@ -976,7 +906,6 @@ static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
 	struct neigh_hash_table *nht;
-	struct neighbour __rcu **np;
 	struct hlist_node *tmp;
 	struct neighbour *n;
 	unsigned int i;
@@ -1004,7 +933,6 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
 
 		neigh_for_each_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
@@ -1015,7 +943,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
 			    (n->flags & NTF_EXT_LEARNED)) {
 				write_unlock(&n->lock);
-				goto next_elt;
+				continue;
 			}
 
 			if (time_before(n->used, n->confirmed) &&
@@ -1026,9 +954,6 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
@@ -1036,9 +961,6 @@ static void neigh_periodic_work(struct work_struct *work)
 				continue;
 			}
 			write_unlock(&n->lock);
-
-next_elt:
-			np = &n->next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -3124,22 +3046,16 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 		struct hlist_node *tmp;
-		struct neighbour __rcu **np;
 
-		np = &nht->hash_buckets[chain];
 		neigh_for_each_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
-			} else
-				np = &n->next;
+			}
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
-- 
2.46.0


