Return-Path: <netdev+bounces-256224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACq8HnvGgWk0JwMAu9opvQ
	(envelope-from <netdev+bounces-256224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:57:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB25D72FF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79DE230BE12F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ACE39A807;
	Tue,  3 Feb 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pudVH0N6"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495639A7F5;
	Tue,  3 Feb 2026 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112525; cv=fail; b=Ls+VeMK1kBn/4vf0u5K1A2alpfqyWzpMt2Zzie8WYsBJDhNF/M0sV5NNh85SuWvNoldxDnmFti7UFE7ziuN/mjKZlhfxh4HSAjCUGt/zGHtGnLnxKHWRAOJQ2KOsIEWhz9YlOGmpQ8/14OZJ90UNU3PVZ441GgXPnKaML2hAiMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112525; c=relaxed/simple;
	bh=njicOY7cKSQ33sB3bQ2RycEQ+7Lns5a7AfnPu4cIxV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YGbh667M3GCRFNRP5sRP9imc6qkBt/UFJTFZ8uD+zbn1yiqQF8F+hHfL6c51SYvgCFL4QdQVY4xzrjnUZsN2tKxw4rep8pDV+uYPMC7Za4YViIL/W37iZH36Lpvj5xyHC072AzlpbAScPPfFC7mJoOrx0gi6ptj5GrAdw8x+mk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pudVH0N6; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykxEG6z3k91rR7M7k0g668riQyRJCk28zdTtQU/8OFXN6/dusrDuMRdqsjUHgYTALckRm8OJXCa6xVqqJyI238BAdbb3LDu3+lRMj4uOqDl4IzXBgne2kawyIZNoSZnfBNxb08OHyzZLMe+rTTdFcbcbRp0Y/1WZ5fCHTKUshVTZcr05fG/2ncfEfbUma+MgxN5I7n22R8F3D6vRz6a8dgtBkQyk5ZWEHjQRuIJ7cYfW2j+8EMjwhwj/zHJa7KqvwxwuE9y06MjWqIzoR3PoDwNDkhrqWN6NDg3qMAGc9uSxKn8wUHpDu5mCDqH7BVwUxhbhra3zBJbi9kX5KSUOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuilmtEfeLe8eZZk/F5BIHyzw3LiodBz5REwVY5JWGM=;
 b=l79Oa+k/UAjSquhULgw51Ro7+8Z0eeq2x1qFlMYYfVsnYEAOpO1S8LBR2v+AlH8YZ96u9/NZY3p6spcKqlRTJ6+EsgKuzuR3nax5RdnYuKs2lMy9My9OX2NPdHEwDc6vaHCe5TwTWBlWjekco3rLL3dBs2V1ZC+TijDX5f0QtW0ZlutY+GLtFIV2bVfgCHPXzn98XLdYgapXQW/j3NSgGSyuUJJBDZjYqnpRNUuUwtTaN9KXFzy1Mz07ZQc0NK/77xy8sLk4zwInlAv2ROuH6twFd8wYLPmpU35benyO9g64li6gwDdJ54MnfehD+jaeuDkGjXIBWz02ZFTM76RS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuilmtEfeLe8eZZk/F5BIHyzw3LiodBz5REwVY5JWGM=;
 b=pudVH0N6heh54lX1/BuW2NiZ9gMBRpiz8Ee+jAz2aNtmCB2L0mc57e3bqNOPak06heM6bCF1hNVXlJXWBHG8LyxR94Ph7OLHPuIU+qNyfvE3wJrJTeM5ULKDQvmwuiJ1FPgcGMB+MVkNk05NkNX2ziPCdZQ+fUyO57ReRN5MqaKKuO17gXmfko4Kq4cgyYYKJKnGBmWxdrrKrmVf3b2ewurUv4ei6J8s0Dw3594832xO2DPXs+LbfPxJrP/7Wf08hKeIYGhcp8VbiXgjF4c02L6RDSFu6LoacpwqaUA4PvnqShR2hYCj+Pc4rI9+U5JoTCYgvCNzRH0NKkOMmefyhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:55:20 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 09:55:20 +0000
Date: Tue, 3 Feb 2026 11:55:10 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Corvaglia <david@corvaglia.dev>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: bridge: use sysfs_emit instead of
 sprintf
Message-ID: <20260203095510.GA60009@shredder>
References: <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff904a3-c2c1-4e6d-53f4-08de630a575e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kaIbpWBFBLoWQZcslhnQ4xa9pwavPmogosA0w2iFVEzFZQykDOc2Ik/WQNt2?=
 =?us-ascii?Q?e/dH9BjUK3vEuPIIIIpbT0YuelJZ1EYC9AjkH/Fw6IQe5LHeFqyvU3h+Ewmj?=
 =?us-ascii?Q?DcWHAqcIRHi+TqrsjiMzTRmfhnsYGbmyB0Edz8ImCCNeypm0GmTuSwYEBKUB?=
 =?us-ascii?Q?4/4H1C7+K7JenVXrbh1VpbTpq+AEwbTxdZW0BY/pXdSYGx5khztUf7wQdmqR?=
 =?us-ascii?Q?hlxSah9opNFjXFDsdQjJ0NcV4/vEhdygUCz2foo1bTA+ZaFZpU2BwXqvDj0X?=
 =?us-ascii?Q?UVdrGnffYuI8MmKi8N4y1ipdKlWFFbeXsZSwD9K3aBq8Z2OVQMl0UGOu1k9t?=
 =?us-ascii?Q?pfoYpr44nAyEZ8VCwS27vc8FmQqHdQNN5wcqXdgQSdFeGwUYuoZehgcRDE6Z?=
 =?us-ascii?Q?rwjOnG49EAxFd79pau5KPPSbhgIKd86Ad+sVfmhPkY35fowsW1QUckeyk191?=
 =?us-ascii?Q?2pbCmwnDZQxtXERXMcttNA3VuRw/08LwCzOnTQUnduBxLxuqRLdqLRzpORhF?=
 =?us-ascii?Q?Z1OwwH/XbVjoPPPCFHtpywkOu9Xc7AAg1iFp0GWvSP5qIIlIytvHtHs03EFM?=
 =?us-ascii?Q?ezXi23La6iUNUFQ/ByGoZsOm8AO6NAPOmyYZ2jeOnXF7kHq/Nt9jEz0Oqs7n?=
 =?us-ascii?Q?muAiQ8alGVPt3HJcJ/UYGoLGGfkea1SmZlW8iwjp36slRy9B+ZqVJzIXg6I4?=
 =?us-ascii?Q?cHtgX66c3yPVmJN6FUHe5HlFm5ZVZHTps1huO6s3+Uo+OGyYYAfa+Zl/6Nbt?=
 =?us-ascii?Q?KSaBVE5KKbP75qYY6BGeXWEmXmLwCKpacvuoE0FTQAEa/Ht4ML2ZZG5tr1b6?=
 =?us-ascii?Q?TvDaCxKpoL58iDbTWL4H68DcAaaZIjKtJCwHGgQLNcdiHscCot/3MjBjsg07?=
 =?us-ascii?Q?dyKWamfjmDEk5XtYcWHynBtRzDD95KNLJNpnbOAyiNXY1SGDi0E3o7NKFRHe?=
 =?us-ascii?Q?ipzH3MyIAHZ2OtweMtQrpEVmGxlu+yXlGbp//giWNvdrnlX2dkSxchL5UHML?=
 =?us-ascii?Q?x78+7jWufRdklTKuxLGAvPbMvXz+XMSrdkKdLAtRHM4D3jEuF6ZyALQo+iSw?=
 =?us-ascii?Q?FtIM0u+3WG6nt+E9pCoMDrE9NZ9hgEnAuWATB4rRBSOHP6rnNm3bjyVYivpJ?=
 =?us-ascii?Q?6yoF3xrwYPqjlXAc/hb31X6D/q4BL0p2B2T2w35yDMdvE0CaE7GhhX7L9KeX?=
 =?us-ascii?Q?mPa6YGw32wopry2bdAjwCb7c868ecj3sI3v8UG2JSAvxwBduq1wFKQXxYS8j?=
 =?us-ascii?Q?gO8nv2ZQGtDn4UwGdHwd8fYH1fW6QI5VwegO+Tja03nz65ffdM898Uy3PP4z?=
 =?us-ascii?Q?9dAuuU95OmO6KiYGLx44ztcu8nW0T3F52T2eOQpeHoBa9UkwF2AfQf8fKMlW?=
 =?us-ascii?Q?8jtVRfWymhFyEaPesaIQG2oMFcpQu0Sd97if/GJ5xYalNmkQ+zaZ6q+lLcKg?=
 =?us-ascii?Q?GZ+odznQACxfHLpdf5tlOhsvz2rpEDXxEwRcJqN/pmj+CzGZCvmMvF7d5fIX?=
 =?us-ascii?Q?J3mh8X2plruVWTBqtSCrk9KnpsododyL2BFTY+6Y11jJydGep8KVIrTSaBsv?=
 =?us-ascii?Q?na3RNDxyWAUQGZhDT1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QUv+pdMVnIPOLiWsvqSier03bNN9w9MC/FHaijQq5GYgBzpSO2xwx4LmWos?=
 =?us-ascii?Q?SFVRT+EFSyCOM4K142+dL/kZBxyCSVa0o1RF8kXMQwPvEFbFi6KdVdM8yzXK?=
 =?us-ascii?Q?dp5w8T/CDKTEwfLIRhcwCXua95bGI1QMDCZ3OHi0IX/BOGp5AcjXAlBPc6I5?=
 =?us-ascii?Q?+crKND/pZX+yyLjlsP9Sh4KjB45JDlXZgs51HScSy5n3u5n7cyhN0JxzZAEW?=
 =?us-ascii?Q?ui4LLOxsd7Dy853d0x2N1yULF5MB4eTDwIEITDC2sZ0sK/8xO43Mgd2EN8t2?=
 =?us-ascii?Q?R3ySRi6Lz8FHBD21scLSzfX9ZrGxWnf2lJ62KH10+IjyhvdGAVHMo6NCRln8?=
 =?us-ascii?Q?6MgqQqNso7cblTZ2wnAb/3g8HANKuI7To/p5Vxu2+cKYT7I7xKHW39wHRcQP?=
 =?us-ascii?Q?wqdj/sF57okGPlnQX5JUSaSWD7owOzbbLN26UNT6g9H1fJaL8+RhQoPE7Yv2?=
 =?us-ascii?Q?Wuu5ZliRyg6LKyjCwKKjJ6aAc+2aRsK9GU6vJPDQ8HCKJ6lUD+aD39wtaUd4?=
 =?us-ascii?Q?FrALSDlG9pV+9fjXuEnVkIg2k0FL6uI0BXwoR6G3kotnHMUhMDkXzhRqD/Uf?=
 =?us-ascii?Q?7pHmAekrBxLMJHZ5iRYvFumGb1LN01ZEiiKOyBDNax5Q3fOx7Xmf+/PVNy2B?=
 =?us-ascii?Q?gf2TZQnyWqnBXXvUC1NsJ8jLH2DYiETw0j2GevReBU5dGyaEECH4FbznIeM6?=
 =?us-ascii?Q?zWbS+uhftmG6ZRRP+upw1kiFA6U+aEpXU7QSngml67Paewv/BpTGTPI5ZO4l?=
 =?us-ascii?Q?Xq5i7wmMqlrm2RFrpPsMTBJz5n/zxbDJ+kHYbbgqLSmv1/anqVNXkNxB8VbP?=
 =?us-ascii?Q?4rzaxiEclXRpKJR+FtvLhToQ5KnRkLPrOQqlpScXu3vQBDedp0LrFERDTOnc?=
 =?us-ascii?Q?al7wVNCqLl7If3H1wQInW9k+kXRFQRV7fIG6ndgi0coyxIJvHzwj/Jcz5AtJ?=
 =?us-ascii?Q?Jpi6cMcmems5LOPLYbRMfSWMlJL522tXzC56njosoCkn3ZvYxZR2OoZ9+1yM?=
 =?us-ascii?Q?nugAgXPFZNPG8aNT3uuBiBZZjyn8gnkS4JDm7n3hQ6QW5XQlmF3VKJ6C53dC?=
 =?us-ascii?Q?VaLXFBEdKe1HtJLzoeJ+9wJd+tgkDsTsmzEIZBXcFm3PxK7j1dqy7fRMgnD0?=
 =?us-ascii?Q?4SHFoACr6UMbDz6hixvLZXDY4ydue7M7XTW1hdVxX25ZiraTzSApZ72bwNY7?=
 =?us-ascii?Q?MWR3MkPTTb/HkQs9jrjNMWt/LqPs9V9Au2P965YJavbntRrV2d5Yp0Jb915I?=
 =?us-ascii?Q?05oTjK+pNAWGl56/SNj6Tvy9557dAVbYSl7Z4MkNOAEgxSgLySqaafV8vG9D?=
 =?us-ascii?Q?XQC7wazU4WI/q0CXZbQpcO19VpTSAMbdibM6VSr7SYWzHCD+rB+Ki6NRT4bj?=
 =?us-ascii?Q?HRXIf6au7AoKdZ6VDgAwihah+gA/4aiZ+j5bM5g5OMuAn/PGrWKx1tdzXLCm?=
 =?us-ascii?Q?ETegvHZ4a8IhpnrTJf4wulsYw8Md+dRJK2CywUErMKuQW/oJh/Bj1KLomFFu?=
 =?us-ascii?Q?ed6kQ1ldmpCtNkmPshFX+SWfEaMROtj7cyN9dTJJA/S20SU01pQYCke6EmWb?=
 =?us-ascii?Q?OK2EKfST9NoEeO15xcl9ZuzJgWD6dOzhw7c4+xt/LTPnBLegiklcD4Bw9rSo?=
 =?us-ascii?Q?PJq08CsnP6Plk3WJDG3gR2+OnlpViPPgRwmE8EKaMPcLVXTabPN8rQAFPT7o?=
 =?us-ascii?Q?JOqTnK/P/Gps4Hdd0nfDA6qcHeS5bVLDxrDjZMVWLUp0HoPCynuwsQubC4R7?=
 =?us-ascii?Q?prf/4OXvXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff904a3-c2c1-4e6d-53f4-08de630a575e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 09:55:20.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMkdo1wxRKNUTpR/aHkgt5W7mQ1zSFD+U9eqODrVLKhn4JttMFMj3hadiy+WCgYDrVsyk39+RpuVR0FIBIoR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256224-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFB25D72FF
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:09:41PM +0000, David Corvaglia wrote:
> Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
> Documentation/filesystems/sysfs.rst.
> 
> sysfs_emit is preferred to sprintf in sysfs show() methods as it is safer
> with buffer handling.
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

For future submissions, please wait at least 24 hours before posting a
new version. See:

https://docs.kernel.org/process/maintainer-netdev.html

Thanks!

