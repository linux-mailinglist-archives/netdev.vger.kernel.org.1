Return-Path: <netdev+bounces-296878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eLHmDaCIJ2qUygIAu9opvQ
	(envelope-from <netdev+bounces-296878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:29:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A119A65C0C4
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=fJfa1nBd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296878-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296878-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A60930BBB28
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1D367F2F;
	Tue,  9 Jun 2026 03:27:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF59367B9C;
	Tue,  9 Jun 2026 03:26:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975621; cv=fail; b=YK+8j4dsTZL//1wcwUIfTbXmoezE2vPNRNlNWiOJS8wih4ir4dZYVdDcHirK0YOwSqLnzAvG/0w0T9x/ivULk/nkwuRIKIpm+EPFVLJztsejjT0qffZfU3OcrHjp/OI8oOUAbXvElnKZlpxmnmZbiFo7NW58DrUUvZBO7RVsQtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975621; c=relaxed/simple;
	bh=vEXFLm9DylGrsq4c8d3lugCowv8v0OZFrUELSql9dX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bf5I/G30MMpWE1RLeFJMKE1xYJooL85TGwvk/pjck9Zu4uCCtlxeMehUAx+nCvgpTwClS8sxMZUleRPZA8tCUh8qT8XSILn6D0d9bpXMr7le1eQacFy00W/CGQBpK79nTXjWPRuDuU0u7T8pskUxCvyNhjWiScyzSIXY096J8s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fJfa1nBd; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGxxeqD1fCos48BeuyOjf/KUoHQ4J6aNqWCLw2NC5qXpaiabYrEr1USQuTqcNEIv4fiyss9bRGfORwTeMDvaRXWRb41mGGDqaduA02ZPMj+1YNAGxiE8lyzTH+0J6mq49+0pZU6BojpnyhupEa8bohpzlxAWldvcUOzRK5hdro8vLeeahFeH06DudcrOmKEVCFCl3RBc66I5Hx7WE2OtD7Ynw93SpvuhrnOp+wS+6wX09VCsg+xFF1WaxFkTLio2ZKwlnUZAmpv7IokGSlP6dkvTFoYOTHuJAS8yMpyplgZhK9mlgxoyE5T5Ii2KAyWzWz/zC88auwaDJJf/8+eL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=XC12WK0u0uSvVc1vuVlVqGN07Q870H7L8NSEX38PbLUvmiT1Nwk4F7T3pUU0cb08BzDvBxU5Rbr09Kx6VHbsl3qkcM0GaZoVi4S7NUD/WWdlZjLPKnlksZi8ijljoMMveYLe8k+AjfXk0aUFs+2op+agrE5FWMNjN/rf+qQJwBnsoz1ALgZ3gxpDQILuHXi2mVigl3aSp7iiVH+LrhPUQkkq+eIGFiXff8xbxk5JyJhsriM34vjKW/8ddcFLAQyIbmOrG8IqZTqJ96UuGRdPTbOwJg+dTtEeZBJAMilhekiPa+ORDNqCvu6DgJ1iXgvXuHQP2Ci6YJ9gXldscOMDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=fJfa1nBdJpthnW5nWgYrgYmtclz+PzNDwjgMKzhj8SIDTpjXz6RInMeJaWv0B1btmy73EgT0qoK+yoIPioFjtBbZIHnlOme74AxF0UuOnERLFiAMPEBETBbV0sh7VJHiCbsWq0FqtnMhgfO+PNolreCZTWdqRAD7iT49LsFNOtx8tf9nBfIZ+eQrj3wztMaUsbmJSoSLKFhtZBK8aOKBQZ+SLd925l+vgV4quJBSYkv9w2YAnDI2Owr3x7CurPxoaY+0rr/lpIu9dfy7tx7oU2L+dpQUA2aJcOeBLlXwAaW2kxpJQWBJ13WkKugfHcDXsZrBbsBeG3qTebfF9jxViA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:26:57 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:26:57 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 1/9] net: enetc: add interfaces to manage dynamic FDB entries
