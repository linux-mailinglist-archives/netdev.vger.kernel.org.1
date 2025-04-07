Return-Path: <netdev+bounces-179723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B091A7E5EB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1296D1688BB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309A92066C7;
	Mon,  7 Apr 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Swbf0vMl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ImRxk7Yq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2E2066F0;
	Mon,  7 Apr 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042018; cv=fail; b=adbsRLbbNl9t5yhbudmM6+SnTnGFx2PYC9GiOoJl30hsoEBu3XyvNkwX2lzCKlInC5rBKg5k8LEnh68IhDQHndUjhgFXgTWO0/1Jn1h29skcvcohOmGXoeelJF6dC/oMZ47WfdOaEbPO84NSX5T1WpNVvybk0TyXYfc/ugOqoSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042018; c=relaxed/simple;
	bh=e0fSBIJZu7y1W0dYaXLOG5qNVeHrlPc8tsCHyqhfR9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pEgBkZk9fJn4BikL1z1e9V0wjRx3kbcfB6462yW/9ZzVy/rdFsfLezRIgdgJ85SOj3aF9TsIhZcKKkdhUMUDEo5QBD4QU66hBhiK6rlTSFM3tQS0jsVhMWpV89buqPXyQ9QmYlNJSKtwoS+LBE4IKbsz0KmyB3x1Ul3GqIKnEJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Swbf0vMl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ImRxk7Yq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537Fu4LS028626;
	Mon, 7 Apr 2025 16:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cHZmYemldd/upDeiz2Yat5tEJmJlwHy6DybWA2e+aoI=; b=
	Swbf0vMlNHo2Wyzw2RE2Svkyc+mdCJrx6F17BK7RW0hvT4A994nofU4ZbN5/O1Q2
	CB/hNmWIW+1vQLTIjE+5DGFFonLEgpDV46LGXO/2apJ2sZn6s2qM63YXcjmUfh0X
	wFoSgWXEUjMlQSOjNgcjhnTmfOjP4VvpnCWrSF96LhAaMRIb2VnfEkal9jw0QZHg
	lNhwBEgC8ROqEU89rQ4mhva3XJBxpRtIIgGB2IDhJUeRgjSAScs9v27xNKyLFFli
	GCRf2gqKOmB5kvkKTmGauoy4eaztKQkKoa0iyA3zINoDF7iNkpTKDMB5sHTjcEO3
	LDHD/kkWI8LB/v1kDO6EOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxctyr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 16:06:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537FxudR013671;
	Mon, 7 Apr 2025 16:06:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye9mf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 16:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5M0P40/cDjjH9V+I3Vf1sMXEEYk2175DQqRIH3o4GPMZhLX3fZqKAsubM5KJyf+i3tocAtSbTpVxHm3ZMhEv6JcZVKU+YmxJJw93gKrxBL3+qemy4SzvkVf2QwZmKWhZSIxNWfq0G9y4zoONML1VF2Q7llHGgFIxhG1QNGbm86xUUDGBPiYaPl3yUnTXhUysrG/Y/DMfqZHNkeF3AxTdnE9i57CechrxNRb0HIMgEPMUBRv7drHFTqaaQs1sKDUlWhIEKlRY6uKWvIA1eTorELchxmvR0WlhMAlAbL99+SuXuVtk7/w4oDTyYXAP74C8wXpndZowZaHhfLPNZZVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHZmYemldd/upDeiz2Yat5tEJmJlwHy6DybWA2e+aoI=;
 b=svpnXUoqFwJKUVeWJJixvasyKnq2V7aURJibBwlRbu+exQIjsT1BLMbJy2oiqXGQD3K72hz6g5a42r8JOwDBeiZ8CGvWm5z8nFAkBgFtB2rwiUpHrlITvYl8uS7FRAXfS8h8ldOfd126p5VvlSlnS9RcL6j1u2sltWwKRr2cqRJbOUErjEQP57pkR9ExtGIm1tTpupk88JAs0tOG8V3uTFaFMMCrT2aTOb+Ca8AXZ1+GwtVjYcknz1cOBke3cEZWK/3GcPXC0C/srZ7OWIelFAw09Qmn2ORiLL9r3kDfWi1gRHT7c6eFc+h6OiBf08t+j8mq7iGfGikHQKxcrFABUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHZmYemldd/upDeiz2Yat5tEJmJlwHy6DybWA2e+aoI=;
 b=ImRxk7YqugVtoNEX0XcNTokcimUnT9hXxzgQknmlg33UfOYwoFb4Trh+SAznW7o1ufrAbDlL2PGa/FeVgjkIgX61XgBdeOkGzAq3BOziq4u5BPfCSqRiNmMzdnXuFPLE6r+vZFARXXuUZvUZHehcnwC8Bnnp0j04xaL42UxfWNs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 16:06:47 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 16:06:47 +0000
