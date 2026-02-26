Return-Path: <netdev+bounces-261478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEOBI+iBoGn6kQQAu9opvQ
	(envelope-from <netdev+bounces-261478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:24:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B711AC559
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84BCD321D296
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047642EEB9;
	Thu, 26 Feb 2026 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y6m+S96l"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12A427A03;
	Thu, 26 Feb 2026 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122788; cv=fail; b=lIIeQeVgVjTV95BZHgWcLvBGI9GWkSXNX828AVPyU0iq/d2f+JjKAlz2JX5DhU5Izwxbu/JT3ScelVl1Yq2m/gAB+vEJ0zo0PLJHDFq2NyHTmxPQKRKAdc/dWtUWoMrP4IyQWWE5YoRjNIBs5GmC0lVndVrr4IuPripmx8wyDA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122788; c=relaxed/simple;
	bh=86WqKd0w+3lG6wgy2LWrCUdkFHR1NCnqVZz9F2fQ5r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+Muj/ADbdCMhFN++pAvytb3IzQnY8IHCr78DfLHypeMeqNN/DJvc2qq9hJPE3JG4V5osc93s3bJvlmjyLYTEvKx/kYqKyXSUeh2z86mGoAwAcIKv4QSsI9HRD6/mzNqTXl4TuHVIzUN0/7ampqRSj8DHifgj3w+1RJCyATZPrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y6m+S96l; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWm+CvcFGGccL9OlW9nE1k9KHufhSTHc6goZXxVAC8p6MJVVdPxabfE78jGdS0OcuV7BoKSyeGV6qRfx2AjZAvkQwjZjSZ9MXsilBU8dueLRiQV3HSh+TVUJNWXJP3rpBreci5597MDjr/tGIBwir/EuRbV7pko890RG4UN4dWkUC2J8gnKmkI5I03tRdEJKjzL4LbWhx9hM64/tlsuy1t24awY9LHtSE3BuPnfekAjAN1n9qtXiLRHtb98Kmo2FMddLMdCsuYHBkbx5XYg0HgmMTC6G/gTlLIOvZhlc393quPsxVEav6IJWM6uBrJjdYdplMJvU9elI1yQNtHkr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClhX9GrjnxuWiV+Fxfs/S9pSXaS6aEAPt8VK4rEVOhc=;
 b=OG5zCEsnie7VN7zO1p4U9qde3J8mjC2ZPeyTE4hrdtUDuXA8H9yVpbTZhDWvPthcTfx4zpzTYY5mZ+wFe4xz0sGXZ39uewhIahE9ik4BiMHHPazZe0r6X/DuIfsbPGVHa7fxwpx+D/GeexZ8WKmTJ5IXf9KTP9tOLqsQu4P+YIjigzB76sPb8QGdji6GBs9ztw6e/wRIUV/WG00+xG6YLNt95Ch5cqaKp/ZPv9gRdccQSxjn1MCMuFWsTOXpVOuVZ+JYAqS5m4+QvG+3dGrvEDHd0Dxq+BampiCiXiNo2AG5E9Oki6DQ+u28Y9EBPGeCyWaHb1uBo9yz22lVQTuC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClhX9GrjnxuWiV+Fxfs/S9pSXaS6aEAPt8VK4rEVOhc=;
 b=Y6m+S96lHUKg7zn3B4bGv7YfFqs8Z+LL24B89L9YoGYVTdU32DYA/qf0uzdm3vRq2oCYSLgel6RRbaaoYhExM/dGO2qn8E970GGzmDnJJs/OtCCxGASqUbq+3TNkFW4NE85Ehj8GOCZ8wB9w+qgTNNdPO7IlhKhyGhzm+2c6D0ElqqNRFawWTWtkqiVcO+LiEgshTN00KSoTFk5eg9dySv87EB0Gq2subqJPsX1xYgdf+aGL9rxXGeCGVDc8spPOfoqrSQeOjYm39Y+CIazb/z/QwN+lz0XjoHQ0JI9Ee3VGIqbQHIPXlpcW7ijCmRs/DtTVQrbdJeag4TS96hb4/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 16:19:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 16:19:43 +0000
Date: Thu, 26 Feb 2026 18:19:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: haokexin@gmail.com, vadim.fedorenko@linux.dev, jacob.e.keller@intel.com,
	horms@kernel.org, basharath@couthit.com, parvathi@couthit.com,
	afd@ti.com, rogerq@kernel.org, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v4 1/2] net: ti: icssg-prueth: Add Frame
 Preemption MAC Merge support
