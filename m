Return-Path: <netdev+bounces-296430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id siy3AJCJJmppYQIAu9opvQ
	(envelope-from <netdev+bounces-296430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:21:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D75B6548A2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:21:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=bIOutu3v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296430-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296430-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87DF63042932
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524443B42D7;
	Mon,  8 Jun 2026 09:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835D3B42F3;
	Mon,  8 Jun 2026 09:14:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910058; cv=fail; b=E9vBp7cGp7jubaZjVOzQV+VDYygL4t8j4vnD24+tlqC7sfIg5spHjXnvpCJbVqmtZgnnk+nuABivcEBeYoNSMPscNV3WrdyuTLqDgtHpvwO/DNvxwg21K8FYfsXz3z6mxMbVpVTBHESbOkaGg7vLgzBe9khwLUiC9iOLymWQs1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910058; c=relaxed/simple;
	bh=ngtVvdP2/WC6Kgq8/u3Qa3OQ25GxXYGPxZLpT2TDfeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UZMRyL3XNC3Xrq+dQC7X0xZIUkFPGEgoHEetWlZRNmnUB8I0fIb/J7ZwNpy6wr9B/x8JM3+L8KOhnkIF/3RDVNjtCtzAIVqJ7SN3afYqi7F5GS42v4MFtRIzXSa/VPVvRUJeBpMKL69WiikQ0DWNUtcaLOO0mQZQQ8v4gze22y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bIOutu3v; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYr8P83yzl0gL9jIsIX3gIONSdPYXxqBZGf/DdtwpROtH6HketfR7VmcEnrC+05S/HnRcZbiMUWivZDTOQ8RWcA+q8GFZAFmWYvFwmo5G0T5hEaebvVpN03uAw9/9QbidKY0SR18WZQuQn+sapPGIe7gzHV+d5tpXBRLqXppRS/rTojK4w8n+B0uxuhAK8ZsvxA95ALzyKY9eayyJRwSKNf6PP32Z1gPZuXN+j9vi6y+qy5mc9rI3/tIPNkyKEeM8QAKD2SOlFT2QNVS25nH3VCz8DVPVCbOA80CozxvoKU/VJnyaR5yeCHWc5T5R2PJuNxTEu+xgLPaxGZQuvbvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHjMlYV1Xd7SI0H9VZLbXO0y3ABJdi1SVlm7PBYJWYM=;
 b=MNdIBNbaOL3TNLurFvIDg6j+bFFsxaUgeDdrdWm0kfDws1ujQjxu1PMw5rRYRoCR9lyvvnay6U+u4ktRE2LIURxRNeOfBUZlcfgmPVb520EFnssA7Fmv4MkLrVsxxnL1UYmYQ4R8ntCp070HZKBOya604x8/9toD9icX6kG+QY9LJzwDlnhxCH4ER5RbWae0IPlEZC6yaJfNN9avLLkMnSo/5vMqzqJU9Mh00VrNdzwDcj4divT7NgXjiV7WFE4rTF3hDMpYtJIJgyaNeaVi/9AYGbB7Bat8oTkyZ9IplwX94ecTccjgWrU1L8YlPVlPT+fmOI/stgk+NAaJN9zGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHjMlYV1Xd7SI0H9VZLbXO0y3ABJdi1SVlm7PBYJWYM=;
 b=bIOutu3v0tvOhuZWLwQUOqnMZwZ6IgtKQoRFhKAi3W9FYRN3vNAVB4ymuCXZz6LjfNV4x7aXKF8s8ljwBOEHqOFnOv87gei9YfD4OeE+n4mF4S2nuBVMyoSqs12JNDEtfpa1074usxaZc44hW//DKGDQiN2AUEDRQbnp8G+YBnoMqksyBv9VkctSPeyrTrAWdzA/N5QPR9drcarJyVE4Bap5ML2OmeybP0p9cuaYm1GrGJCHAw92YrLUvaNCrEofBF77GQ5kXnqxTAFXW9V1fOlTHlzq1Qv1vl8myZ7k7QgSJnQdxLThXxDCw95No4wh+KGGAW39aw25Llk9mguY9A==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PAXPR04MB9280.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 09:14:11 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.010; Mon, 8 Jun 2026
 09:14:10 +0000
Date: Mon, 8 Jun 2026 12:14:07 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] dpaa2-switch: add support for LAG
 offload
