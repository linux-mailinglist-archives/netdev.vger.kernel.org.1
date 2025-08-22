Return-Path: <netdev+bounces-216135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D084B3230B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8B91D63A63
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09242D3A93;
	Fri, 22 Aug 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxmeFE9u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D52D4B73
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891680; cv=fail; b=dsKrv2n+4dnjntQX1IRqzzcnq8nIbp9CUsmrEbofxbgrgT+JdCNegfghmark8ty1zTGyxkZ2CWjrkddWmOzU893ERIgnXM+XbgcBzhQgT1B0zD+zji+/EpQR8sE4BSJProzWlZGqNz6Q1muzdIBn6BthluSZGnhuMg9bZ92JrsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891680; c=relaxed/simple;
	bh=fsdJ7WekvQmE2jxg0N3IL6qV9Npis1TapQuN5/p6Sx8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QfmiGjs5+5+4JasVhsSq98Kz/vkunK9NNga1T95Jc6aKqQe+88h7PuiDkBe4SotxOlunPse81kB3AuUpPpt7mSX+xG+YkGRfNFS/BwiaK+RpO9J3c6/3CkabyHMu+xmpxpOrB1HsQmomiH1u4j3RTOhHt56ZW7RUHwn/LlihTwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxmeFE9u; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755891678; x=1787427678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fsdJ7WekvQmE2jxg0N3IL6qV9Npis1TapQuN5/p6Sx8=;
  b=AxmeFE9uKkHFjY59telvvuwhauE7uFcA97AI/4irMB3SlBib7OAnYmYm
   yeMMpWyECM/a2+dc3MPsd6D8gMePcS3LCixTX8Vi9lkVATLqiMHVDhZQH
   GvzMC5VyC9SxNIyazB3/+apTTOeMIpfp/gks3/7g8QIwFj9f4YAhVyjqL
   HWWCkqx76n4+R2i4wbMgAruzEWXGK+CEcFoSn61ECvKZNl3tfOpOKRiIP
   AI2TY2/RrFPTLHunhz1zBrXWRnG62bhvYMJmBKCjYMrHraJlNU617AVTP
   aNdEV3dvo6C0XIvUy7+xBlzJ4smRlpLh3+G452eSlfTCCzf5f1W1D2YR7
   w==;
X-CSE-ConnectionGUID: KFmsx3NLQvyq+2Ml7PC4yA==
X-CSE-MsgGUID: RZITIBsqQGK4Zoxhj3LPIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58273063"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58273063"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 12:41:18 -0700
X-CSE-ConnectionGUID: YBvuRSk2RvW4K2j5ioXciA==
X-CSE-MsgGUID: /C+/EitJSxqPBU+rz2xrgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173055047"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 12:41:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 12:41:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 12:41:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.42)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 12:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGFLM8T1ECiQAVte7pg2QFr0dydwF0PITTPmAMooWgwrYD4A4/dYuipH0UJnGqlu7DaSdJdTAKAFIAAfCbZuf3pbFUYPvBmzYWEmOvsxTmcHK30E3FJyB/aX9/QeSXAV8BbGq1lUesICP98MpeAutX/geUIAkd4654LbQftMNWi9jC5Z0nlnQpH/MwQaKcHhXzLuf2ONNTevdtbpr5TVU591BpPV5FTde1ejXgTact494ZXnpeHGtlGVOhGzPkwK5G0aO4iF4s2wCSgziwmvh3W2zqYiXQgO9uE4Ox7ATmn/YyC5JkpSNqGx0GIi68GP3xczG5p29BpbfpVpp4zwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsdJ7WekvQmE2jxg0N3IL6qV9Npis1TapQuN5/p6Sx8=;
 b=xKRTl09WBho7at4JDlS28WoT3PxeDWM73U+eFuFAVgHCYotmwuM+Y9uxWconIyCkibWnAaJoMUw0LlQoMxfQwZjj0uD7kStDK4f4b0PEaCpZ8Bv+QvJLmb0r9NIJkhvAkvfR+g6WPzDuwT95TCYClXXYTCZTqDByW9E22eRfN+vGgxLhqyI+JcUYckXDyvsNYhAxTCPEDfBMciZoKHrBwccqOSkNDJVfOknCcFDfyIEHrcsA9IdVNPFkFo5CkJ38cqPSV1P8fYFLYnvRAu6TNCH7+TLy91r/RYVYOJOENpwT4IawekwNjfCFiMSyMwr3RuIFB+sFEwYVvIJm/7OcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 19:41:06 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 19:41:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: add devlink param to control
 VF MAC address limit
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: add devlink param to control
 VF MAC address limit
