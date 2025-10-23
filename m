Return-Path: <netdev+bounces-231921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B437BBFEA87
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 02:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4167F3A28CF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0629A2;
	Thu, 23 Oct 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKCtYW2H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB81FDA
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177834; cv=fail; b=dwm+gXd/awlFOeOoP0aMxo+ZN1htQfGsmqvwQxmp4GfC0mB0R9B7gYeOWgPxNoQ+5/0nWGej0FNekZKNu45ayti5ITALpradnw4WSGN8kfqJeBDeeC++aBy/PW5c4M6uCG+zkp2nLSPHgyJffRBNDikzEHZ/K9PhLzloHYwZLhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177834; c=relaxed/simple;
	bh=x97QZUmnsp5d0k1hOev8v02t9zs9v7hpByYylXzQCNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s8Ls/8YMRT/vJbZWWSb3K708vSaeu5fAM4AfWa5ap4OhWqWb96bs7U539PouQvBImraRH2PwYwwjsiseukwoYQesFMmao0WxrmDaEEGRGGXFA/ltsLhoWYkB/yK6ceZl3AbJJy7NbAfBGQ2DqpkE90ygTihhHfENgUjWDttMLeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKCtYW2H; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761177833; x=1792713833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x97QZUmnsp5d0k1hOev8v02t9zs9v7hpByYylXzQCNM=;
  b=fKCtYW2H8Yh5zoQC4DBI24Q3diWXM2wUFp62czlcF1mLGdTd1DpgAM0+
   IuEwMeoeahjr7QBSSMfbb2O+2AHcP7tFhyjLVa8tI/GHkZ5RvblxM972H
   vfheLX6G1nmZGSkEjbaj2gIiXywsVLJcA/DXGHczZcWmr8VKlBkXTUMy8
   GxilFyfT6JOyi7EooW3tRk45ehqqX44VVRC/Yx+OQsyUJioitWLVb6AxP
   LLXpUKNkXASxksftLPdO9zQITV7BXE8V4wY51zL4yimlbxC0Mnui1b/A5
   RAhwSGKundUYHmW7o2tbnjoL0MXylQ4/VuHVhLYuhbIHzTSaMhx4Pv/81
   Q==;
X-CSE-ConnectionGUID: GqnMgVSXSrixaaqVW1B75Q==
X-CSE-MsgGUID: N0/SpaAmTNSZgOELhym9/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63485970"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63485970"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 17:03:52 -0700
X-CSE-ConnectionGUID: 6kqFepsAQ46/YqyPg9BBaQ==
X-CSE-MsgGUID: MBru8zxVR6+mcjC07q+o/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="184490826"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 17:03:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 17:03:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 17:03:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 17:03:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUjwn5+XiBsK0X6l+WhJQpBZUFaCsUJzfZCLXoT5IJhhOKj6mVOeEvtY5ESKwdJaptbF9Q4GlQ+wPlqPtvQy9v1M4L7gbZe24UVxWM2QHW5HizuJq7yAO7O2xCD7UJJg5MPJsVbGBgVKLdiOUumONNWke2TcAZx4hrPIFr/L5DdTNcryuEQqH+P3uIt0EbvG0SdoXnPYRawPcJi/u6naPiS11qysrakdkQyEdWnFkpVHQd3voD0MMXNom29eev6yi3jT4rWD/iGsrfbJz7A8vKDkdC2KNMX80uDIqyBjEVppC4LAXP5UQKPIsmOwDHvHwX5Ds12urNFzK7rSzAOCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3XGGK9hKNyvlHj6kJoTcUsoNiT/5SFXpstnECT4C48=;
 b=rQw90OFwjchU9eUbTEU9joYUAdFqtBTuzso1rpd69rGD4hhnz1XC7eDfX/SfA/hIbe1zVoAw5F6n+nx5b7naJroUBpLsOnrK6Mnb7fBEBB3PTOj2pWjzw9Dr+DMSRCvHbaiiNXZr/SZH6AVvbOEPn8lm4Bo6wn5E6tmEq7qDiFSK93uqac/+rDuhywZw6zVILINSAZc1UO1kfMa2rQ5dpFfMwQBt7Bs+qnqEC47toQuO18ZbTjKP3LNmZbjXE+0WwaAINykZXSh4hauNnT6tGwOSPFIlQ45gUDQ+jTgAE2y7wr93eow8HgLluL/r6UfaO/c7o6t1Yh2Ua4XCLdPOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH7PR11MB8528.namprd11.prod.outlook.com (2603:10b6:510:2fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 00:03:48 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::241d:ef75:baf6:dfe9]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::241d:ef75:baf6:dfe9%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 00:03:48 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Michal Kubiak <michal.kubiak@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ice: switch to Page
 Pool
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ice: switch to Page
 Pool
