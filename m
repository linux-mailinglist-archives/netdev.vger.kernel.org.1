Return-Path: <netdev+bounces-24950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90059772490
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662491C20B9A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ACEDDB8;
	Mon,  7 Aug 2023 12:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA9D52D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:44:40 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2157.outbound.protection.outlook.com [40.92.63.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A91990
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaQ2qxHZrUaSn5VM4dvzyVF9RMcVdYJ6ggHZ5vENqAWwmTTT5sZTgQP5N7O4PTTm0CjlTTSrQBMqBSPl1EZS8HZN+iGSYx3yqQo0duuBEpfRA+2ID0DjISs/4lNJJmlv4RE5dN8lw69/bLT4Pioe1/wJEfOIFKXTe8jDNT+GfGPbw+bjO+res7Fu4njrXwGVBNrUlFfQiFxg7mOf3cHzhhS64TT58dzQsvueY1N+SE4AA8jKlrg/UhXV84rfTddmWBJoxmvKVtK3EHSlKQLdZwI+Op8KskLEJavjljuVNdoSdd9PP+0hKqWK+F4AP4ID55xjmNP95eqLdbtAzLK3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAe/30Gj5WptXj7lBHxKdBqdglnRYG9ggcLr6lndQds=;
 b=QzXmCuSPslGz1PIm3wpySnuTO3vj8+2JXx9Pde2HaidZhXTg2aG8xc14W5RAYSTjskwxAw+RmQ8Sx6MvZfe4IYknRp7MaOVK7twgKqwwrBmref2AYVAgB6pmY22J3KDc22M5jFyivPXblJMGD8ibBPBcS8cl59ngv3qmyQQcrnqogcOOCSRa74PTlEDWOmbA7vnXNO5EiwzqYJ6I4HdSBBK/04j58EXIFNm5x8dZF2h0/0TTQQ1UbTmYcJy2nrEVDYALiNofKjE3ddgY6zCf6cP1uouTiEJCm3amYToQZFkE0tzB/C7y9uvx87MMWI5LxtU6s14GwyR1vPxTQ3BYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAe/30Gj5WptXj7lBHxKdBqdglnRYG9ggcLr6lndQds=;
 b=GRI/sK7gwmOCBGwpl6ySmGmFZ3Zr1xBYQurhV0jcRWDBY9xO8N3zGQPs6d/TMXCBp9gc7sq3YN/otMcxTAy9/p9u12UxHpCHrCLINkCj8s3wzFPMBM1RSg65NpY6DhJKeIE7YI+rYNWTXbwLHWBI1WqwY38MkSFHRNlFjhrKzirBKxjp2NeH+SglL0UblB98Ts+x58MToU8PWVA1bAznxgUMMZd7wfBuhYLgY7i/KhOg+Lx6B13j+oej8K2DtcieGb6nOOXhnFSJvEz76mufJ3AiI2V2gpsAk7GRxtfFoW8ZuiVmFOflW1G233hkQL5u1zw21fbD7DQDxvSjwWHscQ==
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:16b::5)
 by ME3P282MB2306.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 12:44:21 +0000
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::996a:3bf6:5627:3db4]) by ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::996a:3bf6:5627:3db4%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 12:44:21 +0000
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
	soumya.prakash.mishra@intel.com
