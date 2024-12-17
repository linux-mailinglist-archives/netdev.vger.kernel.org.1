Return-Path: <netdev+bounces-152663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A539F51AB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643B8188B593
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F237D1F757B;
	Tue, 17 Dec 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGCC7b8i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABA1F6671;
	Tue, 17 Dec 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455225; cv=fail; b=r82tQfMyM2+L3Q1s4Xulcuk9sL7ZR6TtpkNiu1MIy3SIZ7xFOHZDYZKi0SGHt0n2MSL2c5jpq69LyYqlUmaDiD9aawleFBLZ3s2l/b30rhcW0IqKy8bS8iNj/WeuozF9CQoNJdbtq6ZRGZ1e94+fcUcAjoMI8iyeqqAl6Zf3+bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455225; c=relaxed/simple;
	bh=Dq4Szq1qaA4cjCZaNB3bqVvHKl+JpeDg8WslQZl7yzI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDjbMOpRFvp1g75q2oTBfbcEBy/gBjOOL/MDpFqswQGxok2iaS+Vft9JNNEhhNBAgAOea9iQY0kv0be9OtSy1Gv9g5FZh5RAMcGXrF6BmfdTU5n7Aj3oGjlgxHRv+G4deQc8pI5JVY5R52rHzWZNpBFIYQlGohoA3rdlq08vwJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGCC7b8i; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734455224; x=1765991224;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dq4Szq1qaA4cjCZaNB3bqVvHKl+JpeDg8WslQZl7yzI=;
  b=nGCC7b8icPlYlzbpLdAn0vUoZDR7W0nrUUPA+JBtyC5BxVTzD3Gg9/sC
   s17Pb5nMG3sPOpuaJSYp6dWUkxkRaZGDzC/kb2gczLc5qzNSNVT0cy8Pl
   NgUYhFi/9hS1pGnnmoclQJmSBmhT/LW5Z8U161STTY0stRAfwcz9LtHWu
   YVhanvqPyMqkQCLcSm4Q6Up+YqaFDTXVY5kbeXl2b0RP0S7Ak72xLvyL/
   DbQKCioPiWuOV3GQQbY4aXy3HXsSumP6U8cjSmdeYekBChMEudcr1CJwU
   fvhp0w79HxpsM6TdnPvv/hDrTbumKaJ/IgaPUle/wtr2+71x0k/bOXcTi
   Q==;
X-CSE-ConnectionGUID: U9ci0JewQWioVBC5lYWyPw==
X-CSE-MsgGUID: 3QaCePTIRCK/b64AmhTalg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45378744"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45378744"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 09:07:03 -0800
X-CSE-ConnectionGUID: WesZYSq0RsyQDaAb86Xy3g==
X-CSE-MsgGUID: Ub81EvjzTcGTrq3jKVR2+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134931324"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 09:07:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 09:07:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 09:07:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 09:07:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3PlhblllvN+H4wZIIxVki4oHkthEyz0Job0WJzJmQpEkPwCuT9FiRbVUWemad1ScCyBh2WnhY5VA9RavJJCdO6lGa/jEOM3dsAZvwoQXyFb8Ds0pXHbb4E0rpH0CSYw9yUzRNm9UV04srFm6n7OzAtSIbQtdoGkM8gq4+J0YjzUf4N6c044CV8LcjlMnnaevYfJzYY0LlrLbtvfrOk6lPkr/hnpUuolUuD/SOa8zaScg+P07JYxH/0kwjxzxZ3LK4D0nSArQ30ffG7VAG7cEnZSUvuTw8x8z/gHFOnS68aNvVFB7Cb1/qSylkoYJ/ubgUqk8EkxepVtV/XliiA2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHTyfwbomxtffWQg621qaMxZ+fM5HOmx0WQRVBOuNRo=;
 b=fU62eRYwgf/aN3FqwYwn2GUS46T6UgL82sVdbDoIqqrsLGE9bCReRJj/Gx2H2AtmoNVaQGsx11bJFRwuKNRq11YELTWzS9+mnOI0LbC1Ig+6xO3vkm9nYf0LMR9jNvDZHxbvUPAah2p//d5W5iY9Ht+4hlChPh9fB70Ay5JEym8WPEEP9lwWC7fFkUQ/4DBPr960CldH+D/7zcG6ZV/hTby7OCsxmjDo4Unj4hrPOXJP8pUyjU69f32rEXRG2+IG9qYqgjusxM8Sy6av4k1DIIr1G0J/L9panG/MXKQwB2WbwqMlAoUdYyNDWQljOELXA/Nk6GwZi2vYJ+VAS9Rlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW5PR11MB5857.namprd11.prod.outlook.com (2603:10b6:303:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 17:06:59 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 17:06:59 +0000
