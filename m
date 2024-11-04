Return-Path: <netdev+bounces-141503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DBE9BB2B8
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAA5282F7B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E261CBA1A;
	Mon,  4 Nov 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcKRjgOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F5A1BBBD0
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718033; cv=fail; b=Npfg0o1Q1MxbyeqeO7pj2R7uDhvUTFx5qL+B6HxDebRgeY3Q5MS0ohxV9kCRnVc5BxWass3XKewYQ04FhFgkJU8DBctVPlXJ4SqllMIFKSwgCalgBxFXZXqtpw1OGyIcvEQp+l9MvADUA7GcJtUuJqzLMANUcC+Ue/gfD7K51hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718033; c=relaxed/simple;
	bh=hGdj7zn2TP+HgLrf966bJxFrKB5+88tyi6BR8E+oq08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ju2c/kFgUqZ0TW+We6Bw4RwenKU2fx4gu/UX1uFuIfSZX4SFeefas7F0svqT5I5NvWjyNHfJGpP6Nsc83eFIk2Sig8Ya02CYONYtvhBzrEItgtnylFnsBntWEkLIpT2vKVPLD9xsbib6AdWu4SbvgQzRVjrmIZYug4paNMu2tGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcKRjgOJ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730718033; x=1762254033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hGdj7zn2TP+HgLrf966bJxFrKB5+88tyi6BR8E+oq08=;
  b=JcKRjgOJDSEpxEMU/SnlQtaSzYr6nobfCXMtUu9JAIUUlKjikUEiXLhx
   kz4LdYpa8cMGuJB9Recp6RseDqqN+VYk2vdHVHC2NXCophbpTDn7RzEj4
   rARFhIkPbhQsFVOIANNXtLQsmyYdX0G0H5MrwL7fWtVmsGFtO/lnjrYds
   j62nhf8n3uR1rHVHybKO1dXcVQC0XLbeda8iZjaKD4o7ZfAF8K69qtTWq
   ZBIu0E9cCcjBL/QIwdCLdcbX0NFtIhChUvAiFnLTfvZhOAnyRzQjBMdHk
   KiJ1BpuyTi5/BSmP0ljCnDmdtbxele7T/OpQdP1yx7idfYeZ3sSaFK9rW
   A==;
X-CSE-ConnectionGUID: kD3YAFheR46S/KEW5RBAQw==
X-CSE-MsgGUID: CSNpyH8FSEa3MNDymo5REA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30585464"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30585464"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:00:32 -0800
X-CSE-ConnectionGUID: AOLPZuoFTGiRq+XW+wUNYA==
X-CSE-MsgGUID: VTIwB6X0QJehBYrvN6D5Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114406300"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 03:00:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 03:00:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 03:00:31 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 03:00:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVwLuGCZ/ECAWuotixD47oXdCpAtw3LjzJbKLCKGgMg7aUC1J0HEVYV0Wdv44MbceCGleUDK6NzLwnsfjzuHHAkWWlBB8d2XhC04lujyOOVyfWbXsGPbVBpsdG0PC26Oc1cOLeGnI9BWTOzdTHAgHnxYVHYYCbXXUkbb+vgOklbhlTuAvO5V2/KcmC2vdNGDOxy8pRqmu8LYjHHizNCbc3opk5R1A1brcLwSHgqEhHIUvgxzgZ/A7UpUYQVUj2LvOGG1u63dzU1a1IJUifcW4qXFNtMh+mZwAnDVci9wMNWl5DunfrZt3k1dkPxP48ZWgZj3hVMhCN77YEmAV9CDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGdj7zn2TP+HgLrf966bJxFrKB5+88tyi6BR8E+oq08=;
 b=v70DIb4hLBlwPnPXx0kPnSfmycMC5+Bba75rQa/2ueNKPSbKVEuC6xG8qUufFmPz1Vfi0Bly80+YiWjZDO9MnvhOjRKnYUhT6Plw6YUIqDInYePfC0TC6soGrem2LsBfBApU6VsFeB8TRao8jXymBfqQJKulsZSRFBOPZU7B5UZP5nRIhC0l6Pjlycs1Awv75y2K8wP89Ew7XqkcaLXPhM3BmXZ42Ke3v+azTN+D+9HlxZXEs7WNf1D4lvTb97enhSt0GDoH5+xCXRfVhVMmy0PWu+1sQjcPePPQ+e4Qzxsu57qNFqh47bsgVHamIY5l1jtwoVY7KIr12IvMtOGMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 11:00:29 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 11:00:28 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>,
	"Zaki, Ahmed" <ahmed.zaki@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v12 06/14] iavf: add initial
 framework for registering PTP clock
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v12 06/14] iavf: add initial
 framework for registering PTP clock
