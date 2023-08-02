Return-Path: <netdev+bounces-23590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4CC76C9A6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997191C211EB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC063AA;
	Wed,  2 Aug 2023 09:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121F63A3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:42:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ADDE4D
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9HAy77Fuu+iMlULgcdcOrZQjaWxfkVKGDXDTVRiO5tZbxOoPe/EGxfDphBDV8yjZ+/s40TSIJoNKDq8+O9qmDrAV1MvKIJNgtyaxZJpSXVrs8HP3WEYuUa8S2PrFi9QORAQK8oMowQSUHbjNxCWkMNP7N7okAcVa94aEzoHh4xaIh5rLRI/KqeDrt4u55Z481R2oiTe/UystfhzYczzshY8x7EIK8nM3dQ8m1pQnKcFAegFvq5CszIZB9yW/gDa6hHAAv01HIUlkz4b3GFfCcKo3/DUKX/FDnmP1b1sG4OTw79q8IgUHBHAU7S+3NLiSAY+l4QBxYvFewRcamE1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=609zpRjSlcZspd3Jgc+n0PViBo6+37DXPpI3ak2+ORc=;
 b=A0cnr4skhhntJ4vbZMmJaxLYvWnzidRZK6J2j++qBi4SX+mTYhBS5sfNjumKaa/HMpJpxj99r5tRuErWL/TIDzl0SBDKIZAhnA83RrL2+bjXQ+WSACSEBooKCs/7euoIKo8DULWwyhbBMzMTV6uRddpuWndOey/e0gqYbboqu0dBhXt8KoprinXVjq/Y1RFa76jOz6fvPcYv04Y3dzUJCzqi/nAnjkN6sQYAtfeEPEZ34htIJWt8tH82qKisKhpKG+rXY5jn64OMfRBSYbko1kpPHKLH66RLf4HTLeQ2ZdfqB7Z1fSk6rI2H8mMhvf8ptJ7nqj4EYFvfvfZORf7Y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=609zpRjSlcZspd3Jgc+n0PViBo6+37DXPpI3ak2+ORc=;
 b=xKEk6YLYUUcdCUaMmAWBZ2QagVef0bZJMzv/CNXX0wIJXs+xSVpu6T1pL/2keJf//XkBfDUdLxuwevbzjoZmcxqTBnjh9oyVaLncEcu1Eh2I3lIqhObRNJ1fXLFXvR9X1W/YSqk3jehLa8nrx3/1uEwgQkl7wC24XMGracuMq6k=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 09:42:07 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::f5) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 09:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.45 via Frontend Transport; Wed, 2 Aug 2023 09:42:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 04:42:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 04:42:04 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 04:42:03 -0500
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>, "Martin
 Habets" <habetsm.xilinx@gmail.com>
Subject: [RFC PATCH net] net-gro: restore check for NULL skb in napi_gro_frags
Date: Wed, 2 Aug 2023 10:23:40 +0100
Message-ID: <20230802092340.9640-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: a63dc3c3-a6e8-4705-2731-08db933cbbe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oUiBmG89+pTxfM4tm6XhalmkOL1OkUyAicfjo/CQZllfyTdu9PlCJQ+6s5bAlRCw8Fc0hHTGVkqoGutNj/JOf/9pMsiUdwnATaDGh87MVb1D6Rxo6bH8m0rfLUyZduJxybO7S054MjfkaAIWIJnkwAycwdAJMcsf/E4uRM35OEDKIpHGG1pSnxifkIWTbUYEgPu0aeahs7UPYhpJWsZbvHvaVa2OpU5KBjQ/g6meaYIg+MF0U6O+CuILfmWbcSAVmGCDIBcoAvil6XB+qRC4oCSJCTcETOIfW3cUAVbFGMW7XvlhDwhfRZo1eyzm7+Bq6mTZtWOgAMjlKH3+9RtYdxhyxUlU10lQ8HZgtNcp3ksFwZVLNjqq3baZ1kD9RVx3cAhXqAPCbNt2f7ChCjn1RRKC5UCZBxKARNxscWSUrYdhHyr7dx1t44y1S4eaKhZVY69ASO0f65XCATHRU7rsfS2sg8ifVXt9kIcaicljk7R+IqYY5XdefVHZ+wxsjR0Jr79KDun1BZOQzu7gwT+TTe9MUWJNMQRTVfswHbBAdRbA6UiE49SsxdvW1cyiAkzIMv/z2wrcSj1IKk1Owd3+OuLXbwBCXWgk3pqdnNzVIF6CKJO1r+pmApiO/pKHXPxGMWuY8P0nVO9rCZE8vyp6hGgIq8UjLeSmn/wYbLI6faH6050LqKu8+iSKIlR0JYY5qZmSl9sxv1u7MVoHC70pixj4vQg7v322vRdXKc5MeOuAZgeUSpN/1bMldzr4M01fvJ9eRsGlG6vxtQLSgXJjkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(4326008)(40460700003)(426003)(70206006)(2876002)(2906002)(70586007)(2616005)(81166007)(356005)(82740400003)(336012)(186003)(26005)(1076003)(83380400001)(36860700001)(47076005)(54906003)(110136005)(40480700001)(86362001)(478600001)(36756003)(6666004)(41300700001)(8676002)(8936002)(5660300002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 09:42:06.2069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a63dc3c3-a6e8-4705-2731-08db933cbbe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Cited commit removed the check on the grounds that napi_gro_frags must
 not be called by drivers if napi_get_frags failed.  But skb can also
 be NULL if napi_frags_skb fails to pull the ethernet header ("dropping
 impossible skb" message).  In this case return GRO_CONSUMED, as
 otherwise continuing on would cause a NULL dereference panic in
 dev_gro_receive().

Fixes: 1d11fa696733 ("net-gro: remove GRO_DROP")
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
An sfc customer has encountered this panic in the wild; we're still
 investigating exactly how it happened (we have a reproducer) but it
 seems wise to have the core handle this check rather than requiring
 it in every driver.
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 0759277dc14e..0159972038da 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -731,6 +731,9 @@ gro_result_t napi_gro_frags(struct napi_struct *napi)
 	gro_result_t ret;
 	struct sk_buff *skb = napi_frags_skb(napi);
 
+	if (!skb)
+		return GRO_CONSUMED;
+
 	trace_napi_gro_frags_entry(skb);
 
 	ret = napi_frags_finish(napi, skb, dev_gro_receive(napi, skb));

