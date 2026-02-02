Return-Path: <netdev+bounces-255971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJReKMTjgGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:49:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1249BCFC3E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7826A304E6FD
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7B33876C6;
	Mon,  2 Feb 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKXTWI1b"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60D3876B9;
	Mon,  2 Feb 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054266; cv=fail; b=AdLD7BD5USKz5LtjIG+U6qi0lM56wbnSz/Jj1GqlX9OtkpBc4TJW+vEqKX5ffGFpuL8/tvn0fh3YQflQP6nA5GM6KK/55wVFu07eLW63TQchlO5tEFrCBApnQipFRt1Bj4muSXoLKaKYCZkxKu6lDICIYMxMlonSJq3hd74P430=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054266; c=relaxed/simple;
	bh=ci2U+5RICIRUNDEj8ckYBKdgdbD0aFWp+Tr/8CzkiHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D8nChHrzwq3IHE9iF/qifAfXKJCV87IgnmUMfjANQdNrMzOtxNXS6OG8zfV4EKKSy/GzpCfs8fB5faNwRC+eNxCyq1twQNX53fXfNcBpOJUgHY9MvJn6XaGpVXoM9pNw4h+VTy4d/YlqtTec7kSSB1fbVEgmSFlyOWJaiWl7ZTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rKXTWI1b; arc=fail smtp.client-ip=52.101.193.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhSFGZrjM4slhJ97ohEkz7yLi7rccVa5hkHnFgnNB4uB8SqOkT/juGwZ6CjsDNwAaj7Wed/MjHSdQ2bLZPpJZsevrdB1XzrO6SuiBLmdL5+IqinHQ/pn0X2TQ0cD8gNJcGztJ3qTTrQki8UGdWOPAYBOXXzl3cvDKQEAPc560HUz+z2DfQZgcOK/CHOTIjMpK4DvtBfXJPeozt0restfJlKLTSc41J3dNApuFnlQDOgDFVUe8rTaTVOjBPL64r4RwyUnxjW+KHh7snUixnjKuMSbImK6eoZSL5ZmPQvdOcMZIDlc8x1ATPjpi0VJRazZPft5hGZoZT6xpUxQPupjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN8pZ61FnwFRvwwP0wTMUxmcMc9Jitwl61UjjVMuxzA=;
 b=QwE9tt4Rtl73wql4vjOl2qfmV6eZq5EeILTWcAXu+0qjNastzz3Y/xft8Tk8zuyKovLibhIgt+j5CSN8NaubJ/KmudaZHHFB3hqWxndqluuAioTONZzKDYgmP/xpPmXGg5WZ93cU0tSv06Njpk9gcG6TkliTakYZA7QW8SIo3dOdNXRUNfl1p2bxWHu1Xim/PLMSZNEl/PJLNkj8xYy4cdKk3U+/vUGyN+YdtZXrol7BUazxMNu/lJz5Jh4oFXwbHu7l7eTvRX+13iXyndHdPIZGpIvZGmTaA+Ym8fp4eJNhGq+0v/PSciwtTkcQZeVYAx/7YOyeT/jzbtT7PK5BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN8pZ61FnwFRvwwP0wTMUxmcMc9Jitwl61UjjVMuxzA=;
 b=rKXTWI1bp2ojWFCWFTHy8Ho+J5WR+GF/WbOpzKuolLHvhTSJ4kurosuJJcEhcDRGWsjHutDvopAYysNcctfRVAKgULTefUPvKNYdHJoYeR5mlmVnFMXdEL6PItmzlRAUjkYnaUu+l6vggtw5uQSlAFHDVWhcJKuUBebQXXsinPJt4S0l8Kr0rmZfgSspRWwcsYCgMqAUrFLrA2HCW13P/s6B3X4U/Zn3Zh/bIKxrH6ucW5lm3iYtsePHPUttG7XKDJ4K5sGENTKCRp1Quukkx5E8rVTVMR9NZQ5qVoVQpGwj8EjF3fPxpXyKmgBdICWgX2TlvNP29FZ2kh9oTLgDzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:44:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9564.013; Mon, 2 Feb 2026
 17:44:21 +0000
Date: Mon, 2 Feb 2026 19:44:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Corvaglia <david@corvaglia.dev>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: bridge: use sysfs_emit instead of
 sprintf
