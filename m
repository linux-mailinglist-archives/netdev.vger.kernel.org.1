Return-Path: <netdev+bounces-299906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n3n6FIB1MWpujwUAu9opvQ
	(envelope-from <netdev+bounces-299906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A63691C51
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:10:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=xwpHfpkU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299906-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299906-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37CA43272D22
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50646AF32;
	Tue, 16 Jun 2026 15:58:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023088.outbound.protection.outlook.com [40.107.162.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1D45BD4B;
	Tue, 16 Jun 2026 15:58:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625531; cv=fail; b=QkAgINL0oYhIYL+vASLV+9DWEoGcgp3yKZuUCortxc8h80tsPgZX1FueQ5tBXf51P5uV5qyUztpNjQ/9stLO/8/556O/BBmNd2tnUh+pj7Q9CMuM5wwIJUIDk+QcmdH9P7REDQr7Fzge6d0hk1pi0eFFccHSrEpPSUYDzyHPKug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625531; c=relaxed/simple;
	bh=OmQm/6mpHxNkmYb7+ggWPM5aoJf8mtflRpPnmg/y9Yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PF+s5aXLkItevT9ZxOodHoWZo/Qoigm5YImORmXZR292SArWVMGTBrLlk2Rtc0aEusRkIDrnInXWGSesEPksDYX0JgRIRWUDYnYro3oKTq1OeADi766Rd1sRTz112Ucu3A0dTmcMWWIuF2dwoZUS3JsqblbnCIZ80ylzmCm9JPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=xwpHfpkU; arc=fail smtp.client-ip=40.107.162.88
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJUkZCw/jN3co89eSn0FNFD4QrVLpJx92QaWjQpAno0tpMiWyjQ/hf36n/QuGTa8oWEDCAJQGU8gxVinDYmFQe2eWPJZVL/RkFNzgoGPkooqY/+Gjk0Tc+SeR7/RCpyqS3t3+/SnOm4Ea6YvZ5CPxCW8hQBV4kwkNP0EkDsyPX7OHFuDf1c3F0fxxDQJ8UqZxBMObPdEfqOx/NBYGtPwmakIgT2y1/uH/f7iaBoobwRMQvYopKs+t5os2ihKpBF92QmLGHnZruB6FzULZJywgnXhaqkykYQCuTX2UIfNe4PURulULPG39C+VCBK8Ad0wHAK1fSoF58AXFrzrpBLKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8QywvoBgxd3eTAJrTnW0XYkSFUTiELNr/wRoV/wdOQ=;
 b=TQGsGn9F2pEFhWV5NYKUBk1MAPH8dny20SFXEpsnHdITLSGmoN0ED+QMfDHWeB8dyv/JM3NZ4u2cv2kwNcwf8oywV5toovyOAHrdfxDtze5a0O+KUuSor/IQ2icH1A3gKIVazRGZ4Yh4E+NC6aj7pSs6WdpUaNWxCz6kyawF4spe/pQwJW6RvGchkUbDRC+JIv+CHooys3V6Wwj9HezUuq3zvKYmRzPpniKBi7TsbpTk0FEzEffV72BwO5Q4SYaSEkvg+E9cHw2/a/nagV9JTl3T+NyC4F1Zmp7f4u/fxFYarQBLoR+o7m74rL/D0w9NtniW1hVPMQTLM79NwA4Suw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8QywvoBgxd3eTAJrTnW0XYkSFUTiELNr/wRoV/wdOQ=;
 b=xwpHfpkUgHwMRRk/To3HLnYSpnmtvdvpYh+LvU5GQowIwbrnBKYzUg2Vq5H331YE6oGb9l7sQg7p1/HDN/+ZGPtTcK2toIpdGJKNoTB6hSYW1++GPGAzbeQqpgdOkkGK5q7xjB8uEHLwuEjcHQYq8KNa8SgzJUAQfNl89haSfHIwMFtwHmpeoSLzjquHZuU3yj0EuDsqhRdJkSAfpeEjOmTaKS6SvB9nxiapI/Emt2FB5fsOxhjl5gH8zcw/Yc2X8IsSy/XHGzatZFXOoc4nA1LLRzgKWY0IrqqELV4UAFdMwqyK2PMC6Nc+p600P/t7x8qS1tYJjdZ1+//4cT3/AQ==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9715.eurprd08.prod.outlook.com
 (2603:10a6:20b:605::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:58:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:58:46 +0000
Message-ID: <3c665b99-944e-4901-a89d-0926cf762a9f@virtuozzo.com>
Date: Tue, 16 Jun 2026 18:58:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] vhost/vsock: re-scan TX virtqueue on device start
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
 <ajFbT6sDESh9FDOl@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ajFbT6sDESh9FDOl@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: e3dcbbd7-9033-4705-8e23-08decbc025c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kmzwqMqabxEAEeiTbqpM+NsAOvIDlwZRTBvpEu3bjxkH/qcA9mTh9zQxETC8VgsJucPxdn3IGgADjaytQRH0//2hkVoDCk13Fn8Z4zSXAVbifU7DotAL+Xz5uarDj2FKDk58R+6JEs1KfldqCs5dZajMCzg1QHDb1QK/LF1jQFTqYbSjdmQDPjlXDQB9Stuc5cheb3sw6bqHKHJiYt4dMVNTaTFO2dbQ9Rupr/gPAaV0W2PgZNQipyrXYtUWTgCuxr9N7KQgggTJgV7WRs+xepnx/4Z7IYLq3r0i2aIs4wRzQjhBJlU4d8gUCR3ikOL9g1FTq1Evy6h+aQuy3uHlSRwJ22UlXsoQC4kt6eaw0VS/BYp5GjIaJOJbRUqUSnL8R9DURyBfwpPaZVfQLya3Ll7xoaESfi/E6R3nLiz0xE9XugClt6OWqh3IK2VLSTT7N8et5B7WfakPQhLH+3ARDgOLZTEkbtXDPYRN1LI7LAxIe4YUJk2JbYHjYzFiiRXwHXKlCs/tSyjDydoZg8LdqKlPbUzP8HDS4zgram9oeIUxYjD5yCfmL0Ev6t58ptn+CLsuh9xRspc3Ph2Ot9Hn7Hjuc2ALq1FDkG/Rf1pv3HAN/8/fdkZfD1vVoj21Fzq8ODHuAr7SuSIXLZaQwYK804aQRtdS4voKgWVOmHBmn0tZp70X2aIb/yfFfZm7JOOQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THRhS21HNkoyYzNRWVlOeTVLc1YyaXl3Y256SVFLYy9ETmxoZnBFeXRDZnlM?=
 =?utf-8?B?UmpSOEJFVXJWSjBCUWlGaXpEb1J1NmtuRTROWjBzc04zVThLeC94Z3RDR21r?=
 =?utf-8?B?bzIyYmJIMEFnOFc1SDNza1RZZFF6NWM1VnRZQmxYTkpSTG9VYlkzUlFvV2pl?=
 =?utf-8?B?VlExMTF6dFF5RkQ1eU5vVHB4emFYK1RNaGxrN2FuSDAvN21JMkNyTTM2REpw?=
 =?utf-8?B?SEpGa1I0Y3NkcHVVbTVQTnBtQ2o1ZkFZN25TUW83Mkw5eDZibWJpN3d2Vjdq?=
 =?utf-8?B?eXJWZ1I5Qmp2aVhzVVl4ZVRGSUxvbkdoSEtCREVUOHZndHo5MFV6WlpSVWsx?=
 =?utf-8?B?WEhzdGJOK2h5VlloQU81b0F1TUNsTE5CVmpabjlaUXh1WkVUY0lldUJ4bm5V?=
 =?utf-8?B?QjZ1OW94VlVaOTFVMWhob2NrTDNFSG1rTnNCeGVsZXFpa1VPOHFCS3F6TlRp?=
 =?utf-8?B?R2ttdE9GemY1djFHN21xb3MvM3k5Z29zNXV3MEQxVFhhRVhaOGlEVjEzM204?=
 =?utf-8?B?M1BMamxGSzVVQU01Z2dpbUJjaDg4UWt3U2tzWlNJUEgzMU9QWDhUTGgzRHdw?=
 =?utf-8?B?eHc1alVOaDFnNWVZSnFjd21jOTBHaWZqZU1MUGROUHlHRTF2cnFtWnlZNHUv?=
 =?utf-8?B?V2pVVWhMd0FXTWE3TTR0Q2o4ZVZqbFN4c2tLbndvV3NlS0VWdWc0VmRvanBk?=
 =?utf-8?B?UXZhV0hLSStsL0xVRWpCaHBHMHV5TXpDVVpOYXpFdm1BaEx1bVcvM3YvSThx?=
 =?utf-8?B?Ny9xaEc4bWRBTlJIdUl0WXA5QkNaOVBhbXppTHgzMlRwaDh4cWsrcDgwMXJX?=
 =?utf-8?B?SElZSm9DSEM2RmVpMWdZSEl5Sy9MbWRjSjVxemZjbzRVOTJGWkZlaENnM3Rr?=
 =?utf-8?B?MEhiSVBtRlJwMlJpeTNWZUtSc1pUMWRoUWU1T2YvWmxJWGV5QzNjdWRHdEo2?=
 =?utf-8?B?eTdUbWJ2UG0xb0Q0UGdmQzh2Z2kxWElacFYwWFZ0bTRnSnAwaWdWd2VuMkpo?=
 =?utf-8?B?Wk9LTlNrVjFpUGs4Zk1iMDFKbWpXVHV5NGNTMHliMzNBSzRyaGhsejN2MW9Q?=
 =?utf-8?B?Q3htMzRMeHlTSHJhQlRLTk1ydXpZMExHazkzdmJLQXovcTRnazdqcE0yMi9B?=
 =?utf-8?B?cnZXeVNLakQwVVlHSkowM3A4bmprZ2EzdENQREpnemkyZ2pPRm5TQStyeTA4?=
 =?utf-8?B?VHFvcXNSdlppUjF6VE5TNWFiRjQrY3RkMUpSbWRRbDNxcnFXZzZlWjJYazFy?=
 =?utf-8?B?UzZXb1B3MHVBYWNCd1BSazU2bnFiNjVRWTNmOEUzano0WmdiK0phRzZGdFRw?=
 =?utf-8?B?Qy85V2c2TGxLVUFxeFN1Mlc4cVhlUWxnZkxXTDc0WFZHQk1nd05qUm9sZ2xo?=
 =?utf-8?B?REx5K2NPK2JGQ3pRRkhGRG45dEpYYm9BczFqdFRlaDBjT3o0Z2syNm94ZGdi?=
 =?utf-8?B?YlVRdHhCTkpPNThQMnVoeElvQTIxVndJWi9hY0wvQlV4djVIaGNHUUJ2TWhi?=
 =?utf-8?B?K3FMVXRzeHgzQS9kaHhpN0JJaUZ3REJoVU1ZYVpPczZJSHhTa0tnanBOd3ZZ?=
 =?utf-8?B?d0JHNUIrNUw0RDR2aE0yMWVXa0NKVUNSaDVORVA1RE96SUFMVXM3OTVXdW5U?=
 =?utf-8?B?MXN4RlNqYlpCMzA2OXJ0a21FTlFXQ3VVOE91cEY0RzE5Wjh0RmQ2T3BwaFRU?=
 =?utf-8?B?aE5uU2pIdUpkRmJMMXFNUXk0R0VuNU5sdE1iY2FiUEQzNGpUTzIzTXd5NUNt?=
 =?utf-8?B?RXk3QStHQnY0YWtyampOeFVHOW90OGlJaHJjR1NKRHNyTHF5ZWZxeUEwWHQ3?=
 =?utf-8?B?Yko3d2tBcXd0VnE5bVl4MENGZWw4czdBakJwRjVpREFOZ3RzLzBVUmN4SG1F?=
 =?utf-8?B?dEtNdDRYVDN1QlY5NE1lUjlabHFTdFF3YTdWL0lpbFVReThWZXhIbGV1MGVJ?=
 =?utf-8?B?MXd5QmprcXpnMncvYWVIa0ZiV00zRVJXUUhTcXcxOTM0WlpjY3RFVEVncjBU?=
 =?utf-8?B?OTJoZGpMQkZwQldodC9IRzJIZk1WSHVFeUJLUWJrM29NK0o2MmVwSGgxUjV4?=
 =?utf-8?B?VHh1UDJNbHdEVjZoSXBPZkUvZGtVVWxWZGxYSWtTTS9HeXJsaG5vZmFSNXZF?=
 =?utf-8?B?TVJoZmd3M09NWDZTSCtIRnFTNTNibmFoM016dDBjSm5QLytLYU9mOXMzY2JW?=
 =?utf-8?B?VE5UY3NrbE9iblpVbUFBKzlTZUtTRjkxODlxUVRRazkzSkxwRUpFa2k4QllI?=
 =?utf-8?B?U1IxNUR4YXNWSkN5aTdLMlJPMUNuZ0VUcFdYNXhEM0FURWtvWFdPQUtMUTFa?=
 =?utf-8?B?YVA2MDNMZGdVeHJ0aDV1OVdxc21YWnhCNnFXZzBCNEhmbTlRaVlkczJQTkg5?=
 =?utf-8?Q?upxpODGHjHdMQSNQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dcbbd7-9033-4705-8e23-08decbc025c4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:58:46.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmBT+9G7YGBH3B5xS6TMYL7jZufB3IW5XuKc7I8ENY5qO1D1sFneFFxlV5vG/uBoC+owlqelf9ZjwAtu38AkStjdtErbxPRdr71Mi/EiX20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9715
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299906-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97A63691C51

On 6/16/26 5:23 PM, Stefano Garzarella wrote:
> On Fri, Jun 12, 2026 at 07:57:18PM +0300, Andrey Drobyshev wrote:
>> During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
>> keeps running while the host drops and later re-attaches vhost backends.
>> If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
>> while the backend is temporarily NULL (between vhost_vsock_drop_backends()
>> and the next vhost_vsock_start()), then the kick is delivered to the
>> vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
>> kick signal is consumed.  The buffer is then left in the ring.
>>
>> Then upon device start vhost_vsock_start() only re-kicks the RX send
>> worker, never the TX VQ, so the buffer is processed only if the guest
>> happens to kick again.  But if the guest itself is now waiting for data
>>from the host, it will never kick TX VQ again, and we end up in a
>> deadlock.
>>
>> The deadlock is reproduced during active host->guest socat data transfer
>> under multiple consecutive CPR live-update's.
>>
>> To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>> queue the TX vq poll so any buffers the guest enqueued while we were paused
>> get scanned.
> 
> Again, it seems like we're fixing an issue that existed before this 
> series, but IIUC without support for VHOST_RESET_OWNER, this could never 
> have happened, so the wording should be changed to make it clear that 
> this is can happen only with the new VHOST_RESET_OWNER support.
> 
> In addition, this patch must also be applied before the 
> VHOST_RESET_OWNER support or merged into it.
>

Agreed.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> drivers/vhost/vsock.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index bcaba36becd7..1fcfe71d18be 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -655,6 +655,12 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>> 	 */
>> 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>>
>> +	/*
>> +	 * Some packets might've also been queued in TX VQ.  Re-scan it here,
>> +	 * mirroring the RX send-worker kick above.
>> +	 */
> 
> Can we also mention that this is related to VHOST_RESET_OWNER?
>

Agreed.
> Thanks,
> Stefano
> 
>> +	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
>> +
>> 	mutex_unlock(&vsock->dev.mutex);
>> 	return 0;
>>
>> -- 
>> 2.47.1
>>
> 


