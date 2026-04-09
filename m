Return-Path: <netdev+bounces-276779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOYZA1AM12npKggAu9opvQ
	(envelope-from <netdev+bounces-276779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:17:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B748D3C5783
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2299F300B59A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278F36405F;
	Thu,  9 Apr 2026 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hfQ9YXj5"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010078.outbound.protection.outlook.com [52.103.66.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A231F98E;
	Thu,  9 Apr 2026 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701068; cv=fail; b=gWqDxiu0gk+1IcU/mukhciCdIoV3hiFhNAKEreSYJ/YqiW/OBIKbXFQcWYuQtlaCfq9AmblSfeAxReWEHEYCX9jtfoRSx2uSWFp2ZevvpYxqpyQZi84HKHamQrTvCuW9BWSd/HeKpZ9YHSyLwGLWVWDAN2FIerEqIk3/nLNecpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701068; c=relaxed/simple;
	bh=949hURPSBrqmYA3XqTjooo2NegsG5dRIYQPVBZyCoJo=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqBK4OjM+v4Y+etfgCaZ2SV6eaKyWN8J90tq8ea32YXMyVyGTOEbcLb9xsDzO8pnRMpWfwbCauuWBvmeRePJE0r2CbHJX3lXB1l64PO5n+SSwwCeO7Y5Kc9xV24otmG2+IzcNd4HUrIpSc6xKaPB8YwvmFwZOnQA0rKgy/TceMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hfQ9YXj5; arc=fail smtp.client-ip=52.103.66.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb/V9AFID0wTEoqGR8MzdM3QMie354W9mdDNkozbNxdTiR60Wglh/G+x/Jni1LZB220lTh5h5ceCq5e89lMGyJ25nHGjk+ycGKbhSBN/GWZ/Mkgq3Oc5p8pjXh0aWQZU6mj/mgt0l3qY4tS8ZJtmFiOid5ElOqZw2juPPUmsU+OVTTW+H2ok1udzH6v8nB3XK2dSVWyws/eUtnzlKHk1Ys4YuC8Yqi5+pXh/ut0EtLrfd6v8Zvt7Y6MBKzZpDH2bbdM1Ixdw+A9PT9VyTzjIq2xxcxgUsmNr0DtA0h9cvxERBO6mC2QhVy2wArCAWn8LxhIT0JVXMwPJt8nvmHaVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf52THD+j1vzVOWv/Zx5XZLTmee2yQoFob2fEumg778=;
 b=vGD/p3AjdrQh1WbI/tE4d0qP7CGRdGADE2FcyJITUH6m9+lsKs10PaDEBMCs+irhuKVUqhs51NQl4DspQ+uUFB5tKkX/S02asdKBFnu9+dVM6YNWnJBPNMLU5ujXay1VwoFqOTQFtQef5dBUe54I6vTd9LVO0eM3fYwnDYxcwldV+gJFTFo8ve0fHk7jVMQw2jhr7gI13IEEWDCbfETRX1ZwlpbMezYxsNKhYTAgqNRb8GJlWJadaEbIl+lr45lLR6MKw8a/MGKEbUOAlWKGqqiJB3qNI18jtW3cG/LkcKoIo66YciGNGMob0T/xwe6fM7PXFJMsa1JEV2BdnnvwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf52THD+j1vzVOWv/Zx5XZLTmee2yQoFob2fEumg778=;
 b=hfQ9YXj52kaxhf9GGd0q2e6RPckd8z/cfNWg6ZCczuRTONe/NwwLkUQuyl8UT9BeysvTjBqO7f07MWjfzZHgCA25wXKywjzZasuPtE0FOTElLF4uCkGM7FuLk/rbvz2URItAmu1djH7sgmlzEJlQ3qub4FQOIvwABlA0kPVRN7+caA9lWFvZ2tzbYjMdyF0Lkpa8nLzMRBoKY0tiE3JCbztsh5JdE8o2NZiBPVxRGVpK5VrgvMlJYAqGQf9odDl6qPlk4cUZwfHihyC+iTwo7biAZVGD2mF6WOhhNJjwABD620Sp5tTK8ctZ+K4L8FVYbsFBDkBIBtKRzNxA//VepQ==
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11) by TY1PR01MB10705.jpnprd01.prod.outlook.com
 (2603:1096:400:326::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 02:17:43 +0000
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e]) by TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 02:17:43 +0000
Message-ID:
 <TYRPR01MB126660375EC4CE2A020044494CA582@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Date: Thu, 9 Apr 2026 10:17:36 +0800
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
From: Xavier HSINYUAN <XavierHsinyuan@outlook.com>
Subject: Re: [RFC net-next 15/15] Documentation: networking: add ipxlat
 translator guide
