Return-Path: <netdev+bounces-136421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451999A1B44
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048772874D8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2EB1BFE18;
	Thu, 17 Oct 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="mO2xg3zc"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB95155A24
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148702; cv=fail; b=fyU0hOLrWvj3b6AtsBXNbwncAvK0vhOQMKL2bDarYD3yjc7AJ6p2wqooEbfj6F4JQ+5k+9dVHwRFlecFix/pUGenbpjDVbnEE3pGfG0xQb9HYLhl6ArR5vxirxPgRuWuT82zwsv/jUP3bA3gGrA5amfHewSxj3BxE8V+LA6XUs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148702; c=relaxed/simple;
	bh=ffrm77ZqPJb8cuktzwWgnrhzg3WhpzafhEaKdmgRyfY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h0roLA9DBlLWNFcnZZ5+1NO6v7Znhil4vMxoQ1Mo2PAx87wXlp3If+J/J3/ZceM0oHMi6+KgLuY/ulcjpIcTZd4tB/soR5UqOA6m7oOPqHJaXyqWDozbAQVbBxQY0lou7ge5ZcysA9eJbFkDvbhQ9amZB/BFUdJytPSf/PNZI50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=mO2xg3zc; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6281E74006F;
	Thu, 17 Oct 2024 07:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgmRIEQ3vv8wNef0UgpV9YMMTMgkjCNZ/z56Xr27S1FD274QcUtnHYCm9sSQBgavzvXApyU3yK9B6j1ey1dx8ApBKqq7AulUiGUovVTdM6ehYLAwUErTDI6DHrf+LuxCDQgG5XEnUeId6WegEnj4UT/b0s1kkABwviQgic3Py9A+mQXCyY2B06ZcXE6pXm0sYH8iQ5q5H2UK0EywtqX1bMwP01qRAMOmpf7oTMCJksNh+bnZ7e6ruOhUM/57p0A/Kl0T6LW4ffvaEtvwPzFVuNLcJM6baT/u5F9NIMy5KAzZl3BW95qi4vWbcGQutWGQKSM5KdVdHw+/QT0dhLNGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHdKWeRKhvmuQLPykzn46MUGxDZ0cBfzf4iY3FzLinE=;
 b=WQKDMD/oQ+qf8fVoGdNR7WhP6u/ZqzaEzeZTXsvBFXQZyLTTFYONRltVR+Lxf6pJkdMgJkY3DHcNuZe5Y5DAwXO3AOabzERuPpOgFwCimg5OI4apRccnHfEmwBfyzYVwETwwnj2rgxBleFb/TmJg2JbAqyXVzXZRY9X/U25VKUzhyKMbLh1ZOpKXGarkAmy0uU9wRrcJjY23NKhaFcrs787OzVNaDV5l1ztLxvhMbrNtJUwh0gJXCJLAI4UIHxBqJFIq5xRW2I8zdRwqdAyJ38XdlKi/Dou88XI7A6E1UFWlpF5ybjTQ5ksrsI2MHd1l8bPNGTx5IFRv5941n7gZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHdKWeRKhvmuQLPykzn46MUGxDZ0cBfzf4iY3FzLinE=;
 b=mO2xg3zccRrGpkWAhxI6CBGrlhwTIuLWAhxAad2ApV3SSs9lwsnsRxexg8A2CMtNyiNgYxhosKE2jLv/WEZaZD0wwwADqrhq0FK+RZenkoKMq5no2ExrblKOeJ3qJGgjUTDcfyPyVyRCkZGGsA9pU4naYe2waBf4I3qkUYqfYaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 07:04:55 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 07:04:55 +0000
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
Subject: [PATCH net-next v5 0/6] Improve neigh_flush_dev performance
Date: Thu, 17 Oct 2024 07:04:35 +0000
Message-ID: <20241017070445.4013745-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-Office365-Filtering-Correlation-Id: 7381dfcf-91e2-4eac-31ae-08dcee7a011c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPK34jeU3SPp+4oKAHtaUDgvJ8gKGJvjCGPW6gyDlYWsIQtjNUeyYzGT4HBH?=
 =?us-ascii?Q?rwp2evAdV8wDYlqxT6MiTkrOK5jPepV9VMWA8yBQFbIzDOwLk6OCiUycxzyk?=
 =?us-ascii?Q?SAVcj86dKjTEZOcz7+GjQFmxo6fnXyMCg+dd0cwpa/HSCfoqYH8TBHDcOIj+?=
 =?us-ascii?Q?t8IMdb3VzvUGHs89mtQctT8w5o3g3mDh9eVD8JbcAWvsE7WyQdEXy0Un7PRE?=
 =?us-ascii?Q?FL44RnAdNeIV/PT0k9rC0zGGMbrZvHzuFuEMUM9VO+GqNJk79pa27ekMwqkk?=
 =?us-ascii?Q?DR+6hzpX9h4/6mNZSo+5d1bBP7rOSfJ5y08oDrj9lcVua81Oe4FAjkSsT1fR?=
 =?us-ascii?Q?OmbmU+tIN2czvqeRTumpujHg5ToHWd8DLNsTu7sHSJaKcZsb+iPeDiTd25us?=
 =?us-ascii?Q?qulSJjHivtXA0JyqnK4gPV2IB28Hs1oMuqtSAUDL+P61rS5/w+yGs3h3pe+d?=
 =?us-ascii?Q?Ol29ivaZhEzfpZhBxJCUmPfdn9g0eYkNy3ERGRrjS/I6PMLlKed7FOhjL+Kx?=
 =?us-ascii?Q?Bk8AdUTXL2eeWkPGZR3OYcoruIKFCNjQTIY57cynmGFCBoCZL3FckHsgT1ae?=
 =?us-ascii?Q?yvy0seTp74H7l9ScvF/fFwIEEIhGtwLk08KF3WQ5sfPvR2LoBNG1oidQ6zxs?=
 =?us-ascii?Q?GRzJLQuvKcHnhVZkDCRikzCEBl+GCtbrPjKYoz18tFpdz9pl5k2K51jwWvC+?=
 =?us-ascii?Q?zXJTAfQaULFw7FOO9wuu5hm5Uz2Wy/NZs2AB0DZ+XHNSlucKLK5bsE42wW8d?=
 =?us-ascii?Q?qfQJP60Kfw9LgFBEQFoPBR8RdepuKoEjT3zGsIQJBj5wSmnBwiybxpMRmmKk?=
 =?us-ascii?Q?rPlYyMRQj3dS+No5bJIiuwu1PPgjDl1Vb70bOXfA7qejssLF+FuqxqPXfnLn?=
 =?us-ascii?Q?Iu0lX5AB77+0n1QxV7b++mgB0Sk0pTfNjH1FfBS1JJFwYAk4MBAw3/5qiXkV?=
 =?us-ascii?Q?t4HEwPl9rxGHr1mlkWx2u6f8WP/O0t/MgdcOpYaA0MIO29fyjvQXOm31XxyY?=
 =?us-ascii?Q?8f22RsON6HX+erEUv2WkdLVYmEQ5VGQo69T0shD4AyigON3W3KSorYTCbU4d?=
 =?us-ascii?Q?uyDDi2eXC5ic7RImNhKdOY0Mj5TvJ3zCAlaClPl3cyM3F2zGXDsVULquszqN?=
 =?us-ascii?Q?mFkLvh5L9aw8UrZpjHmpASbKIR4EsRCQU2lh4C0VSHjvO0jQyUePYqSsPXjd?=
 =?us-ascii?Q?SOaloxIJsdlMohxzgsd/aEHJreRINai36v6FGyT0lYZsBZ0GZD7mHuvsxUlX?=
 =?us-ascii?Q?0mfdJI/0epSgeQnZTQAgOnEtsdwci9jp0Sg5k8s4xCKQJUQyOQyb5mntNJnY?=
 =?us-ascii?Q?xO2aVRigYfilM5UL2XvSzlpxyH/Xgo5JB7L3s0Lpd6LpOHNDrEn2CcLN36B0?=
 =?us-ascii?Q?1gU2qUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSicGvvKttPRPbXey/hqvb3Bj7VzoVHZOfa+mzIG9lRBXTcw7dHyz5pagaLf?=
 =?us-ascii?Q?K6WIer3cQdvtIPMqQ/O4FiMoP3T0p4Zilm7AE2UNBeNRbPsAUjTzolS/qHST?=
 =?us-ascii?Q?erjRy7OjXWhuUNrj+VQAuIT1ELp3RYNcqLAOSRmlhBOaO1+/t/ajeX3Bvrr5?=
 =?us-ascii?Q?6BV5flVpDnfJiKRso+zd/YC3wydfyZClI3byaWOvyq3felR2LLQolb10UkoI?=
 =?us-ascii?Q?VAqO10rNFOnyCrdCzXFZwwQjE99f5NEvClmz4J2KOpEB/YjLzejo78f+htIB?=
 =?us-ascii?Q?u57qhgfBcRNeY9hiVc6XIneBpncdDCDQ7WMIrhCVg/2ME/Psmb5PwFSJM6Wv?=
 =?us-ascii?Q?LePDlY9DiQPFT/LKYijJBMhTtc7LGsejsiU+QW8qyzcL/o8h3QcvxvU4hgiD?=
 =?us-ascii?Q?P29TojkYBC9SZKinkJTZOvZ80k8zeNy39Sna3JT4C9ckr8/XOlzF/2p38Sck?=
 =?us-ascii?Q?TL8GIoZxjQf+jVX5dL/TEWTMe0jhjEkXwL43wmsl9ZwWltKgBgSHAcwkvmfa?=
 =?us-ascii?Q?BnQnfIcRYr8TnuBQAK9d/16gBkNWWEvoufXf8xwqebyDvHaUy6hYf5OrLGWL?=
 =?us-ascii?Q?lEkiDViwWPEq1u77LUdVqQOGLIuRN1mSg/60ToYxPW4sm4IeIAyWrDjE++WZ?=
 =?us-ascii?Q?cPivha7y1xF2pJyAl2zOSZYnfy+KBFaVOdgmBRsyHhGolzmsYV/muN6Qj/oG?=
 =?us-ascii?Q?5CGMG/RyHmNqXjVxxtpaN8Y8JRS4AbUVm9+MGkyXOQrcJPrIAVC0moWhfRDx?=
 =?us-ascii?Q?xKGdahbo4ed03Ah6Y+7bkLCDHMHdW5RniHki+IMo/qshKBzSkZdcB1x1DEOc?=
 =?us-ascii?Q?sUesaEuFBLfH/trOpVTdav6Do0vRr7rv2mYywmYGIxhYyWuJA/UH+04V98Ou?=
 =?us-ascii?Q?hSe3Cr+4R5S9Nx4EVy+DCsS0GUbgoByUr9Cn27NfVRt/lixkcSrJtgttvU6M?=
 =?us-ascii?Q?Cg/eqa+sBsbGJjncgXAKqZDav6CgJOEaPUvCqJ8wo03vk8oHnsXUQwVI6lOf?=
 =?us-ascii?Q?FkXPP1Y6NbbQLmzj0rhT2DvFqtcD6i0ozspV89P5DbNh6nfhfkECtT5KMR98?=
 =?us-ascii?Q?4mT0y5TZiKHXlxo1gBMCTLog+lHZidcGhzQ1WpHn5hFX/bJWDZS5TMnzUyDf?=
 =?us-ascii?Q?htvI2Y3400eM90I/lapDlqzFKPPkMXs/M8VGFm+QsDsXQyp8slrMEIKZjo2L?=
 =?us-ascii?Q?tWsYa5+rVrXYx+VK7/WTlE8gzNry5LqsKdgl031DEFtBw6V4QKqtTBjfIArV?=
 =?us-ascii?Q?w1jto+0d0YtVpsOqYOequBQ5O5iL1/yCEc3LgmYiL23qso8frRxdzhi3P84F?=
 =?us-ascii?Q?/jpWmz3LETkgW+N2oDlUcrxxxE6Cm+8f2eVZusy0atOs8LJ/htyPrunj3vgJ?=
 =?us-ascii?Q?jvXBm5E9opYC0jmaWfj7KZRXeNU2oNWeUXGFDYBhjXhxesHDRoxtc5yr4Bmn?=
 =?us-ascii?Q?0T9X+a+hBeBOfp++jsQek7NbiTnBhf2DQKHpABU/xumu9g8iBn7FZWlPqE9M?=
 =?us-ascii?Q?qhEW8CMpLA98AXX+e7GQsXW39xk3PEEko51uxsJhyZ4VtYAlDuIVRR7vCyjJ?=
 =?us-ascii?Q?qui/OmVvMLkuvxD74+S9hfSuvDqAjZ8x3PdExyyU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TMF/b1VrlSXXMKjPm2L7LYhdOIhpTA6TJQAmrswkntYSFhbMY2N5SUmg67SerdfXTdeU2fpJh3229Trcw03kYCEHTikgzIjr5qZjqPcxjFBnujKRNnk9LAI+oPEQelduTwicZsOiihVf1xCtEtixBQGOiEcAcAmGoq1YQbNCnM9axZAmSPcGhvj5s5n2q/sZh1vpS8oMZ/b6vYe9mRFpZzy+7D5UC7u8+6hdAWb2cAPioZ7REfrN+JVsPZZ22QIgUP5jgGVT45vouOzjYHhoIbExlgLC5YvHGOIXqtbHRd0WyFAB78j2bMXEE+Tc4tx+d+uwx7OTZUyfb91R2dHKc/E7ZHFJmTOQ0MT8XDzhHsv97sxcBGX0+H/y/bs+MjfJnUEuGma/A7Rwy2oa1+HUrB21fki9BqyO5ue6yiubD48o3eyapnhmMQGNnPwlshUXc/wLXMplaBPVI324P7PpO/ifdteyZCytzHvSFMPovEamtavGUVWZpXLkB0iuTQ/JC8P3mVUTQQ9p/YGBi1R5vbe/DKaeuEj6EZX8plVZLXDh4iT4cgYe20VAwQCKEz65LfT37bVzeSauhkmA+W0TuFWdDYb77+GeK/P6U8QYVW8RDZdklx7lIJdYn+rh4TKC
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7381dfcf-91e2-4eac-31ae-08dcee7a011c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:04:55.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+IM6n1JrP40lV0zYBxnMTc+Hsz+dZl02/jXYMa89SN6TNJayScCL4Za/UvO6oLBa+uvVqmph1YJAdE4Pveb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363
X-MDID: 1729148698-5dTnxE-eAMlW
X-MDID-O:
 eu1;fra;1729148698;5dTnxE-eAMlW;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neighbour-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.

Changes in v5:

 - Fix leak in neigh_hash_alloc
 - Refactor seq_file functions for readability
 - Reverse xmasify

Gilad Naaman (6):
  Add hlist_node to struct neighbour
  Define neigh_for_each
  Convert neigh_* seq_file functions to use hlist
  Convert neighbour iteration to use hlist+macro
  Remove bare neighbour::next pointer
  Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  24 +-
 include/linux/netdevice.h                     |   7 +
 include/net/neighbour.h                       |  26 +-
 include/net/neighbour_tables.h                |  12 +
 net/core/neighbour.c                          | 365 +++++++-----------
 6 files changed, 203 insertions(+), 232 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.46.0


