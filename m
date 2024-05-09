Return-Path: <netdev+bounces-94819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1331A8C0C57
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3657E1C215DA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D9113C801;
	Thu,  9 May 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gnC7Jxu9";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fjcwee5g"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE0149C74;
	Thu,  9 May 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242573; cv=fail; b=JGSKokf1Xcx2FLue7rmek8rPHTFwvXEpKhjdLtVXZweugjJiXR7VezkRrru0a/iP/cIVzX+ZXhllyeRC3BM6KWSY6c/vfti+26orLg6WSXKMsTVqICqWQbb8IUnSoKflpsgRMHHiUFIr7g+hI3bOSMjhbY0KjPX0xxKoOi9C6ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242573; c=relaxed/simple;
	bh=mVAUuvcjtHMbDjpv2tWyCyG1Aa2nr+Xinjucvn7K5rQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QlWUHFhs2H+rWdoQChE1pxiE2TTb2GdV/1WP5or4hYW73ry7PgXgcgzaBSCy8v3U5PmHeDZAb8uIxm9xFbcwQoCngHaSDXOaRF7O3RFlB+rzEVfbwLbgVCF7VsJ4/lp2t0wf2tyPXtrnyL2GlK/VDx7RkiuuVWL7Vc9p3f9wHqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gnC7Jxu9; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fjcwee5g; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715242571; x=1746778571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mVAUuvcjtHMbDjpv2tWyCyG1Aa2nr+Xinjucvn7K5rQ=;
  b=gnC7Jxu9HFUSc/SXMVtA68r0uizRsg+w3x6FGxypLzyPZ0b3FTk+JFSv
   XgnAgN5pyeuUFRTrwrqmltm6nLnDgnMYzIx9YzG5x4jhp4mNj8EbOh1zc
   55pjIguUZCSrqEBDrI3bdzT5NscV7awFNkeBDJbB9vBhoNJ0yn3b6Fgpx
   dMYJguDPmlYjOxUk953oNltTFxqPw3MNbBmtcGG4zHUWsopjTPY5GsIw3
   sCvkvWALiFNXrT/C3G2Uz+Fd40WqTWQBoqQkBCnQ84m3IVDvaY3u1QXOW
   cpT09wV+yf6Lq11ug7tykQnhZrsi1HOQuibl6sik2j4VBHscx+zNFSB9B
   g==;
X-CSE-ConnectionGUID: rkMuEdy2TvqpUtT/Dk/drg==
X-CSE-MsgGUID: QgoZ+mHOQ0y2W7Rmtaj62A==
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="191612010"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2024 01:16:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 01:15:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 01:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpGp+1Lc+hMSmnbpilKxn05GFLECUYjheYfhFQkkzuT9xOYi+LT9a8qscs3NfBUe/ZFscvp/LCb0jNw7zDFmV+Q8F3d+uyC3oC1EdgWvOgApgiG9Xvj7IbDigMbkwydB69nX77LSU7NXfa9xWFhGjAi8LEwFR/msyvrhUaZ8xI1IwSyBlYNflcudDxDuYQNYJtKY3G3Nf99+zv7Z83rAd4GbjEbS1eq1bP0xQaBf13J+AeEW8dpnwqN1H8i/br5IudmKIT88I1sAd8mCKvatK/Empjq+4kFLA+h7FqUJ9ojD7s6E3p5kiniXw84YCok8hndPgzdOvnE0IGxx1Dc6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVAUuvcjtHMbDjpv2tWyCyG1Aa2nr+Xinjucvn7K5rQ=;
 b=EfGdeCjbPsOmRBwPWfqZYpLk6Q3FCS08elXKQuX52PSby/tEMUtdeo0OYWULgoMqSvsRvuOwn39WtuNQbSz1qn8H0xN/MyPMY3ZlAfkcIeGSis46ZGKv2t+8r2cI3SXmwOV1J4h8Lr0j6FXIQLG+HqJdgub0Rognw7e2XclZeikZfaxw/NY0tM59LbQMPQNhnwpiPIoW5Oq7fkjwoGkgsI9nccKBtSAKdX+LIdxwwzL6W1MnLt0yuhHbfHt2Lem5GMByKr7cudTL2/1xI/0x2ZuibRGdRWHqFLObP5U2AHyWmaYJdRIl+IgsCxv7WGApHbg6yNEoWjs7+T+aK6FQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVAUuvcjtHMbDjpv2tWyCyG1Aa2nr+Xinjucvn7K5rQ=;
 b=fjcwee5gKHWXrwjX1FjsphcRKF6vte4dAH66Ex4CBeNBhTuf64EL1u09kJyrjGddTgR9Vby0cfxjn1MDREd/E8N3qsygdsamK/0LWkpGoD4LFBe7v9m58qD2rg3uehtaeeGtKfRnkpLeCYACNRveZHkov67guN6MBwfrcd2MJ+EjvHzZNhXR4Y0W6RQwFhtDxAo/J9RVrKsq91AM+rm18VuZis81pj4Hh6Q3hZagVa/8erQ/r1ZdHLcMLhp/81iQTTV6zjk4Ad2LVZPHff8MB8ZWzskOqSaxkS4aOPbfInzPZbho/nAvu7icm7s341kypNgyPDQW7sekfGj8FTSg4Q==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Thu, 9 May
 2024 08:15:42 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%2]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 08:15:41 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: dcb: set default
 apptrust to PCP only
