Return-Path: <netdev+bounces-217160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96405B37A0F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACBF1B62B25
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0341430DD22;
	Wed, 27 Aug 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="TGoHyu29";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="jHNcqVyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8860283FF7;
	Wed, 27 Aug 2025 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274277; cv=fail; b=MUWIqIStPRqSca+fsh/3XUZIcHewoUjsXfX2kNaQJ+MVwYjzLZa+QFX6SdzPqdRilcLh2vNl7xImfWKZG6omazzPBOjIjcoLTAu7SfMqmcSfOq00+IHDWoxdsV2efYb/KT75PrVKaHqueZR7ALfdmBxIQUk/P7fQfIrj+IrfZz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274277; c=relaxed/simple;
	bh=shLtsxEjcLD2CLopckJZIG3mdzRIqi8jkL0ggdIpgEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UlKl8PAQNFAp0e0GuXRYuXilC0FwHLpIlYpKyNkUkWHxpHBorN4tBYnDiuXwyiq2+KtS4G/fCiMdSUBGZBF+ixZ8MEZX6GIP/p6Quo5l7xEV3cJIHNLHjlpN90uZK5qD9Kd5M2H/9BSkrD0mG39WHnnjRyfdURbHqWEVmxbL/ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=TGoHyu29; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=jHNcqVyZ; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R5K22i2036627;
	Wed, 27 Aug 2025 07:57:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	AlQcx9L34k42ZRkzhRgSvR7KYDq2YJ+4AKw256NW98w=; b=TGoHyu29pbVgIiv9
	/CFLa6p2Kzl+97/XOMKKvGdwE362wTRPeHHNvmN3q682TfWWr3+EdRPuS2n4dhCr
	IUOH+oKUKfxP/WF8YB/1brm3kIcyIQ1NpbHJcr9RPo4Z8AbjERZwecyfxdHpFLHf
	34feslVkbmM4WIB0PciSEt0IeZhKtwE3kfhVAsy4kbUcSANz8L0q0a6TWOE2JNfj
	UpAyTb9XXzA0/tAxYtp21gWm0jURrIfyEWlkmZNE4H/DtvdEpWTy0GF1gYmVdwwt
	aplZgX13fOQvsOd307ERv9fgp3jnsNFYSIctGAv//tK9NuJeEaxUmnNxVOMaTZ4E
	Ly3QfA==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q32ebt21-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 07:57:34 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSMJZsLWm3P3tG0J+gj4UypEc9hEjdXdr9Yd5gbwG1Z3/qVj78gqG9B4FxdGnAKSGvUYZOBMCMF3rPH8jDqahR1zC+t1YhA6bcrZ27NlZpz89B9rq9Lr/Kz8I83S3PQ2Pe69nR+m/rqBDDCZkqErXzfAyq2Upoy0xF+F3Ovkv0soHz7mk50gNa58lgAcJPJGSCTn7V7Ex0byXZx4KVPvQhfQqeqdBAnMq6yqP8uM+MHw0AdJJzCjbP7sm3RIKtL+aje7H+VulxlJbc8IR25oBEbdVbDcwHKcurAEjxHeBIH77aTSYaLDuOi7DHlxNHnA6FOTwJ8n7zGhEMpx+BSauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlQcx9L34k42ZRkzhRgSvR7KYDq2YJ+4AKw256NW98w=;
 b=Qpd/ERdv9rQlFiIB5ecSl104fVkHRJKPssQQzLwserQAtvQ2u1FZu+/jXqrqiEPqHjmI3t9hJQG2PUMNTPaVeyyDgwfZks3h8w4MqfqWTARNMQxLjOuvzAMiaRYLf5KNEqoWxxBHDd5QhsuUw+hL/6U9XKylCXGL+mXoxIiSJgxwP8P3S1kfZs0A92GxSD/z61KpoUsW7r6r4ryF/zbQXyB/HiOULjDD9OQJtSudlz8p9/f0s+vh51RnPffRQUURDU5I4jAAYHQSf7qVhRfdBxBsl3+FTf5MUbfTDjIVa8Fr+zaKOd/CCmnOqVg3jjSbaMLvTergotkr/GQYtyn0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlQcx9L34k42ZRkzhRgSvR7KYDq2YJ+4AKw256NW98w=;
 b=jHNcqVyZwrhs2EzEHw6iBUUaH1uElHl+qZ6+taGuyDlAKinLJEgiXJdg35Pi9YF1NpDW6yVrQz2Y3es/8VAGb6sBx7x6K9BFFXBx1ZHk09K9b2xfyPgB5HHqverWqKy0I66+evvSfu4sDvwbTMVFhYbhjKRAdtmTPoki3l/RRZI=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VI0P192MB2516.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 05:57:32 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 05:57:32 +0000
