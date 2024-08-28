Return-Path: <netdev+bounces-122912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73C963157
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48112284597
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB71ABED8;
	Wed, 28 Aug 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a17uNjD1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OPz/YIT/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EA181328
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875117; cv=fail; b=Y0WwuNlf/xcKYNzcykq0z0jdQfRKC/d5ONkTI0eJH7jLDn4hmlbbEA7JqjR/vGoAClgzQ6dpb3Fr7Yx6/2okjMvJC5bTfnhMqsqk6jswd/wQjuGelaVFANzQEzAr0SGLuqjzmHBBfz2KOAhNWCZW36wVaib9cdzfyuXKJTRgPHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875117; c=relaxed/simple;
	bh=DM9rSTPb1ia8NOgjwuT5jsDX+7aaEafhk7TPCYZeRyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qIaYEg/EdcC8FH6sargUk4lt4B3p90fWgAa60SCcogVn6dGNBup4t69o1UJ3WBbxJoEqbn5CvLtmRSFRIP4bt5Mmn3tyQoFk3zFIQYDnMiZzLRSK//g8fkSzW3xrvDOpzr1MZfHxLsBbz4qLamiX/sbl5qKKjonVHDW0IJPTJwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a17uNjD1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OPz/YIT/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJXU2W005041;
	Wed, 28 Aug 2024 19:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=XpwGoA8wrVPpAb6Ghsx7Q7hZN7/q5WzZIbbRO80CW4Q=; b=
	a17uNjD1LtAdg1lnxg1l7BaPucXtCJOJ4AgcRLwXujuRXRORQPoOkw3V2hfAGzIw
	kx4GytpcAk6iwyvXgErtti/sOgLtN0UxiflFG+7aqidNan27zjblZclMg/TBEct7
	j8TR7Ci2d/J9QI/1p4YgjKRK9hzl126SJLS1TZI5WUytR4BP4bKNpTAUJH0JJbBO
	AqwVU5d3bqZXp6+Hn0II0IKqF+pt6DocAr2v89B/7humVwG2faS05NN/ymKO4dfv
	EPHVmwkzxJ+rG9H8eBZ3vubX49W//afO5ob29Ys+A6Jx3M9nv3d2JHQozDiNJxYg
	LgjHNGwBERbspRv1xZ/XjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup26y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:58:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJGotd020303;
	Wed, 28 Aug 2024 19:58:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8ph17q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUxHrbpDpXClu+eBI78Nm47jk87SWrIqZbrf9oHNXGr8jMI+3MKlWQla3QXVjU6OyoIdZhwZ5BTBE5exeGVJVrPY/fsFR89L/lBLzjgN+UFfSxDFXenXRTT5xDhPDg/h0BUi7DJO1eEhPN1zL89RG85n+hMZtlKxvuto2WJDQ+GD98EsCNoL2gFpa+Unwlau/WoDcZtzWBGGQFNbNWFlYYRmo9RAQ5JBTCrfOzNDaHynkaHloQSWE7lvrV+seGWj1x92mMG47rpitpTh5jgMjRchRHrhlEVb1M+uN2XSwHG7GujKf/sUCcbUSjASOtGQ1IYlLRHr5ES6INu57qmrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpwGoA8wrVPpAb6Ghsx7Q7hZN7/q5WzZIbbRO80CW4Q=;
 b=akxqSO1EdE34goPeURoxKF1ZoQ9YrjR3QOioTxlomcqdusXafxDDD5dgVuGqqEtZ1WWJXk9jN6bKSYMWGcYlFdTMajzvMpQ1mpqmq3Hm56XCy/XgsVFLnZshfdl8gRHgZtUulp4Ft1jobiFpdD+Y3GVZ8sI0+r7HJ27HnHPOw9ZkK+ei8h0hD20kTnrsmQnt2waqQRw/ddSMpz6/Q3rEVEJ/PfbfqMpZUUl28WooVvBHUExP01Rf79rW7G35zS05PPEYK8olphhE7i2UI/Yxy/A/7G9rbu303CgfXeTmnPCR4V1U4tqOxP8925+rwV2J5x5rh8Byehz/jOHfccjtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpwGoA8wrVPpAb6Ghsx7Q7hZN7/q5WzZIbbRO80CW4Q=;
 b=OPz/YIT/yju9mqto8VnORbPwsYsUoRTbAjUa5K/5oaGzBfg5F6cA13xhkkK/jkq2jEDlRAr4i+0rDIY3/YWzI+lKLA50+C3RUXJExxEcR3HIINQM8lN/s/kohypYjULk4QrxO8stRtmA0ZPMIswUTg+RYRav8/S+IvXLzjblHZE=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 19:58:01 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::35ba:24a0:87bf:4c44]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::35ba:24a0:87bf:4c44%5]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 19:58:01 +0000
