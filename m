Return-Path: <netdev+bounces-94669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FCF8C01F7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D581F22C68
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D93128803;
	Wed,  8 May 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka/8StOn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3E82C63
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185783; cv=fail; b=VvsACLOOIrrGVLLRBOxXGvTI3ADickHzpCYZOUGK40Nk7gr7uzRGHOdbwsfXRKhuYeysjOfHafaw58sszlSdql3KDBGMSAkSyIlH20OxItC4AZz+Q3tA1zebQGn3CB0YAMqFFBPGMgmG2HQUaUCi6KJDxVoVBM4NBs0woHyXyNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185783; c=relaxed/simple;
	bh=p6e//J2bT8CHd6Tq1OupxqroobemXdHKNOVfEptW2yU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7ET2pquTd0d+DeaWydVuNJs2WnbZHs5RDn6YHjNDvRrY5/G4gytIBIbpmfgRByOt36/cRGVxMVX4OCHY0AG8q7S0NyZ4ADBDPQi9v6FJuqShNHX5C4IzXvf4ivie7v13CmFeuFkulP4MvldlqVUrKlfPtfg735Znbi26eLgEjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka/8StOn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715185781; x=1746721781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p6e//J2bT8CHd6Tq1OupxqroobemXdHKNOVfEptW2yU=;
  b=ka/8StOnD+qNyT7jqjICCNrGJQ5OMGkwzSpEQ7xenFrYnXF/yvAP00qT
   lQ+wVzd9mW9PNqHhGVdbs+LPqc0SoHFl9N20zDPac9upMFMuOZdoYkHor
   gp8Pi8dFqViFSUfaE61eRrCGihRuKVI4s1jDJnmH+R6th9DT84mzM3gWZ
   01hKWswHPKZdet0quf511hXw9t1Yln8PcVskv9IwbOKEkuu5ZlKG6I8OV
   8WeFBvyd3+zXBghURDSfIptJn1wzP8fcJCB+Na6gHclpdMqRjevsdODuB
   JXFp9lfakw4p0mxWC7mTPYiD8LpbiehUk3LqZLTteaaNiTYdBMMMAb3N7
   w==;
