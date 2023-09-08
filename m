Return-Path: <netdev+bounces-32669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93820798EF1
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 21:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBFE281B34
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 19:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B04630F8D;
	Fri,  8 Sep 2023 19:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1C210F
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 19:17:21 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211108E
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 12:17:20 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388IKSqZ027335;
	Fri, 8 Sep 2023 18:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jPM89823NRArZe2c0sNSEb5a+yKdBvlfUgU6SPJJW84=;
 b=z/v17gUd6ic1O3QucFXACsg+z8G5UDASVcff0BhRUJwh9ZiJxoUweWNk3hgMpRJksd5o
 ZVsy9a9qv//ZKPxrZ8Gwn5AnlgX1MwPY7mc/XMrvCGUoEFkh06lZPEnXKKgB1n++IMpZ
 hcOrWsSo64I8PK/BxPUipgLN0ZwamcpsYe0OdD4b6T0eB0V9eNZFW4zfK6mK568wd2Ir
 yw/jl+vjoMMpWXiSWNOxPiZ3vUhNIKzyyFLo0HWoB1LmCTxy2lQRPCxSJPeAk+5Xd/84
 +/jNNj0PK8GOzvegzWxNjp37X1g06QkYZt6uNxDmnpY7XPzF6X+Mmlw+3gKMSEMoqhq8 fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t08syg15g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 18:38:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388ILQts003904;
	Fri, 8 Sep 2023 18:38:04 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugfsb0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 18:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ+KuzWNG/gsHrl1911S3vJ9j9dPPjqEwjvsDEOiehDQL1nrmVH0u303TjChEQtLGp1c1ZmvkzxFMheZTe2DBadaDUCYILuhEqyp2TgMz8ML17YOaLTiK8UffVF4hCDVW6v0xHtbkipr/UtFwIMzM7a7h0iADeY69U6hKXLMLiECC9OlqQNg+rxcavOidNn2mCq9qEBhBUFIUWY27XoMh2VBBRb78PoCwcs642uVGUbNFoGP3ghfxSKUCKSp261nX6inljXwFhxNh1D1M7qa/cEPfG6tAzRzslexGRI1v9Js0meJobRuROQ9EY+DXMrG4Xliog63sJv24FhdYOGa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPM89823NRArZe2c0sNSEb5a+yKdBvlfUgU6SPJJW84=;
 b=ROaxkwxtof6G6bEdug8CHNxkqDeHMaY+sbONzgffQulXXL6VP/7Z5qd/HwmzgZthCptzDfA9vybgDYJfLyAZT9u+sZBsB6k3m9zKtvNOkYJl78qg8LT8p17y9vZwOdjEucX6YCpJrjZTN7CZxi6m1EGgwVx2+0uuLEkmNWGnDmWINqkpfFfxIavxqTuDx5jYw415BxTWgCJWk+LdncniKCTtl6Acd3qOO1FQ2Xp6749Daa13HD4FDnYDdU93gVi//RL6UNP27YXsEgSAjF02n/EIFekzSymeeuDhL+hEuwN26esHkisufoNazSb1peevCE5adR1J8DX4/MHD1nX8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPM89823NRArZe2c0sNSEb5a+yKdBvlfUgU6SPJJW84=;
 b=s0hHmlN46l1gqZf6rCR8woUTa8OuHnAolJSzteTQ//gt5ek+doUPJJqCT8a3lvwAXBhChDQoYUcK3vgM2CsKpjYT29Nzslz2OZjijzTvMp/xwLSkakaDpfDqi9lL2zoSW7UzgbZD8AzhkXs/O1CosIYilJy1LOwWv8H0ZEmh9k8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4660.namprd10.prod.outlook.com (2603:10b6:303:6d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 18:38:02 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6745.035; Fri, 8 Sep 2023
 18:38:02 +0000
