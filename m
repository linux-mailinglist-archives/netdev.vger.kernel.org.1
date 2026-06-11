Return-Path: <netdev+bounces-298049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a3FEK3SFKmqwrgMAu9opvQ
	(envelope-from <netdev+bounces-298049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:52:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A314670973
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=nYe8M3iY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298049-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298049-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBE603095465
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A73C65FD;
	Thu, 11 Jun 2026 09:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F403C4576;
	Thu, 11 Jun 2026 09:50:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171461; cv=fail; b=XYvx4R022i0B98B9ZEzmN/6SeMRw05EVwT+wzA+hNZ6s2hyZOYUS6+X8YGzyp6lOmaIe/fHVZ8zYIu4GqSPSl8+6RJVBW/2+b9XRVeWWPgcAl359tO3HuFlefyrCmeQjkEHeMKtsanLHtmnM3bRDa5Moraaxk/AFmGS+Kb10J0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171461; c=relaxed/simple;
	bh=DxYGOSaM5epktyJpu/M/C3T8eww7nrmt6oHu4BR8EOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0pKJlFgWmTsD8gaIhTHzQZskgf1fujdF7ZivZX8zRK03AefvV/Tj30WZECmycLKcl4G4pSuwm5/B83aYpC6VhlE7tzZFcmhO4/jqAut4klOJly50euABQnXvoiRCy0ADijJoR0ZqtXmnMhQNBOIA/Ddp3qdfUat0dkujbNx1NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nYe8M3iY; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIR4hi2pixOZqSbyacA9TyNV8wlJwBj+6CpEIG6Ow+s+O8IbH8t3sFC/ATsKfrUorEiOSjEAM1+BzuQz5bcQJeZwDaAwfyD7d6DxhCHSkkhdaS14pHaCtghDHDAvXNigkLe0BJeBicImrVo7asdPBD4gRMMpARdBM65uWwme4j4hGGoiJ8/QQxCzh5qHkex1NgoHUT0DCWEofHaypaNl5+yFbx5jPn5X/z3VOLM2958cMdupk/5V2EnTZqBUEYLnZoxwWrjNeAE6xqV+0Nb+HA4574UUjYZSstlpoh+KJ35gg1jOfk/9v8bv+pomzksi3OaZ6IeEBO1lf0N3Dzd5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl+Pp8mK4RH21F1N6maJfnV/4juvSeWi3Db0Hxk8ir4=;
 b=Ep/qwMDGaXrW7d+9NAtfH65ITnkVdUM15YaIFwRwrS9pWNffrHP1u5VNtvcnZCMyjroRTuhp7VbhiQRwV7R3pLj1vGh2aQEi9Snz8zYhkmPpg5vBS3CUJWelSWZ2q7Y4qOrL03naDofESW2bwGBBmxLymU65SH1y5io8j2XYjymZe3IhnHQX7GUBha9XMHkWFgFf6uXHEe6TOGIvIlwsi3sHMGmC9Xn7IrHSTFYz79DTr0y+kOhj4nCTey+EVy1fOy279n62F/iRZ8q6mOns5YMln3FkJG83YOwn0TF6t/d4hrR9DM5Gb1jsssCSEujkvCwF7lF4q47Iow1lAU7ibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl+Pp8mK4RH21F1N6maJfnV/4juvSeWi3Db0Hxk8ir4=;
 b=nYe8M3iYks7fC+ys+QJUFJ2pR9DIKnJTN3xoKpHx7HcqQJxsyzd5USsNtpqqrMITxxbM9KSkJDk5YgMcJ3MPidyJnFMNODFer3GmGnk38rG3o6EFcH+O+RGUE3fe8ws1hWA9SRzY23XkfanPPw648jI6HaCOXZvzbY6kF0ZGJYU=
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 09:50:56 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::78) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 09:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:50:55 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:51 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:46 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 04:50:46 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65B9okHO3362394;
	Thu, 11 Jun 2026 04:50:46 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65B9ojou014477;
	Thu, 11 Jun 2026 04:50:46 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
	<jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
	"Markus Elfring" <elfring@users.sourceforge.net>, Hangbin Liu
	<liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>, Jan
 Vaclav <jvaclav@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v4 3/3] net: ti: icssg: Add HSR offload statistics support
