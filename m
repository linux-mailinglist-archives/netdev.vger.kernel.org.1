Return-Path: <netdev+bounces-244448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C639CB7AAD
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 03:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D75643016CC2
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 02:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43985275AF0;
	Fri, 12 Dec 2025 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="R6Runyhb"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25162737E3
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506447; cv=fail; b=eooKSQa/Q9wxQk0i+Nnl/gLMuiUpWCZJTlTnkguurlnwbIf8coldONwwcZvw8sRqY8Z5SKgbRKDPgincJvqDnRQ43fJRpQkc9WPftH7C5NJ+at3X+/aVUxBtJdBphwsQU9yU2Shj3XLBTkugj70qS+g4xtc6f6GhzgUltVwzdCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506447; c=relaxed/simple;
	bh=cCFTenI+Zenx9YEOcI1ZaX+QhnZkzkaKlYxDQ+hvO3s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h/yquhJqac3YgXH8FHI9ek5Dh8CfWEWc1D2GtF3q+oePGqSVir0v3eiMs6yLdTumNNi5poNibNORnUB0z9SWrESHetzrXjzrSPmfFjkyFQbId3F0SBUNL7qgul7I4NEd8olQy5LO44IUofewiYa4hPghPBvYBC8BeI+5NUIa58M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=R6Runyhb; arc=fail smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1032; q=dns/txt;
  s=iport01; t=1765506444; x=1766716044;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=cCFTenI+Zenx9YEOcI1ZaX+QhnZkzkaKlYxDQ+hvO3s=;
  b=R6Runyhbbc7jFcHjsp+ie95fsLvZ7XF4zpZYXaiPbN3yVcPThEa/lsso
   wGCzvOB1F4lx026ePX2ugz0+C/+r+K6boNuMZnYd4O1YrC/W9JUCr/qjW
   B2bwguIEuOWLJZL8PEOtRqkSHX7+xG0304WtvayQmkJSBAJGsmp0y+Ezd
   Aw8lY5SPdQlmGX/Wo687q3DTDHpv02HY6RrktwYKMP6ZHvdA/f8713tlb
   +y1cnHOBD7vbEZjdbVd9KN9zcchAmC8vGgz/FVHQuMV07nbGDWAO8mPlA
   KqzHOSh8WhpXZVlZkJnTJnxdSJwe3WKLgELZ/ySorQHXcPDP1TfimnRak
   g==;
X-CSE-ConnectionGUID: giUIKpNuTEStATnKw5cBsA==
X-CSE-MsgGUID: T6n2jg1MQv2jDFPNWOudmA==
X-IPAS-Result: =?us-ascii?q?A0AxAAD7fDtp/4wQJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEXBwEBCwGBbVIHf4EhSYRUg0wDhE1fiHmeHYF/DwEBAQ0CRA0EAQGEQUYYj?=
 =?us-ascii?q?FECJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Thk8BD?=
 =?us-ascii?q?IZdFhERRRIBIgIZDQIELxUSBA4ngmABgnMDAQIOBqcnAYFAAooreoEygQGDb?=
 =?us-ascii?q?EFP2yYGgR0uAYg3GwEFbnuEOIRAJ4IogTwLEIMmaxoBgUQXBIU5OoIvBIIig?=
 =?us-ascii?q?Q6ZZQmBQRwDWSwBVRMXCwcFYYEFAyo0LW4yHYEjPhdzgRSDSR5oDwaBEYIJg?=
 =?us-ascii?q?UYGiQ4PijwDC209FCMUGwY9lQ1OgUCBUxo/III+GVcBkXczg1+aP5UXBgSEH?=
 =?us-ascii?q?Ip4gSaVUwQvqmuZBiKNZpU0LCCFDQIEAgQFAhABAQaBaDyBWXB6AXOBSVIZD?=
 =?us-ascii?q?444g2mEWDu7TngCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:mcdHEBSXv7szzqwA97E22OoeCtpso47LVj580XJvo6hFfqLm+IztI
 wmGo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk09JQ==
