Return-Path: <netdev+bounces-253789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJBIB/CKeGmqqwEAu9opvQ
	(envelope-from <netdev+bounces-253789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:52:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA3921C4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648713025C71
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A33321DE;
	Tue, 27 Jan 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hAXiDgcT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EC278E63;
	Tue, 27 Jan 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507405; cv=fail; b=stHfI7W89Y19TQHqxTNidricswwiSI/gUx2+5u9arBEQGfk0Uqq8W8dMZ5N6asJp154sPi/HA/l2jlGH5ytyYeAt3/W7wedsd7h8gEFvcBzUKSYttT7cj6lCjTYYU0Jiz6xULx6xhaeigMvLcKqGYcqF59ZiwCV6glXSaH7LwAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507405; c=relaxed/simple;
	bh=b+YzuC45Phv1duRAr9n0dYFXksiA5lGixifDqr/VxJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDHjvcM/WTa2JP9ehz4ZUsWcTbFrBgn95uRYnLZ4J3yEPq2xrNgWs6w9mLFg4ONgvgQ3bUWPXpd/WatOBxfZEya6hvpm4g0ef739yDh2OZJCcPWo3rKMQ3A2yLR4OeLnSSCnChP6h/PPZQEdH3XDq4591cJXyewP/RLHlkSqTcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hAXiDgcT; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R5ZoxT204308;
	Tue, 27 Jan 2026 01:50:00 -0800
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022133.outbound.protection.outlook.com [52.101.53.133])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjn4ee-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 01:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJJ1uWNmZQLm+5QamTfFKhbRgxzvWRckJmGP3vvV9pQFYuPm6ac7DS94E0t2y89YG9/LKMTjFQkpFpWb3ssJBw8/aj+E2Y1lpBE0qOzcJk/l2G/XcNad7xAaavxfcEFY6I2+ERC6ON7EPW71HNrnwWby+dOLTJdOWhmQQ710CD4LJsAG0vKVElwcGMirx4duQC6Gfjn8rjvOIiRNJJO0LkAYy2rmjsGc6bBmLSIhIoY8lLQLix/7xhY7g8gJIe0dfL6qlMHL1ByExx1ppBZJ2NDgVmY9e/KiJQDh24NB8OjpplKfIQhSCH70CcYm4YYW3Bn1A7CSXOz8e0j9sa6TWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+YzuC45Phv1duRAr9n0dYFXksiA5lGixifDqr/VxJo=;
 b=u2RLQFryg7B2DwH98Sq3iM5yEjo4hrGNGkVz9G984zrVASO6scjhxLwetlX+VxgjbfO/zHWBT5CqxUH33Wyxp2Ei/ICP+CCHe2dkP/6E6nKU8YBlyT5GNn2GF+oT2UnJ8kvQ9tCXQNzfVcJ7qR9PY5MGdYocq16m46AsCSTHvWdtks9VXXXTFaY4Q5gTVhWqW0w463R6pc6Dt6VrfyPPI79rcemPaii4f600dzGb+okD5Y0Jh082mg+1lFRVW0jSMbVDwVbaiFLb9d2FBZgNPisNDou2/LhrpD9CNPyI5j1izbywc0jkWgyV8oFBto5Wv6dRx5rH6Tv2w7C1gFFieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+YzuC45Phv1duRAr9n0dYFXksiA5lGixifDqr/VxJo=;
 b=hAXiDgcTbQ/56oSusDfPXhTXCdL3zGhxgmpzXzIIkNBkxa0Emwad63LMWi1U67aQxnKduZ2pp7OChQbjI1kpLMZFPo7ba8A68xqIUdJEEMCLsd7Wtdc/yJ+52QlTM5R+KEY8WLZaWrC9d1n3WEB3ITu4Gfq6bqARqmbtyUaA7z8=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV0PR18MB927529.namprd18.prod.outlook.com (2603:10b6:408:33b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.6; Tue, 27 Jan
 2026 09:49:58 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%6]) with mapi id 15.20.9564.001; Tue, 27 Jan 2026
 09:49:58 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next] octeontx2-pf: cn10k/cn20k: Update
 count_eot in NPA_LF_AURA_BATCH_FREE0
Thread-Topic: [EXTERNAL] Re: [net-next] octeontx2-pf: cn10k/cn20k: Update
 count_eot in NPA_LF_AURA_BATCH_FREE0