Date: Thu, 11 Jun 2026 15:20:35 +0530
Message-ID: <20260611095035.852370-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611095035.852370-1-danishanwar@ti.com>
References: <20260611095035.852370-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2c79c3-cc63-4181-fdf0-08dec79eeecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|7416014|921020|22082099003|18002099003|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	FWMrAvpeVigBke49UEGsARz2941Ye7VyeNOfNRgDfNiSrnqaLRJJmlc2i36wReShpIiq2g18QnSuGv5MLqU2r+eFIw6msDvtotWPo1W+1r4JnVi8y26FXsJdkCBc6OJCBqxCPsK1zkLTnW98Y0FwPQ3Pu/mQ8Llj5EWeo0pnrzOJd9MZU5r+gbJPV9wAwB9pAM16ZDN+QoV0yYYMPWJQwedca4AFjk38wSWd0NYCe1+ykBSowK9PQvSS0ajNZ61mgIiJ1gBU4W1FpgrGy01ptxcZliDAv/j+58nrV5Prs1cAcpn+9HojgXiV+imHBwA5VeuWNxJkWs7sJEZdG+jIKJ8grGDDnfJRyzX/IEEnbJdbrj6bS1meKr7GrV8TGv9sLPWFa2S8FKTtDEB8LLGD+poWiiafdOHElT0ldKOJ6czAOiyfcHKV0eHd148ECDw7FqHdD17S+8kZiz56UXFGT+z6A5X7QrDmNVEYJ5ZTjr2pLOaZZilG5l/pncY/HCpdwnKYEepTlQWe5aYpenPIPDRIWsfURrcEY7Cf+RmvBornSPNf0yyt7ZuBDCyKwUZxwxoPhsV3h3xgrHJSvGCABI9LJeunZFycHvOGPLMwbIVvlyCyv7YDRGj5bvZen9fOlxFk3tWY1UUCrAFGkquNV2/Iz7n6BUBK5Ad5H3ShjQYmUqc3lSNF6ygDRjCP3UWnY/IbJi55WdCLvqAKL78JaIfzY4maxR1Tc5elOSw4BCAZWrsoEHv9D2777xJ9px6wBwcvqfjQW1iDbrMiP7P0UQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(7416014)(921020)(22082099003)(18002099003)(3023799007)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tix5f/eusq0GRNli969vUP9FMImYX4gNmGCZr3HCqz+90aeCF3XnZgc7IqA/pJMi35oO3VP3S8smWY3h6LkkXz52+fYY+BdaZJ2Ee7lrUMykofa186AXq5ACvlizVVg8Qle6ye64bRFawKaXixuOH4u9QEjsDSUbUObQDUewiaceAgyrSrfbqvtQ993FgjX5baw2imt66mwBIsQ5blGypcChjxJBIr8IE3Ijs3W9lvHKodeAQ5HGUQ4YfqYm/f1HjMdepXjWxaWQCheLQRYNSn/U+hPA3D2fH0V5yKFgqFyAalgq6NtHdpkr+bKW1XaqBSwVDKBjnNlK6fl0IXGntzQ1uUr+RDwK0GjJURJLktQYdc09SrHD6kOXsGhQ2xT/eApXT3cMkekc7mOvD0HKaR8CPMjqs1kQlpB5d9g/Wy73gnPsG/s/6wrFMiQDx2ZR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:50:55.6918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2c79c3-cc63-4181-fdf0-08dec79eeecb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298049-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:m-malladi@ti.com,m:jacob.e.keller@intel.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:elfring@users.sourceforge.net,m:liuhangbin@gmail.com,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A314670973

Add support for exposing ICSSG HSR statistics through two interfaces:
ethtool and the standard RTM_GETSTATS / IFLA_STATS_LINK_XSTATS path.

Add a standard_stats flag to struct icssg_pa_stats and extend
icssg_all_pa_stats[] with 10 new entries:

  Firmware-specific HSR counters (standard_stats=false, ethtool only):
  - FW_HSR_FWD_CHECK_FAIL_DROP
  - FW_HSR_HE_CHECK_FAIL_DROP
  - FW_HSR_SKIP_HOST_DUP_DISCARD

  IEC 62439-3 LRE counters (standard_stats=true, excluded from ethtool):
  - FW_LRE_CNT_UNIQUE_RX, FW_LRE_CNT_DUPLICATE_RX, FW_LRE_CNT_MULTIPLE_RX
  - FW_LRE_CNT_RX, FW_LRE_CNT_TX, FW_LRE_CNT_OWN_RX
  - FW_LRE_CNT_ERRWRONGLAN

