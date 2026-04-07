Return-Path: <netdev+bounces-275892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC/rEk+61GnQwgcAu9opvQ
	(envelope-from <netdev+bounces-275892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:03:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3F93AB124
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CA230056C3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BC3A257B;
	Tue,  7 Apr 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3APpBb4"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4433358368
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548999; cv=fail; b=I6iKrkw8FrwnOzqPCjgt1eJR0rsEa6QlDC4oBV2A0NM+T1tyw6wQAAXqRR5TL/AJ10AEXjI4c4kP36/mwj+5FOHYuDfzzjNhbVRViET6/VHR3TaPT+wKZPcwypzyYTKYeOn97KsWjqHg/whHqU3cU+r09qc/HJdi9m29R/HsoUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548999; c=relaxed/simple;
	bh=/UjrHCLLL5LTL8P4nKWFfcgtWJ4TNiKVw62MtEaprWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bl+yKzx3WNXs6LzbJg9FUocbWwBgrYQpY9U/6hzTLTsGxvgmm4jaMBKYyHRjGhLtOmfjo3B7xjKzwfwgT+/DasdIKL8Zy6y3fm2T9lxsBJi6DKHj7MSLkuRvV6j66yPVEpuNT/p23kDyT0Xb4dM88NUNok73pmYy9VK2uaRSDHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3APpBb4; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDak++QCtZLFU4gcnaVMnRE3lEc0FwnCuMVTNeKOsRjrW/FfQsm7Kt6FOkiAhDxursnefIIrYF5ODuJU+fH0kkKmkHN/OLAYZ3ARYOe8qZdf9RcDyA0GU7FFwRbCTIDo3dx/nf04WVWHqPkngh+dYb9uQ7z9EK0h0Gm14ccdioxLj+kbtLuQ5u1MfX5vI9gUo0TgrEbjHWMPMXERAjmLJhmMNDsaem2gLzue+Uh/hFQ2c7hSKevxTvzejYlM2oBlOjsKLh1QZKV4dnSmSptzpvkH+JsM9sAcC/YyUA3SoNBVMjh8jHoK4DSvaYiHTsmyKPWfkFgwJWKu9oTVVdpW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD5nC1tWLODCqshlUE7y8u3VCF2Kh6LtHqIvGkJF1UA=;
 b=fTIVTHbJg6KJl/MXAPjGi8UbXb6EbS4jVrblIzs1QDfLWDMeaAFKjeMaU3u0e6cyn4Nn5J5LPTUpovmrH3tMP1qWLfJvQbS9/EWQQ2Ky7rhbFj6p/N1wGMifmNHWhC5q+HVnvGhwCkFKmT1Q/MRKhrWvwYfDH7OlJ3s60ukRVmQrji/TYSMg1NK9VseVVBHLcMN/4+YbvsOTrTbcgEx2R9ucDKsbSbWQ8ouBpHaScHQQbrfw8ZgU8vFbH1QQ8ofatmOZ2wyMMI1Y+YVb8cJ1WhWZ1fy5Ga+GbLXdIbgj68GsHJ9f5WsdmySAe0gYHtLeCE9TB3iu3M0MCsLRJ3HpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD5nC1tWLODCqshlUE7y8u3VCF2Kh6LtHqIvGkJF1UA=;
 b=T3APpBb4TfLavH0Steimg0PtZcS+ME6lB+5gvme6j/iLNkvgZzaP9pVhep8Y8ImVil3EThf7cFaEx3OmJMA0LGwMZW7r+q371GylzgK+IKwWQTlTC7ShJGybHsIGMCdZiVHofTLOxp+x8G0/lu/tTyeWZffPzjXB4fIlM0M8TKU42+H5JMywlvNmFFsRR0PoV6bXdQSyxgd5gtiVxTeDw5VgjjLetcyIKfpBo9EVTrhKB9yCwmID/JSqjquL9U8Mvpy8sO6r0DwdgWDsxa0JkhdF7t9QJj3qi8YMNzLYn5+0lNZfi5/gIYgU5l7R2OQUq4pWXjiZ6i1bvOeE9fgM9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 08:03:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 08:03:11 +0000
Date: Tue, 7 Apr 2026 11:02:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Ao Zhou <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@mellanox.com>,
	Jiri Pirko <jiri@resnulli.us>, Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>
Subject: Re: [PATCH net v2 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
Message-ID: <20260407080259.GA760990@shredder>
References: <cover.1775062214.git.royenheart@gmail.com>
 <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
 <20260406154808.GA714138@shredder>
 <b6cc7bc1-f18b-43d2-a21a-c964466fa882@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6cc7bc1-f18b-43d2-a21a-c964466fa882@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b18e11-4ebc-4b1f-eab3-08de947c1c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WIXz5kQbznqtZQR0weVrmGU32PKX5jw0mXH4WkTOnoCehTiuAPUnhb3HuiT7beesGVSE2lGa7B1X+WwIuOZK1/O+pYfcopdqXu5bExineDcHK3OdJO9FumZedsYM+NuXWptJ/I0h+JKUiFu3oFlxJQ+SLvxcHTB3MIrVO3fFKyUDqhavHhYF5cFkfSKiM6O85RFLxWG/FHdpvctwVIyMXKjIPf+ReH1w+m+GtxtrA99fcVQG4P+opD/FLIzwqBkLLXTcrcCMTUFSxXvO9zkcOSy8SyxbZS/aqGB9OgodcbhSdM3TNlli++mZVME07JwiL76jEBdDAkfoWiLKoiI6NINxA6ZjQAsky9Nonizx1qwYiLks200pI9gmWYdzhVJkv9CZKVQcNIwpgQTMHtX6tRVTyRXT4pzQH2Lo1tUwu2Iz3SP2BpTcIMX3h3fbr2IoAwkCHm2ueHwkORf9UCDXXHpZKYKd+iWTUyNMUbZ/gK0VHaimtIVDoQRX+ciwsTN/4hreySswd46/oDY3lXtS+w0T8k4KFpyjlgvZpZVSxeAtPiWtYoPwbSBXfXzlcn4GfOh7Vqux9wBKaIOTMYZ2lABMBdt7arOwzTcpa9Fnw7DXdpMD7+tiaPqSpNeG/J6m8OopFmn0WpXhUJi5H/Dt4nngwelv6+XoR4+b/X66M1ICnih64+1FnU3mkrEmkgK5o17/dHi98JrPWW7dRrraKzZMpS7lOxl7cIVcvxFZBkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zT0DirLQZ7pEEciyjSIFdcdqf2vZwE879RSm8j8fS4EHf6XtWDSIdK46glXm?=
 =?us-ascii?Q?L241yN65fieA7RGDkRyJ1ogjjKErSD0HedLjJJHq6DVUrzeyJSdBTqDhas7w?=
 =?us-ascii?Q?SWUmXlJDSxlJzXYO24sQF4uEmcDwSlPtehCrJ6y7vf5I+uDIhkypbyiLG4h9?=
 =?us-ascii?Q?G8+efdSH5ssJp4GP6aWk90HM/Nm1fC9MFPRz0wyiRIgn13PFWCsm95VN5WZt?=
 =?us-ascii?Q?RafsCp26zK09C1YGBL0RePQyBuq7VthN3e59pI51sYe0rptWxYWlReEW+afJ?=
 =?us-ascii?Q?rmkT+5MM704cUqmVNSl9lifkWN0fwG0MWGSEb42ld/Cd/+NzhzHokYRpIlvH?=
 =?us-ascii?Q?l/mTn8JMU5BVDR+WaWc2DsFXpNfvpsTRNxAWwUUbAN5wyOxZ+Z3ZsPhiPLuG?=
 =?us-ascii?Q?uDbVJCLMYHUcikWTHZLHU7joWYGdM4XBz1IJSY4BFJn3sPIZxM2hGE5Joj0a?=
 =?us-ascii?Q?ha8e476O7JX06iMoJdJeLstb1jTMak1C7v/Q13nPnoMN1i+d+bO2I+CTbiUX?=
 =?us-ascii?Q?Pbuu8fjBgF92Dlp8Usqcvfb79s3suU096hZ2hzTYjCkK5seevX6a32Rn2Crj?=
 =?us-ascii?Q?ZLLltRCajoXB3JB0cTloI3/hzPzi3OUzq9v+tDRCq4WIx7GBmW2GyFsVJLoJ?=
 =?us-ascii?Q?BaXQUbX7s6Q/jcI+SfZ2VaBn2O9b2IOItTbujLPNOC5HhxjQMRN231UlSVxh?=
 =?us-ascii?Q?XOH15PwvVd73emtvAwIQL2bliSYKWsuuVurSIidIQMWVYfbdji1KCUaQ7pbC?=
 =?us-ascii?Q?B5XseoyYeWzb0XCu671NouOfy5Iojt6Ph1BC06re+kvMpbyi84N6bzUoCdoo?=
 =?us-ascii?Q?/LgeJFmaSb3gTGucKvUeN4Q6aIjLk+gwSEyDcnFhxz77tqW8WIzfzOPHHj27?=
 =?us-ascii?Q?Eq7vJgRfNVlUuWVjc2j2xxP+YxU5bNlZmsEHRWo+6e0CJrz1dYrLs7mkbA5W?=
 =?us-ascii?Q?JSbn94jsjw6E3iqmMAmwtgq713hKDt2BQIydttCgWXY2ajTrFMzMkOqPfu1E?=
 =?us-ascii?Q?ztlKEvEqQIpXcf3ivePmHcgljGwEl06T8kmeI21ZrYN9AlgLcHx+Kzwkr1+z?=
 =?us-ascii?Q?OteWve82eo4e1ZqWtalNnxGqYnGWDaz6vuWdEWdV001bgmtZVmWukL8UjxtX?=
 =?us-ascii?Q?EFX2JW4VPL/LBLdV19Po1GsAFlVSIefIkaZZej2AXVuDnxqMnOAtVdFozv+8?=
 =?us-ascii?Q?iKKT6tnxeAcnBgUUid9ug/86bplNRUF1ZOKfPTJrk/PekF/iY1ROghFXQ7Ty?=
 =?us-ascii?Q?iCHfAEBXupG5eGAV3A9sitOFIf9x9pINvHP5zcyCPx+k1OTT5p+1LQxjVmjq?=
 =?us-ascii?Q?Akv2T4WK+JoffUI5Bl5xhzpnJy7XZUScDwRoCSlu0siBwtBA2iZklYEgVwqi?=
 =?us-ascii?Q?rxcf9rFg10j1WnIMsOLZdKh+hHQMvNAxpa5cvQ5loztLRTng4U69bDhYZp1A?=
 =?us-ascii?Q?loLcxiTmWjHoyoALzGDhZGI8U5eCksgjuSLbVEvbh+gtxD0H8VMmrAtLI0e6?=
 =?us-ascii?Q?1k1tV2/njkEuS+8nUMpvsvGwAzRQu2dbrEmarBVs4CXlL2Uf2h9IFCLtNF+s?=
 =?us-ascii?Q?NC+kPU1qr5hpF1lheBViftlyqvWN17mKfvLJTnA0w4KR7tWI5328rTle6nSZ?=
 =?us-ascii?Q?/gEIzmM0HRg4o6o/Abz9wmyr95SdIzK2JWkpcpCPMYgw67zJKJ1WW0hMzo7y?=
 =?us-ascii?Q?RFFAy+tMEpi9FYmXYeMcTDQqM1jGVi1vYNSvj2j8bw+AfJA0jRaR5ne7auUv?=
 =?us-ascii?Q?mMSeJQOkIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b18e11-4ebc-4b1f-eab3-08de947c1c8a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 08:03:11.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ2j95AVMbVef6Pd+S69tHY5DxFZspjkrjEEnOngZYP2DzuGUcD8MeFIKYYmhVmGhLAnGocS1Pnvij1Ut622HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275892-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,resnulli.us,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 9B3F93AB124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 12:14:15PM -0600, David Ahern wrote:
> On 4/6/26 9:48 AM, Ido Schimmel wrote:
> > 
> > Don't we have the same problem in l3mdev_l3_rcv() and l3mdev_l3_out()?
> > If so, please check if I missed more places and include them in v3.
> > 
> > And I think that the part that I was missing earlier is that we don't
> > have RCU synchronization in the unslaving path, so an RCU reader can
> > either see the original master, NULL or a new master (e.g., bridge
> > instead of the original VRF master).
> 
> synchronize_rcu after the unlink (control path) seems like a better,
> more robust option than adding more checks to the datapath.

IMO it would be better to proceed with the original approach and look
into adding RCU synchronization in net-next. The original approach is
more surgical and the pattern of first checking netif_is_l3_master()
already exists in other places.

