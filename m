Return-Path: <netdev+bounces-296477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1X/aHJicJmoQZwIAu9opvQ
	(envelope-from <netdev+bounces-296477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:42:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1F6553FD
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:42:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=Qx6KqS7V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296477-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296477-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91887302E0F1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47673B47FA;
	Mon,  8 Jun 2026 10:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A8387596;
	Mon,  8 Jun 2026 10:35:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914914; cv=fail; b=FDX7kuTxQZgiBwoL2Hht1MsU+avo1j8dzzfNbibuDwgFFkHEwcB29Y29KUtVS0PJXYgG2KJyMKQJHue6QmldJValu3AzLT8Zh5RSdgB1lV+vjODdtuTeoJhhdl54bD6C1CLcib4IAL/NPS3QqGPXtutvk+pWLqQwSaVJm0cFB/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914914; c=relaxed/simple;
	bh=tng7EII7MmzGGVyArFO2apYGau4waZJ82PY9MPoMJdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oPnYyncUw+7cG8VqoO6c09HQkU4Y4Jmenuu1oUhHRcIw/F8uwLylfYLRDV5TtuT/uinsfTS8fQeTEAladMZ4mg4gD1TsG1BUoQam9bu9QXjHqSUwTSXiAppgWzpRB3+iCXNqKoS9s4bgwr7N8sd+vL0C8hpLa2hUjrJle3a3VXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qx6KqS7V; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdFGTMUHz3ppI7S4pqc7UoFmR4T149xuDNq6qwAPUNBprGpz0ny7tweNEULQ5n4Zu1HJJoHDTNY+/KH1hWYgFEoOAG54kf61/QVbNjousjin79ITioRkqiJ27IXHAT4igooqm7BPdBsmypXjFFTamumcgHEai9x8WDyV8Osnm4peWO7nTjNr4BXp9p62tU0evN57jNyPt0C8U37YzttEi3lQmRvX9bU4p+SRYOFimIqxg8X5yzXK3J4I+mNYx1DjvdOsNggBJQSxYmSLDrlGl9YuE7IJW748v3IMjwIgRhaF+FKeME/JpJm54wn4wHy8pH0KVES7WSNFuQzzdoABMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggCTytPAaOCsdw9/CiHYcNLS1ii4qBaafUODHIXChdc=;
 b=pc+A5jM1pqRWcmwNLZAYKHBJSEUN/+OWwvwffJJeotSfG1w8+XfR9RzsGKCRZSOCcMntNegrJ4L6bh68jR/FmdpMUoylT7R8UynZ6Vj+s+i8seX2MkOUe1n1BplRmtcCGdIpEHDCoOHVqN2UQhSEFvn9sFoi+ejhXSdWmcc1JKe1/FT1D0EUJt51sk0al2HnXgBjQ55tBKVlJ5LuX0PS9tvNengvd39kRBkEmz58lYIh69C4dalC1cWFIFZ/IchJudOCC1C3I5y33WWyXgsTgLrJzSNkRbyJERa1M8YxlJyBJqOGjc/YSrYk/HdblfvtujTJyU3APX1oUb4zZvcLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggCTytPAaOCsdw9/CiHYcNLS1ii4qBaafUODHIXChdc=;
 b=Qx6KqS7Ve0toEP5PhfjcG2C0FxV7HNHDDk6/vOHDhe/V+jhHeLSjyG4bvDolTBBgGBNHta3qYzXbD2/N7fe+Sda8YDMO8/kVvKeaR5uXAurg9XhQEFdUNRY/skk8YAeNfCJwPLHKaVsfd87oR7Wjomdicfa6y79Jr5c91QHFqFWwppp8BGMql6Shotgwstx/clAw2xKjJ8saKATxeuCLu0Uqb6QlgVh2P6QpAtUyDX8YqqqEYCsmpY0YtF6mBHMjZhedpryZ9o2QUWZp5/RGyo6f4XWLjZMXGBeERAi6+cmCy/Jt0jFDHuv98C/trJa6XJ1RVRUPV7G1tz2JZAqnyQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU4PR04MB12347.eurprd04.prod.outlook.com
 (2603:10a6:10:62e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 10:35:09 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.010; Mon, 8 Jun 2026
 10:35:09 +0000
Date: Mon, 8 Jun 2026 13:35:05 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/12] dpaa2-switch: offload FDBs added on an
 upper bond device
Message-ID: <anq5hltzxak5fbnj4ajszwsml435jdxjs64dk5trhatiy6ulgk@qqxzamvbvaeb>
References: <20260603143623.3712024-10-ioana.ciornei@nxp.com>
 <20260606021054.4124776-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606021054.4124776-1-kuba@kernel.org>
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU4PR04MB12347:EE_
X-MS-Office365-Filtering-Correlation-Id: cba756ec-8437-4e5f-96f0-08dec5499d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|27256017;
X-Microsoft-Antispam-Message-Info:
	coPqp6atlyxFAX/QFR2uzCsHZWU7QquX1bKIoJWaxRa7wI3TXPHEiAmUDMOYrhsaWSl6AQ2jpUDqkcJTdVEzqPuBmnkxu+vHwsJUNuTiPKhLt4b+jgZves+xLygWWFgJcSpPfvroB16K2jEi7GILYmI3LXy1Hayu9tG5ATC007wKAbbVRMIDg6bbfrS099nLNvTrt1Jxxq8yFCthrU6Z+0jPEF1QfAb4OxxGKAeuufBaDvoyueke4LGbnSB9Ohds5X23pCjPEQeCPV9xxM2icphx3TGH8bNx1MrY7KIDD3Bw8dp7zoJaIks+BIr55uKtiz5iGvncbzHD5wWUGW2q0WyKPG+RSzGS0KmAm+HlyUZyIPGMYdqKmkj550oQAcKqh3+pCRV1jP2pHFcZW8a8wOA09eBOCmdS3w3g06EBmMSWWObOER9xUMIkWbrtABcPYFmKKKAeDRiD7i5wiBj4SYUgK/LwhUedDUHX72hj9fP+XkPt6n8bLw0zUtpp5j8WkSI2MkuCd6qAp1ej1ePLKgjfT37xAr4DpE1BLwRcBQfbtLycVLdCqWOD4JB1/Cjqw1sarbg1FEV+YWPgLR0K0Tzoo7ifb+kQ45GsoNLyKvKYDH8JLNZ8VTpyRsc3pw0PE0vHTX4u4C5nHSfymzl1ZYt8OYXSpakF6VLpGE18dSkCcIKMOfbkDp/KjyhsxBfxaxHEWqKcO+ig7UAJH6ao3ZvnxTdjcdGJY2QYNHhNk+tjyQIg8c0t6fSjjeaB9xqz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stRBKWHa4uPGkHrNXAxue8GC/bDBiFLCcHBUxsJkuhSQmkZFpSiwp4c1MHVR?=
 =?us-ascii?Q?pbY28MLdaIlIZX2O8CBWEe1wXCMCFX2YTP0x9T0qTegv6g9H2MUIp6IijJZ5?=
 =?us-ascii?Q?7xC1DZDPTjVcNX8SCC9Oiv1m0xqml/WLBvX0fwQfOr4fjWsDt2pNF5sfySZ8?=
 =?us-ascii?Q?Dm8qlE4tJq5V3W6JLNlwZvfWu4lKBlJPtO/F/33Spy1uKJ4aoDTueAvpbCYk?=
 =?us-ascii?Q?ja9Q5RX2U/ZyRLnsjXnHIIigpqj+hR319QLzPSUDUdJAIooM02rtlzvXC5mE?=
 =?us-ascii?Q?hiPjPZtbAPiK0Do/P7XcLNFPZ2EVFnzTFQ4KUMTmCbtq5m/Ru4jxrXYaUpK2?=
 =?us-ascii?Q?k+1RXkgrSfBSS7/z5EsxOP2qd5i0luFPOzd5argYAynLAqZhT3ISSiKUaO28?=
 =?us-ascii?Q?H7X0F9T0ptDTJrqRFWXwYdqqLlF0GJNiSiocUthjl3VbXgeKVqJmD9eHPRZ/?=
 =?us-ascii?Q?C+lq0R1WmH5yhZ2YagagfzOBuS0nnmJvK3TPwcWaxDwuNGXTzMuRnXymRe0G?=
 =?us-ascii?Q?28ZubliiukggoPK9Z4mEir+4iawELJtsDafjLd+htkD1Tm85EvtXK5Ucoiwp?=
 =?us-ascii?Q?yXe9R8zybERh7YksFgGNAatKYvUuhexissF4vs9lMApjNVxxSVj18qW734JU?=
 =?us-ascii?Q?8M65ijnoZjc53tRQbNc9CUAMrDk5ZeWUDTFFaIRGnwkqC3kVCMy+ngzFhYy8?=
 =?us-ascii?Q?WFwMa3POeOhWELelvxGoDcy0sp7vvqxudM2PtpnHrsu1xQI41Md598msm1cX?=
 =?us-ascii?Q?ro1YkTBavFzO3fIxp4RMx9F1pSxRnMBe9zVCchG8b+RWzhWdzN9umSLLEnix?=
 =?us-ascii?Q?bXNXe2c18FtqUfwOgSiU/2Ehdbs56h4zwvfGNDdO5/AfuCjbv4bdZp7rVWGh?=
 =?us-ascii?Q?Sl450IBKU8cXT0WxgXQmpZXWajoNpWozgNxtgQC5Cc4AYRyR/xQyI1TYZJwO?=
 =?us-ascii?Q?+jJv7oRKcOsblntL7kWDltbrGWabl975pcNvFlBlIojY8I8yXimcJv+DJ0Ll?=
 =?us-ascii?Q?l2Eg42dcwQgY3F1Iwr3uX7dY0DMaqD0V+PaZuEqWzbDXlNRcHj2LzXOIi/JA?=
 =?us-ascii?Q?faaPrSMrJOlh0kcurA02iXzOoKOSlcRbfhQsQgSdJW+RdqDTc8bhT5b7P2yW?=
 =?us-ascii?Q?gi2h27WcVqyfTB3EwkjY+0GnWttN7/kkFh9ZdNsk4VlnAu+kldcoMZT2Eb7r?=
 =?us-ascii?Q?Vo1zC6G2DpIgx4fpo6qncd9Xb/sKuFhoyF35uN+uR5EdOQsU1xFisZQhZuPi?=
 =?us-ascii?Q?3nRN/CEuGiboP0z6bZr+OWTX1HtL97HlizWpqhuNjxljfWfwfF8dO+Eac7Id?=
 =?us-ascii?Q?hdyPqzQNmiortg3drGi+Q4YvoPhNw8Hltx1U0hXSjAy6CxPIsjoAe0dtZ4Id?=
 =?us-ascii?Q?r9tP3b24YeWco75Galj5SGXI1Gz8iHY+D04ouzz1wVBFK63Eanh+Z6zocmJp?=
 =?us-ascii?Q?lfUbLddf5Q7APhPchz8yViMR1nPnOb3AbvCwDHCsDC8shwF2FYtX8L+5brDY?=
 =?us-ascii?Q?TGBB6okTDGX0TCLqegT6VekseTaA/eFLA4Oqg81ifrEInhj71+LdxMcc225Q?=
 =?us-ascii?Q?Q8YNb0/oKTY139HXP2TlLCIx6MjNbb/j7i6g5tLa4LQ/Leeu/DYv7foYz7BD?=
 =?us-ascii?Q?oUo63tKtcH5axYX1cAMjxZH+gv0pRuKHqhMR32b/1Ygt1seUs5jJdQ65P/B8?=
 =?us-ascii?Q?xbs9+nC66ubrA3+iGAmJUsk8tja4OyQUQQea13uD0zCfHwr0jCsIj7cgAb1r?=
 =?us-ascii?Q?T0c1dnBhjA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba756ec-8437-4e5f-96f0-08dec5499d45
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:35:09.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI2aUKndRBfnrjS0ywVSOD8KDqRTHW5nmvIDNmPf7JBPnEiu8WO0syF09hItWxJasxKrQDQf2rscU4fhqZIwFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12347
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296477-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:from_mime,nxp.com:dkim,qqxzamvbvaeb:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1B1F6553FD

On Fri, Jun 05, 2026 at 07:10:54PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> dpaa2-switch: offload FDBs added on an upper bond device
> 
> This patch adds support for offloading FDB entries added on upper bond
> devices.
> 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index fb754dae80697..fadebf6a758d1 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> [ ... ]
> > @@ -616,6 +640,91 @@ static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
> >  		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
> >  }
> >  
> > +static struct dpaa2_mac_addr *
> > +dpaa2_switch_mac_addr_find(struct list_head *addr_list,
> > +			   const unsigned char *addr, u16 vid)
> > +{
> > +	struct dpaa2_mac_addr *a;
> > +
> > +	list_for_each_entry(a, addr_list, list)
> > +		if (ether_addr_equal(a->addr, addr) && a->vid == vid)
> > +			return a;
> > +
> > +	return NULL;
> > +}
> > +
> > +static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
> > +				    const unsigned char *addr, u16 vid)
> > +{
> > +	struct ethsw_port_priv *port_priv;
> > +	struct dpaa2_mac_addr *a;
> > +	int err = 0;
> > +
> > +	mutex_lock(&lag->fdb_lock);
> > +
> > +	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
> > +	if (a) {
> > +		refcount_inc(&a->refcount);
> 
> [Severity: High]
> If a port leaves the LAG, the fan-out for the FDB delete event will only
> reach the remaining ports. Could this result in the refcount decrementing
> fewer times than it incremented, preventing it from reaching zero and
> permanently leaking the struct dpaa2_mac_addr?

No, this is not a valid concern. When a port leaves a LAG which is also
under a bridge port, the driver will first call
switchdev_bridge_port_unoffload() which will eventually generate the
necessary deletions of FDB entries.

> > @@ -3903,8 +4073,10 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
> >  	for (i = 0; i < DPAA2_SWITCH_RX_NUM_FQS; i++)
> >  		netif_napi_del(&ethsw->fq[i].napi);
> >  
> > -	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
> > +	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> >  		dpaa2_switch_remove_port(ethsw, i);
> > +		mutex_destroy(&ethsw->lags[i].fdb_lock);
> > +	}
> 
> [Severity: High]
> Are the dynamically allocated struct dpaa2_mac_addr entries in the lag->fdbs
> list freed during driver teardown? It appears ethsw->lags is freed shortly
> after this without iterating through the fdbs lists, which might cause a
> memory leak of all active LAG FDB entries. Could this also happen if all
> ports leave a LAG and it becomes unused, inheriting stale entries upon reuse?

Not a valid concern. The deletion happens when the ports leave the LAG,
there is no need to also walk through the entries.