The ethtool get_strings/get_ethtool_stats callbacks skip entries with
standard_stats=true so they do not appear as ethtool counters.
ICSSG_NUM_PA_STANDARD_STATS is introduced and accounted for in
ICSSG_NUM_ETHTOOL_STATS so the sset count stays accurate.
ICSSG_NUM_PA_STATS is updated from 32 to 42.

Implement ndo_has_offload_stats() and ndo_get_offload_stats() in
emac_netdev_ops to expose the IEC 62439-3 LRE counters via the HSR
stack's RTM_GETSTATS / IFLA_STATS_LINK_XSTATS interface. The HSR stack
calls these NDOs on slave A; the callback reads PA stat registers for
both ports (MAC0 = port A, MAC1 = port B) from the shared prueth
instance and fills struct hsr_lre_stats. Port C counters are not
available in ICSSG hardware and remain at ~0ULL.

Export emac_update_hardware_stats() and emac_get_stat_by_name() as
GPL symbols so they can be called from icssg_prueth.c. Also change
emac_get_stat_by_name() return type from int to u64 and make it return
~0ULL on an unknown stat name instead of -EINVAL, consistent with the
hsr_lre_stats sentinel convention.

Add FW_HSR_FWD_CHECK_FAIL_DROP and FW_HSR_HE_CHECK_FAIL_DROP to the
rx_dropped sum in ndo_get_stats64, as these represent frames discarded
by the HSR forwarding logic.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../ethernet/ti/icssg_prueth.rst              | 19 ++++
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  7 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 10 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 92 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 10 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  6 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 85 +++++++++--------
 .../net/ethernet/ti/icssg/icssg_switch_map.h  | 10 ++
 8 files changed, 193 insertions(+), 46 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
index da21ddf431bbc..faa1fc18a6737 100644
--- a/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
+++ b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
@@ -54,3 +54,22 @@ These statistics are as follows,
  - ``FW_HOST_TX_PKT_CNT``: Number of valid packets copied by RTU0 to Tx queues
  - ``FW_HOST_EGRESS_Q_PRE_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
  - ``FW_HOST_EGRESS_Q_EXP_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
+ - ``FW_HSR_FWD_CHECK_FAIL_DROP``: Packets dropped on the HSR forwarding path due to failed checks
+ - ``FW_HSR_HE_CHECK_FAIL_DROP``: Packets dropped on the host egress path due to failed checks
+ - ``FW_HSR_SKIP_HOST_DUP_DISCARD``: Frames for which the host duplicate discard check was skipped
+
+HSR/LRE Standard Statistics
+============================
+
+When the ICSSG operates in HSR offload mode the driver exposes the IEC 62439-3
+LRE counters through the standard netlink stats interface.
+
+The following per-port (port A and port B) LRE counters are reported:
+
+ - ``lreCntTx``: Number of HSR/PRP tagged frames sent
+ - ``lreCntRx``: Number of HSR/PRP tagged frames received
+ - ``lreCntUnique``: Number of frames received with no duplicate detected
+ - ``lreCntDuplicate``: Number of frames received for which exactly one duplicate was detected
+ - ``lreCntMultiple``: Number of frames received for which more than one duplicate was detected
+ - ``lreCntOwnRx``: Number of HSR/PRP tagged frames received whose source MAC matches the node's own address
+ - ``lreCntErrWrongLan``: Number of frames received with a wrong LAN identifier (PRP only)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4b..1fcb031949535 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1643,7 +1643,12 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+			    emac_get_stat_by_name(emac,
+						  "FW_INF_DROP_NOTMEMBER") +
+			    emac_get_stat_by_name(emac,
+						  "FW_HSR_FWD_CHECK_FAIL_DROP") +
+			    emac_get_stat_by_name(emac,
+						  "FW_HSR_HE_CHECK_FAIL_DROP");
 	stats->tx_errors  = ndev->stats.tx_errors;
 	stats->tx_dropped = ndev->stats.tx_dropped +
 			    emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23ac..7a99c99aab1e8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -74,7 +74,9 @@ static int emac_get_sset_count(struct net_device *ndev, int stringset)
 		if (emac->prueth->pa_stats)
 			return ICSSG_NUM_ETHTOOL_STATS;
 		else
