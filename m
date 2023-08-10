Return-Path: <netdev+bounces-26436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B870B777BFA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2D282159
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA7A20C8D;
	Thu, 10 Aug 2023 15:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6621E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:20:30 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2160.outbound.protection.outlook.com [40.92.62.160])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206A90
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLCPz+R1I8vDgV5FwB0IHJL1yRIl7H9sBmRQj98n5vafVSQsHtlLSPNpceEHZEj1X6S1NKwHgapndTKpg6W3y0VO+J9+DIUxYvzzqxAHLkd5QC0wWvuLMPNurkL/1g0TdifaoA7rlbYRUYQzyuYED+YOTGmG57cedhEfYu9huoJUUPBlfBkAxyDmlT9YhnAweyYBowVOVby+qtP+Cg8GWuk+5V4+V7RbPaoqZR6ycA48iGjS++MTBkWjFj+0QN/3Aw9VHSIp4zTo2tE7rixPvTZFKaW/BXWKJhRZrsdjmOna7sGaY9EJyiQfB4tFcA+qhoRWTkmF7pfrUJhm9X6GXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvrpoWdPQahSE5OROCP8QOD3irge+OttJ/BkrmdJg2o=;
 b=IRAOOI9EVnno/fu0VbXHChOU90FYY9iap29GsCAygilYFR9JxMMsV0qg6hCFn9Slfi/BcEkz2raiAgo9i9UxP18djJ+TeVO70LQi9w6JxoIj4DnRPJ0m4iTXRr/+tP+sH7sMdZloMPR20xEjLyWTHfm1FAVbrx+cR+Tk0PGmdIttjuXywtuWwsxzubCu8Seerdvll1D35meNtU1JTl7DJ4WMa5hnBBPQYHgklmj4wQXFH14+bNS8N2tcD7a5chBo5LWhzIQBK1Z0CoaxN1Qt8pYRI6Yr4gCeoqfBzKd16UYk3OfP5RRjfWGlgOlnehpcxIB13RXVhAJVaw935ITbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvrpoWdPQahSE5OROCP8QOD3irge+OttJ/BkrmdJg2o=;
 b=GxNfmegUf5iGi1fL7WOc55xFc+Y8Hj2HI3QqLx9paklNxZWpun3+47r6Vd4J6hoeYzyvMHF+n55zidmyX376Vbq4bgO4eACTY4yPb6u1RJilxXDfclAg2yH1JCIuVgY+KrnKBNt0Ow1kr2nR/mmFyjPkb8TeA2SdGHUVC2MP8jA7GWHummKiD9tRh3GEiyjEGjh//ORwiJUcP69NHf4CsQUqsx5MrWlUDA6PJNo3c1/2MBhXlnSEWu5r2rpUt45+CjcMCB1wfgAqLJEEDZikD+fyp2GIKk84IJwGsGxfibqe+iJOs9dLpIUul2m/UnGLOT3AohQ6PJkznKrfqmfavQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3998.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:20:22 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:20:22 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: jiri@resnulli.us
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	soumya.prakash.mishra@intel.com,
	vsankar@lenovo.com
Subject: Re: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink framework
Date: Thu, 10 Aug 2023 23:19:59 +0800
Message-ID:
 <MEYP282MB26975755ACB814BD556334BABB13A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ME3P282MB270324EC4CEEB864D04ECDB2BB0CA@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
