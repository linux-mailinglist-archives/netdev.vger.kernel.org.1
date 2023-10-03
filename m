Return-Path: <netdev+bounces-37644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F717B66F2
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6DC971C203BC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73220B10;
	Tue,  3 Oct 2023 11:00:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503E208B0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:00:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3D9B
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 03:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiVSMuXRoSmyxvV8aSmtknrvsAEM4CVqRa94zlWIJtnckOz9pNCPqa25iLUOqzyySvqV/60x6QwNRBvj5uD0ot6gK63jnzsmvb+cSqrSFFEcAW86FgHRDv+DuOupvGnW0FE9oX+jPJ8Rm/QsqdBllxjcSGeZzT+fgHFyzQ6s3dN6kHUlyNdiRyQjfDtKPBeaeBMcyWmLZgpnWv97A/iL3NCCVlGki0IutODrVI6shSlt7imXb+dUgAYlb/1Q/gI0BT+7BojFCsi9L37F2mxXloEwpp2/3plRzfexjaolr4B0ltV5XMKDnX9NYYi8qS55Y3xwLxWZBFWnLbnP/FlqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fejsh7NKKgOC6mD0wDvx5yPltB+59Kgg0bv8DgMMXBI=;
 b=H24/umTURwY6tVIv10PaWcY81AtZGAkY4rNA/2ibvBFL6mR1c+eAtM47MOOQsV45mA2p1mN9CcuCJEUQqqEO3IbSBmDMeDtBYWx6HN0do+Ruc57XPYNvTlYTlJRB9JPon6ZL+QDYQkMMr3CQaY5x5Ci1JFlvof88ZWTdY27VjYe606LZeMAWBWQmc+cjm1mWR2lNh3D4rbkQFtuQRHI+mFjy24dOQL67Qh2zO/YEdMho78BA9BEDRPlakZyvenz5X96FqI4X/8Q8LWWDDyaIDP/bC2CTF0Hg9St2gjBbdoYpIQPz2SyayBHZgeYVn3MZq7HXngM0PKXJYJ041IAsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fejsh7NKKgOC6mD0wDvx5yPltB+59Kgg0bv8DgMMXBI=;
 b=FqeYHMZnErTgluCsZgQ03KGNQwOLKsTMTOtjiUr/aBoZ8soblH1K8nEEstz+fFY9hpIwknmBncRP8Zn7NhCLEOwcIs9GtxSnucP5b92P9q9Apxy0Ot99szh267k2jxV9sQ6bEGOM1bqEQLXzC6HsjGCeRzZN+W88X7mvXtDwYJ5jagoGOHEMoRySlkaDirWykbVdTLVJimedhVh76ogPYewYBM66MtK/dJd20dPm6Sp50KP5+JAxpx/rY6UmdM59Uqze59t5AOj3yxD0QFv5OUbQavPRUtR6Ku4YCMLca/hXnxlUtDGMbu1qC+oeqcgE5NJgWrjqLlVxxDVSHZ7lFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 10:59:54 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932%4]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 10:59:54 +0000
