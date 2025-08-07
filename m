Return-Path: <netdev+bounces-212008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D300B1D236
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 07:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482405613EB
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 05:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF1207A18;
	Thu,  7 Aug 2025 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="OwynM5y0";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="PPp2Jrd4"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68821D7995;
	Thu,  7 Aug 2025 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546200; cv=fail; b=PNf6dBP/KRTzgANCNGtK2KmkExx10fQ3ip/ty2Pnh6Nh+r95igRKXEueS3jHLILG5/gjlW7WVxUmWhV7KiNgYB/xD8+vLmt2NQtbhfpDUiLLZ1KN2HtYcwKMsgP4CFjsBoQoWKgz17czR8xYPGH5pfDkZ35k+ImwT69dxKLdb94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546200; c=relaxed/simple;
	bh=7mirPLDUEKJi/oV7KFsFAjNYfEg/N8inKTr14G3b6wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l0SG6gzsW2oU6QCNrY986YzWp4CIBjd0LqyAsbXjcFXidAj6M0qtqZmIWMDpd8z83ZFwLWI1ccWG7zo9EwF3xmevqgxL5bSYVdCXbu1V1ahFH/oDZJo2Hit7EWV6kBXc4gG8cFIcoNGqPMjZ79n1QK9WGszFH7RL02ekF3h9E3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=OwynM5y0; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=PPp2Jrd4; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5775O7T53818366;
	Thu, 7 Aug 2025 07:56:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	TDNZAR6ohBDb3pIW8Ljog7G2oL3tUAdwTjZ7bMhPsK0=; b=OwynM5y0E7apBMJZ
	dC5nRnKCFDFdGJGTNIeJKVGl4VBYLJrAE19KrUngz5if4fTilPYnSLCeDgJdY2/5
	0f7PaCnN7XW5WIsBiL3hBh6RWL0KPYPshECbgeePXG97N3GtSWD5hSKC56s2lWrH
	nmq+GNY6+rX+mdwHdg0vLsvxno1RVqd2/yHAirrUW+ZNSUBdEok5E3tAdU9lii95
	DaeTkheleakofEvBEhTHGVEZwhHmTQGn3WycPRKpiZ+clfqWugbGiRC0eyqXFUak
	crExBmJ5fFaJdNf36nHaVbKUEyJRQOZhtFSxWJ4pTY3aD/OG+yC0ID8hwD5JdWKm
	43S3iw==
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03on2128.outbound.protection.outlook.com [40.107.105.128])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48971a4jd6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:56:06 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLovUCyT+fcJnrmE7t0Ea4ZoB6ElCexrMwfKfhDQfEJjMk9qA0u6SSrJdgSxiEPQ0DhxPSjmzCR2qKfOrAKRi41hioJH2wJ9geFIZKQzHRYxpZLP6GA0NSdW1rZTDYrh5cuFX/clbcEZHxBMOqpZq/UTWC6tpg95/49/QsQjwBGI8aUWUGoR3rD3eltKXp/hXB8odlgpNxGECUNYLuG3oGMydRULw9kJwKlWIE5OaL4rJ9Vu2kn94wZ8W6DgYd95x6E/wDHHlKsbr6wb8uFziU+NUhAe4lVMaHAy+iWtYuAWhO/GwybI55tP2IMjRaUXna/Gk88iwYT6JGA/mkRMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDNZAR6ohBDb3pIW8Ljog7G2oL3tUAdwTjZ7bMhPsK0=;
 b=CgUoSwRF4kePWN3Z3urlFCfytfbBVoiUX81z4otF4ykEmrIBfVtDQUyBS7y4mUvDdqjmBZ/MGaEfZLW4WY9TvqCNuSiHpg/zwyNvJg1r4f2KHRog4MNeDCsd1DCEXqM2iivCHGToYU2yfIwNwS3bxCwM47GL1rO2R3h44U2KP6Aytfca1cY5o8iL/N3vLGIykNgncc64g7Z99/Od4CGzcvcHd+8ztyWuryYAhZqlGcC0AAx3SpUk9hXA55+7X0cJ+jDaiRVbffyx5TjcrCapSVt7ucV6W6yaMFiWpDeyFgX3w4n4Wpatdbm8Xsj7+/ka616oS8q9VlpPDG3EabybSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDNZAR6ohBDb3pIW8Ljog7G2oL3tUAdwTjZ7bMhPsK0=;
 b=PPp2Jrd4/br7LWafsMsg+7K8HRrTHgzI4kvwhkZNhJUD0N1/vqUYNTRwg28L1fPF8FhEbe1BqnVce7GAvk95+5QJOxvo44X6UmrJdSD2mxZHBkHQ5pMCkDG6/bNgPKq5DVjM+iX3cbLOGrWknJHxy2c7+f25foUsHQfxudaeblk=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU0P192MB2073.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 05:56:03 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:56:03 +0000
