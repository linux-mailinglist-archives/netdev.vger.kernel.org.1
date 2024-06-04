Return-Path: <netdev+bounces-100462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3248FAB8F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DCC1F256B0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFA13F45B;
	Tue,  4 Jun 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZZRgERCn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850E13E888
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484926; cv=fail; b=LSQC/4/8QVRKQqFTUGaukZiwstvPsJt7O/CEYSiCW2dRg/WS0ZY2Yon5aUQuBgfg6jNd2rQeqnNEksElfaSNaWQYNYVf3p3iXmsHrUVFeajRh2CI+fEpAQCOaCDl1uGaf6sEwDxOHVZ3XkOGgLnfVkHIjBZ5xvzp78VJJUPbQPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484926; c=relaxed/simple;
	bh=DH55SOVp0Xqx92zWAvkwjAOxu10yLf3k1eqY7ImtMxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2NWWBLhjjzuufrDL78TZAVjnLxiPYdVSyQgaAX29d96JPeYEKqZHHWZfB28j2z+cHoMcoYWK76Pn9d8zcEWPE3m4Ok0MDDw/alSllPFmMkYtKBwGn+oqyGq+iY+iIqzeEV7DhiIlzIdVRCn5SPMMP1csbyj7qVPULdlCEH17v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZZRgERCn; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4541hsC9002975;
	Tue, 4 Jun 2024 00:08:39 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yhsh5ruwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 00:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT43QfD+0B6sOcHrivtSkj4djN8p0FeO+9XZ4XI2W5tPZL5kszqx6cCv53yjrdAclQCB9oORHuDpukFIYfLouV56KWsiA3Mvc1VTpLGNQZnItakulUL4wMLSi2GXhSlI3ITmcf+M8Y729JXCWP/QcimtyL0lDEh0A0vh4UQZnw4IIIx3BlaUlZnq1XGk3iUWJZJa1oNkPT9yjMcbeY1BekPIoP8OuwAcnwuwc83asE8WPK0IfJUUXNQkZvPy+tLJiGcMuNdgOKZvaXLs+WNOdTgv37gFbGwTBsX9udWPcQvr5MCCh/56+ZZHxYkDf8lbVrW9dy4hdzLW+pv0KwE9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH55SOVp0Xqx92zWAvkwjAOxu10yLf3k1eqY7ImtMxU=;
 b=U16lUPNZ6W1qZyqECO3fNFhsvncQPOVVK1CmTtKrO5RYCFQdwoxE7Gbnshvdh4MiOvmURVLLpoO1bVqXi8GANygcb2wnTyyE3D46XSArQmMeH+t1630n4RRZGUV468QjB7ySgY7SVl3mwmbGEcNb5qi8fzAfG7GUNAfdAYb8+ar5ImwUWa3FgjJsbTAkP7hXs51VnrQpO90n73XB2Wl3oZcdf2LfPR2nOPLd5SLlLri2QxeCpIFhCfrssgJqEggRbJ08Fwnq757trsVzVTrNRhlBXtfZf7uvDoei09ThJaYVDTtqxikSPy0ZkeuM2/3zPrjPnArnelQMFa5xXAq01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH55SOVp0Xqx92zWAvkwjAOxu10yLf3k1eqY7ImtMxU=;
 b=ZZRgERCnJPDEBkysxBW3xJh1/BVinOMOroGCTWpS925OUckkvNhtFSJ7RBOgHjwcLdAlC9ubN+pVx+bANi178BVha3Kso3TNVhcV8i6ZUgcETvSizQ/7EoK0xA2eZfXn4yf/MdxDR609+2l9a2gcBVBwFe6ckjJWitd68NF7Ogs=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SJ0PR18MB5110.namprd18.prod.outlook.com (2603:10b6:a03:439::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 07:08:35 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 07:08:34 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
CC: Sasha Neftin <sasha.neftin@intel.com>,
        Dima Ruinskiy
	<dima.ruinskiy@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net v2 6/6] igc: Fix Energy Efficient Ethernet support
 declaration
Thread-Topic: [PATCH net v2 6/6] igc: Fix Energy Efficient Ethernet support
 declaration