Thread-Index: AQHcLf8g823ekE8rokmU452A4pEzY7TPBKlA
Date: Thu, 23 Oct 2025 00:03:48 +0000
Message-ID: <LV1PR11MB8790CF4805E7531B3FFB4FA990F0A@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20250925092253.1306476-1-michal.kubiak@intel.com>
 <20250925092253.1306476-4-michal.kubiak@intel.com>
In-Reply-To: <20250925092253.1306476-4-michal.kubiak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH7PR11MB8528:EE_
x-ms-office365-filtering-correlation-id: 5dc549ee-c9ce-449e-662f-08de11c7a44f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?OWIb40GKyIt0cgieu39LootYNhrj+pynFsw+hIZDjt1i2z8/mVt/w3If8Pvq?=
 =?us-ascii?Q?0Cj7/sstRNQiiVNHlD0FSlkv8kP3g1wwQ9KyvZEGlXHhnl9QWn3HJz35mxPu?=
 =?us-ascii?Q?/WcHr+NtlZfT/LH+fxdwtMgJjH3QCgb6U03YPOYQz1HkqabWTcUqPzG3GVd6?=
 =?us-ascii?Q?q+Cyo73yYpzxt86MrAcJQxd6E3Rb81ks7baAu926wb41zXFrPRUQNbLIqYQZ?=
 =?us-ascii?Q?5OrwwrqJh2341Wb2WtJUWYKFgXyRTn4eS5/lr57rtaG+zzQ+RApupb+iwxC4?=
 =?us-ascii?Q?t5+gvUK0Vt5K7LJVtRmk5eTlnzOEYlHcnX2617CTyJUcoQJMDQsKENjewFjF?=
 =?us-ascii?Q?oY1idGeOoUZPhwyqRr6aLtQtnfhDaLWpfxDW2B1kKvX2elXBz68pKjItEqUz?=
 =?us-ascii?Q?HHtunMhF8HyM8oq6m/63AuoKV4Xn0R/uY067PtfNdQzu+s37QmdqOK1RR37L?=
 =?us-ascii?Q?G6BjKW9a+sYVS5UwHFW/lkXHKnGQFnkHtclh4rZKKyj9KBDJo2p3TibCsZt+?=
 =?us-ascii?Q?KcFlHVcjmW6RvEn9s8WghoA90+t87+MsqVRhskNEpTAqa8T9DuXtahwRx/X8?=
 =?us-ascii?Q?dREuaPIiFyxs/7oss2wcWCLmz2j+shcFBOPbwuvxSNEJZf5L3WugVg9/qiIE?=
 =?us-ascii?Q?JQwTv/GXb7Ud5nSMr3zpjW7U1X7MuLHn0N+0QViaX6iJe0/kagj3fE9g5snK?=
 =?us-ascii?Q?F284KmEQ0zEeu6cLtoU2Qpj0s3qVNCUdzB4kv173uN54n2znWtOC4cfXKoMt?=
 =?us-ascii?Q?j5aJ4VxCBo+ym0qfE+1y541UQYPJz9anMzv8zVL5ZomBrZLIy0Qztjibe+w8?=
 =?us-ascii?Q?4yQawIsTN20AZiR3CHpI3j/2ULh6jyCmUbT4QQ6lna8jPPX/V6VcVmtDpY58?=
 =?us-ascii?Q?JjBi2co1WSI8NTQGKGJ/94Y2tD6eZ0jGOOPJGTNZXIhiFxT4AFly1QqOgeKr?=
 =?us-ascii?Q?0I4oNz4/N/CaYHHhio5Bl/5Qc//30tCylM/+3FHHGyRdOmagt1OssbZ2j+Cs?=
 =?us-ascii?Q?7xxQo6s/PEERlgMaI4vHWlzwAwfPPauXECFtJUS1JHPoseZDSsXJzPWuv204?=
 =?us-ascii?Q?Kdeo3gBhBEME3bfTgMEQzwQpgJFlNX1FawlECG9k8iQCmLD/g+Ar3tYG7SvF?=
 =?us-ascii?Q?Hn1GhJwj70uYeCFbhCthTMJKQFXjX1sqik2Fd2EZHsyX+wcx5AuXuXrzTf3R?=
 =?us-ascii?Q?Be5yWm+CVvDcFPWUs2PXYLAib8zUHdIdJmICTK3ebpDA+JTQwOToqCVSB1hO?=
 =?us-ascii?Q?cp/SCGn4lqn3E9x+uQ/6quNHw36ZxL0sggyCd8M+aMBJAv38bwegE7tiMZCy?=
 =?us-ascii?Q?qBz4QEa82P9/sgLt0hiJ1FB2xJb1N+uk6gXRVp1pMnVl76Mo/b2+Ddxf7m7n?=
 =?us-ascii?Q?gUzTbUoTV/ebs12Im+nXjPS0Aif1eMYPTUcFTniGR3YcsrBM4Rss/PVe+lrP?=
 =?us-ascii?Q?bakGxPAFsuIJI0PwSWmC5phTopmj+FwFhgVbcu5tdeX6aU20Q3wZsJeypqXo?=
 =?us-ascii?Q?KBUJ00ie1nCtpwVJKq6z71hl2nf9Dv76pDk4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/wmfxzjyo/Z0C3BMm8PrlOEavGyvRPk4wlY6KKsPArqUbaHx+7zBN3yb53BH?=
 =?us-ascii?Q?6N6NHsi1vqXMrq5pvxV5Pa0HojiN5RSP6gL5htBvKCJ1tqms/1zokP+tl5UC?=
 =?us-ascii?Q?6xirCJ/orIbuwYi0V5bBDIGzx2CX34Jl8JjsoDrnYQcPpMGTyLyS56Z8DQ1T?=
 =?us-ascii?Q?W/k2NDHCopVQfmoWMMX/rqQ+C/tCqoCf+PX5aOUGRlG1azAbKRZyV5yE1pUN?=
 =?us-ascii?Q?U9GJ/Wq0OpGoyahrIm5G8iRJCZq144IhuhIZhU1r7M/BpAPjKmITVfpEe0kd?=
 =?us-ascii?Q?s8mqIwj4QIWpOt/QhZ9wYqbRywkAB7Ic98iuNtktWKSLJ9MDqJ5Ph/kzJNVU?=
 =?us-ascii?Q?B6G3MYnpO3fhwR7aJczDNoVhYpoysYwtZ2J/4GIoUNrQqt829ksWNDSwlANK?=
 =?us-ascii?Q?E2jyeXWxoiv5f2/GMZdNLrOu4MTrME5plUWIFCENDhbCnuslOTseDo9UpIAI?=
 =?us-ascii?Q?KucwpX7dJYaCk7jz+qCKkkHXgjTdf8ly8cxK0tw5NdkXnxhlQjbMlNARNUiF?=
 =?us-ascii?Q?aOcbHMWVW70ltL91oAz967EUF1nfXwrOcAG1kAszjIDm86TMrd34Owk4TmeM?=
 =?us-ascii?Q?KsdxJZ1Aq0sEb/0WPTBpx5Y3cMI+ZdVRNb+JbchMOQDvUZu18+BFPv8FgKuY?=
 =?us-ascii?Q?/WUs0YqvkBii9/z/2tfy3ZvWGbfDbN1Gb8MKdkOPXoON3uH69ZvyawYVMlqu?=
 =?us-ascii?Q?Yv7GeXCP9oO4Dd2N3NhdjOJDYZb6ucGE9+wN02YmeLR4TFwpxBrNWbl68BcB?=
 =?us-ascii?Q?gV2QlfP5QAzLV03azr5XljjB8jCceIodeTM/yI6swaTR/z/bOuwmmPCs7yrO?=
 =?us-ascii?Q?SUb078feYvmsQ2tr9WY6gXqOghW0btQoisi7G4Ei7Mj5UL1emGGL3Yt6ZZ+B?=
 =?us-ascii?Q?TO2MzBxE3gZgMXOvAQWyR4ay4EyKZGjicP1qED3aCgk1NjaUj8wwjq7DN6d/?=
 =?us-ascii?Q?LgdgE/wRp2GSnO+LglOZtAhspgC6IMTws9pRh/AwlhSu6CNWnnlR34Lxl+Zy?=
 =?us-ascii?Q?EluU8D2RHJH6LtC0TjFLFE/kKJS5dvGkAzdR6x4Ji3d/E1h4f9kGVLOdIXUh?=
 =?us-ascii?Q?B92q0PJsqoJv6OFZsG8xFLYyV3OFBQGAxiliLKfilldfq6l6ia0KSYdP+cb/?=
 =?us-ascii?Q?qc9MlPbzk4zzYGnI4/srIqBGH0jtpFtQkUuf+v+4DDKFViVb+2+Me+K7gMx2?=
 =?us-ascii?Q?CRxZRlfsp7moE3bQOYSmR5jWS2XWoeMb93tC/mmfObog9iCZbU8oZVrqiq8m?=
 =?us-ascii?Q?HZHPMsPQDqhLmfO4W+Aj/xMt5myJA9wBDNKAwt4e3tP+xBOkdlP67gwgnfZC?=
 =?us-ascii?Q?BraS9DshKOMrugOSGEWXiTnsj53h6RB9L4MA0txsypKgahMZ+W7fOzODhAaH?=
 =?us-ascii?Q?KJcs1RVO8oIb+X3X9u45s9Ls/uJBRHByDkDwGlxjZA8NaIkUTfURbkm73a7P?=
 =?us-ascii?Q?DHZWUr0ih0QlmZ/YGZNXVwPSr5djYDCcDeRFnvCoX3M5iEZH38DXTTa9XYF1?=
 =?us-ascii?Q?tY8xUoL+QyIKtCDB+U3mSpwUAO9qrW4OoVFRY6oUU4abV7erLzmOSgnF38Jq?=
 =?us-ascii?Q?U7DT72o0b/xoHtKIGERPLJ1m/eboHy7vEdwouWOvNE2bQfBgX6gpMPzBz8Hw?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc549ee-c9ce-449e-662f-08de11c7a44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 00:03:48.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TKvIXrf/9+Y8AbNiCTCtk+YF2/8Ez9ldM5bPYnhXXKNr/Z3QVV8I90iC2XuFCZZ388A1nSL9TNsrvaAVrPixemAKZ8uVFB34GW7BgEJ8oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8528
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Kubiak
> Sent: Thursday, September 25, 2025 2:23 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Lobakin, Aleksand=
er <aleksander.lobakin@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>; Zaremba, Larysa <larysa.zaremba@intel.com>;=20
> netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>; pmenzel@molgen.mpg.de; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; K=
ubiak, Michal <michal.kubiak@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ice: switch to Page Po=
ol
>=20
> This patch completes the transition of the ice driver to use the Page Poo=
l and libeth APIs, following the same direction as commit 5fa4caff59f2
> ("iavf: switch to Page Pool"). With the legacy page splitting and recycli=
ng logic already removed, the driver is now in a clean state to adopt the m=
odern memory model.
>=20
> The Page Pool integration simplifies buffer management by offloading DMA =
mapping and recycling to the core infrastructure. This eliminates the need =
for driver-specific handling of headroom, buffer sizing, and > page order. =
The libeth helper is used for CPU-side processing, while DMA-for-device is =
handled by the Page Pool core.
>=20
> Additionally, this patch extends the conversion to cover XDP support.
> The driver now uses libeth_xdp helpers for Rx buffer processing, and opti=
mizes XDP_TX by skipping per-frame DMA mapping. Instead, all buffers are ma=
pped as bi-directional up front, leveraging Page Pool's lifecycle managemen=
t. This significantly reduces overhead in virtualized environments.
>=20
> Performance observations:
> - In typical scenarios (netperf, XDP_PASS, XDP_DROP), performance remains
>   on par with the previous implementation.
> - In XDP_TX mode:
>   * With IOMMU enabled, performance improves dramatically - over 5x
>     increase - due to reduced DMA mapping overhead and better memory reus=
e.
>   * With IOMMU disabled, performance remains comparable to the previous
>     implementation, with no significant changes observed.
> - In XDP_DROP mode:
>   * For small MTUs, (where multiple buffers can be allocated on a single
>     memory page), a performance drop of approximately 20% is observed.
>     According to 'perf top' analysis, the bottleneck is caused by atomic
>     reference counter increments in the Page Pool.
>   * For normal MTUs, (where only one buffer can be allocated within a
>     single memory page), performance remains comparable to baseline
>     levels.
>=20
> This change is also a step toward a more modular and unified XDP implemen=
tation across Intel Ethernet drivers, aligning with ongoing efforts to cons=
olidate and streamline feature support.
>=20
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/ice/ice_base.c     |  91 ++--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
>  drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 442 ++++--------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  37 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 ++-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   9 -
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  76 +--
>  drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
>  11 files changed, 203 insertions(+), 552 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

