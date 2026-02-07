Return-Path: <netdev+bounces-257759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HNwObs6h2lKVQQAu9opvQ
	(envelope-from <netdev+bounces-257759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 14:14:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143D105F27
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 14:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2961C30138B5
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94A34107A;
	Sat,  7 Feb 2026 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eC8mA9Xk"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5034106A
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770470071; cv=fail; b=UPvw7W80EAI6eMPvCXANvhnESb3NOZd8PHh9aw60sRgSmD5RbNuOYi0fRadTbaKvIHnGmzfPFGymJDH/ZeZExh2STsh2dTKUJ3IG2TSpVYVn867EeTNjqdDMsm7r+fYCvtLkGDoaqVMNPkz4WcyHEKA/X1ZlUfaS4IZwuRef6tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770470071; c=relaxed/simple;
	bh=dKFqf5nsrIJcIedPZ1JLQlhiyJU3c0cAyCnlzDms0Xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d6Cme0U2cWtMLwJLqqQwFFq8hiy+CPvMQiuy4KeCd4BhJprhadtj9N1aeFy65/1Plqa5BFBGBuNpCeMdKI1J5256OhESsyo8AXaJAhKZKWqokY6zzA7Ex3819SIcmThDQ7NYUS9a0Ns5Zt4Pcjzw9sbq9Y+NpIvns1WUVqS7MF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eC8mA9Xk; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csXH/xjuJnKip16c/Z/+DnBzZN+eGX7AW32U8ZYnfLzMyFL0+LQGkF2SC/6/8kX/S2449uaQebx5WBWJx+EONBoYJ0Vg2Go3eR5WaMWOPBf7heiI9pxJ71iVfEkYWP/FunNkLzjnDe2KKvRhulLRCDCou5VYj6zxrUmzBWUp7vPOBhqJD17Ux5AMbR7CGn0snSeb/eELWOqA6T9nl+FTbvX0Is0bTzpIRZXYh8WAFxFvmVJOiz080hOThSyVxExYK9SztlqAkX2gmpVe/3+BY9SIdDdJgr/f0sSMQ/VcefQLH7tdMiVMbLSA6CfcxKwoEO0kJES0qW2tTDioLj7m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HylQ8cJXATijJiK9q6iwJaXSIDv5eIvG6o180Q2L9pY=;
 b=murcN7MjhmIZjCP6A1X3PcMWG4ThWy4NyuVOE6v4IzgsSX/+1jEZdlstl9e7DjVYe2x5Z9ZZNvVR4Mnw1TNhdRzk7ThqAer9goard2k4P88Gh1ltxUonTAYuOcaW+Y/5/WKL2LDyys4NA6uUifjOg93pimyW9QV4x0gU4swhJS1L5qYuCoF1/7Y1OKycZr5ojanrnLaUUw/htvlZJtp6xjZzBlJXsMTTjiIOVaGeathHf9JW2PD0M8IZgOaYLY4E//kl+U0weALVpjAuzV26P6JAf7jQ+ePh4+aeBDQCHE+PtvnTv3L1dhvR38VQZXfWHEb/xMjCOI+NOYbTWMckuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HylQ8cJXATijJiK9q6iwJaXSIDv5eIvG6o180Q2L9pY=;
 b=eC8mA9XkvKhZnuS8/xqNRZnZi/rh8KIvFG8CT9grmhMNRdKd8x2+9ZD4XpJHHcw0kcsDnqXjtlCgiCO628b9xHeFQtXyRaScrkBnjIsuL0ZIOJLZM6gQkv9k8pKGHrWS0Bir3ka1PuTuCi5sK+mt27A3yl3QbhH0utqIs0pTBN6coUpYMTPxZWBPD5XRsAJJqrXBhmTQaFdsXZMyjV6MCwxFdt0Kd4Eu3QJNUMKqliG7CJQiTj1oV8Gy1UjfefrSoKMcy0WskDfy+u2V/4EmJik2kW/VAL/fWC/axxU3LIT6WxqOpt/ylqgmiMeOErAWIstl47wOFzdTkATis4/CrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Sat, 7 Feb
 2026 13:14:27 +0000
Received: from PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe]) by PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe%6]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 13:14:27 +0000
Message-ID: <c96d6b1c-5bad-4e06-905c-10f722c9b9d1@nvidia.com>
Date: Sat, 7 Feb 2026 07:14:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205184328.3b706154@kernel.org>
 <20260207045848-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20260207045848-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:806:6f::33) To PH8PR12MB6748.namprd12.prod.outlook.com
 (2603:10b6:510:1c4::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6748:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfd2d80-4e07-48b9-ae89-08de664ad227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXUwMnpRZm1oR2lIdUJFK2lWSCtTc1pzRjNGcUpqYUdESm9SYXJrN1pISGRa?=
 =?utf-8?B?dWdNYTArM2krcTl1TU0yODFUYThFMHdJWGorN3BrZ1MrS3NKTHFNa2RXNkVK?=
 =?utf-8?B?V2NMZWkyQzBzRzdLT3htR3RUU3h4ZGNWVzllR1d5N2JzU1A0TGliUzdVQ0xI?=
 =?utf-8?B?RG14UUY4NVdCMGdwdXBXVDBOQzBobUNHV0ZYTnUwSk5zSFkvLzAzMHJsVmRK?=
 =?utf-8?B?eU0vcHkvZHlhYXRjQ0lzZWRMRWtnZkV3d2ExWTM1QXZGVkUvSlpLMDlxT0NZ?=
 =?utf-8?B?QlY4YUJGSmtwcXdYWUVuS3Uzb1NRM2w3dTJ0WWhCZWxtZ0tyZ21tbGs3bkdN?=
 =?utf-8?B?bXZCNnNnZFBVa2R4SEU0OHE1MlRCRkVZSVlGUUgyZmZSQ25VWUxMOUpzRGdx?=
 =?utf-8?B?Qk45dFFXc0lHZ1UwdnpxaWNKbTFqbmJuUUZDK3E1enhwcTRhOHRsZytpd2c4?=
 =?utf-8?B?R3FJMVlacWJJVlVyVC9SdGpzN1VuWDc5UWlYYlhtdEVsMEZTOVV3Mm90Rm5x?=
 =?utf-8?B?NFVua2dGeldMVDMvNFp4R0cyZGZURGtiVUFyNHVXM1k0L0hEcU1mS0hnQVMr?=
 =?utf-8?B?dzZzNFZFNzIyTFF4c0VSSitPR29FT014UlhMNTBydmtkdTZGYU53Ny9DUHlw?=
 =?utf-8?B?aDNPZ0xGeFlQMFd0YlZ0dFUwVXBYWWpiUm0xNm04aFNpcEJoTGl1L0R5M1Q3?=
 =?utf-8?B?NEpKazI5UmJpRHJDVnN5bm83Ly9aa3NoRjRBRWEzbE9wb016MmhYTFUrM2l0?=
 =?utf-8?B?aVpFemtLdVQyOHYyUy9vVnBZRHZFeFZ2ZjhWY1V3SENyOVp0azVzbERSY2Y4?=
 =?utf-8?B?UG9BUHExY0FjenUzaXF5cXN1MHQraE1CeXBHRldTcVFGYngwdDBCaGhnT2hp?=
 =?utf-8?B?ZjB1TGRYWmdPN2JyZXRIUi9IREM1ZGwwRjJZS3YrMXE4WlM5d2hVaXZEdkl6?=
 =?utf-8?B?UWpJeG1NbU9qakNQY0RKZGVaZmNXZWFScTlpR2VhRHd1M21Xem1YVjY3MkhM?=
 =?utf-8?B?aHpxVkRCcE1HL3I4ZFVnWDEzeXZDbVZ2dmhPVDNtbTF4WXpRQkh4R1BNbTJo?=
 =?utf-8?B?OVQ3RlFzUWszWWlGNkliVjN2R2UvSTdRQks0M0tiN0pYejRGYUNmaVdrT0F6?=
 =?utf-8?B?RndDckZ3ZHJSU01XWkU4SFFxREpudnRybEdkSzBNNlI1dklVcFdrS0JQS3pm?=
 =?utf-8?B?T1BxcjIvcysvL1ZYWEE4UjlLWThxVWR6dDkvSkZjajZVa0NIWGRJNEFVcmd3?=
 =?utf-8?B?cmY4dFJtVHdST0hiVmhFUXBNeXVBdGhMaEEzczVEU244djRIVXhFenhpNkkv?=
 =?utf-8?B?THY0UE5QUGtoWVBpZFltdUdOZkp3MkJOQU1jZTd5Vmw4RVhrTXJHVEwyOHI1?=
 =?utf-8?B?b3E2RnpPb2FQRjFjdVRuWU9QakVVTFUrb0xGWCtYMkdPRmZLaFR3UHhJZW5L?=
 =?utf-8?B?TkRnSDJtSzVxeDV0MUhhd3hINXliRkJNdmhjZzlESmQrOXR5akJmelZUUk9Q?=
 =?utf-8?B?MGRSbU1GSldXbVp1SjRzbFJOSFJKL2xJOGZrSEl4MldvbWhWc3UweUdNL3ZO?=
 =?utf-8?B?STV2cVdlSDZ1K0VXR2RndTJxcWpaV2t4eXorWVpBV0o0K3l0b0ZJUkt2K1NX?=
 =?utf-8?B?WG5GS1puWkdSa1B2NVVLQS91aUdJYW9XclNDZWwreElXUnljRGxLcGpsQnhC?=
 =?utf-8?B?a0pDYUZTTXZxUjNYcVBBajA3RTFTQkN3b2xUK05uMEowcWxXQ01zRkQ3VGdj?=
 =?utf-8?B?VnlCcGdtUFVQK1Nnb280VjFLT05udUNFZElJUldhM1IzRWsvYXZHdHlVb2Jm?=
 =?utf-8?B?UmVXV0djS052Rk90Ry9FcGtWOHY0MFgwenZTNWQzYnowbjRCdklEd3lFTHBQ?=
 =?utf-8?B?SmhUYUdTL0d2aVptR0NCaXVVcVJlRmtTZW1CSUVCMCtSOWRwZFBWRFlqWStt?=
 =?utf-8?B?d1dpWkh5UGZGSmxiOU4xaTZDSnFQallxSWJ3eXJzdnRBbWJLYkZPQ0FUUHBW?=
 =?utf-8?B?Q2N3N0paYklabW9JdzBqYVMxMlNwcVV0S3R5UEk2YVlqY3VJdzYwUGd2RGVL?=
 =?utf-8?B?bDNqYy9zVzhhMFhNc3JhVnhQZ3RoWWlYQXU0bjJaWkh4MnZCdW9WaGpwVU9I?=
 =?utf-8?Q?t5fE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6748.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDR5ZHJNbzh1SnJEaFlhWE9tOFdRZ3dCcGRRckRvdzhSUFhxUXNiM2I3czBJ?=
 =?utf-8?B?bXFpZWErS1ZvYXd5OVVaUS9oTThKRVVrK3lJSWt4WFFFYmNENzVkeHg4Y2JD?=
 =?utf-8?B?TllobjBKZWZ2bG9CVlhaY25GVXJaOFJKbXpOUkhHcWlEMThKcC9MUDVvYU5Y?=
 =?utf-8?B?bXlFaUJlN1o3SUVHQmx5Vk1rY2Y0ZmlYMXVVTktLWWlSWnczRjVUYUhaL1Jq?=
 =?utf-8?B?YmNhQkRzTEhCaWFSemtrNG42Q3kvZExCamcwMFg3di9zYVFDR3FNaTA1Q2tv?=
 =?utf-8?B?ejR6NzdFUjRMNDdaVVlPVy8wZk5vQU52ZUZDcUVPU1lPMlRySU1RYkJkMVVD?=
 =?utf-8?B?VktPSnZBWEZYMFIvWWR2eDc0aTAxVk9LaCs3Z1NPUG1UZ2JGb2hJbDFqbzdI?=
 =?utf-8?B?TWlyaTJqdWtCY2dLWUNtSzR6M0tSczlCS1BtcnhsSXp5TklBV1crS3NpTklz?=
 =?utf-8?B?U1RQZE1sN0h6cEE0ckJKR25ySkZxR0Y2THVoS04vZDMySFQyN2wwc3hLU2dS?=
 =?utf-8?B?bEJvREZlWnhKOHg5M2NGYno0TkQxU2Rpa203SGRKNDBQbXkyQUZBSHVuWGlT?=
 =?utf-8?B?MVFmdmNlZlZiVDdYcVJSUnMwTW9keXR6M3ozT3J2LzhGeHY0TkdUUU02OFBt?=
 =?utf-8?B?cU91WDZYSE96UVRUQldnTkhOK0hUQTh5Q0F4MkM3ak1rODVDM3VpSDN1SGtM?=
 =?utf-8?B?VEx2cEQ0QmVrTUx4dFc5VjIwNGxvZWJhcTBiWGRJY2dPemNwaE1uVmhjTkxo?=
 =?utf-8?B?cnZpUmZHWmhXTUhab2N4Y1RLZjhEankzNXFEYnlKWHgzblhQWWtBakxIcmJt?=
 =?utf-8?B?NE9VSzZOSnZsckw5MTZyNjJTKzBleXlpRVM2Z09MbUpiejJzcmRBYVlMTjU2?=
 =?utf-8?B?cUlPWFVIamc1Uk9CbHVJSFBCeGZsZ0hwU3Nhc2NSQStCV2NuY2lMSkVoamNJ?=
 =?utf-8?B?czJwQTVRNzEvMkFtUXI2WW1Qb1BlalFzVitaL0hGRWxKamlNNFRySnA3TDVU?=
 =?utf-8?B?R083WGg4cjlsVWpkSEUvTTNCZ3hKeU5mQ2JsOE1qTEFmVG00YVFQbjZZSUNZ?=
 =?utf-8?B?Y0tDUGdKOStmazBmMTFnN0dKVkJxVkc3emFvMWl6ZlFaUEZOcEp4YjFRb2xR?=
 =?utf-8?B?bmNoc0pOQUJwc1luWUdCZ281TlZTeVB5enBGa08rQnRISDVGYXUxUy9VeTZJ?=
 =?utf-8?B?R01vaDdDaTJnSFNCRE5RbHJYdFY4c1k1Y0M1MnhKbk5KbXM3bGRMTWcveDJy?=
 =?utf-8?B?N05IOCtvWTVTeEtpemJ4UVd5WS81TXY1eVRqRVZXcm1nSDU3QzE4ZEVteDls?=
 =?utf-8?B?dWllSG1vM3lQVDNyTVdEUTA4eUR0OTViNExSSjAxVnYvMWx0bStLQjVpOXh0?=
 =?utf-8?B?Y05yTkpabmExM3BCdk0vRktjbXVRdmJ6SklZTHJ3RlZoNnFaRG9HRmdMVy96?=
 =?utf-8?B?SGxFYUYzZjRHeVBkTHZhbGpueExVazk2RzZHdkx2SXJOd3BMNlZPVkhWVjZp?=
 =?utf-8?B?UThwRkMzVmFPTjUyRFEveGM3MjBUT2V4VjZWWGIrK3QralNGRlExQUNuOUp4?=
 =?utf-8?B?K2dsd1hVa0VqMkJQTEFJVm84aDNBL2g1T3JUTUFuZThiOE0zZnZSNWp4YlBh?=
 =?utf-8?B?TnltTkRVVHE2alUxbGtQMUxJV2hkSzRNWml1RHhoUVR5MGdPajVhY0pVdTJL?=
 =?utf-8?B?d095N0dtcm5naHloancvYStMN3pmNWZNb2VadlV4aUVlM3lXN2NydlFpQjV4?=
 =?utf-8?B?OGRFYmRER0ZhMWpUbnN5T3RKTjZhdS9GMDlQbXhiK3VQUEhZOXYyVGNwWFJh?=
 =?utf-8?B?eUN4VEVTU1l1czl5OGprNjdyMFhhMWFsSXlLbWJSRjE3djc1SUdQQXNGc0ZD?=
 =?utf-8?B?WTlmbzFzWld3WUNoM3EzUWZteEFnWFVvMWM2TUlMUXhYaW9CbWx0bkJkcnUz?=
 =?utf-8?B?ZXhyd09tbEhLYzlJeDRMNUhmeEV6L3c5UlJMTGtDc1RzVEJxbmdMcUcydjRI?=
 =?utf-8?B?d2JaNWxHSzB1ZXZrZXRsZFdQLzlvNG8zTTc2aHJIN256WEFxb0x4V1pVV0dz?=
 =?utf-8?B?L2RYZXNIU0lES09Zb1JiRzRvN3hKNjVwai8rc05kU2ljUFBaUzFCZG4wTGhy?=
 =?utf-8?B?NFpKa3JRdTgvRDByTytFaEV0RU5tSm5yN0k2T0xFZUV2WFZ6enZMaXFkUmZo?=
 =?utf-8?B?K1lHWjg3MCsyemdTdGR4L01KWUR6LzdyZ2ErbENrQzlOS1gvZlZpK3lZZlFI?=
 =?utf-8?B?bjFYQXp2YXlGMFNhL0RDZDhTTjdWSHRaZTcwbFgvT1AvN3JTT3V6Z0lEVDla?=
 =?utf-8?B?WnQzVlJvYTJHcFl0MEhmS25iY1hhZExmamF6RjlkdG1qT3dEVG9BZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfd2d80-4e07-48b9-ae89-08de664ad227
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 13:14:27.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roD2tcJgN5DQPtjuRAbi3tfjr6ABOja8gUWXHbhP0tvLUcJC72Sc8fVbzk5m6froq9QYmfEUy7Uu0B7D2Ma/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-257759-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5143D105F27
X-Rspamd-Action: no action

On 2/7/26 4:01 AM, Michael S. Tsirkin wrote:
> On Thu, Feb 05, 2026 at 06:43:28PM -0800, Jakub Kicinski wrote:
>> On Thu, 5 Feb 2026 16:46:55 -0600 Daniel Jurgens wrote:
>>> This series implements ethtool flow rules support for virtio_net using the
>>> virtio flow filter (FF) specification. The implementation allows users to
>>> configure packet filtering rules through ethtool commands, directing
>>> packets to specific receive queues, or dropping them based on various
>>> header fields.
>>
>> This is a 4th version of this you posted in as many days and it doesn't
>> even build. Please slow down. Please wait with v21 until after the merge
>> window. We have enough patches to sift thru still for v7.0.
> 
> v20 and no end in sight.
> Just looking at the amount of pain all this parsing is inflicting
> makes me worry. And wait until we need to begin worrying about
> maintaining UAPI stability.
> 
> It would be much nicer if drivers were out of the business of parsing
> fiddly structures.  Isn't there a way for more code in net core
> to deal with all this?

MST, you reviewed the spec that defined these data structures. If you
didn't want the driver to have parse data structures then suggesting
using the same format as the ethtool flow specs would have been a great
idea at that point. Or short of that padded and fixed size data
structures would also made things much cleaner.

I thought this series was close to done, so I was trying to address the
very non-deterministic AI review comments. It's been generating new
comments on things that had been there for many revisions, and running
it locally with the same model never reproduces the comments from the
online review.