Date: Tue, 3 Oct 2023 13:59:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	vincent@bernat.ch
Subject: Re: [PATCH net-next] vxlan: add support for flowlabel inherit
Message-ID: <ZRv0IolLA28HlIkP@shredder>
References: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c9f123-d29a-4958-53e4-08dbc3ffdfe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qfpIsUNc+0atQ8q0UToE2nQ0Q4Gz5S+Pc0acugwqOrQ68sOr2df7eXxehoOj0ZeAxntqLhNibmt5oZ7txREGgQK85ZY7yi+LkmaCI+cZrATubiXshaRYKs+PPTl/zkYomvBajAuqpOTCu1nAb3/ruL6bA83OIf5iNqrI7JgFS6X+lsLsLC+bgJWAodTi+rmGG1hdrD2zxtjPPfgGBXG6FGylKaHKUpdEvc/rQE2OGaMgsJ2nPcD5MQhozdv2vo1l1yH/5wuj/DsVcDFc3x6usaHgkVIHao0Q+DMw5JphzETULLfzMZpUNrKnAoul4hXqZGvvT0y2IkI6EgdVNgfRY9aE6pBJoAUO7QIcwkiOMXzYi8uBTpij2Du9Lw3tNVVpquOmtryKMQS2CA/Zs7Q8AocEq0I6ax/etXBjaI5Ifw3PyA1RnDY3Eym9sDesruHdxBfF0XA73rKYuBiZznEDmmAsaz1tSNs59TvkV8qG4aiE/zKR7d3x4u0xFM3aeJLWkRK1wrmYNs2x4YRSGPiA15E9jAovCT9eFVY/6nsbt2kxUgG1Ddgd5edR8FfJmqyx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38100700002)(478600001)(6666004)(83380400001)(9686003)(26005)(6486002)(6512007)(6506007)(5660300002)(66946007)(86362001)(2906002)(33716001)(4326008)(8936002)(8676002)(54906003)(66556008)(6916009)(316002)(41300700001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YloT13NUJJUNOGJM7trTHOICzVJD1EZOOiwWcIdWCyWoqdM1h9kZOVX+qB57?=
 =?us-ascii?Q?+aQfqqXPadAyw4Eq1USvZKFlT9OpgvbETP5UELez8oefspF2BNdR7VAJ5/GX?=
 =?us-ascii?Q?kIpyvtkGenT3EGgybAXQGI3v5VOdrqL4QTxh4wIOLzdyB0DbNLJK+pG5Vuk4?=
 =?us-ascii?Q?Qh1HWrBiZcQGdKCt9nJNDelNTmjtPeNmxINT084i2rkmx6tr62+19zXldG3L?=
 =?us-ascii?Q?FlQVwp7AWsjJNDd8ayKfxrbWPUNzM71l45qd5pqy0ZCFFFnMvDlYZCIzy8CM?=
 =?us-ascii?Q?jBILN34PVImN1GJykbgJuuripDcQmAXrzb/fXHE4XCZhLH3imr9emUpUvDr/?=
 =?us-ascii?Q?SXmPs55gn2WO7nUBngTJ2Tll8A+53zQVBDEDMJjiko0SigmzkpFSe5SlP6aS?=
 =?us-ascii?Q?8t0Faphi0V2tEk26n+b1zCO6S2xyOJ0xMGzPS7Yop7WCyWlzDKT/StxYvmp2?=
 =?us-ascii?Q?CivXcr71tpjS9hgZw676zu8DYMl0jZfEHdX0snG37wGI3bRoG4dLV1kEBpoU?=
 =?us-ascii?Q?b1sOUhrwfHTLv70s56tEoBE8waa4ldV7FcRK10/xF5Srmd7rpxlCiA0nP3DV?=
 =?us-ascii?Q?+zQz+/0wjQf+q3SmXP5cVZCZVS+zTVtrMz7cyedt1AdtFxdzOf/dErd7+1pp?=
 =?us-ascii?Q?Rm8k8pn5Iw9wY1CFDaaZHFCdufBt6BMc1X8lbBjwElWqnqpCmdR4rRjUnriQ?=
 =?us-ascii?Q?bw0L7JyhZUipV1F1tBLYceVEhSREARPAGQZchw6LltASUMFSXY2t3msG2TF9?=
 =?us-ascii?Q?HJodeeMWvMmP3MdX676usyqm/GyBvH/cjvn0qf7Wtm01vTTrxTrmumez8PVQ?=
 =?us-ascii?Q?qWE0IfpltO0YdXgodSm1QNBSuksmI49NK2zELR11Vop65b804+sM7md6yGU2?=
 =?us-ascii?Q?lMAs1udWntktn63I6Xt4ZzH4JVjDfGksrq3hFR666Fopo+rmczJ7xI6jE+2u?=
 =?us-ascii?Q?tuK/BEpYB79e9BhFVFt1gEoPjVkeJZ/klR8JqDauWI85Xp7q4kT+GsBSnXaH?=
 =?us-ascii?Q?GU4hUAi2jUJVaKtLsJOo/O3CYwNZ+KGnhOU6KlqPqI8iCXGKV5ghdW5jws1g?=
 =?us-ascii?Q?JwiY8vDmDyEFZ7MzlLvwJIdqY9ps08q5LGl4O3TeE/6qCrjkMiCpsZevRAAI?=
 =?us-ascii?Q?q+mnVlMn8q+B3kxeBaP9FTOkVVSo59y+V43uTDOkOGIoGRYiOsnuiI0VOJ9x?=
 =?us-ascii?Q?FYvOsFWwLsCf802R3PLNV7mPhJ+GK3cxgJygIo2XWlM0QdP6JWclM5nHc41n?=
 =?us-ascii?Q?/NZECfPTlXSi08ztMOrbQDOYKRWNvnCEksoXNNXafLzxZNP5X1j7zkZXfv5V?=
 =?us-ascii?Q?blLsebaBPH5IIIML7K8RWjFATMNSPAwCL278uPvHPMwIvXqQkarZxwrjqysl?=
 =?us-ascii?Q?ZmVVmJzVmmgQRGss0qs3SNb00IWtMx8fLQf5B6OY3vhhw2HsxzIQ2dY0xNY2?=
 =?us-ascii?Q?GjajALjFI+gvNzxdtwyjYbJKR/w/RCw9soTbhErAFDQvO0MwZbn2uow/7eRJ?=
 =?us-ascii?Q?0Bpvuy80+hs4RsTvckDCGQYggZO97+nMbcD1zZW5IYfSZke+xYGrkbTw/i/1?=
 =?us-ascii?Q?MS/dwt9XGUyG8yNNBDiLCCiKV16uP2+NalVxAHcT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c9f123-d29a-4958-53e4-08dbc3ffdfe0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:59:54.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScJIs4VB8Mu/LhrVCeAtbFhOPcNqKmx1CccnU3ysRbTcWx8nxfC8atjK7ztJYwY3wbXoNTJb44COiIzWbOH3bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 09:28:19AM -0500, Alce Lafranque wrote:
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with an
> option for a fixed value. This commits add the ability to inherit the flow
> label from the inner packet, like for other tunnel implementations.

Please add motivation to the commit message. At first glance it's not
clear why this is needed given that the entropy is encoded in the UDP
source port (unlike ip6gre, for example). I assume the motivation is
related to devices that can't calculate ECMP/RSS hash based on L4
headers, but I prefer not to guess :)

