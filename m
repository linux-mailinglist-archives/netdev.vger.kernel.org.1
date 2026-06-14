Return-Path: <netdev+bounces-299277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWh1EgIVL2r/7gQAu9opvQ
	(envelope-from <netdev+bounces-299277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E974682395
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=JJ6NtmOi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299277-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299277-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FB6C30011B3
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871C326941;
	Sun, 14 Jun 2026 20:54:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460BA30FC1E
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:54:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470460; cv=fail; b=iF9XkukxNJ+fPw3G4uoXeyY3nJsTZBm7Qzzgxatuf8gpLVhyQ1KKU9rEQq8MLE/PTm8u9ChaICZC8xsQG4ukXm6nkUmjxNDAGY8ZTk6H26jzdNzblU7dfvIsC/vhIJXW8iu8ny8ISYch4oFhbSW0tKRkR6sXrTMO25jU3C4Wkdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470460; c=relaxed/simple;
	bh=uRxj/BTaq4rMEQUOh1AAweVMR3U7qYZ1Pukx9s77HzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SSu85cRHNQSTROgcxzGBlleOg16UpDqpM3gsFcvSN4zehux9uVtHxLZDH6pV+9UZAJC1xzcUAskcyE5/nBBx13rswtS9zNAs+EfGbnnRdX6poK6gydHqmieEZj5T+yEYbJNxNrT2MV6wr7eEpL5Nl+9fH2eYGdA9MRUSAZM0v5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JJ6NtmOi; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5jQ88swGt1c/afSmWHxqCoG85Avk4BGPrt+clxI/xmsLW5eoDzuGbz2Y//wVLGlfHmdOX5OZ13GvKYYb2rSy6kTtZC3KKvClf521aJZxS55yfzf330bcdd5bB5i2hfH+QJZg1Kd7OicyO2TsYcWyQ05cdyU77mEGgewyEs9l1Bz07EC8yodalcz2sL3dhs3CmNKJLW80Cq0s72W3ESN6evnDECzFLOV3c+enTzy7W2iOo7e+/WB2P4L81hufQ+6LNr9NJRyCs38TwRIVVnhqiXQb35m2zszqfrtOxrvtP57wg8QgLnUwl6Xt6jdb4ABetoz8pfWxL2LaqsnX2qLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4Kd5GO4AaYFHLP3CN4DU5qeH/xqKblr0vq3w4WBs58=;
 b=JaGJc72yZdeHeqF4MMtEpWg9t9utpeHBbre1gk5L91tOZiVYGmLlckyNWjiaSY5ux2vkZqilgl6c7RDacxQifjEs07tCVz3hq7aglqxw02zQhoUcgakNWLHmrYWL7RLjvXBequhy7L06IV5yR6qJ4U9MX/wadbai9mEsx6NDmfxYb2JceVPI/EPfmtvODjdl7NMdJnP2W56kiDJFPlf6pl8nie9yLJBtCQl91Ojo2Piszn6O/8LIGpYiDPQ1pQT2gDSDmVM7SlTSTyTsyotw5jEGcoPxEdzy5VJqLWJpJ5+CFTOft2kH8SFCNrmMbsRrqwORH9DZXLeTltVT3xWBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4Kd5GO4AaYFHLP3CN4DU5qeH/xqKblr0vq3w4WBs58=;
 b=JJ6NtmOiAUJMQOgzG1MA0Lh2FKv3CaEGSIcWiRBtv3FH0agQIQUaH++8IrRi7/wl8TOmTqrw7cwAo9DyqDaMJWj+oVhggcPbB8hBGDCeUFhW/Vs8H2NkawIo2msMqbYEh7FfNKxTMrEWDQJlJH11yTpnBXXvBRSvKpoZXV4eku4=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 20:54:16 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 20:54:16 +0000
Message-ID: <1c0d4f01-35f9-4a53-ac3e-0db0b5c7c7d0@amd.com>
Date: Sun, 14 Jun 2026 13:54:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/5] ionic: Expose more port stats to ethtool
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
 <20260612091825.GB625020@horms.kernel.org>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <20260612091825.GB625020@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0031.namprd05.prod.outlook.com (2603:10b6:610::44)
 To DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e7a9b8-af30-4fe7-aae4-08deca5718b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	4WYuH3hLil+NhT8FucumDYAqk7Y/rNGGkstg8zoutHo9z2qLX6QGfkJYSFCPflD82Ct2FCcg/ZUU8sTIQmPQOQgp+YX/gVPZ2L66htycnkh7Qz092HQVC4EvhXkN+HpyEqpg4xtCs2BIXfMbYqpFFI+Db9SnyirDggdvHmKjk1EqXDFSHufY78HLZnD6qqRUFcJKLrktOGyAfK+65+Rif50N206SHMKt/2yGAY0bFsypcrtZthevBqrB7LVWdv6j2xKkg+Q7VDt3W8wkJ8dkTSbe6Pvw8DGpmSwnKUlmvg1NUbA9/IEA0TJceU/BkX85GkTaNKdlgkQQtrckg910nkuboiULOBKWTfZLlxlmj6i6ScWSDXUas2gFZgd1kzxk9lDaBp0G2g1tcYDJlkxpH42CzCXzXgRSbt+xFKY9Jzm6sMQzISdsbWAK9NYpjDAqfUXCl8gaUKUxO5H3ipWXvJlw60iRWwzBVn24+b8sShzaRsTwr0+iGYoHEWjKwhHIqVJWTboBTSxfPT7Y+KOqHk8uPV8W+FwyVN9cBTgbPRSR4tiBB9nDl1GGGnnI4zB8BjTheQ8RsAU+Fb0qwRfEKJYYca2fiQF8j3vZMMK9WqzMj9YSO4M1LtlBr+s26s9nZ6mAJwP0hK0s9pjBEUN/Mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0dBWHEvdkhlTi9DUzY4NTB0VXBDbytDbUF2eWdjN21tcy9iS2IxSDZ2Sjlj?=
 =?utf-8?B?TDBiY1VXd3U4ZDFZVkswSGYyYmVjWkIzUFNnQzhtUndWbllCWEo2R2lHNGxC?=
 =?utf-8?B?ekJNd0RWOXBhN1JXSkpYcUg4cUYrMkxLRDRvUytHWWZoNlZJSkFnZ0FpbTJC?=
 =?utf-8?B?NlJFYUtsM0lRbFBqOHdwVTI1TXJraUlUYlJ6YkVvRE9HWnhOMVAwY2ZUNlhT?=
 =?utf-8?B?YkZVRk5KRS80amdNM05uQk1STU5kTUVLYmhTUjd0K3VjK1BOLzJuTm5hKytE?=
 =?utf-8?B?eDZ0L3FCS01oNVhnZFp5R1VEZWZSMzRla3QxY3kycU5XakRDdVdLQTVDQ1RU?=
 =?utf-8?B?dTJ6Q2pwMk1Hd3BGYXpVQ1UwazdaaXZtOFd1b3A5aW5FckJjZDduSis4VVVi?=
 =?utf-8?B?a09aUFpBTVd3bUdVdHN1VTZ1Ui8yUS82V0RMaVlpT080ajdUWEFOaFU5Z3Qv?=
 =?utf-8?B?OHI2emhtT2FFM2lPZVNicmUxQ09hTTZVSEl2L08vQnVvbEJJVWhobDJTMjZL?=
 =?utf-8?B?bVRHeDk1VFJBdCtzNmwyNEkxS0M5OFdaamlGcU1rZ1JQZzBJdktkQW1BUElC?=
 =?utf-8?B?bWUrY0grNFZhbWs1R2NJSlpoQ0JIVmNNU1RWY096OFRDMUZlclcwT1BsaUdm?=
 =?utf-8?B?cnNmeGZETUhvaUNvWnk4MmU5dVBZMHNoL2Ftd1JEZTV3K1VMNGJzZXZhRmlx?=
 =?utf-8?B?aythVGFIbytpSWU1NVZZaFlpdllBd3JkdGU2VzNBMVVvSHJDbVQ4ZDJuZDls?=
 =?utf-8?B?MlF6ZUM2cmEzRlRJUkc3V0hpWlBpY0hGdHRLY01oUm1JVjlHWGV1RDM2QldU?=
 =?utf-8?B?ZmNSYUJlZUZzNmFDV3NOZGRjcjV1KzhJRHFHZ0l0ZEkxRmpZM2FIZWtTRlFo?=
 =?utf-8?B?RFNsN3ozbmdadTA2RnVCUUFoTWtkejJYMGNwVytNdDhlekhtS2w4YXE0MUtj?=
 =?utf-8?B?WW02QndoT0ZiL2RvUEx3MHpIUGI2TlIxQWQ5SkVCUUJtUjRHTk84c1I3UERY?=
 =?utf-8?B?d2RobEpVQlRwODVmM2FPdlZRU2x6VFR4WlVSUTA2bEdDQzRZa21qcm1pRGpI?=
 =?utf-8?B?Rm5vTDdNVnlPaHRqSXV0MFRSWUZFcXA1VTNmOHZKb0tWVzBSTWN2UXl0VHhw?=
 =?utf-8?B?SXRTUXgvbjBBaGJ2UTIxbGZ5alExM3RFVEZSYmJtM29mQzRBRHFrTHMvbXNp?=
 =?utf-8?B?bDlJZHVud1NsaTBUOUFNYTR1UEZwdjJXUnpUSFBudEdBYXBNT1V1RkhBUFAr?=
 =?utf-8?B?WEsvNDJjRWRwdi93c2VHcXJlVEZFUjY3UllIN3hBeHYvMi9McnRiS0lVREZp?=
 =?utf-8?B?TW1KRjIrVldaaXo2aVRmV0Rab3puUnFIYTIvNStrTktWZ3BObWEyaE1RVi93?=
 =?utf-8?B?UkNTT1Y3QWNMVDN4SWU4MHEvOVBFSS9MRkl6ZlNMeERrZDZ2eHhUbW5KTDRa?=
 =?utf-8?B?dU51Nkg3K282MzFpK2xObG56ditoV2VVTnczb2QrSy9wK1JqM2x1dDhCWk1M?=
 =?utf-8?B?OHRiMHR6eGxDS045SUlHMXoxWURlSW1OOWRuUXU5cFFzN1VtbHpxOUU0UC9z?=
 =?utf-8?B?TnlYSkNIRHk2SEEvSzNFRkpGRDFPalM0S0ZYUlhBS3Q2MFNBcDlaTkgzbzdo?=
 =?utf-8?B?ZUlNRlFHc3Z0am56bDhCUE0wWE5SdVJ5c2pJUDRIbys4QUw1S0VTN2pxbDYx?=
 =?utf-8?B?Wk82bUd3RFJNVG84MFFuZXNTbzZoYWVHWStOdEJHREhDcFBMdExnTmNvZU1l?=
 =?utf-8?B?aWlBcFZSUFB1dE41S1kvMVBsUjlqSzIwTnIxK0J3UkV4LzVCZ2t5MlZuN1l0?=
 =?utf-8?B?UTVlaThpWktseG9iOFJ4NjZaYWJWeTQ1ZCtUSk40MHNDMWdCczFtOXU2RUFt?=
 =?utf-8?B?Y3B1UkQ3RHhGczIxQThXQmlURDhrWCs4ZXN3cmlnS3dVb0FIVU1QMFFFTEZO?=
 =?utf-8?B?cUlGazlweDY1WldmNXRBWkpuWW1tQ3h1NG9TYmlhTnhMekF4Wmp0UFVSb1VP?=
 =?utf-8?B?UHFvSk1pMXRPeFJrTy9oYk9WMEdKU3NUT1V6TlZEV0doWnRKM1lIb2JoZFZw?=
 =?utf-8?B?RDAyRG10TFVNOE83b1JqVlpiQTAybEtXT2NCNG54b0ljbTVLRkY3OGYxdlox?=
 =?utf-8?B?NWxlNjF4c0JKeU9zdTViN0tSRm1OVXpmOVh0VDJUVER0N3VWWWhiQTh2V2NK?=
 =?utf-8?B?NjJsRjhjZTBlcWpSc2Uwa1U3dXhpYVZKM1krSzJhM2YvTmtXRFBGTzJNekln?=
 =?utf-8?B?NUE5dFRtSmtUL3ZRMU9xdmlBd2JybDN2REhCVmZPOUdXZjZTRVZwbnEvbnVp?=
 =?utf-8?B?UWJGUm5VMlY1TFdCOEVkM3psK0lRODdtUlArZytjL0ZQNTdWWi81dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e7a9b8-af30-4fe7-aae4-08deca5718b4
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 20:54:15.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msAbvrvB6Vs1ab9xyFoECUrYZGAEVgfVtdqEqiBM708ZFis51wQiyEF2oRN3GUI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299277-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E974682395

On 6/12/2026 2:18 AM, Simon Horman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Jun 09, 2026 at 11:18:25PM -0700, Eric Joyner wrote:
>> The primary aim of this patchset is to support the reporting of new port
>> statistics (and one old one) that firmware sends to the driver; these
>> include general FEC codeword stats and the FEC histogram. A scheme for
>> these extra stats is introduced in order to prevent devices that don't
>> support these new statistics from unconditionally setting them or
>> reporting them in ethtool.
> 
> ...
> 
> Hi Eric,
> 
> There is AI-generated review of this patch-set available on both
> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
> I would appreciate it if you could look over that with a view
> to addressing any issues that directly affect this patch.

Thanks for letting me know; I've submitted a v5 where I hope I've addressed all
of the comments.

- Eric

