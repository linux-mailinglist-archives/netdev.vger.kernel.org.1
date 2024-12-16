Return-Path: <netdev+bounces-152352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78209F38EE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25431188087B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4F2066DD;
	Mon, 16 Dec 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fVzKb4vW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C01CB31D;
	Mon, 16 Dec 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373712; cv=fail; b=sDnhLiO2PwUfbTiAFwyPk64rjthzM6XXafqo75oXQIaMPPF+DMk0gANWiErfjfNIgUVhlq/LVVz3BoB9byawDVhnIwadu6B0S3ollPLrIxfewY+cEN8yTSV97ZbSOjldHMVOSzGq6xo6e5kKUhhaJwVhV7wr2kcGwHxqHZ4uIPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373712; c=relaxed/simple;
	bh=7AKnIxEMES50nLOeYkFEZlsdVbaiQ+He3kgSJ/E4oVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTDp3sMktXLRI4gndoqUJ/su5g8cdiLDQ0C4kZuaYBfiwBwFBINbl1HdzO04bUAln6e2N7rVCAQVU39WwRPlIRrqWutdC7v/ribi4s10BTod8vfCY+Zw3FM919lrG16u+91TLYUiISph3mNpJZmmpb8zzP9VwLM3YsJUdIG+MIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fVzKb4vW; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGH6cPm004435;
	Mon, 16 Dec 2024 10:28:16 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43jram85fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 10:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRgMaZQOKrWhZyAlIxgWW+5Ea+JDGjetX9dqhM7+BEMCN20uuz1JM/4bfepqsiZ9qT0zn7v3XrCyEXUr2cvM2n4gy6gWcJr+aOxdvR5ekEldCVAURNPyNNy6vN6szEB0pP7T8LKjyMpAIrr4K7xJfxT7vKzSUDHGzfvyj1/fwcbbeRXUfMGGrhaTJne4V/Oy+xu05FDKmJQm3yyLddnHQLSi34Fct9D2hUXct9KZEdiskaH/VKlfc182kTAgKYNpt/8ddG59AfkGAABa2aQMgNkuEHblKWSA8R/OJ+9AsbU2WMDxbtkGMfUh+awnN2Yl2whkP6h/itTUCbLLqhNF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AKnIxEMES50nLOeYkFEZlsdVbaiQ+He3kgSJ/E4oVc=;
 b=eHKTCpqGjSf3T+xKmh45tlBpMKB16PG3m9KtYft8rIABN5V8ewEHahsP/2hlz58IYMiyuLc4e5qI/ToHpk8O5pPuHIdF/9v4lGCW/qBf03shuRVLWy/ERG5pDZrTKjU+uOhhyFCZWAAiE9IuJ2OKiTljRjsCa9fCXx+KuCSxGEEbpauRqrZgqwUWjKKuXoHYx/x7/YE5oGI5k2xTLHmXysIrrVNIpLY5ed/TFqfm0ekTMSAKh4vyMuUS0enAHvRiIe0E82XuoOIrIlhZvKuK+WkXTre9NUs2JWQ8JT2bO3SlkgawIbu/zMtwaJTReCfskg3uTTYDW+BiDpbEkUPQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AKnIxEMES50nLOeYkFEZlsdVbaiQ+He3kgSJ/E4oVc=;
 b=fVzKb4vW056H+O57QFNkKn8z7sM4Q21iplN/ZWddZdlklt1WpQGgiWL1wTc8K6JJ/zTICrNIbWbtOrpQt0NHXXyy5rnSHTWz0FT8uUlP5HCUxxPSf+isaSNJBBiqKSH62c8HH0OjGCBiVeBIVHvly2sCroF43FyZ5IFFh/kddZQ=
