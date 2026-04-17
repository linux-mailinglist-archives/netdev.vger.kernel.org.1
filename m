Return-Path: <netdev+bounces-279363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLwSITdc4mlM5QAAu9opvQ
	(envelope-from <netdev+bounces-279363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:13:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB141CFB4
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8EAF302BE19
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7733985A;
	Fri, 17 Apr 2026 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ezuoyE2B"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A0B1EFFB7
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442269; cv=fail; b=m3Sw7R/7GWKl5NhLjFKSof/m9D9t3b3o511QXaL9TdEQBis3+W5NqheVh48OISRShn91WXjLUPlSY77D+Eh9O+4GasL5KgtmDWnTlKk7feCZJmowve5GR8IZ4Qdn3D3YxgOoPZV9ElXk1xj3xvHcE5loPBo8nTuxZWTcjTiVcOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442269; c=relaxed/simple;
	bh=TDo1cz5we+mNWDG13V1D3nS+QU+EELex2Po2dRUTSkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWcxVtqcw6UmV4aNoj1vdHmt1wJWxHgYtBC5XwmM9Z0pGh+m6xsaEk3gcssYXSrKn1Wm0q2iM5qMh9TIyVzHQHWZcX9XusvJpw+mvWib2s42PU2GaadRmbKWzVyQJTnmtQGhk9RC2l+18DQ59zY65q62fxKZ17Hiy5iyhgQRyFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ezuoyE2B; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H53svJ1234993;
	Fri, 17 Apr 2026 09:10:50 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023096.outbound.protection.outlook.com [40.93.201.96])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dk3wy2s5a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6CHM9MYp3s7kH4Dyf5IoxbDM9z20WDhlRj1LRik4PWZDAAbdfJdgmSBHktfnyOXA96WJRFs7mMKEQgn7+ro1s2LPOzkcJoBCQrJzRf5ZtlMIH87ppXPYq8Dkw5gx6ZSuWxVMghxv2idnShPBnAFCznCWcbVZW+NiTkvpKTuKhbDiS9DU9wMUHvAdG1ZWus+meq1rB0pJU5Pj0kFgxxA/5qHqQOWWAHTTZJy5YODcwxQKC2Ui18vcLdMLIKqb/+iV0i/eeiCMc4yWmrFur6F6HcwpGihGLzuVH9L2YYJNYdp9krQAXEmjddWA92fAJQqd7TMiIqpo0XmQzhQ16+65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDo1cz5we+mNWDG13V1D3nS+QU+EELex2Po2dRUTSkk=;
 b=JRSCGvnpg9Gp3lp5Gv9Npv6vXIcz93JPgIIT3ADelCoe+0nnwzHu3mGHFS3+4CvUG8PIWSuP+IlV4TLMZOSvgQ384mejGdxU4O4H1N2TQeBwV0TSGFr1/iNcvxBNwL1YGBSV1xnrCD7t58aXnlpz4wJ19sq/TGhD5Em66vKhFqXOReUjGgW70EDdstVt+u91P60v2HxaNGcq3pVk53zIKgjI7bIa9yoxu5eniJbMeFHsT/3YuEP4wQrC/i65luBM0pfJU350jpBblBt87SR0N8Cu5wSIG6nqIwhf+V6k+QCrp93GlR+VVxrThHifROWNZYOP6taJNiUparwRaOKhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDo1cz5we+mNWDG13V1D3nS+QU+EELex2Po2dRUTSkk=;
 b=ezuoyE2BvIcIe6P+v16vChHQjv5GdkVjjzdi1jg8pCN6xhsoI36RqtI6O8KHTLekCAuFPobjC9gtdfy2Gh7c2qu5/QCbwE04mP0Hc4HnKUulyyWnhrvZBIoDpLjpUsY1Mx17VK3HqbseHaGjGO5Ib36d4jpMW/fZwFx6/kShwUs=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by BL1PR18MB4325.namprd18.prod.outlook.com (2603:10b6:208:30b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 16:10:43 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 16:10:42 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Marek Vasut <marex@nabladev.com>, Andrew Lunn <andrew@lunn.ch>,
        Woojung
 Huh <woojung.huh@microchip.com>,
        Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: RE: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Thread-Topic: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Thread-Index: AQHczoS9UDNeNlQPbU2nPuQec5fcTg==
Date: Fri, 17 Apr 2026 16:10:42 +0000
Message-ID:
 <BYAPR18MB3735885B13017500E153FEA2A0202@BYAPR18MB3735.namprd18.prod.outlook.com>
References:
 <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
 <20260417155025.488290-1-fidelio.lawson@exotec.com>
In-Reply-To: <20260417155025.488290-1-fidelio.lawson@exotec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|BL1PR18MB4325:EE_
x-ms-office365-filtering-correlation-id: b39082ed-65f5-4121-89e7-08de9c9be000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 Xj+9woAluTKyuSMDtCzYs0Fq8HW2SLclSgrBbtjMVV7Alqze4KdUTAAHJbV8ekhD+i4B7lBIpfLyOq8gX/Nq9Bz+Grwts44JsJ7tqIVQHzqfrhvBl2lUG2zg/brb/wvu1z3aoDqBoY/8UncuW5xssL8oRKPHHQ6cYjynUAnWfh2EOinJwHiLdW5Ll/C/K53T/hS0vnY5L9raxqm9TjNMw7QcmXCTeHwDySrmmzV5CQzaHP9VK7c9n9gk1/M/sDbAY2iB0gHT6/xwB4c8YYzF3zAqX9tYox/95N6nTSAx1vv0nYR6FRSz/6qAMVClSu1mhsoYOWZdBMDZEBKHBngJB5vXVkMaDwGfj45SJnNULI7VpyF2tcwJSOrZWD+OAL9NIZvIYMa7PW/c0k+oojFYB1ubT80ncrZNK0zg0vLNl3i0Wxrd5RJzd/sytdBSNEa2q5wbGqrIesUZxTP+i6JM8NVHduDk45Gk3KiTfabqhBkXc8h/Hq0tJKjULbpN8GwtIaV3PPqHROr/AXbyc6VEDyCNEvADUwwpF5eC1wqXn5VIQS2G9JysYnwDxx9AfSYb0d26oiNKm+nBK5RJoM8exPef7HtKsN/WYNRxnFsiNZfy+cbXWHYZ0aflGRJtVZLeuHJeBisBeCfjN4VcdtesfDVKXRZRoyKt2DcPHxH0lY9wFggUcqNsi/B9rRCVzlfDlbhXIXgyyLxPdNIYQhlIs08UNeDxTkE2jSx/NMsj7nSnzVpzsRf6YuBGYsABHR7W4CCyp2zBGPze073VNk8LWzXPl72C7ZZcTyb3itibkbg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkI4OVkzdkpmMFZ6S2hVSE44RVJJVGhDVTdmYUZnQkRNQkJva3ZRMTEyY0d0?=
 =?utf-8?B?RmtFMmxIVjVIRUtOckM1U1dyMTNzUmN1YU1HTmZZeVQ3UzVyY0hoRU1YajQ2?=
 =?utf-8?B?MHBwWkFNelBjVzRqdFIrZmZrTW5GMnF1d1lQVW52MVRqWXgvb0svL2tGZzNl?=
 =?utf-8?B?UlNKQmhwYmVzTzNzZUVraFhHRjdxaWR0OS9GeTZFME1wcFBHUGVqb0xWdVR6?=
 =?utf-8?B?TG1OZjJoN3Zrazc1bVc5M3hCQ0hMMi9xdUU2a2h1S2Vua0t2dGREUldzYzdj?=
 =?utf-8?B?bHBhSlJ2ejF6Q2kzMUMyVFkrOU5nMWcySWJhTk96VGlxWDFZa2p6MWFvbkdG?=
 =?utf-8?B?YjZFa1ZOZUhBbFg3ZTZuMjkrVHVLZFp4WEZJeG1UMkZhWVhFQ1dXaW5zN3V3?=
 =?utf-8?B?WFpyS3BVRVRZVnpJYVNhK3NlNFU1V1Y2SyszOUo0a21KdDVJbFpOVEl3dzdq?=
 =?utf-8?B?MkYyQ2pIcnZORXJzT3FhTVNYRXhOWCs0TFFoRjVYaThzbDRWOVl6L3dUWjJh?=
 =?utf-8?B?T3lka0xuY1V0Z2pGSXVKQzhFUWpiNTAxa050eHJXdGFRS1pVSEF1MlIwYkQr?=
 =?utf-8?B?cWtTcy9vMyt1S2lHMUlEYjVHemtSNTBHcEVod0h3WUpCQ29qWnRTTGM3b3lu?=
 =?utf-8?B?V0QwaFQ2clp3ZzlKd1Q5d0pzaHdGL1B0RHJveU9WMkp6Ri83ZDRqREszelQz?=
 =?utf-8?B?aWpYL3VWRDFTWG9NMFdjV2lDNXM4djF5NUlQVHdmQXdTUVAyUFhGdHJBbDhR?=
 =?utf-8?B?aCs3Z3Zlc09nUW04azZQTExCYkVDUll2dmhkQVhDaWx6dnZ3VmdYSTlkWTAz?=
 =?utf-8?B?OXhXK1d5ZXo1bUZwd1pnLzYwTng3R05ncE1kVzZPTlVGWWMzVy9iWVhXR2pX?=
 =?utf-8?B?OU5YVlhNcUJVNGhLLy9pN2pZNU9tRHM5ZUpUUWFZTnJrOFdmTHV4cmJkOFdH?=
 =?utf-8?B?S1pGRUt5T3paVEFLZkVwVGF1YXdxa3M4eTczemdXT29SaFg2b1lyTmVWV21z?=
 =?utf-8?B?Q2FDcEVZNUVaazE5NXNiS3NsamE5djl1TnVOeDdiT1BIVjNzZFVyUUpEV2RD?=
 =?utf-8?B?Z1dDOG1rVjh4bW9mZ3lmczlrRzR0L29hdUtTS3g2OFZndEhlNjl6amM0SUcz?=
 =?utf-8?B?M1Yyek52cVFHWkx0T2Z5NU1uRWdWenZNWlI4emdvREQxU0hyRS9jeDJkUmlG?=
 =?utf-8?B?eFdRMEdhbTNmMnNzYi83TTk4Q2Vjem11UkhSTzI4d2JiOFBlbGdOUEI2NHpn?=
 =?utf-8?B?OU93RjNrT3AxMjdnVGdmdW5vUUo1Ti9RZWtuNzVTQzNpeHcxeXZ1QXpHZkxl?=
 =?utf-8?B?aFFuM1k1QWtmQWdvWFJJbS9tRTZwN2hpWHJmYzBTaE5wQ2pTMlFNMjUxbDd3?=
 =?utf-8?B?TUUvZ2RpZSt5MXc2anZkZHZMeFNobTFDRzFJY1g2N25NSnJCVE42ckIrcFBY?=
 =?utf-8?B?SWtzNjNSQVRUbjhZUzYvV2hBYmdmd3c1ZE5hTXdkRmhMaUFMNXo2MTNGRmQz?=
 =?utf-8?B?d29OU3lLNGZKWE5WUW9oT3BqZG9YeXpianJ5RFZ2U3JCampob3h2RkMySWJy?=
 =?utf-8?B?TE9zK2JFZ0I2RmhIcGgxbHBZdDNrZDhBa0dsd00xeEp3OG5zcXNPc2d1bXFz?=
 =?utf-8?B?em1zV3piYVFRWE1BV3pRdStmZEZSY3NFM29IUDZ5czFDOTAzMVdDaXJHYWsv?=
 =?utf-8?B?cFZsa202N3d5ZlBUWlp4TjV4T3NGc3VLNDJrUzVBZkY3dmJlNVdBT0dPM1E0?=
 =?utf-8?B?dGRPY25sYzVSNEh6d3hkSXBCQzY2b3BZTVFTRDdZNit6TlhPa0Y1RHYveWlR?=
 =?utf-8?B?QlVkb2xxOXUydHJib0R0Sm5DSkFiY2lKT1pjVlhlQXhWMTBoTkRZbFQ2YnBX?=
 =?utf-8?B?RXZJaGt0Z3AwRDNEZ2NJeWwrZVA3YkFBWU1CS1dWdXdmVzhjMExUcWhsTTln?=
 =?utf-8?B?T21zODdxaC9Na3g3dFplSjIxWXZrS0o3NGpZOFJFOHphSUtuKzR5aERGa29F?=
 =?utf-8?B?Q3JHamtvUmd5SnE4eFhjQnFQL25jS0c3VXhlRVcwY2ZZTXByOVVROEtLSnRM?=
 =?utf-8?B?L2FDc1BJNythbm0wMHBBNjA2eHF5QTU5c3Fwem1MN09BUjd1SFpSdFk0Tmda?=
 =?utf-8?B?QmlOK1FVaXJoZXZwek5RSTF4cXo3b0c5YTEyV3Azb2U0UERsVmw3bXF0Qkph?=
 =?utf-8?B?Y3VmS3FiQlJwR0dkNm1WVjRnRy8zc1FoS3BBdXVDekVQTktWSmtBN29pYjRt?=
 =?utf-8?B?c3FvdkFIWGZFVHFLRHdHS2NvR2dsWFR5bVVEUHByN3RiVkNmTFVKYUpsbWg4?=
 =?utf-8?B?QlJMeXRwVVV0WGJ6dytwT01ybXMrVXNZVnk5cDFkRlpwaWZoZWVWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	D9NV1HeRqA7utL/HgdcHOoSrm9/IJZMBTkVAZFwOwBiYNlP7yhl6lSyb7T8E/uLKKVDxOuoTyrKLJLzeSmFpuK6bDh1exvZ40q6t14tjzbeMTRYQKyyn5zB0NrEP0csR9tc2N5O8I7caZZS51wtmkc80Tu1neVFSzkXC6BVujm2spqseWADUepBhVCMHWR0XA1R4YBbrlI4vpKZCE8HuT5TLof66yR9w0+ijyNOpQJ8NFdixuI8IJ/7Y2T3WlyVc1CCFcBceRn3gaAr99HA1pfp4pitpTo6fWOTTLUeosMFwmksTPMMyDVIv78MIambKz3dl9/qcCq64F5D5cdo+nA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39082ed-65f5-4121-89e7-08de9c9be000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 16:10:42.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkVdz+PtkljHD9JdjOvfd6IG22sYY1qjd3IXvjU/QQaaK2fGTT2LQMQhz9g9kWk6Gg2LLNDbirwL/ecNX6NYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4325
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE2MiBTYWx0ZWRfX0htemITeinju
 gbRma3ToxY26/13Wmc7jyKskVCDDuu0Q1r2IxM3RFbOIYrunIw1pYUqblpcCfBVmXl2PNuSKLVG
 OQKPWKBmtF3kbi0zG7lLKa0eyOgoFvQXxvFj9I/UtEi3WB0heRXZmGWhbYr1kTe8FRtSa3SromV
 BadHftV65njs/gY5OpPy0gYsOpgGdD6M3wN1NOGRzXhHToO6WCM2xAuAv8o9hSkhRm8iITw3ly4
 /kCE6Ztef9TT8rKDU3K6xVS4/YrMw3bLE9XX0Bo4q3WHPZ7/U5/yWNI2LcJPlmKeerVP2AI/wy8
 N3fm5hqt60WrC28r+2TMuBmjOqsPsWb3r73GDqdvWWhgy7lp6JnFvFPEfSUhEflx4Hv7BReYXqW
 Vxf8z+RjTCgLyRGnhOlw4mDooQDi2SSkNnfehkmI4Ts8htaKiDTY7A+yO4ug8OVcSiN1RkLPnVO
 TmuAqY3wYK0QcskdFCA==
X-Proofpoint-ORIG-GUID: dCVtiTuUbNHtf1mYsdDw26c9jYnJKITb
X-Proofpoint-GUID: dCVtiTuUbNHtf1mYsdDw26c9jYnJKITb
X-Authority-Analysis: v=2.4 cv=LsqiDHdc c=1 sm=1 tr=0 ts=69e25b8a cx=c_pps
 a=8ytssxGH5sXDYVMDm1fH2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=p-LfKV-GAAAA:8 a=XYAwZIGsAAAA:8 a=j6IgjNQMAAAA:8
 a=-c1r01GdiGM1rnOejvUA:9 a=QEXdDO2ut3YA:10 a=97BuGM4RKn6GwmfqMd6i:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=HZwLKyjauIvmKaVjM5OU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:email,marvell.com:dkim];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saikrishnag@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13FB141CFB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGaWRlbGlvIExhd3NvbiA8bGF3