Date: Tue, 17 Dec 2024 18:06:47 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar
	<vimleshk@marvell.com>, "thaller@redhat.com" <thaller@redhat.com>,
	"wizhao@redhat.com" <wizhao@redhat.com>, "kheib@redhat.com"
	<kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Ayarekar <aayarekar@marvell.com>, "Satananda
 Burla" <sburla@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Message-ID: <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW5PR11MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ebf608-5760-4a5c-1065-08dd1ebd37b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0k0pGBKB/mTo8YWejLnqB7uQyQdg2kxiYb93PMCjPkqeyamHXx/U8SZCNJsc?=
 =?us-ascii?Q?H1i2niOC5e/qn/ikwqSQKjKMwjNioZpz8J2x+SJUOSs/v/5PTK9SyIwTgVzQ?=
 =?us-ascii?Q?/ZmIpMZpUVJne76/cEd3kaOse3tkOZoq8kv7gIUQN0Ta1OmPmnu0hLtRHZiC?=
 =?us-ascii?Q?6Qv3/MtexydTN5oscci12+pDyXN/+xYj+QOahSHD/O2DC1qrfGhkxQKm3A/Q?=
 =?us-ascii?Q?BVrvjfMOFBvp01xmYdxv9dIWqMvaNwM+4yrATZdWfJKs94W0jeXudrG1Dirs?=
 =?us-ascii?Q?oUQeVs2ErbVKZWgEGksiVU0oIqJ9KHqe1W4VvcTGWW3OWVuRHh9xE7XFkvUk?=
 =?us-ascii?Q?OiZql+FHYcEciuN7v1HOsfc8TDIZiq5Pjm6sCMT2pTAjxV6PwWcVeu7dfhus?=
 =?us-ascii?Q?8pfO6J8rxV23dXiukcj2GZnv9wRc/mLtRsFnkkvKA6Idb0XSSvXg6tCLuHSP?=
 =?us-ascii?Q?9y/7pIsfnl9zfFHqfn8HidAVkIqBM0Vk/BcifNgQE340KukSanyOGly4LReW?=
 =?us-ascii?Q?ygFHLA/Onb6z0IMhWI3RYN7iLEgJ5mV6QsERj0RFKkU++FzusR4/bF9HJJo1?=
 =?us-ascii?Q?N1MBtiEIhC1Rv2fNASGS3kXTyTumfGQa5oULJlTox68YQHnBqwGvecCROnrg?=
 =?us-ascii?Q?Lr2vFkXcpN2IQK2DH5TtJPxQ1ONjisDfdRy9FOgDz1tWU8fLWFi9SXXJQ3qj?=
 =?us-ascii?Q?h+jE4rT67MI4+UWMdveSNmgxyIAb8/wQDpGSfh7Gicm4nVOeklq+39U7uiNi?=
 =?us-ascii?Q?1I383N85sH73V1Byp+Jny6lTypCP1K62ZD3hbM0h9+rb/clx8U0n7KFYP4l4?=
 =?us-ascii?Q?uzrh02ZUqRZ/mh/d/X/V374mOBhTVw9Hy8FT6FrLnabx7w+havSbd5FBxEkM?=
 =?us-ascii?Q?Bz7rkLr4RBxJZ2mOyG3NQ/uhRpa1QYi3HCnLsjMVzjtrmGQwRcP64udYtVNx?=
 =?us-ascii?Q?YUOv8To2sK/zZwnvOVuP+Bn8cLmPq3vV6C6baFKA4Ed5MKw0hByi8dyi55Uf?=
 =?us-ascii?Q?2/NiEcMtX4JoBO7aiCjc6fYRkXois34ArBGnU6H9FpPg3bu/4OkVrXznHqyi?=
 =?us-ascii?Q?D/LfdygkXD9HYgepKq9a18rGFQ7VIIarhi/G5MsuPAZyIqmZUNEhf2UXG2XC?=
 =?us-ascii?Q?rFfCvuq8s+lid/6NNVxhhmtrzPHb27OYzosTPY76F3JJM70bJ8qi1DZTmAaq?=
 =?us-ascii?Q?P821+IkgySPJpeGqazgekAB2GRvgVWuad3S9/HrLEmOykrysvultFXKTb7iZ?=
 =?us-ascii?Q?anfu+4YRZ7egPTym2mnjbp3JvvjnMsYrSMUtEcqZ+ulKm7tm5StSYiHAkFJY?=
 =?us-ascii?Q?PsihUl2X2YBVow/IPk2ZuhqD3Z3E3GS7vLNUXvStxddXFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Beg8tR08Lq5vlhWKiSS6mhAkt1m1ipR0zTWx+jMvjsAU6jHZgKuKqwxU2WiX?=
 =?us-ascii?Q?089/HGYQIS/B2M+e2C2sUlIkUOj94tTdGH2jrd1kLHiDBArU4MwAZPsb2PBC?=
 =?us-ascii?Q?WZqNaNaJ0iyskLnV34IcfLLyl8n2TryfAuPa5axohZNe2rtA9DfMJ81FBthK?=
 =?us-ascii?Q?7BKxKN87PkSgREbq9l+eCte3vZXOH87YByfodBbWzDBKEyKS8+m7PeMz5DPY?=
 =?us-ascii?Q?wHm63DPIxDROcX1Bg1LsMWTAa7n15whIap28BnZBStXzEGvo7S9ImmtjuMSn?=
 =?us-ascii?Q?JCBzGgJ5BIXfgYjW+GhFaQTK84A2uIyQmMDceBkNgysBxruM1y51Wa80KUno?=
 =?us-ascii?Q?aK1qAyHzuPrv2fo88o7RGgxt5/Jbt629Y+b4r6ownKSeaevTTharYObCqQDM?=
 =?us-ascii?Q?pwFmIKNIaTTEE1Ho00SrUWt/hViN1pedJgxBQp5+kuNeW2SzdGmRW9IhI+vS?=
 =?us-ascii?Q?OpAZHF6NR6jGiObVIy7u9HSnNUFJ02omj5mDr0tqC8RL3T8NW3xPCRnd5+G5?=
 =?us-ascii?Q?3auuizWMBD04rXgv7PWKsAdyxbbp8h6cpEWADjXJ9doogGFd2+EuHmFMCQLp?=
 =?us-ascii?Q?15pD05V//2i0bz1iPjeQTHVH4Xjl36Z3ZBcGrAa6tC6u5x9zL3ELT+ndKbAf?=
 =?us-ascii?Q?Db+bU0Jz8CFo+EmES8g0YC1C5I4Pm3hmFoasg1rWapRzb2NWPpdBehi1Hs/1?=
 =?us-ascii?Q?18J2MPKHvGd8bnpPIsrN8xRAfE0XbcYctlvwCfv+71NsBn6QX4+WSr3BQG6/?=
 =?us-ascii?Q?U2eFcLoYx/yYgxf1X62y/vgNit5+ulgkwk/udEU1TNFOtKaLZ4pAND+KMsVG?=
 =?us-ascii?Q?1/Spw7Kl0yd5BfA0EfsRsgH5shLNOaf5Uop+Vtu0wBtGQ1EKgCxhJDSkJ+Pl?=
 =?us-ascii?Q?jQ5p7KQQC9vQIO5kZZrXgiPAEUM97YKcgxYXlkz6MnqX59P8UTWDr2oa2mbB?=
 =?us-ascii?Q?d5sPueTcApoKIyp93cTf8K3oGsOpDavvU4Tcuq1K5ZGq3I0lZBer1XftsWKr?=
 =?us-ascii?Q?m9Jj5XatzAsRcsbIIPDGf8qR9j6qwA+jTuJ5idkNzelmyYjL8R+1CRILWUnh?=
 =?us-ascii?Q?7ZcUkXhs4MztgPWtx9fEGGjElhhwWDcT58wfUOGX7OBGXYX906z8EIofNlJw?=
 =?us-ascii?Q?GyI2t/apSaz3aL4C1LUR4MZNIQ2vWjPrYyrN8kUDeMXA2hc97ZcfitUujPBP?=
 =?us-ascii?Q?LuLTckPChTxqs5fEmvHgM4Tm9DmMDh19hSB0aRtzf03GFIc66NchsHFlGTc+?=
 =?us-ascii?Q?xbJ5emrNpCQPSceeB++Q4UbXQiQHNKoRPUM0gPFtAxKJo4snvG3hGccxe7TV?=
 =?us-ascii?Q?l1P7VTAwyLV4fCFYOranZqkJyfWnenYWsvrRrunK81ohL8BQ+2mXdLhWctpU?=
 =?us-ascii?Q?XysHsEIvJzzGroTJVJEvnunTJuHYTtTnK23nuzT9gotH582VcryC01BNFxy+?=
 =?us-ascii?Q?LnMrZ2BSlKNWngEAITGfAVMZAipNqes4XO+Xen2HA2kU5WZyZFK329RxvLtE?=
 =?us-ascii?Q?S8TUnSdu7zKQu9x492YzukaxTZyWu0A6qMfp1dZlFHYqlwmeqmMvQu5KJTBJ?=
 =?us-ascii?Q?IEFsJtDXT3fdU3OIB/HRTKevgYZeI7OMWzfClISENGVJdEJBwa0UfqjrqAAT?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ebf608-5760-4a5c-1065-08dd1ebd37b0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 17:06:59.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0te/WTanMwoIg9qx/WtFAy/FKEIRkA+NUKTXGjYKAG7rbqBfSFxcOoxfIoo9zsfywdFGzFFqZSszf2G5bmrvozyowBumaIFKNRXJbW/AXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5857
