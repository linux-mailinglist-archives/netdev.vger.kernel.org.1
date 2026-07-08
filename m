Return-Path: <netdev+bounces-305866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mucgEl1xTmpmMwIAu9opvQ
	(envelope-from <netdev+bounces-305866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:48:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7617728406
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:48:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=selector1 header.b=ZjDpk0u3;
	dkim=pass header.d=arm.com header.s=selector1 header.b=ZjDpk0u3;
	dmarc=pass (policy=none) header.from=arm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305866-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305866-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=3")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 273FC310E749
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B43F12F6;
	Wed,  8 Jul 2026 15:24:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75973806BD;
	Wed,  8 Jul 2026 15:24:02 +0000 (UTC)
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524244; cv=fail; b=patJEXm6v8Wi5ecFjZrfmVgQcwlldTKz51eOtNjRkPe0BjtjUrvTSLR4+YLzy00sglx3c5h12YiieRyhwO8LOXsnpA6bdTjj3gwr9PA0nOt+OmDsoGUg82veU4mQu2dvzxssCOl2fAyRFzPHRiP6c8drtKhSCiG81h53KyuSADE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524244; c=relaxed/simple;
	bh=HoU273pQyqs3g8iYCqQj43en+j7QCEDvH3wddbqhA/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4j6y0hocQ7198d+pm2gCtSIlDHw5JLuB2ul6iszTuWNh8/vjGRVHt365EahAe3IiUzwBEnNnfZ8pQwc5Mm98yCFxa06loXzeKWAzPi69ZNa1mGxz/5bBD7q9KkmBJF8X0IJdg9gNOA+oOllkQ06TM61Y+GeHl4HAuor9j8sh9w=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZjDpk0u3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZjDpk0u3; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=j3TJUtAHoWI/iI1cDoti7XzPlSCKNpCjzh9GYvSUW0kUNIzPgzxI5R2zWZ3iShwdGUEX7rlngwh9hqLOW5GUw/trjgF3mOCUAXuudp5finzOL/YvgNqLaHHCv34Zm9rbMrnqX7BbxI5BAqSbDzYoNGE6PxLWRNqjrTqZcIOP+MqIp0egKYeyMC7iq9HeIXSZQh8Hx441X7dB8FPVDRjVSFbnjgsxTkFiEMe6XI03bWDDughvX0O/QEEGNQcke2eWjqx0TbLxpiEl5lZO3GK5u/oceatR+1MR9Xvanr26Jv65cPJpudZ5HTr28tyrdQ18tVu3ttp10Z+WZleLqbOnfA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcspXWhS5j+aqFVUVqnMCRK4Lk3344Lrr4kBgjxwIHA=;
 b=hB5FNpjdTwWYjHSJTNNtfMrkSvJTnO2MVydsQ4AKukDlcoDGpryLZddm0BKgFiG3w2ywoG7snMhsxXkwrglOMiwkwtDR1ZIPbuHrboUv2BsINq/KLlSxUsIXuyBs/PVrqNQ90Fa3UectcybV/f8hU+ITYce8p/qbePHxJ5zWeJpR0ATHpaLSG23vHcAP1ewrMcTmx19sS7WBQ9Wf/gQ5t2mdCSlNGC8MhcxXdehUHTUS44CwevoJzdb1x8MqPyKSZ61gKYZ7tOA2n5MvgspATdZhcbiYdtW5btYPHkq5syBo6VHl6xtbTzR7+H37A2Q0Ngt7G5K46sYtJrn537KygQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcspXWhS5j+aqFVUVqnMCRK4Lk3344Lrr4kBgjxwIHA=;
 b=ZjDpk0u34u1pDiZ9SU4zbbqwpQu2UzVSzfHHGsnwU3gFmemUKHz1fbn6q7TjFMDOJ2r6a2cQb0f6UXRngBoJJxDSTHaa0dZVoYSArq5xQHQwPi2sFXfd0O6gdkcbpl0/3Jh4RJNA5MmEzEV9GcCy9ZVLQduh8Iw0HB4cw717ubA=
Received: from AS4P195CA0041.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::13)
 by AS8PR08MB8876.eurprd08.prod.outlook.com (2603:10a6:20b:5b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 15:23:56 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:65a:cafe::8b) by AS4P195CA0041.outlook.office365.com
 (2603:10a6:20b:65a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 15:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 8 Jul 2026 15:23:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeIwEaJOvMMP0pc3YG88i4unZ62He0lrym5ItpYG3pOiU9YUK+YXDXPXregix9hio4AioKJeEJDlKWfKZE2Nm2Wqfq+CmXit6SAzKl9LxKz3eYJSrambjghhiPr9RxASb1rLI1b8X+RDfgfi9s2DviLOJY2pA0CkmB+hMW1O/s4wXbp9+8RzsBYp/8yuFB900j7AP8uoRBT4RGizpiBNf7xNaGXXS3giPCt1BAiMSgqnDIFrcOEdszjKihP8bJtcZ7KX2CVakRZw16d4H6ctpnjQp4fA6rjOXVJJK3pbOw9gIkWqtqhgNi5d2vP7oh36Eu3lByDXlaEYPmO3IltEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcspXWhS5j+aqFVUVqnMCRK4Lk3344Lrr4kBgjxwIHA=;
 b=siw3+cfQjD9MAPgpAkE15SLD02rOnnGhECRhnMYdoJUdlw60D7NmZ0yj63cLLdZEG5cmpxsAZ91k+r3UsE17LZafyKatZPXgqcz0h7Y2WRbtIRvK/XUO73ZX4w3ErlCKHent9TX7DcSM+/HToZWIipNVYgyL39PI7YNtxIdPnsLotm/dBMNfSUC7yS067zkqkCrnl6T44Ybgs7kxZB/B7Qw1jV2OAdg0fWoWJ62TPDnzbXJuIZpSaqLDyxWPu0M/Ubd0o9TXxWIePtrwy5zRn+d/u5sw6VaMZuIhJLPU4VrLIoN4U2iC8xBHsCTkrY2cqIObO3Kf5mn613IFvPSNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcspXWhS5j+aqFVUVqnMCRK4Lk3344Lrr4kBgjxwIHA=;
 b=ZjDpk0u34u1pDiZ9SU4zbbqwpQu2UzVSzfHHGsnwU3gFmemUKHz1fbn6q7TjFMDOJ2r6a2cQb0f6UXRngBoJJxDSTHaa0dZVoYSArq5xQHQwPi2sFXfd0O6gdkcbpl0/3Jh4RJNA5MmEzEV9GcCy9ZVLQduh8Iw0HB4cw717ubA=
Received: from AS9PR06CA0731.eurprd06.prod.outlook.com (2603:10a6:20b:487::22)
 by GVXPR08MB7894.eurprd08.prod.outlook.com (2603:10a6:150::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Wed, 8 Jul 2026 15:22:51 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:487:cafe::30) by AS9PR06CA0731.outlook.office365.com
 (2603:10a6:20b:487::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 15:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 15:22:51 +0000
Received: from AZ-NEU-EX04.Arm.com (10.240.25.138) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 8 Jul
 2026 15:22:51 +0000
Received: from e142609.cambridge.arm.com (10.2.203.53) by mail.arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Wed, 8 Jul 2026 15:22:50 +0000
From: <enrico.zanda@arm.com>
To: <jasowangio@gmail.com>, <virtualization@lists.linux.dev>,
	<mst@redhat.com>, <netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eperezma@redhat.com>, <nd@arm.com>, Enrico Zanda <enrico.zanda@arm.com>
Subject: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net header
Date: Wed, 8 Jul 2026 16:22:42 +0100
Message-ID: <20260708152242.2268848-1-enrico.zanda@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00027A64:EE_|GVXPR08MB7894:EE_|AM1PEPF000252DD:EE_|AS8PR08MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: c76d936f-82f4-4c7d-22f6-08dedd04ed5d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 VVoPN83q+NmKedWbGyeoGNC18BBeEfO0Y6XmFv+s9/alZrZ0/EKbHTb6iW1rsLxyG9+k7r5qAZzPUcSvpuHRqJ/GVXAbcT+m1ffYP6jRF2y8TqFfPNT7TApJjVCQwuAXUwobHBjO6q1PmlSa15si9x0mNuTPzLbz7pgGs5PZRYfWI+IMJK0skBW2LpBa9CCay/fUAavRecIyXKjzaRAZkB5yhkXgAK5ZirU7IryibvXelfnfyzL7wFHGQkinJcmojN2afnueGi1yhn2cw36DR3Z8nuxjA0R1HIOvbq2W0fdAcwc+wDoegIWfRcG8WaoxCktMVOvTkqfy66DMSXkmm6Wl79MUx3do6EnwhCY24hLEd3+4HUNJGQNNhHv5B88dPaV/+hUnZFAe2Y2EDGj0jQYv2FyjRIsz3S+O6yDVr7degtLJJDw5KyeK7z21Xn4V+2PO/OwwsdoHcbxcynsL/6qiIsNaq2kZ7IBBFbCF8NRCv/zbH3p22Ffd30UmlbFjFbucaglIyiflRZPDGJ5NngOi5QIEnFimGADjH5ADA3RIu7YpTq9SxBM9UeGi8QOW1iM8KJnFTLUTKXklXzIX5uIurHrBfEFjLzIm8MERocKPwglJ6ltTrtyM8GIX4lUP+jBiVwvVyi+rbTTFJnXGhdWf/LcqE6QJEg94DQaJ1KZFvKpwEOPSixBjIKRajqt9wCPF2NhrJWhUSV+X76YlfQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 LTlZs3jE4wczhJst/+GGxLsL87DcicD2/L0h31xA243Y10THHLD3puAWTcEY6pHy6tdVwa/DyqkFU7DBVyv6j6I52+ambUa5u1qc5DlojdW4r4sLXeKKPeo7jtKpOr01KqEDMEYsc3MIM0R1cnaEInEou1IqiUhyJ6ojEgSBeu6hOVn01ZPbdk05hQU0brPV+/nweDCFFzv59AEbC6exZpI/ur1PT2S1PYBCpHa8DsSA8Bs/w80tDNXD/T+VnuvwitapK1ylR6u2XWtX9DQlsiwYRQ/hzCizpx1ow6tMS1rbpdJ0L/tetgXUWIQsj2xCCym5tl+jBIByLbvQuUl6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7894
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	72ff5d77-5872-43f5-b01d-08dedd04c6c7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|35042699022|82310400026|376014|23010399003|14060799003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/FRJzQzbgYVLGr48OQ3ZCkCfXSTLuBNouk8a1g3VZBvsvMTJv7AFlX4gkMAPAarqfJA4pZr35p2vHV3v7YGN9tadyAw5Edm1dDjl1Uw4BITv7WPSM3p4yuCp7JeFr0Ws/dDccAA+HPAHnTe5PoiGRApwYCaewG6F3qiNXHUw6SF8Wyr/cnJTtguBpnPg3aFne9Me82ZVn4Li4QVaBKk/7t5mqzjWG77lCKL57lUNUPbi4CpmSSKddhMYm6LsTPYm0wOwSiPO2ptm3uQeLza1kk86umBERkyoWsltVTE8spcIsn92H0wpb0aEgW56326ib1inoAWav8S1aaW8fdz/iinJ2tR1k0f7evEUCs9c8Wb/VaYx63FEhlCu/pqEQ5uqbN3kQGNEDhCoGaSXANtZ8Q6CD5rwi6V1laWwH08/ibMORFTZEeQAwOrv/WqlUI0MBdDoibmb+gbrSFxyUcDc9UTuGwMRPepdVK4YiVFsMr47/bZDtmvTBL6JxWtxHI8hU/5xNT9lztF+L/uhSJ2fru7E0DlVDdHsqZMpL/hXcMOB4ibXbfB7DgzGZfuXaQWGLC0wysvWonZYDa/8VLsKmUC4UKh5eygBvhAWCLZfLCouTVSfiFPx+f9eTAak+7/Bn48HnR/ucqaLhU9Lo4sCfSsCX/h4PqEybs790tSjyVS+CdXZglsbDu1kJneYm9jhZCYmbXAy0AXYm88T3mDn6w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(35042699022)(82310400026)(376014)(23010399003)(14060799003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ndnX5Ax4QDN1XT02jFe+CrR9m6S/rOQrxSqm0J6Pnotz7y7W2QLCb1JVqKearAr+V20D77vwIDt9fFt9FylbQPNDC6H6okzK474VrqQtslwaZRbSPQtKDMHV26EY1ugqNFQ4gzR3wnO3spLBH+bzNtrFiTuyNZBUNt1GF0c/IUxNzEM4RmekrKCjrZMNWkTCNHw3jbGTeNlA98N/3TlcI+t5j5zGkfni4ccwYxr466mrgLLo0Z2M+vb+iV6ZdH89kKsWe0US82oKAgIksV5gLl24tmuE0plqx8kNR57LfW7vbn1VxBDCwolBLom86SttnI04e7hjwX/HHx4OyMo4W/+luzxMIWqF8AhUHY3aan5H/uUCSr7+P+Zy7Q5GdW49i+ufjPHOdcedQiv5HKKmkGjIBgcO4O/R1cZ9YGZOm3IV9JRxQeimDXDo0W7QBret
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:23:56.4155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76d936f-82f4-4c7d-22f6-08dedd04ed5d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8876
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305866-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lists.linux.dev,redhat.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jasowangio@gmail.com,m:virtualization@lists.linux.dev,m:mst@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:eperezma@redhat.com,m:nd@arm.com,m:enrico.zanda@arm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enrico.zanda@arm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:from_mime,arm.com:email,arm.com:mid,arm.com:dkim,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.zanda@arm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7617728406

From: Enrico Zanda <enrico.zanda@arm.com>

When vhost owns the virtio-net header, i.e. when
VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
meaning that no header will be forwarded to the TAP device.

In the current vhost_net_build_xdp() implementation,
when sock_hlen == 0, the gso pointer can point at the start of the
Ethernet frame instead of a virtio-net header.
This results in a wrong interpretation of the destination MAC address
bytes as struct virtio_net_hdr fields.

This can, for some MAC addresses, trigger -EINVAL and return early
before the TX descriptor is completed, which can stall vhost-net TX.

Before 97b2409f28e0, the gso pointer was set to the zeroed padding area,
using it as a synthetic virtio-net header. Restore that behavior.

Fixes: 97b2409f28e0 ("vhost-net: reduce one userspace copy when building XDP buff")
Signed-off-by: Enrico Zanda <enrico.zanda@arm.com>
---
 drivers/vhost/net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 77b59f49bddb..3e72b9c6af0c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -731,10 +731,12 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 		goto err;
 	}
 
-	gso = buf + pad - sock_hlen;
-
-	if (!sock_hlen)
+	if (!sock_hlen) {
 		memset(buf, 0, pad);
+		gso = buf;
+	} else {
+		gso = buf + pad - sock_hlen;
+	}
 
 	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
 	    vhost16_to_cpu(vq, gso->csum_start) +
-- 
2.43.0


