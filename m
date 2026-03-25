Return-Path: <netdev+bounces-271630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OKLJ74HxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:05:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ACE328A7D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05B5E32CDD70
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5C339A7FE;
	Wed, 25 Mar 2026 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="5G2FKIWD"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022098.outbound.protection.outlook.com [40.107.209.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94535AC01;
	Wed, 25 Mar 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451990; cv=fail; b=EEkk3CQpz47zY6yGoLneJ9gZBlZxVND/Oz63sCmj5qCpZoYx966gp6gn6TUrk8lLXgIrrxF/hkLEPIlAM5wk/SIHJcDqw7q1N6LysaKG1mVUEeHQp4Th9o3WOmImDpjGU9VV5+qu4nHdDtu4UCLtepC/fpPhhvFvFO4OawdD9ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451990; c=relaxed/simple;
	bh=3SWa63/8Mib9x9VOBrRu20nCk/U9sfLDjCUtIK4TpVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/V6B8Hijq5w3+mTykitEkPKWA4Rg03g4GBrrP+wEgTJx4l38McMuL/ThlGoGiA+Zbmo9HEih3bA2/MfBXx39rJx1acuvYYPWTefj1UfdWJGCUPnw9oHbyVYyohGwZZxAIXKoQhjkgq3gIs71M7jenc0pEnVSxP80PunkTMtX3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=5G2FKIWD reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.209.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKlhAtN9nSJbTlf1IlTF6XepD3FL1ep7i2MLIBDMpEOqoftshEvJIelJbWnFKGaI8gap4LlREbGTKvBQqT7ELt9umrVF+nQaWTOwc8qO12FI+TlaMsOghs86QIujz0ASFrpou6WxlKe7Rkospkv5yaS+AbRL0k2m5aMPK+EhzsrSflko9k34H0vUmphEVPVlVs5YkTW+b3bRN7KPykiWhkytgIs94H84omkke6FeqVX/RQlrPnBIIK2YzeKFkPTzeyLIPngZt8VqPL/iCh7x2r91fviER8xL7jg2D+Kqi9GAW/9egwXXsBM0k+fn7wR27Ge1OkXgdrcTyC/xSykPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgZxMbDBft/hfWE5BoiGaBvGWdNiq+Jf1mFEz+1ypGE=;
 b=GfD4fNdH2V3ryoiagVlNZeYhLnZUrreLe8WVqzABhXbDY4vT9l5JwBkyL7TZsGehhcSgDl12vxQ0jtAgKUaT2SKdIFgnfoe1GQvtItVYxQN2ItZPTyEiD3qtPUrMwhOyPH9wuljXlIFjaGsCcCbMw4l1BETagopWrVDE/3sP/24bn3NtBO0H23D7UopPjCXEwFb3Wve3LyMe6Z7E10kYVyF18m+n2ecP65201BOvfl1o1D9pmGl00S8Qw5rYIv4QecGU+8pzUbOBUVjHNIPzPZd6xZ6ysPXEIuLQ5BwGStkK9gjjopl4CSkGYYp24TtK/mDFziAouM+h4pEbgq6P2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgZxMbDBft/hfWE5BoiGaBvGWdNiq+Jf1mFEz+1ypGE=;
 b=5G2FKIWD0bDe4fpLGbIUvCH38wSfNYBKloBb+AdGLk37C9C8CZIGSVTTPzMtSOJr92NY4oNxPPn2Je8fC7iaid/clAL4CPKFFZFyd3J6WKehSOLD3k/WIa1b6JAvfRQwXlaIYVF8iA72azUFb9ewW/mwhN3QazNuMYidGi5pFpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO6PR01MB7401.prod.exchangelabs.com (2603:10b6:303:14e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 15:19:43 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 15:19:43 +0000
Message-ID: <a499b3d6-9c11-4ffe-80ff-761a6a12ff0d@amperemail.onmicrosoft.com>
Date: Wed, 25 Mar 2026 11:19:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v35 1/1] mctp pcc: Implement MCTP over PCC Transport
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
References: <20260324211235.938599-1-admiyo@os.amperecomputing.com>
 <20260324211235.938599-2-admiyo@os.amperecomputing.com>
 <91e228ea442ed3d0726ceb4d2b5a962f570e0805.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <91e228ea442ed3d0726ceb4d2b5a962f570e0805.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO6PR01MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c97b9c5-0c6e-4c9f-6c2c-08de8a81f0e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lTDLfVyrgujCOdBfg8q/x3mslR9VIj/3iQt8rUozBaQIfiipQwNA+qc3MCLfj60MZzNwp5yTINkFfPsK9yE8qCFVLyY4EIuyZ2RKqtDoFOhP/L30K1W2u+ll0XK7+6Qax+HV97JUHW6YN45RlHBVgzZ+XRNsTyw64KS5nCRsNyWEA9LjBmfaTapd018FANpyF4IeYUYCgsct7LTTAkhoX49IHykBfIeDpYizh5T2UjSAujnSe9x32TSdMNCf/e7XQn7zOBUUjhUCRCptmV+U4ssEIerNpmLGEdLfsA7wKeDBULlKiotUgpFcpEnLmaaUZ1CDS0UgdKUokaNCuH4h66vxG+bzwB7qv1soWjW9B75ehareOkltnT7JYSrTTuOS9riEEGrn6ysnks3Hd1gUvb+D+LSG+gexKmNMhfAh2Mo3FoCdGI298t99HF6IgYSwyDTltW0TW2JMAcUWhE0A0RkN9mxCNiGRow5j/IabT+5NWQIC5/cQz2HNwyxz5KP7pbY15A0fm1TKvBNcDQJsskkIVxJSJy3NhLueKJg7+gDonM6hkQst7notSzI+bVrvsUMJ33CcUH6MgMJWUv9hg54wJwLjJVgBtvP1+qU7KaMG/T67Q9GoyWEd75tCFo4yRDOQBPi3567b7Fv0u0Tjr6pgs0j65ZHPwhhGAxCdnGJ9KZ9Xlfth0R947vSA6LWUakoxQSeGJVOiLG1xycEkzW/fA92is10U6OC+1x9YimE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVlkMGkrMHVYK2swRXRLVkZpaHdWazNGYmV2SlFvZ0R3dllIT1RPUjJ6OHkz?=
 =?utf-8?B?QVFPV1ArZXlxMVgwU2NTd2M5bW5ibDM0M0Vsa0V3eVYyQmNkTE9pNkdkWklW?=
 =?utf-8?B?dy9DSU5xbjVYakl1eEdpUDQ4RFJWSkM4c2NtRHh0ZDgxUlJ2cDh6c2F0amsy?=
 =?utf-8?B?NDYzZlJpNVNmZjVKbUZNdlhLUmFXeHBON294ZzRsL1JuaTlPRnlua1R0MFY0?=
 =?utf-8?B?dld6aTBrWm50dVhoVDFVWjFURGQzenpiYjRxV2luQ2J0cENVRkpIdlg4TWhV?=
 =?utf-8?B?cnZqR2ljcmY0NzQvUzZ4TG91RTVta2s5SWRBOW1yOWFEQncxVXdqR0tSNDJh?=
 =?utf-8?B?WGt2SmZKSWY0bEVqNyt3bnNxdFIyazhLaUhVV2RIMS9GRzNXeTJJR1d2Ynhi?=
 =?utf-8?B?eXcxWEVOQXowMTlvSHp2d3FtelRQUW1yblhiT2d5MWs4UFhvNDhpRjFjTVpQ?=
 =?utf-8?B?elNrb1MxNmZpV0VEZ3JnZFdLWmkrRjdYU3lmTVpERWtVb1NYaFZMYm92NE9H?=
 =?utf-8?B?SkFYejZFSTU0bysxSkxDMnB6R243eGFzUTFLM3VrZVZ1ZDBiOERIaExsZGlC?=
 =?utf-8?B?Y3dXMnp5dzIwQVdsZVp0ckxLczBOVlBoZWpBNHlSc1FwaW13blkxcWZrNWw2?=
 =?utf-8?B?ZXV3MGNNMHVVNUJHeVF5TVNDOEo5TjU0WWhXdzgvcnNDQUh0U204VTYzSDBD?=
 =?utf-8?B?K09NMUhhaUdQRy92eWtTU3V0RmpFTWcvT1hYa0s0N2syNUhMYlhPd3N1UjZt?=
 =?utf-8?B?bENNYzU1TC8ycU0vYUM2WHBsNEtHKy95YWpkR0RIVE83dHR5SFBLUE1FVksr?=
 =?utf-8?B?TktXUkQ2WUV4elI2aC9XYzRBVFM5UXVyL0VLbVdwbmxpdk8zeEtRK0pYYStx?=
 =?utf-8?B?WlEzVWpRRTdBZUQrK0JtNS9BaFpheDBOcUs3Lzh2QXlmcXBWN1ZHMVpkaDRY?=
 =?utf-8?B?NEg3blZYZExzdWRBSzF1NTl3OTBBTE0rWU5KOUZXQ1pKaE15Q1JNclQ4MHlP?=
 =?utf-8?B?d2ZiUlE0Z0JOejI4NTFHQXZhSk0zbHRGakpiODExZUhUNkdsS2tYK3kwdXZ2?=
 =?utf-8?B?bEQwaFJpY1VrVXFpZld4c2FaR2U5bG42VllZVFNGcUJycHBRRXpsVFJIWlUx?=
 =?utf-8?B?dmNMYUtPc0pCMTFiY2F4bE5nL0lZem1YME5BdWVjUGpWUUNFNWYvd1BQSGw4?=
 =?utf-8?B?eklncW1oaHdTZjkwVWNxTjEvR09uOVBrVys1WURocXdBQUVSV3ROQlAxVlZ1?=
 =?utf-8?B?YnU4Q2ZmMzUwYThMSWVwaUNlaDYxRjV0NnR1VkppK3pkN0Rnb3Izenl1c0o1?=
 =?utf-8?B?RDJUOHRIMjdvdzMwOU9YMmcxU1RjdW1OWklXYlJmSCtlWk55eHpzeXpHMktv?=
 =?utf-8?B?cjdESUxrOFV0dmFIaU9WaTRkVjVrRlZEdFFQUnNmVHBLaEJLN0VFTjBSNkRx?=
 =?utf-8?B?ZEJMWkg2MGQwWjFqcWxLQlVrWDdlTEkzT0lzT1ZSN1lkVGwzWGdZMWxSWW8r?=
 =?utf-8?B?UjM1Nk41VEx2Y21tMFBGazJaRkpXWnhWaDBDMUhQeW41Tkc2NHlLbDF5QXdx?=
 =?utf-8?B?eHhWYzNGQkFrb2xUOXVHRXpDb1c0dW53blRvNHRGeFA1SFdwMkIwdjRmZ3BN?=
 =?utf-8?B?bFhUbHlkOW9VdU5vZWRQV3BzdkVBVXRUeDhvTUlKTTRXR3RVbmgrM0k4bjk2?=
 =?utf-8?B?Uk9YY3BGb2tiWXpQcElwZ0tjWmphMDY3TUJZeVhXQ0VjYmJtcWg0YWFLc2tT?=
 =?utf-8?B?MjR1VHYxa21ERkE3d0hMSTd0MUJmQkFrRU9UZ0ppUlpPc0UwemtOSGRVbjJs?=
 =?utf-8?B?K3NOMnlDSDJDN0NxTmovOUd0dzZJandsVUdIZjdka2hBU0tMUHZ4N3EyNDQ5?=
 =?utf-8?B?TjBKcCtFNG9SL08wYVEzMXlqSzJlZGZPelBlOFBtTWpXc3BiMnJ6VEkrR2ZN?=
 =?utf-8?B?RG01MjRrK1MrWnpZZWUzbksybElMVVRENVpXYnBlY0pWcUd4cFdIYTR3KzZa?=
 =?utf-8?B?cnZ1TVRhakh1UjFPUVR3N0NQcGI5bklPL3BRaUFzZWNJR0V1eHBUdkNiVDMw?=
 =?utf-8?B?SWVDYTFraS92T0VqTmJlSlhFbzh4NjlKZ0U3b1htc2VRT3gyWUUxWHFNMmxT?=
 =?utf-8?B?Vm5NUUEwdHQ2MGgzQktEay9BSGV2a0YrbXNtcjN1bVpQUTI5SzRtTjZmYVNM?=
 =?utf-8?B?dWRPOGhZakFRYkxLdkZ0d0plblpWc01FU1BuaXJLbHRyV29Qb1VpVjFlendm?=
 =?utf-8?B?ZDB3ZkZOTGdIN3VQckcvZmJWM1RCZ09Odlh2OEZxcFMzZWd1OFVoUUtSYVlR?=
 =?utf-8?B?cmRscFZtTm1wUlRvUEY0S21tbDJFQThMQWxHTXVWaXYwOUpnMERmemFTaFRG?=
 =?utf-8?Q?dDNlJksvAMBvjengZgh6wY0+bf/TibCypq93d3Ufe6h0V?=
X-MS-Exchange-AntiSpam-MessageData-1:
	EvDLqsZFZbFJrxmOeV0wJ2cXJTLm11q2HzuW6C6UeRaS9PW5PQX/xzyi
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c97b9c5-0c6e-4c9f-6c2c-08de8a81f0e8
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 15:19:43.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9NnRSIerpI1pKSGwuKepAzyoB7NCowk0z0IszBfCuo4410UTXlJ4F8GNXxiOK2jfbRHQmGYf/TEdBfdzUKyRlGZ806V2WTXS2VlOAIwbUXiXJquzWyO+wXDheiUn9wJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7401
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271630-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.907];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dmtf.org:url,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: 39ACE328A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/25/26 04:49, Jeremy Kerr wrote:
> Hi Adam,
>
> Only a couple of minor things inline, but overall: now that you have a
> one-patch series, you may drop the 0/1 cover-letter. The content of that
> will be dropped anyway - I think what you have in 1/1 here is
> comprehensive.
Fair enough.  I just thought reviewers might like the chain to the other 
34 versions, as well as documenting the thoroughness that this has been rev
>
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> index 000000000000..f8d620795349
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
>> @@ -0,0 +1,366 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * mctp-pcc.c - Driver for MCTP over PCC.
>> + * Copyright (c) 2024-2026, Ampere Computing LLC
>> + *
>> + */
>> +
>> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
>> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/if_arp.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/string.h>
>> +
>> +#include <acpi/acpi_bus.h>
>> +#include <acpi/acpi_drivers.h>
>> +#include <acpi/acrestyp.h>
>> +#include <acpi/actbl.h>
>> +#include <acpi/pcc.h>
>> +#include <net/mctp.h>
>> +#include <net/mctpdevice.h>
>> +
>> +#define MCTP_SIGNATURE          "MCTP"
>> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
>> +#define MCTP_MIN_MTU            68
>> +#define PCC_DWORD_TYPE          0x0c
>> +
>> +struct mctp_pcc_mailbox {
>> +       u32 index;
>> +       struct pcc_mbox_chan *chan;
>> +       struct mbox_client client;
>> +};
>> +
>> +/* The netdev structure. One of these per PCC adapter. */
>> +struct mctp_pcc_ndev {
>> +       struct net_device *ndev;
>> +       struct acpi_device *acpi_device;
>> +       struct mctp_pcc_mailbox inbox;
>> +       struct mctp_pcc_mailbox outbox;
>> +};
>> +
>> +/**
>> + * mbox_write_to_buffer - copy the contents of the data
>> + * pointer to the shared buffer.  Confirms that the command
>> + * flag has been set prior to writing.  Data should be a
>> + * properly formatted extended data buffer.
>> + * pcc_mbox_write_to_buffer
>> + * @pchan: channel
>> + * @len: Length of the overall buffer passed in, including the
>> + *       Entire header. The length value in the shared buffer header
>> + *       Will be calculated from len.
>> + * @data: Client specific data to be written to the shared buffer.
>> + * Return: number of bytes written to the buffer.
>> + */
>> +static int mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
>> +       /*
>> +        * The PCC header length includes the command field
>> +        * but not the other values from the header.
>> +        */
>> +       pcc_header->length = len - sizeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
> Minor, but you're using two different calculations for this: here,
> and in rx_callback(), where you use sizeof(pcc_header.command) instead
> of sizeof(u32), and have swapped the order.
>
> However, it's a bit odd that you're setting ->length here anyway, as
> you seem to have already done so earlier mctp_pcc_tx, but there using a
> (third, different) calculation?
Yes, this is a vestige of pulling it out of the Mailbox layer that I 
should have removed.
>
> Perhaps just set up all pcc_header fields in mctp_pcc_tx, rather than
> casting skb->data back to a pcc header, then re-setting fields in that.
Agreed
>
> With that changed, you may not need a helper for this at all, as it's
> just doing the length check and the memcpy_toio().
Removed.
>
>> +
>> +       if (len > pchan->shmem_size)
>> +               return 0;
>> +
>> +       memcpy_toio(pchan->shmem,  data, len);
>> +
>> +       return len;
>> +}
>> +
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *inbox;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +       int size;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>> +       inbox = &mctp_pcc_ndev->inbox;
>> +       memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
>> +       size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
>> +
>> +       if (size <= sizeof(pcc_header)) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
> This condition (size <= sizeof(pcc_header)) reads a bit strangely given
> that you have just *added* a sizeof(pcc_header) one line up.
>
> The only way this path is taken is if you end up underflowing `size`,
> before adding the pcc_header size back on, which seems awkward. I would
> suggest checking the raw value of pcc_header.length, do the drop if that
> fails, *then* adjust for the header/command sizes.

The whole "length = length of the payload + 4 bytes for command" logic 
is already confusing.  I felt this was the clearest way to show exactly 
what needed to be checked to ensure we have a valid header.  I guess the 
alternative is

  if (pcc_header.length <= 0)  {
                dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
		return;
  }
size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);

Yeah that is clearer.

>
>> +       if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
>> +
>> +       if (size > mctp_pcc_ndev->ndev->mtu)
>> +               dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");
> We only got half way through the discussion on this, my bad. In that,
> you mentioned:
>
>> They get dropped by the MCTP layer in the Kernel, apparently, so the
>> dev-dbg is to help someone debug why.
> ... which isn't the case. We're fine to receive packets larger than the
> MTU. It's a MTU, not a MRU :)

I can't explain it, as I did not debug that deeply.  I will come back to 
this at some point, but it does not affect the proper functioning of the 
driver.


>
> Your driver is still fine to impose a limit if suitable, but you're not
> constrained by the MCTP core here.
I'll remove it.  We can keep it internally until I have the problem 
diagnosed and re-add it if it makes sense.
>
> Cheers,
>
>
> Jeremy

