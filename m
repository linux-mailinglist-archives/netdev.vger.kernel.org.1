Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E074118A
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjF1Mp4 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 08:45:56 -0400
Received: from mail-mw2nam04on2086.outbound.protection.outlook.com ([40.107.101.86]:17986
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231811AbjF1MoF (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 08:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnMiljTyBMUHPSPRB3v0Ib+PS+yWV26H23BETWtA2/K7f5ewoXzezfH3ZNW/jce50Yoaul8VqJir6YPaT93tS6Zd2b7wyyFAK5AxUNyL7GLe96E6lClybqjEIxy+6XODGUy9istT6XhXu08R8HoJlePVDT7BqTIe8gfOHiIvLU7i9prY1LPFACc68J6sa5kWlWuxSgWKJjG0B1EjYRQfnfH3slYEzz8nyUubB2zl9JhtG0mvf8+HRfAFj2YCk4Tzzuy6WwjUUgjbfw1XkEVQpRz5klnoc3inSRgh3vxHEydWfYOgQ4Rg4KdEu1+bR/P71OBczZY5C+9KOSn8W4KJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EShe1IsihnQ4DZ6/wWQBAgsU3aywRR7zDCZnuY36Go0=;
 b=FHkf6b57/VuPAEQWk1/P88MZs7MALEIiz8/CEGuQ2NS/zSUz2V9oHWADDICkampYcBZz3BQvYx/D9xJGnmN6f7SWGcXph12Mix2kHZQ/a8hZK1D4I1xaOCY2HqK9WgARGuV0UI8GLqewoyZaCY2pApg8JVSM8Cm0361Qg/SArgWbZiQLp4W2ks/o5EyF/5YOrl1xOBU3jzaB1ts5Qpkem8VyVIUEwJi7vl5YiDxMJccZxn9jO7vmeXDXywZJtVl1kUzEks4MFQzUbF7DJOZCRWAAJKgRme+fWdwGDv6L1teuXx9UHOYsrklr5Vu5wd3UnKw4IR7mtrB6dblfLvlJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EShe1IsihnQ4DZ6/wWQBAgsU3aywRR7zDCZnuY36Go0=;
 b=DYQ10xBr9PB5SyZtn9l0pqB9z5Dt4z4dRlvmtgdhdbAgO/gEHTMRrFk6RKakV+Ros6qh1t5+xFItyT5x4uqGnTH9c6K1qmazZ7nxkXol+uhKlWxCihX7YncFrxV0/i/l19IrZXNA61J4mrK83e4/RWh1YMfjnjtnxuzhWeA9Qk0+lezf0IDQ0vUJ2ymemc8YDJb3NlEj0BnzbwEtlOrF9i/2vj7SHHTdfa7AaNf6N4iJEuuPFC4kEo2PQAUPk1IgFoDbvy/yK7k39/XRBduTAbUrqwX2ikGeFvh4G5obq58IMk6eTeuP12asqfH93GOojNyw5537Deq97qb/AFAVww==
Received: from BN0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:408:e7::33)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 12:44:02 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::e2) by BN0PR03CA0058.outlook.office365.com
 (2603:10b6:408:e7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 12:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 12:44:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 05:43:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 05:43:46 -0700
Received: from buildserver-hdc-comms.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 28 Jun 2023 05:43:44 -0700
From:   Revanth Kumar Uppala <ruppala@nvidia.com>
To:     <linux@armlinux.org.uk>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <netdev@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>,
        Revanth Kumar Uppala <ruppala@nvidia.com>
Subject: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system side
Date:   Wed, 28 Jun 2023 18:13:25 +0530
Message-ID: <20230628124326.55732-3-ruppala@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230628124326.55732-1-ruppala@nvidia.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8851bcf2-7b8a-4e77-84d7-08db77d5593c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: No4S4aXKv02+wqmePmilME895DiJmmhu61lrj2UXmFwcx/sq/QOy5WiwR8g6Y4A83EqOVtA48RiIWtUgjW+CJacE4AkdvFsKvPbrZxbOk6V82z1LGrtvEAl0XBAYYPW+XSi/JMa4/34boSc1Slrfk3JM/NF0dAanz+tJ6RJg9ner18WZ6u4YLUM7ay/EYJfxGzqDDDk4AZkRUvK1po/mlqLwznORvpvRlt1zS6534MgEVv1GIdR2ZSL1uVVJc8AXz/WjLsCm487Yoq0O5q2FS0Txi85i8/UDZR3hrmvWDBDySw646g6eOnzI+UNNieUzNiBPLRypXroH8i+cOlohH1HPygWOXhA9oAIgOq8fxlEDaC2X5iljFtjV2vofQMGkGX/aVYMbc9c7/MnfmvlcFhxkqS+prsdTF6rG878NOBh277T57Wvd6e+OkLtnqXUMOMzFF/Pm0p+84Grd2iwMvCEOSTXCdmcHOY1JOzMuRDwG8cL1OBusenNKNlnwtYMZyaQ0HZh3t/+Mff0as7uQwdsDzIrCBF53dPrlCwGCuQGd05r8s2Uvh0mSZ+DQfH1dtOR8O20LP/n6iuY8g9xqKwUhmjeibOAJonKskYRe/iLtnYpjayYEH9CzQXu9Z8hN6Qcbp9aQrZSFlNHWt28OYxKLrhJDihX5dVazVu3oibVwYRlZOHv28pVp12whjczndo4sh5SR9zImm55fxo61L1bK84BtFs8TPutm1123x2FOT+yNt0mOmR6q8nwKKPwr
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(1076003)(36860700001)(70206006)(40460700003)(36756003)(5660300002)(356005)(86362001)(8936002)(8676002)(41300700001)(316002)(4326008)(70586007)(40480700001)(7636003)(82740400003)(107886003)(47076005)(2906002)(26005)(478600001)(186003)(2616005)(7696005)(110136005)(426003)(83380400001)(336012)(54906003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:44:00.9903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8851bcf2-7b8a-4e77-84d7-08db77d5593c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

Lane bring-up failures are seen during interface up, as interface
speed settings are configured while the PHY is still initializing.

So, poll until PHY system side interface gets ready and the interface
speed settings are configured.

Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
---
 drivers/net/phy/aquantia_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index faca2a0b1d49..a27ff4733050 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -41,6 +41,7 @@
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_SGMII	6
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
+#define MDIO_PHYXS_VEND_IF_STATUS_TX_READY	BIT(12)
 
 #define MDIO_AN_VEND_PROV			0xc400
 #define MDIO_AN_VEND_PROV_1000BASET_FULL	BIT(15)
@@ -467,6 +468,19 @@ static int aqr107_read_status(struct phy_device *phydev)
 		break;
 	}
 
+	/* Lane bring-up failures are seen during interface up, as interface
+	 * speed settings are configured while the PHY is still initializing.
+	 * To resolve this, poll until PHY system side interface gets ready
+	 * and the interface speed settings are configured.
+	 */
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS,
+					val, (val & MDIO_PHYXS_VEND_IF_STATUS_TX_READY),
+					20000, 2000000, false);
+	if (ret) {
+		phydev_err(phydev, "PHY system interface is not yet ready\n");
+		return ret;
+	}
+
 	/* Read possibly downshifted rate from vendor register */
 	return aqr107_read_rate(phydev);
 }
-- 
2.17.1