Date: Wed, 27 Aug 2025 07:57:28 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
References: <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806145856.kyxognjnm4fnh4m6@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVYP280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::18) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VI0P192MB2516:EE_
X-MS-Office365-Filtering-Correlation-Id: 177f102d-ad79-43de-7a81-08dde52e9cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cllZK3VwbGJZQ3JRZk9EYVBHZHAxUFlEU3VuSmpRV0gwdEE1SS94a3NTVkdK?=
 =?utf-8?B?VCtHdENjbFlLZ2Y4ZXJ2NlRsRFpQZnFXRkYzdVBDa01BRWNIV2c2YjFDc2lE?=
 =?utf-8?B?eHF2UE8vWmFKQmdFcW43UHZiMVlHYndsU3RsVVJvOTAvazNpWjZaQ2RRdkpX?=
 =?utf-8?B?aytuc2luTWM3M1NkSUtQYlpDTE1yM2RhaHJib0dEeGJIV2JVcmRNZHFHRXBR?=
 =?utf-8?B?c1cvNlRnNm1uSXFKUGU2VzEvREhvWFcwRlZOa0VIK21MZEFnT1B3YThua2tp?=
 =?utf-8?B?MlZrNWZBSzRudVhFQTUzQ3FGS3BSR3V4akhIZlZjcnRVbWZNNTZPMkhsMWN4?=
 =?utf-8?B?TWd3T2pyZmhpczFhVDk2SlhrUE5sWVRvdzFlSEd1bXNBZGNscnJaUVM0YnNM?=
 =?utf-8?B?dkR5djlmTys1SmxkaTEyc1B0bDNnbzgvZVUrU1cwazlPRE1WU2w3Q0c3TzB2?=
 =?utf-8?B?MVR1NmdZdTZiTXVqVlM0ZVhiM3A5aHVNMGJCblFWUGVKZHV1MFZPQkZjSmFs?=
 =?utf-8?B?dmJYTkZicWl0ZkhCYm9nR1lDcHAvNkgzSEhiMmowY1ZSSXY2RHBicnE4N0h2?=
 =?utf-8?B?dFdNbm1XV1VTQmcxTkhoQnIzbnhRMFhVQWlLSEpxbCs0YTQrS0NyZUJjWHdD?=
 =?utf-8?B?anZJS0FaTmZBU1hBcnl6L0UwbEQxTlFjUW5YbktEY2xDdS8xK3V5dDE5SCtu?=
 =?utf-8?B?NzhUTzVwTENFbzQ0UnQ5Z1hRUlF1bkhDVHBoNzNETm5RUllwekJjb2NFRFFr?=
 =?utf-8?B?N1dKdmdDRG1mMHgvaGxhNm1zOXVJVzJhd1p6Sm5YelU2VDdlbUljekNSZWpQ?=
 =?utf-8?B?aVFFTlhFTko4NmhIeW1GZUdaWUZ4b25IdDA2blUwcU5KUzhqS3E3Ujc3d0JZ?=
 =?utf-8?B?YWNja1NjSVNsNXBDMU8vdTd2K00xUDB2SDdxVTN3Und6dldGbGtJZGNjQ1Ay?=
 =?utf-8?B?SEJhVm1seG9ZSHp5Q3J0Z09QcFRCU0lOK2pmdm9sNk1BV0ZTK1J1V3NQUHd4?=
 =?utf-8?B?UkgvR1VrcER2OGJ5QlRGaCs4YnBnSGNRVFl3WTE2cFEwQWZicjg2ckx2cld5?=
 =?utf-8?B?TnBJKzFmZnV1TGVzNDFlb1J5SUV5R1dXMEw2aCt6WVNlSk9GOUNhc0l6OWo4?=
 =?utf-8?B?dlFyVEN0ZURyWHVZR0Z5TTBnNlR0MkttOWhpNDZETTV1K3Z5OGkweEpieFJu?=
 =?utf-8?B?K3ZhSjhIelQ2aWZTc01NL2J1ZnBMWDBrbERlaFhCNXJienV0TDZzY0ViMUFL?=
 =?utf-8?B?ZzR4b3Y0UGZDMTZtVW5ISzZhWDl3Y3lrWU0vbHpyZ01ZbFFENlA5T2lMb01S?=
 =?utf-8?B?T1hzV2Z4dnFKWWxaVmVpMEM3T0h4UFV1S0lVUDdzeEVlZngzRmJQMkZpbSt2?=
 =?utf-8?B?SHRYS2JpcjBtUTRXbVlkQTdCUkFkb3RZQmR3enBvZ0d2cWNreFBVUm5ucWMr?=
 =?utf-8?B?TDNpaHc1VktXTDFkOHRBZ3lYeEphT0hXeGhDZ09BSERtNTY5K1o1c2lPcmNp?=
 =?utf-8?B?cWdkaGFzWlBtdGZIMlVlTGNzaWh4cHhBWkRoTFMwT0R5dWJEQ1NaQlduRUl6?=
 =?utf-8?B?V2htd3Q2TTI1MStWcVRwbU1oRlVBS1VPL2VQczFXV1p1bFl0czQ4V0tMRllP?=
 =?utf-8?B?TjdCNjErRHJDcUhYWWs2Wmg0d2dVcHdoZ0NWMlZtU0h4bkFQaHdUak5QdGVn?=
 =?utf-8?B?WEthZzlwLzhzbWZ0UkFFMHdHVWVJdTdmRHJUb3M1QVMxZTZkTXdKVEhYOFhU?=
 =?utf-8?B?RWk0b3J5dHQ3VmJXYmh2N0k5WVhrVGp3cW5VK0oyYjJVSERhSk1ueDM1QWpM?=
 =?utf-8?B?RVR3MTlyR3dmWVJwWHVERTdTeHB6WHRYdWJHY1lBT2dRS21HYWhoVGZSRzBt?=
 =?utf-8?B?K0ZXMGZFbUV5dkptZCtuYnhRSVJac1ZaU1lFamNOMUk0Q3VHbHFOQ3dSWDVr?=
 =?utf-8?Q?X2t2VHwwD88=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2NsbzBTM3ZoODlQSWl2cER4Z1E4NHJ5dnU4cFpIdmwzWnYyNENKUjVXYk1u?=
 =?utf-8?B?d1JWUUVzMGpVdUdkTUw5Q2UzMVA3VzhkMWpvbWVYL24xMG96QTI2VFQ3aUNo?=
 =?utf-8?B?VnZtWG9GRHo4Z3FIUWhGQTNvVEEvTHp2eFBnSnZOUTBHRjM3eFdCWlB4QmJw?=
 =?utf-8?B?Tzk0UkJqTmRpTGphZWFxaUllTUptVit4OHg5WjJyQjZJUVZ1YjkxSjdXbEVW?=
 =?utf-8?B?MlpYQkNlMFBmdVVxRzRkL3hQTWppVkFjTVNkWUJ3Mk9OSHhuQk0xRzR4MURN?=
 =?utf-8?B?QkJhWk1xcnR4MEl4bVlZKzcwcktvaElxbHQ1cllEQ1d0cUYvRVhKZmVCUllU?=
 =?utf-8?B?N1o1MVhtcDFRTFdlbUxKb2NMYTNGYnRRajJjaVZpblZvbElTREJ3OEpBaUQ4?=
 =?utf-8?B?bUw4cnFaZ0U5ZjlvQnkzbGxDZGQ1RVk2eEF2TC8raVdpM3loUnJuck9mWXB0?=
 =?utf-8?B?QzBZKzlxamJnd293T0FQYVVHdEJ4My8vYWxJRzBFQmRNWlBTVUwvWW4xL2wr?=
 =?utf-8?B?eWRVVFpBWHJLWVI3YldRWHRMd2VvZ3QyWlV6d3d6ZmlaYUd6OXlJT25sR0li?=
 =?utf-8?B?b2lNQXJJbFRVeVE3SkZsMVhIR0drR1JyQk96YmZubTJpczJON3Y0K0wrZlNN?=
 =?utf-8?B?QXNSRk9GQnczMUN4MGtTeUZxZXRnbmxqVzI3Q0U2K3VPdmRFdm1mWG16YklO?=
 =?utf-8?B?QkhqdzFhTkF0Z25lMk9oRzB5UEFiYWZuT0xsQjBtODU0N0htN0ovUVRzT2Jt?=
 =?utf-8?B?Q0wyUW1GYVZIUUx6ZEJtZTh2aEpzSi9aSk5IWERLV0lnT0FRODgrUERmdWla?=
 =?utf-8?B?YTVuTnBGNHFnN2d5VG5YZTZtcm1VSUJLazFDaHljbVUra0RycFJONkxjMCs3?=
 =?utf-8?B?OG9qSjYwL1ZrQTNCOTZ0R1N2aTdjeklXTzZvMEYxMTFOL3p6VWhOcHl1cWIr?=
 =?utf-8?B?TnlHM0NCNnJha2VBd3A1SS9DRDVsWXgxS0xIZ0hsaWluRDdzaGllejJCWnJp?=
 =?utf-8?B?K2JpTmRLam5zcjRqVVpkNmRaUGh2M2hvVldRNmlpdFBNM1dFRStLZXdvcGMz?=
 =?utf-8?B?cjlzV2pydVhmbkpqajU4TnF3Ny93M1BuZlVWb3djaXNKWUMvUjlsdVgrdzlj?=
 =?utf-8?B?TldnRVVNeFU0UDd5NDFqTC9QUGRTbVhiT3lHSTJBVUlZL2VoOW5TNmVwRysw?=
 =?utf-8?B?MVJOZmFoaFVRWmY1SG5IRmpkN25MQjVRbUdSdGhGaVplVnVIM0FVMWcvd08v?=
 =?utf-8?B?Z2x3NHZPdWdhSHBndzhoTlVGa2oybXdqYmZjYk8zWVhHZUVvQzBqZ1pjc2Zy?=
 =?utf-8?B?bjg3MkpSa0JtcU1ZbFQ2NXgwYUp0UXRLK1pXd3lYUXJNWDhOL05XVXJqVktX?=
 =?utf-8?B?KzVJWms2eTJwSGhDVWNJNEdqSDdmbGhtNUY5MFBTcEJmelBuejlGM09aY0dE?=
 =?utf-8?B?WnFmR0l1WHRrNS9GN0VCWlN3b0trUmpDVW5hTUlmb3pWeE45SjJER2lpSFdr?=
 =?utf-8?B?Q1hVTDl1SHdRY0l2UlJ2WGR6RkQyN1FyYmt1bDVvWjRrbmM2UmhZbGp6Mnph?=
 =?utf-8?B?TGhWeGpwS25LN3JjZlQ1cGsxOTNZQ2RQM0h3S2t6OTYwMDBCKzdTcGVRMTBZ?=
 =?utf-8?B?RWYrdWs2ejNWMGV0UVI5N1NiWXVFbGpBcUNSSElZYXM5Qy8za1AwODVMdGNV?=
 =?utf-8?B?bDVqcWo5dEE4aUJFcklhYUhLU1M1bzUyTDFQSTNzOWNSaGtaTWdiWmM5YjVt?=
 =?utf-8?B?WDdkOFNYMmllR3oxZkFKeHI5QUE3aWRTUVRwdkpMMVVKem1JV0YrZXpTRld4?=
 =?utf-8?B?RUY5dTdGR1ZwN1gwWlVxcmE2d1AwK0hYVWlVTUxXOFB1bHh1dmpWUU1MNHRh?=
 =?utf-8?B?RnZndTN1SzhTK3RBUlgxdTV1ZGdnUzlRallJL0lRcmtOQitTb1F3dzVOa29T?=
 =?utf-8?B?OFNaaHJVTkdRUExEbldlUithaGF6TDJBSGFwYXJuNW0ybkpCaWEwc1BzQVJG?=
 =?utf-8?B?c1QyZWRSMy9CUm9ORUJnYkJJNnp1MXk0QW15cEpXS3JnVDVhd2JmK2VaNTZa?=
 =?utf-8?B?MzBuNUN5amxEcW93K3g1UDl5ODFLS2I1YmpVbVFjdFJRcjZqMm9kaGVLY2w5?=
 =?utf-8?Q?Rgkxh4znH03YYXoMaFuqMYtsn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8hQwro2+lVLmt0dlrLxVfo59jcnDh5j9XEGSfT+NALPvjSSxxqgDNCQCyJo+xaHNFA+iFGtkHpiJFGAKzo1h8UEq2mP4PAsIAoo3ej0TjXVVC4ZF0L0IbsEbOi0+P/TWx67uJNAeQB6VA557P3fSns1QhXEwrWu4WHKcnAx/5QTO8zj/wxti1qkQBtaxrlxgAD8gUiMnJlod2UMMMOaI/tyDedCknrBspi9OgfdPaIG3OF4NZJyiRqNoWygaJR+7nGxjU835L15Bdjqi8QG/147oVqarvyXH3O2vCaoGE99XN7PCPNTf27T2BpvZcLLtZrJIuT+xJWONZBxhJMOPI87kw6Sg+EGgajPUgwIOJWhrj81U51Ctgm2F+oBhHT4CAqGPJJjO/iq5zI4I9EfY3rMpFwKHNPJsMpHD2MUKhcZuou7xoJHiOOKkd/ZHDzY+apkjj2K2c5vZvGVJBjOVtgzoRoPygbxLJUXb8ObZc5QgN/ECfTF+HX413bDXSSzeoGmRJ0DaNjpZCQwmO/7oEDABX1NcD5rLzTDeFT9VMzl5QvpmaQ8TPzixrJ2ufsihs6KuLRW5P4sg6mfnVyNnvQndUO6vLkX/LGrC+xTxA2FxUzi+xVONxpZGId9k6ThZ
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177f102d-ad79-43de-7a81-08dde52e9cda
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:57:31.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90/07E8CKdPKBaQFHk8gf/8qz/duM9+HDI/+o/+xDCNa7vuNqGa463BiQJSpG8iS9UqIaV+8pYIH17iTKGvKeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB2516
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: VI0P192MB2516.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: YOm83hVBTA1jCwY3kWdUO8tcvEeMu5Ew
X-Proofpoint-ORIG-GUID: YOm83hVBTA1jCwY3kWdUO8tcvEeMu5Ew
X-Authority-Analysis: v=2.4 cv=P+U6hjAu c=1 sm=1 tr=0 ts=68ae9e50 cx=c_pps
 a=qOIXlmJt9mzowr3NHK3Qvg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=okqWDO1YERODiO1LqHgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA0OCBTYWx0ZWRfX6CJrKSy8IVXY
 bBR9hmkaGQrvD2SUgDACZO6DxX1nqD2V+G8WycTEuu0UlnjQ617Az2scsbBgk9bu58h2/Ee41lC
 ad966e2eHnsIJE/y/S+cmO8bLpeWqPnztJyEnQRrvxvZYYr7lAvaEDMl0paSBNsl+QYyKQRHy/p
 5ogGZudsrSvv9Ovp2MFYGts6LoYFvA23SYlxSTeMgcDKPmL0b4xfdkXgv8bgqWSEkJ3gIOCqwRU
 kkgfp5zGFINnC+q8s1Ba/jE2/twgEEKGnYa1tqUfzW7W00/MyanE6Lxsb72pRVqUuc96xTy3cDp
 Hxw1j8OFluZ2fRspZ6jccg4L60NqM9bjaqkMLKMhzXx1w5HBDOXnqEYmxD+fEw=

