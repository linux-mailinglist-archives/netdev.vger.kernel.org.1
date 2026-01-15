Return-Path: <netdev+bounces-250068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05817D23994
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E28343037CCD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4A356A10;
	Thu, 15 Jan 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="YKqZ5ssP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759B32E745;
	Thu, 15 Jan 2026 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469699; cv=fail; b=Gj15hqcAHmn+KfqOq7KGmooFLKEeug7rvMzxbIoRUw404OAxlllXhVochi+I4oOPAOwGmhZdubVkb3bodg2i6RlMehrgS2n6hL9A68LyI1glUGpsU+0SG0bVGUPfgV7fTeK2updWeYNo1l0AUTeWPITUnnejrODsXoozvmYZocM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469699; c=relaxed/simple;
	bh=BiFLWEyXpEWHc2DfXL9Ci7RFQHxTRfcoTG7ULcM4VxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4Fk7oPXhuLsOfyTxgrWjJXmyEbx6w3IV6XkVSUe2RQIdE876QSFCb/FjNNQVdG2N89kdQvCusKVLa39wtTnt3pZZTnumpQiih6R0n9Q4aePpXwHChZh+xT36+GX6zvQRSAK1g7GmHWZWINLCl8bKuHP+Q+612yR+dOn5XtktAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=YKqZ5ssP; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ENSHFe1190562;
	Thu, 15 Jan 2026 01:34:34 -0800
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023117.outbound.protection.outlook.com [40.107.201.117])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bpmufh1s4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 01:34:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gryvHF2LBjK6eAhqlTYivV3MW9r0ELVN2RhMyFEbyteZHQlIXtgHX+Ma9IMt6pQc8kSnhHIcMJS6yyk4Kq8LgcrZOAq5H3okeNolr9GQaYP1nQ7gV3k8mrXjeQoaDop0/WJhun35uEmWtXm5pL/srBJXvKoXSmRGwpz/qPIqLvMI7kjcXskGOH7GcVm0fmY9bwI5j9J14sy+QuN+V+z6CE6k52Tsoa/cVdLys2NlHPpAWEWcgeFzlahkp+9EPlKLGfAO2UQy7FeDHEWgW1UEhTyLS4AqLSmyIcSI2kZoo1mk+6NeBFsy6OcWyp51xV2CK9N+SnXiWgA2Q7qVY/Zqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiFLWEyXpEWHc2DfXL9Ci7RFQHxTRfcoTG7ULcM4VxE=;
 b=CVpjML0qTcfAyq9GqHU6YE8zSLyZCrhR4gj17xt+8MfDgIaOJkoL7GCavKkdFhjO/cHy0WfiVVyK99G1womn69dicpuyeqCwpiKBq2ZMygvUcLO8XeQr3l6ktGbkITn8Uyl5mFFROO0vw1V5IA2GBWPXSHBFK4/2bYQbj8hvKsRBLQhTv1NZstjAn6F+pAt6DuGULTtoGtnj94YPo33pTILx58h8FysoqOkQhFqi2GzZrHy16f+MB+TMlSgNBLWCKYQ4gU7y9PFyCqUe0+Hsg7crX3ASXwdigmZOHipvdHdZaRQiIVZQ4EO5vxaC/gfxOPhEslyvShclDdRi9Hj1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiFLWEyXpEWHc2DfXL9Ci7RFQHxTRfcoTG7ULcM4VxE=;
 b=YKqZ5ssPlGBtG98zkzWS4r1sovzcIZ5ZMnoNiUbyUBkd5ob1LpVMvqRb822/W0eszw3rJnjZblxdpQdTQjdJDEdbFFPzPWbzGy3Zx6hG1eU6at3U9kNabcrr7n77WudkAQW27+88AEYCZ5EJss0xCwwVUV0adxvGTnrlaaiQGvU=
Received: from MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21)
 by IA0PPFBB9A48050.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 09:34:24 +0000
Received: from MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2]) by MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2%4]) with mapi id 15.20.9542.001; Thu, 15 Jan 2026
 09:34:23 +0000
