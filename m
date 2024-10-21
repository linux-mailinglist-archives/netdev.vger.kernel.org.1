Return-Path: <netdev+bounces-137421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32F9A62B6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148ABB215A4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E91E5703;
	Mon, 21 Oct 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="PNx7AaRA"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70B1E3DF3
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506285; cv=fail; b=Hq/kf1SdAI6uxLKXqQk48wBbx7Yt8L57uKSZXQ4iSk6pJyjdUaT2knDW1VVg7lr04kWkajf4F8TZ5zpT6LJasFfYmkgpciHFXNH2dXKorNsWGR96ENc4/01HcsW9wpXTLscm3faUXMq/XA7xuenJ3mxqDl8KZpuWWGnbZuG9EC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506285; c=relaxed/simple;
	bh=E0Q+txzHoHcyPDio2XkdOD9ksxQytXX3Bdj9z/kjmhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjY75/dtp2IrTTCBUNl0KpCFzGhiiZaxb9haowTsLLrKY50gJUzQAUFcruQ96+19g3ESGAQwUq4nUXxlSxNVvDm0tDBW8BAR+HfThzxJz9qD+ZKB2oQjuKTK071jQaxC//6pAbl+enozmGqCbKCRUsPic7EWH3R6Pp4nmkR5atA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=PNx7AaRA; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02lp2105.outbound.protection.outlook.com [104.47.11.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4D9BBC0062;
	Mon, 21 Oct 2024 10:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDRcJG5v9SfDCpQjjR2S53Ezf4b/didaiU/zbC6amFBZZlcNbmSMOryapaivO/rY9sjnDpUnmLcO/E7ga5g+5gpOflt+HgrhH+mTVvhhlw83vj57eKSKBPSGx8xKpwUUf4X/SZYKRay5r7rALmOnYt3+kVreQVXQ0021CGTxSnQ6KCRQ3lP7j4khKQzy1o6cNv3oo+rhscf4qzUeG3TeoyQM9x5a9d7v1A9B5qKz4QaIgACbGFXtoAshEYIfbwaqtRZ9HykU5dyr6E6HTqok13HZwIO6Xby4eDRXQz8dY5eBZsDlvj+0RJST/y7alBefDWgasVrOnYV5rg9xnArfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV938W5MlSLYy2/R85NGtVzjF4XUd41Xv4F2LHIOI3o=;
 b=VqiEz6lqL0F4k5nO5iFD6IxmOedFSihAL8tePE0YVvliZLjrJEi3HMpWuyLfGzUZ0nuhsHWvhZOfkBGrRI4AvyX5lMQkhdX6S+ij9EFkuc2S1u7VugNWo2QSub5DiU2+nIjNHwlCSsUPfPr3JJujhCl12uAtIPfLZSudGc2HiQ1zuWN5whRAsxmMD7q+vr357RneEvJFEXFV7NoUIawO6ewD0ikFBXhgtr8sRJ6EZPdKxCtcQVpCK9RQUV7bGZw5GgnInD0o46M3MuktJOhP6v/v5z4HrQIhXD5D4qa82TxfaMZ7h/28ixCN6U9weTsGjUiljR3sP4E4d9ojuQPA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV938W5MlSLYy2/R85NGtVzjF4XUd41Xv4F2LHIOI3o=;
 b=PNx7AaRAihRUEgFLclp/7p122Xm3mKO3FMP/GYJnWbD4H5JCTIVSBdYJlP+rezuITHhEcpeVV8DjXqi2Xw9W3MFQAi3ijwE/ew9xUpiucPGJLitMpeF2uXmv6nIQ17yZUkjihs3FlNc317BlyhVB2d0CYTVDYBsoY2TSfoZb56U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV1PR08MB7707.eurprd08.prod.outlook.com (2603:10a6:150:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Mon, 21 Oct
 2024 10:24:35 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:24:35 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v6 4/6] neighbour: Convert iteration to use hlist+macro
