Return-Path: <netdev+bounces-142893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2C9C0AC9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B671C22C97
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED716215F6D;
	Thu,  7 Nov 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="hqcDUlub"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A41215F51
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995515; cv=fail; b=XrZQKIOkjw7xcrRkIeBqUZxl5OMon97hsAijffY65CBqKY5f7a2I9DG/OTyEpXReLPf0SpSEIfMjVBMHzmDp9pOxBMe9H01iwRe82K68h6XHtC6cfCo4wfq6Og9OBTtzIMeaCvrRhTLLQAobiYxNWZ4Vcqv7glW/7kOKvtT4bwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995515; c=relaxed/simple;
	bh=o/sJmCH23AgOiBiW6FCiG0uh/qlrb5HwB1kB2FGNjm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6yKExG5L4n0I11K4mXv8AsliBsSOj13JRKMnoxzmvg9hxFX4UVuxbOVjhzBN2hLE0U5K8D7oO/pLX0WnDvKz+iEksSrae5pAXwqkOpd9UDVV7S3ZEROhLlDQV0Dl0IXQxKSl9IexcRKmetX7QqD8/B9QSbS7jX993tcUsfD2EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=hqcDUlub; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 395F2480061;
	Thu,  7 Nov 2024 16:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUMXT48EvRX8Px3BCSyijk8Vg56bFS1d+4cWSLY/ZLFuipSe9gyhPuLaGkyI8g5QhTWvw47DYMHEbPZj8D+LTz5zZkeQYliyUNP2XT/wvsPBJTVx2t/sNU3WJDYFflPnheoA/eKbGOQ5mZcGhwhtCG9nRNvTl2XRCEbAla3L/vBZFemJ2h6dd/YVB6aWNIbwFWk51wl1kHsZlAuPhZirEHO0aWqxkdwSFR9T8dpoPLiO4KnMPXNeoX6xMQuOuWN6vgHmF2kljxCGCoy6p4jURHZPA2zv/z97D/ghlPp+8i8iyQEWfo5krIA2bo4CdAepLEoIFUvdsK3/bnlXLYc1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRsvtrurKqv2Ls5pVFJGUXGd5ObigBJoVJu8c4OZPFc=;
 b=GHQLV3r+o8dXyoEq1J/DMZgOv0BbcBzQt8IpnmZUv7/u8Q0EZdmd7YhvJ8PWZ2mwQHspsPjfk85UyMYcxFiXPbx36DelQN6l6rbsoK9Ra+XGVk2pI2VzFe0jUwX75U0cw2YMBCGVpgIEDN2u5nhqpSgOs56YmkbZFyvY/l25iRCusxbNOdHKTYykzRMpF7Cj0hZgXZ1jOZyVYJIrpfSXes4W3NzEx90MPEYqfCKzlPX9DV+lRwJxF/O7D2uXH5bzcdZg5ocR+wqMw9wtkOWlzI8t5Myh90agN3NmXdFV02visREUmC9gzohF9Qjh/lA+zyCWK3Oq+a7sk9jOlZXzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRsvtrurKqv2Ls5pVFJGUXGd5ObigBJoVJu8c4OZPFc=;
 b=hqcDUlubQao9zQ651znxVcWAz/F8vnIP6Cpo2awGg/pUQPfDbziMPy6FIqm+7R9zP+MFPdhw8kpGPetXD0IWvDP/abCJi/77tYvhywYAwTrxmvxFeZsw2/+U3gW4Fh/jWaIm7lfxYCEM+pOPuJr9j7CExzp+iD23eJOYb/XJpbA=
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
 16:05:04 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v9 2/6] neighbour: Define neigh_for_each_in_bucket