Message-ID: <7qgoy4ksmvswiaikzjzgiribtglsftmu3nfzhyem2uom5va63s@w4ruzw4fzzba>
References: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
 <20260606021047.4124576-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606021047.4124576-1-kuba@kernel.org>
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7cd55f-304c-4b14-5edd-08dec53e4d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	lVjH3/psnf2oCtGy7Ro8DONYGdpEWMuqKUvPzwg2wRRCrZP6epd0wmqBbs5pNuX3JApkA9gmTFx8d5DsBe1Yp+ZUZhtJEOSgMtnrGHZ4S+1EAMitbRaAc789XSJy4Ffm4cIrPMY9HzP7zeTyZKr0s6SXHAbE9puSSOTR8pcDd9PS+zNnVBjG985YtHHsj5jyrHKttr/7MmgNL+KdTCkQmbl7raxdEKQnd14g1VpH7RhFFPwlw/EQqbnNdA/MAV5IjqDNtDJNcgb+pSUxPNCb09X/6FKMzxEebG+bjMVOImwKW5CRszrup3U5KAihzTaG3WALMrazY5XIZ30BGzwCviruy17OpmGVECwdkG6je2ChAXvd7bLC3Tc0/vCCk2mLQn6otpSLiMDpzn6BG2JSVBITVpeYr+jEOw+GnoBelI0fDdtqFM0vC2oIVDMZD1jWehjExsynB2dfhisqddiTbxcEaj2J4WMjAyxwMjRlaQM01fD9JGotOBpO9qVAg5IJ6RvqmJUQd1sHapiQhC1gpfQxkxLsrZFfR7wixRfzqlii4hVdjkTRcYnacok81+eBUzMvzVEIup1crl5moPN62YmyR4JjB7yAOD21C6LuxLVvYE0uZ6CF9P1ALeQ+D2sIlhkAr/tJTl9OWOXivHc11W9Bs/9LSbI09GFsFVDtNHdyFaP4Yz4VBpEowkUB8GiZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/aPv5tObAok2iQS9BaifriOciyQrZEpP75niBUobmfLk5qOUtHEDknbmbI7+?=
 =?us-ascii?Q?+zAyOfmn5Hh8upM8ahsYHel1jv8zI+rBsYDoIN8GrNN937PT0/Cou3A72+nm?=
 =?us-ascii?Q?a7daYqO5nuAr96Y7BfT1qiTReIf/skbzSGw5F7pFWX5mqgJglkpZ7GAoGrtf?=
 =?us-ascii?Q?UXQCDffzIulnuJ+kJN+aPldSPrEC+nxWzxZN0FOevLqERsWhruk0+crv9Jao?=
 =?us-ascii?Q?Fm3KjTmh2kcNlYCubjurMlAAN9G1i5iI1Z47pCmkE6kgbUQkwo028uuhubeV?=
 =?us-ascii?Q?PlBkFJCQZ8/ZunJmc85q7SJI5a9jplRL7WkwHozllsM9xaT5dqMUefb78/03?=
 =?us-ascii?Q?xAnfRjIMA1nza3EPgHRvOiKpWhXqBt2OvzVAd0kXQJJKsToSijZf1iLfHV3G?=
 =?us-ascii?Q?eXnUt123gJVSZTeF4QPiimVakyDrsNtTv5Um7gxcIELh034RsqMZckQG2bIP?=
 =?us-ascii?Q?5l/mr3OgGjmRgzxzNXlOR737D9eHxk8tKMqzh1oUOA+K3RVtMwpIN+a4CD27?=
 =?us-ascii?Q?0jEprVNYx1nkUH/xQoN+R63cgGbo1M8Hmq/h6GS1+utAdBpPdBvTVGjR/qXA?=
 =?us-ascii?Q?0ouFu1KzBtJ4MMuSc4WL5rom+d4zvg/G+kHcmvSKO/LLzEgKIBhlEoXhAMed?=
 =?us-ascii?Q?OR2z0C/bHsIuYbwY1xJDK9TL7QG8JQXDPE0ZbWvEYq00d47QFubcpjW4nO1U?=
 =?us-ascii?Q?G14sWzsEi2A4S+NuhFLUxCEtdj2uEWy9wOJwnp/26UaW4sCsGL/6U1Ccnb3z?=
 =?us-ascii?Q?89QSaBMyxy4qj8eFmS5YQjAHSV70CdhRPCETs0ic+Kll0uaMK/r0LajclQxw?=
 =?us-ascii?Q?RXE2su7ClMhwb7YePwRsqVgnXUs/XVoQUVmFWdl9m0MjIWZ0eHnLUlwqE62a?=
 =?us-ascii?Q?Kdg/alX/Z+aXQL8pcjYfSIjIk0uBAYaSGoo7meuhofTbS9FZHWaaTnOvuM8g?=
 =?us-ascii?Q?CZU7BCxK3/nyqKk8iI/0OAjaIps+AZPLIhEK0/qvvyiNRs8xRXSh9uEUmQnP?=
 =?us-ascii?Q?bcXy1G+81vh00a8NeVRWhpERPg5kFWmrWP9jGc9QVjYgJVbR8wOstX+f2fNp?=
 =?us-ascii?Q?5e8Rjb92YNtWTnZPt3jWiOIUFEQNkOtMio2AvMk8WFuDwCh8oQxLqcz9Y1ik?=
 =?us-ascii?Q?fJFQxPGeSdyEgfV7pUbubgJI+ZegvIvQI/IODTKL+gAOGD8kWbwQRap4jjnB?=
 =?us-ascii?Q?TFBAxfALaNm4NVSGfwh9XrgBa8sUczW06dT5Y92JwBEzx+wUmf8UKJb2IXOC?=
 =?us-ascii?Q?9QWBlomWFCcp/lQt88FT60e7Ib6fq8QjHXqsH7LmqG249Qadvj00Ocl6RqeB?=
 =?us-ascii?Q?TIXN7+mi8PbiKY/bGNwOQoSbQyimsq0sEPQiwIu69JQn3hHv6b+xG3yB7/5l?=
 =?us-ascii?Q?cVE2xDZGKOMoqfVhGv4w3O0E6PNgSOTEUMPcQ80YVwf3Ha9u5xb1cjGfcv4t?=
 =?us-ascii?Q?9n0zeWChN57CIqzG9CTnr3jiVIYinN9BghdQyUIfJ6EISb8lqQcByV2/ZF+K?=
 =?us-ascii?Q?rky7vNk4yLDya4vsbI1tJUofSGDEpo83wC/86qGphVMpkpnhfopiJiKCB+9D?=
 =?us-ascii?Q?Fqy4spf6BkGizhZ4gr0KCAJ/HICIBiNLBoaInKlALyg5Ny0dlx702WfFWfNh?=
 =?us-ascii?Q?1BFHq5zzulrS3fXX+MYUyov8lnfuoM+W2Rk5IH7ycfRtb9jKBZMuYreqHVzL?=
 =?us-ascii?Q?YICQ6/kgW0gk2PRBkIu8N1gRDdoDCR0eA2KRMylStgEyipvLLhEXg2QFk0nY?=
 =?us-ascii?Q?1euPtTO2Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7cd55f-304c-4b14-5edd-08dec53e4d2c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 09:14:10.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhT6Mubu3thUDizFAwxnAaIGKI+2LGXD4yzZeyFwu9IOsOIZmMvAoCccPEkRE8JcUJrlSJps+ZIcF2QiyRD6lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296430-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:from_mime,nxp.com:dkim,w4ruzw4fzzba:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D75B6548A2

