Return-Path: <netdev+bounces-217040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3023B37243
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C115F3666EC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F265283FDE;
	Tue, 26 Aug 2025 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bqAcD6QL";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bqAcD6QL"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021117.outbound.protection.outlook.com [52.101.65.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F682DE709;
	Tue, 26 Aug 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.117
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233152; cv=fail; b=FP+y4wWeXPLuFyVZsduFkodmicZve2xkXwlRJ0arlV9FF/UnyDq+H9x7TT0IanTf433C05LqMLszM6g5ryG9LeksRDWhpLB3tA68cD5MT5740oN5bY26n49RSMGgEoqvP4ha9uLPOzzhsV2fCoEBWCoo+EHtV6CX5gPiDUmjTag=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233152; c=relaxed/simple;
	bh=r1bsuu80kZyn+6+l4mjy59NenfqgSVIMvthCymcplCg=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=EEMtAiqZFFMgeUn+rPTH4H0YBZEBa6qLPWlW67uadhLaXgmvUVg4sBSK1NQoqIDy6jPOlHAbNCLbXhzZc+IM4vuaBSJU5AX+WEA2zEQ3j6w0jvouzWoyGcELq6zyJtQfnPTEsM2wpj5qLN/pE7uKukkh90pDeSg2usfjei87d/U=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bqAcD6QL; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bqAcD6QL; arc=fail smtp.client-ip=52.101.65.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=m1LDMGdaNv9R2KTClrX1siS4I5CaF3hjJVqR+pzIRD7B82+VJ4OQCOANv0igwAU8VIJV+wOLW6CS1/Qftnwj4pmVfrHyQAThHmx046GGoBN98JzQjsnGOYC3fICnQ1Psn3tWRgheuWLUfqiRc0AIfWSigr1XA+cBwGYCYfMiB+7S+TUfu9R+Ga+0cgyPXyAVdf12e/0AU7uvIGZ1yk7ePtqOdb4Y3donivudcIbtAN3FEfhdktbBDTJ+ykxu5qIyfZ9/7ioEdALHbL+xkc3kIIqLM2ivH7oUjDHYbv5xatdo9lp9WfeiBqpFadtq7GhHvDTyPr1VrkncpESaMi92Ag==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF07U5MM+LabRXGKe2AuHfejjVMWka4L6goLPGUslTs=;
 b=xOkj1bw6Jbt6qwR2bpQ7D9MN5mgUUftzw0rUU5ipYlhDuRY6f4SUUIBjJRJ50V2N75A1RtpTkNQ6PZH/mql85E/taHd5AHVuZOlo/Q4y+o1KVbsRcXERzLnPeTkWGxSYk+5fdHPG7sgqzdW0N2Iy1HCUhviH3NQjaPrupp1GGP+b86v4bnDfEXFriipEjsbQfWyL0SqUj1h9RLrMMClSID0tOl2B3DwPccgWSgQwND7WQkF1tD5IlMHidr7C7B1kCt2SR+VUOeSWAAA0GXgcxM0gDwCOtEIowLS+V48rOtt2x/4A61/i2goyL/qPlYmGDvMJdxevPJWcvE0gV8FfLw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF07U5MM+LabRXGKe2AuHfejjVMWka4L6goLPGUslTs=;
 b=bqAcD6QLjvchUZya9cIGRIXuvMlXI6QJFt48wgHCU/8UX5D1kV6zmEXnQFey1BnltUYw6rhpk/33k/ETt+nJf0h72oyftASx70tJOPdK8NlpsAuVivb9xbcmLhcjL/Z4P5nOxJvmXQx6hK2UeOB35/N9reYIAxex50EaXzfUm2c=
Received: from DU7PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::9) by DU4PR04MB10672.eurprd04.prod.outlook.com
 (2603:10a6:10:581::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Tue, 26 Aug
 2025 18:32:25 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::aa) by DU7PR01CA0021.outlook.office365.com
 (2603:10a6:10:50f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Tue,
 26 Aug 2025 18:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Tue, 26 Aug 2025 18:32:25 +0000
Received: from emails-6218708-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-128.eu-west-1.compute.internal [10.20.6.128])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 49CCA80626;
	Tue, 26 Aug 2025 18:32:25 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1756233145; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=SF07U5MM+LabRXGKe2AuHfejjVMWka4L6goLPGUslTs=;
 b=Z2/rsUTcPIqMAcEvy7F3pOZ+EfRc6NxLHXJvdE65EmibKWT5A6iHSlHN0u9iVedPUnDvg
 yd69K+Xj2ACNx4OuO7YqaMyNpItCQjfepnoz9bYMWr22/FzWRbYlL47M3qxajEtm20JFJ//
 amn1H4eBB2nB1QhGzUm/mQ7g3PaCKQ4=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1756233145;
 b=Qckpp8I15NJcZ5Oi2srOlLIGt/sFEzVQO8hpJ1I6aKnjqDzg1IyGIZWboCy1UMY2z6dl2
 H/xTVX21EFerJb9ZIWLpIeYRG2K0O9Zhjfx0IVGMjrdlrafI3j/5FAib1YwU8FzEcMC5cJe
 bxsbSCctFkicGpF0cZfFA3uKl7eGUkM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8y2Z+1dD2ZSmSL8ddRUL5MYj87pByV5K4rpGfLmzMAAWdOSIs3zVMpgxG74B7I0vyxuwCHhljUA5UDqCd4c8sWg+J0Q3Vh+HWM6jVS8PJdP5eKaqU08ESmNCvVSN8rv1KjzLpVK5yZDKBVsP+JoEU1zX4/A2/H2RhXLSch4dTkNjs7BdWFlx2wpRcJv0qfgZwf8XOtOV/mIHZUy3D3002t5ny6nW1stln/MFoFK3DuOfj0mx/ddFG8TC6+UDTrblQwF6sjlKuaKiC1tLZjV6k0w2cCm1HyJ9EAtp79gDVorsnA7PPK0xAcIlOst5wLqDSWj5OeHflMWYZLnnpoamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF07U5MM+LabRXGKe2AuHfejjVMWka4L6goLPGUslTs=;
 b=aTK1+skBlK9uisR1yANmoQ4KHml8StRiMTnIUYvGT71sEirpsD1Njcl6v3BWvLOHJ2+bjOUn5ZRgApEfr7dDag0lStiP5QcPN1wUkVhDOVSMxQwq4QOEvzxB9fqUnyUY8mSS0CRFR39g+RLqHfOkoo64LgPMo7GUDUnQx86L7edtxEcTN8Z5Eaf/52aIbfpJDnfleq4Q3bjmB4ZEGYqDuQdaI1Hn+2jWP3GNil8tGvnS3Qa1UYlHlVIMPNCtE7X3UcG70MW+r6av15lUgCP+8RQ/4AXoetnUjZQmyol3QBd7sqgJABlGPNeQnBPej2VosYECDQY4K0srSJlaWukL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF07U5MM+LabRXGKe2AuHfejjVMWka4L6goLPGUslTs=;
 b=bqAcD6QLjvchUZya9cIGRIXuvMlXI6QJFt48wgHCU/8UX5D1kV6zmEXnQFey1BnltUYw6rhpk/33k/ETt+nJf0h72oyftASx70tJOPdK8NlpsAuVivb9xbcmLhcjL/Z4P5nOxJvmXQx6hK2UeOB35/N9reYIAxex50EaXzfUm2c=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Tue, 26 Aug
 2025 18:32:14 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 18:32:14 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 26 Aug 2025 20:32:03 +0200
