Return-Path: <netdev+bounces-123874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42F966B4D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96221F23064
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586116CD28;
	Fri, 30 Aug 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHwrZE4L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785B1474C3;
	Fri, 30 Aug 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053579; cv=fail; b=Nndd+rEk4lCYnWzXD/F3d5dvh3Tcb4pvPI5YF+5y3IRAbvSvqc4EB5uP0iCkgsc9joc4PBxB4dzhEDNfqh7I8jMYgZLsFtemh3+qTBKiVBX5/6zf0bpEiiP0XpO8T7FpYACikyuzKMxBRqVBEVCMhKm5lg5v1R77O2sq7dUdBNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053579; c=relaxed/simple;
	bh=bDhEYPCVDSIKRS5nbg3HC18nLaqY+BX6lyHj5eZtOoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npQgsHTCCv99Ie6fGs+ok8eKhQVZ+5f+evzpQ+cBsFsIogfealT1rqs+TQD1YTjRkYKJQ0eVKEo/FcsQqaqNzJudAaTES0x+CuhIPxyfgX0NPICQxFbHaOHa38SCVCHaSoP7Xg4YfyVCcW2djKBiNOPONjrlttJVZwsi6WV1YZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHwrZE4L; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725053578; x=1756589578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bDhEYPCVDSIKRS5nbg3HC18nLaqY+BX6lyHj5eZtOoo=;
  b=RHwrZE4LuU/5PEAieDifyeBKtIWu70cwjeVNn6tjN46n/3cOBozEfA4V
   fanSDB2hHPskK621kVt6QUrTonztxZHTntD2pdPGne0jWuQ89SVHa+LBB
   xrbRHgIVjh2tUnQPVB6WHeY1a06FW5VLEgvKxOQe5lQuMSyoCXFHJcg3J
   aDB5JqJwYhMX4yNzIDfnB0UxerkTYK8f6sxkv+EB7U7TBCQRpYv20lxv0
   okDGTpbDvLJqc3gChudW+Yfx3jmuamaBQWeTxM20CdfoLwNQ6QvwMIcX6
   NIqn5Mez9fncqQX5vaiKlDx2LDm0Ix8hP3hCnx6mqHmubXKwUel1NVr1P
   Q==;
X-CSE-ConnectionGUID: bqVEFeeqRPCxDDbkwozK1g==
X-CSE-MsgGUID: apd1PEFoS+6JpxFLTyy+Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34325065"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34325065"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:32:56 -0700
X-CSE-ConnectionGUID: 4lm01ph2TBmZZdk3d9mWYA==
X-CSE-MsgGUID: gufDUF/1TiS6ODVCbwwbmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63822703"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 14:32:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 14:32:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 14:32:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 14:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeT1acSjq5gAX9/B4tt+AgaODZfRwXIRH00zKuoTHo/Xx0jWoLiV7tPR19wGE2xVV7parobJpnEZYd1EJymRQtuLNUABlE+TGBV9GG8zH7kz+0quaF+z+0MxjlNbF0LRj2XaK2ZGp72IDKNUex2ompnURHhfyCbZRTKe1xcyNUMXIPllBcFJKSYMdgoKcBFs6gaaIBtbTOJk/TZFpsRjzYIg8xJMkJmJXOiucAQfQ4iQxsRApz7MGpPlkhnRlcp7dUFKFC6I/ZzFsksYgKgsEx9cXoQ54EdIuqP2sl0atAK56b6vTKDU3HgjgcGFxpU4NvefOiCX11BsKnhEVhXWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHxHXQnwxCXXuXKakOGSMssTAaY4c1KBBzZqJMSa2Q0=;
 b=zLzFuiuRIuZlacUFD+6Ozrxg9ouAjd8+euTj+hygXl/ku/hpDv3qOyPWNyJPNz6hiC1Rm8VlXhEe5TBS8vXaYdKBYlcqJ1dfOAhYjHiE79id7gZYONN4vTsQQMy7hpgd19p6oyyMYe7aqVKCtz4kvX5JA4ZU2Z9X2ybrIU5QI47Wz/5JjddBdbenblHFTPWQsNoKbLxtVxxSGYR7PCz73jwKPQuM/pw4x5kx1zEXnlby0SPwOiC7YmYff88FCprZ/mRnQODA2+q/V+zgoRYatyrG7FPHyYtOrdKngfZ1/RwlmVZBvUp1UYaAtP8QzYi3q/BBE7tZq6touDLmDsh16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 21:32:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 21:32:46 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lino Sanfilippo
	<LinoSanfilippo@gmx.de>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yang Ruibin <11162571@vivo.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: alacritech: Partially revert "net: alacritech:
 Switch to use dev_err_probe()"