Received: from BY3PR18MB4721.namprd18.prod.outlook.com (2603:10b6:a03:3c8::14)
 by SA6PR18MB6184.namprd18.prod.outlook.com (2603:10b6:806:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 16 Dec
 2024 18:28:13 +0000
Received: from BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db]) by BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:28:13 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index: AQHbT5BaYIqjRH+Vi0yNdgQ+YpYURrLo7ucAgAAEnACAAD0IMA==
Date: Mon, 16 Dec 2024 18:28:13 +0000
Message-ID:
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4721:EE_|SA6PR18MB6184:EE_
x-ms-office365-filtering-correlation-id: 7f9656a9-efb5-48d1-d844-08dd1dff66e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkJqNkRxQ0xUcHhNdnJMWjRlQllYY1VrSWZiRGk0d052dHk2L1dFOURGWkxY?=
 =?utf-8?B?Q2ZoaEtGOVB0VkErTzMyVThHSWRDWFZrQks3TFVIdS9mZ0ZZT2hnckdkdXZE?=
 =?utf-8?B?Q0VEMzBPSDhlUjVUUnVlci8xN24wWVdLTC84cGdXMXYrWTljNnFEVlgzZXVN?=
 =?utf-8?B?Z2RKT1lUZXhNQXE3UWRIWEFTK0xJSjFMbGdnVHo0UUw5YmZyZzdOL0NxNHlw?=
 =?utf-8?B?TUlINE4rM0lVd2xvVVlsQmVkRlBFNkYvaERYcG45SzF4RnRlaW41Ym5tdis5?=
 =?utf-8?B?WCszd0ZpbTBHKzdBSUMzNkZxeDVocmlFbXc4cUVUQnpEMURSVEtFQVVkdzc0?=
 =?utf-8?B?TVltcXR6aG5Vb0h4MUZxai9ISzc0ZDM4YS9XMytNS0JyeDRjSk1qMENGRDdj?=
 =?utf-8?B?SEI1N1NFOTlTQTB3SVhybUc4UFg2VWpDVURkSGpWSmNJbGppR1dNYTNkS3JF?=
 =?utf-8?B?RWNiaHlNR1RPUGV4NFpNWG1qcTA3ZlRlWHkwUHhxUXJxRXBzeTdaMWlhZXhN?=
 =?utf-8?B?UXBnK2Y1dTJTOE95YTZqR2hWLzhXYlg3U2t3U2p0R2VjZjNFZXVOcUFEQ1du?=
 =?utf-8?B?UUdGeHJFWkd6UGpuQVhlUEVoKzZOWVZkM1UwOVJwNno3VGxMTU9tRHg2SDZv?=
 =?utf-8?B?L1NpS2J5ZVpuengyc1FsOFBrcGpmMkZPUzEvUVo3Vko4M1dyYXVOVXNRSE9P?=
 =?utf-8?B?ZlFxRm9BbFRRTCtRT2NlUnRUc1lLcVpOQVhiSmFMRUlreXBPbU9uSTZhZkg3?=
 =?utf-8?B?LzVCV2xSeVdZUTBsSFR3ZENYTjRtUDNrdU02dm5uQzNZQTJGYTN2S3pYUDBQ?=
 =?utf-8?B?S0FSaG5hd2xVWjB5MUd4VUp1UDVTMi9FS3M0SWNZa0U3SkY0TVM5TUw2Qmtp?=
 =?utf-8?B?aWJLV3UreWYvN1gxa3lTNWVPMXJCR0UyOVNZTXFHUjRTMkhXTkZPcWlVZkNv?=
 =?utf-8?B?dmpibUJKYVVRUXVYc2RiMENNY0ZTWUl0QUQrQzBPYWNsMkd3bklVdjRiWlRy?=
 =?utf-8?B?cVJwSzNxL1o3alNzVDZpd2psZHIwaFJVNitubWZRTG1LVXQycy8wTnBTOHhT?=
 =?utf-8?B?dGUrZE5zNzc1dStVaFdpRnBHRzhFR3ZGc3JDTHN2RHNEVDV6elRzUHczaGpM?=
 =?utf-8?B?NHVUSnhYZ3J5eEVRZEFSOTdUREtFYVVJRmJPcFlGTEpQQWllejNNUjVYS2p4?=
 =?utf-8?B?WkJKYWVDcTRPSHM4RElna09PbXJralpWMEN5SXQwUlVRZHYrSisraDg4WlVo?=
 =?utf-8?B?blppZDRVOUlEWTdNL3U4cFVlUUo1V0lrS1k0MTVraC81dkh4VEJFVUlrcE0x?=
 =?utf-8?B?emMwUGY5WFpNdVQzemRFNDBDQThWVTk3NUVySHgwUCtmZjcxUDJDRkZzM3NL?=
 =?utf-8?B?SVBrYmx4b0Q4VkllbUtvRVdjMXdzb2UyaldhLzBsWFQ4dW9aZW9nTDBtUzBZ?=
 =?utf-8?B?TW92OHhSL2FpSzlNQWVZaHpoRmI5di9SZlBTdVhXM1hsbDBhSm1KeWwvKzJU?=
 =?utf-8?B?NGxFakYxRlYzYngyMm5OSFFDczdDQlBwOEtDc2FCMmc5aE4wc01CTlhQcWZS?=
 =?utf-8?B?aGhRRExpY2RsT25GT1pmendNbE9SMlNyS2JZNGFHZDg5U1UzZUVRaTZyTDVB?=
 =?utf-8?B?Y0RQNnNKVG5jZ2NWMGVhVHFPYmlMM3AvS0hrWWNzWktCWlBLbkw2Vmp2TmlJ?=
 =?utf-8?B?aTdzaFlSVlFQZWM2NnZuS3pyUVJibVo4dlhoU2pyNlp3QTNCRnZRZjhOWE5i?=
 =?utf-8?B?cERJSkFGM09vbTFuWjhMa0gwaEFNajh2dThDRTg5T3ZHOG5qY003RkxJem1L?=
 =?utf-8?B?dmk3OUZGV0ZCeWZLOVVFQStVa2JvYWI4YnVnUDY1ZHR5YzkxWGdWRndhbFNX?=
 =?utf-8?B?alQreGhaeXZ5V0IrWEo0WS9uMzZEeHUzYmhQTDh3R294VUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4721.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekZtN2pkTHMrRzNuR1pDQVU4VDR6T1IwOGFjSWplWHRzdklzZkhWdG5ldjJ3?=
 =?utf-8?B?V1pyTGRHeVp6OTFrM2ptVGQyU3pPVTVMbkdod29TU0RNeVBKNG1aMzltVmlJ?=
 =?utf-8?B?Z3RWSm54eWFDNUFmM0wvOEI4QmRBNCtBRm5TQzBDck45UUxxcFMwUlMrME9L?=
 =?utf-8?B?Y3JXWWtUQUpRUFJZcERHRWNqZ3ZnNTdqOGZiWXRqQzd0dHU2bG81YlplaUNx?=
 =?utf-8?B?UjlxQXV6aFpiL2xFdEpQa2o3YnJaRmE0TnE4Y3R3TFppSW9wRFNOVGdRbjYr?=
 =?utf-8?B?dElLa3JxY3lIVGRPdEFIbmc0WmpyWVFwcUs3RElHVFdBYmY3d09lOWFBbXRP?=
 =?utf-8?B?MnYwbUltVFZ6OXlwSEsxTHhmamVqZkVTMktnQXpOa3FFa1M5QjR3eGFKS0U4?=
 =?utf-8?B?dXY4ZGxETWVSNnUzb2tyaW9LOXNCbEIxNHZQeVU4M2tOVnY4alRrYS91Y0x3?=
 =?utf-8?B?U3U4a25vbjlsRmtpRDNRa1ZoRFRXdmdkQTltZkNSTkVmQU5hNFlGRGs3aitG?=
 =?utf-8?B?NFFzMlNtN215MnRuYXNRRlRNZlJWa25IYWxBUktBdWZoRjQyMnJpRGtkZ1VU?=
 =?utf-8?B?OG5xZ0lIcmtsNzlHMGU3cnd0Y1EzMjVQVHNVbUQ1eU1abENkRGNjcFNnMWNZ?=
 =?utf-8?B?MTVmcGR2cnhyblBWUnY0OHBXMWd2azRJTGlJYXVmQ2t4MGlSTXhvWi83NGdY?=
 =?utf-8?B?OFdiaVBjdmdqR3hFdmppZjF0Rlhla0t2VEtIc1poUXFvZHVlUXZxaE81Y3J2?=
 =?utf-8?B?dVN5NEgzcG0wdFpuaWh5WDExN3RJWm1aOFJIMXB0c3E5TmxlMkxxT0FsV2Za?=
 =?utf-8?B?TEhJckFHa2ZpRHFzUkNTT1hIMTZPR2pWUzRreWNIWkhDSDFrWndpeFhTYWVZ?=
 =?utf-8?B?RExjVUNaSDRseEFBT2xyNmxqN0tQN1Y3TytaN21kS0tRUStjbnhjWGltSUw1?=
 =?utf-8?B?WndqRFVJbG80dFJCMGFzYllwVGc3aWdWcUdpdlZub0pGSVRlOFNPa05BK0g3?=
 =?utf-8?B?c3RML0ZmRUNJdlZ6dWpSUkpRVlJ0ZmtXR00xUTZrdFJaSkJTdS9uVjhiZEkw?=
 =?utf-8?B?dUVVSWRLVXNuK1NpbDJJS0J5YkJTNFl4QTFvbWU2b0JzNmIwejQ3M1ZiOVhi?=
 =?utf-8?B?SjVyb0h0MHV4T2xid2lTc3NVbGVUTDZjZDBTb0t5SWJoWmNYT0FkR05adVJh?=
 =?utf-8?B?UVY0OG4wK0FiOFpBL2VVQ1V1b285SXNlZmJ6elJzQ3JMdGwwdUd1QjZPOSs5?=
 =?utf-8?B?L1NKcW5hQzZhSVI3emYweVVrWFk3MWlHKzY0NkFpbCtYbUszYW55dUFGOTlS?=
 =?utf-8?B?SVkvU0NoRW11N0NnekVSdG8zTE9KMFJPc2pFYUsxWGRBcCs2NWRZdDhHSWEw?=
 =?utf-8?B?L2E3RlluLzRWK0ZLRUJ6Y254bjNMVjFnTDFGNFo2ZmxqU3dlbXE0OUh6Vjd4?=
 =?utf-8?B?VUVvOFAvZlFtWThQRGRFZ0dOOEZzVHJlZXd0bC8wZEJzMzQ5Q2FKODdnRTR3?=
 =?utf-8?B?cGVGanFoallsSjRETDRKS0ZoVExkZmsrZFN6MmxNbWhDTTg2UlEwNnNqWW9C?=
 =?utf-8?B?Ykd6M2FhcTMvVCsxSmlkU2h1RWFXdEQrSEFGelp4RzQ3R09wL05ia2RSa0Zh?=
 =?utf-8?B?Y2J2K25GMDF4VFJmS3ZoNUVSMVNHM2lEdHJ3RTFMNHNWRWcvL2Z6YUtjci85?=
 =?utf-8?B?RVM1KzdpRTNhYlVORGRFdUxWVmlvU0F3V3p0R3FsSElnU0l1MVRaaENkOGJj?=
 =?utf-8?B?RFJEU1NvMVY1UjhMRkh5QlF1Q0JWZmc3Z1lzYUl5ajJjODlpUEdGTDU2UE1h?=
 =?utf-8?B?Rmhob21oM2s0QnlURTI5eXVmMlpaYzlpenR5K1Uza21jdlFaR2ZaSFdFYWd1?=
 =?utf-8?B?cWN1V1ZjZ1NER2hsWmRtN2ZlRk9lUHJ4ZEI4Q2czUm9HeVYyRFB0aDF1S1VD?=
 =?utf-8?B?bjJBT1U2M0pJTGRTVzFoM3RsSUxMVEg3THRzUHBlUGNFbFhDMmtpY2Z5RmZT?=
 =?utf-8?B?REFYdHg5Uy9EbTFlaHdYZVZBZ0liWHJ6L0Q0dlhLYkYxeVRub0g3RnlrcEhZ?=
 =?utf-8?B?RDE2MWFLQVdUL2hIbzVTVnZDQjhyWTFMazYreE1EcXAwWTZZbUFGTDBEWUln?=
 =?utf-8?Q?JXlkBn3iUij3XZXoWoqf40K6/?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4721.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9656a9-efb5-48d1-d844-08dd1dff66e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 18:28:13.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2QE7nLb9ZhKoQdrkxJkJmmK3DWSGOHt756a0qaozugMOAyAKWxW28c7u1jfs9ETt1OcZg7lNHKfMblJz0ZgtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6184
