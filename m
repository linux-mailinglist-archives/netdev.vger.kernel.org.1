Return-Path: <netdev+bounces-287997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGxsOT/fBWqjcwIAu9opvQ
	(envelope-from <netdev+bounces-287997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:42:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FAB54353A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F630302F39E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06523F7879;
	Thu, 14 May 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="imR+DS5b"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B67352C2B;
	Thu, 14 May 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769173; cv=fail; b=OLszb50FeRH6gp+w16KWf1Il5lOeCkepPIUPhwuSZlSsBPYJkyoBuCguPjGglFbUtp2jMFX/nbxbqr5cnOPl1rIqbBhEDZf8DrdGlE/fm5ItHJxKCfkn+jQ5+ffq2a9MB9G9zeL+7tsm643lLgtsKL0BhophPHRBfMUt3YKmDpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769173; c=relaxed/simple;
	bh=q6eGWMnqjde+LBXZMZ597zNiM/oF61BdmXms1f4rHnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPK5nOPdul4wwnKjfAjgQblwA/YgYtrpChC4IEiwvZ4JzKgNURRA4dX3syR1DSzyk52/lOgBB1BT065CGZDaskdfOEp2YUnBxUUbBiR60TNrBKfb9eSXdYe+Ulutig8HMP8iea1XrH/e30zH+WItC2t7TggAy7G7DgK7Vx952UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=imR+DS5b reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgqQVa95cTTg69/JqbOh9QF8jru5kf8qxe8Q9XSeJMKPse2zIdC3lmfFkdfDrPiUPt2yEoI4IkWPiQdis4eJ+WdDZeMflzYeyaVMYbqP7eeJwyKiAT/WP7EnnjWIfYUXlWbGxs2FWqiaKGJRVv6V14HQ5xcL/kOzuneIUxzjymT/GmZn5g60JbitSzfPDIetW38KjlKVmAle+Ig8gdbAS4MT924IULiqhAOZ0Zf1d5j+ETIAm6kCCmhoe0qcLzU7Xi+QHwYCNXT+JnIgtyZIEs6ulUZFMO6jN9kezSyA/lq0JIWffIB3by2Q7LqWtziMr3BKJc9sqES/osb8689tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+/BEBkf5V+XUdHZXKK4LPmwvreUIy6/GROvq2oYRnk=;
 b=E78E4wnLjr8CCwOKJw9W00P6vobdOCmPXWrtBTQnhjbTmRZFj3/2UFjFzu4giEsRfbVwdTC0QuGyiVJTGLPoO/lVlzJQ6HO7jaRCXZURJ7QCDbB0NoEFz/OXQQZ/U3PSELPBZIA2R7tKE04Y148j0oLT7CIuWniOi1U/P9BzedP9sRdTnwcUsZPcEmbmmMYfuVb0mftg7AR4ZHzngQRbvtd5s5BWboVPFpn5OM+fPowAR+QaRlnv8EkmbQT4g2Qosxkb4iGHErSxOJjUHtv86e25u6tG9NJWaeHN9fLlzr9c1wY5wqRp5dwnnu1Esm14S4FXL0i98imgytD2UTlPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+/BEBkf5V+XUdHZXKK4LPmwvreUIy6/GROvq2oYRnk=;
 b=imR+DS5bWSwfZRWFjYPMcW2Jg8fHpd9D+oAoCwC5ct1b9eUyX8pe/AUkQhKH7FCWWB06GFawFpiKjkBwFCZ2pBRdkl/PUHI92JHYe1583Xvd5o3hVg/mC/itxCoqXnAtAdg8DX+xjPJXN6GnqtlyKVxEm503iR6SOTIp2QbpQC7VvVQHwy0Jst43IQ3D6/NRG1pSvBPRbCQpqzigJKsb/TLS4uvbSl0mNSgopqmRMBCBvmClnFaFG1dedRn964MNvqLj1nT9FS9q9MShv4Fp/pHhcpBav47x4uSNoh0yjvnb3rN8qNLSZDJ7+kqk3CTY49K+I6PHLL72+epeKPZxJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9645.eurprd04.prod.outlook.com (2603:10a6:10:309::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 14:32:47 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 14:32:47 +0000
Date: Thu, 14 May 2026 17:32:44 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Message-ID: <20260514143244.fjwyed3nwc5rajoa@skbuf>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
 <375dddbc-385c-4dcb-a280-33292215ae67@solid-run.com>
 <20260513112222.2szwvxptk2udv7ga@skbuf>
 <7aa87d24-5501-4ca4-bb39-791beb7c95f2@solid-run.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aa87d24-5501-4ca4-bb39-791beb7c95f2@solid-run.com>
X-ClientProxiedBy: VI1PR08CA0251.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::24) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a24545-0955-4a69-92da-08deb1c5ab11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|10070799003|376014|366016|56012099003|4143699003|11063799003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	C+PZu/+6RQvKMy/mkBaOx+K1/ENAnNOqwypfnECwIBTvyvrbvrxnKnILbqDvOf5ciazdBJCXDLiEgZiKm4evHIn/kIkNz+rlsOZXPsxn1nCNjYfWai/bgdT2G/5vKH9ojfFpzdjAvvR0dNGFKUvWfuj79rjXFS2IXPK8qlBHUqH+a+bOHI7I/En3IIhvShxOcT1IjZH195UQcD4z15ckmYOJFu7u8rBdf56849TZer691cPpIX/MTIYURPDvj3uJEP3O54nMsjDBQaZIemZbCq+mAOFV9GZ3rMgyp0guiVY7zsgubddIVptIsDDi9tdr5A80D9CubzyL1A3FCrf51zB0FY+BoRM1AESXMHVMUK+4ju29XL5TXD3jltIpSIpjNWzaRYQNGTzqLq3vJm+1SjJTUD8JAYtXV6bChTvcXCWcACLj55l+Cym5Dsep6zpdIM7doLDch2k701ynubaihp1e/d7WrPmbKJ37ywdC/4MFCQeaS/lLoUqP4iJ9QBUFek8bQjpGRT4IlUCuIVM+fsTvoTxZ56x9BXk0WBR18Wz5n06nrukA/4Xb845oI29DkP5CMxx3YnK8ooKhAbxts90jJnahiFJ1lA4Dc+hVvdopXXG5BkeuuC+KxITuYJAy+6EVHIkuYYMuCYACWVx5xBS9k0biwmtW7oVoBq9rW3ogXLxw0c9xK6bM84N6qWaV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(376014)(366016)(56012099003)(4143699003)(11063799003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?grGjnqHq207cGgk+IQuF5OUSCYKb/I1/eF4pweHAtuz+OUepnvrQHANZrj?=
 =?iso-8859-1?Q?5MPQCmenYba3NLN3kHu7rTzB+ZXalf31ys2fine2ZSsWyAYOhwSfpI2gWQ?=
 =?iso-8859-1?Q?k+E5opcxN9VOPoid+tIcWr/Rc5oU+gsFyJzS149I7xwqN/A5GMS8wh5AkI?=
 =?iso-8859-1?Q?WxjX4yV3tBgsWJWvQWTQ+vkRf35u7nL9LDmfhjXhptHYbY2JDsXqBvcbc5?=
 =?iso-8859-1?Q?b384tJJd6VTq0VD/+I58N9G6Gq/LQ++IIfHKN3GSQWnK7NPi7emPBy3KMb?=
 =?iso-8859-1?Q?3VbeUelshPRirgVWSGi948Md41cNWGnAFdcfsNCi8tUpZwATX0xLJ8xj1Z?=
 =?iso-8859-1?Q?h2hZa62GrsodzWQ08J5oGJE/l2nmF2DhsayWUOz5HNhdmyVEu5C2BxAcK7?=
 =?iso-8859-1?Q?XNdz91Y693SiVpX8IXI6QuNt1WvW4LHrNy0i1j+gnHEPQ6uTWxiRdj8ZMB?=
 =?iso-8859-1?Q?tBfY4FZ6zXCGjqC27C96UkHT+I6Eb2iJVXpyFA5i2qV53+78mvr+XL0aAq?=
 =?iso-8859-1?Q?G7dAJ7Ewe4gOznzLip1dl9ljpJZMQG4SBQI6Sj15bIx5yUPuwRu5lRTlKa?=
 =?iso-8859-1?Q?U4A7asXHRvgeSn6lU8l6ZTPHadAsok3SxUvhRKCbWlaIou6M3tTebMRLd5?=
 =?iso-8859-1?Q?Jt/6x6eSkauwZaJA2+pOQedvPsFpMRGJf5aPFZl2qSYiHtRm/ABmnc6UWv?=
 =?iso-8859-1?Q?PeAWD/3kTb3yc2dTEfzeX/vOcDFPbdUt660dFQdotkCzzNo7fgIq/jQTzY?=
 =?iso-8859-1?Q?ScD/Gd+I1zX/mtfBga6FFV6K0PP2nI7EflBLM/7Q0NJY00FlOJMq5AkJ8Z?=
 =?iso-8859-1?Q?hEyZZlxTBi7Say0jYSD/M7SYbCggTcAWGsviin3pSOkg0QxZFk9dIryKZt?=
 =?iso-8859-1?Q?IjX9NaLmFZTPMI6W9ZPUmq7D0eF/YWpwsGxSG0hPqpakEcLBsHxy0m7TIo?=
 =?iso-8859-1?Q?0XgULIPpDNsXVHHq8Om+H1Gnilgs/oLHn9Oll4xPw7rsqpttAnCMtF84HH?=
 =?iso-8859-1?Q?jfsaJBY1uaCfz7WAdgz4yJPy3lmipnK71FzJQYLnebSZZqcM8Xt1qRSOfi?=
 =?iso-8859-1?Q?itcWvZmXOcWhao6YURq8gcjk/6jhiv2LCXaTrLyosfpmb9NnBHAfNfKP37?=
 =?iso-8859-1?Q?xSsW4Mx5QK142TGrU29B3VdrDZK+Kn7q2xjiNu6tiJWPWKJrNfwybazzaL?=
 =?iso-8859-1?Q?F8gmo6uZQRPEjX9dS4DrWSy8Q9nXRhkvjO3qeNNrN2jOr+tFn7Gizj4sV0?=
 =?iso-8859-1?Q?KZ1/yJjHukUVtSlKixAFcPe6A37V39BmHoBjnQvkyZYS8HYuJcpAWTMkgC?=
 =?iso-8859-1?Q?GTgMYheQQyIFuaSvcVMrEY1jEXuRpydJ4lQb7IKpc6JuLawFo5CBkSZw6+?=
 =?iso-8859-1?Q?+XBJdKLt3HYPugjT9avLg251hb7DAWS8jHyp/hWs61IkYdVnGJDDNSbmEv?=
 =?iso-8859-1?Q?ck7ylQrodCk6g5j4HOwguY/DANtseKezqqyMsF9Q6lGV4rq3Gor5k+H6dK?=
 =?iso-8859-1?Q?5iuaZj9HMGJfvtlJv0UKMga2LtdiMX3NNGgLT56Z1yeloiPlDRqIHbxzrt?=
 =?iso-8859-1?Q?rLoFcJZ0j/YMMT9DtyKn7FJdHvWPBs1ZhlOlLLa4qM+AzJT2xGYROoZS0Z?=
 =?iso-8859-1?Q?mf47luQcz+UP1PhW1/SqgPtsRAccd012LrL/6mip101+4qRE00xdCN1J4q?=
 =?iso-8859-1?Q?2kOc3mp9+0Hajf8Di8qX+NEN/zyUrPma1+sWU+8M9GrNEUeFGDzWXPIXO1?=
 =?iso-8859-1?Q?BNaCVqsETX35S90x2/T9r8WXGTsrpfIVTO+uXiDSiQ6Un0uS3lbiZXWcLx?=
 =?iso-8859-1?Q?XW7pGI5BBo1pUSltloMtjBlET65hoC2mIHgKAEDTxjt8saCGT345PfUr3q?=
 =?iso-8859-1?Q?9Y?=
X-MS-Exchange-AntiSpam-MessageData-1: ESdz4R1buAyrLg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a24545-0955-4a69-92da-08deb1c5ab11
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 14:32:47.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCVrhJ1u0MIonm7oSWeTcN0os1Pi2BUGLmfR91Z2KwA2JINtPVMUodMF+iDavWirDL97t0W5HJeC0QoqUI/m+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9645
X-Rspamd-Queue-Id: 46FAB54353A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287997-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_SPAM(0.00)[0.533];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Josua,

On Wed, May 13, 2026 at 11:41:06AM +0000, Josua Mayer wrote:
> Am 13.05.26 um 13:22 schrieb Vladimir Oltean:
> 
> > On Wed, May 13, 2026 at 11:00:32AM +0000, Josua Mayer wrote:
> >> Wouldn't it be more clear instead of indirect lane offset shift with
> >> lynx_28g_e25g_pcvt, to instead fix the E25G_CFG definition?:
> >>
> >> -#define E25G_CFG(id) (28 - (id) * 4) /* Offset into PCCD */
> >> +#define E25G_CFG(id) ((id) * 4)      /* Offset into PCCD */
> >>
> >> This is equivalent when inserting (7 - lane) into E25G_CFG id:
> >>
> >> (28 - (id) * 4) = (28 - (7 - lane) * 4) = (28 - 7*4 + lane*4)
> > The 'indirect' lane offset shift is actually a two-step lookup:
> > lane -> protocol converter index
> > protocol converted index -> offset into PCCD
> >
> > LX2160ARM documents PCCD fields as:
> > E25GA_CFG, aka E25G_CFG(0) in code: 30:28
> > E25GB_CFG, aka E25G_CFG(1) in code: 26:24
> > ...
> > E25GH_CFG, aka E25G_CFG(7) in code: 2:0
> >
> > The odd bit is that lane 0 uses E25G protocol converter 7, unlike, say,
> > 1G and 10G where we have a lane:pcvt identity mapping.
> > lynx_28g_e25g_pcvt() performs that translation.
> >
> > Additionally, for locating E40GA_CFG, E40GB_CFG in PCCE, I've adopted
> > the same scheme downstream, where E40G_CFG() returns bits 30:28 for
> > argument 0 (pcvt A) and bits 26:24 for argument 1 (pcvt B), and it is
> > called with this lane->pcvt translation function:
> >
> > static int lynx_28g_e40g_pcvt(int lane)
> > {
> > 	return lane < 4 ? 1 : 0;
> > }
> >
> > Are you saying that merging the two lookups would be more clear because
> > as a reader you'd get to ask yourself less questions (the code would
> > flow more naturally) despite the non-trivial lane<->pcvt mapping,
> Exactly for this reason. Fewer look-up steps.
> RM dos not document this mapping, but now you do in source-code.
> 
> Perhaps a short comment on the function will help, e.g.
> /* get protocol converter id for lane */
> 
> > or why
> > exactly? For me it is the exact opposite. I can follow the RM
> > definitions and then I have a separate function that tells me how lanes
> > are mapped to the protocol converters.
> I think you give a good reason here!

So you would like me to respin this series? What change would address
your feedback here? Keep the E25G_CFG() macros as is, just add this?

+/* get protocol converter id for lane */
 static int lynx_28g_e25g_pcvt(int lane)
 {
 	return 7 - lane;
 }