Thread-Index: AQHcjzt1cvQv8UWfDESJOD5MYNwki7Vlwmmg
Date: Tue, 27 Jan 2026 09:49:57 +0000
Message-ID:
 <CH0PR18MB43395511F6E52A77CEF31F9ACD90A@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260126073015.29333-1-gakula@marvell.com>
 <20260127031600.3841572-1-kuba@kernel.org>
In-Reply-To: <20260127031600.3841572-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV0PR18MB927529:EE_
x-ms-office365-filtering-correlation-id: 879a0483-b467-4f0c-833d-08de5d896e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFEvUE1BZjhjak1NQ3pqbnNDZ0ZLa1Z4UENiRlNpb1FWNVlscGpKeU92eU82?=
 =?utf-8?B?Smw2OGZTb3dxKzJzNmw3ajN1OUswR1JxVDZUaTlvaEoveFcrM0JGdk85QzRC?=
 =?utf-8?B?eGpaZVBoTUhIaWMxVUhMVjFHVjhjNHJwNVNsazM2Rk00SEs3Tk1VVG1TWlY3?=
 =?utf-8?B?VzZ4cGF2VDVnVEhYa1hHWDF6RWRYOWd2YVJTbHcrd1BNenI5VnBONjVrL0FE?=
 =?utf-8?B?bWNocGt4dFVJanRYUUhqdHN5UE1pNjM1dmQxdUtnMmNVY1FuVUlLVkR1QjNi?=
 =?utf-8?B?R3hQWkkrUTlSd1FINm5EK0RRb3VWUnVEY3NtZlh1WGNXZXNheCtGRjlpMkdK?=
 =?utf-8?B?SkpiVFVOdUVMNzZuNEFybEtXTmxtckZ6VWozWStVbmNBaldoTTZJN0pBa0N6?=
 =?utf-8?B?VzI2OHFYZUI3ZWFHOUErcXFhNjRKQWVEd2dxR0xDSmJ6T1RvUzdrZ2tyc0FQ?=
 =?utf-8?B?cmRLcTRLVnB0SHh1dWFaWjFSdWRpNHJnUTh2ZUJGUDNFUndPNWdwamwwVi9z?=
 =?utf-8?B?L2xuMU9rdTFBSEYyM1BjTkFyb0RlM3FZZkloeXlUdkMvNzFYS3o1Vjh6SGo1?=
 =?utf-8?B?clVFcDN5a0dZMFkxdVV4NzlxSGsyQ2FzRW5EcWRmWE9PYk9KMVNBZFNBdWZI?=
 =?utf-8?B?K2dSd0JDelltRDRDRXdNZ3g3QWhKOHUzZnNzNVlSdjNONDhSc2NHV0FvNElx?=
 =?utf-8?B?TjhONkprQnJZSXVwQlU5TFJHN2FLczFxeTFweGM1UEZJZjZhRmJFejJTY2ZQ?=
 =?utf-8?B?N0w5K2t1dnY2Nlo4VDRFbXRPbWNZT2JrVnZOUk5EYkpFY3ZvYSs3OTloU0Zq?=
 =?utf-8?B?NGI2THhsUmc4cUcxUWxIUjFvQ0RURE0yTEdnNTh2VHBxYVdBUmNRU2lDL2xv?=
 =?utf-8?B?STVES1lPVW1wU2lNQnB6MmpnT1I3VVRrSUJrMTd2bWI1Z05xdjVOaTRIMDMr?=
 =?utf-8?B?VVdwWnJ3bnNGaUM1Y2pFa21wV3poMTVWNGdJT080MW1QOWNlMC9kQnhzbFNv?=
 =?utf-8?B?WU5IZ2pqYnRyaGF3WXNsbkVvTm5uam5lRUV4ckxieGlFeDZjellkUldmY0ps?=
 =?utf-8?B?TVR2eUFKTXZ5MUdRNnJRMkpKRWkwN0pjb09vRkR6WFI2SldpMm15TFIxRFhJ?=
 =?utf-8?B?QTRzUFF5SXF4S1NXcUEyclpTUVB4RnpCRWJQM0gyRDh1eTFHOGVDWFFYWnFk?=
 =?utf-8?B?cWV5SmQ0eHhSZFdXZlNoS0FlaTdXazJNY0NPblhDbjVTNmtsKzNXU1RYY3FG?=
 =?utf-8?B?bmt5V0tqS096SnpyeUZEcGc1dlpQWW5oc20rZk96TWxnbDIzcm1NdkR3Z2U0?=
 =?utf-8?B?TWZ5azhabUpiKzIvazM1T1BHSlpmSFZ6aTRiNXpQVmJabU4zRjJKVUxka1BC?=
 =?utf-8?B?ZUVTR0tjVmlyUW1TN2N4YjllMkhRdFdNUmNWWjY3d2ZZbWttZVJ3L2c3R0JP?=
 =?utf-8?B?WlhQUHE3YWhQN0xpODF1OEF0SXIvRXNsL1ZHb29FTHA1M1VtdXR6MVN3bmk3?=
 =?utf-8?B?Z0VUaEpUQi82L3hYN2o3WHdYUDUwRnRaRzRFcWp6Sm9hY2dkS3RQU1VLRVlE?=
 =?utf-8?B?dVlLQkRYa1FrRmV0TDhUWFpaY1VReUlEVXVlSW43eDdsSWJlZ2JGWVFtd3Br?=
 =?utf-8?B?QjZwRXljOWFSY3A0RjNXOGtmcWpLYVhEYkUzV0E4U3RWNEhhMGV5d241N2VF?=
 =?utf-8?B?dUZ3UUNZSkJGbVJWRUFNd1FjOXZhSE1pQlBZOTNRVkJnZU1DTWdLbjN0ZmFk?=
 =?utf-8?B?N1R6NUxTRGd4RlcwR3BhbmN4c2pUM0xIamdLZFJ2UkxFRVp1MVB6TGE4OG8z?=
 =?utf-8?B?UUhkZnlsTE9QZzNMZVBpREpsek41NWFNWGRTTnlsc2h1cEJTMUJHa2xVdTNI?=
 =?utf-8?B?MTZVZ2tWZERjcXJ3Nk14K0hVam9Dc2lSRUpvbzZuNHNoZEhmbllISVE2QTlt?=
 =?utf-8?B?Z2YwNHd0cnp4YVd6MGlQQWJNREVjQUVoTndLTFBWYkVHN0hHalVRTzFaMExW?=
 =?utf-8?B?WVBkQjdZekVjcmE3Q3RtQldqQU1udzBTTGJjY2NZNVFyWWkrcjQ4UFMwSHR6?=
 =?utf-8?B?OXQ2Y1drT29WSGlmY1YzblhzcjJBVDlyMGZVM0JEUGIzdXlKTHAramt1UDRu?=
 =?utf-8?Q?MAluTNbb+K8KMX2jw4Z3NUzik?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clJjWnBua0lURnlyRTBESHQ5L1MvOUNuMFhpcGI0a3BtL2lwNkdvWkJ0Y25r?=
 =?utf-8?B?WmFnMWhib1hNVThWRmFQRktTcUwxT2dqRkR3L2FZcGN4YzhmbGNzQUFjajZF?=
 =?utf-8?B?Znd5VExtRmtzZllBOUc2V3R6elVTQnRYUWRWVFlQZ0QzVEtIenJEa3BHMm1B?=
 =?utf-8?B?WjAyeUM0TXBQTFdjQTRRVitNNUJwQ3ZBaVkvWU5RbndWL21MS0R0TXFqNGN3?=
 =?utf-8?B?N1g5YzZ4QnhLbDN1THJDV0lSckovMTJURCtqelNXbHAvY1JOOC9TZVJBQVZ1?=
 =?utf-8?B?eWtXS2tmaVhKSC9mUmhodS8rWTFuckUyVFk2ditqN3BrREs5L2g3a09UVDhN?=
 =?utf-8?B?MDB2bzdWYlJ0N1JsTkJBNWVYd0orMWhDdWxNNytDajlIN0tINEpBU0lkSTFQ?=
 =?utf-8?B?S05tdEQ3UGN2Mi9SUXdLNDl6a2pVNWZ3SXVaemNScnExeHFnR2xMVGNoaytL?=
 =?utf-8?B?YXpVRnZDZjFzdDB2eW02Y2c4R0xPbGMrRFFha3RFOW5aZkVnWDNEMXJwUGRM?=
 =?utf-8?B?bUNHdUZCYWNWbkZyZXdQaWppRCtOK3FlQWQxN3RqMml5Y1Ixa3UxbGp6eGhL?=
 =?utf-8?B?SlFTRTZEYjl4ZTlObHJGNzJkVHNOMlh0Qk5JZ1A2ZTFiWmZGZXpBdWQ5b3BK?=
 =?utf-8?B?cmJ4cThhVWg1VWxia1RJMVpmMmFVTHc0bWVJdXRoV3k1MFNKM09vVjhlWHNq?=
 =?utf-8?B?QnlrVVpZNkxuQnRXTXlIWGlZOWdqUnU5L3lkenNIUjVzQ1VPL2VhUzhxaWRz?=
 =?utf-8?B?U2NqNFMyL1p2S0tOdWowRWNydzZMOFNnbnpnaTB2UlJGN2pFTnhDdDNtaE9l?=
 =?utf-8?B?RnViRVUrQi9MU2xzR2tPbmhHYncxT3RiV0J2WWFjelExZUlQeklOVU5CU1Er?=
 =?utf-8?B?NGV3Z3MxV2dPYVdwUysycityblFlYTV0ZW5VUHFiK1ZFL01MTzhOallKTEpG?=
 =?utf-8?B?anlZWlNPZXkrMVBWcm4vNzRDU1FjaFFkQlRldjh0ZDRETFc3VDNTaGNZMlZw?=
 =?utf-8?B?NEo3Wk9mdmU5WGRVOFZvd0Y0ZXdBQXZKVFFudDMzMURsN0NGY3Avc1dyc3NX?=
 =?utf-8?B?ZlB5bVFBNldKZjk2WDVzMWcrUjFtNUp2bmVQdkhwNVprSmp4R1d4UWpINTcz?=
 =?utf-8?B?aStwMlZiVlU5ZTU2NTFrdk5RK2ZHdk5mNExUeFI3SVdURVdTYlNjL3FoTkpC?=
 =?utf-8?B?MGtIbHFiaHpoNWJnN2RYNldJWFZqTFZRZEkya2FYa3E3UXpaTzJvamhTZ3V1?=
 =?utf-8?B?RnJreFc0S0Frd1RMV0tHU20wdzRGZ0ZacWgzNE9IK2lPZUdnbHovcllIbU9G?=
 =?utf-8?B?aktYSHltbzQxdjExVnR0cmxLUU4wR1d6TE0wREE3Tm5PdS9WaG5ocUFUN29r?=
 =?utf-8?B?SytaZGQxRVlDTjEwLzhkSmoweTh4MDhERFVuRWVyRTlIZndKOXk1REhKZERh?=
 =?utf-8?B?cEtab1AzQjJIS2NIYjlpRFhmS1hmRUhYQVBMcFN5RStUNDVlcmo2SjJZQVhL?=
 =?utf-8?B?TmhsTitWSTVMdW4yZno1WDVWWGtmbEhUZkVOYTIzQVJjamxuaDlKSCtaU3Vn?=
 =?utf-8?B?d0R3YlplMTdBMHJ2eWVWMHlBSmtYVW5oaWxaU1l6MmVnbTF5YXJINFNDYlR3?=
 =?utf-8?B?aEdrZ3FWR3BLcmE5a2h3VHdkSkJJV28wOU1GTG9teStYNlIyZDBsSG9BeTQv?=
 =?utf-8?B?bFE2clZFS0Jpd1lLSUFWazZxeXM2QTl6YXJVNUpwUEw5Q21Ub0tCSFQrdmVH?=
 =?utf-8?B?NE1lTVF6aGFJR2dyOEdwc2hCWGZaV2VaZzVSc09OQ1VCRXFuUEVRVWVZOFJV?=
 =?utf-8?B?em8reWRzRXhoVno1ZGRHdEIvcDdoNjAxcGFZZ3Z3YlpGZm8rZGxwNk1BOUU3?=
 =?utf-8?B?VlRXS0dmUlQrR1RDQUVRYldpYzNFTE80ODlpbWZCeUhWT3RoaUQrMzlZZXJk?=
 =?utf-8?B?bzUzTyt6MFRIVk5ERDlseWZ2SEVqNVdKaVZvTWRub3ZMUVBqYUR1RERSQlVz?=
 =?utf-8?B?SDFWSTRhRzlkR2hYWGxBeEdvM1ZRd1FpRkxQV0FLdVJWM25oODJhVDdQQ3Bm?=
 =?utf-8?B?SFhma20rcG5XbEhyaStuZk5FUnlTZnptV0dPZE1pK2ZRR2Q5b0VOV1l5OTlT?=
 =?utf-8?B?djNkdlVEV2pMYllIVWl2a1FvcEE4bk9GQXJqUWFmaVFzSzluekEzWGtnSUEx?=
 =?utf-8?B?L0huMFBaWHNBb1BxRGpYcVRpaCtYdkVBOUFtcFhWTlcwK0w5QjBicEJUcUFh?=
 =?utf-8?B?cE5lY0dHL3ZXbmE4SVNzY1RveVdxeVlmNU85WUFpelZCaGhXbkdpOXN6WUdI?=
 =?utf-8?B?L0M0anMrUzUvUFFGYjZOZ2RpamRQSTZuKzBWdURweVFRQk9MclVkcU5HU2RB?=
 =?utf-8?Q?P+h4IiBc/newsfU84MatG1SsdkEo1qd+Ad6/n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 879a0483-b467-4f0c-833d-08de5d896e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 09:49:58.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsEbBUaBHykiZ2y6USAW2pzfq3KwLTpBhQGDZ/2JIO57ub8Zzq6ksoEeaAWFaU+uUV3r/DDjt2mQu1BpqxWRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR18MB927529
