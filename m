Return-Path: <netdev+bounces-117172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6FA94CF61
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4493B21EB7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E60191F64;
	Fri,  9 Aug 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AgDrU6Ms";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4b7ah+nC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511118FDC9;
	Fri,  9 Aug 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203191; cv=fail; b=nN9lUc5fKgA1swNQmfy0f4QFKpZpHXfH44OGmrmGBXDh+1txRc4c6ZUR4Gp2kBtdiHFpZY1XEDn5N9cB6MfAXaaU9YGbZ369rvN97JoYEMFZP/Nqt6wa2BBIDWJCXwnC1m675IF6zI/+DNu2NPI+DkXjpn+kDixCFijexIBs6VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203191; c=relaxed/simple;
	bh=YerR6rxo6bVqRdmzBp/rXCEWmeYnqi/Wip8vuIgUVxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IYgd2BDkx0Trhm+pXHYblbUTUIlzrdA53Dmxt5sAANsusXJ8ytrz4ajEyW+Lgd6LUAMwhFPxXWQc2oxd0Pq9SLEwH7FmmhESnSv/UuNoYlNONJmbYoj0PeECP9z9h4lG2Ug2sqGDx2pQc5DOt5d+VxEPM0Z5d0lQjM5ttgqlHqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AgDrU6Ms; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4b7ah+nC; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723203188; x=1754739188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YerR6rxo6bVqRdmzBp/rXCEWmeYnqi/Wip8vuIgUVxM=;
  b=AgDrU6MsNG/ywiqtXa8LwL6moOJYZ9TOTKGGN0sW8laJ8OB6FbBURMpd
   /3LUuDqIf2gOj5lbZPv65OF6m8LFeR0jylGInw32UCiXEFFORr6XImzxy
   xX8ALyCylIaUa8+g1S4BBQQu0xT1HbeEyCinQUk0+j3/Xt1sfHwIZII1v
   TAUiz/30Cony2QayYiXlL/r0izD0g0kzMfA7+al8FNvg0BjG1fn7dvn50
   gIh+XEA5NipsVwsuvhNLkpOiTys/yjrO4USCQ3D9oRoSGh+OlO7FbktJJ
   lsWb43luabW8QzBHyisSfZ5sVVh6aYI+K86WDomNryC4VvA+Zc/QYxH5H
   Q==;
X-CSE-ConnectionGUID: H9qzFXkLSHq9N7YvVHWqRA==
X-CSE-MsgGUID: SIJtLhWYSyu0V+i3c5zC+w==
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="33200199"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 04:33:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 04:32:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Aug 2024 04:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgkwJgvt7CLJ7Y+qC8a8jQXMSgGuW7f4xqZqgRfRVgYqF5vwnzavOp50jmYEU1FF6PB5yJHHAbL9TA7jwPzMl1BCU1SowTAlTYw+NZJSGHuWvixVv63L0USZFuKnUVn2hV8HIhvP79cIzcEcyKgWr9XkeTiVNjUlMLVGyUTz807RmY5a9FiwRFDa6crkpcL5FtjYnhWK1FzwKa8yiT24Y5bdKU5Qnhvr67n4AVSLZhAPZLEYfzQb9XliBzoFW1OQS+3WSsc+1rMxF9ySHHwQDmsGqHpMJimJPuCCuZ/XoidrHj1CZp40m+4T6PJafTa4qKHC/yI8YrXAW/w5KzxzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YerR6rxo6bVqRdmzBp/rXCEWmeYnqi/Wip8vuIgUVxM=;
 b=R/Q7n3uuOEGcAQuHzGqAqdMUkSsrnUneVIE2r5T+as1ypPD9u8/wS+oVJ4EgCFV1QHFlsFcmKeQF7lfLsP9Ef6reTPKhqL+LQNpjsbNNBT68ITZff19pkzfMwkVJeGBbVhWUvin4fc6f7JW4sNZef+ReHSVRUON4tIBx+Qv4AgyF1Z57HdgjcIpcuLAeDgnyF6FkGfLR6W6IM2umPLHpkwzoHqM/LjeN5jqb14dDDhCEQic2/0zhikbuf1ZTDl8AoaEBZ0LaCdn7DKWlHtKXy3coRjNXZDHI2HLszOse6KXLfeklZyaomPdhylKVPeyueJEU+4q01jqmGAcieOXNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YerR6rxo6bVqRdmzBp/rXCEWmeYnqi/Wip8vuIgUVxM=;
 b=4b7ah+nCVzDnD/D8Na0qt0jYXsAHsk4mL9rbpU41gjkCgiTBzPfczgVDj/mormBC4u0e/nS2seFT1vDsrpn14yrGYGer/bIxp+Cdv9yJAv9bqdgMsucjcs2BQAWCczABNjRaQMENV/ohpyrnQZcx5stivRiTzhBzH/FIYwC9LgWI/XUlY9pNpWpK9kAk61PjEzYzIhjlgkX/cPQGyfPB0//dIMc51QFGXgSczF10Kl0WphPQA/ThnhTAszshNEEBwO/bJMJrYL1bJgY1H5oX4OTx0DipRG0Q6TYjq3z6iFISxMmYAPgYtHf8gE7viDdRYpJ4f7TBj2DsEypoM51lYg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 11:32:34 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 11:32:34 +0000
