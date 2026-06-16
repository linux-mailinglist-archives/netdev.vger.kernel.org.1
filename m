Return-Path: <netdev+bounces-299842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HuZQEbpIMWpRgAUAu9opvQ
	(envelope-from <netdev+bounces-299842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19DE68FAFE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:59:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=DYbz2JYw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299842-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44743239200
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244536A34D;
	Tue, 16 Jun 2026 12:54:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA3369D6E;
	Tue, 16 Jun 2026 12:54:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614478; cv=fail; b=Y7ngZy77Ldlw7kQf76Ub2oVqtQ91tWkZjzSoHiOSbSAfJzQM58m8sfoKgsq2YXbBH3x3c/hi1asJZbL22ZsflwGwtU7L0aoUrie0VDIPzjhQAZazoexltpQL9Drxi1UDppRevts2QdMdhN01Cqtml2RebVF1a0Rfksnq8g+JGJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614478; c=relaxed/simple;
	bh=dbH9MGnKi1wlLD7wWhngfvgkfsnRUrh/euUg/GllsJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WQfwftHDnDfBfX1BW+fQkNxSDE+cTRc14HU884xMHDD+Td6wiagr0kOWjLDa5Ry6Nc+Kl8UgWZ/HKZn33YKyxjLZ4UUO4vEJW33WPXJC1rVqNzJFrqFTK0vm44BVLb6IcOUMEi6gRBOIqJz0dlhkI/U6/i293ssUBOV66Q3wb8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DYbz2JYw; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ9N96Hhh/dDmiq2Pl5/aqIzpQprd3o6HDrLdF5Objvb8PeeJ9lKDVsSYuV1nxIXKiFDmB5nXNYs80aqJmvmuYzLSMJcRlZ01ivsQQwRkSzDboFQyJHjURiWDPbCK45ZhdnKxL6DnHyeqNBFCWRm+3wt7vU4Xd2IP/bNoLJ7nI7hWTjT6bWdFuWWs5uQz4TInXu+bv3hXlak24wkCDvYSjUjKZ9RqCOvtvAfOC5FITW9J31PuBqlMnF5bHsoiV1kDRX9dRqriQckkN+yjTk51eu1+xBm0WDTOdsQxrEg3hb4mZ9F48Cz+NxJmH7cBh4aNgUlfCP4SpSJ8A6+iMbL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSf3030RVTK4uKHu0QPzsTd4Zqy3YqljDoHw7m8yJ5E=;
 b=Yzfs9gdUQRzCMGFeWs2ePFTQbppv9WrAu1tjkeZaoaOKMgXelZd3BOgjWEvEjy7hA5Hj/KNnUp231hyIXLpkN7R/AQenD2pQ4bLwjv0qubwgOQLELObzWBysoDxx6b/9XtFM4qTWd2zjPQjZt+FnlXavAOSSbEwJiJTRZBvVe2dO+MSzeSTUrVp+ZCAPbo6kWcikj7T2i4szSlYZlDYPzKAqZmeiDCai3gPasORPxTO4A/dSc0M0yq3hmqu1x94j550sTKj32kvqZgPcJog3EMe+bxWKIYvGqfzy92FZtgvRnPs+nEO0iR/MhKOKc0RlXOVt0y/Q0olNw0Z0JK0vZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSf3030RVTK4uKHu0QPzsTd4Zqy3YqljDoHw7m8yJ5E=;
 b=DYbz2JYwdMLGnuxdQWXyk14bpd0qzNS4lcOJQ/eIGLB2IAozeAeGypHPaotFMZklEf4LoTXXvunoENd4VWJdLRZgyl8OQDgCnG/PugigMF1KucXx3ayiYqjTU+j9pRkl6Al5CF2rf0yJVlaowEowEjXAFMzQDTwcCBEu/h+U+rI=
Received: from DS7PR03CA0136.namprd03.prod.outlook.com (2603:10b6:5:3b4::21)
 by SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 12:54:33 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::a9) by DS7PR03CA0136.outlook.office365.com
 (2603:10b6:5:3b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:54:32 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:54:29 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:54:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 16 Jun 2026 07:54:28 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65GCsMfU024437;
	Tue, 16 Jun 2026 07:54:23 -0500
Message-ID: <d0123269-b1e8-4fba-94b0-b94d3d9a5405@ti.com>
Date: Tue, 16 Jun 2026 18:24:22 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
To: Jakub Kicinski <kuba@kernel.org>
CC: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <arnd@arndb.de>, <basharath@couthit.com>,
	<afd@ti.com>, <parvathi@couthit.com>, <vladimir.oltean@nxp.com>,
	<rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, <vigneshr@ti.com>
References: <20260610052511.781752-3-m-malladi@ti.com>
 <20260615231041.1007484-1-kuba@kernel.org>
 <20260615163932.50bb3df0@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260615163932.50bb3df0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6102de-8bd4-413c-ebe9-08decba66912
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SQxr1KSDWCOlHg09/PVtVJowckHdAAot+cw3+XXuLBUnFtY03KSgmYqfI4x3d1aK/Fc8vZaX9A1Pl+qrWZwIAKnjdm+5trgArnsvzIgZWMBK10qi2VNEXngwQwqgUYGMNr7Z2Aie2kMe2pc7xRqAVxp0ZJnj8T5bZuM6sHl6JAA4WTPep2EIfY5RrfEBL5oRE96IL0IZLkGL5jM9xkVQVX2du16vkblBCcM8cVcg3Q7ZyvmQ/z0fC6U5K/UDtA4NKqv9q6wfcBYfjdTi7VLnOsraSWfwveQkQeypHcgYqTj/QRyVrryLjRMmNj4Gj7q5pEkDQgKua0Q4nhAVSEu69d3vI4wfmn4UImVytdSXjMYT1FfWG9fIQj8abTOzFg5XFOYxTnk37KdAxkGaN+71f8scSnZgWmBiORGJBp+JyFCKJ+MYxjH3dvqN6NDXIGOaZaomzlBNbH8rTk/PnfnKf6tLIxDtfelVVIQH3KZl2Rd8qyXCBbUywnzDrmzJ4NhZTZKtzpxi1zLgR4Pk/UYOvuk6nn4dbr2j53NuKXKF608U7kCorzjoYzb0Urf4ndM2ABcas0F8Aj8o84aQW30c1IrVnrIFpvhhoyXOneP+KC+N44Gv3Fw7slhHfB2pAg/iGbvynVNsAKlez8pGf6mwzDPBJypDU75ZXzzT5X9MsgMq/dzMUSoNkR/u5rF6Ye6KmXLJFhQKf3orhbHbFddYKCbWY9RAfGw5kgTYXCgrFbg=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AlXsitBGVw3Q3G9cJSx8rfXJJna1ZnIk5xzvaTqtvPCLsTZQLFFBH5gSDBmgK4qK6yVo4zOehER6Y+W6+FH8a1JUBgrESFAs4OtBTaHivpWH+iARtdF6nfBJnSvcxpGbDhAy40lRmY+CcbsEfQQOGfOJeH++frepgYoXskozcRquOKz10CwMxhsdCh1fLq2a8YZ4F6IM2wxAMkd0xw4MSpv/1M3C4GK/ZQI43k54S5NkbLTTiOqsmBtoAUP6BiNmvI6ATCSULv8AKdpcKFvFWBXBzrGKkzBV5N94NrH56EdkUV/Z2FtQZ+upml7hJcaB2DHx1tstbLhRjYDkicmuPSIrvbaGD7vTOYRnG6L7Tbq5NntIHIAHzG92mFAnPFqEMK9w1LFLJglDD+GbB5kNNR5Y8mb9rYiyvkpjbvDrCdmrF+c3d5/dLzTI/RueBr7e
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:54:32.0031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6102de-8bd4-413c-ebe9-08decba66912
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ti.com:dkim,ti.com:mid,ti.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C19DE68FAFE

Hi Jakub,

On 6/16/26 05:09, Jakub Kicinski wrote:
> On Mon, 15 Jun 2026 16:10:41 -0700 Jakub Kicinski wrote:
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>>> index 5ec0b38e0c67..8073deac35c3 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>>> @@ -189,6 +187,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
>>>   	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>>>   	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>>>   	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
>>> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
>>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
>>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
>>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
>>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>>>   	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>>>   	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>>>   	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
>>
>> [Medium]
>> Are these five new entries duplicating values that already have a
>> standard uAPI?
>>
>> The same five firmware counters are exposed through the new
>> .get_mm_stats callback as the standardized MAC Merge stats
>> (MACMergeFrameAssOkCount, MACMergeFrameAssErrorCount, MACMergeFragCountRx,
>> MACMergeFragCountTx, MACMergeFrameSmdErrorCount in struct
>> ethtool_mm_stats), and adding them to icssg_all_pa_stats[] also
>> publishes them via emac_get_strings() / emac_get_ethtool_stats() as
>> ethtool -S strings.
>>
>> Documentation/networking/statistics.rst describes ethtool -S as the
>> private-driver-stats interface; counters that have a standard uAPI are
>> expected to flow only through that uAPI.
>>
>> Could the firmware-register lookup table used by emac_get_stat_by_name()
>> be separated from the ethtool -S string table, so the new preemption
>> counters feed get_mm_stats without also showing up under ethtool -S?
> 
> This -- not sure about the other complaints but this one looks legit.

I agree that this is legit, but right now there is no other place holder 
other than pa stats to put the mac merge firmware counters. I believe
the effort needs to go in re-structuring the hardware and firmware stats 
implementation to address this issue.


