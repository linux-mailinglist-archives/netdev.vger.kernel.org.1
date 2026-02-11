Return-Path: <netdev+bounces-258242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLt/CZVRjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:53:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935D12302D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC878314EAD4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2371366DAA;
	Wed, 11 Feb 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="DHiJ42M/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F4366565
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803316; cv=fail; b=f/IYBNM/TTqLKZ+Uurp6L2XSMWhvvVqcGYEFSIavYH+Fm2SMb5W5H3ltB1fBD+7h1PYiEmtjcxV/es6JqnSKN78t3bgsX8Qad98w1mErdt1Mkiz886BGgqIEbRjK7ZSLmmhsgpF4vcWpSQk3zdCSduA43K2kic1NJY9oNrhRKf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803316; c=relaxed/simple;
	bh=CVqET2k0syNrbQtNHZrvBTU7BCti2EAFS3TQ9vOb5ao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NN9myExrMPWLQYH1Fi+vr7nvg1+MMUh1D6beD259ZID6sagCr/Df1tN6qczNLCraR1mZsUlfEVbdIDId77er/64j3GzEzRB/5JnAna4deZnc9kDTWwaBzHRM41MbMAS/BzRsHkQ7Qzsvkz/JZl3w4BMwcuh2Z7SAYU55gUFoifY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=DHiJ42M/; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B9bVov3984262;
	Wed, 11 Feb 2026 01:48:21 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022097.outbound.protection.outlook.com [52.101.48.97])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9cc848-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 01:48:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neN6k7g03bYjr+gQeZLQ93x1fz4IMDPmisBD8OizqGtObbKfnVjMsXdYhtE+QlaUbcE9go5+FSz9HZWENiomsVcLIb/cyoalIJHgxIO3Bx4SIjFlegEdIhY2Bj+1K08gtphl14+Qm1jP0rNChn3XrqPis19MvuP03IX3YLa1Veoi7MZuLq1d1EsfikWzeAqQj8Cqquxmsko0Sw1xbaGQ+ejPvCrbAV+BJ96pr35K125dzZZ0sq0jMIVpRhBIXd7fQnLRSbsO4TC9ipCrfBJM18Mcvh46vLtaXoRUn0Ghuu7B8AeIsnOGFvypVtJD+77et0ob0g2frufCZVDPp61ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVqET2k0syNrbQtNHZrvBTU7BCti2EAFS3TQ9vOb5ao=;
 b=LihcagB97mvINH9rw9yJ91MgGCtrEBUPk/fU0STuKUdh+MaPmvTl2pJv6Tw91XtNu8Z5z45yhmzzS4PZBNRhMv7zghvfmhRRKv81tQXCyh73ShXS5s5YCwHdEVLlP12RmJrmkuJ1NRoibl5QidSxYnO03YXVsF+LJG/TtA1RGyXtKMm9t9RP5cHXmX291qZA3akKnkM0yWvJ/jEzYQmhE5lmXh2EFExKaIUPfbcIkV5G/JhfZ5wgYVFnR7rAVdBiTPYdLw7UMcEYq+DLr0stm9/ZQDxK6+yA2abmkIwN2V6s3vsonb06xkc2M9xdjy+ZOWWt8IdB39C/Ka57Ejn6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVqET2k0syNrbQtNHZrvBTU7BCti2EAFS3TQ9vOb5ao=;
 b=DHiJ42M/SDw1vfTrw6S0D8q1g3y2NqdHsUv8+p24HowZbAOOXU/YR90dYPUe0qZ0cA5CLxaAgKjUUJyv6Yo8aR0kAqg7pazu/OKynIRE90BetNEQ5PePzT8rRcKbi13UMplpajY+WEwbbe1jJv0+PWejeO/3KoYXLMssEXLLrqk=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by BL1PR18MB4150.namprd18.prod.outlook.com (2603:10b6:208:313::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Wed, 11 Feb
 2026 09:48:18 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:48:18 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula <kshankar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index:
 AQHcl2Bnnph4NcKMQkKIjFDXE6aND7V2kJwAgABwn4CABiDWAIAACokAgAATjjCAAAUHgIAAAoDA
Date: Wed, 11 Feb 2026 09:48:18 +0000
Message-ID:
 <CH3PR18MB637958C2998761F3E8339800A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
 <20260207045416-mutt-send-email-mst@kernel.org>
 <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <20260211030643-mutt-send-email-mst@kernel.org>
 <CH3PR18MB637977B15CD77E0884DF56B1A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <20260211043542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260211043542-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|BL1PR18MB4150:EE_
x-ms-office365-filtering-correlation-id: 5979db5b-58e5-48e5-c44f-08de6952afa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTBJcEhTWmZIdFBIMWtXS1hPejFGM2ZzT1BmbnVZdE9uZEFoQXkwcUhFNTRN?=
 =?utf-8?B?NWxhUGJnMFVVbTZCeDVKMzgyaHowS1IyUGl0SGZxbm1rVjdHaDVrNGtwRGp3?=
 =?utf-8?B?OXg4d1ZDeXY0dzh0TjFMWExJVDVjMDlDSW8vdzNqOTl5WC9ZUXVEbDlwTDds?=
 =?utf-8?B?RWVxTzR1MG1tdXpmV2hJTXFRUXJyd2o2NUdGVndjd1BjZ0U5cHpYNWlkeHBD?=
 =?utf-8?B?c0NDWUJtbEpJWjNGSFdaSDBnaWpTOXRmWldFUno2STdEclNVWm9JMkNhSGds?=
 =?utf-8?B?eU1mNWszc1p4cW00YWVucGxvTXBjczF3c0N4VlVVcXNRcW9JdWp3ajFLN3ll?=
 =?utf-8?B?U041bTNZT2dFOXhkR2V5UUZHZkhjbmQrbXNwRC8rcHBQbFUvaFMrWjJmRHhO?=
 =?utf-8?B?VENOZnRYT1pPdHlsbXExWE9lVm5lUkROM1Vkc1ZqcWZmdUtDZVdXcXFLMHFZ?=
 =?utf-8?B?NmZSZ2ZZWFVuTGFtOGhHN21uMUIzLzg3ZzgvSVVrVUlpa1RGTFVIeXlvSmo0?=
 =?utf-8?B?NFJBenJySVFPdlZGV1dkTDJqVEgzbTBYbUhjcTIreWdmMnNhd20xMlprMjU5?=
 =?utf-8?B?dUlHZUo3QVdjaVlQYTRLaHk2VDUrQUE0VWxlaTZONXlKMFdCSHBvRTJRYmYv?=
 =?utf-8?B?Vytmclc1UkFtcW1PZnZOWG83WjdFSlZLQnJGMkFFLzFsRFNrL1BheDFhWFBW?=
 =?utf-8?B?WEdaMnUvM2pSZnN3YUZ5ZmNvbmFqY1RhSEdBemVaZ2ZneStSVmVONm95VWt2?=
 =?utf-8?B?azQxamV2bTVmU1F3am1kbzg5QThuU0NibFpBRnJkb1VSSGxraFpnOUpOSFU0?=
 =?utf-8?B?M1lKTXRTamtOWTRSYjRid0tMVzlhSlJ0UHE1c20wbGhqdHF0L1lCUDVhOVNJ?=
 =?utf-8?B?T3U3ZWRlTHhvbnBud1A2Y01ZYUdvdTROS25ud2U5UFdubWFYUDMrZDBmYWlN?=
 =?utf-8?B?bE41Rk1GcHJVUytObTl1OGFVNiszSHY0YVhEYnYrT2pUQVBGZ2N2MmN4Q0Qx?=
 =?utf-8?B?ektaR0JpWGYyKzlsTFB6T1VxaUdpMU5oa2hURlZvaGlmUDAzUjJwTVdORFZM?=
 =?utf-8?B?MThDUDNHV2NwYXpFcGJ1WHlrZDcrdWxNWXFxQ1l5TStNdkNhUW1lWGg2aXpV?=
 =?utf-8?B?YjNKOHowY092WGpmbG1VWVIyN1c5QXpyRTFmZ0VmQytIUlJNeEljc3JmZkF0?=
 =?utf-8?B?MlduZ1ZRQ1FES0V4YUl1bjlrVitaV2tTOXgzejZzemNwMm95enVLb3d5UkhR?=
 =?utf-8?B?ZUoza2RUcW5MZlU1R3Y2YzJyc2orUTRvQ2ZJT1BJOFBzUkNhNjlpVmNGckZC?=
 =?utf-8?B?Q1NHc1VMNUZObFNSWU9hNXArR0s3VmhISXY4cmlvMHlaTzFEaXRHVUpxK2hH?=
 =?utf-8?B?SjBmQVBHeCtXWUsraWQ2eEkxSWdDUWd6cVN6cTErMDJUZVVxK2ozMHFITHpH?=
 =?utf-8?B?NVBoZTZrSWpPdjJjMXFwQU9iNVIvYVdaQU16VWI0VDV2S1BURFJiQmJrempW?=
 =?utf-8?B?cDd6aTZUUFh6MVdCMlhvSndMYlc1UGJqT0ppWDNTS1dEUDVKaUloTHFTb0Fx?=
 =?utf-8?B?UThPUmNWRytJZU9INlRiakgzR2lHeXYwK3d2QjRCbzMxSi9WUndCWURBVjds?=
 =?utf-8?B?ZVFPYWFPZDVHaEF4bVVnNWlTQ1JrajQwSStuS3ZBL29HN3BwNE1zSUFwd0l6?=
 =?utf-8?B?RjFnUWwyTDg2dzRXVzNTcW5BNjgzTXNiSTgyajZmNjRlcmVSVUowL05ENk4z?=
 =?utf-8?B?VjNsTnp5MHdSa01sZ1B4L0pRRFhtNFFUNjVieVBVM0dPNU5SMXc5eTBrVHBC?=
 =?utf-8?B?NWlyQTJtWHh6VW4zdy81ZmM1NzdibldQOUZ6aTRUZnRsdEFsRkF0aFRYb0hK?=
 =?utf-8?B?cE5ncDV5bk1tMm43VEZDYmoxcEEwVWVnWWc2QzZ1Nk8wRFFaRWJNRGtYT0NK?=
 =?utf-8?B?aEpxbVZPYVdtQnV6M0k4OWFFYU1ma0toUXVkVkdzOUpaSUxZblFwdjFHTlpE?=
 =?utf-8?B?WkthREIrSUxZZUJLdXhidy9mbG5WV25VQXVOWWtMcHo5cm5scUZyRUVScjJN?=
 =?utf-8?B?Qkc1Y2tCQW4vVmdSL3NadlRnT1FlQ29jdjE2MmJ5SWphS0xMbGNJMnN4dkFL?=
 =?utf-8?B?R2VINTR0SEp2WnRuRDdad04vbHdORHhON3Nhb2E4Z3FWVjZoSythemlCR3Jj?=
 =?utf-8?Q?w9x+8iNHiT7uZXhzrNnsRqA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXY2Q2dKbkorNjJVQTBVUjVJM0VVaExLc2VBeUJhMEdJdXFzZndEdGJXZHB3?=
 =?utf-8?B?UThxOUM2WWdtSTJNY3ZRYWJ5aXRZd1A2MnRLNUZmN3NRTDRIZEgvU3RMaCtp?=
 =?utf-8?B?bkowUWxjYmZaM0RibVQzTnpDMVkvRkdCVmJhb2tqOWZ3dVZzVXJVWmlwSjVm?=
 =?utf-8?B?RWNsb3NVNVMzRURoUmVHR0VPWHlVUUswK3N2QnZIRlcvQTdrbEh3RFFrRGZs?=
 =?utf-8?B?b3dwOHlpNGhHZmJTZkVXN09QYk45SnBldktydVQ1YTVBUk9ZMDFrbFVVV0d3?=
 =?utf-8?B?bFY4bUNtMy93aGgvb09HdmRuT0FLbnhFK1FuNGxUcGdlanlDZ0RGTmdkWWFM?=
 =?utf-8?B?K3VHWGtra1VzNmx5RitLTzJJS3JBM0YwcDZlbHFCVUNrRnJ0QXZuODN5YzVO?=
 =?utf-8?B?ZVJzTFVubnVvUnAyWXV6TEdsK3d3cGxzcEowQTlSN0dDZkY4R1RxSm8rWC9p?=
 =?utf-8?B?ZFJJWnBJKytNTFJMQXorQjF0ZG82VEpleDM0VmlaQkR1cG1Xb2FieUJHaExS?=
 =?utf-8?B?Sm5TTS9GS3QxQ2hpdEtvUGRpeVlKblR4b1o2TzdWakZHN2xqMnFFZHdxY1dT?=
 =?utf-8?B?QnJmTWNSSzNNc3h6dks1eS83TkgwdGkrUHUzWDVoVktGYzBmNXhINlEvaWhv?=
 =?utf-8?B?MlJTM1Z0b3hkVFNBcysrb2JmUkxodEN3SVVleVNnRmhQNGFFcTNxV1VuQllp?=
 =?utf-8?B?bEllSDd3bktJNm9mQ3V2WjdUY2MrMjZmU2hLeno1c1ZtMk1NUDFZdFhEUjh3?=
 =?utf-8?B?UkVETDB4VlFMdWpDT2taRFppRnhwNDZ5MnVjejdYWURxaFVaSEhuKzZyeHBI?=
 =?utf-8?B?RUtLZFZ4dzliNTNrTkNwSHpsZVJkb1pPaURhYzFWRmswR2Vpdlp4Y0o4SEdo?=
 =?utf-8?B?NzNmVkxIS2pFMWVYK3Y3VC9ycVRwdU12VXd2Mm1uRjB6c0dJOFc2Yy9JOXRs?=
 =?utf-8?B?aGpZVkJaK0ZTTlpkTS9DZ3ZCU3VIUlJGaVpUeXhUT092UkJMSSs4NkUyMUIy?=
 =?utf-8?B?Y1JneVNTWTlIWHdGN1k0aFFUcVVMWm5XTmRkVnUvSHVpdFNqVWdFU0JhKzhJ?=
 =?utf-8?B?M2k5VndXYlpWTkRUUWR6cittQzRLMnc0RmFJUGpKWXhRbEVxZitzY2xWK0lt?=
 =?utf-8?B?QlhiQ05zblpla3BDZXMrc3FIN1VLSGpaOFdCR1lzdGRvZkVHSjRHeHUvbmI5?=
 =?utf-8?B?TW1vRmZpa0hLTGxGamdoUG5lM0MvWk1uOHI3WFExdWJITVUwNmlCcGd0K3Zq?=
 =?utf-8?B?QlZHVkRjcTFNTW4vWXhsTDkrTEJKQ21GUW5ZSFRaTWFzT0FpUDhrRTFKWTM0?=
 =?utf-8?B?akQxWWJ1UTBENmoyZVZxQk1Na2FEbzNRL3RQa1Q0UUY4QlpFNHl2eDdvdjJN?=
 =?utf-8?B?Tk9qTTRJaU50dWRFSHRIM2ZQdjk5Qlp0T2hnNk83WWZ4SUpVTkdGZFBHSFZU?=
 =?utf-8?B?NTQ1bnJXb3lhNnlBYVk4WnExOXRPeVRodHFFR3UydVNnc29tb3c5b1diaTlp?=
 =?utf-8?B?Y2Q0OXpnTXR1enFaby9teUFYVjhWWjZGb2RpNCtxWVdKbHVyTGx0NEYycFJX?=
 =?utf-8?B?K1VGTlc0dWljWVN1cXJCZkhVUDVGUU9aZkNzZUQyZEFMdFYwbmduOXJLOUhq?=
 =?utf-8?B?MVpQM2VyYnFMOE1sUExnN3g3NTRMRURyUmJJMDJGOFM0Zm5wT3pMSzdKNVBx?=
 =?utf-8?B?cVFpbnMxTDJwN2lhK1JVRU8xMTlKcG5MUzV1MitJZlBQVVFlVDQwQnBlamc4?=
 =?utf-8?B?VmE5R0JYbjdIdzhYdGxZTGVFc1RETy8xcmhaR1FmUmRkbmkwdkpwYUM4ckMz?=
 =?utf-8?B?V2dWQmpxa09xTG5MaTNQT3FRV09pdTYrdUYvaHBjdzJGME1iS2ZQUi9ycU9O?=
 =?utf-8?B?d0lQN0xWTE5iR3N2N0dPT0tra0dEQkdrdlI1dWtnTjVjV2pUZHQ4WCtIVjFh?=
 =?utf-8?B?NE42ZUJDM0tDZjBwTkdJZzBlaUZEbHlwNEJBeDRsZVlNWEQ5eWJQNnZUemhE?=
 =?utf-8?B?c0xxbG44SmFFZHFWR3RNa241VEZ5MGFCRDhsQXJzblBzTURWbWhPR1d3Wjdo?=
 =?utf-8?B?NkhVbU9kakJMN1cxb25lR3hXczArajJxM2U4WC9kWDVCcGVERU1POHdqTUIr?=
 =?utf-8?B?RFRjUVRFTjkrOTg1MWMvRXJPcjhoVWJXclVPVk4wbndoRG1ielFwUDNRK01O?=
 =?utf-8?B?SW4yeGZXaDRNUDltRWhGZ3RLWk9xdXlrbXV6UmVlWFpmZFBaaThnQzRDZXQ3?=
 =?utf-8?B?UUxJUG43a09nS0hYbmJCdytMbGlWdzhXazlvR3dWWllYMlpENXEzVFhzbTR5?=
 =?utf-8?Q?7Y/G+Ys7EG0TJLrFuE?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5979db5b-58e5-48e5-c44f-08de6952afa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 09:48:18.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skhrcfw6lITLEsjsMKWnMoNYsIbC2KTFzvr3ODhFrZ2MDsZaJM2nvYDoBMGosy18OqKfNKfARA4Msr1iedW8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4150
X-Proofpoint-ORIG-GUID: jrmVof736u4Ze40ZvHKngusTrbmuWya4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4MCBTYWx0ZWRfX0IWaE1h2pIDW
 8YjhlHVuL7XKVzZg/5HSmDZHNUhEcfUwbv6V8VEji/qtrFerQ3QtVyHos5GQYEKuwEPtFePMtWx
 LGGpLrBkgHmW5MkC1/IGWwyZyr0mAsz+SH5LPZihkTym4JiDHnLFc5W3Yaic+Rsyj5l4QqP2Tjw
 SvI9wqFfXULhTq2BcKvVGKPWF9Zf1v4/BL9RZXGa1d+1AkNkldBrv8qutrVkVtaTCnxOLkCPCqw
 37yyGCkoS4IN2QVfPxlDiNQM7hOLuuxDqzeOYh8Pv8VXLstkLo7bj4SoYraFERPAlL4NvMaI/7q
 4k7xU1OhMg43X6I7xzeI8s1weln/7spHIUZNPjsQBYdqNmbfCuo8uU98SOVTwsz6jauQ+d1eP0y
 gShhXYNNQ+7c0SSRgzwa69CDmYyliQ==
X-Proofpoint-GUID: jrmVof736u4Ze40ZvHKngusTrbmuWya4
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=698c5065 cx=c_pps
 a=kzsVodbpLl5/Zj7uDz6sWQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Awk8xOCabwEx62TVmqAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim,CH3PR18MB6379.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9935D12302D
X-Rspamd-Action: no action

PiBPbiBXZWQsIEZlYiAxMSwgMjAyNiBhdCAwOTozMzoyNkFNICswMDAwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgRmViIDExLCAyMDI2IGF0IDA3OjQ0OjU0QU0gKzAwMDAs
IFNydWphbmEgQ2hhbGxhIHdyb3RlOg0KPiA+ID4gPiA+IE9uIEZyaSwgRmViIDA2LCAyMDI2IGF0
IDA3OjEzOjA4UE0gLTA4MDAsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24g
RnJpLCA2IEZlYiAyMDI2IDE3OjMxOjU0ICswNTMwIFNydWphbmEgQ2hhbGxhIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiBSZXBsYWNlIGhhcmRjb2RlZCBSU1MgbWF4IGtleSBzaXplIGxpbWl0IHdpdGgN
Cj4gPiA+ID4gPiA+ID4gTkVUREVWX1JTU19LRVlfTEVOIHRvIGFsaWduIHdpdGgga2VybmVsJ3Mg
c3RhbmRhcmQgUlNTIGtleQ0KPiA+ID4gPiA+ID4gPiBsZW5ndGguIEFkZCB2YWxpZGF0aW9uIGZv
ciBSU1Mga2V5IHNpemUgYWdhaW5zdCBzcGVjIG1pbmltdW0NCj4gPiA+ID4gPiA+ID4gKDQwIGJ5
dGVzKSBhbmQgZHJpdmVyIG1heGltdW0uIFdoZW4gdmFsaWRhdGlvbiBmYWlscywNCj4gPiA+ID4g
PiA+ID4gZ3JhY2VmdWxseSBkaXNhYmxlIFJTUyBmZWF0dXJlcyBhbmQgY29udGludWUgaW5pdGlh
bGl6YXRpb24gcmF0aGVyIHRoYW4NCj4gZmFpbGluZyBjb21wbGV0ZWx5Lg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IEhtLCBGV0lXIGNsYW5nIHNheXM6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjY4NDE6MzE6IHdhcm5pbmc6IHJlc3VsdCBvZg0K
PiA+ID4gPiA+ID4gY29tcGFyaXNvbiBvZiBjb25zdGFudA0KPiA+ID4gPiA+IDI1NiB3aXRoIGV4
cHJlc3Npb24gb2YgdHlwZSAndTgnIChha2EgJ3Vuc2lnbmVkIGNoYXInKSBpcyBhbHdheXMNCj4g
PiA+ID4gPiBmYWxzZSBbLSBXdGF1dG9sb2dpY2FsLWNvbnN0YW50LW91dC1vZi1yYW5nZS1jb21w
YXJlXQ0KPiA+ID4gPiA+ID4gIDY4NDEgfCAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICh2aS0+
cnNzX2tleV9zaXplID4NCj4gPiA+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSkNCj4gPiA+
ID4gPiB7DQo+ID4gPiA+ID4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+
fn5+fn5+fn5+fn5+fn4gXg0KPiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBXaGljaCBpcyBraW5kYSBhbm5veWluZyBiZWNhdXNlIHRoZSB2YWx1
ZSB3YXMgaW5jcmVhc2VkIGluIG5ldC1uZXh0Lg0KPiA+ID4gPiA+ID4gSWYgTWFjaGFlbCB3YW50
cyB0aGlzIGJhY2twb3J0ZWQgdGhlbiB3ZSBuZWVkIHRvIGtlZXAgdGhlDQo+ID4gPiA+ID4gPiBj
aGVjayBhbmQgZm9sbG93IHVwIGluIG5ldC1uZXh0PyBXZSBjb3VsZCB0cnkgdG8gY2FzdCB0aGUg
dTMyDQo+ID4gPiA+ID4gPiBhd2F5IGJ1dCB0aGF0IGZlZWxzIGRpcnR5Li4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gSSdkIHNheSB5ZXMuIHRoZSB3YXJuaW5nIGlzIGhhcm1sZXNz
Lg0KPiA+ID4gPiA+IHNvDQo+ID4gPiA+ID4gcGF0Y2ggMSAtIHRoaXMgY29kZQ0KPiA+ID4gPiA+
IHBhdGNoIDIgLSByZXBsYWNlIHdpdGggQlVJTERfQlVHX09ODQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBidXQgaSBhc2sgdGhlbiB3aGV0aGVyIHRoaXMgY29kZSB3YXMgYWN0dWFsbHkgdGVzdGVkIGFn
YWluc3QgbmV0LW5leHQuDQo+ID4gPiA+IFllcywgdGVzdGVkIGFnYWluc3QgbmV0LW5leHQgKGJl
Zm9yZSBORVRERVZfUlNTX0tFWV9MRU4gd2FzDQo+ID4gPiA+IGNoYW5nZWQgdG8NCj4gPiA+IDI1
NikuDQo+ID4gPiA+IEJVSUxEX0JVR19PTiB3b3VsZCBhbHdheXMgZmFpbCBhcy1pcyBvbiBuZXQt
bmV4dCBzaW5jZSByc3Nfa2V5X3NpemUgaXMNCj4gdTguDQo+ID4gPg0KPiA+ID4gQlVJTERfQlVH
X09OKHR5cGVfbWF4KHZpLT5yc3Nfa2V5X3NpemUpID49DQo+ID4gPiBWSVJUSU9fTkVUX1JTU19N
QVhfS0VZX1NJWkUpDQo+ID4gPg0KPiA+ID4gd2h5IHdvdWxkIGl0IGZhaWw/DQo+ID4gSSB3YXMg
YXNzdW1pbmcgQlVJTERfQlVHX09OIHdhcyBpbnRlbmRlZCB0byBjYXRjaCB0aGUgdHlwZSBtaXNt
YXRjaA0KPiA+ICh3aGVuIFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSBleGNlZWRzIHdoYXQg
dTggY2FuIGhvbGQpLiBJDQo+ID4gdW5kZXJzdGFuZCBub3cgLSB0aGFua3MgZm9yIGNsYXJpZnlp
bmchDQo+IA0KPiBtYXliZSB3ZSBzaG91bGQganVzdA0KPiANCj4gI2RlZmluZSBWSVJUSU9fTkVU
X1JTU19NQVhfS0VZX1NJWkUgdHlwZV9tYXgodmktPnJzc19rZXlfc2l6ZSkgKyAxDQpHb29kIGlk
ZWEhIFllcywgdGhlbiBwYXRjaCAyIGFsc28gd291bGRuJ3QgYmUgcmVxdWlyZWQuDQo+IA0KPiAN
Cj4gPiA+DQo+ID4gPg0KPiA+ID4gPiBDYW4gd2UgY2FzdCB0aGUgY29tcGFyaXNvbiB0byB1MzIg
aW5zdGVhZD8NCj4gPiA+ID4gVGhhbmtzIQ0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
LS0NCj4gPiA+ID4gPiBNU1QNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBmb3JjaW5nIGNvbXBpbGVy
IHRvIGdlbmVyYXRlIGNvZGUgd2hlcmUgd2UgZG8gbm90IG5lZWQgYW55IHJlYWxseSBzZWVtcw0K
PiBzaWxseS4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gTVNUDQo+ID4NCg0K