Thread-Topic: [PATCH] net: alacritech: Partially revert "net: alacritech:
 Switch to use dev_err_probe()"
Thread-Index: AQHa+v4qi4S9Ps409k+ZlwNALDpNhLJAHucAgAAjEwCAABBJ0A==
Date: Fri, 30 Aug 2024 21:32:46 +0000
Message-ID: <CO1PR11MB5089E36B575718BD74F92FA2D6972@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240830170014.15389-1-krzysztof.kozlowski@linaro.org>
 <20240830182844.GE1368797@kernel.org>
 <0f8fbbe7-4a91-4a18-a277-06d144844c2a@lunn.ch>
In-Reply-To: <0f8fbbe7-4a91-4a18-a277-06d144844c2a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH0PR11MB5141:EE_
x-ms-office365-filtering-correlation-id: 8ac2da5d-8be7-4e22-ea1f-08dcc93b4a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7Kjkl1OyQ8kE5Xz/StP+BIyfqhEELrvq+KVhLNGm/xhUucch7kFC7YZ4b6g9?=
 =?us-ascii?Q?XLfNqaxNRe3FJaL064VGzHWpAxHg/Nz5RGTL8qhPGKLXhqCNRWYtckwNZXaM?=
 =?us-ascii?Q?FUEyR+ZU2Re5w8OQBVKEwC0nTLfdjwLErW4qwqftNlPslPerAn9zDhM5/1Ln?=
 =?us-ascii?Q?qlhFRGkwHeaeuOFQF+6fAUzSZaTdqijyxQh7HXO5Alc5MbWRBnOSk6nvsH/1?=
 =?us-ascii?Q?cZe2Wjv7On61WoF6VaA4AvjVnbrTboIDiO1ybfqoar8iXa7m4P2FyjmVyX8d?=
 =?us-ascii?Q?KRzJw+Ngz+DbFHCUtLjfWl1ikdUJUvgp4A1FqvB6LlUStwBR5MmjzLSNt76d?=
 =?us-ascii?Q?C6nn7lakaYBkM/mq2hK2QNEjVGiD4dQNlP/Z0ge4y5YgJ8TpabZEOOQdQi6h?=
 =?us-ascii?Q?1VynTiWVNRiph9Wx2I5X6z7A7xm6Ftj14x9bnau8U8Pmuvuhf/6MMOOfBQHx?=
 =?us-ascii?Q?J18MvUsutTEh8PJq40el18yvO8lWZQQ71bgjjQ/kOTLyDruRVLPn9wPU7Rwq?=
 =?us-ascii?Q?MuJo/e6IMyGuXbXuH+oIiCe4T8yA9zEsn53h9Y6ihNjlJqRlaLVCeU0S3B2q?=
 =?us-ascii?Q?Om/vNFWAq/n8DWMLgTKcHtzzeZ9bcauJiz0GGpZghleVyLbTIWD8K9ASvxVp?=
 =?us-ascii?Q?UJblcT587KwI+FHvWBLBd5HH/+33S5nGDvvUY+PKLLdmF6xd8LfDUsZ6Hfb2?=
 =?us-ascii?Q?7gky2CUZ/gezUT3bhRDthvWp04US5z7sWK1YH6e4eqXO/ewlR7xvf596G9tn?=
 =?us-ascii?Q?3ntmk1amK/WxOEG+07Np76JELLXzU6YY91VE0oADDK5ba4nkD7gsKa5KtnAc?=
 =?us-ascii?Q?QTu61dsR0TRN/8/H/FmfpcdKD84ffopbK4pJkgkB6hV31fX8uyLiRUYGbm+k?=
 =?us-ascii?Q?JNxXunXjPP9suebiH6z9norn6YPPYcjEfoNA3EI1IIMZTvfhJx3uC3RAZiWX?=
 =?us-ascii?Q?teh8uJNNez2JH5otpPh+lurwEX8z5qhvckNZkrf6XbDddlIKe62RwPejRX2C?=
 =?us-ascii?Q?0axGikHfFTa0c+6637RzRE5Kv4STvsFFleBxekZ4NCR9ZaQgRVaBdVHvnPRA?=
 =?us-ascii?Q?37ZZ1RYiRUEBOzXf3sei85NbKAAoqaq+Ob/6VBhw4m7qbGfBri30AwliFEYG?=
 =?us-ascii?Q?wcs50X5kystMQfRmgpdKJEYQn0DNadKMz5YVHeh70HdK5fNV9l0j/tGF1YOV?=
 =?us-ascii?Q?u7JIZNBjGIyY+a7bqFmohraO16YmmM+tzBPODF+ldnVeHSanxJDXR/mIxfD3?=
 =?us-ascii?Q?UF4tTOwUswgBJjjWZWNyM7CNazI7ZTElrJDDwFb4D4zoGs091q04Ba65g4ce?=
 =?us-ascii?Q?Rtb7oQ1ngYUFwn4JYg/EZKgzVDG7bwdqS5u8Pq76IyRbJDZdp5v8taihIPIc?=
 =?us-ascii?Q?rhb66RipxRAtQ+sUQGCg/bdkTgmfBpCJ91LEkXNBUX9R4w7pbg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fTAz8nY9xwDgpWfIMl3OGMvI+RTwOj3efo2qXYL2No70fCGP8+j6zZJioNJs?=
 =?us-ascii?Q?tA7MSnf+bdUYrZ0slCg7U15LYjridvHaxw+mxzjW6Y70pe4AUx4HWiZmOqlN?=
 =?us-ascii?Q?BO7aMwSLQpwSAdP3OaXO4i159P31Vk/aP0H5x4YxMlxW2Fhu3eY45SHxwMUw?=
 =?us-ascii?Q?g+3jZJ7xll/FjlqpFMx0n3EpAnL6w3Zv0/3qZwEjpYx6ssxaM2+YnHvU0DRf?=
 =?us-ascii?Q?RDz0kxeANdwTRVdYMJ8Ue/Jp9naUBJHj8SZrR4jRvdjbG6WlG+QNoXQSFV+5?=
 =?us-ascii?Q?3RuDLY02kZH2Q1wsPEzHD4vW4A9DgYNhUZ5c1SlmIKdeAocqgSvd/j/wWB5Z?=
 =?us-ascii?Q?aehrw6MyQcf8E1qxKl+rZF93UASmf+WQSiziOmjyd/DPXZjUCRHVcspVKcE0?=
 =?us-ascii?Q?Z1oCBFgZB1JtIZrTRE0mZrfX08dTEtrDs+KUJT0rU07+/S/Ks/n6UHrB/Esx?=
 =?us-ascii?Q?fuuU+heSQsoBSP+rSepnfQeYBUeTv96d+TCPOkYGeH/jb7mf0S/GXaftci68?=
 =?us-ascii?Q?6PMoKhzMmWsFYlhXPa+Y0ptyLCtKwUJ9U/s7zYIgF7v0UNu1Fxt678OgFq5R?=
 =?us-ascii?Q?j0P4vsCGZQyoHQaSJ5POprFnKVq684+e6wRhgOd31M9JtSc9j1xfNBc0PS6+?=
 =?us-ascii?Q?4yFPSb9AMfVGoD332qD5Kismhb4jwDk+2fELOz6XxV4l+DLQ3MKzSJseozyv?=
 =?us-ascii?Q?cqJtnJx4BtyPN4NIKMHoSJBgCRsm4fZBH70KjQn+YZu5qEG42Vq92O8RYtA0?=
 =?us-ascii?Q?OsdA0ayVMfZEykPs9QMNQviTZww3wkGsK0MASMD6gCJwsP0hCLP+CxXb8iAc?=
 =?us-ascii?Q?IuXt/KfqbEgtIkEtqSblwJ4X2uj6Cg8VsJcaEa09LFsEwy3vCCtl7RHklYvi?=
 =?us-ascii?Q?JeNv/XxXHMuqGJbsvPSZ/QSVf9TiayQhhecCZaHEooJhauAOK+tG62bLkX9O?=
 =?us-ascii?Q?4iB8apL42KQlUK4v4zbvtHEJgmUPTS7ubmRn8tNtxi0YpMBU9s1n+JbHWVcn?=
 =?us-ascii?Q?sDpoAHREP7txbk6QxsTtvSvNxIbTw/TUcrkBdvXAfOZN0DkT1dIc4fSpaND8?=
 =?us-ascii?Q?EEt1/LFbQIAP2iM9UdCaUc/ZHUqixALS9pqq6xtsIK7U7L7o67oyOZsG4f2K?=
 =?us-ascii?Q?eIKLoFRxlSC2/1cutgu9+yOCRYDGIs7zAzZPN+mtN9psTyHzD66nGJTHuJgJ?=
 =?us-ascii?Q?Q5Pv29yjhFGZYkmDv16bp0n4zjGGgIyCXBBQrZ3jgDTS68jRhA9VmF28kQVR?=
 =?us-ascii?Q?dkPbJieSmBtSgoCyQKmC4ZJ7efglZx5nCOiU/KP60j9f/COYX9ChcO5TUtv+?=
 =?us-ascii?Q?7HfGufE/i9hXBcjPzGoCFu6YvUryC7hi+kYyadF1xzFWR8B2UOd46zgPNgkO?=
 =?us-ascii?Q?9P3LaiO+zSmoBU4jBPPvQ0Bw6MMtg5xd/ZZ62nCW1e/JOMbRDLcMBV4JJcrB?=
 =?us-ascii?Q?t/ZM++3khxvzWxpgeBHcTWjrPPY5OmW8wqyTe+mEhklUByWPwoTn5hYsPFdp?=
 =?us-ascii?Q?zzntYCtLi62aQCv+d/JU1dGWBaBsdO+N08OSdA7TzvoXooWSHHKtI7R9shlp?=
 =?us-ascii?Q?7IVoRHTZnzNckli7WW99/mw3/SMupTTAo+/IZDaW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac2da5d-8be7-4e22-ea1f-08dcc93b4a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 21:32:46.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpxcR8rSHulwaGo/g9r/9tPstoiv13jIasJEbsKutWAWLPunmzhDqNZ7ET5PqWoEKVTBf+kJQ+DeJxpgcDWulbjLp6LQ+2hxd4CVTC0NXVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, August 30, 2024 1:34 PM
