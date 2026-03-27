Return-Path: <netdev+bounces-272625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDv9AWK/xmnoNwUAu9opvQ
	(envelope-from <netdev+bounces-272625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:33:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E4A348686
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F62D30F26A9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9265378832;
	Fri, 27 Mar 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMkI/Ohh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B6378828;
	Fri, 27 Mar 2026 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631570; cv=fail; b=EawkT1+5bU+0IkRmu2qzqP1CtsEPYgmiof3U7XaV2NAseG/c3NpVVQX5Ms02gkaEKUXTUBET56T1BUOAvTiIz2GYDmCNDjzBYcFKp7e8ayXG8HRYszdX0TVuAoF0XyqH5nZidu+fdCKowieu6MLSsdDY8GzRGRPiKC1zmorRbKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631570; c=relaxed/simple;
	bh=fNAm3YhbGxiIn5K4791FSOiex1fInoJLgYVmMUHhhGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KPQawjhA6UbpY3M3wE1CfYNki+Ck0iFAp/6joElISHr1bc74G2BMJezqNYp33Uox0A+3p+iRGUMYbn9OUtkCsVWD49hiN71sjsu3e18QWr3myBhnW0HbkXxCRth57WvCyuyXQddkImcaN+l9gWRnmvRcJIeDpeQPDizUqJfq1z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMkI/Ohh; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774631570; x=1806167570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fNAm3YhbGxiIn5K4791FSOiex1fInoJLgYVmMUHhhGo=;
  b=JMkI/Ohhigf3c/5tqonATuP+0EiH/V4kko0zKbmjjRIBq53a7tox5RB4
   GSUTfyiFNZhkan/xvSMxTv3EU7tnOSbM/iwmuhWpTqZy5Rre/k73kqHMv
   vNEqY0MDKWr7g6xlBJibLTeqjtwOIGWVlhL5p+Dag82Y0Yew/iSaTHyFw
   MhYPVM6KMSaH4NXxgdI5eem/buOua05BdQwNJ3LpYNQs+GLVb4r47Iidb
   VNCz98b9Q6WQT8e/wmVCllOBc1il3QrAA0NtIyW11ymSl4139SwwsiDKD
   bdtTmAhsZR1Hv044QogUufTD5k4W0wjyINlKW9LQ+Zmtvvy0IpFCgEqBL
   w==;
X-CSE-ConnectionGUID: 9bkf8QgUSEe5X7hHOCxzJQ==
X-CSE-MsgGUID: 7O8MG5WtSnqV5AgKp+wTpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75677027"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75677027"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:12:48 -0700
X-CSE-ConnectionGUID: EKKldqKASke+drBANfTYaw==
X-CSE-MsgGUID: P7h0h26gQcOqwHhAugMeUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="225386782"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:12:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 10:12:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 10:12:47 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 10:12:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTH3zYfHnCMHTjafzcmqwxBmYVAKbVfNFh+nF5tPK4XCKD2oF1yZDG4y9NzKphviKh8S02nB/j8qwJqJi3bGAEvrSigum77VdUuNNOVeDrme0ZBcNwXMZI/hKcvWtZYJYtkXgVf5BSXjSyzDL9B4VeYkYZgihDz7EL7Lz6x4DkmqnSmr6wRHmq61nJyyoOBOdk3ZT6uTOPWOkRpVgWZe2Qrnb63UE172o+9xo27gd09DrqKHAlB6xP83UunVMz7M9QnAq1AgwekuyOcNhXEm7jMwIAXrM5fCX2xHuPU//I7rjnRRzM8NLH+0+WqW1GU5Na1DNF5mUZc5I7JZDlEV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKj4un/lvDgUJcNW/U6RJDqqmmA/ujh90hMcfpjL63k=;
 b=WBE3thYTupLnHcN6NZIH8lLIcjbYxlksMMJXfEEIBzvzZHbl3FlA1STm+hnOBMUjaKToGPEZvHnf7ga9RcVB4kJ7LIkxSikCPi+gYf+2pGWwG9e3uXymjyx/hvoYE+pwdUiikmI0Qb4c+lobdD7YJ0PdaK62M2A+SBy7k27tXjWt9yC6PTX4mbDisZtqMALlzx4kVENozbJn7TMSQ4pyJ1uXjlqX3prKGQc91oEeiXKtLYE+1QJF1H6aUlqEfZZT/IeF/zNmJjGkORWp7b6Rcl+2QpfHllIXSjveT2uHTWQpOk3tn70dTrBCjI7E4CEe2YwmWwC7AyasZSaxTPMXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 17:12:40 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Fri, 27 Mar 2026
 17:12:40 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v4 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Topic: [Intel-wired-lan] [PATCH v4 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Index: AQHcvT5IeTGOkRvw4Uycl9iBx0X66LXCnG0Q
Date: Fri, 27 Mar 2026 17:12:40 +0000
Message-ID: <IA3PR11MB8986A25079EA6C95E701DCDBE557A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260326162832.3135857-1-grzegorz.nitka@intel.com>
 <20260326162832.3135857-7-grzegorz.nitka@intel.com>
In-Reply-To: <20260326162832.3135857-7-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB7498:EE_
x-ms-office365-filtering-correlation-id: 7c99f656-9c08-46ed-cd93-08de8c240d7e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: uEhdCGDiizq93ja8v50Ar7y3UYuXz/PsFqEMGylKOEaLoexknJ+/gx60MPpq57r6XqLuV+38/cKo1gRuAxdqzfi810E5it1WJ7R6CkWkoxJPLZKR0O0DT09+1Wo7MBqlyeLWlqavI0DO3aNfMyhuAwFEbHofcmNeaoUtbDfCZi2fcGY0MY2PpUMJ37EUj+dU7L2S4axFTaYX91YfMSEMQ565fr9ybt7IHhDuP6MfjP+FIT2mTIsDeyXQHLw7FhS28Mw5MDXRog4iEIfoIpdzE07AI+l3vIhO8WkPVPJ6K2dP8LkPNrrN+IbvK8ll78IgO4nUxayL40xvQEmXlwsywexP9X6k9mdEEfGZQI9WMJKtAZRLxAKhDaODfFT5ZU/XDhZqtyfIUry1JQfeG8jP53g+pZWKPQttqs7nQNwClAWdRb4ZwmjKHWFQQtPrSmvjuoW4v9lWt2Hn0j0Q47HjZ0h38eXlUyCW0yv98u+r4Q5qKlUyrBcaJ0aDsXADXbUaz+KI4EbLNW5EIyclGtF5kbzdzN+yz0ImmJ+cymFdVfM/013sx2YHK8wWMxU4OnLi1FtTQHrQ0MAn/Y+acixmy8KDaMFwM5HxmzlxaJvBn9npPAn7kjY6OkwgtL9Pp9qtcjTlAvVXi+kuGt0A40pCBDLZbUIkdF9HnN9/LZSbNno1V+HNhiAemtK+LXuZ2fvHx0detGLXEg1Wv8k9SOUj+Elb+caYQQjIFXOdQ2AcY68N+0lWrZBulLuwm+x0KNDvEZAb6P+fzOpRM+C9PigIHW3VHQngTBBBWY+eAppLFuo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XbKYThe8ahOS5LdVyfpFV4wrRjg5lY/EBf4MU0PrcL66/KRTwsbBxkdtrMNW?=
 =?us-ascii?Q?QamGugqZmKrkn8A+UR7UA8+GaFd+7wlee7j5s6vC7vYwvlc9FAK6kBN4w44O?=
 =?us-ascii?Q?Ji6iU7xUdLlqVBmZlcwMw58capN9W9Xqq1cTna+xATM/y3TntidyttbHbY9j?=
 =?us-ascii?Q?NFA1Ra0oH1hpGCGMLWn0EieYRbha48f5/RGsHGQ5IKj8ZE452D0xEqb723IB?=
 =?us-ascii?Q?nus9rbGnbH7AX85A7h0qCLKA6zCk9Bts4fo7wiBOtzD0hhgnXcaQO46AWJiZ?=
 =?us-ascii?Q?1kUf57FFmN7ZxBFTdxnxokcoC1U7HFnFfly3YM/E8nWIl8exr2PbqA9eEpBp?=
 =?us-ascii?Q?8GPtNSnTODPikSSRQoP66dmGfhBjwnm2aNUC92wIrsL/tB+qUW9OjLA3cexk?=
 =?us-ascii?Q?mSQGcBajMaYtqN6zMcc3KQxI4nDBDzfZcmQA/TAP4ZUkFDeFjBRsY/UJcy3U?=
 =?us-ascii?Q?1MfF2/x9sRyN8kGLxbzJvpP1FlNMM2YW0kmxbc0wPsC5xx58zOyFHGKmpbVb?=
 =?us-ascii?Q?Eg2nAVPrZa5xFq/s86c6wUUcJq9EblZfGE40XokVzvBZZnx2xU0bbE7j/wT5?=
 =?us-ascii?Q?nRWgZh2vw7uK+EKBHNMltdZ67RnavHL1HzB1UdIKEtGPF+ymkK2w5F44vogO?=
 =?us-ascii?Q?nRKIP6YKuqJR+l8Dece0fEm68+kfgtja5kqryDH+Y8TM6dJfD2af+68TOPlP?=
 =?us-ascii?Q?y3zJRHYcSCLPcBJPqW8HaRMxoI4brlHjVmDA6+ojw8jiKUwP8GIrHQvg5Wbo?=
 =?us-ascii?Q?gygBqTcxaw8/gyNkxjKP20SZhXIYISIBloT+i/HUebX9nQFKS15TlD8Mrx9A?=
 =?us-ascii?Q?ZEgBqq4om4m7XnXiFpw6HXeFgOBgyqWE3z9vIr8mCJUnzFBxOXtUEK/1Z/lX?=
 =?us-ascii?Q?fL/sQjA54+YUD7g0wYsfomkjOD+p/+47gSFVkenHBQ34qav93ZKRlWtHgCko?=
 =?us-ascii?Q?UlyoN17yY2v8WwI6f/3y/NW/4e3xBuv2pwxR3hPA9e8ho9gu5Jy+m5ATavnj?=
 =?us-ascii?Q?8dGB7kFrhh/4EVvO1hRPzfGQZr5ra2WArEIo2YWgZmkR5KcWjKNmCUaec6KL?=
 =?us-ascii?Q?JdSbp+BXlcF+hbMgqgRn8WS8EAITY+4J1v81n5M/hBuD91NHFTbqzU4RiTZv?=
 =?us-ascii?Q?vSHCNaazPpcXs/VbJdtnGTNBTYYV+6+xs/oB7/g4B+oncsAF4a4H+MP+6nUx?=
 =?us-ascii?Q?qd+CdoK/RUT6Hs45UtYAOPXf6OALISgD+aisxjAHuZjLwl9WDG9AJpuSRn5h?=
 =?us-ascii?Q?/kJXtZAHRIxJSsP+nD0o2oDuuT62S30ppMYD4jVViKnlgNjbbtYDLGgDpnVd?=
 =?us-ascii?Q?u8szw6kQ1Yx315aouicuquAhCTb4UWL8OrbhkzTd1isA3OBCyeTlXhcf189h?=
 =?us-ascii?Q?5Bd0d0L0skJQcJI64mMT2X389DbFg3oj+1ujWvgMJdGj2sin+gIMAtzj0NSj?=
 =?us-ascii?Q?MbspqB4h5BrcuOC79NuMNdWCRBLVLSCGpQ1IS4H/2CnoT9m4phBFICPjGVO/?=
 =?us-ascii?Q?u2baQgz5CfoQNT+8pSt1QymwXMpFvBn7XS0pe//3iAZGB3w/KTMZ79tXOsR6?=
 =?us-ascii?Q?z+uYeswiOL4ZawFtFAXSqdxVCcOyU/1xltLZdKV7uqzOsuwkEOdtb6wCODH0?=
 =?us-ascii?Q?UzJ3xJ9d/ju4ht3/OZqd7pNaSA1MboDs8//TYeGpTDO2XOrduAxBdOJk5tPz?=
 =?us-ascii?Q?ttlgZYY7EWYCbTTQhH/urtiLnGB17va9urvEJV4gaoHj+JVL48Xm0ZKJppJz?=
 =?us-ascii?Q?EAkqEtOYRY0840hExix3Ws6+0Qnrfig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RY38GIq7qzYqK5JVz+v0fNBR8Qn5Ph5x7fzPXVYuKdGRu2iadvFW6cjPReRNGt0U8JyWSV8I0XNvBrj+zyMApgI90KgqsNtJElPWXTWuPe2zvu5oAG3Iz/8NnNqkd+Ve5Grm8e1B+Sh6bpOlOZC6iKsuL8QcTvSlGZhyLAcFOrk/MA+58NwH4pBdlgfHp98CzNswDZNpmI/iexK7cn8Me/2ewYViag8iIzLufuE55TXmH2VjLllZPOYNAW/qsztShbfuuaLDYjvocIUBSMpTCzUQZwOi5Z4T/UwgracdC59XGYKSkHMr4Ys/qXFrFhm4mgJUnEkuyKdJnR6NmKxitA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c99f656-9c08-46ed-cd93-08de8c240d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 17:12:40.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6yhb3sGk/cDtvi1vA7BIZLuI3JjABVoyu7dhIoOQmRsU5Tav5V2H0mqB/h7VEABytfAH+sO81nXAv8h84mCL6Ke4Ty4VNSrYOxq53Mb0BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272625-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D3E4A348686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Thursday, March 26, 2026 5:29 PM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v4 net-next 6/8] ice: implement
> CPI support for E825C
>=20
> Add full CPI (Converged PHY Interface) command handling required for
> E825C devices. The CPI interface allows the driver to interact with
> PHY-side control logic through the LM/PHY command registers,
> including enabling/disabling/selection of PHY reference clock.
>=20
> This patch introduces:
>  - a new CPI subsystem (ice_cpi.c / ice_cpi.h) implementing the CPI
>    request/acknowledge state machine, including REQ/ACK protocol,
>    command execution, and response handling
>  - helper functions for reading/writing PHY registers over Sideband
>    Queue
>  - CPI command execution API (ice_cpi_exec) and a helper for
> enabling or
>    disabling Tx reference clocks (CPI 0xF1 opcode 'Config PHY
> clocking')
>  - addition of the non-posted write opcode (wr_np) to SBQ
>  - Makefile integration to build CPI support together with the PTP
> stack
>=20
> This provides the infrastructure necessary to support PHY-side
> configuration flows on E825C and is required for advanced link
> control and Tx reference clock management.
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_cpi.c     | 347
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_cpi.h     |  69 ++++
>  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |   5 +-
>  4 files changed, 420 insertions(+), 3 deletions(-)  create mode
> 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 5b2c666496e7..38db476ab2ec 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=3D	\
>  	ice_vf_mbx.o		\
>  	ice_vf_vsi_vlan_ops.o	\
>  	ice_vf_lib.o

...

> +
> +union cpi_reg_phy_cmd_data {
> +	struct {
> +		u16 data;
> +		u16 opcode : 8;
> +		u16 portlane : 3;
> +		u16 reserved_13_11: 3;
> +		u16 error : 1;
> +		u16 ack : 1;
> +	} __packed field;
> +	u32 val;
> +};
Why not use FIELD_GET()/FIELD_PREP() with GENMASK()? Bitfields are compiled=
 differently on LE nd BE CPUs.

> +
> +union cpi_reg_lm_cmd_data {
> +	struct {
> +		u16 data;
> +		u16 opcode : 8;
> +		u16 portlane : 3;
> +		u16 reserved_12_11: 2;
> +		u16 get_set : 1;
> +		u16 cpi_reset : 1;
> +		u16 cpi_req : 1;
> +	} __packed field;
> +	u32 val;
> +};
Why not use FIELD_GET()/FIELD_PREP() with GENMASK()? Bitfields are compiled=
 differently on LE nd BE CPUs.


...

>=20
>  #define ICE_SBQ_MSG_FLAGS	0x40
> --
> 2.39.3