Date: Mon, 21 Oct 2024 10:20:56 +0000
Message-ID: <20241021102102.2560279-5-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021102102.2560279-1-gnaaman@drivenets.com>
References: <20241021102102.2560279-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|GV1PR08MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 66746bed-addf-4ef0-bad6-08dcf1ba8f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKZPpVw8B+M/tyYi8BByYlSHMvWWHwIEXo8q29lV4VjVnLRwHh2pK2rgQP2A?=
 =?us-ascii?Q?xN6DSQDfmrejw3VWslI3N6+G9auyOy9R5jJu2Ojx6YV/Jghvw0qILnK/93/Q?=
 =?us-ascii?Q?Ix9ayWw4o/Wuy9NauH4dYb83cBf4govWBAC0ho3057aM9jsKyi1o2nBf1ojr?=
 =?us-ascii?Q?1X50sm9ivrbkqJYa2hmprNau3NfJHrk7+9FK5wMbx1o3tatZX4e3XKzl+hjc?=
 =?us-ascii?Q?gmCQH20y+JDjjbdV4Y4awsAHU6K7CCvujI14IoGDqMLLmmotNf0UiQhyv0kz?=
 =?us-ascii?Q?AGTNRA41UQVabrsLNLmlNQkBcI2fHWb5ZLplU95ghPF3OL60mohyuqo2NUZa?=
 =?us-ascii?Q?gbMTlGkkx1hCsY+5IR8M59CiadYiKLRBgY1cU5ONxPx5/xawTeBdDb1NE8S8?=
 =?us-ascii?Q?Beqx6qS0Ng2TCRlBYjPfnGEhLlNTKQ36/EWpqxDQy53L6g1W55fs5azhi/Iq?=
 =?us-ascii?Q?5gNM136ZYPgK0BQ9H7Ci/L3geuSCbENKt3c2fIo0kb7BiDrLP9OgxpPPQNUG?=
 =?us-ascii?Q?xkF0Y4v7o3JBU1Gy7NMamiw2u2oHg8wLL3CF+VUt/EAnRRznv6agqjeQ3ApZ?=
 =?us-ascii?Q?FA20c/tAFIcJiwJluiK1Ga6DkIS+lJS/d63JSn0aDEpJPMNbhb1Y3DWJ+1t0?=
 =?us-ascii?Q?46AZogwdIpYIm3Qw6GJ00HKrS4TQ0SkgK56EctivFD2YA308ymvB/eSiHbf0?=
 =?us-ascii?Q?d3Wv3sNfFBX3Af9bJIr2ctoYupU+3iLLEUSD1ywwtGt57R2/oLVmirnbye0I?=
 =?us-ascii?Q?WiJaE+UWrZc46vplN21isYtJi05sPxscAnUE1FJPQi2Q7gi7XA+3BJcpeUeT?=
 =?us-ascii?Q?Nt2F6a+EBi7wAm2cbwxz9LVTLk0y75Fobk5mLXMuuFGY0+YSydnsZOrXnn3L?=
 =?us-ascii?Q?pUu8rGKb5JAvar8KajAnplziFNVydpO7Ti0YkvPGU+yE6CfmU8PN/0WSd6bH?=
 =?us-ascii?Q?6uP9N4MGWUqI7ndFPLXQQssW3P+VeLPbFKl9splY3HnQjoLW6YirmJIcZGzp?=
 =?us-ascii?Q?SGL/saB+lJM9f0aJW9jmJNrl1gLoUPifDHmfvN3+2gvsncv8rE6lxmv8Wbl0?=
 =?us-ascii?Q?fP21/JEITobNi+xtbIN7HnqIp0A/aEihHHbgkdJERXbh7/9bnMhS1YTAmNsl?=
 =?us-ascii?Q?+9j1gkn7EgKKT99oLenSZvA+U94ij4DQz/wfxpu0uPkQOGdW2d/1luAju1bT?=
 =?us-ascii?Q?W6KwKT02UuigmOBLkjwAr2W1bnR35E5tQ1iPZvuoqB5/GS0mXfxoVlnF4znT?=
 =?us-ascii?Q?nlxorAZRkyiEuDI1eqeSOkag1qGz+iM0D0BCQfJ8MtuYt2BDmayYENKCvVm0?=
 =?us-ascii?Q?HTzR6VaRKIYS+oicvDRrLRG6zTGAz898JCs/mX26SfUjEYN2vkP3WiatFtsM?=
 =?us-ascii?Q?Zba+PPA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfyRKmZBZ88X2kQxvrI0FaL9kjduqIzotOeCP/AnS1PchBpngAx0ojN9Z3KO?=
 =?us-ascii?Q?60jnYa/Y1QOIdCpdvN3SnlFsMyQcNDfAbIvVw1Ty9WPipBQwyafnq114ogmk?=
 =?us-ascii?Q?NtEm2yLJES8l1Mbs0DNZfhF8cjHcdZYjyu9ppSEv3bdYFTbepZVinTzVBcOv?=
 =?us-ascii?Q?kHpIwjD2VzUoMc21NtaRLiXjsnQSWfgQT2/lSmVp7MW4bVfPbnSgcoqmbC35?=
 =?us-ascii?Q?0ga3JONU3N44JI4UaOfjXhN3Ub1Vs9bP0vru5v0CTnzttuS+QJ0SP0GkqWDE?=
 =?us-ascii?Q?ZkOtJ63rVLocjHOiKY0awecNYLXLgeBXqcLuwae7ShuqDkKDOCWquiMq8WEJ?=
 =?us-ascii?Q?xyMilrVDdDx++4UAMqCaXs6Yv307dq1mZtFj7BkUD1x3avyQd5yOMHIADMQz?=
 =?us-ascii?Q?pm04pAzT0W+BtdVnn8taiqlKGf1X2HIS51kNEL8k2Xr7SVChEJ9rNR/2T4/4?=
 =?us-ascii?Q?xN9DapJn5/U9I0Pj3Ga9bI6Vb0/KeC4l2Srm9WBl+ftX0Ee3/Mf1pqT+jFo8?=
 =?us-ascii?Q?RDbwX4AaVeNOf1RXRbgsr2gtNVylZF8XWGdgfvSwuAAcHlhr65lbw1YUvYWi?=
 =?us-ascii?Q?79ibX+QMtKIcskHEyuwPPW6vpaHeq4/UkJls3yq9cxoydxzuWrfKJnuIuzKy?=
 =?us-ascii?Q?NLpqTToB+Fi0wlFU3sHStp+yhxep6GSE65TaqQ0JfVAGD3mCE08BPu7UfFNy?=
 =?us-ascii?Q?r9Lnu9hOOpNuwyh2/czpPcVOEjuAlRAVG4Kf1CoEXNwAedrkw8uRzoXulzcj?=
 =?us-ascii?Q?rRouuNbtEjAncqe6bxc0xYcYYJsSlQ7c1G6OaDxIY4RTiYOv4CJJFVG6BbGo?=
 =?us-ascii?Q?rebr/+muNc3R2tx9cDvu+1bzvNHhBEcsGC8pEbTynhtLe6C2u7GYFknDmPes?=
 =?us-ascii?Q?RajaidGS6WdPDGPqQnTneEPagBz8aWTzovqz2S03XV96Xo8/nZpenX0RmQ45?=
 =?us-ascii?Q?js6XfxuPCRSuQKdwTSCxMDQtSyKqgbrKFAD9+GYDGj83II+yWCWi5/i/YbKB?=
 =?us-ascii?Q?cHjkvexiyVxJyqi6EBPYu/aF7w1uQ7zdfKn3oSGCsLg9iBlfA9H9RkH4N1EF?=
 =?us-ascii?Q?baLtvb3yfT5X805lKbxIKgADLrOwKR2nPhKpJa28TjvsOlTyDNkhYz+5GbDR?=
 =?us-ascii?Q?YHlrgFFpcQTKhe+vK6xemTzuDS63eTulDqXRoHVjDAyWdSKHW0k2TPyidHxs?=
 =?us-ascii?Q?+oPr8Fs8owG3DfDX2V30dX/UB6MjHHoDXFvrgTrCNKe9JDcvIifA0Tbw6oMn?=
 =?us-ascii?Q?Y4wCmXzXon2/QwM3UoseOszPiGrc++cYSvDo+PoFXLaRmvHi3XU4E9K7NWsz?=
 =?us-ascii?Q?a77tIgCL0k/7wURuRM5bMQibg+652kAX7uve5qL7CobW4puGUoNHRtkj0xBc?=
 =?us-ascii?Q?h2NpUbqSzFAHmNRuRejJMVBA+9drfIEwUKFlzrg/VTrDxHwIdozj/TdjUG4m?=
 =?us-ascii?Q?sMNkrD6DoVBLdObwubYI66s4lqx7beNfWXkexplyXo7mdE7POIWmfjefTJEv?=
 =?us-ascii?Q?G9r4gZmp56HmE5bKd4H4bBk/yCBicK1Y7nE0c9z4DVNV4Zg+pA2kw3JiABxg?=
 =?us-ascii?Q?whCUxpvjR4oXl4tD1YUU9LDSqoljwrirVquzgPG7yDPf7ojfGPcMBLZqbtTd?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zg88QyFId3r4SBo9d+jJ1OzGOp9XwFZoGvI8knWrLfulcX3W81yZl4lPFKdZPtI7RYIh/N65TrwweYUehT6/ttwmT6se7C8Fx4gDfSo/afaoXhWYOZddmfipPzAt7HsrxlSGxdDYk5PYXN/qhAXE4oacnEywK2N+FVuy7qjDcuWvN9lG064M/y6tz0oqiqijORgSJvKWZRAvECvXXLS3sCYWBp79N7OfMWwoPzpN1U0vureOCLae4Ja1y7VX/WsykYTZgzcj3Ed5/M9ESbvsUAXRiLbe0Pa7gMeBUWTNT82gGQFodSxeXQ/R4jO494D5Z1jNHeuT/bghKtyitnuvLQPhDs9fXsFZ3E+PJbEi4GuGYdPYBe3ZBnyptpSoON7DfWQjH/0sfYEp3YTqApLG0B1BJx8IpZl915Ibf7Kp+xG/OsDFo3426o5eOL0dpGj2w05nIkBo/d+X/tmyJPIOWi3jTNdmyiosXVGle5faKljVGQFngXc4iJZiH3pIWXj3JyUHPFtpkndYCdkerFEIrDGyqQB+w75FdfucdPo72qsjJRCpd+zkSqZ62vJ3i1PzsMrkcj1WzPzgGGFNQ1ZVxekPShw5joKOV1VUMiaaP17oYwrHRdfjHYF5GSJZVzo/
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66746bed-addf-4ef0-bad6-08dcf1ba8f33
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:24:34.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pAKl55YXoiSaZxDwlZZCBObkvdAFVBXr0fbt8WQQFyRVhlhQazVmT8r3Q80HHMad3BLFvR/wBp0hVMb+9lAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7707
X-MDID: 1729506281-trmW8L5bgJG5
X-MDID-O:
 eu1;fra;1729506281;trmW8L5bgJG5;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove all usage of the bare neighbour::next pointer,
