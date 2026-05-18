Return-Path: <netdev+bounces-288827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCirHG+BCmoo2AQAu9opvQ
	(envelope-from <netdev+bounces-288827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:03:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C606C565401
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD600300461D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0037CD4F;
	Mon, 18 May 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OruAVUHh"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026937D118;
	Mon, 18 May 2026 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073388; cv=fail; b=Wva7l+JAibTyDscM8d7GzImGgs4OomlGQ9S7yz0FaC9kzPnFTRBHPs3+zb5GucLbvB5lE882nVQLJxjBPPiHrpLtVAdVnM4kYDq0OVRvBhwG6+pO9NFUY3y+KFbI+M3jnP8Iklh3mXeZo4DCQacB3iqqxMg9TmZZ7IVMe8Kg3eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073388; c=relaxed/simple;
	bh=ormiFJ1fm0ygJeMQQsEjrHoKzeXsZhIw8Pp+zSV+UhA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qxb+K5b7YQ+VYOkZ+MMiQ0J+Up4YIelHBZ6Zlp2fUpqj3tx3gVpc34LL/0IKqfx2JJwnQ9SwBcIeU5I6RhPyiiiJ79z6fN7Dn0rh1faM7ELeO7ua6cdCgfMDpz7tzGooiiNWuOiAh2VXzkRgiO8n8oqkVoNn5vUhOwIeH4dhex0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OruAVUHh; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV0WHHYmsxaOBKd3QUNfmjfzMrjVubBOylhwWQW0TPy4vMAZcdrab7nEs+Oby8RPqRquGgrAwSXsg0AjNuL93vPDN54MMK6DmNosDkVrOWehVCZ33I7kHHb3KlXtJo+dNtJtCVOQMCnBhnoZ8O/IRegP/vTVnTAAlrFsuD2R+lISCL61RM8UxT6TxNCGtEFcmNo0pMspFWAsqlLuiB94vJcylis7/TvfHT//LsnYs4Erxjjadm51byo7bGEuvyWoJJnONxVexgjVW/zVJpTWg/M/nXZf4rSWR/PxrPveMnrdaVo6izZyMVTaydVh660/zY4egf4306mXfqs3HuTNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76YSepGvNCJV7mCltw0l1PCCdnGbutnuH/sy/HKkYCk=;
 b=GW8gWonkDfl6dP6O1D2WFBTd6mOFTuU+S+EYTVC7k7NY/RlrtlVDGMflLmd2yamcJk5O7wEyT/Tyn09BumKQxf7zuBf/JG1SmT48WcV6wP86c9IjHpkJ7LUchsyPMczGmLlcy26u3VCaHqasuFSFMdwkF092ZCcmVHdwSeagZUhbYePHR+ZY7X47H1C0Hlw4A6Tp+j9EmKJVIrbR8DkM7bjKD1RHp6WlR1CieXYNdAnPuVcSKjYX68OFVExlU7p0fqDJtm9b/INK+FxscmOGFCkWz4u17MzqRoQjS3KJsY5SuKEIGa6kzTZaeofSxpo1bnBm1P7c0MuCMUadUJT59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76YSepGvNCJV7mCltw0l1PCCdnGbutnuH/sy/HKkYCk=;
 b=OruAVUHh7RNt59ySfthkg2Hs8OpFDlZrNyUIxP2pe6nkRZoEo/KRniOhfhRgJlhct5prdhDtx9oeYmnfcd+PQK4ZYMP/Yg/6Xva1pOTgqQxha94DHj3Ucwxc4xmkivPiNm3F93eg+Cb5a5XLGFT/g5Vzs4FlKvhY7OneCfpmxN1cwWHXdgfvvoZhvri37jjVw4aJgZpeUh9kW9v7+8Nz0r9kvU7eAUM2kJwEv2HdE4hoRymz4/0zaNiF+AyRHUQGB2XwsdHzVa52flWKQIZh4dK4UU2hRnbK9lnIeVxqG7IHctWdG0VHKM1V1drWdKhCKZ8cKcexJi5eMUsORYzXjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:00 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 0/9] net: enetc: SR-IOV robustness and security fixes