X-Proofpoint-GUID: EfFAdHeKDOPE5IuibTOSyVo2zI0cNnUu
X-Proofpoint-ORIG-GUID: EfFAdHeKDOPE5IuibTOSyVo2zI0cNnUu
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=69788a47 cx=c_pps
 a=nXg1BFrUXdgPQNEnN+3bHQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=B8YKcIu03EdaewKlx7gA:9
 a=PRpDppDLrCsA:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3OSBTYWx0ZWRfX4emMvGWD7of0
 QOzl059mEhP73VIvDZEsh0MnZKbBsgMcrDdsxEU2nGYkCCkwUDa3i3bZsm2gr3mlirHhn9Et284
 oG4tqzvfyhd+Jwh8SoS10VRj9jPc4tPB1GIcLoNUvJz+15dPl+Z2siC/zwWKNgumWfOxR5jD/oq
 9wUFhmos0GSkQMmpHWrDOK8zh4wW4GT4DfvyoeVkxxPtGubkRWAKnH9cBm8tG1k/vThZKMe+QLJ
 f258tPoSGxha91AkWbWcXNBmOIVercyqGKtSqYLWo43xzy6Sy1Q40bLVaCyikK4z9xAXLKFdyso
 3W+hiI9a6q0LMRPH+FV1GG6G7h565kTTUJZ7vIqObcRAUGLzoK7UaX/YhnFjycvFOTOujlQ/rN1
 RG6+1jtKsl0J6m1S2apx7cLq4RIhzcC7gufye+EK4MkdQctyLqeadI1th7rZ8Z7QOBnwPpYPt0L
 1fMe8Bc9llkTJNO3O4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253789-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CH0PR18MB4339.namprd18.prod.outlook.com:mid,proofpoint.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gakula@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86CA3921C4
