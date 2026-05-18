Return-Path: <netdev+bounces-289053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHjWLNUJC2o0/gQAu9opvQ
	(envelope-from <netdev+bounces-289053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:45:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98D56CEE6
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A12A300B593
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7342189E;
	Mon, 18 May 2026 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pY5nRRD+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BB41B356;
	Mon, 18 May 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107993; cv=fail; b=RZxU29nlG90nln2FgvUGF5JSPgny/ymkQkhik1Pm0X7pUhA4ZbYOSaSDrROU6cojL17nPuAVNA+ffb6lWpLWCfvivBZNeDl/YyWug0Swgq5GvncoB6MpkJEXdk2oQ0ml98WfIctQ9WamSexlrYFUKOkr1mBD0qDe/HaZmAxAEas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107993; c=relaxed/simple;
	bh=0r4icJTV79QZC/oMDNcF8VuECJuD4FPcCE7ogbBERl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThBuBOFbzWYC90UMN+vHmR/dndZFSYJJTkON6xMtm12MdcFq9Ok2qew1j4YiBLR08fYS4cBxoxF37CQ3XyNwk1xjHSIuxIPlPyhH53dIXX0sRIYm4oix4LZzllR3UvIJnsPwIctaFqFtBjFZl3GZZMxcfVg/Yto0xscwQspJIGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pY5nRRD+; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBHZn3717462;
	Mon, 18 May 2026 05:39:42 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020083.outbound.protection.outlook.com [52.101.61.83])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e6r3evep0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKXsffmr7v83MMNdiB9lQvbkS8yJ/rrHuiQ3SzR5IhbChIjw6IAdCNrguubkurB829o2BPwO+VVCLkZGi5v33KAZ5XR8fAo6TjMoocDeUAlE0FWomxjPerJ/zZkNs+CYGzGTOcO06qD8Pya/BRKrZMKnCciF5VSNahqZIolobL3pEAyvVXxfU7XTgYUR76Kv5hRzuM53hIDCmCtQXSO71Gal+aNjg6YrWiEy3iQoxWgoEODVWazAbuoVuOVyywNj1dxpyQf5QFQmSRCSpmVuGXgOp2GU75JF1vHOiO77nHdY9ekwHW7egMPYkmAtj4ZU983xgO2bu9NHWcQaUdnR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r4icJTV79QZC/oMDNcF8VuECJuD4FPcCE7ogbBERl8=;
 b=ezCYcRK/GuMeghoIfHMBP5fMWny13VYXjb+TpYyZkbRkfzvQ3s8qH4gEM5k3RW6XMg6BreBTDxkHKBlogxYZIgOcPpxrtUOVeLm+0awU/usfR5il1Zkg5/9pehIfY68/dwNlAxtUueuEtFZMkatNucuyfWEu0MDLX94CR/6xRibtIiCeLnsnySrtX3nJ1xOQ2j/Ry2n9YEN7zH5Xg8XQ79+B5c8DfpdM0VUBLuu13i7JrCzk9NrfGISMUH0YtLvNzxboeVu2tKN8Ypg8nKG/1O0DhwZS6cqKqZj2deF6l4TjDzgpP5YlBizrqTG5sSO8DAL31o38VlQcXYjeL8wOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r4icJTV79QZC/oMDNcF8VuECJuD4FPcCE7ogbBERl8=;
 b=pY5nRRD+iLQxubpo1h4AbpGigkl/815HFQH6RJrdHINRt3mrBlF6kU06VcQdI7YSA+fCO/uzG8TDes3qRjc7qeOPAmXGgImBYH2s8kspVzXvSquALIfBxFsLIDSZfOGoqC+QGA4uwytHVIqpTCFVlBweeTInB5M+YoAdnxbBvPc=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by PH7PR18MB5749.namprd18.prod.outlook.com (2603:10b6:510:304::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:39:38 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:39:38 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Igor Russkikh
	<irusskikh@marvell.com>,
        Egor Pomozov <epomozov@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next 2/9] net: atlantic: move
 active_ipv4/ipv6 bitmap updates after HW write updates after HW write
Thread-Topic: [EXTERNAL] Re: [PATCH net-next 2/9] net: atlantic: move
 active_ipv4/ipv6 bitmap updates after HW write updates after HW write
