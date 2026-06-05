Return-Path: <netdev+bounces-295693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +AHGL519ImosYgEAu9opvQ
	(envelope-from <netdev+bounces-295693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:41:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E6646144
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:41:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=LF812qrO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295693-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295693-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 185B530FA293
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B547AF69;
	Fri,  5 Jun 2026 07:24:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931BB47A0DF;
	Fri,  5 Jun 2026 07:24:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644249; cv=fail; b=da5w7hOZpquBD+nETmlgh+vb5Fx7AL1pyYBEk5nmmUs7Qa5HkUpunIKkvJ4vhsNqKTWxXCXET+N8bdS8rs4PHKZxeuIw9EvYgvBKLf2V5CQSYaRkm8Luh7Kjn93EEORngxLHWtir86XHaZdDHcZ6E6TIIu2Re4GuSpmlDnPi3Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644249; c=relaxed/simple;
	bh=X2i31/wQdlL4zeZWp6Ndz8EEcayFTciPKW2vYJ7n97g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+Hu3twx6+jeuPuyJedBLgHL7DYkAqgSA8MtzZuySvfmRqlCBsiuMwLpD9LxQi64Hvg6stI9Q0HqRMNXT+JFJZ4vl/RXNJuWMFeYQpwJU2QP7HkJYe2t2TLhhs7YHg0wo2MKBghoKk3c6inRw1dFr8+QZt059hs19Yk/GmTQMjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LF812qrO; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DekHKAlVgMw8e7U7AU/V7EanXZVc4XEJkFB4Wl4uC1uwtzoFoOjPzkDOEKnqEttCz3OjHgrU6T+P6X/dyq9EzsRd8FdPakgL+FSKeuxk0wBwEScAj1AYUF19jJ8R8smxBOq4HzMfph2mgsXpOX5DK5coEIUcx4UZ7zdx3T07PHa2fTZzFYdK8IrjtkD1prskjmARoaP3Tj++t5lBLC89tBIuadGLEkZZljE4SbNnfzpVDdQTn39H6qD3cgZ9hiGjSYHbvPnlnoYFY3VAgNixTGhxbQwCC8bPCKk9MX+hZ5S7twnwyqYiDpqREBauArM+dUF8eBdcWGsvPY1UzrkO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVI3xtwuHMpsLIYnknGKARCh4CKvt+buvDUnCrro4Hs=;
 b=KhXKcPCuDaKzMwXqwMdz+UK+tqaU5M7qA84GA3wz+ajKHcZJUPuBDoL4FY6W0Pw0klt+zriG8iSVCCHlMHVtbO/Brc9D/0EC/WcAvOP+Wq/wUKVXe/6xQW0mGDoNbysol51kwFJCq7ieliH0MYBbeF0szMhs1yDWLVZUI3dhA65FXyb+HrZErnp72IHya+6ihS18vIxqhhvSr0JrDshGrq8OTltsWO6BVovuxn00n2cjIQ6Cb+HvI8i04njzre+fkQL9X4wKtEeFIOSx1wn4g+cDavLlXKSBRxuarbxeUb8V4EUoqKgdPDeMoNO5mZnh82ewKiJE2hEVQIRxC0bJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVI3xtwuHMpsLIYnknGKARCh4CKvt+buvDUnCrro4Hs=;
 b=LF812qrOvBXYIdJzR144X/ngyYzzJtH1X+yl2ywl8SL6a9s9kXKlNxREh66Q7e5nS+bYy6N/3Bt2PqknuqOhoOrtqisURLJVvHOKgjEdlRb5oFp0i1kEJjzac8l9viBNuwDGBhVA3SXENCGvtRUbh5zA2veEkz63XwcZZJe0E1TX4cxWSSFOnQKmqI+b53J8VAPDv2tm0SFiEHtuQ5w7SXS7QIPb30pXYH2SdBmIn79nx5uJZIYfZPZgXJnuiEFp0qKPe2Sb5GyPMlfrG8lkiQIX9oZIHIacNqlguuXKXiNY0MoKZo9rmdHnLLCbXuZx+1mKIH+S5Avu532WArkh/g==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:24:05 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:24:05 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/15] net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
