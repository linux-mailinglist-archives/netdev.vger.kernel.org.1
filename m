Return-Path: <netdev+bounces-43291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1C7D2396
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 17:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D79B20CFE
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C2D533;
	Sun, 22 Oct 2023 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLI5Q+yK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203801858
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 15:42:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D8EEE
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 08:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1kShAustTN9lAr8VHEQrc0YnQ3++E8k0LcWqBbHohAzx4amXmqESXGizP/zMYynYP7Ju3v23jaumJSdmgcqMkWcuFsLx4unewZLQtyaVMOwaJVnHKLkZ9KBxzoJoHYqwd5NvEwHmrw1ytWHghCT16IAnDWPOSKtjoYCC2EjMr0SlyqvB1HDviuX6wGwufe/wi5aoZ+RNW63FJn9NRv6BTUlOIJKYm0AVMvoE9G+cG3IhuV3M/hme/ZGRgc6r2+puybS0Uiv7ZWtNSOXeKqPmtzyOO5O4CgGPS5swOZjFOSzEOyHKdtUExNY62p42HpMNQ0pFpQwrLBuKtpQJL6RGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLgYWq5YuoArydTRaQfHWkNBzdc6Lc9CxTRqofMvXio=;
 b=EMHWzJCvMBpadiOHeUNmPzopzzr+t1XBSIQfPALCkb/ffYK3sAL2pnSSGTKcyBNOdjbdTNMwb+jmKP6Yuw9AFeP0+w5tsuiVnCzO9zUJC3MeWojNwse9/yQOsXNr+UXQby6asofVoL50IsduTeKGwJamiLlqag+kKZr3MEsiVG1gIn49B3usQZzdEKJdXxfiPjFb4sEks0ZquDDf5wOx4fOpmYnh2ozUCpEEBTTZzv3ceIgORJTtCOEZxdknKJlv5/MTdKGBj8bLFUpidft1qvaaMSdqtWVe7/Ycj/X9myXP9cCAcIBhKjB8ABRE/Te7tgMCysvqkhSlLeE6gmR3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLgYWq5YuoArydTRaQfHWkNBzdc6Lc9CxTRqofMvXio=;
 b=SLI5Q+yKk+3OPBA7w4wlG7ieGJFSb2He4YpCDU74VYgm4bj7q1cvv/a2Bh9SGdxCEzhVtrh7v/AdmcqM0sxVo23GgOSiQoeyyDi0yZ+xQ50ivINn70YznhjCxdnNgOhmu27Ftt7WuQafI9dv1Pn/vWHKwQWbTw13xTiNpuU2T56S+9ya+O4GMQdrW4Ms1eOnREcEfUPtfq35enqd3KEw5Uth6ankqwJp26mfuc3RNnI9nVEVyKNBg58m6MukQ6/VzaeOtygmv8/uP4xDeXSLf3Oj7jKzOB2Jspg64VuhoPPHoLp/AkMHBv2ysuhZpS/pDJRVb0BzRkhQcoNJqEmWFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sun, 22 Oct
 2023 15:42:16 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9%7]) with mapi id 15.20.6907.030; Sun, 22 Oct 2023
 15:42:15 +0000
