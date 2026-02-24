Return-Path: <netdev+bounces-260563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHoPDGjEnWnsRwQAu9opvQ
	(envelope-from <netdev+bounces-260563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:31:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F9B189090
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8522C31A7DF7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F53A4F2B;
	Tue, 24 Feb 2026 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="g6cehP4u"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021102.outbound.protection.outlook.com [52.101.125.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80E3A1E93;
	Tue, 24 Feb 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946899; cv=fail; b=Lwz3lGxyi9l0/k2eh4RIcYQDlsgNWaCbOzH1b+hUkoCFIo/kWz+JKdiKC+cs4Y4CqCB9caMz5jcj3xGOyGXty7dh4Dy9CZW3jaftbAwX35FipUXuR26u4sbs0cVSIefAGfp8Zky4+3d+CZFvDNm6d3KHrINM6icdxcUXH4f2FFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946899; c=relaxed/simple;
	bh=pOD9tShg21azxOFa4mnNxH8bqyQcXlREEGf1NpsqGJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhEZsGbDMvOCP4jrYRwzGxaEOX/wU+J7bdFcs2KXO/lLxKejYbcsTtvX0FUw+1GbXlK+9LA1FoGnmKw9WmhonJ2abTlPiyTFTLuh4++rR52ChduuGZHf6qu8WJ747fJcq9vTQeYvNW+jBZP3wAFW7NiHdwmB2iz/C5b5xE5G4YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g6cehP4u; arc=fail smtp.client-ip=52.101.125.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vANWZgrsjY8Q7ZTT/RNfO2fhW+ZTk70Gqf4jAiXrJfFNaMgZiG0y8rsWxiDnY7nwEjg52EHpo2oJgoOlFzuQrIG5vDIj3jBTaLqHxdbROE5i2bk0gSkuYw4o3oAVPWkxh6SenZvMZdFfLUouTZxWPubfXKg1TNGxhd2NCFfXIJChj3fsqtKHTAcYfLOI5OlGrhmP3QcFPv2slCg6JXly/IcTC5oPiaCiS8Q7D2WUEsu7R/YHbre9zSzamJMfgBHSPCMwdBChhs1v0wI0kI4n33kk9xERaeKIOFQT47WnaLLy5EpstLJYr5pr3XI1IaYgWjkyvBcHNFrQjOerTFWPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpsBZzczUl1C4mAv165HazfO3lsD54jFeoa4ExF/rGc=;
 b=gpa2cJ2PcfDG8UxLTrgY/xvx4atLVvNpQZi1vasRa/eCxkfDJl1xZDo6pDCxFktiJMAg6SltfIh3FhiT/8Uf9FTHzhySeGGj7rfVU5zQPeSzYIvV26vkAu8V0vZjUa8MfJmmBy5RSGZwGPAe4ea+/yvM0MM35r47uB+zopo9YlwWO/rLNolhGFgLKNLXRjmVtqbZ0GLAYlxIoY7dXkhM9UHGnDZQMKPQB2hsjgRhmfQ0hSFDEGDMQdMLLxlXgurnWAPA7a49B3iePfZsMI4mo8FpDpxo8medSoDHMIRMd5qJPlq2VlK2DXqBHGQGtik+OwkNs5LioTMIfCPGRtwd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpsBZzczUl1C4mAv165HazfO3lsD54jFeoa4ExF/rGc=;
 b=g6cehP4usIvYNJFUTeGEK81h0isNKtBuqUbI/H34rdS9ha9t52QPFb+1TwrTFqrYEa+0QP2JcsF85JIDe19HNrU7JB7Mp5SUEcCN8luXho68Nds3/ARMd8lA7vd6zL8U193yKnPweVDaiY/lGBD9V4krpFmcRk+13301F2fYMv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6904.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:418::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:28:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:28:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] net: ntb_netdev: Introduce per-queue context
Date: Wed, 25 Feb 2026 00:28:07 +0900
Message-ID: <20260224152809.1799199-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224152809.1799199-1-den@valinux.co.jp>
References: <20260224152809.1799199-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 323a1628-c9fd-4d0b-546f-08de73b9522d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?itP0n2ijXE66453bjyodPiJaE78og79+Sr6ooNJv0Mh/6Yh8ITSp7P3XXYph?=
 =?us-ascii?Q?M0BE6ExVzj+aFfoJ3hGqupP+IiHjCmtiCSRdZxuebK1ph/hKW7/naRU8fvTB?=
 =?us-ascii?Q?Oblhnmc5+7/f0LGYYmJw75krs/YwoQ91BRpLO84d88ituxlrlp8LdnUavFEE?=
 =?us-ascii?Q?zfCrq6PJ8hMDpU0OuXLtkZV1+uilnsDuRob2V1oDVuUmprJIXgpXce5NgzHC?=
 =?us-ascii?Q?zmX1or8qK3Ag7bviQF+SvD+HGZWDTq5u2dZRp6MBBo38JQKEslC2xALFG/zV?=
 =?us-ascii?Q?wWOH934j08qeS6r8Uar8inmcWJjyVS7Pav1DJPvFxCWttt7oosh7XJ1uw6EE?=
 =?us-ascii?Q?lTyvhaybj61TYR6jOv0CAWOzL5eKWrW7215LO+pz+h/Hik2HTsrDzY+XWGF1?=
 =?us-ascii?Q?KsBQ6fFRFY5sTRDidDqi2k6HWuM22IYc/uPB5MhAXpymY7ft6rw+bdoja12H?=
 =?us-ascii?Q?GXFDyyUFFnH2nlXSx11gSZn6oc2hYubSiYijlw4Ncxa2v/CKjvCK4a0JkEvt?=
 =?us-ascii?Q?3xL2tbPmF02TYdgH2gy0uTZDI7wOP2VCYZPwXAUihYZ3ZGxYxWF08pc5E8QK?=
 =?us-ascii?Q?osVge605NIhHk5RIsyxAwTwfIH9vT3AVfxpesUcXmdhNKjal+nAZPBUtHEI2?=
 =?us-ascii?Q?5SzcPg/KRMesj7ZrkOlbzNGwr0Q606o5JvYgRXaq+bCJlOjMabSwG/aYn3ng?=
 =?us-ascii?Q?nGouRXmkfSS/T9NBOh3dVd9Ab73auGrPJ7/xbD44FfekY9IkAVV0kcWBC2aE?=
 =?us-ascii?Q?WvX0IaPPLkhBpZmQagiEcnP5SIpRZkUkugdhVlgYQJfGk+5Tq00Nd9B7grlq?=
 =?us-ascii?Q?E4Gp36Fa54hF70o4i/DmmgzlomsuOH1TSotgOEWlih4FduOO0dsdLzIjA38V?=
 =?us-ascii?Q?m5knwGFZzKWiFp/Pr1jCoecrGSMHEPRe/CVSO63EfmJCb89PgekPFp5xwNEf?=
 =?us-ascii?Q?AvZ7cOLq8jp3420bFH0hAGV0G1dz5aDw+fcRb30DfsA9cL2RA5BA2qKf864V?=
 =?us-ascii?Q?eRhRF2MCHEylcNIqfmuxFMRtkCzfOCSA1RPGssh4QpCsGwZ1e1dpZAXxUld+?=
 =?us-ascii?Q?s9E5sLuNMXCTXuhwxCrdYGodovm9wwN1pPL9wOZ1VmwZCYpj3XGgNWm65Qwe?=
 =?us-ascii?Q?9A36PBu0QbvzZKZD7JDiQf+g6ngyGmPsAgWzrRAuMihKiBPa2uQvf0aYBwlB?=
 =?us-ascii?Q?/I0IuH9FQvBi4HRCT2OJtLAQzaKWQJIliuxx7Cev5ayLP/QfMW2d7kFsj1J+?=
 =?us-ascii?Q?i1SFufi5sAKWdWXwjF9Bb1PV8+aV/hHoSxYnOhwkNIvN57ZMXGiHhLIjwRhY?=
 =?us-ascii?Q?FIUF3X4NrDsVelURFac3876STluAr8C1Ty2ZP/a3jbCZgeihP7H5h+vjaqbl?=
 =?us-ascii?Q?YYbifywoaPvBAQGFBjFtJ7hO6cS9JqH+53KYBlDZJdQv3jtpYHS3+AjN6Cs5?=
 =?us-ascii?Q?ZUlizWW9Y2jRJsioG5oQW0wASDnZc5X8LocFeSovT2Wl+C9r/gJICqNurvqN?=
 =?us-ascii?Q?FbyKQVkjkI3/HTowfqgm4XxHt7sTdCsYn0eAjEYCrtEPMhB4u35OwPCpoFre?=
 =?us-ascii?Q?oooG7ZoeBHa3RhVEEr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7y0K7G16XN3/xcCqI9fdKSxsIStGvsNrEfQd6fsJyLDD6bx6Eu9rEkEWoLGn?=
 =?us-ascii?Q?34YSNaAm4eTxC20ncK8gjR/byw/02/wC59fZj5iIKKos9XbeYiCDoqQOQiCF?=
 =?us-ascii?Q?8vyirPmYaMNnVOQRPrGX15Z5vtv1U9smcJiH/SE8AUofCYV6tndK8cFuGTXH?=
 =?us-ascii?Q?4X5ABeJOvKL1tTaBMZdRTrvGp3NeXMFfVuuEIOZsLI0X1scJgpxR3H+N+oyZ?=
 =?us-ascii?Q?QjMMB/Y4eRM0C6H+9stiwzCOIjHsJARYYaOMRgLaqOYGZOV0qheM1LFzkiqn?=
 =?us-ascii?Q?WCG2I/2UwfcBJ6cuQkOd6JelYdKkvfvWD1Xg5ArH4IU7ql2W8PT+1c4Sopyo?=
 =?us-ascii?Q?TjG5x3R5yxOOWyWol+ouSxWSe/5NDmNieDe8Qr4zu0zHWy50daxHRp3Q4ibH?=
 =?us-ascii?Q?FN0K1qi5B8q7uTRtIOh8UOEn84nQ4r43ch1SI7Vjctiqt6X2a3R3fmOi/EQE?=
 =?us-ascii?Q?wZFJfPtUm7qoODKLV+Vu6a1e7ZhBQmjKhvJuixJdRB/ZaHJ0Ai28Rft4AXBu?=
 =?us-ascii?Q?HU2yrBd++4fiaWYTdREsIViJvUt+5ziGwQ0t++kapvwO41bvsjPlNI66Try4?=
 =?us-ascii?Q?1ma9UEfho3SKZTzg/MQtsx1bpoGMsTOPry3szXt8bCmtd/TBwGVW9GFctnBw?=
 =?us-ascii?Q?qh/tmRRCULh27CTOUeEDpijKGgq2//+r6kMvYKR1iZpD2BchgyHGgkurJx5l?=
 =?us-ascii?Q?3ifxa6IdE4aQKdi2jb0mEwL7bLTZxwqsrktYpxxgaza5HTYeuxBET0oQy/gc?=
 =?us-ascii?Q?lxvE5OhDIz3rCLKFnjM7+A6JFYLxI0xWL4oUqLG9ia5cNSr70Ws/sSMoQo6W?=
 =?us-ascii?Q?VzZwTjmgdwWhzgCHIMeQ1K9jGRAGOS139Kg/gWhjbtCIyt1DpCrAbMnlo4nL?=
 =?us-ascii?Q?+znMKK7dAVd5uD3zs878bdtWletbFfwHK0KWUAB4N8iWRCk4w2epLGIX7oxN?=
 =?us-ascii?Q?yPHZYWeomQsHYg9JqogNarosjsZR9p1f5SymRA4M6t4YiTSkzVzonvxwYodX?=
 =?us-ascii?Q?UfX4BmgWB+myhpKpjTQgWf+Xgl+AaiFSMizZkB+HjSjlr8+rOUmE6kYoM5dZ?=
 =?us-ascii?Q?E5Jr52JisvtjV+g7soSDmAC3qmt+pcGOz5oPQWc3qzYONfSt3XRrOKcK+0AC?=
 =?us-ascii?Q?qEM/QSQ+3qcpsmfg7yPsOL5WUzl2pBj4PQgnprttsKECnxQeq8cKA36E/NEh?=
 =?us-ascii?Q?jwJZIDBYhXfLuziJpostro87uaFjFrx8CCgvCWtl7ro+W5lqeFL0hJYM3JiH?=
 =?us-ascii?Q?Fh5aY36N6rlM/watZK3Xr+wY2RTm5DCMo08xB/VbvpPAPYgtWc6dHdf/1qFC?=
 =?us-ascii?Q?7UYmjuHfX96RzWYd2oSEOXmJlrhdPeyjPJUangcP4h76i7GkhjskxESSa08l?=
 =?us-ascii?Q?k/YrUR29jGZFufbARLPbnI0ej2f/E49s7hxSE9TT7/laxOhm3OJ5UN32dCar?=
 =?us-ascii?Q?UfNJpYRoU/lFR95vFXoHt9BY4+Bdousqp5lSOlU8QCL++Bg+XLEWs7bwIQHp?=
 =?us-ascii?Q?ZFvc+tdB2hlRPf6Ewuh496URRZNTY3lJvczU1uzNh4r+zmt1iNWvi1UgdlH8?=
 =?us-ascii?Q?FAU81mUm4dCgHy8vjGbeYQjTXu7JaQ6vNpps/ru4JBDV9zOsZVq6CbwSNdsS?=
 =?us-ascii?Q?Y8Qx8sCGM1DNLCkwn0OekqOIayMtV7Do+bEVS2K7mwYmyDHG7FYEcU+jEr26?=
 =?us-ascii?Q?dPxzaQ/qvpZPe8gsETFYSh4iGaW0tRTYf6VfSMXvGLat/JjelySj8OGC8058?=
 =?us-ascii?Q?6SFk7EHZngEWaajFxdl3JJD2CrRFEoRfalxkfqSkbt4+dnexY0Rx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 323a1628-c9fd-4d0b-546f-08de73b9522d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:28:11.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMV71MuugkXmBAUKqKrYsHPdoi2tuOW81FVhzVja+rB8B4w7ZcNmfzWj0URPc/5wnjXha6K1KMtt8OVDXCQNrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6904
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-260563-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: A4F9B189090
X-Rspamd-Action: no action

Prepare ntb_netdev for multi-queue operation by moving queue-pair state
out of struct ntb_netdev.

Introduce struct ntb_netdev_queue to carry the ntb_transport_qp pointer,
the per-QP TX timer and queue id. Pass this object as the callback
context and convert the RX/TX handlers and link event path accordingly.

The probe path allocates an array of per-queue objects and creates queue
pairs in a loop, recording the number successfully created in
dev->num_queues. The netdev is configured to match that count and the
driver uses the netdev subqueue helpers for flow control.

With the current default of ntb_num_queues=1, behavior is unchanged.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 298 ++++++++++++++++++++++++++-------------
 1 file changed, 200 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..d8734dfc2eee 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -53,6 +53,7 @@
 #include <linux/pci.h>
 #include <linux/ntb.h>
 #include <linux/ntb_transport.h>
+#include <linux/slab.h>
 
 #define NTB_NETDEV_VER	"0.7"
 
@@ -70,11 +71,22 @@ static unsigned int tx_start = 10;
 /* Number of descriptors still available before stop upper layer tx */
 static unsigned int tx_stop = 5;
 
-struct ntb_netdev {
-	struct pci_dev *pdev;
-	struct net_device *ndev;
+static unsigned int ntb_num_queues = 1;
+
+struct ntb_netdev;
+
+struct ntb_netdev_queue {
+	struct ntb_netdev *ntdev;
 	struct ntb_transport_qp *qp;
 	struct timer_list tx_timer;
+	u16 qid;
+};
+
+struct ntb_netdev {
+	struct pci_dev *pdev;
+	struct net_device *ndev;
+	unsigned int num_queues;
+	struct ntb_netdev_queue *queues;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
@@ -82,14 +94,24 @@ struct ntb_netdev {
 
 static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
-	struct net_device *ndev = data;
-	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
+	bool any_up = false;
+	unsigned int i;
 
-	netdev_dbg(ndev, "Event %x, Link %x\n", link_is_up,
-		   ntb_transport_link_query(dev->qp));
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
 
 	if (link_is_up) {
-		if (ntb_transport_link_query(dev->qp))
+		for (i = 0; i < dev->num_queues; i++) {
+			if (ntb_transport_link_query(dev->queues[i].qp)) {
+				any_up = true;
+				break;
+			}
+		}
+
+		if (any_up)
 			netif_carrier_on(ndev);
 	} else {
 		netif_carrier_off(ndev);
@@ -99,7 +121,9 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
 	int rc;
 
@@ -118,6 +142,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
+	skb_record_rx_queue(skb, q->qid);
 
 	if (netif_rx(skb) == NET_RX_DROP) {
 		ndev->stats.rx_errors++;
@@ -135,7 +160,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 enqueue_again:
-	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
+	rc = ntb_transport_rx_enqueue(q->qp, skb, skb->data,
+				      ndev->mtu + ETH_HLEN);
 	if (rc) {
 		dev_kfree_skb_any(skb);
 		ndev->stats.rx_errors++;
@@ -143,42 +169,37 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 }
 
-static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
-				      struct ntb_transport_qp *qp, int size)
+static int ntb_netdev_maybe_stop_tx(struct ntb_netdev_queue *q, int size)
 {
-	struct ntb_netdev *dev = netdev_priv(netdev);
+	struct net_device *ndev = q->ntdev->ndev;
+
+	if (ntb_transport_tx_free_entry(q->qp) >= size)
+		return 0;
+
+	netif_stop_subqueue(ndev, q->qid);
 
-	netif_stop_queue(netdev);
 	/* Make sure to see the latest value of ntb_transport_tx_free_entry()
 	 * since the queue was last started.
 	 */
 	smp_mb();
 
-	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (likely(ntb_transport_tx_free_entry(q->qp) < size)) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 		return -EBUSY;
 	}
 
-	netif_start_queue(netdev);
+	netif_wake_subqueue(ndev, q->qid);
+
 	return 0;
 }
 
-static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
-				    struct ntb_transport_qp *qp, int size)
-{
-	if (netif_queue_stopped(ndev) ||
-	    (ntb_transport_tx_free_entry(qp) >= size))
-		return 0;
-
-	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
-}
-
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
-	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
@@ -194,13 +215,12 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	dev_kfree_skb_any(skb);
 
-	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+	if (ntb_transport_tx_free_entry(qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
@@ -208,16 +228,26 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	u16 qid = skb_get_queue_mapping(skb);
+	struct ntb_netdev_queue *q;
 	int rc;
 
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	if (unlikely(!dev->num_queues))
+		goto err;
 
-	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
+	if (unlikely(qid >= dev->num_queues))
+		qid = 0;
+
+	q = &dev->queues[qid];
+
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
 	/* check for next submit */
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
 
 	return NETDEV_TX_OK;
 
@@ -229,80 +259,103 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
-	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
+	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
+	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev = dev->ndev;
 
-	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (ntb_transport_tx_free_entry(q->qp) < tx_stop) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
-		/* Make sure anybody stopping the queue after this sees the new
+		/*
+		 * Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int rc, i, len;
+	int rc = 0, i, len;
+	unsigned int q;
 
-	/* Add some empty rx bufs */
-	for (i = 0; i < NTB_RXQ_SIZE; i++) {
-		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-		if (!skb) {
-			rc = -ENOMEM;
-			goto err;
-		}
+	/* Add some empty rx bufs for each queue */
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		for (i = 0; i < NTB_RXQ_SIZE; i++) {
+			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+			if (!skb) {
+				rc = -ENOMEM;
+				goto err;
+			}
 
-		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-					      ndev->mtu + ETH_HLEN);
-		if (rc) {
-			dev_kfree_skb(skb);
-			goto err;
+			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+						      ndev->mtu + ETH_HLEN);
+			if (rc) {
+				dev_kfree_skb(skb);
+				goto err;
+			}
 		}
+
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
 	}
 
-	timer_setup(&dev->tx_timer, ntb_netdev_tx_timer, 0);
-
 	netif_carrier_off(ndev);
-	ntb_transport_link_up(dev->qp);
-	netif_start_queue(ndev);
+
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
+
+	netif_tx_start_all_queues(ndev);
 
 	return 0;
 
 err:
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 	return rc;
 }
 
 static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
+	unsigned int q;
 	int len;
 
-	ntb_transport_link_down(dev->qp);
+	netif_tx_stop_all_queues(ndev);
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
 
-	timer_delete_sync(&dev->tx_timer);
+		ntb_transport_link_down(queue->qp);
 
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+
+		timer_delete_sync(&queue->tx_timer);
+	}
 	return 0;
 }
 
 static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int len, rc;
+	unsigned int q, i;
+	int len, rc = 0;
 
-	if (new_mtu > ntb_transport_max_size(dev->qp) - ETH_HLEN)
+	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
@@ -311,41 +364,54 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	/* Bring down the link and dispose of posted rx entries */
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_down(dev->queues[q].qp);
 
 	if (ndev->mtu < new_mtu) {
-		int i;
+		for (q = 0; q < dev->num_queues; q++) {
+			queue = &dev->queues[q];
 
-		for (i = 0; (skb = ntb_transport_rx_remove(dev->qp, &len)); i++)
-			dev_kfree_skb(skb);
-
-		for (; i; i--) {
-			skb = netdev_alloc_skb(ndev, new_mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-						      new_mtu + ETH_HLEN);
-			if (rc) {
+			for (i = 0;
+			     (skb = ntb_transport_rx_remove(queue->qp, &len));
+			     i++)
 				dev_kfree_skb(skb);
-				goto err;
+
+			for (; i; i--) {
+				skb = netdev_alloc_skb(ndev,
+						       new_mtu + ETH_HLEN);
+				if (!skb) {
+					rc = -ENOMEM;
+					goto err;
+				}
+
+				rc = ntb_transport_rx_enqueue(queue->qp, skb,
+							      skb->data,
+							      new_mtu +
+							      ETH_HLEN);
+				if (rc) {
+					dev_kfree_skb(skb);
+					goto err;
+				}
 			}
 		}
 	}
 
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
-	ntb_transport_link_up(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
 
 	return 0;
 
 err:
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		ntb_transport_link_down(queue->qp);
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
 	return rc;
@@ -404,6 +470,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
+	unsigned int q;
 	int rc;
 
 	ntb = dev_ntb(client_dev->parent);
@@ -411,7 +478,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (!pdev)
 		return -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(*dev));
+	ndev = alloc_etherdev_mq(sizeof(*dev), ntb_num_queues);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -420,6 +487,15 @@ static int ntb_netdev_probe(struct device *client_dev)
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
+	dev->num_queues = 0;
+
+	dev->queues = kcalloc(ntb_num_queues, sizeof(*dev->queues),
+			      GFP_KERNEL);
+	if (!dev->queues) {
+		rc = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -436,26 +512,47 @@ static int ntb_netdev_probe(struct device *client_dev)
 	ndev->min_mtu = 0;
 	ndev->max_mtu = ETH_MAX_MTU;
 
-	dev->qp = ntb_transport_create_queue(ndev, client_dev,
-					     &ntb_netdev_handlers);
-	if (!dev->qp) {
+	for (q = 0; q < ntb_num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp)
+			break;
+
+		dev->num_queues++;
+	}
+
+	if (!dev->num_queues) {
 		rc = -EIO;
-		goto err;
+		goto err_free_queues;
 	}
 
-	ndev->mtu = ntb_transport_max_size(dev->qp) - ETH_HLEN;
+	rc = netif_set_real_num_queues(ndev, dev->num_queues, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN;
 
 	rc = register_netdev(ndev);
 	if (rc)
-		goto err1;
+		goto err_free_qps;
 
 	dev_set_drvdata(client_dev, ndev);
-	dev_info(&pdev->dev, "%s created\n", ndev->name);
+	dev_info(&pdev->dev, "%s created with %u queue pairs\n",
+		 ndev->name, dev->num_queues);
 	return 0;
 
-err1:
-	ntb_transport_free_queue(dev->qp);
-err:
+err_free_qps:
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+err_free_queues:
+	kfree(dev->queues);
+
+err_free_netdev:
 	free_netdev(ndev);
 	return rc;
 }
@@ -464,9 +561,14 @@ static void ntb_netdev_remove(struct device *client_dev)
 {
 	struct net_device *ndev = dev_get_drvdata(client_dev);
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int q;
+
 
 	unregister_netdev(ndev);
-	ntb_transport_free_queue(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+	kfree(dev->queues);
 	free_netdev(ndev);
 }
 
-- 
2.51.0