Message-ID: <b4014822-48af-ea9e-853f-0a0af3fc47ed@oracle.com>
Date: Fri, 8 Sep 2023 11:37:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] vdpa: consume device_features parameter
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>
Cc: allen.hubbe@amd.com, drivers@pensando.io, jasowang@redhat.com,
        mst@redhat.com, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, shannon.nelson@amd.com
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
 <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
 <060ee8d4-3b78-c360-ac36-3f6609a5da89@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <060ee8d4-3b78-c360-ac36-3f6609a5da89@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: f1029dec-e65f-4844-1266-08dbb09abbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ss1eWiEpf18sBVj4gbFDBk4D4QZy1WINhatqSlDxZQo2QfH/it4vH4jsUOOKCifWg5dQuoc1XZ0zVHgr9LB6JEUHSONqkWkV3Xn7XY1wGCPEKMgE58f+n9D7HsdG/UqWLnMRRIKoVM9T71WYdyVjxX4vCw1+v4F1LWmhSmEbzU2dFtnwRszv/q152X/3afpxbNlx8frsslW2qlCb9ctBxFWgkZMieHuYnyL+z/UPmsjBhoZNqqKooKI7y6DTH/OxshodkMzhbc/VvckJxmf5Yye3jQmyP6FcTadUnS9yyMZxtCAQaet/+j4nl+1EALKcz1bXoDRmqsY43gdF5aqNEO+1sdLcZDD09twlXLPHuxu+QrBVt3o6M3FzA8eyMRzJuKU/AGIRe1UG4wlm+uepYzWnusGe51ib/2lGSZn9aRVAR5UaLbFw8uMnGfDKVhAvV2/mSffAr718OuvzUSrH+QoN8tb9LrTM9iRTXywFry9y4jbDzymGqF0cOIAVUAP0I84MONgDt0WeMOWYa5v9x1v1o7O5JopYqm8ReuaIAuT6BCqo++9F+3oqjkPBFsgreTjL69dEAeBGl0a3DkLoxUVK/6pITSnvrZVh8RKz56M+URuCKVvMBO5Jj/O+Snl+m0UAgFMQSipnY+imyF7Bzw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(1800799009)(186009)(451199024)(966005)(53546011)(6666004)(36916002)(6512007)(6486002)(478600001)(6506007)(41300700001)(6916009)(316002)(2616005)(4744005)(2906002)(36756003)(8936002)(4326008)(66946007)(66476007)(66556008)(8676002)(5660300002)(86362001)(31696002)(26005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkxLZEZsZXN2MGl4bkEvZXIzUkxMYXZIS3FDUUgzNWROQk9nZHBKakhNR0lY?=
 =?utf-8?B?OGxoTkYrSlRGNFRDb2RoZzlleWQ2MmFVVTVlR2FrZ1lOWnRwVzQvUkNtY1Aw?=
 =?utf-8?B?Y0tETFE3SHJ0M0thR2VYRTdUSVBaMGJKZGVGQkxmZ21rVXd2MnZOa2tvRXlS?=
 =?utf-8?B?bFdyZzBwNlpDNTVxWkFIaC9wc01ENkZUSDIvY1F2TVZmbThNdXBQa1Z3S3NI?=
 =?utf-8?B?cVJYUGR2QTBuWU1xODFXQ1U3cXZza3N3czZYRmdidHBTUldKN0wxVkk4OXUy?=
 =?utf-8?B?Ri9vQVBuM0srOE9SRWU1YUN5RGF2S0Y0RkVRMUI0TEMzWDNZUUdodGRGd2t5?=
 =?utf-8?B?RnpGcndka2hheHFIRUdLT1IyS2U1WmVlb1pxRVdRNmZPK3dBQXNUTmNPcW82?=
 =?utf-8?B?c1cvU1ZvbThKQytQdXA2ZzNHeTlhbTBVYXJyUGtwSmNwcXZsVU44Nkdvdjh4?=
 =?utf-8?B?VEVmQXRpYzMxQ29yYXhEa0IvVmcyZHVqTTFwOGI4WmZBSjJlWk5kN1gvRXo0?=
 =?utf-8?B?UkFZanZYTzlGOE91YndMRmF1U0RVNlNyRUkrQlhSWlU1VGp6UXVmRTlnblB5?=
 =?utf-8?B?VUdyTnpLc3Z1V2g4MUpjV0Q0MGFEL1djWmlZTnJvT0JuWHFiMTk4c1pSZVpz?=
 =?utf-8?B?RVZLN3MrME9KQmlPQm9vcUJ0OUdzSmpIei9vZkg5TUxMNmM1T0k3cFRKQVZK?=
 =?utf-8?B?V2dnTXdQZi80WVNCWkkyR1B2WWlxbkN5eitqRHA5QTY3SDd6MGw2QWhWdzhh?=
 =?utf-8?B?cnVJNGxDVGlxcVhweTUrTWpxWWtiZzFtT284bG02NlltRXAvSXQrRllIN0d5?=
 =?utf-8?B?WWVkNFZzRTEvTk5tSHViUythQXlocW5tc1RweW52cXE2QnJrRG8yMmc5RDds?=
 =?utf-8?B?NGM5N1NYMmJwd244aVg5T2krNCtSN2h2VUJNVjZYaVRpRThLNmdNbllFZEYw?=
 =?utf-8?B?emYzb3IycUJFK2h4WXM2S2dwY2FlZFk1QkZ4TjVLQXBOSXVnQlFxOTlZcGZC?=
 =?utf-8?B?Nm5LTmhwc3RlL2RpK0pSMnRYengxL2h2VE84MEhhMTU5Sy8zTWhpbW5UVzA0?=
 =?utf-8?B?TzdTdWRwY2YzaEVNVzQ5Y3BXeFU1MUh0THFoVkxLVHhSYjVXTDFGNjlncHF6?=
 =?utf-8?B?alBGaHdIY21HQTE4NjZLNGVSNElyTXk1TXVqWEhvS0JBbDNZaE9nNVBEeDdq?=
 =?utf-8?B?eGxoK0djcm9ESWVsd1htRW41TEtGc1VrVHVkNVlXUjliZ3gyNXFyNjdueW9s?=
 =?utf-8?B?YVNRVSszZ0FzYmgzc2xSTTV5RVpWVzJ2WHIxQlpnZHhVcExrVy8yV3ZTcUVS?=
 =?utf-8?B?MnVxcnVEOUdvOG1nTGVYZWV4QTAya1VqdHZGdlF4Y01oSDczWUZ5ODFKa0VK?=
 =?utf-8?B?Y3RSY2ZSakRpbk90U3lFcFk4SXRNcmdiMFAwdWJPMFgrT2dXcDBZejRReFVU?=
 =?utf-8?B?cHZ2RThxVHlqd0Uxd3NPUHNvb2ZWSGdhTHVEMXhKVFVYcjVKMVdVNjFpTUhz?=
 =?utf-8?B?QkN3V2FuOGFIZktxb2sxR1BwbDBScFovelh0YVVXenNiem9qVEY3a1YyekF3?=
 =?utf-8?B?VStvbXN4Sk9Sc0pFZHhGNjdVRTdLQkhxbGJxVVYzbXV4TTc1dkNYd3pjYzdO?=
 =?utf-8?B?emxQbFVuenhoSnh6bWthUlJGbmRnSERHVTVtSkFHR3hCQ2tYUDc2a3FUU2NQ?=
 =?utf-8?B?c0pnNHVqc3Uwb1cveVZRTWYwR0FWM0hxNFQ5cFMwR1crZ0R6dVVyL3NkWld5?=
 =?utf-8?B?QnVaYmRLQkZYL0w4UWd6WWVBaWg1VHk4ZHRhY3J6R1RYZ2JodStNUjZDaldT?=
 =?utf-8?B?VFZZUzB1cUpQS2h2c2lQWHgyM0FQUU9UQ1o2UExGVEV3UHUrVEtsT2gvdk5l?=
 =?utf-8?B?QWIrRXhlOXBYUWJsK2RLcFBUQ05EYUdZNmY0dUY2N3hKcGFRN1RBVTdPaVVG?=
 =?utf-8?B?alhROG5sanNHZDBPZDFQWHRDV0ptbXVGNzlSUnNkbjJiODZES1haVXBiQlFR?=
 =?utf-8?B?d3gvSmZpWllacGRSU3hSWm0wdk9veDI5T01GYU1qTW1PWERLZjFnZWNOUzNs?=
 =?utf-8?B?dmx5M0Fwd0pKNHVaRDNtRlJLbmRjM2tBczRyUnZxZ1hPMXhGckRKZVpiVm5r?=
 =?utf-8?Q?oZ+jBBvl91IJk/+DGncx/sWn7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RlRUYkE2UU16bEd4NnhKeFBPcUdsYmY0bXg1ZFdKYVdRUXp3MnVPc0dDYStV?=
 =?utf-8?B?a3hodXpHVUtxRDhKTFV1L0dRZWtwUUNGQmVGZ1BYMUkrK3ZGUWhMZGFiYUlG?=
 =?utf-8?B?My9VM3J4aDROSStqV3BCdEJTQkM2TTUyS3RBYTNGd2pRejBWeVlnQm9sT3Fj?=
 =?utf-8?B?c1NpcXhrT2kyczg1WUxXd3dyNGs4VkNVcXhOVitMOG5jbmR2OExCYmRvdFdk?=
 =?utf-8?B?MkxHU3FaT1hGUnBEc1VmeXdZRUtzTWx0RHhqcXhrWjFiMFViTWV4VFVrTGZa?=
 =?utf-8?B?NlNDVTk1M2d4eFBGblNWVmF3RHM4UmJkRW5CM29heUNUT2puOWRYSTM0V0N5?=
 =?utf-8?B?cmRWRFZkaDdPQWNsMnhlU3pTci9FUm8xM2ZaY2w5UndVL0c0ZWZVU1ZXTmlh?=
 =?utf-8?B?SGIwWHVubHg1bGlvWTV5OHhmYytTeXhWdlNFUDB6TTlITW5PSXdJaVZWQVlD?=
 =?utf-8?B?NW1TbVNnVE9qZjBQVnBjRXhoMmJMeTN2NzJZU283QVZqdmEzU1JrU3FhL2Fk?=
 =?utf-8?B?azJQb2hvUjEwSXhYdDQ1eGF5RGRmWlpQbUZuSEJSUGlxTUU0WUU5S1dPSTI1?=
 =?utf-8?B?amJsMlRFNDFjdnllSGhzdGZZNkdoYTdGbVROUElPZ2ZkcW9lQVlyVVQyNTBn?=
 =?utf-8?B?VzBvY09BZzY3SS9VU2NRMURhdTNYWEptMU93VWVMUDQ3dE1OYndNZlNPeExj?=
 =?utf-8?B?d3g5L1FQM0ZFWHU5YkRXak5IZ1F2cVlJMlFkSllSRTRRZVRnODZUekRHMFgy?=
 =?utf-8?B?R1dvRFo5QzNTaGtDTm9ocWx5bzRqVnlhemdaNDBDN1V3dUdGdHVEUTJJQWxL?=
 =?utf-8?B?eUlBUitsaUNCUEFyRDNhNXdjZjg5eHVFcmRlMlFVaTJ1RHpSdENDNVdxKzlu?=
 =?utf-8?B?cHRyME00Uy9iS3gvdU9vbUo2a3NUczQ0MUVJNml6dWZKL3JySVlsd3ZvU1gx?=
 =?utf-8?B?ZEtZVHlVTTNEMW9VNGpmNXBhMnhURXYwTEJvZVZOZEt2M3V4eXcxTXBoZGc5?=
 =?utf-8?B?RjNJOHRTTm5lU01FRUhlQlg4aEh0am5SeEpNcm1vTlRHTmdub25uNFFBY1dS?=
 =?utf-8?B?QzBhUnlwSEdMZm56SUpzL3BWRmU1SVROd2FtRFY3cHEzQXQ1L2RneExNbCt6?=
 =?utf-8?B?Tm8vUVhDMEJ4c0xnQWV1elprUlNPZ1V1SDBJMmJQaDJsVjU2U0FEK1V4UEcx?=
 =?utf-8?B?UjYveVN5NzdKM3BDWXN1VXdrcnJRV1E3cHpRd29HQjkzRWtITXYvNXJKSDZv?=
 =?utf-8?Q?XGqHWe6NPMxnARP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1029dec-e65f-4844-1266-08dbb09abbc5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 18:38:02.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox14/yc0yKM7R+HGhQWJbb2DWd0eSGnz+MF972tstySsigtYo7+9qhVF7D0oqS0OLMRGJPZfzDC7eRVtyg/Bbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=558 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080170
X-Proofpoint-ORIG-GUID: wCTsXFTPFP12oe_LFDlNreRCMphwxCr0
X-Proofpoint-GUID: wCTsXFTPFP12oe_LFDlNreRCMphwxCr0
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/7/2023 5:07 PM, David Ahern wrote:
> On 9/7/23 2:41 PM, Si-Wei Liu wrote:
>> Hi David,
>>
>> Why this patch doesn't get picked in the last 4 months? Maybe the
>> subject is not clear, but this is an iproute2 patch. Would it be
>> possible to merge at your earliest convenience?
>>
>> PS, adding my R-b to the patch.
>>
> It got marked "Not applicable":
> https://patchwork.kernel.org/project/netdevbpf/patch/29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com/
>
> Resend the patch with any reviewed by tags and be sure to cc me.
>
Just out of my own curiosity, the patch is not applicable simply because 
the iproute2 was missing from the subject, or the code base somehow got 
changed that isn't aligned with the patch any more?

Thanks,
-Siwei