Subject: [PATCH] phy: lynx-28g: check return value when calling
 lynx_28g_pll_get
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lynx-28g-nullptr-v1-1-e4de0098f822@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAKL9rWgC/x3MQQqAIBBA0avErBvIASW6SrTImmxALLTCiO6et
 HyL/x9IHIUTdNUDkS9JsoUCVVcwrWNwjDIXAzWkm5YM+jtkpNZhOL3fj4hKz0xWW8XWQMn2yIv
 kf9kP7/sBTNvgqWIAAAA=
X-Change-ID: 20250826-lynx-28g-nullptr-15de2b5b1eb6
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|DBBPR04MB7659:EE_|DU6PEPF0000B622:EE_|DU4PR04MB10672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d35a219-9c70-4c87-f32f-08dde4cee77f
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RlhJN01XRFRGUUdDaVFnSCtabmtsSHdvSTZWd2g2dUtGekJvY0JKdXNDV3Y0?=
 =?utf-8?B?eVduQ2svbk4yZ1Nzd0V6bXBZdTBOK1VoeGZKU1Z2ZUVnYlpWd2d5UmhGUVI5?=
 =?utf-8?B?TStEZTlTRWdCTDRqcEdhcHRKcGorZnJvQk4zRGM2YnNWNUtLeGFxV0dVdXph?=
 =?utf-8?B?Zjd6Tmgzbk1iM1hiRHFuRzRZWkh4aGhvc3l0cWJmRTNwU3dyOGw3VURIUHFr?=
 =?utf-8?B?V04vOXF6N3E2TjJQZlhaOUFLaHk0UXhCS3oySkMvcEJZU0U1SW1EbUxGK2RY?=
 =?utf-8?B?MG9uT0pEWHhpaEF0c1ZUTk5YRGgxRE50VVdDbWhDRHNnWW9LS2R4MEc0Zm8y?=
 =?utf-8?B?MDg1NkRCR0JWaWlva0g1Q1hERGhmOTJYN1l1NTNmRGE2dE5Fa1QxOEpxeFQv?=
 =?utf-8?B?NmtBbW1HUW5HRjdCbFNFdU1WT3kwWk1uUC81UUZxMGd5a0gwbUNZRnhtRWRJ?=
 =?utf-8?B?Ukg3T1hzekFnUWIxZGQzL0NTZmpzMG8rdGs4T2V4VVNNbzc5eDBreGJmbzRI?=
 =?utf-8?B?bml1SnB4MmxmeHdvV2kxdXVpbnlSek5ra0hieUVnQTlBdjNBREx2eFRYWnF5?=
 =?utf-8?B?MWtYamFUVzU3VW1DbzNzb0RsdGxBSHgzZUt2YjYxSWk3L085UmxBV0F5cmVI?=
 =?utf-8?B?aWhROTBPVVNvR0lKVk1UMXAxZXgrVGdrbWxwbS9PaU9kQmVXZ05jQTJiS0dR?=
 =?utf-8?B?SnBDZ3kvTE93UXlSQ3J3QVpqbUJBRGNXeExYbUovY3RKek91T3VPSnpZUnRi?=
 =?utf-8?B?Nm1vajFtNmlHZCtQZFlLWTUyaTB5eVJRT29nYkc1YS9IZUJRc3BuM1dsb1l2?=
 =?utf-8?B?YkJFcTZtUFk4b2xJWG1OR1I3bm1ySVhVVVNnYUpwcDNUbFcyRHBFVFNDKzlK?=
 =?utf-8?B?N3BMdk9wWnVyZndhWWtxQ2x3OHVzcTNWaVUydkMzOTFMd2xLWUZLWVVOanpI?=
 =?utf-8?B?aTFSakwyTTVpUC8rcWMxTVJiTHBOdVNFMjNyYWJmRGlVU05OYnZNeHU2MzNV?=
 =?utf-8?B?QU1oL05POXEwTmxTM042T1hJQnlRNzBza0UxcDB0VXJaSlVwc0FxOHFlQ1U2?=
 =?utf-8?B?UWg3cERzdmp0YVE2cCtmeWF5Vi9tWTlDUU05WHBrajlSY0dTcjhtdFRhb0NL?=
 =?utf-8?B?MW1jK3NrZk1nTGdINERENTBEVVJ1S2w1Y2tCdFVNWlQ1Y1VFWkpnTzMxOVNM?=
 =?utf-8?B?SnFUaE1DVER6MjhnMnh5bXpKNEpYdjQwMW9QcDJkS1BMNmxOOFduNmx6cFBz?=
 =?utf-8?B?VE1ucXFOVDg3MmNmWlpKbkxhdDJOUVR1SDJqMTBSamM1eFlSS1JsaXJFejQv?=
 =?utf-8?B?dmhSVm5mQUttK1J0Z01lSGN0cjc1bE1jc3FUcElHU0hPTzFYb3Q5S3Z5M0hS?=
 =?utf-8?B?UHEvMFcrMG1TM3RDTy94eGdZeGpMNUk4YnJYME1HbGp0MGNkd1JGaW83R1Fr?=
 =?utf-8?B?S0dBV3djckdMR0lHbkkwZ3I4VWpsZXFYRnFJemFiN0NIZWx0R1dVbzAyYWpN?=
 =?utf-8?B?dExBUFFqZzhVNlE0T0t1TlpqTEhJTkNLK1JvclRLWi9DSmlaOVM4MjZvWS83?=
 =?utf-8?B?WWIrTWMvTzBTRVM4cDhTSkx0REFNZFNmOTdFUVpqQ0VGdVBRMHVCN3lwdTZ1?=
 =?utf-8?B?elUxNVNuMVNwMkJWRVdqTmlVUGYwdTJ0NnlDczdKc2dtSnlITXFzRUJGaWF1?=
 =?utf-8?B?V0NMNHlZTG9FUllaMmVwWEFUYVgzRGowcmJJRFNDbFNQcUdpeWtBVzVTUDU1?=
 =?utf-8?B?ZE90N0xjbVJIU056RklGNmM3RjZPS1htTUJBL0o0MUtOY0h2WXkyaVdRR05r?=
 =?utf-8?B?ME1JcDRIZ2l5eXNZS0VyZ1RJdGY4NzFQdENlS2ZBVTZwNHJtUmxsd1BKTEJI?=
 =?utf-8?B?aGg1TWlQWi92R1dYV0xRZWxSZ1lVWjB4emErT3d3TTR1UHQ1WTcza2dmSE5B?=
 =?utf-8?B?NzZ2Rzh1V0dpNVZIYVFQaFZqaUhBeWt3b2FCRWJ5a1pjYk9vSFgwRU9kU2dT?=
 =?utf-8?B?Y2xkRFVscHpBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e9a56eceb0e74ec18c721bf259b1d042:solidrun,office365_emails,sent,inline:2f10c3d298359afb8bbfb24d363b8ebd
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3c967079-23a6-4cf1-63d2-08dde4cee07e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|376014|36860700013|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzlSVjU4RktRNFNJT2JlU3l4WWIrU21GdXhlL3hhS1J3SlhNSHc2b0RwbTZJ?=
 =?utf-8?B?SE11bndCSFhWTGJ6c1JTUVFmUkNkMEMyQmNtdnFRV1R3VFJ2OElyZ2E1eFFl?=
 =?utf-8?B?eW95S1lhS3Q4cm5ieDlYMTJDSVBPMlp0TXh4bjMzdlRPYXhHb3dQbGRVYnhO?=
 =?utf-8?B?VEMrUWQ0OENjMUpBZ2xmVGRMNlkxYjdXdmEvN2ZJVzlETWRYdUhxVXg4bWtP?=
 =?utf-8?B?bC8yUXJYcU9pZkVWYno1T2RBek81TDIvVDhOditpMmgvdVhmTlAvZVlKcjRK?=
 =?utf-8?B?eGZnV3VNam5DOG9IeDY3MEJqWlJBaVJTd0pmUVR4SjdlVHNOblJGcHozMXJL?=
 =?utf-8?B?L3Z2MUk0Rm9laklBa3JLSlRzUGVLQ3ZFdm9HaERyTHFSWDVNTHZWb1BQc0R0?=
 =?utf-8?B?TGE5RXRpVGhnQU5MaHFlVW1qMXRJZ3RpaHpER1BnYlkxL0ErVTFZREEyWmdP?=
 =?utf-8?B?eml4VzY1dDg5L1dvSTJyVThQUUF2c2NZQ2pKVFRvV0x5OU4xY3g5blRYZFUw?=
 =?utf-8?B?TWpJZm92ekM0NWhsYXluMzRhb0tydjBLbUxxMDNFVlE4emJSQmRyRXpjTVhQ?=
 =?utf-8?B?ZmdIY1p3dkJFaGdCUVpPZXFtR1dIdmpTNHBUbUVjL3NwbGtZV2o3emxMdER0?=
 =?utf-8?B?Q01WNWRHcFVJQzYxVHUwNEgrMzNxdFpWby9tZXZJR2hFL0R2cHduenRGNXZo?=
 =?utf-8?B?dFdxeGVublYzSEhHMW8vbXRmY20wc3pxWGtZdWtuNHRpcUljV0V3ZjE2WHpJ?=
 =?utf-8?B?VkN1VzVCclE0MDNCY1daMEtWUlNCK1p1bEhsUVpYUW0rUUdva3hFU0cxeHpq?=
 =?utf-8?B?ei9FT0JjdURCc1NxaEFXeWQ2T1JwZEtaSlBHdExOTVY2am5reXRvQ2ZSYjZP?=
 =?utf-8?B?RytCeGVCZGF2MStBT1dEcFhjUzErcFpjaGFhM2prR2ZsNG9xUlZjLzVTTVhH?=
 =?utf-8?B?bHRhdjM5ZVV1L1JhTjIwcnhsQlVGZDRKdGJua0d6RmJjUlVqdW9FWTBaNVo0?=
 =?utf-8?B?dW1kSkRMcFplOFJydWJiZjVIOThycDRncUd6ZHZDbmJvWkhQWnlqRU1zWEFu?=
 =?utf-8?B?SmtPR2ZMalhndWVqS2ZpM0V5M1JFckc0cmxOVWlQcWNod0JmeCs1cXFvb1lp?=
 =?utf-8?B?WXp4VEp6MHJMUGMxblMwSmRGKzFuTTAzK2ZKazlhWm5KZ1JoQUxKcHBNWXVH?=
 =?utf-8?B?d1lqN3pzajBHMVVONkpVUDZsNFhtekhMMUhnOGdrTnF0ZjlueDFQSk1KSUh6?=
 =?utf-8?B?N0g0UGRUbWF6VWk4bGcxWjBHT1pkR1JOQ3E4MndlbW43Sm5wZnJORlgyOFM0?=
 =?utf-8?B?U0xkYVVGMHhuSWZ3NjROMmVGM21LQVJxK0FPK1pwQ3RObUhUUE9FN0ZQTFdh?=
 =?utf-8?B?WU5TWW9lRmtqVXdSTFVPaktPZWZmK0dYQW9kU29zMHJYbUt4aUZzcUNJeTJZ?=
 =?utf-8?B?alNCNTBRUjRTWUNFWmowNFVialdyV2RHcUFRSS94KzNzS0krbVowN0pZcGZu?=
 =?utf-8?B?d0krTlRoUFhUUkxWekg1M0FRbkp1RkFzSUtnUXlGR0RXVHNERWtqWW9Ea2NB?=
 =?utf-8?B?QllaOUVnbXRBSktNZG55TXhiTG5BOXkvcDJIUDN5aGRYVVNaVXhLb0wzMDJp?=
 =?utf-8?B?V3J6QmRMNkY0aDJGbWJEMmNlM0I3MUxHVW1KNVZib3BON2t4K21iMW95QmxW?=
 =?utf-8?B?Q0NoS0tnM3JZT09FWkVWQzQxU2RaZGhYeXI5ZGlJbmhLTzJlSG04TVFzZzVt?=
 =?utf-8?B?anFwdWc0YnE4Q041Szg3VGwxWXV4bm00S0hMVVdrM1RnUHEzeU9jbGljVXc0?=
 =?utf-8?B?VWN6TXJTZyt1SFFCZ0lXZjdUeUNaaFhMQUFYUGlOSUxOdWFBc3ZjRTJtVktQ?=
 =?utf-8?B?MG5NQWk3NzFwcE9vbE5JVFp3YWVjUS8wbEZ1dTJOU0lHempkQ0JxcHZ3bEt2?=
 =?utf-8?B?ODlFU0JLMDBqQXhmZE1kZmN3dUVRdEkxRUYzd3c3RlozMVhXUWxRSnFzcDB2?=
 =?utf-8?B?Zzd4eVJwSzZpL2pSbHE2dUM3Zis0NDVFeTRxRmQ4R1FTam92ZnUyampxUHV2?=
 =?utf-8?Q?Kyktzq?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(376014)(36860700013)(14060799003)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:32:25.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d35a219-9c70-4c87-f32f-08dde4cee77f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10672

