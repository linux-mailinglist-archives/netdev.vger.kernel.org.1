Return-Path: <netdev+bounces-305196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wG2YJFj0S2qsdgEAu9opvQ
	(envelope-from <netdev+bounces-305196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:30:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED58A714887
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:30:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=DknFiFUW;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305196-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305196-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 437F33025E71
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70846436BF1;
	Mon,  6 Jul 2026 18:29:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD83DC4A8
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:29:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362569; cv=fail; b=B95ywawj4sntfioNPvhIda9F/0ngGSSvVZbl2xmn535aCmGuRdLJoZzmQgsVDpDqGpjE2FaS2m4ce5pdySxvGj9S7T/pYXgwuojj49gy3bw8dyIfNwB+RN1bnl3Mw5Xcuxn/xyeYswUVz7vQ1dECc6Bw0pFfUBfpMhgH0K2roWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362569; c=relaxed/simple;
	bh=D1iy2Y/4OmcTYk7AaN9uLHW420IpCTbYHRYVgw78H5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PchddSRzs65vnmJ3pUfJZiRoIvhGb5i1Hyw3jJSlXT+ZLRwkpFlGzRqvgsZ4A4mavLAPRlb2vXxoVVgqciidyXFjzE4uBn+mfe7iR31xN6CqzvozADz8zti3TQXg6aQsH3YUWd8X+XqbrYWkq8c1AEnAGPVhkSTGqN4NGFEnBDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DknFiFUW; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkPiB8MmVfTNKSNTz1k2YpGwb3oLq7VW5vam46XCuukULr7C5ZqM677Ynl6nzuiLQJBBQSTqXlEm99RBkzbWWfB7rsqjDWuGEMl+AqOZB4NxWt40xdiwoNUygMWN9RAzB8P4VcWt6Oasm5SgDYqF7DcBl+TCTjdWEz/G0OSXQ7FaCbcw0TPua/WWJpLoDxpQ8cBL33TnrUp7IsVoQs8xzqfk6Q9zpn1E+9kRSMn8dk5ogIaHGNiWQVuvnfRTH+ynX54IImaHhFL0AioN5wVpM2iCBAjMWb4M7oCd43Sk5FoGxsz96N53SwAWz7KovceRXrVUlCjI1X2qgdpJlMNgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBNKYIzy3HU3EZuIBItUbPaFUA/bAJUOPK2cq6N54nE=;
 b=FcyQNNVhpwFXq/Oa5MIvVsrnVYGnA29TiyIVJT++VCLZ7dzVKI6XfIRwlog/WaLjjp0e1nKknvqn0RQN4LqL2q4qD37HKLHXAiVr06uVKUFxhvGHHsHdqP4bTXk0C8bOauml9EZDvtnqLgMQl3SVoZc7aYMS0QWSwRLv1BN+xluDzeLLuByaWGBGot7UUKkLuYGu5Ak8Q56msXOoP6YS7ff3/P7qjlRhClowN5lqKm6pXJ4UUmjRmM00feLmoUv6DDafLwEXJu46KlusLtskPU2yBITdjtSsZcFRtL7P58C0ge11FzlDYO5TAmON02Tm87jf/+bE2PXRCFqIfFq36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBNKYIzy3HU3EZuIBItUbPaFUA/bAJUOPK2cq6N54nE=;
 b=DknFiFUWSx9xy4AIHqXuzg4MEDJpeDW2s2z/nIgKgQKbKcchwoeEtZO5wX5vEWl9KnxOBx3jUsti7xH/F3H6+uGxwM82fWLQ1nJk0uuG1zi4EN//4haEVeN/RE69pIYOqjTZNgz7SRIMlk0feEUr3jWkuwhAh9Pd9rGpjhsFUoA=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Mon, 6 Jul
 2026 18:29:24 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 18:29:24 +0000
Message-ID: <3fb21caf-c9f8-4218-8c14-8192a71f26f2@amd.com>
Date: Mon, 6 Jul 2026 11:29:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] pds_core: fix use-after-free on workqueue
 during remove
To: Paolo Abeni <pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
 netdev@vger.kernel.org
