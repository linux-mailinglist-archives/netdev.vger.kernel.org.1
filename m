Return-Path: <netdev+bounces-34566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6BE7A4B71
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38AE28165E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C1F1CA8A;
	Mon, 18 Sep 2023 15:16:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8F1170A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:16:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6528EFF;
	Mon, 18 Sep 2023 08:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laBb8xHG+JqZWqO0Wo52W5WWDIT+/OE81f+LfS6SvV3ln9HDNV7DitlnIdM4zUT9BLaa3HovsqIihPWE8xfQvNNyM/zBRmTigM8Osqh23httaUm4jtuCS4R7DZ2NoSQiILyn7ke+V9v6AHYHNAYszXcSH1ndD5l/FP3ICdOB9E3BYZPZB+N1u0hf81XfvsbxPosHElmwXREjYZSHZRo1+NLEH6HiMSDlmMYzwjuJ769Il2mdfbjN//pU9pswvRWPkfRoyHfSR46Knv0//JP6w6CF6tK+qzHIcI8UfY3QdeBTe0y0pYHgw0pUtB24QkytWd2B/0+wflv621oAKVoQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R9WxNlJp5TgBh7RAWT8WEesxB+kJlKyUJSkkQNqQXQ=;
 b=kCvKvnFSr3d0OM5I79G7uyknHs2BLaxRCivhTw8NVEEOYTRbJ3p+swH1sFcpexzdGZa3n76cq5J40CCw/XcsJfcDUUQipPrWN2GRxo4XPZfap8qH4TmKPG+abm7qF1eQQVb+VnDvFULD6sw/lnx1aLZgtM7z22JoWgwdyf+lq1pbrhAgchaxItN/LkAQScZGGCy+LVphUoFFGiyL7e9xw3ZzQNpK1asJvtahaSAS/ubYSKXVZd5yNAToD9Hf4UdiemJqGuMXkkO/nIGw+0WR/XAGUdhRF8+juJSeLORaGQ+aoxZOtP1cM5qRYh7QCLtCLyV8QATIqKRypI4XgpGb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R9WxNlJp5TgBh7RAWT8WEesxB+kJlKyUJSkkQNqQXQ=;
 b=DLRu27jrL9WYeYBSx4LrihhgZ4MTpM9BMZdcP8LVBXCiJ8abGoC1uB0Ysw6FWGI0n1UkseGeE2zaRMRWOG5HzPuI4uh86d4Z7hoabFOSYlCoW3/wLe+EQtWiHX5VLnFX7+HrksVcV2sDvM0nZN81LAe+UYyxG6Z6V0q+pcpYbq0qrlUxGRpSlMNSWDnMy/GzLNCFynKzn8WWr8MfvoZBzCy40Eip0UnhZvLqXYPC3bUcP6daFzLKBeShhqyUWDOyNu9S3y5fCkQsjKENuIzH9/tyrdQeDnQMjNwh0j9cVJQNU+aiTEijTSD9aANBO1Extb/ENHvAAD3OAmJi4i4f9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 14:22:05 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::31e8:f2df:2902:443d]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::31e8:f2df:2902:443d%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:22:05 +0000
Date: Mon, 18 Sep 2023 10:22:00 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] pktgen: Introducing 'SHARED' flag for
 testing with non-shared skb
Message-ID: <ZQhdCHiqy2R6N3n0@d3>
References: <20230916132932.361875-1-liangchen.linux@gmail.com>
 <20230916132932.361875-2-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916132932.361875-2-liangchen.linux@gmail.com>
