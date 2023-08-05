Return-Path: <netdev+bounces-24670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B302E770F8C
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 14:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B2282451
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D44BE72;
	Sat,  5 Aug 2023 12:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27646523E
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 12:12:42 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2184.outbound.protection.outlook.com [40.92.62.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87844BD
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 05:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs4f84OpvXD8CC19faCoNpLSjcc+ze9n3wE+r1idxBii4J2imwS11ByIsSBxZPFQL9qUh5UDDGmrBxV6A6avI5LCWLwfMzERffa3FC34dWpz2NbcGYI70mZ21RwfUWvs8baey9p/hqt4K4+Z0+Mb0nDi7s8Vf9J5CDBBLazFOEpKhdFGuXzJBhlykhoLjDvBReuE7Dw9SEBejfPbpqAgt5Hmva3fSRHae2R9aFFZLvmHFCx2jc8d/u1KfiTv19c8g4E+aZgNjtz/0GxP7LiU6fuojpaCaQkE9yF0BhFU3tXzj4bGcCOz0c/LwlcKYZ2OQIfh3Cp60sUH9STMRFo8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eIWT/CjISC6aT/7gp7t6IAyfXMrgCdYjpKd8UTKTl8=;
 b=FIs6SdZnkBIuKxAGSFO3a59MlTI3aXUP2eONSwe2oThuutpzZZEtxi6xoxA5AXIDxDHQvhGIdEtaAzh3rcixROSW1+Os+ODN8lXFFRtGdRDUqP9Ijkl0w9ec4vyvW7HQDf9TbDHrarWeDZJmzDQ+w+PD+bRwPMKNMv/5dXa27oyanfrTFGOOmGLB4xgHvDn9qkZToMMVjCezK4ZYBYhm43c5LgtH44xpIisD3rd6frE0YPGQDqOJ9daSNiEJZaasx9+BWEGKRMQCGI62zLgmd9iA70SRxaNcKMKo96intz6OCD5vYT3C+0CfN6NJgavlhYL09jzEZhVbuyZWrmS4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eIWT/CjISC6aT/7gp7t6IAyfXMrgCdYjpKd8UTKTl8=;
 b=ZhfZltJ7Zbs3JE2tBNvZaLDCfTsYirwZq0Y37O60pc6TQaRN5/Z9cdRa9B6RnRtQKvlz36T3tId/aeGgUQn7C4BVsR68ZB0H64O9tI322CAuoiexzn3RHUC2se9i6pyI0BIOfNbGBCZBVOzA9GGrS0p3E0sqJobQMV8yfBQ6VxBWDBPid+ws7O8tK6KUfMxeSXM3RCdf9d/f0H+ceu7GGX0P7F55l1c3MihDIY9uW5KXy5KVf2kwqAbvhnByEspdLiXec2mtOLaF2aMdmLXB201WxklUwyhmTW06IpzDqBGCrXLTlZOvPSj7mA5jdr1eIYgd3w8tE6tz4QMBBa5p6g==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by MEAP282MB0053.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 12:12:33 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 12:12:33 +0000
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
Date: Sat,  5 Aug 2023 20:12:13 +0800
Message-ID:
 <MEYP282MB26973DD342BDD69914C06FCFBB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20230803021812.6126-1-songjinjian@hotmail.com> <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
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
X-TMN: [B30g2hR/GE9NhefoDb9rd40cEdVqnbdt]
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZMt6ZZxIHMrml0+E@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|MEAP282MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: f6289b85-7666-4069-3ec5-08db95ad3fc4
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMnac85kNyRxquJglHdERmYmKwD+BM2hh9+vpqBMwncHdpeUHzf8oJi/iWjHAv3nK4Nc41ucTbL6R9pkZUPauLQbnpDbA8JHreq7bcojgLzlmtlUAgZzA/IxC18RPcFLrA0kcJLd/L5oxkdlDPUzNrC/ozSkuhsnnHCFbfdza3ThbyQLY9s5MzU+iqitu/8bfcFbPe+3kbxw0py/j6kEAbshbym5kl8152tIb4irBZZ7/XitQ7kqGnweByAr2zhh/anjoY7s8jpEc/ecXdSn5cdvjuzpTP7CbCjABi6DgEhsFPTot/LVCaLrofxGYZ/kycRLWpx75u07VADk2ih5Q0nEwkTf+oHHRmQbYNE5LzXwStoYCk95NQHV8WdVMa7WW2CETyLxkcAsyBaLmK4eRh5X0UAE/81SUvZSkCuQDF1BGxCOVdvrtHbkAqJpZF40pDl+XGLoix+Ag0zULUZ4Oih9sL+nA2htgkMEhD6ATh0pGzvQQPzdGJ93Km2RYcO11O8Shj6owHcueBHHkgWIzI1/1mFbdesXuOZD9Ba1fGDOEAYlm4m6R3DqJJf5Oax+Ngl5qW+lNG3vGJVDU703OQtyvj0s/IR8xP/g84BBYb41lzSZGo8x+WPW56V0bA1YzhFTCd9Low8R5jfR55jsHqqSibs5mNMy//XmTt/W4TqaM15JSGI65XAlpuKVBpA/P/6B/jTKjsvUreFi4ycokfrQpG6/zGx5WmMNF2kigumypBTsIiOrO7w7YU6BgHb3l8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mIUBEa1WpaEZa68V+3xdi4THeiTipgOmPRiiRrIixitlOgiGhVuFjcoy+CDo7JVKzZXcsAkkqDuHqB59LLH+HtOyfGS1D0J5AGNOK/KLwVAwmWE+7osGdHS7n0avGZfoyyLo2dz2JzOmDXOa5YFzUiQdvzDRVucAdJOGw9L308vyhFsG8v43nEGCcgLPSHlYmF4pC9kMW/B4yqi7SI4oUhHiKGJb2YnG+Cyp9dlQJDo7hfPNmL4pTv703wUCiakUQSCiIsITgS74FTBV3aysx06aYsvyl/2GbyknWzggBU3RrUqrldBFN8Lx2yHLi3m9POS3fCKGL03ldjecMaaLsbdteJSRu1eGcd4SdCiv8DHkpzzA/6SestI8j6uyW+1VinJsMOe9wuTGQ6+Ir6MRMSh/TKqbT8uS7eDPFPOpZ/r/VlOGAzrqbR+1uyVNzRqLDQ7w5mi91FtcL5LauDuw1v08pUOi2gKwtyCboXJqSpTpmNi5yqG3MA47WLU431j6EE9P6Zt8no9+S/bB2G40RFFp6JR3XPjyejQzX4qekTD0xxJ0nnRJeL3orX+1b9DL1jC9RE/3gxuLD9s5l80Wyh3Z+fYNs9Yxn4zphZuGTbM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/nrkpiUlKEHtVCJrMsiLklxl2Spu+Gvsfw6vHU6Y4WFwFzihTzoF+Yqkv4J?=
 =?us-ascii?Q?v8LR3r9WMZFXREVeSWlYhvQhtXhF5IN+mTEa5t9NmLKeDynP3z2DCD9p37ld?=
 =?us-ascii?Q?1nDLaPP+NcRSz1AczZCXUsdd8NLMq7wmWFA6NlgvVorGa2WVpoDYVHx9HRdi?=
 =?us-ascii?Q?0yUnjk+O56y6B+9Ac9am923tu0lCsqGidX/fsF8p9O9LDkzaFNGwZ4jqIw5u?=
 =?us-ascii?Q?yrtbYUekjsQIN9ooK9hpuRm80xv0ekSp9GN5QOXsDfTmDP4qY2gRtGCrsLUU?=
 =?us-ascii?Q?wY6toIWxx3IQeTF1vBRE9ZiUs0EZmdW/9CcXyCCHJuVXEuSzF0HFc1EWvPg+?=
 =?us-ascii?Q?6m0tJiwFvW0s4Y1VYvIuii67jKORHaxa0OpvdQTe7QWzhpfqD5sEYx9larDF?=
 =?us-ascii?Q?6IjpJ/lC/BvOA6hSekNogFxxDkeYveH+DqiDY+2Hx/AAp2m4fMqHwtLnxPPu?=
 =?us-ascii?Q?e8UYfpnYS9uLx2lkvZhM+TSoEV7Cmi+e6LlIxip4T55oIyYb2SV+Vmk3JLgC?=
 =?us-ascii?Q?obugpjdLQFv4NZXuYiED79bU8OWsxsbjLCTyFYElFgQLeUS9GrYPPf/fdyDN?=
 =?us-ascii?Q?l7kNmz2W4cBbAyxBrHu7KEBGQ4ZSBZ4tJcdqpiq/DCpIlDjQI/D2wYG3ai3o?=
 =?us-ascii?Q?op1jlP+6TdX18psJPhrQ21YRWRkpiE/3EvL0f/6K/7JTRwKRbq1CC2XrFp7V?=
 =?us-ascii?Q?e7kPBqDlxddy0gtG1CzMebrRxtH4+Ag36Tw23iE2Svk5IMel0rBVyAVi0Vog?=
 =?us-ascii?Q?a2B6VnSN78WKn6fRlOUcpzUGbxZp3GfdGr72v003KTmB8hdt2Np800PNZwL2?=
 =?us-ascii?Q?mJ2JB2v7eY7KNeIU7PUmsh2i1zIxOOB+Wf/hPtn4NVvZS9bCX5ejAXZKCTmY?=
 =?us-ascii?Q?vAJLo0eXiF9JFVnz3bJ+Ro0ylg9d/MT92QVtQL4JXAIwZGjsRYKOX1rwSXsm?=
 =?us-ascii?Q?/wPbZ/f7Du6MeWX26bJO3TO11zSJywsWxcYicBf7r1bVwkF819TmU/lyIfFi?=
 =?us-ascii?Q?sizw+W9DJ6I2bWo2BHgmw34/Tu74tdRiYg/vrOTojkWKrZieRxzeJcbr9WPD?=
 =?us-ascii?Q?5UB7M8xIK7kE4efnSQKFE4etFCGRafN0e3wBIoYLAjZyGty2yt8aS1JnOC4R?=
 =?us-ascii?Q?nEU1vYu3NuOwOSzGv3cBIYCHP80S+Vl0lT0GYMnDVIfClz55Tbss/0q9TKLw?=
 =?us-ascii?Q?FqbQiXPEdIOg+E9RDzgV6oZPoG1rt4gZ8ch6fcV6aXYVZgwkpUF/QTFGGcw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f6289b85-7666-4069-3ec5-08db95ad3fc4
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 12:12:33.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0053

Thu, Aug 03, 2023 at 04:18:08AM CEST, songjinjian@hotmail.com wrote:

[...]

>>+static const struct devlink_param t7xx_devlink_params[] = {
>>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>+			     NULL, NULL, NULL),
>
>driver init params is there so the user could configure driver instance
>and then hit devlink reload in order to reinitialize with the new param
>values. In your case, it is a device command. Does not make any sense to
>have it as param.
>
>NAK

Thanks for your review, so drop this param and set this param insider driver when driver_reinit,
is that fine?

