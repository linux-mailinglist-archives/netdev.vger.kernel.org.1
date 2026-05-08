Return-Path: <netdev+bounces-285860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJRTJ1Ly/WlxlAAAu9opvQ
	(envelope-from <netdev+bounces-285860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:25:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBC4F7B07
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3283630B437A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0193EDAB9;
	Fri,  8 May 2026 14:22:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD03A5434;
	Fri,  8 May 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250139; cv=fail; b=CiIuv/jDCI/kgsIvmGEMDDCjBRRx+KId5b6zHbUVUUkdp+pGCVeIY9Qe8RL/K5di618Uw7E40rvggdEcwjTcvPxo5ojuaGBls08su5znxRSEGWrtDKZbAVamThjfgJH+l9M6UGkpw+xGejPffSi9jKEb+NBeM00PeyNsRPQNQec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250139; c=relaxed/simple;
	bh=0xe3OO6vlGGDslGraMcwOxjV5Zlj0eH+5JYbjhBzQLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxQEXU6PjOTd+bkhwj++Etc/wHFtJoqmCEO/T8HGPurpQKp6YE93b9ZjKYfEPrg4RmloyhvvWYfJ7JcAUMd/XU+hJRWbkGQpTQlGH1nxd++Rf3UkfoWG9nBAi+1wD+zSRiXYctvuSn5JAMxTn75rhEpYIFk8BPAq7GoCvtY8VFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds0pzkalzk/sOwbhjLz8dKsBv2syro+orYcyVGUV3ngGVMxXh6Tros5fOrO+8VluXLpp3ybwTMONdgLCYe1K6C6sFrbiWWP4TTSlfPVkAQwHL7t118TXnjKibn3QI4BsDKDQuGrCqXeM9CqTI7a9pQMif4n97n36w3MNQMwKPIKIOcvaHdf6xv6BzuB452/n54TYKzw+9vujjXAHLd/SuvROXI33bPwZj/hAg8VjruAh+Z39QEVULA49dyaIqAfAtQCeJmwNdFT6/fLvYVY4I7Qe0hXOt7gJtEuXXspsdU0AIg36pNAMRoohW8/CdGlz64x+hMHTPg02oVqoWgG6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdtcsAyFI5rP0nzMbemJTQA5mMkCNmq/wHqdor3F16Q=;
 b=f3Gnb3xNHpQcaPar367V18kr+jJBXM1x6CJx8OmDHcwvZzMDAJZIxgxvkz+suXrfcelj+hH8EuN4203wzC7YAFo+UdR3KaEpVu2b5P+2UIHgzZkHjwxUa8yvmH6F6ZjC179N/UUqbQFIKa1vhVsbH5p0oAgB4pN+ZmFln7ix0b0TR+m4IhoJLTQrFsRU6joJpXBBC00SkzStZw9lAjU152eSxSLMNNqRir/fNWQg9Qu7xFtiR7jrx+gSoerooP5S0+2lkbyAIDTI/oGyKNNSUQCwDB3OBWRVWR2si/QzKw3w5A0Kf5LLpsyZZW0iFf6lPX6/BNIL4BBN07/UlIVDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0696.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Fri, 8 May
 2026 09:45:32 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Fri, 8 May 2026 09:45:32 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v3 2/3] net: motorcomm: phy: set drive strength in YT8531s RGMII
