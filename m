Return-Path: <netdev+bounces-260552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAtFCia4nWmQRQQAu9opvQ
	(envelope-from <netdev+bounces-260552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:39:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AFE1887C3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC7863120396
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34537BE70;
	Tue, 24 Feb 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bq5WKyJL"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759A21771C;
	Tue, 24 Feb 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943517; cv=fail; b=EtEHByzeWD//qMwr7t9U099wzT2TnInOxcWqkBmNkLBidbNDfsNboOQwIdqUSRkNN9Qk4cIh2BDYcffNmAqDS+unucs/t/AmLVmBIj5GCJzaNvGmc+eCEBSH/3prOay0q7YkE//MFeSrvM2NYfmV/I/prysUBzlAWESAFJDI2Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943517; c=relaxed/simple;
	bh=cDmi0kMO5wt0rTCTg+/an8OdEJjIogB6Oex5jn7B34A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nt/V06qhuPl5wzsRVJ1GP6FLlJBAp6pgOX2LvHsdNPnEjJMe0feXgAckjelYUIFX+sBWvJXrpdxqDZ25yHZEYeTQ1scj3kr5MtBDQALh8a+q+yyEkGfID5yNoWj1P4XDEGHgClxbMV0kknER2L0GDqkzOm7O0aMbOTvB7iDzMtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bq5WKyJL; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thMqDEQI+6FZ+FgwT+aJu2n8Sh3mHig2IMa/AHtZyftJyCGzgkLrgoD97A4ZZdzAicNKPKv6Xmm9hA8FT6Jz/RGLybZfKtEOR7BRu6lkm0g0/bpoQgc1aAHpGyj/gzm57OlUWhXSQ26Dc8FIUH+hWiI6lpeeX6G+IBx6Pgz4v2vCsFQLx5reKnYDJNW2gmk6fRjLoqhstfl9JtVoUBrVTvL7VxoBrLM/Ne405TZd4AzhIWYz8JrCIX4JcPlqBs/RWpmqBF/DbBj4ReM+cqsOW32uTkVPs2laxQ1i1I2Taqj90jQ7+KZVwBq8Oh8/aW43G6eQtl2w4EbPKrCdjSdXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hzoYzXU8IwO9Bp5RcQeNj4ySm9ooP7ZLvFfIDQU9rY=;
 b=spsEDx0pSRR/ZjlYLPsIMBDgv3I7EHQadDPrWfPMJMBVR7psXMTEa1xil6FfzvYC9jiHLM2gJE8Ee4PqdqXUOqDJLSQY+tADY7SDoglsChrdqIbAjH6CYMBPzLresinz+B0mCSM8AKT4NF4yrMq5+Qt+LrEL6dxEroanZ+JDSsn2tCvzyNK4ulotvCmWv+uPc2oR+xfk0FxO0HEQp/RCG3+5gUV63K9MNST5/yhBgvGLNJNe4XUqI4DNL4NvBA00U2F9WxgSkBfe+nx0MCsLXTXrun4gEqIRI1zNPjns5zsR2Nv6dejREbbKx5hU05k4MlXZSHpraw4UJLINg/a3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hzoYzXU8IwO9Bp5RcQeNj4ySm9ooP7ZLvFfIDQU9rY=;
 b=Bq5WKyJLIR7SW10M6wzRik9YKfTCOMJxMORqt2g1Xw5zpzGVEPk25mIup6ZpGm7TR2We5icf4cd9HFyixsHLhFxpYXa5xiG9fBH/p7ronPP5oLPUWm+paNhsjmJ6zV8PVbw33PoPG8Lpq+w5dvRPZT/PFemIMYq6GWcfTCKR1h6m55B5hUBEW3uw6oV3YnjrR/Z7Mkw8HVSpiuPDkFqZ2v7eC1hDTkIjjqo5TTMeT0Hm2pA/54ZUMV1jRq+qX8ccG41ldCYaQ3nih9pmFFalzBn4TqNaRZudF71ySCWIhPC3D327YqiPZzmH1HOTMa1ELZjeR/4MnDbDs/Ny4zjakA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8569.eurprd04.prod.outlook.com (2603:10a6:20b:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:31:53 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:31:53 +0000
Date: Tue, 24 Feb 2026 16:31:48 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, 
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>
Subject: Re: [PATCH net-next v01 11/15] hinic3: Add ethtool statistic ops
Message-ID: <47h6jpycuuous3txer2ie2nr7azmhc4jmxwe3pkashqrdnsvwh@ldh3bg2v5pqz>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
 <c861b68abf0d876f29f819526383bac69714ba33.1771916043.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c861b68abf0d876f29f819526383bac69714ba33.1771916043.git.zhuyikai1@h-partners.com>
X-ClientProxiedBy: AS4PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::9) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 006693d5-3ad1-4601-37f6-08de73b17417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GBqGGPBJEXSKvCSLAU8rnThQ5dHjTCe+T4VaN5rQ1N18VBnLLGKpyOu17dy4?=
 =?us-ascii?Q?SuyBHpCVpW7dHe0V5xx/3xIVQnRYowfAPjUHk8AOexV11AyNZ3ngZm3oacTU?=
 =?us-ascii?Q?bdvTOCFNbEbiqiyeN+ZX/jTSIXFKYl/cC7ESD2gTI0Lu9m7d+3ostSQAXsaC?=
 =?us-ascii?Q?yTen/GWkBeb7eXfLmXnym7VjsXfyeTfryOGIhZZGAugzChi5P6Qsm5j/SwQT?=
 =?us-ascii?Q?Qiy0KlkVK8j6hmIOJ6VoItFwXU8rr8CWvepJ1r/bfvOXGjXiZZlztYqx1qLg?=
 =?us-ascii?Q?M9q5tP91XLus6buk50W47WOGj5DBm8JFkYlS3X+WPK0K0+XVG1z8pamSpnaU?=
 =?us-ascii?Q?eG6rg67dGTXb92J0esVxBF6gKZHddUfypoz4aIywu66Py6AHeKtKlveNw/nn?=
 =?us-ascii?Q?Ki4p+WbpAz2wh35m+m7CwayyFjfkHqqpN+IicKpdZ4dPuwBzaQnev+5YjfZu?=
 =?us-ascii?Q?RO8OQusmkMHm56atKzcMpyGeG85y24OiFqNY+ztDahxh2l21wN247MpxcqBx?=
 =?us-ascii?Q?5ap8GULQv/tWaeQ80JxHXIx44ptn7kdrFS6HTVYFi/py81FUE7R/Ve+D2nF4?=
 =?us-ascii?Q?nSTHXcxEinewANcyuTsMeEpIJGPue9/HA5CGAbKA/rg6ZsHe079WuoF4RWo+?=
 =?us-ascii?Q?+sn+Ntsf9jQbFIzK7DGfqK7r2rEe8EjFNjdCgb/VHhdVcTqGzKv2dHfNMwYv?=
 =?us-ascii?Q?oDG48bi8FVaP0u5U8IbzSE6pGhFnje0FE8kOkPxU/yA3pLynjoqS9nQgX29D?=
 =?us-ascii?Q?jqTrW7IeTYgHt5CFDgOV+WPQXhsgvFz38p5dX3FGauCecfBZOs2r1eBoiy9l?=
 =?us-ascii?Q?zlLM89fD2HHUVX48sZA2vNE/Dg4j8xyKsSMIvY7Dx4WOjbMBW6oMO8+OcgqH?=
 =?us-ascii?Q?VzZDovpFPNnejSBcEv7dHqJjN4WLuvLlxYuc5sztsmwUT1pq5zO7Oo+6+bGt?=
 =?us-ascii?Q?H62wwq8Cehe2bvKtkg7v9lDoc4j+k/XzrG20drJm2xU+bPQ5VTLbfhb39tvW?=
 =?us-ascii?Q?Fg6zzM3YRjU2qYROasjgaBRZtfUR5ZvnA4sU79VqYLhARFj/d9HRicheL6m5?=
 =?us-ascii?Q?P2O4nBF8SfdniNdQxeCZYBlT5eU+DIlcXv2+19AcfCyqnVJ9QgoTPr7UhjKb?=
 =?us-ascii?Q?+MYDy3HAavE/f+hTY7wwYvEwUhLhX7fVFYoTBUpdgee63g9m2LjlTsyxWGZO?=
 =?us-ascii?Q?xyKhADYzJmjVydc5nF/Gfco2fQPH3dmHd7BZUs03eBPRNuH1sieFElVqsb12?=
 =?us-ascii?Q?N+MXbZgBiejVVc52f29dAQSDwtjSaGVwHGpNfybe2Xg+v87dXRD11gf01wwC?=
 =?us-ascii?Q?z3lclMYTY5/L4+tHnlOC2i8N4SqElruKsx/b5UjqVjDn/m3SB0hPrBb+4Us4?=
 =?us-ascii?Q?Yj4jGYaPNUdqgITS+Gw9Wxb+y4t9Efzd5zyw+0GQ+yUim8Q8ddar76ADZQOU?=
 =?us-ascii?Q?MOF/PtUEnqXO4qMbwIRVCOWJjjl73fXgmOEzA1VggO1enhxsRsEsQs/JcP/F?=
 =?us-ascii?Q?CFz5JmK2BXuu/QQobDGWvxcHGcSwHnLM0nxeAY3GZ4RAjrXd32JAq+chUk65?=
 =?us-ascii?Q?bxc8ZU3ocwb6z7c7Iuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n5f0oyZnn6G4g95cGWnY1vKKYnrU0gViRt6r2MkGgG/HSncisUg5XPXw8GFv?=
 =?us-ascii?Q?R6JSSCvEWOiR2MYMHU1kZlL1LRulvp7q38L8RpJMyLOGNcHd5rCoYXV2gSl1?=
 =?us-ascii?Q?L6OKcU9XA4q9YDdsyKGHlAAA8u463f2OnMzawBiRNj7iOZWkyc+E5cUI9LJx?=
 =?us-ascii?Q?3B7CMMoQL7UguXhYto1R/FWZbR7YCfzwW2Qva8Nn345XAOZ3lTyqICLW2Q8R?=
 =?us-ascii?Q?5BpY6kOeZaBM3+vdm2lHlSx+7BQCHPpp7WJpOlUbKTsk8qvLF2emQ70k7cOs?=
 =?us-ascii?Q?Vbw49hkdeJ1hJAo/F1+92DNhnOw3Y7m/EV/hAFD5jloBfp1EePqNv3OpAUXW?=
 =?us-ascii?Q?3McUlkHJKNb7bwGg4NwQTzzeN0Jq1b1/Qvq79kX3zB6zkvplfPkXdEBtbwFO?=
 =?us-ascii?Q?Mgh0BVQUXkCGpsG/z9ttiXClq2RnLr5RpOfM8RShOWMZL5j7TL6FQEMHMBd/?=
 =?us-ascii?Q?TlqllMvMmP6wCcuFFkuWKJm2lt995/wWwPAb6ui/HU8uLKTYnR++NmsTkrSt?=
 =?us-ascii?Q?D4dNxhllk13VQr6SG7ULXCRwC1Juj1HxfcXRT/j4fTm+fPol7GCYLnPSDiM1?=
 =?us-ascii?Q?MfKbADVQS7NDEuASieW99N4llbE62r6hGO9GlVOaNM3BF/Jz3QVZnECrZowb?=
 =?us-ascii?Q?pyN51sfPBzDVU2ffbDDbcQoUv7XPzzEK7o5d+EEtFiAKohKIGRi9t6Owc/JN?=
 =?us-ascii?Q?MQ8nncsKyR7KaxDduykm+tuWusMxovLIUKjR/qb98qksLMV4qd3AhHoVMQ/7?=
 =?us-ascii?Q?ZxDwEBg0tgdO53t82cAXHE2V8b7FamXxrk6PY8Y3v/hgHZHwamU9ifwCG+yA?=
 =?us-ascii?Q?NDMpa1ZhVfP9QxY4ZwjASqXx3zwVgFh4gP3N1sgpc/yiX1IR0i+wsce1pR4Q?=
 =?us-ascii?Q?gJJF7tr4+tNDBq/SzbrK+eWUOrrNmXXv7yUPh1D3tcTzh+2o4C05HVUN9779?=
 =?us-ascii?Q?0qOHMohssGE5HbuQcsc7KjDtFnIc578NqAdtn1dOi/qF0FQ7hvH46aiPJ4VC?=
 =?us-ascii?Q?yin1VNq9w4gVhVUdkvAndOGZQMm4ItW58kfUg3+kjFe3JtitNs+4ftTL1NLG?=
 =?us-ascii?Q?x5uC5enll/7HAKXRsLtjJGXlQVTsOIGz4AQB8rR5p2DG7AKacWdPv5j4Y46D?=
 =?us-ascii?Q?eVPWTf0DUd1OL5qE1ypkwgZ9/ahyarL3v2diuNXKG0SEXi7lDo+na0kg/lnf?=
 =?us-ascii?Q?2Age7BtJlwWV3vdYvqFNSAYxgvjOLa3+jFyknNStFMYQ6nJOfKpfb71CmS9k?=
 =?us-ascii?Q?uPSze9L2fysQ9exiR7YLHsoPPhMUzbZ78iWFRwHW4lVpixC6yYoTX1u/WWjf?=
 =?us-ascii?Q?teWCCFW3PHgaf4RPjU6MXyWQGLbUgHRzcjKBIHhL4g/QyjhP+wvTIh8DYhkl?=
 =?us-ascii?Q?lhsRgAbUBo3u3Sa4mhnbAsZSjpapc/b/JurSRof3+6UyKV8hySyEiOErrbFV?=
 =?us-ascii?Q?7wZIT5erC2+t73J+MAvXZtp8SnXwWpVAsha8ELDERsAcHRUaKAmo+iMlyReg?=
 =?us-ascii?Q?98zW5UDd+s17Y/1ny03mtrRUZGl58R4NQBMXLQJe4Ti/JsAkZQ9vjVDBDlwS?=
 =?us-ascii?Q?SPqWYDcMZ7toVSrYnrge4mvYzTC3o4GuxQUI7wAV93R0Q33p6QHLRQZAjuEd?=
 =?us-ascii?Q?oyfy8jIGa43K0K8spvkXyRisd3JhAyHP0eR8nSsHSGTJDcDB1yhGNJTJzdnk?=
 =?us-ascii?Q?YSE7fEWPa/TTAVk3H3pVFbcbdfbGL+EHxzw+KJqmP3wsgjy9OHQf0qquJeEP?=
 =?us-ascii?Q?iw9B62F1gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006693d5-3ad1-4601-37f6-08de73b17417
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:31:52.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbW9qenj84Ep2OpXPovAeiMiMd6RDx3mxYcd4Ec2+wWx77Zf6dyvdHbJ+lunaiJchEwPA6AI+8XpjGb5gQIwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8569
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260552-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 47AFE1887C3
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:15:48PM +0800, Fan Gong wrote:
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>  .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 414 ++++++++++++++++++
>  .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  13 +-
>  .../huawei/hinic3/hinic3_mgmt_interface.h     |  37 ++
>  .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 +++
>  .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 109 +++++
>  .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  15 +
>  .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  58 ++-
>  .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  14 +
>  .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  72 ++-
>  .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   2 +
>  10 files changed, 789 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index d155d8c533c7..ea0b2df73e9f 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c

(...)

> +
> +static struct hinic3_stats hinic3_port_stats[] = {
> +	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_undersize_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_undermin_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_64_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_65_127_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_128_255_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_256_511_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_512_1023_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_1024_1518_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_1519_2047_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_2048_4095_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_4096_8191_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_8192_9216_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_9217_12287_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_12288_16383_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_1519_max_bad_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_1519_max_good_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_oversize_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_jabber_pkt_num),

These look like rmon statistics that should be exported through the
ethtool .get_rmon_stats() callback.

> +	HINIC3_PORT_STAT(mac_tx_bad_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_bad_oct_num),
> +	HINIC3_PORT_STAT(mac_tx_good_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_good_oct_num),
> +	HINIC3_PORT_STAT(mac_tx_total_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_total_oct_num),
> +	HINIC3_PORT_STAT(mac_tx_uni_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_multi_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_broad_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pause_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri0_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri1_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri2_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri3_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri4_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri5_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri6_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_pfc_pri7_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_control_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_err_all_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_from_app_good_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_from_app_bad_pkt_num),

Please have a look also at the following ethtool callbacks and see if
you can export any other counters through the standardized method.

 * @get_pause_stats: Report pause frame statistics. Drivers must not zero
 *	statistics which they don't report. The stats structure is initialized
 *	to ETHTOOL_STAT_NOT_SET indicating driver does not report statistics.
 * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
 * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
 * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.

Ioana

