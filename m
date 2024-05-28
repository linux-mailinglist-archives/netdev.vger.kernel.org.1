Return-Path: <netdev+bounces-98400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E98D1440
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D74B21E4C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B82233B;
	Tue, 28 May 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UxpRtjFT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37161361
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876984; cv=fail; b=JbH3vnOY2jC6n6jNk4KJd2yu5+gtPaGf0FEGqc8QOuEmSkfpC/WQd1D9siu+h7RDJR/tWR2MP1BEI4ZUqd9UR8XotMn2juP8EULA8QW9kHkqWSgYIgAt6P1VkWNbqYTamsW10AHERBbYoQ6VCM2kRi/EJZ3Yx2X+L5sOI2R4QXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876984; c=relaxed/simple;
	bh=P9rzQUAHYwtxSb/NVO+eCAf8MRpSxTvzaU3ypcJQW0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FonC85cBX3vj9segEzIi6Avtf0vD69lVgDte7q6ZhjMxCdrM1G6BJQbkzoc5WaLm5PXSkRLGQ2xlL+CM5ZWrAZ5EZ9iLqDAPUrU68bbbST3a+/1pwbLoVgPU/zWJYb1y33a2C6mX4xD6ClZ70PwVEFLSR048BuD9rm99bs792+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UxpRtjFT; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RJngqU004895;
	Mon, 27 May 2024 23:15:55 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ycqpykh3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 23:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOq5kYBcm4PtKibgsWFQy3Gtex1Gsbke0zB/RdncYweVrPLcwCfypHtnFrDaCIeU9H4WBPzRUEZZllGj7M02trOvakTLUYe+fj8MuMl45FdMtWV6EpT5ph5RidIaTjlCbEyeT28FxnIyIkxbYT+d/fiyte6kDSEPvbz6PZ6IOSYdWDWpX5wygNjm2kiL0n+i1Tg/0h+tYvP2YVVGdYzwk/4hSd2uTrIPoEJusHS8/xpcvkbGU40osfNdboyDq5dVpjp9hKAM7AiU04crSQ5i2NCbv4/J8OJDKwCJhIIAi0MbRaaN4CKJpM39muO2CzN5y/zUupjTQfl+rQbA4+vFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9rzQUAHYwtxSb/NVO+eCAf8MRpSxTvzaU3ypcJQW0U=;
 b=aXlWmEKnwXTEtQvwFmi3xFEmxVWzmyz8TEGOofD8XTJERDPHmPGtJYmI8BdVABWyb0tJmcD1PqSfHbXE/CmD5kxeyIvWaMCijV0b17d5yT8WLMUS/qcTb283qLvYREhWXEqk5jMiox+slea53uYdOSQmmkYVzyUscZw5YWKnHA/I7tVknIeDVczZdv9NYei/YPUAKvmAGq7hXiwa7FvB2ynqEEdre2oy6XlaQ8cifDhSE6T8uktyPgIeLaxhp1H0nC9CWSThharihQZgThsSSbW7BNeyDCgsLghzfwb4ranqT4MkDU5a78GJUOZ6Y0Qe2k9QhVbL4AMAwa/IEPZx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9rzQUAHYwtxSb/NVO+eCAf8MRpSxTvzaU3ypcJQW0U=;
 b=UxpRtjFTsE08QpUNdsyjK2vxCivfqyRMz9z8N3WC/rtHKM3mgLTISCi6XnKoy1zfvl4cqZdjijjRkqcgJzcVyA7TzAMP3RXUf5VD5zHfvSUC72vA/7N6JbT3s0fN2P0nYVQiDefqf0uYywyMKR0CJiaZqOMayfuCSlW5Q1EqSNA=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH7PR18MB5058.namprd18.prod.outlook.com (2603:10b6:510:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 06:15:51 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 06:15:51 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>,
        Realtek linux nic maintainers
	<nic_swsd@realtek.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] r8169: disable interrupt source RxOverflow
