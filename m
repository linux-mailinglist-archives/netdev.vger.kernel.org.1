Return-Path: <netdev+bounces-143573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873EE9C3118
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 07:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F7D281A57
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FD14884D;
	Sun, 10 Nov 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="le5b//7U"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF1233D62
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731221621; cv=fail; b=YFQ6a2xfixeu+CliYqVlpmYmzOj7EBl1H2gt3jT4AVOyOzbTijGAcWlSqcEsUabjRb9mWlRqiOK/3onag6Y++LAwpAqCyOsCTpLRvixeZsiUgyUjt/uu1LeqWCfoc38yrdGX+sHaoD7OQPqtUCNlWWJf2U6rei5oizdCOIuvUCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731221621; c=relaxed/simple;
	bh=r86uZxOPaHcskQHYPyYZxHP93FnqNg+htp71nzeIKQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REEFB9xMcb1cIkFVJh8N7veIUCfOkZR4NA6GJZdYdgWRLOsWnn+ctLXIWh/itmZPf2azsC+9HWUASrVbe2EBu/n7CxyFalGzWcy9v3/BFRwdRsNQhFar4a4Jsh621f5B68lQHZePqT/9kyoXuwN/bbfuRP+jrpNl21rp5WKvC4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=le5b//7U; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A27E3341007
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 06:53:32 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02lp2232.outbound.protection.outlook.com [104.47.11.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D54481C005D;
	Sun, 10 Nov 2024 06:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GK/iKxmPJimmwFTD9+ZV172Flhy6CqIUjKZFnZkvLL5Mqp1ydRDU2ShY+L2xsJWVbJIaOrG7BLdme906/7pHv3sziIlKLU8oZD/EXuXK6aWaFBa78EsSZvT3V0Dkn0A0vf8YvDDdOSIKStqgo0Dj9yI8kb9hjYKdTpnDnStC9WmTqiJvSsrAvPFMiQ3y0IO7qbwiaz9wL+DDbAB6jciper/4N4/oRQOxEK0gJAn7FgJpHsmtspFX6aW2Q1Sl1HeuMiwORqkN+XeVwPv+OLI/1oXzgixLAOgiMz4zgEOlFWzU8Qcf4A3hR/YSO8phffvBlu28gX2ETqVOIsFoKfuxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0puXYqkxAi7cYNBIeKPpMnqIg6dXOx3wceRABhRvGg=;
 b=KvauYcfwmqGFgONb4/MnmAHLNb35YjgetfZn2/eFFEByTD+n+hqE53NMhFm7ktwirCNMgkrIb9somQMvV7UTIrbgSxEDLdimPDwwQKaQZBTATKE62waPqTVeUsDsREGtCKeNq6ie+W8M2ksUu5cvOFwvi46mP+TChpQrcYdW05Blc+Z8AAUnh5k211yz/4GAkiGOSGuGIrRd5vWZ/h1SPkAf6zK12+XB6TVb+SU9qC0ddyb5VMiuOkjr4v+LND2hmLnpMPCGHL+tFSUTMmP9phEHlvOVY/4p2NZjICD88OWdoXEApdDJ+9DxfOnllxUsXqZSZ99/zT0oTUhSdcvUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0puXYqkxAi7cYNBIeKPpMnqIg6dXOx3wceRABhRvGg=;
 b=le5b//7UBib3kBm3w3VKdOowcjqqYLDKjfYerWOADCqEQg2HObrl5+U72ou/eoeNdYpTnVjkUZX2Kf7X+JBm67BHxbu2DEl5wXP2DvYn6o+yTY2XAUJVnEJqOK7qjr9vjVY9ul/PiqBnbrSTN+s/Qyfvt2XaT/kcM3af0XLE89k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DBBPR08MB6172.eurprd08.prod.outlook.com (2603:10a6:10:1f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sun, 10 Nov
 2024 06:53:22 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 06:53:22 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: vadim.fedorenko@linux.dev
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	gnaaman@drivenets.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
Date: Sun, 10 Nov 2024 06:53:09 +0000
Message-Id: <20241110065309.3011785-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ea009a4a-c9f2-4843-b84d-e6b72982228e@linux.dev>
References: <ea009a4a-c9f2-4843-b84d-e6b72982228e@linux.dev>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::6) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DBBPR08MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 33abb6ea-c9ff-4b77-5f5f-08dd01545daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7uF0j2lNgL87Jg8klLnxNAyjIxerYHvUkxI2EstoVTLLqUry3+rRJRdCCXS6?=
 =?us-ascii?Q?htq/Jd+K9Fi0xi9F+wlzQaBWnNFxlsdvxTpq33KhWPV3wOF6I5kPbktAkc73?=
 =?us-ascii?Q?En4uE6TnhgFzzgs+zyXCYY9wrLhevl0Fb0UAc2LNZ+5Rcrvmy+FMnWrFvqBP?=
 =?us-ascii?Q?L1y7Q6VfOYbkaMQBqUuz7oD4vb3PNrR37sGr8tbiJjbmMTZdOf1F5YF7sK6A?=
 =?us-ascii?Q?puHIzMKnlqapdHLZryR9CYbiNHRkACsH0l4e1AiKVh8OKUbUNChHCi6JVsrF?=
 =?us-ascii?Q?3V6+meRh7ciiWu3/xVQGFvZFBHcoGp6vKOPK+E019Kwu3ZH+8dlLqHf9g7Kb?=
 =?us-ascii?Q?Q9ciXnHTHJgtG1o0u77V0PSvcnKm0P1Tpm9HdmJuVaxHWW7Z2ZXQmtjKk6Tz?=
 =?us-ascii?Q?aqB0fkabMls+tARkrkj7P3M8JpKofiXIJn8ODK/cWmudMzhQEwFF4cfwp+cD?=
 =?us-ascii?Q?fxdUvSAbBnP8Hx6fuZm1ECnF0CpJiB21Zzodf6e60GkyFUUSRcAufS2AgyeG?=
 =?us-ascii?Q?qy2p7n+eNvhuSsjIM3NWsKS/Bax3VbHL856OAyqAqtRXM3f75E6r0gGJsCed?=
 =?us-ascii?Q?7k2Eb7xd9rQCyrvtMfTvz9BqSkaqz7JRDaFqw29qH2GFEyWMTg5BImvt3Wpv?=
 =?us-ascii?Q?t+qq9Zy6ZvM+4E8EJ007ByRAfFiW59RVYaUADEV0JiLB+n0O6DOjxBFdTi7r?=
 =?us-ascii?Q?U1DWGoF8kfB2GdTnIU4A7tchm1cDgfiLbMg9K57q/PuiY2F0fQgpV9t6vgOx?=
 =?us-ascii?Q?ih+AMKoHUGZY1jcYKbttpNPpY5toZzJiT6jZW6RsL/cNLN4xcMzlrRoygLob?=
 =?us-ascii?Q?PNS90egvXkcCdAsgnjT+531uI2B7qiAEKlkjnCJwIl80FlFjI9kAsOv9v1e4?=
 =?us-ascii?Q?QTq1P8Eor9C8Ai8dvBki8kQa0THQBm+EhYuuH0kyetDV+Wn7ykG0d8vgx6K7?=
 =?us-ascii?Q?LFh78fqObifaIcOVVkjljYFB+jWJuD6Qj/+xlc62t39qkrDBUlZiiCJxffAT?=
 =?us-ascii?Q?z+SGOF1G82W9LYiTZ4UaQw6dz2kmiWVLFkpzJRUHK3T1BDjPvYHlTZU0Kic7?=
 =?us-ascii?Q?8jjyF5lwtUb56tEvoCBAmy8l2EhWhVv9L4M1P8nJWCi4+Mmg86QIgi9olQs7?=
 =?us-ascii?Q?0rWIZsmq1n4SZXMrXy4vjcXgO8BsHMRyFAYX7OR+1x8vrnfW6p8fuMFZX+fY?=
 =?us-ascii?Q?Fsyyn72tkdR+L0dHPKjwxLFkR+AwdBUeqfJFkV8rzIeJ4YncsYl+fOT53WDL?=
 =?us-ascii?Q?mk8ALeSn3AvekQVrmZeps274MXGeFtOl1We+6zsK7zF0gfz9Cr0LZfh/RLQK?=
 =?us-ascii?Q?QQqZn0c7cRS5pQd+sAoEcqJW5hDdqrpZE3UrLcFAmmMRbMTxEpYKzhgiebnh?=
 =?us-ascii?Q?AaVLSN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfPD5OGxIw2pSw7soLg3OU9In9UXPMaZN8f7Aer4Kf1itMbS7GQuF1KdkBy/?=
 =?us-ascii?Q?EFYte5bpA25GHST5+goAmdDEZqkGnFUfhGHzNtiWDIhQvGjwmVma4gglPF12?=
 =?us-ascii?Q?ksDPRie8C3iz2D0D04m5iQIRV/ckN9pJvLkAB9U6/3aW1I0D+vwE+m//Oy7u?=
 =?us-ascii?Q?b0w7uWs+j85QVDbIZdKio3KcJ8PV9DAmfW6Ut0qpZo9vE+CyV8JEgHZQpDmY?=
 =?us-ascii?Q?zbWrb2LiWB7fOXcHhHOamso1XRuAtZmrznHtdUA71/siJWbRnb/zEAuDKlY/?=
 =?us-ascii?Q?0XBetNCDALgeJLPQkEVcYCMmMtUjajwOCkg3ANMbljc4aoYPSJnHBz3j9th6?=
 =?us-ascii?Q?T06UJObsBA6tLf3nSbtPnvVGEwWG98MAVNjTS3sgALaoYZLsgyFBg7w+6oCz?=
 =?us-ascii?Q?yhBgz1bgSIlTO5Qceu1UGLEFY6qTj/1nCOONnehmhYBMgSqHXET4n4+6zhbM?=
 =?us-ascii?Q?xFvMfeOb84xKVGJmkhYhbO3dw1pxd94M3nBufsIdeJ+VApCwAmaFDLs/VFz/?=
 =?us-ascii?Q?5HZmw52lIHA4cazLUPKgf7bdv41wLObRmVNapPnfrzJ49+rcOOAau+dTsT0S?=
 =?us-ascii?Q?vT0w0giDKPFatubJ4Ke7m91c3PltgQ6wVOSJBEJPorui5vrEHcTDcPQKbC0c?=
 =?us-ascii?Q?JTSiv9/x+CfNcdPTlUpXsgyoXsbk13xa2Ytv6BSTt+zL/yvGzO3aOPzhTG/g?=
 =?us-ascii?Q?9LV9VqQ50l7xdYBSkf9t6EFm+tmcA8Uw8AZjaqejGcwrs0Mq7/s0mRAyQpaP?=
 =?us-ascii?Q?//Jrt0277SirEopXuaxFxL8clXc+29AoEiRLFQ9nj61J2dZ54fNWiMZ86Vf8?=
 =?us-ascii?Q?C8XGD4d28UF+7ahg4Vz904Ny06/1HRh+83yiI/v+CKopazZgCtAps7Z3zkA6?=
 =?us-ascii?Q?N9xuFX7jNMAGDnaTL2oiPe9pBaOyhqo59sgbgsi38dh2OTMFDjtqFVJudZzB?=
 =?us-ascii?Q?ENnX4QalHAxYhESaZ2w5kwEziuCq9t01anJQEZySTPk1YIWQwbQd3Oi02oNt?=
 =?us-ascii?Q?RDEQqVN9n+o4AYpLs2zrtSYUVhs/A7FfQaiT0EZuY5Ezpttyzs+lYyrHVNlz?=
 =?us-ascii?Q?X/tVXRHAolcMsHqMOKx8jWcJVQedV/nuDLuTDW05emmxrlIm68KW6SbFRJtA?=
 =?us-ascii?Q?RAmW8tvCySH4Ji2t7Fp3ayQlqBpx4XrlwPauk/BTeOvo3NEuwTm6D/59FvX+?=
 =?us-ascii?Q?fzGSVAMg3F/y07xzlo9MMZAzsSScufwzUhrRFFM+lYG0ukxjyI+DegIqiuYB?=
 =?us-ascii?Q?i8jab9ktlal9WU5B88fFnZ5u8+xgAqEaDYQ+aYd1f4eCZZX0+XAGX4OrXXHG?=
 =?us-ascii?Q?2pCXZ4/dchBF1C1kBxlFZitlPnOvaHw9lFvcAveBi5vLMPqBNenaQPLzjp/W?=
 =?us-ascii?Q?ElNV4Ajdlkj5XbxBla6BdVQSUFLFmKVt6YdxekHsKFbgJeSRceLbC6F5icJQ?=
 =?us-ascii?Q?rxW14bCC8AnRDzxpAAzJHVD9RZByBYEw7pC+SEBpg1DZnU7BWfBh3kP0VXJu?=
 =?us-ascii?Q?DvfoXM23FioPK84lx+F/X0vofVMVoa5/H3dLYc45ps36qkVsClUJONyaAMGx?=
 =?us-ascii?Q?ePnLlCD3DOVlF2Z/oqCZyVLeq0yGkHeOOUm4r5LrKSHB90Umrjl4XhePLFFW?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+q4ATuWaWbhAz9rEGzoXXtVhmKBub361fsujDNr4GZRHGuc6isijUK3yyVtBt0h8Cz20ZvB4kXQ5Dvra66RPy7Rr3sN2pAHt/a4hkVafJhnWfMvqKkzJALF3CGMU6BrcHWrG2JgP8jF07NNFccXxWfOuGkFnZNhEK2bf2VJbaW3imQJzv1JyRi1u+PXXS/5cxPkIfmI4OE4p8peGRhrVS2aoYrms43SwcHtKY0c6NckTexIQ7N7lFP0YJZKaT5YlF9i9wBTFrOD0pnrB/PwMFzsgyAOosHK5y49SrA/fYKK9XasZmmPCpOlQCxG0bci6ZOFS9dqJP8LA6oldwgkFRmZAFgJUtPj0TFbf3kOk4C0GdPT451qIfJ1OUzcphNOlhiylGZvMuWGhZ5gIR7VxoeSw+dsK437yd2XmP51w2CeflaYHBx21taBBFegsFcvIC74P5oDG7AzqMYLaI1C0AzmtXpfX6et1bAuYEzl4VqO97zilHsZux9VV1bjwPP9+cNxgdh+5sWeQt9P0Oqj0WhAGs7dunuWMVlrd4qQFHKii5mjpWz2L4vqx+vNzUXnOuB1SmWIO6Ta6G6s/ZdslWJPpzxP2mTC7CQxI25z+2+j3//Wtla74Q+/NUhhGn83r
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33abb6ea-c9ff-4b77-5f5f-08dd01545daf
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 06:53:21.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2DHDy1fgXE86Hti/o9mbqP9aJQ5dzVnSv/IBk3TJfZsWFBbJb9d4JCdx/n+FKHKctEptnoOp/qAGDYFoeSwNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6172
X-MDID: 1731221605-LYktxVQ4VK2m
X-MDID-O:
 eu1;ams;1731221605;LYktxVQ4VK2m;<gnaaman@drivenets.com>;152b7a609c5631ab3aa4b4b3056c19be
