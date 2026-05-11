Return-Path: <netdev+bounces-286716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJXEEQ36AWrjmwEAu9opvQ
	(envelope-from <netdev+bounces-286716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:47:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BB5117E8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD1B130690CD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C80402B81;
	Mon, 11 May 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="diMurB5X"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D13FBEAC;
	Mon, 11 May 2026 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514093; cv=fail; b=eQgB9YUhWiQYo8LlqFjpw8+84xbWwl2TNchI+EGmGdgy2JdHUuiB5Q24Qan7ZULI3jigGPI+ehAz7aPGCS4cX6Yvp/x7UCn+FuY4+z9kzzORhQZ9a0vjKhpMCOb0zaDdNtCvM5SR+gOvXDehUqsssa0y6tVDZmDNbnxjzGb/V3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514093; c=relaxed/simple;
	bh=2qfUzkmbxJ8qUThZTKlJF73Py0qoaFYzV0gRK4JzGo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUK1VKJbtpKXS1WCZdSVAcNGKxV7UPx1lsThn6bd0CLrB7XpAuSZo+KrfzWI40cpZCcJo9IDnVh4JJ9RlzLbmqHZ8LQvWBXa/7+PUQSOHuxcAe8GuyZxYhFuzsesd1i+7mzJT9e3oDo6eFHapgkeJnR5cK/3Jrh2B11akFkN9ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=diMurB5X; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDtNIroPrNcCmLGm70AGuASUJ52BBsecXtYCGjO+3bXI146weTDzjMdRw2s15VpwFWoDjqF3RmChvyr2zFA6t4krvNUqQ9bvlVc2/3lgttlJ/Oj0L2KuLGo8zRTZ+EaN87nsdMLcHX2W881U7hIZmelkuCg9ZI3s0wz63ymm01jpyCpNcvx0doxS4batjq4EfMrOIpgBSFS1vxWBE2NFeJOjoGkHY1heTl10Dy9vtHYcLFvo/JUPJCKONr8zE+6lCcsO6OBdYIE5ewSTCUtUnG8hKfQT9JSoB1dIvYvDExlP+jajOVKRzACP7Zh03xipwVcjQEYMpRpfKde+rB8JHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZvhWQcxiN67Mum8yUuWRNxteR8JlYKvMtOimqiEFBM=;
 b=FXT6VW1Qo4M2N5DLUc/LIDQwWjJrNzEWtARPa4MswEXZ2yv/1Y1xIr+qu8t4HDd498jihjEatTjvF8LxUuSYjVZmGjKe6Twvjzoudrp4mm4b3gmOXpufZqT8/wj5qLo1q5aCQLoYZbJViyIQEhFzqj8kgGpmYoeQrJDaXX0aNDPDhjvNOSNfJ6uNr6SMzbUiDEKml85HQdbcxyn9nbwhoWJfJTSq9e3kgWEo8apf4iBj/riFVRNXs3IZlSAbduEOiOU7OYQk1ZLExchgSwlZpATSGNcUYtnz+7pviqZsFBmFBWv4rzrC+Sz+5wM4yk8qGuLXDTQRPmuDiMIge8k+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZvhWQcxiN67Mum8yUuWRNxteR8JlYKvMtOimqiEFBM=;
 b=diMurB5XtrTFv2FjlhKse3deAO9JMTkxOgj/2zMonMhu/sy6xp7g4ceb+i9syMiLSLZy5pOs2lga4Ly0sgI/nHzt7Gaxg+ckTW27WwgpYsrCwHSTG+0Dy66MC6i/ogQT6mg076ryYUQLD9cuHd2sLfa5OLT0ygLMjzdUXIfiFE6N7aiRiUKMRrOkYSwWOTiU0I7Qp2vtmr4wtgIbNW8rg2QFu0j1liWFMD1p5p08I/7JDoNb2EybIZZia1xtzOv+2DXJh/E3tBZOZMxocyOMgUoMvToYF3G9jIG1BvuMnIJr5A746BF2BiGVB1SG2F5EBQQqqeGBDsBcLSfdc75hQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB10937.eurprd04.prod.outlook.com (2603:10a6:102:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:41:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 15:41:28 +0000
Date: Mon, 11 May 2026 18:41:24 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/15] net: enetc: switch VF primary MAC setter
 to PF ops for commonization
Message-ID: <20260511154124.u77vbojcyhic27d3@skbuf>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
 <20260511080805.2052495-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511080805.2052495-2-wei.fang@nxp.com>
X-ClientProxiedBy: WA1PEPF00005B95.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::632) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB10937:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ddd0e6-6562-4d60-62d4-08deaf73c455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|10070799003|18002099003|22082099003|11063799003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	96tkRd3pJA50N93nNkEBmpceuzmyPJ0hlUE+JtyRsnznEqcGdmkiKzwLqh8u3zdkLSRSptMLEmcFeSMNBfDDSl84rOCokDY9QQYYrVRUQvUlTOl0d6m05WrGJ8DSWh96fmD+ooGJqK/yq4qwUvkl59G8XyORLhv8LCsEvCVRE5mbvUPN60PqnOQteIrFA3yzCWBF/hgLGU8VK7c1Od+rbhmUWAZtkfOCaR3cTx8LQ2ghXFtXk0GAv30Jri23Lwcl3yuGCm09fZX4g3AQSy/KPsIg7kaJkW3rG3R3LpkbMeoKUdldXv9jFO0Uo5rW61LJk8B5y60Fs4I6HdUsMP/MkQeclYH+gbiPcn9dHPO3jajpe6welM6m4+n2BHXmaoZWEfnqZO39/oL1nEQ8ZEq5A1Gts9wHtVXnAntrRKok6PWozQaYHa7nm4sXvzDVz6h6rKcj39GvwGCWBEWcL8B9W2a4IMF82RTEzhUVyEJCyGpzzLwa9yIyFzt6gr8R2KcK7FuGlCvv26BuQuhsxxSpDVFjK8Vt92QwPLjlql376EBS0Zu2Gjz5QHoeoJBVyMEUPzuU95FVNlnZOUxwdXvWLZ7QsVVAQbDRnikLDVji3ne7xLPEEMLxlOwsqpggHpjZv/5Bp1X8zZhf7eHb6dHwlF90tUfrYk6eQ9NwU9nbZVuSl2yp+b5gDGqp5zOZhTUj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(11063799003)(3023799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HWGaeBrkSm/XqFUM0AiC2bvUFf81184a2yf9kaI4Q79GaZv1lcyACdGHVm5V?=
 =?us-ascii?Q?FGpmoF6cQnO7U4c9X0DOAeohAheBcNqyAKd7KN22NID75Wx0VK6BKH8p4zdd?=
 =?us-ascii?Q?TLZT/iUleZK2jphgHxCx+oA6oefxliPINsiyye/YDcFkzC5+U91wstSBZ9OG?=
 =?us-ascii?Q?sD4oXLBvaKxSXBjujvSZXxirxL5UDqAg7k7/LJN2QpBMbCVDoX5mdM32v4Fi?=
 =?us-ascii?Q?/ykwX9t+S5nKFwgLLvb1o/4TYoGOLBX14kS8NP2n9/JVzKzIdWTsmnike3fi?=
 =?us-ascii?Q?HuUTfJXnE+mIKcVRHrPpcK8vJe6sobl7h226Q5JvE0YwX/p6oD0qyRdJtBeM?=
 =?us-ascii?Q?MDzVa33/QlkFFRomsRadMNVC04wL7wpQdDcqXS5PDIK4G6WqZV40LURB0D+h?=
 =?us-ascii?Q?Qxw3zI1mDnlz8+VGoQmz0zYspngjVLxK0PUF+nh0FJaNxZIfVCn4N8wkZWUc?=
 =?us-ascii?Q?nzWdNicS3C6BST26VE6Pz6iBXxj/AvGWMuFayHOjVbPZgoSxhgardGGxnLdh?=
 =?us-ascii?Q?4dB9LjvI1f4e0A7fFp8m1VX9mZeLP237VDWdb8T2Fiy6JE7P1DA8YZ74v9d2?=
 =?us-ascii?Q?luh1e8lspQ5pF0Hj6EcPaCc4fRpGE0eRit3YgnSmpr37LhMI19I26ubli4ph?=
 =?us-ascii?Q?HZosVx/k3+BqqybE+tKZ9bjihUUpFOzE75CUZGdaE6ZehgwSzTPb0egpvmVr?=
 =?us-ascii?Q?iZoOEM6B01ejrAeE9NIT7lgeeNQjFPiaaRr1PV251mwQeJzmMo74tp1tH+ox?=
 =?us-ascii?Q?bdW94ek9aTaDPQ8tq8D3ATGenJAoy3hrA8Y04Dh02n0OnGVhD0/LEpSMPsQm?=
 =?us-ascii?Q?vahNblDUL2Kb2ewAuv47V/T1KlNzPdxH0L5Ts4B5pEnp+BLC5i4Pk2E0YAXL?=
 =?us-ascii?Q?TabJ+ECM6Qm/DKm1G26+D5r9vvbqpevq99e24UtdV0sHVCFcGspYRchASkuV?=
 =?us-ascii?Q?BdLOZvLMr04pl991Zm+vNTayEU7vjBaSAdKyzBDd9jbG89Mwd3bt6BzdYjHU?=
 =?us-ascii?Q?imMAMW8ST6R7mVOcQ3qZJMPlnDWMy3rCfSGXlma7ysNl45elL9zKDUVYLiiA?=
 =?us-ascii?Q?GZdMhRL8f02o9eBMQ2Y2An2oci3FuLS6Z6axl3D6Omx43qJhCoxSIAeIvOsJ?=
 =?us-ascii?Q?HXpT9E2LZwOwf79x6mw+CVmLWSPxfwsR9ZIep0JHCZ0gLdLBWWR5PALrXTW1?=
 =?us-ascii?Q?zh+N39nacsyX2pfIctpO94b7aGAH7K14vOQzbHEPVS8KxjQJnrHncwMMhT9R?=
 =?us-ascii?Q?GZRTdhP06Cu57cELSSrczGau42BMeRGMaDfh1oaCkvc9T58CQlPJHVCT5H7f?=
 =?us-ascii?Q?4qd/7vVin8ceDQj4mSRG9i6gJOziNeopAChX1soTN4kT8DX3eCFRnRMh58n4?=
 =?us-ascii?Q?0EP6CGKJ2tCB6T31JeYcFLYyY/ZRxTgwEwiCHWyH2sHe3YrUqkZsgHVhEdpB?=
 =?us-ascii?Q?8Ak/W5uvk6CtirRbQ/XHpTaDotJF6WcODcFhks5W25UTjUj5OCn3AQxLTlYN?=
 =?us-ascii?Q?DrTVu/yo9YzIvoAOUmja+FRlU6fpY1XmASF3r7OHEy6g0+sipkLrVYnNt5W8?=
 =?us-ascii?Q?V2vk7Td4z2zeUY3VYMsS+lHua7FYvov9M4tWE3Puwv7RJmwkVAAF4xDmImWX?=
 =?us-ascii?Q?GBVNIwwXUlmv5Jt3VqHS1+InaV4FW9Tr6dVeqG3HdimJRKWJezvzotYm/V2b?=
 =?us-ascii?Q?MduiIEdb+QaiJFwvTUYe+VGlO4wTGPzMxyUr6caQbEQAYdxUyyimJL0nXyl/?=
 =?us-ascii?Q?r87wcdPhrj/o5apN3TmZRDwekA2RfdMiDKt3zv+hzJLigpapJVfgtrzyx+MS?=
X-MS-Exchange-AntiSpam-MessageData-1: 6A1qwyeGSiLxTkIR50U+D9Mo7D+kmFuOulw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ddd0e6-6562-4d60-62d4-08deaf73c455
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:41:28.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCHk/2fmZbJ+LzlhTD0zt/DRdo3IGHsp/lK8KB/IG5CV6F30YJO4wKkFoGUsoLZcYsAGprHEAixt5qNFptAlfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10937
X-Rspamd-Queue-Id: DA3BB5117E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:07:51PM +0800, Wei Fang wrote:
> Use pf->ops->set_si_primary_mac() instead of direct call to
> enetc_pf_set_primary_mac_addr() in preparation for moving
> enetc_msg_pf_set_vf_primary_mac_addr() to enetc-pf-common.
> 
> This enables both ENETC v1 and v4 PF drivers to share the VF MAC
> configuration interface. No functional change.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index a12fd54a475f..9063255d8ca5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -497,7 +497,7 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
>  		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
>  			 vf_id);
>  	else
> -		enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
> +		pf->ops->set_si_primary_mac(&pf->si->hw, vf_id + 1, addr);

Doesn't enetc_set_si_hw_addr() exist as a wrapper around
pf->ops->set_si_primary_mac()?

>  
>  	return ENETC_MSG_CMD_STATUS_OK;
>  }
> -- 
> 2.34.1
>