Message-ID: <76a7e782-6a7c-4704-b7c1-2459254c1362@oracle.com>
Date: Mon, 7 Apr 2025 11:06:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
To: "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, sgarzare@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-5-lulu@redhat.com>
 <20250407041540-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20250407041540-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:5:40::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: a83c4c69-7512-49cb-8db7-08dd75ee32d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU5nMEJKa00rc1FlK2kxT2YzY3YvTnMrSCtFbXB6VlpTRXN2KzhXZWszL2hQ?=
 =?utf-8?B?K2F2QWFncE1reFEwRXoyL25lcFRNN1UzbTd3UEpLcWJzQWFGV3NCYy90dGdD?=
 =?utf-8?B?ZHRQVVd5YTVsN21GaWtmNWlyOUdkcGJack12citpZ1MxTDNnNWx0ZVhxSzhw?=
 =?utf-8?B?bUlOYlpPa042ak1KWk51MlFIS0t2RXhGemc0cTdOaWF5eVhQTVVCMzdTcTB5?=
 =?utf-8?B?clJ3c09qb2k2NUVOWllVMXFickdGRjFqMEhqallFcmUvOUExL2pmVzZaVzgr?=
 =?utf-8?B?QkljMnNsTSs5cFZPN3R4dGdhOEduTmtzZGkwVjlTSjVKYXpBZVRYVHFaUjRV?=
 =?utf-8?B?dW4zTzQyVnY4MS82eWhvbXpUc2txQnZxMXo0c1J5NDY4N0MxdGJFcVprc0dv?=
 =?utf-8?B?MFJZSXdDN3I1QWZJY3I1ZEczZGxWVzlQL0hWY0Q3THl1bno2cnNXZ1ZmdWQ4?=
 =?utf-8?B?Sm5KRWJpT2hUU2pkUERqdGNBaGRoQ3hPVmtzNzF0UVB1bDRFQUo4LzBxWWVH?=
 =?utf-8?B?UEpZdmJpdVVlOUdCeWFzbzllOTJLK2h4MUhkMW9SYnF6eXlvejRFQTduYk5U?=
 =?utf-8?B?THdCZWY5bHF5ai9LbGQyVFJGQXRJNlQ2RmJMbjVzdWpmVnJwMk53djZxdTAw?=
 =?utf-8?B?VGlXWEEwK1pUdW1Xdkt0blgwNU5iZklqNm1vcldzM2lPOTJZOVEvV1RNL0pF?=
 =?utf-8?B?UUIyWDVWaWNacjhiajBKWFg5NlMyNWxXOVFYaTdBOWlibUNBaU1VZUhMSDJG?=
 =?utf-8?B?bE5JZlhhZHIrMXAvVk0zQmIzRmgvUlRlMTJ6cFptcEkvaU1WYm5QODlKekhS?=
 =?utf-8?B?Y1V3ZEhsWlZCdjg1TEJTMkhtNUl5ZWZPUm5BcVpmcDB2Q3ZvdUNGK3pxQXRm?=
 =?utf-8?B?a1NDVlNwNittOUVxVFFJaVF3eDVuamRIQU8xWjZMamtXS1EycThNeERVZTZo?=
 =?utf-8?B?MytDMVhYUm1RN0FmRjBpOEtocXdDK1JSYlFnVHk2UzVuSm4vWUZFWElhV1lm?=
 =?utf-8?B?dGpmUGJYY2drSTBwcTVOWDJzM1UrSDlsRnZPbVRvSVZFVTdpTm05RXAyNUY0?=
 =?utf-8?B?Vi9oWjdlLy9MbSs2ZkExY1dUUVhzd3pYck9wSzU4L0JvZmJwNXFwZEkvOHpm?=
 =?utf-8?B?akgvdFB6aTRwMVh2dnR2cytPcmFKNUdRMVlHU1hLVldFYlZxYU9GcXRlVHdS?=
 =?utf-8?B?RkVtdHI2NEFxSkRyZW1aMzRwb0ZaZTdLVENRTzVsU0ZLdUJVcVZSODVrbURp?=
 =?utf-8?B?RkErSkM0N2JyS0pBVmR2bWlraGtlbUtrNHpvcXhudmFmbDVJeGc1YzNVeUl1?=
 =?utf-8?B?Q3VSWVRQQk1ZSDlLUEFIKzE4UzQ2YWFWaThJL01sNi9DZ0lRdjNhcW1UZjVw?=
 =?utf-8?B?a1l3RlM5R0lXQ2wxTE8rcWlpMC9WNzhRUThFaGZSZE9GQUVwcUlqRG9aeW1M?=
 =?utf-8?B?OXA4WVdhdUpuVW5LWGRrUVJ5Q0FJbkwrRnA2QlNBYjNQK2lNZDdVK1BzZmg5?=
 =?utf-8?B?dDM4Nm56d2tuaEVmcnRSSklqWGtJMlNBMFE1YTRXMHBPZGZEQ3gxUC93eHZq?=
 =?utf-8?B?NVV2TUJGV2xtK1BIMFNOVytpRDB4OHhaWkVBYk84Nk5oWVZtVzlMWmFBeWhE?=
 =?utf-8?B?TDE5eEhKeTJQTmVYc0w2engzTFQySTVLMjJJUlZRa2F6WC8vOGYvMGM3WGRw?=
 =?utf-8?B?ZzQ1ZEcvdTRzVGlDUnRYbHNxdUxVUzM4MWYyRk8zc1VMYzRIeHQ5QTgzRkk5?=
 =?utf-8?B?dkYvakpKd0FNTHNTSy9PQ29VNWNROE5zTUZiT1RuT29tVDlNeW9Qb0lONzFi?=
 =?utf-8?B?ZFNqRmdxbkMyYjZMT2FiMTVqOURlQnU5bG0wUjBtRWNRMkpIUW03MXdHbkxY?=
 =?utf-8?Q?95sCmiZT5uCn3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWtjTU5TdzJXQVBRM3hHWDJ2em02eE51SHRnN1YrV2MzQmhDbFg0Z0J0L2xt?=
 =?utf-8?B?VmdLa1VlNDRPNUgzNUdFMTdqUUYyeXh3YUxKU0w4eUdiREtVK01pYmxWN0pP?=
 =?utf-8?B?M3ppb2x0c28wREpKSGxZRk5ldVBPTU43WXNBWHFYcUEvWXMzMUY5c3NPYWxQ?=
 =?utf-8?B?SVFPSVhYUkFaRXk1MlJoTnJ5dFdXS2lyNUNrTWRzL3RZWDIzQjc2VHJVdWk2?=
 =?utf-8?B?S1kwcTZ5VStmdE1nckd4TXNTWXJUK2JxdnpDYlp3MitLV2loWGhBZkV4SmdJ?=
 =?utf-8?B?RTlhSXdOOUxsL1NCNjJZQjAyWk9IN0twM3VlRHpRMEJINjV1a1ZoMVlqYUM3?=
 =?utf-8?B?ell1cUtHZyt0eDZ5VkZmZHNaa3RtOUFUT0ZiaVVIWmJ3ZCsrK0VPRjh4NkNn?=
 =?utf-8?B?QXNxVzZtRXhCcmI2dkxHVVM2d0xrOS9UTUx0dTdHSEVsM2tvRFlPM2o4eFA3?=
 =?utf-8?B?VUd0OExqYWxFMHNwUWZXY1N6TlF4SHBYOWd4bjdmTVlzSDRNQXpWREF3blIx?=
 =?utf-8?B?WC9LdlExZjJSOXZEeU1TM3dpMyszN2xrZEhIREJDQlNzT1I4MkFINXFFd3hx?=
 =?utf-8?B?OVkwQXBSNlFNS0Vsd0xjTTB4NGFtZC84V0FyS0Nkcy95WEgwc2ZRaEFjLzhk?=
 =?utf-8?B?RjV4VXdjYVdVdnN0ZDNHSFVUcDRiOHhjczJLUjNOSW5nS3EreURScVNQRFQz?=
 =?utf-8?B?bGFmdDh5eW05cmhjZFRRdkNIaXBmbkFYWjh5Vzhic2p3OERybjgzMG92UGIz?=
 =?utf-8?B?MEo1K1hBeWo1MXhUWTdmbWMzaFdpMzRpeHcwbktJWXZWd096VElwUVU5RDFx?=
 =?utf-8?B?RXJsWEQ2ZGFNVWRwRVF1TU5CVVVjaXEzOFZoWDkvR0dTMDNDWDZDNGZpL0pU?=
 =?utf-8?B?WmxpK2VuVVNyL2x0MmFaMU00SXh0emtVRCtiQ3NBY3lwT3NYR1FRL29BMnZC?=
 =?utf-8?B?cGhscThwVEt0amFQeXkxZ0V4K3VwQjRhaHNpRE1OaWF1SlJvU0xGYk8yZzNu?=
 =?utf-8?B?cnpheTRDNlZxMGlJVFVGR1dDVUZ2R2Mrb1l3VWNUTXEvRFJLa2Z4a1VzWFVU?=
 =?utf-8?B?dzhWQUJUQ1RLaG44MGp5SFF2YmdXcTB0Q0VCc2gvYXJyT3RMVXhqaEFkTzE0?=
 =?utf-8?B?RUp4RXk4eVYyV0pGUFBGVGJhMThyQlF4TjdlTGtzSTVmR1VGSGh5OUU5NXhx?=
 =?utf-8?B?RkpqbWdoVnJFcWMrbTB5aDV0TU1oRHRXWWhwUnVvaVFJYnlGeUNpWURKQ1gy?=
 =?utf-8?B?R21ZV3doL3RIY3M3bmVwWnUwYUkrSWZMbFRmUDh4Yml0bklSQjgrTjBhQjAz?=
 =?utf-8?B?VjkrWkFlU3ZNMTRHRTNoZWl2dXh1Z3VRNk5uc05Gb3lnVWt1Sk1rcE5aWUE3?=
 =?utf-8?B?RFk0UkVuTkg4UjhJNW1NZ2k2VU1PV0VSN1dGcnlRUXhaRXoxazFTMUVtdVIy?=
 =?utf-8?B?NyszeUd0b1RSUkhhb1lWVzY3VzI3akFZTjFNRmRrUWZBd0FTZlJFdWhqSmg1?=
 =?utf-8?B?SWgwNlQ3Yys4enMzL2VQZDY2Uk5RakMyL3J4VTU1NmxBZElwQ3VzL1E2bmk4?=
 =?utf-8?B?SnA0bjBnTVpXeWxCSXRvamtPM3FTMkZhdFA5Q2dDSE1WNjZDbEZPRVJxdE9Q?=
 =?utf-8?B?WThoRW81OVF5bTJZTWdXbnhCYjljc0haTDlOZ0ZyY0o2cmxxZ1VkTjcvL0dO?=
 =?utf-8?B?SlhQQnBIYmNuK3lERGJwdFYwSFM0Q0E2b2FBdFhLbGxKeGVndG8rY2lvNTFo?=
 =?utf-8?B?cS80NmUvYzNJallFNlcxYnJDTitGclVob1N5Ym5HYXZWc2RqWVBBb3ZCUy9I?=
 =?utf-8?B?Z0toSlh4VTc1bHdCd1V4aHdkL2ZHelhiSHFJMlEyWjA5Sjc1blAyVU55YVc4?=
 =?utf-8?B?WmM3UGxEU2xnaFI5eklJNFFuQk96akdqQzhhNkNnOXM5Z2VKZCtmaElkUEdM?=
 =?utf-8?B?WEtvQllSaFlYSkp6OTFYOUdrYTlkcTI1b2UwRW0zT2duUktJdkJjWUlzcEFW?=
 =?utf-8?B?TVczUzRCL2xZTXU0SW1OZHRVWTh3QUxsN3RQUlNsUHlwa0xWSG15RUFLM1dt?=
 =?utf-8?B?YytCQlZZYXo4N3dJVm1aZzhCUTkwb2R6SWNTWWJMN0E1TVZSOStrdG1xTWtx?=
 =?utf-8?B?cWNtRVl3WjBic3hMU09Ubm5VWElXYWdkcUFHNUVKV2greEt6dnR6SjJPYVor?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qHSj15meWDn/Ik4/ZB4K3+8pgBKNnaHVtQMHhWHjR5ygl/Bcvmo5mmHf3LbWcDWbBrDY15lOTy9P9/4KH7oNbhJfX4pwB2p3hPeaURymmpfpxxTZMPOKf26snedVEg0CMCy5H4C4mGGqFOBzlGGIfKnwJgUzH6y1mduh0oxhmbbxcDR7tGh6sX4bI3bUGSTe7xpDmvlkqYO9DyMdeJLzZD25RJ7tOswvwT4fazWEhjBC7u2v8fBwRZWyxrCJxO15frKbcDbrXyaRnrU/4eHd10dzeVDX5CDQ9E2bXn1gpz4MOjU8nUvBMfyIusmk6UVhwMWgWHFWOTRUo7o+nAeTU/wUEQz/H+CNLMKdk28BSXp6SGZTbUXiX23t0bZtvSqs89mTastGIJjAPNCWYTv5RkKPz5Br5sB1GXsi5csYNMwy6pHkwoka9nm0hWvTSLFc35/iDbxddlcuxIRSkuPAI9ndygfdeqbwKqSJAlYm225MqpOkrp3f5NXQEFMJ+mnZk7RxrEd7OHBgIO25Jq5mcXdldAdNytTFEp6sospfw0/cDjwM1hLQo5ZBd6Y05m2R8tURy5g0Ri1aeY4nw/zibICD4Wuf8Da0cPhrd8j3t6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83c4c69-7512-49cb-8db7-08dd75ee32d3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:06:47.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHCUlL66maM0StPbuOQpjTvnJKeqHoNZFaU/CtSkWnaDZO3v8nE8T/GY/V1FRVn34EFdQtLqJZ//Qii9sHipu/9R9stg8fymdLFqg5sJ06M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=880 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070112
X-Proofpoint-GUID: Uuz2SHQJkoMWXUsjL8rmew9a-TQDAU3M
X-Proofpoint-ORIG-GUID: Uuz2SHQJkoMWXUsjL8rmew9a-TQDAU3M

On 4/7/25 3:17 AM, Michael S. Tsirkin wrote:
> On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
>> Abstract vhost worker operations (create/stop/wakeup) into an ops
>> structure to prepare for kthread mode support.
>>
>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> 
> I worry about the overhead of indirect calls here.
> 
> We have the wrappers, and only two options,
> why did you decide to add it like this,
> with ops?
> 
That was from my review comment. Originally, I thought we
could share more code. For example I thought
vhost_run_work_kthread_list from patch 2 in this thread and
kernel/vhost_task.c:vhost_task_fn could be merged.

