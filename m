Return-Path: <netdev+bounces-271154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFZ4OqS1wmlolAQAu9opvQ
	(envelope-from <netdev+bounces-271154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:02:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426531891E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30B830A8AC1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3738AC73;
	Tue, 24 Mar 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOV7u8Gm"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F438910B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367780; cv=fail; b=YO1TaesHtyUKF8MnfdtYobhSkMXmc7fgsjjE/jMRTkSURPAMCK5zzCs7fyFVUL8LAim22FwOLONR5v5f3qYjDcue4q6THtnI2IbRkFYnfdr+InMNNemQyZwb7XwGEA1ITcFg00WTL4xTN3NdNuRzgHTAlgMk1D+sbtfj1cT25EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367780; c=relaxed/simple;
	bh=8gU1V12Em/wFSYBBEzSBZblP1ypeXldoV0UCPIInLX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y23WVUV4nNmIwR3AwEWyIv9eb7ACl8ErdBUS4akdRB3Gl9IxSET4S7rIjV9uEaaKz13Bd144UlD/MtxoXRJocj7Vp5KFFzoxgrv+17Dk8tlecutsV/MzOGFv3qT2/bYx3jN6aXQ30Qkvydui9mlKzPY3/f9e8Pya/gVxHMQRfxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cOV7u8Gm; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANxP1yEOetl9pxrF6gOUqvxeAmmS2GOmYamZfTsADnYjvyjCfUXD98TzdKEpR6l03tY2s5ljqO79K6oW1EtVQTZl8/7Wg9Wl6HhTJF6u1T7eiNFXblhf3qcDIVNvQd+P4lPXdwA1YvIi0QFSmqgD2BQQHy+EUs8CeEPmcoeqK7wZioa/1XTM9JIQyZzOFDVETyU9Jf/1fFzXLt97ndNOWtINmBMKTfu6/m9efDcVE4TYJjZ5Hbd/Xm0r5447HvB3fRsZj+P0ZQkSvf3IYOrGFa77WDcHcS7LzEKZTzksJwWEO3STHtwiK0sAb1La3VNXm8xTRp3vYZlS651yqwDO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjKUDIz5Roon8r11Mkl/FWM2xVhz6mRX2Hz0Lq2oJC0=;
 b=PGL5KAwZR33WNVvB32i8rg+kiXvkiMBKhY07FqIzL930W8JKfeskNN1d0hRZFTjZm3QqBk01LmDI3mPDw7speFfmtkUgp9wFlnYISmq3xn5eIs3T/4V8znBZGknYLsKBvjo7HBOeE0fg1+HkctOSMeDQiINnUvDwxFMEXk5dwmFmxfPwk0dvJw0iJ9aj30SjTXx2+2k0slOWlMoQU8kdjyS7Qwl4WpajtoYX7E0V+e5TgFrERXvMLVBsi6uxgidM5XSGiKKKhY1Wgt3eJuuMW1WQfirBY0YGIE+M1XlLUHMa9Kq1e3YEWNajznuktsrY89eGf6gPDJlczM2c15HCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjKUDIz5Roon8r11Mkl/FWM2xVhz6mRX2Hz0Lq2oJC0=;
 b=cOV7u8Gmb9mgwri94zXWAe8a+zCxoVIrZPiIz6MwfcM2Q3B5ozdS8NJlJjMqwEukvwlqcZyZII5uOHw2YWf5cTTXGOSll8YRtnG8AWBXW5DUbTClPweHYoOcDnL+d8GrYCi03U7m7VowLeH2QQBGEPo0+DeSOYLiznZ5kRwD+Rrauz7Q/VaN9IeVVGMQ0lT7E2W++xI29ju1OAHlgAOqnv16jY866coQCvuAi1v0NEugmzenjpojAMb1V0AOtdY/QWCwu4VEAPWM0PqRA8aW0zDEhg+5T9Jj+0GiDAZ4xpLKvHRTgixGkBD2cqVqpB3ampOV9wr6OROrXQIP5nv2pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:56:14 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 15:56:14 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/3] vrf: Remove unnecessary synchronize_rcu() invocations
