Return-Path: <netdev+bounces-286503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE0uB2WMAWp4dQEAu9opvQ
	(envelope-from <netdev+bounces-286503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:59:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D56509B3B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08AE23069186
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6018B3AB285;
	Mon, 11 May 2026 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qe2nk2v7"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFE3AA4FE
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485894; cv=fail; b=XtxtwYc10EEDJS6ZkMJpqtPq1P+90cP97ukotm+SCrnRjQfjh25EHGK84e8Gpd/iJz7QuJHv9C33gZ0aTgnIWWLzPYPnUMcvl5tygXKZfEcjpPM5Q+Kb7S4TGLDUqPr9oXjuEPS5gBVEO6W67vffqNAVI4GZi85C6qwRDUKL+LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485894; c=relaxed/simple;
	bh=vnqK9KB/9e3CUJqQi1FCBcDT3JXyJb2VmovRQs2VWY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=blwANQNYPMYfwt6mMdmrpVMX2Mfz9s5+0a2UOwHwKerIG5DNsP9aOjwyp3eYfUIwsM4dNe7BJmbNZlfN+FNi/kk/R/3ABpMn3OG/YOaJ5Pgcgf4kzp+djhdnZ4gqia5Gf1795Tqqcpo2IrgpO7/rDWGa50dJUvSRYmiK6nnvkKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qe2nk2v7; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAtjDRHLJthkA6jDhVCGQUIpRLVvOMGzSCBs1blxw9mvBTdDvOtF+R1hSb47QD0I0SWWWe3GtyvBYImhKiTNYn8BE+xeW6a7sQ8z3dqCW/7LmOfeR0s+ObNbF7qrXrQipOmqqlMIArMZ88k5imUhfa2l+fHB7u2InyFzZbRid6A2zW4d8DS4zKaf4xFE0emHLkDVBbCvYO5v3qHRbmorVcgr/WhX/3V6gMjGOfBiKTllvKjJIodQ4H+9g6VzeLQrBAU9X8utY/Ckku2ARTw/OXkuVwaepgbHWiZe7AYZdC2ELN25P9TQpqLMb/nmxXxg4buoTrkGwxcOCrbyp+V9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uYouIMKku/AcYkJIDKCR8v8vQZRpaK05uoDqMQu978=;
 b=H6tYoyV1pINe3V6gS3/leExZ6BEEjuxkaz3+2FC7Du+NSyp/jDjJlE1zvF9LzhZfQmVrhUEut2Y1Wpe63U2j4LfPLl3fKXEQDCa01vlKX4cHcmuZZCzT+x3DsHYA/CqQPA0hXjyEAwyndhqLr8AeEdP2PW5GD+vZc/GNIi+wizCE2vVqOFrmbWISTmXJNm4288XFBalC1WdnXACwBiMt/OAWN2MMj7lHnkNj0vW5a6WgA99jAymUlm8kAsXZ0UHAlBWx4rqdnbdmlchMMi9FwNZk2QS4IlYw89ip3Xnd+vfieN1ue3VqzdpiMXG7hTs7zj5VpmsF98E4Ye9FnjFdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uYouIMKku/AcYkJIDKCR8v8vQZRpaK05uoDqMQu978=;
 b=Qe2nk2v7PZ4BlFDrPA01/UogopCzCrhxZF0P4/MFX5tD46iljec/I32mqF1P5dXO+YjGFOnjydrQupKTYusyWW4YuJxCQ3V17n52y0e0o5UjfWrpx7d+6EF3mRRXs7K1iVnCqebLxYoFhzu00HEJHwynoEjo6/8k4WhwFv9+nHwjSqqYWeIL+rq+Dq2qy2gRcODnlYzBCfp0IcMCjMEntVV+JTxj0ivU8E8kXntkiXLdRrv8mzy+lOZ8bOHi6jazP8N1uaWD6+nxErgT5LotkeQBH5+iZbewiSHo+GXuCheFp6vRBKK0E6r/5Z6YewKwd9qARlzQoNMbvqNz9zHJIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:51:15 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:51:15 +0000
Date: Mon, 11 May 2026 07:51:11 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	tariqt@nvidia.com
Subject: Re: [PATCH net v8 13/15] net: warn ops-locked drivers still using
 ndo_set_rx_mode
Message-ID: <4zgvkwdwqzgafohvo3bjyfx2fmdl3g66uj4gzrskmbbnbblwo2@4m5bkkexcywh>
References: <20260416185712.2155425-1-sdf@fomichev.me>
 <20260416185712.2155425-14-sdf@fomichev.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416185712.2155425-14-sdf@fomichev.me>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9d8e4e-1be4-4e90-9e23-08deaf3213d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AQRhhr5gItO9W7QtbaJB1SX/KIWJRj3uS42W2zvR5PvCHUGLClhuB9wboQ891Ani9+fS/VE3bbDO0pbuNNbmfokgUfWFfOS/uiYp0LHkjgcdKKEoO83euRoea54FCNhtCpoV/ARx5SMpwV2ELrEILAKoToLNEWU4KxX2nTQYgGOwerCQLjDqLC28YaE/vnw33EQIDd1ijuOeAaVa0CchWo1qKgsufb+duSNkNvqQiBIN/Y4mLuTi3AQnvPMQZ3cG3joo/SK8fpQ4CB8JOvPCpl+n2LgNpmFIFuYqocfH0b038pIEc2zCsRkwnfCe/YTlpp+1yHBccK9fbTJISWvbT6PkuMrIJXgQ4rWHTXxaKHcfP4Gfwjs2yjzQ432qksCqpmLACFVGFFs55pDXJQfw9b8iKiQLBu2tjRbAFQuLA8Ru9ewAYDDM2gHOLRzgI9WOkJo0OgdgyGj4umieiGTBQZARjlOUnUt5oYY366bxBF7gCLLCTh8nRXawlmLoZhnGlKvR+xwdAyNSa9Kv5xMUxcRZvN4/GtU+iN2knDQf7on0RZ4SXKOn4IBNVKj2pzMIu92UAUA2K9APs2iry6LxgWugT3GmbstikDW3/ECayj4k+AuGOI+vU2ofo3iV1ItaNgLmIH9Oj85BBSb10CdcB81CCSfirAZz5uXDCQ5BKQTQ1JoMrRDX4VnOGPaqgr25
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJtIfCD5f4joRMUIJzFeJMHjEPL4iAIknNmp/d+AVWQI4dCVFj73poDuXg3s?=
 =?us-ascii?Q?pqmAxZiqKBu+Kgq66nKsbR3lJ6vHRyNk/G+SBE/3tePBPJHp6XwocdcRdKGs?=
 =?us-ascii?Q?TxPczr6JyIvjB6D9LsF2iHESwRqIoG3RBYc6ArQsu00iH/xiRz8fD8oxnBYp?=
 =?us-ascii?Q?55qBywjM202XP9DAmYobM+c099vGAyPniiYbow4YXIobypeF+GXAg/RSgy1M?=
 =?us-ascii?Q?Q1ppSJekpYntZlktPEh98OhV1/wOTlJjJO2h6/oHD6PjSmWzsfUKe/1b6d0L?=
 =?us-ascii?Q?bBVCjyZH1OsVXCmkn/U+oUzrNJzpEpj4udbz1j4S7m766fzcrfccMz/93PHn?=
 =?us-ascii?Q?NLlO4x8/b63VcsVa7gGDHglMFPGo6uqZBiqoC+CXg6Y2IQzeTEOWDUEzBFkM?=
 =?us-ascii?Q?iuPZ4xOB4hOk2wqTvusF6tAlprhj14tDo0WU3aQ3Bc/Q3e+52ep9Yb3kLUk1?=
 =?us-ascii?Q?WfzxFgpc+mPLLmMUyEkNJBmgemzejEWHDEuCgJtsjf92gIeMYX/TrUANMpbm?=
 =?us-ascii?Q?s1a0zQFxTHRVu49p3Q33uD1D8xFnzKLF3x2V7JNp/XavB4dN3SPOXKiMyl8T?=
 =?us-ascii?Q?wvUHrzr+fUWs1tItRhBPa9hZAbnrsO15fJoIEE7GErmEMlkLlq2cncLLfviF?=
 =?us-ascii?Q?vcLs1xoMw1wVTs/ptdYpYKYOjQMIWiD68CzaiIN1/926Io52dEJ034mnrQnb?=
 =?us-ascii?Q?n10DpimcsgIR5MdlsautCiQojc6zcJewl2y1J40QqU8iiT5E9JoblItbyS+O?=
 =?us-ascii?Q?y+q8ysrhESOwsVvXQiznkatU+fmovmx0Fzm3xuVeTc7uS2EUnhIJL1FCRuxL?=
 =?us-ascii?Q?UseK/3ILuz6qXIsbjHj8cgNvJ18ZCPptzW4InnsWtJBhba5Wh7DsDhPDcsFp?=
 =?us-ascii?Q?aSnQBhUi0bqAPLPvVO1khtfE2bR6wqlWT8NJIT1iObsKi4hK5tkVQCY6Eb14?=
 =?us-ascii?Q?SN6kxkMl3994/dlNQDv1V0w4ajdcqDYEfbhZ3yrVA4uH5ZzZtRMODe0Fduim?=
 =?us-ascii?Q?vOlFlLQV7E1SH+Ixxy/Zd3Hdr98Ycs9uR7u5qLzpGOrgQaaaWsd0N/WkcOUb?=
 =?us-ascii?Q?xlqxgntPRwSXXiijI/6w2bk4YP05tlWMrfZO8eKiX7NLCeGE73+e5F0/2THB?=
 =?us-ascii?Q?/AHR/g2juJ2l0I4XFJt9qKF8kcPHWCKBLyXgXntv7XEt8cOtE6yoykjLRaxF?=
 =?us-ascii?Q?yHwzVY1IXUrJJnCQBP+VpX3zAgshqAJKVXiI8vgVf9tl+77bOH3rMPFY5x+E?=
 =?us-ascii?Q?dRp0Z7rCbtjte0BOBWJG7eZ6lBdU0ZFnMFAXPxpzRc08NgiqNlEBKt4Vb10H?=
 =?us-ascii?Q?d957luXXsBWaCi7Fo5n2oufbEgpoUfcACh3UATipAh6G3d11OAsnRigLZm1f?=
 =?us-ascii?Q?UTkOKZsaOCghSaGrQQ+Rr8vO7+cIBdAaaCybeZ7kKqzuGwo9nV28pXHe2Sik?=
 =?us-ascii?Q?971TrZScS6H3QFXH+sU7OBj+upMpQ10Ln0eETrtkLj+0+o68BrNScopKP3V4?=
 =?us-ascii?Q?d/PweaUkMLQMevWQu0zQtrwBeYVo/sjScl6mQyOcjEvtXsPD7+V8Of47rMCQ?=
 =?us-ascii?Q?jjgo8dHNCQHOz1nuGq1PDdWWPeuCCOCzrKbf5N7Dq/9h/AR3jO1+Ocq9Hzeb?=
 =?us-ascii?Q?ZhGSdgioIa6g3EaFMtQzQefF0OpATrzSw0Kiqg4pxpY4UNDpsVcPRMpIk9sP?=
 =?us-ascii?Q?ftFSIUt3QGulKBcFgf6agG3mfIEuqz5OLBp2EBSbDw5kQDoff4GxSAMlESVD?=
 =?us-ascii?Q?VpgAQvc/fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9d8e4e-1be4-4e90-9e23-08deaf3213d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:51:15.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3cTnPhRwPMRYS0Bk4d2hQ7K9Izwsda9mAiHXI461t4AyFcT7QK4Qn02wbYA5y1kt3BMaXfDibHd5i/giUvRtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
X-Rspamd-Queue-Id: 87D56509B3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286503-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,fomichev.me:email,qemu.org:url]
X-Rspamd-Action: no action