Date: Tue,  9 Jun 2026 11:29:47 +0800
Message-Id: <20260609032955.2066089-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: f38d5602-5045-423d-79ad-08dec5d6f5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|3023799007|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mhWdD4MIkh0K/syWyR0Nu3Mtk9C/pXqxGTvMkJMkJIhZl7HHMvtawYyu7CT4A4emB1r4E/t9y+08thw+Rgwib31a/nmeGdpNCiXCRcfCEa6Qav3OoedTlN3mWDIZdQGrQTVvy/6GU+83uaL6P2zP7o8VT6HyQe0oLAuWIBEULghgVtyBsXcUEJX7hgFy/4h7D61NWEwtiG11HTxoPlBa92FoMPssadZr+X04iT1eTTN4Bh4DsZ5tij9TZpduBJMD25tOL0peiJy2GjJ0SkCpywhA9Kw9UGCssMSwvLwM83/tD27JC062mGCE0yt7IWAqF+B4eRYdA1HHw4juttS2HyVabLmLhzAcHMrepXjaGH7bmQ7NHU/Z7eLKfSnIjolP3FIfCpjPJZCLiIU39pLs7/u7H+fk9P/PuCBFdtPGo7zXbb2GJljNSIw8fd8hLLbj05AVs1cLzkGva/ltXvbb9n5bhAhpMmXx3wV60mSP+daNNCTzQqPmKJsfnc9ecGUzxLEcusu3whVvyq52hrzLYh4FcqU3e4XqRJfjdaaq6Gv4lwb9m+fLC/FMB4Iy+3/D59BRToAiMsKGeFd9vuJbssBJgQgYEVlEXZ/uYbeipzBdULC4gEb1aOeoXyBZl77W0OTpvDCZFGxl0GApVowynh9TW0j5idKI8afogyvnO1P2yroeKhOzMA9dqdkxQuzsM2vi1XVg/gH+FlcHURHAwQuGB63Mhn3+7jIaTBRh9Gk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(3023799007)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMjyBmlMv1NBDq70sUBavO+caZeRWHRafPVFKvjsYJ2SUdkH1ZWLdUMifjym?=
 =?us-ascii?Q?+27Eg3EkWH6xDEDoFnAWAbP3dfle1lKdyL4L/aF27kQOSn3wdoHRznzFu7YK?=
 =?us-ascii?Q?+kkAnx59MEwzGNVbwNQ2ToarMo2odvzA3V5fMIfxT+nxv13OGvHuQmpfk1CS?=
 =?us-ascii?Q?5kf4klAKChUOb3mTO77J/hx7nKzZ0JW04ycr1n4PX9+mQmRgcSPkQbc04Mnu?=
 =?us-ascii?Q?9ke8c2zihek5Kb+KWAwN9dn8ZTQ3M3vlwhoDQgVHSiHnAPifep/nyqkqbYWX?=
 =?us-ascii?Q?1EKzp6KDgjNbdjiQh/LKNzz+3WkDY2ZDLMbtW+S5d1aGBIOI1kBHsioQ6lt3?=
 =?us-ascii?Q?/xKfobEBSSiew3Z2WbD8lT2tgmR67XMIV62ttXElPYs7OpTcooYUFygdYQuW?=
 =?us-ascii?Q?7LL3QZtOhE6bVTxriVEYISyOcCtKpGxWEhrAdj3FwCocTaOn2x2u1gA9RdYB?=
 =?us-ascii?Q?yLOXti5qyl/Z2y57mF0sitAf6wdpVzLAU1Hb6xdKqTna4I6J/EhiAD5rF4gc?=
 =?us-ascii?Q?TPFBOnECQlxPHOKewkGgIMnpvEx75LuUw1yYMvcrBhMU2EMecku2SKatzXwh?=
 =?us-ascii?Q?Q13yvZ32sMxsIZ8u+jbckMuqqAP6IgT0S+MxIme6Hsy68+IKv081k9emHP53?=
 =?us-ascii?Q?jafTjHx0yCTAPT+JUDlAjWVWIcythkpHMLSWng/vDPu2UR8zKiWF63kIATyg?=
 =?us-ascii?Q?aCkqK1OvfqrRTzLqqvsn0AyHxFjU9N9Mm4JvaqJh3Ta0GKffylnKxBVdJAxN?=
 =?us-ascii?Q?m4R1D2LrvwUxCdY2Htss6OLRzbt1O9zNXpDbC0od387/GnaxGeBo4Ado5bvl?=
 =?us-ascii?Q?DYLAHfd8qTuoGODjLUHsR8taz3xVLiZYefognCxxZKZTZKXH8IbAue2aF0jF?=
 =?us-ascii?Q?yRiwJLTUkiEDIIy+L60x+3CBkVkzN2YfINd/BS4K/BL7DDwBCPDO4dlW4E48?=
 =?us-ascii?Q?6hZ4Oyp/WEJqYrTLJBiZGLiaWtIXIkIJApsRt0WlVjLuV4GDQlp5QCXUR/lc?=
 =?us-ascii?Q?8kX1OrAlWRvQT6XeJ7GQMnil+VYPrw1yz8l6TjerJcEwdWASoiH9G/QbnJOr?=
 =?us-ascii?Q?3vxJ9zNSbc8q8SeMpiKbiR+z6kwu8G5TwJW+o1Rw2hA4/YtnswDvzxzUtFJC?=
 =?us-ascii?Q?RksCx1xPJ3JAxBBxG4mDNLiFhRZPBlnbxg/vocHLJuFB6xFx7OorNdunwEAC?=
 =?us-ascii?Q?tnzfLa9K7jaZ2LhIZKMVswMaOFKDHlbPZTjhzsx3fvZd5DerxESRV/PNKsNx?=
 =?us-ascii?Q?nCMeGUWQZpD67fFx5+hSIJDV5HewtGhto+unWQ+LXQ5AJtrXmONDSZssXHRe?=
 =?us-ascii?Q?Hc+MLYN2AYCF1U+DhrdlCyJMxQcKmwSSOjGBwUCKNZ7EUsdo7JP62XWad7XT?=
 =?us-ascii?Q?s/dlvGhQcWGvvVBS+JsagcmsSZh9XPGBGzupUxX2fbTMOOrfpHL4qnyq8g+u?=
 =?us-ascii?Q?QShcgH2dCx/i+w1bOKfQtyz04H9XCpC49m3dsqrJUdHUAHNNuhG5yrWby5vJ?=
 =?us-ascii?Q?vjaaMiFOEM6qG9i4Uccgch3tVnUavRCI70pqHtaiI8if1a8Ka+r1Ty8KOgSL?=
 =?us-ascii?Q?tIdoua2Cd3FuwK8/Y77xCQRV779NLkUD2a2pxFkyCJXG1A1SXFv+Xy0qEFJj?=
 =?us-ascii?Q?4xPIywhrjLpZJBvBcsPqURE/rv3QAZW1bY9AInFCwomsRqcT0eevT2O/zm8t?=
 =?us-ascii?Q?KzmczjttBN1auMy74D5WHjRRhB0qcaRQs+4M3Mdsou49VVOjY7m/Wc7a2IiH?=
 =?us-ascii?Q?jus6l3W7xyHbzftzIylV9ys5GpqavpBWvbA8924DhC5OUbRs18SH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38d5602-5045-423d-79ad-08dec5d6f5e7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:26:57.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjghg3mP6ynuLnhQXkW/8ufb1qEGUNp+GLP7Onp+SJGuWN1uKw+QgjykHDfLAcxJ1kZDetz1YZ+AZ0iqnG0eSnK19fP4JH8PsljBI6kyYNP7NSn62J9CKIf3p7usvWvp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296878-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A119A65C0C4

