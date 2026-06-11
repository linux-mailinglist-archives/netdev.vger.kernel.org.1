Return-Path: <netdev+bounces-298051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SBKpM4+GKmoFrwMAu9opvQ
	(envelope-from <netdev+bounces-298051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142C670A07
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:57:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=xYV1EY0D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298051-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298051-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13413045473
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681A3BCD07;
	Thu, 11 Jun 2026 09:52:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97D371D16;
	Thu, 11 Jun 2026 09:52:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171533; cv=fail; b=AqbWQCGncqCX/a9RMOBJa3UCaB0YGFDEwVoMcv046ynHYXO9IN+s2vjmOrkiaFnOko7tXhkZ21x/9vzb1BKXzAtQAXsrva164+sV5jETIeuH0iL0ladcDHxyqAM4PIS7ysGO6nVtP9KoriruxF+5aNTrirVAETLspgpGMcdqH2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171533; c=relaxed/simple;
	bh=iv242MlifAJ1cph5FO5KLVbjY0qvk/Vqj0FVJHvrUac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=prhraR3nNMWncVgM0JftdH/g6m74iG/hUhDooaeoMy4U5OFxrTcUro82Ssg3BVM7z6O2tcuHz2KOCeyMCeTJoZ9JUAUrp1MrBlV8F41RzWw572rEfl6FK9ic/cOhGdFQl5gNLuULW8geJeAy7HAoqxeEm/iltzry4ajsIT9QvJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xYV1EY0D; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvZxCl9cJ8A+Xa0S1aVYO0ZONrYXnNMreweqJeDRq/YWGSmzrAu9bSahmZjhFq2Evr4fMziECwKHchYumabLX1vQemnJL2Q04xMFEidYTfMfyvlH6I8tgtpeDJ9a7cqBcNl6mSu6Kj1drbXeFkXGnq7v1DlxWe0McsRsc+UV4NAfV/Cdxx66OWuhiDlA4pSjjWJ3J00GY5HbSnAzpFpt25HrS1Ez/xxVr3n+0UvIYll71GymR+6oviJS1PaX/ImJWBi1pfwsMX8N+cI9KKaeOs1vgm3QewOivlqgz/LRvyi/0k9vERRvJkj/M5HWMmcHYmCODys92SgUYAqATlnRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG9GkbmZWeHeIenYh+zVZ413zV3V+oqy0gR1VcVBX1A=;
 b=oqxVCj48Wr5dmxTYrqZg1cfml3zenW1qPuoZsQHnSwtiq/vqC7jzLERAsx+JcS+8yNIMC2d93+iqwopBm+JXrPbOrdTmuajme2Z4k7WlNvT+NYbw9riB8WziE6tk4ol17+I6Ckq4xlmlJ4zVvX+VDL+2hwO5ethFJ4y2+J+gY89IJnkOJP1cIRaEZaXk+cp9YggRwgxPZvWcaPqePgnY5i3R7Oby8Z5pQYtfdqXhOhGr6vrpwqkx960pRMrQzKm2bZjets04GOubTsrE501/B07F/+wniaZlVfQrjHdRZWrnAFME7zkZUJbgJ7hlN6aS3J1gn/Q/Og5I0ouER2dlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG9GkbmZWeHeIenYh+zVZ413zV3V+oqy0gR1VcVBX1A=;
 b=xYV1EY0DBC/ZaA0jLntmUn2q6IKn5H+fgYGPZCS359iiQa+Z0vXx9PdRWunm0QIGLv7+IgiIODXhaEljv3jlT54iDliUOzrRyfociIAlR6eHmH+z3/HMj+DCUnRPq2Tn18ggiH5/6GSY+9Saug9iNgRM/xR3EycgONTgF9llmRo=
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by DS0PR10MB6079.namprd10.prod.outlook.com (2603:10b6:8:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 09:52:08 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::1c) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 09:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:52:08 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:52:07 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:52:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 04:52:03 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65B9puqs1627783;
	Thu, 11 Jun 2026 04:51:57 -0500
Message-ID: <6367ffa0-5faf-4deb-8a4b-18b53ef53c56@ti.com>
Date: Thu, 11 Jun 2026 15:21:56 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] Add standard stats for HSR/PRP
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, "Meghana
 Malladi" <m-malladi@ti.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
	Himanshu Mittal <h-mittal1@ti.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Markus Elfring <elfring@users.sourceforge.net>, Fernando Fernandez Mancera
	<fmancera@suse.de>, Jan Vaclav <jvaclav@redhat.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Felix Maurer" <fmaurer@redhat.com>, Luka Gejak <luka.gejak@linux.dev>