Thread-Index: AQHcEvTWThai0XHBO02saiegVHCdW7RvEo6g
Date: Fri, 22 Aug 2025 19:41:06 +0000
Message-ID: <IA3PR11MB8986BCBA2E243D2DE968D6A3E53DA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250821233930.127420-1-mheib@redhat.com>
In-Reply-To: <20250821233930.127420-1-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB6775:EE_
x-ms-office365-filtering-correlation-id: 9dcccc33-1e7d-41bf-24de-08dde1b3d5ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?RE95RWw0ZXkycnlHZFM5S0JacFRWd09qNHpYMnZTUXo3cnFnaGF0UVpjWG9G?=
 =?utf-8?B?WTE1eCt2QjJLUythTDRmRVl2VjFiQWFSbzVlN24yUzZ4NW0wcmVhZFdJY2J3?=
 =?utf-8?B?YkF3SEhnSXcvaWltcElNTlgvSE5aemU0NFIya1h1L1pzZmJpMlUxb1h1cmFh?=
 =?utf-8?B?NU10aHZZdDI4dW51RlRQK2VPWlpjOGNDNElrNlowcjNNRG5Bc0VTTTl4a0Iy?=
 =?utf-8?B?eEF0VHJqS3NXRkxXanUyV1YvcjdqMms5OGtLYm5IdG1yS2ZFRmlBSHB0V0ho?=
 =?utf-8?B?SGdiTUdwbk1uczZMQWRlZGR0Ylp6N0x5SUFocko1VTVsSnVXQzVBMmNTSzB0?=
 =?utf-8?B?TVBkUUZEVXQyRUpHczEwZzF5SXJEQmhibGtZc1E4ZFlRMnk3UUtxVVc1cUY4?=
 =?utf-8?B?enZKdW5POGpOeS9XeVZPbm1SYzk3aEc5eFdRdFVBbE5IOGQrVHduNFg2Vk5v?=
 =?utf-8?B?TTlSTUltM3VZMWxkUWI5Ni9jbUhDQTVjZDBNZ08vdVlPa3FpR3RQam1Za0xB?=
 =?utf-8?B?TzNSVmd4cFRTdEp2MitKTXY2NklDYjdVK0NYYU1vNkpuZG4rcDFkUzVXUFQz?=
 =?utf-8?B?SjAxNjlpNmtwYmpzTEp4ZzlWWHk0dVhTVGF4dmdxSHlkMWVaeUVNOVdLVmlE?=
 =?utf-8?B?V1BhSDNVSkNwNkJqMnRiaDlYckJocmVLQ0M4OFIyZGhnY2pnVjRHQTRaNHRN?=
 =?utf-8?B?TlBVMHJOK0hCMzcyYXNnUU1ZdDBVNmVqU0VneVlpMXdEWkFkSTVIRGxKc3A2?=
 =?utf-8?B?Y2hzVWJxdjRicnlBSHU0bmF0QlpxTk1HdXFzWGVBNElUblozR0tIZ1lsK2Fq?=
 =?utf-8?B?Q1hxcEdmZ0MxaERrSmZIKzNDNXF1OEVxaldHNVptM1lxZEczbWZONkp4VGxp?=
 =?utf-8?B?bUVJNThCMXFWOFRZTGd2YmxYK1JJR0Y1bGl3MDhJQVpOR2g3Ynl1UzdLVnpO?=
 =?utf-8?B?VXgvUUlqN2E0dFhNclRiVDBlWWhyWVJsYVZIeWNldFMxbVhra1lxVzd4b1FT?=
 =?utf-8?B?ZVg1eGh5WDJWdXpRRS90bjQ2TmJoVWovSi9KQzRzaGFUVHlvMndtVWdHNlly?=
 =?utf-8?B?STNiRmtwS1lCeUwwUGVNUHZwSUlTRHRScDNZSHRlUmxiQjZpb2xhR2xqaDRD?=
 =?utf-8?B?Vnc2VXpSdGZXY2w3QzZUZ2FrV2RMZkxHRGQxejZtZ3RocXZ5b2Y0SHNLV0Za?=
 =?utf-8?B?N3VZVEFuM21pNFlnNVBRVFozUWZEZ1MvZFp6czBZd0orVXU0K2hESFJqc0sr?=
 =?utf-8?B?S3V5MWVGK21rK3l4a3dHVG14eGN4TFdCQnp0SGFhbEl4VjlnZmt5czY3bkg4?=
 =?utf-8?B?Z1dEK2ZKOHdoYjdha3hjQkJMMW9WcFJ3eHJsMW1yYWlmOEpKSVpLZWNMZFJs?=
 =?utf-8?B?M0tKalJuQTkxM0ZTalBGd1pqMWRHbkg5Z3g1bVdERUxLdGEzUytZZ3V4bmJn?=
 =?utf-8?B?VFpKaE9WQXZmdm5scXpoVFJXN2dUa3VRUjllalNRelNaVGZpTUc2SXJGSno0?=
 =?utf-8?B?VitHV0pyeWd5b2duNHQxVk11cWZ2UGRBZnljWm5UblRYSHROUXZKUk1RT2Qy?=
 =?utf-8?B?UXJRRXZRcmN6a2U0OVFtRGlwMDh2a3hSeUNXWG9ML2hpU3BWYUV2TG1zdW00?=
 =?utf-8?B?MHBaOWRqYTI2RDJXSmVuVDhTTk9pblJmNys3S0x5UTEzclVDWDlGREFQb1dt?=
 =?utf-8?B?TzlvR0Nzbm0yMjNyTzV6alpOTjZTY0lhSEdHV1VsQndBNVRGT2xSbFN4NEo5?=
 =?utf-8?B?Vjk2eFp2NVVsOTNReUMwa0RyaU0rdUhPeExWVFh5cGFyM2RmRDNpWHhTR3Vn?=
 =?utf-8?B?ZklLc2Uya1BwMFAxNGJaS1RXWWtKNEF5bVJvaWtsK0RtWnBiVktJY0ZGeFJq?=
 =?utf-8?B?QUJCN3RTTHYrN0NmMWVpTVN2c2JIZDlQMXBraVl4WEZCT3FJSWpFbW9OU0dL?=
 =?utf-8?B?cXFUTm1TdVZrTGYyYURBTHJyTG1VRUZKdExyUTVubkg5bTVzR3VhWHAwcXRR?=
 =?utf-8?Q?SgbAYqeFXLn7TpsAUzHKd0ZXOJFWLA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MS9tUHdhUFM3MU9xK2l4QUloY2FJTGVUMVpDdE5qZnc3MzJJMWRmcG1HMjl1?=
 =?utf-8?B?Sm14Y1d1VnpzcndWQWtEWXh6ZDh3b3RHKzRFaS9TMXJGaDZiVE9xL2p6aUEy?=
 =?utf-8?B?emduV1lORGJIRlZYNFF6anRpZXVycDBpQVhFelBVc1ZFdm9sYm9jUHp2cjI4?=
 =?utf-8?B?UGU3MmQ5NGl1ek5DUUdZQU5tTSthTjZQUFZ1bEtxL2psajVmZnhUVHNCMXZL?=
 =?utf-8?B?VTBBRTN5VURFbzZwdU4zSW1DdHdrYnNiUGRONEVuWkhkd2R2MGpsUVpIQitX?=
 =?utf-8?B?ZnNtWG9hbW9TR0hQY2E3Nm9aUWd3ZXhMYi9OdHo0RXRGY0FRakxDK09WY1JC?=
 =?utf-8?B?aWMzTkdpYVg1ajFENTFvZitWUmIyclpwSmZweHhOMWFHWUJqV083c0MyaWpE?=
 =?utf-8?B?eGFQbUFOYUlZMHhQZS9BZjdEVmpaeVdLYnpLSk1nNmZGN0pZdUQyaXYyQm01?=
 =?utf-8?B?RDJWUm5mV3grcEFkaS9rMWlwOTdadm54eHNVWmlUeHp1T0hwY0RaZUJOWG8w?=
 =?utf-8?B?Nk1ETEVCOEhjdXlIc0t1Q09PeXcycGdFeGhxMXcrQWx2Zld2elNNODQzb2Q4?=
 =?utf-8?B?ZlBNcUwwV004TEozK3c4UEdQemc4TkR6dmRuenk5VXZpc3JIY1RYRUxzNDdD?=
 =?utf-8?B?MW43VThseG9aY1B3K1kwTGZHbDQ2ZVJTYytwRFNrRVB1eWZCb1M1Tkl1ZERW?=
 =?utf-8?B?cTRCdUs1YnN2ci9PWElTaTB1Z3JoR0JRMEZvYzZJWm5hdmF3cmRJRUFQNFJz?=
 =?utf-8?B?TUM5VzBNalpqK1RDaW5wdVVIcStyLzZ1ejdGY1ZuUkRsNXdYNld1RXNiWGZZ?=
 =?utf-8?B?S1EvSXZrOFkxMVFHaVdEVWVqTThBTEVUc2tsaWszaG9vYmJRcTJIcFczVHJS?=
 =?utf-8?B?ZGtWamFWQjR4NnZFUlJ3bFA3YWQzRzFSb05XeTBpSjdwMTZMaVJ3bU5SZHV3?=
 =?utf-8?B?aHVoLzN1TDlwaXFZR1g5WFB0dGhnbWdSK21HUjM0VGt1VWp5WXQzZnMvN2ZZ?=
 =?utf-8?B?Rlp3M1NmekpPRzNOZHY5NkdUYXVLOEpsS3VaM3J5WG1DU0U3dGRvMFAwdXhz?=
 =?utf-8?B?b3J3SXVOWnRnS2pPRVJ2Vi9Ibld2RytvWnUzNmx0aHc0WGN5RFN1eEFTa3pB?=
 =?utf-8?B?QVJRVXJsckVEUzBXV0ZOTmpXWDN0V0NaWWxLWkc3Vmhhd3ptR1V4U3FOcUgy?=
 =?utf-8?B?dkk2MStRVDc0cU1XU29udzZqS0c3aFVqRHVLRTBidUI5cCtQV1VPM3RnR1Rr?=
 =?utf-8?B?NERmb3Y2TVZheEpWbXovWEk0eEV0SmxORG5BNXkxME9Mazl0K0UwbzhNVXYz?=
 =?utf-8?B?aWZ5M0tIdzZIeEFvOGtpNjhuUUlrU1hiVFhlQjM3WjdKWXZ6Z1FCbjFzWWRO?=
 =?utf-8?B?dUNqL2QzTFpJdU9XUlZDK0t5UXhudSt5RDRqWGRseThpS050OWdTd01RaGhQ?=
 =?utf-8?B?dC9PQ0ZiTEJVVExJYVNCZVNqa0tNWFFmeWwwdVpDd0JhZWRNc1hlNTBicE9y?=
 =?utf-8?B?UmdKanRVRkpoRENoRGtCcVh1MWRLU2tLVWZSTG5aT282V0hDR1l6V2djd0NB?=
 =?utf-8?B?dVdoUG14bUdYQ2doZ3lFT3RXUnRhUzdTcEZNTHdVZW8vWU1OdHc5Z0xRSUNh?=
 =?utf-8?B?Y2VBSXRGSW9YOWZIUm80Um0yOU9WRUZHT1RWLy93ZGFXaWxONUczR0JWR1pZ?=
 =?utf-8?B?cmw3Y1RrYmt5OXRwRGQ0WFlkWFFQQ3o0dWgrNjgxQWxGWDdqalVZODgySlRC?=
 =?utf-8?B?UU9NNXVIREJWZ29kWVJnNnpSQlFRdmR0SDZKZHBFRXhvcm9PS2FkdXdrSHFE?=
 =?utf-8?B?MnhtU01yT1JXZnZKYlh0cFZLSUV0Sm01M0VjK1JuMUwxS0JhQTdEVGNtM1dQ?=
 =?utf-8?B?ZmxZYVhyS2xCZGkrbk1MVzRIQUJ1QnFTVEhteS9jOEF1K21ZNEJnUUZIeThP?=
 =?utf-8?B?amNjV1Z1MFhyOHVHd1p2QmNjd0hTaittNG9GeTQrM0NmUmltSnhyTlY3SExx?=
 =?utf-8?B?YXhjY1JGT2FZb1l4UW5veFRnNGs2Q0VQNHlEYTd5YzFsWTRIQ09vWngyMWFZ?=
 =?utf-8?B?WWFSUEpYTGFuQjNLOEF4QnJpL3NENFZHZmpuSW0wby9CWVk4dFB5ZWVGYjB5?=
 =?utf-8?B?SUxGZEROUFkyTklUUkFxam9mM3pIdVlwZnRNeVVNN2RBcTBBTWlmNjdFMzl1?=
 =?utf-8?B?OGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcccc33-1e7d-41bf-24de-08dde1b3d5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 19:41:06.0494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxmZAd9XYewW2Ncy1xX+zHj1KnRvkq7NfOwn6/ZQuQjw7ijBmoG08xThmF3xyJ4TZhgyNRob7mxwJuKj5hf2gOoewSZ2Z9BOqKGIZdzcibM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgbWhl
