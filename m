Return-Path: <netdev+bounces-13275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9063973B1B6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFD61C20BCA
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1311115;
	Fri, 23 Jun 2023 07:32:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915010F5
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:32:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2129.outbound.protection.outlook.com [40.107.92.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6C82683
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmAvKfrYKB1N2hT3kCD3QZctWJ/n3GEi6Xe2XeEJWajPwGcY1KVvmJnp9Q+pwwiKwhfNqzyKedsygL3Kq2Ik63Gh4BueZgdSAtEUfuRYhs2FqY15bGNYdaGeTq4aiAaMjsap250TrFwisu60VEqqwRXU61wp7tlu25vfk307ZnN5oqvfJJjfAs3v2xfYjE2pZNJ6L8WrRJmuZ65WjJh2McGJZKo1LIQTTwS5Wg5anFui01+9S2spsxtLoBz8zcgBi1QlJZccToHo4TcyvRyFsoY5amBw5eSwG6HYoSUTCjc3ehcmMdww4mva4dU7vko6DnqIs+r6JdEzSNsFO3oEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTi8GEgujj5Mx8xncgF7y6F13KVzumdZSna0PFBwxk0=;
 b=n2PBNt/SCjKoGXRjz/gtDjZvADoP4CFNGWUxwtkui5uGOpCEeRwYX/adOe0VEgiAeHMHi8E8lXsKY6GerOyYO0otvBU7LZMU20xz0zjTC6zwwQV617wjlbgob5wEwzzsOKheHteH1c/iJ+IYg7wxaCxBzgwCqBAe+C+U1SAy88l3YaNXjCn7xUQd9U//08WR3BgdH9MfMEOeVqwsuFJkSzXAReh8o3btTna0mDefa0yJFv4GIw2i29zLSBJn5+YBb49Ma9MWj2vYH41erGChBjnx65KOX494A4kCs8ynqbE06QOrrm25ZnUkNHQjRQCaVwq3YgoGdUm/8TpkoxDopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTi8GEgujj5Mx8xncgF7y6F13KVzumdZSna0PFBwxk0=;
 b=S3rabc8dke96pDjpLzTYgz0GTtjmXb+jluyNDhhMwkdUqwhnAXJJphcUNz4v7xiDgEx7RH3U3y7nm+cVIfYx48UfA+ls5Z71R6cj1YnHhMsJk8Jui6Ge1Lj13ZIxkBGW8eurUglYjU1RhPH8rPfbX/YHT+9tVUMTHQABGkzOyvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3754.namprd13.prod.outlook.com (2603:10b6:5:24a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:32:10 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:32:10 +0000
Date: Fri, 23 Jun 2023 09:32:04 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 2/2] ice: Rename enum ice_pkt_flags values
Message-ID: <ZJVKdP6J6MMWIcN1@corigine.com>
References: <20230622133513.28551-1-marcin.szycik@linux.intel.com>
 <20230622133513.28551-3-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622133513.28551-3-marcin.szycik@linux.intel.com>
X-ClientProxiedBy: AS4P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3754:EE_
X-MS-Office365-Filtering-Correlation-Id: 269c7a6d-7e7b-44a9-1b78-08db73bbf4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	awy1UAdic+RGc+UzCfH5GHT/dvU9n+NLwPnytCVVyXUaejy8Df2qr5NqKAH6BasDlIN3YqcP03H+9GSWJa8CNEAlYE9eskZU/YkwhHSB/dXQNreKZlrG6nR2Lum9XH1eOZcYtq0ivoSdg4uDTXKd6UFVS+95V6lUeIdUlgpBCoZDtKqFFWO8EcIr1FdBpjaIZ46xa6aveiM/XHvm8NvGItq1yy/ciXho9EpCNsuxJyRSxswRuyLF+3IBeCqkdml+lx1WzLFTAUalEsVZ9SD/QXYKp2rROaKbDPB+w74NSzDpoUrLJzcCst3Z4ey88/9ekzXBAl9dc2mNPuFTZwziXStXvis7t4LNJdXJKDtcf1wxZSdl3U9L9vahhpgU1HdtdYGvQdk5ddt3OAv3VdQmFyESF5gwHLaa/MqOUchCePbNwWLaQty2WxrR7daC75Dlr7vEle7zvOVryEFLMC65kparrgP6v3/vJXohjH1SDQ83VopPh2hS9WgPgkPMB9ve+dlPCUCTvuM4KU2B4e9Ir6dMWCipz4Qbjflxz1K3KKnjfFfWuQLlYrMY3USiI6JesqaKC6E6dCf7D6YeDmOXMmgjKafiQHm+nLTOuHZhbL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(451199021)(38100700002)(86362001)(316002)(2616005)(8676002)(6916009)(66556008)(66476007)(8936002)(41300700001)(4326008)(66946007)(44832011)(4744005)(5660300002)(6506007)(6486002)(478600001)(6666004)(6512007)(186003)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S8v1el26LhuRxQ0EWPDDNZDu8nonrLSM1c2cOTHUExyEvXwY2tuMCGGbztUI?=
 =?us-ascii?Q?qTanTWVORNqTEuL/rCLRJimVK7doveh5RJQYw+UjqAjOHR0SNxamaYHJ+Grb?=
 =?us-ascii?Q?YRqT1TFCbqdNgU2wQbiX7ymKG7q5JeOzAc5i/QH8RzGSnES/3p5xPafWmurP?=
 =?us-ascii?Q?NHUd2CpSRe7OZLf1Ny3BaoBBUktSSa8hP09fLGvVA5GO6YZaJEbBFFyselWx?=
 =?us-ascii?Q?XrxCJPWej9A030rvit4c3L7fJda06aJKLpMVLIoi+FB3OiqaPPQSiOJnLxg4?=
 =?us-ascii?Q?G0z+l6WGQ31wwfwGiXu9JiAivBJWbidT9cGu37stzjuXyuO3mzar5pz9f2MD?=
 =?us-ascii?Q?0qLPmRhQeacHENMBf54JzDpSuVpP7cl9Xlve9+H5jY+aRi5fhHFv2n4esZ6X?=
 =?us-ascii?Q?2feQvznpRjRYynxpmOq/f5if2aheAzOLV0hYW6hoil6wEz3V9A0G2BdY6UAK?=
 =?us-ascii?Q?WORd7lKhcux5L/lNr6idCeManCyHZvQWh4gZiNakuTMazKeLHmYpa7eJjJa0?=
 =?us-ascii?Q?IaALBJ3EUOgGt08yClDtWWvUOH7Tm4w7J2CFl8GPSJi5HSQ7iZEFQ/7XbPyr?=
 =?us-ascii?Q?g/0CSNFQELoNgNVXd2ThcYycO8TYbOz87PmtKnlDYJtqKLM/n/YeSZKxxJT8?=
 =?us-ascii?Q?1Gxiy9sUYQFlzdSSzQ2amkQp5xm4K3juGfWob3fz1XkA7Eraoo2roHBRBzfC?=
 =?us-ascii?Q?yWzcmAY8pPFKpOkQkqUk21heQY5yVoZpxesnAQ42srFDygyduXOPAUbjBBG0?=
 =?us-ascii?Q?835OuK0u1UmZnddcJJGcLhcu8Zjo6cWyUZ6ZRs3pTammXBScfa61bLQEeA4M?=
 =?us-ascii?Q?GBGFG8k6kQubry+t6ZJZg6B7A+VAlvijPaALRRcVNDfl4nZkVwY94rXvQ1e/?=
 =?us-ascii?Q?flYDLbRvgFewxtwvqMs+5dumEHwGka3Bx67eoszjlmo0y63G2skSlx5OVNBB?=
 =?us-ascii?Q?ujPSa26KpFAz6Ho2jl61St/sc/KJf9MO4YoPKJsth8okl8ETNWCsujh29Hha?=
 =?us-ascii?Q?/ZUUyzd0SbXVdKZxYILxeWhoURY0FzaNqeaCzG/e8JGW7fviE1I01SE4e5O4?=
 =?us-ascii?Q?D80F8i24C4PvtC/b3jh8/gv41GVmXfcrX+NVa3fPcHV2AbTfZx+mvD5FaIee?=
 =?us-ascii?Q?37rcNEg/Ad2yZtwhRMuR+lLy95V9EVptsrGw1thqZrQ79c/4EHwrffcG/1ec?=
 =?us-ascii?Q?QBD3da0hBexRrnuCKVUNFWKYYFUkl4KXbtoMkePiPBuu9yCUFGyAxVVatSrI?=
 =?us-ascii?Q?OirYELx15L3Nfe4UWnwgmeM10NpvnmxCMMfmLSjxkzwkT8vT6XbdLhKZLxgU?=
 =?us-ascii?Q?jzDM5f6AQC5xXcZXC4NdneUKIG/EnU7ASz+cYTkz/IzDPPb1JUam72ScWm/V?=
 =?us-ascii?Q?s6FZ9xwG0iZc30/Qa7kMmgpzf1leL7+TVkg1nQQik4kPPlmaZYqVefwe1Aun?=
 =?us-ascii?Q?gBJiqQsnO1c5kbi9cRBbOiYUUIoN3gQkdDoxHg9N4exPNdfyLgRTSbNoet+j?=
 =?us-ascii?Q?gLhTLYUMzMhzhBcK5JgA3RQ/Uj7Bn22Cl3uuLd3UxD8nZm+RgFDpG0U+haxy?=
 =?us-ascii?Q?jlYpGgpMYVaheRdnnzffv/4eCKUzAxxeC3sZfz2dcT713J0TqN7WgjRidy6T?=
 =?us-ascii?Q?F9lHGfzsIyjwZGzgrz0emXfzGcqoHFJ3kQcpP1s4UU6era8GkO+zv18BTNeG?=
 =?us-ascii?Q?XDgq6Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269c7a6d-7e7b-44a9-1b78-08db73bbf4a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:32:10.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuQ6vkj9KWButxXyM13YNdb4Bqx19/FHNS7wgXyIZk/2hm6evCGwOuIT9fDj0OLIp8TOIbcdoRYL0Rbazyo+5dfQAYapC9cmMIrA6u3cTsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3754
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 03:35:13PM +0200, Marcin Szycik wrote:
> enum ice_pkt_flags contains values such as ICE_PKT_FLAGS_VLAN and
> ICE_PKT_FLAGS_TUNNEL, but actually the flags words which they refer to
> contain a range of unrelated values - e.g. word 0 (ICE_PKT_FLAGS_VLAN)
> contains fields such as from_network and ucast, which have nothing to do
> with VLAN. Rename each enum value to ICE_PKT_FLAGS_MDID<number>, so it's
> clear in which flags word does some value reside.
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


