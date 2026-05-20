Return-Path: <netdev+bounces-289871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDwQFx+LDWpKywUAu9opvQ
	(envelope-from <netdev+bounces-289871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:21:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA758BA5C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 870AD30067AF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D913D75BA;
	Wed, 20 May 2026 10:13:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E723D6673;
	Wed, 20 May 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272017; cv=fail; b=nzMFW7kBpEyB7kYKIgHMorQF4NtU7VE8zL+i+ei4yzUpk2G3TZ0Aey6oi36m/vjOjFO1yCxQ5hIp4npQO4hESK2QY8MuR9+Fq+yiPHkDsM+9vjULAaDKutuzHBGym6YJ0xmQeMVg9ZCY6Dc/q2DgJuKkGprA6F8t978O9Af7tRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272017; c=relaxed/simple;
	bh=Bluq+hHhCh4or8cIlI6BO4zsc3+KN2bsoeb9iaC41hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSc7Lvg/k7rqRzrDtP5WE7He3QDlTs/wNSSeFO+A3vNgZowmX8fGMphJFzcnaCkAVowEUvfAcUIqCKC7EHZKnxCc+Hllz8LTPB0zKzkYNwIZ44xRU1df83IwFWiRcDlVGeGxccxmGy0q3GhAwKworZNMQmfu+LkkNqwtE9xfGy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgDp9F9b98FLr8kx74AgsQkSKPn8p9/OVKK3MnGB55VPsxtxSTHhzGEKT7Sg3RDFL7JY7C8HTDwUYZbssrTYmGtkPfUvC013mq1ZTAeGP6QOqJkxGPGZnSILQTP5LJgdNl9ffxUhIv/3Ci0Cp4DleZzdnkPwhKDlp+Y03wDpvQF+8bBXf5MgElhtZ/4atdxJQq9pPtx4Urmo+Y88ef9WNbroUcympTePm8GWIwfC5i5ivNRy9rG5JktH1atZBLUkLI4FGsS8YbPlxRFHH1DwGajq363eWpPCcRbOrBcMrz1cnyo72ttERtq+QOH5ZNotv/ZRFbXQKhuK1oPzk4F7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m7ewRZPZOVT8f/kEU6/lDcTEVp66Laoyf+zuLt+nDc=;
 b=KW6k8dOEZG9mHBw4sBEpUV2zdKcMYbiSQ72AFyrofriLsys5MxYe4mRR14pP6rzoYWcvA/Dk5coCBLCIGJMoXI5DUUdX1sa5oDRGMVBfjeGuDvbw1sNU1e12SN4aZ139ycFl9Cl8ow6OhL0DL4lVf7oPN+uxfOpPLB/E8GfSeoAoKiZSeKfo8dVYVJT+Vk6FhItDl3sRNhYOz7dO+MPq6SSav2n3QShfNW3Jgk/xwGicXWSCpi9gmlqnJ4IyZoosubyij4GFI+krikPlE1/ydJlqx/ezpPsdQllxyDV7+uZeFt2SBtQXGqj9ZeyCJ+xXjl7Qi149WyDD/dGoBsIdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0637.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 10:13:21 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 20 May 2026 10:13:21 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v4 2/3] net: motorcomm: phy: set drive strength in YT8531s RGMII