Date: Thu, 7 Aug 2025 07:56:00 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJQ/8Nta6020On2O@FUE-ALEWI-WINX>
References: <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806145856.kyxognjnm4fnh4m6@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3PEPF00002E30.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU0P192MB2073:EE_
X-MS-Office365-Filtering-Correlation-Id: b78f9385-405e-4d39-9088-08ddd57717f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhLbUQ3OTBOZ09HeVYzRmUrN0xhWk12NGZVdjlOdE9CbUJIZUlwYmFqaHFS?=
 =?utf-8?B?b0JEdGNrczh5SjgvakluSGs3eERZTW12bGRYOXZmelhSaWw5VCtTaDlycVZm?=
 =?utf-8?B?SkZrUVVkNERuYzhxbEtOSjlmeFVFeFNiUnFaM1Urc3ZrR0pNZUZqbmV2SlBD?=
 =?utf-8?B?dkF4VXJlc3VhaHlXUmt2UE9QUDc0dWxkLy9PNkJwdVlpWHhkaG1YeWUxMHBW?=
 =?utf-8?B?dzM2YlpWL054MXlaSlluQWNFUDUyVC9FQlpmc2FQQ0FhRFdwbFRQVnhvMUVV?=
 =?utf-8?B?aWpMbktzUitZNFMrNmhHU0ZzcGlvSFR1YmgvRUJVSVBXNkVsczhSdDJ5MHYx?=
 =?utf-8?B?cnFlSW9Sckl5RHI0b0ZvNFFadFNsQnpxMjBXNVdKc0RUOTkrVk8wbU1JL0Zm?=
 =?utf-8?B?a2Rpd3NkRkdCdGMyV3k3NzloUXhxOXlPcjdxMnN6OVBPcDIrSFprN0FvNWlv?=
 =?utf-8?B?dFl2RU91eCtjZnZyZHNBNTVvM2Nhdzk4S2hRQ3phL0dJNkYvTXJMUEZ1QjZX?=
 =?utf-8?B?R3lLNk5FenAxNDZqeHU2a1V6Wmh2OXNQcFAvSDV4amJ6eFNnbVJZVGNLMHpw?=
 =?utf-8?B?UnFXQUZ4c2V0N1BBeXR0OVljaEhHeEtDeHh5WWlQaGpFMUt2cVUyNWh5a3Rk?=
 =?utf-8?B?MlVOT1Q2ZklhQXJCemFWdTFBU3JrSHloeStqQTZIVngrR29razJNcE1MdCtn?=
 =?utf-8?B?QXZuSEdKTllpMGk5ZlJVbnNVcGlUVnhzaFNpcVhhWitaaGRYeG8vcUg0VUI2?=
 =?utf-8?B?T0tjNForVTdadFhpOGZaWnh2cWdaYzdhSSt2bzZSUmN1dGordDB4NlJpREFJ?=
 =?utf-8?B?VWhxOTQ4NWRXNmhHM1piTjNkOHhSSUsrSm92aDM2c3hBeWJ5L3pBMmswTDVw?=
 =?utf-8?B?RG5XSUxxZzhSd1B0dGJNWGxjTHhOSjlWYWc0cys5RXFXeVZmSytOSW55R1pM?=
 =?utf-8?B?KzdoZjFBTjFVYmJFTkhQYXd6bGNMOGM5YkN2RDdhSnZYRW5Hc09KbE1SdHhJ?=
 =?utf-8?B?UWV0TVVxMHNuc0RFQlh1anEyU04yR1FpY1prcG10eExnYllUS001VXk1QnpY?=
 =?utf-8?B?RElOdmcyZ0tZVDNmdDV6Q3BCZHZnZGYydzRPekNVU3ZoemR4VDFIa0ttV3Bj?=
 =?utf-8?B?ek9jNjRoQlIrWnFueXd4L0w0dVdZOStQbW9CRzhndS9XdzRZanp4WGMxWUs1?=
 =?utf-8?B?NFdWUitPb3JwWklUSG9QY2Rhc1pGQkcrNEhISGlpYW5YRk9NK2NhUVY0UG9k?=
 =?utf-8?B?VW0vSVVqWHYyRVpPRXk4UkptQ3ZlKytSekVxR3R3emdmbFpqRVQ3anZxOUFh?=
 =?utf-8?B?WnQ1Z0p5Q1hnQWJrdzdMY2lHV3lIemxLMUtaSzJZUnZuR1o4SnNUSnB6UVg4?=
 =?utf-8?B?UkZDQzlnN0JmTzFXa2dtQlZ3T0VlZk8zcE9vU1lXRDROdGgvUVIzbEZvcFV2?=
 =?utf-8?B?azF1RVNZZDl6UjJPMVZocUtXdXVQcC8zSTRKOXE5MVNPTFppdFdUbUpHOWFm?=
 =?utf-8?B?eFNLTVVkOTVEajdnN1dObnFzRkVCb0lpbEZWTFpVbU5sOTNPVTlnVFp6WFFE?=
 =?utf-8?B?bUdNbmpia2pKeDlaV2VNbjBXVXI2UUNQY3g4YkxHU0dwVEZwNTVOS3RBeExS?=
 =?utf-8?B?T0w0VUZsNFVDbmZVcmpsMTJoMWd0ZTVoOGVveUU1THlyRDhzd2k1U05TU2do?=
 =?utf-8?B?ejRuNDI1SlJaSGFEclZqalVlQzMxWld6QzZhQ2FMb1YxK2hEd3BhcDN5bFZL?=
 =?utf-8?B?dnFYMWdQS1lVOHFWSkpQbDIzT2JnY2d2dTkxZzBvT2liTDYzRzFUK201dDJs?=
 =?utf-8?B?ZXdVRk9Hd1k0akloZTlpdEo0bXJNd1BaQjhhVy9NeENuQkRZbGVsNGh3QVk3?=
 =?utf-8?B?Ty9CNmlkM1BSbE85bEllWmpmU01zYWxodWFjbStFQXh5WFU5d09FZjZBcVIr?=
 =?utf-8?Q?3i/yBl2RRno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlBRTVdNS0FSU3Z5djZzbjc3bkFsVTFPbTFpdlpaMXpqUFRkeU9EdWtnRXpT?=
 =?utf-8?B?K3dVbENHMWV3Q21abjdmUFl4cmg4c1l5anZqZWxjTWxGZVg4MzVNNkpnRVFM?=
 =?utf-8?B?V2d6WkYrd2hqSnI5cEs3S04yWFF6ZUtGaVBDYWxPWjMvYVNLRi9OazFTTGpZ?=
 =?utf-8?B?U2duV0FZa2F2dGpOZUxXV1ppck1XWk0xbUhVdmMzL3Q1MW5JeW0vVUFKQ05j?=
 =?utf-8?B?Rjgzbm0zTTJqNHZjZVJPamdFdnZQWjNpMlc0V2I3YnBnYzlCK3lTNXlTUW1R?=
 =?utf-8?B?WEdGUjFKK2xQNWVPOEg3QVdjVDlQVXN4dFBTeHMzYk5yNXJJeHl0NTBIZzF6?=
 =?utf-8?B?MlNRVTY5ZVNtZjYyZ2VCbStobEdPcVk2b1p6ZG5WVndnaGs2OTFINUdLdUtE?=
 =?utf-8?B?bWhyQnZmcDNicXdXNHJ6K0ZyTUxOYnVhOEdkTzg4T1lreE1LcGxVRHNoNUNy?=
 =?utf-8?B?aWNWTTZjejgvOWhSUml1QmRGSGFWNStSRnUrNUl0dlFCU3REdU5Fandjcm96?=
 =?utf-8?B?dE9JcWMvcWpUQktsazkvZGRhRHE1ZmUvQnViR0llOTlGL05wOHdQTXd2TmFO?=
 =?utf-8?B?aWI0dkw0REg1RE5XMHhqbU81MUJwNVJVbkNYTitXS3kzZXJJMzVqb1c2Z2Q2?=
 =?utf-8?B?bVMyQVpKY1NscjUvNytIc2ZJQWFjVHl6OFhuTnZkRWNhRTRQN0hXeTNDd2Na?=
 =?utf-8?B?Y0ZjbnRKKzAyWHZrbURTUVhoNStTRDlCRmc4eFlvNjhJRGpJRFE4M1RORndz?=
 =?utf-8?B?QTFLVjlaaXpleHhBb3F4V1AvRFp0SU9TNGpmL0t0b2dkd0pieW42Z2lkUVJ0?=
 =?utf-8?B?bkdpZVFFRUtxY09DM0gycDdQRVpLUkZNNjBPeGlRL2pXNHUzbEtpdG1wSS9k?=
 =?utf-8?B?Tnhsem5kS3JBNW9zR2tLUkVYanEwSTVoL2tRVzJoQUprVkNVMEs2VlBtaU1Y?=
 =?utf-8?B?WVdaSkhQWjh1U0luM1FHR3pwUjhQc0xob2FnNUxoaTdNM1NvQ0JoZkNaTmRi?=
 =?utf-8?B?UkJwNTNiaEZkSW9UNVhFbU1PRXlvNTFrc2tsL1NFR3JQV25WM1pma3VzR0Ns?=
 =?utf-8?B?clI5eW9Lcy94OGk5S0JoRi9WcFdBa2lWL25oTVFPa0t3ZEwwcWh1dlB4YUU2?=
 =?utf-8?B?bkFaSFFMMUFYMHpWOXkrZUpnNno3MTRyKzQrY2Nlamh3SXlKMGJmV3dZQTA0?=
 =?utf-8?B?Qk9OK25JMjZiditzZTRrM21kY2Qwa1I2TCtsK3dJWDhzci9sRzRpR3lOWWhR?=
 =?utf-8?B?bjBuMnlqdlg1WkhSckZMbmxnYW5ERHc2R2RzK3g3Qzhnd25NMDRiaDNhdUxX?=
 =?utf-8?B?SDZHbVRNdUlTMm9BcDJHUHBwK24rTm9LQzhlVTUvUllTeEdpbmpkL1BHa0VY?=
 =?utf-8?B?S2t0QWNZaG8weHJPK2FXYnpBTURoazVJRGFSZGVtQ2F6aU9lY3BhM2lqQkZh?=
 =?utf-8?B?dzMxVFo0WEdDQzVXdXVQaGhFWVY5TzFvWk5TbHNXNDY2N1JMdm5hSmNwN1Jh?=
 =?utf-8?B?VFlyd0UrcUhnS25mWFdMc0VaT0xpK01PL0VVK1VjT0dwNmIwMkhobFdsUjYy?=
 =?utf-8?B?S0t3d0tnaGRWVGlRT25NS1dMNFBTQjkxWkhieVVUaUtJNStycCtpK2JDVFlO?=
 =?utf-8?B?NElTK1lXWTk2eEZBSW40Z0syZHZTSjhJcjZkSWpDSW1xWFFIRkxJNTBETDUx?=
 =?utf-8?B?MExTWjkzclpXQ09VRVhmQ05sMUNmN1U5ZkZOdnhNdzVtcFEyaDFQZjdqZkJ6?=
 =?utf-8?B?U1F4MUJhdDdWYU52aEZrRkhWT3VRWXNFaVRKN2c5YlIwVjJ6aTJlZzREYS9l?=
 =?utf-8?B?aGN2UkoxSytTZU93YWNPNmFBcmFqK2FKVnNyY3cxeHlycGNOSmZSb2d2akh0?=
 =?utf-8?B?QkFJRzNuanBLOE5IZHVtR3F4aGF6cUhLOUQxaVFpbW4yUW1na3hoU0F0Zms5?=
 =?utf-8?B?Wk5NMElLUjkzZFFOL21iaHlUV1QraGE0Tnd0OGZsSFpucitaK1JXenpIbGFS?=
 =?utf-8?B?MDJlOTBkNlVhczNRaGxodmY3MzNKOEdPNGV4K3FoSUFjbVJhMlJMQk5nd3dx?=
 =?utf-8?B?UXpTVU9FYVJwYmN3NmtSSUlWSVZBQzJPY2NUMjBFYWVWeXhrSkFseVdiM2R0?=
 =?utf-8?Q?bFRHq7yDMPGOXY7WkBKnlJSjv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YPxbXzshlhDBCIZ/osQBS9OG2LFxu6a9tM7xprY4Oy7KDCy4U4kwSfG5HZPpRq8ITC3lWPewXivvyccQ4ALxRnxi/FzCJ4ry3TilsvhJW7Xt1RSnH2C3lxJisMT7FqB2ZBpfI4ytZ5hNOdCJBy6BHHzRRWwiCLX8JM2ZXfY9htvHQoL16siH6AloLjU3L7MPaQ9ikl1K+/E4v0mzTaBVscuxuuyPA+2EgAZAZqJbSRtmfMTPObD2kAnlUqTFMCeOcGNzA/YaKPS5Hqn18vMuEpUjPRtBtvTy1ddw8RBLFVcSxQXo360iiWr8Ey3oyeEKTt1X+HrQRVqS7v0ho1l+JOLMqhp2XGBqxlwQtZqJJXcyaA85bXhsLSY9A9n/GzDdYPjm7HjpShvC8T8tJMgU4LpfyQ1iN2ICrCCZBmIGGNMGAC5AyX0LHzQGDfKPtXY59aE17ko0uQf+3E6ALrLAqFSRNRwPuEC4gmUrVTBf4ohoSxImGs6Ala45DS3Qeg589AV/MmriLN1qWzFi+Nk0KJFw2zgEwH1cje7ybR5Mk+VUVEJme/Xs9jn7Iue6FqPik+eRaK2Uojus9r0R0xL5Y5X/uA4WXWdnkpanJYRsqGCdfjHDmr9bYarthQOaMUqw
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f9385-405e-4d39-9088-08ddd57717f8
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 05:56:03.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+mhNdxSPHvlyLUCEK1eY+RP2fnLMtC6YnWjJs22EQKQH63AZVDb5YvCWG+ZxiTaesXLXieJoBdpde3NAjxuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB2073
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DU0P192MB2073.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=JeO8rVKV c=1 sm=1 tr=0 ts=68943ff6 cx=c_pps
 a=4fMlm5sWFUR6aQuiTuskwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=FmlchqDzpnl39RjJ2bYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: D3EkUuxSzBaSiY2CWEAm9mkg1xMbZr8Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0MyBTYWx0ZWRfXxGiEiA49WN0/
 UgiJyjSYSUfoKPxVY+kWTdpH0D2mhpCREdHJysaQIOhbCK3XXa/jf/nDApQIMjONcj0ni6goNAO
 VIEfrvqQZ7jMqYuQKVe6F9z54ArT/jvSS9okiqLCM4/lYz8I6h8h89uRky1C8VWFRecd/tFzxlh
 6InbXEGp++ut0Aotdmbk6Gjoqm3CqxscfrfImTHHsu2NT219qQ8tfCaRcaxTrrDcOWO/ieGMkWA
 liYAwvdwh4u7oYvurTzRVhYWNGPYttlf9XKr9Gg+ChFis1NgPGAJt2RsjHDd5xbKSTlutcKEU09
 YVjGMhyYxWxO2+6bAt7ZZzKeoR8poK1LBolh6AQFAtfX5/moOoAGmA+891OaYo=
