Return-Path: <netdev+bounces-97636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6C8CC77F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1AF1F21CA5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A2146A74;
	Wed, 22 May 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vyqDCLBb";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e5szyakG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81CC146004;
	Wed, 22 May 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407604; cv=fail; b=NzhxC0ZQQYeHOTx6VeiwoHVTfJ1goY0edqlCunuDZg5dE6iiv8CWIOiZH6kLoIxITIQuLkXenAUrK5fWYuT6bd3M/jQIMDUliFjyctfR5+nyiq67o/ndC2f+HTr+VSkBg3G8BNd4TIPNMBGKhvI0fQq4DiqdDqa+dcdhyFmMHws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407604; c=relaxed/simple;
	bh=ZzHDIIeuHY++fubLRSUH1EVts5hB53X5KndOFcm7++8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JfYCPEaMZL6RweW0Rg5dxPSPnwl+8C4gpZhtM8R1o9A8u8upfj1qmYF9T9ww6af177+JLVLilRRJGsuXLmLeyWQgRjR0LRKUUqiJ/AOnMkgE8Xcmx6AfyLso74VOkIa20BhUJzAIder48HQnIhX3enrqtvpdYvR7D5VBL9JrYjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vyqDCLBb; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e5szyakG; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716407601; x=1747943601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZzHDIIeuHY++fubLRSUH1EVts5hB53X5KndOFcm7++8=;
  b=vyqDCLBbHn4GnbJFFTf5h+duHSspNnvYneZHzTxUMJVXR6c1L/TarVZC
   7wh1wK++V5PSvKKH0hzyVpyoLAHMCJjYxxGM+7NNLLoeZhwv2nwdBNSLy
   KC6hQUyBUt4oJUgOBv9JZXw2+dtS0IsnsrQt3kEZdCLSPRJG//4WmRrX0
   DLy1CSkvvpjABbAt3WQr/cJGPWH7eF2/cXRWxWMn+osXMix0cIPt3vL0x
   H763hSJpenNjVWJ8DKhzDtSQXdbhMofTmx286ej1Qwx3aVufWWOismmD2
   hnVtWeE3fgYC7gSbI3aVfwPErkqGRssILsaxo+QllfCyYWgnAD+VhSaA2
   g==;
X-CSE-ConnectionGUID: 2MB9wdtSQAaQZe0bNll0WA==
X-CSE-MsgGUID: ckHptTzQREmNaXwFzGI5VA==
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="28095937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2024 12:53:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 May 2024 12:52:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 22 May 2024 12:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbfNOwRgsQ5Wum0aoZP1IpD/HNcUZ/v36JK4frG3K30LLbKnXHaiJCU42vP2zkY2QLjo88Lrf3XthvB721wvsRKLjxhuVKLqosf5RjdNOfR3ogEOezvvpcSrR7QHwpn+1T7i6AL/15s85xSlTxS3t3xIYATR1DkDnCHVw8meqBN+7M2WS3GS4e2Gtd2UM2uo7+Wec+dD8ciOBvpWIcOfidVkocmOWul9Kv4XX7yVO8bXDIm/JBw9fW92JC3mnh5820Pxixgpk67eT/+zhyf//tTmVPGIlPyp8fqxR+OU78EfyB5D7TmSde+xry71iTOTjU2/8G3jvZvuxNAX1m31uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUsbof13eFxHmO0PHiuih28GKxrYJOk/aM2y4Jx4thY=;
 b=KtM5TfN+lfSIG2fJufEKUVBr5fA8qTKXOp7jBxeZMpLpFAvMwaQktmJO//UCebqD5jLcK7VJNZa1TMzCoRosn2TSkpFCsMRfby6DaDu4S2henTmqknHOf8qHXNSj6wIxKzYchpZpDYSWVmVdjPMwpQH3VL0JihCbl7EJ0yejvJC2cFiVY5mnzBeq2vlNPwsDnR45i3TYR2HUwFeUSZzDx2rNtfRA4rK6/9zJxDKVnyNVcomaKZEMnWUdxoBQQs0KaRhjhWmnUpELuVPC+rGvIvm0xFl62Klp+kZDS8L5OIUyaNilqxr6o4mJvY1gZFUXfxOSeRCYaat3HvSKJb7Bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUsbof13eFxHmO0PHiuih28GKxrYJOk/aM2y4Jx4thY=;
 b=e5szyakGLX/vECsyyq2QJw0krgCXkt57S9X6aOCgIcAfOvmAFASjsHPnQpkCvYsr7mSnEhEg4kIMLm58Lnc3pLcHWgzEzLgm+wn05PM5n6uxA1Rd9J226XK8tVIvwd2C+XK45OXqlvDsj2ZaSOOwYOOH1exlsqgOvY7pKbIGuqiXOLDyECjGX5oChtruYJ2J/3JGvA/edz5/VMcHWCdetmfwZFf3Fu2W3AIQo4HP5yVxyeYytaqSqX5LVld2CHCPAC5we/LcRZmO3hnN/p+fnW34FGqf1w5cOzhHxE64FSks1s/cdAvGSlJ5McuIhgItBzs58RtCAhbmCwbMgjpy+Q==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 22 May
 2024 19:52:50 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 19:52:50 +0000