Cc: kuba@kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com
References: <20260629200358.2626129-1-nikhil.rao@amd.com>
 <20260629200358.2626129-3-nikhil.rao@amd.com>
 <11c0ee2b-96ff-4e27-8688-485dc4605f58@redhat.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <11c0ee2b-96ff-4e27-8688-485dc4605f58@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::12) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 929d9100-fcb9-47d8-bc95-08dedb8c812b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|6133799003|56012099006|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BqLUwEHhVwpaEscXyXW9cewiC6Jsl1YdVYxL8RT/2j9eXDK0ojIQn2e9hGL761aHeUhwW65nGt0CTMQkvLTJQH5s2c8DCtDxZEaHx4LA7Rya0Fe9ounp/yaD56JJOvH6YyHgNqw90GL8ChAsNs2ZMBX15Nkeg3b6WDnz9FAYUpNiOxjKVqLttORBli91ySel/MdYv/qXrI6ghN3qL9z5lxTCUzvA2Aw0hsYlzAqBzP3S7dynoiGgSEgSAxP8Agmzg/sFgF6l1LFqLSThV+G79xzdXLEFO9QejdRkTGfAN5t0m3+TGVZdttdov8RcSiEuzBPg83iiqMGnYKUnb3wPrS6g4eNDeejhle6WzeeqlUqJf3uZa3HNMzHUeNw1VUGSLWsdSFhOYOhFfE9USEMClN5epFcl8Sw5IWstzeWFjBODv2GnFfW/jtq/N2TvSxFdZ1sM13HcX3gzprHXW9FkkWPk77cLsRmCvXOYEAm2oIkPxtZkX6YedQK783GN1P86+dq1ds6esF3zKC/kLrPSxsyByC7WkXZl8RaZXPxF4M+pPWMtfQHzfbNcFHQvy1K1a4hEe4FSalOhhnJVWqeU5Tvfwte+GOQwQT1selK2ciLPCGHc238HvmkTe06Kt63zqgFcUWPJQuXldrNkxLDhNPuIsMbooHp3lZIf6HI53jo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(6133799003)(56012099006)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmVKdkpzaVBXUHlsQ0dHSmpURGJOYzhxbjJJTVdVcURGUStUaDVYekQ4RWIv?=
 =?utf-8?B?OG9EK0xPQnBTMittZU44QXhzU0ZMOE15K0xLNnlzZWYrRVk4QWJVeklZek8x?=
 =?utf-8?B?aWdmM0dZQ2ZPZUxFSkZBKzllSG50bHF6c1BQRGZ6RXJVaXU4ZFgyaHRlU3V4?=
 =?utf-8?B?WVZITjFDOW5Nckg2OEo0cWxEbGtNK2VMZElPVTdhUjZlWFRGNlRlTEpKN2M2?=
 =?utf-8?B?OGozcnlMWWh6L21SMkFOZC9VbTRrZnRkdlBQM3UwSjFJM2hXdHl4QXcybU1O?=
 =?utf-8?B?ZUtyMHpqM3ZLMFpvcXlCMzF1UTNtVDhwYVp5RThzT014MGFxRHZQTFVjQTN4?=
 =?utf-8?B?U0k4ZWgyQ3liK1R0WU1YbGNrd1dWWGNRT0t5Z2pmQUdzVU50bEdFZWtoMFk2?=
 =?utf-8?B?ME5Id0VrblVxdE5PS0tUTGYxT1U0QXpINkt1V0VDSDVFVUZPWjhmNzg0U3Nj?=
 =?utf-8?B?cnRqczBXQlJjenNFVS9lT29nczl3NTVleThCdERhUmJaaUIwZFpXc1ZzWEQr?=
 =?utf-8?B?SGw4TzRkT1BLUUdHaEFobkFza0xMVmpZYTI0UCsvYjZtVjdVNk1aWXV0VEh2?=
 =?utf-8?B?cVAvdCtHY3VpbEFZTXNoVml6bHE2ejJDNXJWM3VBT0RFWTV2b2RDTURidVpX?=
 =?utf-8?B?cE1BSTcwWnd2dWJZeit1OHVCemVGWnd3NlBYYkV5OEVxbzdvZWNzR0VSUm5Y?=
 =?utf-8?B?YjA4VXJEWjJDTysrNWtiSzZiVGhmMW52eTJ1WlBlM1NVR1VHUFJUcjBQMDBW?=
 =?utf-8?B?YnZyMmp5Y3BVMWpmVm1wSkJ4SktFRXd3N1M3b20zMGdXR3JyRDJIV29aUWpm?=
 =?utf-8?B?Y3RlZXE5cndxVmg2QU1qTTBydytXNnVFUXhvOG55Qzl5OFdtdUxpdHNTSlQ1?=
 =?utf-8?B?eStBYkJqUHQ5YkFOYUkxU3gyaWh5ZWdWZE9hS0h2anRLaTRIcFN1OUVZV0ZL?=
 =?utf-8?B?NlRJSFVNcUVuNnlmOGFsSW5xQW4wbi9xM3FRREdjczJBamhMU3NqYzM5b20v?=
 =?utf-8?B?RlZtN0d6UmdnaGxaOVhZaEVRa3ZEd2ZlS1FKNXdDQld1V1RXRUcwWm84YU9u?=
 =?utf-8?B?cG84MC9wMjJuOUN5M2lKZWdBampxT2s2aGlXaFdydmVDZlkrQW91bENpLzkv?=
 =?utf-8?B?SUtoNVFCL3FVMXhGUDZOeTVvakZiNDVpejdVN2hETUV2NXZ5cjRRNVVaSWx3?=
 =?utf-8?B?UlRlMU9KeThWclVQaVAzOFZkbzZSbUdWdGFPczREQStweW9BMXU0a2dXNDdv?=
 =?utf-8?B?eXFoNTZ2NFkyL3d6S0FPbkV5ZGI5KzJLUUhwbnBuRmJ0T2M4Q0lUdjZtUEZi?=
 =?utf-8?B?ZzR2c3RJeGdBYTVwS2F6cyswTjVyT2FON2F4MkQ3WEdIaGc1QkZxWmZ1R24y?=
 =?utf-8?B?ZkNvbmh2T2cydmhOdlUwVWFIY0FyME0wUW9ZWHNscEdPMzU2UWs4bzIzSnVQ?=
 =?utf-8?B?aWlOVWhlMlliRGdGY3JxSVI4VG15UXZCVVdlVlNiT1VYalFBalhMWnpZSCtH?=
 =?utf-8?B?dlUzS05Zd3NUQTZnbUtGRlJ2ZTdjVFhSb2FXNTZrV0VLVFJ3RUdYc1RNalVa?=
 =?utf-8?B?SkYwL0ZNNmpaZHBYbGovNC85UXBPcUFqeUIrZS9RZFZGYjJSZ1E4UmlrdHhH?=
 =?utf-8?B?K1JoSlhnWGQ0czVxSGVCaGRkUVYvWWpkbnB6cXEyS0dqaGZaREJ2ODdYWmd6?=
 =?utf-8?B?V29LZFkzOUk1MlhTZ2dwb0NraUMxc2QrQ0pGYk5HZE5ERGJseTc5MWVqeFBj?=
 =?utf-8?B?U3NSWTlyOFZlNUE5MC8wNDZxZVUycU56cURwK2JMLzhVUlJQRWpNcWZhZS9X?=
 =?utf-8?B?MWY1RnlBdVRHOFZxU1NwM2pKVXg4Mm5ham12WC85bjRaQi9QY3JKcHZUYXpq?=
 =?utf-8?B?c1AzRFV1ZDVnc0t1dTJNRW5GQS9OSjhZakp6MURPVXhzb1h2T0hvQlhNbzFJ?=
 =?utf-8?B?VnRZV2tUZThEN3lNdDNtazBGMTFLSFZ1QmxOc2V4NHd3OVlWQVRMQW9naDAz?=
 =?utf-8?B?M2VhZFFsUjZFNE9YcXgrNkpPZnE0cUgzQlc4cndFUSt6dUwrUDRRb0o5b0VY?=
 =?utf-8?B?bHNyUngxVnNHZ3Qwa1ZSS211UVkrSDNscTYyc0RmRmU3cUEvaXhOMDBlS1lE?=
 =?utf-8?B?OExQNWdmS3BXaGRINkwzU0J1cjRwQlliUTVwVE5PQ0djZzhpVlhPc2NKQlN6?=
 =?utf-8?B?ck54NFBGYW1UOVpRSjhtR2NiQkFyZ25RZSthdTdUMDgvSjNlUHdJUm9FMENz?=
 =?utf-8?B?eFFlYWhCbERXbklPSEFTQk5qYytscnM3YTJrRGVFMVlvUUltNmhSaTVjZzdY?=
 =?utf-8?B?SjhHcW1xd1hhTi9pc2tNSHErZmZpS3pwQVcwV2dMcjNweHhCMS9uQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929d9100-fcb9-47d8-bc95-08dedb8c812b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:24.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/Unaj+861eFv4aM2PoS8EiIRYOrYkWV0WC4KBd6pUwIkcNwY4tOmNnkFzhECNu2oe4D77N2UN3CtoEEhV/k3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305196-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:dkim,amd.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED58A714887