-			return ICSSG_NUM_ETHTOOL_STATS - ICSSG_NUM_PA_STATS;
+			return ICSSG_NUM_ETHTOOL_STATS -
+			       (ICSSG_NUM_PA_STATS -
+				ICSSG_NUM_PA_STANDARD_STATS);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -93,7 +95,8 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 				ethtool_puts(&p, icssg_all_miig_stats[i].name);
 		if (emac->prueth->pa_stats)
 			for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
-				ethtool_puts(&p, icssg_all_pa_stats[i].name);
+				if (!icssg_all_pa_stats[i].standard_stats)
+					ethtool_puts(&p, icssg_all_pa_stats[i].name);
 		break;
 	default:
 		break;
@@ -114,7 +117,8 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 
 	if (emac->prueth->pa_stats)
 		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
-			*(data++) = emac->pa_stats[i];
+			if (!icssg_all_pa_stats[i].standard_stats)
+				*(data++) = emac->pa_stats[i];
 }
 
 static int emac_get_ts_info(struct net_device *ndev,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b4..6df5bb2582928 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -14,6 +14,7 @@
 #include <linux/etherdevice.h>
 #include <linux/genalloc.h>
 #include <linux/if_hsr.h>
+#include <linux/if_link.h>
 #include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
@@ -1633,6 +1634,95 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
 	return 0;
 }
 
+/**
+ * prueth_ndo_get_offload_stats - Fill standard LRE counters from ICSSG.
+ * @attr_id: Stats attribute ID; only IFLA_OFFLOAD_XSTATS_LRE_STATS is handled.
+ * @dev:     Slave net_device (port A) whose offload stats are requested.
+ * @sp:      Output pointer; cast to struct hsr_lre_stats *.
+ *
+ * Called by the HSR stack via ndo_get_offload_stats on the slave A device.
+ * Fetches the per-port PA stat register snapshots for port A and port B,
+ * and fills the IEC-62439-3 per-port LRE counters.  Port C (interlink)
+ * counters are not available in ICSSG hardware and remain at ~0ULL.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device does not support
+ *         HSR offload statistics for the requested attribute.
+ */
+static int prueth_ndo_get_offload_stats(int attr_id,
+					const struct net_device *dev,
+					void *sp)
+{
+	struct prueth_emac *emac = netdev_priv(dev);
+	struct prueth *prueth = emac->prueth;
+	struct hsr_lre_stats *stats = sp;
+	struct prueth_emac *emac0;
+	struct prueth_emac *emac1;
+
+	if (attr_id != IFLA_OFFLOAD_XSTATS_LRE_STATS)
+		return -EOPNOTSUPP;
+
+	if (!prueth->is_hsr_offload_mode)
+		return -EOPNOTSUPP;
+
+	/* Current emac is SlaveA. Other emac is SlaveB */
+	emac0 = emac;
+	emac1 = prueth->emac[1 - prueth_emac_slice(emac)];
+
+	if (!prueth->pa_stats)
+		return -EOPNOTSUPP;
+
+	/* Initialise all fields to ~0ULL ("unsupported"); only port A and B
+	 * counters are filled — port C and aggregate counters are not
+	 * available in ICSSG hardware.
+	 */
+	memset(stats, 0xff, sizeof(*stats));
+
+	emac_update_hardware_stats(emac0);
+	stats->cnt_tx_a =
+		emac_get_stat_by_name(emac0, "FW_LRE_CNT_TX");
+	stats->cnt_rx_a =
+		emac_get_stat_by_name(emac0, "FW_LRE_CNT_RX");
+	stats->cnt_unique_a =
+		emac_get_stat_by_name(emac0, "FW_LRE_CNT_UNIQUE_RX");
+	stats->cnt_duplicate_a =
+		emac_get_stat_by_name(emac0, "FW_LRE_CNT_DUPLICATE_RX");
+	stats->cnt_multi_a =
+		emac_get_stat_by_name(emac0, "FW_LRE_CNT_MULTIPLE_RX");
+	stats->cnt_own_rx_a =
+		emac_get_stat_by_name(emac0, "FW_LRE_CNT_OWN_RX");
+	/* lreCntErrWrongLan is PRP only */
+	stats->cnt_err_wrong_lan_a =
+		emac_get_stat_by_name(emac0, "FW_LRE_CNT_ERRWRONGLAN");
+
+	emac_update_hardware_stats(emac1);
+	stats->cnt_tx_b =
+		emac_get_stat_by_name(emac1, "FW_LRE_CNT_TX");
+	stats->cnt_rx_b =
+		emac_get_stat_by_name(emac1, "FW_LRE_CNT_RX");
+	stats->cnt_unique_b =
+		emac_get_stat_by_name(emac1, "FW_LRE_CNT_UNIQUE_RX");
+	stats->cnt_duplicate_b =
+		emac_get_stat_by_name(emac1, "FW_LRE_CNT_DUPLICATE_RX");
+	stats->cnt_multi_b =
+		emac_get_stat_by_name(emac1, "FW_LRE_CNT_MULTIPLE_RX");
+	stats->cnt_own_rx_b =
+		emac_get_stat_by_name(emac1, "FW_LRE_CNT_OWN_RX");
+	stats->cnt_err_wrong_lan_b =
+		emac_get_stat_by_name(emac1, "FW_LRE_CNT_ERRWRONGLAN");
+
+	return 0;
+}
+
+static bool prueth_ndo_has_offload_stats(const struct net_device *dev,
+					 int attr_id)
+{
+	struct prueth_emac *emac = netdev_priv(dev);
+	struct prueth *prueth = emac->prueth;
+
+	return attr_id == IFLA_OFFLOAD_XSTATS_LRE_STATS &&
+	       prueth->is_hsr_offload_mode && prueth->pa_stats;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -1652,6 +1742,8 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_has_offload_stats = prueth_ndo_has_offload_stats,
+	.ndo_get_offload_stats = prueth_ndo_get_offload_stats,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b786..d6c221e897924 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -57,12 +57,14 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
+#define ICSSG_NUM_PA_STATS	42
 #define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
-#define ICSSG_NUM_STANDARD_STATS 31
-#define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
+#define ICSSG_NUM_STANDARD_STATS	31
+#define ICSSG_NUM_PA_STANDARD_STATS	7
+#define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS - \
+				 ICSSG_NUM_PA_STANDARD_STATS)
 
 #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
 
