Return-Path: <netdev+bounces-52444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0B7FEBFF
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B0D281DA6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55D38FAB;
	Thu, 30 Nov 2023 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5bSBN+vl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138CAD4A;
	Thu, 30 Nov 2023 01:38:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQcsnTHEVVzsTaQyt0nnwDg0vrH4y2R1xm8ftoeouzjJRjgx2yGRy4RCNhXZtnh8sZKO/DptRavkHiHyjFP+1EpxfLGoJS5PuT/Yq5dSMtHS4sIjfnQ9NWZ2/kPaWVnXHdXaLmok67gD0ADfiQMsgUE2s1LTQwp+oOViGD9MLmePkd07pU1DzDZlBsnupoynC2NE5joDvC2C0OiLWgvhrLFQlwVgPvso6drTVlwUjD2el1liT5SWH3MClOyyrzTzq30uODTVC0eOvv6pGNSvO3xOYRjRJJvbwXkIFedavFsXu8at4vRzpTFTSSq1znP0n5dLknINE48xBB8ik7+ywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWNdwTU5wzWahMX8ji8BDpVXI2OVScUfmzFVEKZlQd0=;
 b=RsueGtYarhTZ8U+AaWJVO1dWR6OAz14eAWT6Scs41RgbnYPKGqfLyOqbvoLGJLJ/lNWtkviT+K/ijDLata+yVtWMWg1Lrq9UB621Y8fo+cr19WNYTDAYiCd4/mLhpoGnsbNmjrcIMX921wRNuQ2wazxmjIXAPRVT99uwgDG23Jx2vkyxWTLJUa+E3Q3l19zgkWpf/qRHOY9tnfKvURWFrsHMTgdzvGYqWEHuyVCk0hpY+u/Rfz2//c9CkRrlZUXfZXaIzaS/b7GRGE3LGz/fzonYGpvks/GkJcr3SPAAR8Q6VIbQflH8FkrXEWSEocxXrlQGWiTzdHG+nVw/WRmP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWNdwTU5wzWahMX8ji8BDpVXI2OVScUfmzFVEKZlQd0=;
 b=5bSBN+vlWUEPNH0d0/PMf8RtjIsPaPBpXphu4RfquYu8LJrPu6d4s/re2B5zSYtmXAhQk6D+nqijlX6vr4Etb5M+6uMnaq6si6Z0QU8oFfIbhbA8QZqyNC96UAW+82+Sfs37rCfu0GroizEnoZnC8N70mHDT/GT/7egsqXRCxDKf5r71k07SDknEVPZvhj2q2yQrx46gdlnIR/N1Z1CIzlMV0k2IaS9cEZSDzJIsZk3jmqxJMJgsZjkSZNo6bMEucCVFm9/tjV/y88leN6QA080Y6mKDXfmWUBWOzjj7UXzbV6GpKyDznTaxFNB4Y/VXI0rck6+toPMpRaa9TzLfsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AS8PR04MB7992.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 09:38:12 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 09:38:12 +0000
