Return-Path: <netdev+bounces-280061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GFtLG8/52no5QEAu9opvQ
	(envelope-from <netdev+bounces-280061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A523C438AE0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A1D5300B9FC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039EC38758F;
	Tue, 21 Apr 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cy1QTfVq"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7726B777
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762655; cv=fail; b=Ob6ixcRRh2vx1h3fgIiInAptPsLIG5myU2FMxzboX7CmR8KBlfGW95hm5hKknazE//DeCBanDB6ke+m3JaqEpr0Lk3gspy3As7uGCn2bAqqNIpKEdsXeFctr3OLRO5hOVY93TAQJYZTY6YZRWXw5onqyrd0qQ5Aq4J1Kg3eIGig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762655; c=relaxed/simple;
	bh=n5y43oxmyVR146XYs6NdnnmOsyldJKDkUd7tRai1zr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/wXtErLvqC+KNnUKKnZ1oVbr+Vvem2ZnQPnhOB/d3eFfIauZigCOY6krmkuNI3p4hwQ+r5vsfB8M7LuUtcmrDCoNBcfWW9xoZjf7viyn3cdIBSU0udCho7gT1rH2AlqiSyPtytzYHEx3kHqIgChtvUI5Ch4ixX77QCFxRzZUlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cy1QTfVq; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXWB34jPhZ2eWyMvZ3fYD4b8wrD1nwo4+3SSzUu+eydMcy3qqbktaYztE3S92r7B7UpSH+DdYHixTHsZ5PaS+662hM2dlnzp+/OOD4pgcV5UpYJcNzx2IHQ1fO1b0oX6ycLi+7QaNf2SR6pi36Tknf/8ruG8qdSi/3cZo6N917SXRfk0MTx8/04poklfTC9oSc4uK4ZwH+ILXRlFULMaUSqvCZ+D4KspMeyIH+fuGP3aaoIfadhD+AJ83i9nLpPphd0E/PiYGDc+F9K8/5EXe8NyNGuiJQ5TFgDRCV+7p5Jv0S6TZDgGiS/T9iZldIEDfX9iXWPKzP1H+/Ue2R7XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mfZACwj0RQry6S0fZjidNzKQsqNULdIghiwDP99Vk0=;
 b=NXCJSMeUkTMD+xPBOAzDOb8l6etQqs60XdZ1myJBADcEiqcsvyIQ3fS6YkHzX9QWqjSkxBLqkQJwx08Bkog4lLfxIBYIo2CGbQlFYheb5O3Mxdfkt6lIoJPUPbcqCeei7T+2eXcWmOKXaM0gP3sK+TDf2pbPFNeng7t0eUjZNhRy1CCU8GBv2uelJX/DcODZbvFJ4zChXPFElpsl2FnfUfpUgxWUW0CpXBL9rbWt/umlj0o5kmRDLMcGtJ6PL8XGmBmp8jwqsRu5U1FYiQtRGCGwyo3nzxVSRIg58HcUO0V9+egivpz5c6zGbwwO77xVey5+P2iQAjOCvOXvw4DocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mfZACwj0RQry6S0fZjidNzKQsqNULdIghiwDP99Vk0=;
 b=cy1QTfVqQFiif8+ZZ7iAKkn5NDkZJasSnm1QgTvtqjwY4N9I1BBMSUAjadcQ4eaS7IzVAnRCj/qRCrg0bDER+vkBK2bYabwR8+A/1aqlJ/3nwT1v6M8NBgLKNhFb+415M2OWUzJMA1GaEv/20jQ7krPqjy5BN7lwTMxsWLEgwZXs5pPia34X1OXD1OCRMh53okqpYJQKQe0bjmspPGUCC0mdyRnSQdhxaIM10VZYsYRdl4IsbWbo/DQreOpU6fkjpWZBGAWB3xtFt5ExrdcBsIJ+I4le4JASItKb/ds6Uy61Ouz5iROBMLr04Qr7ZgcuSEf9f1ZVUhpjGJ9ebGjB9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:10:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 09:10:49 +0000
Date: Tue, 21 Apr 2026 12:10:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, idosch@mellanox.com, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com,
	bird@lzu.edu.cn, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: l3mdev: Reject non-L3 uppers in slave
 helpers
Message-ID: <20260421091039.GA1085009@shredder>
References: <20260419145332.3988923-1-n05ec@lzu.edu.cn>
 <20260420113208.GA972415@shredder>
 <20260420182640.GA1027405@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420182640.GA1027405@shredder>
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 9023bde6-0a14-4552-b986-08de9f85e0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iH5xuuWe6rtC2CYEdE+ifQx1wuZgECD1pI4ypQ7tqctDNMsvJbVokoGNdQzC3Ft67g6NAj0J/lnnLjoh8t8RmoeuIvRJWNK1NF4QruSWNwZ44gJtMjk5rJpKUPqAHctHtUju/AAwfkk/7CY6FEHanKIcNcyEh3BsAhMuBMUKFkJEpHSFnxqnYilOSMgXzVC0/OMJfKPH8IZB7EnqjS+lm4ppp7bYRAHZLoVAgY6iyRi7pYRWiokaN81125YdW4pybmY2l+fJr0DJQQ2gL1GLhteK5ETCxuCaye8OvruPvTnav/63AFqkQUMbSb+HFEVF+HSQxz41SLTHjOlci4Z8uqJ8CmZA7L7+kFgVkX2CVd0sEV7UH7zivpydeFEokXtqi8KScixZl/HfsTfedoUc3CvOHt8PtEt3ew4zani0mwlMxFu0jZTyH68t8eXgMnUheMDrms93TDFhecURpCGIKPNX6go7vh9UevF2VpcROJ4ept+9wNLJK5Y55wyqJ1NkHpGdeeAvLSLldCIR7Rof8Zizh8eelNAhwA7lAOnaswNGFJWay+70h3+vvGK9J+LD5wkWXIZNEEkx17x3KLOr0daPFth/xgnu+6N2t5aPNIhyGnHxuEfqRXy8dmA5084o2Mbbr1WlNsI6jctK7EGSu4t3AfJPd4uzCLEexOG4Agz4fvXJkyQsiSViIgwdpNzdBQxsttnvG+X2U0NJBHBXGaUcsc8uQZ0EB/wi+9w7do4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pkulq/QS9D/khlVUfjwZxdXV4ZetlRCSiBxxuoHw3cc3Yn/UZqn13cOzg8yg?=
 =?us-ascii?Q?cgrQUZDXXzLRcXi9kyL7Sw5Myfw4WecjollT0Ceks8V3SFv0bK/ymlwC1VBy?=
 =?us-ascii?Q?XSZfR8LZq+QRrUMSyLkjXKDYrCCSawsBkXKlnyenpwsEDZc7UjTxRuhBiZd4?=
 =?us-ascii?Q?Jvro7X0apkoELcGliFONUPa7lHDl8iyRIZmR1aOpi7+FAFVWV9oYaAUAQgnN?=
 =?us-ascii?Q?rsP5/PSAHh4W/OHonlGZJ8LBnAg5e7rle3EeLsb0G5q4rbWHHaBIrvnjmEr3?=
 =?us-ascii?Q?uYAxG1Ks9muE/Ogdj2isFRGOi0z7tQsvs+U+nMzsXpgBK79kCvpqP5EGwAdd?=
 =?us-ascii?Q?dmoCkEWKswl+kfJXIR2zrf/gF0nVp43PR9b9HYx7J2zdqtok43BymJvDhkHD?=
 =?us-ascii?Q?TnK37VK7fKZsBOOH9i6x0So5FK6TLaysiqLriVCkppoH5m27K7YqCcwPpc6R?=
 =?us-ascii?Q?1hHjYC2+9gjoHNNL/UbMU9z6ljGGKcNmo+sq3ORRautb7SfkhwWf/2cDNzsY?=
 =?us-ascii?Q?hR6ygN4dFYyMlQ1BcwMrXlFnJhK/nmCCuE1tHVWwpWzK7RgenTX5rh5F1Exb?=
 =?us-ascii?Q?rWf7T+SV01lx6v2FqFT026MedOTPmuxsSc/Q4SzwAOvaKQQLPfg9FQfpZb+y?=
 =?us-ascii?Q?BLE/ih9hwVv0znGd81qdUKqPnbG+P24ODRCV+Lii7qkoeG05lKMN60rFJAk9?=
 =?us-ascii?Q?eSDBuQIExcr3rnqELL0E1bVvNIowBJExHNJutmqVY2gutWRojPubxY9lQMBa?=
 =?us-ascii?Q?/h5EerrDebjwr4wUk9ZWGbgEiPDQm1Az5kjsS4i2686soxbVKR14kmqAVD0t?=
 =?us-ascii?Q?ctdrlpvk8vWoghR+9vYgTZXvpI5VuneGlgPFfxLH8aVXO5XEuZLNzM1WdRqK?=
 =?us-ascii?Q?SarSFu6AhQE3/U+cb5INzxfnEwKVy8tgjGw8nvXpO0WY1g+cMZ+wOX6zIq/B?=
 =?us-ascii?Q?n+CfUodBrZ6ZzxNIjvRwA1xn37ngrZfOq8xuEYyPQOIUpTmVf6GM21+Y879c?=
 =?us-ascii?Q?sVX1ks9gMfEMRSCaG3JB9MIPZjWF6hyFlRyrvQlR2ACehLT64mNaIcqbMAHc?=
 =?us-ascii?Q?kAIpdHpYwEVv+1aBu4RGsgw+mk+brUIBMP9Tqqi94OYhRsH/ANb6q/VNmXv2?=
 =?us-ascii?Q?7JODvB11e3PCyGwcR3Aiqfivs0LqAK31vRX5g45xR41PJDxgA+eyREY0bDlI?=
 =?us-ascii?Q?3O0ziaUGAMYfbccKmGZXt9a5zTeDwgPGG9223k9nzbM+rO9d1TuscS3/onBC?=
 =?us-ascii?Q?3EUQAj6OwPD5orVqJgTuLoqP9xoi/tLtxP8qqQMmI4HF0m/UUNHXrMJPNlSh?=
 =?us-ascii?Q?ieyysdR3FCvwPfea9XxpcUJ32ejnD+uZ34Xipqt0klVQDTVchAzV2mgmPyId?=
 =?us-ascii?Q?FJvA6jD2DKqJYxhjmBc/mGwWhhkfZ7kJmtf8U2m9KIx8dzUUiv7glgoAu4oO?=
 =?us-ascii?Q?ngbTZUYkcMy90Mk/fufqMof5uG6qP+f2pML8J2JRVrTrQQpSVJNYbnmU0s1t?=
 =?us-ascii?Q?vq8V99A464GEgK6F5oiHgOGmV5eVPVyqaLXGLScIDVgIJvFkmnsUJem+TV8T?=
 =?us-ascii?Q?I2aXtvT3I5Wz/3OpA0StDJIjjcyVUGNWW4pAf695gUO9V3DCSj8uTeSMph+K?=
 =?us-ascii?Q?86kYAtdvcawxdZL8iv0qGNgm2OOsrcy8gwZCjRu/9nxMopqnaCpE+9I+dEyE?=
 =?us-ascii?Q?pB/C1/QbWEnfo/ljJ7y0mwsRbCcosexw7Snr+O9SmveBw8ZC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9023bde6-0a14-4552-b986-08de9f85e0bb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:10:48.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLWtNyDUcvOahTVFrIl8GHl8NtGyi4UX0nqLFRjaDjQGknOFx7geap4TJ6vjQj/S0u0xZv40kvg4sJ5ZhRH8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280061-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mellanox.com,kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: A523C438AE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 09:26:50PM +0300, Ido Schimmel wrote:
> On Mon, Apr 20, 2026 at 02:32:08PM +0300, Ido Schimmel wrote:
> > On Sun, Apr 19, 2026 at 10:53:32PM +0800, Ren Wei wrote:
> > > From: Haoze Xie <royenheart@gmail.com>
> > > 
> > > Several l3mdev slave-side helpers resolve an upper device and then use
> > > l3mdev_ops without first proving that the resolved device is still a
> > > valid L3 master.
> > > 
> > > During slave transition, an RCU reader can transiently observe an upper
> > > that is not an L3 master. Guard the affected slave-resolved paths by
> > > requiring the resolved upper to still be an L3 master before using
> > > l3mdev_ops, while keeping existing L3 RX handler providers intact.
> > > 
> > > Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
> > > Cc: stable@kernel.org
> > > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > > Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> > > Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> > > Suggested-by: Xin Liu <bird@lzu.edu.cn>
> > > Tested-by: Haoze Xie <royenheart@gmail.com>
> > > Signed-off-by: Haoze Xie <royenheart@gmail.com>
> > > Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> > 
> > I think it's fine for net:
> > 
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> Thought about this again. I would like to check another approach
> (synchronize_net() after clearing IFF_L3MDEV_SLAVE). Will update
> tomorrow.

Sorry about the back and forth, but I thought about it again last night
and I think that this is a better fix:

https://github.com/idosch/linux/commit/e67517758ebcddf8a1b97817e4ab0fbf82f467fe.patch

It's a minimal fix in the control plane of the VRF driver which doesn't
add more checks in the data path. I can submit it later this week unless
there are objections.