@@ -458,7 +460,7 @@ int emac_fdb_flow_id_updated(struct prueth_emac *emac);
 
 void icssg_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
 /* Common functions */
 void prueth_cleanup_rx_chns(struct prueth_emac *emac,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155cf..9950d0ba899fa 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -62,6 +62,7 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 
 	spin_unlock(&prueth->stats_lock);
 }
+EXPORT_SYMBOL_GPL(emac_update_hardware_stats);
 
 void icssg_stats_work_handler(struct work_struct *work)
 {
@@ -74,7 +75,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
 
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
 	int i;
 
@@ -91,5 +92,6 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
-	return -EINVAL;
+	return ~0ULL;
 }
+EXPORT_SYMBOL_GPL(emac_get_stat_by_name);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 6f4400d8a0f61..373debfb815cc 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -157,50 +157,63 @@ static const struct icssg_miig_stats icssg_all_miig_stats[] = {
 
 static_assert(ARRAY_SIZE(icssg_all_miig_stats) == ICSSG_NUM_MIIG_STATS);
 
-#define ICSSG_PA_STATS(field)	\
-{				\
-	#field,			\
-	field,			\
+#define ICSSG_PA_STATS(field, stats_type)	\
+{						\
+	#field,					\
+	field,					\
+	stats_type				\
 }
 
 struct icssg_pa_stats {
 	char name[ETH_GSTRING_LEN];
 	u32 offset;
+	bool standard_stats;
 };
 
 static const struct icssg_pa_stats icssg_all_pa_stats[] = {
-	ICSSG_PA_STATS(FW_RTU_PKT_DROP),
-	ICSSG_PA_STATS(FW_Q0_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q1_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q2_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q3_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q4_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q5_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q6_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q7_OVERFLOW),
-	ICSSG_PA_STATS(FW_DROPPED_PKT),
-	ICSSG_PA_STATS(FW_RX_ERROR),
-	ICSSG_PA_STATS(FW_RX_DS_INVALID),
-	ICSSG_PA_STATS(FW_TX_DROPPED_PACKET),
-	ICSSG_PA_STATS(FW_TX_TS_DROPPED_PACKET),
-	ICSSG_PA_STATS(FW_INF_PORT_DISABLED),
-	ICSSG_PA_STATS(FW_INF_SAV),
-	ICSSG_PA_STATS(FW_INF_SA_DL),
-	ICSSG_PA_STATS(FW_INF_PORT_BLOCKED),
-	ICSSG_PA_STATS(FW_INF_DROP_TAGGED),
-	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
-	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
-	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
-	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
-	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
-	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
-	ICSSG_PA_STATS(FW_RX_EXP_FRAG_Q_DROP),
-	ICSSG_PA_STATS(FW_RX_FIFO_OVERRUN),
-	ICSSG_PA_STATS(FW_CUT_THR_PKT),
-	ICSSG_PA_STATS(FW_HOST_RX_PKT_CNT),
-	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
-	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
-	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
+	/* Firmware-specific stats: exposed via ethtool -S only */
+	ICSSG_PA_STATS(FW_RTU_PKT_DROP, false),
+	ICSSG_PA_STATS(FW_Q0_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q1_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q2_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q3_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q4_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q5_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q6_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q7_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_DROPPED_PKT, false),
+	ICSSG_PA_STATS(FW_RX_ERROR, false),
+	ICSSG_PA_STATS(FW_RX_DS_INVALID, false),
+	ICSSG_PA_STATS(FW_TX_DROPPED_PACKET, false),
+	ICSSG_PA_STATS(FW_TX_TS_DROPPED_PACKET, false),
+	ICSSG_PA_STATS(FW_INF_PORT_DISABLED, false),
+	ICSSG_PA_STATS(FW_INF_SAV, false),
+	ICSSG_PA_STATS(FW_INF_SA_DL, false),
+	ICSSG_PA_STATS(FW_INF_PORT_BLOCKED, false),
+	ICSSG_PA_STATS(FW_INF_DROP_TAGGED, false),
+	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED, false),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTAG, false),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER, false),
+	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR, false),
+	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF, false),
+	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF, false),
+	ICSSG_PA_STATS(FW_RX_EXP_FRAG_Q_DROP, false),
+	ICSSG_PA_STATS(FW_RX_FIFO_OVERRUN, false),
+	ICSSG_PA_STATS(FW_CUT_THR_PKT, false),
+	ICSSG_PA_STATS(FW_HOST_RX_PKT_CNT, false),
+	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT, false),
+	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_HSR_FWD_CHECK_FAIL_DROP, false),
+	ICSSG_PA_STATS(FW_HSR_HE_CHECK_FAIL_DROP, false),
+	ICSSG_PA_STATS(FW_HSR_SKIP_HOST_DUP_DISCARD, false),
+	ICSSG_PA_STATS(FW_LRE_CNT_UNIQUE_RX, true),
+	ICSSG_PA_STATS(FW_LRE_CNT_DUPLICATE_RX, true),
+	ICSSG_PA_STATS(FW_LRE_CNT_MULTIPLE_RX, true),
+	ICSSG_PA_STATS(FW_LRE_CNT_RX, true),
+	ICSSG_PA_STATS(FW_LRE_CNT_TX, true),
+	ICSSG_PA_STATS(FW_LRE_CNT_OWN_RX, true),
+	ICSSG_PA_STATS(FW_LRE_CNT_ERRWRONGLAN, true),
 };
 
 static_assert(ARRAY_SIZE(icssg_all_pa_stats) == ICSSG_NUM_PA_STATS);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ece..556facb33e0ce 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -266,5 +266,15 @@
 #define FW_HOST_TX_PKT_CNT		0x0250
 #define FW_HOST_EGRESS_Q_PRE_OVERFLOW	0x0258
 #define FW_HOST_EGRESS_Q_EXP_OVERFLOW	0x0260
+#define FW_HSR_FWD_CHECK_FAIL_DROP		0x0500
+#define FW_HSR_HE_CHECK_FAIL_DROP		0x0508
+#define FW_HSR_SKIP_HOST_DUP_DISCARD		0x0510
+#define FW_LRE_CNT_UNIQUE_RX			0x0518
+#define FW_LRE_CNT_DUPLICATE_RX			0x0520
+#define FW_LRE_CNT_MULTIPLE_RX			0x0528
+#define FW_LRE_CNT_RX				0x0530
+#define FW_LRE_CNT_TX				0x0538
+#define FW_LRE_CNT_OWN_RX			0x0540
+#define FW_LRE_CNT_ERRWRONGLAN			0x0548
 
 #endif /* __NET_TI_ICSSG_SWITCH_MAP_H  */
-- 
2.34.1