X-Rspamd-Action: no action

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+U2VudDogVHVlc2RheSwgSmFudWFyeSAyNywgMjAyNiA4OjQ2IEFN
DQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6IEph
a3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPm5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBb
bmV0LW5leHRdIG9jdGVvbnR4Mi1wZjogY24xMGsvY24yMGs6IFVwZGF0ZQ0KPmNvdW50X2VvdCBp
biBOUEFfTEZfQVVSQV9CQVRDSF9GUkVFMA0KPg0KPlRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJl
dmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4gc2VuZGluZyB0aGlzIGVtYWlsDQo+aGFzIGNv
bnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxpZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLiBGb3Ig
bG9jYWwgcmVwcm9kdWN0aW9uDQo+c3RlcHMgc2VlIGh0dHBzOuKAii8vdXJsZGVmZW5zZS7igIpw
cm9vZnBvaW50LuKAimNvbS92Mi91cmw/dT1odHRwcy0zQV9fbmV0ZGV2LQ0KPjJEYWku4oCKYm90
cy7igIpsaW51eC7igIpkZXZfYWktDQo+MkRsb2NhbC7igIpodG1sJmQ9RHdJREFnJmM9bktqV2Vj
MmI2UjBtT3lQYXo3eHRmUSZyPVVpRXRfblVlWUZjdHU3SlZMDQo+WFZsWERoVG1xX0VBZm9vYVpF
WUluZkd1RVEmbT1EOVoyMTRpQUhKMUZaU2c2MU5YcllrUUsyQ0xkdTJXM1dsDQo+eG1LeElmS19B
Q2ptUkREd0JxSHRibDRnX3BpcXE5JnM9QjlDeDEyQTF5MWViX25BRW05REJMNUJUVzBydWMNCj5j
bW9sbmJUUTk5TnZrSSZlPQ0KPlRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3Vy
IHBhdGNoLiBUaGUgaHVtYW4gc2VuZGluZyB0aGlzIGVtYWlsDQo+aGFzIGNvbnNpZGVyZWQgdGhl
IEFJIHJldmlldyB2YWxpZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPg0KPkZvciBsb2NhbCBy
ZXByb2R1Y3Rpb24gc3RlcHMgc2VlDQo+aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29t
L3YyL3VybD91PWh0dHBzLTNBX19uZXRkZXYtDQo+MkRhaS5ib3RzLmxpbnV4LmRldl9haS0NCj4y
RGxvY2FsLmh0bWwmZD1Ed0lEQWcmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9VWlFdF9uVWVZ
RmN0dTdKVkwNCj5YVmxYRGhUbXFfRUFmb29hWkVZSW5mR3VFUSZtPUQ5WjIxNGlBSEoxRlpTZzYx
TlhyWWtRSzJDTGR1MlczV2wNCj54bUt4SWZLX0FDam1SRER3QnFIdGJsNGdfcGlxcTkmcz1COUN4
MTJBMXkxZWJfbkFFbTlEQkw1QlRXMHJ1Yw0KPmNtb2xuYlRROTlOdmtJJmU9DQo+LS0tDQo+b2N0
ZW9udHgyLXBmOiBjbjEway9jbjIwazogVXBkYXRlIGNvdW50X2VvdCBpbiBOUEFfTEZfQVVSQV9C
QVRDSF9GUkVFMA0KPg0KPlRoaXMgY29tbWl0IGV4dGVuZHMgdGhlIGNvdW50X2VvdCBjYWxjdWxh
dGlvbiBmb3IgQ04yMEsgZGV2aWNlcyB3aGVyZSB0aGUNCj5maWVsZCBpcyAyIGJpdHMgd2lkZSwg
d2hpbGUgbWFpbnRhaW5pbmcgQ04xMEsgY29tcGF0aWJpbGl0eSB3aGVyZSBvbmx5IGJpdCAwIGlz
DQo+dXNlZC4NCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uaA0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uaA0KPj4gaW5kZXggOGNkZmMzNmQ3OWQy
Li5jNjAyM2UxY2U5MmIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uaA0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4+IEBAIC03ODksOCAr
Nzg5LDE1IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2NuMTBrX2F1cmFfZnJlZXB0cihzdHJ1Y3QN
Cj5vdHgyX25pYyAqcGZ2ZiwgdTY0IGF1cmEsDQo+PiAgCXRhcl9hZGRyID0gKF9fZm9yY2UgdTY0
KW90eDJfZ2V0X3JlZ2FkZHIocGZ2ZiwNCj5OUEFfTEZfQVVSQV9CQVRDSF9GUkVFMCk7DQo+PiAg
CS8qIExNVElEIGlzIHNhbWUgYXMgQVVSQSBJZCAqLw0KPj4gIAl2YWwgPSAobG10X2luZm8tPmxt
dF9pZCAmIDB4N0ZGKSB8IEJJVF9VTEwoNjMpOw0KPj4gLQkvKiBTZXQgaWYgWzEyNzo2NF0gb2Yg
bGFzdCAxMjhiaXQgd29yZCBoYXMgYSB2YWxpZCBwb2ludGVyICovDQo+PiAtCWNvdW50X2VvdCA9
IChudW1fcHRycyAlIDIpID8gMFVMTCA6IDFVTEw7DQo+PiArCS8qIE1lYW5pbmcgb2YgY291bnRf
ZW90DQo+PiArCSAqIENOMTBLOiBjb3VudF9lb3QgPSAwIGlmIHRoZSBudW1iZXIgb2YgcG9pbnRl
cnMgdG8gZnJlZSBpcyBldmVuLA0KPj4gKwkgKgkgIGNvdW50X2VvdCA9IDEgaWYgdGhlIG51bWJl
ciBvZiBwb2ludGVycyB0byBmcmVlIGlzIG9kZC4NCj4+ICsJICoNCj4+ICsJICogQ04yMEs6IGNv
dW50X2VvdCByZXByZXNlbnRzIHRoZSBsZWFzdCBzaWduaWZpY2FudCAyIGJpdHMgb2YgdGhlDQo+
PiArCSAqCSAgdG90YWwgbnVtYmVyIG9mIHZhbGlkIHBvaW50ZXJzIHRvIGZyZWUuDQo+PiArCSAq
ICAgICAgICBFeGFtcGxlOiBpZiA3IHBvaW50ZXJzIGFyZSBmcmVlZCAoMGIxMTEpLCBjb3VudF9l
b3QgPSAwYjExLg0KPj4gKwkgKi8NCj4+ICsJY291bnRfZW90ID0gKG51bV9wdHJzIC0gMSkgJiAw
eDNVTEw7DQo+DQo+VGhlIG5ldyBjb3VudF9lb3QgZm9ybXVsYSBsb29rcyBjb3JyZWN0IGZvciBw
YXNzaW5nIHRvIGhhcmR3YXJlLCBidXQgZG9lcyBpdA0KPmJyZWFrIHRoZSBzaXplIGNhbGN1bGF0
aW9uIGZ1cnRoZXIgZG93biBpbiB0aGlzIGZ1bmN0aW9uPyBUaGUgb2xkIGNvZGUNCj5wcm9kdWNl
ZCBjb3VudF9lb3QgdmFsdWVzIG9mIG9ubHkgMCBvciAxLCB3aGlsZSB0aGUgbmV3IGZvcm11bGEg
Y2FuIHByb2R1Y2UNCj4wLCAxLCAyLCBvciAzLg0KPg0KPkxhdGVyIGluIHRoaXMgc2FtZSBmdW5j
dGlvbiB0aGVyZSBpczoNCj4NCj4gICAgaWYgKCFjb3VudF9lb3QpDQo+ICAgICAgICBzaXplKys7
DQo+DQo+V2l0aCB0aGUgb2xkIGZvcm11bGEsIGZvciBudW1fcHRycz0zICgyIGJ1ZmZlcnMpLCBj
b3VudF9lb3Qgd2FzIDAsIHNvIHNpemUgZ290DQo+aW5jcmVtZW50ZWQgZnJvbSAxIHRvIDIsIHdo
aWNoIGlzIGNvcnJlY3QgZm9yIDI0IGJ5dGVzIG5lZWRpbmcgMiAxMjgtYml0IHdvcmRzLg0KPg0K
PldpdGggdGhlIG5ldyBmb3JtdWxhLCBmb3IgbnVtX3B0cnM9MywgY291bnRfZW90IGJlY29tZXMg
Miwgd2hpY2ggaXMgdHJ1dGh5LA0KPnNvIHNpemUgc3RheXMgYXQgMS4gQnV0IDMgdTY0IHZhbHVl
cyBzdGlsbCByZXF1aXJlIDIgMTI4LWJpdCB3b3Jkcy4NCj4NCj5UaGlzIGFwcGVhcnMgdG8gY2F1
c2UgaW5jb3JyZWN0IExNVFNUIHNpemUgZm9yIG51bV9wdHJzIHZhbHVlcyBvZiAzLCA3LCAxMSwg
YW5kDQo+MTUsIHdoZXJlIHRoZSBkcml2ZXIgd291bGQgdGVsbCBoYXJkd2FyZSBhYm91dCBmZXdl
ciAxMjgtYml0IHdvcmRzIHRoYW4gYXJlDQo+YWN0dWFsbHkgcHJlc2VudC4NCj4NCj5TaG91bGQg
dGhlIHNpemUgYWRqdXN0bWVudCBjaGVjayBiZSB1cGRhdGVkIHRvIHNvbWV0aGluZyBsaWtlOg0K
Pg0KPiAgICBpZiAoIShjb3VudF9lb3QgJiAxKSkNCj4gICAgICAgIHNpemUrKzsNCj4NCiAgVGhh
bmtzIGZvciB0aGUgZmVlZGJhY2suIFdpbGwgZml4IHRoZSBzaXplIHZhbHVlIGluIHYyLg0KPnRv
IHByZXNlcnZlIHRoZSBvcmlnaW5hbCBiZWhhdmlvciBvZiBpbmNyZW1lbnRpbmcgc2l6ZSB3aGVu
IHRoZSBidWZmZXIgY291bnQNCj4obnVtX3B0cnMgLSAxKSBpcyBldmVuPw0KPi0tDQo+cHctYm90
OiBjcg0K