Message-ID: <20260226161938.254et3fcosflufub@skbuf>
References: <20260224124803.3634808-1-m-malladi@ti.com>
 <20260224124803.3634808-1-m-malladi@ti.com>
 <20260224124803.3634808-2-m-malladi@ti.com>
 <20260224124803.3634808-2-m-malladi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224124803.3634808-2-m-malladi@ti.com>
 <20260224124803.3634808-2-m-malladi@ti.com>
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff0b8fd-2a4b-4827-982e-08de7552d962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|10070799003|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	bgRmnJHsXmRcTNMVzrDZnjTZ0cSyMueXp9QZzqz3TEx5TTBmX9G15HDUgP8HuVj1C6F0N1W+wvupjTqJiIlvFODV3rqXbaeHW+nJQ87GuPtVGZQ7krjT+VUgEfRDiFyILX+FDRwCF/TUGWpreimnfvKJ5szoLXDqAi2uInNdiw8y61LOpqduVHiAhKfnOvyuh719NBz2qMUWnXhpOg0Itv+rjnHGXX+vDSqs7mFArZF62ulAIGWupvjwx1kNBcC+cMMc1JroqvRPNvymgUlAaYFMeiYOF08PZLeBXXzVkvSTUEhVp3VNJN5OMjjKUok4+5Y/UoYe2xgEaHpp+rbW7PcUKiIfxyGCNB8HY+cNhJy2rseYyzXJX+0f7Y5zMF9JbjYF2gyvu2qTDNYpKIRP7nD2w+MY7tMzqUkv6g/FjZ8kokXJ1k/aD4vzkB6i0fEVlYxuP33Vlg5DaapH8JuQIuGfsNK9T99msB+7CPxgpXhdEilq3yKCd8+bRbEvb94k84gLV5PXS5myak3ktFzT2KaglFuJ/on8JVz2mzJu7EVy915qIkMLcKFbt/WYb/qS5R950rdTJ0AuIddUYwlTSkuXwdWPvx76/hhTb1i0QJX7+QaSVsFuYbtAz5PhE7L0Mr+LK829BncFu5dJORjOy+spuXBIqAjvBeQw8HQywpeiXa2THpTJnLCzKc07A0pg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(10070799003)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASP2CoLSsU4cRcC9lIaDRGDijjElkGDtOAZfGXQyRZ+u+Icrp3ex8+zem8Sg?=
 =?us-ascii?Q?qOlT/VrOhBOOMTC8IVwr0AX8rEPM5g/yZhuGHH2EgxV44pb2lty3y3KXI1vq?=
 =?us-ascii?Q?nCSU+LHjbSbGKEQCGIw1MGyudAyxYaRLaYJA9TeWZM+7Eb6tFD9xgvARbQUc?=
 =?us-ascii?Q?yrUHKL3zGco04PpCUwXL+7UpYFsj180HAZ07eCqRBAyumDRfeYBQdFTGLxnO?=
 =?us-ascii?Q?w4qTpmOux3yvCUx8eT3YQc3fQmYLBrA6fVWqo6MetX3sdg+R7G0Dpad9v3+4?=
 =?us-ascii?Q?3AskTSfjZ0kpnCFKEU2V1MrLs2OK5hwqGYqQgfQ0KiVG+DudFjNN2e45cASQ?=
 =?us-ascii?Q?76PgRKLv4Lv6OX9Iw0px9Eb6lJCNqOsDjjKtgaJF8D6V24tcxPNMDd6A3gJe?=
 =?us-ascii?Q?s+pO80eb7ypLCMwyyBGtTemqJmgPp4EUM7lQc138NLenNROs10HyCR6er8bc?=
 =?us-ascii?Q?fhp6B2zaUPx+PvCIEzfSWV4jTm2P52PYZyaU286b+/tjRQb/SfVU+lBkdmkt?=
 =?us-ascii?Q?xH+EJEvqdJmfEuJPiObbuUh+dBczuTIsABo2uHjL5dz9OgtEbyzL1tOlZEcS?=
 =?us-ascii?Q?l2NIvtPlOIJVl1lQkHZFnf5B7lrtNuBr1jNJFvUIgajBUrxhFwYWOvCdwfsU?=
 =?us-ascii?Q?LxHI9XrA8famq8NnsDQQMNfTw3v4kAdLBQPuufRdzPNtDyIBS8ZZuq64kxUj?=
 =?us-ascii?Q?hCKHQdMZQJ3SqIFMYvPc6gzOj/cOc6Y+FlJVKKxrLyRrLCteGGEDm/JGi/kq?=
 =?us-ascii?Q?hl/CQGhYNgbwHSwRm05LIbkC5IIJE5w4cpIBol8/rJweh1ffg57WY9mpryW9?=
 =?us-ascii?Q?6Mfx98U3Cu+MwH64+eigjWTomqqRiy7MIj+KsSGP3BuEGXBpXCoUkkY5yUOP?=
 =?us-ascii?Q?4irv23PMDC1QWbKHp1ZRYn1hJXmicYeBUeYvFpOqglLQ/5ZhKWijU86pb2Zm?=
 =?us-ascii?Q?j+XmFGocCZ4bjafqRwK72Ac1LaJbQarkea0guaW5CuS57FzRVrAyeEPaZz6+?=
 =?us-ascii?Q?2GMqgnpfy0bjKR0EQGL+aAsvUCwbFaGdj4bj8+V3LcOZ3o6xQzyBN/9ZYKzY?=
 =?us-ascii?Q?/W2Xoun8KvfC2d5vcq9mED1gPjIjlfUJOawcTTryxub/Zf/om1Gvse22AdFk?=
 =?us-ascii?Q?FofJ+bVKPQ3xSr3VWZ6e83RQ/AEc1t9A9YxKF2uXPPae7EWycsIZNP/lUQuO?=
 =?us-ascii?Q?xP1xpwrKRAJX0dGTQuy6w/NoTLZF206ZjPMut2qPnSjkRZleIVBhCZQaUvM5?=
 =?us-ascii?Q?DjPhVx92SzoKZkoC/lu2yUEfLI6FH8gbRXEqMNxlNzXIcR6af1JTur5GAUyM?=
 =?us-ascii?Q?9gnmBxjpiw9ZG583dtGSd1W5iWzUk2Oc8csDLdtUb/IPSGFc6TTA0Lz9YeQ9?=
 =?us-ascii?Q?sHXw7+oEyu6D3FFopBnYusr7x4RtkVifa+3ITrii7rUsoiSLuvpP/BUuUjk2?=
 =?us-ascii?Q?b1Mp7mpJlHPxefW+8R7GQCkCkaJ0YyRS5f6w17CMQ24EzfEBZjAQMvDftNOa?=
 =?us-ascii?Q?Tn7HGTUOABqGpWePeGEnufXkkeek0+vILdEIKMxicm/yzh6xj/k3vD52M42U?=
 =?us-ascii?Q?c95Jybvyriqu5u9BrFPqz+EhksnKvW4aP4hGeWWO0Z8AwuEnWeDJJwLqoMHa?=
 =?us-ascii?Q?9PmnW21smKy4hTihwK724kdi+cviG/YfrLjo/Gl7cHyFV51mncAY2RG6vNc5?=
 =?us-ascii?Q?8Ta3vrSnWFrrPjtFnyuHevsEfqTHEmq2z8Kb4qiXYtkRlGP1bvES4gncsOvm?=
 =?us-ascii?Q?EDflf/bQXhwDSH9vmNJ0r7mbk65FQkI/yZBureeohi/b0vwxpxpOpdQFrfVu?=
