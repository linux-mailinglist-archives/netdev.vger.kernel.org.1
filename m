Return-Path: <netdev+bounces-166656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253EBA36D0F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D69171ED4
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 09:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23AD19F419;
	Sat, 15 Feb 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozSBh3BK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yrahqH1p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC319CC06;
	Sat, 15 Feb 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612466; cv=fail; b=t1eXmCqn9NQuyS/yDgshOHGtoiljd/QH6pZ4ywo+6pmtC2aHCffbHJh3mMThTalP1OMvm7WR4UOoD4fOX5PN8QPL1PmaHdVbgdFcadhGvxUgJVCAwoeDrgfOoAW+MPKZjLs+s05DsDgABOZ8SP/2pbpArj3bStE7H5fHa7ahOHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612466; c=relaxed/simple;
	bh=ijDW0Xshg+Jju2FWGo7c0BU14ptMq+tNDhRpgotr3i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9TjuuEDnQPqYVfUifBC7j/l4WNES+wo2tcUk/XmfUvAY9mpNS5uYyTV6mSdFEe1eirGp83aw3MzpIxgxjsADoedCh4pYdZ6GjltMXSyy6/u6GSuUhAl48h691dJgR87/XCprifmARO+/vbvs8/FgoTE3PLc3jBpT3cD9Xz8fJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozSBh3BK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yrahqH1p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51F4FwkD022775;
	Sat, 15 Feb 2025 09:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tHVD9prNsBP17Y2h8J
	C0oF78Xq5Gi32BYgFablI3/60=; b=ozSBh3BKl3FkWUm45NF3Ydlz9LvD4GkGSx
	pcy/MFrpYh1GGzuAWMVthi9Dsc640kJi8MPAd59oc9bRUR6Xm5z1WzIVaWVeqX+n
	bQt62cFuoY0SuvhvP5RuVUwYlkFychaX0OAERpd5wFlmPGQTiPaxHZ9Do5zylPL5
	70Cak1xndj9yeAJChHvvtwMpR+N2shcdnW2DBWVdz3cfXS1Ry4KN3uVmRcxRWwgi
	Dxft3y2jbAcBGJzBK11V0vajaCL/OHY7067QhAxAbjPC+ULN7LVMlGlAHdE+zrla
	TZlhTmD+oi01jmAorrl3zgcLQy3qB207x3HTnpjnnzaOWqClkJWw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thua885f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 09:40:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51F6BjMO002066;
	Sat, 15 Feb 2025 09:40:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thccfg2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 09:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1c2E5Yy0IaENSaxb0L/UL1yM9PefJdpj+8JT9IWhSMVTHdxXNK3/BxKrqWytAcyqs9kcUfTxb28wtv8p2tCq/cifAegv1vnNUU48ltUxo5qumur2PR5MmQOQY7P02VbnjVV93AaPv6vY0nd6fT4VDbx/f2XJ7Tud14mOIw+423/z4tMMR5SuDpaFAQwUGY0qHAvxbrwUDbCwGUhREz1XilpLs+joP4Dda1WZG6zhpNX2D7zNIymTKZ+fNxJFL23up2JKX3Hp3yt5S5qi/mF7dU74nmMqmrqkv5+d3yGiL7C8JViTOTRXmdF5kpkekOeLkHD4IRiaRc437ZbhnM19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHVD9prNsBP17Y2h8JC0oF78Xq5Gi32BYgFablI3/60=;
 b=hMin7sOsnXnKFj0+u5Vs/VIbTEPreif5kk1SaE1lW5sjmC9hVd/2ZFqjwCfRL/vUhIubUqU6D5jv+jJJ/+a0hIAiuReStPRVewTSRkWhQr/NCAg90ViELY1Nr/5qvv6BHPnPlTNUvrClOsjwbmPQbxW1gbDMY5LjpfKkQV09eJfdDK25gIKK2Nmm0ktlQ8RdsLlx6TUOqfTjX2xuM4gwAlEq5fpIHzMzzsyfYblh8JBwCkxnmBfhLbArtj5sNaL9uYnBmC56l5MeS7zzyZE7uRrrkG+gXvG9qM1xkkhdkX+7Z8jhK/6w4SH+udeQvrRaD/ZG3X/WBLDxTMgquSGmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHVD9prNsBP17Y2h8JC0oF78Xq5Gi32BYgFablI3/60=;
 b=yrahqH1p+6e7hJjZt93JYekhrrhOkzjYeeaCdSpfMQLFTx+gVb/bKoPnvWU3WzZkAhGIxKLgeqRkT8phPXBvVDSU1VWFYS1Rhx0P9qy5djbfaYT/vArrp+O0NKLCO6sxT/N6hoda8vXJ0ZiscM/7Nh7EyeM+kN323wHivFB/vLg=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH2PR10MB4231.namprd10.prod.outlook.com (2603:10b6:610:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sat, 15 Feb
 2025 09:40:52 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.8445.016; Sat, 15 Feb 2025
 09:40:51 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] netlink: Unset cb_running when terminating dump on release