Date: Fri,  8 May 2026 17:45:21 +0800
Message-Id: <20260508094522.3952-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508094522.3952-1-minda.chen@starfivetech.com>
References: <20260508094522.3952-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (10.43.109.83) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0696:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b46366-0e70-4a3e-e461-08deace68c2f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 X3X2vYEQmgimksnRAt53PXqlvRYNgQ+gcaAwvdqo9ej9dlFWU9W5jeb0m8bGC2LFdMPTBKh1+/uVDiEiu3K1u9qLziBGAyLPYGDcOIXxfees9KF5dE+fa4aCO5XeeyMRE4Q/H+SGYLCRViSB13y+3F1mAhrnTBluIURoQcjHKbHzPogprb7FldhIIDjtHQ++lbzAso7MxEgjYzx10NR7mSRNdYSi3+QMewpIDREUkAo7OZsHWWpZQzHfXmaQWirIn1zGWH+2Q/BFynLH77RIWmeK1XAUHldogTCVpRbWXn+uWiceZ0sBrMeYDeHtD0Ae1SvG3fezSoz7GsjBVNm3B0S2RR10iz3igCOttxlRMwhvFtxmWm4czeylEnDNBKqRz7ItnapAENoKvU/jDIkfLvjzm//HBi2hV+XYyDijSKQjlBxngF0mnhefv0eeEve6sWbgNQ7VmUNYBR5MF5XByZVoWCWARPjXRX6bvjLOf/gqCPfVaf01fGIflruqtvKm1uAg+5N4Sinh2lKwbgxk1xKxmkXvj3hG71KcPeoQlKVEkB73LvJaxenrvg1a8Lgl
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?hYUEfDoqWHbJ9HNjd7zhAoy9lQpO4PP7HX3oJBCBxoGay+QCPIXRNeHgfPw9?=
 =?us-ascii?Q?lxgVSFDVOLE4SrQAkDslN+u+iVr5Vm22KRmNz+f62b0oS7xVASq5lDgGO95N?=
 =?us-ascii?Q?zSQ9altAsP6IMQiQmp6OwZN+dzKlI0dxgcFfd25w8VIYtllJQ3Rk38d9Mvjm?=
 =?us-ascii?Q?bOBuoM3nsPaww9GRIDKsQfYB31gHyh9d8qq6NhPXOB/6qN001p6Yqxjbr/9s?=
 =?us-ascii?Q?40XMtNN+Fsy/eAf1tI+QbZj4uRzBCCRn/Ub5BT5Lk8WyzgLLfb7/PwFwlHic?=
 =?us-ascii?Q?kRligup3/YRFU326vMoSesW09FtvME3qe79FCZeFyY2MStjFvNf5u2liaw/o?=
 =?us-ascii?Q?2wt02c7uTA4Jiy3FaJASpKgn26bfWHRK1CrR+kNMRBExrlIw7AObF7fTpATF?=
 =?us-ascii?Q?N0OMejjNzPyZRzsdtVZZPU0FNMBNxVN3e+dILeNxQ6aU1my/sebz0o6a2qO0?=
 =?us-ascii?Q?AZ6dalFZYzBKpS0FUbKGIcNtNIW1MON4WDbgGACpdRJYehPA2mjXcbps+zD6?=
 =?us-ascii?Q?H1pSaxAn8mDtWM3HIfG8y0mHUCuYSuemjiz8H3xKaWn5gipiebAFhUHRtfQ6?=
 =?us-ascii?Q?EgpgI07uxGP1ZWBh52eUUbTVbkbBrXbvoo8nP5WES9EWDgJngrpmoFd6SBCj?=
 =?us-ascii?Q?q7JZ+RAU/xJaZM7CrksxTh7PrngZ3epBE5sPuQiopgRkXE6n2Bejt3SmyckE?=
 =?us-ascii?Q?/TmeWeYHlVup0TZDlJUKw3Kyh7Arn5+R5OB0qjj+xT3+f/IQZy/UhrZ5trBk?=
 =?us-ascii?Q?Tr3he+K6P1j8JZJNZXZt2ddtia/p7o5bwM4hdEkA6ew6k4Oqwwj9YgpumpWc?=
 =?us-ascii?Q?gxc4uPuobMGtFdmRz2lWIzfXEB/BHn7hw/D9MsQ3a5PS7RQaQUo1XmaJBRG0?=
 =?us-ascii?Q?BbCyi4jCY2dpgm0JyITmHwpVtg+yoXsacr7rC5M/7ANDJciXWQVW1S/JL6ND?=
 =?us-ascii?Q?VPTPKWiikgzBmWWq1FEsa5hbiLHuuBwJwdLKg9jPxBrvO1kLiPOchrbLNmxc?=
 =?us-ascii?Q?K+n6ogN2+uG5vCSxbVrMC0xbvGtB2NltJi9cLTMORU6vJOiwFKxOFnfNuHa5?=
 =?us-ascii?Q?uG2PyrialKToxehOLQ6zQZNvpzjPqJm1scsBJWj/Xti6RnP8RRE1I0694DtJ?=
 =?us-ascii?Q?N1cSwv4GsGt4s+d0t+5Ao+Vws+xmJREbzfIYFjRXI0+bgvvvFYRKfsKV9ZJg?=
 =?us-ascii?Q?AKICXF6XOFsa8xmDLiP6v81TADy0Ot7NuvEKK5F0LbIj4BbhEMfmbrlzCoxI?=
 =?us-ascii?Q?M91anWJs5ftFqdAKhFk6jpWpNDqg7ad2pca8b9giFgr0/aPSQOUQONQ0V1au?=
 =?us-ascii?Q?C23ndEZt7uS2uFX0z+fub/HLBQGgWiotrmpwTgwUd2CODPmGmU+JOPY8U9F7?=
 =?us-ascii?Q?yWyA1e2mKOH0R9e4rtulbPr+/vwXje5bV1D2IivpUkQ/5X5UKE3KQDEBL1qy?=
 =?us-ascii?Q?Tos4t59E7B6FZP+KRpTPPjX7WmOgCopX3wpAHXAYI+ayx2FqEGBFOf1VuA5X?=
 =?us-ascii?Q?iuleAehrl4G/f9vqWO49GcqzUQVdfkGdUjAAxsNt0kA2N39BxptifebT/qZB?=
 =?us-ascii?Q?LVlUI10cN2YUxZDCQXL0rCKaDWm8iLdo8Xc4IS2E/6g2fj/01wc1LWvEhCAB?=
 =?us-ascii?Q?s62TAmAB6wG8BVQWnCMbaT7RVgXzuliNUcXHhhpOpWffGNVAAotK/DYs3yN4?=
 =?us-ascii?Q?AtXZePAmj86RjZ/u+YEKINHjyEuPH7ORrDdQfLoOYgbsd7j0YrYyJBOoyF3t?=
 =?us-ascii?Q?lgftaqCBM4w/maiWGOKwN5a7GsqxXMQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b46366-0e70-4a3e-e461-08deace68c2f
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:45:32.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKZVIaBymXSzJ80xUBdFzVDrrbc+ogUuiv/6eICqCv/K/dDrEf3taba6ZcW7VbV3g/84FKL91a7oy7rO4Lkk4hgZJ5KXAwg3zornIe6Hoe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0696
X-Rspamd-Queue-Id: 23DBC4F7B07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-285860-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.737];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Set RXD and RX CLK pin drive strength while in YT8531s connect
with RGMII.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index c66804537aa2..ebc24f51e626 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1698,6 +1698,11 @@ static int yt8521_config_init(struct phy_device *phydev)
 		if (ret < 0)
 			goto err_restore_page;
 	}
+
+	if (phydev->drv->phy_id == PHY_ID_YT8531S &&
+	    phy_interface_is_rgmii(phydev))
+		ret = yt8531_set_ds(phydev);
+
 err_restore_page:
 	return phy_restore_page(phydev, old_page, ret);
 }
-- 
2.17.1


