Return-Path: <netdev+bounces-107646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BDC91BCEE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1775284067
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66841155757;
	Fri, 28 Jun 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XuI/z4+Q";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OdC9SSy8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4461514E0;
	Fri, 28 Jun 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572412; cv=fail; b=LgJie6Ok9KfoabJNs4IbFKlmhgysPV9Kt7LHlk342TohcRuD4PPj8y+1WzoY/BO4wpO33RftoHy32yBf5PEU/Mp7Is3vxiXvb8or9iq36lL/4RWghRXyCLwkoIEvu8FMQjHwy6OUel+x749z4fQHGy5WYlxhbxM++M7NNiVSSxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572412; c=relaxed/simple;
	bh=oUSnZzwwIqkA3UKVsVuuUAAHt83/a0tvlx2JCNNpHOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lVH3UsrY3MyaPmuGdSHi6fyy3Ip7T2OvL0bsR2y1VpYE4iybv1HfHiAWX9jhRgd6pWfTqHBbUxvLSDfup9JkaWdP01VLK/m8NYoYu3W9Zc6AWfFsYxoWiI5ClDqKFv1mt9Ep8UdeXCLe2khtEhmOk1SyiP0yewOMFNrXSWTKzG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XuI/z4+Q; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OdC9SSy8; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719572409; x=1751108409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oUSnZzwwIqkA3UKVsVuuUAAHt83/a0tvlx2JCNNpHOc=;
  b=XuI/z4+QGj0NdpHC2ePswWq6mpk5ad1hZAYryeO4DDJ3chHL4qUZDuUU
   GSFi62jDsW+XE/ueN+oOgb460qKB4d2VlgEw+GsjykNu1a60zFvLDhxuI
   1mssmG98tIuWO46DdyLqXA8omXg4DQ0NUVC/K09ONn9whFEes2nOa16Lo
   Wk05jH9MGoKpL4cQsagD+gFogJsKCH2P4DhLEEhgwIZXHECN91BftQZeM
   7N+hbyZ49pyfiRyxihT4MSBX/Gm96MINL0d6Ud6829y6X4hoU/ZlHIWyd
   UzQASW29lpo3s6kWCBU6mK0Ge28j44IzBzrBY3Ha6f8QRzne7od+z10Jq
   w==;
X-CSE-ConnectionGUID: NR91jeL4Tk21EtvbKh2NjA==
X-CSE-MsgGUID: ++oOBXXsQzSAOqSdu3AJKQ==
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="31198046"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2024 04:00:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 28 Jun 2024 03:59:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 28 Jun 2024 03:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz0fIlEymLHeAT2D5bkfstcRKr7hrCco/PJlrg2f7+aRTjrvNsy/Xg89B5ZJqR2wqCgpYWTIuYSxPnZAXJQ5ee1xPr+Vqxcs+fiKS0+8+HdNg5PKJKFA60h6Lfd8czbDF3mf7cbT2YpaQLwSRkVY6u+rb1SsMjK+OGp/naPJKurfmktTyXOwjmNx3xfobUTnOETOoWUadEObjSROo4NKxXOzCfmwp73+QGGVEL197tgehNRy0iY+Bltbji24wrFTeuxFab1E1NVT/sy5UAPKLa06/NmGy/75x8EpLKMsWuJIk5z7l7pxQZg9FUl5OOMEkrTS+hs43prdJhUOqwF/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUSnZzwwIqkA3UKVsVuuUAAHt83/a0tvlx2JCNNpHOc=;
 b=FZuZV152Xz0Y4JdRkdpmg6ryDf0Z2EyP0vKg9Fc+mjsKbPZHbAaXKrSWpnPURseOhQbtkQGxCUM5nb6kutYBV9K8WToDexN6qg/gFHNXdQ/BA50Vhqv6KRRki4xrA4ynsqQSuVvlYp+HFy/2euO0+IZMjXGAdOnYQsouG0tz4ftsilaG+3oNXvQxKQyDFKzB5/w44cPlFKsJnWaoBLiMvgeopSfsMvPBq9cJT9E6tcWAeWr71AwC6tbpNoAmIJRBcO+2iAhb5rEmpBje2cfkIA4nLnClfhVJJnemt95SnBAhIfsPUTYXdcPFrdtkLT6XLAw835ULgg4+UWJPWkGKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUSnZzwwIqkA3UKVsVuuUAAHt83/a0tvlx2JCNNpHOc=;
 b=OdC9SSy8xcYcw9TXjjxxt3kkgfFlvTaibTIulddmJT8ioUIrnVkF7iU9xA+krhVbACAk64y6gnpLXbeHIDkkxbghRg5eBHf88gO3RlrUfRIBqS2iRqTAtZJWkNYfhymPfVAs1p/rAt4TorJw90nyA55aduSwYirgbfL/pfQ0oIz7Otb+1gUI5F14xuk1f942iITdj6rHX1esa1Gj4h1MZ45DrWfAJ7xpT5IV6eVkyJASD7gBO+EFafg+43EWAaTS5jGhElu4RK54OpXmsXVKLVpnTkckvni772ZAy2BLMrpbDaxRQvhID+UDRglV7GTNIHUIxR+wXr2cimBEaTNQYQ==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 10:59:45 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%5]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 10:59:44 +0000
