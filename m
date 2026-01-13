Return-Path: <netdev+bounces-249436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F8D18F62
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90DD831BCFFE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711D38FEE6;
	Tue, 13 Jan 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrqIZoDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC038FEE3
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308161; cv=fail; b=mSMdIdBRqk6Nfdh64P0Vwvg8BcqJk2VXd8ULZqtvg9McPlYdzokl23nMPDPQf38KniUJ+ErH6EDiJsCkfR1X0UC7+Oc6NTxLJ3i6X2ZJtIhIxDGapV6NZ6sDGjTFMPHAvx8kLC3sHamwmmIHbxmgr4fuLKCNI64ovFZfGyDe2RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308161; c=relaxed/simple;
	bh=wucKV8kDG0QDVnE6Rkc0ceTrpascwhmnz0eLIVPYAfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SKEXX4r/H2H0hl35x91AZmW8w30o6hsQxwImcCGXDqCh0Oi4YBmqtJj7JQeJg2Y8XhmRWKxPG+bkWh/j0rdXHrR/MwPHNuL6hvXTwK7ZJsddFu5ggj3BVOx3KZAyzrV/Sc0NyYdRVTT+Eva5EWSU+0OlH0cqFzR555fOvQtOhf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrqIZoDZ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768308161; x=1799844161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wucKV8kDG0QDVnE6Rkc0ceTrpascwhmnz0eLIVPYAfc=;
  b=lrqIZoDZoCLt88I3rL7D9owwVBabKrBjeFsE8P5RBrNFBdvqXtfy+t1s
   PwxoEogNHF1gFZXL9I0o62+QiOglvuF+NvkDpl5KxNSQB6c//M4C5cSnN
   EODhSuBUzASBH4UjWMbTcQGcXq1UQIcJrkKlzHk7O1epnAG3f6zw+DPEV
   ig/3IfyXBqkONc1D84JwCgummP0GE2sqPfP8bo1XElaWRcvcXSyR//Bbu
   DZHO726nillAUmxpKba4zfPTg7/bNGGEw93bxdk182ANkm27UN6QOo/uP
   51yEa4xWyVq40UKls8iZ70CtvjD/NYnuljgASrqv7EtfMDAUAox6yHOWA
   A==;
X-CSE-ConnectionGUID: XyAzyKr3SaGdZ7DRTGcuBQ==
X-CSE-MsgGUID: nIAL+iH6SQ+vnioavK+KrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69748838"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69748838"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 04:42:40 -0800
X-CSE-ConnectionGUID: XTvb3S3lTeGqE1p/adWAzA==
X-CSE-MsgGUID: nmCOMHJQRGSHvUaAbaprgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203586472"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 04:42:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 04:42:39 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 04:42:39 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 04:42:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duDTxpliNXQVJUkydekCUNFDgikdra1YrXFVDPTEdTSQ/DVTt05CRxAXrx4mf/fllhMIH2d5eptW7SdKAzYVsTnmyj31gFb6uU5R/NxVXj9h+gjk78sz8s83FPA122hyHqVRr1f+h4NnN9qn7fgmkjx0agsE5esepP9MggcBhuiQuB51ADETzFm+YwO+cc57APE75snI2P6gZVpGrEnDKdWgjZloxEQZtm/fKKqsv1kLgk0yFYBZEprPqTqnNwoDQrTJxdam+y+yncsVVSaIr6SP5FrG8L5impKHDt1HufpmJzbcsrtTEUEfc3SS80JbUe3UUFE6DsQL9lJpUYzodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRbP3AEv+GS93eBrHuduIlDH9V0Vo5qzB3z1PUCdnf4=;
 b=YyyGuKQ+qvP1KV2SA61Hqcw3lJiZ4rhjUbxeMcvTR0djZUj/6s3+P8ax1ucXr3gYEze7ZG2uAX65xMnv/L0IjurnLxkyLZzCnk6c+VnW9UVlT5cGgQisSaxs7Es8hDEZxuIKdAj2WEwdihPUUTPnK6Lg3BreiucIj/xDsHiNGCtbk1VUI/aaC4kgcCEHeretgYGmPhE1R7RUA0bgqK8nnUCmU5Tv73XbtbtbuLJcG1Y+51SgtKtawWPJJaUBrJaBJMdOIiSgZSOX90e11255b0vuZ4qdZsFEOEfOq9uRPRtAAvJdiHgUa6TZ8c2yjW/EmMj16y39SbacVxRGReO0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:42:35 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:42:34 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v1 5/7] ixgbe: move EEE config validation out of
 ixgbe_set_eee()