Subject: Re: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink framework
Date: Mon,  7 Aug 2023 20:44:00 +0800
Message-ID:
 <ME3P282MB270324EC4CEEB864D04ECDB2BB0CA@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB26973DD342BDD69914C06FCFBB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20230803021812.6126-1-songjinjian@hotmail.com> <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM> <MEYP282MB26973DD342BDD69914C06FCFBB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
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
X-TMN: [MqhJu2haaXm7tQwF332kdzOHDaW+GgjL]
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:16b::5)
X-Microsoft-Original-Message-ID: <ZNCby8kzaZrxY+eJ@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2703:EE_|ME3P282MB2306:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b01e79-e96c-4e34-ddaa-08db97440575
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmoX37RsZ1wniXeiQbrJPNAdlVN5aWPnxCL5kJeXlfF2eZt8Ls/j1+8IVnX2ojCpxyIIyIAJbhdkohNhGIEL35iN01ozucXuTqSIL/LXF3X6+w/nNJlDT8vU6lDxWXUPslObA+ywxRVBsz9dajpjNDSJdhchMhN+JebDV54xObm5JQz0tN0FW+a1aFQ4rBfsMvFa20ZHz3Kt/qY1qMJzBo7SPDtE0nmZn/8qZ6NQdWavYFFSVyitjGGuCxi15uQQeYq8XEihqhA86rKnap5ZTZfGnnRJn8UuuLgLVaap2+Cdf9Ji9YhIwW78kVw8WUCdfuR2PtrnUFjuf7TO0O+JZtmrVa+Nts9HS93cgvCOLBc5nvydvfDhX2s3Ew/2AZnyw/3bYXVTCuekwQYZU3FZN2QQ3mXG9/eSkJUxyCv6ANopqGFh5Xm8zRa9ClwmOQyFvN3RdeVttr7/GKwY5ihcmJJ9ANiuh6wbaggxkGyr8MARYRdb9UBhwnds/pWWocUBWHweYQrk0XKeJbLFUWJQFrXPFhrB1OGsuDdVyWEPZvlfqehHYUZ2Sw+OoroSL1FraJFmcqLk87a/ee8boYnnt6D5yb3v9JgCDfY05i990dUwkE1xtaKxB33wze385jbL04W6W+n9yzKsy+dRx7MMpy1QZWxApU/d4Q5bFU+yTdcnqcXossDbp3+hmVHQH1B07vbAhiOjDJVFJD/lldyHxqE4YUcBuTmP3+1M8tXYeIQCZ7ZQ32yEzDFS6+33MuqlMB4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Wim+4wPgpqmnljIcVOutlP4ExFCJSqQVVivIWqrTlRVBsnclVMBwgVWPgbGZMa2kMcj16F2b8YG4NRXnOugGsB9GNc07lWs9AMvbgSeBU+Ecruj+n/ScAMiGFS35034Wj8RdpseXSPXAoPVgg779iy5+dPwHAEU4D6Dd/DWmx+zzX+1ewks9LWNuWqC1+PdaDLVQJsS7YIePwYGyVnWeVmR1a7t1Xc3HsbcS/o9nvthSv4NbGgRNXE9PgCk+vNSXBXNQ4EO/MHsat0RcPndrUD33XbCCiuibolPONnLsj0R/by6dWPoaRcTE+n+dyb1XYQNCp3WgycPvu175vqyU/lXyGuE3acumte3PNzrbKtewzxSwC3X2fET+Y37rvITNlsRYf0UveVIf1opkkjkpxVhPtuoZL2iR7ZaKjVCz09sMvwG8o5p4aep0eMlUwfoYI9GrI7tVGcVLsaKRUfiIQKfWhctTVQaqgEOFwDCgQ8QpD76BBQVkmbdtxcL7Fo25Bo6+hMomO/+mHZmxsAHZllk+PdNzeAOciAiRmLaD+p4XnzU7ADr4/HUXYrMH2YvUgwk9oKmZJXHElaicPRJynAGNd25b0Hefaco15ILNUw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+zXFaQU6UeFkDrNfkVeQXLfcnFtkFTQmfBuikzgqy7VGjqY+cSAFO6+KGuTb?=
 =?us-ascii?Q?hjopr/gjwAbUpPtWzIxxoUJxg/jhA5VFUL4GnLtN+kFn+ootg0gSCRzasc1U?=
 =?us-ascii?Q?pJONThL39CQ3yhVvA5J5IFL0gRrKOToLJy0prm6xvMvs2TTeJXavtPo2y4Tq?=
 =?us-ascii?Q?nk9G3j6X2HVM6Q8KiOQt/6GDJtuAUuheHkWgrcs77RhBTFJ4iYWbm4MZqvaX?=
 =?us-ascii?Q?HAgES7Xk6+4hY7J4wgCsDib5xo+dapV/IM5ajfd7UhqwU5rTMBF3ddAynmzX?=
 =?us-ascii?Q?k8aDMJJk99tJgo1ddtt0yXpwbizrggFOHkajAa0w9nsX81XRXG3Xs081QvcU?=
 =?us-ascii?Q?S191LzJchRlCpUn4VoC69oL0/ieK/+zHWACTJV/2HlyjaKib5BTfNsnW876t?=
 =?us-ascii?Q?50q+PlXRyVd/Vniy+qv2x1rPM5XxVm/8NTQGqaWkXQSXofQQJqMEp6Tr3hPd?=
 =?us-ascii?Q?0iZCtmWcqj/GseoJSxUrPdg4NBKIgul4mue35+UnlD8ZmM33xACeDGdeVnKL?=
 =?us-ascii?Q?/KlxHV3+fMuFqqgZE7VZmgDE2Rcse5ccbXW9S/rUk0WLKq9L9nOIgUN59AdK?=
 =?us-ascii?Q?vrFAcT+ZdHN9TGnUwPvcXWLhV05kFWhiydcTHxw4wjrFGgAvy2JB+ibeF5AD?=
 =?us-ascii?Q?7wV1hIkJcv0C+Q6x9NQ6vKE+9t+8y/7Pc7ZY8ktcHSnj69iEELXryjSvNxYx?=
 =?us-ascii?Q?WAL116iIDx0xi2eOfVDdr1YoPG6vBxQP6l9DxvnR/egQ24s3KaclhNqwTra4?=
 =?us-ascii?Q?UojYsBOxN4o/IJ3l5QYzfzkPwXQ3nX9zt1v7kZR9jCbPq8G6wZZPNZn8fZij?=
 =?us-ascii?Q?sbruKSUqgqam7B8MJZGXgDwt1P0yDuN2El3DnQyfvLMACh/TFNsvhdaPbzjK?=
 =?us-ascii?Q?pKHNxYxaod3QQvZ1SIw5Qp9ZWr3sg4RQ514QtP/D8fk1yQiK1REH81LvZU4V?=
 =?us-ascii?Q?XlJT5yWSi5TRUUwjsCK04V5nZNU+mhNvkZMrfZqaUxRp9VB+Q1L/aKMnO5o7?=
 =?us-ascii?Q?WLyd7D9E1e2Vt1B72HxbRumF+VPEZXUX6vYovWg8CxR36JYFQ1zVfN7mEriL?=
 =?us-ascii?Q?DiW/n1iif1+G33ift1CODKLzh6Dd3N0hIKuPYW9YSkZe8idf8MMcpjCxFsLU?=
 =?us-ascii?Q?VL2t9ZhRHjeqnITzBJL1lMsCgkMvbbVKMLyBjD2MBGG76jxINFthhj6Mhho9?=
 =?us-ascii?Q?2hpYnWNPArbi4qYA2M/DtcsACwrNkIFEgujKyaKkwCsCpv6RQopqWMcCFH8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b01e79-e96c-4e34-ddaa-08db97440575
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:44:21.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB2306