Date: Sun, 22 Oct 2023 18:42:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Vincent Bernat <vincent@bernat.ch>
Subject: Re: [PATCH net-next v5] vxlan: add support for flowlabel inherit
Message-ID: <ZTVCzZTvuZTDSgqE@shredder>
References: <20231019180417.210523-1-alce@lafranque.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019180417.210523-1-alce@lafranque.net>
X-ClientProxiedBy: DO3P289CA0029.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::13) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0c7133-850a-4a66-a914-08dbd3157768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hC3ihAHDM1Q3Wx7D5QRTqbXylfMkTIjvJ5c4b65o6obG65slRK8Xj11zAUd4KJ9TZxc9JaHz06AGY9i2PPzeIkgf4cEWBy24KfAadD3+S42enCzGy9DLHwt2BKmCXgWxoivlujcMfcohnrrS9b6wYd2smWYOgG7//DvIUQ1tiIr/EgMbR6T8dCMiRYQ8pkyv3xbbIpJ313+8rEdVvxBNSSr4m1oPlVEZ4UixcVYLYexaJQLeN+0OKn5THBqggAzH9spawycGpkAn/0+XUxA8pkw+cNxPXDZ45t2SMuoOJceJ2mXNfpbx9naxJjJfO5QmdtCeksKpnC8axUOWJ8vneg9GeKhoS/2LIyC7Kk6+E2zm1571KhGXs4wFDwkOP4FQsk66g2x/JcP87vy+5iiHn3KW9/K89W6dyDH2lQYDbu8rr0vcVl22RZjc6hSU3tMI9+yafDdlDdRby5a8kj9RFW7RGmhFY1s4zXMoPpZdlqzlIJSe5rTA8yZIif5urF/RYvczEHCaKoLywEmUHBWW3k94E0hY0/GeFu/hW9JoJ9DdVBRddQn3ryjBVR+hr0n6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(33716001)(86362001)(5660300002)(66476007)(4326008)(66946007)(8676002)(8936002)(316002)(54906003)(4744005)(2906002)(6916009)(66556008)(41300700001)(478600001)(6512007)(9686003)(6506007)(6666004)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yr6K98SzWtZrqqixKmyP6dno94ryUOzbLxKf9yxMB45qNdktLsdx/KWpACaN?=
 =?us-ascii?Q?7nuUrpXGvpcKxIWGHJycAkI8sWvge7P8h8Vv4BYeMAfFjRWmBVpneCUPJ8O5?=
 =?us-ascii?Q?EY5ydk+QfhL83/JvlCt4Avy5yg8W7+s1FACRPrr2CI129s5JF6sToJ/+VFPj?=
 =?us-ascii?Q?9STcWwpkhITNmXxVXBZDybPWcQo3+BEwf8LrYRiF0klNA6IqpaJd0E+6F+di?=
 =?us-ascii?Q?4+dqo9bPPPt59undVzTNRwd8hfhdsdOt1nccI89gMa40WE+eDiQrIP9s4RC2?=
 =?us-ascii?Q?E6uY26C+aIcyqrPNXdJPCs5R2akCxblAT+HJ1n25dkydiNVDKaCwVRL1M5Hm?=
 =?us-ascii?Q?Qwj9/F0591tePsBpAK8UhthUr5vuvVB6yHiVd/KI5hDPncIttY3iU/1KsRQP?=
 =?us-ascii?Q?kkCnFpXPa+EzmpVdfLDz2DhH7VOKL/9/22co92xo8bPrFOXl6hI3xyXUnitK?=
 =?us-ascii?Q?6exksxfKx6l/b71uv1eqQfVooImZV/X6uLM8uSSMCyoJbwWGOtuFDrVU5A9n?=
 =?us-ascii?Q?/tpTIcv20aixyH3jFFAV797mGsBh4opOcUA1Amqzae1fvJHyz9abQR/s23at?=
 =?us-ascii?Q?XedkB4pacEfYNfzleXycLk/nSE2nXYF0w/y5m2icRRWwIzEOT8NG+sGnTPbS?=
 =?us-ascii?Q?3k5CyVDnxjgCa7sYW4ivGivFmKNcK+zcrUcEHQ3A19DPjeXsLApUKurPHs+z?=
 =?us-ascii?Q?jbPEou8DzoyD7KgensgJncmdJ2IRH0XPFqjOgqaaS60OepFxtkN3uIww0S9K?=
 =?us-ascii?Q?4kZqpX+snbFVLZBqYMDAeFxZzoihSfc4QInuk+ANoxq+McaxnWC7VBY15I8C?=
 =?us-ascii?Q?00mp0ChkavS9GgNEMZ+Om9+JSNNXEOFL6fNhSsM8I1WnZzBaNLpzqgJ2Ha29?=
 =?us-ascii?Q?1fKrsynHlKOI3JrjGJTsXViBTYkyRTQ6ZrsPLGz1no73ves89gGEPmAvoRGB?=
 =?us-ascii?Q?0Mbv+8sOV0xe9SDEIolbi1W8tfUaqzUFE8Qy4/hZ6c4AkU8ZKEUgccBAlu96?=
 =?us-ascii?Q?LKrwfVXx+wo6w8edf7sfcCR6pjbiQ57FYR9Ljr4qe2u5hcHgmtAS42FvQ7+W?=
 =?us-ascii?Q?xbr5knG4lXuOXqW7jhJZvIkklwpVtjINp3qIf8h7RBCjYGu9GaaIVY6g2CJq?=
 =?us-ascii?Q?nlMj8Gr2ET9/NA2DAfC7I17CderUY6og/aDTyHSIZ0ohHhwnn/F9+T191oiO?=
 =?us-ascii?Q?1lYJWKKJqzQWEYXcvC5QBtGIM6lN8W2LBHDmjb0/6vyo+OOwG4zzZZge0w8A?=
 =?us-ascii?Q?jwmyEVgnhAMFy8omaeSYKT6mgUhyX7MVphqon6R5DTox+4N7ubxi/whPgIyG?=
 =?us-ascii?Q?9rn/fcTAucUMF3WX8XUG7T6NbJb2x/E/QivEuF5xvGM5l1qwEMCQu2j0oa+b?=
 =?us-ascii?Q?OmIcHTDndOhaUPoYI97W4u7mhXVtU3Y2MvPvVhisKmbmt+a04x8DEbKkx9pD?=
 =?us-ascii?Q?cJNqqrMO6guKNUeY7DiSW8KA/3uoeo11b3SHj0A1IkolOHjungKsJR0CFxN4?=
 =?us-ascii?Q?HxjC01HLzHrr8uSqUsYmG6p3cCiscnm34Ct+O3gb/aFHsSPBNwT4b2rgfl6F?=
 =?us-ascii?Q?6CvP/mdPgdwbeCcwlnjxFdp1ERglnyVgUmPodmw9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0c7133-850a-4a66-a914-08dbd3157768
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 15:42:15.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYzwikvrJ/BebTgc7SJEgdC3TkU7XQNKL/wBTOyg6OClR7krhmUBrFFziO88OVut2TqDnn/q6/JudbNBU2Lnaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597

On Thu, Oct 19, 2023 at 01:04:17PM -0500, Alce Lafranque wrote:
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
> an option for a fixed value. This commits add the ability to inherit the
> flow label from the inner packet, like for other tunnel implementations.
> This enables devices using only L3 headers for ECMP to correctly balance
> VXLAN-encapsulated IPv6 packets.

[...]

> Signed-off-by: Alce Lafranque <alce@lafranque.net>
> Co-developed-by: Vincent Bernat <vincent@bernat.ch>
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

The patch no longer applies to net-next so you will need to rebase and
resubmit.

