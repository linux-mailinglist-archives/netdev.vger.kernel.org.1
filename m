Return-Path: <netdev+bounces-268128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKO/Dezqt2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:35:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38817298C10
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D4A63005146
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F1338586;
	Mon, 16 Mar 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoMz/5Q1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2E2951B3;
	Mon, 16 Mar 2026 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660903; cv=fail; b=fivPm0SNnV679RqR5TREXXVK11ThjwikCV0MxPVWbQUzlux49Hm3+aKcMlBjJZQ80V6FrgSBQ4RsDJTxbqhtUJ9yrGKmZW6pE4LmkJJVZKuj6EZESX23tS7He7mQk/FCLlDwIT1FLzVgsa9fK2spzozOUrCq6tSb1ybrg0wEFyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660903; c=relaxed/simple;
	bh=/pVL69eYvmKILaeP9bs9nsaVToHDmqeIvpflAWzPzKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zqc5fsNwkNIsTeGDzLbfH0sy77SMvlPa5mWV6c3dFNWz2BJVOFhHmr8efNIebSWEcp1CWO1w+vXLVWD3sAlCJW1BAUO4RVQqZMloZTwfdNtF8IS+MQWHOltg8B45QwwpqfPYGzizgDC0hrAwok6s0lZojFc6ZqX9ANKO7AZxkhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoMz/5Q1; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773660902; x=1805196902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/pVL69eYvmKILaeP9bs9nsaVToHDmqeIvpflAWzPzKw=;
  b=DoMz/5Q1y/yRFUAlZs63rXsiC0Uk7WLV9HI5v5ddjYRpwYzPa8Rg+ZRj
   ofWX5a+vZ4yRvoxT9f7vKuVE8brSdaZbwkMsTV9EYrGJ6wBu3WhdIXDPC
   nlaEOdT1YfZnYhfhWBAaO+7uzCpL14EhVwbDInUlqv7qZyAuNQj0sDR7v
   czzyc85djGF3d6bLexh5AGmr4kakAGli0KSBbl+LszruC4wpkYBUPU5xj
   mFOuyVSgQm8EZS5Q5AaGiOTdR7W1PiVmgVf04l4GloCLJz8YIkZWIrM5T
   VtSm/neD3fbTtT85GJmGeJwwTOt/cE8vg2jakcdPNHbkCgu2DUTFxzIGN
   Q==;
X-CSE-ConnectionGUID: 3eyXBhkgTzGVZJwrTVX7iw==
X-CSE-MsgGUID: USefvTA1Qp66YbGNHF+KdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85374186"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85374186"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:34:58 -0700
X-CSE-ConnectionGUID: MYQlDWcYS22Zv1U/qd40nQ==
X-CSE-MsgGUID: bqY7E41XRkWQ+GTeQeWcsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="218157226"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:34:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:34:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:34:57 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP1SujUuC7qJuc35MpMlffUM++6AMCqUh0luIrk/z7tQhPjyGfcxG7mB/C9cO9/Wj6nit/7WeFB/1y+1ErsUYMOYWaWK4Y+U41D4ZCDxoCX775/4NtUtaL0I2LfXd+Zt+w5i5PUcVPloyPyFp4xMCStWPLSqh4eeYcBJETNWrWaTWPR3p3DMI9e0lkhdicoSXXkWXszy4/7d9/MqVfaYsu5AFDbld4YJW+CIxy9tyJRjfV+mdFb/GnKVwFGAVeMtdQdqiPewY28SIH2nERLQBjolrPdi4XlFLYsz47Q7jnkrK7GOTTSWt57HDmwVsZpOqF5RxIOs8rKNeA2mVwMWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNBZvvWnxug1QFGNnuAEshvu8aDrx+jXjI84vVg07fU=;
 b=byCEFYny/s/nA5jUfF3eoAscAPqqkFltdjvXIyMRPOEmRHcgsld7T8oUQsADZTh6xvMvgS+0Miv2XkHcYbffIeijJikNbgtJmjNWnIumu/FXarFdhpK2vsHwLkFOe3iq8U/M73Fj05/LpUJ460L324fTQCYgpI3P1El60tVaIk/rstLjc4WKmyk+i3xLk7FJVhwO4P1MU48XFGPzchL1uXkDaAH59x0OFnTUyZUiKM5mmu2HHTZ751oFFD1Z7rhMV3nDyWRJeIIpH3YolkaLAesM2t4XHdKgHmcHV/zQyoLOQEDt7iFgrWbN4DX6J7/FLbBs0h9G3azJ16/dMJSACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9657.namprd11.prod.outlook.com (2603:10b6:806:4dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Mon, 16 Mar
 2026 11:34:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 11:34:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH RFC iwl-next 1/4] iavf: rename
 IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
