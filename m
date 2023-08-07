Return-Path: <netdev+bounces-24947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA27723E8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD352812D3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D8101EE;
	Mon,  7 Aug 2023 12:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD43101CE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:27:27 +0000 (UTC)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2156.outbound.protection.outlook.com [40.92.62.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A2E44
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPAZ1v+5zSVKGrTaACghiIZVrn93JjzP1U4I0AURg5zr+/nC4L3hFi31WJAoC8kOuWlnSEMmA/Xu5esdK9yARG1qL+u7ql3Jlo910KkO7PYtrL59kUdrJIVRYSlYholR1uzlBc6zU8dRVOfmdzRicfrxo8d50C9Jp7/WyO3xidV9aka+nxxvcKCLUtPM1HDXX2oazDNK+XLH/Jyco5T9OgJ5THOQlXGM1lXeDIAF/le33MxEHAiOnsy32IYGkS9u6UVe9CcEFlbS8LofnlZ5KOVTm2rwA94Nf3hnbcrkwMx0JpYvmML2GoS0IIwf5rg6ORQt/sRLXeakXDdTQo73VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVAyAUtpI3uNaAXXmxW37rSmvyrF1dbHyAolAr30slk=;
 b=JLJB0nmS1gN6CLrHER+2L/NQ5wVIJRipJBRngQWZnnRSz44j8Qik9v5vr7PWvRfqc81ExWIaS4QzAx2Jt8/K74nNFsazFCbreibb2qBJxDOKnBKmVbMYPbPiW3ToUzANcsKoj9kV7T7tQp+NgWUy2yHcC/NLSu4QesthRlt6KX2B/3hNRamhiXBEvkdYC/8WbN4IBtBMIUr0DGh1bXvzmvOMJfw8pgkhigH2Qjdh2ItyqJPRNzcaaARiBrW3kdZq0kcoYbLO4okG1I1fWYyeZKTVIP3oDbuXx0AExxVhRu01J57aETfQuT6uXjHLLxpEm1PhXEfHN5p8wA4aS2sYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVAyAUtpI3uNaAXXmxW37rSmvyrF1dbHyAolAr30slk=;
 b=lH+UI1qSooOsKMSq4OhnHx7+rgSab1FShmVvszdC7S5QZnpte6gPsy3VHb8elcJuHpcu3uaxoQR74Pqb113DjHpDTQ5wTwMhbu3pi3LB3BuNm6OgSXa1JCUxTELaTrVIli6bSFdD+Sz87bOoN61uBMvcuNuVmMTQXhovQm5Bn8G07ikvlyu6MW+yF4MhZ2X9LNUemC+5vAZmpbk0Tpz7DMBTejTkWvIhaRLN6M//HVQgzTAQJCtvPmR3t9bVZ4miorNOLkZ3h03FUrJhrh+d6N1kH/ITYFJys6ENPc7SywZBbnQ+66W4QLJD41vNatxK4xv9zyNXT/jQNgjDUiwFqg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB2193.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 12:27:16 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 12:27:16 +0000
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
Subject: Re: [net-next 3/6] net: wwan: t7xx: Implements devlink ops of firmware flashing
Date: Mon,  7 Aug 2023 20:26:53 +0800
Message-ID:
 <MEYP282MB2697E81E8FEC49757A385A5FBB0CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB269742CBB438E43607FA3BC4BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20230803021812.6126-1-songjinjian@hotmail.com> <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM> <MEYP282MB269742CBB438E43607FA3BC4BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8bit
X-TMN: [zuwjC+eNlU1+Duaau1I2+x6YXqwbD9re]
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZNCew+BPDITsZdY1@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB2193:EE_
X-MS-Office365-Filtering-Correlation-Id: 019da07b-3bb4-4b1f-693a-08db9741a28f
X-MS-Exchange-SLBlob-MailProps:
	ZILSnhm0P3ldVj1SzACJUMKs8NyCRMTXRA35fWGcAQcBJSsi4IPfz82pB2vvtC9oLHcDFXzGI9lthL8fnGumXJQ/SMTE+FYrXnSr4v4Cha1vTMvRUbUsbMN32Sl9vdd6cCG4/JCto6KKX4qmgk9pIB3/2L9LAfri61QXUQgzVKkWDNh2ovZ3wl4Jduw+AtGFaTzh1qfyz9VpeFRgvqnADhlLgKsGA3aq04MSaWe2DfCO4OldZvnE4exSp80DTjx310M+/u4pOmTkWPCFWaPAEUOu6hLIIzIQ/Jn2w/BfT/HfJ7Y+iKBsb1UnETo2ftN2pda+XWqyqIYWOnHYWHP9CoazmNLudg62igoE02qiI+z62ALzuwZDrsxI3l1jDFeuOTF4jNnCwdYiv7Q3a8nsC0+ahA5onXsKrPwEmx9zS/fgTOP+S0LbE9zktjXBCVsFlApBehkuT+BH4Ek8+ZwPYCVtHgMmF2A/41L2eND4npKzRCUL9STis6QYvnoZrr6qC3/BvFR4+N5R4m/Fmal9EEfrZRkEbkzA067F/OyDG+yx4qC7knqAji8VYKAN56H1bd3xDWx94G8lhg/xbV9/sQbWi91Fn1JpvRtYR0Slyr7Sc6tzDxCDS3ij4HDEK7N28jFm/Pkyuj4IUs5yMr56mWKdiTZT2ekLJerK1f1o+WsIqMMmwvScQF00Br6hoKmVEnC8ymaIomYIMIz9KdIrDLL/qEvxMCHbWhSwfjmJvjz0GPwATJaT18/5BCYy9BugJ2vC+P/K50o+iKnXN+LbnL2QXvohhWvn
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YcoalL02zEjCRn8b5sxNaNBZvExcUtAy2t5zMB7pWulFPPaZ8/eE4DuLQh24FFwQGuHzEiY+H9c7RjQHMtuSr4YayK7dHpLnGHG/kUlkuu3KV2HVqq+gdunrsEQLozEBjrIrVOTXimMZMJzpjNmAPKoPmb7WEZjsTjt/aUwksF7kb2V+bIGHkbH4k0GtuXvi9N9kdg1PlLRomHRj1tf+ExsVYYADnf+vmO+U/+aPrdRAuj/jcGS4VCrr+UJq/7QVR4viK7P8qxm41nBodXOwtY9n29O/waO+P36iawTF3Y9aR1xhJ0N0ABXQ0T1UV4e3OEM4yEwAgRSKSmBb170vw+a0VZN/XJigSTdpKpRfX58lxSdjHzPRoTRtxQBn44/lZp+rsBss8j0ujrJnGgn7Dt/L2LHdfKBDfQdhwhqn8k+SUjdon7BHL8Uo0Bo82ohNg5e+gZP9LRXidX9NSmX1hDvwKP/5zblkRalAG26UDwi2+Fc87nAnvAMqKOVUIxfhXMuTpNo2xQgB4Pi3fHcHNg7f/l/Rzc0HGxUEbQJfvnai4JJqBGScpUM1wWRiX0vHh92zjqrm5X1zYmWGVVn6OIsrryHO5j0Ldxi/0LN01PI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?klDXvmqC9OYDRINtCl0Bm+r5Dr8UNQSDBCrxIbbQaDz6XmI+H5/cdXfVt2Eg?=
 =?us-ascii?Q?7f7ZKT8FTm4iows0VxZ+NeA2cj6yxuixkBpic+IbB7tPZ/gnpg4c37t2NxIs?=
 =?us-ascii?Q?Z8nayCYx13p+Fz8dyZKV6H9f1HSXlGpEs274kuSToSJxOqvSi6kceliOH8d4?=
 =?us-ascii?Q?NqhKsyJljrXIwYpGUdVRhqSbZp9K3Uy6sdNBnK34ij9Io97+VlNP5vDEMUPG?=
 =?us-ascii?Q?LlUDXcSElOyWiIFCXtobGrPYXKP6tdDWzByZ0BjniQAESL5eVcEMGAhjrjvP?=
 =?us-ascii?Q?C++1BgxHbuhKMGT/o82O9ECSSL5MVI7WrEi9VsaPdPFQO41w8zVrBzSDROWi?=
 =?us-ascii?Q?yNu8LLUgX8n16D2KeoAclfU3K8w/zS2unr2H21V2b+qP4KM1Vb3lXqq6kwJ8?=
 =?us-ascii?Q?gLGj+jUrtmo6C5coKdak+U76mb0iXim+8q01tgHNT0sjicKdvasJYajcAsop?=
 =?us-ascii?Q?rMY49KqqjR2n36E0r2XnB2NOMPotd7LlUnjNYPXCmlWcsyHCpYDf3RRGvUeJ?=
 =?us-ascii?Q?UvJ3b7GcC7/lzkncMIsnvBRvTQWTk5PiyyXI+Lk6arhGNp0h334uSuRhcZHH?=
 =?us-ascii?Q?r4rLAdOFcoqtIUFIO86FF9WXFmrVoXoznMi1Yy51GRU72OMSdYKNm0SjRAzM?=
 =?us-ascii?Q?tD6n6KCWWjzhYUBiG9Sml3FlFcgFsSuqSKg+TFPp0n4nuty/mG8Vc3dubzWd?=
 =?us-ascii?Q?s5UW84XuPm9uyvA7019wZjcuM/TzBQ9KgeC7B0LbIi9PrqmPyGtBs+p1AUkN?=
 =?us-ascii?Q?dDkIUB00i9mcfHtCNQZN1dmyUGiJigcBteI71Ks4k9Dc7+rBn28+31EvI+KQ?=
 =?us-ascii?Q?EbKmxYbFw9HniyIBBFq6iVOPuWW1Rej6vuUWLH1hXuGSVMmD608cHuvmwFrx?=
 =?us-ascii?Q?BjFp8EC1sw6zhHZGMyjHCcfKxWsHpxTK91fqGw9mNPrOrS69jXQBMei6Z9VF?=
 =?us-ascii?Q?UhFqJNliVyOSKYlNhtwrof4LO+gyhrxLDfkNt6N5fkPU6vTFpXZwLXGFRTdL?=
 =?us-ascii?Q?zl8i7lAMSRmtM8aRuLk1/c9b9SBflo6bqglCyDzeFgLsmvRq6a0bmW/dKbpE?=
 =?us-ascii?Q?zrqdRygRjJ+7g3NSS4Ta2lI7Bp9j/ZudOfUFkv6gWvgS9nARyUSH/sJxAK3K?=
 =?us-ascii?Q?zaYsT5rItfbwPCG4xCnskha505p10Ed/7qvJwuJIQVpP2mA7hrVQLkqkylP8?=
 =?us-ascii?Q?TZuRJjeCwQDYC5mqgu9LeQnOcB1Hnb9gIg5lobOQzAIjGU1Hrhrfdc6PCxY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 019da07b-3bb4-4b1f-693a-08db9741a28f
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:27:16.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB2193

Thansk for your review.
Witch command: echo 1 > /sys/bus/pci/devices/${bdf}/remove, then driver will run the
.remove ops, during this steps, driver get the fastboot param then send command to 
device let device reset to fastboot download mode.

>
>
>>4.use space command rescan device, driver probe and export flash port.
>
>Again, what's "command rescan device" ?
>
>Could you perhaps rather use command line examples?

Thansk for your review.
With the command: echo 1 > /sys/bus/pci/rescan, then driver will run the .probe options
then driver will follow the fastboot download process to export the download ports.

>
>>5.devlink flash firmware image.
>>
>>if don't suggest use devlink param fastboot driver_reinit, I think set 
>>fastboot flag during this action, but Intel colleague Kumar have drop that way in the old 
>>v2 patch version.
>>https://patchwork.kernel.org/project/netdevbpf/patch/20230105154300.198873-1-m.chetan.kumar@linux.intel.com/ 
>>
>>>+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>>>+		return 0;
>>>+	default:
>>>+		/* Unsupported action should not get to this function */
>>>+		return -EOPNOTSUPP;
>>>+	}
>>>+}
>
>>>>+static int t7xx_devlink_info_get_loopback(struct devlink *devlink, struct devlink_info_req *req,
>>>>+					  struct netlink_ext_ack *extack)
>>>>+{
>>>>+	struct devlink_flash_component_lookup_ctx *lookup_ctx = req->version_cb_priv;
>>>>+	int ret;
>>>>+
>>>>+	if (!req)
>>>>+		return t7xx_devlink_info_get(devlink, req, extack);
>>>>+
>>>>+	ret = devlink_info_version_running_put_ext(req, lookup_ctx->lookup_name,
>>>
>>>It actually took me a while why you are doing this. You try to overcome
>>>the limitation for drivers to expose version for all components that are
>>>valid for flashing. That is not nice
>>>
>>>Please don't do things like this!
>>>
>>>Expose the versions for all valid components, or don't flash them.
>>
>>For the old modem firmware, it don't support the info_get function, so add the logic here to 
>>compatible with old modem firmware update during devlink flash.
>
>No! Don't do this. I don't care about your firmware. We enforce info_get
>and flash component parity, obey it. Either provide the version info for
>all components you want to flash with proper versions, or don't
>implement the flash.

Thanks for your review, I will delete the info_get_loopback function.

>
>
>>
>>>>+						   "1.0", DEVLINK_INFO_VERSION_TYPE_COMPONENT);
>>>>+
>>>>+	return ret;
>>>> }
>>>> 


