Return-Path: <netdev+bounces-30867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B978964E
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 13:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4077928180D
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B9D300;
	Sat, 26 Aug 2023 11:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A37E
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 11:33:10 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2148.outbound.protection.outlook.com [40.92.62.148])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D278E54
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 04:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8bv/X9rgmEHg8mHSYz5+r4L1zzbOq4+Q/mwU3zc4dJKMf3woCD+PsqDn4dC/nCmDm9DKj3rFGwnjUFpoVedOpP3RTpEi6QGt6r+MGemqIKkJ2vVvqoV+HoX1g6xfReSZ2xg6aawU5XEGe1G67G8kG6C+5nYmsb93Fnv7TXFGdcgZTfHnfbgDOnSi3u+VDUUlkaskptXT2mHtdxkAP3JZ4auVGJMC80DLd/05AAVX7rfj7pA8IXeHdZ7dBfzuhmyo5D2VlXeaY1RlAUPTMZYsUI9exIiQuV4BW9eFzTorUREnj7DEZjRyXd2H5tmTRJTQWqkzLgBxs0Sueq8P896hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNfMrq43U1myMaeqEwp72UaoXrjwkfH6BrpuLx259oo=;
 b=lPOwqipxttFTtqsFr8jTKFlJCBBdFxRK0+5/R/jDH+7NNpgR4IdwHshwf99nljB43kCp/lPwXSCykoa5t/3fVsM9TpmGNSHudD/eLaHHyntmakbh/CxUN4RG5wR2tJTTmrAxemseEIzES8LtsY3z+8mZM2p3GyKQkBZ67VeHhpbVxByPg3WHi1/4CiWFfTu6/5Y/x+RUGcac9322CnFVMGRPciPU4XntL8Ve75NbWix/fP+jbKPxJoPAoGFHvW04bZ1wqvWkhnNOdg4x8/nDhjHBz5yLISKAAHLREJ0l4ykri8B5NL3IJUo6+yXIOIhuL1CecogslGL8de4XNGTL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNfMrq43U1myMaeqEwp72UaoXrjwkfH6BrpuLx259oo=;
 b=fDNcifn/DjguMtPOqMoE9o/5BnODnAGbYhUY4ZrSGa+DKeBUaboqYsywgLl+6bXtE+E5LV4BNXC6qd1Y2fdAPt9+OMg+G8cL4aO6KzlFEQ5Uf1UA2vlnjPyJis7NFqKuXXG7YWI8NtHnI0ItVqc31+i/Vh2nGmrJTdbasgCreGRYl07UMD62HARSzotNFBUgxr04S2/CXBUrGMuE0mpDcz6QFppBlaV8RYxvEPOVqJuqHRj6tMGcATguJE8YJg+ZeHiOXlpd3aE1EHTgCsH8rpINGq46lCvp7oH/KeDS74e4AZxMdZ6C5pyX/QcC1d3tcJxrqlCcdLrI9VsyUH7oIA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB1180.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:af::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Sat, 26 Aug 2023 11:33:01 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 11:33:01 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: horms@kernel.org
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
	nmarupaka@google.com,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	soumya.prakash.mishra@intel.com,
	vsankar@lenovo.com