Date: Thu,  7 Nov 2024 16:04:39 +0000
Message-Id: <20241107160444.2913124-3-gnaaman@drivenets.com>
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
X-MS-Office365-Filtering-Correlation-Id: 23fa45ca-b694-4d8c-7e12-08dcff45f166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CYn/fksjVDTiVgmnwDqfTbBxYFh/A1vS3M3i0jOafjnqQLtTY+GJQsh/CGD?=
 =?us-ascii?Q?PV8UOz5xOehrwgcdkC0+4BiV27KItkjIq2HsU+tPdmU/1jjoLhkt3M4st7k6?=
 =?us-ascii?Q?2li4llSjvP/DbVaWbkMpMo+Zzz46lYBkGfo+9Jin+RLg1Z72+pibbG+qb9Fp?=
 =?us-ascii?Q?WJvYSwQc0StT5btY4+t4AzY/iRor6LS+KJfe7EpFssfQleCvxnmzG5nSUm/a?=
 =?us-ascii?Q?LSaLcmfOd61Dzpf3Y0XbFT0tZHEYc1c3aybQ3T2z22jnZkyGdXMUQhgumQPZ?=
 =?us-ascii?Q?cxbHXY3aUGZe/vgum5g8jK/qDLyWRnd8lVrjxWlKe7vlUhB9EDcbTYMBvlze?=
 =?us-ascii?Q?fUYDLTYTodsB4FDmjO71WZ4VN3Dnf6Ueofh+HJPRxmCINBXNEczLUUypzfWm?=
 =?us-ascii?Q?VifbXZGi3ztaqwLknN9sPTFjOBuiCKbfWwlGLUJYBoZnjpZqyOereM0+DL3X?=
 =?us-ascii?Q?2rOaKSMdGNgdrevaofspf0pR+KlMFjkTOKIiG/u/JpPJWHCvSY5BakHZcKRY?=
 =?us-ascii?Q?e75JXR72Xeb9/j8MJ87iR7JjxnviNWZovU0mvmL6n2H5PAFd8ebNXYkQmxyN?=
 =?us-ascii?Q?vGwGyqxKLdfofyC2nbWL89JMA1HA2uMS80gaW/t8QlisfoGOO9CDDZc3Ywa6?=
 =?us-ascii?Q?JeJYjI8LMlOXuI3WETyLd9Ma4XfmR52V5uTDR0aXW7uzg052cXVmxWeFRJwR?=
 =?us-ascii?Q?VM5jXZRXZO8oikAOTeZS+FyqQJoWqqYVgdu/uit3wGneybIUvh4aqzcimOzy?=
 =?us-ascii?Q?hyrodF/PYydTDgyfT/Oa565RnuqxoiuFj3PrqpNYvGfN3S9Dmdva2+zei1wC?=
 =?us-ascii?Q?7KKkM2LcvTPovThYJtYOBIeWcg+yy2HrEuspngDvgKlw+NH/q1JSAuCHH+u/?=
 =?us-ascii?Q?qNXK/Wu5J/eYe7K4bRoZwGVym+CaalqYhwjtRNB/ARC6xkArnHqUWztnVgMb?=
 =?us-ascii?Q?hlr5pkkS24GklQQ7TU7lLX+wBngWAEOnicRA3CLCN5ZhyoNhH9XuN7a35nYr?=
 =?us-ascii?Q?Qz9TsBwQ64rZsQxfT7mqrbaGpddfk8d1gB8q+JeNgbeIB0n8R5U7E7vA7f7m?=
 =?us-ascii?Q?AzkxshLGWWFXvEUHF9g2uRCWxGtH5KJv9faqSN+ElQNUv/UW1lbS6818NveL?=
 =?us-ascii?Q?xBKEu4idPLPWFdpanAPm9/BKdV6gup9AOBl01vNmgCdbnnIl5yNSSp7du1K7?=
 =?us-ascii?Q?m5e/Yt70GFAJzx8xm6CK4vQhSzeRlo6XYfz1sOe95Hm4lmpyUXdgrWVhdtcC?=
 =?us-ascii?Q?Trv6kAMi3XMBOdi/7YE8AbN9V5oROTfwUjjfgcH3aJHtuF//2EdHvxOkpfNZ?=
 =?us-ascii?Q?+3bWhnqNx+0XHWt25NOGMWkipOKfco1YgPwNZJcHGA5pWE3ncL5nI8/oNwe8?=
 =?us-ascii?Q?MeZh03c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+F7VxA1Q4g8Qrj4kz6QIMGNhxAzEoO+WMHpeM9hXbtEUSIWCws82RpLbE7Q?=
 =?us-ascii?Q?XnOfwBTu5RNzqGfltgrsyFkkcd+PCCvKRC9mQB5jgowYFRPyoB5IYa5769W2?=
 =?us-ascii?Q?Yrl7MOqpWy7tNRUa3FqiQZNgM6KqXTBjbO+CjC8yKUxAMJSDBWrtsxTgVBLK?=
 =?us-ascii?Q?0PV91N349z13oLZhQwtZXRVRvJNd/gvS88PMXpL0vsaU0LGePrt975cXeBbq?=
 =?us-ascii?Q?zcSqDvcT3NdoPGWjMM78sXrHqyyIsDSjPgj8vY3vIoS2koEwgA8QdBmNKG30?=
 =?us-ascii?Q?pzBm/Uu6ZycJRgdKBNqdegfUXlwOsjD5zcdwS8BOcD2+Yku9HtceCj4U2ujx?=
 =?us-ascii?Q?CUfitXETIcyQkKRANttCCcQgohkBuJ8YbtXsKWWWasrWlEcWgX1SFupb/hTF?=
 =?us-ascii?Q?00adqpdawj4+5gttFyNKwSpRK/yUGECsRbPZqLJbahob1bx7EktO6KmwQTsO?=
 =?us-ascii?Q?74wcjSBRJuegr5ZsxKyZiu73BH0cSlJJiEVrvFUon1dmreiIMYFawD3pcG1/?=
 =?us-ascii?Q?MwmZfBz3QEN8Vd8OL7T4WPQnn74XZFf+zNtby1046uNYtpwsR0orv+lrcdv2?=
 =?us-ascii?Q?6JlBzrQcAFOjcsLgW7o70lSAzT3UTWE72b3OHNc1BF1pVEMXQ53ju/Nsb4By?=
 =?us-ascii?Q?iQJvjRy0VIjlrjJNfOxged/Y/BYIDt7CHaTjHuuf15TPssuUF+FpmLljAekB?=
 =?us-ascii?Q?30dpz2QTauPdthK01zSV8KSeoRXin9W+Yvxg9euZAZbwS/Gl4yO3H6Ts+OyV?=
 =?us-ascii?Q?dXCfQpFIY6lDE9/EbqoxfxbwZsiHoZ53SBhKrFSOsojzil1FpwLA3IsIxPCi?=
 =?us-ascii?Q?r8/JKPRMcUQrqLWgs/XfxeODLesCE8QJAats4msezwwQCXZFMaaO5SBtr5t+?=
 =?us-ascii?Q?cmTVCxDgFmR0YG+96I0pB6iS7HBVXFrqyPdP4np2nLN5Z/1SOE1KsTbHGzMo?=
 =?us-ascii?Q?TdGHs5JJRd+NUwoo7AFIXhVZ1mGVHyAFcU39LuiCxBYOHTqcypzpzWqYkjNA?=
 =?us-ascii?Q?kZy4wRDANC3im+h0dOT1K9diveqG6hQ7nOO72Fsz4fIV3CS/lY1L+IqJo/e5?=
 =?us-ascii?Q?XXzkQDOzcYZmo+fZlWQHJ1EA+utHt/sRkBwyBz9rWAlShd9SReNbTd6tuOeP?=
 =?us-ascii?Q?kDvAieNZQjtLWwwNcOUczjradw5/+Q6NwblVOY2RECACi21tOaqk2hVJ5dUK?=
 =?us-ascii?Q?NBaoVh+M9CRvchnyYWe4fpVYT+EiSeYHHIqihlYKbABHA4lNI7ApdDBJCuRT?=
 =?us-ascii?Q?OI3nd+GZt2hb7muiZeP2FFwZHe6LJYUiQz+E0iBpIzoxOXzR6kLbQPsCxXvc?=
 =?us-ascii?Q?wFbmdZNdi7i7jUM/tOMO330ko9PPwODbwWYlar2AWEdsTIJwqZMI8AZPFgIQ?=
 =?us-ascii?Q?k5r9T7QuW1as3+ly5JNINEXvSyVObwU9DzheHwsoQV6G1v9t6RSO4d0zAH/2?=
 =?us-ascii?Q?lKe2RoKDFWBCiH92Cflhy101mwZx+Ztkd9HVjFSNfxgDVd81wQCQ2zdmrLSN?=
 =?us-ascii?Q?hkYfz8Y3JPRQW1jqS4Dc5bmVGTYn4ysyJ+ffu8I0O2VSGcYzIQkQLqmCcsxM?=
 =?us-ascii?Q?QeTxWWijxnjz1A+uojXGiLF4iDsh2KFZG93hjGROrQyZIhSIZkRPZohGcV5G?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hTih9YkvtC8Sy0iXOc65FPP4i3rp435h+c6EJHruX0xf4PVRDGJUm60QDaKu0lv6L3d9Bt0jfsyrXozKG6QzOO2J5XUQJnTg7coEts1YQbwUlIMxQZVg60reMyc4wIrlBpYG8t0VBLYksoLaC77rcz4PuKldlAzYcSLxMzLG8jhQ+z83aRnlM+tiuq9RgW09Bag/M9jHDkP0jvdZ0OU0emV1cqaVlDhZfGnZYwaszBtHMM4NOq7ur0N/31HiDD8kQ21L0BviTdLeecamAreEpqYbAYT83+jiyJgtCuQzwBkyjfYFTqN4AP72XBHbXT80aUBxvWLRuuqJZpGFTjHt4MQQNA9LG4GfXNEAr7GH0xk0LGlczc3a7Z8pFJiiHL0s2t54SJbEUDoho7ht20uiCzZ93+LYM32UJ3wSds/t6lcCP8iXJsVNOupiu19eVIa/nBsG2El+WhVNi4ewjoV6kF4iVj9hnUHzW8v2pX/8CZPFSNCam9Achz9lJSm6adFkywMWpmH13u2/TvSZD2mshX0YzfTvH81+gIfG3W5DcJ8YDdKCxJ4QoA6Ys7OTUUsYsuoTotqFu20aGBhDw750yq5ty2TXLeTPKvmqLPnA87vcOFzwDRuNoOSMbShMQ2aB
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fa45ca-b694-4d8c-7e12-08dcff45f166
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:05:04.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8UmhZwlQ8ekrZgjUwyObFA7Kic81ub9lrVKf12z2osFKuQPSL0IPTvGq2zi77qU7D/S6xUtL8t4Mkxq27hBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-MDID: 1730995507-wD4_NtQjtGpc
X-MDID-O:
 eu1;ams;1730995507;wD4_NtQjtGpc;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Introduce neigh_for_each_in_bucket in neighbour.h, to help iterate over
the neighbour table more succinctly.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/neighbour.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0402447854c7..4b9068c5e668 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -277,6 +277,12 @@ static inline void *neighbour_priv(const struct neighbour *n)
 
 extern const struct nla_policy nda_policy[];
 
+#define neigh_for_each_in_bucket(pos, head) hlist_for_each_entry(pos, head, hash)
+#define neigh_for_each_in_bucket_rcu(pos, head) \
+	hlist_for_each_entry_rcu(pos, head, hash)
+#define neigh_for_each_in_bucket_safe(pos, tmp, head) \
+	hlist_for_each_entry_safe(pos, tmp, head, hash)
+
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
 	return *(const u32 *)n->primary_key == *(const u32 *)pkey;
-- 
2.34.1


