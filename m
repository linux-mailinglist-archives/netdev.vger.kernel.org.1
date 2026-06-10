Return-Path: <netdev+bounces-297569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VgyCCMw0KWpoSQMAu9opvQ
	(envelope-from <netdev+bounces-297569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:56:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB506680C0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:56:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=TRGhcc1V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297569-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297569-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD51230CBBA9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5003E317D;
	Wed, 10 Jun 2026 09:46:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A53E1D1B;
	Wed, 10 Jun 2026 09:46:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084783; cv=fail; b=MOleWvJMa8JVTom//4WChUMDhUuoQVnthAVrHyX/NHGLgf2Ogt8xqT0LLOJfuHSTzT/96Ska+RSDwK6HPMlfHtd7b+fv57Jyo34tCzwmHK+HLTBRIh6VGbDoKNjVn+kVAMmhqlT/X9Wm/2CBmWrann0ogCKPKEl3/A+w28fYH5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084783; c=relaxed/simple;
	bh=lhRfZXODOMmlcHz4xkIVc7d8Y4cKw7AaxbJ6HSnpRl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSFRDte9hoFa5Dr4ecTa24T9MFJq02n90Q5FyYYIp5QMzYyAHbFXoOGZzwrGE4vLzon90/L1Fr4SWARf8dDZECgnxzK09+w6mknXtBLOO/XiekNMWV9mBHeOLEGqz4X2gan5sgC33N/Yi58LhZXpZufN98q8gUz7eOpKpJAenGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TRGhcc1V; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7DnJPYXE2XcU33TVyhzQq8tHbEL9J1HXIQJl+9DwYPu8fmV5fsCyr8/JmZbYXPYnrkGuqT8rwpxB9jUwAyvQpaiVCY5D3KDSy+vx2MS1GXuOzICRwhSzR8nUBdvD8hw05nYzRAp/gZ/2UqZunIIfPlKzTpFR4bFduFiIoSCT+4bRpeL+DitGG1wdqRQmTmLxDMvZzY3gMesm4TKAcHD9OxoO3fVFkY8ySYcmKBjOXTKMzwJ6oTceHTXt6GCpLIdbITQSkMrLZsGS1amLZvzZmuVcCvpsjY6JwgbjfRhABUJfVHms8D2NiBQe3OaATDz9neRrBSG8KtxSkw3EIyN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r8Hp/xsgGuH7eD3s5N0JaclVdGs5BLLmUzWbyoLf7Y=;
 b=tYUZgsdZiqZHL5ynBqIYhR17VhUk0i4ZqomhDRWOsJ1rJSeVvabOdE34sO7Z3ixtk/28QDdlxpO4KQGZzelG1Pc/49qojz5F4fzJBz+7vc71fLTZ9lxQul3B3tFpQsnTM6Bi8QGyxB8BYlJ7Zw2GoS19TzH5kdG/tNv6zPhcyNZdmNHeMiOu1yaj/Waouk+D1lMp1RrIGsB0sjymNlEfqDNBUynGky0ry45Q5CNkKN1t79H0GO9eB3Ps63bXT/UdSgQQuefhRXmFhCr9biH2ofH8CYTdXF+pQD9VJ+EKOJQ2eGp3zwH7xekeJkJ7kvXgX3uqasb4bmGg6vefQus2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r8Hp/xsgGuH7eD3s5N0JaclVdGs5BLLmUzWbyoLf7Y=;
 b=TRGhcc1VeCFcl0EgDZ+Pdx9TAgfTK6Bq/XAYs/TWY8VvWfvDeHK8NL4xUl2ikVvoCfifklUH2Y5R3WCX46h3yNeJoFo6BZiUnirZpvc1OyIsyOzbZRxLhKSh2ZiqZ908syF84rojL2RDmt1DFm0OJ3NJKItHThV7mQMQkkVjFSwAl6uMyqgj9/ko5lb/4Kj/7HLXMqlPwsnqcGYGnE7dF++nPLdWZOk1jFR0BwLjYx/pFi4IbIu2rTDv3gHLW6kqWkgSKx+2dbX9INBVoNGlBOAf2H6Yt5cXnbI2YvBQkmz1HugeSBO8qeJkb2Ak6khiV/hwWMoBNYT/o73CWF6V5A==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:10 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:10 +0000
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
Subject: [PATCH v2 net-next 02/15] net: enetc: move msg_task and msg_int_name to struct enetc_si
Date: Wed, 10 Jun 2026 17:18:31 +0800
Message-Id: <20260610091844.3423693-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::16) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: ad95155e-69df-47a1-9b4d-08dec6d51a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vSMLcYbLtkfiVVhw/VU1s6zkmq6zdFyc5FRcBOV9lhozaBjkPDO/6HeYfjKcDd+xUrpQoZPSkP0xUBGLUoq5EaLrBSs/F3rz9WKatPfBvUb6m58Hns7qFmJ7IBslEYadaJD1ephd9y3RXlep0HmCMU8wQodUGUOXK4mLSmCd8UoAecUGLreb6XLkR5/ChqZVf7FaDFCoYO7pRb8y078/zUXSDO/zJuZw9QuVTFUVuvH8l0aN9G8NopF6XFFCaQ28ug38h9OjZJTm6snEwTehw4vehDzqk+VyBaQx2c2DpFZ2Na11Z9S3rmUr+UOfxlyGPPqoDr1biQGmuqLpM9jaw/N3T3GbSnpDFIZ5w5AYJn0krvRnAyug/01tM7okmtbo/I49xjdBD/asL2cp62FTqr5A15+RFoLf9N/aguo3tupIvxmODmZS8qF7rVSL3bygQ+wl+SkFVJ7bXsbgKORG9/ZbY/SromgHN20OV9Z7KMPxtZE9AXSZtDSIoNM+10Imv4cm5F3bk1lh2ef3++t1UlJXX/pPUdMB1ZQTIb/6ku/HQVDlou2tiSAIhhdgO/po1QwUWGvWIQO5VhntJqi9seiFIlMnJpNXxcjEIm3lTwVFpQliM9GlJk5VjpQdjv93cr5MnMonIUnOFRH5FfVAvOSmXBbzs+aGb794B9w2oDMmEyYLHtmxQarko6qwIcn6My2lgBL4P/v2CM9jUhwxqAYGZYnpW/U4C32udJb/JJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NqQ1YAwtqN984x3P0J5pXPdUPjqzHvdCCMLrSXH/zd+9CzsxlVvNTnYQfJGR?=
 =?us-ascii?Q?1mVocZtywTKflkd8fgyBOlBG0KZEPBe+hbwowSf+UorOYLoJSqb4JRFfErSg?=
 =?us-ascii?Q?p59A5n/fkNukDSQkN3EKRRCd5aWgGMbfwfAW/8kD1E6BueqptL21r/FZ8gwS?=
 =?us-ascii?Q?yYIIxn9XCNB0PXu9ih3f5UtZ38DxO+q9hZQgRdZTxAn1juQGOZU9zjshkVxa?=
 =?us-ascii?Q?1prpkkQgY0uh11PH4E6CmwgiIPRMprdzzlmSpD1G3yWbz05Fn4UfFWnuTkVU?=
 =?us-ascii?Q?h8cty2jCRJu8Xzkzs0Vmxs3aHWM3t5yhArmt5ENOEifgVkIFUDpppPOuRTEO?=
 =?us-ascii?Q?Fv7pGkuy/3Wxms12Pc3Mwedni4P/01oPfDtP+XFSoKm4GHVZFXzt81WWKwgE?=
 =?us-ascii?Q?OBEaX3A82nmE+SrH80sj/Ys4izrrJR5pdnMHVlYM4fR4x8pQeOVubUyYo7iR?=
 =?us-ascii?Q?x5YtEQCfcNg8ilhURToMuXsLlHxTyljpOhDEyoIGoKJrtsWhlZj9CrPA45bk?=
 =?us-ascii?Q?fzvQhybo0LkjbyhuAlgWL6F8CarttbxN5udg83s/ZoJgEQl3vCf+DQUi4pfo?=
 =?us-ascii?Q?llXEVw4MwmLaHPLxgHLOtQQ58/2lZ5FeuCTwW+1nFDXdNhJZ+ceJBj7cRrdX?=
 =?us-ascii?Q?CsQaLee+zijdlgdqBP2y23uNDPt/inZiPt4TXtlvINiWWBmaUkCg0hHXr3nD?=
 =?us-ascii?Q?qM2b0v3ZLR8AyDZnWqDulpIhZ+Uql6dwdLB6H+eHdQDqo+mMg5Jh+M7tC+UK?=
 =?us-ascii?Q?OuSLWyF9Tdpizo7JvCJw+LoF3fq+3fVK6pjHb7ycR+nToK7CqvV1NKupm0Au?=
 =?us-ascii?Q?yhX+eVF+HSfcs/ovGCyz2RntwMyfVNuh77yl76QoxsUej5hebazDK0WCAdmr?=
 =?us-ascii?Q?InsphLEvN3LGVfu5dGD9Brw4LyLk3vFVglTZ+gW+ozyHryJeW7pFqWXA42Pf?=
 =?us-ascii?Q?VXihsGR5+xzqj4ss2y3p2hMbgKi8wLdCt9TNhTculIdrVrGLRTkavbm8HgKZ?=
 =?us-ascii?Q?uUmuK/U+o3z8CC2ATYghrx4Jfkb2DOZE2tbs9jt1DBIjQaWMm5Dwp4YFc8OJ?=
 =?us-ascii?Q?nFtNI85LrGDcLFD2e0sucp46OF8xrdVHticm/iBUe7SigQr/d5DtRzQB+3cc?=
 =?us-ascii?Q?ek3CgJZSZiQLqmT81YX2E5y9Te0KNozo28hcQqfZcJVkRIe/e98lgoTSj0X6?=
 =?us-ascii?Q?DVPIlj1BO89sHlE/kirDCtXs9P9twLsqfVEBwUWuL9MnkcQw9FG58ym8FEim?=
 =?us-ascii?Q?PdieAuXTxPoDbNaRa6JMLVpjlPSoLWYvDzKoguq6Q2H8xocMQYjV8MVPd60N?=
 =?us-ascii?Q?6k7lkm+nDuvBCSrGa1u1cOVTsTwP0+V46GKi8Nec8WpxjKcAp6cAeucQ6kxL?=
 =?us-ascii?Q?qzvY5c1S/aUbpD+Eoc0HuFlZZguIpSeIy6gy1Li/JOpcBLQSVYb2ITCoToDZ?=
 =?us-ascii?Q?3vQV7KxhA9qmv2ZWgaZ+S0g1zl3gpA1+lyxOnRQcVPImrrJvy6eZPgjvIPth?=
 =?us-ascii?Q?aoFTY2jYnwPnm64LxtwmN4Aosz+0fv6CsN5MZ0aaJyaMUXj4CKeqo/qZ3jo5?=
 =?us-ascii?Q?fbTGo/XgxowHv8ofWtkb5rWe6rCSpMXfcqfRI1Rsqxf57MBZAC4B2xPnAApd?=
 =?us-ascii?Q?bbTmcWxWcg1tI5LiuRMU7EChyL+S79pVmCpqqwC+YNysxFulw3GoO1aCIqrB?=
 =?us-ascii?Q?SsfQWu+cjNMA8XQVrfGI2C6QN2fj/1MQl9GxcbM3jq0+iCKAvuB6qI/aTWXN?=
 =?us-ascii?Q?Ex0m3sI5D65OBwSgSFiqL3Ac7hX8Nh/idYI6o154WpT/b8EZmPo6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad95155e-69df-47a1-9b4d-08dec6d51a2e
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:10.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn8AZyJ0EyerFakksFe7F2qsRljcXgt7Lbm9dhE7kz615NgklAmCNgRZiCg6haUvJ2/vveAw9D50anfCAfSxdZ89gS4ZbDO1CK8WLzSMSUO5IW3ZQElyh9zXA3DVMiAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
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
	TAGGED_FROM(0.00)[bounces-297569-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FB506680C0

From: Wei Fang <wei.fang@nxp.com>

The ENETC PF currently uses msg_task and msg_int_name in struct enetc_pf
to handle VSI-to-PSI mailbox messages via a workqueue and a dedicated
interrupt.

PSI-to-VSI message support will be added to the VF driver, which will
require the same mechanism: a message interrupt and a workqueue handler.
Since struct enetc_si is the common structure shared between PF and VF,
move msg_task and msg_int_name from struct enetc_pf to struct enetc_si
to allow both drivers to use them without duplication.

Also relocate the ENETC_INT_NAME_MAX macro definition ahead of struct
enetc_si so it can be used for the msg_int_name array declaration.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  5 ++++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 19 ++++++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 ---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..2cd035773aca 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -25,6 +25,7 @@
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
+#define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
 enum enetc_mac_addr_type {UC, MC, MADDR_TYPE};
 
@@ -328,6 +329,9 @@ struct enetc_si {
 	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
+
+	struct work_struct msg_task;
+	char msg_int_name[ENETC_INT_NAME_MAX];
 };
 
 #define ENETC_SI_ALIGN	32
@@ -369,7 +373,6 @@ static inline bool enetc_is_pseudo_mac(struct enetc_si *si)
 }
 
 #define ENETC_MAX_NUM_TXQS	8