Message-ID: <546cc17a-dd57-8260-4737-c45d7b011631@oracle.com>
Date: Wed, 28 Aug 2024 12:57:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Content-Language: en-US
To: Darren Kenny <darren.kenny@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
        "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240820125006-mutt-send-email-mst@kernel.org> <m2o75l2585.fsf@oracle.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <m2o75l2585.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To SA1PR10MB6519.namprd10.prod.outlook.com
 (2603:10b6:806:2b1::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: c4664ad2-8ba1-444e-56a3-08dcc79bb892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODhyN281NWhmeWNqYm45dm5rNCs1NHV0c1FmcXFrdktKUXJsZ2k5TjBlekI0?=
 =?utf-8?B?Tk4xMVl5TEh3YlgxMDd2dkR0cUpjSDVPbERiQ083TXF0K3hXZWxTeERNNlNC?=
 =?utf-8?B?MXJPQkh1K1Qza0xGTnVOSXVvRmpidXdiOTdNNGRnWURlZEhNNzdhb2I4bTJr?=
 =?utf-8?B?dkcvdlNMaWw2ZXd2VFNiK2pCY24yMzRhalY5L3RtV0lNbjFhdWYrOVFsTFVJ?=
 =?utf-8?B?ZWNlUkRMbG9XSm85NEhjV1c1a3JjeWdqY0k0U2FLRGJaSS94dU5keUdrQi9l?=
 =?utf-8?B?dUYxZnlFZm5zMHNUQ2tZbTlOdW5kRC9qNEUyS1I2VXArQUdRbUx0Sm5FWmVs?=
 =?utf-8?B?QzJKSFptWWZVUUxLQlovRmtjem5wQjhxbSswLzNRdDFtdkY4WXUzd2ZmdGNk?=
 =?utf-8?B?RHhFbEs1TXFjalg4VUtwVFFkWnVxY2xseCtPTjkwVHBTdldTV1pWU25lUmN0?=
 =?utf-8?B?OUppOEFuNnJLcU1Mc01HQmVLRmJ3UmRhZ2tHTWprUTRLVnBuWGVpSjBFTVRq?=
 =?utf-8?B?K0lqUlpuK3RMMnBhb3ZHRGhLNUFmM2Exelk3amFUbXIxK1BWNzE2Y0xFcXh4?=
 =?utf-8?B?N1drai9HeUFvcFNqT3NEck1xOHd3MnZyeC8ra1VPZVB2Wmh0SmdKU1U3Kzk5?=
 =?utf-8?B?UnJyb2VVS3pIaTNmMFNoaitSNVE1cFlDODM2U2tqcVFXa0pKZElmeFMrNFM1?=
 =?utf-8?B?TlVRcFJvTEFqallIa0xNblR5QU4wdDc5UGdSWVYwVkZBMWM5eTdJM01yOVFJ?=
 =?utf-8?B?ejN3dDMvUW5vYXNmSldoekNQUTVsTkx6TStpRzcybkNmMkdMc1VxdXBGWGhu?=
 =?utf-8?B?c1hac1F0blVXMGVNYkJ1S3dCaCtEeGpzUEcvY3pJOXVSOUh0eHVTTVRKZkdF?=
 =?utf-8?B?TEJPSnVzVDl1Y0lFRExUVUZQcU9Hd2traHJCWElTU1JibnhscW5oUHhIenJu?=
 =?utf-8?B?Rlg5dUVKaTNQWE9NRkFnR1dlWGVCc3NNWm4wa1RRbVZNOEw0VVh4eDVxNXJT?=
 =?utf-8?B?SzZHQnN2TjRuOFJEWEZ2SW5QMnZzNlJzM0phM1FBR0RuOER3OFRXbFJocGs1?=
 =?utf-8?B?dVR3Q0tmY3FHck1BVmlHZGtWbGFqcjE0WDVZRTN4NU13enYxRkV6bU1MSEV5?=
 =?utf-8?B?czVzOUZ6aks1Y3dMS3pYQkxYV3ZVYjFFckhQMkxIS3pScVhkb1MxY0lGbS9r?=
 =?utf-8?B?WEUvQkF5VG4xN3lHMXJDWnM3UVM0MmhoSld0eHBaUFhrNmYwRDAreWwzUnpr?=
 =?utf-8?B?SFB4VVNtNkwxWWFsUG4yMVRLME5pWU40LzFOQ1FYcXFCYnZuYjZORHQ4VTlB?=
 =?utf-8?B?TVFEbE5EMGsxOEVleHFTdW5TL2RtTkl6QzAvYmRQNW5KMjlPRVVCZ2NuVVFL?=
 =?utf-8?B?SmQwL3VOUkNWU1ZodUc1ZUU2VVdJRWJTdmVqVjhlQXdheUpFRzJaZUF6bmlz?=
 =?utf-8?B?azM1NjlFb0VXU2xQSFhWZmZVWVdBZHZmNWtmOVJTU3c1NEtsRWhJeTlDRWZZ?=
 =?utf-8?B?SXFRSFlXd0o3VzA0eHlyR3RrMG4xVVlaYzJaNWhsYlg1S2xrY0Q4WW12Mkky?=
 =?utf-8?B?VUtJZGwxQ3BpWGFNZ1FpbnJPeWxiMS9KeFpwRitzNmlSdDZZaE5OSmNSLzV4?=
 =?utf-8?B?NkVYNHJBbnJNQ0xlTFdtZDVrRkJLZ1R5c3V3akJFWVdMcFRIbSthNyt6aFpO?=
 =?utf-8?B?aXBrcStTQUR3eW1pYXN5aXdmYXJBT0lxZlFZOU5pSDFFOEJIZ0N5YS8wRXVi?=
 =?utf-8?Q?zpKgWWB/zdbcVm5+k8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6519.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0xyYWNxLzBkdFRVRWxJa3R0NFprbk9ER2lZMnpuOXQwbjdtdmdrcmlvMDUz?=
 =?utf-8?B?Yng3T3psMVlEclhRREZZVldCZmNnY3VucTNWd0dQRmdwSndWUmQ3dUVRZnJv?=
 =?utf-8?B?WHE2ZVRaNWV0MDBWelZUVnAxMWN2UEFjNy9RNjMvTEdtTE83RklNTUpRaXRT?=
 =?utf-8?B?dGxteTBYZFlxYzE4cU5sYnZBY1oyWFdtVGtPSzRqakZaVHdQYVdBMDBtRTlk?=
 =?utf-8?B?NVdLL0JBWXZFZXV0Vk1ad2UxemZBb2srY25SNDJPTVN3NEt1eVAyaUgyUEc5?=
 =?utf-8?B?WU5hTTBXS0ZzVllDS0JmWXN1RGpERG5JR2tWNFlCcDVRRUJSbUlSZUF1Ulhh?=
 =?utf-8?B?M0ZlWDl6aGN5RjdGNVlPb1h3MmJXS1RYM3NnbXMzL0lLRmpXeFpqd1dHN2xT?=
 =?utf-8?B?ZUdrRXNTMDFIUmRJV2F0MHIxWFpPS05GT3dseXRxa2kvdFlHcFdqN3l4VFlp?=
 =?utf-8?B?dHNrUU4xc0JWTXJaRjR4TmovS1VtSXJ6TmllZ04yeXd4UkorYWFua0MrWWZo?=
 =?utf-8?B?NVRvMVdKWkVkSUVHUW96Z2lOZDJtdWJnejQvVlI1S00vUmhhZjBINkdKYkNB?=
 =?utf-8?B?ejJlN0xwSGRKU3VFaGRvakZ3QS9lRFBETkFSS05pUmVpOWY3c3lERmp0Unhz?=
 =?utf-8?B?REQyVkJnV01NbUM5OGgyeHF2cEdTak11R0pYMHl0TjBDQ1BLc0VqZldMSmNX?=
 =?utf-8?B?ZVVueTNIYnZEK0JMMk9udTFZemRQeTI2cDNMWWl6T1ZmK01LNitleVp0RVhr?=
 =?utf-8?B?anNpa1FWSmp1RVZXTWZEbCtEeCtPQXp1MUlnK0N0eUwyTG1JcDRXTWJibGNE?=
 =?utf-8?B?dERLT1d6a0dyMmc1MDZzbkM2UXRvdHUrcklBUTJaL2R1cmczeHd0b3JRcldx?=
 =?utf-8?B?a2w0Y0hxN3k0NU1DeFcvRy9FM2t2UXJjL3JGdXBnUHZoUUJoaFFwdWdFajVY?=
 =?utf-8?B?ZDdxUXo2VFgvbzFYR2VoNXRuVVVOdi9NVGVJdWVwZHh6dGpla1k3N2dCNENm?=
 =?utf-8?B?c3N3d0RYa2pUQk1mZlBDSXh6SkcybzhZT1FaRERKMFlHS0xrWFNodVZTVTY4?=
 =?utf-8?B?TzdXUlRIMkp3dDlCcFFVSC94OFZ6bXZmUm41aE43S2Z4QVZycnh5MTRxMCtV?=
 =?utf-8?B?RzUvRTFnSk0yUGJpUkpkWE82TXN5M0tsYzNaNmxZUW1oSUxPbk1kdkcxK253?=
 =?utf-8?B?SFRneTlkdXRueDBHU29jdk1yVEdaU2RiZnUvQkZocXhmU3dKTnI3U0JsajdD?=
 =?utf-8?B?VGdYaG5QU3p2a0NaVlVtSG1TZ1dCbnQzZHBacTlkOFlncHZTcGh6a2p2Zll3?=
 =?utf-8?B?MWlVbmVJeUNQU04rcjFnQzYxbHdQUXRaV0xyeW1zMDZuMVJZa2pSTk04RkRw?=
 =?utf-8?B?U3BvTU4vaUlVNnFUZ2pBZUNDL1UvclJZZFU1VHR4RGtRV200bW9HV25XS0NV?=
 =?utf-8?B?ZC9tbGtVUXhvUnZ4UGtpN2l5NHczL2pFM2Y2TDFZQ0w4dGtSSDVnTVI5QVlr?=
 =?utf-8?B?M1lRclpFd2ZwRDZMc1hsQWtSdWtFTW1ETVVhMVZvN2pIYTBweXc3MzZ1TTM4?=
 =?utf-8?B?NVF5WlFhTTkwR1FPWDJYbmM2L1NqakJzMkdWQS9KU0k2TmhKbkJ2aVEyaUlI?=
 =?utf-8?B?SHdXNmNvdFdwenNtTldVUkNBbzREV1hqU3I3YWk5c0QzT0EweTVDNStQdWdN?=
 =?utf-8?B?Z3g0L29zaHozTnlJSi9SRUFBTzlqVzFhSlM1OWNwQ0x4WGVuaHJhUFNaUS9j?=
 =?utf-8?B?bGhvbXBvQlE1VW5tdmpPR2N6ZUNEQ1RmaUtNLzRiaVU5NU1mRXJtaUlBaGpk?=
 =?utf-8?B?UlkxR216dWUweTh6NEtLTUpVQVQ3Z0JzbHV6V1Z6ak5RclZFc3QvYzRxcEha?=
 =?utf-8?B?MWhQMU43NitDcXhXRHZwUnRlblhQZm5JbFlOaGhYRnJyaHFjdFJvZVFRZWRr?=
 =?utf-8?B?ekE4L0RHQkRKc3JqNjU2VmhZOFpmUkd3SlFOaFBZK2w3UllJL29UTHJzci82?=
 =?utf-8?B?WTI5S3VEL1pSRkpyN1l4aUtGM0pScTlpKy9xcDUzQ2hnUHdXaGxFR2pxakVW?=
 =?utf-8?B?bFROejBZUlJsYXlqKzI4YVpVdmoxWHhkUmh1ZGlrUmxWWFNUZUlHbktISU5E?=
 =?utf-8?Q?j7rROWktwUMM0RY00KURosxVW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FbdMk9h7ShQZ+rrTf5JltWal5CRu2ygkL07Wyzx0+oJPkVBm0BGTqdGmWTxBxe+qbPlsWd6NKMNqDgWdaqWMBXAgFv7jDQ45LeqRjtwtVyU8AqaV3cdvbpZkVWUI2qbh6NopIAvvKs0th0g5QpWW51+BLjXNspyr+413/oLJjWQcHIr75J9chdBiqqJMTCAUdkJHC84TUjoZSJX/RbekPqtlwwaFYl4NLlmbBeBy7gRwVuB0UWtT3U7Hwi3ObUeJ/UmZJ4cVBBBgSgplYq+WWHMewoiEKaNqz5VHuJGvKjCwxaNi+W4OEq/hNNjJAlyT6B0ALTM3o1T2G0AQES5czp6gB4XIqQ/yD3K2WbmHdQZ3Y++Kz4eCdgLseRhaLm7KfFBnZ6918lZMFwo+3SnxchLrRc6zeGARhjGIyn9xghdkuPRyEm9P7nhlRQoHPBJxvMiGtftd76LSz95uz1FWC449XTRwuOthC/df3ukkwIITYdZh07cXseLwUhuz9ox88Vb99maX7W6TVMayOxlhehYM5VwGphtbxO6xb1rYb76gT/vEH8Z6pnJR10dinntgIhKwiKXtHuD5jADHr/aTCiN/VhcyI7WspHAxybOQWPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4664ad2-8ba1-444e-56a3-08dcc79bb892
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:58:01.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6qTxvBWOPk7tua9MmXfHJQofQDjjMp8iRTCwXsAMSinZTLti36vOmgJTk8xBSToWOUuEJaDSawcAFe1uGLrdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408280145
X-Proofpoint-ORIG-GUID: Pgs3IE_rbwJIqSd8wJL8EN1q9PoovHzO
X-Proofpoint-GUID: Pgs3IE_rbwJIqSd8wJL8EN1q9PoovHzO

Just in case Xuan missed the last email while his email server kept 
rejecting incoming emails in the last week.: the patch doesn't seem fix 
the regression.

Xuan, given this is not very hard to reproduce and we have clearly 
stated how to, could you try to get the patch verified in house before 
posting to upstream? Or you were unable to reproduce locally?

Thanks,
-Siwei

On 8/21/2024 9:47 AM, Darren Kenny wrote:
> Hi Michael,
>
> On Tuesday, 2024-08-20 at 12:50:39 -04, Michael S. Tsirkin wrote:
>> On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
>>> leads to regression on VM with the sysctl value of:
>>>
>>> - net.core.high_order_alloc_disable=1
>>
>>
>>
>>> which could see reliable crashes or scp failure (scp a file 100M in size
>>> to VM):
>>>
>>> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
>>> of a new frag. When the frag size is larger than PAGE_SIZE,
>>> everything is fine. However, if the frag is only one page and the
>>> total size of the buffer and virtnet_rq_dma is larger than one page, an
>>> overflow may occur. In this case, if an overflow is possible, I adjust
>>> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
>>> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
>>> the first buffer of the frag is affected.
>>>
>>> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
>>> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
>>> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>
>> Darren, could you pls test and confirm?
> Unfortunately with this change I seem to still get a panic as soon as I start a
> download using wget:
>
> [  144.055630] Kernel panic - not syncing: corrupted stack end detected inside scheduler
> [  144.056249] CPU: 8 PID: 37894 Comm: sleep Kdump: loaded Not tainted 6.10.0-1.el8uek.x86_64 #2
> [  144.056850] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
> [  144.057585] Call Trace:
> [  144.057791]  <TASK>
> [  144.057973]  panic+0x347/0x370
> [  144.058223]  schedule_debug.isra.0+0xfb/0x100
> [  144.058565]  __schedule+0x58/0x6a0
> [  144.058838]  ? refill_stock+0x26/0x50
> [  144.059120]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.059473]  do_task_dead+0x42/0x50
> [  144.059752]  do_exit+0x31e/0x4b0
> [  144.060011]  ? __audit_syscall_entry+0xee/0x150
> [  144.060352]  do_group_exit+0x30/0x80
> [  144.060633]  __x64_sys_exit_group+0x18/0x20
> [  144.060946]  do_syscall_64+0x8c/0x1c0
> [  144.061228]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.061570]  ? __audit_filter_op+0xbe/0x140
> [  144.061873]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.062204]  ? audit_reset_context+0x232/0x310
> [  144.062514]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.062851]  ? syscall_exit_work+0x103/0x130
> [  144.063148]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.063473]  ? syscall_exit_to_user_mode+0x77/0x220
> [  144.063813]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.064142]  ? do_syscall_64+0xb9/0x1c0
> [  144.064411]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.064747]  ? do_syscall_64+0xb9/0x1c0
> [  144.065018]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.065345]  ? do_read_fault+0x109/0x1b0
> [  144.065628]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.065961]  ? do_fault+0x1aa/0x2f0
> [  144.066212]  ? handle_pte_fault+0x102/0x1a0
> [  144.066503]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.066836]  ? __handle_mm_fault+0x5ed/0x710
> [  144.067137]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.067464]  ? __count_memcg_events+0x72/0x110
> [  144.067779]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.068106]  ? count_memcg_events.constprop.0+0x26/0x50
> [  144.068457]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.068788]  ? handle_mm_fault+0xae/0x320
> [  144.069068]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.069395]  ? do_user_addr_fault+0x34a/0x6b0
> [  144.069708]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  144.070049] RIP: 0033:0x7fc5524f9c66
> [  144.070307] Code: Unable to access opcode bytes at 0x7fc5524f9c3c.
> [  144.070720] RSP: 002b:00007ffee052beb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> [  144.071214] RAX: ffffffffffffffda RBX: 00007fc5527bb860 RCX: 00007fc5524f9c66
> [  144.071684] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> [  144.072146] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff78
> [  144.072608] R10: 00007ffee052bdef R11: 0000000000000246 R12: 00007fc5527bb860
> [  144.073076] R13: 0000000000000002 R14: 00007fc5527c4528 R15: 0000000000000000
> [  144.073543]  </TASK>
> [  144.074780] Kernel Offset: 0x37c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>
> Thanks,
>
> Darren.
>
>>> ---
>>>   drivers/net/virtio_net.c | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index c6af18948092..e5286a6da863 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>>>   	void *buf, *head;
>>>   	dma_addr_t addr;
>>>   
>>> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
>>> -		return NULL;
>>> -
>>>   	head = page_address(alloc_frag->page);
>>>   
>>>   	dma = head;
>>> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>>   	len = SKB_DATA_ALIGN(len) +
>>>   	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>   
>>> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>> +		return -ENOMEM;
>>> +
>>>   	buf = virtnet_rq_alloc(rq, len, gfp);
>>>   	if (unlikely(!buf))
>>>   		return -ENOMEM;
>>> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>   	 */
>>>   	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>>   
>>> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>> +		return -ENOMEM;
>>> +
>>> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
>>> +		len -= sizeof(struct virtnet_rq_dma);
>>> +
>>>   	buf = virtnet_rq_alloc(rq, len + room, gfp);
>>>   	if (unlikely(!buf))
>>>   		return -ENOMEM;
>>> -- 
>>> 2.32.0.3.g01195cf9f