Thread-Topic: [PATCH net-next] r8169: disable interrupt source RxOverflow
Thread-Index: AQHasMZ9x+F+UMiW30O5ZQi9+T5z1A==
Date: Tue, 28 May 2024 06:15:51 +0000
Message-ID: 
 <BY3PR18MB473786AA6D825D6D335691FFC6F12@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <9b2054b2-0548-4f48-bf91-b646572093b4@gmail.com>
In-Reply-To: <9b2054b2-0548-4f48-bf91-b646572093b4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH7PR18MB5058:EE_
x-ms-office365-filtering-correlation-id: 776f97eb-13c9-48eb-0093-08dc7edd9ff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bGJVenFLY3RsVGpFbWFYa1VMam9hNGVhR0NZQkdVcnc5OTVYYlNSQk8wdkIz?=
 =?utf-8?B?b05OTVBmQlRZR0UvaHlwRXpBOFZYUUZIc1U5UzZFejlxV053Z0RnSGVhdFZL?=
 =?utf-8?B?Rk9JVVYwanFtT21rejMrRzFBRGUxQnlWd0RZSm8vVndObWhDR3cwOWtzM1ow?=
 =?utf-8?B?d3NEdEp3TFR5V3h2NWFFYUFqVDhaWHE5bnRCT2QyWGZCbDBRWlM5dUVSNlFV?=
 =?utf-8?B?V2QrRVNBQ056VlBXMXV2TzhHNWQ4VjBZY04wRnhEckcvQ3psaDRnY2w2N1lR?=
 =?utf-8?B?Z1lIMU9FYXJQbU5aaUlhc1NCZXJuN2t3dW5iaTBKRzRNWW92dXlJT05FT3hh?=
 =?utf-8?B?Q0NmcC8yVndOV3R3b3FnbTF5NUhEakVuZ1J5SldnR2NjQUFkYjBLQ0JsU1BX?=
 =?utf-8?B?ZkJYQ011VnFDQTAxUnNCMnRIUVdQbDBZL0dyQlZJcUREWGhEcTUxT0ZYbjVy?=
 =?utf-8?B?TVptQThuckZvckJ1SzRpVGF6U2ZHYTQzTFVDdDZzbTdCYXJQdlRhb3Z3MG05?=
 =?utf-8?B?M2VZNlRhWnZQd0NLV2JuRmtZMFZQb0ZJRlBSSFdFN2VFV3MrZ285T3N6QjZk?=
 =?utf-8?B?WllXNUhpSExEQnFBTW9YakxzT3R0SWd3bldDSmg3amYrMXVPeVpzN2hVbC8y?=
 =?utf-8?B?UDk4T1c2N0tvZndsTk9IVUJQNjZEa0I2c2ZFNGxTV0hHQ3FSK1ZvMGx6RGhz?=
 =?utf-8?B?SkRGMGtaZVl1R1ozNFY5M0pTaGQ0YkFSTlppUUY5UFBTQUV4Tm5wV2RVejVo?=
 =?utf-8?B?Tm5VWkpNdGNuaHBSbWk4QTAzTnJod29sczFpNVZ5SC9nWlVkejdaekJaMTJN?=
 =?utf-8?B?NzJPK3hwNHVVY3BwRWx6bXk2UnpEaVJCU0h0S2dBLzFsMFliS0V1LzNVSStD?=
 =?utf-8?B?eTRUNnErZElIWFVIdk56WGVFVTdENEJvbGFHbi9IVU1EcHhPeTFjQ0ZhWDZQ?=
 =?utf-8?B?anhLTjB2RUszaURJVlFTVUVrbEQra1pJUlZ6anlmOWRqbWNXRDBJd0t0OXdO?=
 =?utf-8?B?cmlkWTdSVFU5dlVXcFI0RGlJMmc0TE9yKy9vbzRNbjdVbk1GZ0pIVmVpRjBV?=
 =?utf-8?B?a2pQQUVEcFdHTUZCNE5lRjdFK2J6WG5rVTBFYS9DTSt2b1lyOVNuVVAyWTNB?=
 =?utf-8?B?K2htem5xQ0syejlNZlZuVVlrWUhLYjBWbHF0ZHVyRmVTQkEzVjdrZ3dlYWs1?=
 =?utf-8?B?YWErNzNjVURZakVxQ3VSem03OXk3Z0xWYy8ybmE0OXlvd1B3V3NxbnFlVUxQ?=
 =?utf-8?B?QXZGZ3Zvak5RcUZoZjAxaDZXdThpVk1QKzg2MUJuT0QvZ2hRQkdSSmFYNzhN?=
 =?utf-8?B?WmxBTVhOQXFnK1ZjNnd3citFT1ArYUpFSDk3RGVDNGNCRlYveUY4UEVVcXdC?=
 =?utf-8?B?UnVWcVZHdDI5Wi91RUR0clk5ZzF5VXF2NlJxcUZEVnEvbWxleTRzNWpUeU84?=
 =?utf-8?B?VWRLcnUyVHJraTcxVUJ3bUxpeXNIeDhmd0JtOVRuOUNrdXhKOFVjUG04YTVq?=
 =?utf-8?B?b0NGb3FZZk5weTM4bXFhZVVYTnlLUFZlTm03U3pvTmpEYmNNYkxqTHZBcG11?=
 =?utf-8?B?dnJUenBJZ0g0dy83N0h4bmgrZFJFVEV6RUJacm0vdk1rYm5kU0dMRzl3cTRT?=
 =?utf-8?B?alIxTHhZLzFoV2YzYkFYY0pKazIxcElTYU9sZU5XdEpveDlsY3VXYkhHeWND?=
 =?utf-8?B?VkxCNTJoU1d6WHM5M1FoS1JwaTE5bWRWNnlTSTBpVUxIRnBGMXI3QzhiajI2?=
 =?utf-8?B?blBvdWM2cUYxeTlrTXFQRVd2Q3k4c0RFQ1FRZms0djM3OUxacVozUnZTWXBq?=
 =?utf-8?B?WkVpZnBiYWxYVGZhbmhFQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WTU0QUw3a0JyN1JXUWZMeFUxNjZ4d2ZZckg2WFhDUVB0Q2F5bERNSEN1MWdt?=
 =?utf-8?B?b3oxZFU0dUE0Z0Iwem5VL3RtQzl3bWNJTEIvVEZlTkduMXZCYTdtbzFFaWZG?=
 =?utf-8?B?a05PQTJhSy95QnBOdUlnWm1pTCthNW1DSVB0QWRiNVhNclBmR0srR3pjOERz?=
 =?utf-8?B?dHFzWi9Pd1I5NEVJeWhuajVzQ1JHazdMUHZZM1pRRjVKaEpteU1kc0VlbFJp?=
 =?utf-8?B?TUJ4bE5SQVVYbWsvamhMMS9DOTcycjNWTDZFdVViYjIzOUFGcE96ckNsYndi?=
 =?utf-8?B?cFFhdjR2MjN2b1NsL0p0bHRLSFdYajdJOEVrUWZXZEJUV2lqMFJLdHA4c0F5?=
 =?utf-8?B?RC8xcUZXc21LbTlsT003VGhjaHlsV3Y4Rk9RVUtPK1FvMVUwdVpnUlFsRW44?=
 =?utf-8?B?bHhiQnJ2djBSTm1DbGtjYVNlRU9uazJOZVA2LzBLYXRwc2JHWjdVZGhSTFhs?=
 =?utf-8?B?Z0xjMHlhQkZKVGhOc0RUVFFFMVhkV1RtNi92YnJ6ckJ0MkVKWElEZkN6SjRC?=
 =?utf-8?B?S0dUS0hjc25zZkdXYlluek92UENtM3J4dkRsV2FsYUdOc2RpQkV3RmlhYnJo?=
 =?utf-8?B?YVo2N3NFUGxWWkYwRmpiN2w4M3R5Y25jK1R1YjZtcHNtVHJSM0JKei95Mldk?=
 =?utf-8?B?ZmxxQ2dEVzJPcmUrNi93eVFwWmFMUGJzbXVRU21ucFRQcUt2ZzBMT1NoVjhz?=
 =?utf-8?B?WEM5WFFHL2Izb0NrU1hHSmZpdmtIRUw1UUxZNmJsNy9ZOWF2Y1VTSUF1TWYy?=
 =?utf-8?B?MDFuQmUzb2ZqZ3N6a1RBb29iVzJETUdNSFMrMnVzT045d1gxQU1zdU5vVVVT?=
 =?utf-8?B?cCs2TXg2anhCWi9pZXBuTnh2eE45SndzZkhaaGw4emtBWUF0QUVFQ0hQcHlq?=
 =?utf-8?B?NUtpOGF5RlRKUml6TWYzWnlHQjltcXpwNHpna1R2L1NFeWdhWFhTdit0K1Z0?=
 =?utf-8?B?aU8xRWtiaGRrR2hjQjk1Zi9GMVVzQlZ5eG11UXd3UWJ3Rk9TK2NEY3dLZmxC?=
 =?utf-8?B?dnBZNG1xK3JpN1V0ZEx0b0NncWZpdzUvaFovampNYjJMNXZwakppY1MxaHBJ?=
 =?utf-8?B?ZW5xQUNyY3JtWVpMTHc1S1d6YWo4RVZDRUwxdWdaejhEd1FHR2MvN2pxaklj?=
 =?utf-8?B?U2ViOGNpQlRSREg3NjcxaE5sMTFnU1JKWDlWTTFUdkcxTDh0NzlxejIwYzBi?=
 =?utf-8?B?bWllakQvNWFwNi9GQllFbFNwUnhrNm9hYysrdXdtbWROK1MxQ2czK3lTOVYz?=
 =?utf-8?B?VUhxVExlZVpiMnhiT3poTUluYlU3Nlh3a1QyY0orNFpsSm5LT2xwYy9DdHVl?=
 =?utf-8?B?dHVVZU9WajQyNUJpQmZpSkIwSk1aR3RFenhjd3pwSFpuUWpHc2w1TWdBeEYy?=
 =?utf-8?B?VFpSMTRuZnZuem5QSkpqc1FlMW1CU1ZMOHA3ZEJDb3pybHU0V1hYSjBUUU54?=
 =?utf-8?B?VWJHQ0NtRVJMRlc3ZEtDMTlzN3pOZUQzQ21MQkZVTnFneVJvN0RKSGtKZ3NL?=
 =?utf-8?B?alk5d3E5NzFyRVlXZGN4eFFIdWtGMjRzSVo4c2QwTjQ2WlFOL3NtNkhCclhx?=
 =?utf-8?B?MU9IUnd1LytCb0hveTJ1Q0V3SkdTMXE2NnQ3NTBGRk94ZzJjN2ROZnUzTnda?=
 =?utf-8?B?bzFzSmI5R0c4dTZpMy94cjhqTUJqQjdJUEdXbUhicFc2SENkM25Lc2VIbytn?=
 =?utf-8?B?TWJCOHRLaUx1Y04xWFZCZHl6R01RUnRoY2Y2MEVzY0lBbkYxQW1NQ056YWJZ?=
 =?utf-8?B?K0FwTnhWYXB4aGNEdXczdDR3SzAwU1J3b0Q1UDNxTUhjWjkvOXNkWGpKKzh3?=
 =?utf-8?B?MzZGWkU0amhKUERNTWRubEtjU1d1TVA4UE9NQ3lYbEEwNHR1emNqemRKdnln?=
 =?utf-8?B?NnU4dDNNOVA4K1o3eU9ScThEb3pkY1o3N3BocHdRMy9sdzEwRjE3T3BMaXR4?=
 =?utf-8?B?NnBrVFBVbWJsQkJNdjRVemg3ay94elVlMm5YS0xCaEtRNjg0Wk0rS0F0Umw2?=
 =?utf-8?B?cXJacDZUeXErRUZWa0lDSXh4Mkd2UzRHeW90VEdkOGtNclZkcFJFNW1OTThV?=
 =?utf-8?B?L2lrWElSNFdhR013bUxub1R2RmhGOE5rOURPUStkL0JjNGhRQXlEQmxhSjFq?=
 =?utf-8?Q?gcQDsmO2/LJ13VVPdCr6Kzlax?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776f97eb-13c9-48eb-0093-08dc7edd9ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 06:15:51.6135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zh5aHbgVxVu6k/B32gLndYcMxegmhsS2yP5r4kjIu+AxAwSUe/nWsbzorGC2MGYjV+ljIVnVgp+kWNVHBj7Mcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5058