> To: Simon Horman <horms@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Lino Sanfilippo
> <LinoSanfilippo@gmx.de>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Yang Rui=
bin
> <11162571@vivo.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] net: alacritech: Partially revert "net: alacritech: =
Switch to use
> dev_err_probe()"
>=20
> On Fri, Aug 30, 2024 at 07:28:44PM +0100, Simon Horman wrote:
> > On Fri, Aug 30, 2024 at 07:00:14PM +0200, Krzysztof Kozlowski wrote:
> > > This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because =
it
> > > introduced dev_err_probe() in non-probe path, which is not desired.
> > > Calling it after successful probe, dev_err_probe() will set deferred
> > > status on the device already probed. See also documentation of
> > > dev_err_probe().
> >
> > I agree that using dev_err_probe() outside of a probe path is
> > inappropriate. And I agree that your patch addresses that problem
> > in the context of changes made by the cited commit.
>=20
> Maybe device_set_deferred_probe_reason() could call device_is_bound()
> is check the device is not actually bound, and hence still in probe,
> and do a dev_warn(). That should help catch these errors.
>=20

That seems reasonable to me.

> I assume the developers submitting these patches are also using a
> bot. It would be good if the bot could be trained to follow the call
> paths and ensure it only reports cases which are probe.
>=20
> 	Andrew