X-CSE-ConnectionGUID: iq8C4/ciRY2qnsc/PIKt4A==
X-CSE-MsgGUID: S3d+oaUKR2an2sCFl9jmoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11215359"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11215359"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 09:29:40 -0700
X-CSE-ConnectionGUID: gAZycwuARIGW69qtYPsFQA==
X-CSE-MsgGUID: RxchWhaLSuiWKpz6yMOizQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28985779"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 09:29:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 09:29:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 09:29:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 09:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faDrO3iBNNF5gtplgPXRym1GEkmZItHO7UJ+Qc2u9ki8Bq00KegXxo0/u3CYiIx6zxSruvuxe+Xzvee9EmXRAODxefXRa0qirsch4vUcPs9JKBcR1u063j7a/rY3ji24gyKarGOzVVzgkg3tDK6NgOCY69NaMT7Ah6Dic88Upd9TEuCpPKPOGQMrwCVCKLkcWGEf8Rf6maWFQ/H2NlUz7tR2Av7AWNuyubVauwa9JyMBKGQLYEY1c7/P5GwuQRsHoN0/htuM4nVso0i9LzXSGOB+53onnqW2k4I1uP20KgPTtahnJm0suxC6UWxHm+nJLiKXq0vfsu+UZqud93r3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6e//J2bT8CHd6Tq1OupxqroobemXdHKNOVfEptW2yU=;
 b=lXlSRs9pyf90yVX420HCnRPj9ok/k5i2OpiW++RwsuYEeBMCBSEYU0HO0T+2FYby74HXKlsFYbvaXjdwuLMknNMQiQ5eOVdIWlBVXvR70BPDvoHI03dJgBQxaObAAJp+EID4DTMPGaH5Z7xmtPcoBKsdbURelZSucgcLFuIG38kS9Avsnemim/rVa9uQ3LN0QJytp+MLonVYIEiF4jiQ7Ny3cTxFYvLD1NBCYayrRVdqlHKsfTRP/ZelaG1NVrQnMxU5eE/m/UbDOvHDqtdpvWcMYb9vcq0469hUXpKHe31K7cqmzB0fqyNQ1liJPJe2TAN2S6zBeM2Wrv+cdDst6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8517.namprd11.prod.outlook.com (2603:10b6:610:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 16:29:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 16:29:37 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, David Ahern <dsahern@kernel.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "M, Saeed"
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko
	<jiri@nvidia.com>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: RE: Driver and H/W APIs Workshop at netdevconf
Thread-Topic: Driver and H/W APIs Workshop at netdevconf
Thread-Index: AQHan+/vVxxAI96TCEiHNDT8iuZP/7GLVPaAgAI0UXA=
Date: Wed, 8 May 2024 16:29:37 +0000
Message-ID: <CO1PR11MB5089B46CD3999642B4195F11D6E52@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <ZjnOfQuM2sqv377N@nanopsycho.orion>
In-Reply-To: <ZjnOfQuM2sqv377N@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CH3PR11MB8517:EE_
x-ms-office365-filtering-correlation-id: aeba3f0c-553d-469c-cba0-08dc6f7c0d71
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?9UWPhZBH62vDt4gxzsebe31R8V2MEqZrzs0iF1kUGMHxaTGeBAq5oZTQp4MX?=
 =?us-ascii?Q?DlRCwDx1rraDA7xqnYn64piuy4LH707fzjKbVH9YirizWNXrFBhSHbdxGtSg?=
 =?us-ascii?Q?dXyizmb+4RLaM8vkdS5Yd8JxlAba7DnGyWQgI2bEQX0v+pLTZ2pfh4lhxxKK?=
 =?us-ascii?Q?d8XcmfDM0/ogr/U1B0zuCrUUYYITVnueKCi2lci91J00kDPFqXAn1xHfiUBe?=
 =?us-ascii?Q?g58CWM0/gRKXTRlIrES4z1BON+2u9cmFxshf81ts84fVvz5PO2GzBf5tRPgT?=
 =?us-ascii?Q?g2yNdqvZ66KlH+R2mwOohiC3rCD4v20DB6eEd0yr0UzUpL+xOdATj7k1VReY?=
 =?us-ascii?Q?WhYoosNdahAWr3O9QAnWUA3Y79shz3B2PNp6DlKNtuPYyTY1RwXPBYOVudCa?=
 =?us-ascii?Q?gh2PMqwo0hjXfVFGH8t55JgD3JCt8ZKPkH2zWR6QnOILtb5YuyjSZr/VbINq?=
 =?us-ascii?Q?m+dzv1bYVJZ+c37KVhNTEes2Y2Jox8DH6/3ogvETX9xFA71qD7xjBAIsfcUP?=
 =?us-ascii?Q?u4pLDnlaDLSWO1NAcremudsfES06uzQKDzWHy+ZKTIM1QFcoy90JM74kLdP4?=
 =?us-ascii?Q?z9kR7ELZuN4K2gX7nITOAhYEExL+mCOZGD9TAvfVoC6MSUgcNb5uSu17XqHL?=
 =?us-ascii?Q?lg3I5hKnGjmlBjAScQ5l7cD6WksXiNGoSyiVGgydRAwKaPDKYp3xpYwu+p+e?=
 =?us-ascii?Q?g59DPGdZplPK6k8tXRGbPGwnOGlvachIEXrVhLY9I6s5RBDJUueAYLIn8UCm?=
 =?us-ascii?Q?alM+myW5pPF5LvQ039TeHPkLIsO5q/Yovcverj0pdJsV5fRQHUJzaD4CqXld?=
 =?us-ascii?Q?FqLAC6QCkSqJvqrTOnYzeMukFblIsf5X17lr+yvc9vdUCdA1LcZLx446T5wz?=
 =?us-ascii?Q?ZvoGqAaO8k5VK8AGs/r8FVbAlFh07Hr5tKqyJ2d/8FGhRmIohtlqSFqiYd/i?=
 =?us-ascii?Q?Mw5+XQRzws6/B0dwd0H3NiM9WP+FBhKAxFXc3FJxpGXIQUIVGKHVS0rRpUNE?=
 =?us-ascii?Q?cP12XY6sHl7oLUUc4R6768xjPJfAjVCi/f64icHs/Tok2bih8bksZM3WTn4i?=
 =?us-ascii?Q?e6uLE4vSqPvy6FceQtPgdn5umI5kk+PXsU8/JqFLA8vfZZe5rVZ+P9HpnyS2?=
 =?us-ascii?Q?ofY5HWa1ZyB98K/oWikpc+GmegtjXXpjQyfK+jP2rimarGbWP/wXDqOx4VDK?=
 =?us-ascii?Q?abK6UHcjs5HQx5HIIyfsGQOEEEpawo/cNQWMHDA0f+2nteBPkSlczZnT8XE4?=
 =?us-ascii?Q?VNcH3Jokb5vLA0VEitKcWqS4WN9JkQItcO3I1D0VZdMMOai3QJpfI19/S2k8?=
 =?us-ascii?Q?Jjx6DVIWn+bIvHYbwy2KQZAB/PwWDK4IOyzHPVS6uDptaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0mb5enJbvWmR6kPScjqhlCc8au8Vk4yZuksaQItUktXSRQW5pw3buMlPocJX?=
 =?us-ascii?Q?lKoaBo3lO6YZzboFQAJ81L4fYnvg5cjWI6XcUa8xsNnygILgtjVs88IqycBe?=
 =?us-ascii?Q?ka5ryjZ52AiKnn7Z9fKjMHXt6CRAXyU8O2y7NUR2FOZ4wZIt0gLgd2vWRS7+?=
 =?us-ascii?Q?55bEqw++xxVMabp7JQLWUEbsK9HYjvjx5vaB+q+dPHzRs/GEtusAqBpkSBqI?=
 =?us-ascii?Q?nPjCmmqEYC52elUHty47nyaixVVLiG6idiW5vmjYOwB4zMmZXdJKknR3lWD3?=
 =?us-ascii?Q?WkMBcx2d2+oEPylIn88jwtPATiChJda3s0/RSSIupvMGyRpvuhYTisTjMBEk?=
 =?us-ascii?Q?BxhlbgXnUQy/GRZDt/KxzljtlWTQDJawSDz6D0hPWK7EnWePJbEDQ0Zc+u0n?=
 =?us-ascii?Q?4bKMWTHuhVIt+ayJDxU/0DBkfaJIB5JsSiDKgiX9dhL5ppSqJOqTJmEO0yvA?=
 =?us-ascii?Q?4zS0K/5hAwJSWwhC9i/aD+fT+0Nr+3rxBRAcsTa+YFsH/RsevvUxaTkNPEAr?=
 =?us-ascii?Q?Hiiif3yzahLEckdhsSmvWekkNr5GaxIEkaxZmdETIGMx1Pdvi61R5hhRFNHz?=
 =?us-ascii?Q?tOrWGlCGpQ+3WSxE91ltpchy3nOaE0ElPJWBBIDVFNL3HraMxzeXlMZKjQ5U?=
 =?us-ascii?Q?XJ0q+y+PtyMBNwu7zLo41BBkvAHWRyMzV61inRsiLEw85CD8UcEMUUmdrfbY?=
 =?us-ascii?Q?av6ZKvLrhkCWvVAnEqg2Fw4qaI0ADiBfeW8eMQkBbfGO4mJ4+dkAh3jL2ic0?=
 =?us-ascii?Q?q236YuuwZJqhEIgGNRr1YByt60VZMNYrZSNYOqBKrg0LBgIk6Jw7klMjGjGY?=
 =?us-ascii?Q?lL5Imx61q4nXJuQ9UspN4Dn68o566RiEPyS062gvfzeklkp1TLMEDYFHAHgC?=
 =?us-ascii?Q?2EVg4Dt/EyCDXR3K7ZcQxhnXQ5CgTZukYZ5/KsTQOpa8MJQzSNQY8l46GBrj?=
 =?us-ascii?Q?YsZKtIFj2KQhoAmvZEjh6EhoUfHBQSWE2hjFsOPmjrysBzFW6Q5t2Rq99tQa?=
 =?us-ascii?Q?kph5dfAKj6ueUj1iOr6HbvF8mYDBdS7XBrUu6L1HqzEnbufNX4YG0WcOtA31?=
 =?us-ascii?Q?n+2/bdARjHEkpMle5wMXxloIs53307hm2vecbTqnmi+54ULQb5bNrTM9I/eH?=
 =?us-ascii?Q?LsdWlvJm5D1XwJ0rauhRPlUiu/KfXq/yo1onvVpkR1/KglCuoKGN86XR5/3K?=
 =?us-ascii?Q?x4nGWUeDrhcC6SPOhpSSiPvlgE3Fk+Jm3yXY0Ay1xVAVIaxF++jRRMWZTbix?=
 =?us-ascii?Q?vi7uwHNw0AV04ihurlbXSgPBBOebp4Z4Cn4G6o2RCGyBAgE3IcPeVl0dVkjC?=
 =?us-ascii?Q?O14VQTwOirYfY0nPkHP478xrSfLttmswlOcSoWKsBytcSDI4UfvL/Myp//ne?=
 =?us-ascii?Q?M7n0Zrnm7KH6nUonaJevkBAz9Nd2VLlmXZRite+JY2NEjc9ZUH4Zd3wqTYgr?=
 =?us-ascii?Q?zptwAG//n3TPrYRk2QLlkohEidQNe9gIhzdWjW235wreBoGJOX/N/Wk/ZeXw?=
 =?us-ascii?Q?ND5xhb7/qDj26AgcA/C/GgfTjsBVgwH0o9fz43k66e9QAM2Mcv12hwBSI1x/?=
 =?us-ascii?Q?fat7NF0lyMC7tY7MDJoHXsrVNUU0wPaZuwyMlvzx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba3f0c-553d-469c-cba0-08dc6f7c0d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 16:29:37.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzVALf4nOj6mus5SlHR7LBuApoEo04cnO9wTUf8q8FUWH9329F7kH3zHJwJfOzxjUHcNu99p9J6aeD44oqD9UohMhxUNkwJ3b8/sqjSskN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8517
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Monday, May 6, 2024 11:47 PM
> To: David Ahern <dsahern@kernel.org>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; M, Saeed <saeedm@nvidia.com>; Tariq Touka=
n
> <tariqt@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Andrew Gospodarek
> <andrew.gospodarek@broadcom.com>; michael.chan@broadcom.com;
> netdev@vger.kernel.org; Jiri Pirko <jiri@nvidia.com>; Alexander Duyck
> <alexander.duyck@gmail.com>
> Subject: Re: Driver and H/W APIs Workshop at netdevconf
>=20
> Mon, May 06, 2024 at 09:59:31PM CEST, dsahern@kernel.org wrote:
> >Alex Duyck and I are co-chairing the "Driver and H/W APIs Workshop" at
> >netdevconf in July.
> >
> >The workshop is a forum for discussing issues related to driver
> >development and APIs (user and kernel) for configuring, monitoring and
> >debugging hardware. Discussion will be open to anyone to present, though
> >speakers will need to submit topics ahead of time.
> >
> >Suggested topics based on recent netdev threads include
> >- devlink - extensions, shortcomings, ...
> >- extension to memory pools
> >- new APIs for managing queues
> >- challenges of netdev / IB co-existence (e.g., driven by AI workloads)
> >- fwctl - a proposal for direct firmware access
> >
> >
> >Please let us know if you have a topic that you would like to discuss
> >along with a time estimate.
>=20
> I think that it would be great to discuss multi PF device with shared
> resources and possilibity to represent somehow the multi-PF ASIC itself
> with struct device entity of some sort.
>=20

+1. Jiri and I have been discussing this due to some work related to the ic=
e driver, and it would be helpful to get some discussion to help figure out=
 a good direction to design towards.

>=20
> >
> >Thanks,
> >


