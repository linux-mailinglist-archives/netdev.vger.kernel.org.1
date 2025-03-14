Return-Path: <netdev+bounces-174984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51DA61C9C
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D103819C4228
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAB204F7C;
	Fri, 14 Mar 2025 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu3z5Ry6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3954204582
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983891; cv=fail; b=NPH+vd7LTgqxj9P/cFmyT2nFpB2QT8wVG/QhgFuAnzdpRp3yMsPj6dsVpTLVDSVWIFDJCvV1OlvO8aA2j9xc/K0/Qwoee5Vyx/opRVyVePmOJ/T8JqAGeSPh9B85FQAqFtMcs1CaFwnAzlCwlfx0Y/gRxy+/04dtV4NUNxyPRb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983891; c=relaxed/simple;
	bh=H6gwcQeAeRM46gJG8xsFt1XQ0xLu4s8e0dRkKpdYVYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=okCOfv3laOtxO5qHhhJKza6c3QVaHaF3u4yxuid8pe9d4Ek06iM/l0ddeuPLOjRV9n/DMRYaywcBgQpXkg9B4I2zQLtPfjwu4JsjkFxjxrBKDXAMwfos/wdsffgNz5meepP1rDzHv1GGSxHyBVvzzdPE4AD2yjkjfZWFLSYn7gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu3z5Ry6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741983890; x=1773519890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H6gwcQeAeRM46gJG8xsFt1XQ0xLu4s8e0dRkKpdYVYU=;
  b=Yu3z5Ry6g1dtQX1pFdqwj9qetPaxqFyzqOHifW8YuEroFkhe9hHY6YcC
   GamX3FtbiMXFb+REF7cGPvoIewb/rY6Hz3UBuqthjiIV+4a1HZfITaI/z
   v1Vx9njZuH/5bxOVQsrowp2wb5xEGgfevuMSFNCScyHBoS7iULKPEvmfj
   uswzr5IixNm2xUyU8STBOT/qUK0ZbTMRKXFIZ4aE6FZrGgvcqHxGulB2B
   454FR9K+T7gfN1cp62MknwaXKQcmT8LdK2qdszXy+I72tCrzo8kIrPoRf
   eCpTOVAZhNcLiVPg/w7Kwc2jLNLK8fT6SFlnLYlS3uRXc5UtrD10hOVLJ
   A==;
X-CSE-ConnectionGUID: WTWTHTp4QJmWGJ5QQB5Keg==
X-CSE-MsgGUID: dC6N9GjOSzCLnyNgDNR46A==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43056053"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43056053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:24:50 -0700
X-CSE-ConnectionGUID: 6C5mK9gCQLuaOvOnQOUjpg==
X-CSE-MsgGUID: z9qmYnjOT1C4sSosMjFjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121332727"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 13:24:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 13:24:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 13:24:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 13:24:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc7mUcLP/UDxvnGodWlNTTarX/FytLg6k0Ogjw5/E5ar7ZRux+xYSMkRRt1fX+URuU+fJLZk/N8xRL9RennkLsLbNI21/rh0aahhE6L5floxUZGdYmsc/X0NYksiiZiVsYnsdQ246h/paVteoD3H3r5JA8QVtqThH/H9c1QYxqLXk+wu54cQZqVthCPSdA6d4OBT/AOsL6o0vhuwAMoMuxrsgkjvKN+1QlFoASCWpQP2cK8nREQOGHmZaSTPO/9ppXbjgdrzVnh+BEt0CXn52vHTBXL98rPjC8RouCZJDyQLpJ+vUu1GapKwGXOhituPTVSU3F/NhBU+QuttXNKs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6gwcQeAeRM46gJG8xsFt1XQ0xLu4s8e0dRkKpdYVYU=;
 b=IDD7sSnKPE0yKGlZ87PkaKhaT0j0rmIsWW41EJ/0De7dyIjvM7T6QK5H6Z85lcn9UgYVWcylVnGa10mKfk68hClf3c9DcWRyTijAxtmqfoB8IYfsIgOtwgQhXKiRbc7EuyiiZ2nhgSCWQcMyo/8YluvEA1ckdVfcBd6qdyMwTvZGZohuyLPZr6hHxf2o7SiB5AdrPtPZxV2ockSfd6CZ/31fdVwfUVntc7il+5FLmk0wjkplZM17u+l9PjnROYbBsHOfxBfJhSo29pAwTgCUybVcos3nLinFDZxEHEi6xNBnHFBnMyXIQq5LqcqUGfiBUVYatALvXkC2lrx7rBK5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 20:24:06 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 20:24:06 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Willem de Bruijn
	<willemb@google.com>, Mina Almasry <almasrymina@google.com>