From: <Woojung.Huh@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Parthiban.Veerasooran@microchip.com>
Subject: RE: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Topic: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Index: AQHarFGdf9peQKRqvUiYmjubDYZguLGjqggw
Date: Wed, 22 May 2024 19:52:50 +0000
Message-ID: <BL0PR11MB2913394A02B696946324E830E7EB2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|CH3PR11MB8381:EE_
x-ms-office365-filtering-correlation-id: 74ae586f-afd9-4bd4-9cfd-08dc7a98c2dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?pgCTfnUNsqMyMoq2EFkpF+HdviZk4LcRoFnjimmD4GORidnRmQXQblFayAif?=
 =?us-ascii?Q?jWDX6rZTTd1b88T9Zn4VNQwWDSBOvd3dnMopFXZ9ytAyCoh0q/QO8ufs0kgg?=
 =?us-ascii?Q?WMaYmNkwMbJkHE3iLHJk8zNgyZx7qT1XnvWBdi9XV2Ut9M1Rhmn6CYtvWtw7?=
 =?us-ascii?Q?z7ofLjtxE2depk/vOAkt/rdARruMK9ezkxnZSEyYko1V5u+AvPIj+mYyKw0a?=
 =?us-ascii?Q?KyeLZZeyrSx7VoTFYqrrcKsLlbmoyiCmkDdX919SxRWit93ZOA8fglIPnr8/?=
 =?us-ascii?Q?YNX1/JSmQzlZgrFwwSJxbwzXVaabaN9fwS0J0drAu33VUNMxow/8wQ+bStUY?=
 =?us-ascii?Q?n/sLGEi4yuxnYoNJ2BCbF00g+niPpDHrJHBJmIWJMx79dFEw1AbyH0Mn4pec?=
 =?us-ascii?Q?OTgV2yntiBakLybyeJwXxDHHOtFCt1K9UZ85eEkBekOCB7ydKJwZ4kGDkefm?=
 =?us-ascii?Q?K2zY4gXauekCSTeYqPImsBAJOR7uZcsisiE3QF7mMp1yio0gNMAKwPEHncHL?=
 =?us-ascii?Q?zgl4vWpgEuxVvghQ+cVFLjFElt+b3ONNOtH1x1zjgk/KE2+DClg075g/JGhu?=
 =?us-ascii?Q?Z7cRWxtfMKlyAMZ0lGRCox1rRlWeJ2Zu9cpqBxNccdQxvkXAl/Xz/LbDneVX?=
 =?us-ascii?Q?8D4Y8vUkSIwwDgpzrhPJhjWdjXLRqb/2NCu+pGvjYauYBVq02iOCj/gMpKsD?=
 =?us-ascii?Q?LmEVkJJW7chqZ5Hs7O8ADQLXIHsuUA9qLzEMzGqi3GH7typ3c6jq2Em8E3nX?=
 =?us-ascii?Q?1VYzECnKkntgEgP2WLeFwLsmdi+D5YPNmv8nwkKmNESx4SLMPmbNlqmq/Z/u?=
 =?us-ascii?Q?jVwUMLqWwQbjkJfzZQ284GCoVN37buEIHbjYrY/jBxbH5bU1kOm4+Vi/Ji+x?=
 =?us-ascii?Q?T3AYLaegvEZ5xsqnokMY2n73NHZ0bVAswGOELZPYBGjVTAoPXeUppYKVe4tu?=
 =?us-ascii?Q?qyz6KLkGw9YIX2UXHtOwnRYsUY+hNoipG69kRmHz0I/leqaouFgcmAqUaYqm?=
 =?us-ascii?Q?BzFuRGtLj2VhrT+u31Y0Lfs5C/iJZtl8WQ/wSo4bPYhkVktq01PY2pxtb+Xg?=
 =?us-ascii?Q?Nn9crOjpXwklWaRhQQKhobNhW6Zq5S33XmuGbxJnrqJce/zge91hlYRm5BLd?=
 =?us-ascii?Q?b/u9efYcL8oIpwdW5/qOrQLkVfCt03DjuQuMuXwqW4ZcKZdy/Yfmf2aTqL7Z?=
 =?us-ascii?Q?ceeGp5TTB29ZeFWwsDrP0jXU2X/BCoy/euTu7tqEvSCDLZpgAfB4yrfhvAZv?=
 =?us-ascii?Q?q0bGZFJVhdP49PNpl5H2bgBjkbM+ZpxqAZk0ZxxCikXg2TLeBhW/+YMAOgXV?=
 =?us-ascii?Q?bua3rEmine+Q6UDfxcGre9QZ/253vGWgbSGqRPhH1ECfvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6IJXU+wqdDdoAd/ObB9/oAArBKVTSAalM5vbU9Wbjhb/y1J5m0zTJkCqmC5n?=
 =?us-ascii?Q?hyAOEaz7vbqab998CytNDACRxtDoSr2fpLb/2s6wFQvTha/TI2C49ndi9AOY?=
 =?us-ascii?Q?M4vmOGiNCzc7T8KEdVhOgmw2X5NKfarDT0TgaERa1qQkOdydm7iyAawfOl+S?=
 =?us-ascii?Q?UBjPrhaTUoTajc7j0DfLvKQyYwJPf26XlTCabvSkNz8Rk3Bu+C9sgQupfdp5?=
 =?us-ascii?Q?n8T30CAKZum3qLLHe7IVPwhxiwGDJ8QPqWHihVSgXo85elOjvOZT6sIVqD7N?=
 =?us-ascii?Q?O8lZGZjPHSw8LeIeL94VOlnm1lmEM6ZzXROfbjCzBTuy/s5Sbrge7iOlnDBw?=
 =?us-ascii?Q?RDWU0TjYGz6//uVCl3g2WABC7z90IkJuXNCLZPrNVkAEMyBojmCAc0UQ6OGh?=
 =?us-ascii?Q?ouGJhN14TBKeaUj2rnrDxLYtQctO3w5FZRHkMHxnxqajd6CPhh7/+Z4/xdZT?=
 =?us-ascii?Q?MkmH2jH34gWECwog3++KnI1oEgp3iNw4VdKwkrB71qHWej3VG7nRpHcu4PV+?=
 =?us-ascii?Q?89ahdM0ctfP1AW4TlnB8F6sjaOQmWzOXpzu02MP8Xfvv+ZJw2kWrPaMbijm6?=
 =?us-ascii?Q?wFQ4QXevPZTAV9IQt70JsWPC7FaQCD+Nun39JJ5e+7rX/HxjHZ6hZK9q6cz4?=
 =?us-ascii?Q?ruFrsx21B6J8BtPtXHVaFZ0ci98yb8kKpoykJoM8KTb/0gUng/F8W7gYJZyx?=
 =?us-ascii?Q?X2+h2SAW3/nhRRXgqZ0/49mrmTyeCCTtucYdIpMKmnBxKLdQeK17SqgjB0Xj?=
 =?us-ascii?Q?xMBXoO+pfDwDUdU4aMCdxWemEUOd9CXUpEB9fssPqx4q9QjMEiDQp8+hqh9Y?=
 =?us-ascii?Q?WMc5PwuaoeeeRLcs2V2mMekA0tKF9FnB1HuQ2b8epF6WUo4KObaUBpz+FV3S?=
 =?us-ascii?Q?QxcEAVNREYQYX1j/mo9ikDHbOSjVQxsK0lvFcj6qNeWZznGR+ZenVSEjc1Kl?=
 =?us-ascii?Q?LIyY/SzmFdkknLGWadMlP01OoRxGnz5/Ts1NSaFzF3Gxwtq8tSh3kzfCO/TF?=
 =?us-ascii?Q?/WAVx53crPYuv4+LJY/sW1vIbcyxyV37ur+G7iiO5ohOTRxYip3g6t0Jyozi?=
 =?us-ascii?Q?Sv/cPt6lb2qV5/Q2N1Y3RYUk2qZlrrYJLVJk+cDog6/XnFTxu9ShgMhpaXjR?=
 =?us-ascii?Q?zskBtEk/0YRP37TbPFnIi3mGyJzSM9+2Bv5p++gamFoNBGbSFUEfW/huynNb?=
 =?us-ascii?Q?6PiaN7tfSVHtizvZ5vcS3pfPKD/c9OWg/97wSQa1U+ISVP0SwN+2fyLlLAYN?=
 =?us-ascii?Q?K4NHyId3wWWfoaZ7f5uqUFY9AHrqJGO0cAorgT9AKzRPOKkl0P1/G0UeN3kN?=
 =?us-ascii?Q?2SZQ6gp8fewl+es86v/iCy2IISSuhzjrYFFbUrGwzs2l+b+O8jU+kqjmQmKo?=
 =?us-ascii?Q?XfnoF+wMspgU6T1fzlYbN+gGdOJWqHnNLjjAn/TD/cinaNIBV3B9zMfRPPZY?=
 =?us-ascii?Q?7QPUHMFDD9B7PBJ3i1SBtHuCr+p5msAU3waBu4n9U+YBo2mz0DZToWoH0wOl?=
 =?us-ascii?Q?R5WThDEhxwS0W3Iu6gpnZOlCxaVE35fhxpCgtrF+BVDNbiMElbelD3P1YROt?=
 =?us-ascii?Q?5DTSiWEr03Vbl9H/S4dDlLidhsJfTRzCAXS3k+dR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ae586f-afd9-4bd4-9cfd-08dc7a98c2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 19:52:50.2096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYApKBn5+SSoRxt+5L+6cSDimNhAUHayajbtiPRAuI8lgTYUqpjwY3lNoTx8O2n/n3adRvwgkBDRv7htDLhBAZz0li3XZSkuHCbQsvlc8II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381

