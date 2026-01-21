Return-Path: <netdev+bounces-251788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHHSAvV9cGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:19:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA40D52B87
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F54438769E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64384611D9;
	Wed, 21 Jan 2026 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gnn6Fq59"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42744426EC5;
	Wed, 21 Jan 2026 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979948; cv=fail; b=sZAZfJ0ZWHDI+oYpZ3SdIDwb8cEJJOm2feC+4qKmFx9AwRKbo2isPdUNbfKhxWH/IRFjBScHEVeSahvLGodhexkp7uUm3BIkvBWXWJKKyLplhklRE82/I66mZaAjdQpBmMZEOLHQZ6W/0PneaFaW28PFqlnbtYvRLWCpz78G7s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979948; c=relaxed/simple;
	bh=5fiSxRbjvSjqtXYMcvIIzD7+F324/9bC8hAk9Zaf3xE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZZtcJtZcqWJSt4DX4Gv2vWgJpL2jwNISubWCDwWH9PP66cKmNwz6KxbvJXtb+AzYWbR+8JvnulJtE7cNrLFdVbzwgTemz9JigImOZ5PQsTA2nxmtXFPR6iZAB6pVfRBYZ95wiB+6zLkJY3rntMSdlBxQodtwx+d7gUhqwnVItw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gnn6Fq59; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768979940; x=1800515940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5fiSxRbjvSjqtXYMcvIIzD7+F324/9bC8hAk9Zaf3xE=;
  b=Gnn6Fq59vbc3svI3diSkcviuGmRA1A9p3mhXIsGFpH+zeDoa3YuJO1xq
   mAxknlWtLda10DZUod+3Uq4hxyBSjLWBOuYWwYaT+CUhYXrhATmmL0bKJ
   /7mYnaKCSPD9hjSH3kA5FChReWRGb4gIDkzvxodBtz5A8153Lg8RRv0q8
   3/oZIuFbwrbWdQpOZOqfwMMC7oV5KdK/o/aH2tTaRZsIvSWD3FCxNI3f5
   hZ5pllKQe51xXqpOw/UJXldPhXp28UJ5SjBuUBuoqAv9xCZZ4UqoDkPsf
   kf/CqKAOyrvmFhfFMWrGcovWxAABguXWUK9S6JXWGcztPIeF556AYky6r
   g==;
X-CSE-ConnectionGUID: HiVD15tAR76tmSsKCe1QaQ==
X-CSE-MsgGUID: 1lLWMPOHS5yfc/QkiRhBNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69220446"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69220446"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:18:56 -0800
X-CSE-ConnectionGUID: gPc3JwJzTsiQK04F0ynypQ==
X-CSE-MsgGUID: i3df66fmT8ee4aXGjl7D0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210877019"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:18:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 23:18:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 23:18:55 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 23:18:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5f0ncpn3uP5dUdynkIP3FUu/VIDoY01VW4uRuSct7m4DZyMH5pr1Tvf7JHEuK2sZzpUK6eSpEuy3AhqYYO6EBaNS9D8IXcg2RGmCBNP/jW+UzBDdC5YF4Ho7dOSEB4XOG0NDnY8eShy9HVWUufQEmB0DhGXoq8nFt2F7gaZPMbMuUlMnwR1ekPcEAoAMV9YNb6s1WPU8ixv9TFKT3CdTzAcVujovl191rb/9ONjIoP67wPHnAqivpZWyX+SyJ8p0mnr/+4nJ/RbPVlWKDxyhMRHle2txmhMbaiTn5Qmk5tf7hCmx5JR3elsWhFdU2408rRk4Qjc5smLImOeFglCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fiSxRbjvSjqtXYMcvIIzD7+F324/9bC8hAk9Zaf3xE=;
 b=MVjDoZsh3m55Djgh9u9Vr0hlA+P3viWG277pgUMp4Lv92QPdCwJoic+WNWVHZ6U5tmnF1h01Tt75OKKCP9ZZpqSo3hOqwnRRITnmQaQqPs+X/6aXApfMmHnLP7jwl7r9Eu7pkgE/cxkPaQKOcEyVjoS+CovY+X7fE2we0rmsCgaSwFX4+cQHOjg6VxyXfb18PKgfObncJyM8ohEAKaNI6bVmBDM3kaBsbycQnSVPKcAl4knFQNCVSsxEFx9GKmSYp5gZ+Cau29D9Thzzd//kQVe88En+f4/x/jxLZmLC9dOvEv1leB+FRs0gcXEV5l4X6FOLL163qLQjdsU1RWxCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 07:18:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 07:18:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next] ice: fix system hang on `ethtool -L`
