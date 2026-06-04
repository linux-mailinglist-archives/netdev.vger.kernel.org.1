Return-Path: <netdev+bounces-295255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6TWIMLWEIWqIHwEAu9opvQ
	(envelope-from <netdev+bounces-295255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:59:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178576409B5
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:59:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=nmOsn7BK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295255-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295255-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D49DF319A042
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB4447DF90;
	Thu,  4 Jun 2026 13:45:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C937E304;
	Thu,  4 Jun 2026 13:45:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580749; cv=fail; b=L6Bq16UoaCLJ5duwnFPD1FbTInItpk8A8tKIxJxaioR7w66C4sh3jcKFB86Rqhsk3Ku1HWKxLq4boPwSj5aPBabXlPzDfstRDiKsO/ITEJguVnoz/CaQ0KTJLihq6yvPlY3yyRTznNPvcfIQwWYaCJ6NQBTe8asmeK8EsWfq8pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580749; c=relaxed/simple;
	bh=V5We3fcyBT7kLjLcnAXaSZ7Yeo0di2w8mNv7mugtkZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GzktnTqMfRvimrkXxk9uNrNRDDonRGasUe5RhG/7hsDKbLKJ4yvA9b4dx2lVZqZI0zvh9Dj6/23pxc+wt6wkwRsey9lhtdEnNv20WIhpRiiMRp7SQmfEfirUzBByrcKiGOEPMdjmZyLW1iV9R6u0HayOm7O0jW3dljyGnOAWnK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nmOsn7BK; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1peX5cYyJ5QoirYXx2AIkC9je5iNfYEx4PETRpMGhh1tVPOJpA6i2rdtFpcv4kbsshBTHHQBPkILoAgqMjuNiQ5n9r1J7owWMdITz69r4VcX8CE9vGD31v7XBUlx8UbGDtrZITZXTgwdjB5/t34WEc0FZeVD3sRkYCZj1VzKj8R7NSVzN5xJyZHymVExQJtRXoiht61Hf2zjr1N8q+0iLaAPsmlnr/fKWWdTY7PvBnbl2fqWymEp0b4uk8pCD3HyIVaoVZ6XNBBR+SHna2oIYSGAY/fnVF/yi8KyQlDi8kQFUyjwg60FKd2qKIHPJy17+1V4etCgtMzeEkZdgc6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA6BkINH/v+UA1P/W1NI/E1R55AagfN9RlLyHR1X7RU=;
 b=X7Gu3tdBFCeO5W5isynMbLD2wIr+dO+3Al5HQkZcWOSVZO+biwg95sC0SKuwK6ootDgXc1evckQw5mcDtieG4U/+fjeXuu+ksvuQ3T9/X9+4AnAVPw6Uw39wTu+jeqlrRpm4B4luEVMMOopa0Q/VJXKV5xcRi25vCULaX73rm8UrHDuOfnPxJdsKILFg8XEYpQdvRWFMqo3HbORPIMA72V2gRKwew9B6oa8GvM+HaqEuNCtPNgzzGhu7zY+82bCqZLKgoZy+RvghXU4f7Hz3r/yjrV+keTeUf6zD0uHWCIz9bWxSAtyvmVaDi1ADPbq8Nm7nkWS4Lhf3pyVywtVUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA6BkINH/v+UA1P/W1NI/E1R55AagfN9RlLyHR1X7RU=;
 b=nmOsn7BKpgzG29ZDM+o6955zyfUkqcKu+hAOOk8bpuBa3Eq+0YiF0UqrSLRbzfzm0Ua6Er0DIODRAXaTjf2hgqTsHXXAW49W7yRbAVOA0xstV9xscUA+oTAVNe3/fGYnkdyqImOP0AgKxAZOhsDVK3Y7RoOpbZLhmDtn4k7QYag=
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by DM3PR10MB7926.namprd10.prod.outlook.com (2603:10b6:0:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:45:44 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::6f) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 13:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:45:42 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 08:45:18 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 08:45:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 08:45:16 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654Dj91C3476705;
	Thu, 4 Jun 2026 08:45:09 -0500
Message-ID: <7c4a4ff9-91b8-46a8-8b97-a0b682418a1f@ti.com>
Date: Thu, 4 Jun 2026 19:15:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, <liuhangbin@gmail.com>,
	<h-mittal1@ti.com>, <haokexin@gmail.com>, <vadim.fedorenko@linux.dev>,
	<devnexen@gmail.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<arnd@arndb.de>, <afd@ti.com>, <basharath@couthit.com>,
	<parvathi@couthit.com>, <vladimir.oltean@nxp.com>, <rogerq@kernel.org>,
	<danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20260525182700.3135858-1-m-malladi@ti.com>
 <20260525182700.3135858-3-m-malladi@ti.com>
 <7f194a90-8bf6-4217-b5fa-c003b3dc85b3@bootlin.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <7f194a90-8bf6-4217-b5fa-c003b3dc85b3@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DM3PR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: fe39a92e-0559-4f53-5a06-08dec23f926b
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|921020|6133799003|22082099003|18002099003|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	17AMEBqLP9lpeN7eHaJaMr/zu6qtUGnaRbs5q13FmGuTWIABg9gsSivPjus8mvjr8drtZIWOLS6bU0DBWdicnfzBqdWJAS3SpOhjrnlGXfUkYVRffZB3+1XJoZphRdx2S16w4In/b3lPjGUUp+onBYVwl1+a04yrHEmmExye1atElQ2RfBFZ1ZNAeRR2dIOZvhK0H4EgU8Ip8V1BHNvrmINMiM5Yed4PU/0MEdDE4E2Tb2JZBpofNyCLReaeXcbj9hQFl1v4dMR/7W7v2g7HpKoVuFr7M/O5iyoLU7Hylky8pBDQpavYQOU62G3hU4omAyZaTvRJGEPYJsd4V0rGetep9bSaTbAp4XTn4cwwzimsw1DtaRSDkMr5kjSiFwfIK1p0an/4bkvwNO3buMeKJOcImZBwoN+l1edARdh5Ce7PXt/o90h3bQujB8HH96MWOPX+j+DFUgA3BuejzTzzs7w/vJd5PVd0WX/eUeS9JTXN13z5m/vb9+8DKcPuaKieGT45ITJBU6b0XKgNfQqY6BklKCeyeI9a5AU6dLo9XzgYZDNQQKv/RnzdyWLRKM8MwIY7iFbsaelp/vxsu8+bkL/JBXLsIh6CYMJA4KKJbp8CzdAC9kqGWSmmM2fylVgSvArtOW4t563ulhb4NZeuSHozzjC0epsy7aiPkGhX/HwIqUDuLtenDFm83prZUQAcxvrHkowkPu+2TIWb4hbg9rJb74LFDTca/NYKycugnJU=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	70pb64vDeQ7QPC0wDx51qkQMwv+HocpwnaPDE7wRnGuxX+k3D2kb2C3z/AxYchSxSEpqZPBYqGnR0v3mUYBpgDaJ1E6ZsJF22OtygQDjHqxb0OAWoXm9KSQJVL+zyqEn72FCbV/H+Rz864pIC2iKFCZp1TbvkdVh/9gBmVngDK+UTdm1xEZfqWK0+aWZYtIPo31zLC8J7hqmQZyPpqQXb6OQ8+jfDU1soOqGcpWZUTvF8uHwGoGnwUMtLAIFiNzfNYsNTH5u+3XR2HJDIc2mqy7PkzsB0xuu7ic7KzUZkq+wMmvsZC3nB/6rtVqUtJtKIg7tXHf7PCm9pEcizDSFrKbabpwzHw65f8dDkAI2scUW3W7UGAZrzrZDCqm9HVQXtyL0CAvREhAh4TRubWRt8S0OK0aasxADO9Dq79mx36zMBuZigty0BQqWmMLml1AV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:45:42.7185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe39a92e-0559-4f53-5a06-08dec23f926b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7926
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295255-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,ti.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:liuhangbin@gmail.com,m:h-mittal1@ti.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:afd@ti.com,m:basharath@couthit.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:from_mime,ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 178576409B5



On 5/26/26 01:05, Maxime Chevallier wrote:
> Hi,
> 
> On 5/25/26 20:27, Meghana Malladi wrote:
>> From: MD Danish Anwar <danishanwar@ti.com>
>>
>> Add driver support for viewing and changing the MAC Merge sublayer
>> parameters via ethtool ops: .set_mm(), .get_mm() and .get_mm_stats().
>>
>> The minimum size of non-final mPacket fragments supported by the firmware
>> without leading errors is 64 Bytes (including FCS). Verify time 
>> bounded to
>> 1-128 ms per 802.3-2018 clause 30.14.1.6. Add a check to ensure
>> user passed tx_min_frag_size argument via ethtool, honors this.
>> Add pa stats registers to check statistics for preemption, which can be
>> dumped using ethtool ops.
>>
>> Fix emac_get_stat_by_name() to return u64 instead of int and return 0 on
>> error instead of -EINVAL. This prevents invalid stat lookups from 
>> corrupting
>> output stats with signed error codes cast to u64. Error conditions are 
>> still
>> logged via netdev_err().
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>
>> v6-v5:
>> - Initialize tx_min_frag_size and verify_time with valid values
>>    to avoid returning corrupted values during get_mm()
>> - Fix rx_min_frag_size to ETH_ZLEN excluding ETH_FCS_LEN
>> - Fix return codes for emac_set_mm()
>> All the above changes address the comments raised by sashiko
>>
>>   drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 106 ++++++++++++++++++
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +-
>>   drivers/net/ethernet/ti/icssg/icssg_qos.h     |  46 ++++++++
>>   drivers/net/ethernet/ti/icssg/icssg_stats.c   |   4 +-
>>   drivers/net/ethernet/ti/icssg/icssg_stats.h   |   7 +-
>>   .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
>>   6 files changed, 168 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/ 
>> net/ethernet/ti/icssg/icssg_ethtool.c
>> index b715af21d23ac..ee940051644d6 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> @@ -294,6 +294,109 @@ static int emac_set_per_queue_coalesce(struct 
>> net_device *ndev, u32 queue,
>>       return 0;
>>   }
>> +static int emac_get_mm(struct net_device *ndev, struct 
>> ethtool_mm_state *state)
>> +{
>> +    struct prueth_emac *emac = netdev_priv(ndev);
>> +    struct prueth_qos_iet *iet = &emac->qos.iet;
>> +    enum icssg_ietfpe_verify_states verify_status;
>> +
>> +    if (emac->is_sr1)
>> +        return -EOPNOTSUPP;
>> +
>> +    mutex_lock(&iet->fpe_lock);
>> +    state->tx_enabled = iet->fpe_enabled;
>> +    state->tx_min_frag_size = iet->tx_min_frag_size;
>> +    state->tx_active = iet->fpe_active;
>> +    state->verify_enabled = iet->mac_verify_configure;
>> +    state->verify_time = iet->verify_time_ms;
>> +    verify_status = iet->verify_status;
>> +    mutex_unlock(&iet->fpe_lock);
>> +
>> +    state->rx_min_frag_size = ETH_ZLEN;
>> +    state->pmac_enabled = true;
>> +
>> +    switch (verify_status) {
>> +    case ICSSG_IETFPE_STATE_DISABLED:
>> +        state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
>> +        break;
>> +    case ICSSG_IETFPE_STATE_INITIAL:
>> +        state->verify_status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
>> +        break;
>> +    case ICSSG_IETFPE_STATE_VERIFYING:
>> +        state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
>> +        break;
>> +    case ICSSG_IETFPE_STATE_SUCCEEDED:
>> +        state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
>> +        break;
>> +    case ICSSG_IETFPE_STATE_FAILED:
>> +        state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
>> +        break;
>> +    default:
>> +        state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
>> +        break;
>> +    }
>> +
>> +    /* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
>> +     * variable has a range between 1 and 128 ms inclusive. Limit to 
>> that.
>> +     */
>> +    state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
>> +
>> +    return 0;
>> +}
>> +
>> +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg 
>> *cfg,
>> +               struct netlink_ext_ack *extack)
>> +{
>> +    struct prueth_emac *emac = netdev_priv(ndev);
>> +    struct prueth_qos_iet *iet = &emac->qos.iet;
>> +    int err;
>> +
>> +    if (emac->is_sr1)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (!cfg->pmac_enabled) {
>> +        NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    err = icssg_qos_validate_tx_min_frag_size(cfg->tx_min_frag_size, 
>> extack);
>> +    if (err)
>> +        return err;
>> +
>> +    err = icssg_qos_validate_verify_time(cfg->verify_time, extack);
>> +    if (err)
>> +        return err;
> 
> The ethnl code already validates the verify_time :
> 
> https://elixir.bootlin.com/linux/v7.0.9/source/net/ethtool/mm.c#L153
> 

I remember getting a comment asking me to add a comment or check to 
validate tx_min_frag_size, I don't remember at this point why I added 
for verify_time as well, lost track in the comments lot. I will remove 
it. Just to confirm, do I need icssg_qos_validate_tx_min_frag_size() or 
can I remove it as well ?

>> +
>> +    mutex_lock(&iet->fpe_lock);
>> +    iet->verify_time_ms = cfg->verify_time;
>> +    iet->tx_min_frag_size = cfg->tx_min_frag_size;
>> +    iet->fpe_enabled = cfg->tx_enabled;
>> +    iet->mac_verify_configure = cfg->verify_enabled;
>> +    err = icssg_config_ietfpe(ndev, cfg->tx_enabled);
>> +    mutex_unlock(&iet->fpe_lock);
>> +
>> +    return err;
>> +}
>> +
>> +static void emac_get_mm_stats(struct net_device *ndev,
>> +                  struct ethtool_mm_stats *s)
>> +{
>> +    struct prueth_emac *emac = netdev_priv(ndev);
>> +
>> +    if (emac->is_sr1)
>> +        return;
>> +
>> +    if (!emac->prueth->pa_stats)
>> +        return;
>> +
>> +    /* MACMergeHoldCount stats is not tracked by the firmware */
>> +    s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, 
>> "FW_PREEMPT_ASSEMBLY_OK");
>> +    s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, 
>> "FW_PREEMPT_ASSEMBLY_ERR");
>> +    s->MACMergeFragCountRx = emac_get_stat_by_name(emac, 
>> "FW_PREEMPT_FRAG_CNT_RX");
>> +    s->MACMergeFragCountTx = emac_get_stat_by_name(emac, 
>> "FW_PREEMPT_FRAG_CNT_TX");
>> +    s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, 
>> "FW_PREEMPT_BAD_FRAG");
>> +}
>> +
>>   const struct ethtool_ops icssg_ethtool_ops = {
>>       .get_drvinfo = emac_get_drvinfo,
>>       .get_msglevel = emac_get_msglevel,
>> @@ -317,5 +420,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
>>       .set_eee = emac_set_eee,
>>       .nway_reset = emac_nway_reset,
>>       .get_rmon_stats = emac_get_rmon_stats,
>> +    .get_mm = emac_get_mm,
>> +    .set_mm = emac_set_mm,
>> +    .get_mm_stats = emac_get_mm_stats,
>>   };
>>   EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/ 
>> net/ethernet/ti/icssg/icssg_prueth.h
>> index 85f7017d2c8e7..61320c252bec2 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -45,6 +45,7 @@
>>   #include "icss_iep.h"
>>   #include "icssg_switch_map.h"
>>   #include "icssg_qos.h"
>> +#include "icssg_stats.h"
>>   #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>>   #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
>> @@ -58,8 +59,8 @@
>>   #define ICSSG_MAX_RFLOWS    8    /* per slice */
>> -#define ICSSG_NUM_PA_STATS    32
>> -#define ICSSG_NUM_MIIG_STATS    60
>> +#define ICSSG_NUM_PA_STATS    ARRAY_SIZE(icssg_all_pa_stats)
>> +#define ICSSG_NUM_MIIG_STATS    ARRAY_SIZE(icssg_all_miig_stats)
>>   /* Number of ICSSG related stats */
>>   #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
>>   #define ICSSG_NUM_STANDARD_STATS 31
>> @@ -460,7 +461,7 @@ int emac_fdb_flow_id_updated(struct prueth_emac 
>> *emac);
>>   void icssg_stats_work_handler(struct work_struct *work);
>>   void emac_update_hardware_stats(struct prueth_emac *emac);
>> -int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>> +u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>>   /* Common functions */
>>   void prueth_cleanup_rx_chns(struct prueth_emac *emac,
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ 
>> ethernet/ti/icssg/icssg_qos.h
>> index 9355e96bbcda8..87ca031afcaa4 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
>> @@ -13,6 +13,7 @@
>>   #define ICSSG_EXPRESS_Q_MASK_ALL        0xFF
>>   #define ICSSG_IET_MAX_VERIFY_TIME        128
>>   #define ICSSG_IET_MIN_VERIFY_TIME        1
>> +#define ICSSG_IET_MAX_TX_MIN_FRAG_SIZE        252
>>   /**
>>    * enum icssg_ietfpe_verify_states - status of MAC Merge Verify 
>> returned by firmware
>> @@ -63,4 +64,49 @@ void icssg_qos_link_state_update(struct net_device 
>> *ndev);
>>   int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum 
>> tc_setup_type type,
>>                  void *type_data);
>>   int icssg_config_ietfpe(struct net_device *ndev, bool enable);
>> +static inline int icssg_qos_validate_tx_min_frag_size(u32 min_frag_size,
>> +                              struct netlink_ext_ack *extack)
>> +{
>> +    /* Firmware takes min_frag_size including FCS length.
>> +     * The firmware requires the fragment size (including FCS) to be
>> +     * a multiple of 64 bytes. Since 64 bytes = ETH_ZLEN + ETH_FCS_LEN,
>> +     * valid user-facing values are: 60, 124, 188, 252.
>> +     */
>> +
>> +    if (min_frag_size < ETH_ZLEN) {
>> +        NL_SET_ERR_MSG_MOD(extack,
>> +                   "tx_min_frag_size must be at least 60 bytes");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (min_frag_size > ICSSG_IET_MAX_TX_MIN_FRAG_SIZE) {
>> +        NL_SET_ERR_MSG_MOD(extack,
>> +                   "tx_min_frag_size must not exceed 252 bytes");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if ((min_frag_size + ETH_FCS_LEN) % (ETH_ZLEN + ETH_FCS_LEN)) {
>> +        NL_SET_ERR_MSG_MOD(extack,
>> +                   "tx_min_frag_size must be a multiple of 64 bytes 
>> minus 4");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
> 
> Is there any reason this helper is in a header file instead
> of being directly in icssg_ethtool.c ?
> 

I don't have any strong reason as such, I didn't want to put any helper 
functions in icssg_ethtool.c.

>> +
>> +static inline int icssg_qos_validate_verify_time(u32 verify_time_ms,
>> +                         struct netlink_ext_ack *extack)
>> +{
>> +    /* 802.3-2018 clause 30.14.1.6: aMACMergeVerifyTime must be
>> +     * between 1 and 128 ms inclusive
>> +     */
>> +    if (verify_time_ms < ICSSG_IET_MIN_VERIFY_TIME ||
>> +        verify_time_ms > ICSSG_IET_MAX_VERIFY_TIME) {
>> +        NL_SET_ERR_MSG_MOD(extack,
>> +                   "verify_time must be between 1 and 128 ms");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
> 
> And this shouldn't be needed as the ethnl mm code already validates
> these boundaries, as they are straight from the standard.
> 

Will remove this is my next version.

>>   #endif /* __NET_TI_ICSSG_QOS_H */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/ 
>> net/ethernet/ti/icssg/icssg_stats.c
>> index 7159baa0155cf..cfdb6f5dc5da1 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> @@ -74,7 +74,7 @@ void icssg_stats_work_handler(struct work_struct *work)
>>   }
>>   EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
>> -int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
>> +u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
>>   {
>>       int i;
>> @@ -91,5 +91,5 @@ int emac_get_stat_by_name(struct prueth_emac *emac, 
>> char *stat_name)
>>       }
>>       netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
>> -    return -EINVAL;
>> +    return 0;
>>   }
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/ 
>> net/ethernet/ti/icssg/icssg_stats.h
>> index 5ec0b38e0c67d..8073deac35c3e 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> @@ -8,8 +8,6 @@
>>   #ifndef __NET_TI_ICSSG_STATS_H
>>   #define __NET_TI_ICSSG_STATS_H
>> -#include "icssg_prueth.h"
>> -
>>   #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
>>   struct miig_stats_regs {
>> @@ -189,6 +187,11 @@ static const struct icssg_pa_stats 
>> icssg_all_pa_stats[] = {
>>       ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>>       ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>>       ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
>> +    ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
>> +    ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
>> +    ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
>> +    ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
>> +    ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>>       ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>>       ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>>       ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/ 
>> drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> index 7e053b8af3ece..855fd4ed0b3f6 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> @@ -256,6 +256,11 @@
>>   #define FW_INF_DROP_PRIOTAGGED        0x0148
>>   #define FW_INF_DROP_NOTAG        0x0150
>>   #define FW_INF_DROP_NOTMEMBER        0x0158
>> +#define FW_PREEMPT_BAD_FRAG        0x0160
>> +#define FW_PREEMPT_ASSEMBLY_ERR        0x0168
>> +#define FW_PREEMPT_FRAG_CNT_TX        0x0170
>> +#define FW_PREEMPT_ASSEMBLY_OK        0x0178
>> +#define FW_PREEMPT_FRAG_CNT_RX        0x0180
>>   #define FW_RX_EOF_SHORT_FRMERR        0x0188
>>   #define FW_RX_B0_DROP_EARLY_EOF        0x0190
>>   #define FW_TX_JUMBO_FRM_CUTOFF        0x0198
> 
> Maxime

Thanks,
Meghana