X-MS-Exchange-AntiSpam-MessageData-1: wzu3n6rdka3s+j5mNo8JCihFyfRgkNKAF9U=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff0b8fd-2a4b-4827-982e-08de7552d962
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:19:43.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZGmfbIS46JxvdVu4yNNL4ZT9ffM0HiDHK3eq3IWYuHMfvJYGqvQ5e0lABuDLmPyBYaiFXDOW7eRNBnKCBfGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-261478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,intel.com,kernel.org,couthit.com,ti.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:url,nxp.com:dkim]
X-Rspamd-Queue-Id: 04B711AC559
X-Rspamd-Action: no action

Hi Meghana,

On Tue, Feb 24, 2026 at 06:18:02PM +0530, Meghana Malladi wrote:
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..388dfcea426b
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
> +	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
> +	int prempt_mask = 0, i;
> +	u8 tc;
> +
> +	/* Configure the queues based on the preemptible tc map set by the user */
> +	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
> +		/* check if the tc is preemptive or not */
> +		if (preemptible_tcs & BIT(tc)) {
> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +				/* Set all the queues in this tc as preemptive queues */
> +				writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				prempt_mask &= ~BIT(i);
> +			}
> +		} else {
> +			/* Set all the queues in this tc as express queues */
> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				prempt_mask |= BIT(i);
> +			}
> +		}
> +		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
> +	}
> +	writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +}

