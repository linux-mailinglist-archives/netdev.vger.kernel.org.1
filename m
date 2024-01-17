Return-Path: <netdev+bounces-63880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F63182FE87
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 02:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984811F294CD
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA06410E9;
	Wed, 17 Jan 2024 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LSAoquwy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303079C2
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455941; cv=fail; b=Bb8xc8AnvXargI//t86sXSVq0TFBhxjz19Y4Qc20rByf8opvg7J4cOnVpLAUerOor3jx9LodKRKknivybQFxvOr/IY7/Ote/cAQWBcGRSxvlCYjhgLrncZ17nYKc9LR04vO4KitMMw2WOv8Ukt2qC/VZHsa+IaltGMINwZ3ng8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455941; c=relaxed/simple;
	bh=AzTVdqxtNDV+DSBT1oINnXI2zRw2pV7G4kDozp5Nvl4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:References:User-agent:From:To:Cc:Subject:Date:
	 In-reply-to:Message-ID:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=RvaOPVMbwvRhCr8pCnXv4wY0z2QvP6Y1KeOF7N0kmS5CAetahSBSb++t1U5Z62bCjE+8ju9XhoUL1T7gxbIMp0GW/lL+Q5Ch/437GQtyfBlAHOXgUHSMQtvElvanW04/Q6Btcimj2aCk4fChQfMCmge+75iot+x+HthFrzOrpFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LSAoquwy; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSB9azQd+Y/vMUd2ziFZXZ6/yMI8TdmUFyHE8SSmtrUcl+7/SG+en1Td6W0nIKaCCZRVLEECqPPw2Ox9PtS9I9VtyJ/Kj31LSxCkIey9F5QTagcb4sbZpKbAM4WLgGzMLp8dDMioi6Zv7YTShxMWMrJGmpL3Mxx0+wIZu+H6VmhpPelN//KHcnWDeKmD+rxc4ZFDBa0SYEU8zbhZ98VgUmJBWIeUOLf9YLPeKmmleJmrxGNR3s45ck+PVFuvziolhuLpF9V986yVNh5Y5sVOiQlvHcTcoGSxOSIuHIdconQBz7McNIQkQgiUN1lCZCAuyloQ8grGNf2rlp54hUA4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyZ/Fjv7YWG/4BL7YuoN7Sfa+p2dyfKPSMcUmwklbqg=;
 b=Jk9f42/KUJkvAEIFfzCuIlatNHf7hmDQ8snCSNwsomwIwgKg6M4LKUFa+DehPpKEBk2HBq0noIHyg45BHYuCQA+7n4o7efegWXo9IILWd6JSQDdYxUvzC5g9LXUHLmY9WueWeYRgP6W9c75OZkQ/fkHtMgOHdQbRFVgLlmkHWhOsQQ6J5Zenzu7iRhyLPs5V+y/2mpGIzwFgoFlBo2EZt+5AnB8YpAddeuKYyU2InDV9hB9adJkupubUdZQZK65zcJZ+Xrq6lx4B9zmSZOE7KepQ7rKsiqbXaTfY1HQWJlyVMRseL7eyosxTLGVxofxG+fzvts0jSHF/I/b/pmdL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyZ/Fjv7YWG/4BL7YuoN7Sfa+p2dyfKPSMcUmwklbqg=;
 b=LSAoquwyPmY8PNpj85zxOJ83PZYsHsazhUYkABjti1cS/3S1j+7fgzwJek1fatyFhyxOEm/VfIxcDVRTWKEJ1MGF6ZZhgC6i8GL8HhF1BQdsxF7hFBCqyJPIc2a9vlInMilaXQ72DFVaP/L4Us0/8BSbmpTdAaQCOSEkznZtNpYSWFeY0HgptGs1wOdPHNFCL1sNj1ccxFdULf5XpjCD9iZVemU86uPx25DKGy6mZ7G9SyX1/98RYKe4aZEtvaEkRkoYCiJJMswsX9n5/QM16Rh7IiB0KasPf/9Fo/CZMb8+gq4r6WssTKc7L2hsKSAJiC5DlQfDanyepMYJrT870w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 01:45:35 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 01:45:35 +0000
