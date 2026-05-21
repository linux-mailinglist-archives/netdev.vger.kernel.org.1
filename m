Return-Path: <netdev+bounces-290255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G2VDvOwDmr6AwYAu9opvQ
	(envelope-from <netdev+bounces-290255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:14:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE77E59FF51
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3437E301411A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC39394797;
	Thu, 21 May 2026 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ohy9EGpk"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555AF37F755;
	Thu, 21 May 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347696; cv=fail; b=pokLp5H4FeBxFK+Ii4u40PbKpqhi9SCD3xV0Y5bo6w9JVQgmwkyMUJW9YXF5NEmHXzsbHObAjDQrks6spZJnH7WWH36bwj/iOvWWwx2rtd/vnFB7lnvYgjmBu9Csx4Zqrr+5nb1lCYLUpb9mR6WcCqAeLHJqXn6NQF8gkgTOiQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347696; c=relaxed/simple;
	bh=eOl/5kmInLQwE/+QbHnoeIM1OfMagPrbzDttZp0nZRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xl7s+FQuBToEXx9prjVUxtMehqzD38yY3+jyhqBptwB8B7RmVD9kwrBfMjFhs0T/hyNU/5WwfGuPNQf9Wo7412OoOOZEt+Ualcr1w6imHbqA0FGsQ1LyBvDuwOvcZy0eEXxvv8ZQ9hDrsasDHXZ9BiLroCaVvOhrSoOyuNYsVW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ohy9EGpk; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na/kKt1VRzyKCEAt0C4oIaqDYqEUdkFgp2QyJ17i2ZxScIp9p69u4BN5Bj0C0bDfqrqgE59fZdw+P9P/NB8YuBsRN3bWzCo9wXn/yhlQQW2Y+wuSHGupyqeud5Xay1LWkG1PrpokRWhhaKfc6R+Mr4JtAMiVKfcIbu7ymoEQQh/x3U/I6CL5Jz7T2GRmDSpxDs/a4bA4GAkHON8YwICHPMuAL/YmQdoi4aKFha1sEXEswI+tGTubDFvtdYp5eBrJvfZPg7DCGAEM7VP20DIx67tV1/3bsY6pZgnJJvoxjCHa4Y7juy8+Iv0m0H2oXHEbajC9adPiglKxmExNbq3SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilpAorFL0c4uoBq9lGB22Q2dd1Zgi8KyP5x3hDIPFvg=;
 b=UtWhABeKESkapcrZBiQVRlp3qvHmczUIXMptYcqFwXnbUcpf/CMNlkHBVRUpy7Qdd9bhR/lgWG1KMMKDr9A2tqsGAVX19XkVaDQOF8tpgneCVZbE6cYvMI7tzPqLTMxkEGoD1uPq77wt4p1fiM3/cCT/53kruGG958/uL5b6r0r0AWJw8EmCbrhVcmLuBzJYzRz61lXAekPmuPe9NuLBZnQ+4ytGUFAEyQMEFcXDSM4isYU70cFAmB2AaACcXEOsyIYGsdQk9EugkDSIYZ0G/HCwBPxIHmTJ+dx2/2DnrXd3y9OtMccAziT1eAqysITlOEubeg/HAXul5T3AecYWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilpAorFL0c4uoBq9lGB22Q2dd1Zgi8KyP5x3hDIPFvg=;
 b=Ohy9EGpknDiyDRq0bhs6EeE9BDTqRP4pM7RG4RzYxHQfeBcrNfCBYmbo/5sbZ+GKDLfXoXCPKfoaRdl5X0ypYCfDG6LfPfxQ+jGjmbCcR7Eq9fsbWz3LijsLDLIxu9Fkpftv5JkvokYQygaTqvQKwFpgkT7EJAZsydXSbcesi0LT2lXZ+FrSqM+6ElOXQy/dr670sKcJMAe14XPXoWbXgcbkYUr5BGh4HZr+sqt2YAwWh+HVgyTS/e0i/2uL0Fwr0aFLm/k5821/UEJqn0bfsmmjokC9xOzra1tpnc32Ql8QulbhatDblB4VpJyfWjvbkIYFqC5UYC7U/ij6A3CfQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 21 May
 2026 07:14:51 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 07:14:50 +0000
Date: Thu, 21 May 2026 07:14:46 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	Shahar Shitrit <shshitrit@nvidia.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Expose ASID group change after DRIVER_OK via
 backend feature
Message-ID: <s6tcrlwfx7uexktx4mk7aee4znpmwitykfuitcmqe2zpev7co5@63vxxt4ze7k7>
References: <20260511094504.1619893-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511094504.1619893-2-dtatulea@nvidia.com>
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3693671f-521b-49d6-68cf-08deb708a609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	P9dKtJpPTkkXwlVSc0SmYbeGRDGo5Yvkr2YYYxVcz3UPoUyIGiSHNGwPLtw/6++kwDVne5RVUUejvEdNVcSl6CXSRDoPiWZBvOyVIhwSYeU+kcWa9Fs90/VZKwiQttp6OJ8A0810zquHMofCLozRzKs82/557BFKODd1hfH4BY82Asnf8x275AZkX1tvzrUVbt2nZSFHnpfPQZGoBQ63b2Rc6qTIO4SaIzm0PJoeR6mGS1Jl2VqH+kCMvmMe6i4RLr6nlkfGTg3pzPOiTW87rob+z15ELhM59crPTDVf5XivU3dAP3ee0oObIFIpdaVBeRbsZHsXVwBnGJZg6CTmolOTElaVa10RsQ/TXrbfdVatT4y2gZnTe396QVAh7t6e7qhGMXyRj97PKNXAWdS5eMSEJuyIpe9VWxixUK3xwiGitviKPVoXPn/8ggEdPiB8Eh9RkUdDcrq1nRAoGZZeWpRc32H9uM3lxQyt+YuPejkFCGMt3eNddCa0mwaXAKDQQh8TVSOE3fJ48fb3rV+6gf8Jr/2qcrGeEaluHhZS3grA14VQ7HUmSmAUhGqDlo5lMkpZWOc38tnmDnNMe7tCc5Knc7TOHbJN3FmmJtD2JgCU/TTceOdsx1vh0faj+94MGXF1WiGFqqVF50PKTJNqcGqo27LDjDwA3gYgVnbADia/+FQaRkSgv0MPwnxVLo+X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vDPiAbRQeN5ozRI/pY1XYDSIQ9Y+1ph3D/v8UjfZl40AbU1UDAc4tlEW5re?=
 =?us-ascii?Q?u03+WR8lrhYKmeKERv5wgNYP8+8BX0k5S6bvWYict/IKTqG8l6IQ6aD9LBeD?=
 =?us-ascii?Q?agxYrWs8aomJ+jsWTNmuX0PwF9e5yQHoc/ernbugwOvXJrRUTvcunborC01w?=
 =?us-ascii?Q?4V2cOVPtw4+V9ZJcttGXNv0PPnLOQruVjX7UWdAnUeaKJee+JYe1H/mlGYaf?=
 =?us-ascii?Q?WOqBwoGVrATFUyileEHjfHEJ6siO2VWK3j/5sGDeDgwXll7CyfyxG1gW2+9R?=
 =?us-ascii?Q?HlRqfqlBvTr/P+egzmFbY0AZUKUK48ui/HBXQuneqDmc5im98lYIihYdEzx0?=
 =?us-ascii?Q?volmli2SEP2iUhVz5G98oapcLkCmTXF3iT4qYShJ7+bYPGyMKTxsZwy8/2Ut?=
 =?us-ascii?Q?HkVBmv2w4so3Lk4ekG5plbw2CigTQXvnv09CtrKn/6ZWAx9ISsrZNv83hGRs?=
 =?us-ascii?Q?1PPYUG+xuv4wD0wA4eiGCpVoLFMtf/Hee+zDrtzZ2R5QQU+bxVZUyPXKOnKM?=
 =?us-ascii?Q?7R4E087QCa3yOgJlIPcdpTbSiChauSPs0WR35mntW/n7JLAqONVg3BasmArr?=
 =?us-ascii?Q?EzNJuJ4NFiyF530rZyka2PRwioD81OMlJxjyQz7n40EapDMFaLnH5o+NvA5/?=
 =?us-ascii?Q?rnC5M/dAvZCj2NBtLTTo8Xu/bYegCGb2cMRndCtCOkZ+flehkdjrzah35Rga?=
 =?us-ascii?Q?cpXzNQ1Zqr0K1/PekzaRqZP9dt51+RiTAh0CBNgiNsjnpU4ogzH720tKL/Pb?=
 =?us-ascii?Q?DJGfgU8mYc+I6cUXOL7bt1Wv+WYOYgx1oWwv9yfn6RCPyrietVCo8QU+XNZA?=
 =?us-ascii?Q?u5zji1FTMzQcWaqBUDt0FwUiuqUjAraZwFm+GvNCziSlhWLq1Tk6Mr+eoS67?=
 =?us-ascii?Q?dt4icPrfK51RFXxb7zI7m8QMXT9L9im+vzC/uZSwJlLgr6CgZ9sx46Km9EdB?=
 =?us-ascii?Q?GfPusCiejl+GEi4gdFOUYUlKmVXoMn9ohgRPOvAfc/n3i9KAJFbzDG/QfbZT?=
 =?us-ascii?Q?xqO7CupQPAPSy189t+fFkVTf1qT3AjMwZvYST21Kbwy7Pl+GmHpSqlqdsL7K?=
 =?us-ascii?Q?XnGz9pBthSy0+kHXptOEaz+/g0GPN6SAoaKty3C1Wle8bDBkFyTXuM1jvU2b?=
 =?us-ascii?Q?HLISYV59vcP4sGDuQPQvEOUxDxXXvqDruplaOEZRfc2xPSnwVFX1drwElXMd?=
 =?us-ascii?Q?8tWcHWl6eCT/SKive/ZRU3OvRZ3Pwqzll+gnYCbXAU0zoipjptS3jaVTc7GX?=
 =?us-ascii?Q?JCsNrdenbIekeKEFv6/IApkImK6VpcL50Vxz6zmVOpEF49yV04x8+HfwmsE2?=
 =?us-ascii?Q?mk4giWnYAcbnyWjILUx1TBDl4ogYBqyZM1qz4xHqLXmy5qVN1X2lBLMtjpL/?=
 =?us-ascii?Q?4ZMLaHUda3VFSuzJofTJw9d7W4RXjc7B3Xw14i6hhVMkIKZbH5zZFW7Q/WhH?=
 =?us-ascii?Q?7FDQ3tAoCZ8ohyhrJqfEe7OZVT76bite47zq5UgUmszFXH6bQ4Sm9wKs8LPM?=
 =?us-ascii?Q?A2z7qN7bp2MEw+ITpesobBLoHugoDIOPfYEvr20AbT8uNo8XV6c5ofbJJC3V?=
 =?us-ascii?Q?vnxYNRR9qCnUUoKCKSirSFA8UFkXIbxNkdrHzUlbtpwmrshLrVfpTwnCDudg?=
 =?us-ascii?Q?rFm+vUphVWjokGaD6EI0H+yobXMA6a+lJM9Y6XGyG4hGIY/KrCV8EIEMlVNU?=
 =?us-ascii?Q?wWnYSVTYhch28kM5Y1D8giVOfyii3ofi0BU3MfZAo0p/Y2hmFP9vw+GQF7yY?=
 =?us-ascii?Q?yRLTT+X+ZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3693671f-521b-49d6-68cf-08deb708a609
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:14:50.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i51HGOxqf8cEbmZwikl2AQCT8dmpik4/0fFQ0bBr2+ldvXi5V25NJP65Uu9DKPEJ34UYdYENHB/adyf+mtiRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290255-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: BE77E59FF51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 11, 2026 at 12:45:03PM +0300, Dragos Tatulea wrote:
> The commit in the fixes tag blocked VHOST_VDPA_SET_GROUP_ASID operations
> once DRIVER_OK is set. That is too strict for devices which can safely
> handle this during live migration flows.
> 
> Bring back this behavior under a new vhost backend feature flag. The
> feature is supported by mlx5 and vdpa_sim devices.
> 
> Fixes: 3543b04a4ea3 ("vhost: forbid change vq groups ASID if DRIVER_OK is set")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
Gentle ping.

Thanks,
Dragos

