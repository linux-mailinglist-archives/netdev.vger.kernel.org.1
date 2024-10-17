Return-Path: <netdev+bounces-136424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA79A1B47
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BBC1C21E6A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA551C2DC1;
	Thu, 17 Oct 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="VVcLVp02"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4C155A24
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148708; cv=fail; b=b6x8a5UphSsN7A9Vh8rJdF/k0KNI5FGGj6putJ/XCSkFaGbmCQ0ygCsD28pxk4DOH2h1OL/fZLrb+d7GV+dn7ZOIpc1wZPpTWVTOuJo0ISsPAqcga35BwS2QYtGnQb/8nbJ2A8UtfYKqw7kJ2x57phS7xB0Lg7Jnfg9KVYMDIRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148708; c=relaxed/simple;
	bh=xsE1AlvaE1VQi4zzjopRp5s1KCpdLJ5WUeO/ZVXTYe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Khlo7jB0+gZunn671cku9DljM1JJYcMEQVE7f/GqZsgmbpFweU+6C1nj35nWu3DtXN/CwBJryANYb/xN1ndHu+CD7q7nyPPOuVNzJ/Ms8fKiYjHH3S9O+iK8BTxPMtEl1c4mGfuPd7mIbrBWgMiYo4Ko2oa37QopEKVK7lndc/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=VVcLVp02; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 05FA3B0005D;
	Thu, 17 Oct 2024 07:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZXG5affyP9SbTnK0fInyuR3Sg3l69aCDlaxVj1srxi1nxkBALreFGEM2HKaxaF6jQymFZdfjVTfAEWBr1QwPRnD+JEjTtqjpB7d4qiYlXxdrJWXmRAQWm3SM+AFjwdgPH4Uvj/TWtYuVZBQ71Rjx8vIQd4xHZ5b8bvF0qb3HmB3jpuCCwHs8Pwt1UedYsWbqGnNsNFRC/QAR7ZjWUVoU1GRbAv1PgptidYEhxH+aEzuTswgbUncylps+LCxuRfxa2yIwQ+wUNUIHJrDQu2WDMW18+4NjEtRpDCC0iQ5gQaKcwk5oG7o//XG0WAAmSh/Une0o6FguosGLmFq/aRoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVy1rlRe9uEwK5FAC73MM3aNvNz9X6UkYTQlSbCABXY=;
 b=U+4yh6QsJlM/P7RuUwLhjvaOheLLTQBljmj/DJU/xTTTZOCzT1/OZV3Wn1UBIz6JcgpFJ6HIc7/U/OlP9FSeIsIOcrj5pkTMiI1WVbIMm81XZiOCO37r0AUP8aG4Db10cbJWDKgwZo0t3+Qnq+/wolW6emkQxpB8YxIDCQSJAKBp5V+D7x988xxDgvItPdfbKtPK4uQnvfnOgqiVb2KNSmqGAw7LbGWCjerwNTw4JT8vBmq9qiQZiHboMHYWjvycScq4L6bKB1iA3V15OFMXs/BKe64C2r5SmnhVP1VQV5t7ThBQoIZd4XXdSWgCbdfwKuy1vtU7kdzYAkBjQZPNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVy1rlRe9uEwK5FAC73MM3aNvNz9X6UkYTQlSbCABXY=;
 b=VVcLVp02FUkFqMJ73xjBUXNzM9SzPfITr1HuzooztkAUHMQelocyxykP8p8GGfsCtH/CMuoLnWmcMyuSpLg5e0sDjPzZRd5G5Gj36aDxq6zlUEqAF5zH/xxSv3CrGlNizHcRiIgAdy1WsxgbPnpu+cEUBGX12xs00cEWx+KsUr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 07:05:00 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 07:05:00 +0000
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
Subject: [PATCH net-next v5 3/6] Convert neigh_* seq_file functions to use hlist
Date: Thu, 17 Oct 2024 07:04:38 +0000
Message-ID: <20241017070445.4013745-4-gnaaman@drivenets.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59642937-7d68-4d1c-018b-08dcee7a03eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCLebh25prj6IMU2Fy1cPOgEDom6aNcGFSoZ2KygTR9aqAOb2RML/ts0k60n?=
 =?us-ascii?Q?UTwWYIg0PdQN3nE2BQpFklaW/MJ0ddx+Id5N5PsffkG2QvRCawh/de0CW4oW?=
 =?us-ascii?Q?40a7ZZoy74qKdpBweRZPbne/+xR05TqMBxtV0Pmrip0/3OEjxEIubC1xO1Ez?=
 =?us-ascii?Q?18C5earohXjMRYZ+lRbcmX/ikUhmqcEFf0oTJbvRctAGaBGb1P/Fvo2iwNmr?=
 =?us-ascii?Q?HurguY5gvzR0JcqH+9SZhQBovvZLTY24fDtDnJbj8xF+mbch3QgJ+G2GeMiY?=
 =?us-ascii?Q?Y736p/qyfxYJ4Ln6zxx9xTG3D5oXx0y1u4PR0bQb5Qgfdu5IFTkmF+c6RmHh?=
 =?us-ascii?Q?Wajd5PfdmKiDXsk/vIN2CI1wSHFHJIWUeNXc81Oz5rk9D+1B0nXTOASVbYCv?=
 =?us-ascii?Q?kdAP+8t8QV4BtOmT0kqhFpNIQQNYA9295vf7svWWUclZP3id3QDgOsSnJV7m?=
 =?us-ascii?Q?oRK9sdQtU3aMki+08nFBbLn+JF0CYGkea1sh+ABqO4bIpbYoPnMUeA3CA91R?=
 =?us-ascii?Q?t7fW1DNeShtALv30nzyKM4LtJuiivhU1XDa1Wu30WJ+tHOndpV3eouWFjHiS?=
 =?us-ascii?Q?s5ZVxrN2g8sIsz58/Ys6gD8KTMhZ8tPA0rpOEtbcDuCNBmRjteX4toJHL5eH?=
 =?us-ascii?Q?BkWFnuBwq4Oar/aDmBd2uggSwnxVzklAJGzAE0DoLVbJScDuStgRT4YoF1J9?=
 =?us-ascii?Q?CH7LARBTMK4PqCSJJ64arncw/YIoJbJM1q1XOHcHLr4pL8wqQgayTP4lY1PZ?=
 =?us-ascii?Q?TzStOVL0Vq+10P7NBXnlSSe6thByvz/hQJKXeTsZRkEij3hneb/CG9p9XV14?=
 =?us-ascii?Q?YLBIG+WnT9+Ux/6YuKQEqvT3drvpg8gwahbzH8KnTreO/WVOkUzRWCwVpVbg?=
 =?us-ascii?Q?ZUrS5qI7m0Vyx195yQsoFxwb+Az5oLXupezfIvcPKbvGFW9FcGfYtQ5Mtrk+?=
 =?us-ascii?Q?a6koKdVacvjLoqvv9JBFyY8J46yGJpSYzSt6KAsG3oH4+mTu06ZBKHa+7Z54?=
 =?us-ascii?Q?tCXOdQjm5+osHAL7lyIqv1xk/MUrn26Jy4gzPTLi1WMh3QXo07yGJZogiP2M?=
 =?us-ascii?Q?bA/qvrVLjHYj3XaCafs8fOxZvf17N1FuG5Mzm9z5onKIrOS0YtJk+qUAk3kW?=
 =?us-ascii?Q?bpQCnf35+G/EqW3ntXKlq3F0Wpa8eiQf1m9vwm0OB6Jv2DFKPPaDnoleoz8B?=
 =?us-ascii?Q?FDxTm75dRy/hO5N3tYFE04j1b/KR7vuwfOR9XGG+8+aY6Wvz6mSrflkzBtm9?=
 =?us-ascii?Q?nClxQJ45KKUXkF5wNZ7cA+ZRc+F9L9Fev3QaGGpEi4TrNWXFk9QDfWbx7g/P?=
 =?us-ascii?Q?yCqiWZBd43GyFltoXsDK5XlBIWAZ2cC0Yc8LiUtAZ7ApiTw635KE28sieNkc?=
 =?us-ascii?Q?RVAbspE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MUhtI9Xl45I+of7fG3OfMiPVfLHIv7O9EXjVmiGJEu14kb95MpHk2hUBRhi0?=
 =?us-ascii?Q?H1g5IfHRRzD4AUZHrxzqfLIP0563LRiJEXufFiRtTK9JdWKU4jtpKc4MmtK8?=
 =?us-ascii?Q?K40x9ZXhaRMhYCNeieyuSTAtaOeKiy9A3ihfrDI+4D903ubqMFGrnDVGp1BS?=
 =?us-ascii?Q?becLsdiTrqHRCRKNFkLEBL/KS83QzN7eLxHZagQWHYUhNEjBpcIz2WyNROC5?=
 =?us-ascii?Q?cFxy3FIOrwTS/IYpgwbjjKynIbzU9zag3KpLNGT3egjnpGm7Xq1ocY5aZ1S6?=
 =?us-ascii?Q?utMB4EX8qHdvwFeYbSm6V/xhDBpGMiVVD4LlrLrNHhgB3QxNjbxHOeEKICWG?=
 =?us-ascii?Q?jJi3mEYzDXrMlPeM/ayXYGTxuBA+0sXbcwfw5qK507k2SjW+2btEpC8zIT12?=
 =?us-ascii?Q?tvY8epCbVKQVppy+2NO34hAbDZKhVkgVaUbkuDGoxmRhgvDvthOyL6rYLAET?=
 =?us-ascii?Q?ApqL78cmYlTDBTl4X4GEj9Zi750W5TblWDaYxue7O7JXF9KD61lDb7E/pdUd?=
 =?us-ascii?Q?Bc/+C9Ol+7fElwoB7mPsaBoCq35XsuT/3GXVf1goi4tOOkPR6TGYZ8z6wmJU?=
 =?us-ascii?Q?TVkMBzSOdjrdhpUI7UQkxnrtbRcbXqbjcioQXhN8FAjOAaySJhnUyzcsZJtJ?=
 =?us-ascii?Q?2lNK1x3uiPalFKvrMVYdq7WsWvB7tvruriMyoEjds8B95poNoqc0jZP1mQcJ?=
 =?us-ascii?Q?oB3qMbA4t1ryJ3mEjD4EaxyQbE+ERRj0ruEHc/JFR2LTofHA5boXmEJaD7hZ?=
 =?us-ascii?Q?TBkH1C7ArLJEUebQjQsv4SF5lYtiIMOL8iz+bOOj/zqpmv63cgDaKaiCoG2P?=
 =?us-ascii?Q?lDBVYxOyeltSAFjgrHRwDATiqRsXyJcMyMN3eDcbFnXyGHFzZz2KSgjzfDAp?=
 =?us-ascii?Q?efar/v2wPP/eYHwIacEg0yWiaIXF2AJWZch6sOFX1BXs3mOzS4S+8urNR1Ff?=
 =?us-ascii?Q?gzLOP6kaL3xnfLB+oGeMbdafoJvzaa0sJDB0T36iXUe2qqj06Qr+9FGVfFJ3?=
 =?us-ascii?Q?yrAonXM1wgoP8ZsUCLIgjBLgzDxqyCW1n9di4bxnppwucZ8S/FTmAN/crSR7?=
 =?us-ascii?Q?vYIqOCsFnil0VL+JLrItwf28aPfx2tGBiZ+MGbxAwKN6MOfkh+Yl8ZGDmTPi?=
 =?us-ascii?Q?em/1owUsQJwEEPel4tY/HOSJjXdb8h6+aQ2Gj0L1X7Kh/UCoPBmuNifcDynd?=
 =?us-ascii?Q?YqOAcPMO8LJikHU3em1jv8t0GeUZb/t+MkHCr8LLhByIxPp17Ymatt1vaHno?=
 =?us-ascii?Q?y7XyA/6iYVfAeosEFGj+WhXXCQ4O00o3lu8QsvqY0yOeI+YmRZrk+BJ29s1A?=
 =?us-ascii?Q?8wsS67DAEoLS4vn/ACJt9+HN3K3ZSl9jAIkQuc4x5X4ZwvcIMIpeoWJdKuIa?=
 =?us-ascii?Q?4qx/OQCOj6XxapLnf3ajsExODEyb1P6yGJvfxZ8QC493THm2FmOoK/SeZdDU?=
 =?us-ascii?Q?0HjniX1qLetIvBiYRIDYDeglkAbAqKbS2sS5TEEgAFnol5kUvJMNaa+xPKti?=
 =?us-ascii?Q?K8hAKVFd+UsvjlMhRG4acrlQMKGyeQFjTuszDt6KxqcJLlWJWItzS94ewEID?=
 =?us-ascii?Q?uT7IPGT8/mH+yj7QWzoXVoc1NmQvITaXCMCTYpwR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LSz2qLNxqQsgXQ/Dklr1ZLsAT56Ye85v4IXDxMjCk5eClnZIqucU3468WAyuWWyn+4lTDLaLroMCN/4i1oRWf7vvfhrjT2SuLYjtHUq/vMpAlUiliP9yqEy1fouZuAfhCXUQxm5/5IyGzR3IYCiWtXcHoYRXXMg4xd4SJkT2gr1HcaiIjcJHt0+tfJYuQwpBJioiLAh34emXDRs++P39EVa7aaq+2r6ShBTJcBWqOpbhTq1cl4s9DIE6MvaWDhZ2YXfZ4ZCaoR1eQ6nV2ix2iLS4Ba07cZ/a3kGr1J52eeEmgqoCgoE8/gWw4A7vxodEEci2/9jY2QUzBTLwybrholVEiR3Jtv/Dy+zCOp2onHFoTTL4IY2W/s+F0XmVcrwxY2uNxrtrX8vKsWx6ABzHkyz1WIMXQPuhWpPS3fzYWAQ/gzBj5CXisXqj0iKscWW502qGBWgDrIDHkOpNGZvKOYnzBY8mJyl9L0n1wriy6Nb8XiHTKdX3mMu0TGP/vMeKLvwA1bJRigvTdkKqmnt015U0hqzbdIE6GD8o2EqI8jHgs+tVoaPa3wmLNoYW3JtCi1yHZSqnb3hRJSOca20tMlLRdKTdA++urZwsfeDjnNpDde9l4ZovEmD3LYuXEQ2s
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59642937-7d68-4d1c-018b-08dcee7a03eb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:05:00.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQyds9mQDzirOy8xH4jQCENGVjm/pBVXPVxyVAHAeDVyIBbrm0DoJEYOHVKumbXoCWQgwH3Vjy3lFo2HA+YZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363
X-MDID: 1729148701-jfwD1gcRoP6T
X-MDID-O:
 eu1;fra;1729148701;jfwD1gcRoP6T;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