From: <Rengarajan.S@microchip.com>
To: <andrew@lunn.ch>
CC: <linux-usb@vger.kernel.org>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <edumazet@google.com>, <kuba@kernel.org>
Subject: Re: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Thread-Topic: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Thread-Index: AQHau+QKS3/WRMWFLkKW/F+crLJ6w7HGLayAgAoFDACAAIbnAIAMYqsA
Date: Fri, 28 Jun 2024 10:59:44 +0000
Message-ID: <369cd82f60db7a9d6fd67a467e3c45b68348155b.camel@microchip.com>
References: <20240611094233.865234-1-rengarajan.s@microchip.com>
	 <6eec7a37-13d0-4451-9b32-4b031c942aa1@lunn.ch>
	 <06a180e5c21761c53c18dd208c9ea756570dd142.camel@microchip.com>
	 <d72dd190-39d1-49ca-aeb2-9c0bc1357b68@lunn.ch>
In-Reply-To: <d72dd190-39d1-49ca-aeb2-9c0bc1357b68@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SA3PR11MB7464:EE_
x-ms-office365-filtering-correlation-id: 31b22ed3-a1b1-40a7-cb3c-08dc97616b52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWpRMUNCczQ5eXZCTElGTTVHaXNxaG1LZ2JVYkN1bm1TbEFLa0FHeDlRNXdR?=
 =?utf-8?B?ZEMybTdFL3ZaRW95eUQrWnBHNlVwNDQ3aEUxb2JJZ0hvY2F0eGJsZXRSZk1X?=
 =?utf-8?B?V3dIajFFbCs0bzNxdUxHNTRjR2xFRFkyRUs1NkZoaWJxU2p1dTltT2FsVkFH?=
 =?utf-8?B?NWQ1WG11dUNhYUdKYVNIUGM4STdwdVp3K2NCSWplTzlXK3lpeUtZYmZRbU1B?=
 =?utf-8?B?dkZxeHJ1M2JLRTBkTWxaMEd5WXRDT3ZmbmNjVkZCKzgrYlRwRlAvQ29URmc5?=
 =?utf-8?B?akFzeEpXNUQvZWpaZVlSUkhaWE5RZWtTT0RKRWFTaUpybXJCMkM4eUEzSWMw?=
 =?utf-8?B?dkZIeFV4d0loR3RQdEV1ME90Vm5ldGpGbXlnSlc4aUc3Nk1KWXAwZ2oyVW9S?=
 =?utf-8?B?NlptcUY4c0szQzJWeE9nVGh4Z0pZdFJ0cml4NVJlSUJxQ2pwTlRrUnlMWk5J?=
 =?utf-8?B?K1VRYWVwNTRKS2Z1RE1PZkQ5N1dMa0NoTkt3Z1JsbnZqU1BGNDg2RWhyU3ZI?=
 =?utf-8?B?ZmRRNjNlUTk2bkR4ZzdKZFlqTEViaDZLRG5Vd1hNRk8rWE81eFBjRlRnZ3BY?=
 =?utf-8?B?VXQ5VVFXYUlWQWRzRG8zMmlBdStTL3o3MnRCZW5FMTM1ZEJPa210bFRZUmhq?=
 =?utf-8?B?eGZpRUpjQjdhbENGRXFJaVdTQjdGamtUQnlobHhtR1FXTG1RNHJoekFTNVBa?=
 =?utf-8?B?bmR1dFBTbWRPMFg2b0JJejkxUUVUanh4c2pMWHV5S3psUkxiTnpkdFdqTzlo?=
 =?utf-8?B?R0M3R3dqcFNqWEx6aUVWSHpoUXlaeVdrNkRtOEU1QnR3Y1JzT3Fid1pTeXdZ?=
 =?utf-8?B?Ly9jSlk0SXZFMWhCZE1EOEVnTlB4dWUvR3FRYjNYTHJBNFVONnpjQzcyMmJ6?=
 =?utf-8?B?NVNVaVoyUlVYb2tRTldzZXBNUVZTWklaNlFORWtZUTFMOUhaRjE1RVF4MGMr?=
 =?utf-8?B?M0FvK05ramNmYnJLSEcyeHNjQzZFN2MrU2U4NnhIM3VrNHVLR1E0T1o4WTVD?=
 =?utf-8?B?R3A5VlRzSVF1cEszRTAxWWNweGRNaTlpbWVzTkJ2WHQzYU1MWUt1ajlsMk1v?=
 =?utf-8?B?ejM5S0wrWUVmTG9xcmRGNHNYVGd1bER5WXkyUlBwcWpCQ1EvUkI1S3JDU0xT?=
 =?utf-8?B?d0FDU2FhR2kyYmNyUjVGL0d6SGQvYjltaWhZaUZsVjYvSWpQa3JXcXByM3pJ?=
 =?utf-8?B?ZzF3RWxsSEJVSXk5bzZycTQvUWhndzVQOU1EbGVxdHZDRU44c0hqTEl6WW44?=
 =?utf-8?B?dlR5amM5S1dTelNoRGpaYXRkcFJaemw0cTd0TVdVcVkvYnJmY0NsWHU1SG1D?=
 =?utf-8?B?NW5rUnhUNEpibDJRemJVL3BNM1FFNjZ6TmsyZ253QnBIWTV0NmlyaFcrUHlQ?=
 =?utf-8?B?bllYcjQrR1l0eVJxZ2VlWnVXOTBGZFZ3ZU5JU2N2VXMyMkJodUhHNFd1Vi8w?=
 =?utf-8?B?K2lsSnIzUUVOS0hiNmx0U1U2b0kwNncvMEpqNjZrd2RVRVNPU2g2RkFCMVVr?=
 =?utf-8?B?SUpvZWdvZmtnUkJ4Y2tqSXBaYks3aGxPb3d1UXlQSWpuVGVOck1QNnN6VDNa?=
 =?utf-8?B?dFRMS3IxL25HcDNoa243Y3NYMDYrSnkrL28rckU3SHRabWdKcG9pN0dLaUdO?=
 =?utf-8?B?TmR3c3ZzcVNobFl1SjRGQnE5ZVRVTHFqNUR6MElvOHlPcVN5UytmM3U1WE1n?=
 =?utf-8?B?NnJGRWlJalJXSm9xUDdhL2Vtc2ZyQy9yNmMyTGt2VDFUNHFocWhnQ3hBeklN?=
 =?utf-8?B?blpmVzVKZGExYnMxajFPTzVwU2hQOVhLbHV5SVZ0dWZBenYxVWd3WDQwS3p3?=
 =?utf-8?B?UnM2QThDbUJ3QloyQW5EelJlSlhEQ1BCZ3ovNnM5Qk45eUlnWlg5SG1scnln?=
 =?utf-8?B?Vng5blpITEVpamE2cFFSc0ROOElpUXphVUpaeXhuRVZqM1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkphQTE3cEFScngwYVFuOXBHZC9nSDNJbVY0b2JQeVpld25HVjZhVEphZ3hn?=
 =?utf-8?B?Zmx6dU9TblQxcXdDNGhSblY5N1FPS3A0ZlhFSWErNkVmSXpnQngydEl0MXFN?=
 =?utf-8?B?UWNGWXFLQW5lZUMrN0x0QXFJdUx6aHlwMXo0WXBCeDN2em9vaytBZXA3SHNS?=
 =?utf-8?B?TGEwR0drbHQrWUd1bzhtUXhDM003SkZEc3RvaG5Zb0F0eGhUMUhwOENscmQ0?=
 =?utf-8?B?YzVQdi84VW00MUkxTUs2TU92Njk1SllSRURMbHpTSlV5L2M5SFFmYXlEME5N?=
 =?utf-8?B?bTV3SEJVQmdrRDI1bFh4cFRzRWdRRERKdUJoQ2FkeExMYzlMa1dZL2VxTWl0?=
 =?utf-8?B?aDlhNHEvSFNqTjcrR0VjU1ZoTTZaV3h5TkdleUZHMHNKdldSaTBxc2ZqUU9I?=
 =?utf-8?B?R0N3eittTlpkMmQ2NnErY29rNmE2djNkR01ncE1XdEFXR2gwQ09GekZwbThh?=
 =?utf-8?B?amhudjVFWU9BQWpFQjZaSnJpN0JvU0hJNnhCdWc3aUJSb3ZGdkczcVdVdXVt?=
 =?utf-8?B?SzVCU205d3N2NlhRNUpTazdxSm1sOXZ6Z0plZkJ4WkdnWmxxbEhjdjhRWE9X?=
 =?utf-8?B?M2h5Y3lJQ3lvK0FDSDlNL1NBTUYwL1E5MXFLeUd6Tjdoc3V2LzhMRi8yZGFt?=
 =?utf-8?B?V0NGRVgwZHhlMWZUQnNSM3NFdy9uLy9lRTdQSFB2YUFzMG91TDFSV2NCb29H?=
 =?utf-8?B?RkcyVXAydVArM2ZYb1BNbTUwTFNFRDdRT0oxcStLbTZNMmpqLzFBWG1RRjNu?=
 =?utf-8?B?NzlvN0xQWnNXTFRjZTVvN3k4VnVrR2pMUEI5bGhmV1VIKzZWS0pScDU4ZnRo?=
 =?utf-8?B?U0pEbDloREE5YjJ4U21sU3pWREpWM2R0M010SWRaSk1aV0k0cG5Xd1hPdTZI?=
 =?utf-8?B?STRqMDFLaURmSnAwWTdwbGh0bGdFcFdNdjhyRDdyZEF3R1V1aTJmTHp0MDg5?=
 =?utf-8?B?RzJZc3BmZGg5WHVqU1gxQmpOYlAxakt4K2poNURzNm5wbm15QlRWczI3N25L?=
 =?utf-8?B?OC9lczF2T21kRFNqUGZNL0hKOFIwT2pNdm5JemM0OGxuSGc5R1lxeDVtblFG?=
 =?utf-8?B?bUU0WXFlWFNIUDlMeWRkTTVzYlJqZmVlNUo3MFlmbmt0blBLSjB5TDJuM0xN?=
 =?utf-8?B?M0xLbGtTUXdNNFMwakJQZHRaM2NUcFAvYjNHT25sYUtZRitjeTFpU2phTGor?=
 =?utf-8?B?WXJYYmFtVzRQSWNXdjBnbjhsd0cybHR3L2Qxa21mYmNMbkFuaHNUMEt1L0Jt?=
 =?utf-8?B?UFlJYTVPM3hIVjFNSlEyYis5OXVyOXlwZU1GR2NuYlhXMnZwYkFIcTlkYmVO?=
 =?utf-8?B?OUdWdDJmQWVjbVdMS05RVEdCeFcyMTNndlgzT1dRUnhUNTBSN3RIdzNhZ0Ry?=
 =?utf-8?B?TXVDdE5qOVFUSWRFdUp2MUkxVWNwRjBaMEV2ckRvTzV1bGdNUE5VQmk3Qkky?=
 =?utf-8?B?RVYwdTdJTHJpRHBuV1pCUDhkdGkwc05YcElnRlpXNTVzR1BFZksrMEtuOW8w?=
 =?utf-8?B?YStTNnJuSWZLM3JQRDgvUGVwbmtsUnVuVHBuVmlnZURXT0pxUEJMdUYyUzlN?=
 =?utf-8?B?OG9VMU13dzZkb0NTaUFycG5uaTYxZEt3L0NPOWRIRm43R0V0dGJ3RzhrOHFM?=
 =?utf-8?B?TERzQ0RHejljdWVtT21XUDV4MzZZK1R5S3kzbFNNOWNVS3VVWmxHam8zVUU4?=
 =?utf-8?B?Uk1USUJIRE9MVDcyWHVqT3d3aWZndG1QN1Z5eXNGNlJVeGYzUjA4dVRUQ2hV?=
 =?utf-8?B?eEd5TDhTSXltTEcxaXZuR3dDcmpqYjN6NitLczlxRGEwWFRJcHhETVlrVk5U?=
 =?utf-8?B?aWVxRGtGdkM2QUJZR2poMk9VU0lxdUZpMjRCNlkxeDAzaW1pZnkvd3F4dUc4?=
 =?utf-8?B?MVo0cUU5djV5SU44THdJYzB0R3NWU3N5RWx1aVpBSnFtQkZjSSt2UWJaMlJ3?=
 =?utf-8?B?SGx0c3BXWkZ0SGU1c1YvRGtWYWZvKzBSTWVYYXVmS0VCeDBoZ2xDR3prTjZo?=
 =?utf-8?B?SUhNcmZRYzVlR3dEUkRkVCtIWlhTUFV3YVZKYVZBT1JzNHl2VzFoeXVudGhK?=
 =?utf-8?B?SEsxRWpsdmxrVWlET2ZOeVBreVo3aGZDcU1SMkV1MzBmRXpxc0x6bmJxZ2hR?=
 =?utf-8?B?ejdsVVBMS2N0SlFOOEhITjlINDhLdTNWWW9pdW9SYUdNblltTmEvcnZCMk44?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD5606675B9D4B4480E401627A481299@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b22ed3-a1b1-40a7-cb3c-08dc97616b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 10:59:44.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDbguAYRQtmtKCZYNxMC7nsccaQ7OTMb+wXQWX7kfWlPsdOvXIcG+MdFGzlxakA4shD2XAp9vXTPg92eCFKeeG2Uig4bZwYxK5Q69BeEHgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cyBhbmQgYXBvbG9naWVzIGZvciB0
