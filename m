Return-Path: <netdev+bounces-166879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEAA37B63
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 07:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21FD3AE242
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339B185955;
	Mon, 17 Feb 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PmIruMRy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367A383A5;
	Mon, 17 Feb 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773912; cv=fail; b=LK/s5pL5U/K21Tc1EA4qmQuG8uKaDLKKZThT8o3qk4PN4i0987jywjwjiuC+/XJueydC8ZH8Gu2XZXNiqP+I/oWsWmXow0qte/y1K5l4JiWcMX5pomJHXL4wYWYM2723xbSEQC7DDpt7IyG5QjDy1A/eVdWu7Nxz7b1FZs6KR0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773912; c=relaxed/simple;
	bh=SYgCkyLPipJjYShw5rUTAIw01MPCmCDoMb/cifqRhKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LxZDqbwSNsgj9eQyRBWclnm3PKiAl3XueKzSfA9oWT/9FzJKI+6V/FDCestDR1wKZIVnA1eqwSPVrw12pYwPc1Ou5UN0O4qmo8JcpTsltKUoxO3LQSMhcm3+tGMC3kNEdxkf0JjhWXoOJx8sDTvm4m2RLGCA53Kul97G78JmoI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PmIruMRy; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H3fKuI012476;
	Sun, 16 Feb 2025 22:31:28 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44ucja9ex8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 22:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0k01MaK8fY9E8G6RREfmUe3I+fysI9K/J9Sbd5MR14GtGfbMuwy6zcxAeMQMnTEyFBAYKQjUGi2eNgmPci8lq2pv5kH1bf63mjmsM8VqDrTO4etRpieSmJNk+ZWFzlAIgH1JarHcAYxKlnHBPldgNoZnhsoy7DqhMXnxltj6C4bPKKSki0uWP1AnS8xqDxSjERReOZz3mqp8HcA+aOnhw7d+O5UhT3Ee9cLHBd6/aDsaBTAejgsUBy3WiQpv8NYy3pR5JHQ/0INbdZPn/tZ8kCtUCd6jQFRulBqGEUbHRyJCaDpBBY9gpjFGLQmyGV7wdZEK9VFPq8eS5YPuZN46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYgCkyLPipJjYShw5rUTAIw01MPCmCDoMb/cifqRhKU=;
 b=naRFcEUmFOREQ5w5o6AOEvil9zC9ePjWhMf7D6zJMIEVF0KghdJm3PyeSCfC2J0kwkMpI9ja5N1vFEXJ8TocQ9vT42FVdUqinngkus6gMeTaVQQGtF9p88dGiXiz4DG9DzLoL4Gq9d/aTQg/VkKsqzXhkMGLmjSDk0GI21r2OxGeo8eCgqVmFKNXoCY2eu8b6RpcI26ZcQHLEQQTqqkPaFsr9bzUuDcQTAEPpfWXtQ1/UnfO0wZkyrDlvxIn0w8Z3ops0lu8jc/Ku+sisqmgWwpBcy+ejGvJWLIqD9nwwYog8JtC6+3zz3fUpPkvBHq3HCREq2yGZT0otJ62JKWleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYgCkyLPipJjYShw5rUTAIw01MPCmCDoMb/cifqRhKU=;
 b=PmIruMRyplSByV8aRgOiQnRITuATAprGWagbg/DVakxs+HP5Sev1sVUoduBNo2YzgYPxXml0om/L5dMRRhVECJut+S+8sE37ZvGoJOze2N4F0oIuvqmu2Z9FTu0Ze9PhptdcGkwI5Urhk2ECINih1BQwcDg2hpuxxC9ecgDw+Y8=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by DS0PR18MB5480.namprd18.prod.outlook.com (2603:10b6:8:165::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 06:31:25 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 06:31:24 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: kernel test robot <lkp@intel.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [net-next PATCH v9 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Thread-Topic: [net-next PATCH v9 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Thread-Index: AQHbgQWRMtc/Mc3i+kG5Scp2xD0cPw==
Date: Mon, 17 Feb 2025 06:31:24 +0000
Message-ID:
 <BY3PR18MB4707F0997944E778112A603DA0FB2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20250213170504.3892412-4-saikrishnag@marvell.com>
 <202502142256.5RFZmK7u-lkp@intel.com>
In-Reply-To: <202502142256.5RFZmK7u-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|DS0PR18MB5480:EE_
x-ms-office365-filtering-correlation-id: ca503a2e-8848-4688-789c-08dd4f1cb39a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|13003099007|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmRKcjR2MnhCTlVlOVpSeGFGdFhaeGcwcitMVnhpUmNSbEo2VytEUU1BR0JS?=
 =?utf-8?B?cUFvSzNhZXRNelpTTUpkZTdWU21GeWVRSTAyQ0VqZFRBYUlUWkxnVGYrK0xK?=
 =?utf-8?B?UmRjRTJRWjVucEg4Sis0Z2tCSWlTK1NVc2N3VXl1Tm5jUXVzVmcxb2YzcS94?=
 =?utf-8?B?cWtZUzFCSSs3VUJ3ZXp3S0lVSFVrU1VMTzRVMmJsZisrTWYwNElxeWttSXQv?=
 =?utf-8?B?VFN0OUJMSHZxSWJKK3ZueURqNThGbTZDeFNpTUx0NERuOFhyTXJYMDBCVVRL?=
 =?utf-8?B?dDdFamt1d2p6SEFVekN6UVNZdElXZHZnLytBMUtkRjVqWTh1blZESmprUGl1?=
 =?utf-8?B?WUJQSzd2emZDZCtwUlZKUjI2N1lEOWVvQmZnenhwaTBpcUQ4RVJ4Y2M5amts?=
 =?utf-8?B?TnVSZEsrbkhmc3hlVEZhMzdmQnRtcHdEOC9PdnhZQUVXRlJpOXVOMnhoRmV5?=
 =?utf-8?B?d2JIMG9aSWF6aEc5QlI2QVRubWsrNzRwTmgyb0M0dEw1eGtMTzJOd1dGb1lo?=
 =?utf-8?B?MTdvSHNJL1J2R2hvdGZwMFowQmREVStnMVR1OTY2aExnWGN1bmxUNzE0WktC?=
 =?utf-8?B?K1lWWTNTOStDUTl3TGlUd3lzRHVaYmF4cDJpKzdlMmx4WVdJZytBdWFQbWVV?=
 =?utf-8?B?MUdQVUEwWjdxS0l1eWZTcFFLWXJmdldZZ255TnZyVmRCaG5lSSszb0tFRHdG?=
 =?utf-8?B?by9kb0paeXJLcHBEd0hZZnJxVDl6YkI3NHF1QWRra2xJN29GSzduZHJid0Y5?=
 =?utf-8?B?c1I0bXBGaUZ3NGlwcG1VRWVka2xLSWpPNjZneHIwYkF1dml0OGl6RGtEclJm?=
 =?utf-8?B?RDZ6ZnBhWlVtM005WUIwV0F2L1N2M3QxQlFoaVRlNW55aXNYTDMxQXVtOHJU?=
 =?utf-8?B?SmJ1V0t6VXh4WDZMSUZKeGdGZkc4c3V0aW5jWGxMOTFrWThDM0NxOXkzVWZ3?=
 =?utf-8?B?TmZDREhGMStEL3ZhcXlsMkg5dnZNRlM2RjhUaWxjR0M5Y1diQmdFVS82bDFV?=
 =?utf-8?B?S0srbFR3NEFMU0sweWZhSWh3bzhzb241NnN2K1F5VlpXbi9tcFlMMEJxMXJj?=
 =?utf-8?B?aEM4WGt6ejk0K21CQWttenN3M1FJWGN1TkNtS3NwcUZDRGVmYzl1Zmo1TnpJ?=
 =?utf-8?B?c2JnblVDVG9iUG1nNkVOUTVWM3NQcWNFSTBnK3ppREZETVIweWt4bFVWeGlI?=
 =?utf-8?B?TGh4ckc3dnJHc0RPUXNySVp4Q1lCd1BoQ2RIVGFDZmkxVEduVXFpWFJzNUI0?=
 =?utf-8?B?ditJQTNuWTA4TUpXZUpyRzFiSmFRL1NtRTdObzlmYks4U24rUW5GQ3JzM0hE?=
 =?utf-8?B?NGVWMXdERHBQZzBqZ3ZoRlhHMSsvVms0VDdycVJUY3ZYaWJkOTVWbnErdGhI?=
 =?utf-8?B?V3NjdHQ1WDJWWkpRdys5S2NiVlNCTnRyWElxNFZrUHV6RHVLQ3hhdUFlSVMz?=
 =?utf-8?B?M1M2ajNGcnMvbGxadS90aUpzVzl0UGJBWktadVlzdHVwVkJ0TUZ1bi9BVStW?=
 =?utf-8?B?RTJabUtudEhMenlya2QxS1JTQkJ2Z1Z0cHg4dFhvZU9NQkpGL2tHWHlRc2Fr?=
 =?utf-8?B?OXk5elhUMWhPa1loYzZwbTBFWUtkS1RzQ245eUxJZ0VPbExPYjhzbTI0OTJX?=
 =?utf-8?B?V1c1VFhPUmo2cXpQM3QwQVFYcXM3c2R3V3hmOXorMGdrVEdpbjZzRTdtVmc0?=
 =?utf-8?B?b2xBaExiRWJkRXVReGxucWxnZitBTzZqYW5NU0lmQkdIYWlPUVljb0NIcDZw?=
 =?utf-8?B?WnFGVnZBMFpGc0oxK1hIdHZLRmZQSkdlQTl3K0lUZEp0dVluMG1aSFRIdlF1?=
 =?utf-8?B?dXN0aEUyODBtcXd3ZnRNOTQ5bWM1VEhnZlVjdzFBVVRmaGJBRkZSOE5hVG9j?=
 =?utf-8?B?anU4eUZyVkxXdlovdjd5MnVXVHlrMEwrbjIrbzREbzBRSTFONTlsUzlQVXky?=
 =?utf-8?Q?0CJKDKm/V5c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(13003099007)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW9Lc3kxcm5McW9NK1JCcmZLR3lZSEhsNSsyQXlKU2J3Vmt4RVQwOUk0V1U5?=
 =?utf-8?B?eERUcEtWbmtXM3RmY2hrZGVzc1FzZTYvdlVWZVgydUVSSTRzc1UxNDZBeUxT?=
 =?utf-8?B?YUwzZ0NNTkxzZFZiQW1ZZVY1bzgrS3ZrOFY3MDJ3dnVicDBnNXJrTk1FeWl2?=
 =?utf-8?B?VWRObGEwdmlTdlJqNVFrZzRmNHVLS1h4bGRKRFlsbWJPK2VJUDVvNlhpaWx6?=
 =?utf-8?B?QzdmcDhsUTgvTGxOU1dFd2hCSU95VC85MDFwUHhyNjhNZDh4WGZZOWdZb0VN?=
 =?utf-8?B?aGlYQWhwcGMwMTBHdldMSUl0dUVJTFJIQ2I3Sy9JZGtJdndJKzQ5eDJmSCs2?=
 =?utf-8?B?TXQ1aDFnQTM0MWlsZW10VFl5Wk0rZUJwcHRVVExRZG5QeTlKZ1k3bXNpSUVZ?=
 =?utf-8?B?TVJFRjd3NjZiSU9FWlk0T2ZObGdxMlFCczhHSzl5MnR3b2UvUUpxNlU4bGtr?=
 =?utf-8?B?SGM3OUF6RVFCV3NKdkw5dXRlOVZ0V2tNZU9DSThBT0RVWHFDcnZzRW54Q1pt?=
 =?utf-8?B?UkcwQWYyRkpSMG9rY3lPZmFsSjNZNWtDQ00wZ0tVb2dvd0NsT0I5NXhzcWdr?=
 =?utf-8?B?N1Q2OHFrWGxDZ2V3cGhwYVlIL01TZTNRSWN2c1RYd2RGNEt3K1VLQnZsUnEr?=
 =?utf-8?B?WnJTaGFWMDlHZXBwWTlybUd6MnN0QXhaeWdOSjRlR0N2TEdmdndhZjJjN1Bn?=
 =?utf-8?B?N29WZktSemx5ME1SZjFwRGd5a0VKR2FGR2d6aGZDTExmL045M25iN21JMmhx?=
 =?utf-8?B?K3NCNThFM1oxalR0SmViRnRaRzF2YUZSRUcvT3FGWGZCNlVrWHFJc2pTN2F2?=
 =?utf-8?B?NDMxUUM3WURDYXFraENlN0JwM0ZnY0huUGlEMjViNWp0TXNldlhpbTFhZk1U?=
 =?utf-8?B?SGsxeWowVHVEQlNFZ09GTG9uVDBqM2xWUnJtUFpzcXVZTUhXNFl4b3kvcXNU?=
 =?utf-8?B?YmxBcCt0ejk1T05QVVRXeTI5T1JlR2pMaHN6U1kvdSthMWpUQUMvbGNHZnNo?=
 =?utf-8?B?V0hIUFBIUU50c3BNZlQzMnkzTkpqNE1lNHlnOHNrdGpNd29nWkVvQWk1QXRE?=
 =?utf-8?B?N0Q4b2svakFUejcwUTdPQ3JEWG5za1lUWFUwNFBJK0tIVkhyK3R5U1loc3ox?=
 =?utf-8?B?MnhNRytZaTV3WmhsZjI1aEM2bDRxaU40V3ZOTFV3aGx1bitXK0Z3Mk01eGtF?=
 =?utf-8?B?eGludnBPS3h2Q3VjTW9CQU1BMG9qTGhwd09BUWVQeXJZdWVLTTJhU2JkYmRC?=
 =?utf-8?B?R3FoTEdrL1hZeDVXR2toenhNMjR6azFNMGFuTkN2MEp3NjhXL3hPb2cvQjlZ?=
 =?utf-8?B?U2NGOEh6cGtpcHgzcUFDSG1EQ1BYWXBabzJ3QnZVQ2FQM2FocG03Y21EeXdI?=
 =?utf-8?B?RjVqY3FEOSthMG1Gc2E4TFVFMlpNNXRSbGNaS2hJRTYyYllZRU9Ea0xYMW9U?=
 =?utf-8?B?OHdjajhqYlNKdVlOOVVNdVQycG92K09wc2ZXQnFyVlhSN2lPWTFzTkVQY1RO?=
 =?utf-8?B?WVVTUHBVYVlzWXVTMkY1WUxpSkljZEZDZnFlYisvL0NaL2svcXQ5a2dNVk40?=
 =?utf-8?B?WGFCeWR2VFVkY2RGL0paQTJmWnBPbnVJMGhYMWdjSlBIdnZFampYc0xiTEQy?=
 =?utf-8?B?L21uNkUxaWxqN3o1VjJHQmg2SEUrZk9aNFlZVzFvTU4vcXplQVdLMkhUUHdT?=
 =?utf-8?B?amVPM3V5eHhFTHBsaTZ6SVpNRXN6MFFKY0Q0TU9pcVlkb0xyb3ovR3RhRkRn?=
 =?utf-8?B?elNDODJDYW51K0VLUmM2dmdIeGlXenpyeWFjTGhEc296ZnEzeGtrOGVzRzVS?=
 =?utf-8?B?c1p1SG9DNy9QUE5UZ24wMXN4ZGZOR3dQRkNJMGhpMDUvVlZaTVo2aTZRS3kx?=
 =?utf-8?B?Ykl4MWtyWGQ0cUxpTTZ1RVd4dm9jcFh3ek00alcyRXhoTVhBZGdPN1l0U213?=
 =?utf-8?B?VWp4MnpQS2I0UUM1Nmx2MCtKbE5Lbk4rRXo3bHJiOE9jNmxlNGo5TmRsdGc0?=
 =?utf-8?B?dERmMDBITWhZVFlMVVhnQ29jTkNFZnJwcHVEdFJxaE9BamFmUEw0Mm4xaWti?=
 =?utf-8?B?cXZERk9sZXExd2ZvcW5ScGFHcm40YldOakRibXhnZjFrY2V2VHdxWk4vQXRU?=
 =?utf-8?Q?jH9xR/4Kc+qySQCTIUX6Gdt5j?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca503a2e-8848-4688-789c-08dd4f1cb39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 06:31:24.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6YBxV9q0L6+AfybGpM+MByhx/sucRfzMGr7Lgy7xdl5cpAVl/pjWaGp8SxQppmOLBsRAistbNaMshwqV0b4qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5480
X-Proofpoint-ORIG-GUID: I6mYrLLzP07N2pg5K4rxNb3qOTwXAa0Q
X-Proofpoint-GUID: I6mYrLLzP07N2pg5K4rxNb3qOTwXAa0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGtlcm5lbCB0ZXN0IHJvYm90
IDxsa3BAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE0LCAyMDI1IDg6MTUg
UE0NCj4gVG86IFNhaSBLcmlzaG5hIEdhanVsYSA8c2Fpa3Jpc2huYWdAbWFydmVsbC5jb20+OyBk
YXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5v
cmc7IHBhYmVuaUByZWRoYXQuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTdW5pbCBLb3Z2dXJpDQo+IEdvdXRoYW0gPHNnb3V0aGFt
QG1hcnZlbGwuY29tPjsgR2VldGhhc293amFueWEgQWt1bGENCj4gPGdha3VsYUBtYXJ2ZWxsLmNv
bT47IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5AbWFydmVsbC5jb20+OyBKZXJpbiBKYWNvYg0KPiA8
amVyaW5qQG1hcnZlbGwuY29tPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29t
PjsgU3ViYmFyYXlhDQo+IFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29tPjsgYW5k
cmV3K25ldGRldkBsdW5uLmNoOyBrYWxlc2gtDQo+IGFuYWtrdXIucHVyYXlpbEBicm9hZGNvbS5j
b20NCj4gQ2M6IG9lLWtidWlsZC1hbGxAbGlzdHMubGludXguZGV2OyBTYWkgS3Jpc2huYSBHYWp1
bGENCj4gPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiAgUmU6IFtuZXQtbmV4
dCBQQVRDSCB2OSAzLzZdIG9jdGVvbnR4Mi1hZjogQ04yMGsgbWJveCB0bw0KPiBzdXBwb3J0IEFG
IFJFUS9BQ0sgZnVuY3Rpb25hbGl0eQ0KPiANCj4gSGkgU2FpLCBrZXJuZWwgdGVzdCByb2JvdCBu
b3RpY2VkIHRoZSBmb2xsb3dpbmcgYnVpbGQgZXJyb3JzOiBbYXV0byBidWlsZCB0ZXN0DQo+IEVS
Uk9SIG9uIG5ldC1uZXh0L21haW5dIHVybDoNCj4gaHR0cHM64oCKLy91cmxkZWZlbnNlLuKAinBy
b29mcG9pbnQu4oCKY29tL3YyL3VybD91PWh0dHBzLTNBX19naXRodWIu4oCKY29tX2ludGVsLQ0K
PiAyRGxhYi0yRGxrcF9saW51eF9jb21taXRzX1NhaS0yREtyaXNobmFfb2N0ZW9udHgyLTJEU2V0
LTJEYXBwcm9wcmlhdGUtDQo+IDJEUEYtMkRWRi0yRG1hc2tzLTJEYW5kLTJEc2hpZnRzLTJEYmFz
ZWQtMkRvbi0yRHNpbGljb25fMjAyNTAyMTQtDQo+IDJEMDEzODE3JmQ9RHdJQkFnJmM9bktqV2Vj
MmI2UjBtT3lQYXo3eHRmUSZyPWMzTXNnclItVS0NCj4gSEZobUZkNlI0TVdSWkctDQo+IDhRZWlr
Sm41UGtqcU1UcEJTZyZtPXc0RGZIWElQN0FUVWg0NGZ2eXRZVHBTZ1JVVzZnOFpZeDZkcWZWT1Zj
Tg0KPiBVMkdQbXFlX21GbVVLdWhRX2F4UnVKJnM9c085cUFBSkpYNGxUZVFhUHBWbWdzZ25wUHZk
NklEY29pWWwxSQ0KPiBrR0JzUzAmZT0NCj4gSGkgU2FpLA0KPiANCj4ga2VybmVsIHRlc3Qgcm9i
b3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yczoNCj4gDQo+IFthdXRvIGJ1aWxk
IHRlc3QgRVJST1Igb24gbmV0LW5leHQvbWFpbl0NCj4gDQo+IHVybDogICAgaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fZ2l0aHViLmNvbV9p
bnRlbC0yRGxhYi0yRGxrcF9saW51eF9jb21taXRzX1NhaS0NCj4gMkRLcmlzaG5hX29jdGVvbnR4
Mi0yRFNldC0yRGFwcHJvcHJpYXRlLTJEUEYtMkRWRi0yRG1hc2tzLTJEYW5kLQ0KPiAyRHNoaWZ0
cy0yRGJhc2VkLTJEb24tMkRzaWxpY29uXzIwMjUwMjE0LQ0KPiAyRDAxMzgxNyZkPUR3SUJBZyZj
PW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1jM01zZ3JSLVUtDQo+IEhGaG1GZDZSNE1XUlpHLQ0K
PiA4UWVpa0puNVBranFNVHBCU2cmbT13NERmSFhJUDdBVFVoNDRmdnl0WVRwU2dSVVc2ZzhaWXg2
ZHFmVk9WY04NCj4gVTJHUG1xZV9tRm1VS3VoUV9heFJ1SiZzPXNPOXFBQUpKWDRsVGVRYVBwVm1n
c2ducFB2ZDZJRGNvaVlsMUkNCj4ga0dCc1MwJmU9DQo+IGJhc2U6ICAgbmV0LW5leHQvbWFpbg0K
PiBwYXRjaCBsaW5rOiAgICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJs
P3U9aHR0cHMtDQo+IDNBX19sb3JlLmtlcm5lbC5vcmdfcl8yMDI1MDIxMzE3MDUwNC4zODkyNDEy
LTJENC0yRHNhaWtyaXNobmFnLQ0KPiAyNTQwbWFydmVsbC5jb20mZD1Ed0lCQWcmYz1uS2pXZWMy
YjZSMG1PeVBhejd4dGZRJnI9YzNNc2dyUi1VLQ0KPiBIRmhtRmQ2UjRNV1JaRy0NCj4gOFFlaWtK
bjVQa2pxTVRwQlNnJm09dzREZkhYSVA3QVRVaDQ0ZnZ5dFlUcFNnUlVXNmc4Wll4NmRxZlZPVmNO
DQo+IFUyR1BtcWVfbUZtVUt1aFFfYXhSdUomcz1xdHdoeDJENnhCcEZRSzBqMDFhbEUtDQo+IHB1
UEhVdUUxUWZtdW00bDJsN1NNWSZlPQ0KPiBwYXRjaCBzdWJqZWN0OiBbbmV0LW5leHQgUEFUQ0gg
djkgMy82XSBvY3Rlb250eDItYWY6IENOMjBrIG1ib3ggdG8gc3VwcG9ydA0KPiBBRiBSRVEvQUNL
IGZ1bmN0aW9uYWxpdHkNCj4gY29uZmlnOiBhbHBoYS1yYW5kY29uZmlnLXIwNTEtMjAyNTAyMTQN
Cj4gKGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4g
M0FfX2Rvd25sb2FkLjAxLm9yZ18wZGF5LQ0KPiAyRGNpX2FyY2hpdmVfMjAyNTAyMTRfMjAyNTAy
MTQyMjU2LjVSRlptSzd1LTJEbGtwLQ0KPiA0MGludGVsLmNvbV9jb25maWcmZD1Ed0lCQWcmYz1u
S2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9YzNNc2dyUi1VLQ0KPiBIRmhtRmQ2UjRNV1JaRy0NCj4g
OFFlaWtKbjVQa2pxTVRwQlNnJm09dzREZkhYSVA3QVRVaDQ0ZnZ5dFlUcFNnUlVXNmc4Wll4NmRx
ZlZPVmNODQo+IFUyR1BtcWVfbUZtVUt1aFFfYXhSdUomcz1sZTVFaENkMHV0RTRqVEV4RTlkbkhT
N3FCTGtXSUZrOHhSRw0KPiBNYnBHMElsYyZlPSkNCj4gY29tcGlsZXI6IGFscGhhLWxpbnV4LWdj
YyAoR0NDKSAxNC4yLjANCj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToNCj4gKGh0
dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2Rv
d25sb2FkLjAxLm9yZ18wZGF5LQ0KPiAyRGNpX2FyY2hpdmVfMjAyNTAyMTRfMjAyNTAyMTQyMjU2
LjVSRlptSzd1LTJEbGtwLQ0KPiA0MGludGVsLmNvbV9yZXByb2R1Y2UmZD1Ed0lCQWcmYz1uS2pX
ZWMyYjZSMG1PeVBhejd4dGZRJnI9YzNNc2dyDQo+IFItVS1IRmhtRmQ2UjRNV1JaRy0NCj4gOFFl
aWtKbjVQa2pxTVRwQlNnJm09dzREZkhYSVA3QVRVaDQ0ZnZ5dFlUcFNnUlVXNmc4Wll4NmRxZlZP
VmNODQo+IFUyR1BtcWVfbUZtVUt1aFFfYXhSdUomcz1PN3ExOEYxWUt6bERNRVZxRGplZWRWQ3I5
akRpaUNGcklnZWI3DQo+IGVJUjVldyZlPSkNCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3VlIGlu
IGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNpb24gb2YN
Cj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncw0KPiB8
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gfCBDbG9z
ZXM6DQo+IHwgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19sb3JlLmtlcm5lbC5vcmdfbw0KPiB8IGUtMkRrYnVpbGQtMkRhbGxfMjAyNTAyMTQyMjU2
LjVSRlptSzd1LTJEbGtwLQ0KPiA0MGludGVsLmNvbV8mZD1Ed0lCQWcmYz1uDQo+IHwgS2pXZWMy
YjZSMG1PeVBhejd4dGZRJnI9YzNNc2dyUi1VLUhGaG1GZDZSNE1XUlpHLQ0KPiA4UWVpa0puNVBr
anFNVHBCU2cmbT0NCj4gfA0KPiB3NERmSFhJUDdBVFVoNDRmdnl0WVRwU2dSVVc2ZzhaWXg2ZHFm
Vk9WY05VMkdQbXFlX21GbVVLdWhRX2ENCj4geFJ1SiZzPTRzMg0KPiB8IG1ldHVMdlRkNzJ5S1Zq
Zy1fWnVTNUhpV3dEeV84Rkd0akpNVElEZFkmZT0NCj4gDQo+IEFsbCBlcnJvcnMgKG5ldyBvbmVz
IHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9udHgyL2FmL3J2dS5jOiBJbiBmdW5jdGlvbg0KPiAncnZ1X2ZyZWVfaHdfcmVzb3VyY2Vz
JzoNCj4gPj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmM6
NzYwOjI1OiBlcnJvcjoNCj4gPj4gJ1JWVV9BRlBGJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4g
dGhpcyBmdW5jdGlvbikNCj4gICAgICA3NjAgfCAgICAgICAgIHBmdmYgPSAmcnZ1LT5wZltSVlVf
QUZQRl07DQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn4NCg0K
W3NhaV0gQWNrLCB3aWxsIGZpeCBhbmQgc3VibWl0IFYxMCwgdGhvdWdoIFJWVV9BRlBGIGlzIGRl
ZmluZWQgaW4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1Lmgg
LCBpdCBzZWVtcyB0byBiZSBtYXNrZWQgDQpieSBDT05GSUdfREVCVUdfRlMgY29uZmlnLg0KDQo+
ICAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dS5jOjc2MDoy
NTogbm90ZTogZWFjaA0KPiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBv
bmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4NCj4gICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmM6IEluIGZ1bmN0aW9uICdydnVfcHJvYmUn
Og0KPiAgICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnUuYzoz
NDk0OjQ3OiBlcnJvcjogJ1JWVV9BRlBGJw0KPiB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhp
cyBmdW5jdGlvbikNCj4gICAgIDM0OTQgfCAgICAgICAgIHJ2dV9hbGxvY19jaW50X3FpbnRfbWVt
KHJ2dSwgJnJ2dS0+cGZbUlZVX0FGUEZdLA0KPiBCTEtBRERSX05JWDAsDQo+ICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+DQo+
IA0KPiANCj4gdmltICsvUlZVX0FGUEYgKzc2MCBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbnR4Mi9hZi9ydnUuYw0KPiANCj4gICAgNzE3DQo+ICAgIDcxOAlzdGF0aWMgdm9pZCBy
dnVfZnJlZV9od19yZXNvdXJjZXMoc3RydWN0IHJ2dSAqcnZ1KQ0KPiAgICA3MTkJew0KPiAgICA3
MjAJCXN0cnVjdCBydnVfaHdpbmZvICpodyA9IHJ2dS0+aHc7DQo+ICAgIDcyMQkJc3RydWN0IHJ2
dV9ibG9jayAqYmxvY2s7DQo+ICAgIDcyMgkJc3RydWN0IHJ2dV9wZnZmICAqcGZ2ZjsNCj4gICAg
NzIzCQlpbnQgaWQsIG1heF9tc2l4Ow0KPiAgICA3MjQJCXU2NCBjZmc7DQo+ICAgIDcyNQ0KPiAg
ICA3MjYJCXJ2dV9ucGFfZnJlZW1lbShydnUpOw0KPiAgICA3MjcJCXJ2dV9ucGNfZnJlZW1lbShy
dnUpOw0KPiAgICA3MjgJCXJ2dV9uaXhfZnJlZW1lbShydnUpOw0KPiAgICA3MjkNCj4gICAgNzMw
CQkvKiBGcmVlIGJsb2NrIExGIGJpdG1hcHMgKi8NCj4gICAgNzMxCQlmb3IgKGlkID0gMDsgaWQg
PCBCTEtfQ09VTlQ7IGlkKyspIHsNCj4gICAgNzMyCQkJYmxvY2sgPSAmaHctPmJsb2NrW2lkXTsN
Cj4gICAgNzMzCQkJa2ZyZWUoYmxvY2stPmxmLmJtYXApOw0KPiAgICA3MzQJCX0NCj4gICAgNzM1
DQo+ICAgIDczNgkJLyogRnJlZSBNU0lYIGJpdG1hcHMgKi8NCj4gICAgNzM3CQlmb3IgKGlkID0g
MDsgaWQgPCBody0+dG90YWxfcGZzOyBpZCsrKSB7DQo+ICAgIDczOAkJCXBmdmYgPSAmcnZ1LT5w
ZltpZF07DQo+ICAgIDczOQkJCWtmcmVlKHBmdmYtPm1zaXguYm1hcCk7DQo+ICAgIDc0MAkJfQ0K
PiAgICA3NDENCj4gICAgNzQyCQlmb3IgKGlkID0gMDsgaWQgPCBody0+dG90YWxfdmZzOyBpZCsr
KSB7DQo+ICAgIDc0MwkJCXBmdmYgPSAmcnZ1LT5od3ZmW2lkXTsNCj4gICAgNzQ0CQkJa2ZyZWUo
cGZ2Zi0+bXNpeC5ibWFwKTsNCj4gICAgNzQ1CQl9DQo+ICAgIDc0Ng0KPiAgICA3NDcJCS8qIFVu
bWFwIE1TSVggdmVjdG9yIGJhc2UgSU9WQSBtYXBwaW5nICovDQo+ICAgIDc0OAkJaWYgKCFydnUt
Pm1zaXhfYmFzZV9pb3ZhKQ0KPiAgICA3NDkJCQlyZXR1cm47DQo+ICAgIDc1MAkJY2ZnID0gcnZ1
X3JlYWQ2NChydnUsIEJMS0FERFJfUlZVTSwgUlZVX1BSSVZfQ09OU1QpOw0KPiAgICA3NTEJCW1h
eF9tc2l4ID0gY2ZnICYgMHhGRkZGRjsNCj4gICAgNzUyCQlkbWFfdW5tYXBfcmVzb3VyY2UocnZ1
LT5kZXYsIHJ2dS0+bXNpeF9iYXNlX2lvdmEsDQo+ICAgIDc1MwkJCQkgICBtYXhfbXNpeCAqIFBD
SV9NU0lYX0VOVFJZX1NJWkUsDQo+ICAgIDc1NAkJCQkgICBETUFfQklESVJFQ1RJT05BTCwgMCk7
DQo+ICAgIDc1NQ0KPiAgICA3NTYJCXJ2dV9yZXNldF9tc2l4KHJ2dSk7DQo+ICAgIDc1NwkJbXV0
ZXhfZGVzdHJveSgmcnZ1LT5yc3JjX2xvY2spOw0KPiAgICA3NTgNCj4gICAgNzU5CQkvKiBGcmVl
IHRoZSBRSU5UL0NJTnQgbWVtb3J5ICovDQo+ICA+IDc2MAkJcGZ2ZiA9ICZydnUtPnBmW1JWVV9B
RlBGXTsNCj4gICAgNzYxCQlxbWVtX2ZyZWUocnZ1LT5kZXYsIHBmdmYtPm5peF9xaW50c19jdHgp
Ow0KPiAgICA3NjIJCXFtZW1fZnJlZShydnUtPmRldiwgcGZ2Zi0+Y3FfaW50c19jdHgpOw0KPiAg
ICA3NjMJfQ0K