On Thu, Apr 16, 2026 at 11:57:10AM -0700, Stanislav Fomichev wrote:
> Now that all in-tree ops-locked drivers have been converted to
> ndo_set_rx_mode_async, add a warning in register_netdevice to catch
> any remaining or newly added drivers that use ndo_set_rx_mode with
> ops locking. This ensures future driver authors are guided toward
> the async path.
> 
> Also route ops-locked devices through netdev_rx_mode_work even if they
> lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
> on the legacy path where only RTNL is held.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/core/dev.c            | 5 +++++
>  net/core/dev_addr_lists.c | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8a69aed56fca..d426c1beeb76 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11360,6 +11360,11 @@ int register_netdevice(struct net_device *dev)
>  		goto err_uninit;
>  	}
>  
> +	if (netdev_need_ops_lock(dev) &&
> +	    dev->netdev_ops->ndo_set_rx_mode &&
> +	    !dev->netdev_ops->ndo_set_rx_mode_async)
> +		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
> +
Seems like IPoIB was not covered by this series (see splat below).
Understandably so because ipoib_intf_init() overrides mlx5's
netdev_ops with its own ops that implement .ndo_set_rx_mode.

I have a fix pending that implements .ndo_set_rx_mode_async but it
simply schedules the multicast restart task like before. This is done to
maintain the assumption that this task and others must run on the same
order workqueue to avoid racing with themselves. The race between
ipoib_mcast_join_task() and ipoib_mcast_restart_task() would be the most
obvious example.

