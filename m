Return-Path: <netdev+bounces-305464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TXlQNCQBTWpstQEAu9opvQ
	(envelope-from <netdev+bounces-305464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:37:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494071BFFA
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:37:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=G4XYcTEA;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305464-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305464-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45BCC300AB37
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC341D4C7;
	Tue,  7 Jul 2026 13:31:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA5313E30
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:31:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431077; cv=fail; b=o0tRglKA2IcxO/0cMxw39ekoZbqg5hJDGhWw+tgRUNLexwwgS4UNfjDlK1+SdmIVgnlXC9ALuA+3k2opomoD4luV6UJ8sQBI7mF6B9l/L7dsrGzPQynRkIXbf6MHa+3GwxVcxueYwkSy7GpQOhz1pWan3jJ4Gm5xQcTt3tLW8oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431077; c=relaxed/simple;
	bh=yRWBYap8s0wryPFPsRDsBPF8tvY5wO08UbgBCLDAols=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mz6CujLb7Zxzk4gq/SxTsFZkzdBaIlJaLws78pHFMZiWMUdfV4P98imRV/urMP6bZAzQbiAG4EXt9RdU1/oVZUbghxCzuFb0q+J1T3FMxGNTa36TXShs3g2pAxpukPh/y+dgKKI81SU3fMfaV4WxG005muIm8yO55b8vNCnwzwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4XYcTEA; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783431076; x=1814967076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yRWBYap8s0wryPFPsRDsBPF8tvY5wO08UbgBCLDAols=;
  b=G4XYcTEA99VRW06GNp0EW+Oy37R/hNJPteRy6IdiE0OAtQ7IzgM3Aob4
   GvmDb2wpe2W21TMzl3PS3BSsSrmkQ21ORIeV9xgQ5zpP9LoU3qm69hBFm
   5yCqEJEsyx0+6MuHfa+igFCTEFLomGKG+EpC4QMrxZoye/Msoz7OlXAty
   /h0BvetPlUxcTjYzM522Dz6FS8nEuZgCXxkK1emfJx+60XviZmK22r1Lj
   yVjryl9mwte0X/URc5dnayYJhkZHBv4yMzwXejGK60W2/Tf3IDcdLEJxC
   a9VzfoF3EygkzQOJBoxZvPA2BkYAaSu0WAmKwoRSJIZz3nL4W++c1WyOr
   w==;
X-CSE-ConnectionGUID: 3uI4rc3cRSmeQr9VZ2UUxA==
X-CSE-MsgGUID: XbHK1HRXTmuXC8y+kdQ9hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="87759882"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="87759882"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:31:15 -0700
X-CSE-ConnectionGUID: nRnematcRfawc/adJvsIug==
X-CSE-MsgGUID: 1nIm97SGQYezJQdd83hC/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257880171"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:31:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 06:31:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 06:31:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 06:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQtWIeSW0iGM4OC9U+Zm+1XDRHFdD04OCFvgTYW0DJaSAuuZlGT0ryEcfEdbqzbkMeQcoUqw3UUur26C6YkBkGGp3dgoxqaAproIootS9uIZIZkIpgZA1gNf5yFUDZFdszDqfEUXNG8W+rWPWQisIPY0H0ndWtTiFqs/gVBAcg0UHg97ny38v/EJpcFaUM2H0Kt6nKsuZjQdX9SMdHylfgGLnC6pogsQhTiNHl1j1XxXEWaQunDzUssGP4h1e6jDFIqIgc6x3T5OXqPZxYEGK26UiYbIAlgwgwTFJSLQkDvLbxIpMiBJyKHT+hPl7+dvqt+lMyt8qM8AJjMkwCaTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRWBYap8s0wryPFPsRDsBPF8tvY5wO08UbgBCLDAols=;
 b=gcEAeQG0tIEOoXGAoRzei27KiSHA/QszteMoJwqxUVo4Ok9KG2LFduPG5qyf8O3IemKF5+06GFqGAOnp7wdk4MPbDZqoeOHV+z+41FLib5HUjld1kN23YcnSmv4z+nb4u8cSt1TB5aUZTKiBW+7OzIb+PIg+YSnKm6tBQ6Qe4RimTWZqELgl1KMK8ssF1ptdO1AyaC6M/wWHLM5Oc6xEve2un2hrgglv3bfDhmtBpT/xqFSKK/8bOmRqtLDO+WQYJ+pdj5MeVKphjYpKP6IQMbkzrX9SjeDnav6UyGjLZXba1+hsfAFIoZGeX8wxVMIgoen5XFMs2EGCwQwHmkpMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9876.namprd11.prod.outlook.com (2603:10b6:806:4d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 13:31:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 13:31:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: add missing xa_destroy
 for sched_node_ids
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: add missing xa_destroy
 for sched_node_ids
Thread-Index: AQHdDZ/L3rI1zzDcaEOCEhQxtGHWRbZiDlkg
Date: Tue, 7 Jul 2026 13:31:13 +0000
Message-ID: <IA3PR11MB898687049BF7F63ED18DE334E5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260706-jk-fix-missing-xa-destroy-v2-1-b83b0f02beef@intel.com>
In-Reply-To: <20260706-jk-fix-missing-xa-destroy-v2-1-b83b0f02beef@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9876:EE_
x-ms-office365-filtering-correlation-id: 8521eabc-bf9e-4efe-dc80-08dedc2c03a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|6133799003|56012099006|11063799006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: 7/9HA7DOo+cpLUmNUaZWCnvqc+jnEHyY3nHA+XCS2HecTVWn9jaDsmJaRdBJBNKwDO+mC1sSklQbn8qAofT4zH9l7E3+mzHTEw8QS9HgTY4T4JwuikM0ZV7KuAnER5XAMiVuboMnY9qynXzM1iPvXtcAvuV+n2nWgtNQnqMt0ZpuAEQtf5KHJGv7w0N//Xk4wMqJP+fslxd+peEqFAxzAe5aq0qMk8EfUcfysYuFemgqcS17LhcaMj0Tv4/JY5UklYgO56y3jtlSNp6D8v2x2fBwd+Fl0p7RPW2QUWI1zwHv5haq3/SKxvRX5rvpTt5dleMUqcvhwBGjBtNLxkmTcSKiqQmlkqMHv/ufFZvh6ULkXdTqQjlOU6yWDFGRra/67rd9M42yj3FXjbL9x3DImKpdBnTgn8I7u+hawp3L9B3+lIKwRSOmr/c5nRcbLKC78SQwJv+wlKkBltA56rnapjm5MJ9ajMeMpL26HTaL2qMGHC/F+rmAknz6eWrxtWCTAmeQPozwOeMUii4/InD0jqSnO/EWfyI8bV4eT3KpJBZifRhUTSZwc+s7T+LziqYLwJHCp/0BONPkQHM+2LfHtwQn4wzd8otTBEEJmx3ZzcwdVrhjEfjQy0y0M4YRiGZjMq9+wqs0aQPtddOMd+QvoDpjdmNbLWd7z8snx+1lgnA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTBaR0xMRjUxN1BFRHBKbS9YbThQN3UzK0kraGROcFZtWEhteHNDSmVKek02?=
 =?utf-8?B?MFF1R05ZTzFpcG1WRjN2clR1MDR6K0JiQU4wY1JVWnh3eDJXaEtnRU9KckJj?=
 =?utf-8?B?L3pvY3M5ZmFnUDU1d2ovNkRzUkRYT1pOSCtzeWovRjZQMkpjcXpMQlZRbjZ1?=
 =?utf-8?B?bmNRekhBOHFETURhYXdhQktYM3pYOFFuVWY4dkt5aUJQZnFPenpUeGVPa2Vj?=
 =?utf-8?B?NlF2aVhmNkpGUDRobTlWYWgweW9pdHY3MmVFNGRuZVZ2V1IwMnl6MHhoMXVn?=
 =?utf-8?B?M09BMDViVWlZMDZoR2hnaUM3QUxlZ2gvN3IrTlRFanJHdkJ1S0trV2o3bGw0?=
 =?utf-8?B?VXdpMGY5aXl2V0M1V2dCSGNrZEttQTY4Q09ybWRTUlo1dUNoTW83dnlZUlhy?=
 =?utf-8?B?b0FtN2N4RVl2UG8zbTU1a3Y3VXZHaHpUbHVPc2ZiTHY5aWtaUVUyYVVRZXBv?=
 =?utf-8?B?YlljVEVWcmJ3WmFZMUE5WHllcEx5Sld0N0RTY1RTRlN3TGRYOEdwRzlWc01L?=
 =?utf-8?B?OUFjb21rMXE3YlhNdkJVYVAzZkFRbGpMbmJ2d0lyMHdJckwzcDZQQmhjOWxH?=
 =?utf-8?B?cEhwNGcva0x0WGxROW93UXExS2kxNExnZDdVTHVySDBneUV6MjZrVEl6Z0ZS?=
 =?utf-8?B?ZlR6OVBDcytRWnRPZUJsNFFreG96dFR0elN0bjlZc3daVnVLOFRwMDVpTzFz?=
 =?utf-8?B?dHBIZFF6Vk5neU5jaERwbzdSRnQ2OFZrVHJsMFJVMzR4ZjRmUTRCckw2dms2?=
 =?utf-8?B?YnJKeVFxVWl4NEg4bmpNV2F6RDlaRHNuOUtXekJJQ0lPcU0wVmk1M1RvU3Rw?=
 =?utf-8?B?WVBtSUczK2F1SGhybE1vZm9JK0ZnR1hncG0vVWYxR0JyYXFTR3kyQVBMcm9L?=
 =?utf-8?B?UHl0OUtZZUtJdjUzR2JnR3JuK2NJMldXS1NqYTVOMVNuNmh2bENoQTduNHJW?=
 =?utf-8?B?WTBFdkRZYmgzSFlBeTZOSXE1S2l0KzR1QXVqbkE5TElGZGplTnVEdGozTmRR?=
 =?utf-8?B?QUFmYlJ6aGxDb3hqYjdFb1daTnlDeGZHaWtQM3J0RzF1c3phU1ZSZHpRazFI?=
 =?utf-8?B?NHBSNXM1NHFKQUpDbW8yY01pWlI5SkdTUk8vdytHN0xvOEc1b04vTXJVWFFv?=
 =?utf-8?B?cEZSYUgySXRuY1lXbUV1NlA5RTBQVjJvUjFyWDVKZ1hRdmlvaGtjQ3lpRFhv?=
 =?utf-8?B?N21KU0FxNXpXdzg0anZPdnZYTnJOTHFKWXlaVmVuMjdMUkUzN0UrNEFVMks4?=
 =?utf-8?B?NUNwQjFERi9lWGNMNDNtWU9qM0lJbGVRTFRaRkdDQ0ZXd1l2R055MmEyK012?=
 =?utf-8?B?Ny9jYkRkMUdGMWNVS3NqQlIvZEIwdkRKczF6bWJadFZlMWdFWnVyUzU4VUY1?=
 =?utf-8?B?OENlS002K3RNblhOcExtTkdBK3hjTWlRRm1JdjN2aVdvS1dBRVc3dHVoVzVp?=
 =?utf-8?B?RUJrRDU2V3hoWFpMUzBNcjI0OTQ0aTBEZ1Y4Skk0ekw2ZWFtYlJWaGVJbjdE?=
 =?utf-8?B?aDRhb1YyMHhQTUNkYnJaUFJGOVFsQWVBdG9zSzRFM08rWVk4a2dlemhYSmdY?=
 =?utf-8?B?cGtoSC92d2dBRVNlMjFacFVpeTBqaHRXbjRsWEk3eS90cHphb2pSUnpOaFhM?=
 =?utf-8?B?aVp5VWphVHA0MWlzMk93a0RyeWdRVVV1WkF5OWppNHJIbDU5SlVUdExtUzZi?=
 =?utf-8?B?MDlqSWEwa0FCZjh3M3EvVm5WV29ITit6ZkdRR0J0TzArK0ZORGduNkEyZlhU?=
 =?utf-8?B?YS9KZWtrL0Z1dHAxcGhhSkZiRG16K0EvNkhQQUVxd0QzQW1jUEZtSlJJZWhz?=
 =?utf-8?B?dmhyeDEwaXlNQU1IRk4yWXhDQVMrRUtEcFUyazVUeWpMRm8vWExoR1Fvdk5X?=
 =?utf-8?B?MnIyVDFVYSs3c0JvKzdLRW02RW95ems1TnM4Z1Y1bVJzaXJxVjlaK3VQcDZY?=
 =?utf-8?B?bUFuZEdlL25LQXBuZTNIcEFsN0pBb0hialplNHhjRW91WU14N1FJejQrTkl2?=
 =?utf-8?B?cFlJS2VHU0hRUFhZc1FjSkZxMEgwUHl2SENJNk1TTTJqS1lJM1k5NzQ3Rkwz?=
 =?utf-8?B?QWhJaHkyR01mcjU4OG8wTjhWZDlWRzdHZFpCbVVlaDlSVHFwSmN6WU9zRHZ2?=
 =?utf-8?B?ZjVjMWpzTzdnb3QyQnhlbVZPQXhEYlZ0SWhJSGl2ck01TW9uVUJ5NnRnaG5l?=
 =?utf-8?B?Z0pIZGFTNXl4ck9pbVRYVGJ5am80c2xlK3o2RllJZWJneGJrMHAxWUhDWEw3?=
 =?utf-8?B?T092ZzV3eHRDc015N2VqQWVwQXhybG5oZFdaSGJyR3QweWU1N2lTLzcybFox?=
 =?utf-8?B?UCtYcWRRTXNkL0hVdGRNcE9xM2pJeGhiYUMzb3dGWDZiakxPWHBuZEdLU0pR?=
 =?utf-8?Q?YL7oE3sIU3KlfBKc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CZcbg//eQNBP+RrJGdAReSXA26KZ3kvlcatmY55e7QfReEFp53lNCe1pacsP6SfMsycqHLkgbANto4WC2QbwAMSXOcVkFjoPlLUzFisKmPjyFk7JGwi+lMv7xb0fc7jkl0Iwv+dkl0/RRMn9svCz3lXuHMYO+XzKlMWHLuOzs3NWPNJvePEGQgq/Nh/4dU+CCQ0MArjg5qPg+jKounnY5uyZweWUjizjK2+Z7xSJ73u/G3inGBKJMxDCrvw4VQFKN9oWfddscidGZr7jFrTE5YgNRchDXe3xT9PUR8+eM6QH3Y7Pcl/fEZI3FbTYIngiJJsi8M+XLvlNQURpdxqnww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8521eabc-bf9e-4efe-dc80-08dedc2c03a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 13:31:13.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j91LPBL+QqhlUM9iH64MjA/hcD2fTt/3vrbhA15UMFDuckgiR7oMrB+FDymPAUNkIlx0ygV3s+nTyn6i+sTGWjXPM6MUqXCZ4OKM0c1rlKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9876
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305464-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7494071BFFA

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgNywgMjAyNiAxOjMxIEFNDQo+IFRvOiBO
Z3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLA0K
PiBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwt
d2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtlbGxl
ciwNCj4gSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50
ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5ldCB2Ml0gaWNlOiBhZGQgbWlzc2luZw0KPiB4YV9k
ZXN0cm95IGZvciBzY2hlZF9ub2RlX2lkcw0KPiANCj4gQ29tbWl0IDE2ZGZhNDk0MDZiYyAoImlj
ZTogSW50cm9kdWNlIG5ldyBwYXJhbWV0ZXJzIGluDQo+IGljZV9zY2hlZF9ub2RlIikgYWRkZWQg
YSBzY2hlZF9ub2RlX2lkcyB4YXJyYXkgdG8gdGhlIHBvcnQgaW5mbw0KPiBzdHJ1Y3R1cmUsIGJ1
dCBuZXZlciBjYWxsZWQgeGFfZGVzdHJveSBvbiBpdC4NCj4gDQo+IFNpbmNlIHhhcnJheXMgY2Fu
IGFsbG9jYXRlIGludGVybmFsIG1lbW9yeSwgdGhpcyBjYW4gcmVzdWx0IGluIGENCj4gbWVtb3J5
IGxlYWsgZXZlbiBpZiBldmVyeSBlbGVtZW50IGluIHRoZSB4YXJyYXkgaGFzIGJlZW4gcmVtb3Zl
ZC4NCj4gDQo+IFRoZSB4YXJyYXkgaXMgY3VycmVudGx5IGVtYmVkZGVkIGluIHRoZSBwb3J0X2lu
Zm8gc3RydWN0dXJlLiBUaGlzDQo+IGFwcGVhcnMgdG8gaGF2ZSBiZWVuIGRvbmUgYmVjYXVzZSBp
dHMgdXNlIGlzIHdpdGhpbiBmdW5jdGlvbnMgdGhhdA0KPiB0YWtlIHRoZSBwb3J0X2luZm8gYXMg
YSBwcmltYXJ5IGFyZ3VtZW50Lg0KPiANCj4gSG93ZXZlciwgdGhpcyBjb21wbGljYXRlcyBtYW5h
Z2luZyB0aGUgbGlmZWN5Y2xlIG9mIHRoZSBmaWVsZC4gVGhlDQo+IHBvcnRfaW5mbyBzdHJ1Y3R1
cmUgaXMgYWxsb2NhdGVkIGluIGljZV9pbml0X2h3KCkgdXNpbmcgZGV2bSwgYW5kIGl0DQo+IGlz
IG5vdCByZWxlYXNlZCB1bnRpbCB0aGUgZGV2bSBjbGVhbnVwIHdoZW4gdGhlIGRyaXZlciBpcyB1
bmxvYWRlZC4NCj4gDQo+IFRoZSBpY2VfaW5pdF9odygpIGZ1bmN0aW9uIGlzIGNhbGxlZCBpbiBt
YW55IHBsYWNlcywgaW5jbHVkaW5nIGRldmxpbmsNCj4gcmVsb2FkLCBhbmQgcG9zc2libHkgZHVy
aW5nIEREUCBsb2FkIGFmdGVyIHVwZGF0aW5nIHRoZSBUeCBzY2hlZHVsZXINCj4gbGF5b3V0Lg0K
PiANCj4gQWRkaW5nIGEgY2FsbCBvZiB4YV9kZXN0cm95IHRvIHRoZSBpY2VfZGVpbml0X2h3KCkg
Y2F1c2VzIFNhc2hpa28gdG8NCj4gcmFpc2UgbXVsdGlwbGUgY29uY2VybnMgZHVlIHRvIHBvdGVu
dGlhbCBvcmRlcmluZyBpc3N1ZXMgYW5kIHBvc3NpYmxlDQo+IHdheXMgdGhhdCBwb3J0X2luZm8g
Y291bGQgYmUgYSBkYW5nbGluZyByZWZlcmVuY2UuDQo+IA0KPiBUbyBoYW5kbGUgdGhpcywgbW92
ZSB0aGUgc2NoZWRfbm9kZV9pZHMgb3V0IG9mIHBvcnRfaW5mbyBhbmQgaW50byB0aGUNCj4gaHcg
c3RydWN0dXJlLiBBbGwgdXNlcnMgb2YgdGhlIGFycmF5IGFscmVhZHkgaGF2ZSBhIHBvaW50ZXIg
dG8gaHcNCj4gYW55d2F5cywgYW5kIHRoZXJlIGlzIG9ubHkgb25lIHNjaGVkX25vZGVfaWRzIHBl
ciBhZGFwdGVyLiBXaGlsZSBoZXJlLA0KPiByZW1vdmUgdGhlIG92ZXJseSB2ZXJib3NlIGNvbW1l
bnQgZXhwbGFpbmluZyB0aGUgbmF0dXJlIG9mIHRoZQ0KPiBzY2hlZF9ub2RlX2lkcyB4YXJyYXku
DQo+IA0KPiBBZGQgdGhlIG1pc3NpbmcgeGFfZGVzdHJveSB0byB0aGUgY2xlYW51cCBwYXRoIGFu
ZCB0byBpY2VfZGVpbml0X2h3KCksDQo+IGVuc3VyaW5nIHRoYXQgd2UgcHJvcGVybHkgcmVsZWFz
ZSB0aGUgeGFycmF5IG1lbW9yeS4NCj4gDQo+IFRoaXMgd2FzIGNhdWdodCBieSBTYXNoaWtvIGR1
cmluZyBkZXZlbG9wbWVudCBvZiB1bnJlbGF0ZWQgY29kZS4NCj4gDQo+IEZpeGVzOiAxNmRmYTQ5
NDA2YmMgKCJpY2U6IEludHJvZHVjZSBuZXcgcGFyYW1ldGVycyBpbg0KPiBpY2Vfc2NoZWRfbm9k
ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwu
Y29tPg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9u
b3ZAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIE1vdmUgc2NoZWRf
bm9kZV9pZHMgb3V0IG9mIHBvcnRfaW50byBpbnRvIGh3Lg0KPiAtIExpbmsgdG8gdjE6IGh0dHBz
Oi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDUxNC1qay1maXgtbWlzc2luZy14YS0NCj4gZGVzdHJv
eS12MS0xLWRlNDM3YmY1MjM0N0BpbnRlbC5jb20NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX3R5cGUuaCAgIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9jb21tb24uYyB8IDkgKysrKysrLS0tDQo+IGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2Vfc2NoZWQuYyAgfCA0ICsrLS0NCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHlwZS5oDQo+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV90eXBlLmgNCj4gaW5kZXggZDlhNWMxYWFlN2MyLi5jZjE0
N2EyMTI3MDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9p
Y2VfdHlwZS5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHlw
ZS5oDQo+IEBAIC03NjUsNyArNzY1LDYgQEAgc3RydWN0IGljZV9wb3J0X2luZm8gew0KPiAgCS8q
IExpc3QgY29udGFpbiBwcm9maWxlIElEKHMpIGFuZCBvdGhlciBwYXJhbXMgcGVyIGxheWVyICov
DQo+ICAJc3RydWN0IGxpc3RfaGVhZCBybF9wcm9mX2xpc3RbSUNFX0FRQ19UT1BPX01BWF9MRVZF
TF9OVU1dOw0KPiAgCXN0cnVjdCBpY2VfcW9zX2NmZyBxb3NfY2ZnOw0KDQouLi4NCg0KPiAgCQkJ
CSAgR0ZQX0tFUk5FTCk7DQo+ICAJCWlmIChzdGF0dXMpIHsNCj4gIAkJCWljZV9kZWJ1Zyhodywg
SUNFX0RCR19TQ0hFRCwgInhhX2FsbG9jIGZhaWxlZCBmb3INCj4gc2NoZWQgbm9kZSBzdGF0dXMg
PSVkXG4iLA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA5ZTA1ZTkxYTlhODQ3ZWQ1NzkyNjQx
NGJkN2MyYzVlNTRkNmM1NmM2DQo+IGNoYW5nZS1pZDogMjAyNjA1MTQtamstZml4LW1pc3Npbmct
eGEtZGVzdHJveS1kM2Y5MGYzNzExYmUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gSmFj
b2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoNCg==

