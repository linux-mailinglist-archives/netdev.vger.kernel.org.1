Return-Path: <netdev+bounces-287235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF5EGZpYA2qh4wEAu9opvQ
	(envelope-from <netdev+bounces-287235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:43:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCEE524F09
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEC67301CA40
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C33D0BEF;
	Tue, 12 May 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="1quqzKIL"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020095.outbound.protection.outlook.com [52.101.85.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156083A599D;
	Tue, 12 May 2026 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603902; cv=fail; b=eVSX3nSHNhNN4o29T3IHhhiWZcWqbz7bMqSXkmt1jK+Twdqs9OyAdJTFqhZA+Eh1tdJSy7M4NeohqSG0VQHoAB+rKEsCrOnAQobesLSSYmthwmjYKwHaAAEVqDHrTrknGIGi1xdj0oCYD1SnCCwo99sYJ2j5kDlKxmMYZVu1EXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603902; c=relaxed/simple;
	bh=BOtpG9ixd52JstWVpK2E/lTaNXC2m+OPEGLbRG1dy+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbuf43jDDC1H2H1duEBI5XMM4H/yy5xUiBBYOlx0rsgkMxhHVUPpanvf6YUEZEqZhNa1z9ZOkAG6tWXsRO85Jy/KqRZ6tmv7KV+SQy/AYVMXTIiUFZRsSwsWtPlvIRZtDSpMatcytVKF1sQxc6jZ/VkJecoxBaF47U6aiV0QAoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=1quqzKIL reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.85.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Blz00ExScPgwcl80f9bQnh0c6YOQsHOjwkvZfw+ntm8iOsECZ4PvxLlk05MUael0d+EAQCjNNZm1mUbV5TYRaqq71nwc7IW9e1/ZFoeYnkAnnz28k5GnA1m3E5bCd+pxlms52Wfym+mulVvMPHhnOdXmwhRhvtKdDso5KsHYJazMXeXF5rG15wwKP5mPV0FwOXWtjkkbLxpb+638s0sZRdjTya1k0TfSgPvPcwE9QNHb7t9WvOvoifsoTmDYrbmzNeQWrOoH7GoVn9yTKkUWOjI7bSS1ogK09Y18iHR6w5H1Qfkw/1QuBFTq+xgM8Rx2TA4qnHjNL7Nq1Ey//86LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34CrdWqb7zfrJ9Slp7ql6qJSNeIEJfsxuC5zFSKQteY=;
 b=qeCOH/Fx/srd3lVeFTwM9sYZUpYHpjMENHHrzGuBVneHYgQADVjCLSLI31xwLxkdi7fYAmGbz/lAxidpFWsZOoWiozYY1UswGkqK9mwzj44wgeRRdIzkHadTYKodvN7Y/5aZLAf+1oLmJWLnV49YUcuFlO6VuRPPMROljL4zSsL4eMQkxN31JGW4C1u4Hvy5pDzYqDghcV2WiwgrQi2YDTdVLZ3lOi6DFx4mihrYTaRkBAquKRwtWdKG0LGWFdvQXXOfmK5peTBN46KUFNA8Lwd8yhVOrb3zgHTKqnBPy29QjBVXS6KyqXJ2MhdJUOKQzszZU2DNldVlY9joxGYFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34CrdWqb7zfrJ9Slp7ql6qJSNeIEJfsxuC5zFSKQteY=;
 b=1quqzKIL4npRjsSUpSOCVYezbdC/+Cw54BoQc0jWkSOddU0HH6wrc63Ch2Rn1iJ77II22/oEcxkSVIMi88nXj3EDjHz9UWOmDJ3g3g4vdzvNosGwzF5MkwdUVwN0Podn+Ex+kGhM2B/tnJ85RPgu/0l9q8LujO4sZxkvttUlQr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH8PR01MB994293.prod.exchangelabs.com (2603:10b6:510:3a1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.15; Tue, 12 May 2026 16:38:17 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0025.012; Tue, 12 May 2026
 16:38:17 +0000
Message-ID: <aecf0ac6-0dcc-4b7c-bcd7-dd78082161a0@amperemail.onmicrosoft.com>
Date: Tue, 12 May 2026 12:38:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v41] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260510163228.443778-1-admiyo@os.amperecomputing.com>
 <9f4d364ebbbbbb697fcee022991a546e60692f11.camel@codeconstruct.com.au>
 <9519a497-c10c-4abc-bcf9-414467f74ba3@amperemail.onmicrosoft.com>
 <71b7c8f40efc25fadb0aede6be888986364f2d53.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <71b7c8f40efc25fadb0aede6be888986364f2d53.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH8PR01MB994293:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d6b80f-0d5b-485f-57f9-08deb044decf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|55112099003|56012099003|22082099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	hxegRY7c1t7Hi9JeUGSQJFHCFcZWEH9ZFnywJuYWt9NEY4zpRRoZjacj2EE4oq/CmArhUAzjKhQxkNxKcGxgit+bryvPcvWLv3Bb7K/nzEsoFqwhN63ehH0Qnrb6uFtpdskUzNAyciKpaA0CqDwjr6CRaw+ZQ8Nyzgx/CGGEFhCbjoGYK+Q8+uY9jdO86rG/pIxT1IJBnyE35cfG3kTHqiCXDgj6+TEf2mCI9vVY8F8AElsO05T/AYhKRW+TkXC9q0MvFuH+DSjJg/nAXftq4hEDyfF+jPG5ln76I89GKDnorOw4uMXK/XeQb6cqQMpmb4ZaUo+6MiIapljDBsylYJ+uZiOnYAhn4W+a8F1/9zN6NKRQbXqpVbugTjVeODZU9NdJ15Bz6HNoquiOlqk5N4kEpoUllrvh5u6ojvzmWhcLjGFhxG0a9Y0NCBj3lNKxetDElf08t+0eESSbs2KHQB2qJBOAhGAVCiXEvtBcJ2fta8ArUXZOYC3FFkFmzTJQRMK76D2PeSMtBS6N+p3rLOsQ5BciaZoNoo2+R7293SfjpxoBM+5t5IxUkOtVL/qP12BoEHaUCt9qqFBqlmA8coiDw0nOFUsJUlw/FULxYWDRe4iAlfhsTrmXhseTzaJY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(55112099003)(56012099003)(22082099003)(18002099003)(11063799003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDh6ZktBdUVZR0RyMXRBR2pNRWFzTDFMeG5NOHp1MWxaVmIyWTJvWk9SLzkx?=
 =?utf-8?B?dU11Ynhvc1d0bFlJNzdMbXAyRDQ0WUFpWDFuK1FhUy9IOFEyVzBmUVBlV2I3?=
 =?utf-8?B?VzNFWGFiOUdmSlVvODZ2NHk5SWFnemxDSXI4ZUFHRitHUDFYVTNEYmpldGlC?=
 =?utf-8?B?QmJBdnZUR0ZCZ3RXU3ZTbFVqS3lBRm5uMVluR2ZzTEFYQjR5Tk9pNHMwQ3A3?=
 =?utf-8?B?dEI4NmVYOFNmbkFxUC84MGhEZ2grd0RuRnlzOGpPYXR1NGJ0L1o4RkZkUCtM?=
 =?utf-8?B?eWMyTzFDQVcvNGRoNkczSnB4V0JrQkdzVDViV3VYRUErdUkyUGQzTmZoVloz?=
 =?utf-8?B?Tjd1NnQzNjREVndNOUNwc0c5U0Y2Qm1sRnUyQjk1RmZNazBGRnF5Y2o3MDUx?=
 =?utf-8?B?UE5XOHkxNkpWNXhMcDlmbFBNWndpb2ZFdGNhb2xPYlRNdDlOZzBsTWJTWDFj?=
 =?utf-8?B?OEVCdTFTUG1ES1Rvd0hHVmE4SndEeWsxclc0SXdGdU9LVVZGVDBoL05VWm9V?=
 =?utf-8?B?OVVxWldOakhhcEpwbzhDbmoyTWJGOFRYNTd5QlNzcnBJRjFRTGxTYTFXSEdt?=
 =?utf-8?B?SDBEd01ZdHlBeCtDaEdjTjRmTExzc1lmZk1FY29oVDZGYWJpYWVqeTNZUWlT?=
 =?utf-8?B?ZHVMbCtVK3psM1Q3Yk5EYVlkNHRjWk1zeW44ZG1EL0NPSUkvMDAxWk8yKzhn?=
 =?utf-8?B?OG9sZkV3MThHU3VJNCtYTmNPbDdxdlNDZVZBN04yY2VNYlBLc1JTeGdOelM3?=
 =?utf-8?B?NzJYMm5vWjNRRTN1bEVINEtYK3VPZkxGY09RWXJoTDZGa1JTTnpBOEVCR1R2?=
 =?utf-8?B?NTVPWmZHeE5OOTR6R3hHU2pmNEo2RG4xcDNSUDVtT2ZhWUVMUk41eGdMRktW?=
 =?utf-8?B?Y1FxL2hOWjV1V2RSS1JJWXVyQ2NmWjdtRzRrYVIzQ0xka1hoQklSaUJiTFJq?=
 =?utf-8?B?VDRYdzlRU2F5SGtFT2FyQkpVaE5XNFRTZFJ0c3gxQkZaaHRwZ0NnRGdNa1ZL?=
 =?utf-8?B?THdCdHlseGJzZTh1ajBnZ0M2NmVBT29FczdlaE05M2Z2UlpTSVRPcTBMUGxm?=
 =?utf-8?B?YStDd2ZHNUxKak02bllsMFVnZkFpaHNCcTRBRnFKRmQxQ280SkFrR2tNeHJS?=
 =?utf-8?B?R1h4QldOblN6NGhid2Q3WHhlcU9tT21waW9MUFIyemJBSzA0SVBLNFM1bUJF?=
 =?utf-8?B?ckZocGllSDhvM3FZYXVPZm8vVEFWZDcyZXpGUjFOS0Rwc1hqLzVLZUs3eVBH?=
 =?utf-8?B?TlVRZXI3MkhHekhpNmlNQ081S21YQi9zOHluSG93VDdleUNrQjFQQTlCOWh5?=
 =?utf-8?B?MmY2T1kxeFZqdUlnbmhRZzJUcW5kSEFGTXRZYjlnQ2VXTVFiQlM2eDd5Mzhy?=
 =?utf-8?B?alV3NVhIdmpRU3lmdUlmRTBlOXFxa2dQYUh5MFErMittaXBLd3g0TytlYUlL?=
 =?utf-8?B?V3hJRUpVQUtoeUZ1cVl2VUxncS94QVRHQnRPZFVXZldGSXBmb2pDZ2hIN01s?=
 =?utf-8?B?NVlZZWplVkxZeVROYVB4MU8vRHczbTFaWStLZ0hhbUtIeTZHWFh5MnM5NW55?=
 =?utf-8?B?T2U5U05GdVlBOGZCdzZRdzlJendJbExyaEE3TlExTFlIdzdzT0E2eWw2ZTJX?=
 =?utf-8?B?d2lwTXltYStJcWtjZzRYVXBDQlZDekFBRkgxZVBoVmY1THIrSGRMUFI2RGVN?=
 =?utf-8?B?L2daVVc1ZzlrSDF6K1c4dDh2ZlYzdjNpeUcwbU5EdHNrQVBoNXdzOUpocnlM?=
 =?utf-8?B?TjBybEc4NDg4aGl4bW5HVkJtZE9tQTYyWllhYmErVXlOY1NIM1Q4SWNrSWgx?=
 =?utf-8?B?Znhwd21tRm9lUllYWjRtZU9peWdKRlJOanE3QVdqVHNjMTZBQVhhSEtNWWpX?=
 =?utf-8?B?UERPaDN2VTE4T2hUeEVrZ0lvM3VkTnY4L2kzaGZPckxmOXdPVy91NjA3VUtG?=
 =?utf-8?B?WnNmcWZTSHpDZzdKSURETnJlVkNaU1dJWWJ5a2RYWWp4Y0VoUW9pNlBJeFQw?=
 =?utf-8?B?QUsrNkFMNEI1QnphSkVZMTNhdkhuOTBvKzV4a0o2L2xLSitUMlRuRmY4TU50?=
 =?utf-8?B?SDE4dzVrdGI3UXQzcU1mZC9waE5oMVJ5UDE1YWl4dGEzODdJVSsveFk4bDZ1?=
 =?utf-8?B?RjdQUUQ0bkJidk53SWVPZWRlQWVQM0w3MENjTXBuWEVSMVllY2R1WWFBL1dU?=
 =?utf-8?B?YWhzNDg0VFRVaWJycHN3MGVEWm1idVo2SytlMFcxQ1ZCM1AxRCtZZEM4Vmxi?=
 =?utf-8?B?VitVcHI0a0NqUE02cWg3MW1Sdm83OUhrTUpXM2liNlRBWS9Vb2lCQS9COEh3?=
 =?utf-8?B?ZW9LcUd5eGI2WG1KNHR4b1N5b3BvRGhUTlQzMVZwQ3ZJM1p3amQ0bGJkb2tq?=
 =?utf-8?Q?DSBXsyWGZ7194qwcbwYekeHeaD0FXqedhAwnckzWOiVYJ?=
X-MS-Exchange-AntiSpam-MessageData-1:
	KGnEqwqysC9oj6qatImXTKuQW1l7LadX//GwZOFIFumX9HpFvatPHZS5
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d6b80f-0d5b-485f-57f9-08deb044decf
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:38:17.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cbF5Q+DlR3pvWz81FNkHYk8CN6bc99TwuZV4UGVe7+V7/DkLD76S2YD8SqVsWNTuME+eesGxohTybNpsEq8Ceb6GKwSU00nFprHdSFnqqUOln5GzOJ2uwMBnqqwI1/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR01MB994293
X-Rspamd-Queue-Id: BDCEE524F09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287235-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.696];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperemail.onmicrosoft.com:mid,sashiko.dev:url]
X-Rspamd-Action: no action


On 5/12/26 00:07, Jeremy Kerr wrote:
> Hi Adam,
>
>> Sorry, I should have been more explicit here.  I am not certain what is
>> going to happen with fragmentation, so I want to be protected against
>> future changes.
> Nothing is going to happen with fragmentation. Your driver will only see
> linear skbs in the ndo_start_xmit callback.
>
> Adding the skb_linearize() there is unnecessary, and creates ambiguity
> about the structure of the skbs that we're dealing with in that path.
>
OK, I get it now.  I was thinking that the Fragmentation was a likely 
part of the progression, as default MCTP packets are so small.



>> The check in validate_xmit_skb() is good, as it protects against the
>> current set up. So my option was to put a comment in here and hope both
>> changes happened together, or to just try and get this portion of the
>> driver solid against the change.
> I'm not clear on what changes you're referring to here?

Future proofing.  Sounds like it is a non-issue.  Disregard.  I will 
remove the linearize call in a future revision.


>
>> And I thought that was what you were suggesting in the comment. The
>> original comment sounded more like an "here is an optimization" instead
>> of "this is important enough to kick back"
> It's less of an optimisation, and more removing something that is
> unneeded, and potentially confusing ("why is the driver doing this?")?
>
>> As for spacing, I get that there is a style, but it really should be
>> encoded in checkstyle.sh or something and automated.  My own tendency is
>> to put way too many spaces in to chunk things together, and I end up
>> going over-draconian on stripping them out to try and meet the expected
>> layout.
> I'm not too fussed about the style at the level you have here, these are
> suggestions to clean up if you're already re-rolling. My confusion is
> that you had applied my feedback to one part of the code, but not to the
> area I had commented on (which has the same style structure).
>
> You also had some sashiko feedback on v40. I'm not sure whether all
> items are relevant (I *think* you're OK for the first, for example), but
> worth confirming:
>
> https://sashiko.dev/#/patchset/20260508032953.337036-1-admiyo%40os.amperecomputing.com

Yeah, I saw those, and was processing through them.  I have found 
similar type issues running against Codex.

Some of the issues I found are due to the interactions with the PCC 
layer, and need to be addressed there.  It leads to some edge conditions 
that are, for me, impossible to produce right now. There is one change 
it suggests which I thought I had already made.

If those changes are going to cause significatnt changes, I will 
probably also integrate your suggestion on how to deal with IRQ-safe 
stats posting.



> Cheers,
>
>
> Jeremy

