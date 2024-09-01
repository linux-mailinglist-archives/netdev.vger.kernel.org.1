Return-Path: <netdev+bounces-124010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6D9675D2
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8641F21B5D
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B465914A61B;
	Sun,  1 Sep 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="HziycG0s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1C1F951;
	Sun,  1 Sep 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725184303; cv=fail; b=RdDw3Q2eDKwZtzkf2HYSBnNd4Tv6CNDt80H8tbDFgHAbNb2XB21Lc5cffk1s3pzPFb8BPovNwJ0XZg9LzDHHZzN2PaRqUNisUJLQJTUvlD75pWHHr1UnD3hS7B/j4IwXbFywZOKCnCGmGunRcEnvkDXcNs/sglbBR67Qspm0a2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725184303; c=relaxed/simple;
	bh=XTJBDM95LiV9GVIanfELiJdolKYkCRrwmp75LniCMEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SllaM520/uc3n7ExynvzYtls4bf3LVzIOJ3bj4krrnAqiBDo9LgqP7gnAXNCm3MHSq5lj0tN1b0VyedLUis+N3GohDcigPZ+fnQVjJWnZwj679kWvIOc50Uc9cZCbfgZSo+R2a5PNZAyTlpWXLUHEVQE3flpUu9mKvG3ZXINDoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HziycG0s; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4817lEXF012052;
	Sun, 1 Sep 2024 02:51:19 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41c2pgt7c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 02:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+/UcJjxaG4tUuubCcLZ1QJ1RTlZ2hfnpCV8TyzoKGAabXqqppmBEMcgBvqyLiY2iFpr2quCmhJ41Nm0oDkuOUQVIG8zUY727+dhe1T1SPUbyzwK/46X4fze6e6KnMif5y837b5gai91J62sf1LCF9W18YSnIwWoNXBXpeQ+FJAlUoD7DQFbSMneHStq89zfA7pv8cAEQTuVfMGP/WkZkzEnqXGFn+dZKQdP8DigBqvhT7oh0T5Zg0SJQch/AS/C+j+AR56fDEbTsHqevzkYn9G482+IyOKKBXkI/iwdGpVAHjLv1hqcCV4YZAT23Bj7wGrLDtdllMfj9cfCyhm8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTJBDM95LiV9GVIanfELiJdolKYkCRrwmp75LniCMEs=;
 b=nK3XL/9/Tbtv60SjZDFSXCc9JpCVyV7uEC2Mcvf5sxn1M4mNY70pqfZG8nMUl1pvvM1f7uqXH0/6u8V+woUOm9jq6O8cLVhLYilJSx3YaXhxIbKN4Kfi2XWulvy77ue3OAT0tqtiCJ4ww9SuSwLQW9hgcdV36FDy9hcP/3v5NVKxbnvhfGlofpcGMTjeJe85p+8K55iWb4g4mJFATk1/If1YwAYUTbagpXLNWuwXoJ8JHnocFN4Wqd28AveMnluj6rw1j7j1QrBFOPMRODWY8g2WK21v8EUh1j2WSiHmy3hho6aRytLovRA7FvyYbsaLGBGKTHRTcebohWx3Y0P+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTJBDM95LiV9GVIanfELiJdolKYkCRrwmp75LniCMEs=;
 b=HziycG0s5TF4XHjWayT7UdJIbRYhe1zfeOWJhv5wuCdqZlG52KHNzozcb5GMC7rC7+k7Swe2Fk/FcHInyeV6AFMKWZOVXi3QHKQ7zaevOGFbbHCSZ6vv7JoeSPdAmrrbjr+1jLIm0+tLGqzayDas0+5f3RNfrBbWRvo9y1PNkO0=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH8PR18MB5265.namprd18.prod.outlook.com (2603:10b6:510:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 09:51:14 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 09:51:13 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v11 08/11] octeontx2-pf: Configure
 VF mtu via representor
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v11 08/11] octeontx2-pf:
 Configure VF mtu via representor
Thread-Index: AQHa9JYy+qpHMqYMykSQBg/SKF2WFbIzVKqAgA9qQ/A=
Date: Sun, 1 Sep 2024 09:51:13 +0000
Message-ID:
 <CH0PR18MB4339B4BC68CABDAC3C5E4DA4CD912@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240822132031.29494-1-gakula@marvell.com>
 <20240822132031.29494-9-gakula@marvell.com>
 <ZsdJ-w00yCI4NQ8T@nanopsycho.orion>
