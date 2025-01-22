Return-Path: <netdev+bounces-160427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50374A19A66
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 22:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB813ACCC5
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11B1C5D63;
	Wed, 22 Jan 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PDbmmjUF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f2/U/nsE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3AF1C3BE6;
	Wed, 22 Jan 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581436; cv=fail; b=h6JwzsR39vb9XlkrAlzN6cns2ZCn6O5JECq8exWhx5ClUbLjTlXqF/Jf7RhdHO0YPvqwkjrFj2ae+Xl9bYhGmXOu7Fyv33DOMWvCmdiIlEwHFAK4L6Z/wCsf00ufQzkuoSNS991N5yZ+u3SmWil9w/dXUbXB+7lgOelo4mBlrU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581436; c=relaxed/simple;
	bh=R019XP5wN1y2BhIhyL0Z+G/8HIEHKnkKoUSVfyMh7Sw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L0dZSDOEBkSVdH9qJ/IeKYfjEaQJOt5uWk0WQ9t2korVNebKjknO8HhytggobBHkfClBZTiEGHsCM8H4vr4+liZZ1SQcDbbBTbj5Tfipi0aMuFH9YC+6HzVdpK5+v7pyuFr53jd5NjcQUTQjYetw1HNURsKwlGgoN5wUvog/1Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PDbmmjUF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f2/U/nsE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKfnue030963;
	Wed, 22 Jan 2025 21:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ggPHqzs6gdaQ8gyp6GX6SFf/VFnD0VTIxrwCSKXkS3s=; b=
	PDbmmjUFC+/1aJvMqr5jeLPc5TULTvnRY4QHbrgMKY4II5K4WYLHJxNsvlKkNz9Y
	D+AyKGXB5OaHlonyj+YWokldBFAwNbpV9eXrmOQwi2ho7HTuUXOQQ2LUNXIDgIX/
	7UxW2nKSeltS/fx8JQ9Sic/6fUqO2OfDm8jmui8Nxn+SnST7TpQMmX46Vgw28/Fd
	VD4KQurv3YDy05bJY6kUx+NyjnkagsjRKecHN8pNUoyrw9NwfMhjaNEqR2/4O22o
	v+GvK6D+seFKP2iag6SWqRGihJQ8mFIg+fk8pPby3C2/Kjy/0zaq6uO6lZc0/MK/
	/9eNlsNZtU8h3ofey7N5mw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485rdgqn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 21:30:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKRZUu030562;
	Wed, 22 Jan 2025 21:30:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 449194c7rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 21:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4SSBfe1jZ7VakH5VigyGuBCGL/3EBF/bkeIh40BQDECj75HrggxBGsIigsX1xZPUiUuuQNcpartRORdaLM7wkdFPDRuM2mvQnfNvd9duv8Ggo0rmaFJ/kfaUCJbC1BfxUDbRX23L+D9OBAVMrbqMHjgeo6mVZrWaiqafQWeD7RqGWT59xt94Eh+u4t6C2DWDGWFOIWDKYUVbxAOI44mCxmGoEv1KkwYYUPinpsUyyrH2BsRo/HVCAIAOaem6VrGm3PrldovFr5nll8QvhK+eCx//Vhb2U02EO3plV1vDU1OhIhjayHxXZRO8ZkttcY7kabysJRr+gZxi0cfO7GPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggPHqzs6gdaQ8gyp6GX6SFf/VFnD0VTIxrwCSKXkS3s=;
 b=hceCNBiE1v0FFL0CfdAQSn7j9flRF3OktNKLQ5vaHbxNK0Irm2WOmuOC/E0X68casR0igNhwc4kA4L8hnWmZ/eBEnFQEswPKbvWjM67e884FPRtmE/39wOWboVLuo6Cz8SKg/fb06aFp3CgbCFYsvVeM+qRBEGgLt7kmGh2crOt8XPij9VlZCkI8XmwwHgx+4lpIOmSvUjN8bKblK5QsmoP3bElKJtFnSdkYlomaSl2sMTWnSRqlBvr4HC3nParuahNrjs2zYAaCqtB4JFjpVztbjPH75tucQsQ8x6JMbyIZPBwJV8QNZJBkuLiPFcvT+ldOrfVZC6wgPEIhzrEa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggPHqzs6gdaQ8gyp6GX6SFf/VFnD0VTIxrwCSKXkS3s=;
 b=f2/U/nsE/Wgf63bzlp/CDoYUKGeIu2aWmPKHnoEHt7Cuv89sjqpHQ5i+H4I6KLK1dmb5x7+tJLoBOe6v+ovMXsjaxTVVY3lmBNfBMdeAtKNbaVF2CB4cXJPVcl57dfqC5nQrjpjIgk2lbVwcrc0prZND0GS35prqQyJ1AmYhqRM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB4974.namprd10.prod.outlook.com (2603:10b6:5:3a0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 21:30:27 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 21:30:27 +0000
Message-ID: <80dbac94-95b0-41d1-a089-b91a17b90b3c@oracle.com>
Date: Wed, 22 Jan 2025 15:30:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20241230124445.1850997-1-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::13) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc084e8-52ec-4250-2f7a-08dd3b2bfced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVlaREZqR0VuaDhLczdmdnA4cDBxN1AyTndWNzNhRFh6bkkvZ3BHN2pyalpV?=
 =?utf-8?B?SkwzejNDMVh1Y3I5UG81cndsaUFKUk42MVhoZ1NodXBOMDcxWVJWVFlwOWJD?=
 =?utf-8?B?aXJQai9uSTFLdWxEeVRWa3NTVnZjN1FhSGxUVHMzeEpIaW1qTXh1UUJxaWVD?=
 =?utf-8?B?RS9Dc3BlSHN6VnAxOEFBOFBaR1NVaFNxUXd2eTJHNVpaUHZiZlA1TkF5bWhY?=
 =?utf-8?B?SWZTeU9QeEJGQnkzVzllTHhDSkxmWDhDVlRRcjF6WGNmQzU1UU9Kbklja2lT?=
 =?utf-8?B?UTlTUGV2UDNyZzFOQW1HUFgwaStiY0lueXNhVk9uVGxnODFrMkRGNTh6YjRK?=
 =?utf-8?B?bEY2NTNVWk1JMmUrWmZHVTJGd2kyRkk5Qmg1cFFFRHp1U0Y1djllVFBwdHBF?=
 =?utf-8?B?RTNXbkxHVHd3WENaRkN5SWYvcDViaWdHa2V0Z2pBMFZZMzZGV08yYUtRblJY?=
 =?utf-8?B?QkJOOHE5cERIa0ZwMU4weEx6c09oSndYeDQ0Yk9HdWRkdU8yZ0JaTk9lM2hH?=
 =?utf-8?B?UGxzeFRHeVE0WkdYRDRzeWhqUzRtUEVla3R5TzV1RE4wMWJBQnRrVDFraFps?=
 =?utf-8?B?WkRxTHdwWUdBVEZSUnduN2dCaG9WZ2FvNnUzcG5jME5QdmNSQm1JZFV4YmJP?=
 =?utf-8?B?aFg2T1NjOURPb3NRV0JCNTFINndhL3RORmVhM3NrRGxkQndMcld3aG93VldM?=
 =?utf-8?B?bmdyUHBUeXRhUkdRUTR6Y2M2MEpOYU81blk3NFVxaUxrOWxEM1dUcUM0alR5?=
 =?utf-8?B?WVNHK21mdUFydFZBRm10VTZXRnY4U0k5cFhleDFZVGRZUmtiMzJhWVh4VkNI?=
 =?utf-8?B?bS84c3dWd2tYclZzQ21ad3pnOVg4RWJOOVVwUS9KbWhkSzFXbFYwK1BiVmpz?=
 =?utf-8?B?NFA4SzYwR0loRTZNVnZIZ1VFRjJPOVhjUFRUWmtXQWczYVVQZlM5L0RDNTRk?=
 =?utf-8?B?a1IwL2ZzOTgxN0kyd2pKaENra0ltdDlMby9lb3ZmR3JSaW0ybXdmS2FPK0xN?=
 =?utf-8?B?NzJJQlJYUGJjVkxjQ0Jwb3ZwYU5IbDROdVplTVZXbkE4NWpKZmg5U0xRN09P?=
 =?utf-8?B?REJIem92TGZDTkpvK2Z4empBcEdmenNGZW9nZklzWlU2SjBYWFlMQVZNSFpM?=
 =?utf-8?B?UFdxREZWb1A5M0ZwNk4rZXFicDBMQkVPYnFhek8zUnorZzQxT0d3cWJ2amZR?=
 =?utf-8?B?N3ZNNW42ZkJVdGJmb0RHeUxYZTBWNzRYQkxRY3VtMnJtbUk2ZzROZ2ZRMjE5?=
 =?utf-8?B?bkJXaStVOEowS1BnSllIQXppaUtCaURVSldxNGR3REQ2MndiRDROOEFYNkQw?=
 =?utf-8?B?T25DZ3BLN29HeTNhcUE1cjdDOVIxNkFPT3ZXSG04K085SHVhSVBNOFdZeHNX?=
 =?utf-8?B?SkdPa3VOQ2tuN0RQS0dsVDB0U1h4Vnk0VUUzaFhRTndlR2RWMisxbjA0ZnFQ?=
 =?utf-8?B?T0pCcnUxS0xLaG1KREV3UWtQbEdpZkdkaG5QaUFMMWllWkhjZVlQRUxZNEF6?=
 =?utf-8?B?R3lUZ2I4UUlSNjZOZ2JYem9iVXZQck5DVHRacjZjY3V2QlBBS0RYVTZyRVdK?=
 =?utf-8?B?OTd6UGIydnZtZCtPZkNsMHlzR0NXcWJlTUpFTjFmUkJGWFZuVmZvUFhwNEFH?=
 =?utf-8?B?UWdzSzcvUVpCYWlNdUJJc2VKeVJjcTBhWWxZZXpmNHZLeGJyOHFkdnlzVHBt?=
 =?utf-8?B?UktodEl0QzhOSElXTkNGcGFtQTlsZjhtRjFVbmtGWml2MStxUjMraUxhYjNy?=
 =?utf-8?B?alNTZkpwclk5eERUbDRIVUZmbGtwVHRyMHhJam1yYXI2RlZlRzBVcnZSOXQ1?=
 =?utf-8?B?WVJ1MzdkU0JZVGM2UkE2aHZkSWpwc2RkUzBxZVNxbXBWUnZ0elBjMEpCakdr?=
 =?utf-8?Q?54eOr0ekCUXfv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWZGQUNPdDdEK1lNQlZWQUM3Z1RRc0FaSTJCQ2plL2RoSVJSN2graTZlOTlN?=
 =?utf-8?B?dWkyRDdjYXc4dHFTdC9WQml6SkxsQWd0dDdUZVJobW92eExMZU5lTE4zbjZh?=
 =?utf-8?B?UllFOUE0RGR1eGh2K1EvQjBxejF1RldRUjBhUlZDNmZPRlhYTjA4Nm1temtw?=
 =?utf-8?B?RU96bW42d3gyWStjK1p2SWhCM3hCYzNHOVJ4bmVvc3FoUm5HcnVPaVZ2Rnpm?=
 =?utf-8?B?YjF3T2ZGemJiQ2Q3RmlNYjRnSkcwMU9YR3JRcjZyV1MyelM5WFdDN3VDWlpB?=
 =?utf-8?B?cVJLckVQaWw2QzV0MWMybmJ4OUhnck9jZVhMZmdDREZkck41ZGFEcU9idVNN?=
 =?utf-8?B?VDdjeEZFQlJlRWFzdnhmRWhEbWZPUHYycFdVRFJ2ZDQvazhSeVhhaUZkNi9r?=
 =?utf-8?B?aWRmSFRBRVN5T2xCY2tJYVlEL21hSkVRc2MxTmMzZ2hWZlVEZU8zL2tnWmdS?=
 =?utf-8?B?dm9JSXVaVWF3WUNReTBLKzlaK0JNeUYrNnZ3MUtKMzA0bmFOYXFBeXFkbnhn?=
 =?utf-8?B?RE5DVVp6akdlVUU5M3JCVDliM0VIRWJIMUM3c0RGSXltdUJBU3Btc3l2amlM?=
 =?utf-8?B?NEdNbnVONy9vcWlRSzY3UC9haWpVVnJtWWtCQUVQb2ZhV2pKWVlVbTF3eXlO?=
 =?utf-8?B?eE1hUE8zcE96NElrUS9yV2tBQTMxRzVwZFYvR25xTUZuY3lnbnROUld2cWp5?=
 =?utf-8?B?azZrb2xvdkdaMDFlUTI4cWR4cmFmU0gxUlNHaVhZT3A1UWc3eDJSVWMzaTcv?=
 =?utf-8?B?eUxveEp4aUJFTzNsaDRkUnhIZXppUVhVOUVDeTdBODdzWlhsNVhBRXpiSXQz?=
 =?utf-8?B?UUtPeU9mUXpBZkF2dUcxZTdDTSs0MTF2dlcwb2w5cGVERUc0Mkw4cGlqNVk3?=
 =?utf-8?B?V0ttblBSQ2p4MXpWb1laYkY0Ny9qZG9JRSswTGFla2xpR3QwSDVVME4veW5Y?=
 =?utf-8?B?VTV1bngxL3d0bHk4bVpoQk1BaGc4a2ZZWVRTenVmazBwZHRFNWY4WDJmY1Y2?=
 =?utf-8?B?MDUxUlF2WHc2RFd3R0hyeU56RWxVcHBINGR1aHUrMGNzVU55VHpmY3ZWV1BW?=
 =?utf-8?B?cnBheFFXU25Ta2Q3WmJtV2pSTUkxNEVQNGhFY2ovTGtNenY0S1ZBYlhqOFJ5?=
 =?utf-8?B?b2RkbHV2L3ZSSVhIVmM4M3VYdzkwV3hCNVRBZWZaVDJaUDVzNDJhUkZLaUNp?=
 =?utf-8?B?QkpOWVp2MWtRamh0THFlZXRRWHQrWVBzVkRYdkpxbjJQZ2lHMU84U25TaEF6?=
 =?utf-8?B?aTNhVzdJOXpKZVdhMytqLzlxVEN2RDZ4SG1pcVBMQ0xIczhoeUF4VU5mb0E1?=
 =?utf-8?B?aW81bUdZZU5XTjYzZjdlS0IxcmZXRjR0UDJPV1pWcXZFa2xJc2QreTM2ZXUr?=
 =?utf-8?B?RzNuMW0rWERRekFPVGEzNVhmY3g4N1NQY3ArQzFmYjUzdVJmdXFHVTBDSmFI?=
 =?utf-8?B?RGVSUlhuaFVXV3ozUDlPL1o0VlJLSlA5YjJTU05Wc2VQZHlOYUM4WnFnUE1F?=
 =?utf-8?B?OThxSG5YeThGdU0xWGpNNzU0aTV2RGxUd1oyd21FNlRBM2YrZko2WEwwRDNm?=
 =?utf-8?B?OUdpMWRMMXdPOWpKelhFdkxCNmo1dVBFd2V6YjRKM2RmeXVVT0NrMVUzTEVi?=
 =?utf-8?B?OVNLcTk0YmZXRzFtM3RBSWVsVm4yTStOam5UWW1wYTJhbGQxYnVUSnlDeEtl?=
 =?utf-8?B?VDFJWnk4MGpHdVd3YWJ3bFZiK0RxNDdFTGRKU1BCb2NNRkZSUWRxby9wL0tq?=
 =?utf-8?B?UDR2RThwbGhrN3dHSXo4c2dRcTFxc0k0S1M4UzJvSUsyQnArN1NPYVdDdTBZ?=
 =?utf-8?B?ZkoyUGRkdWVCejltK2xjeWplcjVWRXM0a1JYV0xRRVkvUW82UmpFQlJjYzdy?=
 =?utf-8?B?YjFBaTJJTzZ1R1N0U1lJeVllSlo2V0p0Y2RTdElnU3MwbUpjZjlnb2h5SGZ3?=
 =?utf-8?B?N0pUYkZjdW5ucEVzQkliN3FTdmNNRkZ5WEpkQUFNRFZudEI3bGRwdTVIekk3?=
 =?utf-8?B?WEVUM0NFbS95ZGN4c0piK29qZ2pGWVA4TDB5eGdsVmUvaGZ4czZ3VlMrU2V3?=
 =?utf-8?B?R1VhbkMyOUpKTGFvNmNrMUVIUFBUTkVUV3RodjBtckNkUU5KeW5wT2hGcXgw?=
 =?utf-8?B?WXZPOXgvd2E5VHhlL2MvTEZOMk9aVFBNM3pXUXVvcElna2N1cE55bWF6NVU5?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fNKCDyHj7GbhWwDMxcxY2gpoqi+W96syAF6fkNe6ncuyS3QLV9rbSW7/Ty3Go3pjQ+j91nRzVJlNNj7I6sA/q3cSUB7OqXK6grTtZD227xH5HBIFA0hCvBzfzbUSRlU4ZVw1n/gwif8TB0b7aZxpFhFBwSkBPV6PnnKcYtBciFXBPeokIr4VXJ6IVNCQh/tsxLssXBkMONSRWfZa2uS/31kSgGwkGjBxMfT7yKGjdcr99XPMj3IEqt3dE2JTr+4k7WlvYn9eR45LsexzOQewGX115cP2QvMeC5PjkmIUaOYrSgHK8OTYVOMCqdiVGPwy8z9HKHc4ic1wY39qICHj3XnBFia0x70uJDjQ1VZJh7KB5O4NM3PQ4Iu6cG13cLGcSqCVyH52D4aSWL//gbtZVxYIvX7KBAds9nTGfrmXOSXX7tKvzGq56MFj9KdbJAEGgbxnDq5fLU6n3oo1RK5jGZYT8J+ehZjnr8PvAJUB7/BWAFswyK6SFtXMiwbcYkFonbjfof9gKh7SLZZD0hVHRuY7X6/iSApFLn6+0kzO8dTKJ+xbSTpgx9cmxfI+/OptS40oz+XwNutkKc2brpuB5ktCeQL3Fg0Xp34azIp4Gi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc084e8-52ec-4250-2f7a-08dd3b2bfced
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 21:30:27.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmR9mzpXO87DteKbb4MtHn2tUGygLHxWM0Wza5beGj/kr/c3Oadvdf3mpuy6zmDiL3QfwAL/7bvApQ720MWhL49L2d//U38+QkNbvpvrWlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220155
X-Proofpoint-ORIG-GUID: DClw4inxEtMKWMVi_42XNl3RmU0XLmns
X-Proofpoint-GUID: DClw4inxEtMKWMVi_42XNl3RmU0XLmns

On 12/30/24 6:43 AM, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API.  
> 
> In this series, a new UAPI is implemented to allow   
> userspace applications to configure their thread mode. 
> 
Tested the patches with a hacked up QEMU that can toggle the
inherit owner bit so I could test both modes.

Tested-by: Mike Christie <michael.christie@oracle.com>

