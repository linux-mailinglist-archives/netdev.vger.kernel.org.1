Return-Path: <netdev+bounces-59707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92181BD92
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8692859E8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322B6281F;
	Thu, 21 Dec 2023 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AOr8oP/V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0120634EC
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuofTmwPbc5ihiH2EFyPalRBy/0gR9r6Kmxarb5SS0Ru4OiF2wcVUQ5g8ruK2PIBuoKE6wsbdz4CIWPYVwZJ7NJzazZIZcnczd6ldNX888fAoM8dEXF8IyTB0qgut7qCEJXsFvrSz4SwAM2lUmZuS/OwXkLhAd3YqKIeWPbAU6Y96PkPxhm669RoNavu40W2C6yO2y3nyRu4KkpXM/iNwDZZZIC3z7hwxrF0tevAyMuNTo9Unj5FIWtwrBU0iHqyyxy0hHRsM18f/MiVvZznoea2n9yTidi78cbp03mGvBaWP5lO+ux3q1uTSWlvxiDttCUVgleJcW6EID2H/8PLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vh3J7efPwIsg0UqveB31CmEL6UvN715lzb8p02HYOc=;
 b=NwyPQgf3MeEFOZJN8OJyGCgAWpU8lnrAdlKrgLMECWJXbZzJ8cPJMdkLiNrQEE+JyQgoD+NX/caA1VPvHvpoieZVlxruzQ18mefoYWlvud95os5mz4+XSSJsZMsV1CV+vJCSFLKiZAEG0GODFnQSng2wSPtvu1sF2NMi0q1yfuLDDW7T0A2Zd9I8H0cKBQZwmPayqo8l4ykABwL8DyqoW61OWpVPWgw/IePTlEr8W6PI8qsH5KRqEpbJpXDnFFRTe/8cKYiIUBxLmWebuRm3KH0r6HSKXgsI0+H2++JFzh+vuUyKjdYrGghUUyyO6cTu/wa/n9jcv/5N7ttQbZakwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vh3J7efPwIsg0UqveB31CmEL6UvN715lzb8p02HYOc=;
 b=AOr8oP/Vhnfh0kf5rEJXMTH81Ce9yHvY+aHNGZ4Ru2CiOkRtDCGcS9VECtNUge3FS9w7RJsjuDIPU+ffV/pO0ebrBuY/b7o9KuOrwKQNtJJ9n9sNKxhdOnbmdSh6tyZwfdnhCPH5ARaLnoXbFgfQ1dtZ6Tv3kJ2dTUFWRBcR7IkCd5TNezk/zZWREGFXy2Cu6VbtRQKYkIasAqZfTXTGhHKSG3dChDQU+h0PPTXhyblkQif1OP/18+dohfXoJjtcW2poCwIAHgPySnEmcV8v3UiLKxlyaNtem7viVNC+MxHzUXs4ZyvKBlgSNdi3ctFB20/IExH8ZVD7VcLnWiRmMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 17:46:07 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 17:46:06 +0000
Date: Thu, 21 Dec 2023 12:46:05 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 01/20] bridge: vni: Accept 'del' command
Message-ID: <ZYR53bf1UL4blJJj@d3>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
 <20231211140732.11475-2-bpoirier@nvidia.com>
 <20231220195708.2f69e265@hermes.local>
 <20231221080624.35b03477@hermes.local>
 <ZYRt2VCTVnGxI_1j@d3>
 <20231221092409.44d0cbae@hermes.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221092409.44d0cbae@hermes.local>