Thread-Topic: [PATCH net-next v2 3/3] net: dsa: microchip: dcb: set default
 apptrust to PCP only
Thread-Index: AQHaodJ/jSRbI3SKMk6Ob0It42tQrbGOjwYA
Date: Thu, 9 May 2024 08:15:41 +0000
Message-ID: <b271ce19110163600d4af5675a4dc6bea102cb55.camel@microchip.com>
References: <20240509053335.129002-1-o.rempel@pengutronix.de>
	 <20240509053335.129002-4-o.rempel@pengutronix.de>
In-Reply-To: <20240509053335.129002-4-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SJ0PR11MB4799:EE_
x-ms-office365-filtering-correlation-id: f61761b3-1e4b-4c9a-f42e-08dc70003792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?akcwKy96a3BPek54bzRlUDR4Z0pHR0RtVkZQbS82ZUVoM1pTVUZoYXJJbG9F?=
 =?utf-8?B?N2s4NjNQYlBQVW1iRjhleHMwUCsybXhFdzB2RSs4bUFRM2RjN2VZL1ExdjBM?=
 =?utf-8?B?OGFvWkNDM2c4NjRhclowRnVsY0c1cXRFVHluSHU4djFxT3k3MmdzeWY4TGx4?=
 =?utf-8?B?VWFZbkQ2Y3cyeU1Db3BwbUpVOUtEVnV5RER5TmxSbm5ETlJtV3B4VWZCMFc5?=
 =?utf-8?B?QksvTkRWRXV3Si93aWs4K0VxMGJTZ1N1SFREVENMcVh5Y254U09NTXFNbFln?=
 =?utf-8?B?cnZGS1N4YU96cEdlbTNFaUREbk4zMW44eEFPeEhFMkJqOHNUeFJBTVNyWUFL?=
 =?utf-8?B?SDhWYVNCdVorQU52L3NzK0MyakZJQXQwOVdSdnk1MjhZNUtScmVwRWwwRjJC?=
 =?utf-8?B?TXZFTkVjRUNjNDUwNWRScDdVOFIzam9ZNk9GS08xaVhzVlZkWjFKN21LWVN3?=
 =?utf-8?B?QlY0enhKVG5HempmTUlQTmJmVlFnOUtNRHRwQWp0cmxsS0lTWDRRR3RMMFZk?=
 =?utf-8?B?eWxxbFBLRFV3NHI3d1FrUlRQaFN3VldoOEQ2VzJobC9HazdnclcvVHcxUlgx?=
 =?utf-8?B?K2lvNTJ2SEMwWitHbmoyaThSSE5FRVRrL2Z5c2prYmg1TXgzSGx3eGhXUjZq?=
 =?utf-8?B?ckxaWGwyY3lvZ2l2b3paZU1YQ2taTlVGckRPM05HRjRvYzB4MTVteXBLNkRP?=
 =?utf-8?B?TmVMSHJzUHUzY0pqWkhLeEQ2MUxHaTlxWWpsc0l6ZGNkRXNhWkJxZzJYQnFN?=
 =?utf-8?B?YytFY0x4cXVLbmNkemVXUHBvS2U5bzM4R3VkTmd4Zy80ODNOSzlZd0w2eTRN?=
 =?utf-8?B?cTdTTjZ5RVVLNHZjSS9UbFNxWlVvUlBkdHJtOHpPTUF1RVM2bnZ1ZXRDbW5F?=
 =?utf-8?B?aHc2eEloc1VqZnlNbC9iUE1GY2JNeTVLRStqdWEwNHRiai9hTndjNG9jMk8z?=
 =?utf-8?B?WmJuRitEWXZINDJhZit2d0ZzTDVST0Z1ZHc4b2t2dnpHWk9JT21lK29JaDhs?=
 =?utf-8?B?OW1MdFdXc0hLeTdrUEdzM1NnaVMvUHZmei9jeHVENmdPYlRtWVhwOTEwREh1?=
 =?utf-8?B?bUYwZm1OTVY0OEsrdlNZNiswNmFmRk9RNGZDZlpQOFdlZmk3R1Z1YkxCakJE?=
 =?utf-8?B?eE1hbEo1OFh2aVgyRHEvRElFcE9RSDFvRUo0dkl2c3JNSkw3eDMvaU5OSUR5?=
 =?utf-8?B?eCtaMzM0V0RuY0owYXZqNjZtSFhKdm5NSW96Y3RmdG9FWFFsSm5BZm8rSXVX?=
 =?utf-8?B?a0F6ZkRNa0hBcjFMTmRSRG53eExNZnMrQm1zalVGb01HZGtTVVQ3V2hWQWp1?=
 =?utf-8?B?OTNTc0VkZkQ4NXUrT0ZHUXREU1hWNHU4YnB0cW1vYm5yWXhNbkJQWE9MZEFo?=
 =?utf-8?B?bXJobnNhT0h5bEIxQ1RpSFFqQ2FWaTFvWkQ2bkk5RlFuaTdSS1NIVi9VZkFa?=
 =?utf-8?B?U1VQSVRDY1lWMjJrbUN3Q2NXUDA5SlhCcmlTV2Joa3kraHF1bEJWQzUwdU05?=
 =?utf-8?B?TzV1VytscmZLWlNtSkxrNnBwUXUwenhaZkZuallYRjU3WllIMUNrVjhic1dz?=
 =?utf-8?B?SDlsNncvdjBDd2dXSnVOQnQ1UlpPZC9vTkdaM3ViOTNTRlg0TDJuSGVBMXF4?=
 =?utf-8?B?L1VIUkgrY1dRSmt0Z1QyZnlIZU1FdUhFYU1rRnAzZWhyc3c0elltbnlEdlVw?=
 =?utf-8?B?bkVLaDhQdkVyZC9YRk5sVVBJeFB4ajluNnNDM3dLUUN0dkQrY0d5aDV6VFF6?=
 =?utf-8?B?MGc2Zmg1STNSazY1U3dOc0lBa21GTXNmRGkzS2NpOFRlMVJjS2JZZFBJdjJU?=
 =?utf-8?B?ZU1zL0NMWFMxQ3BJY01uUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjBObWVJZGhFSzV2S01BVU1mSnpBVkFNSWtlTk9CVER3OXU0L2NsVFkzT1FD?=
 =?utf-8?B?Y1BSQVpRUGtKVDEyb21tMWRHSlBGM3Z1dzIyaHVBUEZSc2RFQWhjSC9DcU5m?=
 =?utf-8?B?OC9mL0F6TWhLVEdBOVB4VDNmQlZ5MGhDZnFxbWlaNGlJY25oMGR4ZEcrQWRz?=
 =?utf-8?B?bFBKK2ZyN2J5M0hnZFllbWJKQ0NJMlhNVHZSWkZBM3V5U2pja2dyTXlndWpW?=
 =?utf-8?B?OGg5c3lRTjJvcTBPb3BsNUZ0dDF2UXgwaFpsTzJ6WU8zMFpraXQ2U3NLa25x?=
 =?utf-8?B?dVhUdXNZSGNqRjNvcitGdkVWL2ZTS09yRTlaNllJN085WnU0T2o3K3Z4bTV3?=
 =?utf-8?B?b2R5VGlsemF3SldzOHdZUGU1bjdUQmtoZEF2VHEvSkNub0RoSkZyaFpMSUhZ?=
 =?utf-8?B?NkhDUmxXd1FsNmlnb3c0SjYwZ1JqTTdRRUFuemdKUERnYUJEMXdUaVhrdUN2?=
 =?utf-8?B?cFVyVmNaZkpadUpQRmtqY2ZNQm1aMW04bVdIbFk5RlVpdjlrNEJDYzVsL0JQ?=
 =?utf-8?B?aFdkUEd3di9jd2tEYzBsNFFCd1pmZlNTYThsMHJFRXpRR1E3M0J2RFMwUVVi?=
 =?utf-8?B?dkFIS3paVFVKNTYxWk96ZytNNmh1V3lydGhTNUo1d0tkTWc0R1ZLLzlhd0I5?=
 =?utf-8?B?clBoalJkRCtZRUJHM2VFRFBvRWUzYVVRSWRVYmIzOE5UYUtPa0pFNE92bHBy?=
 =?utf-8?B?Yk55Vjh6Y21heTlGdW1WSk0yNllxU2oySXRUc1krVFQ3VkptT0s3ejFNL3lQ?=
 =?utf-8?B?aG1WNnpyN2FYNnUwWi9DWmY0K0QvblYvLzZVSW8vYzZCUnJJOEpKcHRIM1p4?=
 =?utf-8?B?UUZIdXhZV0xRaFVaUWhEeUl3N3RSOHBWSktBUGV5VTduMVg4YjE3M2hkUkRJ?=
 =?utf-8?B?b1NPT21EblI4WGhIQlJyQmxkRTNvVWhWeUVMU0pZWGhnMk5kczZSQjVjQXNE?=
 =?utf-8?B?dU5DaWtraTFJdUVGOTdDamdMZlBGc21sNlZ5QVRaMmx2b1N5dE51VG5ObFdk?=
 =?utf-8?B?SGRYNVQ2bXloUlduQXkrSG1CZzVBVWFRN093QitjV0Y1aHMrZkVrMnc3WWhV?=
 =?utf-8?B?L2IwUTl4cmxUWTBrS1UvSUtLbXVXb3I5R1pQb1JlVzRhY1lXU2QvSVhreVdC?=
 =?utf-8?B?bXNuellEdFZ2TUtHeUlEOGViSEdoU3cwVHQvRkVJYS81d0oyYXd2UVh0SGxa?=
 =?utf-8?B?bnpDekp2R0grYVpWZCt1a01KM1E5MGVNbmE3cTNoQjNhRFV2dEUydjBFTUlr?=
 =?utf-8?B?RS8zWVYrT0l2ZVdXMkgyQ2ZtM0sxMHlsaTd1WEp6MUZlczFUbUdhNkI2Vkk1?=
 =?utf-8?B?aWtXRnBUT3RqcENhanZwRGhjRDdCMFhDc3dLUVYwRUh3T3dvQUdCTWNjQWRG?=
 =?utf-8?B?amk3Nll2bmNsQWdrUW5GNjBHbWYwWDkrVXowV3RGeDRuejFLK0VqRXE4NVBX?=
 =?utf-8?B?VWVWQ3Vwd2MwVVQ5R01USW85TURVWVdsNlpWZlFLRTJmUmdCWFJlSmJvdjlm?=
 =?utf-8?B?UU5WblduSjh6OUF4QVB4NGRLSHhZRjJaZEdVVm8vdHlibW9WY0E3cWgzTVhB?=
 =?utf-8?B?Mmtnd3dlNkhFNW5YK0w0VW43QnJaRTZ0dXNrbCtBTEhFVHpDUStQWUUweDFv?=
 =?utf-8?B?SVhsN1BwaWZVVmoyajFGenJjUVR4dlUyYnAwTWxRZW00MVhEWHZ0Zi92TTlo?=
 =?utf-8?B?MFRPdXlwaXNLQU1uQnNPMzB4UmFuTVpnNVlMeDRjdElEalRIMjcwLy9tZUZB?=
 =?utf-8?B?OVhtZHkzM2xVV0ZaODM2VFZHZzNLbXJyQUl5THlZQVViUlFhOWtvaXVwN2lH?=
 =?utf-8?B?b1lWNTMvanJiOFZsZTcvVmxwMm55TmEwclNRWHFxK2Zzdkxpek9OR2Jka1Zo?=
 =?utf-8?B?U0E2SmtrRWxxQkpySjZjZ3lSMkxVUlN0Sjg5aWFzWCt3VkNvS2RjNDlpQ253?=
 =?utf-8?B?bUh4Ni8zcG1XdWk3UTlDMUp2QzdHOWRoVVM1Z1JsRlJuSlJuajVRcDAzdnR6?=
 =?utf-8?B?V3VHazczYWlZY01HRkErK1BrL01CbDgxczJybUhGYWlkbnNVTGp1VTdhQ09x?=
 =?utf-8?B?RXorTlJSVmdCTHg3MFc0R3FuUUZLQU11NUFhcytvaTFxc1lXUnc0VytQN3ow?=
 =?utf-8?B?Vkg3U1E0TitJYXhNRTl4Q2krL3pQNWR3U0VUdGw1ZXY5Qnl5d01Rd3RSdHFJ?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F96019A465904A9FFBC5A42B1D94CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61761b3-1e4b-4c9a-f42e-08dc70003792
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 08:15:41.4294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJugWc4K4BwW1llvHJY3lyM9OGQzLGasX0BPIyd8mNlOicPsdqgbSF0QBpPiHjI24daLqnBWocD8TfwhHsJF4d7acxvYiFKL3pL4YmkD/jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799

T24gVGh1LCAyMDI0LTA1LTA5IGF0IDA3OjMzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBCZWZvcmUgRENC
IHN1cHBvcnQsIHRoZSBLU1ogZHJpdmVyIGhhZCBvbmx5IFBDUCBhcyBzb3VyY2Ugb2YgcGFja2V0
DQo+IHByaW9yaXR5IHZhbHVlcy4gVG8gYXZvaWQgcmVncmVzc2lvbnMsIG1ha2UgUENQIG9ubHkg
YXMgZGVmYXVsdA0KPiB2YWx1ZS4NCj4gVXNlciB3aWxsIG5lZWQgZW5hYmxlIERTQ1Agc3VwcG9y
dCBtYW51YWxseS4NCj4gDQo+IFRoaXMgcGF0Y2ggZG8gbm90IGFmZmVjdCBvdGhlciBLU1o4IHJl
bGF0ZWQgcXVpcmtzLiBVc2VyIHdpbGwgc3RpbGwNCj4gYmUNCj4gd2FybmVkIGJ5IHNldHRpbmcg
bm90IHN1cHBvcnQgY29uZmlndXJhdGlvbnMgZm9yIHRoZSBwb3J0IDIuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQoNCkFja2Vk
LWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoNCg==