Subject: Re: [net-next v2 5/5] net: wwan: t7xx: Devlink documentation
Date: Sat, 26 Aug 2023 19:32:43 +0800
Message-ID:
 <MEYP282MB2697E31AD81A94BEC1E21B43BBE2A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB26978F449A3C639B1DB89984BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20230823142129.20566-1-songjinjian@hotmail.com> <MEYP282MB26978F449A3C639B1DB89984BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TMN: [BFoG6ghctVjOntaOUwgJJKrKwP0P+5/V]
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <20230824154705.GK3523530@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: 142009d6-c5fb-4a9c-537a-08dba6283472
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6ctfqMlX75VzllhgLbnCq7tpwCCptpAggDkAa/XcQJgSl+e6Qp+ZZ4IgCUw1MC95qZ8Mx/SEtkp5n4z0MsyCfGPmxuGRRS3/9iaHD/nrncQHDus9Di0gRChCNEFgC8gVXarxUALLkDDPwzrKh0K/0PoDP7Eh4M/rEnOGZb1PNV0j2H6rVURJ4qFGxQLMA2MAnKF0L3b39k0JVgls8MDc2EIrZ4yTUZ0bEvZYHNMYROaAQUgBEvutmn2Rv5KkBWRXqKZfgd6GdAsbv9b74U4yit1GkJ75hWJssYV1WBpEJnEF2h/lanIY16DzMSHOM7SP71/XT1EixcSIkl52TydJKYPx+3OaP2iROK5Qy/lxLHzFp5zHXdbHAVr2hSE2Lg7HIruenRzC/EEm7XGqA3LDA6duC+vTSG45JwoHTAQOcTX5lpeZluq8isOCewaWfndq70cZxgTWGFMhOt5tjjOmHDgFTxkAnwFEjDkGaWUsKcsrdScpWo3Azr59KcqRGsBAH+BIpoO6IAHYNiQ6Eku8GYsiJYhLDNZmuorX9rU/zFnPRxjZks5F0sB9BV4pjfvBySh4olj1VJrPdlQ4BE578YQy1JVFWrLjazqAZL3h9+5olkhrQCPg/QPumOB1x+AyeAGC8fXOcZvwkaUlIOD1BrAL3O74c94CL8h0rViLhgExAhBblrGCkF9M0rC9u/Aumawrjmf1bAhOZi+OKQJte2Q97uuC11gXh6YVz1ITmQjruk10OD0aoc9nVnP3Lo2csc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KWgRnYKcN3noqTIZa5IkSdEgAX5Sikhqjqud0vzfbclaSUPIPBClYfcxNkE8gfDBKbCWp5EgK8xYAE9lJkmPdjW2uULOrtYcdh7u98whoIvJcpS7gnwbCmNN4QAZAwi0hDJvky5talGC5BYMUxSERTGsCe9UwAmnzs2I8GzkBlBAeaDjvEo2+gADFkYH0Xt6lKEtESi2Qh58p470Mqp37RJG3p+xyNLx/D9sBMhTFagyNv7vbubkJaLkJfb46L5bMoiUaDwFv26JnbZBArTWA/ILw8jcMNY6uDO2xx6oQwApAUrKy+YsKE09CtGO9H3JMtj7RNoA9w71xZRkcyGBkTjmWnBuFjsZzBSNIglc5OaS3DWyp0IgKbRofG0qVx1SQoh/RTB4a7djL6NTKnKeS9GMlNoJTiMUr7T73C79JcFvJlL+ZluuveRHmoc9j5+/aiHRLBKdKEQAmoNna5KApIW8wnv6nvVAWc1OP5ErIL8xQJMhgO/Kb1KQ6BAtlQbShEkq5tV5g3HVh5kJ4MvxzZtpLdvbFdjQWck27Q5V2wSKj9hP99J9u1jwKmstZG7oNNh+PAvwg2c5QDsluZZyizoUbKb/7OwKPPtdcaQF8dw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qow2b6rd1tceUaBGGo9Qc+lh1Ahgh4eN77aDZyvmNZcAQi0LEpjwVLVtqBIX?=
 =?us-ascii?Q?evGJai2FqXszLnDfYwBn8w7BsnyZw8WzYmkMRPhL/5GGnEe+S8S8C+uOocQL?=
 =?us-ascii?Q?8WOm0fewweEapvlfsoOl9DcvUra1h4+u2OBbdKJjiaWNBSpck5n8rTbPpbag?=
 =?us-ascii?Q?Rd/XPSlrQl3ESKfBLz4D4ugENLuutSxEj/VuP3kjdBIIZ9c6sLj1GCLZq5Tk?=
 =?us-ascii?Q?P6of60x1qqfNT+boFFyDXBl2bqcRJidkGjCLv3bJJgnzJpK1cCiQ5HwfF+aF?=
 =?us-ascii?Q?BwAlN0N1XCdwxOwgkd5EMHEZVNe1Not0IJPiIVtGvEXL8J5MzQ9NrVTD598s?=
 =?us-ascii?Q?1aBMji1Px1U7rSUTuCQHpzRH/WEkm1BhG6q9lNeRJmhnxZt5Uc8iyShU8nHW?=
 =?us-ascii?Q?/ZfrJEwJTlrZQInzG3mxsBJ5mlzFIrqOjvxy9pYTbLa9RrfrEajZqxTLigtX?=
 =?us-ascii?Q?ETUuZ0XLEV7XPg6jpHuso8QRt+OoM476xA605QdrNwyTLt0v8t+LPsngjPi1?=
 =?us-ascii?Q?AaFdAXdiGguwE06pFLG3beBUCWDZnRK9g3cdcKQNlKJpLcSCayUR++k5f5UM?=
 =?us-ascii?Q?kE/ZFEhj3ez0jjkl1SgZQ0XJn4d4KyPr6HzDBk8Tj28WhdV58UUbASU+U4La?=
 =?us-ascii?Q?5jVnOLvIjaCi09UWXh0+ktcJl0YtFJsN73uNm+K00rdP12u3qGNzXNgn8aOY?=
 =?us-ascii?Q?V5JZ9/Bu0bN0H6iuZStSPmV+Swd+r/ryHx1vyja+uNpX93KXHldm8JAGZIYR?=
 =?us-ascii?Q?DEC0kzgpQ/1XEVRn5wHb91q4Uao9TdjgHkgBaV6FQl4sBVF/Izc30CO9PZHz?=
 =?us-ascii?Q?b3sNMur4k6iHmbtl6GgJETqkEyq37aefqjmI8fgp/lQBB5XFahsqYY3YytaD?=
 =?us-ascii?Q?WClPCi0qBA2VZhN17ntOZRP5CkLz49ex7h6EhHGoWMMX1x9dNooMAZ+sO8Op?=
 =?us-ascii?Q?dkabhwHzT/1TtU2JAJTElnvckBBnKU0t8wtrvtlBUvzMVUbFq3XlZST146IN?=
 =?us-ascii?Q?0MgVLaI60YvENlZqKXCrdEzM3pLR5Fq9hce8sQoO2j4fJbAJuv+1l1SceTu3?=
 =?us-ascii?Q?Hg3chdt4lGafXO7ulS6u7vXlfae3DMLYGnYY/obZbMUuiP533M/4Gmptzw97?=
 =?us-ascii?Q?G1X6EVWK2dH7u7HCw0hPNMgtGbugazNsLCR5zTbUeWLlPY+UAfAT5ocyFb3+?=
 =?us-ascii?Q?5X2b+jXlyoNuw7rmPtBzUtCGDr4GDgn0nrLkk8iTp7rm+kfc65s1+60hnEM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 142009d6-c5fb-4a9c-537a-08dba6283472
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 11:33:01.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1180
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 10:21:29PM +0800, Jinjian Song wrote:
>> From: Jinjian Song <jinjian.song@fibocom.com>
>> 
>> Document the t7xx devlink commands usage for firmware flashing &
>> coredump collection.
>> 
>> Base on the v5 patch version of follow series:
>> 'net: wwan: t7xx: fw flashing & coredump support'
>> (https://patchwork.kernel.org/project/netdevbpf/patch/f902d4a0cb807a205687f7e693079fba72ca7341.1674307425.git.m.chetan.kumar@linux.intel.com/)
>> 
>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>
>Hi Jinjian Song,
>
>some minor feedback from my side.
>
>...
>
>> +
>> +Coredump Collection
>> +~~~~~~~~~~~~~~~~~~
>
>nit: the line above seems to need one more '~'

Hi Simon,
Thanks for your review, I will modify this.

>> +
>> +::
>> +
>> +  $ devlink region new mr_dump
>> +
>> +::
>> +
>> +  $ devlink region read mr_dump snapshot 0 address 0 length $len
>> +
>> +::
>> +
>> +  $ devlink region del mr_dump snapshot 0
>> +
>> +Note: $len is actual len to be dumped.
>> +
>> +The userspace application uses these commands for obtaining the modem component
>> +logs when device encounters an exception.
>> +
>> +Second Stage Bootloader dump
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>Ditto.

Hi Simon,
Thanks for your review, I will modify this.

>> +
>> +::
>> +
>> +  $ devlink region new lk_dump
>> +
>> +::
>> +
>> +  $ devlink region read lk_dump snapshot 0 address 0 length $len
>> +
>> +::
>> +
>> +  $ devlink region del lk_dump snapshot 0
>> +
>> +Note: $len is actual len to be dumped.
>> +
>> +In fastboot mode the userspace application uses these commands for obtaining the
>> +current snapshot of second stage bootloader.
>> +
>> -- 
>> 2.34.1
>> 
>> 