In-Reply-To: <ZsdJ-w00yCI4NQ8T@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH8PR18MB5265:EE_
x-ms-office365-filtering-correlation-id: 1162ace0-d66e-46c3-a26a-08dcca6b9db5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ymw4VVFzL0hrWUtEQlQvclVsR0lMbnZHTmZLaXhKV0p4aHh1dE1EblhKK1dX?=
 =?utf-8?B?dnU5Q1Q4Rys3cm02ZEM1VmZRVndEcDZXT3RQQmZLM25hRVZacGJ4Y1k1Vk5i?=
 =?utf-8?B?UmpydjArVVNXcFBad2t1ZXVpSjUzRHE5VUppeGtNVFFSeENhRE1kNVp5dnhh?=
 =?utf-8?B?a2xRSXNiczk2WTBKNWNDYkJwb21QcGtybi9qaHFiRnYxWXFrOHVBdU96ZXc4?=
 =?utf-8?B?RzByenFhZ0JBZWpGS1ZYNTIxU2FqL0tLaTRjOUx5akI0Y0NxM21sQ3FuZFBs?=
 =?utf-8?B?dUNFY1lTSUx3Q3JVWVJxby9ST1IvNXBONTArK2t1UDk2YjBEcDdRQ0FVWUEz?=
 =?utf-8?B?b2VlNnlweGFhZWFZOWx4eHNtaWpjRkM3VEtjMm9ha29DTEhiTFRUNTJEYVZj?=
 =?utf-8?B?MnBySCtyVjlMUmJqdVRPcWkzL1ZjeDVnZEhCZGxPbXMwak4rek50MzA1UXp4?=
 =?utf-8?B?M3FEaWI3d1owN2ZRUmFZYnNUWklHNzNYbFJxSmtBWVE2bTFqeWdZaDQ4aXk0?=
 =?utf-8?B?eW1wMDNGTE5oTFc0YXhQNkxRQldsYldLZVRqeTNQSUpiMWFDeWFzMFpBUGlM?=
 =?utf-8?B?cFVjTW14dWk1ZGNkTzZ5cVVROVZtR3dMb0o1UnhnSHJ4VEZCZGorcGtuZGcw?=
 =?utf-8?B?MG9WUkxBSnd4c0tQUWRBRi9jT0FoUG44VVhGVVRGTGZoVUt6NElROGNPaEdZ?=
 =?utf-8?B?UWx6N0N1eHpqeDI5c1dCMW0wczFjbnlaZ1dnaGNBVytYTSthdjRWZEh5cmtT?=
 =?utf-8?B?bVhuUkRHUG5pVE4vWktGZ1B4WHZSMEtOTGVPREVBVHo1UXZqRXhBVWlDV2pu?=
 =?utf-8?B?RUtHdUdIVU9DemM5V0Z1eVZYYnVpeVhaanJqeWNka21nYmRPRk5UejkyaE1r?=
 =?utf-8?B?ejJ3VzQvMlVrZm1kVmRJZzI0UENEUU5rbTk0ZHZvckkxdlZ3aGhKR3dVdEU4?=
 =?utf-8?B?MzViZ3lLQWFkUCtqeHhXTFMrUmw1c3V0ZWFVaWc1a00wUys1NkpoVjRXa1F5?=
 =?utf-8?B?YXMwYWw1ZlpyM0hzQ25KWkFZeFhFN2J0alBvT3JHcjRlTUhRZlBmWmxla0lZ?=
 =?utf-8?B?dy94cjgzQU50ZFhlekNhcUI0WWVsSE42NVY2Sy93WmJOaW9telNFbDhoQXhT?=
 =?utf-8?B?bzVRWFVMTk03aGEyOGRaS09oQzhJTGxPSXFRYmQ1bk5GNTVHa0RDK2J4THhm?=
 =?utf-8?B?YzUvdU1IbkRuNDJGSzF6K3JCM1ZFN1p4b2ViVHUvdm44aTJGajFFOXlsSmxj?=
 =?utf-8?B?NldJSTdjSmhaQWpmVE95MVcxVFRVL2g4L0lhTTVJd1Y4MDFFOGgyVEtGenRV?=
 =?utf-8?B?N21hQ0t2YVRIR3FvVzJVcXcwTGh0UXV4bjFHS3lNdVpPdFJLOFVoWGcvUTVX?=
 =?utf-8?B?UnQ0VWRvT3VYQUd4ZEhVT1JBcVpKaERsbnBUSEJCSUtiUUhYaG5aQlhKRjBv?=
 =?utf-8?B?U01kZ3dhZU43Y2xWaDJjUTNBbVg3Nm9QdUpveC9YOFFoa2tiTmdpMTZMUWtq?=
 =?utf-8?B?MDlvYkJpNDdnakI5cnA5a2xLcFAwczlWL0x0MEZyZ3cxUTlLTGtSWXlwTjMr?=
 =?utf-8?B?M2pVMnBSZ3pKY0kzSnFlWlVxbDlJR2prblh2eUM2WWRIWFZ5WHdUR2RUNmE4?=
 =?utf-8?B?Si9MR0ZNQXlzVjd0b0tqc1JDQlk4V0NqUXJvTENjeHNkRmw0QTlJRzJrakJ3?=
 =?utf-8?B?ZnBlMTNhVWlLaU0waWoxdzA5Mk8yWlJ2TFRQek5sWjlOeVV4Y0dZbTVmTFBo?=
 =?utf-8?B?eFFsbStnSWFKaERjZFE2YmtKbFljbk1iSXIxeDd5dUkwVTE1THZmOWhYSHh1?=
 =?utf-8?B?dUxjamZiTTErb3FwQTVhZXVGbHhQWEhnclhRUGdhRldKYy9QQWhBNi9YU0Va?=
 =?utf-8?B?VE43Skk1cE5mdXgvZ2lmdTVJb1o1a1FrYVMydllyOWh3bGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N01CZUlhei84L2tGNm9FRHg2Wk80emE1ejhaNHJlanl1RUMzbnZPS0RSUkJa?=
 =?utf-8?B?UmtuVmRBeG11MnpMay9odzRyMFNMT1Z1Ny91T04vazNNZkJwVkgyUzBoR0dQ?=
 =?utf-8?B?amdoWmE1MkIvcHRaNytKUlB0YWhHZWRnRlVqeUVtcEh6cy8vNWlMcnFnVGUy?=
 =?utf-8?B?aW9Pd1lJaWxYelVVdmtrUEpRY3VHczRqL3ZncHduMkJ0a1AvQ3YzTGVTMXRS?=
 =?utf-8?B?eHcvVnljTEp4ajNKdmluSk5rMCt0UVVXQjBDKzRrRGJoeFJid29yOWFmbGNl?=
 =?utf-8?B?aUxKb0JQTGsvOWZ1OGpyUmtWWFlxYzZJdmZjZ1hFSklwdEpzenhxU2MwK1JW?=
 =?utf-8?B?b1J3ckIwV21JbXFQOWEwbmdkbzNsMjhIdDNycFp4NFVzQkZPY1JuVE52OEE3?=
 =?utf-8?B?OEgwYkx6ZGphVzFsT0FuYk0yS0pRelFLeitmeEp5K1M5VVJ6WjlpT3FOL1lt?=
 =?utf-8?B?NVNYdlFQdVN6UW1rL0hxQlpVSXJuemcvQUtpcnlnVXRWSUpGdzk3Vk52UWZi?=
 =?utf-8?B?czQ0YjNKbXlzYXVCaHFYUTJIMHFtZFlKc0NQVlpKbkNLZVhvT08rSHNPRkJ2?=
 =?utf-8?B?R2RvQlRKNDEvNnVBWmZkdHlUdHRZRVBsRTV6NEltbWtNcGRld3hrdjV2ak56?=
 =?utf-8?B?ZDZ0NmE5S3NOTFl6NXdUOFNyemdqQ2NBT0hiRWtSWll6by9adUtxejEvY2Jv?=
 =?utf-8?B?MEhKMFZMVVVNVTZiTDQ2TDJsTTBqOGl2TzA0OXo2TTk0bm9JZHlOMHd6YmZV?=
 =?utf-8?B?ZS8valRQT2d2RER4WHlkamtSVWw0cFFNOUxmLzVmeC9ySDQ5U3dqWnEwSkd6?=
 =?utf-8?B?b0liWUZGV1NDNWtBSG9uTGZCYjN4MnhNSG9MdFJaTUUveGVzaXlSdDN5YkJ3?=
 =?utf-8?B?S2lZcEIvM1d4bEZCY3U3SWIrRHNWYWZ6S01GYVJxRW0xS291NzN1U2xPUnQ2?=
 =?utf-8?B?T2lrYXhCbytYeWtvc1VjSFExMmQvK2dwZG1PV2lyd3UrSHhYU0xnTUpVTFBU?=
 =?utf-8?B?UTE4Rmd5cUoxV1paRGF4OXVUK0xuZDB2a01UbkJjUVZ3OWhEMjQxUFAwSk5O?=
 =?utf-8?B?ZE1BSmdkNUsyZzhJU0JEVVNnMk8yTFlhdGo2Y0ZDdWxpQ21FZUp6MkhRRFFF?=
 =?utf-8?B?MVpSOFdZOVNGYS91SFJDaHl6ajdTYzdic1cyZDI4Z0pjRVpkWWxJTENTaVo4?=
 =?utf-8?B?ek5BcEJFVXI4M2dvN0ZoM3ovYU02b3VzelpGaUUzNC9TQkRHV1dmQ1BqaEJR?=
 =?utf-8?B?NklRdFArVVF3UzV5MDBQOVBoeCtrUHJlZFdEd2UyTWtJZXNoSEVkRTZlTjVB?=
 =?utf-8?B?bUhnSUZKeXhDUVNTQ1lMc2F6YTEzODF3NFpVNXd4bTlSbjd3TFptdmxOT0l1?=
 =?utf-8?B?K2Zra1lKODJqSW01bGMwRldMTHRFTUhYb0g0Y1BFRlpFWlFSMFEvWlF1cnBy?=
 =?utf-8?B?M2hOUXRZYUFsQ0t6UGV1bjNidWE4RGRhTXh6K1dJWEtvZ1BzWTgrUThlRUIv?=
 =?utf-8?B?bWNzZVFIZ1pKUUVUSkVxQ2hVOUo5N3djejNuNklPckxkejZtRFNZMkxJNitM?=
 =?utf-8?B?SUMxSjZpbUdjZDR3SmI5SGJGYys5L3V3OU54TUtnSlAyMmpBcXQwYy9HeFJB?=
 =?utf-8?B?cmRxbTd1V3labHg0SlppeDBwRDVSd2cyRitodWZzdlkrZDgzb2kxZlNYU0pu?=
 =?utf-8?B?NkgvMlZDYmFrWldlSUhrY3pUak54OWJ2dWJveEJpVkIzL083WDdBVThwQ1Iw?=
 =?utf-8?B?OWJoNWxYZndSbmtWU0dZMWNpUnNhWDBKcDFCbllja1BKbVZIQkhFaE9uenc2?=
 =?utf-8?B?emIzUExGbWx3dzcxdFp3Nk9uMjFXeXliczdIWjRqcHQ3VC9mdjEvTzJndW9t?=
 =?utf-8?B?eXBsTDQzbjl1ekdYS3VyTHFZNlhmMFVjRVQzWGdQbXFqZ1RHVk5MZzY3TGQ4?=
 =?utf-8?B?d2pvYllSa0JmUmcxaFMra2lpMEZtSExsNUhpM05TaFEvZXB4cFdkMTNkYzJi?=
 =?utf-8?B?K2tFN0M5R1RaTlI3YlJrQUczRHhiUER6ZjNrU1IxU2lCcnJpbmt2OFhNMytj?=
 =?utf-8?B?Zm1kN1JxNUdaTmxzTGdvRDYrQnlNVFpvcFBjbWU2aHFVQ21ULytFanIwcUQ1?=
 =?utf-8?Q?kV14c0VicOaWTlWQZ9KwiBaeA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1162ace0-d66e-46c3-a26a-08dcca6b9db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2024 09:51:13.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KygMy0Z97iTIBf5JDf8shh5s0SByU53Smly2q+/WvVucx/cRMGDyu8jeJbvwWnRdNNszKUzx0Pl3oJOzIyDOLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5265