X-PPE-TRUSTED: V=1;DIR=OUT;

> > -		spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
> > +	list_for_each_entry(ifa, &idev->addr_list, if_list) {
> > +		addrconf_del_dad_work(ifa);
> > +
> > +		/* combined flag + permanent flag decide if
> > +		 * address is retained on a down event
> > +		 */
> > +		if (!keep_addr ||
> > +		    !(ifa->flags & IFA_F_PERMANENT) ||
> > +		    addr_is_local(&ifa->addr))
> > +			hlist_del_init_rcu(&ifa->addr_lst);
> >   	}
> >   
> > +	spin_unlock(&net->ipv6.addrconf_hash_lock);
> > +	read_unlock_bh(&idev->lock);
> 
> Why is this read lock needed here? spinlock addrconf_hash_lock will
> block any RCU grace period to happen, so we can safely traverse
> idev->addr_list with list_for_each_entry_rcu()...

Oh, sorry, I didn't realize the hash lock encompasses this one;
although it seems obvious in retrospect.

> > +
> >   	write_lock_bh(&idev->lock);
> 
> if we are trying to protect idev->addr_list against addition, then we
> have to extend write_lock scope. Otherwise it may happen that another
> thread will grab write lock between read_unlock and write_lock.
> 
> Am I missing something?

I wanted to ensure that access to `idev->addr_list` is performed under lock,
the same way it is done immediately afterwards;
No particular reason not to extend the existing lock, I just didn't think
about it.

For what it's worth, the original code didn't have this protection either,
since the another thread could have grabbed the lock between
`spin_unlock_bh(&net->ipv6.addrconf_hash_lock);` of the last loop iteration,
and the `write_lock`.

Should I extend the write_lock upwards, or just leave it off?

Thank you for your time,
Gilad