aWJAcmVkaGF0LmNvbQ0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyMiwgMjAyNSAxOjQwIEFNDQo+
IFRvOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogS2l0c3plbCwgUHJ6
ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IE5ndXllbiwNCj4gQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
DQo+IE1vaGFtbWFkIEhlaWIgPG1oZWliQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13
aXJlZC1sYW5dIFtQQVRDSCBuZXRdIGk0MGU6IGFkZCBkZXZsaW5rIHBhcmFtIHRvDQo+IGNvbnRy
b2wgVkYgTUFDIGFkZHJlc3MgbGltaXQNCj4gDQo+IEZyb206IE1vaGFtbWFkIEhlaWIgPG1oZWli
QHJlZGhhdC5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgZGV2bGluayBy
dW50aW1lIHBhcmFtZXRlciB0byBjb250cm9sDQo+IHdoZXRoZXIgdGhlIFZGIE1BQyBmaWx0ZXIg
bGltaXQgZmVhdHVyZSBpcyBlbmFibGVkIG9yIGRpc2FibGVkLg0KPiANCj4gV2hlbiB0aGUgcGFy
YW1ldGVyIGlzIHNldCB0byBub24temVybywgdGhlIGRyaXZlciBlbmZvcmNlcyB0aGUgcGVyLVZG
DQo+IE1BQyBmaWx0ZXIgbGltaXQgY2FsY3VsYXRlZCBmcm9tIHRoZSBudW1iZXIgb2YgYWxsb2Nh
dGVkIFZGcyBhbmQNCj4gcG9ydHMuDQo+IFdoZW4gdGhlIHBhcmFtZXRlciBpcyB1bnNldCAoemVy
byksIG5vIGxpbWl0IGlzIGFwcGxpZWQgYW5kIGJlaGF2aW9yDQo+IHJlbWFpbnMgYXMgYmVmb3Jl
IGNvbW1pdCBjZmIxZDU3MmM5ODYNCj4gICAgKCJpNDBlOiBBZGQgZW5zdXJhbmNlIG9mIE1hY1Zs
YW4gcmVzb3VyY2VzIGZvciBldmVyeSB0cnVzdGVkIFZGIikuDQo+IA0KPiBUaGlzIGltcGxlbWVu
dGF0aW9uIGFsbG93cyB1cyB0byB0b2dnbGUgdGhlIGZlYXR1cmUgdGhyb3VnaCBkZXZsaW5rDQo+
IHdoaWxlIHByZXNlcnZpbmcgb2xkIGJlaGF2aW9yLiBJbiB0aGUgZnV0dXJlLCB0aGUgcGFyYW1l
dGVyIGNhbiBiZQ0KPiBleHRlbmRlZCB0byByZXByZXNlbnQgYSBjb25maWd1cmFibGUgIm1heCBN
QUNzIHBlciBWRiIgdmFsdWUsIGJ1dCBmb3INCj4gbm93IGl0IGFjdHMgYXMgYSBzaW1wbGUgb24v
b2ZmIHN3aXRjaC4NCj4gDQo+IEV4YW1wbGUgY29tbWFuZCB0byBlbmFibGUgcGVyLXZmIG1hYyBs
aW1pdDoNCj4gIC0gZGV2bGluayBkZXYgcGFyYW0gc2V0IHBjaS8wMDAwOjNiOjAwLjAgbmFtZSBt
YXhfbWFjX3Blcl92ZiBcDQo+IAl2YWx1ZSAxIFwNCj4gCWNtb2RlIHJ1bnRpbWUNCj4gDQo+IEZp
eGVzOiBjZmIxZDU3MmM5ODYgKCJpNDBlOiBBZGQgZW5zdXJhbmNlIG9mIE1hY1ZsYW4gcmVzb3Vy
Y2VzIGZvcg0KPiBldmVyeSB0cnVzdGVkIFZGIikNCj4gU2lnbmVkLW9mZi1ieTogTW9oYW1tYWQg
SGVpYiA8bWhlaWJAcmVkaGF0LmNvbT4NClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92
IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg0KLi4uDQoNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZS5oDQo+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlLmgNCj4gaW5kZXggNDlhYTQ0OTdlZmNlLi40YTRjYjU1
YjZjZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQw
ZS5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZS5oDQo+IEBA
IC01NzQsNiArNTc0LDEwIEBAIHN0cnVjdCBpNDBlX3BmIHsNCj4gIAlzdHJ1Y3QgaTQwZV92ZiAq
dmY7DQo+ICAJaW50IG51bV9hbGxvY192ZnM7CS8qIGFjdHVhbCBudW1iZXIgb2YgVkZzIGFsbG9j
YXRlZCAqLw0KPiAgCXUzMiB2Zl9hcV9yZXF1ZXN0czsNCj4gKwkvKiBJZiBzZXQgdG8gbm9uZS16
ZXJvLCB0aGUgZGV2aWNlIHJlc2VydmVzDQrigJxJZiBzZXQgdG8gbm9uZeKAkXplcm/igJ0g4oaS
IG5vbuKAkXplcm8sIG90aGVydmlzZSBmaW5lIGZvciBtZS4NCg0KLi4uDQoNCj4gMi41MC4xDQoN
Cg==

