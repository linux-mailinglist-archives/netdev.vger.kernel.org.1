Return-Path: <netdev+bounces-301664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WaUdEtTfO2pJeggAu9opvQ
	(envelope-from <netdev+bounces-301664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:47:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D246A6BECB2
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mRE2KNRY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301664-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301664-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A668300827C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F193B2FEB;
	Wed, 24 Jun 2026 13:46:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291A221DB3;
	Wed, 24 Jun 2026 13:46:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308818; cv=fail; b=t3IfzBUx0PiU2hNUOZBvYDTZwGlOFtqCBBe6otEwpZixGsg9xwbBD8CyxRFSsGeDXUMp+4q5i948oW94561HO3YNGAU5Hh6Bk52jQXqar9tK2Rp++yXLK1J6mPxZ6skPP88wJf2M2JEOALGUFKw8jZ71SIuj97tZsWmqDpY1EPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308818; c=relaxed/simple;
	bh=xtJnnk7RelVRMAr5j6LBfh2adn1ReIS1hpH2tva6U1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lxusWLkvxJ95Q+8HQy6/CErLBgJDInmH8iQsj6J1K6VoNmjfLzulfUcpPHXV6N5ZKooE84TohACsCYTO90rkrahfFwV2g7uRe4ooMXWaAaq8eoWzWK80ksKLn+qIpqRfwMKJG/VAUmSogBtYalwi6fT8Jc7vjS2mqwyotSR4bpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRE2KNRY; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK28GMDR57R1NtyE+eIpAAU/TWkWfzI1Piakw5rDcD13f9+Oypo3DH5ptFpoPiQ/BM+5aHNKUXAuMHz9eB16ONPSxofXMGTiotyBcq8Wjdb94Oo8UMchGQevqA+R7lHLNDmMD58Q3AZOj5aPiwVtJBevO9TWWpYGOAwOiVGQQrk7ryJ7jhLmxhUiJO+R9cs35KQdjOZkYrScbjjOVhkv6LIqseM+v+xezAUVJ+Uyf4ZvFO4bQQuRx3nGmW36PYjeqW/kyud6+qvi19DhaabH6kig9gKGrOUFDNcMlzYDgCrf18pg6M6M0KZepJphDQzBoyUo6P3u7VAaZw6cMLg5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAHl5++ZszFxohzjIHx0EdJd7kYuYjT5heDlPlZ/vrM=;
 b=gzGCPXanwkLTFBluJJUtycdVvxhTuyZkfE4Bet7nJPorAQ5DFXdWWWW1LrbmP7rBgeavNduMhyPg6h2HqJZ1L1FGumzzjd4CcjTgBsjAaAww7gcVCu+jchbaSPC6Lz7tULt41SlMRaqaLCA4YUB2NfPLCsTY6dNBI4ZjlaKlOE/bw1Uo3QLIC2dn7XpEH6tWyJmVUbzWAMZu2QgX/0he09mUY9OzFh37CgzDZpMQI59GKenP0gyeuDAdG0fFW5cH4jrInZkDF6vmYc5ILfw3wHoUmRMO4pxB9ps0cXoOgQixJM5c+bOd2tFUZadDTXLcmgl6WcwDd22blNZtd9kPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAHl5++ZszFxohzjIHx0EdJd7kYuYjT5heDlPlZ/vrM=;
 b=mRE2KNRYI1olGcBFdH7DpWSxl73D8Wrb49i1rVeeUoRGIdzgTWdbVkaYRwmq6Ok7WPSsepfdkrJxGge+40EW96NtjnFArLRBQud7p2dDh1gV44Q9EuSvV6Ip+FHVpCLFTNO3Obi16WY0eUXSczlGBVUIY5sejzXyknXpIFRCb02Q8x2yrkTjt3XUqIO4haphh+9yGY66GHvRVwCcN868ylYxafYusHAcl15905app6a95NOi7N9GYzdheXIQiaYtLD6lwjiavbFO3oOm/EhKymr1dgCki4/iiXPAd6L7WaI+8yALjlG6Q291Mk+WPVck9y5C7D0cimR9oSolT9DcXA==
Received: from MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::28)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 13:46:51 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::1d) by MW4P223CA0023.outlook.office365.com
 (2603:10b6:303:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 13:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:46:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:46:36 -0700
Received: from [10.221.135.3] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:46:34 -0700
Message-ID: <b4ab21b0-9025-4422-a53e-e99b7d9638c1@nvidia.com>
Date: Wed, 24 Jun 2026 15:46:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: tls: size splice_short pipe by page
 size
To: Simon Horman <horms@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260622202847.3944076-1-nirmoyd@nvidia.com>
 <20260624125132.GN827683@horms.kernel.org>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <20260624125132.GN827683@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 667cfbd9-01dd-424b-27f9-08ded1f70b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	EgRjYQRRBsvmMPEJVOkMMyFNnCWB4vRfkpltbvuggKdzxynsllkmr8LJ1RAt9rO3YaYPr1uB5LhqS/UCfO2fdQvzog09SxFTEWKOJmjC6SDADH/1p/88MYg0mi2v2JEsEupIxKFyuur7l4sKsKygIorOEp/mlaq4GJPtpUeGQzO5IBxoZ+PJKoLfhC8xVqHdWxt0jpjeIU4Z73xZgll3C2rAooqOuqKsBJGETHVydBqI0or49EOiuhRBZF1WG+CSqcIID3Yd2973DlhP8ZlMkh5Z49ETlI0PgloVV9+wVTWS/2gMbIHdBjHXeyWs2/N48zm9BlaqFwrnucERqArvEYA9tyCw4+csJPoW478SSXRlWDL6AXBtmnHQvFSJzbRfeG7CaJvhCUsV+Pdpojnau6xoHPnZQf2XrPjVk2E5oJsaP22cfLQlcvv9zFC+EO7gHU0jDN08d/Ae0NmWldzsTs1Pl8HOKPTHaJEap9YdUoo2vD6dnbOITfmrt6NeUht8ch5pr9exzecpyVgoBhQx+XjSO+TVvSUKiwu30CU6y0PsAk3Z+XpOUFtrZDtywFVtqVv3KGOWoSvTrJkIWplSDIMPin+XMH0DLto12usxWxbfyWz44Fs4Kje+xUU3tyePW84JdKqbYvnpskKLSLHtFF/AF5/YKdRcDE5RidgTbaxytgn3Ais+OvKaGY1k6+WSqUJS7vd9boBaIf37iPewyg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hg259A5aTwLIQ0wGxIVvnP+Nt1Jbauva8lRbi4Ionm4Nzegf0XHaisiWc8Y39ntkbLKuoj7+INWxMOdEzkGcG0b+fD9wgNecmli3Kdh+aahJWI9xBc7Q+jrOkTb8zdrEfYeliZ88BreixG1+jI7fYm1hvB3FF0lfbDDq8QB9CmtAVO9QI4IeMrGRdrMtOO2Rg9dGZfaQ4+GvQ6bpx4Apkg0DpvA3Ygb/LfhNQuW968dJkPE8AoZBRfIj7C/N9X85E658NRirDMv3H1LQw0qIBFWaCbFetO5SwGGu59uCelm9ir9W5vXbrej3+0QfgTGe9yi4OcKXuMd+ilhbasswGite7+IWlF002FRlT6VfWlznHn6z9QfhHl/hQgURReUq5P1XA27+kfvKtsMauDNzv7aUcS5TirORrTRYSrc3bfTD6cqrDMoD1RkpO6qW32yZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:46:51.3973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667cfbd9-01dd-424b-27f9-08ded1f70b91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:kuba@kernel.org,m:sd@queasysnail.net,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nirmoyd@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,queasysnail.net,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirmoyd@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D246A6BECB2


On 24.06.26 15:51, Simon Horman wrote:
> On Mon, Jun 22, 2026 at 01:28:47PM -0700, Nirmoy Das wrote:
>> splice_short grows its pipe with (MAX_FRAGS + 1) * 0x1000 so it can
>> queue one short vmsplice() buffer for each fragment before draining the
>> pipe. That assumes 4K pipe buffers.
>>
>> On 64K-page kernels the request is rounded to 262144 bytes, which
>> provides only four pipe buffers. The fifth one-byte vmsplice() blocks in
>> pipe_wait_writable and the test times out before it reaches the TLS path.
>>
>> Request enough bytes for the same number of pipe buffers using the
>> runtime page size, and assert that the kernel granted at least that much.
>> If an unprivileged run cannot raise the pipe above the system
>> pipe-max-size limit, skip the test because it cannot exercise the
>> intended path.
>>
>> Fixes: 3667e9b442b9 ("selftests: tls: add test for short splice due to full skmsg")
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> The nit below not withstanding, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>> ---
>>   tools/testing/selftests/net/tls.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
>> index 30a236b8e9f73..e3bf4ade0f770 100644
>> --- a/tools/testing/selftests/net/tls.c
>> +++ b/tools/testing/selftests/net/tls.c
>> @@ -997,6 +997,8 @@ TEST_F(tls, splice_short)
>>   	char sendbuf[0x100];
>>   	char sendchar = 'S';
>>   	int pipefds[2];
>> +	int pipe_sz;
>> +	int ret;
>>   	int i;
>>   
>>   	sendchar_iov.iov_base = &sendchar;
>> @@ -1005,7 +1007,12 @@ TEST_F(tls, splice_short)
>>   	memset(sendbuf, 's', sizeof(sendbuf));
>>   
>>   	ASSERT_GE(pipe2(pipefds, O_NONBLOCK), 0);
>> -	ASSERT_GE(fcntl(pipefds[0], F_SETPIPE_SZ, (MAX_FRAGS + 1) * 0x1000), 0);
>> +	pipe_sz = (MAX_FRAGS + 1) * getpagesize();
>> +	ret = fcntl(pipefds[0], F_SETPIPE_SZ, pipe_sz);
>> +	if (ret < 0 && errno == EPERM)
>> +		SKIP(return, "insufficient pipe capacity");
>> +	ASSERT_GE(ret, 0);
> nit: the line above seems redundant to me given the line below.


Thanks Simon. Sent v2 with the nit addressed.


>
>> +	ASSERT_GE(ret, pipe_sz);
>>   
>>   	for (i = 0; i < MAX_FRAGS; i++)
>>   		ASSERT_GE(vmsplice(pipefds[1], &sendchar_iov, 1, 0), 0);
>> -- 
>> 2.43.0
>>