On 7/2/2026 1:13 AM, Paolo Abeni wrote:> On 6/29/26 10:03 PM, Nikhil P. 
Rao wrote:
 >> In pdsc_remove(), the workqueue is destroyed before pdsc_teardown()
 >> is called. This ordering allows two paths to queue work on the
 >> destroyed workqueue:
 >>
 >> 1. If pdsc_teardown() -> pdsc_devcmd_reset() times out, the error
 >>     path in pdsc_devcmd_locked() queues health_work.
 >>
 >> 2. A NotifyQ event can trigger the ISR and queue work before free_irq()
 >>     is called in pdsc_teardown().
 >
 > I think this should be 2 separate patches.

Thanks for the review.

The original combined them because moving destroy_workqueue() after 
teardown fixed both issues.

But they can be split:

- Patch 1: Set pdsc->wq = NULL before destroying it (fixes issue 1). The 
devcmd error path checks pdsc->wq before queuing, so this prevents the 
UAF. Also avoids needless health recovery during remove.

- Patch 2: Move destroy_workqueue() after teardown and add 
cancel_work_sync() (fixes issue 2).

Combined, it looks like this:

struct workqueue_struct *wq = pdsc->wq;
if (wq)
    pdsc->wq = NULL;

/* teardown (free IRQ, cancel work, free memory) */

