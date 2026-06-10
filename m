Return-Path: <netdev+bounces-297477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +1PfInECKWolOwMAu9opvQ
	(envelope-from <netdev+bounces-297477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:21:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1F666301
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:21:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=vzgMMRL9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297477-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297477-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 396B0308B0AF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B337206F;
	Wed, 10 Jun 2026 06:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17037204D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:19:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072346; cv=fail; b=Lkk5ooXb3h60itdYFzlqmqF5ikhF6XaJDmS5yHwtFcaSfqH5NCwgkEgo2X3g4ytks1bvujg1nhgHUjvS9oV457SmZ7hIn5Y/LO3cDWO7yhwWTLStdU//Gf50zki6oRZ75dMgK1SqaHWI5Fyd+swD9S/B7OtVDgxH0Sxv7tgwcuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072346; c=relaxed/simple;
	bh=lhARjXRu1aetvYk+IcXLXWnyg3fyZ86eSsDvevbGiOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7AyXIB9x3b6y25a9LWt35FQtD21Pj17NdtpAbuQX6Z5D0/gGo3oqBMXbTusD69+swF1llxi2VAoByXiKoXZePaOjg9PkxL0fxYBk2o5GtGiXhcfEB5eqBXOjChjgzhB0SZOP+8xiuoB7vpMYTNnBZvHUj2dSsEXlsyYw28t/lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzgMMRL9; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjj8ZJ8k0HZzzSlMJG5hAjkn1OMtu7RDJny22yrO4iIyRS2zwxu4mM853ycp1+EQow3b0/0t0ditfyTXmb724ZsxeIUHFkzGgXQ3S4YJoVHPyzOF/Mc25I+5oXFegQoCr4WImyvyTGa0Vo6zKGlzCmF7sknrwbLDQtfiGlWP9DGJAqUHhwM8r7kBOeKD8m5DtKnHtFgFJYW7Di2MViiS3xW4vtBKIRflVoio7/KH0Tlrep5ZXoCH2tJPP4+7FoqNZCtXBgNo2aUl9SAGe7zlO6XldKbBvaC6+aN/XNVZRNuJD0oXPbkk84aYRPDXCznz+uJj1Ht9S6quWr+01eTcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkvWXpIS0mq+qE4VNVfukAwZdPtGHRLAJV8+2ePyzF0=;
 b=CdmAPW0h2J5/zet4ikBaMNqclOxN0xL2Z6lPP+40l/vpe92t9VdSK6hWDCE+DXY5DC7DPkpvjO/lOcBtu4vKiFL7F+Ego+jjAv7X+NOO7Bz+p/SPSRVY93SEeldFHAble/WaPDrNo8+UEIA+eSeqkL1+mV7weZpN+uia6/UCyqIe9aBqlT5dfhMPGW7ON1NFQvILjq8vUyAUCIG9kgplWfYqgCFR62z8kguV3RcBM/JKMSUFCK4NMw/695FEkJ4IRUxprZEj1f2uTKDKwQF5WmoQp6UT3xNPq73tUOfGaRFylGzw0VC62YQQSTZwHs/ugprQzdr2+LlrtBJirzrHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkvWXpIS0mq+qE4VNVfukAwZdPtGHRLAJV8+2ePyzF0=;
 b=vzgMMRL9hnJki424Wa6EMLBlXzM10DHltsxJlkm06oX4NW5fZE9BeJXjgdYgq7gFTVRCbh84kPl+vIaU1rtBLwHe+lcem6CrSqOe/K4bugSmsYFneOFwWOv0kyVjAEzyEhLY9h0QZ7QJz0H4bIsGbtnMgVisfAqVcBYkNUWsp3s=
Received: from MN2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:208:23e::29)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 10 Jun 2026
 06:18:52 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::7f) by MN2PR14CA0024.outlook.office365.com
 (2603:10b6:208:23e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 06:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:18:51 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 01:18:50 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH net-next v4 1/5] ionic: Fix check in ionic_get_link_ext_stats