References: <20230803021812.6126-1-songjinjian@hotmail.com> <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM> <MEYP282MB26973DD342BDD69914C06FCFBB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM> <ME3P282MB270324EC4CEEB864D04ECDB2BB0CA@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8bit
X-TMN: [K2l4yYYH39FLeohuVblH381FnWk192DU]
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZNDqd3oee/nLuSO+@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaa2711-a849-447d-4898-08db99b54f8a
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6c9d3aaXfNnpKzRqBtZ6l12An6oGdBXNRLFnUP59jIvj1TSvAdGGnMQfmWwrmdaAgZ5x2pOxCXgt58Ce6Yf2hZ+dLOnUU1FUYSuf4r9MeBJ0SBP9zhpUHWT75/IbXhNedGJzzjGbw6AYXrlMn6Yxi8ayMyBfesxzFQh7QflBg/0FqgAVZK0yYGlY/4i95ghy9AKhfkPdl4ZtaaFBTOPEBbzdYCQxkrT85odBLM4K8s5HjWj4CnALnsyf8JvsLRCY0ZID2t7JftnWgiu1hLh6Jk8a8ONRXvdAbBMxY+8/GK0LGaRgnK1oI2RYlUl9FWmKNfw6Tfel+isH0tXZwycDtF1cKwAIz/ZdkRmqAd2Qi9OO+3okac2RzrzdCGBwk0Y+Zw2ysh8VmrjkrKhXoE/j+HWa7V+piCUCaEOEz6vQR1fe0+lD0Dy7krdbSQDbqWVZ+PyMt78eONRxyER4jTaCoZxwh5RJE7O+V7w1YohZhxT/+nQ5apt3eTAx+u59e/atbs4KV5PflT9iMASgAqTPtTSK8mOxV3BCYL0kBgIgWG6nNuRV4IPpTIamYNXbObx4lCvWwLpXVmMYo0+rooXtnE7vEyjvsSpZrCl17kkkQV1dJPNUagnS6Mqq91l7sG1xxcI9mrjIq3qDoQmOjXhoHkIodmTSmB2qc5zCOkzluvCm/AmKnEkFdHzX4F70B8Le4nupSYqFCQf1o4cUUNoKN9nLBfL6+zFlGKR9k5urYe3hWMs2V5MF5M/ekQAwYSUkGY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rVC7DTH8UoHwgxF4LbvBhtK4CPFo2rE3TJyB4W6PtQ9Or590k5f5YMjdJCJnXWq9OeFkwigoYCnb8Axqcha6M7k5n0HmK9NBlSgts9TdulQVm/MmfWNIqL3ZMZXtszPJff5TJvUyy30qxIpAOaY4UstnBXr0g/rYGwi+Kxi5faChamwWJ71XvVyGoeIjJK8JIlUFpR+vsF05aEg6SlgrNPIA2irR8jeD7/PXGKcE+co2eOF4VHaDdmn54w+R90j8zNMaIaPm4lbSJew1Ocy+u0IRGChXQwz7hGymgO7piATDgc8HmIf/g1M8BKhvwu/Mb6NSSHPk0DlDb5s5k60UePWHchXLH04Xqo1D/a5KfpCMV/voDuJmRIcBrJ/1S/y4kRf589lV6ixbpQcwwZbJtRiihgnGrrutJgjo+5EJ5G0SrbWd66yorKpzqOztG1vEz6KGXKfYwuV3vBEu7Ql4nHx9p2bX8B/PkapqgBW7MTblWDbFfwDZ8zeVwPPF/2ju9L4wYm1wQOCCYETlylJhX2wHHJgksK41YuWxmBNvzY+BZObEmnQH/FPCOXA35yAeX03XT5E8TNZAm+dO1kJjK2WQoOSqkly6mM9GDPtMig4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXM9QjfYij1kMgjQHLcnxS1i7sFeab/bNfewHjcJqwVnZex/pmaJJklZCSXu?=
 =?us-ascii?Q?NCuTQ35Ecfo9xXzr12EjJhFsK/hamRFe/hvWSgsCwlzYMSJHfvTQ50Jhc/21?=
 =?us-ascii?Q?qQ9ONxKOsyWLRexhLMxhuLrYRcg+qKaGjCVL7rU+sFS0l/BhsWZK5Nj9JsEs?=
 =?us-ascii?Q?GxIOoHMNJb6Cs6yDJ/T9MkHmcJFNtYr6mIkQcIx+xiQBCeUZ5spqn3Itum18?=
 =?us-ascii?Q?E605JBjM7+J58SiPNt9tXAcYREjUyfDXq/eSvxwrVMCEzjaXEMhsnkfuXhQk?=
 =?us-ascii?Q?Bsen2ZCggEOcaudPIs+XePU4g1ytcEYFJC3IicqRHnNaItxDSc9MkaKI7PUx?=
 =?us-ascii?Q?49L9OprYBRRc+aGFQLo+A7TDGddbOYvMtcjLCaElroV/QIQPIitHQGSW+H/V?=
 =?us-ascii?Q?FK66XRqtbwgCI50bccnHbejoE5JzY3C38BFQCUyl6v5Uva2CPbvxaYGNbehG?=
 =?us-ascii?Q?ajjgc6sPJGN5D6rjZU8b25Ew1wDQzINcJZqMg2jbYcLt+MsqmxdQf+4IuywQ?=
 =?us-ascii?Q?hPnTeZ9aicgc1pi2UbJLhzhGfsPhXRu9Yh3vLpNFcG6S9F3WkbyoFoaZtrDv?=
 =?us-ascii?Q?MdZfGe+8LCNSozTzO8BU3Fl8h22Ol4l/PHZ+5oS7OL5HSkYlKDiudX3xQCai?=
 =?us-ascii?Q?0SnuJJexofIvVFQr56Q5t8jRRT8IvveGXGlrtnjXQfNMNp3h9MeMjUL54VyH?=
 =?us-ascii?Q?MPVmKQTxWOt45n7/3xXT7Qj4yzX40sMiY1jHun0WAS29cnivlaAkYbD/g4bj?=
 =?us-ascii?Q?RDGzch3t0bgKcifMvIKBaT9iIPMtZnCfbzvSma7hIU9FQftpMbzUu1dk1f+v?=
 =?us-ascii?Q?N1T+lRV/sSFFiB0uQ1rxkMQKij/t6XAtG+3YaL1et76gtDhki1KmvSYji3Es?=
 =?us-ascii?Q?VC45HNI574BgmyadvzTfrg9aqshhhnXj66zsgpTK0+Rb7viB/gmbZi408Q/Z?=
 =?us-ascii?Q?jLciQHwqnPIQeZg+VoVmGgpLXl4qJLq/+3nIWIrYmVZ3SQu7nVvJyp2NzKos?=
 =?us-ascii?Q?ZxaUdt4eppPLRlwc1eQkHEOYGaM/DDYrNTgT10uB5a6x7nR2QnpuqWgMK5oC?=
 =?us-ascii?Q?pU2WhxSbbmKPJAyYvACAsE397rTSAt3VFkJ5qNsut7Ik2hxKKZ2lvK8sx4cT?=
 =?us-ascii?Q?lhYPuqEk3GZWOc+PHImO9l/0ZI5NVVXQ8ie236MfnRNAPFk5um0c4ItUu6aB?=
 =?us-ascii?Q?aRRo0aNxXfEIoYPGzPBb11qJNErKLBTOIq/FfiR55vdAczIiLlIHu9lZPuA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaa2711-a849-447d-4898-08db99b54f8a
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:20:22.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3998