Date: Mon, 18 May 2026 11:05:26 +0800
Message-Id: <20260518030535.1057228-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: db18ac94-f24a-411d-db86-08deb489f833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Ji1o6X6xO5+ReW1f5tyDlb4rvLvTQi8s2ByMtn78P/n/yEkAKqgdRWqGPKCHMQwcuA3WTvTge1FpLwoJpdaizwjw8QZeIYujkj2yYFkzf9gIcY6aRYPk8wF706/jnXYsQ6GAppe41UDvyUGKnBZHHGrE8ZQq1VqeVIahYz04unWut1OX2slZ7tm/NTavBkjbGLBogMSVI595oIiCnc61qQ6VYxlOD6LVXO6ucN6ljw909Mn9eDOD9j/JccgY5BuuRmnC6gg1zobYtMdNKR1JQLNPtgcFvJuVxYeIuVda4F+4lqkU6C8T2KQyUrecZ2l6je3WXLMsTUwRmj9TqypxyN2uFk5hO7zzzHvClBNCL8Rcz1tYvYKXE+kd1+gjFZK48C1pGJ6ZMxQ1s4ZO2SlrtmtEsccJhsOGvPZpkDBdoxPmmDMZhoRm3XI2sH4vB9+AwLHS3gQsm2UzKfDXLV/nV+xAM+XZDuZcRltK+BMbqPNzUexPVFs36tw+BnTPF1M8EMamZr6niFLne/t3bbDGmDAZbaWZTJMGcJo0Ic9dc4IsKWWGAWcZlScdvJhehNvKeuGxCX9aTmTywL6h4HchCLgzhYvxK0jLjh2nLp+GCGEddj7MOenf6L/qraRpgDL1xuqFpsPyXRUBDiScK7vdILwzOuQHshQqH34X/DE49xZDAMtfsGrWM6zNDg3uewyJ8bN8KW5nZgYWNvpvyjkmC/CyC9NwJ6t01bU4W0qKgbbwFW0Iy0FPfpiTdWPjFBgD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPiYst3oixL99GcgEvOhhwmLMJvyoW225GygOhsL5OdsyIudfTIsgdxxw43H?=
 =?us-ascii?Q?6L716ER3wEpD/Lo57hBiEe8i/wJJmLA4+/YlcKiAfunQwEe+uw+NkKm87Dxr?=
 =?us-ascii?Q?Xy27GhxJgFuSl9yFrnSTjhAmyqH1HGjcy8D9mml7CMtSFoLjNQAYTJgv64Z2?=
 =?us-ascii?Q?IPg2elsH85Ja7FCyPHg5yKCJhlczSfV+2ox/WGbCaIdccv+b9M1HYsrIexeh?=
 =?us-ascii?Q?2H72OiT1WwsLIP72IqMVuy8VwMzU3JrTQvJZuFskbGKcv1RcrRLdzzgOLvj9?=
 =?us-ascii?Q?BItpddAx3YauIeLtKxy6XaFJXnFkg1mToeQwcT50MNP65PL6PHfb8HEsNM+z?=
 =?us-ascii?Q?sVXrTGKgusEiJRIxajuF+w9c+9MJ5ZwJwfNGHk3VlUTyWjvPAzE+dKpp1rfn?=
 =?us-ascii?Q?Rixa4tuYDcb0+pLX2qIedVfQ4HCPuptHVZS5vxxp/nqF1n3DzXsrWzZnpZLH?=
 =?us-ascii?Q?w70cJRjsbvl2bJyH38m8sDkNaxFF+sc395DhTAA7l7J6ppBlGGCx3c/t8pcj?=
 =?us-ascii?Q?EB8kOEzY5f6WAV6aCrwPLzIN5sCikNFmwiF24CqqVe+iE+saFLl5zGYZeiL2?=
 =?us-ascii?Q?NFGs3PzkIonzX+da0jc3XrMqNLSDjWQapbta/zmdKF/v4JtHM/BwTMSDbyqL?=
 =?us-ascii?Q?nP1RdUNb4b271xNTQbVx/frePYEFcDLdbCd4HPjj5AEsXJfKYHLx5JSJugJs?=
 =?us-ascii?Q?yKrflOXAM0h9b682+FlUzpIi+tzjhoA4wFrdPHZaSUUOzcMRK4vK5oDa+fZq?=
 =?us-ascii?Q?f8gZqZ/eD1SilgrxqTtsAbdTR2ZwV8/6tv9ox8smYInp2LRdVRJdvw7ItGdo?=
 =?us-ascii?Q?qLDTUUlUzoPqzvFyX+yImDKuw+PpoueTIwEqSXXyHdg4DwrT0gorCYoFaYj+?=
 =?us-ascii?Q?8RRCMDYoVi8yGpRxv/WU34G19LLyv+3dPYDe5sBOiM0NzhfS1Tw+ZC5qbq0Q?=
 =?us-ascii?Q?LpgVAHU8a46oVgndlA7lebJaKVV15PcJKzeEmRo5gJ2YQzH1InLek5xBp92Y?=
 =?us-ascii?Q?ok3JFPEHH3yLnI75jS0lFS8/st8VAY0dKoQWWgiiP9Aoas4As2uHvYLx1e1C?=
 =?us-ascii?Q?ece4ylrDTare2/nBoZaUxfhh07BB/NlGvpX2W13sAmsGmepKpCLIKFxMA04I?=
 =?us-ascii?Q?wpjtmERL9SaSspUZRJQrtEUahru0rcnOAnCQCeAp/ZUDTBlmq8Xf/lJkygV2?=
 =?us-ascii?Q?naghAFyGK/c5JV1cFcCCbvoQV6YeVNgLIT2Z+AdfGCXqcuiM+TnMgRGqTCi5?=
 =?us-ascii?Q?kydjsKbJqDbh55Lgqtcj1aHV8M5nv6wXnqLga1ckluXMvzyXMu4XLxG05o22?=
 =?us-ascii?Q?NPtrZjjNWPhfGWZ/jfSdEtrYmQR5t0d+uOwUXDehIlbA6ccPmEgA2XNFI5vC?=
 =?us-ascii?Q?BhgqfjAxX46EK/6tuwb8jz35ZhWKZvGQiOuePmP6X5XJim4QIuPGO+72mREW?=
 =?us-ascii?Q?srqUR3N1eM8mYXJnTsD9HRCE1in9nj2s1jQfNSit5P7KWcvC9NlwSPnUYhxH?=
 =?us-ascii?Q?d2XeKEiAUEy6J5Jei5LnihvvJaRpW7b1s8rASm48ei0YXtPLBwTYlvVLsLmc?=
 =?us-ascii?Q?PTuIh2ReDvorEGuJZ/vTUornr5yBj4g3AlG+4BhPFUiFPMgZqzz2P5qQfYpZ?=
 =?us-ascii?Q?rittyj2JbdpJ3VIx/n6gKY5LuNNrezJ86eb6Xu2F82LKN2ahl4HLv/Mo1eGp?=
 =?us-ascii?Q?1lwbqdaAK6bsryOfzQSJKx5YkBTRUbrsWcz+g4b9B+fPNxrG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db18ac94-f24a-411d-db86-08deb489f833
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:00.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vm9JCnoOxO6KRRVuXHWDuwGFZOGiij/m3aSK90VNF01tl65txXyefVR9ulFhYH+JbLTT+Kuu93KC5HW8ZvIP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: C606C565401
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288827-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

