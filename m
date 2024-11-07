Return-Path: <netdev+bounces-142891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268F79C0AC7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A382849DD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430162144D6;
	Thu,  7 Nov 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="d6HJmGKR"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA52144D4
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995512; cv=fail; b=uLMDb+JhvyZvaFwksDQQA8tU7vIWsZrA2AE5wVVYHm+JGkOvISTcOhLW0J/VqgyhnOGjxnhdaxyiq3S8jd1BSNFLnDvHwlkKiYjKkCszWH4gtOj8EF5hcTEeSfqM7peDFRsnhZUAB9m6tT4odnPr+hgYUaenBrBtUBXxx0yn5lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995512; c=relaxed/simple;
	bh=wRDXq4KnObBIDA4BqD3773XGaKp3SKWUJL81Lvhh+r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnLESe+XSpoopSHGJ2U2ozVzVDwf+if73z4g+W8sLFjVo3KwSKFMuhtKU+GdDPyR1i24Rj+rMAUaZkh2T8rRgj9kdaMyWB7ArZrYRcg7KFG95V2Hqa1jJqR4+XlMP0pJwZoPNuNThyOPEwL5BQKW90tUzsnOaet63hB1aKwWglI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=d6HJmGKR; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0B09D480063;
	Thu,  7 Nov 2024 16:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKG0RKLx77D70grVAuWxd64EZ3TdntRb7GlbyvGXGMQxMAueQQpmnT8LRu16NMsKHgelnngU6R5x3eUIOG16ZETJKxoja10rtnekCFKNq1etJ8NT6ECZh98pmSwSMgBnm8OhtPYfU9mqObWYZnD1HULtbbM8f/Q8g1KoLIrKRr8SDY/kZtWW9gewfyW1m8Pn2R8T0Uk9d8wsWu50rNJTv6AUovkb2CtiiCp6U/HBo/qAzB9Kx7clofu+nLviWqDI9D3gPZYlJ8kpiKtAIVWuIi3I8Y7x0y5w0122+DC/X5blMu+sOn1yhohj+9+90I0hI3lg49nNgtgvGpLK0tdicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XE8lGBpL4f3fHxpbegmRttBBbC5qazmOj6/n5o2SLM=;
 b=INs8/lUKHkftcL67bQ5/yYj7k9RC5EyLEIBG0k0Rth4ejvLkEfjEeOV3bk9jbhE5x/sT1glMDoIPldHYgo+eha4w05QqiGDXANUagjrgw8F4JQrVYd722CkEX8sxMPMTQXn7SxzJ0nCAOP08R2LHRpGOSHjX88YwXTjbEDmUkVKpq3kv+Ta8u0jcZ2b/1ng6bGuythWcTweKoyqw+Hr2mvT26bqdN1QqvBwbSQ2+NhoZsqwl8OnoLGXYj6Q4LCr+l+2hqFhXB3PZ/lTIPd0jfIvcY0Hhn4c2a8qX8yq74nRIKl7tLYB0+OpJzeETrTfpZITeimy1NOfj29DG2JEfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XE8lGBpL4f3fHxpbegmRttBBbC5qazmOj6/n5o2SLM=;
 b=d6HJmGKRgr6rfZ+J0ydhHydT70ALqEuuKpvvNonPR5HVbWWixU8jomA+/D5plMWRXQwz8vwmHDOTpzShlUIUD+s0OkKreNalTa0VSxPImhbLFeqyOfSXQjDF/rSmCfalDLuLv+79MT3FIOwuWBdUAEPDEzBhj92o0IeiU8jK5mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB9296.eurprd08.prod.outlook.com (2603:10a6:20b:598::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 16:05:04 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:05:03 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v9 1/6] neighbour: Add hlist_node to struct neighbour