X-ClientProxiedBy: YQBPR0101CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::18) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e31244-62da-4c1a-019d-08dbb852a253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2yP9LcVOxlYMB53FzAt+joPCF0Ie531H79YJ5Iw9aBwcvIq2hTg+F81MsFwoThoZW0MsjQ0GhtQDzXCB5BN3EsYwBbO+9OoTacPP1sDRRxywISE4Iuzcp8IcT8dfabjQfkl+SQnncwswugLde2OVRwLYh/U2xPaUEwRkklZ0WHv0WzcQEvPDhuZb61hLKSoLccnq7aqtGncZFmF7M0qIIDStgPvxtF3Ycz94QUul6n5gHxSL18gr3wX8fHpiq/nifzVnGlSdggBTzkfg/GGfjTNSacUrSfzDjMA5qtFHF9uGSoucH4NQqHWGjiFk1x0HP8p0+ZK7i/Ddkz7spYl/P6z5C4ueXkO8zz5RM6qpXslyuawLsBQ4VWNeULvtCXNpy9ZxaUUlumuyCldXMaaRGW2ZprrC6i9gz2vujBpHo2yT6JUkPrFqHrK8specTQL0dEqide4XmWC+izedKT2gO7hTLvd2tB3FjUPGBM6urpGiwuoBxWmwF4DGWPxup+TeOi35V3c1G33pLyDeGmTyzZg3xLedaCP2ucc02EcAV3ySqljFkN3l4vVreKN9hutC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199024)(186009)(1800799009)(6666004)(6486002)(6506007)(478600001)(7416002)(26005)(86362001)(2906002)(83380400001)(5660300002)(9686003)(53546011)(6512007)(41300700001)(33716001)(6916009)(316002)(54906003)(66556008)(66476007)(38100700002)(4326008)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NC9auriRBWHK49sDJroLcxwv8jn54VQRGBbAFhMCUiGqZ6IIAKUNiZHw3vdS?=
 =?us-ascii?Q?wMvA0UKSdkcABytXgcWyyrM9nTXGhFIVcy6yvAsj3loSKuEUHfle0neX7YbB?=
 =?us-ascii?Q?g9SslstkuPvPi/92VyiHHqEF4ymve+ITT5JazaynAF9LmX/AR4k4AnLGyq6e?=
 =?us-ascii?Q?a1KDXFCfZCZ/P8U+sWqbKSTvpLHI6fkuaybcQmnJ6Exn8nKL3moFtQWfZKNl?=
 =?us-ascii?Q?B17e9Rg5JI6rctvdZoorQVRUbfJgZdzZXktSDkbnUUg3ETsS5eR9l3/Bn/vk?=
 =?us-ascii?Q?Ld5OwHoiKKwrkLdfUPBVQa2LM4gUAogdoLk0GjmlB9hnM4lv7JupbeAZZtQR?=
 =?us-ascii?Q?TJP4mpjWfYrDjDGxV2kODOQhh8iVOraTFS7raMmU1d3hrz1XSjabhoTCWvou?=
 =?us-ascii?Q?DbuPFYNVZs7v6WgfMRYGd8aWPEgkV+2C9mqr2UEgXUcb099t65BG3jXmJUWl?=
 =?us-ascii?Q?URqkt40TZTbEyO44aGFEtxTM67IF6CXgVg7VVX6F7Z0h0cLmhf3UrAaYWLKH?=
 =?us-ascii?Q?bwklh2N4JpLhcSpLjjQBXgMIv/wCBeiPliy+6oSi7eGopsjSbMkQKXKq/84v?=
 =?us-ascii?Q?gYUAeQZIC9F2b3xecTCFWc3lcTTYi5kSMWlrsge3SCfa3GAuIyOk6KGQaUDh?=
 =?us-ascii?Q?ACyy9jINeoiSyhzM0oW0ROtVHoGNxxQRGFttYBW577NwgXu1kPjyxk3D9AcF?=
 =?us-ascii?Q?0B0U0xf2U11/Rtl0e5Y4b18rZ8tfA+w85Ur9FBv5QQCAHOuGK+HTEAuZVK4c?=
 =?us-ascii?Q?Y+SFgW5Mt/kzECDDaMo/b02bhinpOQIGOv5c4Wvvlc4uNxMkEF5dovlCL5oD?=
 =?us-ascii?Q?Et/mZ/in7GV4DEIgq4+rJIoNrfqolUqAaUcm6wGqylePI9FixUVNUyJoN11+?=
 =?us-ascii?Q?OZQDDXRpTi3fRhN9n423P2NsrAy6/5eLecYvgJar9UsVoJSVVR8exxA3d0OF?=
 =?us-ascii?Q?BvUrausHF/gRdW2euTXVredlFRV3vRWXpvrpyETh5EI0ICI0XPGJsDLwGDTu?=
 =?us-ascii?Q?VUT9zw2Ie8f+IaA/uFWSFKDTMRlBcpzWt4vSTCaMBI0cva7C9sDVny/LODnJ?=
 =?us-ascii?Q?+XgZqzYwFC7M4K+fX39MmDpKzhb9/A08B+7kND2p69hRRR3uqGplVN54Mtap?=
 =?us-ascii?Q?L6U0ZZlTilYPlSkuD3Oc36G4f+mjXVCuSI5xXwWIqpzyy4OyfKO/JouVjzDq?=
 =?us-ascii?Q?oGXIMOLs5rl8YzBN4Sywf9sqz7ZYAExF0a0v+sgKld+E217mi4INMGEVymov?=
 =?us-ascii?Q?Ka7/Ay598hZsJZ/GM3BgvaX4N7J6aEdNhia1D5ZGsozSeW4UtoAGjlhb/PLR?=
 =?us-ascii?Q?CxHZrfPa536IOVjKYXrqtUA3KPD1g6HukWJVSB3Hk+o3Kq6BWPy0C4vCuYfo?=
 =?us-ascii?Q?nPpzsT6K4AiXWUSyTj8y1vppdS3SSHO0MA4i0Ou9PLVjdHZSSgx4qwfzEDmV?=
 =?us-ascii?Q?gr/wH+U30JdS59yhhzOCWuFTJIDvQUGqQ9J0iGKyeb/qjnWzf+DbXH6Cjwl9?=
 =?us-ascii?Q?GceWIB+JJ6ZZQqwlwGdmFaERCRVzPIXb9UlkgpMWWkNFDIMlg7SndEwpVdvC?=
 =?us-ascii?Q?zts+A629TUQo/pxGgj3e+do05Ha+BgMvXaXAaIeK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e31244-62da-4c1a-019d-08dbb852a253
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:22:05.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkvDpDvUwd/2Lk7Gmfr3RXWL3QhhUEw7bX6vkGjxbRlIoGpVIf2GnpOGeoiX3/N/3BN3a1zhQXSNymL45vwgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-16 21:29 +0800, Liang Chen wrote:
> Currently, skbs generated by pktgen always have their reference count
> incremented before transmission, causing their reference count to be
> always greater than 1, leading to two issues:
>   1. Only the code paths for shared skbs can be tested.
>   2. In certain situations, skbs can only be released by pktgen.
> To enhance testing comprehensiveness, we are introducing the "SHARED"
> flag to indicate whether an SKB is shared. This flag is enabled by
> default, aligning with the current behavior. However, disabling this
> flag allows skbs with a reference count of 1 to be transmitted.
> So we can test non-shared skbs and code paths where skbs are released
> within the stack.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---

