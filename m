Return-Path: <netdev+bounces-13291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5F73B1F7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F0E1C21097
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4637211F;
	Fri, 23 Jun 2023 07:43:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3C2115
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:43:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2131.outbound.protection.outlook.com [40.107.96.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A42954
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RquuUaSjy1tPD7i2aitSKxplR7UwcoKIdCB6qU3LiXV1CsvWLGvQlgi9QBvOeaG4vfdjHJ8bOA3qw0bUxJYKJG7TlEcIGV4tLx8vNnY8WqLmR2kqjszRRHYEHZ23o2pvo+oQgnodfCoRgOWe6TQfjK7rVH3jbhAwsznfcSuqmY74+9espeGJVs6DZk2W+XJTeITB6oQueNskkN6tOOOwLObynM5i9YpsHaRHYALRZZ2Kov3OAH2zSYFDbjIkzEh4WU/b2xuWvzj8kXCp9o4oN4401ykSx9GRwY0z5jYp3RiQfbNfDyKCwQfs+QEd/boFH56fccGg58LitVYk0S0aQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8HY4eLLroPGO04PAiIvrrJ7wzkh6sY7oipSbrrtF+s=;
 b=fhAp1JbdoBt/riIDcLKVXYZ2/4ef2N58vthMekQXAG/qo+7uUCzJUeNXG83Nr9Rv80EkUyg24rMpMn4Z9KlzOVT1ulO2vFd52hv2HMeoCoZczuT3NyzWsj+0sLf1m415K+K1T7/tpl9hUQpP1dqpBzVAKcxx8/2YUHgDuSfhP5zdc9MIdWCUVdbnDvTLmpkTQaV/3Mn6HqLLy8Obfs7CuqLPGpMT9PSzGIUoynO8mbySbp73Oq28FhcOnwZZ7xFJ+VsSACVddjxDeDR0cn8xZt7KRqDrn9v+A0igEzym9psmw6W0gAEGQJBOvmnKEvj+Aq9OGX0rTbWjgZf1btp0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8HY4eLLroPGO04PAiIvrrJ7wzkh6sY7oipSbrrtF+s=;
 b=a+RYODlbCMaIKF1JfAozaZgz4lc+yEO+EdMyTV6WT+f4gFTDqCHWG2FqeZy0skxqDMfW371N+4NoPXe0vh54xVTYryjyCrZgCOF1y6W6Y8KC8wDTpQCrCTUBBqa4Fy1PZYhRDS1zEQ3M3IMAjTO1441/D2uT1ZggY1JcR/rZCSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV8PR13MB6375.namprd13.prod.outlook.com (2603:10b6:408:18a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 07:42:07 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:42:07 +0000
Date: Fri, 23 Jun 2023 09:42:01 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 3/3] iavf: make functions static where possible
Message-ID: <ZJVMyQYRCTMhsnrq@corigine.com>
References: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
 <20230622165914.2203081-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622165914.2203081-4-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM0PR03CA0101.eurprd03.prod.outlook.com
 (2603:10a6:208:69::42) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV8PR13MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dd8bdf-fab6-4e87-8996-08db73bd5839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QeFcTn9/Gq1tphxFEzW/JM5icuAmULBFTyOlfIHdB8JlfA7/d2RCUry22v/1M6K4YhWqZVCN/AK2Tvh8A8joR3gVxCrKIRZUCZ/Lk+3ilZ4s85Hxkmhj49cUDIg+HfplvIWAelcJmXf+Ewa3I9tLNv8ul5eNkF+eRzbOt1bbpScI89ITRRxZT0PpQH6hoGBwu0aww8Rec8rYTs/YnoIfsj5iL362HWXLWQShJJqfJW1XC9Vv4O4BZ2rJt/fhJwNJ9BYUqiE5e1RinBFO/k9MozxuGnW4QNnZq/PAA0BwALPrUlsdbsvnMNyx8I8a/f0C4dCivTOU3FL0NI17E1hoSvMiCbPC2sNlR2a4vbKtoVcFdGl20RHirhx5DqOyXzIaOW7Xt4jHQXsQh4IWn1F8ey5iAjFTqwvP5vPZAl1Rg8cpsDfrLaBHDz7pzGOwX7DPPPbrBXm/awPRfrdpjgHKjeeLG24AGWDKGgZtuJGmtqoXTJsKzmcOVbMOmCrDIU2/eYSzJRHiMY/dOVmNhFm9IgxxbNDmYiPHYrAUzAau2+zj/QQpRvJdWR92eODI0Zho9titdQ7W1HbDF8ItRC4U4yB3lI/OynBnA/i1nPilzPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(376002)(346002)(396003)(366004)(451199021)(5660300002)(478600001)(6916009)(66476007)(66556008)(66946007)(6666004)(4326008)(316002)(6486002)(54906003)(36756003)(86362001)(6512007)(6506007)(186003)(38100700002)(4744005)(2616005)(8936002)(8676002)(41300700001)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MAXDeRhVyK3INDPznNVZq6b6CCe4hPxyDiEj3fWMZ7hyJnaUxSr+QrNFjCQF?=
 =?us-ascii?Q?3uu6yfd0XqVTxU6mTv/RDo5usv6NOm6s6faC5M1HHu1xwvYgiLhAjEaKnxxl?=
 =?us-ascii?Q?UFCaRf+z2uLl4+F7ejZdx7a3NNdgO0go008UNq75Nxjf5u7JOMkDaUwnUbO0?=
 =?us-ascii?Q?LFX8TBTwvx5OsyuKmR4nRKdrmmuSD3LXeW/G3mGRwpkv1fP54FPVM64zPIB0?=
 =?us-ascii?Q?fNn71ZjUZ/bpBwKZZTmhQnsFL3kvjNx/ucaa0XQGow6ou/qYUd0/ycJ9inWG?=
 =?us-ascii?Q?bf/liaibVqpdhd6rIE2nAU87tmaJ8N/XkZKKtYxq69Z4FK9WfxVwAEm5KMvJ?=
 =?us-ascii?Q?ah14CqD18tTNSmQoYwQpqZEnV95yMgX1p8f/Iix8mE+ghZvw0WQaA9cpDXp1?=
 =?us-ascii?Q?iA7Qb3KRhJVVY8lgGRmVyY81/O8SSE2TfXWewOLzQoOt5G0A1eaEqHwHDv7U?=
 =?us-ascii?Q?aBtoyegb/GIBUboJLY0Gm2/Ko8DQWYamQCLUxzEoLSmlPbmLWLfev5Jes1sT?=
 =?us-ascii?Q?Y716ThseJCy8VqlsU1IA0ODntKKvkkwqwEuU1BK2yc57AGNxn4cmyUaWtLe8?=
 =?us-ascii?Q?5Z/IXEKWn+YWiNvN7QJwSdE/AXopWkn3tKe0p4c/Rtr06ZxiygbiokB2p8EZ?=
 =?us-ascii?Q?BZwOVwEx0Sb0HxKztC4u8I1uEtK2wvHWo8f485zuOcXv05dkgdH5zZtbuEaN?=
 =?us-ascii?Q?MXq3IyrKyqqq46xZtIse7tKXEeDPaUTlKc6M2xbB3hMSily+qahzEgsotRzW?=
 =?us-ascii?Q?YKSePwaFhFaF+LAg//6fxO/gw3FDjJpyOXFHPgsGuXLiOp88p5G5GVU08jpZ?=
 =?us-ascii?Q?VaNCZmXWQqd+BLCZAML2YNJmPsnKlWojBM66i78kzaWkKwBQRIL11TDNsw3G?=
 =?us-ascii?Q?N/0czyMd2SCA4BGXXx7zJnkts6S60hkRcoKpjw25kNaoR1dHF++tqnKXikXu?=
 =?us-ascii?Q?ZpD5Yp1VqsrPPANrvgXvmTanHn+8eo3uWYpuzbbffad3IaA+j+wj+MgC5sUK?=
 =?us-ascii?Q?PLtmLVoJCzWomT5N5aHn9qipDGpQrMFydsV+CN1v6PmeElukIDLc7XtmNvjp?=
 =?us-ascii?Q?eF6u2sBK2sYXW1gUy2qKfrb7elqm1TvEw/5vC2OHw05pXUILwSaoXnLENMpW?=
 =?us-ascii?Q?95Qs8el4MSrRmPNPpumcVMzn/PQd/D+un23ocTsx4yU7zGmhlUi+eto0H2uO?=
 =?us-ascii?Q?Np8L5ZlyvxXlfQbmnUUZoTnsGcG0q9xMXR99bkOMZ9j/YCttb+qKi4Bl9hSV?=
 =?us-ascii?Q?qO7n2EsIcX+kbxYhYACnKtDJcWKl1sKAPK36Ejx+aSBqegs9q1k1NGChBLOP?=
 =?us-ascii?Q?Nm9wJJ28lpBrRe40boRsTTYglobc1iZaSoueFZmOR61xAyh3ZbPZiim1qN9p?=
 =?us-ascii?Q?ki2wE2trBCg5UW4zISLaKqQv0xJONxL/Xb/SsrhDrvI2j1I0SH5FWefhCnR7?=
 =?us-ascii?Q?oi/c4L2gaHGphNm5t9WY/v4cbIYvIh5a55Rt2MvKD0w1lGYzhEydhqaYZhNG?=
 =?us-ascii?Q?WO7ECqfT8sV6D8ukSNpj039HzmQwTtRTfd9Kkf5d5f5GZuewZ9s0mJHG6ABK?=
 =?us-ascii?Q?5X6mnpJurwCmP7B3LfdsOmvTRJtw0z84wZLBU1+xXJQEXHmEkC49skEgsiwR?=
 =?us-ascii?Q?InaIi6yKREAAlnAO8uWGAgsC2NN/2V6pUy8cL4wHnsjbFyqG+gWw3LrqHm/7?=
 =?us-ascii?Q?ZIEVVQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd8bdf-fab6-4e87-8996-08db73bd5839
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:42:07.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZiMWb6zHSf1rEn7fWQMu0RGxrv6Z78vRfrEWATUIwNBwyEH/r4LkxhOTcT83wPsVPgcsWuKk0xEeEEYFojjGevhsVorq0bcKl7n1TgF7kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 09:59:14AM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Make all possible functions static.
> 
> Move iavf_force_wb() up to avoid forward declaration.
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


