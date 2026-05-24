Return-Path: <netdev+bounces-291177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLg1MO3zEmpq5gYAu9opvQ
	(envelope-from <netdev+bounces-291177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:49:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD15C2698
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 539AE300D870
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEAB3955FD;
	Sun, 24 May 2026 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdrFaKa/"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A123955CB
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626969; cv=fail; b=c3HdPaxcr6T3sfzL5ukwbFHyqCzEUhQRXGZTOKahBNQIAISRuUSdaJUr2nj6sOf6MD66Gu5Yx3lDEha8xR04ZHopspzgX70XfM9RLjA9G+y8nsM898jFBAn4M1Yrtc6F7rV0kQmVutQZsCqxJX8+gn725Kv9W/qt0daijvaSzuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626969; c=relaxed/simple;
	bh=WXYKMd4I2z2BH/qCqVq7Ef18Pg6kgvHwLZ/1E+pioX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbfY4zfBtm5C/QaSaQDh9YEgrxey3WWliI9THglSWYW3+3lyWrHQ8OZqbYYxqxlLlAbo+JVjamsYqM6PHCmXFD9oNl4CF7zqwP4CGyPrCxBTEXuDwRF+OYIxIaWsnh5vU/lSmERLm9ZMScgvdKKBcxigLoaEnBt6fk3wedbrwu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdrFaKa/; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3z7efjUfSDJI9aVdggjoT+qdE3Gjt1Ihfvif5W/ZDU4UzWtUKPrZcua8Okm7hy9svcWn0JyKaB1uWfFo+yUER34KNFZ9jetGNb3F6/fO2vVA8Ap9RReCmWq+w8MJLHRBkGWW+eZSLOW0qVH/iE1dB3UNn8bKtbFDWdU7XZ0HU31d+iiRlFoWNbAiIMUSfio58YzOKzLwXLbRdi7mINWKbU5aa1AGUmSqJaoFAMBjAWtGAhD2UP1o+D1uDmlWJLSpIqlMszQ8NBB8NJb/YEtmKzKlED3lPENvDjD7LdQeYEVOL68f8YdO+YB6nSAfEYsztsH59He5clITHymP07Uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ci1ZUJah2fkeEIcEG5OWEAst716beiz9bYf2K79xwo=;
 b=lv5qMYYukYR0d/Bmjq3igH4RHqePE+GIyn5pnKGoJoiRRl4EJMhoY0pJHkUYOlYqsLhPlVYNvFjoHhMawDI9a4KL13OD6LifY/EvIWqpeYlEy3wB5kRPub3AvIUuYlzBPT4ZZGRuoaWKGKhOBCmF0arK68arNkynuNBFZq51PyULNhL5Ns59ae1EZurjPpdUeTsh7CMcMQCccfQfRwly0DbTSHiBsIMRR4mXNuae1DxWkpJTtY7kVXf4Vh91Iyrq9Uj9k0UIrQgiY6CZZNOMUKR7oPuHDmGXoZAD8w9+Sgq7gv0OT8bc1peONs0k48Jv+v07VslA3sFdWQoc+/vBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ci1ZUJah2fkeEIcEG5OWEAst716beiz9bYf2K79xwo=;
 b=ZdrFaKa/DyDrZqWz/dvuvO1OzE1awio/AWKStcl3lwcKmM6iKVwva4++/nvvrBstPqGGxvPccJTIKu/jlyjQPfUKjFf6o9n73yEMg+4+EglYS31du4Xmb+uVon1Gb1tqiwbQGEgSyrGUroc2yoVgOV5gcDuR5PJFmcU7kMZPimlZt0WJmdQD+nBNsRFOeMSj0rAdafg7HT2D18BvbsrDwJWz781ebV7EowRiBLBk5vWkQ5yH41d1E4Vj31myMwPvmeMbNonqU8LCDZFHByaBrrzJAcdQBmGRnJWo0XE+5zye9R/1IzykVb5xRp4+Bmmco3gU+b7Nx264uLs/Ili54g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:49:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:49:10 +0000
Date: Sun, 24 May 2026 15:49:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 08/11] bridge: provide lockless access to
 p->priority
