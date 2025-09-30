Return-Path: <netdev+bounces-227310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD77BAC2C5
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B573177A75
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79B2D7DDF;
	Tue, 30 Sep 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="R/H/MtvV"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F801CF5C6;
	Tue, 30 Sep 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223128; cv=fail; b=luAvOuA27w0IHsx8RTvE+nueqHE/5bfTyel2NvXjpH/SzaksDIt4YmFjfyeWO0FfmKth94U1YxK4GDWV0lJYZ4cHDLlu3x6I5hqTjYalgj+dKPsjpDKSCfHM7DnRiouWA6YY+PJAUWPk3E4ZYXv788/QdHQpwoboCkMSkywccYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223128; c=relaxed/simple;
	bh=FdbEXm1abrBCZ03E7qiLwGGB9phbsxYlE90ztzLaE/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hRmhhOnsIBV7aFoxdzHf5iez9avbk6mJIbU8Y+3H9YY3zL3cBJUr0NkT+I1b+ndTYsOVfASAWTdL3jfrC2gKBhiw+5hRmlr/4/56oK7+dBwEZJUp1PPWUtR9ZTZBkErQWTWlZyhJrAkMm/e6nHDnkQP5ma6lnA8MeWZnK2RZKZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=R/H/MtvV; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8nitU017446;
	Tue, 30 Sep 2025 11:04:42 +0200
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49eu6xgsf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 11:04:42 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+UPR9jwMSuID+Z4INnIXGP+0gUgVDF/m4PdQ9tKygPQVY3aRsZjnnV4+vw2mNTfP67EI5dGL2s8QPEbcUBpKHj4UJ/WmfQzZrOvcf4bIZ6PQLZnP5yACpV1hXSFlvVctlb+UVhKcAq24POYTNdAGsBxM46ZfMhbjbnr5NLfX8dAWzuWwThSNxc38Q/jhsyr1XfvkbK0tRo7n7094H741jrNh46iCpy83ign0AD4MCY7f02ZkQ+B6g40lUq6E3FepOqFqkVqqGEjtPO8Z5FtJ5Ngm26htLFWzEUb7k8baHWQhbqL0GQRQ74PSgge9BJzGZFyFXiD7EVQU93J9KD9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdyBL2TLqZrEIrUBB07NRc9zunEktSnF/PT3Vu/CgBM=;
 b=Saqc0N9cIzuyoT+P0UHiJWCpznTYh6I/1+udaFa4flS5C5Qf2kcFyFctnbYV39ZOrdkCOrDaazjWf7iVAgcboJzT5w+1Pd+/E1DH26agTZvJDimWRjRJDqJGu9K0VSTUqwMOLdvY7b/SLDN7RSeJgzXstjIey+xLGhGOqca9onsKEq8C7NNW1Y8xdj4n4sM0dxGPiUo5O/syLqU2x947ueaaIZaHezm6g/VKoCkGCc5sXfjYUyHt0wy9u7Pk//uqHYPpMD4womg1Rqelj0zJyYNV4qHPUCCFMkZfZSdVTs/Hj8ayf6svbuwrMSI76ieK9bRl4xopb8WbP8H/qWIOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdyBL2TLqZrEIrUBB07NRc9zunEktSnF/PT3Vu/CgBM=;
 b=R/H/MtvV9YWNRWIzfRvpFy7GuVytkBXHdRi9XM6VODRiyXqHLnRiDHPquyTKI3LoKy8bxkqxPtEOmzV+rmnN4pqka19w2T7PtTVZ3ZuSdSsyZqVZuY9VroBNmR04I3Gr+3BiP84DLc4gwNiR3FyS6RGdOuY5wuJqWRcXrc0WrKwFWfsEanxAsRQ61hZQGsLgKweeEJfvp/eq4wlcMSXZwU/1+APWpY2LCbUaiIsdAK8n7E4q/DQv/zDHbL27H8Pa+drrl/dpND3HUwb7kU/WINBEMR13inWxQUCToTlidQhFVFnIwylRNgiivw8iiGZ/9ajs8cEyqUJpnUSKXdw9Pg==