On Fri, Jun 05, 2026 at 07:10:47PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> dpaa2-switch: add support for LAG offload
> 
> This patch adds the bulk of the changes needed in order to support
> offloading of an upper bond device.
> 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index a0bf5b50aae5f..d082ecf9b1252 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> 
> [ ... ]
> 
> > @@ -2210,19 +2300,275 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
> > +static int dpaa2_switch_port_bond_join(struct net_device *netdev,
> > +				       struct net_device *bond_dev,
> > +				       struct netdev_lag_upper_info *info,
> > +				       struct netlink_ext_ack *extack)
> > +{
> 
> [ ... ]
> 
> > +	/* If the bond device is a switch port, join the bridge as well */
> > +	bridge_dev = netdev_master_upper_dev_get(bond_dev);
> > +	if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
> > +		return 0;
> > +
> > +	err = dpaa2_switch_port_bridge_join(netdev, bridge_dev, extack);
> 
> [Severity: High]
> Should switchdev_bridge_port_offload() inside dpaa2_switch_port_bridge_join()
> receive the actual bridge port (the bond device) rather than the lower
> physical port?
> 
> For ports enslaved to a LAG, passing the lower physical port might cause
> switchdev to immediately abort the offload with -EINVAL, since the netdev
> is not directly enslaved to the bridge. I see this was addressed in a later
> commit adding a dpaa2_switch_port_to_bridge_port() helper.
> 
> [Severity: High]
> When a port joins a LAG that is already enslaved to a bridge, is there a risk
> of dpaa2_switch_port_set_fdb() corrupting the in_use flag of active FDBs?
> 
> Since the port first acquires the bond's shared FDB, and then
> dpaa2_switch_port_bridge_join() finds a port already using that same FDB,
> the code in dpaa2_switch_port_set_fdb() seems to lack a self-assignment
> check. This could mark the shared FDB as unused before reassigning it,
> allowing another standalone port to reallocate it. I note this was fixed in
> a later commit covering bond scenarios.
> 
> [Severity: High]
> Will dpaa2_switch_port_set_fdb() skip bonds when iterating through lower
> devices, breaking cross-LAG forwarding?
> 
> When a port joins a bridge, dpaa2_switch_port_set_fdb() uses a non-recursive
> iterator (netdev_for_each_lower_dev). If the other lower device is a bond,
> dpaa2_switch_port_dev_check() will return false, skipping nested ports and
> failing to share the hardware FDB. I note this was also fixed in a later
> commit.

As sashisko also notes, these concerns were all addressed in later
commits. After v1 I tried to reorder the patches in the hope that I
reduce the chance of this kind of feedback but the later commits use
structures / data put in place by this patch. This basically means that
reversing the order would not improve anything.

The only alternative is just to put everything in a single patch (FDB
management change, changeupper events for bond etc) but I don't think
that would make it easier to read.

Please let me know how I should proceed.

> 
> > +	if (err)
> > +		goto err_bridge_join;
> > +
> > +	return err;
> > +
> > +err_bridge_join:
> > +	dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
> > +err_vlan_add:
> > +err_lag_cfg:
> > +	rcu_assign_pointer(port_priv->lag, NULL);
> > +	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
> > +err_egress_flood:
> > +	if (port_priv->fdb != old_fdb) {
> > +		new_fdb = port_priv->fdb;
> > +
> > +		/* Explicitly move the port back into the old private FDB */
> > +		old_fdb->in_use = true;
> > +		old_fdb->bridge_dev = NULL;
> > +		port_priv->fdb = old_fdb;
> > +
> > +		/* Reprogram the bond FDB to no longer include this port */
> > +		dpaa2_switch_fdb_set_egress_flood(ethsw, new_fdb->fdb_id);
> 
> [Severity: High]
> Are we permanently leaking a hardware FDB resource in this error path?
> 
> If dpaa2_switch_port_bridge_join() fails, it will have allocated a new
> intermediate FDB and marked it in_use. The cleanup block here restores
> the original old_fdb, but does not appear to set new_fdb->in_use back to
> false. Repeated failures might exhaust the fixed number of FDBs.

No, this concern is not valid. The only case in which the FDB chances
when a port join a bond is when this is not the first dpaa2-switch port
to join that bond. In that case, the new FDB was already marked in_use
prior to this moment so that change does not need to be reverted since
even if this bond join fails, that FDB will still be in use for the
other ports under the bond.

> 
> > +	} else {
> > +		/* Same FDB means that this was the first port joining the
> > +		 * bond. Keep using the same FDB.
> > +		 */
> > +		old_fdb->bridge_dev = NULL;
> > +	}
> 
> [ ... ]
> 
> > +static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
> > +					struct net_device *bond_dev)
> > +{
> 
> [ ... ]
> 
> > +lag_cleanup:
> > +	/* Recreate the LAG configuration for the LAG group that we left. In
> > +	 * case any step failed, at least we free up a LAG resource.
> > +	 */
> > +	rcu_assign_pointer(port_priv->lag, NULL);
> > +	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);
> 
> [Severity: Critical]
> Could this trigger a kernel panic if lag is NULL on the rollback path?
> 
> If dpaa2_switch_port_bond_join() fails and sets port_priv->lag to NULL, a
> subsequent NETDEV_CHANGEUPPER rollback calls this function. The lag variable
> is initialized via rtnl_dereference(port_priv->lag), which would be NULL,
> leading to a dereference when accessing lag->id here.

From what I know, a failure in a bond join will not generate a
subsequent event with linking=false and the leave path only gets called
with a valid upper device.

Anyhow, I can add a defensive check for a NULL port_priv->lag pointer at
the start of this function.

> 
> > @@ -2263,6 +2627,80 @@ static int dpaa2_switch_port_changeupper(struct net_device *netdev,
> >  							     extack);
> >  		else
> >  			return dpaa2_switch_port_bridge_leave(netdev);
> 
> [Severity: High]
> Does calling dpaa2_switch_port_bridge_leave() wrongly split LAG member ports
> into isolated private FDBs?
> 
> When a LAG leaves a bridge, this is invoked for each member port. It will
> unconditionally call dpaa2_switch_port_set_fdb(port_priv, NULL), which forces
> the port to drop the shared FDB and isolates it from the other LAG members.
> I note this was also fixed in a later commit covering bond scenarios.

This is the same as above, concern addressed by a later commit.

Ioana