Message-ID: <20260524124900.GH74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-9-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-9-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 521d93b8-e125-462e-8ea1-08deb992d9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	zp7E8DDbDRaVt4FMPP3m63GyPeq4bC9ctfLMIbQZRdnzNRvQMDxyufqYpB5WzKx3R7QdM1udQ2bU8iKHB2RtehpXD3QgTQEBchxzdhGDYDL9tKdm4DBlaW+enJV9CoiIs2RKml9n+YsXDHkKW7U3CA9Qbmc4gb+zqF1nNhe06KsJiEYrrFIiXOmWa6Wc+Ruc3Wls24mzvWy9NNBDzEktLzRnukGAl6tP0IyAyPRQu/PG3AxuXeY43V8V7TK39yMJjsG7Zdstu8ENBAA+h8BAw+SRih+8LYOk9ittoKGdsCai3bgpJajVz/iJbXqO0q7F6fyXvZolqts54bNzlEWakDRcvCMv/ReAQZf18uLsrdt326w18PN1384msFsVDuCl90TGziVLukg3i727VibSCmOfv6EdmFbCIsVgCdhtMOBTIwVztU8SpgiUaEAvQjP9B5AG2b+/QK2YyS4y6seOVEvnssCQBalLsgLvmUyzkWq/oo5JPlpcojUqRvA4uwRx7304vpbvibCUlfp/uvw3nQHcYWSsNnGS+y5/uPgAEsyCrnP6GJG7OsSz7NKc6L3qTJsHsf4jcTpyjKnF0/j2E2QkwBjR8kIWZJqh+q1vI+sYhE73MxCnW72gs+sA2DTurM189QqjQ15ZBft/TZAisXX7MA4EMG9sm4l306NGAGsCW72b1p5u14lQWIr350Cm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zf5oUgcAPMxOAweVC9lOBzhSNeDg9fIxqjO8jRK2ECJYoivK1f3z1P1m4xoX?=
 =?us-ascii?Q?Xc0nxgzf1pV4FNkf1+5fZQygaRFMQGSOAZ7+H0sQEKlVmzFEYS0YVRL8bber?=
 =?us-ascii?Q?Fw7FnQRAHU4BaP5X55u3KjdD3wchp5r8hGQ/HAKSwF+6swZW5FCe3gP75CDV?=
 =?us-ascii?Q?7LtpwZbn0IC56OYiMx7DTkn9/zGOlXwIn6lH3irSmIzyCdzwxHykayiM9Wsq?=
 =?us-ascii?Q?iB7CfVYjsJR0Vq2PIE/yXwceMQz2CcWz8gRhduhGFkFxD7hFelV17j1Jq7K1?=
 =?us-ascii?Q?KB/InW1d8owDZYJsgkTgBl63qJbXtgt3PTOO7xYSFBiuPaeTaB1SLvaUL/zK?=
 =?us-ascii?Q?7PwpVe82EKo/LbTdxIDLTR4fXJfWsIH033VY5CPZrPRajjvZbuo8OhLB+v1P?=
 =?us-ascii?Q?o3MPVU9TlOBZTBiTwesLNL203tgMtNC9fVFVFt8om3BdNGEI03wj7/clgaH2?=
 =?us-ascii?Q?xTTJP4eAS/ymudS7CaHO+KmaRtXlRhlY6yOrgtbOBw1Ou/lfJibeLrXC9zh3?=
 =?us-ascii?Q?aYvpnKDc6Cwn8MVm9Wt8ov+d1e4/dlSkrzLQFM+WfX2wAsaiDQ4i+t+SgJp2?=
 =?us-ascii?Q?zhX5x46HOsvSdNuPDiAc1xJVwH2DssaUQR7tw/LEpV0DZr/M8q2tYeAOY12B?=
 =?us-ascii?Q?7vDoNLpsvFILEAtX14Pgf2SAq8ObjaDMVgk4JF9fiaZOTYDmGimXuUhyHQ1X?=
 =?us-ascii?Q?p2JdSZhyPSamVZXYePLPKBnZNVLJr34/sFAQ4Im1coJpEQMA0B29aplr9oDR?=
 =?us-ascii?Q?tcJWHypY1GERbwnTsRLvhajo4wKtHeKBzC3h6yxNM90EFhsQtmeFpfwxg89A?=
 =?us-ascii?Q?QMT/57sEpaQO3vBOE7TkZQszBRhA0CLc6D3iZp5phx+LeTecYNcOwwwydbYB?=
 =?us-ascii?Q?lPC8D2NnNxgjuYQSbmDjLAv8nCNUOpeEcFRE+7WoskX6WdKVWWoD/RsVsHSx?=
 =?us-ascii?Q?uo4vlK72sjJdE72UFnjMk2M2qC5RLhulfKxsmUOxKe9QdidUW4UAJSkfrfN+?=
 =?us-ascii?Q?Me5DwkROEHUSf3iftw/c9UfqKSY7ZxTr4Z00aJZrbqm940U1pxMz+DcqVoLu?=
 =?us-ascii?Q?TzpQPLL8xquPyKNlVD2lmsgBaMRgKCQ7pUZ25pJX+ZM0imlMfBpCW6JILcE/?=
 =?us-ascii?Q?elGgiyjgXJczjnjwkd2T2ZJI3x5EaN2DbC8pOmtBLmvXSbUlCosLgy3/W19M?=
 =?us-ascii?Q?iEVe6c0aq6Xmv8WU0s55E+uKaQRYxcSD8/+6KhSgOgQNa6/frqJGlZGtdhOB?=
 =?us-ascii?Q?skhvhxiPfi5o/j14oGcrBuxzwagyoGuY5Sm778GJuLNf2giRhQ7J6oATS42c?=
 =?us-ascii?Q?mOpq9/lmB/JUwrsm3Z2Y6jxfzfjeGqv5XUd0nYZQk30KMl86Lvl11DtScJyN?=
 =?us-ascii?Q?VD/sGNK9pl44MP24wyXZF7VW0E+645p4UUlsb+UQuPwXMWSYeWGk44mcEEN2?=
 =?us-ascii?Q?K7AqIp8TuZ/yJBYOX4ffm26+DG9W1+Tm5l9NYKNolvLif/vkdxiHiO2jWaA9?=
 =?us-ascii?Q?DUK9+VpmUBEJPlXa8MfkYMipxJVCrW4s6MXHkyG/c97VPy5ZLu2qf4iTRPuA?=
 =?us-ascii?Q?idPU+HsVHGaJD7lU2zfIkLqBvRxAiwP4KFTxXvj9RrCubFsbD8uV26JBhHd+?=
 =?us-ascii?Q?gUmkAWEkNRTvISUfgxrOxbMpPRATgxGictvME9P24QBYDx+tOfM5DWybxjJl?=
 =?us-ascii?Q?96OER8/qtlkSmJvCJr40UGQYcDr7/4DYuNW5SXOGydmqTpb/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521d93b8-e125-462e-8ea1-08deb992d9e1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:49:10.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhTTDcbF2vRzSAmivUoCu3e9B9Pbn701ZMUH82Jx0KL8+1VohnYhWvuaves2gycgljo5r9buLL11HsPOSB3wLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291177-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 20BD15C2698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:13PM +0000, Eric Dumazet wrote:
> sysfs show_priority() needs this.
> 
> Also br_port_fill_attrs() might in the future run without RTNL.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