Thread-Index: AQHc3WBoDJ9GgDNuG06r5D/eOrkIfLYKL6CAgAmNINA=
Date: Mon, 18 May 2026 12:39:38 +0000
Message-ID:
 <SA1PR18MB46008E383B8443820BB989A1BA032@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506135706.2834-3-sukhdeeps@marvell.com>
 <20260512095339.134878-1-pabeni@redhat.com>
In-Reply-To: <20260512095339.134878-1-pabeni@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|PH7PR18MB5749:EE_
x-ms-office365-filtering-correlation-id: e0e64d4e-bebc-4554-feb1-08deb4da8682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003|4143699003|11063799003;
x-microsoft-antispam-message-info:
 hJ0chhakchw3Ejp2ZUaNAJPK3zRWK8tomPZOerYg6iI82I3VZJTQ3GKuoZElbGVkPmvXV8QVhkeBBvkhA/DQq2lAVdQ4ctIjNRiDJacVk3sc/9FID407ochrpyHjz/v77RkeObbiXir8sXDZohnRBJ/901uCwceufB82/haWyie939UK067wFVChV/iA9hDK6BRWFGY5HHXBCdeFhbpU/0PbBATIrQTg9G+3QzwlxTWBrPl3VBSQe1HETAFwBrJIz4bjT0BLfT9ja4/t+BAYfdN6o8vJKNDfrFQfAjJYv5s6ifY+sE9L2HznXVyDAnrHdahEuJJS9D+GGhojt6qY7YLIpc7fdwE+giW35ny16PNpT2xqPR1Io2Lmp8nlOyu8Tg2G/AhROXXt5D/Syt59Nrb9/WAP4fSby8wBpTFGj3yu4d+SkzhjrJldG156rwQBL1U3Y9+K+Ojngocm1eTmNNLICCDVCgrS9Zom/GUKkwQpKebLUkPsStiTixcMOwotrvoEv4CoBBixuQywSLGGXGWM/Qp1+J5mVBcsxJ1au7i9Lv9GTbfZqLvia1I3yJiQ77jmymbxJN/54a/LaQHRzVbO8WXpl48sARkLgkGRCkNPicNBOzKowdUwZT+bAr1V/fAik3vp8e3pgO6rcWdhd8PPOWn0N1zsNJRNexmNGHJCU3HvSf70eALXe3HWAwY0jJG1snvu+v8q48NEP2uao7oCdp7wx53uNIxoTe1Hhn6Vwa7IMe/ktyJ5yTGjoYWX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEgwcWthVUFvMERRRnk5MklPNk1TZ2tlR1BMZUhRVi9aQVVPcnZxVTVyNzZP?=
 =?utf-8?B?M28yNXdaQ3pmL2V3ZVNIS3kveWU5b3NJSldFM1VzSFdKZ0xqVlVJV011SmFN?=
 =?utf-8?B?U1E2dThZc2FJRlFBL2tUQ0pPVENZRnZFM3F1cVg2c1VrNzEzUzJaa0pMQjdC?=
 =?utf-8?B?VDFHM01CYTNOZjF5MHhiZnpQS2g1V29HdjB5UFZRNHlSUC82VldOYStyTzNi?=
 =?utf-8?B?akNkYUMyNFM3a0RIYWpUYmtkbGh5aGxCbTBPWmZRWkpGTEJFTENMU1NxSnN1?=
 =?utf-8?B?aHlGYm1wNWRMaDVCRTZjNm0wZkNpd0ZWanBMRU11VXBLRzdRNU9jQ00ybGJy?=
 =?utf-8?B?Ky9oOG91MElVOGVQR3JDOE9nNnRSMzJ4UXY0ZjNmaUIxYjZzU1BwNU82bzFO?=
 =?utf-8?B?S1NBSVpiNEtkYjZRTmtDQkRCdDhEZGVjR29KcVRZYkszcm9rYnpaZHNrOEVa?=
 =?utf-8?B?WVJVbjBxZ240VkxYODlreURXd1pYQzNOSXVYOHJKY0V4QUk4ZGwwczBsTFhn?=
 =?utf-8?B?TUZLd0c1WDJiWXo4TlJqMFBRS242V1RGTW9OalZhOE1BSGNiRUdxVStLeStT?=
 =?utf-8?B?RVJoU2d2T0dCZXlsaS9sUHRuK2JHQTYzSzBkMWRKTDJQSGF0OXFnL2dVckt4?=
 =?utf-8?B?cnI5N1hUMUY1ajl4clVmUjcxOFZQQ1Q5K3lOdnV5NXMvTkFEUFBuWHVwZTJt?=
 =?utf-8?B?ZVdwckxORVA1c2ZDeHdDRkxnM0tRa3BvWlA5RG9kdFhxZ3ppRGJESTdmMGhj?=
 =?utf-8?B?YzFtZXA4RkR4YjVBSEZUVE9Ub1hIZzAxME5vMVRRUHZPYVVvRHdXQ3h2cGp5?=
 =?utf-8?B?djhkRjdVWEJremh5a01jV0RBbGxnVWFxQU5FK3dkOU1jR0hsbW4xWEIzMHRG?=
 =?utf-8?B?bE1vV1p3L2E4RmdZbWN4OSsydmlJUGlzQTU1Z25JTEl3aEd4N1BEV2w5Z2hm?=
 =?utf-8?B?ZWZybmxvWVdTOC9OSVlDRk9zT2lFM1JKVk5OZ1dZRVV4SlVucjVVbW5CbzN5?=
 =?utf-8?B?ZExIVkI5Q2owNVNZRWpxTWZaUURnRFdZK1lPcVdvRG40Tm4rakF5R1ZrY3VE?=
 =?utf-8?B?UFVMRnpnNUd3cmlmdGVYNitrZGxWbFc5YWtFSmIvSUY4TEFtUm9qTFl4K0Vw?=
 =?utf-8?B?U1pML1lJSy93UlpBM2VTVDVEQ0JUY09rWXFFVzQvcGY4Y3BoelF6Rmx4SXJK?=
 =?utf-8?B?NzhvSWJneXNKck5VT2pRdXliVUtLdHcxL084Ti9vVmh2MUJkbGxDWllaclAw?=
 =?utf-8?B?NnpFWURMd0RLT2Fwa0Roc282d01hNmFSR0tZaDRRcGFoa2RxOTNWVnRxaXNK?=
 =?utf-8?B?YXNBb2VMK0hmZ0xFTnFYUisyRTVwQTZvaHVQTWM3dUY4ejZic1NmQmN4N1c5?=
 =?utf-8?B?Z05zZVc0bURNWVpNMFZGVE5TeWJYNUkrK0ZCVVV1WE5lOS83aUJGdlBEYmlm?=
 =?utf-8?B?OU1BOFVQdkpZMEhNNDNWZEhmZEk4YTFad2pKWkpNL0FWQit2RGhMTGhKMWxs?=
 =?utf-8?B?REhkTU1hVGkzUnIrSVp1MDRQSDZGRURGMVRsVTArc0ZPbmtseklEUUtnc1NW?=
 =?utf-8?B?Mnl6RzNleHVPc3Jkbmg0VEdkWTAxYUhsUjRlRE01cSt0YzYyaUZYbUROTmRD?=
 =?utf-8?B?bjEydUhNWnZiTGdzbVlBM2ZCWllZaktPcFpsQ09Ba09MMCtvZDVVZHB5YU1S?=
 =?utf-8?B?bWRhWVQxWEREU2dnSGtyclkra1ZaTEg5RVlDTks1cVlwbGJlTzZDeHVnOGR0?=
 =?utf-8?B?azhZdXI3dVpEOFJsZHV2QU5QOU45U0YvRjY3YWZaK0FSMlNtK2MvRmVDbmxF?=
 =?utf-8?B?WUJBb1RoaFpuSXlxcUYrVEFkUzJkQ0FlWUplMFpPdVRIKzFHRG9sRmZvY04w?=
 =?utf-8?B?M2M4eDhYdlc4TnRiOURVU2pkRWJockw0Z3R1VFRqTDdHYzNrNy9VN3ZpaExU?=
 =?utf-8?B?TkhvYU9QSGJxdEtic28rWW9GYmNYZ3VjVDRSM1R6bUZEU3pYV0Vic0Nzcjlp?=
 =?utf-8?B?b09IVkkwWTFIcGVPYzllM2dCK0RyaUIwRG11ZlRLdUY4aTE0K0lCc2kwQTJQ?=
 =?utf-8?B?dzVhVjJrYVZlV2tiYy9MNG5PbTQ1bWRIZGVXWEl3WE94a2x1ZVdrZEFCKy9j?=
 =?utf-8?B?Uys5WTJMMWVpdW9rYktuTUh6dDlVNW9aYVVSdzBUKzRCdDN0UkE4U1p3WGxB?=
 =?utf-8?B?NkRwQVNDNUx5RmtzUVU0dzdUa2NZTEZUQjJEN1VQNkxnYy84NitBVnBmV0dV?=
 =?utf-8?B?NS84azk2WmtYSXVnY080bTBnNm9PbjQ2N1MyNWtQRE5qdUowVm9iZ0NqWnE3?=
 =?utf-8?Q?Ax/PJKbnmjiLlqlPcx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gC6H9T0e6/5rDZoTurOnf17FOAruGNw3wrs04Dh4rNiSI3m2UMhaV80Gbs/9LKPQIhJ+dCI8y171T281eo4+jeGrqVqBQCja4Sv/iMbkmz2Q271viXF2IpcTi+5Ws1XxHcqOJAJEYIcXs79Wf9p5afkHps6lDm1SmknmTO7rUs2hZny+ZB7uvB4NSzyUVK2feW1gjQEUh+2xJtu/biAIuJFdmHDDsPASPKR7BdSk+XT6eXFAyXOe3evGJz4dNRb9fBsfy0BJ8K3RB1wLZxRGvG+Yx7EnfE9jTInbrFwpBdWhZWLdHbNO8G5FJ3U8i3IZnqz+5TN92rvzh6B+BJ1MEA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e64d4e-bebc-4554-feb1-08deb4da8682
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 12:39:38.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs9E6XeGEe7R6zIID7t6Di79TA9LHhvcC/BazJZYF2JMc1r9SC/Jp8k4ruBaP/N9fPG91g3JLJqPUeDc7xW72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5749
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEyMyBTYWx0ZWRfX3v65kwp+fjY1
 N5M7HgD1Lfkwb2ZujlrUdSJe13ScSINME1jjvzHqAu2KDLV0Ocmz/zDxYSLrwl0/Qv70qJi/zBK
 NiWDxGrZwn5rv4Vy2VljtQzmQ4jnkin4dwbkitxZmOYdmYisxwgr7lGI3FM7tbKgyHiiB1IFfy1
 3oI5iPgYO/mEuCdWkgjjDVdOATx2dapf5eFkEmROKy80pfS20lGr2ZrAlCFK13Ymwt/b7lBwn/T
 J5TjCdBtBlLCetGfxbQxuvpaMlfd6DnHBomT1P4JcDTwL5FZQb5GjziPWDI0vQ3vPadd63TdBUE
 bjt1hlbjH2OI8sijNcymX6Qmcudai8q2JdZ+SK3LLFhOir2v2Z9nPLiUsMAqE8Jhe69/qOFpkmY
 6n7O1uo29C7gLtH7PRctwx67Unr6Qx3KEoTv0kVL2MEII03zS1T5m0FDyG30H7nV4ULEPeN4mq8
 f6IuMcrAJftxvLSP8kw==