Convert seq_file-related neighbour functionality to use neighbour::hash
and the related for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   2 +
 net/core/neighbour.c    | 104 +++++++++++++++++++---------------------
 2 files changed, 50 insertions(+), 56 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 37303656ab65..14f08a2e4f74 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -278,6 +278,8 @@ static inline void *neighbour_priv(const struct neighbour *n)
 extern const struct nla_policy nda_policy[];
 
 #define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
+#define neigh_first_entry(bucket) \
+	hlist_entry_safe((bucket)->first, struct neighbour, hash)
 
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d9c458e6f627..e4e31d2ca2ea 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3204,43 +3204,53 @@ EXPORT_SYMBOL(neigh_xmit);
 
 #ifdef CONFIG_PROC_FS
 
-static struct neighbour *neigh_get_first(struct seq_file *seq)
+static struct neighbour *neigh_get_valid(struct seq_file *seq,
+					 struct neighbour *n,
+					 loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
+
+	if (!net_eq(dev_net(n->dev), net))
+		return NULL;
+
+	if (state->neigh_sub_iter) {
+		loff_t fakep = 0;
+		void *v;
+
+		v = state->neigh_sub_iter(state, n, pos ? pos : &fakep);
+		if (!v)
+			return NULL;
+		if (pos)
+			return v;
+	}
+
+	if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
+		return n;
+
+	if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
+		return n;
+
+	return NULL;
+}
+
+static struct neighbour *neigh_get_first(struct seq_file *seq)
+{
+	struct neigh_seq_state *state = seq->private;
 	struct neigh_hash_table *nht = state->nht;
-	struct neighbour *n = NULL;
-	int bucket;
+	struct neighbour *n, *tmp;
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
-	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				loff_t fakep = 0;
-				void *v;
 
-				v = state->neigh_sub_iter(state, n, &fakep);
-				if (!v)
-					goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	while (++state->bucket < (1 << nht->hash_shift)) {
+		neigh_for_each(n, &nht->hash_heads[state->bucket]) {
+			tmp = neigh_get_valid(seq, n, NULL);
+			if (tmp)
+				return tmp;
 		}
-
-		if (n)
-			break;
 	}
-	state->bucket = bucket;
 
-	return n;
+	return NULL;
 }
 
 static struct neighbour *neigh_get_next(struct seq_file *seq,
@@ -3248,46 +3258,28 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 					loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
-	struct neigh_hash_table *nht = state->nht;
+	struct neighbour *tmp;
 
 	if (state->neigh_sub_iter) {
 		void *v = state->neigh_sub_iter(state, n, pos);
+
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
-
-	while (1) {
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				void *v = state->neigh_sub_iter(state, n, pos);
-				if (v)
-					return n;
-				goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
 
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	hlist_for_each_entry_continue(n, hash) {
+		tmp = neigh_get_valid(seq, n, pos);
+		if (tmp) {
+			n = tmp;
+			goto out;
 		}
-
-		if (n)
-			break;
-
-		if (++state->bucket >= (1 << nht->hash_shift))
-			break;
-
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
 	}
 
+	n = neigh_get_first(seq);
+out:
 	if (n && pos)
 		--(*pos);
+
 	return n;
 }
 
@@ -3390,7 +3382,7 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 	struct neigh_seq_state *state = seq->private;
 
 	state->tbl = tbl;
-	state->bucket = 0;
+	state->bucket = -1;
 	state->flags = (neigh_seq_flags & ~NEIGH_SEQ_IS_PNEIGH);
 
 	rcu_read_lock();
-- 
2.46.0