From: <Divya.Koppera@microchip.com>
To: <kuba@kernel.org>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: Adds support for LAN887x
 phy
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Thread-Index: AQHa6Yq368FyCB2W40W0fvYzUDQ2srIdWxYAgAFw3UA=
Date: Fri, 9 Aug 2024 11:32:34 +0000
Message-ID: <CO1PR11MB4771E502B69BE3B5051F3479E2BA2@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
 <20240808063008.6cce71f5@kernel.org>
In-Reply-To: <20240808063008.6cce71f5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|CO1PR11MB5041:EE_
x-ms-office365-filtering-correlation-id: ec5eac04-7701-4973-ef5c-08dcb866f69d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pXc1snYeH1YEXuR2ubZNG96xetySaFaDsFemnJXpYW7xjh5OQlBDXsbRCBme?=
 =?us-ascii?Q?+LX+TJYg18aF2ECeZ2fVdbQJS6B2ANAO3LFxz36OZmB/xjRLs2BDVs3qibnn?=
 =?us-ascii?Q?QFpVGTe3u1+OtzbnD0UX5uEUdW32Ejj+YxSd635QKrPcbh4IbBsdi0Eb7Gbv?=
 =?us-ascii?Q?qJZMiHf53i6e0uFFRW1IxQKMuGSJvmEyftF9CDwoiCDLAe8OSlMajyLhkWZd?=
 =?us-ascii?Q?611100yzRiqetyg6KvHnzCqBz1Jg4wcGIery0+oGhLoEvXhxIJoF1mGEaQPA?=
 =?us-ascii?Q?+NMUDT9sIZojax0IdWbqnLma7RRcWgyH4sSZSn3lIDtPyufz8ofnIaomp0kY?=
 =?us-ascii?Q?hAS7acc6mIoe9gVbjRsSRnhUyAo21qfJpfPkoqnu05g8H6XUEQS5l26aT0Wf?=
 =?us-ascii?Q?8JLbCh+Zr6amwJnmLkGVcGQd7LoV63fmC1QeZIl0/gy3At9lH7Ap+wexqsOm?=
 =?us-ascii?Q?lOumXgnI9JQsbmp45Jn2v+NCpiqslTg7HPyF+Kn4TzkvYzigJyEH0H0Jqoov?=
 =?us-ascii?Q?OXkmFL3xHsp8sBkGvCkcYB493nRAO3pzPBt827yDuzeHvfKIA+UJs7vbBTXp?=
 =?us-ascii?Q?CZVIq9Tv0Qhq2j41qYEQCpnw297XST4MBoRGKyYBvwHVA/QayIDWLItkqy6V?=
 =?us-ascii?Q?TrvzlTP2TPh92ZQiontxTrjIaG2plMxy9ARA2e//D8jIaNRq6XbRnAK3yeAr?=
 =?us-ascii?Q?1uz3gBGl7Fw0YCzZ9+4yh7XibIS/c2XuA94dSdv+LeL3qAPG8KKj6/PStPIf?=
 =?us-ascii?Q?Sum3cwPOKDvqwwabFDh+RuDtgHsedxLzeN6TBTGYT6TR80vQknj4x61g0VJh?=
 =?us-ascii?Q?TI4MWR0O+JAzxfWP99NJB6KtbvFY5lTz4Xf5ljsN3NhXPe05iu3ZwHTAzlvh?=
 =?us-ascii?Q?4QBjPk2insgCsHxK1Kq64ShRFwrB2xOCZZc7dzHrC0o+E9JcBXHoLw9EmBuN?=
 =?us-ascii?Q?L5L2YVsgvlALXnhgHiVbR1sdmPuUVsBQrQhuCRyK/vrRFEn0e+sUprRKIdrn?=
 =?us-ascii?Q?d2IGFhnBbN+lvW4YbpI0QsK4VApTH1qBv1oHs8lC6+53mnMZnTAKalDPe92V?=
 =?us-ascii?Q?PGctMVn5FOUX3jw7oncN+ZS1LinwlzDBToDqgCUfqMhBcUpspXI8tpTS1g+N?=
 =?us-ascii?Q?FjuKphd2nAKPcNxIvJgy7G7sljkNq5SWgphgWzQ+qDKw1oaKnJ5383uu02QD?=
 =?us-ascii?Q?r7HHnRHw2h6XQYPyofREg2saMeLRx/0tTVp6TWunGyaIWqlN+tBmV7b1M6u8?=
 =?us-ascii?Q?5lgaf8rBKpI9nwak8Rig1ra4DPZ1MteT6E8OpOziVZjoIW81RF7JEA1TaKgJ?=
 =?us-ascii?Q?ofdqh2/MfxfNyvesYkf0xe/WNdvNiKgPq1EjTACHpoOxSNkFY6yBGA5ef20D?=
 =?us-ascii?Q?LfUGQL5DivFkZZBUxcaJBBa/+LbmlJuJo5PKYSBS9UoFbRkbCQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYoalzVfaejX1FumS6pPXLldZyuF0o3YNmNwBIsTb/U0+mxdnZtTT3sDus0w?=
 =?us-ascii?Q?hugCIhxK6qX9fGPVL9GQIBTgoNyh0zN+hkTJGtNtsNblvjoGbjQU+jY0bU13?=
 =?us-ascii?Q?IuOKrbFFh4P4zGw29reCQ5fys8DiyJydGlouFxqkOsvUyF2Cn4sxfZGe9eWp?=
 =?us-ascii?Q?c0sISG/WGUWryb3LjXsd/FBonK3Rt2FLKXbFWaZFNnWj1c9nk+Uf07qU/Z09?=
 =?us-ascii?Q?1Vo7JAGLAEcVQSN30hlUQ/pAnyfDYcPNLfNTqA+vRsSysYRpuTHEosxDQ7FC?=
 =?us-ascii?Q?MElHCaPWR5o6Q63LwFBiuNxp3zmUBrVEeCzIyyxU8iLK2eRqRQeCVyNJG0ev?=
 =?us-ascii?Q?KV8063OQL8o53bRFQF3Z/Mc4h+IEa/DWRIlQgdbenWobIWrRaKkzIibzDFgH?=
 =?us-ascii?Q?tgRAWTZqAmCZnZoSKDTL7J9wdJUcFa/jN/JvVcKK75nGciBP7Kc7UtCj2bWg?=
 =?us-ascii?Q?tw24XGmJrmXwfrDTkRAwOoIh0LOmwfboCLA3vmKz8Rx8/oWYm1M88meEQiuT?=
 =?us-ascii?Q?q7zpBdvBmIcuvh4D3hcHzionpFqf0xlquCKv92lGaz+qoXifdOSoowmGeJ1g?=
 =?us-ascii?Q?bk5Isrd0Inr3CkoBswrnCPE7yyrxE6AKe/HXEdiIbaQVaxzQnOQWTIws5hkM?=
 =?us-ascii?Q?4/3yl7kaSyz1eJ3aRgE0hdpC4AHJnRY11iEkxN9MUnOiXZwghuzmXkFrfaIb?=
 =?us-ascii?Q?gG6vIVUVCw1/MnlRO6AyEtt4Eb6w+IJvH2kp9skwpd6Zzsfr4rn2CCBJk/x0?=
 =?us-ascii?Q?8LD0wcjevOdgLH8bDe5W/Sg7xovVEsJh+bJ0YZq6LCZO7qJr7syF6iwUJFx9?=
 =?us-ascii?Q?Kx6mPd3cSNkjPwiXcpBtQ04eYuQLWP6oz6Ad99wWcDfcrjAuA6Zyb1qtz2F+?=
 =?us-ascii?Q?I21iF0OqlCgDIVN4AVS5zgoIFrQX67dInAVqgmzfdk01xaGk8rtFoPZAsyJo?=
 =?us-ascii?Q?TxsZPjwjiCKK4zpw/DofWfTe0bmpjHSG1hCfBUbgQDE4bXxbQf7VZz5cwu2J?=
 =?us-ascii?Q?0lJa6+KEi5BvFwfAmr4uGVK+dYDPR1VwJnT25xqTEyiYeR4YF38WFKGFkFDa?=
 =?us-ascii?Q?Z+BlaF5zAaj51S0BVvzu7MjCH7tr4rdpTpk4i9rWzdmEhCgRTGvZgNFaRn7q?=
 =?us-ascii?Q?CqrR4LqZtXDplNjC1MhMr1COaEzYm2s5+vN+jUJ6JMCkR+D++v35DcR8eK10?=
 =?us-ascii?Q?ShvuXQuOLoinGptOf56tUkcqEPRpEZoiWtyL9izpQEFeNJ5T2y+ATJdihUTq?=
 =?us-ascii?Q?/hl2tctTsb61gA/+pZ63+R1vYiophhFWeROu5/aTxXFLCWctc5P2E/eqXILj?=
 =?us-ascii?Q?FpP2bUbGZxLw5lyTdK5djaPIMA58XX7CW9qHhjcotPHLzbegLt0lR7irAVn/?=
 =?us-ascii?Q?eGwpAPw/6US6GVZEwWr0CvLcbG3qHaqG5mUizEuhIqEyzHVML02o4JwtyuDc?=
 =?us-ascii?Q?t9790n3q5xA/7GvEUuuQlQvoLx1KdADsoYhf28ZO6MC0an65SLT8V7npvt1C?=
 =?us-ascii?Q?wLwZRoVYU2emHapZ2PfARFB5qXGKlJRxuK6xFlBaOS3ZK+1iRzFJv+G/vdlD?=
 =?us-ascii?Q?brEo0xatHfEaWqrS4hM7NtsvykbaNVYmIY6AE7qhwS1sbCe/cZmGqFafL6qj?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5eac04-7701-4973-ef5c-08dcb866f69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 11:32:34.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxoBqmg5diEOhHUgtUxrMcHK+1CUVYuSmzumFmtWWbAQCfydQJaRIi9fUpYPu6gFnAT5Du1otN8TqnkDk9J4LJ83nxiIZAYcRae7Q2qpB7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, August 8, 2024 7:00 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; andrew@lunn.ch;
> hkallweit1@gmail.com; linux@armlinux.org.uk; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
> LAN887x phy
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, 8 Aug 2024 20:29:16 +0530 Divya Koppera wrote:
> > Date: Thu, 8 Aug 2024 20:29:16 +0530
>=20
> Please fix the date on your system, I'm replying to you an hour and a hal=
f
> before you supposedly sent this, according to this date.

Thanks for pointing this out, I'll correct it next series.

> --
> pw-bot: cr

/Divya