X-Proofpoint-GUID: uZwXBXbwOEVDGlvwlpV0nM0q66eZr_DV
X-Proofpoint-ORIG-GUID: uZwXBXbwOEVDGlvwlpV0nM0q66eZr_DV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgTGFyeXNhLA0KDQo+IE9uIE1vbiwgRGVjIDE2LCAyMDI0IGF0IDAzOjMwOjEyUE0gKzAxMDAs
IExhcnlzYSBaYXJlbWJhIHdyb3RlOg0KPiA+IE9uIFN1biwgRGVjIDE1LCAyMDI0IGF0IDExOjU4
OjM5UE0gLTA4MDAsIFNoaW5hcyBSYXNoZWVkIHdyb3RlOg0KPiA+ID4gbmRvX2dldF9zdGF0czY0
KCkgY2FuIHJhY2Ugd2l0aCBuZG9fc3RvcCgpLCB3aGljaCBmcmVlcyBpbnB1dCBhbmQNCj4gPiA+
IG91dHB1dCBxdWV1ZSByZXNvdXJjZXMuIENhbGwgc3luY2hyb25pemVfbmV0KCkgdG8gYXZvaWQg
c3VjaCByYWNlcy4NCj4gPiA+DQo+ID4gPiBGaXhlczogNmE2MTBhNDZiYWQxICgib2N0ZW9uX2Vw
OiBhZGQgc3VwcG9ydCBmb3IgbmRvIG9wcyIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGluYXMg
UmFzaGVlZCA8c3Jhc2hlZWRAbWFydmVsbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IFYyOg0KPiA+
ID4gICAtIENoYW5nZWQgc3luYyBtZWNoYW5pc20gdG8gZml4IHJhY2UgY29uZGl0aW9ucyBmcm9t
IHVzaW5nIGFuIGF0b21pYw0KPiA+ID4gICAgIHNldF9iaXQgb3BzIHRvIGEgbXVjaCBzaW1wbGVy
IHN5bmNocm9uaXplX25ldCgpDQo+ID4gPg0KPiA+ID4gVjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5w
cm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2xvcmUua2VybmVsLm9yZ19hbGxf
MjAyNDEyMDMwNzIxMzAuMjMxNjkxMy0yRDItMkRzcmFzaGVlZC0NCj4gNDBtYXJ2ZWxsLmNvbV8m
ZD1Ed0lCQWcmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9MU94TEQ0eS0NCj4gb3hybGdRMXJq
WGdXdG1MejFwbmFEakQ5NnNEcS1jS1V3SzQmbT1EaDdCSDV3c3VDZFFuRS0NCj4gNGVyanB0YUpu
TTQyWXNMVTJ0WTR3UG41Tldxd3N5bWtOT2xsUGZRQWtvbWoxbVhQTiZzPUlqV0hrM1NPcXINCj4g
aWJndjZrei1XVEw4VmZHVkluU3U1RHpLU2JjakNGSXZrJmU9DQo+ID4gPg0KPiA+ID4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uYyB8IDEgKw0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMN
Cj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9tYWluLmMN
Cj4gPiA+IGluZGV4IDU0OTQzNmVmYzIwNC4uOTQxYmJhYWE2N2I1IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfbWFpbi5jDQo+
ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9t
YWluLmMNCj4gPiA+IEBAIC03NTcsNiArNzU3LDcgQEAgc3RhdGljIGludCBvY3RlcF9zdG9wKHN0
cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3Qgb2N0ZXBf
ZGV2aWNlICpvY3QgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPiA+ID4NCj4gPiA+ICsJc3luY2hy
b25pemVfbmV0KCk7DQo+ID4NCj4gPiBZb3Ugc2hvdWxkIGhhdmUgZWxhYm9yYXRlZCBvbiB0aGUg
ZmFjdCB0aGF0IHRoaXMgc3luY2hyb25pemVfbmV0KCkgaXMgZm9yDQo+ID4gX19MSU5LX1NUQVRF
X1NUQVJUIGZsYWcgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB0aGlzIGlzIG5vdCBvYnZpb3VzLiBB
bHNvLA0KPiBpcw0KPiA+IG9jdGVwX2dldF9zdGF0czY0KCkgY2FsbGVkIGZyb20gUkNVLXNhZmUg
Y29udGV4dD8NCj4gPg0KPiANCj4gTm93IEkgc2VlIHRoYXQgaW4gY2FzZSAhbmV0aWZfcnVubmlu
ZygpLCB5b3UgZG8gbm90IGJhaWwgb3V0IG9mDQo+IG9jdGVwX2dldF9zdGF0czY0KCkgZnVsbHkg
KG9yIGF0IGFsbCBhZnRlciB0aGUgc2Vjb25kIHBhdGNoKS4gU28sIGNvdWxkIHlvdQ0KPiBleHBs
YWluLCBob3cgYXJlIHlvdSB1dGlsaXppbmcgUkNVIGhlcmU/DQo+IA0KDQpUaGUgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IG9jdGVwX2dldF9zdGF0czY0KCkgKC5uZG9fZ2V0X3N0YXRzNjQoKSBpbiB0
dXJuKSBpcyBjYWxsZWQgZnJvbSBSQ1Ugc2FmZSBjb250ZXh0cywgYW5kDQp0aGF0IHRoZSBuZXRk
ZXYgb3AgaXMgbmV2ZXIgY2FsbGVkIGFmdGVyIHRoZSBuZG9fc3RvcCgpLg0KDQpUaGFua3MgZm9y
IHRoZSBjb21tZW50cw0K

