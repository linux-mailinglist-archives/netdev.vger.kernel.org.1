Return-Path: <netdev+bounces-303864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 46e5AlaORWohCAsAu9opvQ
	(envelope-from <netdev+bounces-303864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:01:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921FA6F1FF7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:01:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=P8DhMRX6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303864-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303864-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE0D3082E77
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE86D3BADA9;
	Wed,  1 Jul 2026 22:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDA33123F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:01:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943262; cv=none; b=jFr9SkWTvAW8tn5vmZ971yqMXMPHkrL2Fr4NWy+3WLK6PS9yleMzy/flysjcdFjiXKdGUrT/Ixi1DzXBEKnqVcNSYgGonRe3waBeDg9FfyqK5bGkt/2fUOsbbwzU9rqS1GRq0a8YP8adVdsGRz3vOCk/UeimFEgWMJ37agksrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943262; c=relaxed/simple;
	bh=//JpBM9HZDj5IC6kglciNevF/UaPtugb1j5FCAbr72E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Mdq5YgN7g15bQM3KKv/a6CT38qVLujO/CqRvDEep2+WsBkghoupfueo8kWl2dYHyatIMpLzt4g/BwhwjJBLxXvwW/os1IXAs7j0lK6LXdOILTHYe3CnzPw9W7aWakojFoh3n1MicUSl8i2b/UHGkRf4UEL0kx2iVP36COH5ZTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=P8DhMRX6; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782943260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//JpBM9HZDj5IC6kglciNevF/UaPtugb1j5FCAbr72E=;
	b=P8DhMRX60ilYgCFn2G5yHSCBMm+Fv7YjCNEhW9bLXc2Pb3SkzPDw4xPSsgAMLq4lS1GWWt
	I3UjNsrV1dD/pQhz6owCFKv0X8wll0TDsGYA7wargRDXsRkt075nqfStj14UAHij6HXfGY
	zidcjeLviHaN82IDCA1BTZyMe950WctBnny3nZPo5X8Hb9cvnt7htsL7i9lWyX3yUGLFn7
	sEAdn1c4kOQ/6LJEKlKuTlpC/koTCSeokYdmCN4OxGz2IbJ4k+YGAqVYxyPaWVFn66bzEr
	Pi0BEVVS8g969UpZtOh3cnyMnn7EZsCqBck+LwS0XwBB3oDPNcitGCRuIhaDUQ==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-43-GV-QJgWmO8yUrkPPwHj2HA-1; Wed, 01 Jul 2026 14:59:31 -0700
X-MC-Unique: GV-QJgWmO8yUrkPPwHj2HA-1
X-Mimecast-MFC-AGG-ID: GV-QJgWmO8yUrkPPwHj2HA_1782943168
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by SJ0PR02MB8752.namprd02.prod.outlook.com (2603:10b6:a03:3d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 21:59:26 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Wed, 1 Jul 2026
 21:59:26 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Jerry.Ray@microchip.com" <Jerry.Ray@microchip.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH net-next v6 06/15] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v6 06/15] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AQHdCJts8bGaeSznUU+YPDhBJlQQu7ZZD9SAgAAmv8A=
Date: Wed, 1 Jul 2026 21:59:26 +0000
Message-ID: <CYYPR02MB9828C252211C4C077C5BDDB283F62@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
 <20260629-s2500-mac-phy-support-v6-6-18ce79500371@onsemi.com>
 <CH3PR11MB77231F85DFC870B5B43AFDE1EFF62@CH3PR11MB7723.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB77231F85DFC870B5B43AFDE1EFF62@CH3PR11MB7723.namprd11.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|SJ0PR02MB8752:EE_
x-ms-office365-filtering-correlation-id: 6a02d0d6-5bd8-4a48-069e-08ded7bc04b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|921020|38070700021|11063799006|56012099006|4143699003|5023799004
x-microsoft-antispam-message-info: seRUNy//sbcjgVUDdjfHDyv6FwrGbl4vJDGaiWI85gGckC31B4tQxVcJlQUS00ba/LS4mzPGKb/+PFPE9V9yQP3S3Wh/g5pj6QByO2Qb+5ALmfX6RpukEUB9yEVExHF0sbgG8QSkqpESLZ+hJTv0aeSqwGctFzfb+2gH5Zef9Dnk57jHdXe0Vz8sN4qzlR+FagFufbCTthVd65QLdaMorPWA9MWTkeEgSCAApjoLu+ttx4eYb8vjHAKYzPmmeHWkQnnX1ujwtIE7jgOqiCaKuW96JzaQb1ywrC/HkjOezUMzwK2DUt2IcU7FdA273G+fUH4bivquw+6tCS5FYFdnoB0b0v/sSsu+Qw2CSV6vSN/aiTBeQTEXmD+zyRKdDQMF1G07O0slM4jpl5DPgc+bKMvqDKHdboARsjVyJJUf7KfWgmNGmjnQIq+p/NWKLpG+bssPnU6Sb2XfEqYAxOxTazYtXYegFltvCl2kUkNi19MPeQORwOKWm7Pef5ZmGz5+CBW7Xq02mjxjiimAUMoZwai8cR9qvPKXR++6iizFNLywd6EjOAN/Euk1Yp8NGlmHoAjtBUzkVKk/dLBE0SWGkZVze1mVQYTgQN84XOYkEED7a8XdeHs4GOsJuRjoj965I/Tx4BhjvWKLuOvOB3YSqwNXLHTZj0dETjIFk75JdcmpG1ZR40226dML0JCFbBVQdSHLSRrrwL+k5IDs0zwaCve5k7DE6cNFrUolIYhlSVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(921020)(38070700021)(11063799006)(56012099006)(4143699003)(5023799004);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNhRDVXQUs3dUk0bEQ4MkhSNjQ4cURFVW9zQ29kZlJIbWtvQWxBWjlrZ2xn?=
 =?utf-8?B?eUhCMUNYTWNNbHYzK0lOZUx5OGpJWXlsZUJQUHhWWWRGSGR0ZU8xam9DeVc3?=
 =?utf-8?B?YXJXUkphRWRwNEZ6K1I5YzJMSEtDQUFoUGxSTS9JSDBFU3NDRTRjcFBRS2p2?=
 =?utf-8?B?YktidGhGc3FYV2M5TmowSWtaQ1kxSExsTE41YjV0eGZvT29pWVlWcGUrb3E3?=
 =?utf-8?B?ZW8yQnpqb05MeG0rcDVhVWZ6WlR4RlduTHBkQzdJZjJ1dDYzWmR6NG44SjhI?=
 =?utf-8?B?TXc4bldDZGlGWkhBaXVkY1Q0RTAraWFqdFhqWGFnMERaYTNNcnlCWlNwZkhS?=
 =?utf-8?B?dWFOYnJoREUvWE5JdEJpZVhERnJpZ1JFWjJNMVNpRnpXdFhsMDdsb2l0VDRm?=
 =?utf-8?B?Tm1iN0ZTdW13YzZnWFA2eVNSWTV6K1JlcUlDLzArQ05UUzQxMW84dGFGQ0NB?=
 =?utf-8?B?RFBSaUh5eWVpVmdVRG5lc2dSeW1rc0VVUHA2ODVOK29TV0d6SE1ZVEliMlJn?=
 =?utf-8?B?eW9uVWplajFVbnJ2dWRmZjlaV0YrNm9WNE5EcVhrN0dnZFZFMzhmVjA1aUdl?=
 =?utf-8?B?ZTJ3WTJ4V2UxdVVWUzk2WlJEUDhSQmJPem9ab2pVZUZ1cG03OUR2Z3lDazkx?=
 =?utf-8?B?d3RhWmQ4SEVHakZUVWpMVytWenNEaXIzSXlFYXJ0dythQVk3MGFXODgveUht?=
 =?utf-8?B?clp3bHVkeUlpeG1hU0phM0ltNFJoUG5vSEMvM05CQmZFN3hmdm5PMk13WFMz?=
 =?utf-8?B?U3YydTFJLzYraU4vMFUrZU1Fcm9lTnM1a0FIcVRjbE5nZWd3ZGxkOUxwOVBE?=
 =?utf-8?B?WFRoVGM3NmloUG9ROG1QdXR4UEdWTU83djQ5K0FkNUhxTVNoT0wxM3o3VnI3?=
 =?utf-8?B?WHZSUGxqMWJLeGRFNGhBUEY2MVpIZ3g1ZlNtRlFCQXY1RExxemlPUXRrRWRK?=
 =?utf-8?B?TEgybFBhVTRHOVdnTzU1K1phdWVITmhoQk9MZjJ4a3VMcVcwUUpxNkQrRmZL?=
 =?utf-8?B?RFp5aVNpQ3QyQ0QzcWxuT2t1SHdzaFdFUnlVS0h0U1dCQ3pqbS80dTZIYy8w?=
 =?utf-8?B?cG1Bc2NOZ3UvWFZaNTZrUy9ydDRXVU1icVZBbURkbkl5bEsxYmJQb2VsL2ZU?=
 =?utf-8?B?UUsrL1FhWEpYVEtxREtMU24xTEZqblhQd2h3NWNaT1BBazdSNFl4ZE5vQVBY?=
 =?utf-8?B?VFYwejlVc1BiYlFIekxBRWY5Z1ZsUHlhc0dCOVM1TFpOelBBK1UxYVBSa0lh?=
 =?utf-8?B?UUR4QVRROCs5Q0o4N3hhbFZsbjR1WE81dFVqNkNpaXNDVW4wa3VWS0RXOTZC?=
 =?utf-8?B?S0pKMG14TWYwdzRRR1I3bE0weXdubDBNakJMTnZEd0svdkhHL1FBZUtteGgz?=
 =?utf-8?B?RjVMdHJiRE9EWFkzNGFxWWdkKzF0Vzg0dndIc0QxU3NHbGdGQjQ2blNNUU1T?=
 =?utf-8?B?cjJvSk1VeDZaWHRsVlh0cHF0VURHUGluc2ZCYkxsMlZqbGlNbDFXQVY2elBT?=
 =?utf-8?B?ZHdVYVhBV2FnN3hZQ0o0UmFRL2t3a1JLQ24wN2NIZkZmOGVCbWU3Ymt0S0ti?=
 =?utf-8?B?blJUSzFOMG1heHFmQWdlaitmYlB3eWY5ZEJDcGpjV2hheTQxb0RPOElWdDdL?=
 =?utf-8?B?VHVjUWx0TzJlWVlHUFlpS2w5SklYVHpxN0FqMHlRcDVScDF3L3VyM0ZqbE8z?=
 =?utf-8?B?WnM0R2E3Wnc2Sm43NjRJL0I4SlNOZkN2cjhDREphZEFGTklRc3BIbjdQZ1Vu?=
 =?utf-8?B?N01nTTMvSFlMRjJKSXZaK2w5NkpFVTluZlg2U2s5UmVoWnZDWlpwY1Q1bUFu?=
 =?utf-8?B?alBpM0krbit3ZFdkQ3VqT0RLUXRic0hPdlNOdWNBTHhPdHZEeXJESTA1OVFK?=
 =?utf-8?B?aTh2RVhvQW93MGNPUnVVQW15Um5pNkt0Y3pST1ZzSVRFSUttaEFmZGNkd0tR?=
 =?utf-8?B?NStvOXR2aS9mMHpjb1FiMUMrODdSQlpqRHUwWWZnaEsvRWlzZ1FxblRoZXl1?=
 =?utf-8?B?Z0NhN0J5RE9kMmRBelZrOEY2RFhta0s1WkliRWc3RW5hWHA4dEVFSC9GamRE?=
 =?utf-8?B?cVBKcklmMkhXSkhYWlZQbFNZU0JlVFRJMGJLNHNYYURzcVJNNzFOUC9BeUJQ?=
 =?utf-8?B?OThITk15Qzh3WHBlNEJCSHZTa0Q2QXZBQUNPbDNXeHNGZnVOblFXOWMwK3R1?=
 =?utf-8?B?ODJ5YzVFM3JjY21La0M1d0lYNzFDWkdodDh5WTBMY2NZS2lOWFlZNzMyZDZS?=
 =?utf-8?B?bmsza21SSkxHaFR0NHpEdjd3R1JLUGgzOWRKaC8wcnVLWXVGM2dqT0FuMEI1?=
 =?utf-8?B?c2p4UjlJdW5xUjEwdGdHcER5L3p0aG9rTENDTmR3YTZJamtBZmlydz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CEFcE9T90/6kJvHgDF1VL3awrYwYLKQBoyPDZ36ZvEhNaXMto5ceWYjdZ7IA8nsx6+njx8NhaszBPxKGChV5obuwGhyEnViNXLzEGit1QniHsUwnpZGVVidQKtfzdULKWGhhWi6qE8VA8ZoBEsLGb+/jp4h46N73sGhjkzZINnDFFxY+K0kNa8db1a1JbicmUL41oZORCH6rhm6aiB4rHK8mGjS2tRjO9P5loY98WcKqiUbjUTGlf3QuwVgF9hBdaDyEEcJrdjEo9DRtFb/ILFcs2A6ql3pbpKkt586CsL7vCCBr4nQJRtD96isg3AeXmRx2KiyYTkHX+SskoULprA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a02d0d6-5bd8-4a48-069e-08ded7bc04b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 21:59:26.5700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzgzArHSS3DlaerVmrYVXBvEHwr/EABTyp0gmJta++dSuM3v/Y3SeyIT0lS2rrRgKrJcbW+jMOVA0CHa9grErI2YU7a9wLe8EOsFVyFev9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8752
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1f1G4mNIpUY82WG04av6AldUddRLTB_NBQqPrXdsuyE_1782943168
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303864-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Jerry.Ray@microchip.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:Parthiban.Veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 921FA6F1FF7

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplcnJ5LlJheUBtaWNyb2No
aXAuY29tIDxKZXJyeS5SYXlAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCBu
ZXQtbmV4dCB2NiAwNi8xNV0gbmV0OiBldGhlcm5ldDogb2FfdGM2OiBTdXBwb3J0IGZvciBoYXJk
d2FyZQ0KPiB0aW1lc3RhbXANCj4gDQo+IFRoZSByZWNlaXZlIHBhdGggaGVyZSB1bmNvbmRpdGlv
bmFsbHkgY29uc3VtZXMgYSA2NC1iaXQgKE9BX1RDNl9UU1RBTVBfU1ogPSA4DQo+IGJ5dGUpIGZy
YW1lIHRpbWVzdGFtcDogaXQgaXMgZ2F0ZWQgb25seSBvbiB0aGUgZm9vdGVyIFJUU0EgYml0LCBh
bHdheXMgY29waWVzDQo+IHR3byAzMi1iaXQgd29yZHMsIGFuZCBwdWxscyBzaXplb2YodHMpIGZy
b20gdGhlIHNrYi4gVGhlIFJYIGJ1ZmZlciBpcyBsaWtld2lzZQ0KPiBzaXplZCB3aXRoIGEgZml4
ZWQgKyBPQV9UQzZfVFNUQU1QX1NaLiBOb3RoaW5nIGNvbnN1bHRzIHRoZSBjb25maWd1cmVkIHRp
bWVzdGFtcA0KPiB3aWR0aC4NCj4gDQo+IEJ1dCBvYV90YzZfc2V0X2h3dHN0YW1wX3NldHRpbmdz
KCkgb25seSBzZXRzIENPTkZJRzAuRlRTRToNCj4gDQoNCg0KSSBkbyByZW1lbWJlciBvdXIgY29u
dmVyc2F0aW9uIG9uIHRoaXMgc3ViamVjdC4NCg0KRm9yIHRoaXMgY29tbWVudCBhbmQgdGhlIGNv
bW1lbnQgYXQgdGhlIGJvdHRvbSwgSSBiZWxpZXZlIHRoZSBmZWVkYmFjayBpcyB0byBzZXQgDQpD
T05GSUcwX0ZUU1NfNjRCSVQgYml0IEluIE9BIFRDNiBmcmFtZXdvcmsuIFdpbGwgZG8uDQoNCg0K
PiA+ICt9DQo+ID4gKy8qIFR4IHRpbWVzdGFtcCBjYXB0dXJlIHJlZ2lzdGVyIEEgKGhpZ2gpICov
DQo+ID4gKyNkZWZpbmUgT0FfVEM2X1JFR19UVFNDQV9ISUdIICgweDEwMTApDQo+ID4gKw0KPiAN
Cj4gUGxlYXNlIGZpeCB0aGUgdmFsdWUgb2YgT0FfVEM2X1JFR19UVFNDQV9ISUdIIHRvIDB4MDAx
MCBpbiBwYXRjaCA2IHdoZXJlIGl0IGlzDQo+IGludHJvZHVjZWQgcmF0aGVyIHRoYW4gY29ycmVj
dGluZyBpdCBpbiBwYXRjaCAxMi4NCg0KDQpJIGRpZG4ndCByZWFsaXplIHRoYXQuIExldCBtZSBj
aGVjayBhbmQgZml4IGl0LiBUaGFua3MNCg0KDQo+IA0KPiA+IC8qIENvbnRyb2wgY29tbWFuZCBo
ZWFkZXIgKi8NCj4gPg0KPiA+ICsgY2ZnMCAmPSB+Q09ORklHMF9GVFNFX0VOQUJMRTsNCj4gDQo+
IEl0IG5ldmVyIHNldHMgdGhlIDY0LWJpdCBmcmFtZS10aW1lc3RhbXAtc2VsZWN0IGJpdCAoQ09O
RklHMCBiaXQgNikuIFNvIHRoZQ0KPiBmcmFtZXdvcmsgZW5hYmxlcyB0aW1lc3RhbXBpbmcgZm9y
IDMyLWJpdCBiaXR3aWR0aCB3aGlsZSB0aGUNCj4gcmVjZWl2ZSBwYXRoIHN0cmlwcyA4IGJ5dGVz
Lg0KPiANCj4gVGhpcyBoYXBwZW5zIHRvIHdvcmsgZm9yIHRoZSBTMjUwMCBvbmx5IGJlY2F1c2Ug
dGhlIFMyNTAwIGRyaXZlciBmb3JjZXMgNjQtYml0DQo+IGluZGVwZW5kZW50bHkgaW4gaXRzIG93
biBTUEkgY29uZmlnIChwYXRjaCAxMi8xNSk6DQo+IA0KPiBQbGVhc2UgcmV2aWV3IG15IGZlZWRi
YWNrIGFnYWluc3QgeW91ciB2MyBwYXRjaCBzZXJpZXMgb24gNS1KdW4uDQo+IChDT05GSUcwX0ZU
U0VfRU5BQkxFIHwgQ09ORklHMF9GVFNTXzY0QklUKQ0KPiANCg0K


