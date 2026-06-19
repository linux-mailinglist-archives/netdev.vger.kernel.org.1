Return-Path: <netdev+bounces-300648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dPFOJbD5NGpMlgYAu9opvQ
	(envelope-from <netdev+bounces-300648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:11:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9836A4886
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schleissheimer.onmicrosoft.com header.s=selector1-schleissheimer-onmicrosoft-com header.b="Pw/ADzf5";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300648-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300648-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=schleissheimer.de (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E6C3024A18
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409135C1B0;
	Fri, 19 Jun 2026 08:11:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020075.outbound.protection.outlook.com [52.101.169.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67535AC2C;
	Fri, 19 Jun 2026 08:11:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856676; cv=fail; b=Kcus1TLWrUrdt47ZEcO6nMgrwqXln+0GBuhjLPDb9ckHhVyT26TCA0JseBpYH7S3DvJajLdTxVzYhLyA6HT4r5UNKReIqfgnjahgNPi4cbFqLOywVLjt+1/UEA/wK0hdwuz7f0pP72gCeAZSfJEHacPHV8/PFyxy5M4HXQR+euU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856676; c=relaxed/simple;
	bh=5lE8TeIHXDD/CLTlh9CqzPu7JcUpIg00DviePSbxGwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFNw3QT/fMb3orWz6sK9m/zIxzSEQ21mKzGJR02tpuXhlwG0k5LglQyrGOulIYFPu+HzXNZW+8cUYKOiUwWV8Ed+MOQzhwr1a1kQnSCdgMiGaKu4598cQaPDuB0AETsYvA1Jy71ScwyffIVuWD/k9i7UwTc6VgQaAioEm12ms+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=Pw/ADzf5; arc=fail smtp.client-ip=52.101.169.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhDhdU79EuXYjWdgmrlSe+aaqkb+delZoDhqtxqbsJnZ+OFLNIHdzO5egKn1oiITNM+QPtCQxlpFq5Q/Xdm2yA7nbLa2u6xDPpXM3QzlilU+FYLJ111RScFdXwPFDZ5LmkjleQj2EjtW34enqAAJNfO8NOWWI2baAvX4trc/HeTwt2RqGbLAbMvKFN6wk4sBlFluzvXlOUJbWLVXj8n60QS2CDsC55C4g0LMxtB3bAaIZj4AaoZq1KLc1nzZ7kz+tGI2TgzcN4idG+mlUUWZouPnAUIK98N7Krs783tEZR2GDvZfa9728w3bEwUNdCIh9TECcAsyimwGW2Bl0fKZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdxdyZoAM5lyLkudNU3MQo7sQeldu5t7eYbcT1vDZVg=;
 b=EdgmvT5msSKLzCIkWjqf7P/Rkctncu+1ovHL1Nf2+XPFGROUkfZ1h7xOYAdB/6hk1h4e4iFnfI7aVUj6jUkL1jOZEwrKySlc5Z1G9mKo0dVshjqPMBFkxMjTvbVVekYO3JIYkBRj/wtHvM4xv5wLdI465HYD1wqENS6ujd24IU1GYaxSEvJS5rwy86d0DVZNa6BICcbaBtSPvxlc9+mA5aDv8mvhnNz1LByWIs9Oo7Wf0r7jlha1TmJyzo74tOvCC8Apjkb27JSDeARQqKec3wUlwom2ihvMWJVV+kU3ycCQHC62l+9ctlis1Y7O9x17r6fKOntNrJE/T/nDbx/LKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdxdyZoAM5lyLkudNU3MQo7sQeldu5t7eYbcT1vDZVg=;
 b=Pw/ADzf5zS6jxTCOfBVk4+H2LoH5kPiZYdMsCuhm+ExPGA82/47n0YCk6pWoVglrm9xcUS2Ow212i3ix+oqxGstDcKXE8BLCVmzUOjvdgT+F6H9c4Mnzt8HMBfKlNxcM1js2rO7PvA9kSS0HkE768qW3OZWK62N92NwxiecTxWE=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR2P281MB1429.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 08:11:06 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 08:11:06 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Nicolai Buchwitz <nb@tipi-net.de>, Thangaraj Samynathan
	<Thangaraj.S@microchip.com>, Rengarajan Sundararajan
	<Rengarajan.S@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "Woojung.Huh@microchip.com"
	<Woojung.Huh@microchip.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter table after
 device reset
Thread-Topic: [PATCH net] net: usb: lan78xx: restore VLAN filter table after
 device reset
Thread-Index: AQHc/1ZL+dYj4wyIHkavMkZrzwxM9bZFg8XY
Date: Fri, 19 Jun 2026 08:11:06 +0000
Message-ID:
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
In-Reply-To: <20260618191109.4086598-1-nb@tipi-net.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR2P281MB1429:EE_
x-ms-office365-filtering-correlation-id: bb2dd9c2-7af7-4b97-3e95-08decdda503b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|3023799007|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 c3OkYSw3KjT4JJ+ROy9JUct67iBSpZeqdOC1r2DQLXvWl9vXqompdU5Ci26pR+U6JbTj64ky37ZR5tA56Ea2Mhou4ap+I1lRthY1YbcBtHmymcEQOzrly50m49EKIhTd47cZLPC+l7HluyLGjEX1ZkMFd++FiOYQIZMNVp0EMHwpvYtG9IuPEtQuZd9bOK1lQxW7NAHNc9wXs5jKPcXvobV9bAENJllaOtllgGGESo+sloIC4k88dyJuAaWSQNJFhAf9JclDl3cAAWMfnRZjrYJGGc08cod33n+sf6/toBXRFDnUbnmdWyr6Oe9yNMqUkZyEZqX8jm6W3VUFGt6aWfi0ov85dBor7A557neVNnqasNBa+GDivsavLvnfTKOD5Sopq0mY1o0sDWWIGWi+ECpPg15O9lvGTbqUt868FJWF09BnYtL20qHsd3cB9aPrvEj02TBGdM4yB8spoyqZ68FFJ97ZwjRGxuW/GFFG4+jK/gQ1wXvNkRAB1VE4PsOujdigsMEFyprRTLOQV+IDK2+Ufdwo6vbAOmy1o9cIL/bUMH4MjIsIbPsiC9ccLk8InFTH705fGUzb51xz4VhK8XbEzMm3WPU+tsGQaS8v7eyfoxhG0NHSkiaLdt6nKGz3DQwaT7P+4uNBkB0kUWFKBcl7GFqunDtPv5wskdowglI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(3023799007)(56012099006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+hqA25fGUdf83knpstH1LicAlEHEWITtAJA+BANtsqBGLs1jIZtJxu/+pz?=
 =?iso-8859-1?Q?X2QBn+sw4Jfq8HelWXDe7AmIFiaR+YQBKsSxpiow3IbBWDITop/eneWLcr?=
 =?iso-8859-1?Q?GmgVfkKH07xkUsCt7NFLOD4CWBp4cedgRuL0pzLEth+Jf5RTqjf5f02VTq?=
 =?iso-8859-1?Q?1kg9kLRj5m1Q/6NEedF9Uanrnhr5+ywFp4muknLntAJVn2YVGJtuTIzjIa?=
 =?iso-8859-1?Q?tW6E8MB39AR/+Yp/hXE56IYTuBuvtFAAm9sODd9/L2zBC/yC7+Y+KqeDaq?=
 =?iso-8859-1?Q?+DZsWpV0X49HkMTZyx20Wm+y2rRDqAqWqz8yb568HscNNiaZ4lGi6VoK9d?=
 =?iso-8859-1?Q?e8LIsYmFeiDVuvNIiXpUOsk9RxKz3m3UuoG5K9ZMDLsnU3Nn8XRemZa18E?=
 =?iso-8859-1?Q?0b4CNco4K/cos0kojExbjcCwudydFiulB4xiW9evtkRBxkEcbDpYGG+AEe?=
 =?iso-8859-1?Q?fK0GFQeucsHH4re6BMRrNo292wl+96Cr6ARlOPbgfwYKum3OsMjZOD5new?=
 =?iso-8859-1?Q?iNufY/3dbxjkJvjbcZTfhyOC7bQSrHU/l7Di7J6+0Y4jOIB8wpqjn6R4J4?=
 =?iso-8859-1?Q?D+cSAmkkSXNGPhuGTyMWUs0SlGABuO4OOM6JH/QeGUSwseTJoBiR4WceRi?=
 =?iso-8859-1?Q?8kXXBn/S7r+xsDSPV2dJ8qL4mNT+lMdDOjeY3pfs9sf+D61YDaiVi1Jjdd?=
 =?iso-8859-1?Q?KdCOhHTiboBAij742HSXtSWi2zXce7++mwf9Zo6fEXceFKmGkzYxHlMtYP?=
 =?iso-8859-1?Q?jiCAAcvp27R5qH73v6jjcLZsJoiooJZUaX9sKqIn+oCKdDaY6AfKs+cEkA?=
 =?iso-8859-1?Q?lTplkTGi7f7M8EqmxZArMIIx+9ffQzbLeHVKVaqK0xutpKGA+qORdyEJ82?=
 =?iso-8859-1?Q?UWdbEPZ/5z2BRj9CQfmMcr09jf0ZiuxVpR/hyYT/tL3W4O4fdxAIs5Ghk0?=
 =?iso-8859-1?Q?FUhYqtBqxKfD+GfdspHieSLDbADkh8c3b1t8bjteNTlpHRNJZiBAtCmQ8C?=
 =?iso-8859-1?Q?MVVZZzFEaGSKXRnNSFpijgUqV3h7THrWETrBdvMlqjwZTwKgCBNTwlApyy?=
 =?iso-8859-1?Q?dgGGFpqcLjSud0d6sprLiLSSMew5zW18pSaC0JC+wVLHC5JTvbQYOmJj6G?=
 =?iso-8859-1?Q?ORHva/wYP2ghM4KxiqmqOD0nGpbGdrdTzjVppaPfR3V7ZbSJWKqg2lliSM?=
 =?iso-8859-1?Q?+zgvOdh19vr76L69SG7rcJ/nxifrZ7Ot0f4Sq1cPzaiA2KZoAJ7DgJRa7C?=
 =?iso-8859-1?Q?o2++YARmgOR8xpOxS4qne+rFe9vjqekRF6zBEWcJrgFz3tDBrh4y51fq+E?=
 =?iso-8859-1?Q?YP27lLU7ev5zlbe8KXnh6u7OCL7cbtiQiwrKD/era5EstR+tHhd+6mTQCM?=
 =?iso-8859-1?Q?n1zRAcmw+lHYF2WDNFMque+hwvke9h+uyP384T+FtmBZgdFHKhrt3oXyDq?=
 =?iso-8859-1?Q?PrrU8KkBWGsu4a7e36rNpxz3AqyMkTUGZLvsWGUlTS3bcz/JmV3uMDh3jw?=
 =?iso-8859-1?Q?8GvI4OiBE8hqN8oNN8GEKx6ylTlc37pKpNKXoKHxcqUowzPk4Z3tW2ySqz?=
 =?iso-8859-1?Q?yov9/3Lgn2hnUHMsG/iikbR/+T9NLoWyyhQdtd/FBB3DwP1hsY47s27FCP?=
 =?iso-8859-1?Q?J87Fx+Wvn4dxaOUYZCBQnLvq63j56VpPXEDjApkajeqE5VlGFhqeapTG3J?=
 =?iso-8859-1?Q?ivxITnxxfuH4C87hcq+LJ66OO/+t9v9pN/Imxymo3gqtTPu+EH+PQbsocS?=
 =?iso-8859-1?Q?XR940tntcCpC+6Q3S7bA8gBSiObloJP8dR89gUvN3v0lkNHBmOyyVRfngw?=
 =?iso-8859-1?Q?UdWpYoZtdw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2dd9c2-7af7-4b97-3e95-08decdda503b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 08:11:06.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbKW1PnsZjiy+MZYoiVtPPRha0WZeGSr0MyFqL6REruEGn5oH0V0NDZlVKLabQeFrXnLXHUAFQGpoAGlE+3QIZOlDeyD+rWnhCKRkiZ+OBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1429
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
	TAGGED_FROM(0.00)[bounces-300648-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,tipi-net.de:email,schleissheimer.onmicrosoft.com:dkim,schleissheimer.de:from_mime,schleissheimer.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD9836A4886

Hello Nicolai,=0A=
thank you for the quick response and the quick patch!=0A=
=0A=
But actually it is not working for me... If I disconnect and connect=0A=
the LAN Cable (I have setup an automated test already with two adapters=0A=
connected to my RaspberryPi CM5) the lan78xx_reset() function is not called=
.=0A=
=0A=
Here is a dmesg output from my test.=0A=
I defined DEBUG at the beginning of the driver and added=0A=
netdev_info(dev->net, "function()"); to nearly every function=0A=
in the driver. Also I added my a VLAN compare function:=0A=
=0A=
static void lan78xx_check_vlan_table(struct net_device *netdev)=0A=
{=0A=
	struct lan78xx_net *dev =3D netdev_priv(netdev);=0A=
	struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)(dev->data[0]);=0A=
=0A=
	for (int i =3D 0; i < 1; i++) {=0A=
		u32 buf;=0A=
		lan78xx_dataport_read(dev, DP_SEL_RSEL_VLAN_DA_, i, 1, &buf);=0A=
		if (pdata->vlan_table[i] !=3D buf) =0A=
			netdev_err(dev->net, "VLAN TABLE %d: 0x%02x 0x%02x - ERROR", i, pdata->v=
lan_table[i], buf);=0A=
		else=0A=
			netdev_info(dev->net, "VLAN TABLE %d: 0x%02x 0x%02x - Ok", i, pdata->vla=
n_table[i], buf);=0A=
	}=0A=
}=0A=
=0A=
I call this at the end of lan78xx_start_rx_path() and lan78xx_mac_link_up()=
.=0A=
I now I get this output. The output ends after 16 disconnects and connects.=
=0A=
Then it is broken. What I am wondering is what is happening after =0A=
lan78xx_start_rx_path() that destroys the table...=0A=
=0A=
[Fri Jun 19 09:40:25 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:40:27 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:40:27 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:40:29 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:40:29 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:40:31 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x00 - ERROR=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x00 - ERROR=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:40:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_terminat=
e_urbs()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: configuring for =
phy/rgmii-id link mode=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_conf=
ig()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:01 2026] 8021q: adding VLAN 0 to HW filter on device 100B=
ASE-T1-1=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
01 0x01 - Ok=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
01 0x01 - Ok=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:01 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_terminat=
e_urbs()=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: configuring for =
phy/rgmii-id link mode=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_conf=
ig()=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:02 2026] 8021q: adding VLAN 0 to HW filter on device 100B=
ASE-T1-2=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
01 0x01 - Ok=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
01 0x01 - Ok=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:02 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_terminat=
e_urbs()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: configuring for =
phy/rgmii-id link mode=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_conf=
ig()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] 8021q: adding VLAN 0 to HW filter on device 100B=
ASE-T1-1=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_terminat=
e_urbs()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: configuring for =
phy/rgmii-id link mode=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_conf=
ig()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] 8021q: adding VLAN 0 to HW filter on device 100B=
ASE-T1-2=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_write_vl=
an_table()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:03 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: receive multicas=
t hash filter=0A=
[Fri Jun 19 09:43:04 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: deferred multica=
st write 0x00007ca2=0A=
[Fri Jun 19 09:43:06 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:08 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:09 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:11 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:11 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:13 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:14 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:15 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:15 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:17 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:18 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:19 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:19 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:20 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:21 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:22 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:24 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:24 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:26 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:26 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:28 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:28 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:30 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:31 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:32 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:32 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:34 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:35 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:36 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:37 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:38 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:39 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:41 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:41 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:43 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:43 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:45 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:45 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:47 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:48 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:49 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:49 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:51 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:52 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:53 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:54 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:56 2026] Disconnect LAN Cable=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop tx path=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: stop rx path=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Down=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_down()=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop tx path=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: stop rx path=0A=
[Fri Jun 19 09:43:56 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Down=0A=
[Fri Jun 19 09:43:58 2026] Connect LAN Cable=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start tx path=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: start rx path=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: VLAN TABLE 0: 0x=
05 0x05 - Ok=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.2:1.0 100BASE-T1-2: Link is Up - 100=
Mbps/Full - flow control off=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_mac_link=
_up()=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_flowcontrol()=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: lan78xx_configur=
e_usb()=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start tx path=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: start rx path=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x00 - ERROR=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: VLAN TABLE 0: 0x=
05 0x00 - ERROR=0A=
[Fri Jun 19 09:43:58 2026] lan78xx 1-1.1:1.0 100BASE-T1-1: Link is Up - 100=
Mbps/Full - flow control off=0A=
=0A=
=0A=
Regards,=0A=
=0A=
   Sven=0A=
=0A=
________________________________________=0A=
Von:=A0Nicolai Buchwitz <nb@tipi-net.de>=0A=
Gesendet:=A0Donnerstag, 18. Juni 2026 21:11=0A=
An:=A0Thangaraj Samynathan <Thangaraj.S@microchip.com>; Rengarajan Sundarar=
ajan <Rengarajan.S@microchip.com>; UNGLinuxDriver@microchip.com <UNGLinuxDr=
iver@microchip.com>; Woojung.Huh@microchip.com <Woojung.Huh@microchip.com>=
=0A=
Cc:=A0Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@davemlof=
t.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org=
>; Paolo Abeni <pabeni@redhat.com>; Sven Schuchmann <schuchmann@schleisshei=
mer.de>; netdev@vger.kernel.org <netdev@vger.kernel.org>; linux-usb@vger.ke=
rnel.org <linux-usb@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>; Nicolai Buchwitz <nb@tipi-net.de>=0A=
Betreff:=A0[PATCH net] net: usb: lan78xx: restore VLAN filter table after d=
evice reset=0A=
=0A=
=0A=
Configured VLANs stop receiving traffic after a USB autosuspend/resume=0A=
cycle, e.g. when a cable is unplugged long enough for the device to=0A=
suspend and then plugged back in. VLAN filtering stays enabled but all=0A=
VLAN-tagged frames are dropped until a VLAN is added or removed again.=0A=
=0A=
The reset on resume clears the hardware VLAN filter table, but unlike=0A=
the multicast and address filters it is never reprogrammed from the=0A=
driver's shadow copy, so it stays empty.=0A=
=0A=
Restore the VLAN filter table as part of the reset sequence.=0A=
=0A=
Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
Closes: https://lore.kernel.org/netdev/BEZP281MB224501E38B30BFDC4BD3D364D9E=
32@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM/T/#u=0A=
Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Eth=
ernet device driver")=0A=
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>=0A=
---=0A=
=A0drivers/net/usb/lan78xx.c | 21 ++++++++++++++++++---=0A=
=A01 file changed, 18 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c=0A=
index bcf293ea1bd3..52c76de64eb9 100644=0A=
--- a/drivers/net/usb/lan78xx.c=0A=
+++ b/drivers/net/usb/lan78xx.c=0A=
@@ -3065,14 +3065,20 @@ static int lan78xx_set_features(struct net_device *=
netdev,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_=
ctl);=0A=
=A0}=0A=
=A0=0A=
+static int lan78xx_write_vlan_table(struct lan78xx_net *dev)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)(=
dev->data[0]);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_=
, 0,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DP_SEL_VHF_VLAN_LEN, pdata->vlan_table=
);=0A=
+}=0A=
+=0A=
=A0static void lan78xx_deferred_vlan_write(struct work_struct *param)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct lan78xx_priv *pdata =3D=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 co=
ntainer_of(param, struct lan78xx_priv, set_vlan);=0A=
-=A0=A0=A0=A0=A0=A0 struct lan78xx_net *dev =3D pdata->dev;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, 0,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);=0A=
+=A0=A0=A0=A0=A0=A0 lan78xx_write_vlan_table(pdata->dev);=0A=
=A0}=0A=
=A0=0A=
=A0static int lan78xx_vlan_rx_add_vid(struct net_device *netdev,=0A=
@@ -3353,6 +3359,15 @@ static int lan78xx_reset(struct lan78xx_net *dev)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 lan78xx_set_multicast(dev->net);=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 /* The chip reset above also clears the VLAN filter tab=
le held in the=0A=
+=A0=A0=A0=A0=A0=A0=A0 * shared VLAN/DA hash RAM. The network stack does no=
t re-add VLANs=0A=
+=A0=A0=A0=A0=A0=A0=A0 * after a silent device reset (e.g. on reset_resume =
after USB=0A=
+=A0=A0=A0=A0=A0=A0=A0 * autosuspend), so restore the table from our shadow=
 copy here.=0A=
+=A0=A0=A0=A0=A0=A0=A0 */=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D lan78xx_write_vlan_table(dev);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* reset PHY */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D lan78xx_read_reg(dev, PMT_CTL, &buf);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
=0A=
base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823=0A=
--=0A=
2.53.0=0A=
=0A=

