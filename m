Return-Path: <netdev+bounces-41271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0D7CA6F7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC8028171F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C92511C;
	Mon, 16 Oct 2023 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4veZfP8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D85250E8
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:51:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0460EDC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj8asG1ukmbFD8fwtkV5q9lkf1AZz+8+rtdW+5F6tXE7rV1melJa9bCxn7Y5JeRddt54CprcaQ79JW1TW3i0YnX8mAUDHf6we3mek9oefn1S2BI/0pworZCL59EMK9BQ6HsCmG7JPwIr5rDNv39HYCPLfDNG37WdVtQxlq9TejPmgXFT0ga1dEgWhC/QKD8sDr7xbSdQWiuxeuyGwpbx0kqCSkwbwvltbfqvtZChjzXNAQFuE0/QzFXFFhTNY5NRP3x/ZEB7lglJc+/hYCuRZF1YESKXh0vgHERKmKtPSfgTvt6cxA3uuJGNim7Xw55bWfTPHBoppw8lY4yitnV8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZzrLbJhw7jc5iLiq9MdwElAUDU9txuko2ojFmFYYR4=;
 b=H/jW4vbPJuaVaUlj+iuxwUHnyT3eO6m1RyzgffMn2Bsv7QF3tUnrANnkCrR/4tzA2NMj4LcDzn9HSNc2J5wPkj56b5BvvANnsjU2G+zksgA4k4Z1dfiluHrInSXOliZmmRf3ubFhsIyRnY5Ip4AgwQmdIJ6nmqYwwvQI1LR28T37r2mer9JwAKfoMoOciuM3eL5LdXABPuSShYri1Vzl+1xLaHZn59zQ6MxMH6YAQZKNIgoJD7Hw6ws8ZzAwsl42QIY06lsowWli6LMaqdsBa6B/rUnXPnA6R3/Sc92Yl/A1B4RO3EuzwxVMEvB6RYHvw2o7I9JXhvPvQjbueJij4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZzrLbJhw7jc5iLiq9MdwElAUDU9txuko2ojFmFYYR4=;
 b=f4veZfP8lIGOO/pIL+0Oj5urYEMV3B+yoxA68ee9FKdzY/C+xN4eeEpYxoW3a+x8DxzFv+lpuu5u3QfXAhfhr0xeQbgxMBX94IS7P5CruWEiaANnxhh6AV186zwRrEf4AAC35HfwMuBpV3OYBWpSr+whm+t2BZq8LImSzYpRKHVLlAcFJsWegPTJIyz89cOp35R6h30krzlsZt9oCJXQUfQArL+shiyenLIlgTsiazvhFsqTlstWALNTAGbJ9AbX03KjOqdtbx8Em9RBVRJs5aEV5q1K7Dy0jzRdFeimg4nFQsMsZzVqixp6viFltc76fo0ffn0URI3y/wqPZ0gH5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:51:49 +0000