The lynx_28g_pll_get function may return NULL when called with an
unsupported submode argument.

This function is only called from the lynx_28g_lane_set_{10gbaser,sgmii}
functions, and lynx_28g_set_mode checks available modes before setting a
protocol.

NXP vendor kernel based on v6.6.52 however is missing any checks and
connecting a 2.5/5gbase-t ethernet phy can cause null pointer
dereference [1].

Check return value at every invocation and abort in the unlikely error
case. Further print a warning message the first time lynx_28g_pll_get
returns null, to catch this case should it occur after future changes.

[1]
[  127.019924] fsl_dpaa2_eth dpni.4 eth5: dpmac_set_protocol(2500base-x) = -ENOTSUPP
[  127.027451] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000014
[  127.036245] Mem abort info:
[  127.039044]   ESR = 0x0000000096000004
[  127.042794]   EC = 0x25: DABT (current EL), IL = 32 bits
[  127.048107]   SET = 0, FnV = 0
[  127.051161]   EA = 0, S1PTW = 0
[  127.054301]   FSC = 0x04: level 0 translation fault
[  127.059179] Data abort info:
[  127.062059]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  127.067547]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  127.072596]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  127.077907] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020816c9000
[  127.084344] [0000000000000014] pgd=0000000000000000, p4d=0000000000000000
[  127.091133] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  127.097390] Modules linked in: cfg80211 rfkill fsl_jr_uio caam_jr dpaa2_caam caamkeyblob_desc crypto_engine caamhash_desc onboard_usb_hub caamalg_desc crct10dif_ce libdes caam error at24 rtc_ds1307 rtc_fsl_ftm_alarm nvmem_layerscape_sfp layerscape_edac_mod dm_mod nfnetlink ip_tables
[  127.122436] CPU: 5 PID: 96 Comm: kworker/u35:0 Not tainted 6.6.52-g3578ef896722 #10
[  127.130083] Hardware name: SolidRun LX2162A Clearfog (DT)
[  127.135470] Workqueue: events_power_efficient phylink_resolve
[  127.141219] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  127.148170] pc : lynx_28g_set_lane_mode+0x300/0x818
[  127.153041] lr : lynx_28g_set_lane_mode+0x2fc/0x818
[  127.157909] sp : ffff8000806f3b80
[  127.161212] x29: ffff8000806f3b80 x28: 0000000000000000 x27: 0000000000000000
[  127.168340] x26: ffff29d6c11f3098 x25: 0000000000000000 x24: 0000000000000000
[  127.175467] x23: ffff29d6c11f31f0 x22: ffff29d6c11f3080 x21: 0000000000000001
[  127.182595] x20: ffff29d6c11f4c00 x19: 0000000000000000 x18: 0000000000000006
[  127.189722] x17: 4f4e452d203d2029 x16: 782d657361623030 x15: 3532286c6f636f74
[  127.196849] x14: 6f72705f7465735f x13: ffffd7a8ff991cc0 x12: 0000000000000acb
[  127.203976] x11: 0000000000000399 x10: ffffd7a8ff9e9cc0 x9 : 0000000000000000
[  127.211104] x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff29d6c11f3080
[  127.218231] x5 : 0000000000000000 x4 : 0000000040800030 x3 : 000000000000034c
[  127.225358] x2 : ffff29d6c11f3080 x1 : 000000000000034c x0 : 0000000000000000
[  127.232486] Call trace:
[  127.234921]  lynx_28g_set_lane_mode+0x300/0x818
[  127.239443]  lynx_28g_set_mode+0x12c/0x148
[  127.243529]  phy_set_mode_ext+0x5c/0xa8
[  127.247356]  lynx_pcs_config+0x64/0x294
[  127.251184]  phylink_major_config+0x184/0x49c
[  127.255532]  phylink_resolve+0x2a0/0x5d8
[  127.259446]  process_one_work+0x138/0x248
[  127.263448]  worker_thread+0x320/0x438
[  127.267187]  kthread+0x114/0x118
[  127.270406]  ret_from_fork+0x10/0x20
[  127.273973] Code: 2a1303e1 aa0603e0 97fffd3b aa0003e5 (b9401400)
[  127.280055] ---[ end trace 0000000000000000 ]---

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index f7994e8983c8ecf52148ba4024684c0c452fc5a1..c20d2636c5e9c079d9178fdfa9030dd8041ce0ba 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -188,6 +188,10 @@ static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
 			return pll;
 	}
 