Message-ID: <20260202174409.GA127339@shredder>
References: <0100019c1d2d46e0-a083f912-ac82-47e8-8cbb-ac9d70355ed3-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0100019c1d2d46e0-a083f912-ac82-47e8-8cbb-ac9d70355ed3-000000@email.amazonses.com>
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8d66ed-905f-4413-b100-08de6282b272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXFxdXJrYUFkRmRjVjh1MmFUMGcyKzZEZ0ZzT3lEWWF2cGlFeEVBQmw1U1N2?=
 =?utf-8?B?SGtXQXN5VDVpYjMyOERRUVdVdjZLMEZ1cnlIdTVOWHBLUEh5SVJrTTVQdFFr?=
 =?utf-8?B?b1drRno5R2xteExUSTVrT243eUhkcW1LSk5uL0gxV25JNmEzVXZzSmdLUm4w?=
 =?utf-8?B?b1pmTGRsUHVHVlFqRjFvY01PbVE2a21Yb2phM2R5bzVRYjNIeGpEbjhjbWFM?=
 =?utf-8?B?N0Qybis4QklqT204TVRHWjIyLzNtbkZjbHp4bkEyTUltNUh1b2p0OFVQaGU0?=
 =?utf-8?B?ejZLV1FGV0hCTUpKSnRXbkMzQUlVUEZUZDdPdldFeHZkTi8rRFp5K3NpMUFh?=
 =?utf-8?B?eG5yZlBTbXVnZnJBUEtodkQ1TnRWcy9lT2RNQVhtajE5THR2c2VxNUhKcVFl?=
 =?utf-8?B?bVdqdlE2S0IrNitwQ0J4NTN4THdDc3Q0Qm5BbnF1dXBkK3hZalJibVVqOUlu?=
 =?utf-8?B?Wnh0ZlJNWEUrWTFXOGVSYUg1R1d6SzdZQ0RaNlhuRzd3YTRhbjA0anVDV0RI?=
 =?utf-8?B?cWZ0MGNvM1MvODQzT1hCMWdaZm9VN3NIaXQ2ZDRudDJ1Q2Q0dmY3R3dRaVIw?=
 =?utf-8?B?U3FDc2FaUzRaZThkRVBWY3lUelFBZWZvcVJ2ODJoY2ErRGR6YlhqYnJ0TmFB?=
 =?utf-8?B?WE1xMWg1OGh3RjgvWXVrWUduWUErU1BNbkdHZG9zNFdQajdMU2ZVTnlaUTdZ?=
 =?utf-8?B?OXdPbGFsZnRVVG5zSkd4UElPbC9YeUw0TlBiRDUxRXJSbmhxQTRvSzU0ZVpa?=
 =?utf-8?B?MHlsTmFmdW5nTWMxRm1WTVEySW5vMFkyQ2dHV0drV2Z5bkpyQkkrS2Y0Y0hM?=
 =?utf-8?B?REF2VVYySVBEWnM5amtkUnl4Wk83SjQ0TGUvRkI1ZThydDhRYk16ZUk4ek5T?=
 =?utf-8?B?dDR6Q0V3dFYrUFdRcitaREpuNnpyMjQ4bEEzb1g4K1RTRFE5My9oejZQb1Bv?=
 =?utf-8?B?bzhBdktxRW5OVjNQSTR5SU9KMDBCR2tidStENG5URktjTmtXd0VscTZhblEx?=
 =?utf-8?B?VjVVT0FlT1d0SkpuYXdCakRSR3pIeGltNVd4MkhkTVNFVitteW1KU0tKMDU0?=
 =?utf-8?B?RkRuK1BHciticSt6WEovU1ZaMUVZeHlaREtUS3Z1WXBDUjRHc3JrREhFUzd3?=
 =?utf-8?B?c0dNSjQ4UjJEZnFiKzZFNXlpRWdkSElBRTdjakpPUVQxZkcweExCU2JzaTUr?=
 =?utf-8?B?TnA2WlhCVEdIeDFGdUpZK2hTWVdnano1WGJxSFBZSkNqUFZrWWpIS1BzWHRa?=
 =?utf-8?B?djM1UG5qWWVjcTl6OGhHOU9TNVJZeTJ6STRQYURSZzhIQisrSkc4TVpsd1pJ?=
 =?utf-8?B?RG1TSEZ4WGpPd2JOV2dKeXBGTGh2TExrbzRIY0gxVllVZ091TU90cit3T1py?=
 =?utf-8?B?SFk5N0NMRHMwZ0NDTWtCcnYzNWZWQzkzNmd3WDlVNGtLL1dmTUpxK0FxZDRr?=
 =?utf-8?B?ZFB5VHBrQVlOQThBRlpKQmwyOXBra2lLQ09ZRGNUY0tGZTBsUkp0dnlXcHZm?=
 =?utf-8?B?NnF2a3VyLzJBTDBWTk9iY0FZY2tCY2RLblpIKytDbk9aSXNwZzR2WUtmZk1o?=
 =?utf-8?B?enpvSS9xUDBEYmRTUWJMa1Rnd3lsZ2xZUWw0bkZNOWRobzRpMlhDenY1bXpp?=
 =?utf-8?B?eGxqbDVLb0Zmb0EzVTYxMC90UmIvOEtLRjBFYWRKNElBeVJieXNnWDZsVDQy?=
 =?utf-8?B?WGZXWmlmS1RIUjRQTFpOUFdVYmZDUXRQQ2lMVjZ0U1JIbnp6MlJ5Q0M1RWRQ?=
 =?utf-8?B?M2VNYWU3Mi9RcVIza2YrcS9SRWFlZ2IxT2xkVGl3VFQ4Y1NvYmVxZEQvS1BF?=
 =?utf-8?B?ZytwR2h5L0hzV21YVE5VdHpxNlMxTkRhV1hjcnNGYWd3eW81MTNiNm94YU1E?=
 =?utf-8?B?Mk81MWRWdk0wZ0hxYi9LR1NzaHBlMnBTd0EydEZicndTalNWMjJPVHN5YlhH?=
 =?utf-8?B?MU5mRjlWVnM0amlTeXFpa3h2WG1HR2Fsbk01bFUzemtqMkN1R3o3OFpqbHkz?=
 =?utf-8?B?VFZuYlNydS9jQy9OWHlpR0JOMGNnODNRY3BFejkwQlRrQ0hZakhmYldhMXN1?=
 =?utf-8?B?REpyd2N6Q0lsSVlhdWlsNnVrNmZuTzNtZjV4SDVSb0g0NkVjNXNpakwvTEgy?=
 =?utf-8?Q?BdYE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXQvMk5XblFKUEJaYVByb3NvVDhuVXJNV0NOc1JWUlpYRE1QV0tHMHo0dDR5?=
 =?utf-8?B?SnY1aHpkU1JpbWlJakE5Rjl4bzRUR1krbSs0TFF4OVVSM2J1VUcxZjMxQkZh?=
 =?utf-8?B?dy9reWtWWWpub1lKUnRWMGlpa284ZlIvcWtEVDd4SkNRQTBYaklCc052RFhT?=
 =?utf-8?B?YzE2QVBIcVFDOXhSWWR0SURDK2tzYnc1bExmSGRNT3RvZ204VFVSRnB3MVBw?=
 =?utf-8?B?RGRWR2RyNXMyYXFzOVFienhZWnhINTJLbjEvR01uTHJSMHBBYS9STjJPNlRp?=
 =?utf-8?B?M2ZVeXN2TStJM1A2SEU3RExzWUFKVUc2a2NNQWI2aXpLc1dpeE5nWkJ0cXFu?=
 =?utf-8?B?VTREcS9TbDk5UlV6dHVrUk5IdG1DQ3Vtak9RRVVjMmlTdnZNN0lURXY5MnU5?=
 =?utf-8?B?akg0TTUwODRQZzd3ZS81bEgvZHpHQ0F5V1pKTkhzQ2lVU1g2TjZTdWltMXhy?=
 =?utf-8?B?QXVFRnJoQWZCR3d1Vk15SExLQnFHYXFDVXMvQjRhREJtdGZhL3ZMVnoycVRZ?=
 =?utf-8?B?ZDloTHpYbWZOOFFZUFZQd2xnSzNaK0xEWHVHWUxsQmNjdkVYc01zTS9Fbkxn?=
 =?utf-8?B?U0RYb3o4RWYxWFlCV0tIZkxtNTU0M1VqSXBaeEVEcmNLenZPaFdCNmZSbDVU?=
 =?utf-8?B?OWhkSmNWRC9mbGZnYTFITU1ZQk1KS2czbDVMYm5wRWNRS3UwTzV1bE1tV25l?=
 =?utf-8?B?WWFKbjhtc09wUHVvRVhkSGZSM0Erc3ZBTXBQaDVSSEtQVzhqeFRGYUNTWUpr?=
 =?utf-8?B?QkxSMW5OWWZoaHlFVnR5MVJnNTdJU3Zrbnd0RTZKRUdSVTdCL3o2c2lxQWt2?=
 =?utf-8?B?M25LdVdBb3Y1SVdpUG5zbEplZ0xaaW84Vmc4QjEzY1lRN2JlR3B1L0dQaXFT?=
 =?utf-8?B?cHFzTE43ajJ1Z1A1V0greDdxN1JIUmtwazhzQUhJa3hnQmdnVHVSZXI3TEJ6?=
 =?utf-8?B?dzFOd1U1c1kzMVllMlVGNFhGUW1qaGdWRVZhbEYvV3g4NzgrWWk4VjFMaFVY?=
 =?utf-8?B?RnZRSkNXV3QrUWdlYjFkV2tuZEhuc0l2TzVKNHN1ak10VGRMWUJoNVZ3Y25S?=
 =?utf-8?B?bnN6NFhsV0FiR0RnWDVYZFV4cVR0WWNjOGhTdXlsaTNIMFpkZzRNUnZYMUZG?=
 =?utf-8?B?a2xnOG5IaXJZU0NQY3BuZjNTWmllcEVvZURTT3Vjb2J1VnRNTUVJQURSVTJ3?=
 =?utf-8?B?QXVoWjY0cksrRUphK05kWldtZjliejl0N1dJeXB4Zm8zd1hjNTF2R0lueWdW?=
 =?utf-8?B?WEhtQk4vbkI0VVlibmRNYXlKelRUbmM3eHB6UThaNllScXJCT2x2Y2NsSW5m?=
 =?utf-8?B?UHZyeld2TURQMEpWNmRLN2twWXJ5NzNYSkJvUnUwU1grMXNqSzMvejFBV3l0?=
 =?utf-8?B?OVozSEM3dGRxSitoSzJMVk5Qc01lRmVjdlBNaTltZk4vMy9LdDE2dUxKNjVv?=
 =?utf-8?B?cE1PL1JLb0V2bDJvcCs0MzN5OEI0dzdoUGV6VURsUWJLWTBUZHBRVmRHU3ZS?=
 =?utf-8?B?TDU5dE53ZzQ5cU5VcENYVXg4N3hxUUdadUN2Wk9XU1R6Wi9jN3o1dnZuWDJk?=
 =?utf-8?B?alFyQmU1SWJRbUpHeTF0YVNNSDdvQ281N090MktLQ2pPUlYzcnc4eHJYMGZo?=
 =?utf-8?B?ODR1MUd5Znh2Mm1GQ09Gdmo4dzJLbitDVjd3Q1NNSS9jUW93Q1pHUGZEN2Zz?=
 =?utf-8?B?clZhS0NiZWN5cStFWUt1eDYzdDBSMForY0lRb2lNTVd1dlV4c3AyY0dHMUFq?=
 =?utf-8?B?a3VPUHJtdWs3d2VocGlZOTFJSmtvQXA2YURsMjRtNlgxb1RjaEtONE1CdTdU?=
 =?utf-8?B?cHhoZFpVMnJWc0ZwVTd2ZENhcHpjM1RmRGJOUlV1bSt5Tlg1UWxIRzd0bWtz?=
 =?utf-8?B?aldoL0l6STl1WUhBSzJucnV5Vm4yZlJVZy8zVTVQT0NRQStpRy9uVFF0S0xS?=
 =?utf-8?B?Y0o1M3hJQWxxbFZuZ1ZGdXJRcHF2c3lVby8yb3lwOEcyZlhtY2UzVFczMVl1?=
 =?utf-8?B?WXBPc1BibG14T3U2eThzVmJvQUFCWEhMWnhoUFlwOXl6d3poa2pIVUNuRkFI?=
 =?utf-8?B?QlFPTjhMSk1URS9nT3pQYk55dkFRdjZBOGd5dXFPZ3ZORllwSk5LNnEwVDJl?=
 =?utf-8?B?aktmVmxlbU9iaGdQZnpBSzEzb2pXQXpWdndrSHZCTHppYmlnaEJ3L2xYV1po?=
 =?utf-8?B?dnE3aUVUNHp4WVREMHBKSll2UlowWGRNbHU0Y2RneHh4Z2hjVlBiRnJ6ZWRu?=
 =?utf-8?B?U3crdnczQ2NJdWtsenR2ZGNIa3BhdEJlS0tCOG9YMXJEcjZWZVZLZkVwNHpz?=
 =?utf-8?Q?i2ujhx5Z6kZgZQMlr7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8d66ed-905f-4413-b100-08de6282b272
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:44:21.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTPt3QUCAP0j2W27XtGk8aDsAwftjNu1nybjAstYcWWpQN/VVZ2WHc1jbCIji+8TtnIb1Zbkbiyb7lr3sRgnpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255971-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazonses.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1249BCFC3E
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:07:12AM +0000, David Corvaglia wrote:
> @@ -677,9 +677,8 @@ static ssize_t multicast_query_response_interval_show(
>  	struct device *d, struct device_attribute *attr, char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(
> -		buf, "%lu\n",
> -		jiffies_to_clock_t(br->multicast_ctx.multicast_query_response_interval));
> +	return sysfs_emit(buf, "%lu\n",
> +		          jiffies_to_clock_t(br->multicast_ctx.multicast_query_response_interval));
>  }

I get:

$ b4 shazam -k 0100019c1d2d46e0-a083f912-ac82-47e8-8cbb-ac9d70355ed3-000000@email.amazonses.com
[...]
    ● checkpatch.pl: 392: ERROR: code indent should use tabs where possible
[...]

$ scripts/checkpatch.pl -g HEAD
ERROR: code indent should use tabs where possible
#332: FILE: net/bridge/br_sysfs_br.c:681:
+^I^I          jiffies_to_clock_t(br->multicast_ctx.multicast_query_response_interval));$

total: 1 errors, 0 warnings, 0 checks, 495 lines checked