Received: from IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::4bc5:1f45:40f0:3cf3]) by IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::4bc5:1f45:40f0:3cf3%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 11:51:48 +0000
Date: Mon, 16 Oct 2023 14:51:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Vincent Bernat <vincent@bernat.ch>
Subject: Re: [PATCH net-next v4] vxlan: add support for flowlabel inherit
Message-ID: <ZS0jywD/ktdhcdFj@shredder>
References: <20231014132102.54051-1-alce@lafranque.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014132102.54051-1-alce@lafranque.net>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6163:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf36775-8e66-4ff9-655e-08dbce3e4791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IvIla+UjWRDAXEsDA3p6Cl0TxTHqxGhwncDu34SZlXGeB0+/tIm/IFfUiPloDtqrCEV+qSRy/nwmjrbEOulnb+fXdjgFdIii1e7clerLRuJdMjx9B7i8yPvvxhD5ALuTHdu31RlpdU44FuK6AecEfLJoy/L94S6ML8lGmXZI4zek9H2PN/DeaYXdQ/7kWntDtkGhBxRs4/5OA2pa0A3H0P9ZByiqG9oRHpZqXENq3+ZdLCK1VWgq+JCKFrGlbYT2G27NCltFzw8Q9b19Os2QJRCu6cacB+RJzHk0KinDJ8auB+s2XuQOXzvHok+VHl3QrUqyjbLlx4MIka4Pvcc2OaR18b+bGHK0fnnkB/6PDSee1avrbKSRELkp5NYO5nZlo0TFTHMgy3q7+3MYmFiCRa5pgsxUAIiUF090KViHp/Oz/vQmpul/riLOVrvDhi+iyYbjQQZET/aBrJZMTDOT5RFgOJb6tHRE0ltGGPaoDBx/VWIaAKAV9mYtxyQVEZV2UgtX2GNFlOOtXGDLL1LCli/S9tpuG1joeXVEpqMWyVDOli4D0GRzgP5qgB/w0BNnkHkSf2H9DtMgFoTRn5nLrjbHnj0301sNRraU8A8dRCN/I70PNuzGWM8EDGjY0g9F5T8Af1eh8LZtk+rRIGQ2cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6916009)(316002)(66946007)(66476007)(54906003)(66556008)(26005)(66574015)(83380400001)(9686003)(6512007)(38100700002)(86362001)(966005)(478600001)(33716001)(6486002)(6666004)(6506007)(41300700001)(5660300002)(2906002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKhVDyW7X8wYwR4tX10/6Au0C4WeEsPUhsAv2FucDrTEQnu4zIIDr3IHTJwq?=
 =?us-ascii?Q?fFCMKByJaZ5yPmKP0OVfid2IIA1yNhZYVQlmmIVuBNoOMB5IJylfbMrSb7iB?=
 =?us-ascii?Q?hp/CgmdTK03KmK5efBPsbTHpTpJyV18eRa39z2gc2ra6/Z8M1ZNDerL+4rB1?=
 =?us-ascii?Q?ISZVn8GL60ZgW4lae2TVI6N3P/g3AswzgL4K00/AN1N5IGBHyVxPEzOi+bA+?=
 =?us-ascii?Q?5GDEyj5eIlPFktWY/Q+mtIKzvb0y6bMLeQ1r9WjAeASPGPAQsfHkadeAMpht?=
 =?us-ascii?Q?QjxUEljJUJ2ILcUxotG47Jfn5CIqP3+ydRvhGu8p2AUnBYfy15hGynJbevc9?=
 =?us-ascii?Q?7/MTpu9+U3h5sfFY7u6T9/heAvCsNdkqq7P+Z+fe4hla9NIEYAZPZE1KnSVb?=
 =?us-ascii?Q?IcYZxQjNq3MXXIXQsS4mboyfw6ngJVuWZGuxkM7z48pZnCoFG1L0SxwIKhyP?=
 =?us-ascii?Q?ALQvQbHnbOOw6ILz2KByi5Vbkx8Tz4gUU1bOZa9MnYkWOTA7JAvGnsGI7jJ8?=
 =?us-ascii?Q?pGcKIA5giNDTTHXd4zVHgWd4fiEO1ZRTRmkg2wc+YAshjVGTNc173X5Ba3Qn?=
 =?us-ascii?Q?a0lRFDIimVhwIK700Th8ckDK2Mi9lDGeGEFnilukOYKZ/+LxSA+tqVpy7UKc?=
 =?us-ascii?Q?TgwLt4vXS/1MzWVtLyo5AVCPofklTDfNxzXCVhffVxpXLKIcmysmoW467Wb8?=
 =?us-ascii?Q?xZIVw0xoXYV+PJ9cBhFxeB5jfJVATrxs0nQ4KUtepoLoVCdYr+tnyiK1qItI?=
 =?us-ascii?Q?o4hApOQm7IEZGB57pUqUaEX6yyZ6xDe120p7aYFaB5G9bBRwRFhEH/iS1uH9?=
 =?us-ascii?Q?nGcldZ4Iacz8EX/dvLK2NiDjjvIa3tA78p7VqAGdMJRyfLhWH4uKwn5foius?=
 =?us-ascii?Q?ZAbDecrb3YAfdkFTrP5mBzwR2Mu9+S4s/JAIRw1hxYeJYNW2eTK5m7EFV8PY?=
 =?us-ascii?Q?WNfoApovF9tnTnVjNEWjDFZ45UEkftoTE22xwN+fNdIq2EDuj2MiaPh1uqaz?=
 =?us-ascii?Q?mIWxhd+RF2K4QkdWKHn/KpOhD5zg8jinBoHjqboVuq4v+058huVuCMF5YJEb?=
 =?us-ascii?Q?sC1/iefPERfJdDdfOecsH+kBqRqlku80XkA6VNJPqW97SdKSF41M1bQ3cB50?=
 =?us-ascii?Q?i/B0yd5c61+Ju2Dj2cU+z0Bxuy6EZ7iweLsC2kN/xGcPLKS6DqXzB7IQtYSr?=
 =?us-ascii?Q?uLbZ9Avg4cKhLsv3nDITfA9+k7bQ+6PQKS9aMw/isvK0goQwqnncrmxrJ9x0?=
 =?us-ascii?Q?/8Ct93NcyCivz3nM4eW40VSldsxx4mlbUiik7w02lNvkKnWru3MWmnB4dRPd?=
 =?us-ascii?Q?dELEaj4vnyiSz+lltoMFcM5S3QAlXHYNv4HacMeuwtH/VkuCfvoG48qKw1D/?=
 =?us-ascii?Q?7YHmcoVuC4DHrulVB+4PDdjaA3SnYBUax5dOkNb6QyJY73qoym4a+PRAkj5/?=
 =?us-ascii?Q?ZcMwgnnhSNoV0SpNmsPNeL3ISNNF/lyl4zZCoIAkP/lpDhS9BEZSOUJ/Ddsc?=
 =?us-ascii?Q?CqwWkbXxX6+N5J3sd1rxqexNbuHQ6nSmG2CEFMk8nIBB0mGyHLRx9Bwp8KRL?=
 =?us-ascii?Q?9Xx5TKOdhP+aES5mdu9mEdzqvkZ3omPUuEour662?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf36775-8e66-4ff9-655e-08dbce3e4791
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:51:48.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSgx7SF9X58IPMHJqaKiTjQ+0zsi0rtPx2sQZTCSocDvX4DnEWrKKRuJXrCfeekqDVohg/kBXb9GBj8CoL5gaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 08:21:02AM -0500, Alce Lafranque wrote:
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
> an option for a fixed value. This commits add the ability to inherit the
> flow label from the inner packet, like for other tunnel implementations.
> This enables devices using only L3 headers for ECMP to correctly balance
> VXLAN-encapsulated IPv6 packets.
> 
> ```
> $ ./ip/ip link add dummy1 type dummy
> $ ./ip/ip addr add 2001:db8::2/64 dev dummy1
> $ ./ip/ip link set up dev dummy1
> $ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001:db8::1 local 2001:db8::2
> $ ./ip/ip link set up dev vxlan1
> $ ./ip/ip addr add 2001:db8:1::2/64 dev vxlan1
> $ ./ip/ip link set arp off dev vxlan1
> $ ping -q 2001:db8:1::1 &
> $ tshark -d udp.port==8472,vxlan -Vpni dummy1 -c1
> [...]
> Internet Protocol Version 6, Src: 2001:db8::2, Dst: 2001:db8::1
>     0110 .... = Version: 6
>     .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
> [...]
> Virtual eXtensible Local Area Network
>     Flags: 0x0800, VXLAN Network ID (VNI)
>     Group Policy ID: 0
>     VXLAN Network Identifier (VNI): 100
> [...]
> Internet Protocol Version 6, Src: 2001:db8:1::2, Dst: 2001:db8:1::1
>     0110 .... = Version: 6
>     .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
> ```
> 
> Signed-off-by: Alce Lafranque <alce@lafranque.net>
> Co-developed-by: Vincent Bernat <vincent@bernat.ch>
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>
> 
> ---
> v4:
>   - Fix tabs
> v3: https://lore.kernel.org/all/20231014131320.51810-1-alce@lafranque.net/
>   - Adopt policy label inherit by default

I don't think it's valid to change the default behavior. I checked and
the "inherit" policy isn't even the default in ip6gre where unlike vxlan
the inner flow information isn't already encoded in the outer headers.

>   - Set policy to label fixed when flowlabel is set

I assume this was added because of the previous change and can be
removed. I thought about what you said earlier that old kernels don't
reject IFLA_VXLAN_LABEL_POLICY so iproute2 can send it when setting the
flow label to a fixed number. If iproute2 maintainers aren't OK with it
we might need to add a new keyword for the flow label policy instead of
folding it into the "flowlabel" keyword.

>   - Rename IFLA_VXLAN_LABEL_BEHAVIOR to IFLA_VXLAN_LABEL_POLICY
> v2: https://lore.kernel.org/all/20231007142624.739192-1-alce@lafranque.net/
>   - Use an enum instead of flag to define label behavior
> v1: https://lore.kernel.org/all/4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr/

[...]

>  static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -3653,13 +3664,18 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
>  			}
>  		}
>  	}
> -

Seems like an unrelated change.

>  	if (conf->label && !use_ipv6) {
>  		NL_SET_ERR_MSG(extack,
>  			       "Label attribute only applies to IPv6 VXLAN devices");
>  		return -EINVAL;
>  	}
>  
> +	if (conf->label_policy && !use_ipv6) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Label policy only applies to IPv6 VXLAN devices");
> +		return -EINVAL;
> +	}
> +
>  	if (conf->remote_ifindex) {
>  		struct net_device *lowerdev;
>  

The rest looks fine to me.

Thanks

