Return-Path: <netdev+bounces-17535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B9751ECE
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F332817B4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D66107A7;
	Thu, 13 Jul 2023 10:26:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67018100AF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:26:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2139.outbound.protection.outlook.com [40.107.92.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59771724
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw4qmJ4gKsz2DhkG4fr0+/oafHExnW47gkyw8TRgbD3ZLmEvdihfB0VKBkB5fjdpDHsaZGZVyTolHWS+ROQEDUNNtbkhcgl4BH8HCy256N9hME1qZIU6Y9G2+6kaW8uN/an2NrWQOp7tReWQWudBp3jyo0cHZ0+lY043LDHMGK1Lv0Ffiru6KRzgqoXMF5F5f7RsM8dSVAsWRv62j+x2VuTJZS0e2x29Uk+Y6bnI6n18pegb1XWUEXNRkB4iVLlyUB4wQncd+P6Qzh2lEEYYXXCKHMraAtiWp+YsZKFHD9XTQbtrnTpDfy5/70pXNp/izIe4JXn9WTn67iL0JLIsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3Gtar190gx6xXkgSqlFhZczjdlll0X658oTsHkcSx4=;
 b=oKJa9wLe/c/eRBqM7zKtvt3YccN8IDPdGS/Lro0eUUCNmdQblXqHHKIqQ9/VD1GXyWuZ08xkz6X7fKhswXXF+6RqSg0WFCMdtOi8rn611M1BjLHYo5qdWBVxfvjkizPU87HGuprCiAslQuQjq+fRtAlB6f4Qmt9XI5DH014SlFfTRU0s7CZZD+Ac0a44iJoLGzjG/ROWpquYI1FK9Rjfvu8BXOzx1PK97WlOcLlARVYIDZIMx1/yypOhS81U1HfEnY3CsD1CUJ5Fw5wzuZyEjHN7qogNVOcobL0Gy9faCSd7Fx9rHIp8LvwOQ++bszl4GDbzLFA4TkD7HsjAupuVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Gtar190gx6xXkgSqlFhZczjdlll0X658oTsHkcSx4=;
 b=RBX/jMF34A8E/Muii6KK7kZd78EAOoghJ5fjbwZ191Wi0j8RqyB2zYdxSi+TuzxI/KdQASekQWTIAZXwJmKhOCNpdryWCAX9euG3qh0F7Stl9KYQdSZnqg2uzwH5Aw1xFR1j8MrgdSpaIZNZboN5SjEwqu5J9nV/Bh9gI1QlsiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB5492.namprd13.prod.outlook.com (2603:10b6:806:233::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Thu, 13 Jul
 2023 10:26:48 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:26:47 +0000
Date: Thu, 13 Jul 2023 11:26:40 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: linux@armlinux.org.uk, kabel@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZK/RYFBjI5OypfTB@corigine.com>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712062634.21288-1-jiawenwu@trustnetic.com>
X-ClientProxiedBy: LO2P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB5492:EE_
X-MS-Office365-Filtering-Correlation-Id: bc83069b-6d2b-4c2f-3cfa-08db838ba9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kQtrMH96DnXnHsdyuE143uZ874kAcrHPN5Q1HSn4vuZnHk5NbAaedYMqk1SZ5xwu/mQb040EGzSGnHebcxSkXyjOZhH6HTjVhLaWfLyd1JDEUI+M9GbnUBJ9vSVy1XlZKJ6wy7c8soBm9rm+wJVnIrhZdlJARIN44AugSyu4be6Z20eGYA4QeWFMm3UaDHoidU0Z4GyggL6ugkIU4JeroeHCQwQ8s93AyZv0kGy8PlR5GSIwf4gQmhPpTZxL8XI3VzuXsA2tlPczarbh+mXtyg0GctVPFCec9KeDMjL/6MeU2aieKJGh5f1aFhcLgDbmcS+LkSNXjiaR+1iHJMIZfxPD5NPbxlNHieqiu7tOlEqPymkILF5/nJ8D/YQt0bU/9dayLDZ2U3moPwjy0LzuSmUUOimSbWmkf4+R9vLtUVIvN/04kP2yW94Y4YFBruZgAcyvpSJSCe581pZikUyHRYfmJSqNe3Vh3J3nu6pElo6GdEFalicB4CDLOgoB2j6tzT4WeRbRQusgvTmjVtxUkxiAfZbtao/0UEGfKecNUbDbbe0+2r3I3qjua+NflsGlQk27ipxcQAMcjW2zi5/gC1a+JYkS9f3wq59huuz3y+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39840400004)(366004)(136003)(346002)(451199021)(6486002)(478600001)(6666004)(26005)(83380400001)(4744005)(41300700001)(2906002)(6512007)(6506007)(186003)(316002)(66556008)(5660300002)(8676002)(4326008)(8936002)(66946007)(6916009)(44832011)(7416002)(66476007)(38100700002)(86362001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ny8UO87LEPSUE+Xji+GxSXXtjWkWP3+LZfVSHAUG539dYL3zpUqPMwNhT3EF?=
 =?us-ascii?Q?IWPNLLz8OBvE4jHkcvhxtAGXwEGW6/13fQBaDa65gNflr7wdMB7g46QlmNr0?=
 =?us-ascii?Q?0hsF+K9FHdCQRdx8CwJVgQnvgePm9i2TTYmB2yFRtr5ecISeRSEvndH2dz8n?=
 =?us-ascii?Q?Ae0bxepWY5N9Lmx+xETNiJGvtXi/oM3hDjMVMEtaxY93+/Kur7udZIFA9I7y?=
 =?us-ascii?Q?uO/Myw4mEoykGlbYw3HQqwpqqSdXQ0bLYs4evz968TiV3voNi3CDUeC9VVzS?=
 =?us-ascii?Q?8bVK/l5/BURZWTSBn/cxqbzde3ZeU6D+45MCilPrh6RItcUdpNji7SAuWetq?=
 =?us-ascii?Q?ySHV0CK1QYhHa6z2rDJ0ck0Ki8lngEsfP+b+2G/wxkIipmKJRbny9W+nsezu?=
 =?us-ascii?Q?bXaZAvPFE3tSM6b/anW3yKr48XXn2a2jhhDaYmG8vWs75fKNxAFN7s508w00?=
 =?us-ascii?Q?NP4gJNPJ8xhbHyl7Vrim7fyjj4sywu/2ks1G1IhyWInzPbwx17C8kUbtFcuS?=
 =?us-ascii?Q?kcC/6CdXYPkCyMiwtjy+bZIRkiUjMQplrgcegBKHg1ZlKz8f8suIWHQzi/fq?=
 =?us-ascii?Q?k60Z6sprRtwT98aGPNt49dhWmaYb6flnizl20DfT8K7NtgN/gp5Y+G51BDC4?=
 =?us-ascii?Q?/+PmxHj9P7CnTmtW/raNctTWYrFKpUUgoA48E31DEuKiCMdG2OrkYN96AJsc?=
 =?us-ascii?Q?cJhms8xr/nxTQFp/zaPOLEQEk9zDMfG2UfoLEhv3lt8l01fsbRmmwFVV5t6h?=
 =?us-ascii?Q?p4B2gbChYtrl11VIc552qhDHRa2IyHVEEeZJTIJ5Yedqu9ZBrSDIaPdSYADr?=
 =?us-ascii?Q?H5+899j19xuCkb1/9+w9K5+hb5l9mK01DgAHBIIpwW5D5a69Tzzwc0nb5Xzh?=
 =?us-ascii?Q?Om9Nl+r5rAp8iGDxI/3t1T2KKm/z3TumgVOFJOiVxEXCO7c7/rwdyM1XoCyG?=
 =?us-ascii?Q?32YpPzReUKV2UTFgEJVBYihucj20sqhK9ZXs/BeZM4rPxYlAiAfZ0VY4Fwct?=
 =?us-ascii?Q?bmfqfirWWQMYerVx6U0CJrezjBcFPlppTEpKTBilVlu/M2JJ3t0MQPzOvnTt?=
 =?us-ascii?Q?lwymfFbtKVBfB8HxZULfYqBz+jihp9bnpYv8eJ8tpvTqSleKP9MexEUtUuvU?=
 =?us-ascii?Q?wkNmO0pyRvVbqB3mcHw6EiiOleBSAYbCIMSFVg4a4DGddHne93eL6XxVbamk?=
 =?us-ascii?Q?nFcRZy3rqzsetkVz8ZImnaheUB4jlGTnUvmdZTj5B6MnFRuPFZIqFrMssQha?=
 =?us-ascii?Q?NhuuER4yu2/JObXrqCdRy9c9qX2g0ej9pW58LCL0i/clQP+THBEg0zLyI4kP?=
 =?us-ascii?Q?P7Omc5gEIw6lmqwG2NiOXKb6NJ3UnEjhLD5ZuW5zUdntBfMtMG6EtZiFhZnh?=
 =?us-ascii?Q?gdUM0ros3NxO38fIQIv1aBNzF8waBgsuNL5K5+ugqWWHGuoNMvlsk1/0ammi?=
 =?us-ascii?Q?yO3KvxAgS/NC9wzTVdKM08No8dGFfcqq81c0UCcVP93H0u4Nc/otQFW3Kgp9?=
 =?us-ascii?Q?89OwM7N9smfE7DH2BlC3WjdK+SyfcXE4oiKyoLGiL3l2tjij1rx+M0a2/7M1?=
 =?us-ascii?Q?omi7t5M1oNm2+NcW1eXehkmP36kJQ2wFuXZyAJey7pOa8oNQmAYLS7wvSKl/?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc83069b-6d2b-4c2f-3cfa-08db838ba9bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:26:47.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c22XY5c+LQrhR2S/p9nOdFK+grWuRha33B+8avXkP05B1kmjhqYMErxXSin6lefKzMK/MzaGk8w5pawVtZS/IzolZ/JD0g6PVzSWBjopRbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5492
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> it sometimes does not take effect immediately. This will cause
> mv3310_reset() to time out, which will fail the config initialization.
> So add to poll PHY power up.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Hi Jiawen Wu,

should this have the following?

Fixes: 0a5550b1165c ("bpftool: Use "fallthrough;" keyword instead of comments")

