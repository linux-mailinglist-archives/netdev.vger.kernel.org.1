Return-Path: <netdev+bounces-295695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /h4aMPR7ImogYQEAu9opvQ
	(envelope-from <netdev+bounces-295695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:34:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961264607A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=x68qEArI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295695-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295695-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43EE3106C06
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1D048094F;
	Fri,  5 Jun 2026 07:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E9480948;
	Fri,  5 Jun 2026 07:24:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644261; cv=fail; b=PYxGNvZjJDzjXdLvlac66PehX51GkHpF2bQsBpioced4qBjeQnSrwrRydjMrtTduUzYJhoYFAC3blfK/KjPZl1sNxWB5cLEjpfkenJgAdZowb655KftFR9QIUlDDKgvqFrqHvktJrwUgjY41RJt4xv6kAZc2DrdHAH364rmvoKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644261; c=relaxed/simple;
	bh=uiDf2+tQG+6NfLNA9xnILlq2B39WXiByo32SQUe7CyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4M6hRwq/fdeHifTFsDcRudPArrTEPC08g3/rFJKIKPbicv6qc4QJgWq45g9H2PtzwFrsn5gDiSUSc4hVBsbL6TsJ05bGbFfK2LtmxemXp89HKo6wxR5TVgpr9CTlc0CDdU8n90+VrHuFUZitBKnaRJg/9hi9mvawpAdw0runN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=x68qEArI; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEbLTTZqDqtXZp4Cj2vGAo22OgFDTlPYiyd9WmGVUgvl18jLekQe9p2hfaz4wjOEm/FYuD+pxa7rTjiRwYPtzy4traA+RHbS/f+QCMzDteaY1tCrlcj0e+tQR465xutNUaHF8f2jOJR+zDFgXIHUcs4q6lVeI177GFpWoN3IAKli9RkcqYfnfPhQ5D9fZDJwFWYU0s2OBRT2Bb1MJdXRdz5zaY6CtvEsGPPMYPQku+rmtp8HJTSBHrntCEX7Lb2Rw2rWS79/7oFGprZY6y7+OQc1fBjZg7ZuEj6obcN6lHwb3j6uU/+rWAWOELlSRUdXm3FNfWinwO3/PMhGXxddSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXlsjuVC1mNpqCs/yAMxJJp8NbOG/3AE2IZgdG/Un98=;
 b=oYj+PVXux+SaLFg4K656u5V4jj/lxpMDz0DTpT5+dldonSYEdceKgtPBcPeaSOwVn7L7eU72dI5sZyVvBZiO8BRHkDum1S8tgrth5ZBFFnyc95MUi5i/MLWSmNibaUqDZ7klogOLBrGbyvaljltaIEdlUwfTOjwNOh/mfNciD+lNs0mQmj38wlmeyekGuwxSvXL6lJ2MVXPNYSRALkzvK4XOV8k65F2ACQQcI6brN8MXafkqMqfnMWsSK15NglD6Ma5wNOabLga04ejNs7o2T9Et/5Kb9C5MAYyIdR9xMDtzlHpWZxvm1n1lx9DlLYYoNy196IPrHNCdRA93mNkOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXlsjuVC1mNpqCs/yAMxJJp8NbOG/3AE2IZgdG/Un98=;
 b=x68qEArIXToRXT9mEjo+WWNYAdTX0BV6ISKyeYUP6Jy1aer/KsTT28g/NUwdwAye2GGd4JIeXY4/CBwm7IK0PNGqkUVrZwDrfL9lvjFxMtkgICc/vs8RlEEDAiTLuR06HxMcaVnjBrK1V7gdSU+MJF8TsIKUUr/xKrXo2G4jJNObz9PbXwvCQ5UrmG3249PFuKmel/JAmuLc8tc3KV95JRsdGPwseaANAXU5x2v0NOGo3hDOruWSTtr+BQ7PMKcQxAtCwpKhHO5PhwMmrjvpPwHHq8DZEdV7Tu7Zcap57xyRrpOCURv1vP8lYrYzWdNW0hDoFjIqQLENUlkp5jS0kA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:24:16 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:24:16 +0000
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
Subject: [PATCH net-next 13/15] net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
Date: Fri,  5 Jun 2026 14:55:48 +0800
Message-Id: <20260605065550.3038579-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: e2034227-c824-486c-b4f9-08dec2d3739f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|6133799003|11063799006|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	KvCoG7m2Zl0lF/SPS0VwYU/vtk/tKLA/T1QkmnqsdZwTW9k8fXHhF0WcuJTDinimBcQ2ADJXj4rs9q2X+PRcxwLhG+P+/GOnb+5pib9AZaastZb9Yuc+9WjsbyEt2xwEDaNwqzYsPjGo++bJypGHHBl+b60+wvLbGtZ7lioySMuE3ZsxAVShE6fSiH+Sql6Vek7IfW116A+szQxRuav8CqjWmqbN6lAzNhL/IAxnr9jD5kscDCmkmWwvWJIW9b8dbdE4Ll/pc3/cznyTAB/RIlE0E+1lxdWeIP3QSqlPlYozdUBKn6IGLgBz55o7qh6ZPvLtz4rF0EeG0MbEmXUsI+Q+Xhjxp/T5RfWquw7PyP+RJnIg1RIctYHY4dm05fl1UNxw8izqUo9oCk/8K0Y7Sm6Y4oh1EFx8AdENv+88QR82k6Z+mJE634EY+WjthwQ2KQiDt/O9QBpAmasShTQWmdQiGUoCHNoB0a+rFGsA/ayCA8bz7hvj5RNRdxjMWUHUgXQ+Qqdc+JwXAp9SRcY0hCcrq3f/lyBW5SqKJ5S9A3OnUkVdDxZXHJOmdN+pSupXIhEUhPwq9clAmMeUVJN3/LJQNgriZW2VKA1nO/UOhj+g0NG+EQmU6QdkZ86BsOolo9GZBOUq+5hD4RllOOcFnl27sBSMVi6Y8Y0YIJfTabAcz5AsN81WsmhpfJZvL7tEgndjERkl8n+mP+g0I6aBo95waohAWetUMpPZAQyHXaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(6133799003)(11063799006)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bza53Zgh93/K4Gn8fDllqxo8SvOnFjn5CPlT2O4mn5AZUiz0CbfPrjNabPIs?=
 =?us-ascii?Q?mT6VEkv9wIk2PHQnk8PF+6ihvExQRnjfcoscE/Hnc9wEIhvpMFNrAak1u1Nd?=
 =?us-ascii?Q?a+UJETjKTwvaeEBDMSHecHF7dczgrZxReBzIqHNpjZliO/62+6Zx8mp8n7Rh?=
 =?us-ascii?Q?ztNhoDhV+c+zauYWW0AhkVGh545qouyfwI4+PFoUxmsk7OVpoaEpp5LJHP2f?=
 =?us-ascii?Q?GJoelHad0bHzgxk0qfy7Nkrui+D3yZN/uIJP3rR+NvI/omuvR5BnLS37pO2j?=
 =?us-ascii?Q?YJ/sxx86o1U55QQVBDnw3ZuWIW8Kl6oMhin6+lxoowzq4p6OYyYsvz3h1kVf?=
 =?us-ascii?Q?IlXRtrvbO/rISVxnRl5XrPg48nOJVeRyBJl57WOBEZjoyvXpf3rK8qWk5nrd?=
 =?us-ascii?Q?nutqoshTX+Y8aayoNPE7I+d8PHRE2h9KKV9+hjFgsOH3XiFeIbbOrowdW5EL?=
 =?us-ascii?Q?0bOjrBWWNEct08GgmtZCoLmt1nZbwY5SIOuD/HPTAqNiyqyPes1YFz8ZoLTE?=
 =?us-ascii?Q?0M9p1kTVHJrnkL55yjmma2r7zlKdBZvH2PIdLxQtsmTiN23e/9VoMxvnJVwf?=
 =?us-ascii?Q?wL79fksnwoJghMxQMs8U1vazprsdlgq/22CNzJybGN0sgEwshNB/qxQ//+Xu?=
 =?us-ascii?Q?f1pMFk1ChxRPm2RgBAx7lRbTrOgKHYq1NAqLODfF8dvoKSqbvmLSoQaIpDuo?=
 =?us-ascii?Q?NhX+9ESh1sMoj3DwzpbLpABaty09SUXL+z5SgmeIH2+Fufg0WPXFLsIyf5d7?=
 =?us-ascii?Q?Gh+2VwW7Zqt2zxJ/nqoD6G+YvTgroR/NLXgTPNTBhMAn8jpSRUMfpRm47sDI?=
 =?us-ascii?Q?G9mbhGk714FQM1c7jQBlm3oGg3P9tuRpqY4wctOKkl8Y3F+XjRWAjziOwqj0?=
 =?us-ascii?Q?42vVQB9YhI/98+W6xADXQBPsioX/+cTP01KKCkPpZ7IX13TY/oQMlLL0JU90?=
 =?us-ascii?Q?xT0Sej0ibqFNFQXQfNzXFtnto3K9gj3AIztu5GWVxz2YuS1up9xKrKkxJQqS?=
 =?us-ascii?Q?kjDuwhPvMtOzTt5/yTohOuQV84UcqYrFGK10ex7o94cnCIHkRl0Yl/EEsJdE?=
 =?us-ascii?Q?2s5mGxnfvP7MX8Ok3iRnKuoCKCANSO4SJscZ50nj4JLYBEY3XEAlEaaYd9RR?=
 =?us-ascii?Q?a8aBS/m/AvWeF03jSjmikZzQPNv/K7mMA4hEam+wudqyzuYYsuJ2hwAnn/gv?=
 =?us-ascii?Q?ycX+aMVWOG7onCijIa5gQ0p19nf7/Z8xZXFyJ7vt8eabtdjDftGvuM22l7UC?=
 =?us-ascii?Q?HYJ+1sDzbhaTHmW78u2k8g3AgVgFSPJs+b1en0AECpn8WYPfWxul9v8C72Y3?=
 =?us-ascii?Q?+1G5Ekop3gKRpB7Wcl+wZqNVw1GSo72rD/H54kYxUoslQ6B/diFCc/nRjur1?=
 =?us-ascii?Q?8UtJYUO0afTLILrX1iLGgGIr9CUrGtLczZaKAg09rTdsEcz3nsX1BLIrpJMJ?=
 =?us-ascii?Q?j4tWjZQIHZGfTFQP6zYaVYHDGooWvd076ur7slM7kWrc+AyuaCUAy/u2KRO6?=
 =?us-ascii?Q?xKlwoKWQ8R/ZIj+yEsk97mk9pLc6MDDKaPI034+e0aRanjCKgrTag+RPrDbK?=
 =?us-ascii?Q?njo84oWhgHKhEzl4/en7/V9mx1Rz7RMlWwXwbp78qN+eZ1oBFJ8TFWdhTrV0?=
 =?us-ascii?Q?Te+7MioyWQ6isVDFVEYgB16MZrcT+ztf2E01/Ar2z6GrolN2Nl5xpSRp5xhi?=
 =?us-ascii?Q?bZBNJPt1HCCtZu9YOuholIxCycr5RNAcfDc9Uph+J0gf+B9aZAi9nRQ5NlYi?=
 =?us-ascii?Q?TCck8dasoIynwkqCoGD251e+kR63ySJT2dXQXHK1cRpTKCiv1csd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2034227-c824-486c-b4f9-08dec2d3739f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:24:16.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJZm4bVCKUR8cMPWFJVThtyL/kLnrZ9tpDLsgrZziQQGxoNLyQosygmmRvLHepmbVy9F5kUf4Tc/eMTKL2LIRCBbrrt3y8TQ5DkdL6z+bawFV4kqCefRpMULp25muH/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295695-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3961264607A

From: Wei Fang <wei.fang@nxp.com>

The ENETC VF communicates MAC filter changes to the PF driver via a VSI
mailbox interface. The message send path in enetc_msg_vsi_send() polls
for completion with a timeout up to 200ms, which requires a sleepable
context.

The legacy ndo_set_rx_mode callback is invoked with netif_addr_lock_bh
held and BH disabled, making it incompatible with the VSI messaging path.
Implement ndo_set_rx_mode_async instead, which runs from a workqueue with
rtnl_lock held in a fully sleepable context, and receives pre-snapshotted
unicast and multicast address lists from the networking core.

Add enetc_vf_set_mac_promisc() to send a MAC promiscuous mode message to
the PF. The message specifies the filter type (unicast, multicast, or
both) and whether to enable promiscuous mode and clear existing MAC hash
filter.

Add enetc_vf_set_mac_hash_filter() to send a 64-bit Bloom filter hash
table to the PF. Each filter type (UC or MC) contributes two u32 entries
representing the low and high halves of its 64-bit hash bitmap. The
function accepts pre-snapshotted address lists from the framework and
iterates them with netdev_hw_addr_list_for_each(). When IFF_PROMISC is
active, hash filter programming is skipped since promiscuous mode already
accepts all frames.

The ndo_set_rx_mode_async callback selects the appropriate filter
configuration based on the current netdev flags:

 - IFF_PROMISC: enable full promiscuous mode for both unicast and
   multicast
 - IFF_ALLMULTI: enable multicast promiscuous mode, disable unicast
   promiscuous mode, and apply a unicast hash filter
 - otherwise: disable all promiscuous modes and apply both
              unicast and multicast hash filters

Set IFF_UNICAST_FLT in priv_flags for ENETC v4 VFs so the network stack
does not fall back to full promiscuous mode unnecessarily when unicast
address filtering is supported by the hardware.

This feature applies to ENETC v4 hardware only. ENETC v1 (LS1028A) does
not support VF-PF MAC filter messaging and the callback returns early
for such devices.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9b16226602aa..418ee98da17d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -209,6 +209,122 @@ static int enetc_vf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	}
 }
 