Thread-Topic: [PATCH iwl-next v1 5/7] ixgbe: move EEE config validation out of
 ixgbe_set_eee()
Thread-Index: AQHcg85iwb4Ax7fHEEaG2QEK9WoJW7VOqfcAgAFglwA=
Date: Tue, 13 Jan 2026 12:42:34 +0000
Message-ID: <PH0PR11MB590206D74638658471D9964FF08EA@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
 <20260112140108.1173835-6-jedrzej.jagielski@intel.com>
 <29577cab-c96f-4799-99d7-c78cf61cfd61@lunn.ch>
In-Reply-To: <29577cab-c96f-4799-99d7-c78cf61cfd61@lunn.ch>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SJ2PR11MB7575:EE_
x-ms-office365-filtering-correlation-id: 75a9f97e-05c5-4a3b-3193-08de52a139e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?gBDxUtD0B9co4lZhJ0c4Q4bLfeJVxTVKrJNNNLeTsXnZj5G1fYiV0PGO4sye?=
 =?us-ascii?Q?1LTkYHwggiR4FGCrN88Yq3rXqO60EBElgYpHyG195eVA1nTBMdfGA1IP+Z2a?=
 =?us-ascii?Q?0K5dZGnTOBI0CSp0Kug9xLamKNmBpVS8TA7muHd10AtTDALQIiU1yvw3GE81?=
 =?us-ascii?Q?iFSjR/Y71Sv0lF+UiD+VIsRDjNOFUMGSAuqnYyduFrBidsjKUXy1tDKYd8uf?=
 =?us-ascii?Q?vQGm9snAe9YueTHzTF571s5FUxVIo+HcEZn/JX6iUZe/37f96ejRZhO/Mp8V?=
 =?us-ascii?Q?tGkk82EX46RvBK1dTHPN3lpr3cM9aX58M5u7dyDN6Dnv6jBmEU8gQPQSEp3x?=
 =?us-ascii?Q?1feZVFaPOkm+0fOWvvIY0SL/EVBG/bbevbOz4rH7F6kg3t4HliaK6ah2MpDD?=
 =?us-ascii?Q?iCnHo2MLbdM4qUpUqlHtdZUVP+29Fl5ip/BPWYgMXODmOIuXfvck+xw/nlpE?=
 =?us-ascii?Q?DB6v8a7bJ1n1IzmsVyi8m96wt6dmFODfuq2hjXZ36/rrJBiY8XN6IvWp8JqT?=
 =?us-ascii?Q?9awfXxLrOTOWZRDIIInPVzxpJLlBmEFo09AczCH6JklYSZZ35BG1t9CvIszW?=
 =?us-ascii?Q?UaLJQ6CoBuZ9JfxyxUE003wHCysPXjJpNKE3XO8FYWYNrS4qTtUQ3kMGV/yt?=
 =?us-ascii?Q?3SlZ1Fmq9821MC0ORsGW2afRfePPbxnvkt+GKtVlpKUtUkjZIXJU811NZAGr?=
 =?us-ascii?Q?30EjhOXv5+Wh1T0q8vUlOXllvcoK4H8Kz7JWGvlNJa7aM30tN4E/WhMlDVK4?=
 =?us-ascii?Q?QEBwFQ2Tf8aeKIoFAukPyQ6O86jexm0TWAfsQfdH49ALgE/MhC4+pfnGhDhq?=
 =?us-ascii?Q?HefhnWl4hJSr2HU0BsPzRAN9Fr3hlKhjlITj3i+/zxx3P5LLOTPFhaGnqhFW?=
 =?us-ascii?Q?+LpC7pBkRuxrphaXgPxSvuBXA7ZMYXtNrttimn9B0Mi/bGWduE0NdBZwTTO0?=
 =?us-ascii?Q?YSC1e/I1WLKimmAuMsjL+mwdkD3sKI4uDmaKJn2mAsUrT5skd+8b4WvJQCSu?=
 =?us-ascii?Q?2nW787wBtXlzKTLyTv0KHjR1298SzUDmSjoIzLiTNvLEr3f8CxvQI2BZA7v7?=
 =?us-ascii?Q?nmOYuUprgTvJlwrerSsK2ARlLKviJqDOa/aBFHB8hvLQ9XTIs3yVCpYDR7GW?=
 =?us-ascii?Q?GkNQaXOMGudrlIG8EEk1StEbtY+2JgTiqkUajTMbq1wgcCDJqTCSz85AdHFQ?=
 =?us-ascii?Q?NBCK62c2Jwyl0uRRrCf4dulsBFz517rRollAFwQ3N/oagBVIvTmEKpr+nywY?=
 =?us-ascii?Q?X5iuS728L6i05yf9zxi3tTIeOZT+zesv+GVGxJ+7bxUY+9Ih8tsbvVSX55CT?=
 =?us-ascii?Q?KS/UF0pNfVlY2g1EIztXL9uLQjW9u9192tY40XJYxziqHBI12ygcDwu1f3yD?=
 =?us-ascii?Q?gGBOBj7rur+q0Oy1/wCFnZqo3NtLzTQuJezHipDv1sUYXjRO/piljas+IEpv?=
 =?us-ascii?Q?2vME4EDJgqt57nuJ4UOAdzqjh8jV4abcZhZC0WIBR5qf5ef4lONBwqIzRoNO?=
 =?us-ascii?Q?x88OKgoGE6yTjRR+Aiucv0OJzyNr1t9lw6+y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UbCSm1hpxqzESnScvm7euryfQ72DlSdhXUiyUgR5o884nUxuhSyEl1kfee0w?=
 =?us-ascii?Q?Nj0xGNX8BGpwuIK9a8EpvtBihNP5UjUNUvivsPXxcDEXZQWTo6T7FlMVGDuX?=
 =?us-ascii?Q?61iv2vUXgn03o1DxUboozxIONM+e6uvYYlheEjiHxl7A2nPIuPdD6W/jpVkL?=
 =?us-ascii?Q?eomdTUufNXLHXX1Y+eOL3WIn2hXcXBnRtWXTo0CcmsibGtjwwYmIChyHEw8O?=
 =?us-ascii?Q?1xMM9kH0jSmn3jtuiO10btJSzGofotNaOXJ0KCgE2WDG5jM9XdMEc/HedlLm?=
 =?us-ascii?Q?AlAM3kWkIfimw3un7b+tWxTz0FakWcMrKdFbCIWfKHPIH5K6Pfe6v2QwSGld?=
 =?us-ascii?Q?/KNAxSXbk4up8JybWueY1j486qyYt8EuC+FmdiNKP/Zs58cahArHqp8/0W7K?=
 =?us-ascii?Q?XvhHa2Ckh8MrI1JCQ3rYR3+i8luoJXhlT1x2FqerGaDAArjtOqdETmogrAjA?=
 =?us-ascii?Q?4GhAbAARRq+pX4BbOkyVVqkCHEzFnxiIo8BnBkBR/lh5nV8byXfYzj+0oFYa?=
 =?us-ascii?Q?xEX3fxANyDS9cIuIlpyEEnlDdUc7XzTPGuq1VTJbGPetnwjs7jKVxhH6UVEB?=
 =?us-ascii?Q?qCN5Le552zw0HtqXcgqCrh9LP8i5Yd9sJG2pHHUSNEsO7ihbVhflM+jcDwzF?=
 =?us-ascii?Q?tCXMg9Nry7SqTLQHKipOdGiXxqWejdww2ygoatCjgJRGXLfzns5BbStt5+S8?=
 =?us-ascii?Q?e1Fjnl9r4lyYTUkkh1W+5EvnZIAnRGFcBwxOjgW/Hz6XSfn23uzpudKzYSLp?=
 =?us-ascii?Q?qmlV3NQ41tClNuXMr1QjCiXMhGRSJUlHcmQOuXWXy/XZ8XpGb4wdDhNFmUxA?=
 =?us-ascii?Q?LvVAUAxTkq07wnndvJ6vZ0yNfcDJIhwFWSWsbmKS3qdfJ2ktVN3DqC7wj0Q6?=
 =?us-ascii?Q?AAvYciTbDq3Js8nJ1Pw9VFMLQFBZv/fHJ0k9gV2WpwQU+HF7Q8286A3bvqGF?=
 =?us-ascii?Q?CXLDxSCOnkyhJp0K4lmNniVX//GFqnJBhSG4pChIoC+9rQmUiC08jBSNYrHl?=
 =?us-ascii?Q?4+as8F2xxB+dbGQyLP7+NLKABiP1fXK0WcLjyeEhSb2SAq/7sxeZ+DPmqfCH?=
 =?us-ascii?Q?N1ttlVA67YxKqPq8bLDiGRjOWFWOK6/JV+GzifpI5+wlIXdfqbVQyEXWiCAi?=
 =?us-ascii?Q?7uxK+YiwtSx38ahQY+dHnKxlWve8c5XVk5E05m7JcU0AgPPnUzs0fZxzzzPY?=
 =?us-ascii?Q?gBY3yOyiY7AGD63UexjZKdVQCnUDac2pn/J/m6ote28A8lKBiVYbZ7AfEDgN?=
 =?us-ascii?Q?6nN1j08/viRnbQ+z0SDemckuzyvB3g9s2PK7WPBc8hZfNuIjadGkzzTl2mWI?=
 =?us-ascii?Q?U1mUk9mfWknbFDsrAE9pVI3Jf36qF0j1fRus4b9VrHDDFlMCrntV/Ib4/iRR?=
 =?us-ascii?Q?KqPpe+M3MtGBEL8ELytbxBPAR6IkDYf1AKhEe/aVhfsaqxHFS8eUrWSNAQzb?=
 =?us-ascii?Q?mitqCCwN0FdNNDh2MeHLOmvO2so2eyTaZdMmrYQiQ9slttHaqThh4VW8FUFw?=
 =?us-ascii?Q?i1Vf3WEKlkw3Sy2sKdvnAVRRmCgjL5oMNnvAgtH/Ze5e/J/MpnRBRBpnzgRE?=
 =?us-ascii?Q?O7M/U+Idm5AImlutsUP+P4n6SJQ9hKhzLz4ok+stjfKzWh5MzaoWex5FJAAR?=
 =?us-ascii?Q?yg8S4fKbgeaKMlp24bCcpfGilbgDw2usd9vS7pED/7aqgNp+mdJZ9KVHsTvD?=
 =?us-ascii?Q?5qF14wuE2E2dDPuCJGlMnnqRL4TUn692c8aOCH5JH7Ubsjga0c753khx4bhI?=
 =?us-ascii?Q?tjCb/NuG2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a9f97e-05c5-4a3b-3193-08de52a139e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 12:42:34.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFZC2JdVqGqElr9mf5i/feITTNpU+djM9aSHv2FZNFayK2Ewn4gnrid+SAAtcDgLnWFafjpS2lHDiClpRfHSkFEV+uPEat4UY5qcL7dD9B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-OriginatorOrg: intel.com

From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Monday, January 12, 2026 4:33 PM

> +	if (keee_stored.eee_enabled =3D=3D keee_requested->eee_enabled)
> +		return -EALREADY;
>
> know this is just moving code around, but i don't know of any other
>mplementation of EEE which returns -EALREADY when no change has been
>equested by the user. Maybe in a follow up patch you change this to 0?
>
>	  Andrew

EALREADY is used here just for internal purpose to save some work.
Then we can have single input validation function and provide info
to the actual ethtool callback that it can early bail out.
Driver doesn't send EALREADY to ethtool, it's later replaced with 0.