From: Vimlesh Kumar <vimleshk@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sathesh B
 Edara <sedara@marvell.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Haseeb
 Gani <hgani@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v3 3/3] octeon_ep_vf: ensure dbell
 BADDR updation
Thread-Topic: [EXTERNAL] Re: [PATCH net v3 3/3] octeon_ep_vf: ensure dbell
 BADDR updation
Thread-Index: AQHcf9g9aGaovzN8N0SyzFnaV/fSs7VOouIAgARguRA=
Date: Thu, 15 Jan 2026 09:34:23 +0000
Message-ID:
 <MN6PR18MB54664F9D22C6374CEE5FBCF3D38CA@MN6PR18MB5466.namprd18.prod.outlook.com>
References: <20260107131857.3434352-1-vimleshk@marvell.com>
 <20260107131857.3434352-4-vimleshk@marvell.com>
 <aWUHrqOpf-6hZqlu@horms.kernel.org>
In-Reply-To: <aWUHrqOpf-6hZqlu@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR18MB5466:EE_|IA0PPFBB9A48050:EE_
x-ms-office365-filtering-correlation-id: 282462bf-b257-4892-17f3-08de541944c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUhjaTQzZGVNOVNTLzZKS1M5aldTdnNvOU56TG1GaDRSY0oydXFXK2dONW9B?=
 =?utf-8?B?UU9SM295a2JJS1pIU3JKUFBlaWRySzhMNC92aFR3K09XRlkvSWROajBMcGw3?=
 =?utf-8?B?aWdFYUxlZzZ0ejdqdjJEM21zOEFrVmdsN1dPbGxseWJZcDAvbURpaGRsY1ln?=
 =?utf-8?B?RUlZY1p0SmUwUDZieExHaGR6NTNSeXczekg2NTFKMU9jbXMwVUI3YlBIS1Fl?=
 =?utf-8?B?UHFvelBVMEdybm5LTTZtUkJVdFVLSDUyNGlXYnBRbStqQy9GVi8weEZqUmhs?=
 =?utf-8?B?UmJxd1BkMjdISTMxQVh6Mk9JVnM0dGJPcDV3bnVNWUpOMWdvRk54L1huNmFL?=
 =?utf-8?B?N0J5ZmNtWnljWUd1NlVrZVJlbnI5aW91VFlCSUFrQ1lVNm5wS0phL1dpOXdE?=
 =?utf-8?B?b21rS2tRdVl1UHNpQ1dkVTZsdmxSYVNyREZBZnlDaWc5VWx4bzViVWFrZUdE?=
 =?utf-8?B?YTBYL0xlUVNqUFdoVk1Ub0NYRW9YT3VZMGI0VTgwV2dKMkpXU0w3M0ZtdHJE?=
 =?utf-8?B?NFRWQmJMRksxaVdtNm9rdjI3SWxqUFVuT3BSeGNMOEdtTHphZndtUVN5TSsy?=
 =?utf-8?B?VU56REhWZkFuOXBJMVRWVHAxQ2lWbVp5SDg1RFgrNUo4YkFSdEZWODRRSThw?=
 =?utf-8?B?NWxsL3Jpd1IwMTN2QmtvYklMNGZOejA3Njc2UlZyR3I0QWJ1Y0M1WG9DUTlJ?=
 =?utf-8?B?dHFpZEdKNkhKZm83TzJCMGlseDdBTklaUGpXNFUrMzd0ZzZyRFFCY2FTT0Y2?=
 =?utf-8?B?aGdwSlNKNGZOMEZEYmhtcnVYQXV5QmEzb3dYQVVqSkJQUVN4Zk1IdE16LzNG?=
 =?utf-8?B?YXQrQWJ6R2NWM2k5MVgyVC9NOExveUE2Zm9qWXNGTVI3ajhVaklFUE95cnd2?=
 =?utf-8?B?K0RYTENmTHp5QWlXMC9Mc3N5aFFJa2FKeXRVZkI0YWplVmJ0anJZOUdIY3hs?=
 =?utf-8?B?RzNtNVJpSTdaNzhvbUYxc2tKMlR1Yi9FaHBnNGg4NkxXMXhlNVhpcHFndEMr?=
 =?utf-8?B?UkNIb1RCc0k5ekNpdldmVlY0ZzBZNThjdHN1eGN3ZDJvYk5seStQM3RhdGlP?=
 =?utf-8?B?dmI3emE3dEVGZEtweVRqTThSclRnRXVUb0c0NlYrNnA5alFqM09CT3FCR2lt?=
 =?utf-8?B?QkQ1Q0lIWmtGTVpyYTlUUEFPZkc0ZHEyTVU1VjhEVFhhUUVCZEl0YTVxY3Nv?=
 =?utf-8?B?U1VCVEFCWGswRVZCN0laOThiaGVxVzA3VE55TDd5V3Boa1QwTHhGZ0Z1WnlW?=
 =?utf-8?B?Y2w2T1NLUUpGQkMrMnBhYm9BZk8wb0pQWnprRElJWkdDNFFPTVFOM0N1MVhx?=
 =?utf-8?B?aUd3WTVsY3kzVGNWWk5pTlRvSFdWMVNtdWQ0SzNMU2xCbGtjaGVRdUUvaTk2?=
 =?utf-8?B?c0ZrMytCMmhqbjNnSmlwYjl5Q241ejBReCtRbVBlbDcwck1uMGhmT25HNjlM?=
 =?utf-8?B?UjRtZURHQURQSzlucUIvRWhvY1VjT2c2SEVVZ3h0bU15TGNWbUh5NzB4YUla?=
 =?utf-8?B?MCtrZ0I5Y2ZtNS9seTV2SUMzVWZZTGN2eGFKWXBYeDhhN20zTlhMV2c5aGc3?=
 =?utf-8?B?cVBPTllreFhtaWFHSytQclJ5ODRmaDluVXpVWFRIb2RyRDJVRXQ3R09VTmhH?=
 =?utf-8?B?ekUyQ25NNXhkMWJvRTU5V0FDWG4rVTNQN3JMSTdoNmNSSEhLemsreFZZdktG?=
 =?utf-8?B?Y1lBL2dyTXZDN0MzaGdTNHZhaWpOUGxWcElncVFDbEk1WGpXMVQ5Z2hveG1h?=
 =?utf-8?B?cDZPWW9qaTlhMkE1Q0htTVVhQ3g4YVNpZHlGWDUxSzRkYkZWK05QcEhlTjFO?=
 =?utf-8?B?TVowUUt4bXp4UDhDWGNmOExjK0JHNTc4aDRSZERSbUNnM3RwZlljMTk3QWNj?=
 =?utf-8?B?VGYvMWR4Z3VGUlM4Z09oTFpyemFYcUk1MlhQTFFBTTVuQWZTQmNMM3VKVU8y?=
 =?utf-8?B?VzVoeE1GbGJzb21QS0lleWk4U2RqV3MrN3g4ZFlmVTJ2QlF3OUh1NHprVXVH?=
 =?utf-8?B?cVNjYTNmRkNOZ2lBL1R2L0tpbnhaa1lFYkNGelBLRkEyNVllc3RRQWk1YkI3?=
 =?utf-8?B?Ky84dk9MMldKOEVtTmh0ektYbWZxZUZzVmFEbWxaRHFXOXluWHU3WGxqc0lm?=
 =?utf-8?B?aTJJQjYzWUdHb3F1aFR1S1RJbWVaVEVGSHVKc3J4MUxOY05ScnU4Z3YxNGdO?=
 =?utf-8?Q?Nu50G20YyKyu2p14iVei5qk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR18MB5466.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGtIQkFhKzFhWnJnaGM3SFdobWd2TUM2YWR0OFVSNEtOQ0R0STFMNTUyQTU2?=
 =?utf-8?B?TzRFOXlVQ3pwbExhZ2FrenB1RzdkY1Y1b2Q4WCt2TWtGV0JUSmRrV3FBY0JC?=
 =?utf-8?B?cGpJRGVubSs5YkNVNXM4eVQyZURDenZ2OWMyakFlUGQweEJIazJLYmdKazRa?=
 =?utf-8?B?VCtwYXNBbDRaUy85WVdpWUFiN21WMEUyVzcxcVl6akQ2ZWJ0ZnpDdDZFRitO?=
 =?utf-8?B?ZFo3ZG9yNk93U3pKN0crVzNQaFRacjVQY3J4cUhRZmxHZWlmMWgySnd1UVMy?=
 =?utf-8?B?V0xmWHZ2R2g2aFliVVVnSVdqWUlDOGJjQkFPZDlPRGtHTGFIMC95MlRlWGpa?=
 =?utf-8?B?bEdEaXNaZmYyKzFOYlNEMFkrQzh4aVlXSmJmRTRlb2Z2RDNaUzlOUFZiTFlE?=
 =?utf-8?B?MnlkaXdubkFaNG0wL0RwdTd6MWhCeWFRRC9Vdy9tMnN6eGtXYlN1c21nTVhC?=
 =?utf-8?B?dVZMVmtkZEtxWXJmQjR1RFlCUkRYZUFNZ3ZPdFRIQkg0VzN4a0RNSldkQUhK?=
 =?utf-8?B?anhDdHY5Qzc4NVFkajhJMkRJalBvZzhhZWN4VEJYbmdkRmZSM0xtc0V5ZEtr?=
 =?utf-8?B?TjVoRit5M1Y2MG1IeEdVT01PRUY4cU9wd3IvYmlmczVPdmdpTUVRTWxDdGdr?=
 =?utf-8?B?L25YYjR5TVdZeDV5RFN3TkFzNHBTSmJnc2NVVm1XT3AzRit5T3lyL2hSMVp0?=
 =?utf-8?B?dldJRVkzTUxtZWU1MGlWYnl1NzgvRDgvVExCUW9NS2xUUlNOYVpyaG9kZ0Jn?=
 =?utf-8?B?dGw0OUx6ZzRSTmNYbVMyUjV1Um5wU211a0dDRXVENkg1d2ViT0lNR1pNRjI3?=
 =?utf-8?B?YkNHeGp0ZXIrdDBMY3hDNk51eStCdDYzOC9IbnZ1VHRybTlIM09YN0ZWZmxI?=
 =?utf-8?B?ZE9RcHVvRzd3QTVpcEJwVFJ1MDc4dU5TMUcyL0VMUmhsbFMxamw4Z1FVb1c5?=
 =?utf-8?B?d0pUOEVTSFh1Y0krZ1l6NDk1em1oTnM1UENGOFdya0piWlBGM3lrdE1yZkNk?=
 =?utf-8?B?STdXbmJkSEhLUXFMQzlPNEdqbTVHbjl0TCtPREhaOE5nbndsR1BwNmprdGlr?=
 =?utf-8?B?ZjhGdklmRXMvYUlkR0J1NkNGNWw2eTZDS2t2amdwTm5tOFdRNmlPTXIzVmhz?=
 =?utf-8?B?cDdkekt0TytrZlRxZ2VpM05TejUzRHlVdFE2cDg0VHAwWFBYUHB1aTk5UnlL?=
 =?utf-8?B?WndVMEQ4QWxFc20ySTJpU3BJdlE0RFhKU0ZvZm0rZjdkeUxuL2IzUTFxTWQv?=
 =?utf-8?B?UnUvclFYRUlpUmVnbDRpdUs5WlNqSnNPQWhRVVlWeFZMRWF1dXlTdUd5UGMr?=
 =?utf-8?B?THhjS2ZpWHJWN2ZVa3g1VGlaQXg5dE8rd0hxeHFLK2VPRXo0RHEvbWlRZDZX?=
 =?utf-8?B?VW1WUWYwSkhCZjQwamNqUTZWYmtzUWYxdnhpVE1JV1RWWmRxSVhiY0hObFcv?=
 =?utf-8?B?M2NzY08yLzdQTTlPbnk2bHhlSGs4aCtEUkRMNnNIc3gzcHV5VmtnMVU1bXlu?=
 =?utf-8?B?NnRxSDJMMVIwUWUyQUZsUTZFMlpBdC9CZVBST01WaVVtUEpScGcrdlZVRXpN?=
 =?utf-8?B?MTlIamh3a2w2YUZhcHZLSnRkVVE2NFc2N3B4VEdQZlRaaWR0QXFGU0dPU2lm?=
 =?utf-8?B?Wm1EVGFtb2lESHJaY1VsZjQwZThFVTgvemJpd0pMSkorNlNxdmdEc2NGczgv?=
 =?utf-8?B?UDFrVnJTeHN6MFN0VlZQOHVQOFhsSWxhV2YrVmdwTmN5VlZoOWkwMmxxNVEr?=
 =?utf-8?B?OHFhYnZuOXZYK0xpem9KT3VwOEtzSkFDV2I3T3UvdWNFcEdXUUh4U0xnbVNj?=
 =?utf-8?B?WTJQYnUvK1R5UlYveTZoK3M0WmxxbEh0V05SMGdtSk8xbXY4bVNuUTdaVlBG?=
 =?utf-8?B?bWxtYzQvSW1NNjRJbHAycFhkbUYzNTFrdnRLbW5pZ3FpMGRHMHAyNkJuNGJZ?=
 =?utf-8?B?M25YaU5qemJiL2U3RnFuVWY2NWh4dVY1U3F5TDFZWmlPQVROaWZXVWg4Zm0x?=
 =?utf-8?B?OG1UV2kvb0NkY3MybEl5dnZrN3ZRS3haOXhPVkpsUG1WekNtNkFPRWtlM3Rl?=
 =?utf-8?B?WWExbnNtK3BNN3ZBZ21lWkRXVU9KdEIxV1I0VnR0QTIzeUttTUlEZjJ1OWdi?=
 =?utf-8?B?b0x1MU5GK2FFODRnYm1yYXltNFFzbjZ2bUsrRTdLRVRkVUZnMEZORzJWdHdG?=
 =?utf-8?B?ZmYvTXZjL1VFZEZjemRGd1JkbEVQeEVzWDNZS01GczMzZFg4ZGJ4bGcyc081?=
 =?utf-8?B?TmNZY1A4THF2V2wxVHUyVEVTWStJNGdmd3hxZnBSNlFTNk9HbnRGSE5GSENn?=
 =?utf-8?Q?tenXIgD5mEXmStVKum?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN6PR18MB5466.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282462bf-b257-4892-17f3-08de541944c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 09:34:23.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m30Th8W5/X7g591vTgFBZIqRGv1vWfmgMfXJEAiBI2RV6KnopMzzmC0BH8G2UQX1pFxQbhNGF4Ka2U7yiccbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFBB9A48050
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA2NiBTYWx0ZWRfX75EqEP0dD9+f
 kDlKovEUwRJrh3Fvrbi7qEg4yphqko8C8nm+nuzcCoAJwOwt36YOaL5SojVhGPB1bW+VlQi/29x
 fTQYgWrjjzfkVnrP6Y+w5NnZL/5HJcA2LjmCxShBDX51yULe0aDIiTZU2f/XcfjJU/fQ3poEuGi
 HknhOMNmZmTnoSjnBL+M/kmDST3t1z27rucJ+shI99DcF4oYhwi5G/e9B5DfYnCvsNCNodf+a60
 Yh7mfYsq3LjEDiTeaggtb4BYxcWklzX1x/bulserELxcRF1+BdYh6GyzlI+JDbiZXZBUyqbrf0R
 4Qwh7ISG7tPEucItgkRC5cBj/BIQDTSn2LNSOashic4C0dJRHUlt6W88FBMn8IWnu8dury4na7a
 OtSoJJbD/dI2uW6K30hTcFrrHD9aZjAKkIM6a0QNpUQZpyhtB7hZcSGIVSCWbJEkfjnZH3ylWEi
 mW4R65bMZ6gUtNok3sA==