Date: Thu,  7 Nov 2024 16:04:38 +0000
Message-Id: <20241107160444.2913124-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107160444.2913124-1-gnaaman@drivenets.com>
References: <20241107160444.2913124-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS2PR08MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: 099680b7-d65c-49fb-a125-08dcff45f0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/MqEBEa+lHYhohPNERDVVOI21PrL0tunOR0ayiQplMC80cR+5Ao3snN4J0L?=
 =?us-ascii?Q?kI0XxdMP34BgxT162oEQP9kziXaP/+Lea4uElP9TpkL6DAxuIZzPmp2r6k0R?=
 =?us-ascii?Q?xpXyrozm8NUHY683G9sgUFR7gV3e1CDfziG8l09QGUA8/tELs7fAsDR0jrV5?=
 =?us-ascii?Q?QEvEsrZszDTYX9GJp2uqqt1UWOaWjQ5lI5piCA24IIiVjbu3xAgpzHxD+3D9?=
 =?us-ascii?Q?Udt2YJXiFVfhEtIPGpgQRuXkJ9WCPOx2dhMg4AQD6ikT/Z0gQxGETe1Ev3Zh?=
 =?us-ascii?Q?l+7kB+dhrw2tt/2A/53CJ552T69cDSsWG42dZg8xTqFm/qFsepdPt1mlhWeI?=
 =?us-ascii?Q?SnffrTIccM0Q6ayVaXxe1iamPRNWxV7duX4d1fFHfEBI4qPJyJUzG4qkUVWZ?=
 =?us-ascii?Q?NaGHp0/eRp/zgzLTiNiDg09gsS3krD3TL6YBJqxaxVfLY/ESUzP20FH7OlBf?=
 =?us-ascii?Q?s4jW/WEzPE1ycpcFfLXgjbKP3VsbrbmSJ6A6QiTmkPR6jzcPPrSdEyoz2Mk0?=
 =?us-ascii?Q?ybylEgJKJkM5Hj0sMf7oSp5ZvPNqhVlzCWAa/dChnJzWhEcpFnIQ+Pwozv+v?=
 =?us-ascii?Q?ld3ZNxfkrNEqT25fp37fAlJwddLAECMJ7PA1uEku9nG5wcPI1s8OlTYTxRs+?=
 =?us-ascii?Q?30CT9JPLb6sWiGADlhzgehzwrTcP0QPXs2SggoUE4S9hs40F27vISPmCui+a?=
 =?us-ascii?Q?nCU6Gth5MIbFL/827X2/41F5bNJIpf2JPso1swmvEuF7fShFvUl9bBJcLCGL?=
 =?us-ascii?Q?egyi57/W2+bFIGmShNsx/f3BLCgXyAesLfLywxxqtM83KcpuONq/W7oapq3W?=
 =?us-ascii?Q?ga+l5mue6/ah+pw0Rf7sYr3h9m3TtalKiuDSEPrZoZlmekQHjtdtvYhEi7yH?=
 =?us-ascii?Q?a/Q94WXcrLMqkv49TPvZPKn2K8dc2WYa9aUF9G1DDPyd9TmzZZ+7+AAJ5nDO?=
 =?us-ascii?Q?RKH65+7Qg7Cjn0/1rBLeotXfbxRKRHa4A9n8eAY0Zcoy3cydyPA0ukYeHXZ7?=
 =?us-ascii?Q?kgSmj2TuWaPGaRcuAsdIjpEkA5Rcj3ffxmziV8RS5iejPTyOFnMPoRJOXsu6?=
 =?us-ascii?Q?mL0O/60myrZE3jL8+XAeLFIDqrN4EGbs6LGjvPhyqjc3hWCFhYVe1dApjA2s?=
 =?us-ascii?Q?5+sC1mX6hSsvxu1CSLdk9LDsiyX15W3m+AeJ0VQfzIBtCtFAyVuinyT0RWnq?=
 =?us-ascii?Q?ZLer1CwfP8R3ZfQ9jGKMOr/uOsRX0t4dQ66nlqUujeGLF2CfgvmakbUbFXPs?=
 =?us-ascii?Q?MlkzDJaeFWqZB/pWZanCSx2YDKeQmPmvF+HgowK7gKB2cuwaOrEqE+Tom0Os?=
 =?us-ascii?Q?r4MJ8tCExbxy6DmA++xovUIBkADc/yl7lQddGjTVbH7RI42YeIuhDgtwaxO0?=
 =?us-ascii?Q?R9DE5WQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yw3bejnUBtVPRrzuQvfR/vml01NQ3w5TeJqCJv/SMoJT4SHvXRVwDJdR+aoK?=
 =?us-ascii?Q?2is6AWcOQgf19mOtmxXvffF3AUz6T8R08k7xM1sEiAi5SPyU9Xnw6lO9Hdpm?=
 =?us-ascii?Q?VU7WHpAJhzmJ9SNVw9SC6Zf+BpeYN2tY6SAaLGi//uP0c/c29joij0kOCf4M?=
 =?us-ascii?Q?BI86PicaTBkBbnzjQqLDQyn28Ai3yGdDgie9/ZeTXtGngtUJO6a9oI/EKe7d?=
 =?us-ascii?Q?MbGRH8IAFnZGGZA9kairRhZHgtno9hkQP1ZlGoYjy+/BFzn6rh52cFgEBux7?=
 =?us-ascii?Q?oWwAMAc9zbpNKur6zkwbEJbXzuwiGqYT2bqvqks82QRiL6LqtR9T1okVgoDG?=
 =?us-ascii?Q?2vMkyvcF223GtITyvxyheMjXizrW1zC1/ea/RucmagB8DKVKhmNr2DQXCBSB?=
 =?us-ascii?Q?v/aIOlJxtMbV+W/Pl/hnV/7HlHBtNelyU8Owgw0EwOHQBOVIHHcnmydevE89?=
 =?us-ascii?Q?DQjG95G08KT4MBlLLhU2qm5YRu6bTgWWTKs8XJ4+w22NZfY0DYYcArrnSsRv?=
 =?us-ascii?Q?cFafUFWNtb1HekC9tf3bBRw9R1z3WrTtcGS1M9eFB6XGAM7Hsou0Lc7iD3WM?=
 =?us-ascii?Q?H+sLlOCeLtAHZwijfuLmvKlS/SQA/WlSLQmhoB0gUxNpo8/7rZeuZp7xCKPr?=
 =?us-ascii?Q?QzV5vsGX+qAgmP3X8Wvui2eGLjsgudk26/mdQH6sfOg5VqJv61hREGGiGUl5?=
 =?us-ascii?Q?f3r2EwlNZPjipCGTWUTBs8gsMC93tZ8txbkhRxQ/mW8BMyaos9FZiEaYTrty?=
 =?us-ascii?Q?9kTixZTTcCr2MMWwJSSbAmmNM/+/cNhwjWKS4gvWqA+tQcbU/k/VNYSuu4Pz?=
 =?us-ascii?Q?sb7c7pG3WgS5DIxflvD0eDJVRYsA2SIA54+l8cYeiGK0pcE4+gl1enTCq4kH?=
 =?us-ascii?Q?eiXiXr00A5WY/vT0QWoAhL9ux9O4cS+b/TT7EsmJManFsXotXuJZLb82BqVR?=
 =?us-ascii?Q?nOUEyVVMOdYxFpATxOoYLDuAa9ecEDZ9/Rz09MFppfU3+T+E8rgMyprrV7tl?=
 =?us-ascii?Q?9QM8Am9ZpQoIyTe/um6JpyasH86Z67EAoW2L3jK7HVktCnxxda6p8vGIlZkX?=
 =?us-ascii?Q?zYLMlTzzxdAPj3ua1MoJsuH7keq3kMhtnB3fxsLwePmAO5/i0O5ydmIcsJpr?=
 =?us-ascii?Q?btjxY1TgFLVgGo3nQhnXryRCm09X+5HTjroYPG27fLyJ0q6azVuOZnHlrf9W?=
 =?us-ascii?Q?M9G67uvQzhJv5k0e2wAvedpkiaNcxPyhDEIXVZsKVjiTdXCC67OqA5ssgAFr?=
 =?us-ascii?Q?/V4zGXAbee/ZX/O4Pt+ptowwub9oT3G8WDZ39Sx/I9Inxh3X5oVyu29rXEAi?=
 =?us-ascii?Q?R1KnV+o/6FlC0rwGY2q2WybVbIF2k0Vm3zeM8SrTlsCW2wbj2LsJCV414aaI?=
 =?us-ascii?Q?nyi4E19dx1TQTdtelRYoGN9sNYMNSSmMnkfss+xKmqbMP3e3mTU1YQ+VvqC/?=
 =?us-ascii?Q?FxH5ys3sH06wVlEDRBXT/lRFqnfsagy1883lqPyOXEoaWF+JkQApFJPTtFvl?=
 =?us-ascii?Q?1zX8xL3GJA236HMX6FIGyH3Q5JbBQeM65f2T69EfGLLDqLignS7VoP53Cyqk?=
 =?us-ascii?Q?kBsG2VTbXHMlAl4e8EoA7gtvbkjPKK7ssISa1oJfxCnMHhh3b7TBCw/u6PgY?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x5espOFd2vCYiBy0Dwuc4+2/4Karhy34tPfk8Ggdt4qPqNjGicC4EWgnSrgj7dMoBQTS6HHN4t4UVlvgvc4AXEcH52jgNCe0bnfT4PZr7dM80PzMFUMtLPSXi73wzL2eQq5doG/w2hNnaIJxPTtUgj55lH3F25mvhH//VHGjExQOCuDkhCpl/Jm8TM171KXJctve8u+wK1ZdgQUOv53Y0xgiIUZ4QpMSFtjVJzLmxuE1MeNbwrm0O0/QnhyRoU99NTaqe7D76/QLvzJHgDY0F1bu/ToZ2GMB57a4XhDHYt2pbDlw13D5ooRjDFmc3U7Woj2o5Ka9rfyITY6yVwQmNjpCdrF1y9bfR3HWzSVVOhDKnfM3PTaHaXBpDJrTKIlN6t8F1/1m9Hel0GhRLQtD/eYjMPlOe6vgevJN5sl7hffJZNzuNTTrAzTvo2ymc19vW+guovSJyC+bdDOBgyrATUZmO9u1G0FYfTz9iP5wJhEy6nX50d4bI7hLB4bTivM5tvDGAvJtDIzI2erFa4cxIEuMTGJCt4i7pFVZuCWVfltuBqJY1xaj8KIJnE7wAb+7BtfE162R79JRU/ZAS9WVfLOtuBowuAnE6DyutxRCf7BtHFlFMsuQAKKZ3zU0BrcN
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099680b7-d65c-49fb-a125-08dcff45f0d7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:05:03.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54U4k/meJm6SaMBRq36VZlbOrIk5R1FSDG78XLPu0C3la4/t13UG9Xhm3cAB6VHcjLwGrKCWSnKI5pM1vjp+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-MDID: 1730995506-Xo8XbgfRfsvf
X-MDID-O:
 eu1;ams;1730995506;Xo8XbgfRfsvf;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a doubly-linked node to neighbours, so that they