Received: from DU2PR04CA0252.eurprd04.prod.outlook.com (2603:10a6:10:28e::17)
 by DU0PR10MB7336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:04:36 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::7d) by DU2PR04CA0252.outlook.office365.com
 (2603:10a6:10:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 09:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 09:04:35 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 11:02:18 +0200
Received: from [10.252.21.196] (10.252.21.196) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 11:04:34 +0200
Message-ID: <2e23535f-f0a2-4111-ae64-6f496a72f27d@foss.st.com>
Date: Tue, 30 Sep 2025 11:04:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add phy_may_wakeup()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "David
 S. Miller" <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Simon Horman
	<horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>
References: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
 <E1v2nFD-00000007jXP-0fX2@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <E1v2nFD-00000007jXP-0fX2@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61D:EE_|DU0PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: ab77962e-b263-48ed-1e50-08de000060ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHBaZWsrem1nRmEvaDhRYWVIdHR5ajdDSk9SVldpMmJpdjZzemNQSkZUWkV6?=
 =?utf-8?B?LzhySExXaFBZSmtkUVNmVFFQZlRkUUh4bWlwUkowajBna0s3RG1xQldnZVdV?=
 =?utf-8?B?eGZ6ODcxL3k1MVNhUEFRbkVhejIvK2djQ1NzdGJkQms1NFUwWUY3d3lScGxI?=
 =?utf-8?B?K1l0d2ZkZzhEZzZBL3I1WTI2YldTWE9PbnREbVN5MHhHMmgrcGZHdjIvbDRM?=
 =?utf-8?B?d0IzUEc1RmNIWDFEMk5UeDRTR092VzN2eUdmV1JCejNtZlF0K05mMWlUK2Y2?=
 =?utf-8?B?L1lKMnBDOFh3RmNtWUM2SUNVTThpWGg3ZzhOV1RWcmxiMlIwYVl6K0NQZTZa?=
 =?utf-8?B?RTg5dHNiQUxxUTRqSHhmcEpHRENMMlZ0SzhUSmtPa09aaXdtTzRrM1hXVkxG?=
 =?utf-8?B?bGNEa3pHMFBrcFJnNmkvNnRGZGdJNGpVOHZ1RXZjYWNxS0ZFcWl6OUwvSmU1?=
 =?utf-8?B?WnRKbEVlUENYM0l3ZlpyNjRiUnIwRnlOU0t4Y3VIR2toemhjSEEyYjFVQnBx?=
 =?utf-8?B?eC9FV3YrNlFvSldadGJtVzk0eGdoNkFzQ2xUL25sSDM1NGg3U1B4alNBQlRi?=
 =?utf-8?B?QVU1ZXdSMVJyQlR2eW8wRnNOSjFibU9TaDFjTmN2K2JLSGc3NldOUHc5TXVS?=
 =?utf-8?B?SWN1dmg0RkVTeWxkUy9xNnlFTU9GeEpVanJJK3FMSFlvZjlzWGV5c3l3Z0x4?=
 =?utf-8?B?ZCtOeTQwcTVSbzE2eEJESk10aVF3SWw2MEZnOEI5bW44bktQcjhldlNCSnZj?=
 =?utf-8?B?Ri9JSm1qbnN3c0xXQVZUVzZWem1VeUw1bXFzVkhUSmp6UDl0cmpiNHdUUy9V?=
 =?utf-8?B?ZEJPVWhqTzNMNWt6OHQ4eEtKK1FZZUllcXZPNGJENE05eXpzY0NYTUFhVWJo?=
 =?utf-8?B?bVNoSEtUbmZGRG9PSksxWURTQk1yc3pwNkhoTzVaTXlZN3hhaUhlMmZka0Zv?=
 =?utf-8?B?TUxJZ2J6bGM5d0JRQ3UvMDBaWktTdnlYcEZ2dXBRV1NrL2RXMmFPVGVDajQv?=
 =?utf-8?B?R0MwL2VmTUN4bzIxRmk2TVJCM3hyeGRyVy91WC8yYVBXYXZ2MU4yejNncTNY?=
 =?utf-8?B?eEFMQTd0ckJnQlBKdWFmNlVuNnAyd0NhOThPaGVCRFNNYmNpRVlKOUQzRndM?=
 =?utf-8?B?VDdnVnNiWUkrVWpRVDdRMnVWY0hIVUZEdUNiTXRZTlRrdjFnaHhaSjFLbDVi?=
 =?utf-8?B?ZUxVV0dmdTFsd2R0QStDN2dOS0g5NXRCV3Y2ZUJ5Z3JBbG9GUjk3MWRFQ3Fn?=
 =?utf-8?B?MEZvYmcwQkpoL3dOOWJsSzJ6c0JYenBnM2VWbjVNb0ErazRHbENVVEFIY1V6?=
 =?utf-8?B?ZWkwdnNMMnE4T2ljRmxjRFlFc3d0QnZGMkNxMFkveld0T2I2UHQxQTZRekdL?=
 =?utf-8?B?WUhRd3dJMGhNNkFZSTdlUm9MTXdvRVJYUG5oZUhqSytnSm9OUjV5SXlBaDhN?=
 =?utf-8?B?Nk9BMGxwbVVvT0dUL3hHdStBMkczdDNRVFhqZ3UzVXJLVkRZZzBLdzVHU0NX?=
 =?utf-8?B?OVdtRmVUbEg1S0Fsancxbjg5UkxXZUw2bi9NblJvRlMvSStwaUVzSlZTajNk?=
 =?utf-8?B?M3hPcGFweDNVL1BUSUdOSmpWcDZqRDlsQjE4RGw0bE0xK0JIZTVzNEY1MXZx?=
 =?utf-8?B?cWtoZGdHTjVpb2lwVzNib0pYelkrc2JVVTVYWkhRZGFheGJ1WHFuUXNLeFNB?=
 =?utf-8?B?UGFDdEJyNDJFbGRpbTltblBQTmZRQjVjN2VLNkZwYXJZKzIxYzlQbVlWMUpn?=
 =?utf-8?B?QzVKcWloZDVvKzZjZEduS0VvZTUzNEpUdExrZWRyWGxaejJxRXFqdmlJMW1j?=
 =?utf-8?B?VDd1VkFnV1R2ZEFOemZycWxQQ0dzMFA0SE5pNVBRRFNvT244WTl2bHpoUzNJ?=
 =?utf-8?B?TFBBYzJGQTBZSURBeTh4L2lvWCs3Q1oxWDFVQStlbFp1SkFvNVEzUFN6Wmc3?=
 =?utf-8?B?UjJxU01rNHdwU0tyQU4xRmFvam53aEJZU3NoQk00Q2xpMmZ4R3dkbkgzNktx?=
 =?utf-8?B?T0g2SmJmUENuVjhKM0lBa1dnWW1jcFB1bVQwZmR6c2JubWZEQmpsVXhwbGU5?=
 =?utf-8?B?Q3MxT1VDQVNYREZIL0NsUjhpLzZsWDY4UEtRNXo3TlIxVTJKTk0xalh6Q2lz?=
 =?utf-8?Q?iCzw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:04:35.9132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab77962e-b263-48ed-1e50-08de000060ff
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7336
X-Authority-Analysis: v=2.4 cv=fOk0HJae c=1 sm=1 tr=0 ts=68db9d2a cx=c_pps a=C6zU/Za3lUHRbVusphFing==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=bZacASX0aO4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=PHq6YzTAAAAA:8 a=YL9D9Psk-rNFDlZyr74A:9 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: OExFlbHry3p__PLQZfodN9nFWox7oj4H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDAwOSBTYWx0ZWRfX9tZRzSd5jBWv IuxCaUepv20040dRlF+6x0tqCWl5v7ib8OJFsJHjNe4mrf89L8zUejSSnCZ9yS2fA/uMekQjcgX ep+a/1+x0/Yj5r2zuTKMRoWVWXQ8lk2+jAkvggPgFx2TZSwO+MsM4MVXPOlbbgosDSPGpUn0MQP
 I7WG7HgRnvcR9ki/cqO8LUBHrXx5zjcCVUycY7iIFMcXeXMRquZg/BEPEsMkISmgqxCYmHtHfW0 w3rvocl/45NktAF0DOW7gQ67CwSHs6QRY2WpBq1rWmlJMldHVcfuk105ouBKh41UjW/YGq3C2u5 LXWoq5/OYeI7k8mvlnKWg3FV2NmvFc/FgOjBwv6OBE/hbXw/E8q1JO5ahd0tqhEshtRwXelFyqa
 khwHibdG+CnibjtvjkzmZI9F9Q7lLw==
X-Proofpoint-ORIG-GUID: OExFlbHry3p__PLQZfodN9nFWox7oj4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509280009



On 9/28/25 10:58, Russell King (Oracle) wrote:
> Add phy_may_wakeup() which uses the driver model's device_may_wakeup()
> when the PHY driver has marked the device as wakeup capable in the
> driver model, otherwise use phy_drv_wol_enabled().
> 
> Replace the sites that used to call phy_drv_wol_enabled() with this
> as checking the driver model will be more efficient than checking the
> WoL state.
> 
> Export phy_may_wakeup() so that phylink can use it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/net/phy/phy_device.c | 14 ++++++++++++--
>   include/linux/phy.h          |  9 +++++++++
>   2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 01269b865f5e..4c8df9f02eb3 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -251,6 +251,16 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
>   	return wol.wolopts != 0;
>   }
>   
> +bool phy_may_wakeup(struct phy_device *phydev)
> +{
> +	/* If the PHY is using driver-model based wakeup, use that state. */
> +	if (phy_can_wakeup(phydev))
> +		return device_may_wakeup(&phydev->mdio.dev);
> +
> +	return phy_drv_wol_enabled(phydev);
> +}
> +EXPORT_SYMBOL_GPL(phy_may_wakeup);
> +
>   static void phy_link_change(struct phy_device *phydev, bool up)
>   {
>   	struct net_device *netdev = phydev->attached_dev;
> @@ -302,7 +312,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>   	/* If the PHY on the mido bus is not attached but has WOL enabled
>   	 * we cannot suspend the PHY.
>   	 */
> -	if (!netdev && phy_drv_wol_enabled(phydev))
> +	if (!netdev && phy_may_wakeup(phydev))
>   		return false;
>   
>   	/* PHY not attached? May suspend if the PHY has not already been
> @@ -1909,7 +1919,7 @@ int phy_suspend(struct phy_device *phydev)
>   	if (phydev->suspended || !phydrv)
>   		return 0;
>   
> -	phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
> +	phydev->wol_enabled = phy_may_wakeup(phydev) ||
>   			      (netdev && netdev->ethtool->wol_enabled);
Hi Russell,

First of all, thank you for taking the time to propose something.

IIUC, using ethtool to enable WoL with, e.g: "ethtool -s end0 wol g"
even if the WoL isn't really supported will prevent the phy suspend.
Therefore, PHY drivers should be adapted to implement something like:

	if (!device_can_wakeup(&dev->mdio.dev))
		return -EOPNOTSUPP;

in their set_wol() ops to fully adapt to what you propose, right?

>   	/* If the device has WOL enabled, we cannot suspend the PHY */
>   	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 7f6758198948..2292ee9a93c0 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1391,6 +1391,15 @@ static inline bool phy_can_wakeup(struct phy_device *phydev)
>   	return device_can_wakeup(&phydev->mdio.dev);
>   }
>   
> +/**
> + * phy_may_wakeup() - indicate whether PHY has driver model wakeup is enabled
> + * @phydev: The phy_device struct
> + *
> + * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
> + * setting.
> + */
> +bool phy_may_wakeup(struct phy_device *phydev);
> +
>   void phy_resolve_aneg_pause(struct phy_device *phydev);
>   void phy_resolve_aneg_linkmode(struct phy_device *phydev);
>   

