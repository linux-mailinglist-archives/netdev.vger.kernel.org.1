Return-Path: <netdev+bounces-260129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hr/N7KLnGl8JQQAu9opvQ
	(envelope-from <netdev+bounces-260129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:17:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9835D17A938
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F69305D2B9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A365330B2F;
	Mon, 23 Feb 2026 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knsrZizI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622F330B3F;
	Mon, 23 Feb 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867006; cv=fail; b=LTpR24IcXo7G1N2CLiVa2tL+pw03UfypF4ZVNMHy1/d3RnRUrjJ4XrCTY5CfL10KxFCfwTdO9V9AwNbSkl9Zddu1Ec2nZjUx9JL4c9lx3xyQUrgd3pffqYfybpXniCl5rmyFuCmUg1xlXdDVSSfBf7cTray/PuJrgevlYf0gmCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867006; c=relaxed/simple;
	bh=mRhExLdwI8m2lHK8rYdMkOK441CeDJID6XS+gdf27VQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Td6uAjLGA+g4NwW+l7bkeC5tKmIXDRY9s+upKPy+BNj0zo6HPwscsFH8N9A8IBAnG+W/GLw6rc+e83HFw/FAZoQamoSlWuSQHd3pH8btwjX8W5JyB8ttv0C0mJlyV5l2AmD3mAxOs2eLommvX8BYggyJSgTxl7j/+SXOc7pJYvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knsrZizI; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771867005; x=1803403005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mRhExLdwI8m2lHK8rYdMkOK441CeDJID6XS+gdf27VQ=;
  b=knsrZizIOxZ++//qnmHJLk6YLlzkDEKofeUMrArMmKAjbhG+51qnCiCW
   fvIWOf8ZC4GWppK06Hau18Iet7a4UqA3vRgbkV4fnEpl/T2WqEp2kDa3J
   0Nod9HgPKlj+uzH3AA5zDv+uQVHYx9Si0be4RfV6w3qI78mkyQwLArUOL
   ZVmsyWyHYH8ZhnM4FtEGvpHx0uWgFmaf6xCKmP3ZTIRNojrIC2INd7HzA
   c1bH7qKlWgYHTEEEmPJqw/iWN6k/hZFQ1+qAjm2MNBcDIKO5aoB2B+NqT
   q2ZPaBmHUw737Ga/FVASME1bUhZFnWi6A2+UlNsQqoupgg6wXJYMcsJ5Q
   Q==;
X-CSE-ConnectionGUID: JMqxjP99SKiIMBIHqoXZUg==
X-CSE-MsgGUID: OiuAQDepRYO4bzUBcVKx2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83492151"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="83492151"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:16:44 -0800
X-CSE-ConnectionGUID: imgJGLVBQpuwbhJU+T1JbA==
X-CSE-MsgGUID: TO+YMYXlQ6O+Ce/PUR5eRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="238586851"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:16:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:16:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 09:16:43 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:16:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2UNe+cWCt/C45x3xrnTGrJtU1B+QReMCJvrouVqk7zEF3fh21xhIdYceCDSAQ/t93b239VhL0vOV+aWmzDuzC8y6nS80NbkNDDjIi+It+5rnfwCMH8kkSIkn5wl0ozd7Uk7VF+ycxw3lNklzzemDccn3lmTIfq8IGh7vrQeZ0jp8CbChOZuxftIpC1Y2Cdf4w5dVmv1zG4XtX9Y/+Nh0CTG4M1aAOKoyby09SGmIO8B3b1IYCRJkKTlYvJlNpGyVex+X8V0OnJTMVaYLA0F3xGs6Tfqao8J1x8OGh6dOJlaKeIAGwQzIpmEFGalDACdDflw/RTEQME0q0k89FFGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRhExLdwI8m2lHK8rYdMkOK441CeDJID6XS+gdf27VQ=;
 b=l50pEIDUaTfq3z8jUKsqAMKTvDPyeh9Rtd6lBxX1ODRWV5UrPJ++uI0lkWR/1G+aHSPd1XPjDd4awYGts1uInGayVtHthJJnxMLJs5zl17dWHK26DoYJmPMtb+Sp5P3otMk2+4juKC3IuW7N2Ay6imkK2EhKExGjcO1lMl758oR9aOkt88+QlUVnRidEL6bHH004E0FhagrDCs3jxc9VwKn3QMWfVod5Z6RO4WpBdCbNzSsllszgI3LBuFD8F5Fnh4J4MfZt7u4MkzgO/nHdQp7XE/Yt2s8Go1A2YTLh0inQYzPLYZvUraiSzRwZ3A9wfP4KVmG0r7gzWy511k3JoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 17:16:40 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:16:40 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 08/15] idpf: refactor idpf
 to use libie_pci APIs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 08/15] idpf: refactor idpf
 to use libie_pci APIs