IronPort-Data: A9a23:LkqqOKopoiGlFVrFDDKWNBtXH+BeBmJWZBIvgKrLsJaIsI4StFCzt
 garIBmCM/yMZmKneI10bNvlphlQ6pXVmN9rGwo4rClgFyJG8+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgbNNwJcaDpOtvvZ8Uo34JwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0ul2PEBt7
 doFFB02cjm/gcGpnbmRUcA506zPLOGzVG8eknhkyTecCbMtRorOBv2Ro9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtPYH49tL/Aan3XfidZo0mIo/Af6GnIxws327/oWDbQUoLRFJkEzhrD/
 Qoq+UzFXBdANtPG7AObqHCAqNfpogTmVIc7QejQGvlCxQf7KnYoIBsbSVe2v9GnhUOkHdFSM
 UoZ/mwpt6dayaCwZtD5Wxv9pDuPuQQRHoILVeY78wqKjKHT5m51G1Q5c9KIU/R/3OceTj0x3
 VjPlNTsbQGDepXLIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:pwOQsa2Gneb4fCLyYqCNkAqjBcpxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6Ky90cm7LU819fZOkO8s1S/LZniohILaFvAc0WKE+UyvJ8SezJ8Q6U
 4OSdkFNDSdNykfsS+Y2nj4Lz9D+qj7zEnAv463pBkdL3AOV0gK1XYBNu/vKDwMeOAwP+tAKH
 Pz3LshmxOQPV4sQoCQAH4DU+Lfp9vNuq7HTHc9bSIP2U2ltx/tzKT1PSS5834lPg+nx41MzU
 H11yjCoomzufCyzRHRk0XJ6Y5NpdfnwtxfQOSRl8k8MFzX+0WVTbUkf4fHkCE+oemp5lpvus
 LLuQ0cM8N67G6UVn2poCHqxxLr3F8Vmj3fIB6j8D7eSP7CNXUH4vl69MRkm9zimhMdVeRHoe
 Z2NqSixsJq5F377X/ADpPzJm9XfwKP0AsfeKgo/jxiuU90Us4NkWTZl3klSqvpEE/BmfAa+K
 MFNrCu2N9GNVyddHzXpW9p3ZilWWkyBA6PRgwYttWSyCU+pgEz86I0/r1Xop47zuN0d7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUPhvAQOBl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBG+9QTPuwMdD4IURgMy3eJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR+TuKGP/cLw5qTEWm6MiXkX2fPdlzurTAWj+0P4jAreaw9DmTA==
X-Talos-CUID: 9a23:LPrT0WFhmg9A6cLoqmJo9XM1OdgDb0Hw92v5H0mbFjtiYqa8HAo=
X-Talos-MUID: 9a23:Vb04hQbX4WzbJ+BTi2Hq3jNtbeJR/f6sJG41t6ohpsWBHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Dec 2025 02:26:04 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-03.cisco.com (Postfix) with ESMTPS id D56441800042D
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 02:26:04 +0000 (GMT)
X-CSE-ConnectionGUID: PL1oG/mgQwaiOM0+b7RRog==
X-CSE-MsgGUID: d1sVtfdQRWKpmPxn2+b6uw==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.21,141,1763424000"; 
   d="scan'208";a="39719067"
Received: from mail-dm2pr0701cu00100.outbound.protection.outlook.com (HELO DM2PR0701CU001.outbound.protection.outlook.com) ([40.93.13.64])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Dec 2025 02:26:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpYC18fWu4KwWgA/gLFDPfFmTRLJAbyN+J76eTKUbfmf1hTFRL3P82UlOtIUSQMzRwY2J6rxpQGvSpz/996cmLgrKUpFhGfo2ZbOlAiPhxnJhiWwcPiyhl4/J6oC9cP/jVohcxURt4nelELYOEVAwViuHW3knD1LIZuBULgEK36By3fraF3nYf/Z6oImSvDVFYyDQ6Q3CScmhIBPiDDl43Pl14cfJ15FNI2cF4oUkJTCs6ui0iUZJGMCDa57AkrLe8IIo5JFLKlUcU2EzgJNKIdeJXMtrXZwnhz7lted3XC6cr6uMqT5txHo16WXOWg8rashibgLnHK7WH4onLPXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCFTenI+Zenx9YEOcI1ZaX+QhnZkzkaKlYxDQ+hvO3s=;
 b=Q0X1AzJWXV+XifmzurwLO+AMSc697uXIn5B1iwoXx7IZKZ/0TDa9v7/ZwHAnhH169JqAw687WXoq9oFPmtbZe4/0Wv4h9mbRMOqtBH64P9mqjMB3eME1PNIVzMNyYSFjvi3O6aG8RI0QG8HtLqBXGmCNB8FLR2br/X17lfK//jygkbwNNPuLmxIRxbA/y3ZzTDxm52tZZ9WMHTs1Wh2PO/EuNh5qksASzJuLoqtwEg2ESVwrafW8dlbeySuE3B5NVzoz9FGq77FfO/O6fyiGjcHy9/NiE2UheWoMkSWNqvxB1m/qZGAqeVvpGEJA8zSjg1VgkJJ9s9heOjdcze2OVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from BL0PR11MB3332.namprd11.prod.outlook.com (2603:10b6:208:6b::25)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 02:26:02 +0000