References: <20240114174208.34330-2-rrameshbabu@nvidia.com>
 <9b1d136c156b33759a0323e988b73839d5920acc.camel@redhat.com>
 <ZaaJ17btw2PtW-Sd@hog> <878r4pov1b.fsf@nvidia.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, "David S .  Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH net] Revert "net: macsec: use
 skb_ensure_writable_head_tail to expand the skb"
Date: Tue, 16 Jan 2024 17:22:58 -0800
In-reply-to: <878r4pov1b.fsf@nvidia.com>
Message-ID: <87y1coohq9.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:40::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: a3779971-f74b-481c-e352-08dc16fdff8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vUtevC63oWcwdsgd0BeZDHaCO9rJCCDe1GzVhDCLGErlNssZp5hsFsZ/Q6ljO7DkS1/r8RRqUyFv7Xv04Rknx0xAxXF1SsiZZuIVpKIQZKE+fWQlWlkLT0IV+g++hXjRqew3oVtz1ubaLmwvwGwg75Hv4s0BRPCMtygOmJgb6mmSJ36G1qoe9sjIJRC6nGU3wzL2kYSRmKlwGNzEIsVmMWcVzkGqGja5liA3oMcu3ujU47VvPBSaGwAODt9t6QtusGg6pbXN7BGs6Ewn45eD7meEtw4SFSv/qE9GDdvW2lQv3dO9dTN4QFVoA9f/w3dT38DPseSnrDKyZvaHMFNlLUfDK0vmUjgsZRN+fB0AeE9YqVYVu7DxSiyrDSHkqKyVmPzgqPW/SJ+uhFRAjVHP8qfejFwoqRbnE5IYzgFxwFZV7EqHaZ7gsx+MymVWXXdvb+31pVQLfh5r46c0yMLSqz34lUxlq1EbPvY5H6HAOtG+ctD/HJQBMA3MICcVmOWQsZ6ozR1GQQMTMzN4jx+o5No4D32qppdMCdPqEzXZLww6WDKiZGZC4TBNUarBJ6yEw+R68n1h1tM14iBT0GepOOg4YHTyRkes1gDqgIC9OolwEBGdrK5XjhdgTYykseMy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(36756003)(86362001)(41300700001)(5660300002)(2616005)(6512007)(26005)(66946007)(478600001)(6486002)(37006003)(66476007)(8936002)(54906003)(66556008)(6666004)(6506007)(38100700002)(8676002)(6200100001)(6862004)(4326008)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjQrdEtRSWdsVGJBVnNPV2FPclFkaUF2QUVKL1RZekppRE11Nko2eTAzeCtz?=
 =?utf-8?B?bjcyOGEyR1c3VnFscmdpc1g1T3RnMkFTSjBra01ONmxuM1NGWW5FSjdScmdy?=
 =?utf-8?B?ZFJMcm8wWXkzM0lqMWp2d1g4b0poWWIvUStaOUtYVzN4bkhNamJhUVZ0N0FF?=
 =?utf-8?B?ZXdnR29lcFRPWStBMTI2VlA4TnVCNlhxYWVVeXJvNkhLaDE1b1JpNEQrak1t?=
 =?utf-8?B?RGhOb3U2YTlvSmdMNWdZL1NJV1l0TkxiVWhKSTZJSmtYZlNubHlUdlNIbjla?=
 =?utf-8?B?aEZJK3dSRnFjOG11QlMxVmRBZDVuZnlsZitnL2RCNVZHVFk3SjBCYktNelZh?=
 =?utf-8?B?ZzBzSmtpeTN0MVl5OHlEMWdoZXRjZG9VRkk0WDJnWE84TmVHRmNBZVJVcitD?=
 =?utf-8?B?YmtWT1VHZ1NRL3lFLzRqYmpLMjBXRmNkYkdhMWhCNktSRGhueGp6NXRxQ3FE?=
 =?utf-8?B?cEdWMjNWUnRvb3M2K0w0bXRZM3NJUjRXaHd1R3N6NXgzT0VxTmlaWGdhaVhZ?=
 =?utf-8?B?V2VmUDFkVkZOaFBWS0ZrWTJuNjdEMmYyUTlmd045TmZXb3NxWWxHQ1ZodE1F?=
 =?utf-8?B?VjJFYm56VG5tUHVEandGV3lqZ0JiZGVZbjFDSUZTT295L0ZZOU9UVE9lbUxm?=
 =?utf-8?B?andsczNhWWV5eEtqSS9wZCswREJkWFVTeHpWY09mY2hlSGJDQ2xROFNYa0dQ?=
 =?utf-8?B?VFpRZHNFbGk0V0NWbkdIcVgyQ0dpT2NlRlpKVXVKNE15bm9qaVRUcnROSXNt?=
 =?utf-8?B?Q3E1Zk5QZE1HUnZXZXJ1RitxRXA5R1lNOXBDNWFZZ1dRME5vbUNWVC9peVla?=
 =?utf-8?B?czhRTllmTEJON0xqa28vN2hQRDROYk0vbktVVjYvM05XLzIyMnNndVFzeFRM?=
 =?utf-8?B?TDZxdGZObVMwb1pVU0xIQVJCRzhKWVNyTHdJYWZza1F6SmJWb0c0YzdmbnlY?=
 =?utf-8?B?S09rVkgrU2ZpUWlHd1NtMFpGdEMzTVhkcVo1bGdLZU9la21NNUtyQ1BZdmhr?=
 =?utf-8?B?YVhaT05iNCs3R0VZT2ViZGtzYStCQWlzMlRvREViSTJZM0phYjdPWmxXN3o0?=
 =?utf-8?B?WVhYcDlyVzBQWUdpc1ZaNFJHZVhqU0JDd0tZeDRscmhhYjFjNHZpMzNMakJh?=
 =?utf-8?B?a1laenk3ZTVmZzVaTGxOWlFBS1o4VFZxcGVCSXBucS9yMUswdUltYWNrZTZw?=
 =?utf-8?B?d3dIb1BuUFZYeGZKbnJHSHIrOHlFcEluM1RINGZ3WU5uZFc4RlJMTUVSMEFm?=
 =?utf-8?B?Wm00ckFlOFd4ZkJtd1ByWW1rRXpCZUVwK29wUWlPMWdNK3FaVC9tL1MwSjZ0?=
 =?utf-8?B?K1JzbXFaMXVKUU9pTEtJSDE1NmR5MUJWemxhNXRWL2VYVnF5S3ZyaVFQYUhK?=
 =?utf-8?B?Z2tJaG5Dc1VwQWgrZkpHQWdKamVNalpvbU9RRTNSRjJpR0pnVkJLRTJkQ2ZN?=
 =?utf-8?B?aXp5T2gxTm5UU1VyMTdDSUozWlh5eTNWNmJidk5zTHBsOFduRzJoZlNRVFN3?=
 =?utf-8?B?Rk9lekZDbWdsWUpFOXhaZElWVFBKMjN4WkFxTGtRRENzTjlIT01CSTZVUEMw?=
 =?utf-8?B?c0ZNemNpNk4yUVUrWjZGZ3hOTTA1UzRweExoaDh6TzFlWUZraEI5eTdLaWRj?=
 =?utf-8?B?V1ZrMDdOTVV1dCtxcWNta3J0anVEdjdhNURRRG12aG1iUGk3bk4vVGx4VUpu?=
 =?utf-8?B?KzNtR1hzOHFVVWlhSHR0Tlp2VlBzeDJObUZzQ2tpR285V1o2VWZralFGZzc4?=
 =?utf-8?B?aDJZQjNNUUpuSWRRZnFlcEhzejNZeUNZUEgvcUJNYjUzNHRGT3NpVkJveFly?=
 =?utf-8?B?bVYyY3dIaVRSZzZsdk1wNXZUOW1kT3dta2xBQjMxamQvQXdUaVZibkpSMlNL?=
 =?utf-8?B?RzRvaEtGM0h3SEZFSzlSWkVXYmtnWlprSm01NmJRNHBSSkljaHpNU2NxQXFJ?=
 =?utf-8?B?QkRseEpaQ0VEcWZMSXhtSkVOOTJtSEVkZDNpZUpFWTJTZ0loSXhDQlZ0c1dk?=
 =?utf-8?B?bFZTS1RRK2YveDZkcndCbm5KWTUwV0cxNDYralFCd2g4cnA4VXVrZFg0ZEhH?=
 =?utf-8?B?aThDTDVLVkFKbjRjcHNYb3ZwakVldFIvTngvRnY0cDBvN3dzNkJqMWUvbkRq?=
 =?utf-8?B?Z0pPK05hQzRaMkdoNStkczdnY2dRYWdTdnZMeXJqK1ZSb0wvdnpEYWlqNFlS?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3779971-f74b-481c-e352-08dc16fdff8e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 01:45:35.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqq8ftZqfYm5zLUepZvkwHcGFyIMPFkwXV7y0B9hjR1DT+9vmivKcGD6xH3y+Eqnz/SexhUdVxe0aKcIg3iiEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498