X-Proofpoint-GUID: D3EkUuxSzBaSiY2CWEAm9mkg1xMbZr8Z

Am Wed, Aug 06, 2025 at 05:58:56PM +0300 schrieb Vladimir Oltean:
> On Tue, Aug 05, 2025 at 02:44:15PM +0200, Alexander Wilhelm wrote:
> > Patch is applied. Here are the registers log:
> > 
> >     user@host:~# logread | grep AQR115
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10 SerDes mode 4 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 100 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 1000 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 2500 SerDes mode 4 autoneg 1 training 1 reset on transition 0 silence 1 rate adapt 0 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 5000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
> >     Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 0 macsec 0
> >     fsl_dpaa_mac ffe4e4000.ethernet eth0: PHY [0x0000000ffe4fd000:07] driver [Aquantia AQR115] (irq=POLL)
> > 
> > While 100M transfer, I see the MAC TX frame increasing and SGMII TX good frames
> > increasing. But the receiving frames are counted as SGMII RX bad frames and MAC
> > RX frames counter does not increase. The TX/RX pause frames always stay at 0,
> > independently whether ping is working with 1G/2.5G or not with 100M. Do you have
> > any idea here?
> > 
> >     user@host:~# ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0' && ethtool --phy-statistics eth0 | grep -v ': 0' && ethtool -I --show-pause eth0
> >     Standard stats for eth0:
> >     eth-mac-FramesTransmittedOK: 529
> >     eth-mac-FramesReceivedOK: 67
> >     eth-mac-OctetsTransmittedOK: 79287
> >     eth-mac-OctetsReceivedOK: 9787
> >     eth-mac-MulticastFramesXmittedOK: 43
> >     eth-mac-BroadcastFramesXmittedOK: 451
> >     eth-mac-MulticastFramesReceivedOK: 32
> >     eth-mac-BroadcastFramesReceivedOK: 1
> >     rx-rmon-etherStatsPkts64to64Octets: 3
> >     rx-rmon-etherStatsPkts65to127Octets: 42
> >     rx-rmon-etherStatsPkts128to255Octets: 18
> >     rx-rmon-etherStatsPkts256to511Octets: 4
> >     tx-rmon-etherStatsPkts64to64Octets: 5
> >     tx-rmon-etherStatsPkts65to127Octets: 385
> >     tx-rmon-etherStatsPkts128to255Octets: 26
> >     tx-rmon-etherStatsPkts256to511Octets: 113
> >     PHY statistics:
> >          sgmii_rx_good_frames: 21149
> >          sgmii_rx_bad_frames: 176
> >          sgmii_rx_false_carrier_events: 1
> >          sgmii_tx_good_frames: 21041
> >          sgmii_tx_line_collisions: 1
> >     Pause parameters for eth0:
> >     Autonegotiate:	on
> >     RX:		off
> >     TX:		off
> >     RX negotiated: on
> >     TX negotiated: on
> >     Statistics:
> >       tx_pause_frames: 0
> >       rx_pause_frames: 0
> 
> Sorry, I am not fluent enough with the Aquantia PHYs to be further
> helpful here.
> 
> I have made a procedural mistake by suggesting you to print select
> fields of the Global System Configuration registers instead of the raw
> register values. I am unable to say with the required certainty whether
> the configuration for 100M and 1G is identical or not. The printed
> fields are the same, however there could still be differences in the
> unprinted bits (looking at bit 12 'Low Delay Jitter'). That's something
> you should explore further.
> 
> About MAC RX counters not increasing at all. The mEMAC has a catch-all
> RERR counter which increments for each frame received with a wider
> variety of errors (except for undersized/fragment frames):
> - FIFO overflow error
> - CRC error
> - Payload length error
> - Jabber and oversized error
> - Alignment error (if supported)
> - Reception of PHY/PCS error indication
> The structured ethtool statistics API doesn't seem to have a counter for
> received frame errors in general, only for specific errors. So I didn't
> export it in the patch I sent. It's possible that this counter is
> incrementing (but the more specific RFCS/RALN/... counters apparently not).
> 
> In any case, the T1023 host configuration is literally unchanged from
> 1G to 100M, so I am suspecting a misconfiguration in the Aquantia
> provisioning somewhere. Maybe an FAE or AE from Marvell can help you
> further with this issue.
> 
> If you do contact them, please also request them to fix the discrepancy
> where the Global System Configuration register for speed 2500 has
> "autoneg 1", but all the other speeds have "autoneg 0" for the same
> SerDes mode 4. It is precisely this concern that I was expressing to
> Russell that makes it difficult to implement .inband_caps() based on
> reading PHY registers.

Hi Vladimir,

Now that I have 1G/2.5G working, I’ll be able to run some additional tests with
the device. I’ll revisit the 100M topic later and analyze it more thoroughly. I
suspect that some register settings in U-Boot might be causing issues when the
PHY is initialized again in the kernel.

I truly appreciate your detailed support, it has been incredibly helpful in
moving things forward.


Best regards
Alexander Wilhelm