aGUgZGVsYXkgaW4gcmVwbHkuIFBsZWFzZQ0KZmluZCBteSBjb21tZW50cyBpbmxpbmUuDQoNCk9u
IFRodSwgMjAyNC0wNi0yMCBhdCAxNTo0OSArMDIwMCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBKdW4gMjAs
IDIwMjQgYXQgMDU6NDg6MzFBTSArMDAwMCwgUmVuZ2FyYWphbi5TQG1pY3JvY2hpcC5jb20NCj4g
d3JvdGU6DQo+ID4gSGkgQW5kcmV3LA0KPiA+IA0KPiA+IEFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5
IGluIHJlcGx5LiBUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guDQo+ID4gUGxlYXNlIGZp
bmQgbXkgY29tbWVudHMgaW5saW5lLg0KPiA+IA0KPiA+IE9uIFRodSwgMjAyNC0wNi0xMyBhdCAy
Mjo0NiArMDIwMCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+ID4gPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiA+ID4ga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgSnVuIDExLCAyMDI0
IGF0IDAzOjEyOjMzUE0gKzA1MzAsIFJlbmdhcmFqYW4gUyB3cm90ZToNCj4gPiA+ID4gQWRkIGxh
bjc4MDEgTUFDIG9ubHkgc3VwcG9ydCB3aXRoIGxhbjg4NDEuIFRoZSBQSFkgZml4dXAgaXMNCj4g
PiA+ID4gcmVnaXN0ZXJlZA0KPiA+ID4gPiBmb3IgbGFuODg0MSBhbmQgdGhlIGluaXRpYWxpemF0
aW9ucyBhcmUgZG9uZSB1c2luZw0KPiA+ID4gPiBsYW44ODM1X2ZpeHVwDQo+ID4gPiA+IHNpbmNl
DQo+ID4gPiA+IHRoZSByZWdpc3RlciBjb25maWdzIGFyZSBzaW1pbGFyIGZvciBib3RoIGxhbm44
ODQxIGFuZCBsYW44ODM1Lg0KPiA+ID4gDQo+ID4gPiBXaGF0IGV4YWN0bHkgZG9lcyB0aGlzIGZp
eHVwIGRvPw0KPiA+IA0KPiA+IEZpeHVwIHJlbGF0ZWQgdG8gdGhlIHBoeSBoYW5kbGUgYW5kIG1h
bmFnZSB0aGUgY29uZmlndXJhdGlvbiBhbmQNCj4gPiBzdGF0dXMNCj4gPiByZWdpc3RlcnMgb2Yg
YSBwYXJ0aWN1bGFyIHBoeS4gSW4gdGhpcyBwYXRjaCBpdCBpcyB1c2VkIHRvIGhhbmRsZQ0KPiA+
IHRoZQ0KPiA+IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzIG9mIExBTjg4NDEgd2hpY2ggYXJlIHNp
bWlsYXIgdG8gcmVnaXN0ZXJzDQo+ID4gaW4NCj4gPiBMQU44ODM1Lg0KPiANCj4gRGV0YWlscyBw
bGVhc2UsIG5vdCBoYW5kIHdhdmluZy4gV2hhdCBkb2VzIHRoZSBlcnJhdGEgc2F5PyBXaHkgaXMN
Cj4gdGhpcw0KPiBzcGVjaWZpYyB0byB5b3VyIFVTQiBkb25nbGUsIGFuZCBub3QgYWxsIGNhc2Vz
IHdoZXJlIHRoaXMgUEhZIGlzDQo+IHVzZWQ/DQoNCkFsdGhvdWdoLCB0aGVyZSBpcyBubyBzcGVj
aWZpYyBlcnJhdGEgYXZhaWxhYmxlIGZvciBhZGRpbmcgZml4dXANCnNwZWNpZmljIHRvIGxhbjc4
eHggVVNCIGRvbmdsZSwgd2UgaGF2ZSBhZGRlZCB0aGUgZml4dXAgZm9yIGhhbmRpbmcNCnNwZWNp
ZmljIGNvbmZpZ3VyYXRpb25zIHRvIGVuc3VyZSB0aGUgUEhZIG9wZXJhdGVzIGNvcnJlY3RseSB3
aXRoIHRoZQ0KTUFDLiBJbiB0aGlzIGNhc2Ugd2hpbGUgdHJhbnNtaXR0aW5nIGZyb20gTUFDIHRv
IFBIWSB0aGUgZGV2aWNlIGRvZXMNCm5vdCBhZGQgdGhlIGRlbGF5IGxvY2FsbHkgYXQgaXRzIFRY
IGlucHV0IHBpbnMuIEl0IGV4cGVjdHMgdGhlIFRYQw0KZGVsYXkgdG8gYmUgcHJvdmlkZWQgYnkg
b24tY2hpcCBNQUMuIFNpbmNlIHRoZSBkZWxheSBjYWxjdWxhdGVkIGluIHRoaXMNCmNhc2UgaXMg
c3BlY2lmaWMgdG8gdGhlIGxhbjc4eHggVVNCIGRvbmdsZSBpdCBpcyBub3QgcG9zc2libGUgdG8g
dXNlDQp0aGlzIGZpeHVwIGZvciBpbnRlcmZhY2luZyB3aXRoIGdlbmVyaWMgTUFDLg0KDQpTaW1p
bGFybHkgZm9yIGtzejkxMzEgd2UgYWRkIGZpeGVkIDJucyBkZWxheSwgYW5kIHRoZSBhZGRpdGlv
bmFsIGRlbGF5DQppcyBwcm92aWRlZCBieSBwYWQgc2tldyByZWdpc3RlcnMuIEluIHRoaXMgY2Fz
ZSB0b28gdGhlIGRlbGF5IHZhbHVlDQpjYWxjdWxhdGVkIGlzIHNwZWNpZmljIHRvIGxhbjc4eHgg
VVNCIGFuZCBpcyBub3QgYXBwbGljYWJsZSBmb3Igb3RoZXINCk1BQ3MuDQoNCj4gDQo+ID4gPiBM
b29raW5nIGF0IGl0LCB3aGF0IHByb3RlY3RzIGl0IGZyb20gYmVpbmcgdXNlZCBvbiBzb21lIG90
aGVyDQo+ID4gPiBkZXZpY2UNCj4gPiA+IHdoaWNoIGFsc28gaGFwcGVucyB0byB1c2UgdGhlIHNh
bWUgUEhZPyBJcyB0aGVyZSBzb21ldGhpbmcgdG8NCj4gPiA+IGd1YXJhbnRlZToNCj4gPiA+IA0K
PiA+ID4gc3RydWN0IGxhbjc4eHhfbmV0ICpkZXYgPSBuZXRkZXZfcHJpdihwaHlkZXYtPmF0dGFj
aGVkX2Rldik7DQo+ID4gPiANCj4gPiA+IHJlYWxseSBpcyBhIGxhbjc4eHhfbmV0ICogPw0KPiA+
IA0KPiA+IEluIHRoaXMgY2FzZSBmaXh1cCBpcyBjYWxsZWQgdGhyb3VnaCBsYW43OHh4IG9ubHkg
d2hlbiBpbnRlcmZhY2luZw0KPiA+IHRoZQ0KPiA+IHBoeSB3aXRoIGxhbjc4eHggTUFDLiBTaW5j
ZSB0aGlzIHdpbGwgbm90IGJlIGNhbGxlZCBvbiBpbnRlcmZhY2luZw0KPiA+IHdpdGgNCj4gPiBv
dGhlciBkZXZpY2VzLCBpdCBwcmV2ZW50cyB0aGVtIGZyb20gYWNjZXNzaW5nIHRoZSByZWdpc3Rl
cnMuDQo+IA0KPiBQbGVhc2UgZ2l2ZSBtZSBhIGRldGFpbHMgZXhwbGFuYXRpb24gd2h5IHRoaXMg
Zml4dXAgd2lsbCBub3QgYmUNCj4gYXBwbGllZCB0byBvdGhlciBpbnN0YW5jZXMgb2YgdGhpcyBQ
SFkgaW4gdGhlIHN5c3RlbS4NCg0KQXMgc3RhdGVkIGFib3ZlLCB0aGUgVFhDIGRlbGF5IGNhbGN1
bGF0ZWQgZm9yIHRoZSBQSFkgaXMgc3BlY2lmaWMgdG8NCnRoZSBsYW43OHh4IG9uLWNoaXAgTUFD
LiBUaGlzIGRlbGF5IGVuc3VyZXMgdGhhdCBib3RoIHRoZSBwaHkgYW5kIE1BQw0KY2xvY2sgZGVs
YXkgdGltaW5nIGlzIG1ldC4gQW55IG90aGVyIE1BQ3MgY29ubmVjdGVkIHdpbGwgbmVlZCBhDQpk
aWZmZXJlbnQgZGVsYXkgdmFsdWVzIHRvIGJlIHN5bmNocm9uaXplZCB3aXRoIE1BQyBhbmQgaGVu
Y2UgdGhlc2UNCmluc3RhbmNlcyB3aWxsIGdldCBmYWlsZWQuDQoNCj4gDQo+ICAgICAgICAgQW5k
cmV3DQo=