Thread-Index: AQHatk4D/gOlqjsn2U2K/zC61upG5A==
Date: Tue, 4 Jun 2024 07:08:34 +0000
Message-ID: 
 <PH0PR18MB44745F4BE9093B23E9A59864DEF82@PH0PR18MB4474.namprd18.prod.outlook.com>
References: 
 <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
 <20240603-net-2024-05-30-intel-net-fixes-v2-6-e3563aa89b0c@intel.com>
In-Reply-To: 
 <20240603-net-2024-05-30-intel-net-fixes-v2-6-e3563aa89b0c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SJ0PR18MB5110:EE_
x-ms-office365-filtering-correlation-id: d9cf799a-8c4f-4102-d22d-08dc8465261e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T0o2RjNPaFlOQVluYk56N3R2c1diWkp6a3FlMGtkYk9zUmp3ZUgvQ3BDRjlk?=
 =?utf-8?B?TjQ1RmoxangyYXpqbjdqUk1DYTVWaEYxVFNCZHhtck1semt0Y1cycWFWWnlh?=
 =?utf-8?B?UGx0OHptb1pWSG1zbi92TytxMldwVzNSbHpOVlZCYlRUZjE2azJod3BFZkJs?=
 =?utf-8?B?aldiMlhJUklhL202TTVBTWZtK01kSTZtdE9HSFM5NTJBZ3dydzdEY3Axcjl0?=
 =?utf-8?B?ZzRyMk0rYUlhSllzOUhkTWt0ZWU0UTdLQm5MSXZucytaaFFFNU13d1RUSzd4?=
 =?utf-8?B?NUZvVDFCV2ZHSDZ4MkZjd0pOVTdIb2Ezay9WYUZWWHY0ZXlyNHVHVVNHMGNP?=
 =?utf-8?B?ckIvNGhWQ3FaRnRDUEY0ZXE0N2NtMWIreStycERVWDlId2pnZ2RKckpSWkRR?=
 =?utf-8?B?UWVNRUhldi9Mb3VDcXBQZXJLeTYwZ0tTemRXWWpEYk4zcjcrZlcxaFJ3ZnBO?=
 =?utf-8?B?ekswNUw2TzRaazQwRFZOV0ZPbHN4bWUxRGx6VHFkbU0zRFZtTDF1NXFqUWFy?=
 =?utf-8?B?WjNGTituV0w3ekcyUU50RHk1VWFQVmJYcmI0clFSVUt6Tzl4bGJKMU5CVC94?=
 =?utf-8?B?UHVsUG1pWElxd3hVcFZNem5SUkhiUmlJT25idXBoQjdNRjlQZlA2UWxjV0VY?=
 =?utf-8?B?aFhDQjArbDc0M3dweU5UeVUxRXVEeG9hMHByNVJMbE5kZGFrUk13K04vMmx1?=
 =?utf-8?B?N3dzZjkrNmhvZDRKZ3ltVUhXUmVQYnZOTk9abGNpajJ3Wjkwc3dvRE9lZCtx?=
 =?utf-8?B?bE1UUEJDTERvazVJYU1qcFVtZGUwdEZoRXlxenp3MUFUb1JodzZPUUptbSs3?=
 =?utf-8?B?ZDlicnVpeG5QbmFUN0hsZ3JrMTIweHJyNHZuT2NhK2trVVFRazgvSElQTitL?=
 =?utf-8?B?UlNyRncrSWNObE5YSUNoREdHcmFNVDhhazU2UlNhcFlyaWhaeitwQjFSUHBC?=
 =?utf-8?B?K1NVUjVZWENYMlFtR0RCTnlHY3AxUmN1RGZiTm01VGpjSllQVWhOSzd3OGV3?=
 =?utf-8?B?ZzgyNjJadjAxUFFmenhTNFFaKzZOZzQ0dkFNUDZZS1FSM2t2VE9URUtiM29l?=
 =?utf-8?B?ZDRjcVpUS3g0ZUtsWmpzNWFWbVBZbGdmRGVhekt5Z0N1ZGh5bWo5azd6bjZ6?=
 =?utf-8?B?Rk9oc1ArTWFRVk9EZ2piNkJoSUxGY0hpU2gxVGtiUWNJc0FGem00bTFpcTE4?=
 =?utf-8?B?WlZ0Y3RzSSsyNGtTK01FS3FBNHIrVUZuTXBpWHhxWjYya1lEbjh2aUUrR0Zo?=
 =?utf-8?B?OWltM1E5bmVydHNhRXpTUlVheE05SUZQY1doOTdneUZGS2I5RW1BUTA1WlpD?=
 =?utf-8?B?SU5qUm4rQVNZcXg0aDVldFZWQmkyVnhTZFRnRGpCNnUzQTQ5NmV0WjBtN2Ro?=
 =?utf-8?B?ZytwN3UyaFpneGxpWUV0UkdlT29qRVBFOFltalg2M29MN0F3bW90aEo1QlJL?=
 =?utf-8?B?K1kxMjNIYUdybEJiNk9xbTFhcFQzRTY5bHBzMWZPMXVRcUhVcFhBQUZ2eVJX?=
 =?utf-8?B?MFJKcmtvVkNYVk5qN2xKQ1hxbktmS2xneVFXRlBDa1ZvcHMvUEsvV3N1Znkr?=
 =?utf-8?B?Y1pYc1cxLzQvRVMybmxwaGRxa0xGRmYxeXMvUUE4cUFxeE1yTUVCL1FSOUpO?=
 =?utf-8?B?bVVjcmJZM1dpTVlNdTNUTldkK1pKRTNjQ2NTZmtqVDU5cmg5Y3hsV1ZIVEFI?=
 =?utf-8?B?a216ajRoSlhFYjg4R1pRQlNxZHAycEp5YVVYalppNUhJVGR4cU9VY20wTElX?=
 =?utf-8?B?cERVSGh3QXdxclcvMS8wanpURnl3czkxSU8weTJ5VWZmcXdqand6TU9PTWVB?=
 =?utf-8?B?Mm5OLzhKclMzc1VRV3I4UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aG1TcXBWTkpmV0tORWI0YUFnTlVTdG9Pa1QrVEI3alZTWEExY0lqU0VHcW14?=
 =?utf-8?B?QUhoWE1CSEN1S2h2SExBLzY3NUZBMVkyZEpnSWlIU0hicEVlOEE0SW51K0t0?=
 =?utf-8?B?ZUo1VWFqaGcrWWY5blozYS9JSnlGOFBrWW9nUlhOWEZJRytueGVnOHFPdVJ0?=
 =?utf-8?B?aUlGcTVoK1lNNkRoR3BnSElkQnBzNktyMG1yTWEyM294aUhkdTlBQTJ4Q2dQ?=
 =?utf-8?B?eHU4WEVGd3NnM2h5OUc0MjNtaTlXMlZmdnBmTUVLNHYyYmxIM0VpaDBXbmpN?=
 =?utf-8?B?OHpqeVBvNlZwNzNRbURlbjhQOTFGWTlJT25rYnNiRTc2NWdBeE82VHloYXZ0?=
 =?utf-8?B?M2o0REk5Ym5yVk1CNHhrSDlxRmhydWxPaFRCYzZXMGpwQTZIZVpDbXBZcUZG?=
 =?utf-8?B?UEZxbWhNOW5LUENqc1FvYzFUZCtDUStiY0NxS3JRcWlsc2VwcDE0elRvLzJK?=
 =?utf-8?B?QUNKdTNNazFjZUFpOUhhcjNJSDhKYmYyTnk2WXk5UE9oZlUwc0dUNTdIdmx2?=
 =?utf-8?B?S3ByczF3d0lzdTFrbSszZk9YWWJWKzVlczhQODhBTkUyeERnMnJERkRZaGYx?=
 =?utf-8?B?M0VYM045QXRUU1U3R3lDY2g1ajAzcnZ0bVVSVFB4ZUhMZWZoQksxOVRuc2pk?=
 =?utf-8?B?dW9PZHJyS0NjcFRuRTM3OTBhelFwaWVzUVZweDM5YUxFRWFYb3p4TGdGeGNM?=
 =?utf-8?B?QnUxMVBycTRzWXlkdVQvZVBFM29TT1pCUG9wZGhHMXZ3bkVFbTRsYVBFR2xH?=
 =?utf-8?B?dnRXSWVkaXJ3QzhUTFVTOWZBV1BhNGdFR1lUQ1d1UFh0SXZGZnlhREFxRzRU?=
 =?utf-8?B?eWprNUxBeFhrNjVuMGd0dVlHWVZxYmlMM1JvL1NDaDBZNFBZYXhJZE1ieXZN?=
 =?utf-8?B?emRsaTBMQjUwdXBHTEo2T3VTRHRZKzBBU0x4c0d1WWFiZGZxTDZiclllMHZO?=
 =?utf-8?B?L3ExMTVEUkkrNXN6bWpQL0NHTzUvNm9CR1dYbHJNWnE2VWJrMFloQUNLS2FW?=
 =?utf-8?B?N3FuMldmcysvNW1NWDEzbEZHUFoxNXpseDAvZVJ2T2VSL2ljQmVaSzUzNTAw?=
 =?utf-8?B?M1RCRFp0VUMxZm5pbG8wem1xN0RvbEt2MDY3eFdOV1YrWUlVcXFNYUtES1dI?=
 =?utf-8?B?aE14alJqcC90YTk2WHZFQXFwTW5CUWdVOThLRUMvcDMvVlNOcVcya3RqOXYw?=
 =?utf-8?B?UlA1a0pEUzQrZjZ3NDgyMngrcThZVmF5c0lqZ0xOWmpDZy80Z1RQcnB0RndG?=
 =?utf-8?B?czV1aEpyaDdiYjJNakhHTUwyY2QrWVllc25RaUVmZVVWUnRSWEpZQTdoWE03?=
 =?utf-8?B?blBMWXFFbi82YWtycEs1Vit6c252N0NkTkU5TEdmczdZZE0xOTNTWmlWRHBh?=
 =?utf-8?B?Q0xxZlZhcVhBaXNTNEFwTHM4b0tEajNTQUhpTjdPRGNMZEo2ekRLS1VVYTRn?=
 =?utf-8?B?NWs0K0t5MnFMYWZOcWM4SXZaVnVDNm1mRnBGa0RCTGNQUzJVM1JtQTN4K0Jr?=
 =?utf-8?B?cGdOYVNYTjVSeXExRjh4RWhaeGlSSDJjbEdpMFd4UlpNR2c1cFVPNnB2K003?=
 =?utf-8?B?b0NkWlFPQWxNc0JoU1Z2RDlDby85bExzbnF4L1RkR2hMN1BDcDRjOVROTnlW?=
 =?utf-8?B?eS9jamdzQTNNTGhKeXZXVDRHSHYraWhQSnRLVjFTVWFvOTJSZVhMaDlBWlRw?=
 =?utf-8?B?Q00wTExURWoyb1BPRUp1THZ0ODRnQlljUUFnVVhqc3lmNXFreXQ1Uzd6SEJS?=
 =?utf-8?B?SGtOc2ZUSlVoR0VEcjRPc2ZyUFpITDJkMFlUcnZrZHZZMFVPR3M5cXpOcXdu?=
 =?utf-8?B?SmtVKzl5aFNtVXVTeUY2R3JYQmZKRkVvdThnRnZrUXV3UWgvNzB5cTVJQ1BG?=
 =?utf-8?B?QVFwY01TMWNwdTQwS3pXY2xmRTJpcnNmcXd4SVdJWHBKblZyVVdWU24yMzhW?=
 =?utf-8?B?SXIvc2hrS1l2cDgzUHZROU5wdWhsOGNzUWtCdnFJYVVoeTh2bEVpeHFxZ3pH?=
 =?utf-8?B?QkZYUjBqOVBBYURVWXpmNEl5SDdWUzVVOUFhNXdBSDVRRmZrZm5pN1hrd3U0?=
 =?utf-8?B?b0JCcTZmYm5JcHV0cGVaRE9JUk1xYS9vNEFWSFAvcVp4NjBsVVNvZk1NRVhQ?=
 =?utf-8?Q?Sn7c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf799a-8c4f-4102-d22d-08dc8465261e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 07:08:34.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+eWJ/O7xp3jLT6sncRL/GK2tLOutj34LoqyEmD/bVhkNsiTYQsig+xWeiLMJpG01OAi6FAtaPNis/Ie5cQPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5110
