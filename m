Return-Path: <netdev+bounces-35417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51027A96AA
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A266C1C20B6F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8514F7C;
	Thu, 21 Sep 2023 17:03:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438D17FA
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:03:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2EE63
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVhGtJT/DFE5zPaAVQbU4WFcb6rKCdz3dtQ+4ycjeBoNcRh1rDJ2MKtFAtVIwBSduBT5o8PbiveKVWmTaX7T604C8MJDs12Pe5Bu5QhKQGgFn4rn1bdj0kV15F3MoWZWXkgmhCCpitslMQS9/EcNs+5p/2nlKTvf/uheMsqJS2XU+SRwot8kwbx3otQ7Jcg01zy7UYAjigR6HngwilFjp9gUA5EH/vq/lIc+p88TdQFZEijezoW4PPcKYEYwE68PrNf/fUGkUc/wPYvMiIyU+poNHd1oqDJT6Ju8RYQzxEhu8htkR+KYPSJws/fXzekPDkbSS4OAI9kq3gZwspGMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OC0Oow8ABi7Blx2dY/ctL43+MLt3DT9vqm6MjwQ6Q4=;
 b=exZIVjiR6q/nXHhdyUe52V9nwdEXwNwgcvTuzHGtlz7HolZujUQnpWb+vMMkdmBurtudvcK195BY0sQNQcbGe/t88B9qL+1x/xI12uZf4PD163itucQZy8Jy3iJbYFRCJt9lpi7Bkgj+gRXZDJYNra3GWyUt1TIXt2712bpqcg+9LkZzzLiIfIghH8G6f/itHEn+C2iry1qk4Sguh2gi0XNIbMVW2LebJaKwZBkENYAgqA9lBliXRBaD5+40eEj+NFOfAZc9hz7QrtnOz8po/yzE7p2UaIC/iprNNY5fPH0dti0gueLN+I/apwDh7YNf+xRYu7yPFF0/to6hPwZirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OC0Oow8ABi7Blx2dY/ctL43+MLt3DT9vqm6MjwQ6Q4=;
 b=lhEOy6VLOIk+AY30gmAa91shPQTjmWPm16FrsBfan/d2NJrHSveUkXs/4F3RFv3c3PWdScIveO0psLZtAZmRBSpWFPNhsbNbgaBSKaCihROQiKgDIu2OM2v3pz/OAyrg4NRajBhw5nd81nGn78rwyTRN228K5Abiu0mltXjPM0cddNpDhyQymp2qX/WuTW19GRR2cx5+FXKZcGLJ14VOG/TtS3sl7h8LLTB3gm7W1XHhRD8U9TDtSe8pgklTlPQi9B1VLds9IZ541HM1oTdUopAk2WL1Lpb5w6MYJAgwXadqHrJQtjzzxb0h+uP6CsXiQ/cdkkBsg24rGzCozjD1hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 13:02:28 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 13:02:28 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: David Ahern <dsahern@kernel.org>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v15 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <ab57c5d6-be1a-dca3-1629-4f81b07a3c19@kernel.org>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-2-aaptel@nvidia.com>
 <4ae938a0-6331-f5d6-baa5-62eb8b07e63f@kernel.org>
 <253y1h0j7j6.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <ab57c5d6-be1a-dca3-1629-4f81b07a3c19@kernel.org>
