Return-Path: <netdev+bounces-254729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA1zCdc7e2n0CgIAu9opvQ
	(envelope-from <netdev+bounces-254729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:52:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F3AF2C3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEEDD31261E8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D1389E0E;
	Thu, 29 Jan 2026 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zbs7VQZs"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1638947D;
	Thu, 29 Jan 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682958; cv=fail; b=Zp3+P5echGllxc8O1bNof2KH3eE9UrFTWQoB555zi+Fwu8aFiPcEF88932JM0BJsG+pADPWmlhlN0uC/VG7f2miU44ksHA8GhpCie/dr6jsIVX0hh74QLyvfXbz3EApsZg2uPbDZ3+x9nPr08tza1bMsEh4SS/RKKJqbGUzioQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682958; c=relaxed/simple;
	bh=HpmM1thlvFao5PVg+Yi90SbkNqXcY9BLZi3Mgk0VUHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H35blHbBurQ4KFZxqLWrSVmPaf7ipMpg02X9GRUuAjaxssrhEj7e5/JaakO/WGzks3WWtcV0CyAtDdQv5gF42mIzZL9wjOziWOYd8mx/dcZp6RyZYcpCgwT5zEO8x1GB+STWXsoYSUtYH0JGzl9OhSducZ6fHxGkxLhyA4OKuMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zbs7VQZs; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQUybRQ6brb88rI0jxkEwU0/893S6rIZNR+xow1ACqaeIKFFEw+vCTbWb6hFeP8bNN/LSPzCvTsYVuqV6dVK+SZbSL8w/50xEb2YowFAb/rW295tvkcsxdxYnulCwsOoO2/yrHjceQmqcv2oTjAQoqn6QPuPwMfpRVJD09b3Z9l7cZVizqd+ZuN/EMelcdcB8gJCIYPffaQJUfvjehtUbxv9iAjB93iiVrnZoh22A9JMvVTCNg/Oj3I8oBr4FSoizI5caFwFvDdS58nUqRP8HKJzPM4mIx69+6O+rfaQKZvSTAoBBM5+nk8bbhE+sdZxgmFhMZ9cO+LpbPFHwc5j+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO6t7ffAegJkeO7JIX5bIKYnZ5Zc4dLotZZsWM+GqZM=;
 b=Br72YTlPHzDV7prf1WkECPDA46++bwGEUD2FNiZgiKCHyCiUUkbXhSkP2kXP0H5DYvT6rJJ0RNWDLQYmLRcYJlNUU43v58yCvEThutQwOhTgZ6BPMkktRt3D9Py+tb4gFxf7XSImGkjgV9C649fb4GjaUO3peCqKbZT5hYuwLBOBgqr7FZSxsY8f0oiL1SbzMQZHQATX55CDgzUYtOZ4WKO2mzGIGAOABJ4x+k6BJ7kTk4OG/SoXxz3IByWC3jKsAF2gH0l2tGD1GLT2gdZMnYjpzH4n+MQznBwActb4yYEmsquswMYfg2Z1e8O1OH9kCMIBGqkUOTB7vlmWQOxyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO6t7ffAegJkeO7JIX5bIKYnZ5Zc4dLotZZsWM+GqZM=;
 b=Zbs7VQZs4AAOWUMTSc+U2/vjSLUsEJ/bXAiONOvdRSw5AtarYiG2S4ikw7Yj2F72ef/ybZj9PxBGJAELqiAwENgX/TKzkQW0I9blHQtIBbBRSMu5v9jFQsvP/EN6/eN+VzV/23gydoVx6aaPiJMmOpp+wElaxMZEXIHTAbLegSnQW7WvwZs2eQh+E8LWynaNmiUTs+dBG30Y8DQ5yCFWE3/trpUa1wD9JNoPfRZt6RZknN3tREUNNxpPimlerfZLNDng3hOQntlGSINKmB6HMpUBO5hLO/qJSvgaZwGtlVMT+UjqXKtJEYAGKK8HFlTh2VQuCFvF1vNPlExSiGKWPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v5 net-next 10/15] net: fec: use switch statement to check the type of tx_buf