if (wq)
     destroy_workqueue(wq);

 >
 >> @@ -121,10 +122,16 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 >>        qcq->accum_work += aq_work;
 >>
 >>   credits:
 >> -     /* Return the interrupt credits, one for each completion */
 >> -     pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
 >> -                           nq_work + aq_work,
 >> -                           PDS_CORE_INTR_CRED_REARM);
 >> +     /* Return the interrupt credits, one for each completion.
 >> +      * Use READ_ONCE to get a single consistent copy of intx since 
it can
 >> +      * be set to PDS_CORE_INTR_INDEX_NOT_ASSIGNED concurrently during
 >> +      * teardown, and skip the credits if so.
 >> +      */
 >> +     intx = READ_ONCE(qcq->intx);
 >> +     if (intx != PDS_CORE_INTR_INDEX_NOT_ASSIGNED)
 >> +             pds_core_intr_credits(&pdsc->intr_ctrl[intx],
 >> +                                   nq_work + aq_work,
 >> +                                   PDS_CORE_INTR_CRED_REARM);
 > AFAICS this does not look safe.
 >
 > A concurrent pdsc_qcq_free()/pdsc_qcq_intr_free() may free
 > `pdsc->intr_ctrl` before setting PDS_CORE_INTR_INDEX_NOT_ASSIGNED.
 >
 > I think the teardown should:
 >
 > - disable the IRQ
 > - cancel the work
 > - free the structs
 > in the above sequence.

pdsc_qcq_intr_free() doesn't free intr_ctrl - it only calls free_irq(). 
intr_ctrl is BAR-mapped memory, freed later by pdsc_unmap_bars() after 
teardown completes.

The sequence is already as suggested above:

pdsc_qcq_free()
- pdsc_qcq_intr_free() /* calls pdsc_intr_free->free_irq() */
- cancel_work_sync()
- Frees DMA memory and structs

Note: the adminqcq ISR handles both adminq completions and notifyq 
events, so notifyq struct is freed second.

In the current code, qcq->intx is set to NOT_ASSIGNED in 
pdsc_qcq_intr_free(). Moving this to after cancel_work_sync() removes 
the need for READ_ONCE/WRITE_ONCE.

Please let me know if the proposed split works, I will include it in v3 
with the change above

Nikhil

