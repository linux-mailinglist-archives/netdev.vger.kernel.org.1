Return-Path: <netdev+bounces-24976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A61772683
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B025E1C20B3B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C2107BA;
	Mon,  7 Aug 2023 13:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8C443A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:49:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D392
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGMz9VIq9A/+Y6FcbRpncZcKFAHM2ttRdVXg6+7AtLgA+jG6ZbKi1yXA9B2useF/gBnK1y8PkxLylsCxh9sGlZ0D1TPUXthOhm1mAdynJ1C/VXSsonuS6enehl1wm7xFcFPb7VNAVtIV1OVUpEyOLZrB5nhCLs23pfE/7Za9rHtJvzg4bmKKo6ZyqSTYDsJ+GoPr7HpnNzkXIF+IlFRNJB5vE9XnBgwjMrAktICqzkNKxkuKZX15QE6IMROwRFbYOjWLoTuxOXiUpc2DyOMjSC2632xGSlyVog8g20vJcKWU/AlmDgQpnd6pPhaGwI2dcZF8gp4Lztn5I2NcI8M0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J4mJ+w9OO0XSF3uM1FipvUQtPmHGzWuin1umRQfgiw=;
 b=Xdu3b+K3d13VHu2urnEosGHhgmbwQ8OwdY2JQzBEq+gw2wJ6NS2DEBbKGxrSLLAUOd3fQei96K5v8f4StvKUjC3WvHzr9Y3W6rEZJbglpQ8liZWYs8c3z5KvP7SN53lrJNX3HGQeL7CSZgJBF/MywoRva9FE/ne1H58FG7rRCJ885kHqtGVZF03qENz2GViDNrofK1CuwvOgApxflUvhYGmIsApOY/QlI5qQ+o1PLJws5xK4QEg0Ook0YLUwZPwo0Q2TRsdhaf+IaAURHoxMpPyl2EQaRq9VhFcrmde0RJFFXwSdwQjzwWy0Y/AZLlF6ObjRCenN+X7ETBsA3UdgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J4mJ+w9OO0XSF3uM1FipvUQtPmHGzWuin1umRQfgiw=;
 b=Fs4apgcg1iKsnkIfhGRy+K2CAk33l3JqxlrYVwMg5HdyxofhtLclc3uLzAT/DU8hoct2spe3H+Mh9tSt8LoaeWuHRzbg3vcx6EnSovRJGXNRFfhahPX9ixOn/ppdM02p870XKJ30WCyYXUd0ekUpbAYQPXcsR3It017BfVZAkIU=
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 13:48:54 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::69) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 13:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 13:48:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:48:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:48:52 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 08:48:51 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH v2 net-next 0/7] sfc: basic conntrack offload
Date: Mon, 7 Aug 2023 14:48:04 +0100
Message-ID: <cover.1691415479.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d3fed5-7ce9-4a28-9bb9-08db974d09a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9wCTesbkEbDc35Q+QcxWTAJ0uKat6mBHCPMTPomq6U6krkkYCvnxQAeLOAnyRiBiTTC2LEqR9tHCE4wQnAlgv2HYUeVublmjGU4CzRunlG0Ovr/JADcv3iaXmVh0z4WI+BwFZF+QenjZ/U5LhfOqSAwT1H7UOvCKTh2qq90aSfOx+uRL0GXT34gKUlG3btxGPlpBntEp9cPfZAO7oxjHUvr8Yf1YurY9ZiPZOXDLH8c3/7d/lPpbhbEQZEi4wvEuIxtIOFUlqdKc2hxhxfq235h3k7Ht/usw1DfTbyEjts5yENXYm6M+qjCVdPMm75lcfpCY7rEc+ZQksEP1u8VCYI8L3wey5rv6pdVNeSr6/mcdg36xcdzPLIyKJQEEkKxqfRrcY66IRmIil8yPVVMZwTb/Ron6pFhcDn+hfovM55AVYL3t5Y0xPpCPOl2gwekDi17wREHXbbw/t/lsFw52WWwvfsFXpvQqIZmkalBxv1OWz3AXhQI8cF0b3I7bLa+INMgw/7QtH8RMSWAwJjtQ1DE3ZZhRivlmUGtxkmKrRRq3Jj7Gxg5QoMOnV1ohYemfPzTPBDS9wqZUMmn+hcPugGto9j9CjgBy/dSgWgnO1S125mEKxpd/nUa1MDrL2ECYkFpFtxOOA9AkXdvn9w//PLBRs4mU82BEXya8Fm4sDUrprBFy9ZS5dBP3ooAoiizlGMB5mNv+MlHfyRVtUaN6awSATmIn0jv/MxEx5fjX1eF6jIG8IgI2VbjW68qvn8yBt7Fyz8TsmCq6ymG8lM8DQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(82310400008)(1800799003)(186006)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(6666004)(478600001)(86362001)(9686003)(55446002)(82740400003)(81166007)(26005)(356005)(36756003)(41300700001)(316002)(5660300002)(8936002)(8676002)(54906003)(110136005)(4326008)(2906002)(2876002)(70206006)(70586007)(336012)(47076005)(83380400001)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:48:53.1880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d3fed5-7ce9-4a28-9bb9-08db974d09a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Support offloading tracked connections and matching against them in
 TC chains on the PF and on representors.
Later patch serieses will add NAT and conntrack-on-tunnel-netdevs;
 keep it simple for now.

Edward Cree (7):
  sfc: add MAE table machinery for conntrack table
  sfc: functions to register for conntrack zone offload
  sfc: functions to insert/remove conntrack entries to MAE hardware
  sfc: offload conntrack flow entries (match only) from CT zones
  sfc: handle non-zero chain_index on TC rules
  sfc: conntrack state matches in TC rules
  sfc: offload left-hand side rules for conntrack

 drivers/net/ethernet/sfc/Makefile       |   2 +-
 drivers/net/ethernet/sfc/bitfield.h     |   2 +
 drivers/net/ethernet/sfc/mae.c          | 827 +++++++++++++++++++++++-
 drivers/net/ethernet/sfc/mae.h          |  12 +
 drivers/net/ethernet/sfc/mcdi.h         |  14 +
 drivers/net/ethernet/sfc/tc.c           | 533 ++++++++++++++-
 drivers/net/ethernet/sfc/tc.h           |  86 ++-
 drivers/net/ethernet/sfc/tc_conntrack.c | 533 +++++++++++++++
 drivers/net/ethernet/sfc/tc_conntrack.h |  55 ++
 drivers/net/ethernet/sfc/tc_counters.c  |   8 +-
 drivers/net/ethernet/sfc/tc_counters.h  |   4 +
 11 files changed, 2039 insertions(+), 37 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.c
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.h