X-Proofpoint-ORIG-GUID: VmhMm7sPvr7uvuqmVRbtGD-qFhEIOmx_
X-Proofpoint-GUID: VmhMm7sPvr7uvuqmVRbtGD-qFhEIOmx_
X-Authority-Analysis: v=2.4 cv=Vp8Txe2n c=1 sm=1 tr=0 ts=6a0b088e cx=c_pps
 a=2MR8MeovB3HU/Khs2orgEw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=BFiUtCh7ndbT2dfImaEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Rspamd-Queue-Id: 5B98D56CEE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289053-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gMTIgTWF5IDIwMjYsIFBhb2xvIEFiZW5pIHdyaXRlOg0KDQo+IG5ldDogYXRsYW50aWM6IG1v
dmUgYWN0aXZlX2lwdjQvaXB2NiBiaXRtYXAgdXBkYXRlcyBhZnRlciBIVyB3cml0ZSB1cGRhdGVz
IGFmdGVyIEhXIHdyaXRlDQo+IA0KPiBUaGlzIGNoYW5nZSBtb3ZlcyB0aGUgYWN0aXZlX2lwdjQv
YWN0aXZlX2lwdjYgYml0bWFwIHVwZGF0ZXMgb3V0IG9mDQo+IGFxX3NldF9kYXRhX2ZsM2w0KCkg
YW5kIGludG8gYXFfYWRkX2RlbF9mbDNsNCgpIGFmdGVyIHRoZSBIVyB3cml0ZSwgYW5kDQo+IHJl
bW92ZXMgdGhlIGJpdG1hcCBtYW5pcHVsYXRpb24gZnJvbSBhcV9uaWNfcmVzZXJ2ZV9maWx0ZXIo
KSBhbmQNCj4gYXFfbmljX3JlbGVhc2VfZmlsdGVyKCkuDQo+IA0KPiA+IG5ldDogYXRsYW50aWM6
IG1vdmUgYWN0aXZlX2lwdjQvaXB2NiBiaXRtYXAgdXBkYXRlcyBhZnRlciBIVyB3cml0ZSB1cGRh
dGVzIGFmdGVyIEhXIHdyaXRlDQo+IA0KPiBUaGUgc3ViamVjdCBsaW5lIHJlcGVhdHMgInVwZGF0
ZXMgYWZ0ZXIgSFcgd3JpdGUiIHR3aWNlLiAgV2FzIHRoaXMNCj4gaW50ZW5kZWQsIG9yIHNob3Vs
ZCBpdCByZWFkICJuZXQ6IGF0bGFudGljOiBtb3ZlIGFjdGl2ZV9pcHY0L2lwdjYgYml0bWFwDQo+
IHVwZGF0ZXMgYWZ0ZXIgSFcgd3JpdGUiPw0KDQpSZW1vdmVkIHJlcGVhdGVkICJ1cGRhdGVzIGFm
dGVyIEhXIHdyaXRlIiBmcm9tIHN1YmplY3QuDQoNCj4gQSBmZXcgb3RoZXIgc3ViamVjdHMgaW4g
dGhpcyBzZXJpZXMgbG9vayBsaWtlIHRoZXkgaGF2ZSB0aGUgc2FtZQ0KPiBjb3B5LXBhc3RlIHBh
dHRlcm4gKGZvciBleGFtcGxlICJtYXNraW5nIGFuZCBJUHY2IGhhbmRsaW5nIG1hc2tpbmcgYW5k
DQo+IElQdjYgaGFuZGxpbmciLCAiZHJpdmVyIGludGVybmFscyBkcml2ZXIgaW50ZXJuYWxzIiwg
IlRYIHBhdGggc2V0dXAgVFgNCj4gcGF0aCBzZXR1cCIsICIoQW50aWd1YSkgKEFudGlndWEpIikg
YW5kIG1heSB3YW50IHRoZSBzYW1lIGNsZWFudXAuDQoNClllcywgbm90aWNlZCB0aGUgcmVwZWF0
ZWQgY29weS1wYXN0ZSBwYXR0ZXJucyBpbiBzdWJqZWN0cy4gQWxsIGNvcnJlY3RlZA0KaW4gdjMu
DQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1YW50aWEvYXRsYW50
aWMvYXFfbmljLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hcXVhbnRpYS9hdGxhbnRpYy9hcV9u
aWMuYw0KPiA+IGluZGV4IGVmOTQ0NzgxMDA3MS4uM2NlYzg1M2U5ZmFkIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX25pYy5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1YW50aWEvYXRsYW50aWMvYXFfbmljLmMNCj4g
PiBAQCAtMTUyMiw4ICsxNTIyLDYgQEAgdTggYXFfbmljX3Jlc2VydmVfZmlsdGVyKHN0cnVjdCBh
cV9uaWNfcyAqc2VsZiwgZW51bSBhcV9yeF9maWx0ZXJfdHlwZSB0eXBlKQ0KPiA+ICAJY2FzZSBh
cV9yeF9maWx0ZXJfbDNsNDoNCj4gPiAgCQlmbHRyX2NudCA9IEFRX1JYX0xBU1RfTE9DX0ZMM0w0
IC0gQVFfUlhfRklSU1RfTE9DX0ZMM0w0Ow0KPiA+ICAJCW5fYml0ID0gZmx0cl9jbnQgLSBzZWxm
LT5hcV9od19yeF9mbHRycy5mbDNsNC5yZXNlcnZlZF9jb3VudDsNCj4gPiAtDQo+ID4gLQkJc2Vs
Zi0+YXFfaHdfcnhfZmx0cnMuZmwzbDQuYWN0aXZlX2lwdjQgfD0gQklUKG5fYml0KTsNCj4gPiAg
CQlzZWxmLT5hcV9od19yeF9mbHRycy5mbDNsNC5yZXNlcnZlZF9jb3VudCsrOw0KPiA+ICAJCWxv
Y2F0aW9uID0gbl9iaXQ7DQo+ID4gIAkJYnJlYWs7DQo+IA0KPiBDb3VsZCBkcm9wcGluZyB0aGUg
YWN0aXZlX2lwdjQgdXBkYXRlIGhlcmUgcmVncmVzcyBQVFAncyBJUHY0L0lQdjYNCj4gY29sbGlz
aW9uIHByb3RlY3Rpb24/DQoNClllcywgdGhpcyBpcyBhIHJlYWwgcmVncmVzc2lvbiDigJQgdGhh
bmsgeW91IGZvciBjYXRjaGluZyBpdC4NCg0KPiBUaGUgUFRQIHBhdGggY2FsbHMgYXFfbmljX3Jl
c2VydmVfZmlsdGVyKGFxX3J4X2ZpbHRlcl9sM2w0KSBmcm9tDQo+IGFxX3B0cF9pbml0KCkgdG8g
Z3JhYiBhIHNpbmdsZSBMM0w0IHNsb3QsIGFuZCB0aGVuIHByb2dyYW1zIGl0cyBJUHY0IFVEUA0K
PiBmaWx0ZXIgYnkgY2FsbGluZyBod19vcHMtPmh3X2ZpbHRlcl9sM2w0X3NldCgpIGRpcmVjdGx5
IGZyb20NCj4gYXFfcHRwX2h3dHN0YW1wX2NvbmZpZ19zZXQoKSAvIGFxX3B0cF9wcmVwYXJlX2Zp
bHRlcnMoKSDigJQgaXQgbmV2ZXIgZ29lcw0KPiB0aHJvdWdoIGFxX2FkZF9kZWxfZmwzbDQoKSB3
aGVyZSB0aGUgbmV3IGJpdG1hcCB1cGRhdGUgbm93IGxpdmVzLg0KPiANCj4gQmVmb3JlIHRoaXMg
Y2hhbmdlLCBhcV9uaWNfcmVzZXJ2ZV9maWx0ZXIoKSBzZXQ6DQo+IA0KPiAgICAgc2VsZi0+YXFf
aHdfcnhfZmx0cnMuZmwzbDQuYWN0aXZlX2lwdjQgfD0gQklUKG5fYml0KTsNCj4gDQo+IHdoaWNo
IGNhdXNlZCBhcV9jaGVja19hcHByb3ZlX2ZsM2w0KCkgdG8gcmVqZWN0IGFueSBsYXRlciBJUHY2
IEwzTDQgcnVsZSwNCj4gcHJvdGVjdGluZyBQVFAncyByZXNlcnZlZCBzbG90Lg0KPiANCj4gQWZ0
ZXIgdGhpcyBjaGFuZ2UsIGFjdGl2ZV9pcHY0IHN0YXlzIHplcm8gd2hpbGUgUFRQIGlzIGFjdGl2
ZWx5IGZpbHRlcmluZw0KPiBJUHY0IGluIGhhcmR3YXJlLiAgQ2FuIGEgdXNlciBub3cgYWRkIGFu
IElQdjYgTDNMNCBydWxlIGF0DQo+IEFRX1JYX0ZJUlNUX0xPQ19GTDNMNCArIDQgKHN0aWxsIHdp
dGhpbiBBUV9SWF9MQVNUX0xPQ19GTDNMNCkgYW5kIGhhdmUNCj4gdGhlIElQdjYgZmlsdGVyIHBy
b2dyYW0gSFcgc2xvdHMgNC4uNywgc2lsZW50bHkgb3ZlcndyaXRpbmcgUFRQJ3MgSVB2NA0KPiBm
aWx0ZXIgYXQgSFcgc2xvdCA3Pw0KIA0KWW91IGFyZSBjb3JyZWN0LiBSZW1vdmluZyBhY3RpdmVf
aXB2NCBmcm9tIGFxX25pY19yZXNlcnZlX2ZpbHRlcigpIGJyZWFrcyBQVFAncw0KIHNsb3QgcHJv
dGVjdGlvbi4gUmV2ZXJ0ZWQgaW4gdjMg4oCUIGFjdGl2ZV9pcHY0IHVwZGF0ZXMgYXJlIGtlcHQg
aW4NCiBhcV9uaWNfcmVzZXJ2ZV9maWx0ZXIoKSBhbmQgYXFfbmljX3JlbGVhc2VfZmlsdGVyKCku
DQoNCj4gSSBsb29rZWQgdGhyb3VnaCB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzIGluY2x1ZGluZyB0
aGUgQVFDMTEzIFBUUCBwYXRjaGVzDQo+IChhcV9wdHBfZHBhdGhfZW5hYmxlIC8gYXFfcHRwX2Fk
ZF9hMl9maWx0ZXIpIGFuZCB0aGV5IGFsc28gY2FsbA0KPiBod19maWx0ZXJfbDNsNF9zZXQoKSBk
aXJlY3RseSByYXRoZXIgdGhhbiBnb2luZyB0aHJvdWdoDQo+IGFxX2FkZF9kZWxfZmwzbDQoKSwg
c28gdGhlIHJlc2VydmVkIFBUUCBzbG90IGRvZXMgbm90IGdldCByZS1yZWZsZWN0ZWQNCj4gaW50
byBhY3RpdmVfaXB2NCBieSBhIGxhdGVyIHBhdGNoLg0KDQo+ID4gQEAgLTE1NDMsNyArMTU0MSw2
IEBAIHZvaWQgYXFfbmljX3JlbGVhc2VfZmlsdGVyKHN0cnVjdCBhcV9uaWNfcyAqc2VsZiwgZW51
bSBhcV9yeF9maWx0ZXJfdHlwZSB0eXBlLA0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBhcV9y
eF9maWx0ZXJfbDNsNDoNCj4gPiAgCQlzZWxmLT5hcV9od19yeF9mbHRycy5mbDNsNC5yZXNlcnZl
ZF9jb3VudC0tOw0KPiA+IC0JCXNlbGYtPmFxX2h3X3J4X2ZsdHJzLmZsM2w0LmFjdGl2ZV9pcHY0
ICY9IH5CSVQobG9jYXRpb24pOw0KPiA+ICAJCWJyZWFrOw0KPiANCj4gV291bGQgaXQgYmUgd29y
dGgga2VlcGluZyB0aGVzZSB1cGRhdGVzIChvciBhZGRpbmcgZXF1aXZhbGVudCBvbmVzIG9uIHRo
ZQ0KPiBQVFAgcmVzZXJ2ZS9yZWxlYXNlIHBhdGgpIHNvIHRoYXQgYXFfY2hlY2tfYXBwcm92ZV9m
bDNsNCgpIGNvbnRpbnVlcyB0bw0KPiBzZWUgUFRQJ3MgcmVzZXJ2ZWQgc2xvdCBhcyBhY3RpdmVf
aXB2ND8NCg0KWWVzLCBrZXB0IHRoZSBhY3RpdmVfaXB2NCB1cGRhdGVzIGluIGFxX25pY19yZXNl
cnZlX2ZpbHRlciBhbmQgYXFfbmljX3JlbGVhc2VfZmlsdGVyIGluIHYzLg0KPiAtLSANCj4gVGhp
cyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3Lg0KDQo=