From: Wei Fang <wei.fang@nxp.com>

Add three interfaces to manage dynamic entries in the FDB table:

ntmp_fdbt_update_activity_element(): Update the activity element of all
dynamic FDB entries. For each entry, if its activity flag is not set,
which means no packet has matched this entry since the last update, the
activity counter is incremented. Otherwise, both the activity flag and
activity counter are reset. The activity counter is used to track how
long an FDB entry has been inactive, which is useful for implementing
an ageing mechanism.

ntmp_fdbt_delete_ageing_entries(): Delete all dynamic FDB entries whose
activity flag is not set and whose activity counter is greater than or
equal to the specified threshold. This is used to remove stale entries
that have been inactive for too long.

ntmp_fdbt_delete_port_dynamic_entries(): Delete all dynamic FDB entries
associated with the specified switch port. This is typically called when
a port goes down or is removed from a bridge.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 162 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   4 +-
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f71cad943424..bda26fe93b8d 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -31,6 +31,7 @@
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
 /* Specific Update Actions for some tables */
+#define FDBT_UA_ACTEU			BIT(1)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -793,6 +794,167 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_fdbt_update_activity_element - update the activity element of all
+ * the dynamic entries in the FDB table.
+ * @user: target ntmp_user struct
+ *
+ * A single activity update management could be used to process all the
+ * dynamic entries in the FDB table. When hardware process an activity
+ * update management command for an entry in the FDB table and the entry
+ * does not have its activity flag set, the activity counter is incremented.
+ * However, if the activity flag is set, then both the activity flag and
+ * activity counter are reset. Software can issue the activity update
+ * management commands at predefined times and the value of the activity
+ * counter can then be used to estimate the period of how long an FDB
+ * entry has been inactive.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, FDBT_UA_ACTEU);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	/* For activity update, the access method must be search */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update activity of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_activity_element);
+
+/**
+ * ntmp_fdbt_delete_ageing_entries - delete all the ageing dynamic entries
+ * in the FDB table
+ * @user: target ntmp_user struct
+ * @act_cnt: the target value of the activity counter
+ *
+ * The matching rule is that the activity flag is not set and the activity
+ * counter is greater than or equal to act_cnt
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	if (act_cnt > FDBT_ACT_CNT)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.acte = act_cnt;
+	/* Exact match with ACTE_DATA[ACT_FLAG] AND
+	 * match >= ACTE_DATA[ACT_CNT]
+	 */
+	req->ak.search.acte_mc = FDBT_ACTE_MC;
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete ageing entries of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_ageing_entries);
+
+/**
+ * ntmp_fdbt_delete_port_dynamic_entries - delete all dynamic FDB entries
+ * associated with the specified switch port
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	/* Match CFGE_DATA[DYNAMIC & PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete dynamic %s entries on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
+
 /**
  * ntmp_vft_add_entry - add an entry into the VLAN filter table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 0a9b87286105..ad532b059ba8 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -155,8 +155,8 @@ struct fdbt_ak_search {
 #define FDBT_KEYE_MAC		GENMASK(1, 0)
 	u8 cfge_mc;
 #define FDBT_CFGE_MC		GENMASK(2, 0)
-#define FDBT_CFGE_MC_ANY		0
-#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_ANY	0
+#define FDBT_CFGE_MC_DYNAMIC	1
 #define FDBT_CFGE_MC_PORT_BITMAP	2
 #define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
 	u8 acte_mc;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 88166f9ad3a2..5db078e1caa0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -263,6 +263,9 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user);
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


