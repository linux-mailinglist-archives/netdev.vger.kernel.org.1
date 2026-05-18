Return-Path: <netdev+bounces-288844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN1zNq6PCmrt3QQAu9opvQ
	(envelope-from <netdev+bounces-288844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:03:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C67565900
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D50300A392
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB652580CF;
	Mon, 18 May 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="AXd62Xq1"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8A2AD03
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779077035; cv=none; b=na3Xa0SLCpDz3ZMCbTiWwpVBneeGVSLepOA2jGx/ykT9pFJLwxD5L0k/SMFZkB3p+v/X1Fnzx6fFY3jPZPC6ZxQpiZ1KTFtC/ipY4RJO9R6kAw62lSrOkRdjDwTl7E3QigFRVmqS1uUIpjfWWqhJ4Kfy5Q9kLSMuPFSihdyt+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779077035; c=relaxed/simple;
	bh=gIqArM0eS8AC0h89gp8WIgP9W48XMxZE0NStVDsqVaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Vhbm/90osIAoCC4VWr8VuZOKezO9RvTuagFYoJGe36oXJ+v40ANxvdTKSp6eLIe4kpWDduKcCRwXDKSuYy9rd5CSQ0RZqPrcvrOifPdbg295zkd/4SOWU69ubSV0IrIdEbk6D/LId/yU31Kw9Q8/XiQjy5alUFl/DaUpIgF4G9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=AXd62Xq1; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1779077027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIqArM0eS8AC0h89gp8WIgP9W48XMxZE0NStVDsqVaE=;
	b=AXd62Xq1tmJDjPSbG7pnD42L4f1fMTNRn5JxN+HzZJk4hdltbXTHetz7QjzBKQdMDSEhR5
	ZmB864ousbXOClWIrZUio6vGf6uHpnrUygOXxXrLY4NXAmgE6d1yDQ9TtSvH/hQS2oUPFg
	/jCZUAtqUSJn6h84BwXHTaqirO95guIgxpL3CUZe2nv85kUhbHHDZ7xdK/H2iQ6xxvO9D5
	tFaznWAl0YS1Hoou3R/sDpPyMxrwi92v88CoSU9xIZ0Wpya0jdaukgHGcwO7LwzEm+RsrY
	wh59rQzQd+K6FnoMoj4TUWNeOmD5qTj2bGtpTOR4HMT1PP7DQdg46V4lGIVtVQ==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-39--cBX339YN7O26Rv7ckWY0Q-1; Sun, 17 May 2026 21:03:43 -0700
X-MC-Unique: -cBX339YN7O26Rv7ckWY0Q-1
X-Mimecast-MFC-AGG-ID: -cBX339YN7O26Rv7ckWY0Q_1779077020
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DM6PR02MB6652.namprd02.prod.outlook.com (2603:10b6:5:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 04:03:39 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 04:03:39 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AdzhcbEAp6Owv179R1mImunkqBeYBAAELzkAAT2eW1A=
Date: Mon, 18 May 2026 04:03:38 +0000
Message-ID: <CY8PR02MB9249BE304350D2FA7C196A6C83032@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <c9b1b559-f72e-46e0-8d71-57ea26f70bb0@lunn.ch>
In-Reply-To: <c9b1b559-f72e-46e0-8d71-57ea26f70bb0@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DM6PR02MB6652:EE_
x-ms-office365-filtering-correlation-id: db5fbc75-4d55-49e6-1dbd-08deb4927126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|11063799003|21046099003|18002099003|22082099003|38070700021|56012099003
x-microsoft-antispam-message-info: Sx3svRJHgAM3NOAu2mmNTsXHkW+RJ37WGHuw5lDwoMKfGbY8LJBcRJeCxB6XqIHH8mITFfIQLNqZD1baFm9HKgztG+6VMrRkORewnscszi4Z3UFOcdUFUWlihvjNM2VKLU8uNZ/EP7PJn4zzb1+uOKILkLsDd9X0OJnFvxrxFJNhAmgqh74tgsqNmwOVAfn4eCqo+pWLGB+nN1DgPrVumcR3lMZSbvr59Ak22SLouKZf7nix75m4RuXGG9FCoB5tOK/jq23wRP6K0kVCIs+t8mAcHDxmLmg4slIIUeQblKWDBbaadf4NzNTUVWsTFYf/SONRRv/LU+ly7SdG+PIZqZKDKsXE4lbj8zYi+B+FlfG+XNeY83eIJ1kfExSOtqZC0SO3AoUHIurt90BAlfgCTVjbyCWtuCWLAhfm8rtwQYKPOvQsMhxVLdP06/KFhl8CboAWq7NC849rGKgZ5vyNfdNvXzx0T9lbVhJ5zYqqwVD1t8Ncwrmdu01dl0i4Esfa3IfRyn/Swp4+zzG7+IF0YRqbO5izvSYPKWPxEa2uFeF3HP7Qc3e9cSBRp7RqaIi26h25BpNEMxY9GL5FmsY0WmMnWof5aXr6dP18dxSWHACGdo4SlusXVrDwS4fxkQYxwEO3RSBHup0AuLjlrJZFsdsUQ0Q7Yf94QXgiahTDjq8g0vR12iV8PxiTU7IrgFzMWblFdn7W8z1nGWH8EUIhEU8yBadAWsgJn4ZfC/bB2BsadAUIBzgJDfsZSA9Lrl+z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799003)(21046099003)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REVaWDBCU2JySTJwTnE3TFVwb1dDWW5lQU9QVkl2WTdwNjJ2R2dPbStYSTFj?=
 =?utf-8?B?ZE5GVE5wTHdoZVp5ZVJTZ2xlNnJhTmxrSlVQb2lqbEhHYXdvUVNHcG1qUEx5?=
 =?utf-8?B?YWw4bW1UbzI0eURVdUZ5L2hQSllVc3lUU0NwTm9SOUxwMWpqK3RBOFBQRlI0?=
 =?utf-8?B?Z2h6OGYzdVE2SUhDWjBDY0VWRTRYQ0dwOVVsbFNFTmhNV2YxaHM2cGNlbHQx?=
 =?utf-8?B?dU9UL1BDVmhKVHBkKzJLSnQ0VW9nVm5XTnc3eVdsbW5KUGJFWTRvZ2RqVkl3?=
 =?utf-8?B?S3AxdlZtdmxqSWEyMGZNZ25YeDVsdzFPTkNaaUFTdFdOMll3c0N0OXA3cnAx?=
 =?utf-8?B?YVRRWkVlRlZkcHI2aVp4QUdoQkFsanBUc20yeHQwRHRmRFQvdjNZcktvMDRa?=
 =?utf-8?B?SGt4ZjRhZzJUcjB1dW1Kc2FEbG96QllCeCtLSFJUVUZzeFFYVWdJTVVmSUlL?=
 =?utf-8?B?YndKa01jcUdaanJnWndRZjcrNmo0dlpjYTkxdkxvTnNYU3p4OWpBWFVrcDNl?=
 =?utf-8?B?SmtGS2I5Z2x1YiszSGZkWFBqQ2REdHcya280TEJvQ296ZEFwRXBoSVhhN2p5?=
 =?utf-8?B?RURBT0gxWi84U3JtNEhPTU1QR1lpaTJ6azEwY3lUWDB3Q0IrSGM3OEZSOXVF?=
 =?utf-8?B?UUYyRExVZFVUbHdzaGQ1M1BacHFzc0ZPQmlYVW05SDN0eGlPNTBpM01CbnRq?=
 =?utf-8?B?TEdjZEpuVU1RTnZGWHB6VDlvZXRyMEZTVFdGNnhSakt4NysrRlNhUHpZa2lm?=
 =?utf-8?B?Y3pyRDVFdTVWbkZoMFE5YlplL2RqN3oyOFlmc241bXhnQzNRbDY1UDNteTJZ?=
 =?utf-8?B?UmdISWIzWTVuS0lJN1ZTTVRVdk9JYis2TEpaWlpQZWp0bFhXU09aYTN3YlQ3?=
 =?utf-8?B?K3ozNmdTek9uaXBFZ2I5eDFYY2p4R3dQbjV3b2ZKcUhoams0ZFVtNHJjNFBP?=
 =?utf-8?B?Zkh5VHdYcVozRGl2YktrcnREeTZORkxKTmNidk9nTnE5SElCS1hrcnArdmJC?=
 =?utf-8?B?aURDNmNvOHpNOTlsdlRXdHhkUlZpblZEQzhLc3Z4L2poREh1S3N6QmFFSU5N?=
 =?utf-8?B?Y2JaWFRteVJ3OUl0em9IQmFyR2t6cVpZbnZ3ZHptMmUyRTkwbE9oZ2d0U0F4?=
 =?utf-8?B?ZkRvYzBQZ0lLQ3BFSmtQcE5tamNyNU9zdk11SlNvSm1UdXp3MlZybm50V20r?=
 =?utf-8?B?dk1nRzJ0bHFBYWZuK2c0QkdaWjlMbU1JRVlhLzN5WjRtS3FJYVowTFM3ZENB?=
 =?utf-8?B?U3FPQVN1aUZGazYzR1NEckczRzJwQnhIRzVGWDFieG53d1RoZEdaQTFxdkw0?=
 =?utf-8?B?NGlzT01DNjFPZEoyUHQ0dFNyRlQ4eGpSY2VPZ1cwV0RaVjhHUFV6dzVwR05U?=
 =?utf-8?B?T3lwZ3JaOWt6ZnJLSmdQclpyTU4xZUxMMkZBMG13UmFzTE50K0p3YjQwVnM0?=
 =?utf-8?B?eDE5NDRlTHlQeXZsbWFsQkdwSVkvRDYzVDY1L2k3K2R6TU42RzJUeUVTanE2?=
 =?utf-8?B?RFhsZlZzSENPNlI5RHFiV0FSK1p4Q1NMdXVDZ2E0azVyVk1oaEtUaStXTGhX?=
 =?utf-8?B?eXArVVFMdWxSakplMGJxelZOQ2tqVVc3QWJzSC93S21UdHdic3JaN093b1ph?=
 =?utf-8?B?eTZSdkI5RFNXaHhYU0JLZXZpUmVYY0txQzZtTG9HaTJvSzB3ZHlDRzNTcCtu?=
 =?utf-8?B?RFM3UThuaG1zSVVnWitvSTBCTFJNdTRyYTAxN1JxdUJEWHI3WlFtRHh2cWZ5?=
 =?utf-8?B?WGU2K0ZLTlJtV2tsWFpVdDJHWDdBNENYL1d5VUl0Y1pRTTlORDR1bkxvYmZ2?=
 =?utf-8?B?UXdQMm5UOFNIMGlYTUp5RkJmVHR6M21PZFFaeHJZY1laMnhqSEN3Zlk5T2tF?=
 =?utf-8?B?MCtZNVhMem5kbjVNY045L1Q0VzRieTZldXdsQzV4amdwN1NIcWxsK3dtYVND?=
 =?utf-8?B?SFB3SnVHODBPZzc1VHRiZ3A4M0VxYUhYT2UrVkNCSWlXNVZzRm12akNscTlt?=
 =?utf-8?B?cGthTGdaeDlIY2hudTdFL29FTUI1K0x1YnhnZSsxYm9xRlZodmZzVlpOMjNz?=
 =?utf-8?B?MFBOdTgxT1UxZ056NUplcmIvVmpSVGtMYXliVzY1Q2ZtOVdrZUpyOVdsTW5J?=
 =?utf-8?B?UDJ6d3ZZSnRzT1dwOTZ4MU54R2k3MGU1ZVp3YXNWTExyUkJqZUU3R1FHcnQ0?=
 =?utf-8?B?cGhGKzN1OWhIUk94Nm4yZ2hsNGhNTDM2WnllY292US9kMEpPU2VuUi8xSkVW?=
 =?utf-8?B?dmI5WGM3YjI3TWExWGMza1dKaWtDVkR1RUtsWXdFZDh6dElFNGdoWVROeWpp?=
 =?utf-8?B?MGtYNUkxdHYrK1RXL3lWRURoZ1FSaG5kYUJSdE1wT1A0WmlaWlRUbzdHT3Vk?=
 =?utf-8?Q?ZHXUOHWnSBFq1r3w=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SGzlfaY5ukFMbA/bdQ8gG3H1ZzC/Zmjvio020+bmeYxqm74yZjpxqTkFMLxf5LVgGXD9+C2boxsK6CoyfvNXtMz20Y8OhBHPo4XhwGASRkJQa1g3GUay3Rnk2amagBcSe77caWYh/BPA5EXA/1McZFCrHhoW47tD3tzzVv/cfozizxK0PXiBtIMmJBzLTVzoYChweMVg1quAHMnjeUyfPRnVj1VvFD3NMtMbL7iGcTAEUKvaThldu7L0JIneT0SYYyYpJvIjhK4rawXt1qFxpi507uP01/yTjox8+/UaP2OSSQmUXrK8w2ud20+bbadY1DqxP4pvxMneueH/xrFVqg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5fbc75-4d55-49e6-1dbd-08deb4927126
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 04:03:38.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tw4ot2eES1e2ep3tZw4FxBQO2KyN5lpdLASmsfZ7zf+dEmQgvT+6l1Y9CDAJf9rr1fSrT7PGAAZRCe86P0HVxPtkKOPNPtYB8qAgbcjuyD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6652
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m3GhJs8kld02P6-gUooP7fV9kC7LDwiHb9455wcIZgE_1779077020
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 47C67565900
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

DQoNCg0KPiA+ICtzdGF0aWMgaW50IHMyNTAwX2h3dHN0YW1wX2dldChzdHJ1Y3QgbmV0X2Rldmlj
ZSAqbmRldiwNCj4gPiArIHN0cnVjdCBrZXJuZWxfaHd0c3RhbXBfY29uZmlnICpjZmcpDQo+ID4g
K3sNCj4gPiArIHN0cnVjdCBzMjUwMF9pbmZvICpwcml2ID0gbmV0ZGV2X3ByaXYobmRldik7DQo+
ID4gKw0KPiA+ICsgaWYgKCFwcml2LT5wdHBfY2xvY2spIHsNCj4gPiArIGNmZy0+dHhfdHlwZSA9
IDA7DQo+ID4gKyBjZmctPnJ4X2ZpbHRlciA9IDA7DQo+ID4gKyB9IGVsc2Ugew0KPiA+ICsgb2Ff
dGM2X2h3dHN0YW1wX2dldChwcml2LT50YzYsIGNmZyk7DQo+ID4gKyB9DQo+ID4gKyByZXR1cm4g
MDsNCj4gDQo+IFdoYXQgaXMgYWN0dWFsbHkgc3BlY2lmaWMgdG8gdGhlIHMyNTAwIGhlcmU/IFlv
dXIgYWltIHNob3VsZCBiZSB0byBwdXQNCj4gZXZlcnl0aGluZyB5b3UgY2FuIGludG8gdGhlIGNv
cmUuDQoNCkkgYWdyZWUgb24gdGhpcyBhbmQgdGhlIG5leHQgY29tbWVudCBhcyB3ZWxsLiBOb3Ro
aW5nIHJlYWxseSB2ZW5kb3Igc3BlY2lmaWMuIA0KDQpRdWVzdGlvbiBpcywgDQoxKSBTaG91bGQg
d2UgYWRkIHRoZSBQVFAgY29kZSBpbiBvYV90YzYuYz8gVGhpcyBQVFAgY29kZSBhZGQgMjAwKyBs
aW5lcy4gTXkgcHJlZmVyZW5jZSBpcyB0byBhZGQgYSBuZXcgZmlsZSBvYV90YzZfcHRwLmMgdW5k
ZXIgdGhlIGRpcmVjdG9yeSB3aGVyZSBvYV90YzYuYyByZXNpZGVzLg0KMikgSWYgd2UgYXJlIGFk
ZGluZyBhIG5ldyBmaWxlLCBzaG91bGQgaXQgYmUgdW5kZXIgc2FtZSBDT05GSUdfT0FfVEM2IG9y
IGFkZCBhIG5ldyBDT05GSUdfT0FfVEM2X0hXX1RJTUVTVEFNUCBvciBzb21ldGhpbmcgc2ltaWxh
cj8NCg0KTGV0IG1lIGtub3cuDQoNCj4gDQo+ID4gKyAvKiBDb25maWd1cmUgUFRQIGlmIHRoZSBt
b2RlbCBzdXBwb3J0cyBpdCAqLw0KPiA+ICsgaWYgKHByaXYtPmNhcGFiaWxpdGllcyAmIFMyNTAw
X0NBUF9QVFApDQo+ID4gKyBzMjUwMF9wdHBfcmVnaXN0ZXIocHJpdik7DQo+IA0KPiBUaGF0IHNo
b3VsZCBiZSBpbiB0aGUgY29yZSwgYmFzZWQgb24gRlRTQy4NCj4gDQo+IEFuZHJldw0KDQo=


