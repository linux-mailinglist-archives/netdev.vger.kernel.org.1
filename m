Return-Path: <netdev+bounces-93638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E328BC932
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEA52826D2
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E3140E23;
	Mon,  6 May 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="tdj5Dk5a";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="zT8y84fp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE027456;
	Mon,  6 May 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983135; cv=fail; b=CEzHoXkcJ4od1I/L+Cnl+df7sNXzs3o4yUZOWfQRi0xqHXqVtADPQwElGRmdEIk7oD913fOcfXOViC3ZxWn+sz6oO8sr8zEcb2oOyhYLQxvYt+vDJLuJVyrHc6NpMJ6DPhV0LjzOUOWpxDxNJKDIizt9vr7iwLKn3/rSA/30kso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983135; c=relaxed/simple;
	bh=+nPB4czz2tiI8gwAe3tHMkzGC7yo6Y2E8DqKrd0hbsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bEyf6ovrjkQyxWeN56KeLJ2aaN3zgUl+SqO9Sd1yYfU1c7vXhBql8q8kbQIj92Q3abFOnWxo1futjtLWPxQPyI5gMkM/jb9Ky6YUZIHo8yYHIoLi5F4J1/0SMorMZVfFnoABMC7EpG/dKf1gCYNiRx1WYl5p5/OgFwup1C0xFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=tdj5Dk5a; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=zT8y84fp; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
	by mx0a-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 445MwNEP012173;
	Mon, 6 May 2024 00:47:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pphosted-onsemi; bh=YiJQLKI2Q8vdhrhkBXe89JHZf4gDTpzLEqz7PvyqTdE=; b=
	tdj5Dk5a6D6eUB1AS39Lc21orc9y/YJ8S4ebPHSkU4I0aBCxOFrXD3H7S9kv7DD/
	zLNKs3fPo2rmyCofqBKlF+amMzyyOtBziVLiG2qa6XF5RIReWmrs2h3xwQKcgJTx
	7JIKATUKLcQGNClzTlA+y+NNpA/5eaFAJFIqkVI5Tp/boxn4jVQUwsL2HN/fmdSe
	bPpnxDVU8nnf8OuiOQ1aAWV3qBablrhRSK3hac8pR9phKmL0d2CrTl+KammxNwfA
	hknAWqP9cjqfDSzdzpfY30GEeOoVvwL9E9Kt00IwWqOdoQ/Ch4Leikqm1XZB49HQ
	6kExp7HOIAz0cP+0t3OnfA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-00183b01.pphosted.com (PPS) with ESMTPS id 3xwfv2u439-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 00:47:38 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e77U5Z/r+uod9pLXWlKrY5zLTii+qiBwHYIAHLQ8ShjdJWLpXaKdEBjdDW6wevmnUfallrYwRIFJC1QlNRaBj2m+BqSoKOYjMCGpV1JjUjVondq4l8duyAVj9uJGkv8D9/+80lsd18EBfsHOYLdKVTMcqC9XjxUf7vmVUpt3SY39zicovKI7KM1RLWNnkkXM+JZdHzy55ZZkC+Zc4L8e/Sd0Wv2yip2noeExypHzm0morb2MTY6W+n5vWTCdeB9o3j8pZwyH8103clPVNAx3uXcymKU3oJdo2eY2jzUnsPVPReUORz72QGq/5qQ2fY7lnTkbbZYAq3uEfZCXRtT7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiJQLKI2Q8vdhrhkBXe89JHZf4gDTpzLEqz7PvyqTdE=;
 b=T3SO2b6zpTc6eLBe0Gjip4PmqPZ1yGpOH6HzViIF94nZcUjrC6QncEynK2a4OHmku41GaYeTK7HU7rwWCndRXv+fOGO/EX4Abe/U8R+1ELHWdvn2cR6lOkkCUoINGiG8z4DdHWti1ckuod4vVcgOWHvrhBagw2y6fl0axHQj5EcxPB/4QDEY3zl0fZXT4eUkIt8hw9eB7EVmmy2srRj8bHUZ5iuOgalPou/n5syj66RZj6fumq5x7Kv0fuGUP6zek9pkf68wqMk56fRafGZJedimR5IfRRmhZkb86xzsAYgVgtKpi6gqpbSmTbm946xOv93KoyozIpEEu0emj40q9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiJQLKI2Q8vdhrhkBXe89JHZf4gDTpzLEqz7PvyqTdE=;
 b=zT8y84fpCxrCiWT1UujtcIuVvU4S/unJBtuTiRA3yXHJAezb5Zijamwv8wl8GUSMok+AoV0Fi+E5txAg3FWcHAYDjjDbgE4ByGF/p5gDnnkh7nBLnGvMYMnBlZmQJoUHliswTLijdyWAOtqwjsp0pg67WHoQKaouCBG2g/YuWaE=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by SA3PR02MB9327.namprd02.prod.outlook.com (2603:10b6:806:31d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 06:47:34 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 06:47:32 +0000
From: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>,
        "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>
CC: "ramon.nordin.rodriguez@ferroamp.se" <ramon.nordin.rodriguez@ferroamp.se>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        Selvamani Rajagopal
	<Selvamani.Rajagopal@onsemi.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: 
 AQHakZAC89gsXFcqv0WhzhAN3HgiZLF8la6AgAAX2YCAANNtAIAAVU8AgATxiYCAAQbggIAAAp2AgAFdb4CABFWKgIAAWgJw
Date: Mon, 6 May 2024 06:47:32 +0000
Message-ID: 
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder> <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder> <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
In-Reply-To: <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|SA3PR02MB9327:EE_
x-ms-office365-filtering-correlation-id: 1ffd48f4-5a68-425b-6578-08dc6d986803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?PQljv1qeX6H6kvTQpL6Hr7eZbmAono3fewmGGul48BL+2LZeTDzj6veSTN?=
 =?iso-8859-1?Q?l5apa6MAcgcAKy5fWrIcxSfmlct9jnCij2V5qMgmo6IE9I5UOfYyW/XqrF?=
 =?iso-8859-1?Q?qgbDrxWDHYTu0TGA/C0fYxE7o7mJw9y/hlhoTk8Rkm0z7XvWCyE5g/qbMR?=
 =?iso-8859-1?Q?qH9TT4lVkotRCaf6wpFEXhOt5Twr18uAZ6ACqSDz70WwphFJ56VoAfRS1t?=
 =?iso-8859-1?Q?gwHR0F0V5waJXo+e85SbgIaz+fwPl9ueTkuHaSECMzvLjyCasxoP97L7mm?=
 =?iso-8859-1?Q?9gvVHZDKUKWLQCLZwdCB0YiDtHLQqehW3AbJvsHMBuya2wXlX89/zcHb9B?=
 =?iso-8859-1?Q?2DKn5Y/A6lPh7Pg+hbSnA4DIgSaE1vPGq7R4shFqcz5/frPdb/6AITvDZv?=
 =?iso-8859-1?Q?eVsQOAUaLFBpag4foWmD3rDjR7ow2IDs72PZIiUMwr6EDU3LJJoqO8kYaf?=
 =?iso-8859-1?Q?yQDAH8NqZmQo4QD4v3JTuHIrey5u9308uXKWlBODxoraci+S3DTvzr94xK?=
 =?iso-8859-1?Q?L4Km9ngqVjGFDvSSTgDPf8e97AeCKZqpJF7ZwfKYafbzF+r7+f7fCQU5AD?=
 =?iso-8859-1?Q?cybYaPcc4xmT3QK+dsXUEb8awUvs4seBPEq2DbterSHIoTpZskqHptQVKa?=
 =?iso-8859-1?Q?HVN90LJ5qIXBADmXmmark0XGe7x+hTWOq9I04EPYAJC9QUfqywaisgCXDk?=
 =?iso-8859-1?Q?ffiCQjvNsKjvCztrmP4cv8daml0DBOglItSFNXh/319WLV4XpXMTbdDYWb?=
 =?iso-8859-1?Q?0Ub5l5FmfCiBufMk851mGnSjTX/J+dR1nCiUvE6jaJKfO2d2hHaO2F6W9m?=
 =?iso-8859-1?Q?91healu3xkJmWRssnU9qS9i9OJQJ8rVwLl2xjoDhSoLgrDYDm7xCzJyiU8?=
 =?iso-8859-1?Q?1VgQuwwFK1zvHH++zYeI6oszDaopi+/mQC/cEF005Prp6xUSSTLJeNSmxl?=
 =?iso-8859-1?Q?bOYRea0h24VS04adW+5zpsfDvo4UzQXCJU5tUp6xgTw28+G67nIGriTjWF?=
 =?iso-8859-1?Q?clZ+NA9wwmIJcCBkKtsCXoG9l9pUd4wbmW96ifgEa4dha+f7epEgeL69qF?=
 =?iso-8859-1?Q?wpu/T91+poF5kVhSNs85wOSmZK1stlBNxMkK4dUiwWn7V3pS9Xk5mq5Amg?=
 =?iso-8859-1?Q?rT2t2mEUSmhnOUwzC9bQzTL+PxQO/b93y9toW7meXrG79pV8u32LXf4HOW?=
 =?iso-8859-1?Q?qGVlSJi3IouC67oc5j3/Y75RmlwCzinsXmlLOXC3AN7d3TOjRr8duqwOeI?=
 =?iso-8859-1?Q?gK3BSnEr8V7uggm4gesKse9EX8z8U8VamkWPWrJrmOZdi72Pw1lNM8gs9N?=
 =?iso-8859-1?Q?/JHcg0H3Z6PiMi2GGZtoHqEZKvWXX9q7CSFYpnAlIwHJ1JloxokgmiSTp+?=
 =?iso-8859-1?Q?pWUpXhe2MOz7JNmUKVQrgIr2LH/PkoLQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?O6EAG7Pgl9Hkp+6DaMyZcbxunG/De5BH3aX1o25cb9XhhPY9RVc6zmotW3?=
 =?iso-8859-1?Q?GPwm1ivf3AJ9CSNLCVnp/YdYoRgDQrujxL4qhIehAKCT/U11Uy6X64uJji?=
 =?iso-8859-1?Q?w9+Lofb4spkYxbcYmxdECyp689BKLq/qetUmk8PgYyLJDyudxEG1Qdkd6u?=
 =?iso-8859-1?Q?lvgoe8P9cNpr/4USMVNdFG/zMcwtYRF4BfteKjIk8i3m/WLcsupCSBoXcs?=
 =?iso-8859-1?Q?b3gtTnmEW/QKgV7ErkVOQTG0CEdxRxNNk5ZVf9LMJU6GaV37fNBBFawq66?=
 =?iso-8859-1?Q?VwNpz3vRL5jAF+bXErYbrkCHnKOWLsnKyag81MmgK/lI6MAwwhuvX57cxu?=
 =?iso-8859-1?Q?dGv+xjSIGtupatpkoS1uU8P0qgIIdPwbSY/b3qMQ5luH/V8h2SkyboCSZT?=
 =?iso-8859-1?Q?qi1FCBX/J9CvYWel3smBCWpd/sKSjeaXiJ7vUPxEPAQ0W0untqs+Zt8ye6?=
 =?iso-8859-1?Q?8FfO1p4ZHKwY3EtOodRzHTHslJfcBFBh3SWllAfyi2J4Ce6qhgOebnAGHK?=
 =?iso-8859-1?Q?0Cph7ZTQRRQqh3QblyqxBLDUP6duWU5uNVQd9QK8/dCgWYHhMGZEDx12kS?=
 =?iso-8859-1?Q?9I2UjyzmMmY2SBJhKCZjYkgo7mDqWIMMnZCy8gizAMh0tx8TqWE6fEnjFC?=
 =?iso-8859-1?Q?n1xXGRPuaD9BeVDTRzw+SbUptUHjOrekDox6QVrN9WX1glvnBD9Wp030qy?=
 =?iso-8859-1?Q?mgAvi+YckwR4Xp6ZCCS60lraMEjZGN4mVkvDHMls7Gu1rxE1Xd5+Ftr+lO?=
 =?iso-8859-1?Q?Exu6kEEtzbEeenKxhNEAHDQnxGEpZAbqj5BNeK9f+myk/jYTWC2+8Bu9UW?=
 =?iso-8859-1?Q?BO0MSF4BCiBfhhNRXx8DC05sr/RBmwT3YG8FsWVUuyRZl3ocy4V1RVR35j?=
 =?iso-8859-1?Q?pioodvzMDMrTbWQN6oc1I+3FkUbwmVCpCczTyUfqGfiXHlmRxMwG+sha3L?=
 =?iso-8859-1?Q?w/y3XCtKkP2sJjLgEglEKs82FoGipVmtHubvnIaYcqfz1l/8iMJ0sH9O15?=
 =?iso-8859-1?Q?JF5c2Npy2wCfCgKxoCwvcbidKSrbR3+1zlkcvh5g4zsX/OUj0CAaLKqIkA?=
 =?iso-8859-1?Q?Z/I1yiKNHjNBEmMDJjyY0Wq5QwQNKlslB5zOO4bnocVZvr+k4SiJJDCtyT?=
 =?iso-8859-1?Q?csuK6HSP65NJD5hlh7DpivD1K7luEac9hHFRK9r7fmgFvrFDHFeWI16QPM?=
 =?iso-8859-1?Q?AFwcMeYgVoUiC04Xgip9eOu2IJ0K+vq+XMoAS1ft/xY9d0lqg5xVIhxUnj?=
 =?iso-8859-1?Q?+OBYhn7W57kpEmDE6Xomso9ZAfbTIGschax1fWOPbgkeT6b4VOt5mxvuJa?=
 =?iso-8859-1?Q?D5J1vN7NWeo7oAmYtklrURIpiw93ck0Zed8EIqqv4dlDSByLBI6qt4skyX?=
 =?iso-8859-1?Q?BbiJr/P0hvVsfE8+G/cmoxORCnymom1kX3MsnbofKXC5su/MW0SoUBM3FJ?=
 =?iso-8859-1?Q?UCbyHnezOQRzqY55mraWVLGJsKpr0n2J+0DHyRcFWL/+VcJsPYGXCuEjIo?=
 =?iso-8859-1?Q?plDO8U5HFu+cD3E1ZZ7yHtlByRzi39xDWX7pRKGfWQHFwhL652ny0uOjTF?=
 =?iso-8859-1?Q?UjfJ7pU8tfQQWzip9KI0B8dscVyRUekWd3YGilvGTAmoxISoxQx1vRvm3M?=
 =?iso-8859-1?Q?tSo+X7Rx7hA4OUmUNXg7qFN0nZXpTRptXS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6786.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffd48f4-5a68-425b-6578-08dc6d986803
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 06:47:32.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhyyBGGb6z2goelWfSJzICK9VSIha1p30w+WCQescI6QHXGVJBXa2HQS2K720c6OrvtOeVE0iDaWFKJtRMu6EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9327
X-Proofpoint-GUID: RSfE5npXVMhGf6yxJ4O136p0PrBafcoF
X-Proofpoint-ORIG-GUID: RSfE5npXVMhGf6yxJ4O136p0PrBafcoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_03,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405060042

HI all,

The RXBOE is basically a warning, indicating that for some reason the SPI h=
ost is not fast enough in retrieving frames from the device.
In my experience, this is typically caused by excessive latency of the SPI =
driver, or if you have an unoptimized network driver for the MACPHY.

And no, you would certainly NOT drop a frame that is transferred over the S=
PI bus. It is the frame at the ingress of the device that will be dropped (=
ie the one at the end of the queue, not the beginning)..
Just my 0.2cent

Thanks,
Piergiorgio

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: 6 May, 2024 03:21
To: Parthiban.Veerasooran@microchip.com
Cc: ramon.nordin.rodriguez@ferroamp.se; davem@davemloft.net; edumazet@googl=
e.com; kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; saeedm@nvidia.=
com; anthony.l.nguyen@intel.com; netdev@vger.kernel.org; linux-kernel@vger.=
kernel.org; corbet@lwn.net; linux-doc@vger.kernel.org; robh+dt@kernel.org; =
krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; devicetree@vger.ker=
nel.org; Horatiu.Vultur@microchip.com; ruanjinjie@huawei.com; Steen.Hegelun=
d@microchip.com; vladimir.oltean@nxp.com; UNGLinuxDriver@microchip.com; Tho=
rsten.Kummermehr@microchip.com; Piergiorgio Beruto <Pier.Beruto@onsemi.com>=
; Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>; Nicolas.Ferre@micro=
chip.com; benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement err=
or interrupts unmasking

[External Email]: This email arrived from an external source - Please exerc=
ise caution when opening any attachments or clicking on links.


> [  285.482275] LAN865X Rev.B0 Internal Phy spi0.0:00: attached PHY=20
> driver (mii_bus:phy_addr=3Dspi0.0:00, irq=3DPOLL) [  285.534760] lan865x=
=20
> spi0.0 eth1: Link is Up - 10Mbps/Half - flow control off [ =20
> 341.466221] eth1: Receive buffer overflow error [  345.730222] eth1:=20
> Receive buffer overflow error [  345.891126] eth1: Receive buffer=20
> overflow error [  346.074220] eth1: Receive buffer overflow error

Generally we only log real errors. Is a receive buffer overflow a real erro=
r? I would say not. But it would be good to count it.

There was also the open question, what exactly does a receive buffer overfl=
ow mean?

The spec says:

  9.2.8.11 RXBOE

  Receive Buffer Overflow Error. When set, this bit indicates that the
  receive buffer (from the network) has overflowed and receive frame
  data was lost.

Which is a bit ambiguous. I would hope it means the receiver has dropped th=
e packet. It will not be passed to the host. But other than maybe count it,=
 i don't think there is anything to do. But Ram=F3n was suggesting you actu=
ally drop the frame currently be transferred over the SPI bus?

	Andrew