+	/* no pll supports requested mode, either caller forgot to check
+	 * lynx_28g_supports_lane_mode, or this is a bug.
+	 */
+	dev_WARN_ONCE(priv->dev, 1, "no pll for interface %s\n", phy_modes(intf));
 	return NULL;
 }
 
@@ -276,8 +280,12 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, LNaGCR0, PROTO_SEL_SGMII, PROTO_SEL_MSK);
 	lynx_28g_lane_rmw(lane, LNaGCR0, IF_WIDTH_10_BIT, IF_WIDTH_MSK);
 
-	/* Switch to the PLL that works with this interface type */
+	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
+	if (unlikely(pll == NULL))
+		return;
+
+	/* Switch to the PLL that works with this interface type */
 	lynx_28g_lane_set_pll(lane, pll);
 
 	/* Choose the portion of clock net to be used on this lane */
@@ -312,8 +320,12 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, LNaGCR0, PROTO_SEL_XFI, PROTO_SEL_MSK);
 	lynx_28g_lane_rmw(lane, LNaGCR0, IF_WIDTH_20_BIT, IF_WIDTH_MSK);
 
-	/* Switch to the PLL that works with this interface type */
+	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
+	if (unlikely(pll == NULL))
+		return;
+
+	/* Switch to the PLL that works with this interface type */
 	lynx_28g_lane_set_pll(lane, pll);
 
 	/* Choose the portion of clock net to be used on this lane */

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250826-lynx-28g-nullptr-15de2b5b1eb6

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


