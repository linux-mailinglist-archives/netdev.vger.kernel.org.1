Return-Path: <netdev+bounces-298485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GOtEIMu3K2pdCwQAu9opvQ
	(envelope-from <netdev+bounces-298485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:39:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504E67751F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:39:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=KY8vLsWj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298485-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298485-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EE76300D173
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8437CD52;
	Fri, 12 Jun 2026 07:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F35396D14;
	Fri, 12 Jun 2026 07:39:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249992; cv=fail; b=JFBFJlhvdlbJKPfy4v9CSDmB1h89OEu/l2DN6TrdZx1Jomj1X3IoeAM1B+3QvnfIE8OLi9Gj/N6AhzcR1ugRq+uGtOiMGy+X9YDdSLR5rxpHBwpuwIJEnfmzYTaZ8amWTJS4V3WoAKnPVQQJ8qCYzrg7dRyDOytxbVi3Jcp9Yr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249992; c=relaxed/simple;
	bh=h5IOnQOE/20l9uNU6217dy5xFeKYoqGhLhcohIm1hrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R+WnBjFyAjkJnjfM0NHQWmzrLd/kVK9dJ7MRvh71GIO9EwO1Wh+Sn1nWZmUY7fS7y8dRCh5O+7fIJkpy/TvmvBRA7ICVJ3mjdkIZJGsdrqzfReQlmPuy1p2EmnihBMjJALilXas83+oM4bnbmq/xtQIwKTsZHL16p8J49lTYZtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KY8vLsWj; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HepqWIyJrsGI2XaxyFIHdHRhkbfsekjmCtAcnu3wqUHsolbBrL0IDVpyqq1njvR1sxSEhwP6vnIP1q37ONXNkdq9QS3XFfrLd/q+KyDMT5YMXGChN7b92DjvA+GnZziq7k3mAtwrTCLk7H1jEfIqXeEONkfOwrKGZnAbXo3KY7XCLpb1iVCLMyYnhUNuGNNM+O6rx4Esm5yNPLqopReLIZGd+hhb1W9fDdO349npKxWgWwqh8tRVvyNZwYXh0NTyy1DQSsIHAvJU9RaJGv2RdZGBZBvzSAwsqF0dARKxEU5vxUIizhBGJyNNMq71G2O5hMclsB4ztMUAiJ9nRKcLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJdD6cpTPifGYy7OFaKdV6UfGhCrss85UphO3cSVB/M=;
 b=UY9t+s/NLAyY7LrPAuLByPXqIKbLPQZVSASnF0smGeqFFQPJ4RiQyfbRTG/mz4K3BUqHdXHrR90mRhLokk4gGU/6z3D4Xquh10qbhnd3LzhqMrMsIEaDhIutiH3RwDm/IOhtWoecBVTD6lXG6z4gljzx5dNa+PTeqAEPbOmLotI7MaUABWAHnnbHtpY0R3TtwzN/n8BBsMK6xC3wsqoK8Vn/wGYZuj91CFRvLQMk8gY7qP90uGwmEET9T21s5aS9NRHG+HHD01K+v39SNapv0oIdmz3U1/8WozyGY1f/EB902N6dq8GG8Ao6k2UFCelBx6+IubhDXf37rlpSBhxlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJdD6cpTPifGYy7OFaKdV6UfGhCrss85UphO3cSVB/M=;
 b=KY8vLsWjOgbnlYAaqT8tKNIRb6Hn97LKxbN6BasrFcfrKykK7ZbC/mQppv7ufXsTGtXIj4a8cHzMMAKF5l+oenwdcDE/XjqbZuDwVWB5xgmjUq+flUx01eV79vpKBokIiis6hmWlvSgUXp4eRi7PrXTWbpPrlUJWIwtaO2BiXjE=
Received: from DS1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:8:44f::6) by
 PH0PR10MB5644.namprd10.prod.outlook.com (2603:10b6:510:fb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.14; Fri, 12 Jun 2026 07:39:48 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:8:44f:cafe::4f) by DS1PR04CA0006.outlook.office365.com
 (2603:10b6:8:44f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 07:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 07:39:46 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 02:39:12 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 02:39:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 12 Jun 2026 02:39:12 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65C7d5043591894;
	Fri, 12 Jun 2026 02:39:05 -0500
Message-ID: <ab7242c4-0c8f-4199-a9f6-02cd36755a89@ti.com>
Date: Fri, 12 Jun 2026 13:09:04 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/3] Add standard stats for HSR/PRP
To: Andrew Lunn <andrew@lunn.ch>, Felix Maurer <fmaurer@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Roger Quadros
	<rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Meghana Malladi
	<m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, David Carlier
	<devnexen@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kevin Hao
	<haokexin@gmail.com>, Markus Elfring <elfring@users.sourceforge.net>,
	"Hangbin Liu" <liuhangbin@gmail.com>, Fernando Fernandez Mancera
	<fmancera@suse.de>, Jan Vaclav <jvaclav@redhat.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Luka
 Gejak <luka.gejak@linux.dev>
