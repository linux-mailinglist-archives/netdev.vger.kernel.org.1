Return-Path: <netdev+bounces-24647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A766D770EF6
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B021C20AE3
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC38881E;
	Sat,  5 Aug 2023 09:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD31FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 09:07:57 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2148.outbound.protection.outlook.com [40.92.62.148])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ECB113
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 02:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV0mQBr4mYr4PqBiGviWvQFfHQEEmj6khwRoZd3FfvhSoqYMxzwOdkviuqQR7oqwLjAHnDqYxW/AulPZauFezB+/3RdNYdJq4lOoFzHa0RCdfRgufMBcDERj+1b7UbCNCVkHqr4o1p2TWfl7YFok4fqtQ8d6gvSvB6gqvRLSGYc8pQ8FKYdlZNwqhyrSNBjJVn1kJ9U7/REwGKO4rE6w/xvRdQCGweVXoTV/8Sxk97offYW+luOXSTZomHrLiKO4aEYS06BObnqZWqEK/3OR6wPqF2sGwF2hJLfNYF4CNhIWAEFg26isonoZDCCB6JA2mDr4y5RDA/hcT01Q4pEkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP410LXQdISLIepnBdJkXiEZmvDCHBh2QYOlpnufiNY=;
 b=V/0Ji405YwCTnyfsw55vihyhIJSSHgC/S+m7+02tJ7JePain/8N9wRtftvgooD9beC+AnUMgvoDa3rmf0rAEkjFCqAn1QocVVxuLiceEJUarWF+z5M/ZdCamRZJSrsrGcqk1vELh4H3e4tSnLw0h/l0gydwQd96auoxSFEczx/Cm8ODZ1ujNPCmkGlNF7Jt0t6tPiC4B4+NDPNxmwucu2GLb6bJeqM+pEHTFc3WVUGbqIQT4avL0guaU99jeGFO2iD1JF1Gd2ZBpwxZCaEe+oKEVz+EUVmXh78aMmk5et2WlDCh57z5MaAvWs9ksvT9kyVSgIZ1ej9LsTMJsyuT/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP410LXQdISLIepnBdJkXiEZmvDCHBh2QYOlpnufiNY=;
 b=MbR7jdJaD9LGXGtZDpYZua5NsUI+CV6xEZRscmNLxLCt/8VwVukmjPyFOBMnUVpOUqhch+ala7nbPQpaCVlvAgM/2PycYfLhQEtlKVwr6xzh5QPu8zED24OOkTCXkHa//sKIJDg8Lyrm0kLKErFaLjyHxwJBk8+jd0U8Lcuauk88L781BBfH8d5zATJV4CQWGHvQ1aMf4z8GUflEgmhtCGeXl60jTj39R63RLM/26kKZkD/1aeBwSNluqeYIXNhgU8/FjpP//E9ILBGlTk+TJ50dapxQpJDlgudeeaTZh2MerN1lF+ABMdsSnxQTdCt6LGP9VIY2rHoGVpqnyFxeYg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by MEAP282MB0294.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 09:07:47 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 09:07:47 +0000
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
Subject: Re: [net-next 0/6] net: wwan: t7xx: fw flashing & coredump support
Date: Sat,  5 Aug 2023 17:07:27 +0800
Message-ID:
 <MEYP282MB269773B07C32A7B487F505C3BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB26974DA32942DE35F636FA41BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB26974DA32942DE35F636FA41BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
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
X-TMN: [KzdDZXiyUY7vgEIWvEbD0NdpBtr8j5pl]
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZMtyV8qxr4RePrgb@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|MEAP282MB0294:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b72b55-e512-4651-1cbb-08db95936fab
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayFnWChqaReCkR4h6JtJ/ehMDOGV1AxVyNWEmKvOf3j0ZNWH6kmFxkEbX1Da3V2KNzzN+R8lKuhgIdRdwl/R12VwzD3P6rEt7xOjHKZN0tXwX9qj1ufLS1agU2GHlqIrbG7Y7oCVEiOMswwjla7ShB90kYR1Agt4hgqW051qhIV/v38JpY15YT0oaI/Te3jIZev+2Yv86ZkNkZEndspWLtCqCo98exYLyfvLaAV9uIWV+M3ZXFvJlvaUL7dZ+PABEJ4drbzbO0TimArx1VrPO290GY3GFTOtLFN4MT3/4VQokNprFBv3Slk7th7TcdBLNjG+/5vlxhVn4liHlJTBrN9+qepEkQlc+xN2Xi//REONRcsVm1gIo1bnCGqyfXjhxUb7XrqJZSrGYabNd0riGnvUMu3+RntVaudYze1gtk7H0Tnu+J3yJVi4u+QNtMl079L9Gt3h0L/aEACtE4stI2qVaFvRw9wvH+p+9MFldPMOHpdebdv73f4ikb6B+eEORgnrMbpk/IwR7TBKuM5CsA/dZdFXpgkBULSH939cjfH3EZY+VISPhpHpVJFJk9J5gTZ7NRahD6ULYjf9V7Uy2gszgZzXQFrk4Ctrhe3WBceOQiBH0vJLMjBsDoU/D5IT5V0cMhhdch2B+vyNIsrtLiAxdjBR/1WVgbX6RTUXMMyxbM5kfoAtWmV6jBnxXMr9y7TdBWY8WG9SwZ2Q0mV4xNRmkUSbn/KTlnQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pxvGMX8M7Yqa74Z8bFnB5Zlo1XYA+rWTSDmw8ykYnDbe6MbxW8bqMJP80ru+ZIk+HDW5LgD7gojoir+YKBstwCiNV7ONj5KcgbIXWkaNxk2qT9x2DaXKd/7XSf9Gbw/MTayzdMbalOBciIMjfSKv7ruiPdj6m9Zx9khcVx1SVtfQpnWklWqQw3Lwllt14UrX7h/mSJx3BcMPokys2oo4nLeJ4yyVx/f//s75gXa4qjo8QsUaCmt2A+arsL3G4ZB9MbyjtzdPhN+zvCXMcEIPipM7lsVAk5L7nkG9djTJGXauCugbV1EHLYEYVCe53k5r/ntx5/ypRQE1a22Jf1UXpgD+CdepnlzLYcJrbDYLNHTIbVF2wLyMyIavwKlpw1DgXNCrJ7GkdPZbMDUywsYJK7FTPUdkqwor5dqO5HEjvQT0/zvZPPLteLgtKurKMXJ+b46ZWqBzAtld/EdlE4g48Yz9ZsEltiWPqVnCtNt74f5jdWMMYC7venAA/sJLawHof4pmJW17UJ8h/svGxv3al68dJ087J5FGWNo90CJuFhQAm+VjpPgAonTUYhG/qfk/DN96Dob7nD1wZoAWNDWARzDHii7NEPyWhMhbbDif7lw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vO4DfHPG9FTHe7J3IZwXGYwqnRRl/Yb9Se1k1wagR83Q22/VT+5OwrJ8+psV?=
 =?us-ascii?Q?RAQgkw2tMt1dJWd1/VFSqVAFdabz428A5+j5f4cR/NNzp83qbXJy+gaDnCbr?=
 =?us-ascii?Q?idmESu6DzDZdZrGlJggIxE4Panma0d1gOC1cB1JXw1yRG69VIyQiFC5noaA/?=
 =?us-ascii?Q?a+qRQaAjL4qGfsGPvak1z21EKx7em5HKezhKqLvoDbkLApfZ2sNO6dbcYQFn?=
 =?us-ascii?Q?8AObrDHbTNdyUnrHnB0qBc58cghrNwkr2qCi7ULgrR6kZmYqgdkvYgaKrW1X?=
 =?us-ascii?Q?eGkaeKuKvigIfxx4l501U3HdFv3apZVYmMowcWxAlWT8+cne+MXPfRdsI+Jl?=
 =?us-ascii?Q?1mIcYJ9UD8LeiJOHRmcw2eNgvt9s8/eu9++XJNl4dYvmqLNoBrliD2vvgzsd?=
 =?us-ascii?Q?YuurObzPs3H9+IYlbQ7E/tgbH4s5zmRnWVeIempmktj5IStw+qIMWJ7ZD2eI?=
 =?us-ascii?Q?cyx3xVLaC/Unc3HvKqs2NRYt1u6uKlcrStQ1x16gHpD/vvWFtYC+lECGTv1i?=
 =?us-ascii?Q?BgQL9X9Ruh0Cx9DZ685g+CrQqVvBo/LndhJSYmL5+//peQ5/qjVXuiOTs+md?=
 =?us-ascii?Q?19D7GaYES7KIfk19cZj5DBCcd2++pVfXEenJWaN5OIIExtZ20G4WqzHIU8IY?=
 =?us-ascii?Q?4d90ftTaZOXIRCvqwUNG5KvBatmIDRT+i3YkWg+BEtuTG5oohUxvDUbXr6dN?=
 =?us-ascii?Q?QP609PQdP9QtkZ32HXgj7V93QMNYeHdsO8zXsx6W40v6ivqOt/6Hrh3syA3H?=
 =?us-ascii?Q?iOHPD6kZxJX5jOByWJ2TdAZJWxHk5WG9BGN3Y1jvdbLZ+Np7T/FiLwapgrAo?=
 =?us-ascii?Q?kO7sArnOtdKmZ+lnJxUvLz8+kdOR+3ayNEVAQ6gIcVMhs0oYJrJYbnpbY0su?=
 =?us-ascii?Q?yxZsIvf8p0Vo+ceN2f/NASXgm7uWUv/GeufHCNQd7w7pVXZLRPUYt+wBYZa0?=
 =?us-ascii?Q?YYtFglwhvFXPOAc64fi0Tl3mCRY/numLuJylj4N90MI59PHRYw7l1GajRhpt?=
 =?us-ascii?Q?B8d3qSzx8CtKdkL0YZ61hdcq3Bw7gggoMpWIa+uURMGVpFJfwslr+Cv73fDe?=
 =?us-ascii?Q?QX27eBGZkND6XJ84hFzghg61m5XrBLdc/RztP4jI/5CzATpSCQrG2kdKb2uH?=
 =?us-ascii?Q?Jop/PDUhJljLz1+JSIv7xKShr/tM7IOe/Nfu7aZxmH2OZG2aNz4YGsJQOf5W?=
 =?us-ascii?Q?sIHgtaYbeqB8j/e4MVJi0dkFJmK4RX/hAO9SqhBlBI6ArBqXpiviDRHwATI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b72b55-e512-4651-1cbb-08db95936fab
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 09:07:47.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0294

