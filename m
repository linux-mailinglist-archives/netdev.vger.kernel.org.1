Return-Path: <netdev+bounces-271527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YESkDE/bw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:55:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8EC325482
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66E7A307E7E4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0103806B5;
	Wed, 25 Mar 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n4klQAdB"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98F332919
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441215; cv=fail; b=m659Gc/JbOftyT7nFsqhTzpBvTVEzhDTMwJrCptOEbHMv17qtNyJKdbXnCIKlIv/xK4wD2dRpfjNQ5bKXZBtBYQdSCeEFdzK706jVzBlDz9ppf+TEhKGRAXudckxT+KigZ9CNv+4ASLyUqLqmNM7a7kw9A5MXD7Zfyl8jiC/+bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441215; c=relaxed/simple;
	bh=ilCO9aS2rnCwqpHXE1/QPQcLnw82h907srIWSOcakik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XdenK646QGPGYraINXXKgA/ND21QMNzpnoIy8xOZl55Bw3mrD0WMntC8IKs5xz3R/81g9i+aD4o/2s32MBEubPGr76RlMl4rmVucF4l3iNChZ0RNv9TWoon0D90gh6p3t4Te+Ffj2+Qw6i7i2Mvz3O3uSqw3fCwwBZ+z+pt5Hz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n4klQAdB; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGYEQpi3ql/Qifk8oyFi4u9011ZlZPQ8hY9TMcKK9ho3gTpGQgvNOhMvnpg5/3hZo4kK000Mb+DZVnQ1LFZ5ptTBEIg72Mxlkr1nMx5g6GBGXUEjR7nMvMstSeDtSX9cpBrM9IkOfKSRg4wxGKY5Sijk73ipikBIk7BmfDsOZNZRJW0vGgwjSahfsOqET7sb5rehEz8JfxyJ68robh7g61xmBTMR0aUuUT3skN/FApej6SBDIbgzLUbGO6AkOJ9mlfQdWim/q3zkc7na0Gc7L+ryubyiEhEoo7IFjDa44i3OJ7I9ioflmxeV13qLdmyQwYh5KLHEQJvpko3pEYJfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I1j9huL00K56z/kOJnpETjXl9Lc0aPUxuWBl0RVvW8=;
 b=WzAtEy7DFem1L64UzD+eafaaw2ZVDfqojiUzq9axU41oWjEBOlgBOvnBtKf+DdEzuXiIy0zcs6y7f/BbBJqE9ua48lpDuFahfbyTBsmOFfOd9dGmbb/hOe3fVE8UQgL2jajsh5D6EGx/GsH3M/4ZSrlTIozdW1JC7pZYVpfStm0vbkhnCz/HmD9DPm2tCeg44Lpy53efiK2ZIcK5uBKV86OMZqoE1ENCSMa9ZdSk4A9EVcYeqtN4iufjKcSe/dMNf+awY5PNMSm3dR0iZqA4WfZ9TMHYtPp3Mrpm6SJaFZYTpExhwRtSFoYxmG7HYAt1zEevBOwbBNASt4nCFF7mnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I1j9huL00K56z/kOJnpETjXl9Lc0aPUxuWBl0RVvW8=;
 b=n4klQAdBmXKXwFLWSCXXO00pEYc17d3w800WV8dhFjJIzusIligpRe3qvYYMuXI0I/mpisYekhV+a1E6KuUH3Q2yxVOvoMb+x5M8PTZ9ILGmvR/uZe0xBHZE6YGvXhlAoU1IMUzJv62I5guEUXMHvfrb5QeCxcuEZeDCl6CCmEdpT13k+RGWs4MxJff6IMOXbslw7B2pnRmmA87xh1RyuFsk2Z99nIqFE/zSi+mErto47iaTBCHdjILiIjoDEqVwLhGsiyykSDO/x89wWdvJ2wkBkQ3a77+3W2DDFcuZpY0/NXDU0R3gYXYXoflCiOeLu/tTc86mXvXKnSl8rkBqxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB12107.eurprd04.prod.outlook.com (2603:10a6:150:334::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:20:08 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 12:20:08 +0000
Date: Wed, 25 Mar 2026 14:20:05 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: ocp: fix resource freeing order
Message-ID: <20260325122005.jvis4ydmogfkrxl7@skbuf>
References: <20260325120510.34481-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325120510.34481-1-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB12107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3642ca1a-9162-45b5-9405-08de8a68daa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|1800799024|376014|18002099003|56012099003|7053199007|22082099003;
X-Microsoft-Antispam-Message-Info:
	8z/f504dG7RCiIBKvJEVsC9i8AdgMgC6d+tW/MDP4gl48yaAlrcXtosdww/baEnCUyk6Obx8QzLl7tYnEA9Qf9luq1xSGx8tTUEYLk19TZumbZ89GWIUSANuaaRsO6cbbmZEMd7vcc5Vh+EA8aGY5asjm3c2Tz6efbQu0Gghn2tx+IPacskOxf+EUC/G9HxsNCncPaRZ4nn38kBSd9Nr2Flzjn1Bg8rrShfjZ0XMvB1Pae1rUzU6bTTbfFKnOFkKr8dP6uwxWya6vFJQzkKdXags5YcEQho2FNvlP/006yS7jmgh9wD8yZHX0NfABnPsEeZaJto1zC/wMVXefYQOn6evnOqauY7q+h1GQnhz5bhUsEBnwM8y5HO+QTCfLv3YdhvtRZNlTT8zDDMONqFm3mUu0XN6dGxoU2wXv8VbqFCL8nhnHxDQG/I2VAQkJ1WhACZz65Z+zxBEtDd9N1gQGkzs/JC0ewijayFNbVG+EZcn7qAFfwTjEYXjWQPkxpoG9kvvb2B3n/3zMzA+9ZjrrIKC14oi2dnqGhK52QN3JuXcSoPrtBw539brr77EKI0MJFXJ38iX+OGHSOLfkukyLco13RAG1osGamRuncTbREUhQkHIvHJ/5LflpCYbClsHHsfv0klZvW5BS70a5k5CAjHft1DwyEnyqKtBe1FPerXBt1gOoFY9v7Pr97Xhc5/cEDolA/EkcMj5OT3f2olFoijiwjDM8iUFxTWIWy9UCgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(376014)(18002099003)(56012099003)(7053199007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IViUWvIKfOU+9hWtmL8hgQvSs7JrcrMcT9Fz/UEjGbUzvNYYJWXPgwUmAQJD?=
 =?us-ascii?Q?niaSONTU3N1c51D5v8bmP90ywsCFep4tDeoO9eRghi/1sh3C0KhihdwEdaMx?=
 =?us-ascii?Q?Hi6HYxYRzOlqa3EU91VmgYVf6gdNBcztKHLNp6vzi3kbj1nftf6afu83Au9J?=
 =?us-ascii?Q?6kxbx5pWlMwuOPCLKVzW7bd5jZHzo3RDpBLS1+lCXyU/wnDvKRd9UvKA8VOg?=
 =?us-ascii?Q?w9TROszcVtt5p6ooikRbFgOkjDz4nMDoqdSZxtJtwty1ZTAwqwN/+pFtc8RO?=
 =?us-ascii?Q?yFNFxMEczBtwPfN9xWdlrkgPOINDavKEQIvuqmX/ZBMc2wTRCWqevkWkmlYG?=
 =?us-ascii?Q?PIC+QN+cMZyDwiiapi+062ATJBB8uDlGi/zfqy5ZcIU4OIwh0xhZ7ID0hY5H?=
 =?us-ascii?Q?UvVHhqtsQ+wAOwOOcer+rDw7nsi6RjqnYsAbp1RLRYNMcQMx8MaO5a9rwyo9?=
 =?us-ascii?Q?SEDszwTcQDoO2mA+jbmSGgn6gYCzKTpwDt/9hDWaGY21tWFNeSUb0y2Sm744?=
 =?us-ascii?Q?RGMLP2GmPZGZXAp+wsdtOXxF1Yifp1QCr81qQ4rvvjqozQ0J0f6h+Mwbe2Xq?=
 =?us-ascii?Q?4p6woL8NI0zlWldU+/mLs56gQCOPIwiq3/mMZIeLz/C5U9CcW6YUraFqv3Xj?=
 =?us-ascii?Q?GqPn5+27omEM8KrmCzSDAEVyei8kwLZZ19C755cSt8Fms4AKWdJ61c+3q867?=
 =?us-ascii?Q?LRCj+6ZIIqpiJH52XNHVOpx5D9XHN00J4KOVz3/yF12QFb6/FPFP2UtQLa/g?=
 =?us-ascii?Q?Sajerw1tTVRS7tw5S10MIJq/9oaDULOhxnLnAw7EHVFOgFO/Z3rneoy1FRF+?=
 =?us-ascii?Q?L58IwfQXwcF1GfWNMDIbDTonb6BsUliAYrK0KVCXgTEF1bVBlD2fdFK9yGZu?=
 =?us-ascii?Q?jc4hNURoucK7/qoA0eG4PCUhfHo3zEIiiZ/FyHObFmdYaUCBBqyr21wiK2LV?=
 =?us-ascii?Q?C+WP6EDdXZTf+CLQKhluVkq1NPF//b27p9/nrMpFX3AK5lvGXCEUOcwln+VM?=
 =?us-ascii?Q?XfsHTgaNjVfQha4KYAww+fhbxFjMG3xznA9Qw/KbA3vquAmmGxW3mP6wkVC/?=
 =?us-ascii?Q?MzvaCanDscmJrBKpKRttCCJsL9AGECS3UGi1/G3w4Pemt97a18KVRtFTSvrN?=
 =?us-ascii?Q?dhgJeCRytWffi1PgyUODDyu1KN9AH7l77ftxBB/GAw8rquGEss+3WxEXlFJ3?=
 =?us-ascii?Q?56n3v19yoN8XnWksFFLKlDFcWHOtMapIZl72FkCQcXgpyfaY2woBM21FPVCZ?=
 =?us-ascii?Q?ERz6d2v+WOaQtAIeSxvrPhUJojAai7kU8avTkMsOrljz4aFWi+ShyN2KrlBu?=
 =?us-ascii?Q?DQORI4l4G/o0DlrFcIQN2AAT60cMxMYQ682cnqgtRIfTCyYXamTL6ADu/45c?=
 =?us-ascii?Q?Qxi5x6mBDAqr2B9F9OsTFkNgYgAweLwMuv/0dnwEemo4hofMwYwkZUvq0okF?=
 =?us-ascii?Q?dLNQWhpVUbSZYAmLm4H+WMSCObn5S/XD3gM2PdgHpgxKBV8IuSi9ZKxpM7Cn?=
 =?us-ascii?Q?8UjfTtPJlAK97YAuwpO9x5La1E+RnZry7wVOTEhvLDjrYl59c5yN4ZfTUgi9?=
 =?us-ascii?Q?+Hbr0TrdcKeLdQ3BZAGlms7Naw6sEL6eO8enI5FgJbC3An+qob5O1iXtm6k4?=
 =?us-ascii?Q?VWsYvzD5tSERMPvMJ44pGQybMbYcgMeV6XRNUTl2a9sHwVWuX3Zw3prxsnch?=
 =?us-ascii?Q?qKLueAwNi+19MuLfFRbbkp4Te7DHrwIlNnXGeXiU7e0/o/1+m54ouBkropE2?=
 =?us-ascii?Q?UIBRfI1MHgqSRARrKAuPlra5bKGgfj9/FmOuY0pFdxDPv8FM2cHkCn+COo9g?=
X-MS-Exchange-AntiSpam-MessageData-1: EUAgFdgfoowwXA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3642ca1a-9162-45b5-9405-08de8a68daa9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:20:08.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnAaihUElrN5mI/+GXvjFNQFa22KeDJ3glX0zXduLdz+L8vjwlGyMTSbf7c9LwcSmcBL+YukLv7LMIOrn5NYRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12107
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271527-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,redhat.com,armlinux.org.uk,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 2F8EC325482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 12:05:10PM +0000, Vadim Fedorenko wrote:
> Commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable
> events") added a call to ptp_disable_all_events() which changes the
> configuration of pins if they support EXTTS events. In ptp_ocp_detach()
> pins resources are freed before ptp_clock_unregister() and it leads to
> use-after-free during driver removal. Fix it by changing the order of
> free/unregister calls.
> 
> Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/ptp/ptp_ocp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index d88ab2f86b1b..16fd4804fc6a 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4558,6 +4558,9 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  	ptp_ocp_detach_sysfs(bp);
>  	ptp_ocp_attr_group_del(bp);
>  	timer_delete_sync(&bp->watchdog);
> +	if (bp->ptp)
> +		ptp_clock_unregister(bp->ptp);
> +	kfree(bp->ptp_info.pin_config);
>  	ptp_ocp_unregister_ext(bp->ts0);
>  	ptp_ocp_unregister_ext(bp->ts1);
>  	ptp_ocp_unregister_ext(bp->ts2);
> @@ -4575,9 +4578,6 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  		clk_hw_unregister_fixed_rate(bp->i2c_clk);
>  	if (bp->n_irqs)
>  		pci_free_irq_vectors(bp->pdev);
> -	if (bp->ptp)
> -		ptp_clock_unregister(bp->ptp);
> -	kfree(bp->ptp_info.pin_config);
>  	device_unregister(&bp->dev);
>  }
>  
> -- 
> 2.47.3
>

The code wasn't safe even before the patch, since user space could have
emitted a PTP ioctl that passed into the driver in between the
ptp_ocp_unregister_ext() calls and the subsequent ptp_clock_unregister()
call. It's just that the patch you blame made it more obvious.