Thread-Index: AQHcV8kaT8oc4yExL0u+Y9/y2jsRm7WRIEDg
Date: Mon, 23 Feb 2026 17:16:40 +0000
Message-ID: <SJ1PR11MB6297C7DBA25F1FBFACB9081F9B77A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-9-larysa.zaremba@intel.com>
In-Reply-To: <20251117134912.18566-9-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SA1PR11MB6688:EE_
x-ms-office365-filtering-correlation-id: 8bede3dd-d3f6-4e66-b7ec-08de72ff4f0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?1BNiu4PgcdCPskliBAIjgLMTQiA1T+kM8LIfS0FVdxhQRBoLB/gsgbKLrxKS?=
 =?us-ascii?Q?Bv2UH7zkY1jyrSvGaXHI0tEi5oHqjhfaIiNbqpZ5mGsSF5lABQVB2EsQ8n3M?=
 =?us-ascii?Q?V0s9gjI9gjFdB0gJK/C6o4ziI56BxOlcHbVTtczAV1Po4EFgRc+yntNISu9u?=
 =?us-ascii?Q?Bi9nJKmDc176hOIssr1lkZE1apbAGx5my+11+Opn62efp6hGn/6OaL0hsQCi?=
 =?us-ascii?Q?HX0i/Pv6gRKeUIt3XQv2fPLPw10pahnJtANjF32oVmKW8bje5AKCcDLJDRXa?=
 =?us-ascii?Q?G2eHZxaQn9wbCJ09yXw9DBQC+d3czSHlUXyjsrPvPQmdGuGEJ6WU58FFrYL5?=
 =?us-ascii?Q?c7AvZTJ0yrt+nrylSixPtuwIBidDLYGLA3F4Ve6Cx3No0eDRXNDN/1/Jhq1v?=
 =?us-ascii?Q?EwikmiHMrZCeCPB6gNbJiOLiZhmfWx47i7VdfSZ085NspfUdFHqlbTnGeezz?=
 =?us-ascii?Q?1bMJK/qK2vhePh/hAODdCMfEB776ZwPuTO+daC/fLXBVGXaHGLIihTrm18W5?=
 =?us-ascii?Q?sCnAic0wK2Qp6pJ47Ny7hwVrUZly59W+2Gq1A6t3KZWEghNZ+22EeOikyeWO?=
 =?us-ascii?Q?B99m6NOthsdwi5Yl1lmApVxO0QHPOrg8J9X3O4qledvrgkjreK+Sh9yUmXUB?=
 =?us-ascii?Q?iH0fj0wC2EXTuWoegvoBcde9u8Ss8A4pA7l8McbyyKmtplWHXIBqxWkf6haE?=
 =?us-ascii?Q?uSXK4gcnT9buasoSUpyCYwlOYccx2IzjJNsJIt1IoNKwO24pMujWqA+Ndhuk?=
 =?us-ascii?Q?G547UB+fhI3VmGOIMQvPd4IoBNxdAToHzx1k+ybWoJHJw0Na6CYR1lw5mTlA?=
 =?us-ascii?Q?UrTeYALLXQ+TCrH8A4grB5WbeT1/VAC1lGGzc6y/O7puoHfS/+5o6l0jpI3W?=
 =?us-ascii?Q?mWCKCTCbB6VgTV6+0K+BEF5cf0vgujDWgDn/m9fBe28T7ZowJbG+d2woVKj2?=
 =?us-ascii?Q?VUDafjLk9TxJ1Y7hCD/hPeeLmYtv82843BM1hP4bSCCPdDSpqbXHk+JPTkO/?=
 =?us-ascii?Q?wwO9WzBAdwV38xvolqlIe/JEtxghJnIYfJd5S6LjJJjMmvmAppy4gE6epyg5?=
 =?us-ascii?Q?rbA/K6PxSyGo3vpi9I+mk1gk1bpZJaGF9NNVmj/rVMisSgcSLVCyItDh7mEJ?=
 =?us-ascii?Q?bRhvjFSFzX1GGLtILlwbqZREuERp9ueCKfcWO74BqhxHnJKf9OvJABzV2hoE?=
 =?us-ascii?Q?KB+PlegC8MSBaCrtximLHdKd08xLfZelQeucWVBC9rmYpOUbCKuXM2YzM+rH?=
 =?us-ascii?Q?+bzSD6wmXMrFvxaKULwVpQmxO1mzO3Pi2IlMEjgDIuZfJ2o4mzOfPoMqv+89?=
 =?us-ascii?Q?f21xPy6hPZZhtN2WlqJ+bFWWbsMiXZPCBajVxSrXsWpjGMNG1DdPcVAADf6N?=
 =?us-ascii?Q?KSDYqO8WYzgqnR3cJtHfGtfttCtpnfXyJQrXfUDzyMPve4Y4Tz9/p47fae1G?=
 =?us-ascii?Q?6GtD7fBpLwPh/hu7YPDkWlUrvd3v3e1OWTuaAwbtTKYpA15QyvAkjZubl6i7?=
 =?us-ascii?Q?rbz0oCDjXvBcmPrJFJ2oBVSh8YA3QoWJKNjeQVV80UpmsFmbPkihVktb1Il7?=
 =?us-ascii?Q?aBVSaQ0jyDv1hT90Gh9GOcBf4D2pvf0TGML2Ad9+yYGWbWfyMdG2xaOyZR2Y?=
 =?us-ascii?Q?GVFRG2TtAlbOCieKD+g/d+0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zsRjVy6HU8kvp87iTgZeA2VshXfpZurzQhAnL3L/9eRlLuDzc//zSXF47MfP?=
 =?us-ascii?Q?ucviPA1IY0iO699ki+Ks/pYT9I7Dn+ag5byLYYhIDTnvl8Xv6lWmWFZEHDZw?=
 =?us-ascii?Q?bAxvIY0/uin1s7xl82ncB3x4Eb8j04yF5kO+cRtrUfFsaX0Ffl0rJ1x5oLtV?=
 =?us-ascii?Q?KdUP0wXIQYGHNpnO3j/FaFdyNY7crd63egxbxfNiGu5IiLgmCWiy3ZaacHBg?=
 =?us-ascii?Q?d6diG2D9CQI9jNQyC3h663LzhuKJTHA/eCxV8H2UpRZkhbl64D5H1wBSuC5A?=
 =?us-ascii?Q?y8LJA8yMsrzoknPdXZQDzgtg/m9FAQbBAKWkKrmQW/B4p9M7/iakxsWoiHEL?=
 =?us-ascii?Q?Hvo2hJgczIc1S4wQkO93/fszK4RbrkW9LU1G7Qu6sBqvkV6LLU4RkabJ3uNA?=
 =?us-ascii?Q?12vTee69YLafb9ObOCVQGDXZrQ1PFgSGXyK6E1E2TvbPK6xmH8kC+vxnN2a1?=
 =?us-ascii?Q?sPbbFaeShWIKTm598nojhDNrKEzmxmYYyIqmNPhTaxzfufVasYlRKct+sSvy?=
 =?us-ascii?Q?A86WG7OE8AydwfVxoX+2JFrmUWx1KSx1AshFoSv8HT0QFEiZc6yVDodQ7Y9A?=
 =?us-ascii?Q?+OBijc47tzRh85cZsL0B6E0jBYJ5sAOqrXHW89swjGEb35NRMNB5thqLhN9J?=
 =?us-ascii?Q?tjNpgvF8w04zVVxVd182A0QWz2ISgG5u2BCQ6fmA7V+Hv/zZBGLNRbNuzqyp?=
 =?us-ascii?Q?tLbkgEf/A2TcNlv2WObs8Jkt9M9rrwTaq0M1J21S4Mlxt3A+yWt7ckID7dqH?=
 =?us-ascii?Q?gBxXpf7/WtqMUgEbKunMoXQJChHDkLoV5aplsxqHXlZLy7RLbeXVAjn9ta0j?=
 =?us-ascii?Q?0Xe1kZMRuSpDjuH7EOC1LYyH0fWp9JGsBr7fsdeBCiVdrE/Kv3jXYeBtsakF?=
 =?us-ascii?Q?HcCfn37XClQGCX9lhF+c85kZho9E2zddAGqZBTiwc5QSTB7RAhAd04vw/hfn?=
 =?us-ascii?Q?SG1B15Zs2GqL7Bk7YC3PM+HsJP9239EpJVRVP+9Lw8aYTa6p5lyMQCJUDGDE?=
 =?us-ascii?Q?KoFiGKQ1W9ol9bGxynXCuV4lkrlV58i3xPb8CNugj/rA8L7xoF2DN9SShfSw?=
 =?us-ascii?Q?BBdm/NEwKjmjO4EfzTaoT27297XcG1qg8MeVv4bqq+HwqskPcK7DDWBCUJlN?=
 =?us-ascii?Q?052oRFeypzSxFfkthGALeEj68EY0eJP4pzUEYuSNeEot0rBVXewx3GG4Z71P?=
 =?us-ascii?Q?rUn/OMLqiiLJ98PjN9btxQDIBNQ5ekCsfkPihJuo4NYy7aJEbeajFKIl5Y+4?=
 =?us-ascii?Q?OG5UKhlESiOYJigmJPXfDzNh1FoS5do/Pr2a4ykfLS1Jrpztfwno2Yh6qipa?=
 =?us-ascii?Q?Xr3xYTDHp2Efa9PWRtcf8htOq6b4vXjpoTgzYR5x4HPkY5/gIxvM+HryCNGg?=
 =?us-ascii?Q?KB7Lh2c26lzOfy5MdHdehR/h14eWyiI3naJDBQ3JqToXo5Tf7aoVVSwFR/kQ?=
 =?us-ascii?Q?o8Irk4Zqjej+mtabIpgOUrCAca+ZjrCdwGwO+Gu/CP83X6nHTMJJdoDNOS+j?=
 =?us-ascii?Q?5QGaLauPtlOGm9s+UMmxuglIuUmJY0QjM6aQHEFCowrzkceenu9RBl7/VAVm?=
 =?us-ascii?Q?TAjmGfUHyqQaGAvMG7P7sD41MrIbrBPyLgCkzxbRbJC/U/SdbPLk2W2eIiSi?=
 =?us-ascii?Q?8HbugSPJEJoevpAEZJAR7lof2FWoq2R7S+rLV9GMKE45PQN++wn7DFgElrDD?=
 =?us-ascii?Q?5GvsHikakFLUr7KayKnvCnpYjB23jc17PKf7kkmPBa13QHSHr4Oiqq1lNWpO?=
 =?us-ascii?Q?TL2TvCmfiQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bede3dd-d3f6-4e66-b7ec-08de72ff4f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 17:16:40.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiSk2yzhpQtlUDz8H++utok1Lxn1BaV1Pep8smWMRcapc/a8pIdmukVLeLOSi6PtPT7GP6Utr31JMz9VtBq0Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260129-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9835D17A938
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: Monday, November 17, 2025 5:49 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 08/15] idpf: refactor idpf =
to use
> libie_pci APIs
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Use libie_pci init and MMIO APIs where possible, struct idpf_hw cannot be
> deleted for now as it also houses control queues that will be refactored =
later.
> Use libie_cp header for libie_ctlq_ctx that contains mmio info from the s=
tart in
> order to not increase the diff later.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
> 2.47.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