References: <20260608100930.210149-1-danishanwar@ti.com>
 <20260610184737.GO3920875@horms.kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20260610184737.GO3920875@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS0PR10MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 197ada4a-04d3-4bd7-7eed-08dec79f1a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|23010399003|82310400026|4143699003|56012099006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xCx0xotw808SdLy7DgzzQJJcweyZh2tuN1htQTIw6vBGVQBZq3Oe9Ve7l3lXiqxbXhVIl1LU8jCMVTmxH1k7hfHOU/b3q1qQN7lFtRiR+uiBGozYZoQE7SecOSjLJZXVBc0aBVghTLHA6ej/CkYbYd6AIJOXLMTUbm1E4lxK4OUzk6AJVi5kUI5xuci2WOtW+8w8sYLvheNUamhqGHiH9bNkj7cnzZ7JePvJ0Ao0DAXNuvCWLLPtuJwsMZseBMHLVdhp2VanAf0CjK4aPtD8M+A2KMw+SLcXpGv3BRZ2bHwUHpxofGq5hFNT3Wzp9+Vd0mZVRBLQ2ONWQHfO9sydcszIGIHwNY2zkiBloluXGLmBBqLKkHsVRLQxV5UkcHUUu7AON0N6+8eCePuP5dFKtL3jbHfRTH8cJfaGAad1BJYmzpZ6r3UVifGvLSvYIWEROGAlyCcbw28IAsyfdEFmeRS2gP3aK8AY+feQUK4WVgFjNVDIsm86BXPILHxDlqNQZOhoUGCm15z2csqCY+ufLzbJ1vAeDdy7DYYdbuKcN1vW3o83TAyMFCd/ZWXIXmXhrP7YJR+5iMdYdntR5WwqcFqkSu+dqm6ueiRfJ9IF68GCGfAu+6p0BqnfsrPtNdpiizhIbdiUycGOGu1WMyLyF96kvDiyKIy+VTiXCsI5lcnEkSeGlttXbDjJ88FU51MS
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(4143699003)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4DiNlO7ygQZDrVs8Qo58TcdL2FHUhfrHAVlpfUprD/4ma3RS9OB8OaTAZz0QbtjmbEFPBjuBvd6aHg7TgxmaB7gx+65uhMApFdMCWpiXeu+I6jhqfqCN1QJRa9yg4z9WjJc0cVW4ysVpVL/DRfP1D5lkpUuyHzdoFdib12qzf9gZBjA4lWBvdQgo+nQXrZy+p9wbzRT6ud2i4jVe/fa8mHF+VYWuC5DrFiUhWl7nwSBPOSccRpq3CIbab4F3iEhTzsKOmd883glCg2MX0t3fB9Wtc0IE604uNLFQVhAV5FW0Q/3J8TqmQzZo6yw6/MUc+7GzcJHdExJ5ITJFkrDHwyE3mXoVBjhiyzfhn5JFhGp8dmTNTXHMNvVDqS4/Cmrh5+/RKtr2X9R9IJWdwkMk1f3yqNMvSwaOy1BHQJGzILet7ty/z28PJTzq9Jyolkw+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:52:08.2605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197ada4a-04d3-4bd7-7eed-08dec79f1a0b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6079
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
	TAGGED_FROM(0.00)[bounces-298051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,linux.dev:email,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:mid,ti.com:from_mime];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:h-mittal1@ti.com,m:liuhangbin@gmail.com,m:elfring@users.sourceforge.net,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,intel.com,ti.com,gmail.com,linux.dev,users.sourceforge.net,suse.de,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2142C670A07

Hi Simon,

On 11/06/26 12:17 am, Simon Horman wrote:
> On Mon, Jun 08, 2026 at 03:39:27PM +0530, MD Danish Anwar wrote:
>> Add standard stats for HSR / PRP. This series was initially adding HSR/PRP
>> related stats for ICSSG driver. Based on maintainers' comments on v2 I am
>> now adding support to dump standard stats for HSR/PRP.
>>
>> The drivers which support offload can populate these standard stats.
>>
>> This series only implements offloaded stats. For software-only interfaces
>> Felix Maurer had said he will do it later [1]
>>
>> v2 https://lore.kernel.org/all/20260514075605.850674-1-danishanwar@ti.com/
>> [1] https://lore.kernel.org/all/ag87pBZfOyccPZTc@thinkpad/
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Felix Maurer <fmaurer@redhat.com>
>> Cc: Luka Gejak <luka.gejak@linux.dev>
> 
> Hi MD,
> 
> There is AI-generated review of this patch-set available on both
> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
> I would appreciate it if you could look over that with a view
> to addressing any issues that directly affect this patch-set.

I did look at the AI-generated reviews. The review on Patch 1/3 and 3/3
seems like a real issue to me which I have fixed. The reviews on patch
2/2 is not related to the series.

I have posted v4 with this fix
https://lore.kernel.org/all/20260611095035.852370-1-danishanwar@ti.com/

-- 
Thanks and Regards,
Danish


