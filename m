Return-Path: <netdev+bounces-307593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZF+iI0ulVmpp/gAAu9opvQ
	(envelope-from <netdev+bounces-307593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F4758DE8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:08:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=yIegOz9Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307593-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307593-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC23430C6380
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5DE2F7EF3;
	Tue, 14 Jul 2026 21:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14732F9C37
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 21:08:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063305; cv=fail; b=XAT4itAxvQWwzDcAr6YjuLqhCFEYMQaVTS1BMMU0C2CfatcnxL26EurbsFgjsbR5dYSORtOSuOtoQqSHt1cP//5djAVPeFectddMIv3VilELhSEte0rmwSZ2iSOATRGgvQ7R/pLuJRuK+Jrpi2MyuBLpNMJ6gzc2ISjRmZqkpp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063305; c=relaxed/simple;
	bh=3f5nXHltqa6Tw9LZWV8Xl7yFQUr18HflupCFtU1ARxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i91qyBoWtuFjOqmxhSyGfZsxSOQYXCy5Ur9ahB7L8fz5ZJG8LHaUlz4iLK19lk/L8uO7wdOVeMWf0wUhdwbnuffPAsnlznuSJ/nfb2XY9zUFRHKdGGVCFT8K/juKOvJvEqRdhiXqiiDupye3MdaIT/P4/Ic3LBwVkK08Ue6lPLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yIegOz9Z; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTSrmS3fC2E69hBGQDL61zRECaeYH5KNAOM7U3zCiID0QGQh6CbjphyTbd9LQTCEKiDJE3jhGix5wa+9pdVeSfvqZPuUDjceo5TdnooX0CrFy84lOJhH2ArhXKiQArt2OjLBnOuQKw2kUev/jTXceGqLLynHNzN+nRjoVWvNdr/SkWwkkUqkFnvU5Abo7RBsS8jVBAL03NSuUm4Yhln5nvwcjGd3bnZBfjVBb9/0z6gYC4hz+j/EoOdQJCOjbtYak/xvGQyGM6FXkT9pw9UzmEbv4IakPencIR2yIQDMTybbykVBPZ1mzxEl/IHuo5BpE3Zv4FbSVkfXu4fr59CiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaNGYzZRKwlLOs+X0s9u5VBxi0IlngJPA8pyuuQ0jUM=;
 b=YqxefE57qkxRLDB9kn+/Gbkk++ZS5b1zEy2Ff0DtNLWsnHQwH2Z2aoKJOIk49/OIZOepHxfW53+AGaUxaOweke2hmDhnmNz+Cd1hNVYXbIj2+Z9sdiuOAtyquKBv7etw8wdoWsWgGa+cJTR4h3Ir3niotwZ+nuCJigw5x1EXZ/iJWTOx4MPasRKVePkWvkk8mqaxE0GKOu2RnP1sdCVbMO/OdEL0nmg2/YLruk5y27FWPFP/825UprPNjN1zIv1Z9k9eWCq2WXm2WjXF7Z/QImZQANoj7ZP3n8hZQwpl0PN1S1HSiYSf+EXQGgfxuKRuCyfZRIk7lHMeXHGtkAimiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaNGYzZRKwlLOs+X0s9u5VBxi0IlngJPA8pyuuQ0jUM=;
 b=yIegOz9Z13s2l2mZ9IQiaPR+8QBmDsKM2qyI8V9/M9thJK4383q4EwpF/SkVhYWbBa6z/axCTjkR93ayn91hsMNGqlWWPcsYCo+ZhKlsFUpoUp1NLjp4a0FrypI1T5QrxF7ANVa/Z3UjO75WukAF8TH0Js14nQUzf6zq+VJBYCo=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 21:08:18 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 21:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 21:08:18 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 16:07:57 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: fix auxiliary device add/del races
Date: Tue, 14 Jul 2026 21:07:45 +0000
Message-ID: <20260714210745.1785625-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 290b0950-54c2-4c18-d697-08dee1ec0749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+MxsX0EQ4A+3ZPiAidMTLaUiLSWUr3rKaErvzerYKnwCbuOFo42Po+Hghpmvz9FDcgscY4bQGGiDJafi4mWz44jGGDg5v3Vx+/uC4zNJUKTKPH6WlzdSZM5/7csMDTDDYX+HHRGwGkQb5E2msu1mZNteeTCTh0UXTf2G2p8iCXe2ByKugROXwfRmQ7Vtwm+bVnxinRL+tZLB/nErjz0jPPeiOKJ2kjaFOgxS4OX/a/NKTSV01CHdeuWQURmuh+UStJiq4HzGoySznUladQD9zHx3ZcR1MoBhNxBY/6AoT1CT9IEODHA6bK6uYyelTx+KPXNdIJJCtXbSr4XczhRj7pnRCUxY03woqAslDTIJi/RGFIim1tIadwywgOhYEmZx4bOuteQ4gfn104THYPyye0JECerkwCW5nSdTu+YRb5GxKlzRAKXIYdTK/0QEaYBA5ghniojjyEUPAFrN8rAUUPJOCD0G05Iyh5expmJyQXAJzWu/gAyYQ1i0DMf4YUSjLaVpZqIacPTMrZng4r5MGyEpxVFejCBx9EaPfsOW6IcLcoDt7Ztl7XtbwK08MJD+N6IBvSX8NKqMrAemmYoJzUQE0BRoLY2LtmX7TByWUssaJIArtijMe8mpQxJfE0XByKb2HzzrcRgvpfloBEBLKTiBeVeSvHL/fBpoVWyHmmKtktLBmq1deqnonUHqr6bcqiJSnKagxU0or9tp651tOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EjidtRHYL0nXG62Bbk3XLepEk04wFxrNsRDxtoDF5Xfd3Ldmq3Ufbeb9txFBH35PgLDmiB5Ew3OtgG3SkjWtqLGxKSnaSIa5FrsOT/1iqw5eZJwQamFwLChkZek9dA+Ii8cRAroS5IIhUlGVPcj3GbGHjcRZsq2JdD7igftagvB137ciIY8HzFCFsNdxvi0LO77dd90bNlMx95SfGWnqHU7NDTq7H5qRIy0Ta376yYB1UEW4O921PwJ1lE9EtqwdZt6nO639ZCcAdGIbeIpkyOC+llC3jXs1Qq8uTU/4HSv82P0yWxDmqFMmzKDJh6IyD5CtHSy3piDzecLdvrMm/XYgXW9uHpEDzZnLGrhTaWPR5SUMmBng5XUsadNw/L0273hSRgUNJ8kPr+pG5uroAqwibmZTxasrZ5abM0iyHVbGgqiR+orUZSC9INTZpwKd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 21:08:18.3125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290b0950-54c2-4c18-d697-08dee1ec0749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307593-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:mid,amd.com:email,amd.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F21F4758DE8

Two paths add or delete the same slot (pf->vfs[vf_id].padev): a VF's
pdsc_reset_done() and the PF's devlink enable_vnet/disable_vnet handler.
They serialize on config_lock, but neither guards the slot under it
correctly.

add() registers and stores a new auxiliary device without first checking
the slot, so a second add of an already-populated slot leaks the first
device. del() makes that check outside config_lock, so two concurrent
dels can both pass it; the first clears the slot, and the second
dereferences a NULL pointer.

Check and update the slot under config_lock in both paths.

Fixes: b699bdc720c0 ("pds_core: specify auxiliary_device to be created")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 73b3481220b1..3acafe10a6d5 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -177,17 +177,21 @@ void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
 {
 	struct pds_auxiliary_dev *padev;
 
-	if (!*pd_ptr)
-		return;
-
 	mutex_lock(&pf->config_lock);
 
+	/* A concurrent del may have already torn this device down and
+	 * cleared it.
+	 */
 	padev = *pd_ptr;
+	if (!padev)
+		goto out_unlock;
+
 	pds_client_unregister(pf, padev->client_id);
 	auxiliary_device_delete(&padev->aux_dev);
 	auxiliary_device_uninit(&padev->aux_dev);
 	*pd_ptr = NULL;
 
+out_unlock:
 	mutex_unlock(&pf->config_lock);
 }
 
@@ -210,6 +214,13 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
 
 	mutex_lock(&pf->config_lock);
 
+	/* Nothing to do if the aux device is already present.  This also
+	 * guards against a second add overwriting *pd_ptr and leaking the
+	 * first, symmetric with the check in pdsc_auxbus_dev_del().
+	 */
+	if (*pd_ptr)
+		goto out_unlock;
+
 	mask = BIT_ULL(PDSC_S_FW_DEAD) |
 	       BIT_ULL(PDSC_S_STOPPING_DRIVER);
 	if (cf->state & mask) {
-- 
2.43.0