Message-ID: <794803a2-3084-4591-b91f-6c7cc7a3dbe9@suse.com>
Date: Thu, 30 Nov 2023 10:38:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] USB: gl620a: check for rx buffer overflow
To: Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, dmitry.bezrukov@aquantia.com,
 marcinguy@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231122095306.15175-1-oneukum@suse.com>
 <2c1a8d3e-fac1-d728-1c8d-509cd21f7b4d@omp.ru>
 <367cedf8-881b-4b88-8da0-a46a556effda@suse.com>
 <5a04ff8e-7044-2d46-ab12-f18f7833b7f5@gmail.com>
 <2338f70a-1823-47ad-8302-7fb62481f736@suse.com>
 <20231124115307.GP50352@kernel.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20231124115307.GP50352@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AS8PR04MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 7025bf9a-81e9-4a3e-7ca9-08dbf188117c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GOEUe8M4w+oZyLaFojmAA+lINUZzDmhYA/X/aQzeNHAG55X1NrDVuPgrHIRY4+Gdcfxro/++KxjBpF6EY4T6MRiKxFSolwnm1ExAjZWIUD+mOGKF1kOThALsiK+BQ36dwYqT7d+hpBEjgETtiR13EZIughk/NUY16ZVHXUIkTZL9cZ+XsAlH01QhNNblCrasLbsoHcwnMy3b7mWQOx358UHslfeoNXmLUxL7F6uoIpp7bFknNPK8/xTW//nPEPfA9Nc3GpJjkZuQnN7YvqIxHnPE8RfupdhFq8+diCV9TxntNS5WpGQs8e+JBJPLb5r4Ljm/nJSoDaNCtUtqcsWSIxGTOPmeJWXUx0FPaAzRyZRUXtLs8QmRL1dKQjvo9bcMU+dhsOo1oHaegRu3Kp333qzhHiFY5kSZq5u/OlRoJ/RcQt8vQrC1jArTormLltySObvtWwlK2uIwdas2a15ijak/1/elj+G5okDHHPU8E2KFh33hRcJoV+K80WatAYj+eBC7rgWHm1csqwohMvw0aeM+jFMrn87qSxv9DK+0i64jfkQVR0ArACVCREqOI528CZWyr9m59gp15jhHWL6ZlEr+tzpPoDgoWSET/62NBnA1xD27a6SILa9JHfYNFG8hH0fgvTBZF5DgMmQU5RadlAOJ5nDRC1I7YGoRmSteQKRHOwGqM+39xF2RZ5ac1L0Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(6666004)(6506007)(66946007)(66556008)(66476007)(54906003)(110136005)(31696002)(86362001)(316002)(8676002)(36756003)(4326008)(8936002)(41300700001)(478600001)(6486002)(6512007)(53546011)(2906002)(4744005)(31686004)(5660300002)(2616005)(202311291699003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJzQ05nSzVBSzdQNjMrN0s1QVNITUJCYnVndm9HakF0TU9nZ0FDT2NPcjNo?=
 =?utf-8?B?bWYrNVJNZWR2S0h3dkUyZ1hWYzZSVldQbW5kV1pvZE03cDNxUWNZRGZLcUUz?=
 =?utf-8?B?VU1lQ0VpMk5XYjFSNk1GaUZsamNFRG1BUkFBajJWTXNZWEo0WkFmbjhkdnJu?=
 =?utf-8?B?SEFpeHFDdEZ4ZGQyZFBnWXpiS0pqM3NHeWpGMExDUUVzNkExdEtBdC91Tmdt?=
 =?utf-8?B?cEM5WVo3RS85TUFJK3pNVm1aMFZib0V1alJIeEN2bFhlY2N5RmIzRGRYcS9v?=
 =?utf-8?B?Y0poajRLbnRVcjZ0K2ZiTWVGQ1dBOHVKTjdOZW9aRHMxcWF0ZHRkV2I1STEz?=
 =?utf-8?B?YTk1OEJtdmZKMGl2VmJEZzJuZ0VQdjJQSHQ0cmt6YVZTR251WnRTbnl0NjVT?=
 =?utf-8?B?dmdDQ0RocEJtWUorR2VGZk84eFN6aGRreGFVQlU1Q2diQmt0TWxoRlgrTXB5?=
 =?utf-8?B?SW9QVUEvTTdpMFlhSHZZOTVRMlhLZGlNVlhzbDg0N2JGTWpNRzZINndJMzA0?=
 =?utf-8?B?dzNxQkJKV3RNTGFHRXg5U0N1Y1hvNVhYaUdNUHFMTHBxdnZhbVNqaXJ4VFRT?=
 =?utf-8?B?a0ZzZUE1ak5ZZHVDT2VXd21oK1JXRTh3KzRwL2ZHYzlRM1pzR21UTG9Ici9H?=
 =?utf-8?B?amQ5SThBWm95QkNMM3Z4TGdmYlh0dFA4MHJ5YzBGSXhyUk5VYzZLL2NJc254?=
 =?utf-8?B?cEJsM2dSMDdVSnJuNzVEbzJRaWFJeFV1OVFKNXF2Nkoyb3ZBSzMrNWZmT0ZF?=
 =?utf-8?B?c1MyUnZGaGlJMm0rOHp4YU5mbFljUkRqVk1ERVN0aE9LdmxoMUtNbUxRbjl6?=
 =?utf-8?B?Y0w5TVJYb2FKWFVVN2IxaHMzV2h6djdLUHpsTzF4MGFwN3l0c3JIK3ZkQkE0?=
 =?utf-8?B?L3RHQXhxSHlUdFg5bUJFeTltbjR3NkU1OVRpdkt6STZ4MFRHSDRlMGZtUDdG?=
 =?utf-8?B?YnVhclhDSFE3WmpidTY5aFpIL2syRFZjakxoL2RudmxialVQM3dqN0htcVIy?=
 =?utf-8?B?amFWYWM4MWpha0JVMUsxaTcwUFFWai9zcXRCaGFKcFBqWXhubDBzeWg2RW1M?=
 =?utf-8?B?ajhCREtJSWt5K2pFbmxabkJPeGFKK09iOE1pSkF5ZFNLWTBFNFJNeXNUdWNL?=
 =?utf-8?B?Z3czak8yeGRvaFRVZUVTUVVjbmFkbzA0QlFLMkR4dW8raFhDQWRzTU0rbzVW?=
 =?utf-8?B?VzN2T002eGlKRzRySldDbjMyNFNGSVQ3WExvZHZOV0ZpOS9RTlNJR05CSDRj?=
 =?utf-8?B?S1NzcEFQdjgyREkyUzJHTWhxeFA5YUZKZWp0RlJ2QWxoM1pnWnN6eTdiM0pk?=
 =?utf-8?B?L2loZzRnZjl1QXI4Mk5oRTNzcHhuMlVvNk4zNXFrY3djWThWRDcwZlY1T0Yy?=
 =?utf-8?B?andERXY3dVg4TloxcVI3bDNKWmp6UlRrbGFDZldCK0x6TmFCa1hDRzRwanFh?=
 =?utf-8?B?Qk5VOHVNMHJUSTVxMEtmWkViZVI4VDZ2SktrUFRrQnM0d2hoQzVMS3ZoTFNG?=
 =?utf-8?B?QzdkbnZaamRVbk11ZjlONEhwYTd3NXpZSEJHUk1ITGZmVnQrODdON0NXUE4x?=
 =?utf-8?B?S2RJVEhUVVl0VzVBN3ViSlk0R0x0ZGg0NVZqU3JLYXpVWThxWmhIeEd3YWVq?=
 =?utf-8?B?WFpVbkRkWlhtWUV5YVEwV2dNazVwOUFnMDhHTTBhZVdpS0VyeFBjUjd1VE5v?=
 =?utf-8?B?dTA2dzcyL3RxSWtudzk3bUgyYm5JQzgwZU9aeGJRN2hsNkVJcHE2R0h3THBl?=
 =?utf-8?B?YlpoQldHOG9ydnFKc01lek8xdU1HZ0svZ3QwY0laSU9pb3YwQ2ZEMzltWVkv?=
 =?utf-8?B?MkRFK1dUbDFJb0hiZnhNb0NPTy9yVUxZNzFKb3lNa08za25taVM0S3FHbFJE?=
 =?utf-8?B?eG84ZUlJTnlqMUlEaUtpOXBuRkdNbEdScnFBODdQSnQ4YXRJUVpGUTRvODlP?=
 =?utf-8?B?dkE1RzEyTU9OUkdKblJMVjY0cTUwVTFsSjlJbkJ5V1I5d2daVnRaMitGSlM0?=
 =?utf-8?B?MXZwTUdsendjUGRNUEFKVm41bVN2dmpRZzZiN1I5UTFHL1R0NjRHeTZIT0pa?=
 =?utf-8?B?MVU5cnlYaVI2NW9XYjNnNHFPUFEwS1ZENkV2MWwyVWdMbjE2KzdjQVFidU81?=
 =?utf-8?B?Z2pSM2ljK1BuVEVWY2hleUlyWWxydldSbnJZd2o2TEVQaUh4d1dmUnJ6MTJQ?=
 =?utf-8?Q?yx3jvi/0/tZRGhV7C083AN3150fkdQ9d3F1PRBrI6wxG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7025bf9a-81e9-4a3e-7ca9-08dbf188117c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:38:11.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCgF3JLnlRdtB/dORaGbjfehlAfW4dZ6DUlgH70uu359DUC6FXrtx8Ddckjw6rbZ+qkgJ4r7a/t2Y+Z25iMfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7992

On 24.11.23 12:53, Simon Horman wrote:
>
> 
> I think it would be useful to include information along the lines
> of the above in the patch description.

Hi,

I see why you want this information to be available.
So I thought about it and I think this should be
either in Documentation or in a comment in usbnet,
so that new drivers include the necessary checks
from the start. What do you think?

	Regards
		Oliver

