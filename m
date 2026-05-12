Return-Path: <netdev+bounces-287046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIVNGun4AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:54:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B751E1AD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FD513018D60
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A54C6EE9;
	Tue, 12 May 2026 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJioO+zq"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE024A3402;
	Tue, 12 May 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579651; cv=fail; b=u8suUsi6CcUfcceZDm+gxlsn8QN5HYzMqv0cKmWDDXxTXRu+13tA1iQWyVYJzrx6gi/jO4TcF1fs4IfVQhk9Fqo0u6Dnko7a1rGFHh9ndNaLV+X1cjKedCqXjh8YIEpVQzbkjFXO5maAm8u3crcXuZ/IFkzJmLAeKH8KsQE7ojs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579651; c=relaxed/simple;
	bh=5XalBylogepL6k0Yl9WSCrlwDukXWss0eA3mJ1wuusk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dNX6eS4UwAFJgQy7LZHNbKuFwSl4N/yYz0A0PAaI6Jf+dRlA/YoVn8tDcwvVab6VaS3l84P9VEsg+fXQfUTw7OEl58I6jpDv6anduJK9F77H/B22hB4570wEO++GV3msK4rqnFvKduSYh+4iq+awsKUdyOSexCdGdKOaq0MB9LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJioO+zq; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAkgSppr6TtESe37Ri5VvTdh6GZlf9305uhNuulqbHsIXmPSkxftiJt1kRUwof08lt3vix6Ku1DA0To3TRS3+bE+NZlwH9I21zRP4Fg9Twx3COupuKXkdvMIbrOuA3lnSkUN/r6Bg72/WvNP7z7+qM70z9Q/GEJVQCwYX8WJ7mdQq0/agjF5dlsS2NO1v5wi3aRkHsbIXYbeld9halqxVtOdRuaOJZ6Mt5R9y6JpzlKw4mAAEdEDnZE1w6h2cLUKG7zNht7H6ABTpkRF2xJa4K3Xpl0Ae9AqEkEVQ5vUELUKhNvi5KUtRSm8blOF/NjgXGExY1jzLOyzhr6ndHk0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx1FtB9Qq5bTa30hydDu1009D6LGvwR+ndnPyVPKRvk=;
 b=YeQ87tTZGFp2Jk9NDRY765dsMJzOkB5DnUUKzWeYOWSEcmZJHAj3YdI9LxNAQ+tYcV13hgcDFYBnJdHBwxnhkDWj5+2weYSDoXAKtZwwXpd/A03463JR7mlRnJ/vRA9BR9/xxisBPe7I4fO4QhnBv/Y4d4nQjH4KeThBMa95p6dsu+51k4vC8wjbHAOWSHLXm27p/mk66wi/4jdYw+Krd6aiGenVF+CNo9A2aL9w4dUaNmPMz1eTtkWoBpwNKXGEe3SvclLI5ObnlQxnOtpWxTvUYtYWjxt8eLegYjzSFZx3hJFLsJul3XoboYg4Z4M3XIL660CxiOYty/YMmkWiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx1FtB9Qq5bTa30hydDu1009D6LGvwR+ndnPyVPKRvk=;
 b=oJioO+zqkZD8VlrtEZJiNhZsKSsHVrm7hzk5v7JqQueou4BX6FVKWqorc3VGy7XGuRPKN1KE/MKqDGvbv1f9QymFT7bOtM/0yCwEkv1SvxZkBN1riCHloT61Fv/BTWnwkCR5IrXzrozmjToTMxlhpOz1Z+ku4fnQq9vJDWHPskcx6qtDOJN+YxX0/gRe9kS9VNM+NHu1s6zbewisABjwTGd8+cbm29eSdOruEJoUIO3lI44Y89jTcVi7qwwgpk5TfUIcXcj8vXUETLSWUN6YByS1vVVELIXH2aaSu6+ojYa7k5CEtWHUPHkoGeqBG4w9lcWoqtezdPbv8tM1DJvKlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:54:01 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:54:00 +0000
Date: Tue, 12 May 2026 09:53:56 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Anshumali Gaur <agaur@marvell.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com, sgoutham@marvell.com, 
	bbhushan2@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] octeontx2-pf: Retain ethtool stats across
 interface down/up.