Thread-Topic: [PATCH] netlink: Unset cb_running when terminating dump on
 release
Thread-Index: AQHbf42ziGwWUCk7jkuMfqWT1BMwZw==
Date: Sat, 15 Feb 2025 09:40:51 +0000
Message-ID: <aff028e3eb2b768b9895fa6349fa1981ae22f098.camel@oracle.com>
References: <20250214065849.28983-1-siddh.raman.pant@oracle.com>
	 <20250214170631.6badcc24@kernel.org>
In-Reply-To: <20250214170631.6badcc24@kernel.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|CH2PR10MB4231:EE_
x-ms-office365-filtering-correlation-id: 04b7dd9b-e2ca-46a1-c601-08dd4da4d5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0U0bGI4UkJwWG5tTWtkcWF6Nlc3enFjL0xCTDFxZmYycWZJUGl4NkJ5OE9i?=
 =?utf-8?B?NGtzbGNwM2VaWTJBK0ZKNjEvQnB6WVFoU3k1TVFyVU50N3JCSjQ5QWljTTFG?=
 =?utf-8?B?Wll2Vkd0WnViRGhsOHc2YjZGMWJsRy9WcjVWVzR0aUtMMThRbnV2Q2x2Unhm?=
 =?utf-8?B?cjlKL2hDVnBGZkZIQW1WSjR2UUFWaXltOWhyY1UrM0xab3RDRmVnMDEyOEgv?=
 =?utf-8?B?bUdLaGRzNEFTcklzOExWNnRhK09MRTFXUVZQKzd5NUpXSGd4c1kwZmNvQU8x?=
 =?utf-8?B?UHFaOXBYS1R4MEs5MnQ0eGQ2VWVEYUdkeVlVUFg3UnlCQU1YK0FrQ1Z1anFX?=
 =?utf-8?B?bVJEZnhaRC9rYnREYzUxUStVNHVCeVBJbkNNcGVQdGNOTUppNmoxbDB4cE1Y?=
 =?utf-8?B?SlY0R1lNdCtWVGpSKzNiZUJuOGdkUW9xbHl1cFNsaURIanZkRzV5Zm5pbE4v?=
 =?utf-8?B?ekhiOThUMGp0SS8yaHRTZ1pHMkFqb1VGbDZnN3doeVZ4WHlkRnY1ekRjMTJ2?=
 =?utf-8?B?Yi9yalhqR1VVZXlwc24yTGR5RUYwZkVvdzh3eFVVSXN3K1lIZ3k2RExsMzV0?=
 =?utf-8?B?ZTloU3dzZ1lWMENCZnRzUWh2OFovUmRLZVRZc1d1elJDOUdGS3V4cStmbWdB?=
 =?utf-8?B?OGtiNmMraVlqZGl0UXY2U3ZJWDFWdUxuNkllODY2YkZxcHQrczlrS08vVndO?=
 =?utf-8?B?bGNsVmFqL0IyNWZoeW9MMEx4R0ZEbmxRN3BtdStkWERtYVE2Z2FOVURNRkdK?=
 =?utf-8?B?M244UytkQ1JTTnZXTElNeTRjOFEyOXpneHJwVk9wNnpmWXZVQ01DVEx4bnlQ?=
 =?utf-8?B?VTZISzYxaUFxcUczUHhndlZ2dW9zMmlaMGk1V3JMU1czS2E4ZlAzWVkzelA5?=
 =?utf-8?B?TGRtU0wrUi9MN2hTQ3k0MjMrZVlUNHpML0RKTGdrS3MzYlgxNkRQamIyY0VH?=
 =?utf-8?B?Q0dzWStOakhTMmIyZlJvRTdPK0x4VXczTGFCbmJmc25tbEU1RjNZVnI4Y2Uv?=
 =?utf-8?B?aWdaaUZreG9sVndsUDJ0V0VEOHpWTWpsOURUcTVKREMveEcyTnd5UE1qVDhm?=
 =?utf-8?B?VjhCeW9JZ3JabWxNM3RoL2NIUkY1bGZpVXh4dU5IZExsMWdXSEY3N0tidjNk?=
 =?utf-8?B?Y1hrK0h5UUxySUlnbHk0Vnk1K3loeVA3bTVueCtVYnRHU0tvUmtxcEhLU2Fq?=
 =?utf-8?B?SklwKyttMlhXaS8wK01YMmRQcTlOcGh3Tmxhb1FCcUV0dWtCZEJDZmI0R1g2?=
 =?utf-8?B?Nk9IQVpWbGtCc0RPczZKUEtSSDBJdmpBZ1EzZUhGYlVlTDA3NzhTVGNNKzdw?=
 =?utf-8?B?SzVXQkZrWm5OYTVYN01XZHRDNGFXVzMwSlM1c0FCTEZJR1BWYnZHM3V2cWg1?=
 =?utf-8?B?RDVnZHU0Tm5lL1F5SVdrYWhTNjk2TUQ2dUFGbm9oY1NyVmNrTjNJbTJ1dVJH?=
 =?utf-8?B?YU9ib3Q3VFhJOU8yUElKYUxsYUozb1NjNnE1cG5JUCs5SUFtYmZnUmxmdjQ5?=
 =?utf-8?B?eG5sYnAybjlyVG1yaVNKSzVIakxiMmNJcThob2RBbEZQN3pJTlB4K3ZEK0R2?=
 =?utf-8?B?WXZ5eTdDSTJUZmlkalRUMnR0TmlJdWp5TlNIaDJ0a2swUHRnOFBwdXVaK05o?=
 =?utf-8?B?QzViNDc0YWJwV1BnRTJDWEc4aEVOQXdkOEhzRElsZHlTd0FDRmk0ZjZsbmJI?=
 =?utf-8?B?QmV0R25pWG5iK3liTFoxRkF2VHBHblpRV01OMi9OdGVqR0xWQzdYMWZjUmxX?=
 =?utf-8?B?eWExN2tIcnExUU12TVA0WU1mb2ZydUxEZ0hKdWVVRjFxenlDNzdSckpqMmFa?=
 =?utf-8?B?QnZkMjRBdWJ2cElzYzdZR3pqSit6YUE2dTR3RU0yU3NCMjdlT3EwNFFHcHpy?=
 =?utf-8?B?ZkRFSmRSLzlNZk5saVhnQW5yKy9IQndSQ2NJbnNMNUR1RjQ3WWhLSW4wNXdN?=
 =?utf-8?Q?LegCr6JnTkQ36AvlAiOwkkxvCu6EUcQD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blJ1VEhLZHp2UkF1N0hKNlFiN3ZFN2c0MXlxMUV3TVBKazVPcDl1K3FReDd5?=
 =?utf-8?B?K3o3bHFTTndTUnczYTUrTG1wRmdrYmdKOHBGQjVGT2lWZEdiMW1iQmdzWTZM?=
 =?utf-8?B?ejRSZHVWNUp0cEhOcnUxMWhpQVJtenI0T0tRR2xPSHhxeXBueDVySm90MUdW?=
 =?utf-8?B?c0Q2ZFBPUFJBMm5CTHNlakx2WStKYldMOE5kZnl0WGR5bWJHS3BVSE5CV3ND?=
 =?utf-8?B?VDZndGRSWVhCZVFjZkdrcVVTVkNWZzJOWit4Z1VXTktNRS9FdUVNOEdCaFNS?=
 =?utf-8?B?TjI0RlNreVVXUlR4VGp4czVrZDdSRml1YjhOKzd1Y2pOa21LVmYxZGYzR1Nr?=
 =?utf-8?B?V212MC9TbTV3Q0MzVms4eDZ2V1dJVjlCbGV3aDBZeDZ0SXZ5NVZFTS9Qb0I2?=
 =?utf-8?B?ZE1NUnZITnFDL3JZdmFhamRXR1ZUaXRFNGk4YUZZMUY3NzJVNWptclRYRTBl?=
 =?utf-8?B?eU9NZmx2aEo2bWE5QmVndGxyU3d0c1NtY3YrVGVWS053YUVZdEhCL1VwT2NX?=
 =?utf-8?B?U21wN1g0VkJ4a0ZTdGdrQ3dKTFIvdkh3V0ZOVmR6aDlyM0ZIYXpzam5RUE5p?=
 =?utf-8?B?VFFDZGlrT05veXZKSHM4dkxVTmZiYzJNYjVYQkNNTDJHYTg4SnBoZk04bUs3?=
 =?utf-8?B?T2dNa0YvTTVnOUJVYUEydHMvR3JGUzJHQkZFV1BKUXN3WDNxTFpKMGdXdy9q?=
 =?utf-8?B?bWIvWlpBdjRTNytwVTZPQjdpRlZFVmQ1U1l3cWMwSEpXZDFiWnp0SXl6OGw1?=
 =?utf-8?B?U3lLMCsrbitMNVBEOTJ4RmdrQTVKbVE1b05wVmhQUEVCOUp4SFkvRVFHV2gv?=
 =?utf-8?B?QnI5L1BmWFZLTldGV3M4K0M2MjgvL3ROVnNLSFQvM3lDcmc5NXA4R2JOT3FR?=
 =?utf-8?B?QU1GZkkwTWtQWC9NaElwNFZBeUFHM2szMkNvZGdXbDBTWHIrSnY5am4wd3ZM?=
 =?utf-8?B?UFFEWHZwbzhhS2FjWHNzWFdabFplMFVlZExwa2k1QUhqMktQTzRhSElWaWxJ?=
 =?utf-8?B?RlVSWHpKajVidXpuZFdpdFNtajFRb216S0VOWTkwZmdvMTUwR3NmdTVmYU9E?=
 =?utf-8?B?QzF4cGNJeDZHUmFiMzhNLzQzdFZ5L3ZmRkhhSmVINllwZUR2MTIxS0wxMkVU?=
 =?utf-8?B?dDdId0JOUDg4YzM5VTFiQVZuSGN0SlFPclNyNGZUaS9UbTBWV3NJeWZnSXlj?=
 =?utf-8?B?T3YzdndFUDdBeWtaZThESDRvaTNBelViM3FSMk92UjhQQTZ3Wi8zUHpHVDJ1?=
 =?utf-8?B?SzFPK29uZC9nS09JdVFGeUR5UG0yTWFPUThvZG5ySnRnQXI0cGh2eGVvV1Qz?=
 =?utf-8?B?S2I5NzJiNE1rNEZMTGJLN1UvOXoxemdJbXhaVlo3TDJYUURtWnA0VTFYWFl2?=
 =?utf-8?B?dW5IWXVDOU1FY1czdURYVjNheGRFMG1HQ1d4OXZaSURPZXVVeUtoaWZ6SUc1?=
 =?utf-8?B?dnpGenVFVWJuekpCd0UzMFV0bWNNZGJQa2tqRUFUNG5uakVKODhwYkx2UGJ1?=
 =?utf-8?B?c3hnSEpGNUpFekR0eVk5Y1F6czd4M3JOaHRybHdjdEJXRUJVUjRCMUR4L0pL?=
 =?utf-8?B?WnZBY0k2RnI3MGlmMUZLQ3VQTWZlNitZdWZqYWNlaVRRb1BvZWptV1lmLzBh?=
 =?utf-8?B?TjZ0d1Bkbjk4dlg0V0R4Z2oxdFBQQmRLT0dLSDdlSzZsVHNvQUdmR2RBdUZn?=
 =?utf-8?B?dXQxUG9pSVIzK1VkM1Y3em9UY3l5TXlXYmxLM3NDbE52VzMrZ1NGR29uUEp4?=
 =?utf-8?B?RXUwRXRLS21wdlYwRFM0ZW9sNjByZFI1V1pyS0ZRZjUyRWNXVVA4UUZGK2No?=
 =?utf-8?B?U1E0MWFYSVlMVnNkWTI0S3k1ZkJxd0Z3R2hrVStQOXlrTkFReUlZWjRDQTBh?=
 =?utf-8?B?MjdMVnRSN3pLbk1YTkMzSEVKMWc0SXFyWkpReFR1bFNKL1J2T2VIeE5saXJM?=
 =?utf-8?B?c0dzQ1pVOGljZDdFVmw4dkE4KzVxNlpCNllEOXQzVTZVZ1JLYWlyUTYxbWhj?=
 =?utf-8?B?T25ob0Z6SGgzV1RPMDUvZXhWTS9kbk5aWndMQVF4dmRvWG42WWgwZFlEa2ZW?=
 =?utf-8?B?ck94VXhXRUlQbWxUSkhwQzdCREhxMlNsWWVycFhGMVlsT2FDOEIvYVBkQ2tL?=
 =?utf-8?B?VHhQMTdSTElNTWRBMHpDNE4xWGJMQVlvZ2loK2t1M1FxZUZBQ3RCMGZwWlhK?=
 =?utf-8?B?ZkZBV0RXYklLZ3NLQmliQ2RaYmZsNHNrR2ZVV0VlN0h0bUc4RzdpZ3pYZXhD?=
 =?utf-8?Q?9Vb9ki/TxyyVe4mti57EzIlCfNHZ0pnbe10KB5fAq4=3D?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-1KXsW2zaZkBpPOJYBm0H"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zS2EnpjPpQbJmbbCxGrf6wX6FB22fGy01QaX1QtlrvsWARH5f5qBRjMU10r73/iN62sxchomvJEa6uy8KyBWMo3mk6NMezE6pVfdS0eShJuKTzZHoMqCHw5usxd4Wc8wmulSv1UGYva6ZsY0CxoDndfe9mJyU5lHkqMU+FGAU95Hm4XVdtx+OQ8kFjDeVODUnH4yPnG4MC2cMpUbx4ant+FVj/fHmCn6ze4kq2vxlGXG4fOen5LZZnrv4sSUweejnen3Ztn3dUSnibM7CZrLJgYNIB/M97aE5O7ZOUovA0cOcEYXxkVKFnHx9svpezgBEQryUMYieIkST20cF4Gh3vVYEmojx7qd5w4DRf805/pRsFr81SyS6A+S4m1QzJLI2D61S1VyootQl6B4Oa6bkM7B99+gRJReK7jNdOwZsoTROXyY6bFIcy3pjnSNGUpn97FsjBPtA/+qZuIoQcB6WVY9+t7No0zqP1Q6xztrvxdPR6fCNFW9EKJIjh5AzWIoUHA6dmMb5lPxVlAFyA9x6JKKZLq/ZUbyaxhWtefsIwZPcNdERetqbc/HinJNxgUA0P+1LcY1Bc8O6yAiAd6LpJLj+I6i7TjJ0HZLPWeFuqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b7dd9b-e2ca-46a1-c601-08dd4da4d5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 09:40:51.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNSx6U9BNbLOASNoppCbJQz2krb6fv8V33NS3W4jzepzkDTgcg3McvZGfjuaR2MmIxmbA4Qo9MZrgBicegAcvA2hfzeDu9QDmrWNPHy3sT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502150084