Sat, Aug 05, 2023 at 02:12:13PM CEST, songjinjian@hotmail.com wrote:
>>Thu, Aug 03, 2023 at 04:18:08AM CEST, songjinjian@hotmail.com wrote:
>>
>>[...]
>>
>>>>+static const struct devlink_param t7xx_devlink_params[] = {
>>>>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>>>>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>>>>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>>>+			     NULL, NULL, NULL),
>>>
>>>driver init params is there so the user could configure driver instance
>>>and then hit devlink reload in order to reinitialize with the new param
>>>values. In your case, it is a device command. Does not make any sense to
>>>have it as param.
>>>
>>>NAK
>>
>>Thanks for your review, so drop this param and set this param insider driver when driver_reinit,
>>is that fine?
>
>I don't understand the question, sorry.

Thanks for your review, I mean if I don't define fastboot param like devlink_param above, I will
define a global bool variable in driver, then when devlink ... driver_reinit, set this variable to true.

like:
   t7xx_devlink { 
       ....
       bool reset_to_fastboot;
   }


   t7xx_devlink_reload_down () {
       ...
       case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
           t7xx_devlink.reset_to_fastboot = true;
       ...
   }

   other functions use this variable:

   if (t7xx_devlink.reset_to_fastboot) {
        iowrite(reg, "reset to fastboot");
   }

Intel colleague has change to the way of devlink_param, so I hope to keep this.

>