can be deleted without iterating the entire bucket they're in.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/neighbour.h |  2 ++
 net/core/neighbour.c    | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3887ed9e5026..0402447854c7 100644
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
index 4b871cecd2ce..5552e6b05c82 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -216,6 +216,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 		neigh = rcu_dereference_protected(n->next,
 						  lockdep_is_held(&tbl->lock));
 		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -402,6 +403,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			rcu_assign_pointer(*np,
 				   rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -529,20 +531,30 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
+	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
 	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neigh_hash_table *ret;
 	struct neighbour __rcu **buckets;
+	struct hlist_head *hash_heads;
+	struct neigh_hash_table *ret;
 	int i;
 
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
+
 	buckets = kvzalloc(size, GFP_ATOMIC);
 	if (!buckets) {
 		kfree(ret);
 		return NULL;
 	}
+	hash_heads = kvzalloc(hash_heads_size, GFP_ATOMIC);
+	if (!hash_heads) {
+		kvfree(buckets);
+		kfree(ret);
+		return NULL;
+	}
 	ret->hash_buckets = buckets;
+	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
 		neigh_get_hash_rnd(&ret->hash_rnd[i]);
@@ -556,6 +568,7 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    rcu);
 
 	kvfree(nht->hash_buckets);
+	kvfree(nht->hash_heads);
 	kfree(nht);
 }
 
@@ -592,6 +605,8 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 						new_nht->hash_buckets[hash],
 						lockdep_is_held(&tbl->lock)));
 			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			hlist_del_rcu(&n->hash);
+			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
 	}
 
@@ -702,6 +717,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 			   rcu_dereference_protected(nht->hash_buckets[hash_val],
 						     lockdep_is_held(&tbl->lock)));
 	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -987,6 +1003,7 @@ static void neigh_periodic_work(struct work_struct *work)
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3116,6 +3133,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 			} else
 				np = &n->next;
-- 
2.34.1