Date: Wed, 20 May 2026 18:13:09 +0800
Message-Id: <20260520101310.128969-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520101310.128969-1-minda.chen@starfivetech.com>
References: <20260520101310.128969-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::22) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0637:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f36981-166c-4068-062d-08deb6586bcd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S37ehUoE6cxaL1nkkX5ffHPVuG1FyfoR5znk+ilrVOYaatZZIGzASviymLYgAQ41gJHd/vaabuKFoXVdtAqAUL6dlKK9ZN9ZPJMsfJjaVRt9O7gflRJ1pn3n1f79QHtkzxm7kxwoxqTh9glkG0/Lg3qexi0MWCbHOWT/XBqiFzyHDNpr4K/bR3g2W/QEHhl8rYoPr7v/gDtk7wT+XHgVf1s/nCplVV+KT8vLD4zCjD4K8+pHhDUUHas14KaETC6DC9hjgTcJHl8i9otwxEisqaUJqPTRureyDr6TRe8gDjcXzayNG/4aLSh8hZRt7gWFOK4+ECck6L51PVhUFedeqydwZWyHK/jGSxP281TTdYDEkweoEtfP+SeJx9g6cjPEGHU14a23QJzcOyaISb4Dshx2WkD83djSAbjZLaCChUCENEiVdE6qde3dcM7qAR8iinx3KQ08XHzaXNYUHKZISoN0Uy4aSxwHm0WdmOvnSJTiOe6JPpFADTS8Pw8jDPprmAUMoos5HU2GDt4FmI1H9iBEtDYgIul+AwStNYlYrtr1OM92Zlu0weCI92v4kxl1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZaxUPNIQT8sSjLI3WGotdDOmXAOkFE/IGtoNTmoH+e1ax6UJH4BrPXLj0TO?=
 =?us-ascii?Q?9cLswQdFRStpuGOZBkmAIIxeiRz4MTE5id21mt2JOOUrQIjD8kg2u/LUVNBM?=
 =?us-ascii?Q?lGaX0cKYj0Obdr1p7H1xswJVuSFiGXS0qEzx7IqbP737s83Mu6MDoBCwdakD?=
 =?us-ascii?Q?K6D7aObQlagOMFItg2Jy2/7lsFCoUf9q9EGSSI/tpBpnaqbkLW6juM2iX5BB?=
 =?us-ascii?Q?yl5F0+oX+1y8b4q13LnPqboodOcrZhOm7KYwJ3phB6zQFgyps9D+c+tu9fYT?=
 =?us-ascii?Q?Uf0oK01qMScJ1Ohw0f0jwSgY+IJqDJ7yp4iBPohQbHQ1SqFBHoMkOdelhnKm?=
 =?us-ascii?Q?MP7edaS2cq2V9x75dlTX4+IE3kFKnRzRJP1nzIexXjxaE30fpzahu9sadf9b?=
 =?us-ascii?Q?+aFmsiculqX8vFRMwltk7xRtnrlJYf3CWroyEXTYGcd+xm0Px0NbCyo0AO2p?=
 =?us-ascii?Q?1IfrMQoOKDA1G/SQs3C3Y0ARyr1kSnU4bzNsYw/+X2Cc2hwYK7txvFu6xkzk?=
 =?us-ascii?Q?Vgr4VlLZQ3B5S1i9Q8I6PcCgrDxej8nSJmaFaf6cntJiHLTKmu57pTslAWzC?=
 =?us-ascii?Q?8FkI39KkaIby7syR6TNGJN0W07o9Xeie3/PHvtqfl0U+UBDx3wP6KR23nTT9?=
 =?us-ascii?Q?cWxiHYtLe2MIvNK6dUetz2Bb8YGIg0XPAisOKxRhJzUULBKPtEWwvqTiTDmY?=
 =?us-ascii?Q?6x1JORmw6ASNAWJJDoNK1bGDjGem9gs0CJWayR2bBdQEXw6DXRb4OPIQZby5?=
 =?us-ascii?Q?VaqLwmJ5mFJEp10a1Ep1Hj8scdkV4vtS4tnIJwAEsQIbo3TKOhXNADIIweZd?=
 =?us-ascii?Q?fxHOFnoCR/dGQMdJtpf7jf3a7hV+MKJgk0sF0b3DFvxhzSZyK9t6dM2442iG?=
 =?us-ascii?Q?LWj7i5/yRjgBnCrfKKMWQpspTQl2m4jwSE9lUCvzUlWHLD/tAyOE2fAYV26U?=
 =?us-ascii?Q?n5Ivl4bgA/UphKh49NZq4ziwWpDm9GTbx/m1DXIaeE82NoqAXxuEaZNa14RY?=
 =?us-ascii?Q?QOr73P35gg2s6ZbXwkE86fOkFpxOerrOTPgNB9Epi/B/jXp/QIGryVwcj6Hl?=
 =?us-ascii?Q?j7V3A/YumwouxkNpUf5eSk0G1/r3haXbMZxWhwauft2ikTLi2OzlyeHSw7kb?=
 =?us-ascii?Q?X2bX59cr+fxyvbsEicEzUwsmC+3QTBS2tku+EkyaYQklXi+A53q/UDabM4Cd?=
 =?us-ascii?Q?RynltyiRh8tbM+GwK+xvKOAtByI0b46TBqyZCe3U4ItQ3RgS2B7jEM5wAdsB?=
 =?us-ascii?Q?CdV0mvEZmHV9ySJbtJyUUiuyDegAT0gevN3xorZ6WoqinT78pJF/4+cwGeZb?=
 =?us-ascii?Q?xMR0jcBahItIdD9FdEhKT22O15kSTf/pEMUJBKUesGR3YhCtxW+9RZINH/Wg?=
 =?us-ascii?Q?jWp19B/DnyhoyJ+8NPBGLNrr1SNyxkzVyTkOowh8yBWDSQKQqMSWm4gt8y8c?=
 =?us-ascii?Q?JGgvrG54iUuph3apm6LYk3O2MbP2D7leMQUmOp3IAg2pFyQloDqiyDPQKEh9?=
 =?us-ascii?Q?sYUqSgVcBMpSlKoQptw3xuDwa6pwJ15t+sOZQdwcmjD3leeDdrZkGEMBevGe?=
 =?us-ascii?Q?Tv0cIk2tCjjs7hNKztAPt77HFgz5h10aOIeMbOKKXXCp4KyMB3KcbWF/WFUI?=
 =?us-ascii?Q?G9JllXNRtGhMTRsPviwrHTLCkxfSOFpxD4C1NfODSNnzxN0dUMcKiOFgfURV?=
 =?us-ascii?Q?4AYFHE0RRXi8nABQuR9gxE+MteL1x4mapwMOh9Gy2MLvNlxca06EqQ1jhVM/?=
 =?us-ascii?Q?DZYkjOuQdz9m5ZiitU+gIEm9U2j+zYE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f36981-166c-4068-062d-08deb6586bcd
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:13:21.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jufxUR8C9eaQEophq+VqNDJWA9XiFljlXenfpQGgmER7uyNqdTvGdneeeCOE5TaFl8eknMRbddQdhKzidFwTUdD0TnLmsDfczbWBCyDpiC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0637
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-289871-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 02CA758BA5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set RXD and RX CLK pin drive strength while in YT8531s connect
with RGMII. Need to check 8531s PHY ID because 8521 and 8531s
pin drive strength is different, 8521 can not call
yt8531_set_ds().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 688679457ef9..3977ec5e45f7 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1697,6 +1697,11 @@ static int yt8521_config_init(struct phy_device *phydev)
 		if (ret < 0)
 			goto err_restore_page;
 	}
+
+	if (phy_interface_is_rgmii(phydev) &&
+	    (phydev->drv->phy_id == PHY_ID_YT8531S))
+		ret = yt8531_set_ds(phydev);
+
 err_restore_page:
 	return phy_restore_page(phydev, old_page, ret);
 }
-- 
2.17.1