Thread-Topic: [PATCH iwl-next] ice: fix system hang on `ethtool -L`
Thread-Index: AQHcijM5pW/fzrEjnk+Pyy7RcFnXw7VcNs8Q
Date: Wed, 21 Jan 2026 07:18:47 +0000
Message-ID: <IA3PR11MB89860B4F0CF5B396C86747D2E596A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
 <20251204155133.2437621-4-aleksander.lobakin@intel.com>
 <c507379f-07a9-44fe-9679-277d618c0e04@intel.com>
 <20260120173405.82147-1-aleksander.lobakin@intel.com>
In-Reply-To: <20260120173405.82147-1-aleksander.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB7666:EE_
x-ms-office365-filtering-correlation-id: 2f4a652d-7334-4b14-ac27-08de58bd519d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MTRsMXFqREZJekxlOU1HTmdlRThOSm1yTDV4WFdGcVFRL0dqNVEvZGhab0hV?=
 =?utf-8?B?U0dpNEFKcDVlUi95TkxWSURHcDVpMklxcm9BcmFqSmwxVmt5QUxhZFpGWkZJ?=
 =?utf-8?B?SUtOUzluMDdJcSs1UnQzRVgxZzhUek51YlpwVjF3R3hldGs5a3lYTXFvVUx0?=
 =?utf-8?B?WnQvYlZTQ3pUcDQzTFN2MUVGakIzNnVVaFB1YzZHVkx6dVNBME9Cc1JHSVFS?=
 =?utf-8?B?VFlmc0doV01Yd3IxaG8rMFMzZlBxdldZYS9LS3BHWXY3dTI0ZFBrWVo4elZa?=
 =?utf-8?B?STFVUmlBTzdQMkdBRUZqcEtrS1RWRGRQUXhEYmZocVhTaENVU1paWFNlbit4?=
 =?utf-8?B?Y0VPT3Q3R0czN3czdEQyNUVWWkxKMmVmelM1SEFlQjM4UWpvdFNrM05IT1E4?=
 =?utf-8?B?T2dmdXRSZDU2SkJlR3NjUnllK0pBc00yekcvT0Nib3JWNTdVM1ZWYTAwdjgr?=
 =?utf-8?B?QS8zNDh5aE1VcEhERDBNT2c1UTZkb1llZ1VFVXZuRGh6N1RGeEFKRDgzNVox?=
 =?utf-8?B?Z2FZWWROVHFWaDA2T3lIRGUyODIrNXJTV0VDcklxUnE4blgxbHNFaUJhRVJF?=
 =?utf-8?B?QkdpYUMxZXFibnRtYy9QNWpsZFFMUTdhakxOcUtHYk9VZkhtM1dzakNoc0xU?=
 =?utf-8?B?Vkt3d0d3NXhLWHQ1aFlIWjB5c3M0d08rNjlITWRxOFJGYmlZbFRoQm1NQnkv?=
 =?utf-8?B?bk5KRm0xSG9zelJXREdsbytPdGwwZGJqQjJUdDlyekpDNjN4UUdOUFRuTkZO?=
 =?utf-8?B?YmJQaCtpdUFhRVBZSmY3K3E2cWF0ME8yQ2hQR2JUckk5N0Rwd1pQQ0ZRVnMw?=
 =?utf-8?B?UVlLa3Bid1g1aVFSRi9nYmJaUWFFVTNRODBsTXljTXJKc0t2L3E5WDZMNm16?=
 =?utf-8?B?V0tmY2Uwa1ZLeXlHK0NKNk1qc01mdHljNE4wdHZaRWU2NEJOWnAwS1BCbkJW?=
 =?utf-8?B?ZmpZWStaM2JMVmNvQlYxUUhuaWpTS2U4QWVYQ0NocmNDTDJiK0VzWDBOdTBk?=
 =?utf-8?B?ZHg0V2pvYnRtdE1HYkRWT0VjbGhmVmlaak5UTldDSVZhV1NaTkZtQnN6LzZB?=
 =?utf-8?B?dllqb09aRkRaL1JJQlhtUkJZd2VBNkpoUHdoaml6QXJXK2dFdGd6RnhRcUlS?=
 =?utf-8?B?U3BSMnRWZGtPS1M1ejE0NkpPOUhVRXBINEJLazYwQWZPOGV3MUsyM2VBYUFF?=
 =?utf-8?B?aGFBRldrUkkyMFhnQW9SVWFyYWJWSnVDcDJNMnFuMUdVZThWY1M3OS9mbWM1?=
 =?utf-8?B?M2p1TlFONU9UQkk3REJFTkoxZTUyZERBUEhHZ0FzM29LcFdTem1sMUNiUERD?=
 =?utf-8?B?a25SbG1oUUM5N3E4RGRVQXlNeE5yckhnemVTK3JZVi9RZWQ1cGdQbytlemZ0?=
 =?utf-8?B?OEtJSWJKV1VRQTc2Q2VScC90YThIZjlyOCsvK0FralVRczQ2enNzd3ZTYlhT?=
 =?utf-8?B?Tzhyc1JESVBCYVN5WnhEYnVYZFNhNFpCM0pXOVk2blNhK3IzQVpiUzhWbTdB?=
 =?utf-8?B?VnI5a0NFU0dhaUNicU04MVBFTkpoa2dLWlk4T3BvOVJROFlZZUJScHlKcVJE?=
 =?utf-8?B?ZWIxemZKUUdjdWI2L2dCZEpyNjQzQjJRb2tsRnJzL0NuVTE2cVo0UGR4TEk1?=
 =?utf-8?B?Zm1MSE0vMDFaTDNRTXJsNVgvOW9UQ2g4WGpxUFJUazhLOEdvRndLWmxPbDZD?=
 =?utf-8?B?djNxbEtwcWlpai91eVpjaTRhOHVJekJaSStPckdGaVFkaFJGRE5ITTJwcmEr?=
 =?utf-8?B?ejRpZnV4ZHJvL01ncEE2cmVPSTZKRlR2SHl6bmpUbVgvUWVnUlFwVDFFSnhz?=
 =?utf-8?B?dmlta3RQU21veE1vOEUwV1k4aUM3SUxHa000OHc1djZ2aEFXaUs0dmtmd3dy?=
 =?utf-8?B?QndqSzRpVUdlYnpLbWhQaUlXNE5SYUQwZnQzQ2ZWV1Q3QisxcGptd0JZR0JJ?=
 =?utf-8?B?OE5XWnRBeTZ2WWYxWkRTREJKYnN5YmpJZ3k5Mm1XQVJVVnZ6cE1oQm9RKzFz?=
 =?utf-8?B?WXBHYTV4TENBNkp3VEhXUHkyMG5vdEU1Wjl2R3RuR0QwZHlqaVAyYzM0dzFO?=
 =?utf-8?B?T3pzZzBIcXdLWkZXUm9yaGZZVTQ3RmZtcG96L2JiZXV2SWF0YnExUWtRbVJK?=
 =?utf-8?B?elN6S3JyblBTNGVpUlI0QjNCN1B3ditOWE9NK0N0dXo2M0syeDZYSXlkTVUy?=
 =?utf-8?Q?ApzLYXiSN2Zs6RXY6sTeWmE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEI1L3lUb2srREo1UGxGWVpiWTAyRUhibHNoMTYrRkhJVE1Zd0ZGMDFlVG4y?=
 =?utf-8?B?S3N2MU1KbUlTM0UyMVluOHo3QXlSMFJPbjhScjJDN01QNDk4RkQ5cDRXa21R?=
 =?utf-8?B?TUVld0JFZWVERSswM1pFS3JvT29IdTR5aFNLcXNMUEhVekY5VTRacGtwZjVJ?=
 =?utf-8?B?dVdYWFpvZzVxS1NBRldsL1ZlWWZiZ3NRS3I3VFF1eXAvc29jTHBmUkZNTXY1?=
 =?utf-8?B?dFdRSUhKdm8rdzZHSjdlNWE3YS9rMUQ4eWNRZ0tHb2pVd0Rqdy9FbUlDZUtL?=
 =?utf-8?B?STloWTZ2OHljd3BUTDBWVUxBYy80M3RwSFU3VW5CWVZROEhCTmRROTFJMHhZ?=
 =?utf-8?B?QVdTZitXMDJrdmhtSTVVMnpNa3k0dURVS3JPOE14aUtGRlJRWDRYTFJwKzJn?=
 =?utf-8?B?cTZJbUJoT3VycUhTMUtodEkwK3pGNTZTRVM2bldsVnFLVkJ5REphN0pudXQw?=
 =?utf-8?B?dncxQk5GRS9rVEp0Y29Pb0JZNnZ1cDZ1TGVDbmVBN2tMSTdQck5QMUNDeU84?=
 =?utf-8?B?TDVvZ2h0a2JBbkR3Z3RnMTJzMGxadTR0Y1Q5b3NaODdXK1BwRUlsVTgvMFJ6?=
 =?utf-8?B?bXh3NWpweUxiRzRzdzMvQ1pJalRGdVdaek03Ty9oUWZ4dFdxZkxhNVQ4VERM?=
 =?utf-8?B?aGxUeWpmSGhEQWV4bENOSEEydS9aNzN3ZnJHeDV4ejIxK1NRUjVtNmZMWEF2?=
 =?utf-8?B?Y09NNm9LcS9NMDRtNk9HQ1hzUXdJSkExUkRQNE11MGpBYWswTWgrTGUrQ0FW?=
 =?utf-8?B?enRadmVhdHAveU00ZlpXTG9BVk9BQkIwTEJKb3pGc2ZwWW5kM2picmI5RE4v?=
 =?utf-8?B?dXlYcjJwQjRqdy9lTmFoZHRXNlF3VmVDRGxWMXg4VXMvL3FycDA5N25RRWhB?=
 =?utf-8?B?cWJPZEhkalp1UXFTbW5ZUXRpbXhiaE1peWNsZzZNOGdOSHpQQ1paaTNzREtn?=
 =?utf-8?B?N1NBVWVrc0sySGZVNWRUdStURFFRQ0t3bG5RSE1Mb2s5RmhoN3RLMFR0L1lq?=
 =?utf-8?B?SEJ5YTF1MEFzcFl0dUw2R0pwZEE4LytBdVUraXFZZE1xVm8rTWRwMTNqNFlX?=
 =?utf-8?B?aHBSL0RicTREcXNwajNaYndHdFRCZDFCY1pRVUEwK2xmd1hQRDFGN0dEY3lm?=
 =?utf-8?B?NVBvNk4zSnl0SEhaTDNxcFBsRmpJak5Ic2tjOEFNaFVvZk5kY0xTbFp3Uy9E?=
 =?utf-8?B?SUx3czVzQ04rbjlPUno3bDhVL3oyQytpdzI5Yk5Sc0drN1NEUXlLeExPYXB5?=
 =?utf-8?B?YXVFb2lvWVU4azVIaVYrdi9TNytLNGRaYVN2cTNkQXpWK2hxTFFnL1dkVDV5?=
 =?utf-8?B?WStKZEhBYjBtbWlBaVVIbkFkY2Vqa25aTVRtVEJmdjhlSmJyamk5Ly8vZTNP?=
 =?utf-8?B?MEhsejg4VFJ4WGIzenV0UlI5Rzcvay9BbjVjZCtBS2UwZmJvZU5OTENTaHRJ?=
 =?utf-8?B?ZFppNGM2dzd1VVNXbHhkTlFMaTRVekJ6czVEdDdIQzNFUmFQUzVRZk5pMVVt?=
 =?utf-8?B?Wm1MRU1oODhLM1RBMVRJR2YzbHFabTdSZTV2U01ybjVKcGVUSHpQOFJ1Lzky?=
 =?utf-8?B?Zm0wMjh6akMxUDU1eHRNR3krRVc4VHpXZktJRkxXM2pMK0FPUWkrR2VOcGNL?=
 =?utf-8?B?eVZhSTJpUXVSdnA3RFBhWFJoMXFBb0FNWTNGUmF2NlpjYnFXY1hBR05pQjNE?=
 =?utf-8?B?SlhoSHJMQjdnekw4RGNPTnVTWHlaVnNOaTBDMzh5b0R6NUt2OHl3TjZZZk1m?=
 =?utf-8?B?SHVrejVlTlNWVlhnWnY2YjRzTGJVRytvaVZubUoraU9LSVlld2pFbVY5UHZ2?=
 =?utf-8?B?OGpxZ3FBVzNrL25KRTVka0h1MkVZU0JpbXgwVUhXWE9GbnF3eWd0UWZycUN3?=
 =?utf-8?B?bTVWK0JhZGpJSkxwUkxlak1NcVYxVTRTZWJ4REZPakJqdWhESjFqcE43ckFS?=
 =?utf-8?B?ayt2d2J2Y3IxTXVlOC81YTFMRzBCMHFZUVgvTWVqMk5vV0VKSTBzY3BNb2Rl?=
 =?utf-8?B?ME5ybkNoLzRFSDN0Y04waEc3Njh4ZHkrcTUzdEc0anBGYTZRUXhkTVU5Rmpx?=
 =?utf-8?B?VGdpUS9QUGdaRTljMmNiUmFLMVpucE5Za3Q0UFJuKy9lc2V5eHY4UExwZXFo?=
 =?utf-8?B?Y1JYczA3Q3ArOVhRQmFmNzdIY2VHeDdYNGxyZ1czTzNBUVpLcmtqMGpUK2pu?=
 =?utf-8?B?RlEyUmN2ZUptUVRRNjU4c2FsOUVGK1gxckE3VUZIbHFZSmJOaVRQeXlLUTNT?=
 =?utf-8?B?SHNSNDFWbFhqSjJBNXdxSm42TFFXWFFaeFZDeTNjNVRrWjAvbG43OTlRZkZX?=
 =?utf-8?B?a08vRm9ucDloQVpQdW1WK00rREhMSnpWcUZnMEpxVEVGTldMcW45WWswcERH?=
 =?utf-8?Q?G0SGgGcxCIgS6esQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4a652d-7334-4b14-ac27-08de58bd519d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 07:18:47.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mks3TSHGnKZLsQXGdhqagcmB5LjvScaFK45ekfxSpf0gjqCYzPQB9m4t5JyTxstD0vbDFzFLcuw2lgOaa2rOCH8+vO52XNgvGLfcIj2drtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lunn.ch:email,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BA40D52B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9iYWtpbiwgQWxla3Nh
bmRlciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSmFu
dWFyeSAyMCwgMjAyNiA2OjM0IFBNDQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5s
Lm5ndXllbkBpbnRlbC5jb20+OyBpbnRlbC13aXJlZC0NCj4gbGFuQGxpc3RzLm9zdW9zbC5vcmcN
Cj4gQ2M6IExvYmFraW4sIEFsZWtzYW5kZXIgPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+
OyBLaXRzemVsLA0KPiBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsg
QW5kcmV3IEx1bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxlciA8
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNv
bT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBLZWxsZXIs
DQo+IEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3Nh
bmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IE5YTkUgQ05TRSBPU0RUIElU
UCBVcHN0cmVhbWluZw0KPiA8bnhuZS5jbnNlLm9zZHQuaXRwLnVwc3RyZWFtaW5nQGludGVsLmNv
bT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXh0XSBpY2U6IGZpeCBzeXN0ZW0gaGFuZyBvbiBg
ZXRodG9vbCAtTGANCj4gDQo+IGljZV9zZXRfY2hhbm5lbHMoKSBjYWxscyBpY2VfdnNpX3JlYnVp
bGQoKSB1bmRlciB0aGUgbmV0ZGV2IGxvY2sNCj4gdGFrZW4sIGJ1dCBpY2VfdnNpX3JlYnVpbGQo
KSBjYWxscyBuZXRpZl9uYXBpX3thZGQsZGVsfSgpIHdoaWNoIHRha2UNCj4gdGhlIHNhbWUgbG9j
ay4NCj4gQWRkIGljZV92c2lfcmVidWlsZF9sb2NrZWQoKSB3aGljaCB1c2VzIHRoZSBfbG9ja2Vk
IGNvdW50ZXJwYXJ0cyBvZg0KPiB0aGVzZSBmdW5jdGlvbnMgYW5kIHVzZSBpdCBpbiBpY2Vfc2V0
X2NoYW5uZWxzKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgTG9iYWtpbiA8YWxl
a3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gLS0tDQo+IEhleSBUb255LCBwbGVhc2UgYW1l
bmQgdG8gdGhlIHBhdGNoIEkgcmVwbGllZCB0by4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX2Jhc2UuaCB8ICAyICsNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9saWIuaCAgfCAgMSArDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfYmFzZS5jIHwgNjMgKysrKysrKysrKysrLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2ljZS9pY2VfbGliLmMgIHwgOTQgKysrKysrKysrKysrKysrKysrKystLS0NCj4g
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9tYWluLmMgfCAgNSArLQ0KPiAgNSBm
aWxlcyBjaGFuZ2VkLCAxNDMgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9iYXNlLmgNCj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2Jhc2UuaA0KPiBpbmRleCBkMjgy
OTQyNDc1OTkuLjk5YjJjNzIzMjgyOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9iYXNlLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWNlL2ljZV9iYXNlLmgNCj4gQEAgLTEyLDggKzEyLDEwIEBAIGludCBfX2ljZV92c2lfZ2V0
X3FzKHN0cnVjdCBpY2VfcXNfY2ZnICpxc19jZmcpOw0KPiBpbnQgIGljZV92c2lfY3RybF9vbmVf
cnhfcmluZyhzdHJ1Y3QgaWNlX3ZzaSAqdnNpLCBib29sIGVuYSwgdTE2DQo+IHJ4cV9pZHgsIGJv
b2wgd2FpdCk7ICBpbnQgaWNlX3ZzaV93YWl0X29uZV9yeF9yaW5nKHN0cnVjdCBpY2VfdnNpDQo+
ICp2c2ksIGJvb2wgZW5hLCB1MTYgcnhxX2lkeCk7DQo+ICtpbnQgaWNlX3ZzaV9hbGxvY19xX3Zl
Y3RvcnNfbG9ja2VkKHN0cnVjdCBpY2VfdnNpICp2c2kpOw0KPiAgaW50IGljZV92c2lfYWxsb2Nf
cV92ZWN0b3JzKHN0cnVjdCBpY2VfdnNpICp2c2kpOyAgdm9pZA0KPiBpY2VfdnNpX21hcF9yaW5n
c190b192ZWN0b3JzKHN0cnVjdCBpY2VfdnNpICp2c2kpOw0KPiArdm9pZCBpY2VfdnNpX2ZyZWVf
cV92ZWN0b3JzX2xvY2tlZChzdHJ1Y3QgaWNlX3ZzaSAqdnNpKTsNCj4gIHZvaWQgaWNlX3ZzaV9m
cmVlX3FfdmVjdG9ycyhzdHJ1Y3QgaWNlX3ZzaSAqdnNpKTsgIGludA0KPiBpY2VfdnNpX2NmZ19z
aW5nbGVfdHhxKHN0cnVjdCBpY2VfdnNpICp2c2ksIHN0cnVjdCBpY2VfdHhfcmluZw0KPiAqKnR4
X3JpbmdzLA0KPiAgCQkJICAgdTE2IHFfaWR4KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGliLmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2xpYi5oDQo+IGluZGV4IDM0N2I2M2U0OTdlNy4uZTU1YjcyZGI3MmM0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5oDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGliLmgNCj4gQEAgLTY4
LDYgKzY4LDcgQEAgaW50IGljZV9lbmFfdnNpKHN0cnVjdCBpY2VfdnNpICp2c2ksIGJvb2wgbG9j
a2VkKTsNCj4gdm9pZCBpY2VfdnNpX2RlY2ZnKHN0cnVjdCBpY2VfdnNpICp2c2kpOyAgdm9pZCBp
Y2VfZGlzX3ZzaShzdHJ1Y3QNCj4gaWNlX3ZzaSAqdnNpLCBib29sIGxvY2tlZCk7DQo+IA0KPiAr
aW50IGljZV92c2lfcmVidWlsZF9sb2NrZWQoc3RydWN0IGljZV92c2kgKnZzaSwgdTMyIHZzaV9m
bGFncyk7DQo+ICBpbnQgaWNlX3ZzaV9yZWJ1aWxkKHN0cnVjdCBpY2VfdnNpICp2c2ksIHUzMiB2
c2lfZmxhZ3MpOyAgaW50DQo+IGljZV92c2lfY2ZnKHN0cnVjdCBpY2VfdnNpICp2c2kpOyAgc3Ry
dWN0IGljZV92c2kNCj4gKmljZV92c2lfYWxsb2Moc3RydWN0IGljZV9wZiAqcGYpOyBkaWZmIC0t
Z2l0DQo+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9iYXNlLmMNCj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2Jhc2UuYw0KPiBpbmRleCA3MDk3MzI0
YzM4ZjMuLjY1ZTE5ODE1YmVjNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9iYXNlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV9iYXNlLmMNCj4gQEAgLTE1Myw4ICsxNTMsOCBAQCBzdGF0aWMgaW50IGljZV92c2lf
YWxsb2NfcV92ZWN0b3Ioc3RydWN0IGljZV92c2kNCj4gKnZzaSwgdTE2IHZfaWR4KQ0KPiAgCSAq
IGhhbmRsZXIgaGVyZSAoaS5lLiByZXN1bWUsIHJlc2V0L3JlYnVpbGQsIGV0Yy4pDQo+ICAJICov
DQo+ICAJaWYgKHZzaS0+bmV0ZGV2KQ0KPiAtCQluZXRpZl9uYXBpX2FkZF9jb25maWcodnNpLT5u
ZXRkZXYsICZxX3ZlY3Rvci0+bmFwaSwNCj4gLQkJCQkgICAgICBpY2VfbmFwaV9wb2xsLCB2X2lk
eCk7DQo+ICsJCW5ldGlmX25hcGlfYWRkX2NvbmZpZ19sb2NrZWQodnNpLT5uZXRkZXYsICZxX3Zl
Y3Rvci0NCj4gPm5hcGksDQo+ICsJCQkJCSAgICAgaWNlX25hcGlfcG9sbCwgdl9pZHgpOw0KSWYg
eW91IGNvbnZlcnRlZCBpY2VfdnNpX2FsbG9jX3FfdmVjdG9yKCkgaW50byBfbG9ja2VkLCBzaG91
bGQgaXQgYmUgbG9ja2RlcF9hc3NlcnRfaGVsZCgmdnNpLT5uZXRkZXYtPmxvY2spOyB0aGVuPw0K
DQpFdmVyeXRoaW5nIGVsc2UgbG9va3MgZmluZS4NClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9r
dGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg0KDQouLi4NCiANCj4gLS0N
Cj4gMi41Mi4wDQoNCg==

