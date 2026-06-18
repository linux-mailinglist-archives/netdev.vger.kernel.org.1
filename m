Return-Path: <netdev+bounces-300317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyU+M3OAM2r5CwYAu9opvQ
	(envelope-from <netdev+bounces-300317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D66669DAE6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MC755vU1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300317-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7F230131FA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA5837EFE4;
	Thu, 18 Jun 2026 05:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B937D135;
	Thu, 18 Jun 2026 05:21:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760100; cv=fail; b=bPDNHNiUJwlLE4dzAfCAYg6gDpcUxs1OZNeLSTaehzR33ADC6NM+0Xf8zpWLlHBTJ9vFGupK25wzg43KkiTJE1GoVFvQLJc45y/HnbF/amt27RwBUvFSHJPuDxqWAVGKJxIP2pxibnbTtQfkxQQzMsd81hxJLkH8lNrCgZZEVjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760100; c=relaxed/simple;
	bh=d5sL0WaE6bzrkY8QkRBr5z63gJsKhRrhUr9tsJ9Gmao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qjldwGZCzyQutkJa2eZBTFE02jo/rMqf+DmzPN37rBBnQRgJxmvW8C77P45GHgU7AEtXmeaG39TBmungmFjU+65dd9Tzx/0/BBbNb7E9WbzfebJ6G6tQgWKLDqPw7NRiEz1GuCn0XNBnIE5UdTEN96hRxXynm/9tcclsbwPFISY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MC755vU1; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781760098; x=1813296098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d5sL0WaE6bzrkY8QkRBr5z63gJsKhRrhUr9tsJ9Gmao=;
  b=MC755vU1hv2YEwzLDsnfxxh1bz/Y4S0UPeGO8/3ww/0L4bn6E2ErKzjy
   5VUU5KzCnOx93U942e6Rk1lEJ/YJ/JQrGPUU4+ef8lNP7l1K3uWz4sKy1
   Sf+hdHqiT1ZaOBRnQzXV7f+OfTNEZhKLlHhsttW9d+Xfqyna7avJtmxWO
   /Fq1U1cCDc1+5ARe2guNefDmLZVXnuWAhN7hcJkwZ3lEH4fpKNIHq5uuz
   WUrSk+H0zvGQ9ARQpCHAtVI9w2y+td8hrFMQ65vL8md/UStM1M7smfR51
   6d3zwv8EBeVhlFjuqW8lRO68mqHP95i/ZzWxXGJeK/N59oeQE0QyIf+JQ
   w==;
X-CSE-ConnectionGUID: WF3mQLBMRmSFEXXKU8szuw==
X-CSE-MsgGUID: v3DoxMPISOytG3vo9n+RTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82694902"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82694902"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:21:37 -0700
X-CSE-ConnectionGUID: xEMzUPIERauaz+JeIdNHGw==
X-CSE-MsgGUID: jFdz/5UBRBKpPCsnwE1NTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="286381982"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:21:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:21:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 22:21:37 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:21:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwraek4iyhLKvgJepj81oAWPBAeQyEDRkWL1hJ4D73vpbr3KP5Tc5wGMwQzzI1f4yWCN4N0O3KQiRCMByTZ87Q/Lhb3MrGN1M02fY4l2hX6fQ2lQsUMj++OMoFzVCImDSEWGNv+3SFn+cwcF/fYetghGkUpEd1Lhq4p5ilX+qCdPmpzHMtvQM51+gZjV3K1Fa4nhywdK2Die7iz8nYRNx+DBIgjkMXmT67VPDj8o5OPdjzYvYz9koXb8jZDpyTII5SoysRW5AQAFD0OCc33QLmQDWh1BfLE9sd/JmsY6CNqPh/BldTNW+d/a2vwxGeZhRzGNRrDGOB+ayiQVS8k26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC+6HhS81qU1qvgxVypJS91yRixuTMu+Eu+RzO2QNEw=;
 b=GObGnzp4OBx1yjQHQbkhy8h+EsqO3wLTw5U/UzGOvu0IgQE8j38ydWTDvsPNk9KuelxCwCEEf0WYMrCYPc7UiU9ixLGVx4Tlqkl3eSlMH+egUCCs2hEjldVhChechVwT1eKh/JFKQW5jASvSx+m9BFMd6Gigabn+BzC8CBQybH+YBuJ8R3aSgsXIgQooCA8yxuBeGcLDo5ifr/nZLSMvl+pWvjJwDBBAI915+1pM8/CNqJDFzx1hvvLnX1pDaEAYbv5+HWHA2c7IQco7A5Ji+QFnpVMYpTqCljReEecPjgPKV3tFFOaWtbkZSLY2p/mDr3XDvTAxeXr94kdrA6ebzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 05:21:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 05:21:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: NeKon69 <nobodqwe@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ice: Fix use-after-scope in
 ice_sched_add_nodes_to_layer()
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ice: Fix use-after-scope in
 ice_sched_add_nodes_to_layer()
Thread-Index: AQHc/ipU8paUxUtCEEO1rGLfeqUTfLZDyD/Q
Date: Thu, 18 Jun 2026 05:21:33 +0000
Message-ID: <IA3PR11MB898659AD67697A8297D56337E5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260617072155.1172432-1-nobodqwe@gmail.com>
In-Reply-To: <20260617072155.1172432-1-nobodqwe@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5791:EE_
x-ms-office365-filtering-correlation-id: 22d7cfe0-01d3-4eb9-8ffb-08deccf9763f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: aZF/647N3mPpB6/GKPFU2+ngQfq1ZVBKNMB9ixOY+hvwQgU6DEObJ5fIjp8My41hPBql9RgbQ18Nbe4pR0jYuJizXlTG+uHuIbAtnSsOagp9a1cNjkcqpQ63VQFYDObHenYaCyDgPwDhq9TR2vrsHbspqKzotVb3F1laAhT3O60FghgsepNUmqJvYZMF0qIp6xYsGGfz2CYJHmhN3Gz68/Asor5igqTAxgZ/RCrMXKsRuvnfwNLZguAVaUZzoIdZYo4m3Cfr+Ty7Kizhf9hba3BRK7ENvw8jsaVhl3MBHVGTJx9D8dy7N/PwY2duMG0RSvlw9P0nrStPV7mM5ciIMwJPh11di/sQVulrDPVFkn9AvE+ZOH4mMlUjCiv6nssGg2LXS+CcRVYZ2xGSWQ/Pa1rUN/9Z0O2maAapkb9zYWHXFLfUH8+j0VgyfMoteF4Aic4o8ZXO1Cq0cugIqh08eQ9Cs9rmZa66jJw8oI9wcmQe34w95tjf6g7NmhfmaIB868oaAOsw2CCbgPnvl2yFDWCeMDeU3lWnUeltvHsPL8fpbHmotQI7QFEF7XYZ1nKDLwVFc6Y+USZ129tMij7nstb/XxNBkzIExZgfrBUT0KVaKaUK80llvtnfiNs6p8/BbAf/Xwvz6FecjxKvzcbxrFjwF4uwOg1aTEjt3B2uPhDhzZ5Laq7F5J9slprpBpdVQ7jQtVBcTXbZLg3UjfyDqaQ8UX/JDo4XmWGXNvyPBuMDGDcQY0N4cOxN33ibgVXR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QEoadVLemDGGNYkgtbxyJHYxOlTTyBxxfHeSYVshs6kbJQ+0goyPZ1wpV8r5?=
 =?us-ascii?Q?X89B8AhR0Dd3Knh9oWjJJeGdneOtVVRgcYeX8sqstBTZYGhMxruuJvGTXPPs?=
 =?us-ascii?Q?YuUTFJ5Lu23WnN+H16JqvfW9DXNqkOcF/lzCfU9qvGlJzMY2Ium+kuSnVTWP?=
 =?us-ascii?Q?j2zxx7nReWVz5dBP8JvYHu9l/IjQ9DGnqXB6Pl1kztPkBRPNd1+lzO7Ra3cs?=
 =?us-ascii?Q?gxWo6cZox/NsNy7XiuPrVMrJ/EDq6FAA1hOb5YPBVWohUWPZdCy261Xq/3MG?=
 =?us-ascii?Q?WgZzN4ZSdTluzoVFz82Qbuqyqyla9iUGIkspLqVcMwiLM2B0FbNjFNK65kP8?=
 =?us-ascii?Q?20J0QUi0pBOQOy87JKJHTKgpGQjw0DCmqgEa1DaFL6ICwGol3bTaJpAajlcl?=
 =?us-ascii?Q?E5RJkYsWNOnOyEmC/EdENiOq7wNWOMg/QlQl9FnRcmILXpp9ztLA62eqPRVn?=
 =?us-ascii?Q?YCUOFb0U1LC7JV1dAlbeT+35qTs7kQZMy2nQdQzv0NlLnCJhAt1awvZcoNBv?=
 =?us-ascii?Q?OZrxARwsds3vn5Qh+HlVUwKCfUwf3xWCBKfARKn6RR6wa9ZQcauy8ofo1kWf?=
 =?us-ascii?Q?50Os4ZLnFahIkw+P892rqP6EuSzcTu7xLFu/KZ9AMbSght0LFQuGtYfWAPNs?=
 =?us-ascii?Q?wyKm7v9mTZatXe4txWZWz74pncRFKcwMnm7NKnsV9f6VNActxX1kPiny+Z3p?=
 =?us-ascii?Q?oa+3LZEQ1R6tNaM9r9hEy7Dohs3JbC4LkJfPJoSM/sZQvjx2mMirM5pbI8zu?=
 =?us-ascii?Q?LENQVymnr1A3jiFKxwhtA7vGzOJzmFzy67e6Weu7CJpxcEHBrr6dsLks2YKX?=
 =?us-ascii?Q?cycuncykvbhiGng5smIH4frwr6G6MCwJW9n7EoF3h/Z+uRhXlHxOtO4jAnu5?=
 =?us-ascii?Q?kYg8aUlRsEUmrPgxzT5shPAL5O/albUBMAHCEG8U7+oIGmkb8YzcoylkJn9v?=
 =?us-ascii?Q?Kml0RKzAS8cpwE27AUQU0YKayK+5HaJBxF5wvZKLgmsyc1y+L27KAODUm0N/?=
 =?us-ascii?Q?n9uFxgZr5b1DXLu1HEZ6tnpySBUXuyICbC+FmruLg7GgX92mDSfq1WmG5cjW?=
 =?us-ascii?Q?FkaoJBIv8my3nj19Ux2l5sWsxQcmPTMsJuZkTrYVEwtaLo2JyJkdFpdCrXz4?=
 =?us-ascii?Q?RUV+FqunzYhe6q/3ggEODtwHctX/xg7/fovib1lCj7uWhzTDuizFoB/YfyRS?=
 =?us-ascii?Q?CsVo0lNwmpEixY4W4VyKaYGqSofSpi7LHkaF7UwgjOeT+fr/wx1zTmOWFe1V?=
 =?us-ascii?Q?pmLmxqPMjSOPX6eEYqyaW5yE13rAGWfYPpPhaBsJJsoMioAbrjekoRV65clk?=
 =?us-ascii?Q?fbKdAx+qByhoDRE82ixOPND49KMgFMrURS1ePMCntnZz3ufvLSEPRk9l06Py?=
 =?us-ascii?Q?gM2TfZonZx5SE+AxIcIETzDLZ2I289Q9+ErMt6I2p83wxf4PT1rinQTBtdds?=
 =?us-ascii?Q?TnLOsDKC7V3jR1/7knneP+S2aEVdJY5GhjIP2KNkdIoqgw2A6qXYCXxJ48Os?=
 =?us-ascii?Q?jngRbRS0XXOwUpCt1ClMroueyvjCbck15uf4xrLIU5DAC+3dBYTPuiIMBHlM?=
 =?us-ascii?Q?okUexWnHe3TJXtHePL4sh9Au1Zn5JdG0pTTfoaBXP9p1Ch9doSejg4YnRt6r?=
 =?us-ascii?Q?Az6DrXo0BkFwTNL4l5Be3ZpixVevfeDkNCpjFZxB/6/VtW5CqfK3iEZ3aFhQ?=
 =?us-ascii?Q?XAvEjViFPKfXC1/VPbxL5af7nUTwaHnjlv2URympSDbFy2JgcWWpeIIoCucI?=
 =?us-ascii?Q?zF/xaDKg3GF3yeGgWnOOZO2nyFie5eY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UvHtEma1FRNATyrahbg5F5pH4YcOpLE+PtN/aMYSZYE9G7O3gIuR9fVnthcxlFQ4KGwSK/PYcDRrBAK+Gmcsgv7zEWINOzIBoDLPJYr/F6tU16uo7wFI5esNjA5yxaSUj+amIxICarfpRNcE9QtgBHu+xLWe5ZX7TBLKibjV9/nOPctKZHmIcPCr0zLbOnldWQennvrasxqT19Z9HDwwaKVQaW3JEZHiFAW29N5F5E7cpglLHrst+dOxa/tqe5hjz8FpU9kQfRSZsTb7JOQvp7hgYQglRfT4nNFaDUouoPgAqM60AXHX2/ju/LkzyCatXLrTeRTv/x8+Nu7A1tBqiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d7cfe0-01d3-4eb9-8ffb-08deccf9763f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 05:21:33.5532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/SzxiyDJRJdLPKerA1BqHu7IhZZmODRQDQ5EhWTMhvy6yRExpsRQpflOmaDhmbgIuwrRIpb+m6uGpckfzSWUEhm5xHcamXHP2pK5WX5LbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300317-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FORGED_RECIPIENTS(0.00)[m:nobodqwe@gmail.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:piotr.kwapulinski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,davemloft.net:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,lunn.ch:email,intel.com:dkim,intel.com:email,intel.com:from_mime,osuosl.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D66669DAE6



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of NeKon69
> Sent: Wednesday, June 17, 2026 9:22 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kwapulinski,
> Piotr <piotr.kwapulinski@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; NeKon69
> <nobodqwe@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix use-after-scope in
> ice_sched_add_nodes_to_layer()
>=20
> Commit 7fb09a737536 ("ice: Modify recursive way of adding nodes")
> changed ice_sched_add_nodes_to_layer() from recursive control flow to
> an iterative loop.
>=20
> Inside the loop, first_teid_ptr may be set to the address of a block-
> local variable:
>=20
>     u32 temp;
>     ...
>     if (num_added)
>         first_teid_ptr =3D &temp;
>=20
> On the next loop iteration, first_teid_ptr may be passed to
> ice_sched_add_nodes_to_hw_layer(), after temp from the previous
> iteration has gone out of scope.
>=20
> Instead of keeping temporary storage for later calls, allow
> first_node_teid to be NULL when the caller does not need the TEID.
>=20
> This was found by Clang with LifetimeSafety enabled while testing C
> language support on a Linux allmodconfig build.
>=20
> Fixes: 7fb09a737536 ("ice: Modify recursive way of adding nodes")
> Link: https://github.com/llvm/llvm-project/pull/203270
> Signed-off-by: NeKon69 <nobodqwe@gmail.com>
> ---
> v2:
> - Allow first_node_teid to be NULL when callers do not need the TEID.
> - Pass NULL after the first TEID has already been returned instead of
> using
>   temporary stack storage.
> - Update kernel-doc for helpers accepting NULL.
> - Link to v1: https://lore.kernel.org/netdev/20260613101440.80190-1-
> nobodqwe@gmail.com/
> - Compile-tested with:
>   make drivers/net/ethernet/intel/ice/ice_sched.o
>=20
>  drivers/net/ethernet/intel/ice/ice_sched.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c
> b/drivers/net/ethernet/intel/ice/ice_sched.c
> index fff0c1afdb41..89e191c839b1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> @@ -895,7 +895,8 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
>   * @layer: layer number to add nodes
>   * @num_nodes: number of nodes
>   * @num_nodes_added: pointer to num nodes added
> - * @first_node_teid: if new nodes are added then return the TEID of
> first node
> + * @first_node_teid: if new nodes are added then return the TEID of
> first node,
> + *                   may be NULL
>   * @prealloc_nodes: preallocated nodes struct for software DB
>   *
>   * This function add nodes to HW as well as to SW DB for a given
> layer @@ -1000,7 +1001,7 @@ ice_sched_add_elems(struct ice_port_info
> *pi, struct ice_sched_node *tc_node,
>  		if (!pi->sib_head[tc_node->tc_num][layer])
>  			pi->sib_head[tc_node->tc_num][layer] =3D new_node;
>=20
> -		if (i =3D=3D 0)
> +		if (first_node_teid && i =3D=3D 0)
>  			*first_node_teid =3D teid;
>  	}
>=20
> @@ -1015,7 +1016,7 @@ ice_sched_add_elems(struct ice_port_info *pi,
> struct ice_sched_node *tc_node,
>   * @parent: pointer to parent node
>   * @layer: layer number to add nodes
>   * @num_nodes: number of nodes to be added
> - * @first_node_teid: pointer to the first node TEID
> + * @first_node_teid: pointer to the first node TEID, may be NULL
>   * @num_nodes_added: pointer to number of nodes added
>   *
>   * Add nodes into specific HW layer.
> @@ -1078,7 +1079,6 @@ ice_sched_add_nodes_to_layer(struct
> ice_port_info *pi,
>  	*num_nodes_added =3D 0;
>  	while (*num_nodes_added < num_nodes) {
>  		u16 max_child_nodes, num_added =3D 0;
> -		u32 temp;
>=20
>  		status =3D ice_sched_add_nodes_to_hw_layer(pi, tc_node,
> parent,
>  							 layer,
> 	new_num_nodes,
> @@ -1109,13 +1109,11 @@ ice_sched_add_nodes_to_layer(struct
> ice_port_info *pi,
>  			 * try the next available sibling.
>  			 */
>  			parent =3D ice_sched_find_next_vsi_node(parent);
> -			/* Don't modify the first node TEID memory if the
> -			 * first node was added already in the above
> call.
> -			 * Instead send some temp memory for all other
> -			 * recursive calls.
> +			/* Don't modify the first node TEID memory if the
> first node
> +			 * was added already in the above call.
>  			 */
>  			if (num_added)
> -				first_teid_ptr =3D &temp;
> +				first_teid_ptr =3D NULL;
>=20
>  			new_num_nodes =3D num_nodes - *num_nodes_added;
>  		}
> --
> 2.54.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