Thread-Topic: [Intel-wired-lan] [PATCH RFC iwl-next 1/4] iavf: rename
 IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
Thread-Index: AQHcqjl3DQLyrPIRZUueojti1eCG1LWxHU/g
Date: Mon, 16 Mar 2026 11:34:54 +0000
Message-ID: <IA3PR11MB89861519B35EE57D5D03969DE540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260302114025.1017985-1-poros@redhat.com>
 <20260302114025.1017985-2-poros@redhat.com>
In-Reply-To: <20260302114025.1017985-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9657:EE_
x-ms-office365-filtering-correlation-id: 10e5cf0c-46c4-47b9-533b-08de83500b4c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: S342cCa50pFO39QvAS54kG4W31FsLARV1IivvfEB5elNVJ4cKV/k/qV4YhwGLyVaFAaxvV5SHZedMu956rLRdAYmOG4MGZ+uWCu3lXlXwXQiRHkv0x63klfaibnu2C1sW4CySD+pzKlUxEBHbtLOZIcc7JQeBn3gUBL1qtWiSO1zFSIbBnl7D7M2kIE3xXogsbBgqG2hetmGINi9mEzhcklN3dm2JlqwWc+zgQGJqQ+ObiD/znvDtrGXXCanRW7PafP6j4Aa+Y/QIu6MxeVMcEO9tqdMEgYRq4/2NXhkAo1ofwfZ2Hm057jaAtZrAJIuX19hugEC9TH+C6ZsNJ462BfHgMlGquH/HU4iiUaX/RBueExmRJ+AW2ic1cwgvOTmsm2jkqbz7xkuWyrX5dwgSgzUe4xfmI+r4UMt1UGQdBjci5QKUENjy2EGNPCkV9MQYss7AAo5leF1ABi5j+uwubFne7A1ftL083l87HhiS7O6+utOl6caAOvYC2o1uT0TwPxiRglb63MkSk3at8XCpBMN9mGsJiM3kaP2Nu4Qgh4SvUJ/4XpFmw7T6ChtxU6bbXhUxGq5o0Vi9213JL18HgH2LhwiU6bLnqAAF1RH0sQJCsTo53ZA7uKzydhTGVDurdx7sG4WKpQLQZvIeyyjzT6NRsxdi1GS6Mh1oEMhd+mkyZ+tFfImRTydXVhalLkrEAdslFJUJVVUSo+2hloQhBerniRNbn9Qax7n9UiIv8sYyOp1RloiSE1uLKRabh80X6etsuZoNr10FH2TKsExHKVOH6KVrZCmtj3/Ufj/bD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sZ19WW634GrGCNExaQSYkEd3SfA+0HFb5wlmD1Die2kGddF/rQj2MThjbbZ8?=
 =?us-ascii?Q?nX+Kwp01q/6MdsoCRB0gznXuIm8WeT1/eQ422tWj6yJ0hlB5LIAIvGKSUrn1?=
 =?us-ascii?Q?uLY8KKC7cCR2T4IvVjtMRNy+xGZ1c2MSD09UKaHO1JeObZFMkkXTy9+Kay/L?=
 =?us-ascii?Q?mG5U/pyt2n7uH5TW3MXHUM68OKPwoo1Y5WwLx6gQrSrqLbWL5+xsUxtC6hZT?=
 =?us-ascii?Q?SDwjKWPEFmie1BonaLjZPlqy7xuGAmRdWdjAZIxl46+yb3z4fzAgmmBEwY7I?=
 =?us-ascii?Q?69aVBD7MOcPRzYHe9K+nJbBcJLWIwwxKIir8c/5JTjgGJRX1nknu7goXt2Vn?=
 =?us-ascii?Q?YOGBrQrPEdlKRkgdLM56lq86OjzxTH7eL2fbRDdmwqze+Pe4lFGit5iDwJO8?=
 =?us-ascii?Q?dB0YxTGSgptByldYF+1GwNrFJ49zmRRsL/pur8j3JNIpb9lFsG5b67sn7rq+?=
 =?us-ascii?Q?BPtp0Jwfa/Du53rAebbgY+ZbmR63rZ2cuCNgqMovATxikvWO6mWIyyUAR/11?=
 =?us-ascii?Q?JTDz9AhYDq6rAII0lSjeyba8qCEbpwb/9j3onClttszWRvn4izqvCOVpdN8y?=
 =?us-ascii?Q?dyAaBUHllMMRS2PPK/9iKPO7QLayk7S1qonHNrT8R5xXkimXJnMj4ZPi+wlz?=
 =?us-ascii?Q?hTqicIXegi1IlRPNOWK1iJuDI2qoNFzui2HYePEQnxJaVCrZiL/nVY5Bv1vs?=
 =?us-ascii?Q?Uo+Tk3ZWBiBDz7uxoVSSBg7IChBGEviIRVRw7ZiytTtIpumXew5NtVTqC9aw?=
 =?us-ascii?Q?U8c0D4JJPnc2aQkzKjPTVz1W+kOp56XjSRn+7HGEDbhGi9krldMCb7Sxhdoz?=
 =?us-ascii?Q?71ES941mXt2Eqfz7k9BUGhb6MgOqhIajnha3z6a+tyqPy1q0uCw1z7Bmvb/Z?=
 =?us-ascii?Q?Qd02qQC6sDTLMwruhD7Acxt/bpn6N53WYKklq/bo+Oo2VezrcbHmAkUdez0K?=
 =?us-ascii?Q?BjjlvSATwoA+Fo95uNsYMP6viAsJSxOZxEp+IMcB1+pc6xuvRjOVUhqUvswu?=
 =?us-ascii?Q?kdI+zdUts26nsrBcREKPmsKM5FUK9bmnWZKQyHc9uwARpP4Rv/l0uI5Efvif?=
 =?us-ascii?Q?RQ7bvMZfxlxS4jXaDl+tfsQbLfStZcbadhySO7HHlFcrBNYaqVagVYo0kLwY?=
 =?us-ascii?Q?8ashp/p6gJ5lxVVbU/sU+Iy6rNTnSag7F5v2+F7fWwB/ngIeIi3AkpRDjA6K?=
 =?us-ascii?Q?jD7hsvv0+ebZgHmUtrZE7fvgTMZw6MUMDGIy85Abn941MET9n6docZvUlYOA?=
 =?us-ascii?Q?/i7amWN3MVmQDgA2cUkGReDbNJ96f3MR4zbJKq+lidMg9HT5Fu22MH9Oj+Ft?=
 =?us-ascii?Q?PcjJg4S7E7+zQYcyojmSXo81hrG02G5RtBbwL6vt3K1XQOi7Q6YswSLTgo5b?=
 =?us-ascii?Q?XEyecF1opyMfJPEqn2T5fFxvoKYaLetp8OauxGGy39Mv/iz3u/8xjMAWh3LK?=
 =?us-ascii?Q?+bsMZMMQHF3I1NWU762taaui34Rg3S2KJLA/5u8o9k7z5xVsXPfSiMbVouEU?=
 =?us-ascii?Q?ZnxhctR4mx+0VDTrHbNOPFVF/TpFe29SpIZgu9+JFU1FTnzZ97R0EUfrsQRD?=
 =?us-ascii?Q?ckf9pbDhTron7DGCJyNgIjCjoqQXWys7LYuEGHlf1kMgk0dcXq8OFwVV+iJG?=
 =?us-ascii?Q?xj9zrtyO94NYp0bGssY24HQJCiHSjZtlL7+ABfXNhmNDFWdiIGrrGdm6/IhQ?=
 =?us-ascii?Q?cQlB4JSzlhFuhCesLWbuzYWcYYsy1GgsfX1G6+ORL1mWeODVokpuA2B2+mAr?=
 =?us-ascii?Q?yQRP2q8OpLBqr8Sp1YM0alK1xK+RO0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IYyJ/kMa4NIdKYZ+GBd+ibMXfbeeZtFT/BHLred1lHqniBu9umo6pPcZ/4ppXt3Uju+S2YIbJaqsB99hB3yJnJNtkV5ToHVRciUx5shq/2Y3e+RU1cqGC7RaKjbNLqjwG3zFSZCZdoL/kd/X/vcj8nTUj368dccU842rewIpPI5US6SVosMnU9Pk2NbCeoBjekS0jIwTfswGg4DwzZCS51JHFLuxaD3Nq8vZyN9FRDV0B1aD9vb/TAmnB2jXD+iWr+khj/x8IokKdv2w8TMxnT/yP0ILBYpU33fAt89x5l9XLCbxX7VJs45vAyRmekGsoP/PQg+LmbzEBOV0tcLfVA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e5cf0c-46c4-47b9-533b-08de83500b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 11:34:54.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1hYfx4O/SKyUxPwEFZZqrlSG+iQzEBr+p11ChXcbGzYOc6qmiLQj2Fy4ttmg6GHN51EOdbjXwukfTJoGmbiWe7D1YgB/DL+15F9md+mU3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9657
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268128-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,davemloft.net:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 38817298C10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Monday, March 2, 2026 12:40 PM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet
> <edumazet@google.com>; linux-kernel@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; intel-wired-lan@lists.osuosl.org;
> Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH RFC iwl-next 1/4] iavf: rename
> IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
>=20
> Rename the IAVF_VLAN_IS_NEW state to IAVF_VLAN_ADDING to better
> describe what the state represents: an ADD request has been sent to
> the PF and is waiting for a response.
>=20
> This is a pure rename with no behavioral change, preparing for a
> cleanup of the VLAN filter state machine.
>=20
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h          | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index a87e0c6d4017ad..8e6db72828ae14 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -158,7 +158,7 @@ struct iavf_vlan {
>  enum iavf_vlan_state_t {
>  	IAVF_VLAN_INVALID,
>  	IAVF_VLAN_ADD,		/* filter needs to be added */
> -	IAVF_VLAN_IS_NEW,	/* filter is new, wait for PF answer */
> +	IAVF_VLAN_ADDING,	/* ADD sent to PF, waiting for response */
>  	IAVF_VLAN_ACTIVE,	/* filter is accepted by PF */
>  	IAVF_VLAN_DISABLE,	/* filter needs to be deleted by PF, then
> marked INACTIVE */
>  	IAVF_VLAN_INACTIVE,	/* filter is inactive, we are in IFF_DOWN
> */
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 88156082a41da6..5114934fe81fa6 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -746,7 +746,7 @@ static void iavf_vlan_add_reject(struct
> iavf_adapter *adapter)
>=20
>  	spin_lock_bh(&adapter->mac_vlan_list_lock);
>  	list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list,
> list) {
> -		if (f->state =3D=3D IAVF_VLAN_IS_NEW) {
> +		if (f->state =3D=3D IAVF_VLAN_ADDING) {
>  			list_del(&f->list);
>  			kfree(f);
>  			adapter->num_vlan_filters--;
> @@ -812,7 +812,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
>  			if (f->state =3D=3D IAVF_VLAN_ADD) {
>  				vvfl->vlan_id[i] =3D f->vlan.vid;
>  				i++;
> -				f->state =3D IAVF_VLAN_IS_NEW;
> +				f->state =3D IAVF_VLAN_ADDING;
>  				if (i =3D=3D count)
>  					break;
>  			}
> @@ -874,7 +874,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
>  				vlan->tpid =3D f->vlan.tpid;
>=20
>  				i++;
> -				f->state =3D IAVF_VLAN_IS_NEW;
> +				f->state =3D IAVF_VLAN_ADDING;
>  			}
>  		}
>=20
> @@ -2911,7 +2911,7 @@ void iavf_virtchnl_completion(struct
> iavf_adapter *adapter,
>=20
>  		spin_lock_bh(&adapter->mac_vlan_list_lock);
>  		list_for_each_entry(f, &adapter->vlan_filter_list, list)
> {
> -			if (f->state =3D=3D IAVF_VLAN_IS_NEW)
> +			if (f->state =3D=3D IAVF_VLAN_ADDING)
>  				f->state =3D IAVF_VLAN_ACTIVE;
>  		}
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