This patch series addresses a number of robustness, security, and
correctness issues in the ENETC driver's SR-IOV subsystem, focusing
primarily on the VF-to-PF mailbox communication path.

The series can be grouped into the following categories:

1. DoS and security fixes:
   - Prevent an unbounded loop DoS in the VF-to-PF message handler,
     which could be triggered by a malicious or misbehaving VF.
   - Fix a TOCTOU (Time-of-Check-Time-of-Use) race and add proper
     validation of VF MAC addresses to prevent spoofing or invalid
     configuration from being applied.

2. Race condition fixes:
   - Fix a race condition in VF MAC address configuration that could
     lead to inconsistent state between the VF request and PF
     application.
   - Fix a race condition during SR-IOV teardown that could cause
     VF->PF mailbox operations to time out, resulting in unnecessary
     errors during shutdown.

3. Memory safety fixes:
   - Fix a DMA write to freed memory in enetc_msg_free_mbx(), which
     could cause silent memory corruption or system instability.

4. Error handling and initialization fixes:
   - Fix missing error code propagation when pf->vf_state allocation
     fails, ensuring callers receive a proper errno instead of
     succeeding silently.
   - Fix incorrect mailbox message status values returned to VFs,
     which could cause VFs to misinterpret PF responses.
   - Fix initialization order to prevent the use of uninitialized
     resources during driver probe, which could cause undefined
     behavior on certain configurations.

5. Diagnostics improvement:
   - Add rate limiting to VF mailbox error messages to prevent log
     flooding in the presence of a misbehaving VF.

These fixes improve the overall stability and security of the ENETC
SR-IOV implementation, particularly in multi-tenant environments where
VFs may be assigned to untrusted guests.

---
v2:
1. Copy the message content from DMA memory to local memory
2. Patch 3 and 5 in v1 are merged into patch 8 in v2
3. Add more fix patches, such as patch 1, 2, 6 and 7
v1 link: https://lore.kernel.org/imx/20260513103021.2190593-1-wei.fang@nxp.com/
---

Wei Fang (9):
  net: enetc: fix incorrect mailbox message status returned to VFs
  net: enetc: fix missing error code when pf->vf_state allocation fails
  net: enetc: add ratelimiting to VF mailbox error messages
  net: enetc: fix TOCTOU race and validate VF MAC address
  net: enetc: fix race condition in VF MAC address configuration
  net: enetc: fix DMA write to freed memory in enetc_msg_free_mbx()
  net: enetc: fix VF-to-PF message handler unbounded loop DoS
  net: enetc: fix initialization order to prevent use of uninitialized
    resources
  net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown

 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 79 ++++++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 75 +++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
 4 files changed, 98 insertions(+), 58 deletions(-)

-- 
2.34.1