Thu, Aug 03, 2023 at 04:18:06AM CEST, songjinjian@hotmail.com wrote:
>From: Jinjian Song <jinjian.song@fibocom.com>
>
>>Adds support for t7xx wwan device firmware flashing & coredump collection
>>using devlink.

>Interesting. Makes me wonder why you didn't mention the "fastboot" param
>in the cover letter...

Thanks for your review, sorry I forget to add here from ptach 6 Devlink documentation
+  $ devlink dev param set pci/0000:bdf name fastboot value 1 cmode driverinit
+
+The devlink param fastboot is set to true via devlink param command, by
+passing name ``fastboot``, value ``1`` and cmode ``driverinit``.
+
+::
+
+  $ devlink dev reload pci/0000:$bdf action driver_reinit
+
+The wwan device is put into fastboot mode via devlink reload command, by
+passing ``driver_reinit`` action.

I will add here.

>
>>Jinjian Song (6):
>>  net: wwan: t7xx: Infrastructure for early port configuration
>>  net: wwan: t7xx: Driver registers with Devlink framework
>>  net: wwan: t7xx: Implements devlink ops of firmware flashing
>>  net: wwan: t7xx: Creates region & snapshot for coredump log collection
>>  net: wwan: t7xx: Adds sysfs attribute of modem event
>>  net: wwan: t7xx: Devlink documentation