X-Proofpoint-ORIG-GUID: pTSmFsU7u9O9ENLiDBz8Uj3WCfb26U_4
X-Proofpoint-GUID: pTSmFsU7u9O9ENLiDBz8Uj3WCfb26U_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_04,2024-08-30_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCA3OjU0IFBNDQo+
VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2Vy
bmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgU3VuaWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwu
Y29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBI
YXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogW0VYVEVSTkFM
XSBSZTogW25ldC1uZXh0IFBBVENIIHYxMSAwOC8xMV0gb2N0ZW9udHgyLXBmOiBDb25maWd1cmUg
VkYNCj5tdHUgdmlhIHJlcHJlc2VudG9yDQo+DQo+DQo+VGh1LCBBdWcgMjIsIDIwMjQgYXQgMDM6
MjA6MjhQTSBDRVNULCBnYWt1bGFAbWFydmVsbC5jb20gd3JvdGU6DQo+PkFkZHMgc3VwcG9ydCB0
byBtYW5hZ2UgdGhlIG10dSBjb25maWd1cmF0aW9uIGZvciBWRiB0aHJvdWdoIHJlcHJlc2VudG9y
Lg0KPj5PbiB1cGRhdGUgb2YgcmVwcmVzZW50b3IgbXR1IGEgbWJveCBub3RpZmljYXRpb24gaXMg
c2VuZCB0byBWRiB0bw0KPj51cGRhdGUgaXRzIG10dS4NCj4NCj5OQUNLDQo+DQo+Tm9wZS4gSWYg
eW91ciBwYXRjaCBkb2VzIHdoYXQgeW91IGRlc2NyaWJlLCB0aGlzIGlzIGNlcnRhaW5seSBpbmNv
cnJlY3QuDQo+DQo+VkYgaXMgcmVzcG9uc2libGUgb2Ygc2V0dGluZyBNVFUgaXRzZWxmLiBJZiB5
b3Ugc2V0IE1UVSBvbiByZXByZXNlbnRvciBuZXRkZXYsDQo+aXQncyByZWxhdGVkIG9ubHkgdG8g
dGhhdCwgeW91IFNIT1VMRCBOT1QgdG91Y2ggVkYgTVRVLg0KDQpXZSBpbXBsZW1lbnRlZCB0aGlz
IGZlYXR1cmUgYmFzZWQgb24gdGhlIGtlcm5lbCByZXByZXNlbnRvciBkb2N1bWVudGF0aW9uICJo
dHRwczovL2RvY3Mua2VybmVsLm9yZy9uZXR3b3JraW5nL3JlcHJlc2VudG9ycy5odG1sIg0KIlNl
dHRpbmcgYW4gTVRVIG9uIHRoZSByZXByZXNlbnRvciBzaG91bGQgY2F1c2UgdGhhdCBzYW1lIE1U
VSB0byBiZSByZXBvcnRlZCB0byB0aGUgcmVwcmVzZW50ZWUuIChPbiBoYXJkd2FyZSB0aGF0IGFs
bG93cyBjb25maWd1cmluZyBzZXBhcmF0ZSBhbmQgZGlzdGluY3QgTVRVIGFuZCBNUlUgdmFsdWVz
LCB0aGUgcmVwcmVzZW50b3IgTVRVIHNob3VsZCBjb3JyZXNwb25kIHRvIHRoZSByZXByZXNlbnRl
ZeKAmXMgTVJVIGFuZCB2aWNlLXZlcnNhLikiDQoNCj4NCj4NCj4+DQo+PlNpZ25lZC1vZmYtYnk6
IFNhaSBLcmlzaG5hIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4+U2lnbmVkLW9mZi1ieTog
R2VldGhhIHNvd2phbnlhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+PlJldmlld2VkLWJ5OiBTaW1v
biBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+Pi0tLQ0KPj4gLi4uL2V0aGVybmV0L21hcnZl
bGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMgICAgfCAgNSArKysrKw0KPj4gLi4uL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVwLmMgICAgfCAxNyArKysrKysrKysrKysrKysr
Kw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+Pg0KPj5kaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0K
Pj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMN
Cj4+aW5kZXggY2RkMWYxMzIxMzE4Li45NTVlYTk0MWE1M2IgMTAwNjQ0DQo+Pi0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMNCj4+KysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPj5A
QCAtODU0LDYgKzg1NCwxMSBAQCBzdGF0aWMgaW50DQo+Pm90eDJfbWJveF91cF9oYW5kbGVyX3Jl
cF9ldmVudF91cF9ub3RpZnkoc3RydWN0IG90eDJfbmljICpwZiwgIHsNCj4+IAlzdHJ1Y3QgbmV0
X2RldmljZSAqbmV0ZGV2ID0gcGYtPm5ldGRldjsNCj4+DQo+PisJaWYgKGluZm8tPmV2ZW50ID09
IFJWVV9FVkVOVF9NVFVfQ0hBTkdFKSB7DQo+PisJCW5ldGRldi0+bXR1ID0gaW5mby0+ZXZ0X2Rh
dGEubXR1Ow0KPj4rCQlyZXR1cm4gMDsNCj4+Kwl9DQo+PisNCj4+IAlpZiAoaW5mby0+ZXZlbnQg
PT0gUlZVX0VWRU5UX1BPUlRfU1RBVEUpIHsNCj4+IAkJaWYgKGluZm8tPmV2dF9kYXRhLnBvcnRf
c3RhdGUpIHsNCj4+IAkJCXBmLT5mbGFncyB8PSBPVFgyX0ZMQUdfUE9SVF9VUDsNCj4+ZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9yZXAuYw0K
Pj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9yZXAuYw0KPj5p
bmRleCA5NTMwMWZhZjZhZmUuLjVmNzY3YjZlNzljMyAxMDA2NDQNCj4+LS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL3JlcC5jDQo+PisrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9yZXAuYw0KPj5AQCAtNzksNiArNzks
MjIgQEAgaW50IHJ2dV9ldmVudF91cF9ub3RpZnkoc3RydWN0IG90eDJfbmljICpwZiwgc3RydWN0
DQo+cmVwX2V2ZW50ICppbmZvKQ0KPj4gCXJldHVybiAwOw0KPj4gfQ0KPj4NCj4+K3N0YXRpYyBp
bnQgcnZ1X3JlcF9jaGFuZ2VfbXR1KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBuZXdfbXR1
KSB7DQo+PisJc3RydWN0IHJlcF9kZXYgKnJlcCA9IG5ldGRldl9wcml2KGRldik7DQo+PisJc3Ry
dWN0IG90eDJfbmljICpwcml2ID0gcmVwLT5tZGV2Ow0KPj4rCXN0cnVjdCByZXBfZXZlbnQgZXZ0
ID0gezB9Ow0KPj4rDQo+PisJbmV0ZGV2X2luZm8oZGV2LCAiQ2hhbmdpbmcgTVRVIGZyb20gJWQg
dG8gJWRcbiIsDQo+PisJCSAgICBkZXYtPm10dSwgbmV3X210dSk7DQo+PisJZGV2LT5tdHUgPSBu
ZXdfbXR1Ow0KPj4rDQo+PisJZXZ0LmV2dF9kYXRhLm10dSA9IG5ld19tdHU7DQo+PisJZXZ0LnBj
aWZ1bmMgPSByZXAtPnBjaWZ1bmM7DQo+PisJcnZ1X3JlcF9ub3RpZnlfcGZ2Zihwcml2LCBSVlVf
RVZFTlRfTVRVX0NIQU5HRSwgJmV2dCk7DQo+PisJcmV0dXJuIDA7DQo+Pit9DQo+PisNCj4+IHN0
YXRpYyB2b2lkIHJ2dV9yZXBfZ2V0X3N0YXRzKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykgIHsN
Cj4+IAlzdHJ1Y3QgZGVsYXllZF93b3JrICpkZWxfd29yayA9IHRvX2RlbGF5ZWRfd29yayh3b3Jr
KTsgQEAgLTIyNiw2DQo+PisyNDIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vf
b3BzIHJ2dV9yZXBfbmV0ZGV2X29wcyA9IHsNCj4+IAkubmRvX3N0b3AJCT0gcnZ1X3JlcF9zdG9w
LA0KPj4gCS5uZG9fc3RhcnRfeG1pdAkJPSBydnVfcmVwX3htaXQsDQo+PiAJLm5kb19nZXRfc3Rh
dHM2NAk9IHJ2dV9yZXBfZ2V0X3N0YXRzNjQsDQo+PisJLm5kb19jaGFuZ2VfbXR1CQk9IHJ2dV9y
ZXBfY2hhbmdlX210dSwNCj4+IH07DQo+Pg0KPj4gc3RhdGljIGludCBydnVfcmVwX25hcGlfaW5p
dChzdHJ1Y3Qgb3R4Ml9uaWMgKnByaXYsDQo+Pi0tDQo+PjIuMjUuMQ0KPj4NCg==