Shouldn't the preemptible TCs be committed to hardware only if FPE is
active? The callers pay absolutely no regard to that.

> +
> +static void icssg_config_ietfpe(struct work_struct *work)
> +{
> +	struct prueth_qos_iet *iet =
> +		container_of(work, struct prueth_qos_iet, fpe_config_task);
> +	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
> +	bool enable = !!atomic_read(&iet->enable_fpe_config);
> +	int ret;
> +	u8 val;
> +
> +	if (!netif_running(iet->emac->ndev))
> +		return;
> +
> +	mutex_lock(&iet->fpe_lock);
> +
> +	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
> +	 * fpe_enabled is set to enable MM in Tx direction
> +	 */
> +	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
> +
> +	/* If FPE is to be enabled, first configure MAC Verify state
> +	 * machine in firmware as firmware kicks the Verify process
> +	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
> +	 * received.
> +	 */
> +	if (enable && iet->mac_verify_configure) {
> +		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
> +		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
> +		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
> +	}
> +
> +	/* Send command to enable FPE Tx side. Rx is always enabled */
> +	ret = icssg_set_port_state(iet->emac,
> +				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
> +					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
> +	if (ret) {
> +		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
> +			   str_enable_disable(enable));
> +		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
> +		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +		goto unlock;
> +	}
> +
> +	if (enable && iet->mac_verify_configure) {
> +		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, iet->verify_status,
> +					 (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED),
> +					 USEC_PER_MSEC, 5 * USEC_PER_SEC);

You are sleeping up to 5 seconds in the system_percpu_wq kernel-wide
workqueue, blocking the kernel from making any sort of progress with
other items in this workqueue. As include/linux/workqueue.h puts it:
"Don't queue works which can run for too long.".

I guess you should allocate a driver-private workqueue on which you can
sleep as much as you want. Or make the icssg_config_ietfpe task smarter,
to be stateful and reschedule itself until the PRE_EMPTION_VERIFY_STATUS
changes, or a timeout expires. But that's more complicated.

Side note: I had this question on my mind - all contexts from which you
call schedule_work(&iet->fpe_config_task) are sleepable, so why not just
invoke icssg_config_ietfpe() via a direct function call instead?
I guess that's why - it takes too long to reasonably wait for it from
call sites like ethtool, phylink etc. I would make sure this design
decision is part of the commit message.

But let's not lie to ourselves. Having a deferred fpe_config_task
creates its own problems which you are not handling well.

Consider:
- iet->tx_min_frag_size
- iet->verify_time_ms

Writer is emac_set_mm(), reader is icssg_config_ietfpe(). But the reader
can run concurrently with the writer. This means the reader can pick up
and send to firmware settings in an inconsistent state (old tx_min_frag_size
with new verify_time_ms). Configuration which was never requested by the user.

You have a mutex &iet->fpe_lock. Does it help? No.
You have an atomic &iet->enable_fpe_config. Does it help? Also no.

Please try to think of a synchronization pattern where the config
writer, emac_set_mm(), stops or otherwise blocks out the deferred reader
while it's making changes.

In addition, schedule_work() while the work is already scheduled will do
nothing. So if the fpe_config_task takes close to 5 seconds and the user
sends multiple ethtool --set-mm requests in that time, they will be
ignored or incorrectly processed.

Also, iet->fpe_active is problematic too. It has emac_get_mm(),
icssg_qos_link_up() and icssg_qos_link_down() as readers, and
icssg_config_ietfpe() as writer. But it's not obvious what the correct
access pattern is. These things rarely work correctly by chance :(

I'm sorry that I don't have more time to untangle everything and see
what would work best. As a result, the comments above are just "some"
observations. Please try to be more deliberate with the synchronization
procedures, explain them and I am more than happy to double-check their
sanity. It's just that not much effort seems to have been put into the
current proposal.

