Return-Path: <netdev+bounces-303525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +inzCYHJRGrN0woAu9opvQ
	(envelope-from <netdev+bounces-303525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:02:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C566EAEC5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:02:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=jMoDCKrQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303525-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303525-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B0430D4BDD
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526813BFE5D;
	Wed,  1 Jul 2026 07:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA83C3451;
	Wed,  1 Jul 2026 07:57:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892664; cv=fail; b=WttWKeMGVsmeiMxMxH/IGQY48MmQwkvY6HmOYrnNhem5WQlET8Y3xjTF/Nd7tcjqGIyu+YhFucK993pYbJx5kMYgp3tu15EOOS3iINYpZkgn+r6Gs/DcFe/Q4cM0+joB2UFpI97PQrG05kWttYvLMXccYaqksTTwalTz8nCWl+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892664; c=relaxed/simple;
	bh=HK9pPGc80dh99H+M5jn9LVothaSXxJ1EC0ZoDJ4Uq7w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lDxtS9RtBMg1TcyTWFHF8o6Uw01LWVM3ZAaYtiKJ56PvGvR7gBnDR8regay+Z7EL0uI03LBqvgaR/dViR1gQUg1G/h3Cf0Fmn1SOMJ5gNokab0UVgL+8xY6AZWa14f44J0vprLOoAbW9KG+FO65aa/dhnwZfuVNh3t8PNWggW84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jMoDCKrQ; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBdqYMSvKaVma1kLhtZ1lw6OXWpt45bKhax2AfGuwl6hXGKli1UlhSa+tBWt0l2UI0QFSTxOd/KvZ2fA7e8ZOUreLupqtjDUJjZifC1IC5pkNcsPD7U42NusvKi8XUewMGoZLvh2qCSs0C6A1lySYlVPQcPy1ZKqpLegWuO+BRo4c4lwKb/mSlmd7fW8gyrHzyXzw3XTDeA2oFk4/MsOUMG11a3yTYgy7wprNNXK31UHQjuVsX6yFhrBAwuE/BCFlIqfhCqXq6LfKmWzHxKqY3S35pD0HXbu8wj8n0Di4u+PqSaKPxVOD/9eX+hQxt9/VNgzOPxHKHaA/oOFqrprhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDvJIKPw+tocJK8VfZA3kYhln3dawe9YckLTldJwZm4=;
 b=TWn82x8L7fHVVc3fvNs53Mbf6f9fEVcj1eeHst69oBjTpKvFuoORoR/dnTrrELzQPpuY715MFrK5EF0g9sNtRheJq7q4JU7xwWKQVRZZ4Y2hPNH8c1UFaFO6UQBM/Zxt0mYXyfPZjnV9MokBN6sdc1OjDC2tTVMUGGFECBp6HUQ67RVajHvio5LmyGJNG4O0KK1J25eg2r6bK2k5HD0go6W+InABkGmh+8bbABhtzq4eXs8wnr+/V3devS6Mj00413jocQOCjS9I+wKDq/ebNn4K0l8PfrmRnjw6jXQqSuHBsFlRZkdnE6w2ru0e6Q6Sre8PcTYRqfnrNrEmunTg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDvJIKPw+tocJK8VfZA3kYhln3dawe9YckLTldJwZm4=;
 b=jMoDCKrQmjhymdTBGgYq6FBoIotZ16CvQTWyOFUPHKq60SJn3NSSDzNE/3NeGINd0jrTz+MAuMXgm1+X21wCB1746D/tWxD3wFNAGYQQ4f9BPNP+RDSmwhtMVUg6THz6pCiYnrfWAtMAclnXsqPwDcGR8RgWb25mSULquSrEhEq+1vdBCsHNYsewFpuTYijlGHmpUPjiE4+qfzwqte444ucP/vyWDk/ZRnVnpzqdtQiKIWVwI7fcnkcM/LGu9EtfNjOX6m1+DZgkkjMPwQ5780s9obsBzT88SiecynTUPBuTSWVEp0wvg6qZGDpkJrNzkyNLBuhvXJoTcFhSyAoXqw==
Received: from AM0PR04MB4418.eurprd04.prod.outlook.com (2603:10a6:208:6d::15)
 by GV1PR04MB9197.eurprd04.prod.outlook.com (2603:10a6:150:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 1 Jul
 2026 07:57:38 +0000
Received: from AM0PR04MB4418.eurprd04.prod.outlook.com
 ([fe80::a4fb:9ac8:704c:fecf]) by AM0PR04MB4418.eurprd04.prod.outlook.com
 ([fe80::a4fb:9ac8:704c:fecf%4]) with mapi id 15.21.0159.007; Wed, 1 Jul 2026
 07:57:38 +0000
From: xiaoning.wang@oss.nxp.com
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	xiaoning.wang@nxp.com
Subject: [PATCH net] net: phy: motorcomm: read EEE abilities in yt8521_get_features()
Date: Wed,  1 Jul 2026 15:57:30 +0800
Message-Id: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To AM0PR04MB4418.eurprd04.prod.outlook.com
 (2603:10a6:208:6d::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4418:EE_|GV1PR04MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f48764f-f730-4811-a085-08ded7466b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|10070799003|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6QImS0EnhO+Vg3ZOAOxdfUrkdei8TC/OW1EXbugWG72vIBQzsYwDpPMPW+ScsKQMYd+vkpvtyZcoc2L80qppT3Pj6U6AfJMNO6R9ugDqPBy8NEKsobiZ0mMST/pScLWOXO7doE4yfUd/6rGc73Qjbjqr7c3l4g5GYK5Wy3eTKLj55+zKNmnksyChZV67ROns4QDPvJSYdrHJldF/HosKD/Q9xHgcNiil1BBINymf6ykzqMo0UIXuEm659QN2zZ6pzOhbqRIDy1Rb77zGvDvdfD4jllm7n1tfJR+y1S2CIldsUZXCWDfOb+g9g6H4jBqZJqRcMB398Fy0j62Yg5lvQ5QxAc3/Qk7NX6xyf0dZt6p2DgFgdNAOrK6n8cob4u0O6/bmhR0CWA5b1+0Z7p55J5razfHf0co5LhOj8Aw4Wp07toEh2tYWKVZX4ycAZIBSp4U1dFbZ1eLVX965VCiihInfDBVerRMdlpBiYANk+U3uBJIPGAcApa7l9fRnteHEX4gr70t3NMbQrS/pb8IoetpbZMrfhbdXmzc1TUod49viD6+e8nN7lRLssJ0FRigJE5K9rXoco/9ZN+J/WeZFlVM+rv65ILALep8jV5EJNj+sVoJzCwza+a2beSrev1qyRr9lUG8NcVsw7WxXI6pueL6z0jZ0te4k9myQVgwQqcQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(10070799003)(23010399003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQ1VX7EW2rspph61DiK/GgNGOLLIe+2IaNMtIkZgIn4OWDo2CVjgNP6GlLEc?=
 =?us-ascii?Q?jOwgHEJdIiLLrOgsWEbX4rSjtwI6r90zFMuTTj2+NssDm9YuFRAMgkbXd1Hv?=
 =?us-ascii?Q?HvEjNvKVSFoFQScFJX1q8QmnMIUXqC/ZGc5iUujgbOq8mEhcZVO6PZdrbtjP?=
 =?us-ascii?Q?+D7yrobOXtFCVP1I2jtEk4gmp2EKedkxdLi8zRP5/vT8X+w0n5lMEjr+E4h3?=
 =?us-ascii?Q?hxZpTNcRvd0lnRbQBvarFLJaj/NduAb0mIsCF14uZ0+oTptpAwuOKcv/drTL?=
 =?us-ascii?Q?KksvumjrfNoc9uLFiI8gVSSKCKsDsYuseszKyv65PxN33ZqzrvfNNFR/bHsL?=
 =?us-ascii?Q?cMs/o0zRdmVB5lzDeDZGelJy9PfufWlytZ4qqsYAeL4YYP3Gzlza88OcPkuf?=
 =?us-ascii?Q?KsWWWkMwwnyMjuPOxPBpfXTox7OpdfrL4rjJ1t354F4KwpRjgSQYBcgkSbdw?=
 =?us-ascii?Q?2x0qJcau1DT0ObbU2d8FOna0yNoJ0NtoX6Fazeckblw/CP0/PYYtEXgWpE60?=
 =?us-ascii?Q?KNy59/vY1Czacnm61p0i5C8lJ6d4l7NtorO+6SkJI32bCcn3XpPliRn/PRd7?=
 =?us-ascii?Q?40hwk9nBjhI6xM6O7y1hZ9DvQw6TXiHamI4xWYoUNxtBMvVwrd1mBT1K8iyR?=
 =?us-ascii?Q?0yOPKttntAW6+oASCs1jKmtJEemaeXibMepj6FAwS8jFNaiATZSez6hgI0pt?=
 =?us-ascii?Q?qNav74/vwgpznf5NWd5Yky78+BeJ7t2xgPh5gSFGV3m3BGVzwqoqVL0+7HS1?=
 =?us-ascii?Q?FdVTtLutM1q/KoINqPmK4df/iM/M8eOdftjYn5R1Im5AEUjQ1Nhvlm2Qi4Pn?=
 =?us-ascii?Q?fjLPwn40dmqpu34AoCn4LXhIgZJa/phfSyHrwQbOqyUns7lmkvqhkyI3C9fL?=
 =?us-ascii?Q?9jO1d91yDfbLI9lh/akaDNwcwsZ5IrT7PtTOQFal0Ady6NiDbTD3tF7yN+wn?=
 =?us-ascii?Q?WIlpAP68s0mA/paQhU/vjeWzMQCOWgWxy30G7ATtQaNzOyCXWoAj41SjslUK?=
 =?us-ascii?Q?FZj7js6ZPNCLqZpLEf7DfjMze+X7knFDHsPmyuGejpORSTSMJoePlQXwBWDz?=
 =?us-ascii?Q?IUGOWtQZ3ieTSAUWqpvYUnU++yNhCTmMTmN11H0WMAg5YIBfUAxElnzdxek3?=
 =?us-ascii?Q?OJ9NGWE60iY8zIosRMLtjAKTQzsG/oGqtZ/fOkBVBaHyP0tvgSET0XpUPt6s?=
 =?us-ascii?Q?IG/GXtfAkDimm+6Rwvu6UBeFmIWEefx1chzOriLmKbrYRbLDNR+/U2HsgJyn?=
 =?us-ascii?Q?iGn8yaRsMNX2KXsg6u0Md5SIeeIqlzlL9CzXjMq++SdJWJJlmuYXxXC+7smU?=
 =?us-ascii?Q?0aZG8XFfOCfFcNCDYwIa3TsXloCiziCevGU1zay0AS3YbF85s1e3U6B5Gtmo?=
 =?us-ascii?Q?j4KifJacHBqu17Jldn5mVpRywWIevlmKWB8Yli5U/Imea5iVmt8H3dyRY/E0?=
 =?us-ascii?Q?UavKUNFwdPqoLKKVIS2vVcPMWfc/M2jnfBd5bUmicN5yz6GmfN5sTxk18W6a?=
 =?us-ascii?Q?/4c4OUAoN3IPC+u8XMZXkTpF6/4PFT7TCVBnG3EhIi1WDbG0ojDSFIgMxTSK?=
 =?us-ascii?Q?+FQBoZMmouOZee2vEvapVd8et996YlLdeK9AlAvKNZT5YTYkoCOKuVenoxcv?=
 =?us-ascii?Q?K7ZGL1meh+TnHEeqZro9beH662ZNvHo0HSn2YuHK/6vejTCAFMHn1Z0gJn7I?=
 =?us-ascii?Q?uwt5WxupDkHFVWYrT5OdSr/krRQFvQyT8zhZ/nwGwoEVsoqfMdfh93WxOaXH?=
 =?us-ascii?Q?RH6dkI7Dyg+WnrSMqXBQs0E0wgcFa7JrSlqM9bc7vDk0/AyNjERkXl02O4HY?=
X-MS-Exchange-AntiSpam-MessageData-1:
	9ajjs0tmsngxvhLeMXUd7OhLv2yYD54p76AWWPFWT1mhdsDvJg+PH4FnSOz4rv47RgWdComaoBv1EQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f48764f-f730-4811-a085-08ded7466b66
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:57:38.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkbLODxL3twtElIh0U061uv+MZEL5nxYeNOT1IPHkPjEYsCulGRe85A9RG9Q6oMesLxf367rVDDyPVzyho+Yc2xthQgNSUto7VB+Cu6Anjy52YJnTNXaVlRNgAtbz//9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9197
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303525-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiaoning.wang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:xiaoning.wang@nxp.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64C566EAEC5

From: Clark Wang <xiaoning.wang@nxp.com>

In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
driver uses phydrv->features. Drivers that implement .get_features are
responsible for reading the EEE abilities themselves.

yt8521_get_features() does not do this, so phydev->supported_eee stays
empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
not supported", even though the PHY has the standard EEE capability
registers.

Call genphy_c45_read_eee_abilities() at the end of yt8521_get_features()
to populate supported_eee.

Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/net/phy/motorcomm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index b49897500a59..46efa3406841 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -2439,6 +2439,9 @@ static int yt8521_get_features(struct phy_device *phydev)
 		/* add fiber's features to phydev->supported */
 		yt8521_prepare_fiber_features(phydev, phydev->supported);
 	}
+
+	genphy_c45_read_eee_abilities(phydev);
+
 	return ret;
 }
 
-- 
2.34.1