Hi Parthiban,

LED_SEL is configurable option by EEPROM which should be populated on
EVB-LAN8670-USB. I would suggest changing EEPROM configuration than
hard-coded in driver code.

Thanks.
Woojung

> -----Original Message-----
> From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> Sent: Wednesday, May 22, 2024 10:08 AM
> To: steve.glendinning@shawell.net; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com
> Cc: netdev@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; Parthiban Veerasooran - I17164
> <Parthiban.Veerasooran@microchip.com>
> Subject: [PATCH] net: usb: smsc95xx: configure external LEDs function for
> EVB-LAN8670-USB
>=20
> By default, LAN9500A configures the external LEDs to the below function.
> nSPD_LED -> Speed Indicator
> nLNKA_LED -> Link and Activity Indicator
> nFDX_LED -> Full Duplex Link Indicator
>=20
> But, EVB-LAN8670-USB uses the below external LEDs function which can be
> enabled by writing 1 to the LED Select (LED_SEL) bit in the LAN9500A.
> nSPD_LED -> Speed Indicator
> nLNKA_LED -> Link Indicator
> nFDX_LED -> Activity Indicator
>=20
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com=
>
> ---
>  drivers/net/usb/smsc95xx.c | 12 ++++++++++++
>  drivers/net/usb/smsc95xx.h |  1 +
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index cbea24666479..05975461bf10 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -1006,6 +1006,18 @@ static int smsc95xx_reset(struct usbnet *dev)
>  	/* Configure GPIO pins as LED outputs */
>  	write_buf =3D LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
>  		LED_GPIO_CFG_FDX_LED;
> +
> +	/* Set LED Select (LED_SEL) bit for the external LED pins
> functionality
> +	 * in the Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet device which
> +	 * uses the below LED function.
> +	 * nSPD_LED -> Speed Indicator
> +	 * nLNKA_LED -> Link Indicator
> +	 * nFDX_LED -> Activity Indicator
> +	 */
> +	if (dev->udev->descriptor.idVendor =3D=3D 0x184F &&
> +	    dev->udev->descriptor.idProduct =3D=3D 0x0051)
> +		write_buf |=3D LED_GPIO_CFG_LED_SEL;
> +
>  	ret =3D smsc95xx_write_reg(dev, LED_GPIO_CFG, write_buf);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/net/usb/smsc95xx.h b/drivers/net/usb/smsc95xx.h
> index 013bf42e27f2..134f3c2fddd9 100644
> --- a/drivers/net/usb/smsc95xx.h
> +++ b/drivers/net/usb/smsc95xx.h
> @@ -114,6 +114,7 @@
>=20
>  /* LED General Purpose IO Configuration Register */
>  #define LED_GPIO_CFG		(0x24)
> +#define LED_GPIO_CFG_LED_SEL	BIT(31)		/* Separate Link/Act LEDs */
>  #define LED_GPIO_CFG_SPD_LED	(0x01000000)	/* GPIOz as Speed LED */
>  #define LED_GPIO_CFG_LNK_LED	(0x00100000)	/* GPIOy as Link LED */
>  #define LED_GPIO_CFG_FDX_LED	(0x00010000)	/* GPIOx as Full Duplex LED
> */
>=20
> base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
> --
> 2.34.1