c29uLmZpZGVsaW9AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDE3LCAyMDI2IDk6
MjAgUE0NCj4gVG86IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1hcmVrIFZhc3V0IDxt
YXJleEBuYWJsYWRldi5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+Ow0KPiBXb29q
dW5nIEh1aCA8d29vanVuZy5odWhAbWljcm9jaGlwLmNvbT47IEZpZGVsaW8gTGF3c29uDQo+IDxm
aWRlbGlvLmxhd3NvbkBleG90ZWMuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGZpeHVwISBuZXQ6
IGRzYTogbWljcm9jaGlwOiBpbXBsZW1lbnQgS1NaODd4eA0KPiBNb2R1bGUgMyBsb3ctbG9zcyBj
YWJsZSBlcnJhdGENCg0KU2luY2UgdGhpcyBlcnJhdGEgaXMgYSBmaXggYW5kIHB1c2hlZCB0byAi
bmV0IiwgYWRkaW5nIGZpeGVzIHRhZyBtYXkgYmUgcmVxdWlyZWQuDQoNCj4gDQo+IC0tLSBkcml2
ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejgu4oCKYyB8IDYgKysrKysrDQo+IGRyaXZlcnMvbmV0
L2RzYS9taWNyb2NoaXAva3N6OF9yZWcu4oCKaCB8IDMgKysrIDIgZmlsZXMgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tz
ejgu4oCKYw0KPiBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OC7igIpjIGluZGV4IDBm
MmI4YWNlZTgwZi7igIou4oCKNjJmYzU5YzNkYTdlDQo+IDEwMDY0NCANCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejguYyAgICAgfCA2ICsrKysrKw0KPiAgZHJpdmVycy9u
ZXQvZHNhL21pY3JvY2hpcC9rc3o4X3JlZy5oIHwgMyArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9rc3o4LmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejguYw0KPiBpbmRl
eCAwZjJiOGFjZWU4MGYuLjYyZmM1OWMzZGE3ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZHNhL21pY3JvY2hpcC9rc3o4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9r
c3o4LmMNCj4gQEAgLTEyOTcsNiArMTI5Nyw5IEBAIGludCBrc3o4X3dfcGh5KHN0cnVjdCBrc3pf
ZGV2aWNlICpkZXYsIHUxNiBwaHksIHUxNg0KPiByZWcsIHUxNiB2YWwpDQo+ICAJY2FzZSBQSFlf
UkVHX0tTWjg3WFhfTFBGX0JXOg0KPiAgCQlpZiAoIWtzel9pc19rc3o4N3h4KGRldikpDQo+ICAJ
CQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsJCS8qIE9ubHkgYWNjZXB0IExQRiBiYW5kd2lkdGgg
Yml0cyBbNzo2XSAqLw0KPiArCQlpZiAodmFsICYgfktTWjg3WFhfTFBGX1ZBTElEX01BU0spDQo+
ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAkJcmV0ID0ga3N6OF9pbmRfd3JpdGU4KGRldiwgVEFC
TEVfTElOS19NRCwNCj4gS1NaODdYWF9SRUdfUEhZX0xQRiwgKHU4KXZhbCk7DQo+ICAJCWlmIChy
ZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiBAQCAtMTMwNSw2ICsxMzA4LDkgQEAgaW50IGtzejhf
d19waHkoc3RydWN0IGtzel9kZXZpY2UgKmRldiwgdTE2IHBoeSwgdTE2DQo+IHJlZywgdTE2IHZh
bCkNCj4gIAljYXNlIFBIWV9SRUdfS1NaODdYWF9FUV9JTklUOg0KPiAgCQlpZiAoIWtzel9pc19r
c3o4N3h4KGRldikpDQo+ICAJCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsJCS8qIE9ubHkgYWNj
ZXB0IERTUCBFUSBpbml0aWFsIHZhbHVlIGJpdHMgWzU6MF0gKi8NCj4gKwkJaWYgKHZhbCAmIH5L
U1o4N1hYX0RTUF9FUV9WQUxJRF9NQVNLKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJCXJl
dCA9IGtzejhfaW5kX3dyaXRlOChkZXYsIFRBQkxFX0xJTktfTUQsDQo+IEtTWjg3WFhfUkVHX0RT
UF9FUSwgKHU4KXZhbCk7DQo+ICAJCWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4X3JlZy5oDQo+IGIvZHJpdmVy
cy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4X3JlZy5oDQo+IGluZGV4IDVkZjE3YzQ2M2Y3Yy4uY2Q0
MTIxNGY4NzRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejhf
cmVnLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4X3JlZy5oDQo+IEBA
IC0yMDYsNiArMjA2LDkgQEANCj4gICNkZWZpbmUgS1NaODdYWF9SRUdfRFNQX0VRCQkJMHgwOCAg
IC8qIERTUCBFUSBpbml0aWFsIHZhbHVlDQo+ICovDQo+ICAjZGVmaW5lIEtTWjg3WFhfUkVHX1BI
WV9MUEYJCQkweDRDICAgLyogUlggTFBGDQo+IGJhbmR3aWR0aCAqLw0KPiANCj4gKyNkZWZpbmUg
S1NaODdYWF9EU1BfRVFfVkFMSURfTUFTSwlHRU5NQVNLKDUsIDApDQo+ICsjZGVmaW5lIEtTWjg3
WFhfTFBGX1ZBTElEX01BU0sJCUdFTk1BU0soNywgNikNCj4gKw0KPiAgLyogRm9yIEtTWjg3NjUu
ICovDQo+ICAjZGVmaW5lIFBPUlRfUkVNT1RFX0FTWU1fUEFVU0UJCUJJVCg1KQ0KPiAgI2RlZmlu
ZSBQT1JUX1JFTU9URV9TWU1fUEFVU0UJCUJJVCg0KQ0KPiAtLQ0KPiAyLjUzLjANCj4gDQoNCg==

