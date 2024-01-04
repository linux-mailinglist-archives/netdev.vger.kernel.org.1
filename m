Return-Path: <netdev+bounces-61452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8AB823C64
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 07:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3779EB212DC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE91CA97;
	Thu,  4 Jan 2024 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3HyUWvy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F21DFED
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1vFbjcVdC/yZC7Did/4UQcgUPY10WFjcVMhYNPtbtsh3/3/8efAgOM+J2VqJPYnF0i/p2m0ostX1snO54FY87TZSeLFwf89yktic7fJ+0Kk2iNpnTe/HNmkN5Xrd6wooz1CIL2VA1ACAIhMz5ZqVEKObgqtBss/7zkQ0z5QjBWPSUTvxfHS3txnaRqWxWsKYGsISkk7+tBBXi1R9Uf+HbUVa9RnmA7m4Wx+EgeA0pUZUGinK/TvxR0gDaileVcvv+x09xaH1zOy59VyZYJo9qyVQ3o2o9rDQqUb+cfCbiAF0HAyIrhP6PqN1XyM8Vw7Odit4xyC1SL43YLXnZWvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRwPwERlnYjgQykV4Lov3bwJopBwHenOqfhI+sIDOKE=;
 b=DagGa+b4hYd1lBRl4A/NORke4LDpjMii4Zmki40r70JMuzW2v6IFS0VHuWyRtp/63u0i39U6t7X6edQwAC+SUhNWC3wBvZf6zlpUGooklEPHxzHTZAfsRTZzoFdRyHylT1BdxHZMvLpXNoTieubOmwvSsBJUyji+OuNP1pGLE004o0CGPHXw5oIyHnUlQHnBYxjj/9RJCq/7vwxhWEZmg2iTj36FE5bSS/dqxVVsGQW5BiEGTe/0HjbH/GhfMvpdT9K7S5KJujtqYAc9dbDVebOmFwyITN6P6K4D8jSoaHPRyjtRGaGuLlhZvWdKRpFf8uoXsL56LnmZyljKuyR/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRwPwERlnYjgQykV4Lov3bwJopBwHenOqfhI+sIDOKE=;
 b=W3HyUWvyD3cjzYxTx1hvX+gn7IDQuKViUIshyggHA34PhnPIQ3icPhC4/82ZL+Sx7uW6stEneXPCXSCAylvAsbO5F4mp0bvH2QQqnqkCznE7d91Da/B0l/ICovkrSd+8pRWEDWGeU13/3I6IYIlTBLSQzJY3q+XP7w8FT8pty+/oli0eXlKwxmadxdiCGy84mQ4jPYxLXJCWm3Cj5RliXb+1lT5yVBm3omXAQgxieLyqH427xhTRBTC3RNX5CKjCrtdrYkOwYlSiWcRsuRubJZLyShSReQD9W+g4lvd06WivemGK1ZFBsNM/9r5fXofj39dBLgSwCS0cqc09WNcmHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 06:52:04 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231%5]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 06:52:04 +0000
Message-ID: <d00793e5-2895-4ce3-8da6-d99bedbed6ba@nvidia.com>
Date: Thu, 4 Jan 2024 08:51:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: Fix set RXNFC call on drivers with
 no RXFH support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>
