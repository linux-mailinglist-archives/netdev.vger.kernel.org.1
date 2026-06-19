Return-Path: <netdev+bounces-300662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0QeoF4MJNWovmQYAu9opvQ
	(envelope-from <netdev+bounces-300662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCD6A4ED4
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schleissheimer.onmicrosoft.com header.s=selector1-schleissheimer-onmicrosoft-com header.b=YzvodifQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300662-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=schleissheimer.de (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8DCA300A501
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661DD23E320;
	Fri, 19 Jun 2026 09:18:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020107.outbound.protection.outlook.com [52.101.171.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F6360EE9;
	Fri, 19 Jun 2026 09:18:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860736; cv=fail; b=RALN7EMXgZQ/81xIqeQG51eZSQviGB3dhyp91ynqeqotKwXrV05LlK1jFZLGOkcvkNwB45WcKAANGnxvkqFR5pTFbPEGzpWzRJx2SZ8RYli0e6TCHKrS4es0yuNw97GHXR2y2xscs44YpmfgdCZ2AfUdqEeaPulE+ZI7bBDZoEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860736; c=relaxed/simple;
	bh=7UkT1KWknmQyBBhftoxgBZ5SWdUgonujOfOsbLKO1WE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVYA098L3gD/yFDBOs5DaQfLDtDkGcT4QYxKHEUlNpoYDLuuSaLDcNQT52LWyEw0xBKhUG/7ODPfR9jp4XYn2iSZgiEluY0Mj0cmavtvfnHUHahAhpTQYFXQJAVxI81HgoYUknRu8aAAKKQHFo1WPwfgO19EOKUSOoRJba5ouU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=YzvodifQ; arc=fail smtp.client-ip=52.101.171.107
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaiC7YCxPOAU5naedD41qkho9tj7bPkOGODud5TNENz9t66Z3K3sMURy/US036Raqtlw9dZRa7ru9goRZ+EUREROSZ4dBwHrEMcdiKUvlcu4EqbnGyI2wYXjXxcMILbGWtza8yNpfDHTFKQP8j3mywayYOpItW43vlTgXIejBYO2ppdSQRptzhHxshY8YY81S1kbHacjAM7ebNOxRGs9Kml6NYmh9IZsL/Q4ICTEoFGTYec7LYguJVAa1pzwr5/0KW2YfpnCfiEzkQmI98CG9y0catsib9SxsRwyxpC6uVXgNSvcuOILH8MFlbSIesJI3FVGSdahW7BR8TuhUAbgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxSfDccKodZMw227s7rhFfOgCJy7cjusmf9BDw2nPfk=;
 b=QE2ihW+zgV46lBw0xP6kxgbu2ddSvLfY0m54kt8LhT+Frs7vN+wrUR4CChmtcpXIRzCcCnhJUOqOjGFO9tsngeD6StQ81h7ydRNu8Xb9ahvbqA+kaN1RMF2aSftKsOqRqYZ0AEA+0IaoMdoBKRnm51CYu/jdIdM0JccsaEYkULLAqRsTy4p28ZweEhY1SjoF/cxkNbg50hwSn158oda2kcDLGFXcyb840fTTLLBUCzk6H4StrpCSGbB8c5ikHBlzWzKkCJMHIMPM2jqfvWJNXiu4C2aiauTJLunfPLMV9CMtyrExF5uLVHQGLZCQNYiPS0DsMSCMCfi/GRXFXUoL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxSfDccKodZMw227s7rhFfOgCJy7cjusmf9BDw2nPfk=;
 b=YzvodifQk9gFO2H2aKwV6fMPC7T3ZMFSQKm7RwZi6H4m4R8jPTV3f51dDFoZnfROQS8g7P+K4NPHRMe6NDMO94D/XzdJ6TCp/GNH/t/gaspq4extI1wjMxV2ilzHVJMfxhRtxLgz32MDv8INOcIyE9srx+CXT4yUY22UKmRQ+Dw=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR5P281MB5014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 09:18:50 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 09:18:50 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
	<Rengarajan.S@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "Woojung.Huh@microchip.com"
	<Woojung.Huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter table
 after device reset
Thread-Topic: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter table
 after device reset
Thread-Index: AQHc/1ZL+dYj4wyIHkavMkZrzwxM9bZFg8XYgAAJTICAAAseOA==
Date: Fri, 19 Jun 2026 09:18:49 +0000
Message-ID:
 <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
In-Reply-To: <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR5P281MB5014:EE_
x-ms-office365-filtering-correlation-id: 3165ef0b-88bf-459c-9793-08decde3c635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|5023799004|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 gT4ETJL92Q1HQYsgKdXqQXBo1C1dZYYYDeP4ZlRNfnxKI8uaHHIaKgtv/8hM56QFriLnFiSkvEUCleaQZia3LAInDLicLYxIIgxq68eCGOGyVkG+OqXWs5fGttu74oYBZWKX9J/uANAcgqD5kvgZXpVRzVPpPLo8CDIV/wc2cBBmjPimFKA8O9L4VfZjKirSAFo+KTo8dlxhPlFQ1j718eYmjFzx/WmNsbjsBQIiV1+loUZPp3ES6vXLHtLmMBOq//UXtS4B5hOxMtCVpfJPOLtRudPBC5DdtTQfBjtF7TSDdjhH48e4IWZ6Bt8EwJOoXBNE62kchdNAGJ/2i/GJZPhpmI6TFPy+t5GUL6iXeiVnEhC8QUWhq//Yp9a0CllCdyGw03jkVz9fzCo9S7AoMLnLJ8+Rjy7vu2UUfojZ9Z7f20yQslB0I05TracS/3SJ5jMACiPM3eutBS0Fa2MZHmJrHVe/qSq3oV+A46Vmzo0eZTRl3x2Wvf4gf3ef1VjGgcp3yniQrdKXTSlvwbLV14ThAkOtzYyOgU+PSomB0GSWptniqAPbePzDXul6EKpSKAOo5Jpi3IXvOwVHZ1eoKA+maDbJXjzUCe/9zI8ngaOKp5GxT6/6ICui8if3Mxd9AUh9ONWFOGIA+Bl11dctOICQf/SHAITBrmF/Rv+ko0vudFCvUKgeO72trI2W0fGxKuvVUxoQXx5+FeF6OxxBOHc3El9olyvik56DWzVaiag=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QfZK/dFaXyZbWHbxF0FWYbhkY3isIUfjQWOo25cKOCcGv2EBhRAe/rT9WE?=
 =?iso-8859-1?Q?eeOLbOMbOcQoNMKNEGYEP68K4se1pa8k+blDU6dkMyvJEB/kfrujqpkCuS?=
 =?iso-8859-1?Q?FEoYZGoDKkGqtcLvH7yzBVnnc5ASrdE/bbDC9hGod0z1qJzGZSLrcum77K?=
 =?iso-8859-1?Q?XtwlghOCKpIsScN8TG6ZHzMeD+gxEpOjfIDjdUhrpFpCYdDMXu2Y64enVR?=
 =?iso-8859-1?Q?TJygHVYOAFPP560jucLhPqtVwgUE7WJ6y1VOzmaF5lEh/drf38oTT+6O1o?=
 =?iso-8859-1?Q?zxQZCNyV0aeqwxZGjDYcpDQfmPO5Vq37YXp+NPl//S2zmD2Dtb/7UNXHqA?=
 =?iso-8859-1?Q?/UStTx72Ng24UoOa7+YHihNJmMYHFtWgjYew232KWeDdGAdpKUTgG27+yr?=
 =?iso-8859-1?Q?x61Xadx6LgZMM+DuQ5ALbS68cGdk70aLRyBN8lh4/1IHuYDNSvFVbQU/eA?=
 =?iso-8859-1?Q?F0qkoyV9QFx74ArWCsG3rXxw1paDHt/1leChOtzN2jKxZcc0J19QO+pnKN?=
 =?iso-8859-1?Q?+KSl0pLhh07naemlA5JBqUREbtDcu3sqdfmz0G9xXNccHjZnU4glY/qyfi?=
 =?iso-8859-1?Q?G9LA7RpcNlG8OUmEhP2TYBr1kmF5V8Z4CX3pwNUMfJHlQpl9uqC1ynI1/l?=
 =?iso-8859-1?Q?o7hIwkiYvhbTcaShX6dmUbnFFKOTOUoxJhzshUyLjg94RejKx/6Vxq7m9c?=
 =?iso-8859-1?Q?Qve/on5dr2pBV7LOQS7uEh7iVZDr7pjS5Ir55g1mqogNr8N18YiJJuBGyv?=
 =?iso-8859-1?Q?N1otZ+kxSAyALcuUlL4pI/1+OnnmaQOKhFZzO2hco4eEt5kv2Ovzp+aiQP?=
 =?iso-8859-1?Q?yuF6W8JaYTFqQR9eioFmrXj38U/C6pKdp9ecrJ/R+zkyZpukFDE0XiqzTv?=
 =?iso-8859-1?Q?b9rwgPhU1cEXItRxit0cmB1OtQB0U3HLoxpetOpRsZuQeJMc8Ntwyu0Swx?=
 =?iso-8859-1?Q?EsjwAOFog0+JOTCmhP44Izs0FTrVJnbTymelkJbBAb47GV1vw4sysKTY0a?=
 =?iso-8859-1?Q?GUPgpdZtJcdg/4kYw5xTppwdz+m8IdEAEonmrGDFHcUeFkttDdwXWeBXIC?=
 =?iso-8859-1?Q?39oOQYo8qwJ7JMsoSwuAiTQGm6I0Q1aUTHhkQokRMzkK5k8Ir92JmwKaR1?=
 =?iso-8859-1?Q?rpEKFSVj8UkBqLodfExLMv/q33jrVK/XdJgAFq0/2I6CtgU0IHXhqIGdiC?=
 =?iso-8859-1?Q?Cz5IUHcyw0QjAk1spzB/8a0sJ8kVEGdDO+LzyHGV8lG9Ba/jHueKB32/7l?=
 =?iso-8859-1?Q?X/NpPhvrPF5pOcoSeFX9tcUqB/1i14f5HnzGTFMgnrDlCSlOcvEVOyWo2Q?=
 =?iso-8859-1?Q?2cRLrfocMkO96M5jQ2wtwrIqq0ViEnLD3ETG12sQlMaV59+MOMdZqq0StU?=
 =?iso-8859-1?Q?7ARzPcNJIOz1+9L3rMeN1INHlLUJHh85vmnlWsC6UsB7cacuKqzS/YeUsV?=
 =?iso-8859-1?Q?dEuUZW+Nqmj5eslu0UHiCT93XJ9hGfjXThWphbAZXM3/2YSLRYpmDZgHZJ?=
 =?iso-8859-1?Q?XwHDJWO+g68VbsDSIeZ5IylA6lQ1/PTYcVlgRyi/BHywluKFPJEYOhm2Xn?=
 =?iso-8859-1?Q?y1Y9YCictYS7aFmVQrC/cUaTSkOmh0OlDIWSxF/mhkKUibZGRjBMLAxcNg?=
 =?iso-8859-1?Q?uxtOS0OWqdzREA57h2uXIsYmD388r4eBldtC5DTo2KIU3FVZaacnobVm9P?=
 =?iso-8859-1?Q?CYdq+c9TshYpZPFbW9UIHHjy2WsBQNXQCGMcemeYYqZs2iMJ0vaakIjUZy?=
 =?iso-8859-1?Q?rHusbBYSxCZZe664X3eQcpQIZsddWtGzN6YbFkFQmoQ01rpUVmonTupNOT?=
 =?iso-8859-1?Q?HCAmwGm3vw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3165ef0b-88bf-459c-9793-08decde3c635
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 09:18:49.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGYN5FUOu+Sx/VpgCkW053k6EUGIbFU6oqmERAt8N7dXBQS48oVK1FSuGEwROs2VBX2NSb7ELGQopiSXQCvXJ82XhcyOPXO3/cw9jIoWAcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5014
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300662-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFDCD6A4ED4

Hello Nicolai,=0A=
=0A=
my first opservation is that calling lan78xx_write_vlan_table()=0A=
at the end lan78xx_start_rx_path() fixes the problem. I was able=0A=
to do over 200 connect/disconnects without any problem.=0A=
=0A=
On 19.6.2026 10:30, Nicolai Buchwitz wrote:=0A=
> [...]=0A=
> =0A=
> Can you please try with the following changes to lan78xx_mac_reset()?=0A=
> =0A=
>         ret =3D lan78xx_stop_rx_path(dev);=0A=
>         if (ret < 0)=0A=
>                 goto link_down_fail;=0A=
> =0A=
> -       /* MAC reset seems to not affect MAC configuration, no idea if it=
 is=0A=
> -        * really needed, but it was done in previous driver version. So,=
=0A=
> leave=0A=
> -        * it here.=0A=
> -        */=0A=
> -       ret =3D lan78xx_mac_reset(dev);=0A=
> -       if (ret < 0)=0A=
> -               goto link_down_fail;=0A=
> -=0A=
>         return;=0A=
=0A=
Actually with removing the the call to lan78xx_mac_reset()=0A=
in lan78xx_mac_link_down() problem still persists.=0A=
(Note: lan78xx_mac_reset() will never be called then!)=0A=
=0A=
See over here:=0A=
=0A=
[Fri Jun 19 11:06:37 2026] Connect LAN Cable=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:38 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:41 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 11:06:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 11:06:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 11:06:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 11:06:42 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:42 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 11:06:42 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 11:06:42 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 11:06:43 2026] Connect LAN Cable=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:45 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 11:06:46 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 11:06:47 2026] Connect LAN Cable=0A=
[Fri Jun 19 11:06:47 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:47 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:47 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:47 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 11:06:47 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 11:06:47 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:47 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 11:06:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 11:06:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:49 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 11:06:50 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 11:06:52 2026] Connect LAN Cable=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:54 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 11:06:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 11:06:56 2026] Connect LAN Cable=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x00 - ERROR=0A=
[Fri Jun 19 11:06:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
=0A=
Best Regards,=0A=
=0A=
   Sven=