Date: Thu, 21 Sep 2023 16:02:21 +0300
Message-ID: <253v8c3k7c2.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::28) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 9215c9f6-6964-4332-c9a0-08dbbaa30234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5UGObZBjR/5j975oH9PvYS1TRpZLYb5E1PVBhKSDrz3VaDQ0hlInEKWQOX/h1yKR5ezLjm7+y7bzi6c8sNl6P280Wlvu5U4CZu4OE8I5WXBgwCGSk7YwEnx+QIeq7/FrboY+gtf5EHtW+7gSnJfOjJBoA0Df8rrZnBv6EGhekb2HvW/gLnupyaDJf5+6QS1yzeIVUonaXXvL1CfYrG5/s6T6Xe54lHmoVPd/3o+qRynYbGQzzg30RShRiHHHDwa+akNFyzkUkaDbjz/B16qwl+68OuKpa8dG+qe5zVBzpxvhJrEjSy8AA69xXn7AEAv3bRpU1rSKEN1lawFlzMwwZAWjj1+7qo6B2JXep8u1St27A3sOtsMudKlZiAk+dZJls3YizvlGt+MlWAoDb3/cuENgfQ7pnf7/eizS86xp9ACtJujykUit/eqr0GTDp5QQdJwMd2fn21qiktvtVif3S+H8lXxZztjjfzPHZ/7xY6ePM2Ytl94Djt3zmPo0t5KqPCe7fEsA4YXImL0OkcPxP+MAKp8Kph3dls4yi5ImD6w7jVDSI7z8eeAV6OkKjCRQNguxdpdia/QchBT0ryFzVJjQP2kMQgiMSn0yBVytbPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(1800799009)(186009)(451199024)(558084003)(26005)(2616005)(41300700001)(2906002)(921005)(6666004)(478600001)(6486002)(36756003)(38100700002)(6506007)(6512007)(7416002)(5660300002)(8936002)(66556008)(66476007)(8676002)(316002)(66946007)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cGIVGek9U2FdX9yJMvxeAChDriBuGLgP8m41Hhu8ovQNfk1jqapItEaGtwqD?=
 =?us-ascii?Q?rpNA8ICo2Y/nDHDF2kOrAfKIEZslDKL+QrH3yUAT2A6cW5AU+nw3LwD6hKRg?=
 =?us-ascii?Q?HMogVC5oJWNesqUT3gxJh68EE52BmkTVfimHdCEmNQ9UnQxrl3rQaWaDt+bz?=
 =?us-ascii?Q?1fffW9wjtAARQU7YC2B4cJkX3hc3yM+KMHhitz1+zMvAKHuEX9+0CAiTsvJd?=
 =?us-ascii?Q?dyjia0yJLfn7DtKVWHS+w/k+RH99ODaMhXSi/WsBWOFyK++X3zP6HbOkgGb8?=
 =?us-ascii?Q?WvORKDi/aeUc+m8WIBnepFM4tPnURZ2EU9UBK73LjzPO6xOYJbgUfjKU/ss2?=
 =?us-ascii?Q?Cm/OfQMK8HFxFLtoaCW/2MGc9pETG4EQtVRKgMWhphlwOy3urH0R01q2j5h8?=
 =?us-ascii?Q?yTz+v8+xB4L7UXCjwHhi6OHgvsGIfUUT09fVLXMENLM2GtxEoPbZTfraZa6E?=
 =?us-ascii?Q?gIg0scouAwGAGz4qcOAChcrW0xwcEhq+KvZLStD+DZwEvxyFkDUE9oPgxT7r?=
 =?us-ascii?Q?oGxinTVM7xyPU0ZABkfEKyV0JJD/JaCYeJ2/A7bYkZklYUAx6FHrSu8BYOKa?=
 =?us-ascii?Q?KWM7hoPeFWF9qvPDh9lxmTTFC0aKAyfDrY6v/EnAXeuRCX+JQQ9XbgFB2Wg9?=
 =?us-ascii?Q?/iZR6ETHsk6kMIJVfOrbrEqzV0g0sUQUivu++zDmLMSb0X+M5uYQyXUEIVgE?=
 =?us-ascii?Q?GYKESWk9sRIw6WLRB1oCjJp0UiPXzmsavMXnIeBvkG6Dn59nDHaDCYrPaL1o?=
 =?us-ascii?Q?4pUnnjjUDDb+owXX4/QjZBZn1JBQNjqBCBfSyOudsDeAsu9jHFBszTOjc1TS?=
 =?us-ascii?Q?pCXBOTDvdc8JHx+ES4AySjhRY0UFHBeGG6pvJNpysDZSSfP6u9NynA7cg0nB?=
 =?us-ascii?Q?RMeVVYK9SJ9XdTwTRxeBhmagiogiw+7iy0ehSoVIlM0X94ud4MNjCHFjQF9b?=
 =?us-ascii?Q?esuDhAjYbazueqteoTtl8CDOiGFLPvuTXFNJvJnwyHM5LFrvtCfkbcAa4VJW?=
 =?us-ascii?Q?CYr8xyUkok8SeJMJKtzEpaSmdsAR0zhGnsWR9pvsK/V8PpPeUjl7wRnVlhl2?=
 =?us-ascii?Q?rmL1rJaNGnCEXoBMQagpIpsi5YeWe0saQ6T1+vnAFzR18YW1iLujpA3zS2Xc?=
 =?us-ascii?Q?KNFEc+5ezzYiBUiMWXiSk87mBJUaaZNB6Gm8tydebmMGhkVhdKe1wHFCIhRR?=
 =?us-ascii?Q?3ts+EfLv2s6pAJA3h55MJnfH2twjgo95Kjk4sPpKoKqeEsvo55HZcQxwDx4C?=
 =?us-ascii?Q?NjBORGabz4pfQElOAHQN7jWR/24Im2286y5TDXnD4mnlAx9mi0jGJYzyKInG?=
 =?us-ascii?Q?qKkpaKs7M1xAO9OMHnNfIC0l2spIbFFAUAPQkAyrlQyBLWnCV7jLOwgU9KcG?=
 =?us-ascii?Q?8jJCvtdwMkTf4kwgEYVY6XOeWSeCsrDriRwNF/avAdUeuMTObsdEp8En7sHr?=
 =?us-ascii?Q?9BLSJSIgGcsMWZBYBzmzwvcLJ0k2qIEGfOc8mcRNh7CpH5/XYKvIK/E8Jod1?=
 =?us-ascii?Q?eXbwAPW4nLIhnlP8ny2eEcpZDzx/UJcMHVn0F0v2gh65IGB9O12ysxTxBI63?=
 =?us-ascii?Q?9FrWTzL1Ud3g9H8O86R9LkALsms+qQskgg4vBfkj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9215c9f6-6964-4332-c9a0-08dbbaa30234
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 13:02:28.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkXHekyiUo1W8SG49rq77Zprodk+PVrCFJ/LL4tU44xBlUx4HEGEqna4bEtM96f+CAcfohVNxQPd/Pq56R6ttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

David Ahern <dsahern@kernel.org> writes:
> The number of single use case bits on sk_buff are piling up. In this
> case, skb->ulp_ddp is only used to avoid skb_condense, so name it
> accordingly. skb->no_condense for example.

Sure, we will rename it.

Thanks

