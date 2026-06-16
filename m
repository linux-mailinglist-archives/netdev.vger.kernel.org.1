Return-Path: <netdev+bounces-299814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0lUAF3YuMWq5dQUAu9opvQ
	(envelope-from <netdev+bounces-299814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E568EA3A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UXkMjX6b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299814-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299814-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 670C6300ACB9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC442EEBE;
	Tue, 16 Jun 2026 11:07:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCB3B71B0
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:07:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608052; cv=fail; b=XorOXYt5+BDV8459neCL75auzO6Hs6JNTBarbo8gFe3WpyeP9Cwf3kplm1NkBiHd8oRRJFA0Sz8RsxbNySZkH6mFhFApsrAcvNGXNvEGzF0NZucaX77M88yDsEWWwyMFkKXbU9zy+h4pFBc14dqh2Lt51avdbHztdXY+l4Lqe/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608052; c=relaxed/simple;
	bh=6+iCp8lYMr49xXKnsJS0KdWQGzFtAAwuV2nblkjM0Fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFkRAwaTzqSGwPFwG12PBIsXhLCowEmYP4pl45GBWHMKAG0kePGMBS3Fktdf4M7K+YXujvPWp6Nq6ut1A1XHQcTzuwffl5SyGQFYw2O2S9UquUyxjITAPCjrwBeFZG2dfszPuGtvPOg9q+coO2NnWU7iecwISQ8tgL0WwyBrGd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXkMjX6b; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZmZDSYrKnKYzmQBcCr006tT6TLGJ7PCino7NwvBw2z02vYMVOiR1Vr7FtfCus5VqdErvns4P1rMDh9Ob70Agp0TvONbmi8Fg8mN6xQvJ/AD/EoHXLBNqecRPIPBzDWEMN7lAPVrGx0i2vvr+IWT5lhVd1OKO/bjCHNhbv58O0MnWEBdFXdCTFEgWMQfL4EIrRphvbAPOWiHQeuOVO647OiU/u1yaMfPBiCZ7WdeLFGHMZk7+yYH5KrXK3Kk7j1vpZtqg+CR8VG9o2lrc5RPKQBEXtWIb4e2Oc6jN7inDbr2BDkA8/zE/pxBxSIyOZn1gQO2I8TEwN1gY9C3vm8D6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX/oui61y6CdTPBU6nbOtmiodpWC5vhGmopfvuYYJAM=;
 b=SUdL7Q+vqs3Pt03S4JPRJKJhx2MbXl/zaszsZH9NqHge0gHtY2pOxyQO59W58WlVOgJ/i7IbZCTCho+cC3gl3aE8jQrmj1On1fLYIPTVHG06BW8FsHp+5XkmFC6OAvmXGYk8Wj88pmx+BzCb6NdHPEtN+krL1C8cQf9FGSx2Ka4i/L/iUvPrmNxC1gzZvuF9cHn1lVvpu5Fqy2DTWLo+XncsrkKX3QceuStEsX7RVL2NnRR5kGyCGHPsfV5IXzDVdIvxQYrNEa4F2orzISFbd4i0CsQVkr2EVMJbYTkm4zB08Qk5h2DYmCWTfeH+7LKuH8TNbUob2qOqXwtzOY0lWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX/oui61y6CdTPBU6nbOtmiodpWC5vhGmopfvuYYJAM=;
 b=UXkMjX6boPXRmW9zQWnuHwgNIfaa8kSMfmAS9YpyQoGW/iV87n58Yv9W9tFWeei1q8qGicj28qAwdLJPv6jm5L5YXg/I+5vyRLicDxyy17+/uAqsAgj5cWfptiQPxhdevJet656n9xe3X/Mxv33x/clk8zp3vOYSgOuoQasCVjYcfyqmpUJox1wQOYenadgBHcV7Asrbm0eW2JzrklQaj0yjhbCY4gpS0vu877rFTTJwTk1XruymIKrViDlCn0K7T0XTfznOUDtnH+85SONTthqsYI0gtqjDODVWIDxqz9Bp/7gNR6rrflW/65luz51Yps/gKwVsYenfseQcRD2FvA==
Received: from CH3P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::10)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:07:26 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::46) by CH3P220CA0016.outlook.office365.com
 (2603:10b6:610:1e8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 11:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:07:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 04:07:11 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 16 Jun 2026 04:07:07 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michal
 Wilczynski <michal.wilczynski@intel.com>, Carolina Jubran
	<cjubran@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/2] devlink: Fix parent ref leak in devl_rate_node_create()
