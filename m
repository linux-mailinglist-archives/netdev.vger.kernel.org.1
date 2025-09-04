Return-Path: <netdev+bounces-220184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084BFB44A82
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E9A3A973E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9412F6573;
	Thu,  4 Sep 2025 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jzBXRT5p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EV5x5LZp"
X-Original-To: netdev@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F142E03EE;
	Thu,  4 Sep 2025 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029325; cv=fail; b=aXJhq8S8OQY68grU8DzGEmHy9W46apsuPwhDHDmpDP5agv5VSzvCVbTttw6+1ljGi+xtCheQSWRS4LMAmeHf3kkvLrqgA20pVt5Lr4im/TbHQCGWWdZEubDO5LQoKxzYth7OUPWNi1WpAb1pPLq4routAfpv3B37Pd4ZNyS6AVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029325; c=relaxed/simple;
	bh=rdtxgwY/V8wJpDaLcfVrr2OPr1VmhXhvSFkpm3g910g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtpOXnPzMwGaeHT2jYNu0VxaSItOYVIZe5u87R4coUJFn50w91CgOiSXyC9NhlzD7QpHjzLnT/37WmlgA2QTfPCPNj9MDWalOnfYUB9qDf7hgevDLzZP35q3uk9iM5nDuISON9lBwCsL8Tmz3oOSJ3pJwau2+qTrVhwgxUAApHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jzBXRT5p; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EV5x5LZp; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757029324; x=1788565324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rdtxgwY/V8wJpDaLcfVrr2OPr1VmhXhvSFkpm3g910g=;
  b=jzBXRT5pH/SKQapRD6iaFIN7yb9C90ihRywF0MrVgDIOr4qSuVzV6F6w
   GoOoRVg2FctIBCXVX5h4cfe6uEomahS75qX4NvSVAwunJPC3TaFGOKrh9
   G4jxB1gYnfQKpRrgc2FW1oaDLwo+1A07N/S31CYFuFJaSlmi9gUo2Yuwj
   fjX+jmooHo/0bEdYe2LhpsgAEImTFMRvxAOQI92/Xvsf5OQTnbDLW8DQj
   KzdGztCt8II9bCgwSJtxaJD/+9KRCaseFulxlUaMhwNRrptkJYA2HqE2E
   j7JFwzhX//Kg4VeSiR3fIzabCSsSJZJvvCyz5+6aB4Xii0DD8MNXmm8qt
   w==;