Date: Fri,  5 Jun 2026 14:55:46 +0800
Message-Id: <20260605065550.3038579-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0356.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9776621c-d9b7-4a17-a3f2-08dec2d36c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|6133799003|11063799006|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	HjJ2hyLC4K6rNld9teEVuPGktNkNnrNI2hVlO+oIhXlyRXupT8KVjJzsFHoJJgu+eNma/nhizQKxslfDchMcRyojCi5GeFkcz2WTR9ysz35ItTZluoo8c5jWiLNmcKtnclYs1YnN925H3WEuw1PjR4qxIUHa0tBLYVhHIgsgBqjfAEl/VV/+SW0I5fqs6Se9cSHBJ6yO2TPoefBtdS2CVo7Ux0suxKI+vDRDXPv0zublx2aeBwx1SgeZQVfAuoRvhHiFx80cy1xfnLOuELE/BqAs8sCX4imNUu8eLq3ObPnVahWoiA+hahUFgLU2Kl76Wi6/YoKDBBSWZumLjQtNrrHvYZu3HTe5SfWXapFHGm3zwZGX54H4t5j3jA/mqsFrutiT+Y+fNJK9JW3yfDzt3SlPyqYCet94474GRjUaFhwxrF12xj2r5GlB2p1QDlejwogffUSPea2wM7xH2s/5zs7PNdzH4laP4gVRyhqzJD073bsUJtGWTLJQLNevrDLnflXvgxPV83ilrYnTm43crs5FJzKc01u41Vp/XY2XUEStdpFwxYPlT+82sdyQKbYGiyoEGli00otGpimAs4aKIu9sLpcGvf5/Ctn1kj5Rs777JFqFjAVthNjy94GWOoTsq/2PcWov+RdzE+aAZLPKSEqST3dE31EiXDDn1JsLmlW0iRdx0DT1AnjMrcrORAX4mALB0XVnUxqymtVvlbCTA2QOQCJJyYgjJahM4RqIjBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(6133799003)(11063799006)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XqnYMRgt2jXk8FfW+p3dfHlfWqlzIb70FRYiK53ijl1U0+WpzilStRn4Y7Sq?=
 =?us-ascii?Q?30vkWjdnUOMfKilZ4/te+mxM83R7MM68JYzDYgtf9CBissZ7YsrdOzGUQL7W?=
 =?us-ascii?Q?1rXIviliAqrlcoco5JRPJp9XueL5EKAJ9RTlzqKaaAnPGLS+uo0+TdZYeM2Z?=
 =?us-ascii?Q?LF62mWK6T2WCjTmAgdk2c1b8Gu+L/eU/XfsI5TVRWAiMQFU3n4P1fOBVgY7w?=
 =?us-ascii?Q?k+KsgGxWhMXJ9odVLxUG85kdef5orcOVutnRsd5FfMjPjpXljevB46pbLwXN?=
 =?us-ascii?Q?qL+XujslC0vMUMIgUbdfszN1XVB3Yk2DwVFiE04tpkEKLpWhxERu5bwpQg/+?=
 =?us-ascii?Q?z/zsN7lmYXRReRsj0aJ2JlI9w/hY5mqjhUC6XMuPa5e3RtRYBF7E83VjIajy?=
 =?us-ascii?Q?NYoz1XLX0EZYLX6kNp1adAZCYEt8Az/ONySzOcKsf3OJVZJw12w/Wxx4qIn5?=
 =?us-ascii?Q?guIe7aEH+7sppdILhgTC8Mg3raVa2t/5Z6cpl5jq2rCAZg+NC4NFWOR7teIb?=
 =?us-ascii?Q?Zf+IZ7I/6tmezKLV8LCGq0lfmLDirKFOjAo18s8EEFfnk1twL1BEs9TGOqK0?=
 =?us-ascii?Q?s5t70OBJ9ki3NRWlQLUrcHTj8r/E+FXjJmj9ii6vyLrmlmlonsM6/GhQrgSn?=
 =?us-ascii?Q?aF+2gS/zio2yVQKiGjRXjonK6bNQLAa3A9eDs3h2aiBO9aEXXrLTSflQ/4TU?=
 =?us-ascii?Q?yQEoPuMMqW8o0emmGiik82vB+MoiSoqNe86oVaPsm97VvuHefg33JDnIj17s?=
 =?us-ascii?Q?ywX/2iRlxejOMlMxe4+RdmBT8KIHtEL0jaszrs8zpfaAJ2uOHbvMpUCqYqWp?=
 =?us-ascii?Q?tQuCtiavDom1dUufjocJyAcbnqawqcNCc6x2H8LMgGWTun0YrS5gprAyvuM5?=
 =?us-ascii?Q?1qtq6E3U/xtwO7Y4taBQ/0q64GBBFot3hlqg6IYN70KEyfSL1Vvu/WyVob9j?=
 =?us-ascii?Q?vLcDKUGrJb+CSBFohL1xHzu5DVHl9YATs/DNtSaI3QJ0jXpz/mZ0SbLouiIC?=
 =?us-ascii?Q?duHs3o7OeYuFHgDOEhmSqXJMs3qxLR+oLkdakKaU72RcsVD5/t4a3Zufqudw?=
 =?us-ascii?Q?HPI/6GuJs1rjEP8od7pNExz8j2nH+JUwdH26Q7koMEHZxNCJKZQy0SxkMLhH?=
 =?us-ascii?Q?O7S7IbfFTU1hma32JO9c3gO3A8L/4Xj022TXwuHtS6zCkrkKc2GmjePsIi7a?=
 =?us-ascii?Q?pl/DACDiMLCR190rCuwANDMIz1w3KX1YJ5elbLHCMB8lHSWM0bmfww37ZjhU?=
 =?us-ascii?Q?JA2xuqhZ90RfQ8W+8vbaHa9SA0avbArhJwkU44UuOQfbofVUqfLuTbL8OsA/?=
 =?us-ascii?Q?mGfpyPP+lYuQRg3DAnSfBSVvmIGywaCdUuD+jtQTvL7DUgWyZd/jldst+y16?=
 =?us-ascii?Q?rOYCpBuMh71oVY4AfhqgoRDmbtIWvXHmG9L3F8liW/Cr1mBTSVBBsCrExmH9?=
 =?us-ascii?Q?2RQ3KcJAQRbsdEfPxmXqt9WaNGjEncQYevzkres8awGRvKQu3CGjnVY6oGcP?=
 =?us-ascii?Q?WpE3kfipoLB2+zTuK38nH6y3zbOb8p4aUk3YXkvFnyEncZG5gwx3bvIaWF8Y?=
 =?us-ascii?Q?ELF0H0jwS/B81RPKsRs+8O80kLAyGwz+d/bE5gR020umT1v6JHLnkG+fhuZ2?=
 =?us-ascii?Q?8sUqrqzaX4p2MRHX59NtTONBXvoxUih2Ur4bwKG/l6ARZgHbcBAXQ18yvvFV?=
 =?us-ascii?Q?F0wb/H1G3/HiUL1PNQs9+F0S1sZtd4XER7rTAerjs8BSd8zzBp/Q++bt1j6M?=
 =?us-ascii?Q?hPLpEq8woBRd7YdBd6cNOgH3ncnuFtcbVegnEXaOHyrVF7e9fGia?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9776621c-d9b7-4a17-a3f2-08dec2d36c8e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:24:04.9796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab7GfWno9660tSYverXChXqlpJdlK+Vie9parFuoqVsIuwUGD/srfyMp6FOG0ktMZ8Q4+D3rqidPZwwJT1tagKuysmSbEm8eMuPNauCBKHheyAHDbHUUy5CMx35pnAr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295693-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:from_mime,oss.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 309E6646144