X-ClientProxiedBy: YQBPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::30) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: d76a897b-be82-4b67-e7ff-08dc024cb55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vLbTYTT/sAZ8T1vw5kyt/481NeeOkC3RWqQN0rd6Jg/yp0K3ogXt6JE25SrVShW8rr7/jp4DQNa2f8Y5ywZ2vqB37Uqx6yFHTsPDA0s08UZhP/yPywFRbuaH2GQP11S/e+Isz1XnDmcwhQSX0Gbn3M4VkQ0GEhzsjHq0YkCC5clJDax71/TfneyFOUZzG4EoapTUnZrjcQ6vF1QVC2B1j98HaFpJ39UWQZ8Farz2AYnjgICYxp0ivWGS1dEgQnj3pTqM4Up/Wxe5fmQVqco8SzP8SuTlUR63KBbm5acELYw1BLTRXaWSGQxz8otQbgP0e0+f6kECZC06Yy86/7bav0z7AVV5RTvkccILDHHuu6FZ02A0pnyBmRPqf5sUU2oKxmMG+e4uZ8cGNvVBbMwbpW2zWeu2DvPD1f3iJRnMz/DwJuQu/xmf8u+/dWsjL/8R3qEZ5d1vFfK6mxBiXg548wpR528rddRjv0GB/ZFcY7Zg20EJ19DwS0zxSsYQdZCQ08HH2tJOUkFDyAcRsnNyF34eGoiljQU6cfwJREJUa3Y70gelMEeVyD8H+fsF3pcm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(8676002)(478600001)(54906003)(316002)(66476007)(6916009)(66556008)(66946007)(8936002)(83380400001)(6512007)(6506007)(9686003)(53546011)(26005)(107886003)(41300700001)(33716001)(2906002)(4744005)(4001150100001)(4326008)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fEsQ8AeMRMO3AK2xx/60HPjiNRkwkAWhPm75xITlfEnkc0BASINXoIgE9r/o?=
 =?us-ascii?Q?ZDfRBJjimhrAcMDYPAlJZLadDt4q18CbIOeJXvDjRd/0DQDw4QlIkwsNsugl?=
 =?us-ascii?Q?5NQ+/GLAgTV4LX9UkmxO8Z04mWfBFzJID3rubPGpK3CveR35bWBUxgKDtugt?=
 =?us-ascii?Q?3itlzfzUtg6AJ56y0vp8m5Y2qs13kpowV9hf8zDuIGDUe27j0eE5ktqytm2j?=
 =?us-ascii?Q?sloKBpWs6ksvC/zF5PoLz6UsYaos4OIpZrtzFFE7FI2XkBqFIdhldMGlY9iE?=
 =?us-ascii?Q?bFcQ6xwA2Z8Ifum2J/oJefxRcmb6IsgQWjWr5gz4yoGygY9nhwshGg0ANQX9?=
 =?us-ascii?Q?TZnqIJ/fwkzfhxXfVGD/2DRGlh6KjVGvHJDqvYtqgcmRUhGn5MAwztVHLFlQ?=
 =?us-ascii?Q?oOrLEsJGSYDroSweAQIquBe7aqn8fjlEHy5l2Q4TceaND0Bx7TyVcMlTSchJ?=
 =?us-ascii?Q?7bLvA0NTdZk545c28ejFsMdlc20QTAF2gpzNcsXWr30Fl3REjvGM0y37kIpl?=
 =?us-ascii?Q?ncgM5CKmHzoSTnbZTmpMrG5nhbCUzBdLtTmaiwzxilH8V3+dWzjY/PprQT8z?=
 =?us-ascii?Q?KLHu04oKToWpIVlyYpyebcYO6HVcDPQU4GFjLJXOGMaNNhkknNxEPK4tpvdA?=
 =?us-ascii?Q?dxhqCpLM5EXamR71nSxUADUXhRHyJVKNqlG5MeRjZMKFqrsEyutUAIbGmiP7?=
 =?us-ascii?Q?03law6QmQ3wUXS2Zjc7gH3kD+ZmO/i2C2sexnFnqxDcQXz2bwzh86VDfAXvD?=
 =?us-ascii?Q?RokRxpMTDzU/0n4WEh1xZdFZOjrl81U1Wf0svgb4LfBmwKAF287cLETFsu0x?=
 =?us-ascii?Q?OoMOnVDS07YYshs5vs1GUPawh0Ti8r+dbs7aGIbClrudc09i+7ut0Z2GvJAO?=
 =?us-ascii?Q?uHtB2up/xpglsFLge4LvrCPa0hdFnkI9ISUS+mhcIXuGZ9qfx3c5fBU17moW?=
 =?us-ascii?Q?dvvVEcboHVuUZcVWAsnOd0azNYgs9FrnbAcpue3iXdkR13fFxlN4K2HrYD9D?=
 =?us-ascii?Q?Hq4YJITDIaMIf9xs9IAgzb6H2Nk4wZZ3Of+Jnmlrdi79pLBUVXks6Ejo0NHa?=
 =?us-ascii?Q?kJJPUV7Mx+hI+zFx0QpMjux5DnHFBg0VeC6Z2JR577ZWOoW7UvLY0ygh8+81?=
 =?us-ascii?Q?UPXQkp/FZbNWj1PYZJ4cu30kGqSpdm1iP1vkQEiOKaf7tVl/8dpx4jqiOkpa?=
 =?us-ascii?Q?ASrslrBb7FSInksJG2w8UU2jPOhw0dQ/CC+5B9Em7SedzyryqzD3mXAE9AiY?=
 =?us-ascii?Q?NEfvRf32ppqV7PW9AqqG0ILodLUTVsUBFCORf4MM3rVJQg2ggsAHkCbrTQIv?=
 =?us-ascii?Q?MvAV+A3oNc+2TZjb8qjzmSrs0xZkhTuhpWpGrCj6sniuvo33ftSiNflmSwUm?=
 =?us-ascii?Q?1XGRz0M1Zjztyv+sz2aTRbwcGO/vcbke46GLSP8Na/c9XfNttrxeTf15izUT?=
 =?us-ascii?Q?BIKw2taVTmZCUrQQFchCSqh4LZ2QnT7Q1UuFnrJ+6VtlDQpsEGvO2KIdf9GV?=
 =?us-ascii?Q?N5AMmkvExAXB0F4HvPCxU9IsUN2cjnz2is8crAaqytyoJj/rrj7KJQXSawog?=
 =?us-ascii?Q?d3nHAXFT4iSEWlEYyReUXWe+AAax/5/IXTQqsKB/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76a897b-be82-4b67-e7ff-08dc024cb55d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 17:46:06.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khIStbBZuTSeflWMjz54HGPwDJpuhp3yMfgr3EP17aqcVoRqPIhG4v0fKDVkrXSK2+ASeulzSxy+Rq8DMjNmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

On 2023-12-21 09:24 -0800, Stephen Hemminger wrote:
[...]
> > > > 
> > > > Please no.
> > > > We are blocking uses of matches() and now other commands will want more synonyms
> > > > Instead fix the help and doc.  
> > > 
> > > I changed my mind. This is fine. The commands in iproute2 are inconsistent (no surprise)
> > > and plenty of places take del (and not delete??)  
> > 
> > Indeed. Thank you for the update. In that case, can you take the series
> > as-is or should I still reduce the overall patch count and resubmit?
> 
> I will take it as is. Ok for me to squash a few patches together?

Yes, that's ok. Thank you for taking care of it.