-#define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
 struct enetc_int_vector {
 	void __iomem *rbier;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 78114ab3e482..a89a5a418a23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -37,7 +37,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_pf *pf = enetc_si_priv(si);
 
 	enetc_msg_disable_mr_int(pf);
-	schedule_work(&pf->msg_task);
+	schedule_work(&si->msg_task);
 
 	return IRQ_HANDLED;
 }
@@ -223,12 +223,13 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 
 static void enetc_msg_task(struct work_struct *work)
 {
-	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
-	u32 mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
-	struct enetc_hw *hw = &pf->si->hw;
-	u32 mr_status;
+	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
+	struct enetc_pf *pf = enetc_si_priv(si);
+	struct enetc_hw *hw = &si->hw;
+	u32 mr_status, mr_mask;
 	int i;
 
+	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
 		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
 	if (!mr_status)
@@ -311,13 +312,13 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	}
 
 	/* initialize PSI mailbox */
-	INIT_WORK(&pf->msg_task, enetc_msg_task);
+	INIT_WORK(&si->msg_task, enetc_msg_task);
 
 	/* register message passing interrupt handler */
-	snprintf(pf->msg_int_name, sizeof(pf->msg_int_name), "%s-vfmsg",
+	snprintf(si->msg_int_name, sizeof(si->msg_int_name), "%s-vfmsg",
 		 si->ndev->name);
 	vector = pci_irq_vector(si->pdev, ENETC_SI_INT_IDX);
-	err = request_irq(vector, enetc_msg_psi_msix, 0, pf->msg_int_name, si);
+	err = request_irq(vector, enetc_msg_psi_msix, 0, si->msg_int_name, si);
 	if (err) {
 		dev_err(&si->pdev->dev,
 			"PSI messaging: request_irq() failed!\n");
@@ -350,7 +351,7 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
-	cancel_work_sync(&pf->msg_task);
+	cancel_work_sync(&si->msg_task);
 
 	/* MR interrupts may be re-enabled by workqueue */
 	enetc_msg_disable_mr_int(pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index eb977da2be71..07bb9aab89aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -43,10 +43,7 @@ struct enetc_pf {
 	struct enetc_vf_state *vf_state;
 
 	struct enetc_mac_filter mac_filter[MADDR_TYPE];
-
 	struct enetc_msg_swbd *rxmsg;
-	struct work_struct msg_task;
-	char msg_int_name[ENETC_INT_NAME_MAX];
 
 	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
-- 
2.34.1