From: Wei Fang <wei.fang@nxp.com>

On ENETC v4, a PCIe VF Function Level Reset (FLR) resets certain bits in
PF register space, including PSIPMMR[SIn_MAC_UP] and PSIPMMR[SIn_MAC_MP],
which control the unicast and multicast promiscuous mode for the
corresponding SI. The reset (default) value of these bits enables
promiscuous mode, meaning that after a VF FLR, the SI is left in
promiscuous mode regardless of the configuration set by the PF driver
prior to the reset.

This is a potential security vulnerability: a malicious VM could
deliberately trigger a VF FLR to force promiscuous mode on its SI,
allowing it to capture network traffic not destined for that VF.

To mitigate this, make the following changes:

- Add ENETC_VF_FLAG_UC_PROMISC and ENETC_VF_FLAG_MC_PROMISC to
  enetc_vf_flags to track the PF-managed promiscuous mode state for each
  VF.

- Update enetc_msg_set_vf_mac_promisc_mode() to keep these flags in sync
  whenever a VF requests a promiscuous mode change via messaging.

- Update enetc_pf_set_vf_trust() to clear both promisc flags when a VF
  is untrusted, so that a subsequent FLR cannot restore promiscuous mode
  that the PF has already revoked.

- Add a vf_flr_handler callback to enetc_pf_ops. The ENETC v4
  implementation re-applies the tracked UC/MC promiscuous mode settings
  to the hardware after each FLR, ensuring the hardware state matches
  the PF-managed policy rather than the insecure reset default.

- Add enetc_vf_flr_handler() in enetc_msg.c to detect FLR events via the
  PSIIDR register and dispatch to the vf_flr_handler callback. Invoke it
  at the start of enetc_msg_task() before processing VF messages.

- Enable FLR interrupts in PSIIER only when a vf_flr_handler callback is
  registered, keeping ENETC v1 behavior unchanged.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +++++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 12 +++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 44 ++++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 ++
 .../freescale/enetc/enetc_pf_common.c         |  4 +-
 5 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 2e081a59154e..15c8b704b2b7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -283,11 +283,32 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_MC);
 }
 