------------[ cut here ]------------
netdevice: ib0 (uninitialized): ops-locked drivers should use ndo_set_rx_mode_async
WARNING: net/core/dev.c:11366 at register_netdevice+0x83c/0x21d0, CPU#1: (udev-worker)/237
Modules linked in: mlx5_ib(+) fuse rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_core ib_core
CPU: 1 UID: 0 PID: 237 Comm: (udev-worker) Not tainted 7.0.0_external_tested_net_next_2026_04_24_22_03 #1 PREEMPT 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:register_netdevice+0x842/0x21d0
Code: [...]
RSP: 0018:ffff88811acc70c8 EFLAGS: 00010246
RAX: ffffffff844403a0 RBX: 0000000000000000 RCX: 1ffffffff40774c5
RDX: ffffffff84442360 RSI: ffff88811ff48118 RDI: ffffffff85ce74c0
RBP: 1ffff11023598e22 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000005 R12: ffff88811ff48000
R13: ffff88811ff48118 R14: ffffffff84442360 R15: ffff88811ff481e0
FS:  00007fab057efbc0(0000) GS:ffff88850d432000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560448cd6ac8 CR3: 000000010d8b0003 CR4: 0000000000372eb0
Call Trace:
 <TASK>
 ? unregister_netdevice_queue+0x350/0x350
 ? mark_held_locks+0x40/0x70
 ? lockdep_hardirqs_on_prepare+0xde/0x180
 register_netdev+0x1f/0x40
 ipoib_add_one+0x35c/0x880 [ib_ipoib]
 ? ipoib_intf_alloc+0xb0/0xb0 [ib_ipoib]
 ? rwsem_mark_wake+0x930/0x930
 ? do_raw_spin_unlock+0x54/0x210
 add_client_context+0x2a0/0x430 [ib_core]
 ? remove_client_context+0xf0/0xf0 [ib_core]
 ? rwsem_down_write_slowpath+0x1880/0x1880
 enable_device_and_get+0x19e/0x330 [ib_core]
 ? add_one_compat_dev+0x800/0x800 [ib_core]
 ? rdma_counter_init+0x13e/0x390 [ib_core]
 ib_register_device+0x732/0xb80 [ib_core]
 ? rdma_dev_change_netns+0x1f0/0x1f0 [ib_core]
 ? mlx5_lag_is_active+0x7a/0xb0 [mlx5_core]
 __mlx5_ib_add+0x88/0x1e0 [mlx5_ib]
 mlx5r_probe+0x26b/0x750 [mlx5_ib]
 ? mlx5_ib_add_sub_dev+0x550/0x550 [mlx5_ib]
 ? kernfs_new_node+0x13f/0x1b0
 ? kernfs_create_link+0x16a/0x230
 ? do_raw_spin_unlock+0x54/0x210
 ? auxiliary_match_id+0xd5/0x150
 ? dev_pm_domain_attach+0x59/0x100
 really_probe+0x1e1/0x900
 __driver_probe_device+0x1dd/0x3f0
 driver_probe_device+0x4a/0x130
 __driver_attach+0x1ab/0x4f0
 ? __device_attach_driver+0x2b0/0x2b0
 bus_for_each_dev+0xef/0x170
 ? bus_remove_file+0x40/0x40
 ? bus_add_driver+0x1e3/0x500
 bus_add_driver+0x21d/0x500
 driver_register+0x1a1/0x350
 __auxiliary_driver_register+0x14e/0x230
 ? test_ti_thread_flag.constprop.0+0xe/0x38 [mlx5_ib]
 ? __SCT__tp_func_icm_mad_send_err+0xc98/0xc98 [ib_cm]
 mlx5_ib_init+0x107/0x170 [mlx5_ib]
 do_one_initcall+0xc3/0x4a0
 ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
 ? __create_object+0x5e/0x80
 ? kasan_unpoison+0x40/0x60
 do_init_module+0x27b/0x830
 ? free_module+0x3f0/0x3f0
 ? load_module+0x6792/0x69e0
 ? kfree+0x164/0x540
 ? find_vm_area+0xe/0x50
 load_module+0x5005/0x69e0
 ? module_frob_arch_sections+0x20/0x20
 ? __vmalloc_node_noprof+0x8a/0x100
 ? security_file_permission+0x2d/0x60
 ? security_kernel_post_read_file+0x37/0x70
 ? kernel_read_file+0x3d2/0x860
 ? __x64_sys_fsopen+0x190/0x190
 ? lock_acquire+0x10e/0x320
 ? __virt_addr_valid+0x14e/0x420
 init_module_from_file+0x153/0x180
 ? __x64_sys_init_module+0xb0/0xb0
 ? do_sys_openat2+0xeb/0x160
 ? __virt_addr_valid+0x21c/0x420
 ? find_held_lock+0x2b/0x80
 ? idempotent_init_module+0x5d5/0x750
 ? idempotent_init_module+0x5d5/0x750
 ? do_raw_spin_unlock+0x54/0x210
 idempotent_init_module+0x21d/0x750
 ? init_module_from_file+0x180/0x180
 ? cap_capable+0xd0/0x380
 __x64_sys_finit_module+0xd5/0x160
 do_syscall_64+0xaf/0x960
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fab061be18d
Code: [...]
RSP: 002b:00007fff0e4335a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000557665c7f6e0 RCX: 00007fab061be18d
RDX: 0000000000000000 RSI: 00007fab062da07d RDI: 0000000000000010
RBP: 00007fff0e433660 R08: 0000000000000001 R09: 00007fff0e4335f0
R10: 0000000000000050 R11: 0000000000000246 R12: 00007fab062da07d
R13: 0000000000020000 R14: 0000557665c7f9c0 R15: 0000557665c80e00
 </TASK>
irq event stamp: 88443
hardirqs last  enabled at (88455): [<ffffffff8185888a>] __up_console_sem+0x5a/0x70
hardirqs last disabled at (88464): [<ffffffff8185886f>] __up_console_sem+0x3f/0x70
softirqs last  enabled at (87614): [<ffffffff81700a39>] __irq_exit_rcu+0x109/0x240
softirqs last disabled at (87593): [<ffffffff81700a39>] __irq_exit_rcu+0x109/0x240
---[ end trace 0000000000000000 ]---

Thanks,
Dragos