References: <20260611095035.852370-1-danishanwar@ti.com>
 <e8965004-f286-4589-a834-309ccaa1d575@lunn.ch>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <e8965004-f286-4589-a834-309ccaa1d575@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH0PR10MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 17304a49-e89f-422e-81e3-08dec855c6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|22082099003|18002099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/A+HdPp/MHa54fYcWXvKPT0oplIRjJRdzRbiRHqflXzY2HJeVu+3GMrjClLGpCWiRD3PPxNeeEN4w5y9vQuEIW4JTg1YlGnsf5h7RFrtPSrJOja3xmY64P240gaTovXC2WGD2Z8Xx1LiUlYkxeJzW87TrA8bzf5vx/T9msdYZq9eQs0ZoaOhPIM1o7rhPO7tcXf1w5YTlAPCue4Y3u+oDKhUMpLHRo20rBRzpWKJEBL3TI7AAfj7IpowWg8XhuC320R6urh8UQrs4paAW3d+EMOxM5pxLqNl70XiOeCL7+Na7BHa5enFdMsDpqBQbx5Wqx/A9dhoWrgAaAdkPBLAkrRzDrOriFxkYazSg8QHjcSJNekz6apLwqdhvAuuhlERIieEPAqN0FZCGhvGj97LN5UAk+cS8KfogG0ssgngrG9W4q8P1xzUouZ8c0crVf5pXXEhziInDzdhzeBK3u4C76d1n9cDvihqVx+PD+N+XnRkvKRQQ9TQyXO6kck+v/UzZ7gbc7XJoTujb/qsrmjAcvsOZXp3Xl1AMW3t3KzbKc3f/VTRcr+DWcgvktWV1ZltO1W/iSqAhzmfsLPQU/5KRBasUW/568DAes1FnwKRmqsuTQkJwjcPZY2e6aJzjrtHd7jZ3sadSQr0uR4gKqY1alLZsatY9il/axefeZyoHyIV/CuaqSSrekQmh8Bleiwlu+Zxv6RauTgNzvVHmx/mwdK4LlO4V0onuikaxfIEKhc=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EUeK0mbGZKwMkmttCJqe3GReK3lgVOc+tUZPQzFwtI3VLTfnncS7b5dradjstjR2zlGn5ccxA4RBppJsdsdpN03iGxebEUB01srIAnT3svQc8WRaWNgTnkBr63UP/oikFjTtyHGTq8Z7n4sNGQh7JapLCzpzxK3xtLxNRVlFJbtuWVk801XbFnJSj1Ugd/XjF11C+wJV9jFemAvh6NSK/OHIE3IZPHz2eVsD3vFEMRn13LKOn+pbRWXHJnp2q2pTr1pMBV1kmAdpFUX/AyUL1PmYDFRLijRSraRvqxfospYHqKfugLygroSSLOpduYyFbwCNTxrlw2U5UVXxYwLKvfHqr+8cXGv5pxKl29UYWN+inSO19CZnNk8ARx9OJQ2KB06q89hhiwqTXmoSban8xK2KQ0YpjxshERREyTYWotvyCp5OnYp2INx1H4s+HKuz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:39:46.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17304a49-e89f-422e-81e3-08dec855c6bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5644
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ti.com:dkim,ti.com:mid,ti.com:from_mime];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:fmaurer@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:m-malladi@ti.com,m:jacob.e.keller@intel.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:elfring@users.sourceforge.net,m:liuhangbin@gmail.com,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:luka.gejak@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,ti.com,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9504E67751F

Hi Andrew,

On 11/06/26 9:20 pm, Andrew Lunn wrote:
> On Thu, Jun 11, 2026 at 03:20:32PM +0530, MD Danish Anwar wrote:
>> Add standard stats for HSR / PRP. This series was initially adding HSR/PRP
>> related stats for ICSSG driver. Based on maintainers' comments on v2 I am
>> now adding support to dump standard stats for HSR/PRP.
>>
>> The drivers which support offload can populate these standard stats.
>>
>> This series only implements offloaded stats. For software-only interfaces
>> Felix Maurer had said he will do it later [1]
> 
> That is ideally the wrong way around. Offloading it used to accelerate
> what Linux can already do in software. Statistics should be part of
> this, you first define software statistics, and then get the hardware
> to report those.

On v2 of the series Felix commented saying I should go ahead with the
hardware stats first and he can later implement for software only
interfaces [1]. This is the reason I went ahead with this. Initially
this series was not standardizing the stats of HSR/PPR interfaces, it
was only meant for dumping those stats for ICSSG via ethtool -S.

Felix and Jakub commented saying I should standardize these stats.

Hi Felix, When can you implement the same for software only interfaces?
If we can't add support for hardware interfaces before software only
interfaces, then what should be the next steps?

[1]
https://lore.kernel.org/all/ag87pBZfOyccPZTc@thinkpad/#:~:text=(no%20need%20to%20implement%20it%20for%20the%20software%2Donly%20interfaces%0Ain%20this%20patch%20series%2C%20I%20can%20do%20that%20afterwards%20as%20well)

> 
> So please get the software statistics merged first.
> 
>    Andrew

-- 
Thanks and Regards,
Danish


