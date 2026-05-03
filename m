Return-Path: <netdev+bounces-283645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wbGAC1aH92nQigIAu9opvQ
	(envelope-from <netdev+bounces-283645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 19:35:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783E4B6CAB
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D9DE3001847
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4827835B63C;
	Sun,  3 May 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="AM9LMuuE"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811AF296BBA
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829710; cv=none; b=Kn3rSPOaXHAEcWw6W15+oYof53gNFyw6oDUJTfMzF2TwiiTzTjV3E3dprBcLIS+FwiUE/d/Gz4VjnxTA1rgupsmHn4LKY/A78VJT3FqcgUKxZXtRXlYiX7rWd7NPwR1Dd3lFej+affNBSQ782Ym63sCY+Ywpy/tev93YytesbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829710; c=relaxed/simple;
	bh=ajO5AI0LO6nCZe4N+69Dg4HIZXNpXML7RHgQIRxAxeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UEW6HJrtrlNoihZm2qA1QpCVYBKYDqX3mKbdPUKoF2TW3jLBS3mps4gjEXQB7gv8cDF9omXWk7GMm8JTU8VyB60tTqza/3doxpD/4Yub/C4U7Fio0qeS60PkhTH/j2vBboNRpDYJOU0RaRcXg2Y2x/z8Y2hj7gHXrCbwn3B7tek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=AM9LMuuE; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777829702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajO5AI0LO6nCZe4N+69Dg4HIZXNpXML7RHgQIRxAxeE=;
	b=AM9LMuuEcLADYs5fh5VV5XTaVaHNX5tSonl1oKxLUOk7APNtlzux4xNNU/+WAdRlY0n8jt
	XesxWt1LPidTFeqDOLoOknV/Im6oWuK5zA3nhcbDuKVN5QtFVQtn4JfwmwjhDWrqjI2G9k
	2XIwkpog5J6/nJRSvkxWXbuMCwdzq9tbeMmV1YYthOg9HYXt5N2LPqI5g3TM1/L768TrVE
	PfWvoJBvlxZtu+Vy/wfkVFkrf8LteiZho+I51oeIgh38p+UDkjfPRDV/pwF3sdazSP8L+m
	QDhwq4QziToYAOg0y/BbnSv8c5jS6tyuy8ZZYO/RSuTz3u9sCOxy4BWWAvgdhQ==
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-57-MFwrQmrGOqWI5IUlOiOHag-1; Sun,
 03 May 2026 10:34:58 -0700
X-MC-Unique: MFwrQmrGOqWI5IUlOiOHag-1
X-Mimecast-MFC-AGG-ID: MFwrQmrGOqWI5IUlOiOHag_1777829693
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH3PR02MB9781.namprd02.prod.outlook.com (2603:10b6:610:178::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 17:34:48 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 17:34:48 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, "ciprian.regus@analog.com"
	<ciprian.regus@analog.com>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Thread-Topic: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Thread-Index: AQHc2rEgF3hIAB6D/Eq3y9ss2XCLE7X8jmMA
Date: Sun, 3 May 2026 17:34:47 +0000
Message-ID: <CY8PR02MB92498A398D3F05B94EEB7ED383302@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-2-dd043cdd88f0@analog.com>
 <aad9cb98-8f1f-409f-8d58-0318e125210c@lunn.ch>
In-Reply-To: <aad9cb98-8f1f-409f-8d58-0318e125210c@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH3PR02MB9781:EE_
x-ms-office365-filtering-correlation-id: a6af705c-2624-423e-2eed-08dea93a45f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|22082099003|18002099003|56012099003|38070700021
x-microsoft-antispam-message-info: r0KLl9d+3n7Z0kb99ChN/fFsTwzXHvJypAAKlzQSgutmUlcf9lCNiD6rjNi5LnLpxNVfUOOQVI8RCIlf1wNkiozdUWuzI3w6rtm7Y4eC2+iu1Vmejq5wCu+z+ifQquyJfHh6ogw1ViArBhXs/loyYJOZan7CMlm7HdxMf1fC1fcc7AoCAvw85IVhvynP48VrwhzPnuOUP4vzZXkfbVsh+zDXKUKbrVAVIpns2NSHMrkZaWRpTSmTkVf9GpBn/4kKgk9QBmGxPLbiDELMjUDFgn2rBiG6AHZmuA+xx464KA/wHd8p6L+obKktZmO2AbWiJOjOTHwg2PIhikpN3s4/woEGL2W1KRFtYyLRGsxAqSh4LCww2EU6Mo+3s+6SaETfdVNcJUh9t6XzP1wFKsjN/yD1jAsPA5+7PTSFV73Q1968UjRvfrjN2HxVS0wAoICgTBh3GEwH6oDMvAHzozNx5Lx1piGzb//s/ZKqNm5xzVulpQbpfDT+6737ElFFb7mFpx6sHH5SdRAGkCnUawGkJ1i5R7oxNbeuLxOORUSuGMoKbLv8l205bT1LPSSbbqImY4la7uWK2U1mjxrnCSetV9BkZd2DFz2A1dJWm4FIeQqTxWTyJSjGyAjGRP2o1i5A/6+yDzbvugYmvRIpFXyK8RsgJfFImbxNerjDJhbftAdJGvw26ElkUx0EmcflPzPEMI3wgUUa7+V1ndhLqzLnE7webw98J1pRws6KuOwlIAvKACZ/ZxUL8MN503NwVBLf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxUWWpWd1AxNGU0Qk9WTjRlaTB1UFZHWDFwY1orVVFDVk5wTWFFczIxNU5W?=
 =?utf-8?B?Qm41RTFsMUlDRUhMYVk5Z0NaN3MwZTdNME5xUnZWVnN2Zzh0Qms5Zkpta3lL?=
 =?utf-8?B?SVYrelVsM0RUMVY2eGttM0hjWStqNS9RWGVtU2p0dEc0YjFERVFjMzFxNm94?=
 =?utf-8?B?aWQ2dHhDelVxc0c2Z09JS3J6YWRpRTdFZnBRNUNkY0Jua1pwS1o1WVp2Q3h4?=
 =?utf-8?B?azFrNnJwcnIyZTBBbFBnTGZ3NHpvQ084SmNVUXU1MUFHM1dDQU1LdENTUi9l?=
 =?utf-8?B?S2ZBUjdjaVhkNFFybjBiS3QyU0dOc2dJL1gzN2ZGVHk1U1hyQmYzNXBORkxk?=
 =?utf-8?B?ZXRLVXlWdnpKdnNrTXhZYUlkSEtNNm5BQmZMNWNxZk12VmNMQWdvVnA4Y0Rw?=
 =?utf-8?B?YmNSZkdKekx1K0FNdjJUVG9leTEvOHBUSVdWeEg5SWxKdkg2b1dMSzQzeXNT?=
 =?utf-8?B?QmdPbzI4SXNJb2krdFY4Tzl0cFNxeW5oQyt4WkpLUU9XMHB6bzd6RkpMZCtt?=
 =?utf-8?B?Rjh5UVhsUmczSWZYTklIL3FuN0ZYNnhET1NITk82M283VzhsTGduQTFMbnkv?=
 =?utf-8?B?TWd1TzRiSHJtSC9MSlkwakZ4dzBTNzRVWUxTVFhtdnhzc3VCMXBoNW5JYlps?=
 =?utf-8?B?Ri80cHpRSDd2SHdXRGUxdnIwYmwzWHZ3elJ5S0ZLVjFvTVFvUUd3MkJPMXMw?=
 =?utf-8?B?Z0ZIVjNiN1VaWndXUGxFM3VIdHN3cllqaEFvb3p0YjF3dDUrR002TlZVTUZT?=
 =?utf-8?B?UDNhOU9sd3ZrYVduS0xNMzdZV1VtUGRFWDAwaHp1YmFKU1AwTHMxS0RnNWhv?=
 =?utf-8?B?eWVsWDJ0Nkx1YlZkUFEwWE1QUFhwNXh5OUhMTXlIcUp0a290VndyQVBERGxG?=
 =?utf-8?B?Rld3ZVFLSlE2OC9laVYzTzlUYVJxSnh1VHVxU1k0UUlvY0pXMjh5ZVhYUnEy?=
 =?utf-8?B?akoyZFdDcFhrcUhLYUZmdkt0VTh0OWF3Q3JHc0plbm05UkdRMzQxRXFSYmtH?=
 =?utf-8?B?bUo5clI5Q1pnbXNvci9nM1hndmRUUUZ2TTVIYXQ3UllybU9mWDJFY2huWHg3?=
 =?utf-8?B?aXI5ZW9qeTVIeEdRRHF5L2J4azRNOTJmNGpvWDUwTUZwa3ZDRUVhVWgzQlYr?=
 =?utf-8?B?WmI2c3NuVm8zdVN2R0tpN3lRcG8zVlBhUmVOWVBjanVpQS9xT053VG9PT1l2?=
 =?utf-8?B?dWVrRDlFcWZST0lzTmo4R2JwVnh4SlI4aWMxenptdWFLRXdrWVg1NDc2MXU4?=
 =?utf-8?B?c0c4RytrSzZLd3VleHgxWDRTT3QvY0JOVTIvbEZWTm8vM0s5UEdzRk5MODRX?=
 =?utf-8?B?Wk1QeWdzMU1UWFk2QUcxNjBxNlNHRmFpUE5Ha1U1SkhTRHdDSTE2Uk5pbjI5?=
 =?utf-8?B?V2VPUDdnclVnS0M3WkNDSy84SG5iTTVDSXJqajRJQktUQXgyS0FKSllNUzhw?=
 =?utf-8?B?aGJ3cjlBN3RuVVFVbS8vR0RQYUhlelRiUHZ1RVZLczc3c3ZCOCs2YkpZMmhK?=
 =?utf-8?B?OThnNC9MSXRKWU9Ga1l6WjJ4bzNNVG54aDVzZ0szem1KNXpFeEFMd0I3dkFK?=
 =?utf-8?B?NzdFam1BcHM5d0dOSDBNNG1iR3BweVRNcFA2SDB2WVd3bGtjWWgxaWtRVWJL?=
 =?utf-8?B?aUt1bkdsd2RoVGd0eDFFNE15dzkvejF3SUVxYVB4aTBRSFJPcXRrTWFSMkZx?=
 =?utf-8?B?SERERVZWUFBIT1VoWEp0ZUFtNm14NmRMYUdPT2JTbE14ZkhvaU42UWMxYzJj?=
 =?utf-8?B?NFRMRTFlTmhwbEZzeURKNEhNbnNQemRiYlZ5VTgxUDhtZzZIS3lhTlFaMmFw?=
 =?utf-8?B?dlh3RmFyVWNzK2o1UVd4N0pQYWVuRDRWL3V1b1lNUEdiODY2Q3VJQUFEZDlZ?=
 =?utf-8?B?QlUvRjk2WUVEdE5vMnUyWE5qRi9CYmpPSExJSnBYbFpsYWNsMzFOeU9GMytO?=
 =?utf-8?B?ZkU2dlhRendtVG01Lyt2aTdWa1l6TjQ3ME95SXdQbXYvdlNOTzI1TFNsVEdi?=
 =?utf-8?B?UCtxQmFkZy93Tm15NWlYTUxiVGRRWm9yYXJkU2NPQ0ZyNnRvQWV5dkJjV2Fl?=
 =?utf-8?B?a1YvTEpjYzlWTEh3QklIVWlmOTJ0UFhyYk9LdTZ2RlpuK2ZsbTZPNDh2eUEx?=
 =?utf-8?B?Q2ZLdXV6WHNheHdSNWhjdGRTbSt1eWdHNWx1SnpXYlZZNGdRNnZmMGljTGVI?=
 =?utf-8?B?Z0Y3Ti80eFFraHJSOXpQZm8vZTVSeERGV0RFaS9BdVY1VUY1VytYRVpCeFZE?=
 =?utf-8?B?cVNaYzhxTWJFNWNVaWpWTUZMQ1dtLzY1V0RScDhQcVkxTUZHMmwyYVRGeUFm?=
 =?utf-8?B?bjRyU1ZkSGtWMDBRUnNsTFVoUVFySm5ZeThxLzRzZ0l5Nnc2d0lodz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: osCwsWDF9yE1fjk9acTFplJ34L13BI1t/GBFTkrg7MAra94Xrn/5QlfLd8worDvbRU40Muwuj0FVcGKE/jGnDaj19OikmCyoAtmr8a2LQOp/eUJsPKKTQ8nb5pyeYmKPLK653hLOJPkdvRPDlnyTW5OKfqB4H4yOjvWk7IZcBXRMeFhf8PFR4PM4ZXXLZD7nyIVdauJ2Ww7iAp1SAKzu2j0nPOU88PqLB6fPKPCBxdzr+IzVVJNo2ADFXJ+dosg1D5+nFQx+UWfHWwGxQLSGyNZ0tt0SpzhSs7Uvjz748KeyFNEYjVQypqT2DV3bFORPAJK0i116DQXBP6WkRer9+w==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6af705c-2624-423e-2eed-08dea93a45f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2026 17:34:48.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X83O13LeebLcWukZgpThnm28lic1CxJMfkVcN7EUyCi3OqHEV60hwu1sN8LuIJ45fX8pPtIzflRH1UhE1Gw9lF2WwLjospn9IdHk9Ymb2zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9781
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IpnlQAvPAJrz34QsQdXv6WyKDVX5jQW5RWRCs_6xZ88_1777829693
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 1783E4B6CAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283645-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPiBTZW50OiBTYXR1cmRheSwgTWF5IDIsIDIwMjYgODo1MSBQTQ0KPiBU
bzogY2lwcmlhbi5yZWd1c0BhbmFsb2cuY29tDQo+IENjOiBQYXJ0aGliYW4gVmVlcmFzb29yYW4g
PHBhcnRoaWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPjsgQW5kcmV3IEx1bm4NCj4gPGFu
ZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBT
aW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBKb25hdGhhbiBDb3JiZXQNCj4gPGNvcmJl
dEBsd24ubmV0PjsgU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47IEhlaW5l
ciBLYWxsd2VpdA0KPiA8aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBSdXNzZWxsIEtpbmcgPGxpbnV4
QGFybWxpbnV4Lm9yZy51az47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNv
bm9yK2R0QGtlcm5lbC5vcmc+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAyLzVdIG5l
dDogZXRoZXJuZXQ6IG9hX3RjNjogQWxsb3cgY3VzdG9tIG1paV9idXMNCj4gDQo+IA0KPiBUaGlz
IE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4gVGhpcyBtZXNzYWdlIGNhbWUg
ZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLg0KPiANCj4gPiBAQCAtNTM4LDMyICs1Mzks
MzcgQEAgc3RhdGljIGludCBvYV90YzZfbWRpb2J1c19yZWdpc3RlcihzdHJ1Y3Qgb2FfdGM2ICp0
YzYpDQo+ID4gew0KPiA+IGludCByZXQ7DQo+ID4NCj4gPiAtIHRjNi0+bWRpb2J1cyA9IG1kaW9i
dXNfYWxsb2MoKTsNCj4gPiBpZiAoIXRjNi0+bWRpb2J1cykgew0KPiA+IC0gbmV0ZGV2X2Vycih0
YzYtPm5ldGRldiwgIk1ESU8gYnVzIGFsbG9jIGZhaWxlZFxuIik7DQo+ID4gLSByZXR1cm4gLUVO
T01FTTsNCj4gPiArIHRjNi0+bWRpb2J1cyA9IG1kaW9idXNfYWxsb2MoKTsNCj4gPiArIGlmICgh
dGM2LT5tZGlvYnVzKSB7DQo+ID4gKyBuZXRkZXZfZXJyKHRjNi0+bmV0ZGV2LCAiTURJTyBidXMg
YWxsb2MgZmFpbGVkXG4iKTsNCj4gPiArIHJldHVybiAtRU5PTUVNOw0KPiA+ICsgfQ0KPiA+ICsN
Cj4gPiArIHRjNi0+bWRpb2J1cy0+cmVhZCA9IG9hX3RjNl9tZGlvYnVzX3JlYWQ7DQo+ID4gKyB0
YzYtPm1kaW9idXMtPndyaXRlID0gb2FfdGM2X21kaW9idXNfd3JpdGU7DQo+ID4gKyAvKiBPUEVO
IEFsbGlhbmNlIDEwQkFTRS1UMXggY29tcGxpYW5jZSBNQUMtUEhZcyB3aWxsIGhhdmUgYm90aCBD
MjIgYW5kDQo+ID4gKyAqIEM0NSByZWdpc3RlcnMgc3BhY2UuIElmIHRoZSBQSFkgaXMgZGlzY292
ZXJlZCB2aWEgQzIyIGJ1cyBwcm90b2NvbCBpdA0KPiA+ICsgKiBhc3N1bWVzIGl0IHVzZXMgQzIy
IHByb3RvY29sIGFuZCBhbHdheXMgdXNlcyBDMjIgcmVnaXN0ZXJzIGluZGlyZWN0DQo+ID4gKyAq
IGFjY2VzcyB0byBhY2Nlc3MgQzQ1IHJlZ2lzdGVycy4gVGhpcyBpcyBiZWNhdXNlLCB3ZSBkb24n
dCBoYXZlIGENCj4gPiArICogY2xlYW4gc2VwYXJhdGlvbiBiZXR3ZWVuIEMyMi9DNDUgcmVnaXN0
ZXIgc3BhY2UgYW5kIEMyMi9DNDUgTURJTyBidXMNCj4gPiArICogcHJvdG9jb2xzLiBSZXN1bHRp
bmcsIFBIWSBDNDUgcmVnaXN0ZXJzIGRpcmVjdCBhY2Nlc3MgY2FuJ3QgYmUgdXNlZA0KPiA+ICsg
KiB3aGljaCBjYW4gc2F2ZSBtdWx0aXBsZSBTUEkgYnVzIGFjY2Vzcy4gVG8gc3VwcG9ydCB0aGlz
IGZlYXR1cmUsIFBIWQ0KPiA+ICsgKiBkcml2ZXJzIGNhbiBzZXQgLnJlYWRfbW1kLy53cml0ZV9t
bWQgaW4gdGhlIFBIWSBkcml2ZXIgdG8gY2FsbA0KPiA+ICsgKiAucmVhZF9jNDUvLndyaXRlX2M0
NS4gRXg6IGRyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4gPiArICovDQo+ID4gKyB0
YzYtPm1kaW9idXMtPnJlYWRfYzQ1ID0gb2FfdGM2X21kaW9idXNfcmVhZF9jNDU7DQo+ID4gKyB0
YzYtPm1kaW9idXMtPndyaXRlX2M0NSA9IG9hX3RjNl9tZGlvYnVzX3dyaXRlX2M0NTsNCj4gPiAr
DQo+ID4gKyB0YzYtPm93bl9tZGlvYnVzID0gdHJ1ZTsNCj4gPiB9DQo+ID4NCj4gPiB0YzYtPm1k
aW9idXMtPnByaXYgPSB0YzY7DQo+ID4gLSB0YzYtPm1kaW9idXMtPnJlYWQgPSBvYV90YzZfbWRp
b2J1c19yZWFkOw0KPiA+IC0gdGM2LT5tZGlvYnVzLT53cml0ZSA9IG9hX3RjNl9tZGlvYnVzX3dy
aXRlOw0KPiA+IC0gLyogT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IGNvbXBsaWFuY2UgTUFDLVBI
WXMgd2lsbCBoYXZlIGJvdGggQzIyIGFuZA0KPiA+IC0gKiBDNDUgcmVnaXN0ZXJzIHNwYWNlLiBJ
ZiB0aGUgUEhZIGlzIGRpc2NvdmVyZWQgdmlhIEMyMiBidXMgcHJvdG9jb2wgaXQNCj4gPiAtICog
YXNzdW1lcyBpdCB1c2VzIEMyMiBwcm90b2NvbCBhbmQgYWx3YXlzIHVzZXMgQzIyIHJlZ2lzdGVy
cyBpbmRpcmVjdA0KPiA+IC0gKiBhY2Nlc3MgdG8gYWNjZXNzIEM0NSByZWdpc3RlcnMuIFRoaXMg
aXMgYmVjYXVzZSwgd2UgZG9uJ3QgaGF2ZSBhDQo+ID4gLSAqIGNsZWFuIHNlcGFyYXRpb24gYmV0
d2VlbiBDMjIvQzQ1IHJlZ2lzdGVyIHNwYWNlIGFuZCBDMjIvQzQ1IE1ESU8gYnVzDQo+ID4gLSAq
IHByb3RvY29scy4gUmVzdWx0aW5nLCBQSFkgQzQ1IHJlZ2lzdGVycyBkaXJlY3QgYWNjZXNzIGNh
bid0IGJlIHVzZWQNCj4gPiAtICogd2hpY2ggY2FuIHNhdmUgbXVsdGlwbGUgU1BJIGJ1cyBhY2Nl
c3MuIFRvIHN1cHBvcnQgdGhpcyBmZWF0dXJlLCBQSFkNCj4gPiAtICogZHJpdmVycyBjYW4gc2V0
IC5yZWFkX21tZC8ud3JpdGVfbW1kIGluIHRoZSBQSFkgZHJpdmVyIHRvIGNhbGwNCj4gPiAtICog
LnJlYWRfYzQ1Ly53cml0ZV9jNDUuIEV4OiBkcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5j
DQo+ID4gLSAqLw0KPiA+IC0gdGM2LT5tZGlvYnVzLT5yZWFkX2M0NSA9IG9hX3RjNl9tZGlvYnVz
X3JlYWRfYzQ1Ow0KPiA+IC0gdGM2LT5tZGlvYnVzLT53cml0ZV9jNDUgPSBvYV90YzZfbWRpb2J1
c193cml0ZV9jNDU7DQo+ID4gLSB0YzYtPm1kaW9idXMtPm5hbWUgPSAib2EtdGM2LW1kaW9idXMi
Ow0KPiA+IHRjNi0+bWRpb2J1cy0+cGFyZW50ID0gdGM2LT5kZXY7DQo+ID4gKyB0YzYtPm1kaW9i
dXMtPm5hbWUgPSAib2EtdGM2LW1kaW9idXMiOw0KPiA+DQo+ID4gc25wcmludGYodGM2LT5tZGlv
YnVzLT5pZCwgQVJSQVlfU0laRSh0YzYtPm1kaW9idXMtPmlkKSwgIiVzIiwNCj4gPiAtIGRldl9u
YW1lKCZ0YzYtPnNwaS0+ZGV2KSk7DQo+ID4gKyBkZXZfbmFtZSgmdGM2LT5zcGktPmRldikpOw0K
PiA+DQo+ID4gcmV0ID0gbWRpb2J1c19yZWdpc3Rlcih0YzYtPm1kaW9idXMpOw0KPiA+IGlmIChy
ZXQpIHsNCj4gPiBAQCAtNTc3LDE5ICs1ODMsMzAgQEAgc3RhdGljIGludCBvYV90YzZfbWRpb2J1
c19yZWdpc3RlcihzdHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+ID4NCj4gPiBzdGF0aWMgdm9pZCBvYV90
YzZfbWRpb2J1c191bnJlZ2lzdGVyKHN0cnVjdCBvYV90YzYgKnRjNikNCj4gPiB7DQo+ID4gKyBp
ZiAoIXRjNi0+bWRpb2J1cykNCj4gPiArIHJldHVybjsNCj4gPiArDQo+ID4gbWRpb2J1c191bnJl
Z2lzdGVyKHRjNi0+bWRpb2J1cyk7DQo+ID4gLSBtZGlvYnVzX2ZyZWUodGM2LT5tZGlvYnVzKTsN
Cj4gPiArDQo+ID4gKyBpZiAodGM2LT5vd25fbWRpb2J1cykNCj4gPiArIG1kaW9idXNfZnJlZSh0
YzYtPm1kaW9idXMpOw0KPiA+IH0NCj4gPg0KPiA+IHN0YXRpYyBpbnQgb2FfdGM2X3BoeV9pbml0
KHN0cnVjdCBvYV90YzYgKnRjNikNCj4gPiB7DQo+ID4gaW50IHJldDsNCj4gPg0KPiA+IC0gcmV0
ID0gb2FfdGM2X2NoZWNrX3BoeV9yZWdfZGlyZWN0X2FjY2Vzc19jYXBhYmlsaXR5KHRjNik7DQo+
ID4gLSBpZiAocmV0KSB7DQo+ID4gLSBuZXRkZXZfZXJyKHRjNi0+bmV0ZGV2LA0KPiA+IC0gIkRp
cmVjdCBQSFkgcmVnaXN0ZXIgYWNjZXNzIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIE1BQy1QSFlc
biIpOw0KPiA+IC0gcmV0dXJuIHJldDsNCj4gPiArIC8qIElmIHRoZSBkcml2ZXIgcHJvdmlkZWQg
YSBtaWlfYnVzLCBpdCBpcyBhbHNvIHJlc3BvbnNpYmxlIGZvcg0KPiA+ICsgKiBpbXBsZW1lbnRp
bmcgdGhlIGJ1cyBhY2Nlc3MgbWV0aG9kcywgc28gd2UgZG9uJ3QgaGF2ZSB0byB3b3JyeQ0KPiA+
ICsgKiBhYm91dCBjaGVja2luZyB0aGUgUEhZIGFjY2VzcyBtb2RlLg0KPiA+ICsgKi8NCj4gPiAr
IGlmICghdGM2LT5tZGlvYnVzKSB7DQo+ID4gKyByZXQgPSBvYV90YzZfY2hlY2tfcGh5X3JlZ19k
aXJlY3RfYWNjZXNzX2NhcGFiaWxpdHkodGM2KTsNCj4gPiArIGlmIChyZXQpIHsNCj4gPiArIG5l
dGRldl9lcnIodGM2LT5uZXRkZXYsDQo+ID4gKyAiRGlyZWN0IFBIWSByZWdpc3RlciBhY2Nlc3Mg
aXMgbm90IHN1cHBvcnRlZCBieSB0aGUgTUFDLVBIWVxuIik7DQo+ID4gKyByZXR1cm4gcmV0Ow0K
PiA+ICsgfQ0KPiANCj4gVGhpcyBhbGwgc2VlbXMgcHJldHR5IGludmFzaXZlIGFuZCB1Z2x5LiBQ
bGVhc2UgY291bGQgeW91IHRoaW5rIHdoYXQNCj4gaGFwcGVucyBpZiBpbnN0ZWFkIG9mIHBhc3Np
bmcgaW4gYW4gbWRpb2J1cywgeW91IHBhc3MgYSBwaHlkZXYuIElzIHRoZQ0KPiBjaGFuZ2UgdG8g
dGhlIGNvcmUgc2ltcGxlciBhbmQgY2xlYW5lcj8NCj4gDQo+IEFuZHJldw0KDQpLaW5kIG9mIGFn
cmVlLiBJbml0aWFsbHkgd2Ugd2VyZSB0aGlua2luZyBhYm91dCBjaGFuZ2luZyB0aGUgZXhpc3Rp
bmcgY29kZSAoTWljcm9jaGlwJ3MgdmVuZG9yIGNvZGUpIHRvIGFsbG9jIG1paV9idXMgc28gdGhh
dCBjb2RlIHdvdWxkIGJlIHNhbWUgYWNyb3NzIG11bHRpcGxlIHZlbmRvcnMuIEVpdGhlciB3YXks
IGl0IHdvdWxkIGJlIGludmFzaXZlIGNoYW5nZXMuIFNvLCB3ZSBkZWNpZGUgdG8gZ28gd2l0aCBt
aW5pbWFsIGNoYW5nZSB0byBvdGhlciB2ZW5kb3IncyBjb2RlLg0KDQpUcnlpbmcgdG8gdW5kZXJz
dGFuZCB5b3VyIHN1Z2dlc3Rpb24uIEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBtb3ZlIGVudGlyZSBt
aWlfYnVzIGFsbG9jYXRpb24vQVBJcyBpbXBsZW1lbnRhdGlvbiB0byB2ZW5kb3Igc2lkZSBhbmQg
a2VlcCBvbmx5IHBoeSBkZXYgdXNhZ2UgaW4gb2FfdGM2LmM/DQoNCklmIG15IHVuZGVyc3RhbmRp
bmcgaXMgY29ycmVjdCwgSSBndWVzcyBpdCB3b3VsZCBiZSBjbGVhbmVyLiBJIGNhbiB0cnkgdGhh
dC4gTGV0IG1lIGtub3cuDQoNClNlbHZhDQoNCg0K


