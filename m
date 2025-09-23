Return-Path: <netdev+bounces-225511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FDB94F02
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884D116C72A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729423191BD;
	Tue, 23 Sep 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CD/Ab+36"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00C30EF7C;
	Tue, 23 Sep 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615107; cv=fail; b=d8NppxMOxg26cqXNYjfAnCojn5r3kMCKW/LB6TB9YE0q1esVsKTqyzEE3rF+lQ7YpXFU1zOsNuYrcYimvpqRlK/q6VtZXdTPJ3ozbzKRXWUQga7IlRrH8uZpTe7JB0K7piaZSDQ0eHLb/T7yd7H/LjKZCzS3LWK0fOWf/uzkFw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615107; c=relaxed/simple;
	bh=43BAcB3X/hn87BSPSiYD6jybCgVJmBLfqMfocQyYoLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tJSIQblJ96c46PJUk+ipLodRrpdSDtpxNIl2DdGSlL1N3kQB6I4+cXFPn8TK5QRbxf+00+V559U0apaCFLvZ8Y62Z5SkIuPaf5+a2p1QHtHgKjZen4ahWpIDe+E2CawEwD+dLiviY5/S2E6+eP2N/OT7bVIk5AkhtZii4QDVzjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CD/Ab+36; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N7HDHD031289;
	Tue, 23 Sep 2025 10:11:15 +0200
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 499hpgmm5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 10:11:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt71HLtx5qRXPt9rzID0WgAi1a3/4BU47fXFdse5a1sB6UtUwBdl9EZoDJwaXUotVyAi6pHTWnAYe1b7R3pkmy491HnmDn+nf8WoU9MVi8ab/ALZ99QeMS/EWvqwdvRcEzG7tV+cgSYaV7WCa8Ok95d92qKADj/V/1MDcU8b65Rm/+PUqLofMEY0nxW+XNTTsEpiHkHHrllAC5hnAtbEhq9CX1AJTka8+tlO6y6EaNjz/CJF+6Kevyb+PA63rVU2EKBIWgZrtUhvDvS4psAyPvLZQpjoYOjPb7OrLmdCr67PRJWrovOVV3WKjtvO5kSWBwmWxfEZl0Glb3Ayb+Sg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwBhvZiB43RK8oL9dmK0dt47rCw1E8NMx3f/Ba93Wr8=;
 b=Dz53olFEUOj7CJVScLL6uknJPMI8NblWHMjb02m3t2O1sUxdsIh9wzIbiC8zXnlXiofV03iqCkSB+/a16QdAtlJKSk0L7PSukGEKrsffk2FnMOOQ9aZxBmHfQQxJDagMMdApmIKzfJQiDa0FFKwL0KwUi4Enpt8XYSNacO3hCseJsU8DmlDCQv2PVfo4Q9Mi0YTbw+kh1FSmr2+Q7FG14GRkEY0latBsVWoOab61YuiabpZ8z9iQyf1Vax1MMgQd4VCeBzOLctEaMp+iy0B/Ok+L8O5njqOwgADY6Ppmi+Oef0WEmXxmINtO5V7TVG7vGztSPsSn29WO8s0qVTz17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwBhvZiB43RK8oL9dmK0dt47rCw1E8NMx3f/Ba93Wr8=;
 b=CD/Ab+36ztrFAu/eBgvtpxEkn8n2OfmTqAZYNnPtVF7EFbqVfsJYIeM5s5y44EXBh4Mw+qiBCuzeLjnu57bHjf4LQPeHXNUNSv8CcoYCQeAv+dyw4/euZ+YCL7wgAXiXhqEhiIN6NKQ1kPvJRQcVkwHihUKTYM2oeesvKIXngx4xPSmCabRGPhbmjIDhZGLu9Q1oAHhSVM0AgqgtNMXTlEd4B522zJtapcpvJsIL1PCzaz8u9hBYWIOZvMQ2l7O6Vx7fPUS8baTU1pj4fD+lp7ZxYXY8nIMO0r08CnxViZ5ntBKGZHJZ4uRkKJJR3FKJ78z0h88H4CSIzkUnk7GIsQ==