>Mon, Aug 07, 2023 at 02:44:00PM CEST, songjinjian@hotmail.com wrote:
>>Sat, Aug 05, 2023 at 02:12:13PM CEST, songjinjian@hotmail.com wrote:
>>>>Thu, Aug 03, 2023 at 04:18:08AM CEST, songjinjian@hotmail.com wrote:
>>>>
>>>>[...]
>>>>
>>>>>>+static const struct devlink_param t7xx_devlink_params[] = {
>>>>>>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>>>>>>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>>>>>>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>>>>>+			     NULL, NULL, NULL),
>>>>>
>>>>>driver init params is there so the user could configure driver instance
>>>>>and then hit devlink reload in order to reinitialize with the new param
>>>>>values. In your case, it is a device command. Does not make any sense to
>>>>>have it as param.
>>>>>
>>>>>NAK
>>>>
>>>>Thanks for your review, so drop this param and set this param insider driver when driver_reinit,
>>>>is that fine?
>>>
>>>I don't understand the question, sorry.
>>
>>Thanks for your review, I mean if I don't define fastboot param like devlink_param above, I will
>
>Could you not thank me in every reply, please?
>
>
>>define a global bool variable in driver, then when devlink ... driver_reinit, set this variable to true.
>
>That would be very wrong. Driver reinit should just reload the driver,
>recreate the entities created. should not be trigger to change
>behaviour.

Thanks for your review, if so, I hope it is possible to keep the devlink param as above.

>
>>
>>like:
>>   t7xx_devlink { 
>>       ....
>>       bool reset_to_fastboot;
>>   }
>>
>>
>>   t7xx_devlink_reload_down () {
>>       ...
>>       case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
>>           t7xx_devlink.reset_to_fastboot = true;
>>       ...
>>   }
>>
>>   other functions use this variable:
>>
>>   if (t7xx_devlink.reset_to_fastboot) {
>>        iowrite(reg, "reset to fastboot");
>>   }
>>
>>Intel colleague has change to the way of devlink_param, so I hope to keep this.
>>
>>>
>