Am Wed, Aug 06, 2025 at 05:58:56PM +0300 schrieb Vladimir Oltean:
> On Tue, Aug 05, 2025 at 02:44:15PM +0200, Alexander Wilhelm wrote:
> > Patch is applied. Here are the registers log:
> > 
> >     user@host:~# logread | grep AQR115
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10 SerDes mode 4 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 100 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 1000 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 2500 SerDes mode 4 autoneg 1 training 1 reset on transition 0 silence 1 rate adapt 0 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 5000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 0 macsec 0
> >     fsl_dpaa_mac ffe4e4000.ethernet eth0: PHY [0x0000000ffe4fd000:07] driver [Aquantia AQR115] (irq=POLL)
> > 
> > While 100M transfer, I see the MAC TX frame increasing and SGMII TX good frames
> > increasing. But the receiving frames are counted as SGMII RX bad frames and MAC
> > RX frames counter does not increase. The TX/RX pause frames always stay at 0,
> > independently whether ping is working with 1G/2.5G or not with 100M. Do you have
> > any idea here?
> > 
> >     user@host:~# ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0' && ethtool --phy-statistics eth0 | grep -v ': 0' && ethtool -I --show-pause eth0
> >     Standard stats for eth0:
> >     eth-mac-FramesTransmittedOK: 529
> >     eth-mac-FramesReceivedOK: 67
> >     eth-mac-OctetsTransmittedOK: 79287
> >     eth-mac-OctetsReceivedOK: 9787
> >     eth-mac-MulticastFramesXmittedOK: 43
> >     eth-mac-BroadcastFramesXmittedOK: 451
> >     eth-mac-MulticastFramesReceivedOK: 32
> >     eth-mac-BroadcastFramesReceivedOK: 1
> >     rx-rmon-etherStatsPkts64to64Octets: 3
> >     rx-rmon-etherStatsPkts65to127Octets: 42
> >     rx-rmon-etherStatsPkts128to255Octets: 18
> >     rx-rmon-etherStatsPkts256to511Octets: 4
> >     tx-rmon-etherStatsPkts64to64Octets: 5
> >     tx-rmon-etherStatsPkts65to127Octets: 385
> >     tx-rmon-etherStatsPkts128to255Octets: 26
> >     tx-rmon-etherStatsPkts256to511Octets: 113
> >     PHY statistics:
> >          sgmii_rx_good_frames: 21149
> >          sgmii_rx_bad_frames: 176
> >          sgmii_rx_false_carrier_events: 1
> >          sgmii_tx_good_frames: 21041
> >          sgmii_tx_line_collisions: 1
> >     Pause parameters for eth0:
> >     Autonegotiate:	on
> >     RX:		off
> >     TX:		off
> >     RX negotiated: on
> >     TX negotiated: on
> >     Statistics:
> >       tx_pause_frames: 0
> >       rx_pause_frames: 0
> 
> Sorry, I am not fluent enough with the Aquantia PHYs to be further
> helpful here.

Hi Vladimir,

One of our hardware engineers has looked into the issue with the 100M link and
found the following: the Aquantia AQR115 always uses 2500BASE-X (GMII) on the
host side. For both 1G and 100M operation, it enables pause rate adaptation.
However, our MAC only applies rate adaptation for 1G links. For 100M, it uses a
10x symbol replication instead.

We’re exploring a workaround where the MAC is configured to believe it’s
operating at 1G, so it continues using pause rate adaptation, since flow control
is handled by the PHY. Given your deep expertise with Freescale MACs, I’d really
value your opinion on whether this approach makes sense or if you’ve seen
similar configurations before.


Best regards
Alexander Wilhelm