Regarding the netlink interface, I think we should introduce a new u8
attribute that encodes the flow label policy:

0 - Fixed. Taken from IFLA_VXLAN_LABEL. This is the default.
1 - Inherit. Copy if packet is IPv6, otherwise set to 0.

This will allow us to add more policies in the future:

2 - Hash. Set the flow label according to the hash of the inner packet.
Useful when inner packet is not IPv6.
3 - Inherit with hash fallback. Copy if packet is IPv6, otherwise set
according to the hash of the inner packet.

This already exists in at least one hardware implementation that I'm
familiar with, so I see no reason not to create provisions for this in a
software implementation. We can implement the last two policies if/when
someone asks for them.

The command line interface can remain as you have it now:

 # ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001:db8::1 local 2001:db8::2

But unlike the current implementation, user space will be able to change
it on the fly:

 # ip link set vxlan1 type vxlan flowlabel 5
 # ip link set vxlan1 type vxlan flowlabel inherit

Unless iproute2 is taught to probe for the new policy attribute, then
when setting the flow label to a fixed value iproute2 shouldn't default
to sending the new attribute as it will be rejected by old kernels.
Instead, the kernel can be taught that the presence of IFLA_VXLAN_LABEL
implies the default policy.

The JSON output can mimic the netlink structure and add a new key for
the new policy attribute.

Thanks

