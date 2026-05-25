Return-Path: <netdev+bounces-291331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MhXCcdXFGr+MgcAu9opvQ
	(envelope-from <netdev+bounces-291331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:08:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D07995CB8F0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C76B530090BD
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9F38655D;
	Mon, 25 May 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbVyojEg"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16901E1E16;
	Mon, 25 May 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717754; cv=fail; b=qYfEKDnoX4Pzf5ODbBnYOrXsLBMvHHlWm47cuYF32y6b1k3ycAS9FqXZeU1UzuQP19rQSRTMBmm24vAHaIUe3ioeZWsL8yq5krgw8MLOHfw3YIGsmusLedxGX/r8CIUT8FiXUXd++6Otothaq2etZOit60FLQGkzdhALxwLtsPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717754; c=relaxed/simple;
	bh=0pxT43686FTrRWbsfW5H5SUYBdtd0CLiFQgEXqoQsic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPkvANQgTzx55UAY9tBWr+z+hVEeBocaEOZFPHskgYnlQuRv/UY3xCJumv8OzuVestuF44rmPdEqjYQ+1u/0BIZPBIOWe654xrlI4mh+46FUwjC11h2Hj/9XZnQAgTadU9WQ3fBh0ybR03NP+4nwioWTLmilfQuk1d+fGLrE71Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GbVyojEg; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSxG0v0bKnb/OE34YuvnjgK1WrqU6jGPjP8TXSYZYLhk7/eES6F2rxvweNEcz4NsbDGxvzq3SgsrjL94MpxGb1jQFMCQP1x/iMTF/ZZ74ZIFlcVrgBie7N5KfCi4DZZX2rskPk/sF5vXvgRTfR22eKyDe5JaApWXcZxOiMiSxjn7m2shmFT5DNqG0lS9gxaEg+pEsrEG6owBFHnqBO5yfkCToPGfOXnZXaSB1lnos6Khv+jYdRIRXq20GIeRFp997tAWIGOYvshsUKbGxL8SwtQvzhmn6QVrV3vfKVSCvWYhYOT4ccfE4/GWAYixemTz6J35IApuYa0kxoGlv+uFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P24hvQcH7zqhjelEasVwmvc2/Ns1lVUUuGk3+PSliK0=;
 b=Qk5s9eiL4MhryHLfJKly2VxEhPUZ2zst7ziajbsIP8Zb7R/Pza2HiUXT5YPuT7Npb1KLFvqHXUnHB3yqdXqj8tO2ymiB5N7VB/ZmY9OmXLC/iaMhhFV8Iwbjca0TfFahIc4JMKR5CXW8m0hQpIrXxbYf1SZkXvabbvek4dVjSIJu3gNdpNxFO4oNd8gy1x6haaF6jGEqb4rByKoIE9Xl8Uy5F9EnwD7bHBEfu2Po6dRqnV9HSmOboFt/ElcuKNGK8BhQXFrmEYSRmxNDcTZ7fkMl084VvYmSza/4dmQjz1UZhIldIpxC+Iy6O+0iLuu/dS4Glx7UJB0a83pBMe7J3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P24hvQcH7zqhjelEasVwmvc2/Ns1lVUUuGk3+PSliK0=;
 b=GbVyojEgD9XNPm2FKM5y2PBPxdUzmbQOfWIQKKCSQpciVe5fq0P31x09iw8oTF+NN4wMgJptWEyEIKK6bTMVpt11KUFdkxxwmy9gTqjHiqEBNEfhvk/ScboVuc2ayUNocM+D+BmjQJDr9zy31LPl5DpL56TJQ0LJL4ll4RLANtDD7PUIs4Yd/o60KElDj3j51PrYAhOg+sTIAg0zMauQUw7dKdZ4IoRB/FLhnlBaAPSjdbA+4GVCyd07R4C9bIqWjJB1/Rt7JneWOJ2utg9XpYxojctV/6oM8TqFlGYHcLrhZ5zalcyfYsBUHwg3XGgo/bQ0Y0Mym6ZroBCMhs4Qcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:02:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:02:29 +0000
Date: Mon, 25 May 2026 17:02:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_fid: use a dedicated list head
 pointer for sorted insert
Message-ID: <20260525140218.GA215190@shredder>
References: <20260525071759.1517576-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525071759.1517576-1-maoyixie.tju@gmail.com>
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: c74499d7-72dd-4c2c-4918-08deba66424f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hdGUdQ0JkvLGoHiskXyqRYN2dTVAL0Y6aftx4BwWv7TSe4KFqqthL0qfWxUBOQAKTfc8Ah6YuAgBB0l+wacUuKjfW7MH5+KplticBSJyTWqVxJaZqW9s537y8V5iDBz42nVbYIgHIDZFDLNO7yXjHJGli2net3bn3jO4AMZOYHk3/qBrKIxfPCryHCfjiYzZRFD1+sHwV1ckVS50h3Le7fSPlXiJBS7b+PXS/02N3pToba5VEpVKCIj7O2OT/NqFCasUO2fNK9HhnjF2MD6rV/xgryHrliSyhDKaFvBuAi1pZAWRSBeJ3GjEc9jTCVFrPAwSm4Q44+rWFkt62Dv7EEGiOxsa0NVk0hJCnDfRDVsGiCFDEYk3WVHPHksDahzhor5/2mRIqxd2suPbYNsjfgHCR+RvHw3lIO9grLQ1skvIvEKK7sZwTtvcc1P4TiEcszGUD41U3Q9it94NkRQt5PUMrDRoQQI/gYpIRXGlhvvJY/+qIJpgOywaW+JHmDzGvMCRa980hTnH8yOavE2H744T3rdR9WbnkjrbadD+I2hfb18HRTUZQEQhejdxOQZNUW+JxdWORcw7QgOjvVZNt2dGIbfE+Qwe2d9jKRyTa6neE1AqOZD63w0tNrcabs/KkYZ4YBxpmwwNUcvbWkkCzVKx/40WM6trZiyK0UvNo90+cMCBPEpHZbW2mpjLHR+i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smbacIt+kAJ0mRjqIEvgdKo2KTSMOtGF5vXcAon3tf2Iti66O0k0qzCgReK5?=
 =?us-ascii?Q?kGs35uQ/BFK8bi8bDTo99+A0jVNkIELSO8bjHNnCSBhHxz5QjtSh0yw2+7Z4?=
 =?us-ascii?Q?TyO21Bc0M4nzqGYPuhXsU58LjQCkQ7RuCoNtBYb5v8vsU/NbM/Ta5Q/wfuTv?=
 =?us-ascii?Q?J6yHrbyY2+GktwSFOT64UStEmtYcyVW22/cozfUw8NcZl4rt6fIXtZ+uQiBr?=
 =?us-ascii?Q?ikKlgPHQqXWlBBQfo5OIDYzA+lAjqLf0Fjxyqc1V7F23gbGCYWDph1WE1Wdz?=
 =?us-ascii?Q?SP72/wmtJlyhqUanhS69UEQ6TB8uSEtPYtrOS/aPrRLMgwKBa2t0y+6RdYAI?=
 =?us-ascii?Q?6qibN3rXpsvxICV6LlCdCHR2gPBWxq8GQzzq5ZWDP/J8IpVQI9UKl7nzRjUN?=
 =?us-ascii?Q?3EcQ8i33uR6qVSG2HoyMw4iZ0mNdzRtkWDvVHLnQqo6IOndNV9p0gAg1DCJb?=
 =?us-ascii?Q?3wtvFvKjgzCnMZ1sWcL1y9bt/a3lW02yjpPiPTDbw6pQGrSrmVr0UBBulU1A?=
 =?us-ascii?Q?cZetLn9AE1CsyDTF2FPEeSEeTA1S7zfGeYOJgkbkFyjYrmgwL85rLSFmQDTz?=
 =?us-ascii?Q?Zaww4dfbsCHo79pXomR58E7R8WkXwMUWEA8T4YxDSRmFB564VJN5LRO3G+k1?=
 =?us-ascii?Q?/9fU5LzWzZOm/G0GhG7MLxDjuvSE0hbv9MK5GjAR7zx8LdwVw2DWn6zaiVs1?=
 =?us-ascii?Q?CNNgGlIhyIedHo+qvulItjo7bngT1rymjR3oZepbFwsjgfb0JKc3eG3RXTLV?=
 =?us-ascii?Q?u+n6jhl3vXpeCY5KHClCvYxgvO8q3FwhoPpdrE36rw+pLbTzXohIz9ksTMms?=
 =?us-ascii?Q?UEgz84Q1G12d2dxeRJU/tAT2GBZOJCvkDiC8iTZnQLYMy5f+4PY53TRBLu7x?=
 =?us-ascii?Q?2f9yto7E+nXmCnCALFIo+mhiSbheSER0qYTooru9f5+o1DqeMANQ6lQvHy37?=
 =?us-ascii?Q?kifGyaFrLC3d8fhxjcAucagK3pPrPkgrN/aPmd5CNZCn1oKwttrHJeq55Fav?=
 =?us-ascii?Q?/ByVB6wc/FE2wze7so3xmwrNACTrxVDxeJaF99yHMlxP7nN555cg8G9EAero?=
 =?us-ascii?Q?0j5uJkry0X5UQh32/CBRYTigED1m02DGICdmpKGaVEdLkTljGTuFQuAY8Pk2?=
 =?us-ascii?Q?4+QgIIhvGFP75ux52f4S+U7owtPb2kYNZyl/Jlhs05NLdvawK5fHVOx5bRrU?=
 =?us-ascii?Q?kCTwF8p5PYsLcJ5EgDTRPPt9Yoe7WPUE/1yBwQWFkDM3XuDcX8Haf7EJFZLN?=
 =?us-ascii?Q?0wP7Bxy43iCZ+zBsCFvwr00se7Qs50ACfi3ZzZtzhgpRr3vtIUM8tKWOHCOR?=
 =?us-ascii?Q?F1FtkbqB39YjjybbVpBpKm3FI6YqdZC2ZpHq2B929+eSRj6+R360jwzkSzy0?=
 =?us-ascii?Q?n4Q0ZG0FQFNhc3m1xxycfhWLkTXMlAaQgBfNUkxQU7qL99hWzv7aVSemd4wb?=
 =?us-ascii?Q?38yAC4Ke8YkM/sJ3oseqNE7bVuGPNmOfeQyQe6w4LuWVChYUu077kkyqd0S8?=
 =?us-ascii?Q?UVFifHhatB446w/H5K7mRfQH+cjCEvgaru4kydFevR37QsUC77JvHfcxn5UL?=
 =?us-ascii?Q?Ds43cCW9galQ1rOkclKGR141c3IRcafvezqdXp+ObSpY281uE/axY4sFFC/C?=
 =?us-ascii?Q?BjoNGdQBroW7kA6H409xI4qEZLnn2QUmKmJQSlbbACUhglSZd3FmugwJCdgi?=
 =?us-ascii?Q?osNgFYKiE7QxDqg7q+ELWFCaRaD5vTKIGVwGgjsfB9Oi3y+k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74499d7-72dd-4c2c-4918-08deba66424f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:02:29.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bc8JEUVMgGFLlsxBeWN2CzxYZLdgWo45kdbxVMXqHuoUtXL0zV3As5uilEmczHwq3eFsscSolNUxhvOIX4NiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291331-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D07995CB8F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 03:17:59PM +0800, Maoyi Xie wrote:
> mlxsw_sp_fid_port_vid_list_add() inserts into a list sorted by
> local_port. It walks the list to find the first entry with a
> larger local_port, then inserts the new entry before it:
> 
>     list_add_tail(&port_vid->list, &tmp_port_vid->list);
> 
> If the loop falls through (the new local_port is the largest),
> tmp_port_vid runs off the end of the list. &tmp_port_vid->list
> then ends up at the list head itself (container_of() offsets
> cancel), and list_add_tail() inserts at the tail. So the code
> works today.
> 
> It is fragile though. Anyone who later adds a read of another
> field of tmp_port_vid will hit memory outside the list head.
> 
> Track the insertion point with a dedicated list_head pointer.
> Initialise insert_before to &fid->port_vid_list, set it to
> &tmp_port_vid->list only on early break, and pass insert_before
> to list_add_tail(). The cursor is no longer touched after the
> loop. Behaviour is unchanged.
> 
> Same shape as the Koschel cleanups from 2022 (e.g. 99d8ae4ec8a
> tracing, 2966a9918df clockevents, dc1acd5c946 dlm).
> 
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