Received: from BL0PR11MB3332.namprd11.prod.outlook.com
 ([fe80::c4ba:5be3:6fd1:be2a]) by BL0PR11MB3332.namprd11.prod.outlook.com
 ([fe80::c4ba:5be3:6fd1:be2a%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 02:26:02 +0000
From: "Eric Sun (ericsun2)" <ericsun2@cisco.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: bridge-utils: request to fix git tags
Thread-Topic: bridge-utils: request to fix git tags
Thread-Index: AQHcaw6pmNbbyBYtj0CNwrle2e8ctw==
Date: Fri, 12 Dec 2025 02:26:02 +0000
Message-ID: <161B0C34-1F18-4010-B89B-738DA12F77DC@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_c8f49a32-fde3-48a5-9266-b5b0972a22dc_Enabled=True;MSIP_Label_c8f49a32-fde3-48a5-9266-b5b0972a22dc_SiteId=5ae1af62-9505-4097-a69a-c1553ef7840e;MSIP_Label_c8f49a32-fde3-48a5-9266-b5b0972a22dc_SetDate=2025-12-12T01:54:13.0000000Z;MSIP_Label_c8f49a32-fde3-48a5-9266-b5b0972a22dc_Name=Cisco
 Confidential;MSIP_Label_c8f49a32-fde3-48a5-9266-b5b0972a22dc_ContentBits=3;MSIP_Label_c8f49a32-fde3-48a5-9266-b5b0972a22dc_Method=Standard
user-agent: Microsoft-MacOutlook/16.103.25110922
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3332:EE_|CH3PR11MB8137:EE_
x-ms-office365-filtering-correlation-id: 6020d9a7-3d27-4ce1-47e9-08de3925cbb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzkwMmEvNi9jNlFIMWdHQmtkdzQrV3ZoK0NLV2hUbUpxYXFtUFBKaVYxMFk5?=
 =?utf-8?B?VkNoTlNyallKMEw4TnJjblh0SDI5aXlVc01Fem9QNENCb3ZYYzlXNTUwS2xw?=
 =?utf-8?B?QlRBR2FBV3EwNjk2T0JtcktvaTNYbnp3cWNlS0hXMVVGOXhnQXNsNUhiT1JY?=
 =?utf-8?B?Q2hibTZhMGJUN05hRE1rVEFuc01nWVpSZ1NZUlVaMVFzN0RESndiVC9meDRt?=
 =?utf-8?B?SmExc1NFbXJac1J5UU9KQ0JNdzZxbTdMV3hmQSsySStmQ1FFNmlaVHFyQ2dS?=
 =?utf-8?B?RjVOcWdoeUxlSytPWnZDYUNWQmdBRzhsRGZVNnRjbHIzdFpFeHZsZGhFb0Fl?=
 =?utf-8?B?Ymc3cktEcjBMeWd0bVFzR2JodGgwcTQwYXdpWXRHR0F5M0hpb3h1bERhTGJJ?=
 =?utf-8?B?Y1FINkZIbm5FMU9UNHA1YUZxdk1ObFM0ZEVHam9BUHFYRlErTFVLa09IMGNX?=
 =?utf-8?B?U0I4MzE5c1FlQm4zRzkvTnZlVnFKblhCa1dhY3R4M3o4UE1aRDRnL1R1RmFt?=
 =?utf-8?B?M1g0YVFoR016dlU4WURPUjlWY2NnTGowdExjQ0pjVnFLUFJMS3JYUDIrVmFn?=
 =?utf-8?B?NGdBZWJKdjhlV0pTUkViYW5nTG5VOTBWcDBOTTFwT05mZTFJTkNVeHVvUmlv?=
 =?utf-8?B?NThleXg2cmZuRlFPWGROWGdFdFZJN3NSNG0yUlpHT2Yrb0NONFN1MGxoaEda?=
 =?utf-8?B?WU4yNzJUYXNGVHNxOURqa0xBZlZTcUsvTnZnZUV5TlIwRmp6T3ZJdWN3MzZ1?=
 =?utf-8?B?bnFTMzl0L2dSMFZTNTh0QitJNUpWc0ljS2JRSk5lLzNOYjN1VGRwcmdLWDJi?=
 =?utf-8?B?RjExdURqR0xjeWNnaG9hUFZzcDc1RUFFcjZwQXA5TGRaUHNvZEF2QjZybExV?=
 =?utf-8?B?aGtiMG11cklzd0tFTGtFOW5qenBja25lRmZPNVJLaDY3UkVZWnlDZ01mZ2hW?=
 =?utf-8?B?UkFaT1c4MzFha3M1M1J2ckc1Tmdnd2xoWUN5cE1QRlB4SWliMGZvME92ODFm?=
 =?utf-8?B?VFRieTVaa3R6TDdoMmFxWStva0w3RVc1a2REdjltRFgrVVRLdXJvdlZKdlpD?=
 =?utf-8?B?aGF5VlIwN0ZCblp3WTFLanFOYVEwdlIvaHMvUHdyUWdXTUJicTZ2eitGUk5v?=
 =?utf-8?B?TjNIeTQ2Um5DQlgvNGRDS2tiSnVabEcwWCt1ems0OXJMZXJ1azloTitqQ3ly?=
 =?utf-8?B?VzNVMUljZHJoUHpzeFJtRnQvR21EYzBETnNpMitWRzd4V2k1U3JGdkhaVFN1?=
 =?utf-8?B?aGZXV3k5SVVyc2xraFNacUpGZ3pEcWttYnA3NXVvU0RGRTBaTWtCZjcvZ0d3?=
 =?utf-8?B?QjlRbWhuaXFNUXpQVisySllEYmRWZXIxUjZCRVpEM3pPczgxcGhDZUZzeUdn?=
 =?utf-8?B?TkVidTU0V1hwUzJhZ1NHemxBT0cvcW95bWhNMWdVQVpsdjA3RE5zZHV2dlgw?=
 =?utf-8?B?M0ZTeFIydXJOeGVIeWgxaGhMNmZydm1jNWZYaXBmS1FkeDNZN3B1UGh3cVJQ?=
 =?utf-8?B?NTNpNmsxbHZwUXo5R1ZOSHRISGhnVWRodDZHUlovRW1UbXNxTjRUU2U0VW5s?=
 =?utf-8?B?UkdiSDhtRU9JTFVzYis1TDFxUXU1dFh6ck1aWjV5ejVIL3g3eXBOSmV5b0dl?=
 =?utf-8?B?K1dHcTFWWS9YS0tiUnlhcnl2b05JK2hMZUl3eFcxbEZSZXdVeE42UlNoZE0v?=
 =?utf-8?B?MW5nSFZUT0I0b2RmUUlUQTNDQUNhazNKZkNpUGEvMXdjbnZpZ09iOVo3UFd5?=
 =?utf-8?B?MmJvMSs5YXByTnJ6VkkvSVFMbkJlZENxMzc4SUh5Rys4TDFKbGJZSGcrdnBH?=
 =?utf-8?B?OVkvc0tsbmQ0UFZYdTNJOXQwNkFOcTZmbDdFNk8xRHJON1hyb1ljdEJQU0Mz?=
 =?utf-8?B?SGM1L0JHZ1R5bEFFWWhSY0RMTDY0bENiRXhJSnhuQU50VjVwa2ljZVh4TXFH?=
 =?utf-8?B?aExWZzZhcVRZT0t6VTBCWitBNjZtT2Z2aG9KVldHZklPdzUwN3k2QTlndHpi?=
 =?utf-8?B?aFkzZUJreEwraFdmRkc3dW1nd3dhK0VQbUJpTHEvTStlN0lFaVZqNVhEZFdB?=
 =?utf-8?B?VVpVRVpLSDBrSjhJZEJFcEd6NTVuRUh1aWZQQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUV5elIrVUlkK1dwUE5zZnAvSUdhb0I5d0FNSUtRZ1phVXhwMXpnNWhPQUZq?=
 =?utf-8?B?ajRKaXQvU3BzUGljN2RXcDZRVk9ReENMZkFoUlRZK01SRGlTdi9yRXFLSWM4?=
 =?utf-8?B?ZGc4TUtPTUFkOEhjbE1QcW1kYis3djNNcjJTc1NnSHl5Q0xwOWNRT0R4WTVB?=
 =?utf-8?B?N3k4aDZzQzhDcERncTNybDk1U2VlZnAxbkg1NWxFam9OQk51TE1wVVBZZFV0?=
 =?utf-8?B?NmQ1c09JV1ltYjkrVjhad3RoZWpvTGpyU0x6eENwTFJvejFuQjdLY1IvdjZL?=
 =?utf-8?B?OFl4SUhtWUhHczErS2JsMXl0eDZFSWRScWhEV3ZheE0xNXpHZXltb1RvRlBG?=
 =?utf-8?B?eHU3Sjgxb2RNQkFidkVJOVROOUNJSkRSUUVzS0RKa25GUXpkd295SWJBa3JH?=
 =?utf-8?B?VE04amlGSXZPYjIvYTZUZnlWSEpISVB5TXZSY0NjTFRGTUI4dXRNMm1iU0M4?=
 =?utf-8?B?bmhlUGFEMkZXdDA5WkVpN1NZUUZzN2hGUjhRVjF1cTBJVFFSUHYwZE9LSFVk?=
 =?utf-8?B?dVNhNnRLZ0tpbThpN2JSU0daYmJPWG52UnR4MnNCblgydG1Od0RJaXluMG1p?=
 =?utf-8?B?Mnk0OGZWTWdNMkRicjF0UDVYQWsrYlMyK09QZWZKemRiUUJPL01XUUxhNnRL?=
 =?utf-8?B?L0l4ZndWV01lVmhJcHZINGYydEVaQXBTbG9DcHkzRzVKbFh3UEtDOGJiK1Y2?=
 =?utf-8?B?S0lhUUJDcjBhTmJZdmkzMnFkS2w2dmIyN2RTVDNGKzJnUDhrZDF1b2cvTDhn?=
 =?utf-8?B?enUyYzZuUE1qVzNQQ01HWDBmcEh1cWJ6TjhxTG45cDRGTVFpNjNwRjNRVDhV?=
 =?utf-8?B?M3JsQVZCcFdnczlLakNrOE5PKzRDa3Fnbm5IRHRGSXN0NFJ6bUNuVVBjWWJs?=
 =?utf-8?B?K01xMThqOWFnd1E0TkpQVDhjdlZnNkNMZnBKTkk4MmdvbDZYcGU0UzhxbzFj?=
 =?utf-8?B?NEl6YXFhUHFibzlweVpXS05BVHBvc1J0TFl6eDlHNEMyS3VnM1c1Vjg0SWNG?=
 =?utf-8?B?TEMxME1oUDVCNmx6VlNQejlzSmxXNFlhK1hnaW5ybnNtWWhONW1uemZJblJp?=
 =?utf-8?B?VlZaTGZOS0I3VVhQOHp5Z3dwMnJFcExBN2xkM3o1cTlyUjlwa1pWVkJhTWxP?=
 =?utf-8?B?UUJVM3FtQWdwRjhuSmFKOGFLMVhTUEpWWllSUjgyVnFVamNsU0FyN01aS3dx?=
 =?utf-8?B?T0FMQTFJY2JpUGN4aUxyYS9QT2s0NDVSaFc2TlUxVUJVczJZdDFoSytMY245?=
 =?utf-8?B?QzNDNklYazA0OVhwbzllb3ZyeVlmZkRueFprOGk2OW95MFdXemNaMm9ZWW90?=
 =?utf-8?B?KzQvSzJPYWRMUStnNHZFN2F4aS9zMlJuNTZoNFV4Wk9qMjVKNjE2QWJWOERv?=
 =?utf-8?B?YmUveU9jbFdBUVZkWUE0dENZdkhsVGVWU01YUXRzd0pzNDBJR3BCK0czNENn?=
 =?utf-8?B?WTY3ZXRlcmZzaGYvZUVjb3F3UFBDRVVkdHRJRW56dkkyVTM5RnFHN3dCWGZJ?=
 =?utf-8?B?Mlp3TU1KS2hZclJQNzJORGwxRzNDejV4a2FnazVLMVlDNncxb0ZOcDdReDJz?=
 =?utf-8?B?RG4wd20zblkyL2pIb05TaUc4c0RVK1V5cVZ1OE9aTENrTENyUTJHSGVJSnlT?=
 =?utf-8?B?dk9nOTMwbmZ6VS9WbXN4elh3MDFTYXk4ZUs0MzlXTU9yVThhU0dlZUR0OFo1?=
 =?utf-8?B?VHlERmJaS3FtNGE0UlBGMlQwakZUWVNGSXd1L3RuQkdhR2FFSCtzNmNYSlA4?=
 =?utf-8?B?SU1rUmsvVjduaXpSb2FvK2JuZjdlbHBTRDVML0RjS2VLVlNWT3hEdFVXZHpt?=
 =?utf-8?B?K0QwN3BSeFJOTDJDeTNxZkhlRHhacFg4cXV6Tk85Q3U2YmZLSzdpTW9nTW82?=
 =?utf-8?B?QlRMNkd0eW8xelBkSEJ0QThBaGRFNnNTMUhUR0RIMGk4Ykw2eEVDWHk4Z2RX?=
 =?utf-8?B?clQ1SXA5UUVoeVZMS1FYMlM5TVRLTVI2ODV2TEdmMExyU25mdG5pREJZcVNl?=
 =?utf-8?B?TjJIWmM3RFozaW1zSndoaS8vTmcwL2piSEZXN3JQanV1WitLVFRJcFRBak9N?=
 =?utf-8?B?d2s1T0JTQSs0TG5ibVB0Ti9sdWM0WHQwd1k2VU5nMkhlZDBMeFAxNlhxQjgr?=
 =?utf-8?Q?qWrmQxPU2skKMSXg2Qx1ucczb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18CD289B8641344FB5D3AF503A749832@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6020d9a7-3d27-4ce1-47e9-08de3925cbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 02:26:02.7466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTvTGaGggBQzYM0R/+cTfcDA0oX7hi6+1PUSajZulXk2vK9UqlIvm4mpOhTJqOs5eZfzycXhJYpFXTSXueyxZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com

SGVsbG8sDQoNClRoZSBicmlkZ2UtdXRpbHMgZ2l0IHJlcG8gWzFdIGhhcyBzZXZlcmFsIHRhZ3Mg
dGhhdCBjYXVzZSByZWNlbnQtaXNoIGdpdCBmc2NrDQp0byBmYWlsIHdpdGggdGhlIG1pc3NpbmdT
cGFjZUJlZm9yZURhdGUgZXJyb3IgWzJdLiBUaGlzIGlzIGZydXN0cmF0aW5nIHdoZW4NCndvcmtp
bmcgd2l0aCBnaXRodWIsIHdoZXJlIHN1Y2ggY29zbWV0aWMgZXJyb3JzIGFyZSBub3QgaWdub3Jl
ZCBieSBkZWZhdWx0IGFzDQp0aGV5IGFyZSBieSBvdGhlciBwbGF0Zm9ybXMgKGUuZy4gZ2l0bGFi
KS4NCg0KVGhvdWdoIGJyaWRnZS11dGlscyBpcyBkZXByZWNhdGVkLCAgSSB3YXMgaG9waW5nIHNv
bWVib2R5IHdpdGggYWNjZXNzIG1pZ2h0IGJlDQp3aWxsaW5nIHRvIGZpeCB1cCB0aGUgdGFncz8N
Cg0KSSd2ZSB2ZXJpZmllZCB0aGF0IHNvbWV0aGluZyBsaWtlIFszLCBzZWU6ICJIb3cgdG8gd29y
ayBhcm91bmQgdGhhdCBpc3N1ZS4uLiJdDQphZGRyZXNzIGl0IGNvcnJlY3RseS4NCg0KVGhhbmtz
IGluIGFkdmFuY2UhDQoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbmV0d29y
ay9icmlkZ2UvYnJpZGdlLXV0aWxzLmdpdA0KWzJdIGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9n
aXQtZnNjayNEb2N1bWVudGF0aW9uL2dpdC1mc2NrLnR4dC1taXNzaW5nU3BhY2VCZWZvcmVEYXRl
DQpbM10gaHR0cHM6Ly9zdW53ZWF2ZXJzLm5ldC9ibG9nL25vZGUvMzYNCg0KDQpDaXNjbyBDb25m
aWRlbnRpYWwNCg==