X-Proofpoint-GUID: VpaOY_wUJvI6AyPoES14ksmB2NXL_-rE
X-Proofpoint-ORIG-GUID: VpaOY_wUJvI6AyPoES14ksmB2NXL_-rE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbmVyIEthbGx3ZWl0
IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDI0IDEy
OjQ3IEFNDQo+IFRvOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBKYWt1YiBLaWNp
bnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQu
bmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgUmVhbHRlayBsaW51
eCBuaWMgbWFpbnRhaW5lcnMNCj4gPG5pY19zd3NkQHJlYWx0ZWsuY29tPg0KPiBDYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHRdIHI4MTY5OiBkaXNh
YmxlIGludGVycnVwdCBzb3VyY2UNCj4gUnhPdmVyZmxvdw0KPiANCj4gVmVuZG9yIGRyaXZlciBj
YWxscyB0aGlzIGJpdCBSeERlc2NVbmF2YWlsLiBBbGwgd2UgZG8gaW4gdGhlIGludGVycnVwdCBo
YW5kbGVyIGluDQo+IHRoaXMgY2FzZSBpcyBzY2hlZHVsaW5nIE5BUEkuIElmIHdlIHNob3VsZCBi
ZSBvdXQgb2YgUlggZGVzY3JpcHRvcnMsIHRoZW4gTkFQSQ0KPiBpcyBzY2hlZHVsZWQgYW55d2F5
LiBUaGVyZWZvcmUgcmVtb3ZlIHRoaXMgaW50ZXJydXB0IHNvdXJjZS4gVGVzdGVkIG9uDQo+IFJU
TDgxNjhoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQx
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5
X21haW4uYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0
ZWsvcjgxNjlfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9t
YWluLmMNCj4gaW5kZXggZThmOTBhOGZhLi5lOWY1MTg1ZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+IEBAIC01MDg1LDEyICs1MDg1LDEwIEBA
IHN0YXRpYyB2b2lkIHJ0bF9zZXRfaXJxX21hc2soc3RydWN0DQo+IHJ0bDgxNjlfcHJpdmF0ZSAq
dHApDQo+ICAJdHAtPmlycV9tYXNrID0gUnhPSyB8IFJ4RXJyIHwgVHhPSyB8IFR4RXJyIHwgTGlu
a0NoZzsNCj4gDQo+ICAJaWYgKHRwLT5tYWNfdmVyc2lvbiA8PSBSVExfR0lHQV9NQUNfVkVSXzA2
KQ0KPiAtCQl0cC0+aXJxX21hc2sgfD0gU1lTRXJyIHwgUnhPdmVyZmxvdyB8IFJ4RklGT092ZXI7
DQo+ICsJCXRwLT5pcnFfbWFzayB8PSBTWVNFcnIgfCBSeEZJRk9PdmVyOw0KPiAgCWVsc2UgaWYg
KHRwLT5tYWNfdmVyc2lvbiA9PSBSVExfR0lHQV9NQUNfVkVSXzExKQ0KPiAgCQkvKiBzcGVjaWFs
IHdvcmthcm91bmQgbmVlZGVkICovDQo+ICAJCXRwLT5pcnFfbWFzayB8PSBSeEZJRk9PdmVyOw0K
PiAtCWVsc2UNCj4gLQkJdHAtPmlycV9tYXNrIHw9IFJ4T3ZlcmZsb3c7DQo+ICB9DQo+IA0KPiAg
c3RhdGljIGludCBydGxfYWxsb2NfaXJxKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKQ0KPiAt
LQ0KPiAyLjQ1LjENCj4gDQoNCkxHVE0NClJldmlld2VkLWJ5OiBTdW5pbCBHb3V0aGFtIDxzZ291
dGhhbUBtYXJ2ZWxsLmNvbT4NCg==