In the future, please run scripts/get_maintainer.pl and cc the listed
addresses. I'm adding them now.

Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>

>  Documentation/networking/pktgen.rst | 12 ++++++++
>  net/core/pktgen.c                   | 48 ++++++++++++++++++++++++-----
>  2 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/networking/pktgen.rst b/Documentation/networking/pktgen.rst
> index 1225f0f63ff0..c945218946e1 100644
> --- a/Documentation/networking/pktgen.rst
> +++ b/Documentation/networking/pktgen.rst
> @@ -178,6 +178,7 @@ Examples::
>  			      IPSEC # IPsec encapsulation (needs CONFIG_XFRM)
>  			      NODE_ALLOC # node specific memory allocation
>  			      NO_TIMESTAMP # disable timestamping
> +			      SHARED # enable shared SKB
>   pgset 'flag ![name]'    Clear a flag to determine behaviour.
>  			 Note that you might need to use single quote in
>  			 interactive mode, so that your shell wouldn't expand
> @@ -288,6 +289,16 @@ To avoid breaking existing testbed scripts for using AH type and tunnel mode,
>  you can use "pgset spi SPI_VALUE" to specify which transformation mode
>  to employ.
>  
> +Disable shared SKB
> +==================
> +By default, SKBs sent by pktgen are shared (user count > 1).
> +To test with non-shared SKBs, remove the "SHARED" flag by simply setting::
> +
> +	pg_set "flag !SHARED"
> +
> +However, if the "clone_skb" or "burst" parameters are configured, the skb
> +still needs to be held by pktgen for further access. Hence the skb must be
> +shared.
>  
>  Current commands and configuration options
>  ==========================================
> @@ -357,6 +368,7 @@ Current commands and configuration options
>      IPSEC
>      NODE_ALLOC
>      NO_TIMESTAMP
> +    SHARED
>  
>      spi (ipsec)
>  
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 48306a101fd9..c4e0814df325 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -200,6 +200,7 @@
>  	pf(VID_RND)		/* Random VLAN ID */			\
>  	pf(SVID_RND)		/* Random SVLAN ID */			\
>  	pf(NODE)		/* Node memory alloc*/			\
> +	pf(SHARED)		/* Shared SKB */			\
>  
>  #define pf(flag)		flag##_SHIFT,
>  enum pkt_flags {
> @@ -1198,7 +1199,8 @@ static ssize_t pktgen_if_write(struct file *file,
>  		    ((pkt_dev->xmit_mode == M_NETIF_RECEIVE) ||
>  		     !(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))
>  			return -ENOTSUPP;
> -		if (value > 0 && pkt_dev->n_imix_entries > 0)
> +		if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
> +				  !(pkt_dev->flags & F_SHARED)))
>  			return -EINVAL;
>  
>  		i += len;
> @@ -1257,6 +1259,10 @@ static ssize_t pktgen_if_write(struct file *file,
>  		     ((pkt_dev->xmit_mode == M_START_XMIT) &&
>  		     (!(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))))
>  			return -ENOTSUPP;
> +
> +		if (value > 1 && !(pkt_dev->flags & F_SHARED))
> +			return -EINVAL;
> +
>  		pkt_dev->burst = value < 1 ? 1 : value;
>  		sprintf(pg_result, "OK: burst=%u", pkt_dev->burst);
>  		return count;
> @@ -1334,10 +1340,19 @@ static ssize_t pktgen_if_write(struct file *file,
>  
>  		flag = pktgen_read_flag(f, &disable);
>  		if (flag) {
> -			if (disable)
> +			if (disable) {
> +				/* If "clone_skb", or "burst" parameters are
> +				 * configured, it means that the skb still
> +				 * needs to be referenced by the pktgen, so
> +				 * the skb must be shared.
> +				 */
> +				if (flag == F_SHARED && (pkt_dev->clone_skb ||
> +							 pkt_dev->burst > 1))
> +					return -EINVAL;
>  				pkt_dev->flags &= ~flag;
> -			else
> +			} else {
>  				pkt_dev->flags |= flag;
> +			}
>  
>  			sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
>  			return count;
> @@ -3489,7 +3504,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  	if (pkt_dev->xmit_mode == M_NETIF_RECEIVE) {
>  		skb = pkt_dev->skb;
>  		skb->protocol = eth_type_trans(skb, skb->dev);
> -		refcount_add(burst, &skb->users);
> +		if (pkt_dev->flags & F_SHARED)
> +			refcount_add(burst, &skb->users);
>  		local_bh_disable();
>  		do {
>  			ret = netif_receive_skb(skb);
> @@ -3497,6 +3513,10 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  				pkt_dev->errors++;
>  			pkt_dev->sofar++;
>  			pkt_dev->seq_num++;
> +			if (unlikely(!(pkt_dev->flags & F_SHARED))) {
> +				pkt_dev->skb = NULL;
> +				break;
> +			}
>  			if (refcount_read(&skb->users) != burst) {
>  				/* skb was queued by rps/rfs or taps,
>  				 * so cannot reuse this skb
> @@ -3515,9 +3535,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		goto out; /* Skips xmit_mode M_START_XMIT */
>  	} else if (pkt_dev->xmit_mode == M_QUEUE_XMIT) {
>  		local_bh_disable();
> -		refcount_inc(&pkt_dev->skb->users);
> +		if (pkt_dev->flags & F_SHARED)
> +			refcount_inc(&pkt_dev->skb->users);
>  
>  		ret = dev_queue_xmit(pkt_dev->skb);
> +
> +		if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret))
> +			pkt_dev->skb = NULL;
> +
>  		switch (ret) {
>  		case NET_XMIT_SUCCESS:
>  			pkt_dev->sofar++;
> @@ -3555,11 +3580,15 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		pkt_dev->last_ok = 0;
>  		goto unlock;
>  	}
> -	refcount_add(burst, &pkt_dev->skb->users);
> +	if (pkt_dev->flags & F_SHARED)
> +		refcount_add(burst, &pkt_dev->skb->users);
>  
>  xmit_more:
>  	ret = netdev_start_xmit(pkt_dev->skb, odev, txq, --burst > 0);
>  
> +	if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret))
> +		pkt_dev->skb = NULL;
> +
>  	switch (ret) {
>  	case NETDEV_TX_OK:
>  		pkt_dev->last_ok = 1;
> @@ -3581,7 +3610,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		fallthrough;
>  	case NETDEV_TX_BUSY:
>  		/* Retry it next time */
> -		refcount_dec(&(pkt_dev->skb->users));
> +		if (pkt_dev->flags & F_SHARED)
> +			refcount_dec(&pkt_dev->skb->users);
>  		pkt_dev->last_ok = 0;
>  	}
>  	if (unlikely(burst))
> @@ -3594,7 +3624,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  
>  	/* If pkt_dev->count is zero, then run forever */
>  	if ((pkt_dev->count != 0) && (pkt_dev->sofar >= pkt_dev->count)) {
> -		pktgen_wait_for_skb(pkt_dev);
> +		if (pkt_dev->skb)
> +			pktgen_wait_for_skb(pkt_dev);
>  
>  		/* Done with this */
>  		pktgen_stop_device(pkt_dev);
> @@ -3777,6 +3808,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
>  	pkt_dev->svlan_id = 0xffff;
>  	pkt_dev->burst = 1;
>  	pkt_dev->node = NUMA_NO_NODE;
> +	pkt_dev->flags = F_SHARED;	/* SKB shared by default */
>  
>  	err = pktgen_setup_dev(t->net, pkt_dev, ifname);
>  	if (err)
> -- 
> 2.40.1
> 