Date: Tue, 9 Jun 2026 23:18:26 -0700
Message-ID: <20260610061830.51037-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610061830.51037-1-eric.joyner@amd.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f50931d-a2a4-421c-413f-08dec6b82434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VsotsZP3hNxK4aKVDGgpAe+CGiPveg6tKnjXutPXhPyUMsZtntrU+ISb0muf+DBJttIpYt3u0T70Awx16Wf0rwb8uW97hAm1AKj2eE4OS73kx4PpssZEtJ9xEzY5xEfDGTbO7jAR1xfK2ZzG+Auuo+np5lzxb9Uevey6R4jhL+m9Z4iCWbiiBw0hA/YoECyKnwYV8rHfj57hOkvT60Np0r/28Tbq+cWsfyjCPieD7BYPPpaHed+VIij1/EzFhHgt2ai8lSC/HCoyAdM7oLm45PXjEoaUA4e/RVzmaA+jXroh0zCx0IVUpHY4Js39p/pdm6+LzLhMhUPzgxZr5EG01AsFXgJfiyl7vwYm75oWwnuxxwmztGAHFGwn1UTeHZIpVvABHkDydxpoa/Y7ry+uSTbulzJNgoL4TDLHRZJGKg7dgOdcuy8QNNU/e5rIpyMv88Aa5cbiNqzFEKMmuTuPG4MGjJ2dbwdt7VcqjIcWTtLoGQyXWuXMlDtgJDtSdCksvYrkTxWQZ7pDZvqLMofomXtnwCnls/X2KzQ52zoVQSHnox6Tir4ySRB4hrgUOZBDpUCv1ZYC+rQMBM5H+usNEc2xb3JAx5JWIedzOUsRxI63OxEpinVuPKepj49jRFNACKFmgQN1172vy4/JAZfDhdU3WFsMMETqdd1FsKDR/kVbcgDqzru6tn4WaSl7F27AJNrxqKc30Pm5A9WMW8gVf9G2lVLkSaDcLPrKNlFHsJo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CeGwrBK5FvzraOJRa9HUI3IM6y0HhmG5TcWTuVkLxkqqJjU+L6rgb4vVS0/Q3U5ZREFZAdSmy2xM5N8nco9gwGKZ193jaU2Ep4mHtsinlVn5xbuzcsbAFNrQlVhZKes8zt6utZ2THm9j8q1Ke12zPhqtOfNVPrNOmUuYKWi8k+steETgFzlpA8n4X/RsrM7B1s47rgLw9wZ7bRgSS8iJ0v0eeqdw3OZURiHI1PRvPAsjtLFzruAfl+dS7It4SzGwwpRmRzqfFRQh/0i2eiRuLVVhowgGTw8GWgMllPRxP0gWV0JfhuWJXGWJSBITsmbYUSq+ErZnUD8XlBtT5jm3dNa3q8uior4KZalHL5oJ0dSXukzuZdnsgnbSOapw3PofPbqRjQyn/HrhdSQIp/gpreR7PIQiSsq3lN+WePCLan3JPclXc9hVGaZRa7gTpOqQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:18:51.6436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f50931d-a2a4-421c-413f-08dec6b82434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297477-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26B1F666301

From: Brett Creeley <brett.creeley@amd.com>

The current check will fail if SR-IOV is not initialized for the
physical function; this is because is_physfn is 0 if sriov_init() isn't
run or fails. Change the check that prevents getting the link down count
to use is_virtfn instead so that VFs don't get this functionality, which
was the original intent.

Fixes: 132b4ebfa090 ("ionic: add support for ethtool extended stat link_down_count")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..6069fa460913 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -116,8 +116,15 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 
-	if (lif->ionic->pdev->is_physfn)
-		stats->link_down_events = lif->link_down_count;
+	if (lif->ionic->pdev->is_virtfn)
+		return;
+
+	if (!lif->ionic->idev.port_info) {
+		netdev_err_once(netdev, "port_info not initialized\n");
+		return;
+	}
+
+	stats->link_down_events = lif->link_down_count;
 }
 
 static int ionic_get_link_ksettings(struct net_device *netdev,
-- 
2.17.1