+static int enetc_vf_set_mac_promisc(struct enetc_ndev_priv *priv,
+				    int type, bool en)
+{
+	struct enetc_msg_mac_promisc_mode *msg;
+	struct enetc_msg_swbd msg_swbd;
+
+	if (!(type & ENETC_MAC_FILTER_TYPE_ALL))
+		return -EINVAL;
+
+	msg_swbd.size = ALIGN(sizeof(*msg), ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(priv->dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	msg = (struct enetc_msg_mac_promisc_mode *)msg_swbd.vaddr;
+	msg->config = FIELD_PREP(ENETC_MSG_MAC_TYPE,
+				 type & ENETC_MAC_FILTER_TYPE_ALL);
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_PROMISC_MODE, en);
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_FLUSH_MACS, en);
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_MAC_PROMISC_MODE, 0, 0);
+
+	return enetc_msg_vsi_send(priv->si, &msg_swbd);
+}
+
+static int enetc_vf_set_mac_hash_filter(struct enetc_ndev_priv *priv,
+					struct netdev_hw_addr_list *uc,
+					struct netdev_hw_addr_list *mc)
+{
+	struct enetc_msg_mac_hash_filter *msg;
+	struct net_device *ndev = priv->ndev;
+	struct enetc_mac_filter *mac_filter;
+	struct enetc_msg_swbd msg_swbd;
+	struct enetc_si *si = priv->si;
+	struct netdev_hw_addr *ha;
+	u32 msg_size, tbl_cnt;
+	int mac_filter_type;
+	u64 hash_val;
+	int i = 0;
+
+	if (ndev->flags & IFF_PROMISC)
+		return 0;
+
+	if (ndev->flags & IFF_ALLMULTI) {
+		tbl_cnt = 2;
+		mac_filter_type = ENETC_MAC_FILTER_TYPE_UC;
+	} else {
+		tbl_cnt = 4;
+		mac_filter_type = ENETC_MAC_FILTER_TYPE_ALL;
+	}
+
+	msg_size = struct_size(msg, hash_tbl, tbl_cnt);
+	msg_swbd.size = ALIGN(msg_size, ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(priv->dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	msg = (struct enetc_msg_mac_hash_filter *)msg_swbd.vaddr;
+	msg->sz_type = FIELD_PREP(ENETC_MSG_MAC_TYPE, mac_filter_type);
+	msg->sz_type |= FIELD_PREP(ENETC_MSG_MAC_HASH_SIZE,
+				   ENETC_MAC_HASH_TABLE_SIZE_64);
+
+	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_UC) {
+		mac_filter = &si->mac_filter[UC];
+		enetc_reset_mac_addr_filter(mac_filter);
+		netdev_hw_addr_list_for_each(ha, uc)
+			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+		memcpy(&hash_val, mac_filter->mac_hash_table,
+		       sizeof(hash_val));
+		msg->hash_tbl[i++] = hash_val & GENMASK(31, 0);
+		msg->hash_tbl[i++] = hash_val >> 32;
+	}
+
+	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_MC) {
+		mac_filter = &si->mac_filter[MC];
+		enetc_reset_mac_addr_filter(mac_filter);
+		netdev_hw_addr_list_for_each(ha, mc)
+			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+		memcpy(&hash_val, mac_filter->mac_hash_table,
+		       sizeof(hash_val));
+		msg->hash_tbl[i++] = hash_val & GENMASK(31, 0);
+		msg->hash_tbl[i++] = hash_val >> 32;
+	}
+
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_MAC_HASH_TABLE, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
+static void enetc_vf_set_rx_mode(struct net_device *ndev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+
+	if (is_enetc_rev1(si))
+		return;
+
+	if (ndev->flags & IFF_PROMISC) {
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_ALL, true);
+	} else if (ndev->flags & IFF_ALLMULTI) {
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_MC, true);
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_UC, false);
+	} else {
+		enetc_vf_set_mac_promisc(priv, ENETC_MAC_FILTER_TYPE_ALL, false);
+	}
+
+	enetc_vf_set_mac_hash_filter(priv, uc, mc);
+}
+
 /* Probing/ Init */
 static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_open		= enetc_open,
@@ -221,6 +337,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_setup_tc		= enetc_vf_setup_tc,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_rx_mode_async	= enetc_vf_set_rx_mode,
 };
 
 static void enetc_vf_get_revision(struct enetc_si *si)
@@ -276,6 +393,9 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
+	if (!is_enetc_rev1(si))
+		ndev->priv_flags |= IFF_UNICAST_FLT;
+
 	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
 		ndev->features |= NETIF_F_RXHASH;
-- 
2.34.1


