Return-Path: <netdev+bounces-297329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XafTAHWRKGpmGQMAu9opvQ
	(envelope-from <netdev+bounces-297329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285B66480C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:19:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=XOkV9fgk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297329-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297329-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED174300FEFE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293137D133;
	Tue,  9 Jun 2026 22:18:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9233F6C2A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:18:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043497; cv=fail; b=fDXLmQ/poV2r9T/k38CdBHJLc1rausSWaRp+63zPNz/BmHj5Pb+DJoPsXe2tbtdo+7m3uXv9DqUU9TkJMmwKEANj38h0fSpkRG5L2M87c8+NtnsOoNjOsExiGLmswozfVwtqOVD8bXGguTUrS334TyvWVGN5aEqfDA4MiYv66PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043497; c=relaxed/simple;
	bh=+Z47uarw7+zFie251lqY9XUTeg9utct58N5EDyqkm5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFi2Q3l2ETtqd+4TVraJCjh/aBhIn9MK1DSITnkFIL0NRaXvEQNiGV3nMUB1b+6jD4L0U2hS47qq1gEeFRDAt9qPuL/d/yTlyppxN8+y/uonLR7Isxb2TwPMG8o2MPKPfcMbkA458/NPI2ATzw33oHdkNESIdehjycEpJYHdR+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XOkV9fgk; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBEzdGcDEgIsxT3OYIYIdgqOKtKtC26pFlBGxWZ1KQ8n8XrHqXgNJq8OE5NI76r7wkCEXaRdvilp2FS+MzLMOsgT3Q6NxDoAXagq2rcBZ0Ep33AnRrcnr7fqJTvMkT5cZwKAsR3iSCe7ShQva3Azh5lZmjU85t71CAfgZNQNZsUbN7fkvq25l1BtAULz/GHkLNIhx2Yt3TzwaB4mBtbYQCIAD+Jh3YxKbzlDLtHIwJ3zo4GbLf9JdtBod1np0QCLnon0MACu/toEYIjvTL/RPlzReHj/6j0EQLdVSeL2uZQUKbfzcCi1tT258sj7X0VvuL3D+dR7rWA41cSEhzSQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYRBuK7D3mkpGSBVWn5D5FibwAHveGvMtrRszvuA1d0=;
 b=basABp6dmxWWLR/fzt41JGu3vt85Cy/ZdYb8dNMU5KRVltP9aOiIa+SLJdbmoyXAvQ9CHIx5CDiP1aZeGs77SVyLTeUs7V/+tDo/NZIwABOJMaeJen5KIqOfj/WjdO76ql4BAENFgCrhUP3kdE3bkyRJFr763w+Zz90XcBDJmwBycVGC7uCWNZn2u9N4WffZzIhf0pJA5k2KibLGg19mMiyQoM5UHBeFgj+l1FOzTqCdyMvKvovkiuZAwZrDFo1uA0KhU+50r5cArfm6JzltkKT4gwlR2MbpGweeWLOreeq1/mG86rk2TkEm87weosRnD3RJHHbJ21a3SX7cVzFDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYRBuK7D3mkpGSBVWn5D5FibwAHveGvMtrRszvuA1d0=;
 b=XOkV9fgkoS2GPzReSf3ahXztFAkLtP6cQB3VcK4cnxlbr+i1hJXNsDR7YhAlAZ1bKT3fYlW96B45VIt2zr0INr6GpC5H8zuNB2TXSm8UP1gu6CEyJXmUrl7QySR5PINP3DqtQNwgaKgFDsrE1IryBNyX45ObqvBz1Q5gBUbWmAo=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 22:18:09 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 22:18:09 +0000
Message-ID: <49231399-e8ca-4f68-99ab-729444567c7c@amd.com>
Date: Tue, 9 Jun 2026 15:18:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] ionic: Get "link_down_count" ext link
 stat from firmware
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
References: <20260512224421.25236-3-eric.joyner@amd.com>
 <20260515012747.1292575-1-kuba@kernel.org>
 <f2d17ae9-ec9f-46db-b46a-a2bb680c3460@amd.com>
 <20260609142640.261b7d87@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260609142640.261b7d87@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:610:20::31) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 712b6ae9-0f44-4f00-694a-08dec674fcec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399002|1800799024|56012099006|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CPd/vTuhvKY9zuCCwK4avGqewXBS5U9fm0A9Ny9Rfp2nUGSFUv13gLZNkvLR9RsiTb241QC1pu484Kkvznzyukqkh3d3OtmwPeiQFGBmdP9s2nVj3eKL4IwnK+d7d0m45Kq3VH/BmaNh7XXxfCb3i4MqNG3EhNhdvZOj0LGZbsFr7rg/J4jpmd/hjalLdf2+BaCvAPO9iWQP93E0ZHhCHdcBnxm5qCLQr1/EzEUCoFEdYQPSp6PsV67u0HIqrLRDPh8+8AVchVdb18W9RbvPTVbjd9el6ZxnY0vLsL855sTZ/qID4AvhewPOwBBLpfDAQM0CisumPS0/WMi20KN8TtZ3rGVx5gY8ZW/GjCNxpmh/2Zp6Wy27DnuVITZm4ghnCiR9jG3K0/sW+es6neSDaH7VXmbpyoadIWWQ8c/Jy6ZvvnjGrAreppec6GT8iRw8HCuQs5onMN8WJ7lRZ8CYMergy1aVA+So3dBSb+bhRy/AzlnlqSoAzykOfMCbzTd82XIwEIqHmdxo7vhOuVpAmrk4Ec3JDDgxwhIpUvKtJnYhHPIvv+NCqjDq+Eoljh6UEiV84FeAbvy/6TsxaRKbgnvq5PhcsNVp9TIUgwPPZAl7xZNmMS1mUotid7gVtAM7mdCHbg/I84DMXMdKmT4AoNV0RJj9KCWEHETYyR/a7bV6KAo9Tq9Nl1J5TCmvdaSk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399002)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czkwbVVNaXpmRXJENDNaaE1ZV0pwUXpKeUZYa09XSVVhS1FEQjZxMU44d25t?=
 =?utf-8?B?SUNCZWNoSUUydEJJL2RoSisxNGFmK2hDYW10Zk9yditPSEx0c1pqRzJYb3BB?=
 =?utf-8?B?QUMybUVZWGZJa3d2VStqelR2dUFONWNuZG5rSUFqZlowdFF4OVBHc1lzVVBC?=
 =?utf-8?B?bU5oT1Z0NXJJRmJaL3F3dkRVR0dBOHVVTlZHekV1eVUxSWYwUmRWaG0ybk93?=
 =?utf-8?B?WGd5RDYyM1BzQThDSGgxcUpZSjAvTWlWSE1yK3BSb3pXTEx0dzE0TkV1RU4x?=
 =?utf-8?B?WmNMaXA2YVVvL0l5MkNjbmEyeGI3RERqUG15c3pkVGJrdHU4SXZwNnBBSWRU?=
 =?utf-8?B?UklUS2NxbFB3azcvd1l1cUdUUTkzM1hGb1VYQ0tpSEFGazEvelMzb2dkUkdC?=
 =?utf-8?B?Nk0zcmpvZFNWN3JPRDNjTmJtV1BZdFYyMDlvWkZwNGdIb3NubnRKdjNMWkFX?=
 =?utf-8?B?ekl5bVhvbGJKalljSlplOXc0VXJiTzl3ajVNRlU0SllsR3FCU0pCdmJROXdx?=
 =?utf-8?B?bVBWK1NIUzZ1VVRHanNCTmoxR3c2YTJuN1pVZEdRMStqcUJDcDM1Z2JwYkk3?=
 =?utf-8?B?TTJiUmUrMnc5NG1OY0NESkxxakNSQlJMc0FHZ043bG9kN2hHWmlld2hXaUgr?=
 =?utf-8?B?N0xmc29CcFkwRS9mOG1EQlJkUmxEWmdlWUpzNXhEUXZ3STRlbjNQSmpMelE3?=
 =?utf-8?B?MGNIWkpaQ0FlUU96Nld4K3pNWWdKMjNqd2I0MDJxVG5UMkZweE91L0duSWxX?=
 =?utf-8?B?cHU5bnpHd1FtQkQ2cTdXNGpuaWJCbERXVDFrR3cwNjlYaXpSdWxBK3J2R01m?=
 =?utf-8?B?YlFBQ1ZCSGZrdmZtc1ZhcVZ0UVBtNjNSUERHVzlqenI5OVdxRDh1NytxT2pY?=
 =?utf-8?B?TXN4a2R2cVdtSk95QmdGMFVRM0VlNkI4S3JORDJWVVp4RnNHcVdMQmJ4a2E1?=
 =?utf-8?B?M3d4dmdRdE0yUnRMSlVlN2xMUUR5THRDSk1xRVJNaE5vSVA0ZTJQODFEaWVQ?=
 =?utf-8?B?STd2S2RIbGt5Vjg4ZXpoOUh1S1Y1ZGNCM25Hc2VlS2V3Y0xwMERDK3RzL05x?=
 =?utf-8?B?S0JETXQxVWJFaWJvcW1zRytqaVpMdHFhRGMrZk9HdHBpSWZEVUtyYys0UmEz?=
 =?utf-8?B?V2JTbHdrU0orYXBRZ2pWWVhBd3FPcFU3NndQemhocFRjS09QSjR2OWozYjhr?=
 =?utf-8?B?c2hYWVhKMEFhRm1aeFZwR0d6UDFraWs5aklFcHVWZ0hOUVlKeTAydnkvQ3J6?=
 =?utf-8?B?QXMxNG84Vi9RTzRZcDcxRkViV092cTZGbkQxK3JrcGw4dmJiY3ZkemRxNlBY?=
 =?utf-8?B?TEUrNWV3N3RYdFBaYU93K0pnYWYvbHFGRXdNODZhWjJIZDdoWk91UFYzRzFS?=
 =?utf-8?B?V2ZDVy82R1N6aWtHNXJaeDBwR1F4SGNobVRXVXlQaEdkU0lMMGdlYm5pY0Jm?=
 =?utf-8?B?aGxpK0VjN3paWjBEMFB3TEtNNUY3M0JmU1ZLWm0yUHNNVW9QQmxnaVZlVC9G?=
 =?utf-8?B?L0dCRm84ZzBCZTBWSXo4ckhYd21NNGdlSGRrOXFqSWxlVW1DUkE2QnJhVVN2?=
 =?utf-8?B?ZHlkM0MrbTkxWVJ2aXBBc1hoMytLZ3FXMVRCbGdaemp1K3hNOGFHcU9ZWXVz?=
 =?utf-8?B?cUxTM2ZuRk9yMFNJcEI4WmVuYi9QWGQ1WkVWNHFrVE1kUUI1NDZLMUo4bE9j?=
 =?utf-8?B?ZmJVbnQ2QXBPVjRFcFlxR0JCMTRzaXI0bnQ1NnRpb1hFU3lIaFdsZ0JOZjdU?=
 =?utf-8?B?RlY1SUdvcnZlc3JsYnB5T09QVHQ0QzB5TmxIKzFENVRkT2U3c0FkMXVLTFJn?=
 =?utf-8?B?ZENqdnR3aWtzRlgxUGtDaG9wdnhYUlJaYTJKSlRsa1d0TWdmcnRGNk4vdVRG?=
 =?utf-8?B?enNVUTZiOVZLaUtiQzJHQk54ZVRSdnJSOSttQWlvd2ptejZFT092MFpOd3l6?=
 =?utf-8?B?MFZ4RXExeFpqQ29qdHVYbUxCK1huNFNWQlREOVRyckFIWkl1ZmVtRlpPMmpH?=
 =?utf-8?B?Y2lHd1lNd09JY0J2TzY1U0RFeE0wbFVIU1BFZklJaDM3V013K09ROEEveUFE?=
 =?utf-8?B?Y0h1Q2dySDNKUnhja2UzbDJVK1dCQzJ1SjJWaWZrUkpmMHBVODFrTTljbFJ4?=
 =?utf-8?B?N1JYckNMY3puMkJoaVl0UmIwQ1RPRkJoZXlVRTZ5V3dDRTFvVXpscXdoU29O?=
 =?utf-8?B?L2xjNEcyNSt0cDNSeTNJVmFJemhtTXVlNTZpMTdGTldQMlJlZjNDWlJ6aTR4?=
 =?utf-8?B?dHZydWptcnZtTEtwVzNmcElkNktNRVAyZzJXMUFzZkZxVG9FTEFKZkhkaW01?=
 =?utf-8?Q?Hedd4Vdk7Xl4Z9h3nH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712b6ae9-0f44-4f00-694a-08dec674fcec
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 22:18:09.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94q9rQ3X+w6YA0obeGXnv1Lq7U/CbtpXMNpqXTndtFq2HqDHFuRMoOT1nwu7BnMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297329-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4285B66480C

On 6/9/2026 2:26 PM, Jakub Kicinski wrote:
>> Is this a big enough issue to deal with? Is link really going to go down
>> sixty-five thousand times while the driver is loaded? I guess we could have a
>> running tally, but that seems like more effort than this is worth.
> 
> Seems unlikely indeed, but drivers routinely deal with such wrapping.
> It's like 5 lines of code, no?
> 
>         u16 val = le16_to_cpu(...
> 
>         if ((u16)stats->link_down_events > val)
>                stats->link_down_events += BIT(16);
>         stats->link_down_events &= 0xffff0000;
>         stats->link_down_events |= val;
> 
> 
> This is also not great, operationally. Monitoring systems may expect
> counters to start from 0 after boot (IIUC you're saying that unless
> the card goes thru a full reset we'll keep the value from previous
> boot).
> 

Yep, that is what I've observed. I now wonder if the previous solution of having
the driver calculate this statistic may have been an attempt to bypass these
concerns.

Maybe I should go back to the original version, and have the firmware stat just
be an extra entry in "ethtool -S" for additional info?

- Eric