Date: Tue, 16 Jun 2026 14:06:32 +0300
Message-ID: <20260616110633.1449432-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616110633.1449432-1-cratiu@nvidia.com>
References: <20260616110633.1449432-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1339475c-4927-4946-1024-08decb9772f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UPdI4JuPYHyHk4qK3o/gDzlUqoHjpL0QXboelf6IaLY4nfLkQZEfi8Y+AD7qJ1UDaOMNT4qQP0zVSDRl3dw9JgBSZ+AltRGkCfATQzPCbVLOMTt4FzXiO1sy8QK5anEhuV3j6keYq/GqbRD7BNbJJ8t4iTXSlm++bpZRh1Kge4rVYljz/peOyFOjs3aAGwGTC2RRIQySe/Z12SkA67cgRoYDqhZlyrjpoAMBHbY6IYHd77fZoIpwjRpAdHFVEpBrvVb1SAKmuV5Svqbmvnpo0M3Rn63XZ4fI7GrTdknYxy+NMOHkxDOOgfFNrZZlzzxhYlSYLi8clztfOfqOs68/WmcgZT3fY3DbJOfBUdq91MiGNGqclScBK8YN7DvObR/CXrNu5xVZ9ZXW/CzZN3BY/fWsd8AJAoKTvUD3Vh9Ss4lQ5lyO2KliLjBWNVjdL3nNMn6aJLDibh8XaYJ+1/7UBQTrkmG825uEKnnhdVUTtq3L+d5mUyONPN46jRZ8/mWbddGVMKbvo14cSShcdd1veDPutjQqP/UjYhXNzEqtNS/LSiQol6ZxDJLnLKMfHyLyZXFjZI2T2lkFYyWiKBGhdB78ThFqylyowmBHCXEstpMal3ggNDNNRD4ahGSkjjIPq3uGFefQyycNcW6d51eZwUJ/iLXNvUhOhLkjN6d4piqpaiErGfZm8vL1vAeex9JfRqo1VMA8vxGrOTIQe+Choo3LiuRbEIiBxIEcI9FYNmg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LgCBCqui8Q+lu+UDIgaBXr19yL3lQHHOiiaYxP6NhDeaTep1H8ic66A2zMOFlT/udkKPjI5C11AcHeUY6ijuIDpOCOiEuDkt9IH8WNeYo8iH57Hjsn8yZ2Yn1p+NA918w2J6h5CgMfb/MvL9udauv/ia4t2ADbspdPjbl13efhCP8KPuTJ630K3rAZVMD+CnXri6CoG5tJvKnfBMkrHWSOVkd+5LHwDlW3y0l7Y6y7CeAAiEiSw3VwqzUFT6OWjIF3kaBRWbGMKXwnBw2CCFRESkzBoTHT7TwKcfIZQnMzmrQSIe873bmYscp52C83/zPtcf6+CjfwrYxVZLxcMBWxXNqeh9Sww7Gz65+9rYa9wkIhTWDmWV+zmZUvp0/sdWBLW3APVLjRakha8OSZAh3x/sFzMOSJgtUC4d1utiNTeIDYD3uzJ8uQ3qDSZHOoGS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:07:26.0626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1339475c-4927-4946-1024-08decb9772f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-299814-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:michal.wilczynski@intel.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:mbloch@nvidia.com,m:tariqt@nvidia.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC8E568EA3A

In the original commit the function bails out on kstrdup failure,
forgetting to decrement the refcnt of the parent.

Fix that by moving the parent refcnt setting after kstrdup.

Fixes: caba177d7f4d ("devlink: Enable creation of the devlink-rate nodes from the driver")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 net/devlink/rate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 41be2d6c2954..210e26c6cfa0 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -725,11 +725,6 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	if (!rate_node)
 		return ERR_PTR(-ENOMEM);
 
-	if (parent) {
-		rate_node->parent = parent;
-		refcount_inc(&rate_node->parent->refcnt);
-	}
-
 	rate_node->type = DEVLINK_RATE_TYPE_NODE;
 	rate_node->devlink = devlink;
 	rate_node->priv = priv;
@@ -740,6 +735,11 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (parent) {
+		rate_node->parent = parent;
+		refcount_inc(&rate_node->parent->refcnt);
+	}
+
 	refcount_set(&rate_node->refcnt, 1);
 	list_add(&rate_node->list, &devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
-- 
2.53.0


