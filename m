Return-Path: <netdev+bounces-44189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03177D6E88
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF91C20982
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8DB28E2B;
	Wed, 25 Oct 2023 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="aX0bZnRI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16118B08
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:16:42 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2117.outbound.protection.outlook.com [40.107.7.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F318B;
	Wed, 25 Oct 2023 07:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/5y65UZv5YGTMC+RcFvR69Xge8euvrX/pZsMDPASOW7PzdGmviZGTtep8XzPDsPSy9CESATYuwujSgZQwmQtb4Ck7B7qT03E10DhG7uDA8X6D2yvNxIqn1+reLXUddMcJ/TbW8NGDQEzvTr4R/eY2+b90KGFSxx1rtcVhHyU0BeUQptWf/lxooCw2d7OrEY2nnmzgjHnyW0Y+MSAtpnoqdUaAiZkA0s10SjCfxNysTL1DSMtdd6YdqSlOz3jJG35uB5Ob1SP5lyQIXqrs+FudObqf3Tpammt5CrhlEMTe83DQAaZdeyQ4gD0Dl2Im4WcMxhWtqcwwvXKUW7pQYmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8urGlYk0/wJuySBnLXo+vmKMIxkPdqi8yGh01+2Dk0=;
 b=MOcVo0/oG4Az7ajoq2jQGnW6vtm5gMEBanzbccNKsGbw68HzRRPgveRr2m7S815jgg++k4ZDQUTL7ihZj2STQYvRPMM++PRFLtAk1wh774ZBn9+iJXkEzN4NEe/6dWLDuh0DKAGXAuKTaQoMLUTWEBO/A+4RMLpRLUcV6iQWuW9Gm6pV70ViSfVl1J+VFQYBUOc5wdCzcrqC4mlooquW6ixnu+jcrF8jYhCtkRsyCmyLkGF2sj3A9aTdYBLprK/XynXPpfeHAgHfMMXOQCdXC00Dhr6JJZvLKANKQPd9N4C/Sw9pRlcbmdpsOeB8oen6xixJITmwdwhfryKfO7KLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8urGlYk0/wJuySBnLXo+vmKMIxkPdqi8yGh01+2Dk0=;
 b=aX0bZnRIC8QVwpm0XtNlNHasoNyrd332LGwFxpKfH/xf3CNsLLp+jKYPr/0+hTiFMAFgWCtSQ4aAjpP0CI7LNHPwKvZIbd2zWBE7KOWOd9gbUqZPU9tqlNnMiSUeYT0wEJetKLYSr/iu0dKI8uBPR3+zUpHgIgcGSY4x0ABn9k0=
Received: from AM6P195CA0092.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::33)
 by GV1PR03MB8790.eurprd03.prod.outlook.com (2603:10a6:150:a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 14:16:36 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:209:86:cafe::41) by AM6P195CA0092.outlook.office365.com
 (2603:10a6:209:86::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 14:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server id 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023
 14:16:35 +0000
Received: from esd-s20.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 49C297C16C8;
	Wed, 25 Oct 2023 16:16:35 +0200 (CEST)
Received: by esd-s20.esd.local (Postfix, from userid 2044)
	id 30E922E459C; Wed, 25 Oct 2023 16:16:35 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v8 1/2] =?UTF-8?q?MAINTAINERS:=20add=20Stefan=20M=C3=A4tje?= =?UTF-8?q?=20as=20maintainer=20for=20the=20esd=20electronics=20GmbH=20PCI?= =?UTF-8?q?e/402=20CAN=20drivers?=
Date: Wed, 25 Oct 2023 16:16:34 +0200
Message-Id: <20231025141635.1459606-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025141635.1459606-1-stefan.maetje@esd.eu>
References: <20231025141635.1459606-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|GV1PR03MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: bf54df64-6203-4d00-dd69-08dbd564ff14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w0b2s304LnN2yHnG5KKX/LzNJns5VjFCu7CDajN+GGHVnHPgo99tRJa3oPEpzoOxVUGGQWRQ/BR1xWC2GlpwoQPbxrfFJKFzU5r08Me7urr3Jq/QHtOOr/INcfhQiPeXd0slDMB0x23fZwsp8wjm2T2conZHsw/RpA0Guh94Ty1FG+CjGBXXisbBiUh7wXwimrOHxjiIJCgB4hHjsMBA0wSukRStiMVbfTNq5E9612aOfyF3qZYmNR+53dPZ642VlW83FJK2gnqS8+mbYYZ3Ov52UM+59MKV1TE8/scoEfQFiRWx8pu7XMO0HFj04T/hzzqXXvaZ3Tfclb46HkJQpxMgDqPwEVPT028zaLy6ExmcWmW7t+/OyLJ7er/cfW9qZDsiCSNARR4DYu3nP2y2JPY9FB9LoTD64I/UcDSEZ71buoUFbjKoc6lrXLASNRdszh+z9YEGpvDJho0+81TBkOuxNycNkziz64ggwmSRY/bcXeHaG5k5o+hHZAF2QyQlLuKNLDwL7clqUdAMq1sCJtN1weP3khxvrpo7lCpOyPEB2/8ale8D7B4SzU5eLrBiRJlDx99xTRJr6Nuc0DNDybb2bjDs4wR57EjSLhJvC8GwUgUzMa7lCpnrdL7/JqiBcCYC0PJoxa5BOYaYtb5kV70CT3OrLeDUeYHsWXfHFdZi1F9CsO3gwOVI7jtnu1V+pa0LDA7pY1va/8zBHM3i9Q==
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39840400004)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(224303003)(40480700001)(36756003)(54906003)(70586007)(316002)(42186006)(356005)(26005)(86362001)(36860700001)(81166007)(1076003)(336012)(6266002)(2616005)(8936002)(41300700001)(70206006)(2906002)(478600001)(4744005)(47076005)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:16:35.5279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf54df64-6203-4d00-dd69-08dbd564ff14
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8790

Adding myself (Stefan Mätje) as a maintainer for the upcoming driver of
the PCIe/402 interface card family.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03011d7ee087..7db1bd399822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7753,6 +7753,13 @@ L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	drivers/net/can/usb/esd_usb.c
 
+ESD CAN NETWORK DRIVERS
+M:	Stefan Mätje <stefan.maetje@esd.eu>
+R:	socketcan@esd.eu
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/esd/
+
 ET131X NETWORK DRIVER
 M:	Mark Einon <mark.einon@gmail.com>
 S:	Odd Fixes
-- 
2.25.1