To: =?UTF-8?Q?Daniel_Gr=C3=B6ber?= <dxld@darkboxed.org>
Cc: ralf@mandelbit.com, antonio@mandelbit.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
References: <20260319151230.655687-16-ralf@mandelbit.com>
 <TYRPR01MB12666EEA0B8007166ED446088CA5DA@TYRPR01MB12666.jpnprd01.prod.outlook.com>
 <fldksy7obiaonlcxrjcbnfkfmaup27t3fq3ktubd7sx35fsswx@hjmchh6sr7rw>
In-Reply-To: <fldksy7obiaonlcxrjcbnfkfmaup27t3fq3ktubd7sx35fsswx@hjmchh6sr7rw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0042.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::7) To TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11)
X-Microsoft-Original-Message-ID:
 <990fce63-5d18-4938-b4bb-88a17d261373@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB12666:EE_|TY1PR01MB10705:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b01ad74-17f0-46e1-8c0f-08de95de2e5f
X-MS-Exchange-SLBlob-MailProps:
	P1EfU6pZOd8VPwDsmXmpSwyPl9aRR8R+ll1Y/yAkXfLqb7XpFT9gDs0qSsTfMJR+bnyyk2KYfMYHnLq/2WzRt5FhJ3qmlkcYZPLSmmdll9X5j0uqLKn42fNQZ3GxYk5aB6wbVwhzWLBpnFDlYn/5zUlzPfj8i1Mnwlw3U/9W8sjJD8pD2Y3IZuJwfNzWvNvfyra44u4AWSl/ufx+JuDoZPfoaok+my+JwdQSJ16q9rF9IeD7rtVE3SS06JOLapY6DNHOD1XA3LKI1LNNh0tuxMLMyhE4J9PNJ2nNm7SCxOVm9mJONt6tH3FPo1AJ+LaS0LUBrstXtJezS0hhgFvOKdFARZiiO+cwZu2edgTidR5SyNHYq0in1FBtiLa8j9BNNaYxoj871Ooj0+Nt/dV+y/1XKrOSK1pUbUEsm4Nq1Tb2vvydQHfbH6foNWMXrTQ4LvDppHOffpD3ihB0V2gsYFs+IH5Co82mKPFo3CvAQDLT+lH5Uo4ihHL7fBBtr/g4tXXcfot6U1owllYnFZxNsEhCfd+yiuYMQlxOkWIaKNrupfcQvhp3qLbU/uDwBsqvPh94ehNAfgj1RJkLKElHbh1kqTjWjbsFlwF3JXRMrnuhBkS+2pBZ2aShovYQWLCjK8Q8OysM+IIXugpYTmjdeDx8bbJzRaDZ0my0ou08oaoqSHvOdDHKzz7BxNJrnw9ntLq10tAsF7mbyYAm7bDzXQf8f0JzkrWl6FUvmHIM4l6RvFs74fgr2k4l3WBW1ipTav9edZC8JaoCY8liwID8aXMVUhg9K7xnke3UMajgeARCeImUnPfuBw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|25031999004|51005399006|6090799003|461199028|15080799012|5072599009|8060799015|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVNPMmhsY2VZY0EwWWhaU2NHeUdTMzhvQ1lFS3ArV0VnWjlndllQczFpaTZv?=
 =?utf-8?B?WC8rcUhVQ2xtV2FZQkVYeUtCUDdQRjhFS0h3WE9aRHNKUlZPUWRPckc0S0dB?=
 =?utf-8?B?Ni94QkpFdkV2ZnVNWDRMUDhGZFBreW16THVFM2NjQU91TnB0YXBmVHBYU09l?=
 =?utf-8?B?ZGlOQW1sYkhhNUpuemhkanBacCt5YzZrb0lJblNYN0F6SmZxSVNTamdZUGNt?=
 =?utf-8?B?MGhsZXpVRVpxRkJ5T3F6SnByQ0ZJaVdpdjhiSXp0d3JMcDM5VXBLUy9BT09n?=
 =?utf-8?B?WHZpYnVrQkorL3haTjRTS0kwbStmTWxoclBSTWhhQ29KYitGUUZ5ZWhHUlg2?=
 =?utf-8?B?VHpvVkhQb0tmM0JnSHNhb1lYZ1R2Y1RtQ0tOY0kwMWxQejJmZnNsL2lyKzEw?=
 =?utf-8?B?Qkt0bjhnZ1FpRUVSY2x3NDNiUFhHc05hWTEyaWZpeGF0UDVWUVJYVmlkVDRQ?=
 =?utf-8?B?TUp3ZC9FUGRlWGVJdVk2MThPbzJwUXFXK25RdERhUVhzRHJINlF3OWJtdElu?=
 =?utf-8?B?VEswZmRocUJKU0lnTXdwVDZHWjlnNmd4amt5d1lLQ3hZSGhpOHdNTkRIeitz?=
 =?utf-8?B?VkVBWG9qNzhJd1hyeFVNOFlHV0FrMUVpR2Vod0JBZHNQMkpCNlFCblVWU1BO?=
 =?utf-8?B?ZWVBUTVZOWduYXZqTlZwZGY5T09mOWk2ZG5XZE56QnZZWjRQTmZ2N2dIa1V6?=
 =?utf-8?B?S2taaHNyN0EzdjJtcm9qNUZWejMxR1FHL2pwVi9aSTVEMGtIYXcwZFlxRTZK?=
 =?utf-8?B?TnRRenplVE5ZdzZEOEtDNzRkYmNUd0Jnako4RU45MFhsOUZYeDZzdVd0VVFD?=
 =?utf-8?B?UllHSkNJT1Zad2VtQ3dLc1dTSjVzWmtkMXhDOGNYakNMaGNCaW90UFBnZ1F0?=
 =?utf-8?B?a2UwSXJBYk8ybXo5R0R1OHF0M1hXZjFINGhuS1R6UThrVkxCOC9Pc2xMSUdQ?=
 =?utf-8?B?TjlUNThGQlJjMDU5MFBuaTdsUDg4QXFMeU9UclN0b2dlWkdRM3lQQ0VKM3Vt?=
 =?utf-8?B?ZEhyNjVqTjMzdkxySEtRUkRyb01JS3VyQlQzUDlLbmNhV285UTV1UzAydkNU?=
 =?utf-8?B?S3lSdXgvNTdaVDFpT1UvbFdsWE1rVkNteTlGemdwcU1LZTRSRlFKME5JNEFJ?=
 =?utf-8?B?ZFF6SXVvVmZtd2xFT24yMU5ma2xRQVhXM0s4TXlEaVV4NWxpVldjZWQxalFW?=
 =?utf-8?B?dE1YWTU4NDBtb0hMRng1VUdySlFHSnU0aGdZRlB0U05oNXR4SkFZQ3dnNllE?=
 =?utf-8?B?djhHRFM0bitYQXUybnNLeDFlT3VzbzR5eVNPSVhSVmk2RmdsT2FnSVdyVkxs?=
 =?utf-8?B?L0VwYTZiNHo3d2RrWG9iRjNjTVRHNXBKa1ZUREdncE01TTJCQzg3Rll5MFNG?=
 =?utf-8?B?N2orTU16SDRiSVErRENLMzdWOWJoR1NFVUdVSlovTkhYQlFmTVIvbm9QTHdm?=
 =?utf-8?B?OWpzOTBqdVl6OE5vZ20vdG9oWGEvMXVLdEJDN1RFNjlwQ3ZXeHNhd0J2K3NV?=
 =?utf-8?Q?XlmMyviqdN8zPugGEgEJdmMySpg?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aExMMkhrdGpqdEZFbVBiRjVIaEZhVHBuZnFvNGpudjcrTHBsNUEzbmMzYWVX?=
 =?utf-8?B?OUZkRDcrdyswdzFpYVZSQnczaStsYzFyazZjb1hCNzFxeW9ZbjFMNWcwdlpS?=
 =?utf-8?B?cmIzcTVBY0FNRWgxV3FwU1F4SmhRczZvS2V1Ukd5WnU2MVhzWGpDVmJZK0Fr?=
 =?utf-8?B?bWN4OVRpVWI0a2Q3b1UwS1ErMDBTRk96eEJPS2hKK3h0VmUxOFdQT2JiSUsy?=
 =?utf-8?B?a1YyaWcwQmhzMmZ0emhGNVh3QSs3MGVjN1dpZzFxek5wS1JCS3Rjd1gvcWlT?=
 =?utf-8?B?eGFLZjJ5M1ltVDIxNHBPb01nMHJMV2JCZExXOEV3Y3E3RUIzTldDWnNHRTFV?=
 =?utf-8?B?d2pIanZxaUZ5Wi9CVUw0bDBlM3MySXMzckxYYmRuMjVROXQzU3pPK3d4b281?=
 =?utf-8?B?VDBXcDk0SzNRSmJmdzZGQnlHM0FqRVFTUGVETHlXSG1VTnIvZjRid3VoLzBo?=
 =?utf-8?B?SFlEN2hOajhxSzN5cnYrdDZHemZOSXNwdXpDNlk2NFFZRFpLN1NXWEtBTzRE?=
 =?utf-8?B?Y2tacG1INW5ydXgvd2xnbHljdnBPVTNwa2pYbWZGYmE1QWZic1ExVm54anpt?=
 =?utf-8?B?T1RRdWlMVEVseUhNUCswYXFkYnBkY2lNV1U0NkhiMzEwWTJLUVdqeFk3dElC?=
 =?utf-8?B?M2NOZVpJU2w0eWdLVE43ak1EMG41dFR0L2loQ1pmclh6V1hFem1lQ3R2TWRY?=
 =?utf-8?B?T3YwRU9IdXJML0crTjZzMVlDYk42dzBYeXZDZ1didm1RcVhWQVM0RjdxSmtH?=
 =?utf-8?B?UVE2bE9ZVlpINFMwdlgzcTg0eGRxT3RrUEZGVTRDNklxN1dNaVZrS1ZRZVcy?=
 =?utf-8?B?SkxSR3B4dy9LQ3Mra01SVWV5UFFXcXFObGQzYUFGYTdyRTZXV0dSRVY4SU5n?=
 =?utf-8?B?S1d2R0RpWjNEcVA5Y0l1eFYrVnNpeEtkZFBLZVZTRDN4RVpFUnFZRFdOTDRN?=
 =?utf-8?B?YjlOdGYwdXU4K3NNeVJzYWJnd2VyamtzWld4aDBlOEcxM1MvVGdQZndPY3g4?=
 =?utf-8?B?WnZDT3JqamJ5QWNsUzRYMHJXRVJtM3pRc0NmRkN0NURvbWkvOXFhaE9SUlp0?=
 =?utf-8?B?ZXpHRW9Ld3FQWUdFaWRjeGtjWEhOL20rUk9qVi8rWExtZFNIOHh2dGh2OWlZ?=
 =?utf-8?B?UjZ6S0YwOFFPNEpxRHduQVV6TWhFalczenlmSC9lTFFRRVBXcHlKa05yY2hq?=
 =?utf-8?B?ZEtwQkcwOWJZV2lrRjZ4Smc5M3p1R05rUEk3Uk9QUzNxSmIrc1Nsek16dDVa?=
 =?utf-8?B?OWZyejlBMFhGWkpNQkU1VHhtSWlOcHpNNWNOWFpMbzZwbGVsMVNUTDM2OGNO?=
 =?utf-8?B?UDNiSHFYc1lFRUo5U09aWWs2QTlRelVabkZkRXYzSjc5VnFKYzM0OUNWMFZF?=
 =?utf-8?B?R2RHUVowYkE5VHNQQnU4c0VyOVdDc1NiNUowa3FyS0E3V3R1UFU5eXBlWUdO?=
 =?utf-8?B?RWNRMENHUFpUT0gyd0FPR1VNM2tvQXdKeHZLRitHbVNaTnlJQWRxS2xvTDNi?=
 =?utf-8?B?Rno3dE8zR0IxRHV6OHl2TkJqWU9GRVduclFxY2k0L1RTTHJjdEFaTXZydTZU?=
 =?utf-8?B?V1FjZmxjZXB4RTRTS2Z3WDlIcHdnbFpYdUtJRUxsQm10c2NrSkhCV0hoMUdk?=
 =?utf-8?B?UE84L2NqSjI4a0taSTMxcG5iYW5kcnhic2NNTi8rNzJ0dXhXYlRiWGpJMGsy?=
 =?utf-8?B?UzFWaEVmOFV5U00xZVk0NG9qU1F6SW91WFhxL0ZPNGhnejkxVmE1NXFDOHBR?=
 =?utf-8?B?MUxRVEtLbjhUaG9oS3prVVdZZ3FkNENMMFRkOGVsQktsTFRLYjlMTEpLbFpR?=
 =?utf-8?B?dDBlc0RmNmlEU1FDSjJVUXRaalhuUXVsZjdMeUdTRzB6ZWkwV2lIcDM1bEw2?=
 =?utf-8?B?eG5xQ3ZDNUpSbU5vdElPekJZMExvOUVNMDdsNXhMOEpLZk1Ub294Y3BVeTM1?=
 =?utf-8?B?YnNnSWFDcFp6WFMwZ044OEd4UUFyZ3ZkN1EvangzcDNxNm1ZZ0pRUjNEUGx4?=
 =?utf-8?B?LzNPRFI4TGlRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b01ad74-17f0-46e1-8c0f-08de95de2e5f
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12666.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 02:17:42.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10705
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[XavierHsinyuan@outlook.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,TYRPR01MB12666.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: B748D3C5783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

> Indeed, the JSON is just wrong and --do dev-set is missing. However
> `--family ipxlat` works for me and looking at the code is basically the
> same as specifying --spec.
> 
> Could you try this:
>
>    $ JSON='{"ifindex": '"$IID"', "config": {"xlat-prefix6": { "prefix": "'$ADDR_HEX'", "prefix-len": 96}}}'
>    $ ./tools/net/ynl/pyynl/cli.py --family ipxlat --do dev-set --json "$JSON"
This looks good to me now. `--family ipxlat` is fine with me if this runs
from the source tree.

> I worry once we start with that we're really just re-stating what's already
> extensively documented in the RFCs.
> 
> How about a reference to RFC 7915 Appendix A? This has a full bidirectional
> end-to-end example of how translation operates:
> https://datatracker.ietf.org/doc/html/rfc7915#appendix-A
>
> Admittedly using a /96 prefix (which the appendix doesn't) would make it
> easier to grok whats going on. Not sure that's reason enough to get into
> more detailed examples here.

A reference to RFC 7915 Appendix A sounds good to me. Still, a short /96
mapping example would help readers quickly see how the translation works
before reading the full RFC, and would make the following NAT64 section
easier to follow as well.

Best regards,
Xavier

