Return-Path: <netdev+bounces-25304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95489773B4B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503CF280D0C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5161429A;
	Tue,  8 Aug 2023 15:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB114A88
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13521FCE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BocaJSna7hZ6TNL0a/OAB3vREcBQ4w5llzkMJjCgqcx1wfbZ4PyuwyBdX/CN58UPGh7NF540Hsht4cCOvA2kM4jmEkJDkpXO/SVa/doWxAgAF57mQQ5XroJF7Jy5GGh0gjycAMUQNiXaScIgK5CHfCz/f/dyFRcVSNwrZEH5yXUWMVLyJpvNfZKseUBI7UBvD+/m5/W2komc717RP4zXOfkNDv/awfFYxYJPgtYywmXafGsovh1Y9fk1/Y7sWgR7/GuI5q1VfhrqrgbdFdHm5IC+fX98S1UloqlWgJWM6fKSNCZQLGonqFeWGpyvyuMrsLd12/xFdF2SdmZ/E9cshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwkHaBjjqBzCuKcEjJZhGZ+VaUK2jbwzT5k2c8mFXRk=;
 b=jvbOOKYByNstHrGkBi70ZjHRgGilFkCqbnNrQNtr19zRB/3Ogi6hdQlYEluBhzPrW4YhXgxAzsViMqSQY9t9Kw41SAaKwDAwxSAsifXz98DTX72nZyNuYCSk6RZfjAhNxgQGnY7l2w5VOa8Rq+1URSceP0oMtZm3TrCwPbBVtLi/U+dyihQGHVNshFj/c89CLWwPdox86Y2MSoxC8exn5rvILI4aifQx6vQB4YGIgfirboeo6wAd7oZZ+yAeSvYUWNSzPFhIZW0mIcltbojQz+qQ+oNOrNoCcQJvFuq19cpShiQ9k6KvpLumQLgppkhufmDDb6kyepLrrwTt2jaMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwkHaBjjqBzCuKcEjJZhGZ+VaUK2jbwzT5k2c8mFXRk=;
 b=LAJToXAssAOgT/Lgf/n4MmfoSjdhHAD6szH1Gep/x6pdSI6XNdNctPZrjfPzA/uJeHz79LcX61sEOTICVGWRdVkG3cLKBZ08lvdXxixcMJ5twFUipZZFjrvaUHd69RS431tUCC/Fk2RgxzdQ4eMmD59SMVsdxhma4h+0o3MFYWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB6783.eurprd04.prod.outlook.com (2603:10a6:803:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:28:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:28:44 +0000
Date: Tue, 8 Aug 2023 16:28:40 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ftmac100: add multicast filtering
 possibility
Message-ID: <20230808132840.667cwgzippl63xe5@skbuf>
References: <20230808124307.2252938-1-saproj@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808124307.2252938-1-saproj@gmail.com>
X-ClientProxiedBy: AM0PR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::33) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 30360402-e462-43f9-5410-08db9813634c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eEv36mWObWTnqRt0VCTpil3KNw8/ETcRn7W4leQsiYZbPgRxx6tc5mYN9++XoXFnadvCgZ9/0XGK4EO6o3WHxyMqvjkUAQZBRjxdNxaLFlUyboqDzzu9v1WzkhjFHuQGbbVeBv7L388tjxn1l0YR3QK4U5b9DVdOeD0w4er9J4WTOtX/D18AHS9MpTSSdDQMG3g173RjuzCUNoMoPVhs2jliWCpQLi5VH3+1L0se7rBDYHBw89iHF2Z3TNLMI5vvwt0QwaHl5GDwFgmnsZUcyn6ScTr/kLz2+C0fKb+osERQCuVAE0heJdetT6HlhPhmovT8TRQ4xpMaNRb/HVoD3ZgyNWbx+qWnKtlxJj5QEESRSxtppdkgyl45oeJd1V6KPfzVpQXaYP+zWt+kaJbUTFQsxRUqo49HEIEaF++36V+wfGHcKDynYWnhje/m+Tn6FuY46J0Cz8SelCPE4/ZDoL96lzCuVBJW/4BCDW9ba0TMww11nmVw8ITVzhBfxmjDjAd7hhtC/63Vx3r7LEO1DXOsJ2A6JhYhDdfAFDrFcVAK17IrS6Z9TuXHrb0bo8q2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(44832011)(5660300002)(83380400001)(8936002)(8676002)(478600001)(6916009)(86362001)(316002)(6506007)(33716001)(38100700002)(6666004)(66556008)(6486002)(66476007)(66946007)(6512007)(9686003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yC8Qd50y3WuP213ueHhuIXMcQLu6tOQri6RwJZ2styZtTuyXEvQH/dQA7bdf?=
 =?us-ascii?Q?hM78trPgZzMPeDlusEjx1rdeL50DAgFjTB1FH5Sjkz16X3VusUVWFWZExfFc?=
 =?us-ascii?Q?2OFurw887K6fi/EElSDGGwd41Ral0AiiTthDY6UxdiDRsKyVjrTOo6ZCAqWy?=
 =?us-ascii?Q?1DQRejnLpq7bY77xDR5j9S1nxDca3FNHF1AYD7qO94HMrdqpmOcWy+bE2+LJ?=
 =?us-ascii?Q?8vonNqPH9Ye2kWbhE6/PSSW9z6bjVCKqoyHSFRpKCfhW0FxSGRmA5Q9IThvl?=
 =?us-ascii?Q?hNJdVEJMOf7NIyCBw+EOC26rcjAFi0P7pvmRk5v4Aov7PDvdSJMWKH1ZyF1V?=
 =?us-ascii?Q?yOI+0r3uO4GorbYu19iMUqbfZrC0N6TkgLiaxiZcmOQKsmU+Ts8vEJt2k4Ll?=
 =?us-ascii?Q?9hbLnzg7JIcAhHQyLjYE0fwFDf36NpI4trU/nln/WifyHwWibNTgQRQyLw29?=
 =?us-ascii?Q?Tjva+pEt2LciRv2gZj6vuax+RZfoGUs00aUy/bfWRYOzfcm/C8sfCEfo5Kqw?=
 =?us-ascii?Q?gd6ISiG28TB7ki/7yX2PekZPeFk9d3TuC5ik+x8rB+yH87v+buUDUuYDvWv3?=
 =?us-ascii?Q?W+FpKkSlK2f08tazSwplyKV9VYtv2VbfgXYh1Kc7lMstW1xg+RN0z3qxzwrp?=
 =?us-ascii?Q?fh8QKMI4x73jJfbMjsrtY1bEqqzc2ET2n8rDwDw7ItdDWCk5uuLUoHgQ4RKE?=
 =?us-ascii?Q?Cz+Fs3tm1mPT/1Ekd5FXTo/KVM7f5xiuYNmgrLVORMXs5yZ8pYzNzB3P4u4I?=
 =?us-ascii?Q?ik6FnebIe8I+1L/ZrAw+WkBEWLUYl+/kPsw8T6AQHJR8x79sd9ezu7vQWaP3?=
 =?us-ascii?Q?os4Qbkt+tOSu5eDFyYoskAZGeVbjyJmiOqyKWNuO59oLvaCHjQsl7wPxJ0TX?=
 =?us-ascii?Q?Zh80wdSfUKMb3r+ne3t5PPBYRVMrE+q5cxHrjl/pD2US1Uai9/1o5YTvqQuH?=
 =?us-ascii?Q?nZVQ8RqVzMG9DnOTx7iq4NoC4japm9Fxo9+1A4p6lkc8D3uoHvOdoUZ9C8rj?=
 =?us-ascii?Q?Ivdww7ZzOt9zwZZKL2wZSS50/sd95GAn7QhGboEIYPJXZOU5Ru1mtFv5X5I1?=
 =?us-ascii?Q?rtGtpNSYQNUll78tcqBC3psQbddYYpmwM8Nk+1PA7ns3M1PzUpGb0mW6KnWS?=
 =?us-ascii?Q?BSn1faR3rHwMeSMZLzR/6khfe0QmllQF58YMekN/9Y1bW+4CDxHbY+mwQw70?=
 =?us-ascii?Q?0nXOqfXbgJBvdqP8V7oVATbnugf9pK/iMajZCcvM4Ykml4a4BrTEY/S/H0NV?=
 =?us-ascii?Q?CDWmXg6ojuGBSV5BcSRlypr74A33Egl7+RCqkwLRi/JGrXSQtcb79wafXJCb?=
 =?us-ascii?Q?jbKvV6o9L76JK+tYH3/Omxwhfox740R6gqLgSJyVB0p/o0YToyf9gsRrNg0X?=
 =?us-ascii?Q?2vs4/lVoaa357a5jnqO5TrL35i8BRSYbi1Khr/L/tvG3ChLQKQ5vgymJNvpB?=
 =?us-ascii?Q?C2YOq8Wzv18y4/+mpD/5W+IRi826L47NDgUkPxqOYMSGKivjiQ5R/V4hoxof?=
 =?us-ascii?Q?gY5OVdy8hDDeeyCctWrvFS0MS2q6jsb4r2ZahyZKWKj/u55Rogc2W3cvQEuw?=
 =?us-ascii?Q?01aJP6tIf0pgKlA+IlA47ClVhgtPYx/lxKWRT3xYjnUvGdyDNMPBFsJCyJ2T?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30360402-e462-43f9-5410-08db9813634c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:28:44.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UsosK9sp6NVfBqAVPUimmBv/6aZV4855RaZI/0VVoeT92mHSa/G+x5Nqz9bmv5G8eTVK/CTb04rsCa4nT1Tqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 03:43:07PM +0300, Sergei Antonov wrote:
> If netdev_mc_count() is not zero and not IFF_ALLMULTI, filter
> incoming multicast packets. The chip has a Multicast Address Hash Table
> for allowed multicast addresses, so we fill it.
> 
> Implement .ndo_set_rx_mode and recalculate multicast hash table. Also
> observe change of IFF_PROMISC and IFF_ALLMULTI netdev flags.
> 
> Signed-off-by: Sergei Antonov <saproj@gmail.com>
> ---
> v1 -> v2:
> * fix hashing algorithm (the old one was based on bad testing)
> * observe change of IFF_PROMISC, IFF_ALLMULTI in set_rx_mode
> * u64 and BIT_ULL code simplification suggested by Vladimir Oltean
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> +static void ftmac100_set_rx_bits(struct ftmac100 *priv, unsigned int *maccr)
> +{
> +	struct net_device *netdev = priv->netdev;
> +
> +	/* Clear all */
> +	*maccr &= ~(FTMAC100_MACCR_RCV_ALL | FTMAC100_MACCR_RX_MULTIPKT |
> +		   FTMAC100_MACCR_HT_MULTI_EN);
> +
> +	/* Set the requested bits */
> +	if (netdev->flags & IFF_PROMISC)
> +		*maccr |= FTMAC100_MACCR_RCV_ALL;
> +	if (netdev->flags & IFF_ALLMULTI)
> +		*maccr |= FTMAC100_MACCR_RX_MULTIPKT;
> +	else if (netdev_mc_count(netdev)) {
> +		*maccr |= FTMAC100_MACCR_HT_MULTI_EN;
> +		ftmac100_setup_mc_ht(priv);
> +	}

Minor nitpick, you don't need to resend for this: generally the coding
style recommends to open braces for all "if/else" blocks if one of them
requires braces. But it doesn't look horrible here.

> +}

