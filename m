Return-Path: <netdev+bounces-37554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3841B7B5FB1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B8D86281631
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 04:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F3ED2;
	Tue,  3 Oct 2023 04:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03443EC8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:12:33 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2126.outbound.protection.outlook.com [40.107.247.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003BA1
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZAaPq5cr1DTgouDracH6Xl5xIV1CCaF2RwTR90s19Ltua+WYq+dCtO9Sz6IzlC7kdwdFwenC8sDt2Zypdnauko6gDUiVZ6G2fCXZxkvVX0N6K9DlYDGv+4Ei3CzV5vuLJmsvaYwfVPApWSodDnS0XVQsTTKlyTJOHnWvt7S/pAp4Yg7G5VfoqXPt4liZ+z7zPqPb+rkUZ3wU03lV2oMO/u6MQ/B5FrppGkDinP0L2dgjm3X53nyOcmplqRtwVtns4gXvTXG1UkMlQGpSMGXN8+/FA1zyVT5YmTiijs/vcX2aTPvIN60yaX6g68FtAZUAQq10RUKDFczH4h0czbxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc5H8kxBGYV5FyYWciDSyq6MEocC9u6MOWC4Pm2oNZc=;
 b=n+NkdaudO0l5B4u3y+3LvK9+dMccmq/4hFq5IXXPRReccu0vZxkUUd8VS5fzMpPGON1AkSWuhDlsoTpwkpSJRqA4hx/KhkkKx2vK1TzrvGGOxAg6CpYrC9q+/oh3sWyX+04/v1KfC0dMm7kT3FwBpkKpJM63EOxXvvbmEVrZcEdCcn7rtOZOAN3w/IKicRYMBCdDD8rd2M66iTz2IBIoxGTF0eI6dQy8Ym1eKjujHZlTIphsqPxR+yxdA7MN2G/YAPg9NoNyxw08ALce4ww1F1Nqo7ZFsYEmnsZTPg5O2xibfgJVV2IVVYbmeoaSAeOz6Hbf2ZaV3TmK3R5VF+NczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc5H8kxBGYV5FyYWciDSyq6MEocC9u6MOWC4Pm2oNZc=;
 b=kwfwKu5qmAkREuhDZu+fj2ZPOdAGG+EeUpZVSBhSTGoWzTsWk0P9FecUYTNSKhFOQnij5prxvpseilGvRjaX2UqKTwbEQv3e1xHMSjcKYZ+wftiI3lk0YMFPC10kfGRr+0FTImt/EUOP3v7Ryyf7v4mSPDWbgvNHbthzVXKX0l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by PAWPR05MB10164.eurprd05.prod.outlook.com (2603:10a6:102:2f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 04:12:29 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1%6]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 04:12:29 +0000
Date: Tue, 3 Oct 2023 06:12:25 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, hawk@kernel.org, 
	lorenzo@kernel.org, Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, 
	mcroce@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <wt6tkw6g5ouhjcs3mqdibzoveczfqmnolpdzxaiapfbs7buoom@lvfwkxjk6bj7>
References: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
 <20231002124650.7f01e1e6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002124650.7f01e1e6@kernel.org>
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|PAWPR05MB10164:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a67926-5865-4452-061b-08dbc3c6f5a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0AvGnwOOpujzfiNoNEWW0P1ACl+zCRDd8FgpprnS4cs+vW+MW2omAW+EdVqJVifOe/+MXY7a45YKtoXaxm1qx++bJS0nDjuASN3Z1qcXBB3tKV0ut8xgNfq7qJVOFxmSGgsLei13HMop3W/ba8zW4fhqgR1tsfIel8RpYQPIfSjQS96E6ZV9DIT+az5IcoceSu9TJfds6M8xxDvt3ipDJ+H89J60N1GJgPGgzushBeOiHS0/LL29FDYEgqm1r/8GtxmnU3EqbPMQq91osbTBNhcZHocZwUjU50B6jxjCNfrYh6bAZtsTGFGByySSLhb8ftkUHGDP+0RSmc8JTZLowL8N3njdaliU8iBuU+bDOUDN8bgVw0B50DlU1qB04TVE+d36vGBcg2jYUof/jk7v2ZiR4E8Cg9azrS1yGiokk4TAo/RZ351uRNtqiVj2z6Sr8ZvBwKt0XtH1vKpKWrtF9PAn0X2PHwEGCISv8IMsFx+HCU4r6El1zcVw5DLOvFA0lZI9i9fBYog6MypPXCQuxxYgdHRHHV8y371iVn9hBSYxtTe/qsuTQb9+zaiV5LzA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39830400003)(346002)(396003)(366004)(64100799003)(1800799009)(451199024)(186009)(26005)(6512007)(9686003)(86362001)(33716001)(38100700002)(66476007)(66556008)(478600001)(316002)(6916009)(5660300002)(66946007)(44832011)(6486002)(8936002)(4326008)(6506007)(41300700001)(6666004)(4744005)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vICrpFM8iFTWpTzYt/YH48kxcHSrz/VyKMbbs91aXpThkKA0kmfKQLald6s5?=
 =?us-ascii?Q?yoaqI6Ppt90dmL5EndLf73DmkuC3K4ktZLYvaqOsRQXSRKveXWm1dqx6DAZu?=
 =?us-ascii?Q?DLJ7nfPTGWCBhLFveueQykD4BkH0NLNRqN4Zxp0iBgs670PfKmNU9Ve6Nyry?=
 =?us-ascii?Q?kNJTMS43tI9FaMcK56ScZx1rOSX+ORvQDVBbHWqybBGzQP08j8YWqhT1M7rR?=
 =?us-ascii?Q?SjtyiurINpTUXkVsvYYIM2fXew9mv+nNHoIv67Qsrs09RE1wTBTQRcpBA6pU?=
 =?us-ascii?Q?8Jw5A2JShCwPNwxkTjM2EL85yHbw4lqqeQw1ibuFDt+XpB5wTfRVxT35YOcC?=
 =?us-ascii?Q?j7vWALNNa6l1C0p2FbvWjHSXtWKeZ7UKcu6It/4gZsS7emPeKl+5WEolzAga?=
 =?us-ascii?Q?+yLVCqrB8N0WpDPfsV9TCNbR+AEXqUpg+MDECAqIQDlntrChlyq77PTryMbi?=
 =?us-ascii?Q?ON2IoUuPARCHb9hSFyHkHGuqhZBzHJCJvkkm+XwJXfstRov/45ZkNtbqx+fp?=
 =?us-ascii?Q?trJSh3VCZW5oEDcsx0npb10qqSFZN+gqQwOR+IBQOfhIY15n8vYAw7C4FSD7?=
 =?us-ascii?Q?tI/2Fn3Nj2UsOQFqNPZ2P55NmkIaWJvV8E6fb1Ln/9+sFPDk/oQG185Ob5GO?=
 =?us-ascii?Q?qU2uF4RIaB24k8rZoy0paA3Sgod1LahDYqN32fPjscASSm4CUEZOly5wF7zD?=
 =?us-ascii?Q?IzDoB33OvqnBrYNFL27JHCfEpcNoTY/zH+tOQBb9m/MXb6yr3meEMbaMsE9o?=
 =?us-ascii?Q?TLG88R1DNqBk2RzF1r6NxLD6jk//XJjvJuLlK7QTyiZcjwSn6726qD6ByEpn?=
 =?us-ascii?Q?s84nCSevGrKGEe3S+nHWaNlf9NvdAmmByQL72KDy2ozGWX4m2zafdiElvhQd?=
 =?us-ascii?Q?LG21y0W9ak05LGO/y2erTWkRMWlbK7gLvL/uLO5shv0ByhJPaFwibArwD1Ve?=
 =?us-ascii?Q?tnscWTkFeK1Zj/p/M8HV3pfbn+p1N9w9x5XLErt5zyq6FOA40M6w+JQouzE4?=
 =?us-ascii?Q?HFDySCpM0ajetgBwexHI2TBWTMlwQtV2LEI3cX8IrXdnxuziIx52AdCbq5XA?=
 =?us-ascii?Q?iEhWJFV6bQdxZBiLuquMoQlZ1cal66/HMUZQrvOHvlR/oRUTDeRFNzjG3gil?=
 =?us-ascii?Q?8ylXwSjdLdxKhm7/Bal7PJU3JfyUROdLNqkzzx/T+x6nU6vyg/SktG3mOsCU?=
 =?us-ascii?Q?U3PwvKv3XkUkHvcYp1197u7w8/5eFTSiga8uD7lvnbdkiky8Svt62hnclWFC?=
 =?us-ascii?Q?A4wnyxXrNL00sd6OnEb1E9Vvs97zWIxbvLQ4YiffUcd0XWqCytKOXPtxbyoI?=
 =?us-ascii?Q?ChvYxuckkPwlJUqfmHxdrZw004btzigJd0tI8tUDYKjOryHRIVg30orujghB?=
 =?us-ascii?Q?pNwNObyjfQIsNYZv7BYt5qcH9pmMg2IPUjK2kec8yohSjtz81AWlHqRUOih/?=
 =?us-ascii?Q?coyW0ZfDx0l8CbDDWyO/fpWx4WJvZ1O9MgtIV7VMOCz2BikMPB5iiT5cE6/j?=
 =?us-ascii?Q?AiV+oI+HgWOVCv4zUhHcfCzmYhjJ5izJilZ8dwKAKOoLGV+oillBg7UDHa6R?=
 =?us-ascii?Q?YFVJZc2wpkxokZCEzLexPIoJXUR6PlfpbLwJPImdg3IPBAefiZEvRf/CKd1+?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a67926-5865-4452-061b-08dbc3c6f5a7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 04:12:29.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ylwx+rr1FlYlYZVjuGtNclwnqclpMlJJSBtJWjNfHsMBAS301VD5q8MEVcD0AiFtu3u9ybOWVDPus30xdw8dBU8U9eeHnR/v5naPSckUpWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10164
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 12:46:50PM -0700, Jakub Kicinski wrote:
> On Sun, 1 Oct 2023 13:41:15 +0200 Sven Auhagen wrote:
> > If the page_pool variable is null while passing it to
> > the page_pool_get_stats function we receive a kernel error.
> > 
> > Check if the page_pool variable is at least valid.
> 
> IMHO this seems insufficient, the driver still has to check if PP 
> was instantiated when the strings are queried. My weak preference
> would be to stick to v1 and have the driver check all the conditions.
> But if nobody else feels this way, it's fine :)

:) let me know which variant is preferred so I can send a new
v3.