References: <20240103191620.747837-1-gal@nvidia.com>
 <20240103133940.73888714@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20240103133940.73888714@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9f8a97-84b8-45ab-003f-08dc0cf1a8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IKuCjLiAmgafISqGhKF6rLeBVJ49IveBC78/G9K2XSJ2y1wdJ5Tk4IF+cQ66BPPqEnymbm55VmorfYP4IrIqAsfr/wF6SS0j8qJaWPeGQdzN5CgWL+fLeMF0Dot1ltl9tUIoHu+H2+euHrN30iqU4K/Bl5daet2WPovmXfojno6mp5Qi0QCpkNEKCP9i3v30luQwkBhLOREIoLpJ2lap+cABcKDQVKDwj/dqAxm0IeT+0ujudad0D7un8s8WNuEIWgLmiXzRxRuhe2wol1d4jmHe5hjM/Q1XX6PINelfIjL5CgWVrxghXJd5IUNpgrI86ZfG3cMGH5A7QT/EvkMrfWQ6kum9hT9UhNGmu9CgSLzfyq4wWkRSJw+ML4azJ7QivZzeUUZPfHbxO396StXzVqcBWpD18aIgtjEvt4+pGbZcXm3MTIjkZAGAgJ5R24TIRDYXR2EvOGXEdJq5Z/YZVKGfuDQpGdPNxONDA+5EAiOQwwkRh164SwHTUXnJfuysCyEumSq76kBekjXXfEM3sk1H3w3HTrEWhGYrWLaK1DlEsYzgUUXFeA9gnQ0R1+J+PgT41LaiLDE+FNsBqJNE745o0mDOao3ajL01FKWQzPOtih0HE32Ny7InHm/6timDhfmJ4gqRoSTjGH9o41kXYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6486002)(8676002)(8936002)(4326008)(6916009)(26005)(66476007)(66556008)(54906003)(316002)(66946007)(2616005)(6666004)(478600001)(53546011)(6506007)(6512007)(5660300002)(4744005)(2906002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXdTVnNkSnBHNEt0Wk5DTTMva3d2K2Z1OGJzalMwUzZSUHVESkMxRzNpMkNu?=
 =?utf-8?B?MzNjamk0bVNXaXZNOVpJOW1iczl1T3QrdWxMTnAzc1l6alJtSHU4UzhuVFlU?=
 =?utf-8?B?amhDdkFDSWV4QStRWGlOSHNOSzZhaHdGN2g3QlVWUXJuQ1FsMEFNMzgveFg3?=
 =?utf-8?B?N0kvbGViVmFrNzRKQ3UwMWpVSGlRWEl2Q2xVejJVNklGaFU4THZRQ2EwbTh6?=
 =?utf-8?B?bXBPUkZhZ1ZmMkRzRjNsS0hPYmRNelBkR3FFek1TR1pwTkdRNUZkWmY3cCs4?=
 =?utf-8?B?OTc4emhqTENta25VYkIzNXlxc3VYYkpDV3NZcVRKeFJlU3NvMEtIdjA1cVVu?=
 =?utf-8?B?cS9ETGRVaTJ4OWh5aGJvTGNaOFdoOHFtTlhGM0ttZ283WWtMckZndXF4MS92?=
 =?utf-8?B?VDdDb0pOTHZnSHE4WVpmalA1K1ZqU3dwRldEa0lTeEJWR1paN3RUb1NmWFJo?=
 =?utf-8?B?dFhxclpmeE1ucFBPd1phUUszbHBKRzVWYkVCVzNjeElhdmZpRXNnRjJkWk42?=
 =?utf-8?B?dnpkUHpGNGRwM0JxOEQ1c2pJQlpFN3JqVjZndUIzMjVXZTc5dGhvcTdqbzBp?=
 =?utf-8?B?N0VNTUlqWENUdTA5a1orQmQzcndYOUQ3am9BcE9JeWV2bzBuL28rSW9jUVBK?=
 =?utf-8?B?djUxd3FjYzM0WllVUXk1b1RIU2N3YWdGZW5XdjdGaVh3a2h5WFhobmFIcnJm?=
 =?utf-8?B?YXVhQ2ZyTmdJWlJaalRxcFZyM2lKZjIrdWpKdGx4NXYxcGpISW9URHFHSksr?=
 =?utf-8?B?SExubkR6MU5JSUZrWjRNME90eGpiSE5PUnRxK0s1QnNYSmxqNUdXSjFtU2Y3?=
 =?utf-8?B?ZUtWR1F0TUFJL2I3Q21LR3lPQUNIQjhJYnh3QVFOYTFRaTZlajYvYzNLU2JI?=
 =?utf-8?B?bkJleG8vTk5GcjgrbGlzaW9OVFZXa0xHVlQwRHZZNEdtMWNjSmZwM0Y3ZVFX?=
 =?utf-8?B?bEEreWN2Uy9YdjZMS3RBK3JaSFBXYVNPS2RLVHhKbGN0ZjVOd3I4R3FkUWxB?=
 =?utf-8?B?ZzNSMjlsMWJha2dBdmRQVS9EaEYrZElEbXNVQUNFS1oxZHZpNWl4cHpGaFU0?=
 =?utf-8?B?YXBtbEFic2ZraDB0cmRtVnFFMkxkNTBydmNmZzFnTncvWExkdVdsMmRuM3FJ?=
 =?utf-8?B?VllNbm5KczNuUlhRTU1XYTJRdUdnL1ZJQUxEUjk2TU1DZ0sxODVldi9sV2Fp?=
 =?utf-8?B?WXptdzdLUWtnbmtacDUreVFqZ25NLzdLVkRmbjBEeFI4Z1hWV2hrZGFETVNo?=
 =?utf-8?B?b2ZoczhrRW51MkRwN2h6TXdON3hIZHk4Tzl5OGtORnhiZ1Z3WFZKc1VIY1pm?=
 =?utf-8?B?ek8xcjRlK3NHSkUyVUQybStjZUhMd0xpTnk1NVRaSjhwcE5tN0dHUlFjQ1J2?=
 =?utf-8?B?SHNrb2gyaUZIR1hxZlB0MERCK2hqSTFKUnpobFA4eVFZMTVsZjJQTVFoWmFl?=
 =?utf-8?B?a1NaYVdYWTlvTlBxeUhpbjBBbWIwRVZCV3MyMXVvM0hNLzlwbXVpMUNFSDMz?=
 =?utf-8?B?ZEx5SmNkdWtFUWR1U0E3VHpZNzJzVEZBcEJKMk83bXNiaUx4Q0xIRjN3ZzFR?=
 =?utf-8?B?UnJtVHZOVUFKbTRTTXB5Zys1WVRjZ3c3WnNPc3lHSndwSGxPUGovcHJHVHdN?=
 =?utf-8?B?TDNmdWx6cEpvT3RwdS9kUCtFQlJNRXVtR1Y4UjdVaTREdUVuVHp6dnY3Sjlw?=
 =?utf-8?B?T2tzTXhtOXNNUE9TVTFwWnJiMHdXWElLcTNEL2ZnMmd2N2dMdXFnd3Jnelg2?=
 =?utf-8?B?emhNekFjbmhwN2JVUDVRdHRwS0lCOSt5VGZFZG4zclRCTUpTMHd2aVZpVW1H?=
 =?utf-8?B?ZjFudUR6amRVYXd4UHRaZWZZR0JqRkRybXhFWnlsQXVkUUpjWEF2KzB4RFov?=
 =?utf-8?B?V1hRRzhtZWozNk9MMjlQZjJHTGExL0JLemN5SjZ1UUgzTnZna3k2dE93SzdD?=
 =?utf-8?B?U1ltWHFNSnNpdEdDdTYrdWViRXpIVks3ME5UdGwwR3Z1QTFnR0FPWWpXa05N?=
 =?utf-8?B?UTl4RjYvejEvdVBiNEdtR0hKUnlYdGRjRTZublpDejg0K3dLM1JRR280b1lJ?=
 =?utf-8?B?V1d4T3VGSWJNRDd2UFNoZE5EYWVGUzh1T3owNW5adHVjZ0NoK3NRYVFIRVRL?=
 =?utf-8?Q?Aq8KtstfxSWyYH4AEz5RUdywi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9f8a97-84b8-45ab-003f-08dc0cf1a8c9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 06:52:04.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTC9qlsu2+/W3HbXoSfgb2OlWee+NZYaZcihIwNHPLtqws5DRazlv4AA1kvyd4TL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

On 03/01/2024 23:39, Jakub Kicinski wrote:
> On Wed, 3 Jan 2024 21:16:20 +0200 Gal Pressman wrote:
>> Some interfaces support get/set_rxnfc but not get/set_rxfh (mlx5 IPoIB
>> for example).
>> Instead of failing the RXNFC command, do the symmetric xor sanity check
>> for interfaces that support get_rxfh only.
>>
>> Fixes: dcd8dbf9e734 ("net: ethtool: get rid of get/set_rxfh_context functions")
>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> Thanks, we got a similar patch from Gerhard, applied yesterday:
> 501869fecfbc ("net: ethtool: Fix symmetric-xor RSS RX flow hash check")

Thanks, slipped under my radar, nice to see that we fixed it the same way.