replacing them with neighbour::hash and its for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  5 +----
 net/core/neighbour.c    | 45 ++++++++++++++++-------------------------
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 69aaacd1419f..68b1970d9045 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -309,12 +309,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	neigh_for_each_in_bucket(n, &nht->hash_heads[hash_val])
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
-	}
 
 	return NULL;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e70693643d04..395078d8b226 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -388,11 +388,11 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour *n;
 		struct neighbour __rcu **np = &nht->hash_buckets[i];
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			if (dev && n->dev != dev) {
 				np = &n->next;
 				continue;
@@ -620,18 +620,14 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 		return old_nht;
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
-		struct neighbour *n, *next;
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
-		     n != NULL;
-		     n = next) {
+		neigh_for_each_in_bucket_safe(n, tmp, &old_nht->hash_heads[i]) {
 			hash = tbl->hash(n->primary_key, n->dev,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
 
 			rcu_assign_pointer(n->next,
 					   rcu_dereference_protected(
@@ -726,11 +722,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	neigh_for_each_in_bucket(n1, &nht->hash_heads[hash_val]) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -982,10 +974,11 @@ static void neigh_connect(struct neighbour *neigh)
 static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
-	struct neighbour *n;
+	struct neigh_hash_table *nht;
 	struct neighbour __rcu **np;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 	unsigned int i;
-	struct neigh_hash_table *nht;
 
 	NEIGH_CACHE_STAT_INC(tbl, periodic_gc_runs);
 
@@ -1012,8 +1005,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
 		np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-				lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
 			write_lock(&n->lock);
@@ -2763,9 +2755,8 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		idx = 0;
+		neigh_for_each_in_bucket(n, &nht->hash_heads[h]) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3132,9 +3123,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
+		neigh_for_each_in_bucket(n, &nht->hash_heads[chain])
 			cb(n, cookie);
 	}
 	read_unlock_bh(&tbl->lock);
@@ -3146,18 +3135,18 @@ EXPORT_SYMBOL(neigh_for_each);
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *))
 {
-	int chain;
 	struct neigh_hash_table *nht;
+	int chain;
 
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
+		struct hlist_node *tmp;
 		struct neighbour __rcu **np;
 
 		np = &nht->hash_buckets[chain];
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
-- 
2.46.0