Message-ID: <7jiq4s63gnolplmqcgnip76mkv6sztls6bds6alaygxvkqxwow@yswtunwuvi5q>
References: <20260512072338.1460580-1-agaur@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512072338.1460580-1-agaur@marvell.com>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 54681e94-6d81-4f87-cc01-08deb00c6490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TQK3pnqTZPhKk4A8vqAq/VKoW7umQY7qru9EcUlo0DAGGGvQiX1Dz8k2JR3xPrtFZv/xDNMvG0Sk++0duDqUn5gZaxJYMD98RqKVfxJZBC/3RlTPY5y+iT6TlVw+YsOTCHylp6sY3gB0vxrbzQwiYPKn2NXSEy2QrwpaZvz2C7b0HcPA3FCkDOEOS/H4zwJRiJRFAfAhSACoczhCUHovfXA79hW2QgkZ2+/ClRFv6XEyioVoy1k0bylqDdr4Cpx0S+cJmo22A96a1SsjXYF4E/RmBVPhCunR0eBqFTq0pmpaolOG+EPPsM/tGqrw+ndJJlwWQTO1ya5mlNd0I2FAKXAciOLBViy3FuFqxJ6lKsZU+vLI3wzUNZSAwCNf92N8hIs9mlExrTEM5a4IFQVuyT09/u2ubaJe2dhpZOY3PNGzsTTGQRdfn1UNN8FluDP7GKm0JZ0kgh2jcwDkvr2l0d54ift4BlncjnGRWq+CBnd/1JdX0xQVWvvxRLfOwOHZH/ULEi6O635CPiaZXRUBgJ8NqF5AjUhPmZcx52ZWoQwBhE+lCNGAdpQDGhl0zHmT0QGEj7yQodSZ9/O308VAe8mFmnzK6Xu7VbfmQfHeMEET8s1PHCcy8ERgypueecHeCMlkj1JyAJtS8gYPeSdhrBdAaYMGFCDq1SbVHSaDaNW/rGTk8hTCZigWdm3ZYBGBi+W59iAi5lesXnLB+qOeR36ZyEiBb9jhNPXz06aL80e9++Y6oAWa0dIJV1Qjql0H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXOTptc2NLB5qsLwenM0XVgr8TAFnVFvMgydqWqd82vcgEgiQmfkaC44BmnW?=
 =?us-ascii?Q?DH+0qVlRmdxzl9Da/2bhBYKxpGkFnedKED0/UgI7YnkkrOvxip+yNoZb7rw5?=
 =?us-ascii?Q?nflNxRjn8MTbrUlSo2UYr1wZwnqiVfcrWn1ZXTFs0UcEqJ0/AgX65Rq4QUTl?=
 =?us-ascii?Q?jn63/yrcThh9uios07Za/mwuegT9ErvmAvHRZVElQ9JMOuo9TeR4KhsZ+qjF?=
 =?us-ascii?Q?ME7uHBLUL7JBPrkna/YeEyRIBgMXSnUsfTIwZ1Bg6MvFPTfa32oKhMoxOuUK?=
 =?us-ascii?Q?Bmb2LxhoDNrydPV1V+1G16g1T6pf3E4x9I1Fx/6l3lL3cWnxHiN8/oIPmkfU?=
 =?us-ascii?Q?iRNOr1xj0Cb0YGh5qYXCnWQkJhBmXJPt9PaPiO7Bdy/8JJxTD84KhZfeipw8?=
 =?us-ascii?Q?qjtaLbt+o338CuqBfMoawDEPAcrQPfWLSqafwx5r5XjyCLkrT5Oi+avNdEkC?=
 =?us-ascii?Q?QKZkyeD98zGK9vqK11tEIWGN1lS9KB+oSOvgwZo9eopjaUtyzigCfx3cL9fU?=
 =?us-ascii?Q?Qzlpp1QUWktxUZhXglcModFzx/80Ahao7YFo9tIurSFDysgxy3sxGNzsVXWl?=
 =?us-ascii?Q?DMb8UQcga7lNQn3n1aQIeo7+qf9dQVZPbO+Xu2cHhl82dYgbMBX8NPrGXZ34?=
 =?us-ascii?Q?O0o9QpAlcX5/3pa+GbIbI+rBp82wFnrOoeguoy+3GO6Xj293w4otVrUxSYzc?=
 =?us-ascii?Q?hf5I6Hyk3S2+zfdIBL4sTnSHn4bf3ELxnCaTfB24j6MO6xIh5K34hKfXqnCV?=
 =?us-ascii?Q?fTS2JU+fsSon37VK3gvlhlWQvVlsyMBtEdDBuSZAOY5oco9iR+zzV8oE+Vlt?=
 =?us-ascii?Q?79HiIQeZq79TGud92DKv87tlXewl3aPo91Y7X7r76fiTFRDVIkqo92JdCaS4?=
 =?us-ascii?Q?Jjme/w1epY4PGme4BWFnx3aOjb7l32rC5YbqiDYapsXe2eX6aSJGaaVKXq7k?=
 =?us-ascii?Q?gj41uktQebsFb4yu05XefpAzofcfzZHCKw0hZSxykAIup1IeyXGsUCqQOTFL?=
 =?us-ascii?Q?N/MTotyG5E5BRf7zHiiPxSCWNAX4uAm9UiHyC7hQcA9N1b+fbLkXf3UhFc3o?=
 =?us-ascii?Q?I5xrUCuEIaE+EQeWpBU/X6adNVYK7qc/p//AnGOm8aaZLTcjaCiEYhpCKuGU?=
 =?us-ascii?Q?iNBAC4K17sWpnMKFusiyoLLG0RYKwRa2sWVdwy6GrJ/IovfNhiMlDbzkh5Qy?=
 =?us-ascii?Q?rwyL1ioKfvvUk+2GksDlvB+znTJ59Sew0iGlFvzFieueu7zdcvm3+IHQH/bO?=
 =?us-ascii?Q?EMhSFxAeRyGoMrmEieHjN4nNcTCD+bkNZ97eoKtEHU2lqdkUhW/u6Cmu1CuF?=
 =?us-ascii?Q?11Xh4/o7IDbbMkIAiASGUYZ2cz8hpAVWyMoncUzGdULivPo0jhVLgQP/Mcr8?=
 =?us-ascii?Q?vsGr8pDXPe1CuQiMmuKZRUdSvr1XBiWabwvEnGENN2Hy3BhVQqa+dnJmWtuU?=
 =?us-ascii?Q?RY8/kzh9FLTjvAheWr59zq1DwEvcNDTroNOJrnl8ajbXtxUCHDNBhzmyMCWW?=
 =?us-ascii?Q?upIs+dyjrM/XkXlUA7mPtWfeGy2FVPSjNYSPdtocUKQnhM501BGYP7KxCRkg?=
 =?us-ascii?Q?QnWD7GWCZtD9e0YNn8eykU90XL0azcwvbuayf6EVp0D3lw/yn6t46A+JC7Mt?=
 =?us-ascii?Q?9b84n9Hj0y1IqtD3rx5mSBO3aPBBxyISTf5GNQefBaPkViIb83nYvdKl7xdm?=
 =?us-ascii?Q?gIutj/VpsAFxZQg6ZFJHJAITo1fQBRtR3wt827dcjaRMe6mbrRwcrG2cNwml?=
 =?us-ascii?Q?lUrcvBmerg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54681e94-6d81-4f87-cc01-08deb00c6490
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:54:00.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sP8cvA9dHdBWOZrB+jBNHuLhKJTzRxjeACe6+aFIzqbExzMIBatRDKbMPaTmyNnlo9ioIU6cfVGt8tfl2Dqzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
X-Rspamd-Queue-Id: 6A5B751E1AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287046-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:53:38PM +0530, Anshumali Gaur wrote:
> Currently the hardware counters reset when the interface is
> brought down, causing stats visible to userspace to drop to zero.
> Save the accumulated stats before bringing the interface down
> so they persist across routine down/up cycles.
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---
> v3:
>   - Code format according to kernel coding style
>   - Reword commit message
> v2:
>   - Fix subject prefix to target net-next
>  .../marvell/octeontx2/nic/otx2_common.c       | 20 ++++++++++---------
>  .../marvell/octeontx2/nic/otx2_common.h       |  1 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 17 ++++++++++++++++
>  3 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 971fcab1c248..0ffcc613a4b2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -139,19 +139,21 @@ void otx2_get_stats64(struct net_device *netdev,
>  		      struct rtnl_link_stats64 *stats)
>  {
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
> -	struct otx2_dev_stats *dev_stats;
> +	struct otx2_dev_stats *dev_stats, *old_stats;
>  
>  	otx2_get_dev_stats(pfvf);
>  
>  	dev_stats = &pfvf->hw.dev_stats;
> -	stats->rx_bytes = dev_stats->rx_bytes;
> -	stats->rx_packets = dev_stats->rx_frames;
> -	stats->rx_dropped = dev_stats->rx_drops;
> -	stats->multicast = dev_stats->rx_mcast_frames;
> -
> -	stats->tx_bytes = dev_stats->tx_bytes;
> -	stats->tx_packets = dev_stats->tx_frames;
> -	stats->tx_dropped = dev_stats->tx_drops;
> +	old_stats = &pfvf->hw.old_stats;
> +
> +	stats->rx_bytes = old_stats->rx_bytes + dev_stats->rx_bytes;
> +	stats->rx_packets = old_stats->rx_frames + dev_stats->rx_frames;
> +	stats->rx_dropped = old_stats->rx_drops + dev_stats->rx_drops;
> +	stats->multicast = old_stats->rx_mcast_frames + dev_stats->rx_mcast_frames;
> +
> +	stats->tx_bytes = old_stats->tx_bytes + dev_stats->tx_bytes;
> +	stats->tx_packets = old_stats->tx_frames + dev_stats->tx_frames;
> +	stats->tx_dropped = old_stats->tx_drops + dev_stats->tx_drops;
>  }
Missed comment from v2:
https://lore.kernel.org/netdev/bf626b44-efad-43f2-b8b4-509934f4befa@nvidia.com/

Thanks,
Dragos