+static void enetc4_pf_vf_flr_handler(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_vf_state *vf_state;
+	bool uc_promisc, mc_promisc;
+
+	vf_state = &pf->vf_state[vf_id];
+	mutex_lock(&vf_state->lock);
+
+	uc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_UC_PROMISC);
+	mc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_MC_PROMISC);
+
+	mutex_lock(&pf->msg_lock);
+	enetc4_pf_set_si_mac_promisc(hw, vf_id + 1, UC, uc_promisc);
+	enetc4_pf_set_si_mac_promisc(hw, vf_id + 1, MC, mc_promisc);
+	mutex_unlock(&pf->msg_lock);
+
+	mutex_unlock(&vf_state->lock);
+}
+
 static const struct enetc_pf_ops enetc4_pf_ops = {
 	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
 	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
 	.set_si_mac_promisc = enetc4_pf_set_si_mac_promisc,
 	.set_si_mac_hash_filter = enetc4_pf_set_si_mac_hash_filter,
+	.vf_flr_handler = enetc4_pf_vf_flr_handler,
 };
 
 static int enetc4_pf_struct_init(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 37c6060ccc82..62844344ff29 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -109,6 +109,18 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIDR	0xa08
+
+/* VF FLR interrupt mask, n is the active number of VSIs.
+ * It is available for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_MASK(n)	\
+	({ typeof(n) _n = (n); (_n) ? GENMASK(16 + (_n), 17) : 0; })
+
+/* VF FLR interrupt bit, n is VSI index. It is available
+ * for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_BIT(n)	BIT(17 + (n))
+
 #define ENETC_SITXIDR	0xa18
 #define ENETC_SIRXIDR	0xa28
 #define ENETC_SIMSIVR	0xa30
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index d9560e2c5385..6aacb22cfa82 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -23,6 +23,9 @@ static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
 
+	if (pf->ops->vf_flr_handler)
+		psiier |= ENETC_VFFLR_MASK(pf->num_vfs);
+
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
 
@@ -184,11 +187,23 @@ static u16 enetc_msg_set_vf_mac_promisc_mode(struct enetc_pf *pf, int vf_id,
 
 	mutex_lock(&pf->msg_lock);
 
-	if (type & ENETC_MAC_FILTER_TYPE_UC)
+	if (type & ENETC_MAC_FILTER_TYPE_UC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_UC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_UC_PROMISC;
+
 		pf->ops->set_si_mac_promisc(hw, si_id, UC, promisc);
+	}
+
+	if (type & ENETC_MAC_FILTER_TYPE_MC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_MC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_MC_PROMISC;
 
-	if (type & ENETC_MAC_FILTER_TYPE_MC)
 		pf->ops->set_si_mac_promisc(hw, si_id, MC, promisc);
+	}
 
 	mutex_unlock(&pf->msg_lock);
 
@@ -507,6 +522,29 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	kfree(msg);
 }
 
+static void enetc_vf_flr_handler(struct enetc_pf *pf)
+{
+	u32 flr_mask = ENETC_VFFLR_MASK(pf->num_vfs);
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 flr_status;
+
+	if (!pf->ops->vf_flr_handler)
+		return;
+
+	flr_status = enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
+	if (!flr_status)
+		return;
+
+	for (int i = 0; i < pf->num_vfs; i++) {
+		if (!(ENETC_VFFLR_BIT(i) & flr_status))
+			continue;
+
+		/* Clear FLR interrupt status, W1C */
+		enetc_wr(hw, ENETC_PSIIDR, ENETC_VFFLR_BIT(i));
+		pf->ops->vf_flr_handler(pf, i);
+	}
+}
+
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
@@ -515,6 +553,8 @@ static void enetc_msg_task(struct work_struct *work)
 	u32 mr_status, mr_mask;
 	int i;
 
+	enetc_vf_flr_handler(pf);
+
 	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
 		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 7ca85731d6cc..650735a7de81 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -10,6 +10,8 @@
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
+	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
+	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
 };
 
 struct enetc_vf_state {
@@ -38,6 +40,7 @@ struct enetc_pf_ops {
 				   enum enetc_mac_addr_type type, bool en);
 	void (*set_si_mac_hash_filter)(struct enetc_hw *hw, int si,
 				       enum enetc_mac_addr_type type, u64 hash);
+	void (*vf_flr_handler)(struct enetc_pf *pf, int vf_id);
 };
 
 struct enetc_pf {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 66a9a734d18e..1aecaba04cfd 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -480,7 +480,9 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	if (setting) {
 		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
 	} else {
-		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+		vf_state->flags &= ~(ENETC_VF_FLAG_TRUSTED |
+				     ENETC_VF_FLAG_UC_PROMISC |
+				     ENETC_VF_FLAG_MC_PROMISC);
 
 		/* Clear MAC hash filters and disable MAC promiscuous modes
 		 * if the VF is untrusted.
-- 
2.34.1