Date: Tue, 24 Mar 2026 17:55:21 +0200
Message-ID: <20260324155521.525292-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324155521.525292-1-idosch@nvidia.com>
References: <20260324155521.525292-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d72083-3a46-4703-61e9-08de89bde05e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MymXkfIMHWNakiEn5Se5xTYYOdBtmo8Tea9XL2SHE2+K4gQfZqaXVmvZV2/HmFFqG/zj+xa8MouA99NdvvVOaoWPoTOixkX0U3uOmNxnVcmbgrqaJQgBWkhnUx5uRgG1JqdYlFGVd7SQvqm0cbVx6QxwQaGcsB8iP/WwmkpSsS+JBXaVbjqD3DINK1gi2pV5UdDYuf0GJ/147GaF5ExpFMwJ3mH8kQ+qr25cTIq+fb0YGy2/cfm3md3y+BUx0ewTKl2BNqFdJUa/c0gpWLOEe4eP3S4IH/TWpNOFtwwyqY/+7lmZstNbUkooxNRBg7roVJxMzvSl7chgHd4v14maH0DeiW2bsfWgRdKjDsHwwQn6JNIrxUTiEfX4eTxhDGFYtAQNu1ko2w8NF7926u53wQPS2ck5ANFKKreoN1BlfC3jkaQlRjb1yvnBZiIq8ZZCictzSFyn0TcOjStw210KgYWTD2IfYOq21DlsHVFBpdhSjS+U8OQFLzAaIebZAi1sHLdeCVhA8FkxnpW4uFeHU/7GJw47Xzm5Fq/31sYwmVHK8l875/WO2+Sx2DC5inGeP6WFV5b1BR/44zVUzVqCLBEC3x9W71CeaCwt80zzTkIcDjfyuYgWrfWlrQ1/NodrYKpzYmOI6VibpwrDx6HydXCnMgVB0Mgh8pJCdquLVnRQQMtmknd7A6GDtnIhGEOhGNska9Z0n2OqUzKnxjGLg6Q8ubRLyjh1oEDV9pjEClk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIL9kuiNAnxRK+6M3PqNFEIlNZ4NmUMR9oU6fVEdVOkxCc/AJ3HdZu2vNHgh?=
 =?us-ascii?Q?MvIVhb5An15TU7iWnuxUbiTUQQDVbFLmme94f76FcTlcFqcFB1+lHxWhZXHp?=
 =?us-ascii?Q?dTuWRLCNTQAyuBugJcRyDQD9OYzAv91ydZt7VBJ15hZyPeYRCy75QLbRgto6?=
 =?us-ascii?Q?ettCO0KkHPOmuIRbhG7AP4BL6Meu3FcPVX6ja4lzU6AuvktExxcS7Yi+T65F?=
 =?us-ascii?Q?caWxijeuT8q0nt8PmZscFPREgILA/2uvYVnsFzpyoe8yZUFtwkBgAuB/Eq0Q?=
 =?us-ascii?Q?8RMx085NGkPyTkwl+j1IadRgu4vIKQbhfo50mG8tth5YWyw2H7VP2RTyBADI?=
 =?us-ascii?Q?nesUrIv/Ld5SuIYs0R8VTsByu6eo7+U/Zl/ekXpP5SfOn+gsLj6jek2EoQR4?=
 =?us-ascii?Q?hb6Hxe0sOlVxfwbPJ92bWswesNU1Q0R4rmfVtdBE7t7RxdkMtZgaQPPjHVtW?=
 =?us-ascii?Q?OM7LZ7fltbkSjBgyRkzlzVa95KVSXEjKONzdWdzUkVTccSjCDnEY6tXfnPXw?=
 =?us-ascii?Q?4zGxgwsobZVT5ekZvLpIoi+x02ZxHHnWre70jWf5BM4OH03KFZeJvNKihSle?=
 =?us-ascii?Q?zO1NQu9ePiRw2dUtNlne6r1kY8HPUC65OOwwgUENu6SNumAz0kKRgkbpsQ0G?=
 =?us-ascii?Q?6kRFaES5we5WxKMZYy+fK8VvXfvboMSaBDG9I35laAW9wubwVEaBkGuGCtdl?=
 =?us-ascii?Q?eYyGjUFcMdl7RrqxtYou277VF8biPW3wgkt75jctun0MBEbmHhAuUp5IXdY1?=
 =?us-ascii?Q?O4ghMThUWktlMy9/q4i9HMZorQkkC3wsS/x6qc6seTY4pdfZIFtwtJHmqdlz?=
 =?us-ascii?Q?oA6+PBWHd5HsVbwe9fAu3WLTWdxDmHpwB5+kftALHCm8KTtASyh9EQzSMZPJ?=
 =?us-ascii?Q?7WRaR7EnVVDdappez7159K+pmDaYQklNbwHIBCZy1O4DwO6Ak+FVOqcJrsgM?=
 =?us-ascii?Q?heTysr8RP/G62wUxGZRe4sffzX7mdxyZI9uzsxnVAKyg8DvY7nIl5KZsvtR2?=
 =?us-ascii?Q?yykdakT9L7lyl/Njg2leRoiLdKpf97SOlIGmXzlKHsagEwHvxcv3gfQerqER?=
 =?us-ascii?Q?r9SgdkEqxzkB29s/7Y5nNJ8Am0byzloysDraY/x1uct12XIYGx5eHHN8Xu+G?=
 =?us-ascii?Q?SjzncD4Wdv1qaVEp1fyJcbHLtotJcJI+3TlvFiByTyudtDmIb+TDtp5plFRz?=
 =?us-ascii?Q?eGNw1k5CynFPBcWBV1XrdivqnNzFFNBRQnnI5GEc5HdCrmQ7vsUuSzuREgE8?=
 =?us-ascii?Q?VhIozLhR/wFTayRDHOFAKnIBLNytLxNeZPyxLz4tGxdJ/sfxqZBOoSnHBEp9?=
 =?us-ascii?Q?T0SDl/tg6byRzDSRlyo/aB2aBUa4wkJuTtWFBIrAfXuurrArGpUT8qeY1Yst?=
 =?us-ascii?Q?HQ6jM0vOR5zkE9J44A6FYsaEe4oKTTq8VVee8YcNkwEq0pESKStOa4c0gUXF?=
 =?us-ascii?Q?hiG/X9BlkEzD6tP17mXaTu+BBPyRg1ht37bsZCkouP3n5HNBw1puUmikXkv6?=
 =?us-ascii?Q?unM9ZUV5p4jdNyaFeJlyLrW5PqruTjSHLX7WsQXddIfDREVBPP2o5OI0B1Mb?=
 =?us-ascii?Q?WhCSUwiPtTqN60QlGwxFFmE9me/3/lB0mUGDrqlANKkZwVo9Oh5MeqD7nDGU?=
 =?us-ascii?Q?Dx44cUrc7MbpmkKwOKA4m6HUNgpN2GRS8NIh194ymgzN7kNtMu6t/JE1nrxV?=
 =?us-ascii?Q?Vi+09J0twOTE+PZY3aveflG5E727J77Cc/JonUrTVLjmbw1zlKcBNFbRBR5l?=
 =?us-ascii?Q?RlCpa7mZsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d72083-3a46-4703-61e9-08de89bde05e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:56:14.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0OkY5RZmL10Q+gIRZm+O8rBU2j+CwgdCRQMoqdMRzBeH2traKT9ljxG9Er8Zl5cUjTD9YkUvgTjFYarTVj5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271154-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6426531891E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vrf_rtable_release() and vrf_rt6_release() are called as part of the VRF
device's ndo_uninit() callback. As such, an RCU grace period passes
between the removal of the VRF slaves and the closing of the VRF device
until these functions are invoked.

Therefore, it should not be possible for any concurrent RCU readers to
try and acquire a reference on the dst entry while we are potentially
releasing the last reference via dst_release().

Given the above, the synchronize_rcu() invocations in these functions
seem unnecessary and only add unnecessary delay when deleting VRF
devices. Remove them.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bfc9ea91ac20..75edb8eba87f 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -753,7 +753,6 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
 	struct rt6_info *rt6 = rtnl_dereference(vrf->rt6);
 
 	RCU_INIT_POINTER(vrf->rt6, NULL);
-	synchronize_rcu();
 
 	if (rt6) {
 		dst_dev_put(&rt6->dst);
@@ -992,7 +991,6 @@ static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 	struct rtable *rth = rtnl_dereference(vrf->rth);
 
 	RCU_INIT_POINTER(vrf->rth, NULL);
-	synchronize_rcu();
 
 	dst_dev_put(&rth->dst);
 	dst_release(&rth->dst);
-- 
2.53.0