Date: Thu, 29 Jan 2026 18:34:42 +0800
Message-Id: <20260129103447.1893129-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: a79e9e81-2cf6-46c3-0ad8-08de5f222d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rbTDG434hvvijGrXQ0d98RITnDLb3NLj7yGT4wMmXdXt2cQW8+0pB2LcLwpU?=
 =?us-ascii?Q?AGn5zCuZ7gfYIsLtGU34OTc3YKg9KEyfGzL+iuESAyuPB4DcpHYsFIeokmAx?=
 =?us-ascii?Q?Q7V9wWDuvE0VIlQpXrZVB4N0pGUraj+i6klWARasH7PcJ0KrnRFTwsCVoeD0?=
 =?us-ascii?Q?jY6VTWuc62Zz5cvkRaa5KQAVUx/xoWNEjpCDPnZKnSFI+utaAQR7y6PM5XEh?=
 =?us-ascii?Q?u+gyU4MleyfmHK1z9Y8mKvxrqA3fdbQUFnF8MVhX9W4T/1R3vCW+RQPSiBmW?=
 =?us-ascii?Q?D1TWAidKEHC/1/Zpfo98nsPiavmPJPoizni4GSVBffa+PztSC3o9Xs6gpVUI?=
 =?us-ascii?Q?877elzczHFeF1VgIYKyHk/hkwhj9eBKDxK71nCeNIsNsTbLEF9BjHgr4j+u/?=
 =?us-ascii?Q?kmxaSFHzncYhS6xocYWG1UYlKZrGFcdeHgrQQHZzVWh0KkfA4/T3lW/eYkSA?=
 =?us-ascii?Q?xKz0oL21/KPhAHX8mRySg1wThfyt3Qg8w1jpLIQ10A/XZSW6Eg7m0afkUnYn?=
 =?us-ascii?Q?yLfFFS4O+HXxu1c3EoYoQc72vMl2qew021vIS3pGazaLJqWILKW2S31RaLlF?=
 =?us-ascii?Q?jX6nPMnfvDFPN59pN6oVn0bDTt2Hf2LuRm3sAQZjsmNW6Hch2Vo+4hazwOoY?=
 =?us-ascii?Q?fD40pJ0AqPU82n6zswgLCDPXtFl2CpiADthtlqo6t3ZepcCHQyOvWRcm/SOR?=
 =?us-ascii?Q?7kPQzmcTMdw5GKDXg1Yrms8EF5eVdnAjUOab+hOUGjTjPV9/nlHitKIzolQR?=
 =?us-ascii?Q?LsXf6OsuyD3U443blGXou9X7zYZSHEGQjIGeOTHeistHMUyeE8UpJ75fpKZI?=
 =?us-ascii?Q?K5LcJC9m0yXaUWJEtgPLmaa9su2BhFYn7HsqskdWyyZYBBYNYKMmtBDSIYRQ?=
 =?us-ascii?Q?5K3qFmWMWo31C8apv+vjHAxbTucGtGR2YyYcwm9PobvGvnDSeKMx0Wyjdv3o?=
 =?us-ascii?Q?sHpnJ6/xnZ/JD7G6gnvhaDIlsVeIN98f+9v2oCH+PBWqYf2TPDFHxxZbvnMe?=
 =?us-ascii?Q?FBmj0rJojICQq+jBfNv7Q4Ql/Skz2c6F5cs2BFLhovWKaNLMfhWOoJMOM/iV?=
 =?us-ascii?Q?oM8BDX4x0nLF5g/MpZY6CE+qMd7MAeNUN1R7axmQ5YDAvgULceEZLEVK8pMf?=
 =?us-ascii?Q?7pNQw2Pp80T2sEaWUUq0jXQbyzHGOI7/N51RVjlJEeXlsq/wPdBIOMc117AG?=
 =?us-ascii?Q?TEt0MONpMkO1Nk3sLML610gKoqe7ZDwvlpfneCxn7e9eja0DlaWG3bssnuvN?=
 =?us-ascii?Q?cmmawEtgIwVMcnEAH72NrhGaifjfGe7W1XMQ2fySE6ntD5KWA889RoBjut6i?=
 =?us-ascii?Q?eHYsA0M6nOvdue+9xXR50Uf3tBgk+B0J+vQB/npUWPTUkxmFIZ+PnC7Q5SwE?=
 =?us-ascii?Q?bVgQBCBH4WkWpL0rtLWEwZwG7TeQIa33NFfoBEmxKrQtIXdIcddI0QZOf/VA?=
 =?us-ascii?Q?7Nefz1OLFb0OuaG26W2zxwtO22+d5Z3QFdgEWyjdXfvVp+dCsBXM2JHGIs4e?=
 =?us-ascii?Q?Xr8VVZ8oj27L95SiINSUPimZi4e3hlGj+XrVRVyegjSeeeMg+YGQvchksOpS?=
 =?us-ascii?Q?wFEsOeonOAicGO1GUr/+erKbemYzCkQ59v6YvWDcQV99DAgvhFTfHRMRIyno?=
 =?us-ascii?Q?vq0yg7JRcjey8znAp/eMFUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rm2ioYTPez4qUacM3ST4xzVPyzCrnq7eDH4JXbfurQFBuzZBnAeaDwUGcxbg?=
 =?us-ascii?Q?F55tVShULHRdpGCo2+UpBACauk2eXgAPkKMYEdSTukUnV0voUkAz7gf+gRc7?=
 =?us-ascii?Q?f83YTlxlrMUZGC2p5naGAC7r24pXKVqDrj8t8Iij3mP3lWCD/HQ7d0vBhBKB?=
 =?us-ascii?Q?2i5fo9G4WvLwGfUCRjvmLBHjkLkzldsgRvOrrsBpd4jXckKm0FSjX88tbgIB?=
 =?us-ascii?Q?UH5/jqnl3NtIWi0Taxdw7hkgAB/xvno+G8lrtLG9U6Glb3K0BP7NAMG20DKU?=
 =?us-ascii?Q?WMGBj8bKzWrHoXFCCd+EjQA2Bo/rL33F53MuKNAgRLR5qUWvfIROnfCBLkX3?=
 =?us-ascii?Q?X7SYu5OVpmzEd2vsh2vx1GDB/D180hm93YQFsYFXLOcOB82ZW85JQeKemp/Y?=
 =?us-ascii?Q?fyi0iZRPw1kSt/wWY+SZMygbBwUE/CUx+87pfmsyIczpnehYTtE0JHFAR4e7?=
 =?us-ascii?Q?TE/glUUR+qAgzwcdUULMe1owqjPeRZHj4H4Y6VaJYJlqL2G8yfsxHY210VcY?=
 =?us-ascii?Q?xRfg4SMyIi4u6O2IcbBytkNdVgDN5H/g/yJvJC7owKu5vp+Jv2J4JamNonwQ?=
 =?us-ascii?Q?whk3kcLVnQw5fkE3HwtcI1hc/JaYe1AnhPERPFk516713wZWO0JpW3E6DeKk?=
 =?us-ascii?Q?fzwAi4ThVh3LlqRTMw0BWjrY+yMazTC0hMpnUityqx3IeERqK+/YpGBXsS5a?=
 =?us-ascii?Q?qBtSBgHX21HYsgHtc1/C34f1iHxOU659w9EwCk19cF6PflS8b/ku3cKbrYP2?=
 =?us-ascii?Q?1tzk3xHnvuvbSv8zlBfcFe8VUb+1WIC4GzGkaJW+nZe8IN0jDhxh4bLfsi1H?=
 =?us-ascii?Q?QFu/5r0FwFk31zupREhNS02IHxM7cIOdkA9pNJaBGZTUCtdqUSHbpAX4zbIe?=
 =?us-ascii?Q?2wZZLYoxv3qUfkmiVS3rPPUBUrM2HBOJX4P+0msDaOqrx2MP0z12CRWmHFri?=
 =?us-ascii?Q?AMxuivN3pSJdK1hPgrXt41+s/BpOHA01S/tSsxR9poQhgU3OiEbMwQEO+Xx0?=
 =?us-ascii?Q?PKuV+j99fZNNlsJWbqoTTG54KNkeO8AchU9+F4CBs8QKM4n5NqXKeRFQEN0m?=
 =?us-ascii?Q?p7ptJrgyjIFLdtPPrFp+uJZ1WCcfzNj2RLX8yc3ST5uY1MRA4t64FzaVOcfH?=
 =?us-ascii?Q?bnEY5LTciPEAudUvT0+rTFGUjWc7w76QUc9eeCiPcOTdl5uixDrkO0H3big0?=
 =?us-ascii?Q?jT2iAtICEja5vhbrxC+PawW+TCrY8M6ZKTelEy+NQkldjfemfzIE+c/BnX8w?=
 =?us-ascii?Q?fcg+bSoPsE61AQDlNXSMYG97stleZgkdy3Tqkqbb21EZYzcK6kO+YjFVEXyb?=
 =?us-ascii?Q?uPgyd2rVN6/mN565zs2Jyr7dJ8HmNisLnF3/58RX3QWP/CoVhinfpLjY7yPV?=
 =?us-ascii?Q?mPifi0PZSV99j3R2YeshHcS829ctboWm35odT/Z/HbGqO0VXAte9Di/Kea5U?=
 =?us-ascii?Q?Tqv/Ux1KW40/l6eqJh3ntyMNMbfwgbTPUvrNPmg+bPJ4KGcDM8/1jYxTu297?=
 =?us-ascii?Q?WTTLSdujfo1EyvGchgP/zJ9gZ/YAZPqJ59Vw2eO7Q7OZF2YTRo21noPcZyQw?=
 =?us-ascii?Q?7SpwppHC7dg1FvCZhqqIp3t+YgfPUzw02HF07ZAY+qElpZErfI8rmFsmEbaB?=
 =?us-ascii?Q?yuOGFQiQz4CbvzYxYW8IYyPBamzXEb4vUSFYIxXWEHnHFo4fPh8jFVC+bI7c?=
 =?us-ascii?Q?xJgqKY0FR82RV91NQNvwRXW/KIbb2lA/OLCGPF8vmmyLQpvL3E22dxv5clfZ?=
 =?us-ascii?Q?SOyKqV3t0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79e9e81-2cf6-46c3-0ad8-08de5f222d38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:52.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mwhdf5pzoAjVrPQSqLaycCE/pPwL7LrMYmRtnIwVwM//JWI3WeE3qG5Prd5YDYKxKsGUvRGpHAQX4JzAOM+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254729-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: A27F3AF2C3
