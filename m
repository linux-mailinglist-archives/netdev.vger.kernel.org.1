Return-Path: <netdev+bounces-279720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF4rCM0O5mkGrAEAu9opvQ
	(envelope-from <netdev+bounces-279720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:32:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B2429F19
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F40B83044800
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D42E8B71;
	Mon, 20 Apr 2026 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="REbqwbU0"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63711514F8
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684745; cv=fail; b=ZEzHd3CfukjPuEQEiuYG6Sand3j/ltj1qpsQfBQOxDzPc2OTddZid+klWqjxvJVTgxYs6zCPB6jQHZpEyjJDoTYIkHp+H2SigBKu8l6WX7Bb9ZlO0KysIpa84iTPEjpf8fz4bnGTFxd6VQFnBhr6qsM4dKC//Y5HTQik2zphubE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684745; c=relaxed/simple;
	bh=IvgozM89aZkJBH6zpyDBsRpKNTJKWcMff4vOuWBCzgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DofzNt/jcd5OlQ5MRaVD5hiI2PDdPm2FV3FTDskdjXlUOodn6ES2I6gGoZjyJNmHOEqyVTN53JyG35ylDjzW6hs4IrkSdFV/J2Mg4uCDQBy3/X8CWDvnvyPOlNW9oa89pwy0appjIJpBtq5g7VpVGDf3HSWwf5k4fepsvh7YRiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=REbqwbU0; arc=fail smtp.client-ip=40.107.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU0cvLyEOHmYD8aSqhi/ufkLy5lVeToo8jZY+4ezpCWd5y4rx3RUage8+B8bRgwAWFbJDw/NjiZzbVbzyDLXRooTymFGTpYKeb2+zWo01FP6qyLcVN82C96whZ1OHppkILI4Qb1mHm1G/lA1lKhUjLHthwoRW4t7vvGIdltr6BtsVAHj4XTwom3g9TuV4T/UiBL57WuJvKyd6TsXUSYbZl4MU6lFdZ4mnN82RsxGDeWMVfZSpTf5gXCwum5ysHKR7jKg45zJvDxhVSogJkFzu9K+0MkmB93vuiMGgna7tWW56/7A/QmIwaJpUxqF0Ygtq9VtthS0dEeAo5TfwVwJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLGYxG1u+cqWYnZpTulGzo3Y6V+xnC44/AdBYSluH/Y=;
 b=fw4/E27sX3SOrKhq/XXLPAjzxqa03MHe3/1p5UyjGJ2mDS72JE/K70+SCaTJ6wyjFSKpJOXUpIAXCCP7gj9454x8hhfel/Bk4zQlWoFbtrAHQZVN7NhwN/o54swIn4qY2MajySNDWjmkKqRiIe00liwVIUYwpbxju71YiABsRU8d6esH7v05ed+QT/hW/1A7vOUnsP7P00w8a0HA3gx6RffuW/M12SxASxRQTU1ihZ0KIt2lPNwu7cNgeEg776yJm1RPdWUFOQaMBW1GJdpK0IYjNdW1DfSUxUy+FR2lEUd5tgGxTVtR2/lTM53W5k5w9NKEZM1yNtlz3VBfh4xJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLGYxG1u+cqWYnZpTulGzo3Y6V+xnC44/AdBYSluH/Y=;
 b=REbqwbU0S7uXZrq27SuX4oW4ZOnATDpi29JMFt1EuJy/vWyMA4znS/TJlmibpvQfH42OhnlI1t6EjMUxU2UO6xtcKNoZ+VHK2skHCEiczf2YFRgVKozSxXvUmiDZltsRsxypm8D6YB9Jpt2n4rphmM0nFDdhhr3/R6T8dYRN7O018IvzIHyiemp2I/E0WMv2APtMXfQfDm0F6Yu7eCMNnhnNs0h7PvLaJ58kbVR7lSIavu32Fgw8ueY7FN5dbXhaceK94MwrQqMNuTgtUcAbyAI/yCFqX7/3HkOy6sxqIm5Z2T1PxsyOtPnWGVPwPqItDE0GhfAjTgNAN7kJ24eNww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 11:32:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 11:32:17 +0000
Date: Mon, 20 Apr 2026 14:32:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, idosch@mellanox.com, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com,
	bird@lzu.edu.cn, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: l3mdev: Reject non-L3 uppers in slave
 helpers
Message-ID: <20260420113208.GA972415@shredder>
References: <20260419145332.3988923-1-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419145332.3988923-1-n05ec@lzu.edu.cn>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a206ff5-3230-4a2b-68f0-08de9ed07a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tJsthlzR7eATJJLWIXaxal25i3JEUoGQLqgX+JE/tQKXu7eW2NO3og9luA1AuRlyToyjn1rzY7NZiuPS2T7NeVKYnLOzGbn/xAxl720Ej9wpuyk2bVXnGzRxNwE+BSX7BcgcTw3suzjhAPzIHNSwGfuB32Htg8KtJ0gmH85VUsYS0HjpOEP6vTkMNfHbvww5p8i7nBaJKoq6bwSAJGyA8lnQguVEOwabzIgt1C0nGqTXS652q3w9oRnioGKY9LklaefIKCD0Nfu94lQnkb4y8UDn63WqxH/lJtbryXBEtMJHo/XoTb3mV4iVpVy+0kE6HegQTnTfFKPoHbu70UvxFyzWcn7+rT2K5223+zdwaQ5qmckAkbru2ukqZ3Sjf3yziFkQo8Axo6yWXPcK/mXPeEp8rMKGxxaRikl/EMclXu/UkWoA+dHmnO1E6uvE+OOLQaeERdyQ16vIveQaiS2axZrFI8C48pMsdzW8xIpElAhdr/8fIi451HUo6iyFnEfSINRoecl7yb/aGKao2eUmvtcMYHm4ILKP8/wxhD7mPgBn7IFXskjN6T6asN2bxYjihfwSBUqcjlt30JOTrZcnsPirXCvUUQ0jQ6x3Xa5uadq2XHjeOsbHyP8w5noJUR/Bh1YA6bsC5G6xmDaw+3bnk+AQ3uCT0HbQTHSgezE59vhikPWTCapx5cxhh9CE/MrAuO2Tn46ci2ksMbi4QNuG/zW3wsl6TDLbEZ4AmgwGngw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oSNvKKo1hxEOHX2QsMHUZ5Ya8Bz0fOCwhBnzx4o8iJ4l64hFffdZEdruuVrE?=
 =?us-ascii?Q?PwUjESXJM9x9QFCYxYa167/9hq9zC96gPfgEMIAOWgOc0liFrk79NWiUPdbn?=
 =?us-ascii?Q?mK8unWZaXXDFGKBV4bvEwHhOgrZs78oz7Y5G/ySQIBroJ25HJj6KfM7HQy6X?=
 =?us-ascii?Q?RbyJL8+8SCYoJQZMZxyRkPGD3+99YnDvp1bPW3y45JMJst9tGkfLOJok4wwK?=
 =?us-ascii?Q?Q4u20M2qmfr1x6vWxjzeGDBGNUUe2c5JPbaq86ySWcdJrnl6c4sqhCsBt/xW?=
 =?us-ascii?Q?nkt5baoje+lvUskorA95McO27wv92ayhtuIlvoAxFxORbBHlwxTXHRBpIbn1?=
 =?us-ascii?Q?gdvtNKZ3v60nLxxzApX5hreZsvTf/BprDHT4EucKcmLL8fvUbC1sR4IKrWP+?=
 =?us-ascii?Q?/NAXUMmVJyIvgWjvr3Slo2RsqWSqUwPIImyHFMys1t76Oq+IucJNpO9mBIde?=
 =?us-ascii?Q?VncpE/FbxeIi2GsC/mTnJ6uTSg2A32RBzXLjW+eG2GhSOiU0l34JNG17DpBr?=
 =?us-ascii?Q?hirlW2AW0hHFrku372PlIc3SWcDKtXlugIC7Kzm6ZlVY4/4wB+dW/NzqUqmU?=
 =?us-ascii?Q?6JgTmGA80l+RMWMT3EWD0hGXQXs9hGpYtlQqpBjFqw0LTZwAVoPR4fMbcsJG?=
 =?us-ascii?Q?mFPMvWHMUGJI0aQ7uUsxwvQUAyjhuTkLXxrYUNG7EzaazxYHWb/WFfBBStae?=
 =?us-ascii?Q?4gyIpEu18nPjoscwEkGonS3OoftTnPdzQ07zs9iH1zhud9C9xIx4lzP+JuKk?=
 =?us-ascii?Q?l30CQi/5bslSC6AxmGw2BrwwfS7xAzFF3Xu/Q+7jeiLPlkVhM0YoumSciIbU?=
 =?us-ascii?Q?ZYn3agqZTFCoOIPYpEunmN3wMd6FiJXrmMZW6KU3FxhrQ+d1iJMhUE1g8jBJ?=
 =?us-ascii?Q?wUMPkyFGYhmxAqOxCr/80iFkrmsUJcG5hnduscO+D7P/4Afpttp0uJ/R1PqX?=
 =?us-ascii?Q?A/77MLC3yU5/wZKjy+5ciprbeuCDCJGsDJYJbJx0EtOFpYkr05hLynMdhWlR?=
 =?us-ascii?Q?6VUmRzzTtvuTjawLeP3AgXo22PnpY2T+qAn1fU0TIPPXvCyZ12aVqQVZbPeT?=
 =?us-ascii?Q?7WJcjSA/0x876GcEnjhq2+ob2VfdyIRqC72/s5Z8iysH+JK90Ewk4FvUa1rP?=
 =?us-ascii?Q?XF7olZetdk770n+g9yMIEzEC5lNNXO5HYN3Vx/483RSbRdXo+f//9PF4iE+I?=
 =?us-ascii?Q?CCfBGd9r0ux+yX267RsjbFA9+F700EsvB3Fc+9RcGMC8jE6nmqkm6tTf0rBq?=
 =?us-ascii?Q?2NtCOg2DpWznRv0zU1pDyYqggE2M1z+NBIRQ7Z5GPtASxP7DHw9Q5fbvtyY8?=
 =?us-ascii?Q?LiZevKaKWwi74a2m0yjpG4vfxbD/2gnjlu7xMDKQSrkvHMml2qgI1G0pz0zR?=
 =?us-ascii?Q?QW0+JhD6fr72/mIszjjA0BKfgdnUKZKRhPUdZfRThOibqnpgoWnh+qMoQMmA?=
 =?us-ascii?Q?bKNDt3KlgQRcNeKGGc3fzfo4xBFZP+CfEUkgYkY2wkJSnKObuWnbQHgKHytP?=
 =?us-ascii?Q?hBgZrWyZmoeaFBOFpTc+bRopZVU4ulUUn3szrN/EKRsPTshk1YmgPoJqMm5T?=
 =?us-ascii?Q?OzTYtoXCMEZFvzuVyqh7SHfqpoW+sBpW/dyLR8dDoqFGji8mKzMJuBGG6h1P?=
 =?us-ascii?Q?KLuLx3QARLrIVzNNN5FnxG4iwirwfjnpgDzLFMTQtBKG/KcIAgbDg7SFKVfw?=
 =?us-ascii?Q?ZtlrrR6ctH1me0LTqo5CVzXCgMHd/he8PsEkTZ8HPfRn1PHy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a206ff5-3230-4a2b-68f0-08de9ed07a09
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:32:17.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UIjlZx9zB1GxDVTv7bSaC/6GF33OWcMo6KL/6O6iPWvjWLzdKrQUGC6Tn9rQuFGL7nGdaeD6wVkCPx2pHIWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279720-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA7B2429F19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 10:53:32PM +0800, Ren Wei wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> Several l3mdev slave-side helpers resolve an upper device and then use
> l3mdev_ops without first proving that the resolved device is still a
> valid L3 master.
> 
> During slave transition, an RCU reader can transiently observe an upper
> that is not an L3 master. Guard the affected slave-resolved paths by
> requiring the resolved upper to still be an L3 master before using
> l3mdev_ops, while keeping existing L3 RX handler providers intact.
> 
> Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>

I think it's fine for net:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

We can try a more general approach in net-next which ensures that RCU
readers don't see different master devices within an RCU read-side
critical section. Something like [1]. I tested it (without your patch)
using the reproducer and was not able to trigger the bug.

I am aware that there are more places where we can unlink a device from
its master (e.g., deleting a master device), but most / all of them
(needs auditing) result in a synchronize_rcu() before releasing RTNL.

On my machine, the time it takes to unlink 1k devices from their master
increased from 0.96 seconds to 1.22 seconds (on average), which is
probably fine.

[1]
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 69daba3ddaf0..23657a11c66d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2970,6 +2970,7 @@ static int do_set_master(struct net_device *dev, int ifindex,
                        netdev_lock_ops(dev);
                        if (err)
                                return err;
+                       synchronize_net();
                } else {
                        return -EOPNOTSUPP;
                }