X-Proofpoint-ORIG-GUID: DaXpeuQpA6ylaiMcQxcywUxXw0m-mSC7
X-Proofpoint-GUID: DaXpeuQpA6ylaiMcQxcywUxXw0m-mSC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01

DQoNCj4gRnJvbTogU2FzaGEgTmVmdGluIDxzYXNoYS5uZWZ0aW5AaW50ZWwuY29tPg0KPiANCj4g
VGhlIGNvbW1pdCAwMWNmODkzYmYwZjQgKCJuZXQ6IGludGVsOiBpNDBlL2lnYzogUmVtb3ZlIHNl
dHRpbmcgQXV0b25lZyBpbg0KPiBFRUUgY2FwYWJpbGl0aWVzIikgcmVtb3ZlZCBTVVBQT1JURURf
QXV0b25lZyBmaWVsZCBidXQgbGVmdCBpbmFwcHJvcHJpYXRlDQo+IGV0aHRvb2xfa2VlZSBzdHJ1
Y3R1cmUgaW5pdGlhbGl6YXRpb24uIFdoZW4gImV0aHRvb2wgLS1zaG93IDxkZXZpY2U+Ig0KPiAo
Z2V0X2VlZSkgaW52b2tlLCB0aGUgJ2V0aHRvb2xfa2VlZScgc3RydWN0dXJlIHdhcyBhY2NpZGVu
dGFsbHkgb3ZlcnJpZGRlbi4NCj4gUmVtb3ZlIHRoZSAnZXRodG9vbF9rZWVlJyBvdmVycmlkaW5n
IGFuZCBhZGQgRUVFIGRlY2xhcmF0aW9uIGFzIHBlciBJRUVFDQo+IHNwZWNpZmljYXRpb24gdGhh
dCBhbGxvd3MgcmVwb3J0aW5nIEVuZXJneSBFZmZpY2llbnQgRXRoZXJuZXQgY2FwYWJpbGl0aWVz
Lg0KPiANCj4gRXhhbXBsZXM6DQo+IEJlZm9yZSBmaXg6DQo+IGV0aHRvb2wgLS1zaG93LWVlZSBl
bnAxNzRzMA0KPiBFRUUgc2V0dGluZ3MgZm9yIGVucDE3NHMwOg0KPiAJRUVFIHN0YXR1czogbm90
IHN1cHBvcnRlZA0KPiANCj4gQWZ0ZXIgZml4Og0KPiBFRUUgc2V0dGluZ3MgZm9yIGVucDE3NHMw
Og0KPiAJRUVFIHN0YXR1czogZGlzYWJsZWQNCj4gCVR4IExQSTogZGlzYWJsZWQNCj4gCVN1cHBv
cnRlZCBFRUUgbGluayBtb2RlczogIDEwMGJhc2VUL0Z1bGwNCj4gCSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDEwMDBiYXNlVC9GdWxsDQo+IAkgICAgICAgICAgICAgICAgICAgICAgICAgICAy
NTAwYmFzZVQvRnVsbA0KPiANCj4gRml4ZXM6IDAxY2Y4OTNiZjBmNCAoIm5ldDogaW50ZWw6IGk0
MGUvaWdjOiBSZW1vdmUgc2V0dGluZyBBdXRvbmVnIGluIEVFRQ0KPiBjYXBhYmlsaXRpZXMiKQ0K
PiBTdWdnZXN0ZWQtYnk6IERpbWEgUnVpbnNraXkgPGRpbWEucnVpbnNraXlAaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBOZWZ0aW4gPHNhc2hhLm5lZnRpbkBpbnRlbC5jb20+DQo+
IFRlc3RlZC1ieTogTmFhbWEgTWVpciA8bmFhbWF4Lm1laXJAbGludXguaW50ZWwuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX2V0aHRvb2wuYyB8IDkg
KysrKysrKy0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYyAg
ICB8IDQgKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ln
Yy9pZ2NfZXRodG9vbC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19l
dGh0b29sLmMNCj4gaW5kZXggZjJjNGYxOTY2YmIwLi4wY2QyYmQ2OTVkYjEgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jDQo+IEBAIC0xNjI5
LDEyICsxNjI5LDE3IEBAIHN0YXRpYyBpbnQgaWdjX2V0aHRvb2xfZ2V0X2VlZShzdHJ1Y3QgbmV0
X2RldmljZQ0KPiAqbmV0ZGV2LA0KPiAgCXN0cnVjdCBpZ2NfaHcgKmh3ID0gJmFkYXB0ZXItPmh3
Ow0KPiAgCXUzMiBlZWVyOw0KPiANCj4gKwlsaW5rbW9kZV9zZXRfYml0KEVUSFRPT0xfTElOS19N
T0RFXzI1MDBiYXNlVF9GdWxsX0JJVCwNCj4gKwkJCSBlZGF0YS0+c3VwcG9ydGVkKTsNCj4gKwls
aW5rbW9kZV9zZXRfYml0KEVUSFRPT0xfTElOS19NT0RFXzEwMDBiYXNlVF9GdWxsX0JJVCwNCj4g
KwkJCSBlZGF0YS0+c3VwcG9ydGVkKTsNCj4gKwlsaW5rbW9kZV9zZXRfYml0KEVUSFRPT0xfTElO
S19NT0RFXzEwMGJhc2VUX0Z1bGxfQklULA0KPiArCQkJIGVkYXRhLT5zdXBwb3J0ZWQpOw0KPiAr
DQo+ICAJaWYgKGh3LT5kZXZfc3BlYy5fYmFzZS5lZWVfZW5hYmxlKQ0KPiAgCQltaWlfZWVlX2Nh
cDFfbW9kX2xpbmttb2RlX3QoZWRhdGEtPmFkdmVydGlzZWQsDQo+ICAJCQkJCSAgICBhZGFwdGVy
LT5lZWVfYWR2ZXJ0KTsNCj4gDQo+IC0JKmVkYXRhID0gYWRhcHRlci0+ZWVlOw0KPiAtDQo+ICAJ
ZWVlciA9IHJkMzIoSUdDX0VFRVIpOw0KPiANCj4gIAkvKiBFRUUgc3RhdHVzIG9uIG5lZ290aWF0
ZWQgbGluayAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdj
L2lnY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4u
Yw0KPiBpbmRleCAxMmYwMDRmNDYwODIuLjMwNWUwNTI5NGEyNiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4g
ICNpbmNsdWRlIDxsaW51eC9icGZfdHJhY2UuaD4NCj4gICNpbmNsdWRlIDxuZXQveGRwX3NvY2tf
ZHJ2Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbWRp
by5oPg0KPiANCj4gICNpbmNsdWRlIDxuZXQvaXB2Ni5oPg0KPiANCj4gQEAgLTQ5NzUsNiArNDk3
Niw5IEBAIHZvaWQgaWdjX3VwKHN0cnVjdCBpZ2NfYWRhcHRlciAqYWRhcHRlcikNCj4gIAkvKiBz
dGFydCB0aGUgd2F0Y2hkb2cuICovDQo+ICAJaHctPm1hYy5nZXRfbGlua19zdGF0dXMgPSB0cnVl
Ow0KPiAgCXNjaGVkdWxlX3dvcmsoJmFkYXB0ZXItPndhdGNoZG9nX3Rhc2spOw0KPiArDQo+ICsJ
YWRhcHRlci0+ZWVlX2FkdmVydCA9IE1ESU9fRUVFXzEwMFRYIHwgTURJT19FRUVfMTAwMFQgfA0K
PiArCQkJICAgICAgTURJT19FRUVfMl81R1Q7DQoNCiAgICAgICAgU2luY2UgYWR2ZXJ0aXNlZCBp
cyBzdXBwb3J0ZWQgaGVyZSwgZG9lcyBpdCBtYWtlIHNlbnNlIGFkZCBiZWxvdyBpbiAiIGlnY19l
dGh0b29sX2dldF9lZWUiDQoNCiAgICAgICAgbGlua21vZGVfc2V0X2JpdChFVEhUT09MX0xJTktf
TU9ERV8xMDBiYXNlVF9GdWxsX0JJVCwNCj4gKwkJCSBlZGF0YS0+YWR2ZXJ0aXNpZWQpOw0KDQpU
aGFua3MsDQpIYXJpcHJhc2FkIGsNCj4gIH0NCj4gDQo+ICAvKioNCj4gDQo+IC0tDQo+IDIuNDQu
MC41My5nMGY5ZDRkMjhiN2U2DQo+IA0KDQo=