X-Proofpoint-GUID: QPcFLEds5aj3_eg9dBH9vksFDmWHPzd-
X-Proofpoint-ORIG-GUID: QPcFLEds5aj3_eg9dBH9vksFDmWHPzd-

--=-1KXsW2zaZkBpPOJYBm0H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When we terminated the dump, the callback isn't running, so cb_running
should be set to false to be logically consistent.

cb_running signifies whether a dump is ongoing. It is set to true in
cb->start(), and is checked in netlink_dump() to be true initially.
After the dump, it is set to false in the same function.

When we terminate a dump before it ends (see 1904fb9ebf91 ("netlink:
terminate outstanding dump on socket close")), we do not unset the
boolean flag cb_running. This is wrong - since the dump is no longer
running (we terminated it), it must be set to false to convey the
correct state.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 net/netlink/af_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 85311226183a..f8f13058a46e 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -771,6 +771,7 @@ static int netlink_release(struct socket *sock)
 			nlk->cb.done(&nlk->cb);
 		module_put(nlk->cb.module);
 		kfree_skb(nlk->cb.skb);
+		WRITE_ONCE(nlk->cb_running, false);
 	}
=20
 	module_put(nlk->module);
--=20
2.45.2

--=-1KXsW2zaZkBpPOJYBm0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmewYRgACgkQBwq/MEwk
8ioXxg/+IOsJ4jELup0476pBqLvYlD8lpwHxYHeyqn48Mzyhih4TYN3xShfW4Hjh
nihtkENzAv07+mGuShBSqzAkMpaV8vZUeKiGN1GY4H4mK1P8EZjhYAHonTCz1l3y
0Z7h/d4PRn7sopMeAUElrEzXwcSiAW5R/2tyvb58IVflo3r8wO45Yu8hRExUTb+x
7a4FxgzW+wdu4Mc08JjxU4p22QRBD/w1M5SEiWDahdVSHW43KdTP4onMv2RhUyHh
3QWvVE0uCLgem1r0wF9Qyo9HFBAz3JwQEl9rVWzXmZ1v4AeKPOq2QhPVcj80C1n7
GSR9ykJnOPWwvC6QD0IkKz0LNTdXI6S75vfw+LOWUZ8FcRz8JmiZkd1kGeMslbln
K4GypxUgZWjTtdtA97AP07tEpc/njYzGA1xSCDbB04VtHnegCfRHwNS3BcVWP1GC
tucwx7RDSKmm+uATL+EJwQohlcBslkqEyGuLtP68xASCli7yOfJUNPrDvXye70DN
lNYc6ob8q+C1Y2X5FOhf/sXV7v86vIuHHbywyBSuTnUJe6egHnE6lZGXSRSKGOvY
MdAnmSBR8/yaMQ4/alP6wT5sVCSiuMSd33/USkOcBfv8CtL7oiUtO6qaPzgA74pK
daTbPJYLsLwRtSbtzCRPmRgfO+Z+yh4Zo93I1v+ItvQDmlmnkhs=
=S1bK
-----END PGP SIGNATURE-----

--=-1KXsW2zaZkBpPOJYBm0H--