Received: from DB9PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:10:1db::22)
 by AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:11:12 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::ea) by DB9PR06CA0017.outlook.office365.com
 (2603:10a6:10:1db::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 08:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 08:11:12 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 23 Sep
 2025 10:03:51 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 23 Sep
 2025 10:11:10 +0200
Message-ID: <64374318-f11e-4d02-9841-31ab60a97763@foss.st.com>
Date: Tue, 23 Sep 2025 10:11:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Tristram
 Ha <Tristram.Ha@microchip.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <72ad4e2d-42fa-41c2-960d-c0e7ea80c6ff@foss.st.com>
 <aMwQKERA1p29BeKF@shell.armlinux.org.uk>
 <64b32996-9862-4716-8d14-16c80c4a2b10@foss.st.com>
 <aMwnCWT5JFY4jstm@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aMwnCWT5JFY4jstm@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|AM0PR10MB3331:EE_
X-MS-Office365-Filtering-Correlation-Id: f78f0cde-f370-45e2-5202-08ddfa78c28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0tidDQ5Y09mZVVUdTM1ZG5ZM2VIdzZPQngvYm04OHY0TnZhdUlGWGhrNWM2?=
 =?utf-8?B?M3hINHFMb1lkbjBmNVhGRmoyK0RmamlBRjE1N2h4UjFYeUE4aGRSOGthcWlv?=
 =?utf-8?B?NkFpbVpCeFFUVzlSRzRlQ0Q3bWtvakh5N2JMbjlDVHBrTGplbXNrb0tYK0dC?=
 =?utf-8?B?QlozRzgwbFZhdmhaTXloUnY5ZGY3TGdxMjBRZXV1bzhicGpoc0kwclhhOE8w?=
 =?utf-8?B?cDY5SEE0S1F3UlFhZGNHQzZWVjd0WUU5bGwrblFFQURRcGVxbGFUc2RwSm1E?=
 =?utf-8?B?RnRSbFNVL1ExUVdoU3ppREI0MDZkQm94MTVGclQ1Y3RReGp2a3FsOVJzQ2ZL?=
 =?utf-8?B?a3NQZTEwZ1p6YThBMTZGbkVJT1JPSTFkdnlocmNhZzRwejNqS2F4UW5xOG8z?=
 =?utf-8?B?N0JGY3NSV2Qyb3FoTHc1cWxRR3lucjY5V25pRVh0WlJvZ3g3VlZlSDVHWWZT?=
 =?utf-8?B?eEQwUWViSUdyUVoxajY4SUc5U2trVWVPeTJDK2xNclNOMXEzb21nVTU4eWp4?=
 =?utf-8?B?K2ZEWmF6cUNmVEQ4dm5FQTNtb1pJWHRWRk5OS2VsM0F1Y2Z3N21qbUhmUzJ6?=
 =?utf-8?B?QlgvazZLeWxJaFBxWGFneFlHU25WMzJRT1dmekhFS29Scm5GcWU3QjkzTDlP?=
 =?utf-8?B?dXRWS2ZLOWh5cDRlVW9OOEplRjhaSFQ0QWdZVnlDVHNQTDdSak12QzhVNldW?=
 =?utf-8?B?Q2ljQ0kybWhTckxBWkdvdmZJbUJ3WTRJZ1NzNmoyVjl4S2txTHZPWVEzRDlh?=
 =?utf-8?B?dDBhU2JIM0V4dGg3RFpLTEtuTTZJMEovdFYyQWFZWmJGeURRa2RLNTZqSm83?=
 =?utf-8?B?a1R2RXAwTzlVank3Sm1PZFk4OVE3TmJrZlVKazBCcWlYUHNZMjJmV0hFZmtQ?=
 =?utf-8?B?aWREZnpwd3VyNDJrQzBrOU14eGxiRGVmWjBHenFyb3d6Rms0Znhzc1RPUm15?=
 =?utf-8?B?eUhkK2lIeGNRV1ZoZW5ianZiTnZWREYwQmtNQXIxZHp6VitBOTV6TWhSZzFn?=
 =?utf-8?B?bkttR3ZCUk1NN3JSeEJsM1Z6TVlVelJSMHRlRUF4OGZDZi9LWEZ5L0w0VC9w?=
 =?utf-8?B?WHpMNENNWGVnRXpremxLUHJWTUprVW1Ma1RjU3VxeEplbjEzbUloSTNsQlRm?=
 =?utf-8?B?QmowWG9EbklDUkpJNGNFZVpoTFJUWTdSRzVGdUhIM2Rid2lKK0ozcGF3OTFO?=
 =?utf-8?B?cGpMOVloSVg3ZC9jLy9JYm82T3NxNXJmdzBmNkVNODhkT0lOWk1jUnA4Rjlm?=
 =?utf-8?B?ZSs0M2Vqdk9FdGdMeEF2czhUeVRnQTNsSHdoZVR2L0tJZ2VubEJNNkN4QUNR?=
 =?utf-8?B?WHBnWDBlUTVGSnVpdjgzdU5meDRmQXU5TW5JSE1TU1g4a01BWnZhSXhKQTFT?=
 =?utf-8?B?Z1h4eDdMOG4wcjV1NkF3b0xLR2c5RjhtSGRuMXM4amRLcDZtMkY5MkNzWHBS?=
 =?utf-8?B?QkoyT2dDZlV0OXdqU0JhYVV4WTc0SjNQdW1lYUJNU1V6TVdnSkNhR3paTmw1?=
 =?utf-8?B?R3NJVDd4cmN4cFBNM2duanFXMGFSQ0dzVDZYcm1aU1p3WHVZUk9Xb0V5V1cr?=
 =?utf-8?B?WitTVm9GY2NnUUNMNFN4OHRpcXA4RVBkR1NvVURqL3dqU3E3QTN1RUxLbE1J?=
 =?utf-8?B?YVFyTEtObG01aE45bHlsZEpLRUhENDBXZHhVZGpvWjhWT29HUGNvSjFPT211?=
 =?utf-8?B?L200QXlvU0RTUHNwb1l1ZUdRWHF0UmVOWlNWUWlydXFDUzhmT3ozVTZsSHp3?=
 =?utf-8?B?SWxIb1dqbmNkVlJBcGRQZ1ZOQnlCV0ZlRzYrU21OWnIrSldrdHRBVkJlVG0z?=
 =?utf-8?B?eDd5c2FTZDJubWV1TktRMy94UFM0RE1BcFYxd3VqMURFUXYzUUxWN3VUUWdG?=
 =?utf-8?B?bGdmQ1NIVk1tRUtReHZFUmNrSURiWGZUOHRHU0lYcG5JaHp5dHZ1eDAySHhM?=
 =?utf-8?B?WThFcStCTFAyWTlhSUQvWlRwRlRCZFEwOXhJbFVJSEF6czhnd0tMQzB1bDVn?=
 =?utf-8?B?YkJPem9WS3F6ajZiVXJyclRMV2V4djRqazVVaURuWS9oMDF4dU9ZSk5tUjlC?=
 =?utf-8?Q?KZb85S?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:11:12.2169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78f0cde-f370-45e2-5202-08ddfa78c28e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3331
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMSBTYWx0ZWRfX7ko80snAg5Y2 qaW30j3YWnjbw4Lu0VfAoJz4yAhy3+llQBHCK/SOBQycRNg5o/y3M48ulb2dVH8XwzlHkWF6iUJ i9bUpVZXJJSZsw+5cAermcHfc7XmkOBlpVmccp+sVTQd+OH3rt6exDr18nA2ene9jsKYcXO9Fht
 GXj0NbKPjM2d5dg+ujqJ7hjBT5KKQWz6vuoT9Cyc4Gtk3rshybNWGEeFdQkBepHNJCV0mDeestK i1U3yXP2aiZVQKHtUTr+t2I4++HjT50bajbaC+4b9efw4T4+n5GOHriHYDVIoRUk/QNRcBS9XR1 vPXXy+M0FWdFy4xsOk7lWMyhogSIQNrmORIUTQRip2PwL/vNymt1NbacBB9pCvJD6P1HfM+qGhk I1/2TA4p
X-Proofpoint-ORIG-GUID: knBOxXk71hxkGghKZMY8jplHdGT31BuC
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68d25623 cx=c_pps a=r3amAyZnyFs1+HRFMa/lSA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=NQGlzXKa162JxgxB1IUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: knBOxXk71hxkGghKZMY8jplHdGT31BuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200001



On 9/18/25 17:36, Russell King (Oracle) wrote:
> On Thu, Sep 18, 2025 at 05:07:00PM +0200, Gatien CHEVALLIER wrote:
>> On 9/18/25 15:59, Russell King (Oracle) wrote:
>>>   > So no. In a situation like this, either we want to be in interrupt
>>> mode (in which case we have an interrupt), or the pin is wired to
>>> a power management controller and needs to be in PME mode, or it isn't
>>> wired.
>>>
>>
>> If you are in interrupt mode, plugging a cable would trigger a
>> system wakeup in low-power mode if the INTB/PMEB line is wired to a
>> power management controller and the WoL is enabled because we're no
>> longer in polling mode, wouldn't it?
> 
> What Andrew suggested, which is what I implemented for Realtek, other
> interrupts get disabled when we enter suspend:
> 
> static int rtl8211f_suspend(struct phy_device *phydev)
> {
> ...
>          /* If a PME event is enabled, then configure the interrupt for
>           * PME events only, disabling link interrupt. We avoid switching
>           * to PMEB mode as we don't have a status bit for that.
>           */
>          if (device_may_wakeup(&phydev->mdio.dev)) {
>                  ret = phy_write_paged(phydev, 0xa42, RTL821x_INER,
>                                        RTL8211F_INER_PME);
> 
> This disables all other interrupts when entering suspend _if_ WoL
> is enabled and only if WoL is enabled.
> 
> If you're getting woken up when you unplug/replug the ethernet cable
> when WoL is disabled, that suggests you have something wrong in your
> interrupt controller - the wake-up state of the interrupt is managed
> by core driver-model code. I tested this on nVidia Jetson Xavier NX
> and if WoL wasn't enabled at the PHY, no wakeup occurred.
> 

I'll replicate what you've done for the masking of interrupt when
going to low-power modes to the Microchip driver and see where it takes
me. The wakeup occurred because I didn't mask the other interrupt
sources in nINT mode... :)

>> You can argue that as per the Realtek 8211F datasheet:
>> "The interrupts can be individually enabled or disabled by setting or
>> clearing bits in the interrupt enable register INER". That requires
>> PHY registers handling when going to low-power mode.
> 
> ... which is what my patch does.
> 
>> There are PHYs like the LAN8742 on which 3 pins can be configured
>> as nINT(equivalent to INTB), and 2 as nPME(equivalent to PMEB). The
>> smsc driver, as is, contains hardcoded nPME mode on the
>> LED2/nINT/nPME/nINTSEL pin. What if a manufacturer wired the power
>> management controller to the LED1/nINT/nPME/nINTSEL?
>> This is where the pinctrl would help even if I do agree it might be a
>> bit tedious at first. The pinctrl would be optional though.
> 
> I'm not opposing the idea of pinctrl on PHYs. I'm opposing the idea
> of tying it into the WoL code in a way that makes it mandatory.
> Of course, if it makes sense for a PHY driver to do pinctrl stuff
> then go ahead - and if from that, the driver can work out that
> the PHY is wake-up capable, even better.
> 
> What I was trying to say is that in such a case as the Realtek
> driver, I don't want to see pinctrl forced upon it unless there is
> a real reason and benefit, especially when there are simpler ways
> to do this.
> 

Yes, sure, I think there's a proper use-case for it. If it's going
to happen, I think it would need a dedicated P-R. I'll send a V3 in
the near future addressing what we discussed here. Thank you for
the feedback.

> I also think that it would be helpful to add the wakeup-source
> property where PHYs are so capable even if the PHY driver doesn't
> need it for two reasons. 1. OS independence. 2. it's useful docs.
> 3. just because our driver as it stands at whatever moment in time
> doesn't make use of it doesn't mean that will always be the case.
> (e.g., we may want to have e.g. phylib looking at that property.)
> 