X-Rspamd-Action: no action

The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
to check the type and perform the corresponding processing. This is very
detrimental to future expansion. To support AF_XDP zero-copy mode, two
new types will be added in the future, continuing to use 'if...else...'
would be a very bad coding style. So the 'if...else...' statements in
the current driver are replaced with switch statements.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 134 ++++++++++++----------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 4ed0dede7d81..f460a490c49e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1023,9 +1023,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 		txq->bd.cur = bdp;
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			struct page *page;
+
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				if (bdp->cbd_bufaddr &&
 				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 					dma_unmap_single(&fep->pdev->dev,
@@ -1033,18 +1037,21 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
-
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1510,39 +1517,69 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].buf_p;
+		switch (txq->tx_buf[index].type) {
+		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
+						 frame_len, DMA_TO_DEVICE);
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			skb = txq->tx_buf[index].buf_p;
 			if (!skb)
 				goto tx_buf_done;
-		} else {
+
+			frame_len = skb->len;
+
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			napi_consume_skb(skb, budget);
+			break;
+		case FEC_TXBUF_T_XDP_NDO:
 			/* Tx processing cannot call any XDP (or page pool) APIs if
 			 * the "budget" is 0. Because NAPI is called with budget of
 			 * 0 (such as netpoll) indicates we may be in an IRQ context,
 			 * however, we can't use the page pool from IRQ context.
 			 */
 			if (unlikely(!budget))
-				break;
+				goto out;
 
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdpf = txq->tx_buf[index].buf_p;
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			} else {
-				page = txq->tx_buf[index].buf_p;
-			}
+			xdpf = txq->tx_buf[index].buf_p;
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 frame_len,  DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xdp_return_frame_rx_napi(xdpf);
+			break;
+		case FEC_TXBUF_T_XDP_TX:
+			if (unlikely(!budget))
+				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			frame_len = fec16_to_cpu(bdp->cbd_datlen);
+			page = txq->tx_buf[index].buf_p;
+			/* The dma_sync_size = 0 as XDP_TX has already synced
+			 * DMA for_device
+			 */
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
+			break;
+		default:
+			break;
 		}
 
 		/* Check for errors. */
@@ -1562,11 +1599,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
-				ndev->stats.tx_bytes += skb->len;
-			else
-				ndev->stats.tx_bytes += frame_len;
+			ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1575,30 +1608,6 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-			 * are to time stamp the packet, so we still need to check time
-			 * stamping enabled flag.
-			 */
-			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-				     fep->hwts_tx_en) && fep->bufdesc_ex) {
-				struct skb_shared_hwtstamps shhwtstamps;
-				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-				skb_tstamp_tx(skb, &shhwtstamps);
-			}
-
-			/* Free the sk buffer associated with this last transmit */
-			napi_consume_skb(skb, budget);
-		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-			xdp_return_frame_rx_napi(xdpf);
-		} else { /* recycle pages of XDP_TX frames */
-			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
-					   0, true);
-		}
-
 		txq->tx_buf[index].buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
 		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
@@ -1622,6 +1631,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		}
 	}
 
+out:
+
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
@@ -3415,6 +3426,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
+	struct page *page;
 	unsigned int q;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
@@ -3438,20 +3450,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
-			if (!txq->tx_buf[i].buf_p) {
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
-				continue;
-			}
-
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				dev_kfree_skb(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.34.1