X-OriginatorOrg: intel.com

On Mon, Dec 16, 2024 at 06:28:13PM +0000, Shinas Rasheed wrote:
> Hi Larysa,
> 
> > On Mon, Dec 16, 2024 at 03:30:12PM +0100, Larysa Zaremba wrote:
> > > On Sun, Dec 15, 2024 at 11:58:39PM -0800, Shinas Rasheed wrote:
> > > > ndo_get_stats64() can race with ndo_stop(), which frees input and
> > > > output queue resources. Call synchronize_net() to avoid such races.
> > > >
> > > > Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> > > > Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> > > > ---
> > > > V2:
> > > >   - Changed sync mechanism to fix race conditions from using an atomic
> > > >     set_bit ops to a much simpler synchronize_net()
> > > >
> > > > V1: https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__lore.kernel.org_all_20241203072130.2316913-2D2-2Dsrasheed-
> > 40marvell.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=1OxLD4y-
> > oxrlgQ1rjXgWtmLz1pnaDjD96sDq-cKUwK4&m=Dh7BH5wsuCdQnE-
> > 4erjptaJnM42YsLU2tY4wPn5NWqwsymkNOllPfQAkomj1mXPN&s=IjWHk3SOqr
> > ibgv6kz-WTL8VfGVInSu5DzKSbcjCFIvk&e=
> > > >
> > > >  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > > > index 549436efc204..941bbaaa67b5 100644
> > > > --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > > > +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > > > @@ -757,6 +757,7 @@ static int octep_stop(struct net_device *netdev)
> > > >  {
> > > >  	struct octep_device *oct = netdev_priv(netdev);
> > > >
> > > > +	synchronize_net();
> > >
> > > You should have elaborated on the fact that this synchronize_net() is for
> > > __LINK_STATE_START flag in the commit message, this is not obvious. Also,
> > is
> > > octep_get_stats64() called from RCU-safe context?
> > >
> > 
> > Now I see that in case !netif_running(), you do not bail out of
> > octep_get_stats64() fully (or at all after the second patch). So, could you
> > explain, how are you utilizing RCU here?
> > 
> 
> The understanding is that octep_get_stats64() (.ndo_get_stats64() in turn) is called from RCU safe contexts, and
> that the netdev op is never called after the ndo_stop().

As I now see, in net/core/net-sysfs.c, yes there is an rcu read lock around the 
thing, but there are a lot more callers and for example veth_get_stats64() 
explicitly calls rcu_read_lock().

Also, even with RCU-protected section, I am not sure prevents the 
octep_get_stats64() to be called after synchronize_net() finishes. Again, the 
callers seem too diverse to definitely say that we can rely on built-in flags 
for this to not happen :/

> 
> Thanks for the comments