Thread-Index: AQHbJEUStSP+nCAjMEKQvyTqFWTTa7KnCNmQ
Date: Mon, 4 Nov 2024 11:00:28 +0000
Message-ID: <SJ0PR11MB58654C9766759707F71DC9F78F512@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
 <20241022114121.61284-7-mateusz.polchlopek@intel.com>
In-Reply-To: <20241022114121.61284-7-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|CY8PR11MB7082:EE_
x-ms-office365-filtering-correlation-id: 1f1ddc82-56f9-4c93-657a-08dcfcbfe4b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Eatf8Doc04bedfEDiWx5+GsXcopO5iQKqXqSH9Hki7RabvJofTvyKjMe9mQS?=
 =?us-ascii?Q?Xr3y2dAJkKxg07xeeMJNGC65rYlKDWmO7htwdR+yqt8aAO9lpLwoqp6aotPX?=
 =?us-ascii?Q?OXxDRPAzLdZWfe23aoRuOl7d1qweVImsGHTtA16tcy0KUlGLdjJku9U4LJ4H?=
 =?us-ascii?Q?s1WBsnR4QIMyQJf1bhcszT2iQHhJQFL9+Jinr/cJeA3IkPlk86QWLP+HpHDf?=
 =?us-ascii?Q?qmpjfWsWHfSeSCbyDLP0+74AoA+CZhMl1FFcz0fPlVvsx4MIfzNkBvalff3j?=
 =?us-ascii?Q?0c/odzLn3XsyKmxlu1cTFmPXqAiXvQQOepWoliyUAyHXqIhKFbZCZ9ENf+oZ?=
 =?us-ascii?Q?qZBOBZjv+jB0x0ACOLhasFAg24IxvzSpS8UAOdmVqtPrvt6cNVRblbr9a267?=
 =?us-ascii?Q?khGKJc0fTQXPdsdinyswqEQps25XPNb6IZjq1cNxb1QDP2wBYZmTM/TlvrtO?=
 =?us-ascii?Q?jOZ6+zhHH6VFykRbYyrCXQan0DBdNBbY0WDA0pM1QlxQT0gan6awVi0jmEOX?=
 =?us-ascii?Q?f5iit3HzTaA2Gf5h85UVxqmCM3yP8ezKxI84DMLMmGht+xX6j0O6Hftl4Zgm?=
 =?us-ascii?Q?dtiIpYTj1GLbjgC2OBh5rIfAGxOeMiUhTEsbCNUlTXgz09lRadl+IRfzIcAO?=
 =?us-ascii?Q?BJMgaeL5d2ZbQVQ609pPm8VRWgA0RZfB+OI7umfxkDkr94HUH7aylXstMvb0?=
 =?us-ascii?Q?vxhhq56J/LfIrvOBk0/PwCxmhPLyVqy/8X9uKRzJ41KSQ7TkLgljTkHF/30s?=
 =?us-ascii?Q?16Jfhfb9DdD23EJWy+r9INEz/DwGhY8SYJ15mGtisa918PoZXvUYzyITwIho?=
 =?us-ascii?Q?IFSymz7yYntLUCpkppKT6jn9SAnUmdiWXIZKFqC3/wEslfgTKzB2SgWSSABf?=
 =?us-ascii?Q?7ajFy9KaMSGz0VaeMLmwuk5XxE9605uGcx7vkUMPGhPzkkkV/GkoUXef3oOr?=
 =?us-ascii?Q?00WgJ+yyMa/+ffaIp+0/AsxET6/T1u3EMzxv1FcDZneYJLSF04LShYL9L75+?=
 =?us-ascii?Q?m1jkt0Uk6FfzyrgMt7sRgvtzR7vaPNGOeGsV/QQVBj2zeNIB4di16k4TKeQz?=
 =?us-ascii?Q?30c4ZFx4qD9DA6L06wnllvei/pbbr4t+0HlXW/btnULNJmeEHT1o1iCk/kl6?=
 =?us-ascii?Q?pqkGQcDMzXQVpsX+Odbno+opXwwZH9X93cpOEiWR8ZlEKAWS2KgvaZucLP18?=
 =?us-ascii?Q?pJDBn8d/hna0HsNLAgceuD1Z0T4uIwDAdNBGx3njvXjHl5V/FN2R2/UKaJLW?=
 =?us-ascii?Q?fbKG/gPibSBqB99o1DpqBA0jNgNWqKRXuhDASZz7Gu/4sezO0mXFfO1Kso++?=
 =?us-ascii?Q?ppTGPGLhBdaGX+43lhxYUEKFhhBpVOaIQ7bzV5h/UoGPGdubxSuDGLcQUJnj?=
 =?us-ascii?Q?INMi4YQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yHeTcaN6hK+brfgo9ynDPFCyNMEpIx7Nl6A3Zr8G8b5Y5Sepnb64nK42Dkee?=
 =?us-ascii?Q?inKvBBiiVfrgZVe6rpv+K8/nA4EFUWl5BPs/HGEFM4JSTyy6J90h7TDi95PW?=
 =?us-ascii?Q?5n4EIcuMzpHXI/4sBnqB03KgUrBsnYlI1NTfzTqIGcSdlOOdB5oyoZ45j98T?=
 =?us-ascii?Q?NKsx/kV8kHaPcligdOTbjncr0vM2YRh2J9Z0W/gHxQbsCGQNdCuX7QJwM3NW?=
 =?us-ascii?Q?r1R8iqMZE5NzjU2vYdo+wSMA/Tmi5RobFVn8bIcxDwSsy4vbvF82QKdw07Et?=
 =?us-ascii?Q?y7safMRnesWRAzapVeponz8gpWe2lEwsBi5ua1CF30ZzHpQLLbL4Jy1tGlm+?=
 =?us-ascii?Q?spCj0EKn8bCe1heb1FiLTIy6kKl9BwTmX8t7yjrT+maamk1IrOV3Dh2j1C70?=
 =?us-ascii?Q?iFzoMu0wsFsNUnyUbE6i3E8mFj1aPhLdLKmWPz7bvykehJi7LY8nHvzw0OBz?=
 =?us-ascii?Q?icqpWJhkif2cyGEs38K2JSSVpxZgnpSSQMR0bVx4sV8LscJootzNBHnFHugs?=
 =?us-ascii?Q?+u1FzMMsV1a4+MHWXj1p467E7PZ+FAzzdw/Rqfb7WtcNLei8mrr8iDjFX+Fj?=
 =?us-ascii?Q?XCbz6f+49j8/j0AkcrnEX7dyp6voNL2epS44rinEnXAlqTXoVnWFKZHaEmNF?=
 =?us-ascii?Q?U1t4cst8k/xgd1NogiA/6bdFPu7WraZQV6b9jpcti5Njw6KSt3oZayvRZyjy?=
 =?us-ascii?Q?uWHxVLObTVJFkMuXBsMAZPr+sVRUd9xdzfG2N4brOwAG/nfdmdDZ6miEFgyD?=
 =?us-ascii?Q?cVFY7ioi9nfYlu0T29J4p3QOLq4iL3bkzRWGJiON9XhVcDF/JOQirJgCK9Jo?=
 =?us-ascii?Q?9epds5LEjlNdvAAJbaF4klXizxh0sMXV+qBTpl6Dh7ZWkYXYY7YNtkx7JsXR?=
 =?us-ascii?Q?VBB7syEf0H9XJxCwSUYEBWefp0mK6+h5m+2ypwWFl8dqqCsMqhSONXIQcU1U?=
 =?us-ascii?Q?TiIoqq1tu8lEHV5Bz0zViS60U2Kd+F3UEi6m/XuJFR7rE62AoDb/SLcF8++4?=
 =?us-ascii?Q?J9SYJGJbvHAen89aqJ9zCUHeHk3E1aZl0xaOVEnKrVt/GQlDxjRA28LV1CHw?=
 =?us-ascii?Q?16GAAiqc6put0o2vcxaFDs5p0uPgIf8MzNermLOFHRzH5HhvuPCw6IHYrAmA?=
 =?us-ascii?Q?EgcNlZ2h5lw8Le2U7WDWIkbJlnpAxU3xQ/WJSDftkCy9bM0KHmY5VeIVH2Me?=
 =?us-ascii?Q?5KQ79PLdLoUqETy2eVSVHRNM8bQe273HR9jG7Mzda3Yw6xzQalHMbmZQDD5u?=
 =?us-ascii?Q?TypkjlPI6jmJoRBunb03OUAQOPeUeVdCPFPv+v7MKsLjmdCLCH2CBJJD/12q?=
 =?us-ascii?Q?3O6PkVzVd5GVMjnYjMMyRosBC89xQkhxhMl6JntEBVmLWeC+jxjeaM83jNAe?=
 =?us-ascii?Q?jqPdXUpY/XkjbGKsHBE+2EnlaZ4r0UtLJossXKp0K4HzT3NNUekFGYt4uuxA?=
 =?us-ascii?Q?bLKb1yp8hE9Bkr7sPTud/utXHkUzalDWHxuKviM6Z9PuEZnPWNrH5cgCnR2b?=
 =?us-ascii?Q?sugfIJMoEaXhtoPy2IEZAGV+wHXgTZLHs3dGKT03/h0aMEPcJzOFqc5TEWaN?=
 =?us-ascii?Q?p/JksCwF6enXHQcdkcosNXFuiT58nNFrwD2iwWXeDkGG8YEQhrojWoKqVVbp?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1ddc82-56f9-4c93-657a-08dcfcbfe4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 11:00:28.5280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLVsEr+DsDdqVBmpA6dvrJEO7FSOnZGUysFTdpljDBmsVz4wqQKIy/nRqDcPapiTFZm912t6ff/xl5IRmTFfXS4CR9rwxyUv16V1Hy6eibY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Polchlopek
> Sent: Tuesday, October 22, 2024 1:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>; D=
rewek,
> Wojciech <wojciech.drewek@intel.com>; Sai Krishna
> <saikrishnag@marvell.com>; Simon Horman <horms@kernel.org>; Zaki, Ahmed
> <ahmed.zaki@intel.com>; Polchlopek, Mateusz <mateusz.polchlopek@intel.com=
>
> Subject: [Intel-wired-lan] [PATCH iwl-next v12 06/14] iavf: add initial f=
ramework
> for registering PTP clock
>=20
> From: Jacob Keller <jacob.e.keller@intel.com>
>=20
> Add the iavf_ptp.c file and fill it in with a skeleton framework to allow=
 registering
> the PTP clock device.
> Add implementation of helper functions to check if a PTP capability is su=
pported
> and handle change in PTP capabilities.
> Enabling virtual clock would be possible, though it would probably perfor=
m poorly
> due to the lack of direct time access.
>=20
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