Subject: RE: [Intel-wired-lan] [PATCH v9 iwl-next 06/10] idpf: add PTP clock
 configuration
Thread-Topic: [Intel-wired-lan] [PATCH v9 iwl-next 06/10] idpf: add PTP clock
 configuration
Thread-Index: AQHblENl7HviYRhn5Eanm+c3qvG+cLNzDZ9A
Date: Fri, 14 Mar 2025 20:24:06 +0000
Message-ID: <SJ1PR11MB62978B4C0833163B0EA2FDDC9BD22@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250313180417.2348593-1-milena.olech@intel.com>
 <20250313180417.2348593-7-milena.olech@intel.com>
In-Reply-To: <20250313180417.2348593-7-milena.olech@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SN7PR11MB7468:EE_
x-ms-office365-filtering-correlation-id: ad9f300d-30a9-466a-f3e9-08dd63362baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?jqw9d+LMaIe7XJMew66wViVnK/UvtlQdYhsFwjj5h94Klvc7j0fYcM7sg5ah?=
 =?us-ascii?Q?x0uj6How9NLMZ8O+lPAV2M4z6f+N2M42n05ed890mZfIiqactqn3hBKlQq+K?=
 =?us-ascii?Q?jJO0nKXVyrP+iqQTejhTYJ9pRbJ/TO0IFYs0kdpX8BzSX8ht/OOmDA2NI0NN?=
 =?us-ascii?Q?x+H6aJEbFa2m/OHu5AI7IKLCFtHanHA2QmLsn/4oODoJn7ADXmcoUrdR602G?=
 =?us-ascii?Q?2lOeRbseayVvSoZEO0D8hjmul3O95ifH1pbm8efDOOScicvvLsI0v5tp+dUJ?=
 =?us-ascii?Q?EV0VfRGgCH6VA+LOftZ5QtsJiV7H/i/4dZzRrTJ7HQXZFElWQaG9ac/g7yjZ?=
 =?us-ascii?Q?tZdVYpUaxVvEde11JpY3jPiWNsQTIhVKm5UrCEWWXFrjDWGxBZKA5g64BL4s?=
 =?us-ascii?Q?+zWYTbMuoJaj7U2MaMI4sD4Ml+q9Cl0iK6+4GJkxw4sG181w10/olNqeb6UQ?=
 =?us-ascii?Q?WK5wQwF8NK+H81W++U2RZfUZ1fK6MT7i736J8FJh1pbDjNPjA60kdqKaw+8r?=
 =?us-ascii?Q?8ZGHVBPNAk1+sLhwVPAn3vKNgYy4NmCOcb0JzlrjK5xO+FhWr6rNXJKJlzsg?=
 =?us-ascii?Q?KLNqg2YKu3JMcVaiqrUkHCtnVZCIJ1tIJcPVAGfxLgqXHtW4jOGn8IwUgD80?=
 =?us-ascii?Q?oY/8WX/pXjt3zjLERiiTxMkLzPKyviuPUHB5zbeEiwOs/90auicqzCS+V2CV?=
 =?us-ascii?Q?pc0jYaEEFNrQW6WkmVABLCFw7gbt+eKl2AWs6+zIU5QunIJdZNb53HnddCHW?=
 =?us-ascii?Q?3/9FisnOwVZ8m0oR7yNdTRq1wQnhX4+ZMVn8DqtIOe9YcAEk4jO+YMGYulRF?=
 =?us-ascii?Q?9zYQ7hvTBJc16CN/04aNlJjplwpowhy9Y7IeWX+4wE1QT/jJCG6w1gpNzCcj?=
 =?us-ascii?Q?l+D//HFUYvW+mjfSf8qSRL4Yi4AWUOkVbBT9yYlzWTsBZWbicU95GqQ48pSM?=
 =?us-ascii?Q?+qjP7z6NenonujC+j9BXa33JXgzeId2VF4pqbS/4Y28sGwx84rlgWI4lnwKS?=
 =?us-ascii?Q?NJsxcEvN6p1ee2dr6TnIQwe77kZHkO4IxW6zgl8eF1bjlI80z4HhlnD3tDgs?=
 =?us-ascii?Q?awTd5dzmQyJb+T0hY1iyi2TRgPJXCCvFulsbZJ1INHIeA4VtvlE+DjrIQbTP?=
 =?us-ascii?Q?HReeqPE391TTda+Akv4LDxnZSygY9vmUK+RAM7y7hanFjGWra02D75S2vYPa?=
 =?us-ascii?Q?tJ2/oSeM0sE6KYkXexuX0ESKrltptmCxeRgm8jvwdDlnmc/Rwq146/nDY3PY?=
 =?us-ascii?Q?fhKkUwp4/XlOQPl//psd9TLxO9fkanW6Jmy5vLFiVrTbB55eqN97j2ovcQCz?=
 =?us-ascii?Q?cGmAmJJXnnkclDZKs+DmNKfbJICg8h766NRoNITSjAIg8iK4VctDV9kNiTKU?=
 =?us-ascii?Q?WHzNhWyfUuoeWSRzUYkbKFntaeLYJw6Za28M522UuCUYIibtpMLV5Y/S9Nx5?=
 =?us-ascii?Q?QvLxcdh9W4vQ7ZmtiO3r9ggzFZ0/faAg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G1QMDrHXec/WtBOOr7xj8ujfPqLspTUQUEkv51KiobKHhiUwz6Y+lk/MFxun?=
 =?us-ascii?Q?ebIODwycCUXBtaI4jG/EHeij6Q+ccoFuItOAllB7+msazhFCYRgJhoFJcKKJ?=
 =?us-ascii?Q?OBsYZMW32V5dkP0UFuKYVL+Ii9/9Ft1Qk0DXHlJuDw861HlJh6ItTveKXk/x?=
 =?us-ascii?Q?Nnk++DMenqmt7qNUBF08fT63Col6qLMenDHVeWYIzcdq1IAK0g79JpsadMZm?=
 =?us-ascii?Q?em5VqNk2H9cLcyRnD/0CWKuuRlkyvLm0nCn9cydVweB7uWv3+TRCkly613Bx?=
 =?us-ascii?Q?EcV8QLCod4gyNgjaea10VmDMabSDUOWELPNNogSftwIzjXL/7PazJw/91sUb?=
 =?us-ascii?Q?fZCsyjck8EHWC82e9LZu7n2vVSL65ei0FEg8EucfXLGxJbr8E0+75TWO6bvv?=
 =?us-ascii?Q?Fvgy6DYcrOys0+DJraidfFkGShOlfJzjjNLqcDPEsD9T9DSZKjbVAeJQzkRy?=
 =?us-ascii?Q?cWvehvfSjlQ21XQEp79M2L9EIBPie4zZxkjDjxR4joLsjiZz3Y1wJJJNfpUb?=
 =?us-ascii?Q?D1uWbv95smXnAZjmnZ2OszqFSz1KpF+q8lXTry8E33pBaS9S1ui0otSIsGbA?=
 =?us-ascii?Q?B23NdCoe5jtX4ZA3T5zL4lFK+ZYAhAVCZp3n6e5ONdr49s9U5wwmJ4QjbJar?=
 =?us-ascii?Q?zv4iHCMOozSsaXclkiVVKgaGaF37555ulGnNAEpHiM8cJGhsuEt/OwnVJ92W?=
 =?us-ascii?Q?uKd+UBdeBg6/U3AfLc2PN74aEhHn7/dCx3KXT+plZiaSSH9d284IDTxD+R2N?=
 =?us-ascii?Q?wX59CMnIKSacVRw+KhlG50inDdBixm90XxZBALSdt6LZHQ0cFNRSrxd7CBOJ?=
 =?us-ascii?Q?LQYEGpv+1N8wHKOEqUXiYIwH62UT+viaugyqImRr+BBl4mth8euFo1ID36rD?=
 =?us-ascii?Q?hjlR+3qOPCMNkt6VWcRQWMtLu3xuNqhkalZ2zGT8f04RM/26cDAhL7NjomKT?=
 =?us-ascii?Q?xAafnUinOb/zNi+XCSfvtyze1SU5MOnIM1CY6ovr3YoxoUzaFKHXsG1DKF43?=
 =?us-ascii?Q?7jJ2y4oX3gzKXAS2ZwZ0Jm8MZVMvZm0WYim7MBX8Rve/56H+Hlocaxl5MJps?=
 =?us-ascii?Q?DqVsTurEu9N9ygX+t4WVPyPe/0EhW1A0ezA2kgf6P59A0DNdyzBndN9z3mWB?=
 =?us-ascii?Q?cYrTYozDd9oCwerJEACjVhqareQjDAexXePUPMRYnXoI7MoSTeWt6VGFoIFj?=
 =?us-ascii?Q?ouv1BX2UXshbzaNDKhfRiya0oia3kB1uTsqgSFcBGT2nH7FS3nQwDX8QoKow?=
 =?us-ascii?Q?euLoCpXlS9Rdre41Q6/whfsmbF2CEILHxYxWIwXkDiyWaN5E/fLOzwbv3pnn?=
 =?us-ascii?Q?LtL/iKrHeDYFYiGNOG25s3KRQ9RXpvXl4Ug4hYpM8NeHUSMkZG9AImqpbuJz?=
 =?us-ascii?Q?m6kKx1X2PTBQYOcP325yvV3gxT0jOLyaa1nZ0YXEw2sL2Yie+npt9EXVV8xa?=
 =?us-ascii?Q?efzFTFseGtH8j3cdXmFLLW87dMECfMq8lPdYR+1vPOjKaYjM3Fnsm42Sr42+?=
 =?us-ascii?Q?7ypA26wQLU3AP6dV19QelPYPc17XrtciwNUN5efj0nG1jIjoSKz/1TJ6no/i?=
 =?us-ascii?Q?QHl0N9y5gvKY0hTeWd6bIXnq3+DidH7G4ZnGRRdc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9f300d-30a9-466a-f3e9-08dd63362baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 20:24:06.8220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9FL7XtHvvbA+LdMfBa1mrXf05VK0jHjLhA9WJPTyaWN3JR68LlyIUAmXk97DyXnsBsS8Gx6RVPpKqEydb4BEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Milena Olech
> Sent: Thursday, March 13, 2025 11:04 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Olech, Milena <milena.olech@intel.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Willem de Bruijn
> <willemb@google.com>; Mina Almasry <almasrymina@google.com>
> Subject: [Intel-wired-lan] [PATCH v9 iwl-next 06/10] idpf: add PTP clock
> configuration
>=20
> PTP clock configuration operations - set time, adjust time and adjust
> frequency are required to control the clock and maintain synchronization
> process.
>=20
> Extend get PTP capabilities function to request for the clock adjustments=
 and
> add functions to enable these actions using dedicated virtchnl messages.
>=20
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Tested-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> 2.31.1

Tested-by: Samuel Salin <Samuel.salin@intel.com>