X-CSE-ConnectionGUID: XrTqwKMEQMSQM4gUFHfHGQ==
X-CSE-MsgGUID: VXX2op56RFCpNEHVN0qyYQ==
X-IronPort-AV: E=Sophos;i="6.18,239,1751212800"; 
   d="scan'208";a="108912980"
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.88])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2025 07:41:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtwRmDZxpugER/x2/xhmG5rbL1GA2snhyMlMe2jhWCdMng1dexYg+WpQ7d4BLBRKTDgFIpZknyMaYMsfhSCZHsLPPmfP1HsFQk0JrgtDS+p4fCxWuI0jZI27EIgqb/t53q4A0mB71rNBE2K2gxX9hKFZJwCGKAIZZ2vW/Rzlvw41R+DNDikPCGxzq/Ic5PBjBJFEvaL4KOYHaNtupVo+Dsx0Pv7i7rQOviZ1EKuzjU53FficCRCptw2UIwIW7HnuOlfmhasfoPMlSxr+YdkHbXjj4aw/0yZ+l87jZ6BOSuqGy8IQAku781npgV3BLzhFiCbp7U6q6CpMRU+iS3dxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdtxgwY/V8wJpDaLcfVrr2OPr1VmhXhvSFkpm3g910g=;
 b=IjU4k+Qjdvjh112rgx/4w8s2WmECXAj2HXvq1U/tnuqLYrFU7h7syWF/1ze69ghYFV8le5vno5OUSEO8deTPS0aAnFgABfws0WgPYN1jsbgHwUtrLu1KGtK2TgTg5FcLmSxix61pt+BHKluMm/aJIySB8JNhUQnWwDyr9kqq+RnUygJNOphWECY+N41SBrm2nufK6+4sUj2Tv0LU8kSJL2Jmy3pM363ZoI17tEaug0Wz+iEdmXUBlIa+h3hr4sgJW8DQQZ1s+ZCrZiRaCu7LD85bMdes3/dJCIXN1aFdbibUaB52w/cl3WqUq5Qld2uE/csjpvRbKS44GatJYw7VzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdtxgwY/V8wJpDaLcfVrr2OPr1VmhXhvSFkpm3g910g=;
 b=EV5x5LZpx3juoQBtIZ7zc3fVl8j8Vg49UUV4urWvXnziVvcY3krApEcAfpNFTtLC4NaSJgH9LV0fYfKMAJt55JNPG66Yzu92AxLDUH6JrLfhcVniFwp8ojkMZDa7vum6vUVg6lmXNfnSuyhvrjmEmoAVPKSjl4LtoOharrbIZMs=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by PH0PR04MB8263.namprd04.prod.outlook.com (2603:10b6:510:104::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 23:41:53 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Thu, 4 Sep 2025
 23:41:53 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Alistair
 Francis <Alistair.Francis@wdc.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
Thread-Topic: [PATCH v3] net/tls: support maximum record size limit
Thread-Index: AQHcHHTtbHT26j0+1ECxdz+YR3SeILSCEakAgAGgZwA=
Date: Thu, 4 Sep 2025 23:41:53 +0000
Message-ID: <a5b742c7530226af4fc7cdf67269be9d3aa842c2.camel@wdc.com>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
	 <20250903155130.3ce51167@kernel.org>
In-Reply-To: <20250903155130.3ce51167@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|PH0PR04MB8263:EE_
x-ms-office365-filtering-correlation-id: 9b3005d9-609a-4487-310d-08ddec0ca09f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3F0YUNpNUthcStZb1BHSXp2dUNNTDZvWGVGSHo5Tnd0NFpRZ28xRXZtRkNt?=
 =?utf-8?B?Nlo1a1Eranl6ZU56MWh2aTAzYmdUQ0pKQUVYaUQ5KzBTV3luQTlZZ3NFRzYw?=
 =?utf-8?B?Njh2Wm1DNitsUjRzN0UyNGZEVXp2dzg0TWJVVXhnR2QzTWRSK2tCa0pPTWFs?=
 =?utf-8?B?TzcyTDU5eEtqSDh6KzdqTmNKNngweGQ5WWE5aGt3N3owd0lOcmdnS1lqSE1P?=
 =?utf-8?B?TnRqRWQ3c3UvSkI0N3FmSjBIOVRKR2RRa2JDWGFqSVcxclNjWHd1RkJveXh1?=
 =?utf-8?B?VXpBSXh0bzFBYVo2RUEvdW94KyticzBxY1gxTU5LTkV1SWZuMEx3RjhPbWlw?=
 =?utf-8?B?WFIzQTNMenc4ekZNTmZRTFNpMWlmWk1tR3VHMzRqU1lZQ0N4akUxK3hTY3JL?=
 =?utf-8?B?ZXU1VVZSSm9obkpMRlYrc0VJUnZCSFE5bjJYZVBVSUdpOFU5eE1aMXRYaGZC?=
 =?utf-8?B?Vm8ySGhXdWpMam5tV1lpZGhqTnZZWHNqUTFWSlQ2djhJT3pCRTJBc0FzdHYv?=
 =?utf-8?B?U0gvYXhpMGJZczhsdGdneGFvbXM0MTVRYXpRUk4zcno3WGVvQ28va1R3aWI4?=
 =?utf-8?B?N0d6cFhtSlhnQkY5YWZhMjA1Wm83VmYrbXpDdGZkMHZ3U2Z1cFZhRWVQdS9l?=
 =?utf-8?B?ZzFhbDNlYUZzRXpNbkNMZXNWakhWU0l5ZC82N1ltVVJBSFpjdnVkTHBmTmh5?=
 =?utf-8?B?OVVXeVRMUlg4c1NPMXhXb0xvRTNiT3ROWXNQZFp1ZmhvNHA3cU1RVVdja0Fr?=
 =?utf-8?B?eVNjRkR1dURoTzZzQU5nSWNRMXMxalVjV2kvTWl0Y1JoSDRaams4bjZLL0t3?=
 =?utf-8?B?TjdYTFRLcFdKY2lKUndWUGZhTVRVYnFWYklCam5kYUkzSEVVcXAzeHEzUEd0?=
 =?utf-8?B?MlRkMmsxVkpsN3RQL0FjUitVYVh4ZVVrVjF6N2h3UTZudzNQNzR4MDh2eGRC?=
 =?utf-8?B?bSsvbXhrQkwydlowSEtMdWI3U1RJVHlWeVJLd3NGUzNlelRvazZWU3lSMk9B?=
 =?utf-8?B?VGY4U2JFMWVua2NBMktRa2FwK1dSMnE2VUFHMDFDcVpqUzUwOGZ2M0k5aDdo?=
 =?utf-8?B?NDhaaGNqVlVzSmJvNmtJcENlbkVXQ0ljQXNkcjl2MjFMa2lCaE9tRnFhamFh?=
 =?utf-8?B?b2pVZUFoMmc3U0hmTmRwSVBtS1FqajMwTUppVmRiM1QvWnhBS0RKWmJRNFZp?=
 =?utf-8?B?eTZWR1VJaExZNkRlQTBGQjErV2hHTm9RS1prM0s3Um1TY28rQkZnbFU2S1lo?=
 =?utf-8?B?cFowZ1FQM0VLdHA5UEJiY3o5akVGVUduendPZzVHdmlsWkRDMmI0QWtkMzFE?=
 =?utf-8?B?RkF0dm1PcEU3bWRxTFE5a3FheTJXeXRVenZSajdrdVgwU01zOTR2WWlxOUlE?=
 =?utf-8?B?TzlDNUg2NmVFdlY0S3hxdVZidklvSGFQdXNJK1hxdDRGbU9CMlV6K1JGQldx?=
 =?utf-8?B?T1d2VjZEbGR4MHViTEpnR2xaNTdnUmY5eGRGSWhCWDZhQWo2OThHTmgwRlhq?=
 =?utf-8?B?MXVrMllJUE5TK3ZZYkR6NTcrUDBPNGlxeFNQU0JEOS95YzA5Qk5Oc0tiNVlR?=
 =?utf-8?B?SnhJOGNZSVRqdUZpMGdhR3ljR2ZXMEJUcExXSWNvYUFtelVHNlhSMXRkak5K?=
 =?utf-8?B?TUxQMUpaczVtM29aNEFab0Z3NUVpUDB5NmhMU29HeHJTSGg0aytaSW1WaVZ3?=
 =?utf-8?B?cmFZUGpRNCtPamVESHFIWXZyYXlwMHA5ZHJhb2tHM3ljaDJSOUlwdy9zYkNp?=
 =?utf-8?B?VEdkbDAyV1Q2TkpQdkdWZ1dtLzlRbU1QNXRBVStYWjA3VnMyL2tJVDRXWWN3?=
 =?utf-8?B?WmJjUTAxZkpmZEY0SnJSR1RLMVB5Nlozd0tkL0w1Q0RUU1p1OHdsTXBhUEh3?=
 =?utf-8?B?cUZodnJUb1hpYS9Qakh1M0U1MDhNUENKU2pRbFRlNmRCNVNGS0dNR0ZNK2ll?=
 =?utf-8?B?WUNQcUlBaEJoUEhVMVhXaDZyTWNsMXg2MUdSaC9sZEllbzlERERRYlJ4N3NT?=
 =?utf-8?B?MFFzL2poNUpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlBYU3BPK0RKZm02b1dIalpOTW80NnpQRGlHd1R1aTVNSkNVS3BxNmxDaE85?=
 =?utf-8?B?Zk94REpjZytkaWNLdG5LeHdtUThuZmJCTUdoWmxuY0hidG1VUHB0Q1NZYmhl?=
 =?utf-8?B?RnhodE5MVlE2ZjkyaUl1dDhnakVUZ3NIckZ2RjZBeGpQMkREb2NoZEszbUpu?=
 =?utf-8?B?S3FISmZQUnJHQ21ocDdlUGwzdXVjRFdqelBHUUsxUGxhSkJJVFBQSUROMVZJ?=
 =?utf-8?B?d0JuME4yeExPNlE1M3h2Sm9CT2NaRDdaUEhPY0ZPbXNoZTlOVVd3cmpVUWUv?=
 =?utf-8?B?dFFZclo1SGc3WFJKbWhJZTVIYWdLQWorMXdPZ3lqbmtYSWVRc3UrYzhqd3B3?=
 =?utf-8?B?alF0VGk1VVpLbGM2YlEvTkVpc2pLQzJvSnZLb0dXS2ppNzhodjFSZkxnQlZy?=
 =?utf-8?B?NUxYT3JIeUVvVUZjSkdnelVLd21RYVBpaElpL1l5RTRNMXpXMFM5MFhrWlBD?=
 =?utf-8?B?eXl6d0UyZUhTbThxbHhvN0hQZGNXY2FrQ2lKckczV0xZbTh2bmpXNElqQmJy?=
 =?utf-8?B?cGVCYmtyd0dmSUFQZVJDUHF5dlJTVDk4ZzRHNzRSMXJJRUJ0T0V0VXgzbFdY?=
 =?utf-8?B?TmE4bURWYXFwaXptRkJCZUZKSlAzRWk5bUFYd1V2NWFWQkJTQW0vOGJFRUpB?=
 =?utf-8?B?UVVlbENMM1VMTk5GMmxYWnp0SDZEZEpHMnpwMXlaVksvQWR4MHJlS2YyQXVq?=
 =?utf-8?B?eDFmU2NSakdWWWU2Q1ZwUHBRVzFLc0kzeGpnUU01c0ZENGg3WUJEeG5pSEV6?=
 =?utf-8?B?UFZCS09iaGhPMmxQS256WGtWaTV4c2pTR21qdEd2N1dGK0xEcUUyckhIeG5h?=
 =?utf-8?B?eGFUR0x3c0E5djJvLzRDTGJyMVdSMDZvMFMxSzFrRWVFekg2U0ZhTVNTRk0y?=
 =?utf-8?B?c1FnOVhMdHlCWXN0cnJIZm1RUy9kOElRcSs4dnkzK1kwZldKYTYvMzArS3F0?=
 =?utf-8?B?amttZ1dxd1JJaEhLUG9wQit2VzJoc1RTNkFPSDJMMnNobnhKNTdVSFBTRS90?=
 =?utf-8?B?ZXNrS0JyQ3ZHQ215VDZwWlZ6V2dCVjcrOU1reFo0WGhJSGVDOGtoSWJqSDlz?=
 =?utf-8?B?dEVQM1RHMEVaVlU5WGZlK3h0ZGV4NUtlV3JEbklMQ2o4UzBGV3lpdS84RUh5?=
 =?utf-8?B?WDAzdUdxQUVRSEdZL21VUzRwVHNWcFdxWUZNWXRzaTdEZnNSc3JWT2FlNndL?=
 =?utf-8?B?dXdMOVluMG9OeWZJcG9DTldFZHFsL1UwNExYcXhJcGczUWpTb3FrOFpKbHl5?=
 =?utf-8?B?ZGxaZFVqWTAvY09IRnAvdWl1eU11aXZnMWxFbGNuNnluR1hzN2F6eU5XZ0xs?=
 =?utf-8?B?S2ZreXAzRmNnWlJUMEVGU2xuRXFjb3ZvVEFPUU0vYU9CNUlCWmhtamNGV2Ji?=
 =?utf-8?B?bkFxU1FRMS9iclh2WGt2NWxvenM5Um9xcDdwOUNwVGxQNkRaRVE2OEpIcitV?=
 =?utf-8?B?NkJSZC95TElyMTRIVmY3ekRLaXdhbjBxblVvYnk1TUxMSjZUM0h3Yjc4S1F1?=
 =?utf-8?B?UTJ5WVVXeTN2UUg0endDbkZjcVhGdW5uWkhaeDlvODhsVlBkcFNEN0tJeFZy?=
 =?utf-8?B?blNwT3hzUTB6RnhENDNqVHBKdFMrSk9pVTc5TzdpUEdLdE9aeGZBb3ZKOVJH?=
 =?utf-8?B?K1I4dHF4Wm11YWFEZUw1Z2MyeDFTMlhEQzZjS2FqWXBkaWtnU1N6bDVDK2pj?=
 =?utf-8?B?djJibGpuL0hPbXV3QlZRakc3elpsRFl1TnJDY29RcUhzUWRzOVBESzc0SGs3?=
 =?utf-8?B?TTgzUlVlSDJkaVJ3K0ZjS0V5enlrL2xrNjhTVEd0OVpsWmtSVUpJMzRRYUor?=
 =?utf-8?B?dUZKdDRjcUVpLy9VdUppS0tVZW5TbUlCRzRhZi8xK2p1MnkrVE8rd0x1VjFm?=
 =?utf-8?B?YTNNc01EbmR0eXFjNWF0TUpRcm1acnNhRGJubXVGaW1yZjdjRHlWVGQ2T3dX?=
 =?utf-8?B?ZXJUY2t3djJDT2Zwd0dzZjNQN1A0SlRsMWtUOHVxeFRQZE15T1U0TmJQb0Iw?=
 =?utf-8?B?MUZBQXdOWWJwYUJaNlZYWTJDckRrWFRvUW9ndUlyRmUxTmJLT1MzNnJjN0J3?=
 =?utf-8?B?MlVhM0VLdVVTdDF3cFVrcndlTTA1OVNaV0p5UXptQm56OVNMdjloNnZndVZq?=
 =?utf-8?B?VEpsY3NKbHFlRDV3Rjd1WTVJbnlhTFMzN0p6VmxwWStlM3Urei9LQmJ3ajhQ?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0981FAA288C84AB0ED1E0792F5C37C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bc3DNhuWDnoOE8wqwiSycd2xjFJlhp1C9uhbgBNiSpTTJ6zb43WrFLhGtsnptliwLF/BFYEK1p4sQh4X+j5gtn28fEB+rujrOTkZbfTyvZoSr6YvUSdMMV11QNpzT0hyIuUyx7gCYO3Km7GFW4fUtt7zAcU9fMIS5AVdnibdqXIP6M7DvdeAan7cLDT3z0fvljI1q6MGAtvBiluaLOuWxN+CWVKcVvifXCy7or/xtLbSkHAsnfuy9PgSrXFy4ujtR3SrOebgWgk1LjFTlGRkgTVhk/DpXTGWA8jJlObs6yDtB1DM3C8Mf87+//vBPtWXCOIbtKKbHvWrBqQE7mNTIhY2KbiT58tNaM4KbMBwOs07zL9AL36R1KNNmS/fqE6TbugCIdc8+7v5Zt9RFwxI2hIKaAPJ3nAfBVwXFBZoK10WVx04WTg+ENgcJoj6bvI+3XS2vP6Isd0RtgcspkYhJONHnQxgSdyqICOoDAjWmyK27zGCsz+srldHsLOvQ/xsZAOFIHiXlqQruoyXA5I3WmLXmarXsRyAOM8a0vgOk+FgLT0hz2zz1CrAlmBqGsqY23seKbDQhB/i8o/drpOBt3SLip52iBsqZSXvwhJcxkXIGJV9sfVPWJ2Hh077Mp9Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3005d9-609a-4487-310d-08ddec0ca09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 23:41:53.4731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NjqYYcPqsnqReg50LTlOnfxDmoSNPxzzSD3n+t90aDcaHZ9Cd8/K5CWEYR4SiM4vFAruNTwktSFp6aDpgyYqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8263

T24gV2VkLCAyMDI1LTA5LTAzIGF0IDE1OjUxIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLMKgIDMgU2VwIDIwMjUgMTE6NDc6NTcgKzEwMDAgV2lsZnJlZCBNYWxsYXdhIHdy
b3RlOg0KPiA+IFVwY29taW5nIFdlc3Rlcm4gRGlnaXRhbCBOVk1lLVRDUCBoYXJkd2FyZSBjb250
cm9sbGVycyBpbXBsZW1lbnQNCj4gPiBUTFMNCj4gPiBzdXBwb3J0LiBGb3IgdGhlc2UgZGV2aWNl
cywgc3VwcG9ydGluZyBUTFMgcmVjb3JkIHNpemUgbmVnb3RpYXRpb24NCj4gPiBpcw0KPiA+IG5l
Y2Vzc2FyeSBiZWNhdXNlIHRoZSBtYXhpbXVtIFRMUyByZWNvcmQgc2l6ZSBzdXBwb3J0ZWQgYnkg
dGhlDQo+ID4gY29udHJvbGxlcg0KPiA+IGlzIGxlc3MgdGhhbiB0aGUgZGVmYXVsdCAxNktCIGN1
cnJlbnRseSB1c2VkIGJ5IHRoZSBrZXJuZWwuDQo+IA0KPiBKdXN0IHRvIGJlIGNsZWFyIC0tIHRo
ZSBkZXZpY2UgZG9lcyBub3QgcmVxdWlyZSB0aGF0IHRoZSByZWNvcmRzDQo+IGFsaWduDQo+IHdp
dGggVENQIHNlZ21lbnRzLCByaWdodD8NClllYWgsIHRoYXQncyBjb3JyZWN0LiBUaGVyZSBpcyBu
byByZXF1aXJlbWVudCBmb3IgYWxpZ25tZW50IG9mIFRMUw0KcmVjb3JkcyB3aXRoIFRDUCBzZWdt
ZW50cy4NCg0KQ2hlZXJzLA0KV2lsZnJlZA0K