On Tue, 16 Jan, 2024 12:45:46 -0800 Rahul Rameshbabu <rrameshbabu@nvidia.co=
m> wrote:
> On Tue, 16 Jan, 2024 14:51:19 +0100 Sabrina Dubroca <sd@queasysnail.net> =
wrote:
>> 2024-01-16, 11:39:35 +0100, Paolo Abeni wrote:
>>> On Sun, 2024-01-14 at 09:42 -0800, Rahul Rameshbabu wrote:
>>> > This reverts commit b34ab3527b9622ca4910df24ff5beed5aa66c6b5.
>>> >=20
>>> > Using skb_ensure_writable_head_tail without a call to skb_unshare cau=
ses
>>> > the MACsec stack to operate on the original skb rather than a copy in=
 the
>>> > macsec_encrypt path. This causes the buffer to be exceeded in space, =
and
>>> > leads to warnings generated by skb_put operations.=C2=A0
>>>=20
>>> This part of the changelog is confusing to me. It looks like the skb
>>> should be uncloned under the same conditions before and after this
>>> patch (and/or the reverted)??!
>>
>> I don't think so. The old code was doing unshare +
>> expand. skb_ensure_writable_head_tail calls pskb_expand_head without
>> unshare, which doesn't give us a fresh sk_buff, only takes care of the
>> headroom/tailroom. Or do I need more coffee? :/
>
> Sabrina's analysis is correct. We no longer get a fresh sk_buff with
> this commit.
>
>>
>>> Possibly dev->needed_headroom/needed_tailroom values are incorrect?!?
>>
>> That's also possible following commit a73d8779d61a ("net: macsec:
>> introduce mdo_insert_tx_tag"). Then this revert would only be hiding
>> the issue.
>
> Ah, I think that is an interesting point.
>
>     static void macsec_set_head_tail_room(struct net_device *dev)
>     {
>     	struct macsec_dev *macsec =3D macsec_priv(dev);
>     	struct net_device *real_dev =3D macsec->real_dev;
>     	int needed_headroom, needed_tailroom;
>     	const struct macsec_ops *ops;
>
>     	ops =3D macsec_get_ops(macsec, NULL);
>     	if (ops) {
>
> This condition should really be ops && ops->mdo_insert_tx_tags. Let me
> retest with this change and post back. That said, I am wondering if we
> still need a fresh skb in the macsec stack or not as was done previously
> with skb_unshare/skb_copy_expand or not.

Both fixing the headroom/tailroom management in this commit,
a73d8779d61a ("net: macsec: introduce mdo_insert_tx_tag"), as well as
simply reverting this commit does not resolve the issue. I also end up
needing to revert b34ab3527b96 ("net: macsec: use
skb_ensure_writable_head_tail to expand the skb"), so that a fresh
sk_buff is created to avoid the panic mentioned in this commit.

I think we can do one of two things.

1. We merge this patch, and I send a follow-up fix with regards to the
   issues in b34ab3527b96.
2. I send a v2 where I add an additional patch for fixing the issues in
   b34ab3527b96.

>
>     		needed_headroom =3D ops->needed_headroom;
>     		needed_tailroom =3D ops->needed_tailroom;
>     	} else {
>     		needed_headroom =3D MACSEC_NEEDED_HEADROOM;
>     		needed_tailroom =3D MACSEC_NEEDED_TAILROOM;
>     	}
>
>     	dev->needed_headroom =3D real_dev->needed_headroom + needed_headroom=
;
>     	dev->needed_tailroom =3D real_dev->needed_tailroom + needed_tailroom=
;
>     }

--
Thanks,

Rahul Rameshbabu