X-Proofpoint-GUID: wMoOELJSYTqniY6c_I1WL2JwAvotFGdq
X-Proofpoint-ORIG-GUID: wMoOELJSYTqniY6c_I1WL2JwAvotFGdq
X-Authority-Analysis: v=2.4 cv=edMwvrEH c=1 sm=1 tr=0 ts=6968b4aa cx=c_pps
 a=czckzaKnCwXpY126n2X5rw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=2lxw3UYo9iNxTTAS6KEA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_03,2026-01-14_01,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMTIsIDIwMjYgODoxMCBQ
TQ0KPiBUbzogVmltbGVzaCBLdW1hciA8dmltbGVzaGtAbWFydmVsbC5jb20+DQo+IENjOiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTYXRoZXNo
IEIgRWRhcmENCj4gPHNlZGFyYUBtYXJ2ZWxsLmNvbT47IFNoaW5hcyBSYXNoZWVkIDxzcmFzaGVl
ZEBtYXJ2ZWxsLmNvbT47IEhhc2VlYg0KPiBHYW5pIDxoZ2FuaUBtYXJ2ZWxsLmNvbT47IFZlZXJh
c2VuYXJlZGR5IEJ1cnJ1IDx2YnVycnVAbWFydmVsbC5jb20+Ow0KPiBTYXRhbmFuZGEgQnVybGEg
PHNidXJsYUBtYXJ2ZWxsLmNvbT47IEFuZHJldyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6
ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3Jn
PjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJO
QUxdIFJlOiBbUEFUQ0ggbmV0IHYzIDMvM10gb2N0ZW9uX2VwX3ZmOiBlbnN1cmUgZGJlbGwNCj4g
QkFERFIgdXBkYXRpb24NCj4gDQo+IE9uIFdlZCwgSmFuIDA3LCAyMDI2IGF0IDAxOuKAijE4OuKA
ijU2UE0gKzAwMDAsIFZpbWxlc2ggS3VtYXIgd3JvdGU6ID4gTWFrZQ0KPiBzdXJlIHRoZSBPVVQg
REJFTEwgYmFzZSBhZGRyZXNzIHJlZmxlY3RzIHRoZSA+IGxhdGVzdCB2YWx1ZXMgd3JpdHRlbiB0
byBpdC4gPiA+DQo+IEZpeDogPiBBZGQgYSB3YWl0IHVudGlsIHRoZSBPVVQgREJFTEwgYmFzZSBh
ZGRyZXNzIHJlZ2lzdGVyID4gaXMgdXBkYXRlZA0KPiBPbiBXZWQsIEphbiAwNywgMjAyNiBhdCAw
MToxODo1NlBNICswMDAwLCBWaW1sZXNoIEt1bWFyIHdyb3RlOg0KPiA+IE1ha2Ugc3VyZSB0aGUg
T1VUIERCRUxMIGJhc2UgYWRkcmVzcyByZWZsZWN0cyB0aGUgbGF0ZXN0IHZhbHVlcw0KPiA+IHdy
aXR0ZW4gdG8gaXQuDQo+ID4NCj4gPiBGaXg6DQo+ID4gQWRkIGEgd2FpdCB1bnRpbCB0aGUgT1VU
IERCRUxMIGJhc2UgYWRkcmVzcyByZWdpc3RlciBpcyB1cGRhdGVkIHdpdGgNCj4gPiB0aGUgRE1B
IHJpbmcgZGVzY3JpcHRvciBhZGRyZXNzLCBhbmQgbW9kaWZ5IHRoZSBzZXR1cF9vcSBmdW5jdGlv
biB0bw0KPiA+IHByb3Blcmx5IGhhbmRsZSBmYWlsdXJlcy4NCj4gPg0KPiA+IEZpeGVzOiAyYzBj
MzJjNzJiZTI5ICgib2N0ZW9uX2VwX3ZmOiBhZGQgaGFyZHdhcmUgY29uZmlndXJhdGlvbiBBUElz
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYXRoZXNoIEVkYXJhIDxzZWRhcmFAbWFydmVsbC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpbmFzIFJhc2hlZWQgPHNyYXNoZWVkQG1hcnZlbGwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpbWxlc2ggS3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwuY29t
Pg0KPiA+IC0tLQ0KPiA+IFYzOg0KPiA+IC0gVXNlIHJldmVyc2UgY2hyaXN0bWFzIHRyZWUgb3Jk
ZXIgdmFyaWFibGUgZGVjbGFyYXRpb24uDQo+ID4gLSBSZXR1cm4gZXJyb3IgaWYgdGltZW91dCBo
YXBwZW5zIGR1cmluZyBzZXR1cCBvcS4NCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXBfdmYvb2N0ZXBfdmZfcnguYw0K
PiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXBfdmYvb2N0ZXBfdmZf
cnguYw0KPiA+IGluZGV4IGQ3MGM4YmUzY2ZjNC4uNjQ0NmY2YmYwYjkwIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwX3ZmL29jdGVwX3ZmX3J4
LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcF92Zi9v
Y3RlcF92Zl9yeC5jDQo+ID4gQEAgLTE3MSw3ICsxNzEsOSBAQCBzdGF0aWMgaW50IG9jdGVwX3Zm
X3NldHVwX29xKHN0cnVjdCBvY3RlcF92Zl9kZXZpY2UNCj4gKm9jdCwgaW50IHFfbm8pDQo+ID4g
IAkJZ290byBvcV9maWxsX2J1ZmZfZXJyOw0KPiA+DQo+ID4gIAlvY3RlcF92Zl9vcV9yZXNldF9p
bmRpY2VzKG9xKTsNCj4gPiAtCW9jdC0+aHdfb3BzLnNldHVwX29xX3JlZ3Mob2N0LCBxX25vKTsN
Cj4gPiArCWlmIChvY3QtPmh3X29wcy5zZXR1cF9vcV9yZWdzKG9jdCwgcV9ubykpDQo+ID4gKwkJ
Z290byBvcV9maWxsX2J1ZmZfZXJyOw0KPiA+ICsNCj4gDQo+IEhpIFZpbWxlc2gsIGFsbCwNCj4g
DQo+IEkgdGhpbmsgdGhhdCBhIG5ldyBsYWJlbCBuZWVkcyB0byBiZSBhZGRlZCB0byB0aGUgdW53
aW5kIGxhZGRlciBzdWNoIHRoYXQNCj4gb2N0ZXBfdmZfb3FfZnJlZV9yaW5nX2J1ZmZlcnMoKSBp
cyBjYWxsZWQgaWYgdGhlIGVycm9yIGNvbmRpdGlvbiBhYm92ZSBpcyBtZXQuDQo+IA0KPiBMaWtl
d2lzZSBpbiBwYXRjaCAyLzMuDQoNCkhpIFNpbW9uLCANCg0Kb2N0ZXBfdmZfb3FfZnJlZV9yaW5n
X2J1ZmZlcnMoKSBpcyBiZWluZyBjYWxsZWQgZnJvbSB0aGUgY2FsbGVyIGZ1bmN0aW9uIG9jdGVw
X3ZmX3NldHVwX29xcygpIGluIHRoZSBlcnJvciBjYXNlIGFuZCBoZW5jZSBub3QgcmVxdWlyZWQg
b3ZlciBoZXJlLg0KDQpUaGFua3MNCj4gDQo+IEZsYWdnZWQgYnkgQ2xhdWRlIENvZGUgd2l0aCBS
ZXZpZXcgUHJvbXB0c1sxXQ0KPiANCj4gWzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50
LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2dpdGh1Yi5jb21fbWFzb25jbF9yZXZpZXctDQo+
IDJEcHJvbXB0c18mZD1Ed0lCQWcmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9YmhmM041Q3I5
TkZiWndsDQo+IGE2RWJaaFlwUkhoUXpmcnF4TWlwWUlacENNWUEmbT1GZnBZYmxOYk1rSW9qYWRL
TGotR2RCV0I2dS0NCj4gRmI2b3NmUUdscmptUDBQcVE5cmhTZVhia0d1ejF3Q2lCUTRFMyZzPUct
WV9vVDREVzlaNUo4V2MtZS0NCj4gWFhRUmdWQ25fOURYVENEdWtuTXFIcmxJJmU9DQo+IA0KPiA+
ICAJb2N0LT5udW1fb3FzKys7DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiANCj4gLS0NCj4gcHct
Ym90OiBjcg0K

