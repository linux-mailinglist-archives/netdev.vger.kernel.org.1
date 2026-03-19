Return-Path: <netdev+bounces-269290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL5hGKlvu2mjkAIAu9opvQ
	(envelope-from <netdev+bounces-269290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:38:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3F2C59B3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66E3630D22AF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B42D0C9C;
	Thu, 19 Mar 2026 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLhwJ9mf"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820B1DD889;
	Thu, 19 Mar 2026 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891321; cv=fail; b=e06M69ZKjCQIEOEHAuF/mopVSr5JQkeIRYiubseYQdLEDDQKTS3NsMzbGegGL15dFD5hi6WKBuwVEaUKrXD4o7vTAEVm6PPGwk4BL3cQGYoWo0QUYxzo13C68jXsvFhdruilZNUwMVVAWQcfdxjtHMy5dSoqT0rh7/U4q0aUxg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891321; c=relaxed/simple;
	bh=FF8+6fMjaQsprjBLXAxGFwfnpVlTKhxm50ku+eTDBWs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJPhVt+ZIUnODJUWvjR1/y97f1A2F1bav6xBZUV62riU+M8qZoTPUPR/CGwvNzb4wdsQOEI9VOS8u/Pm+Q4X8xIa6JMEH4UcprpsR067gjhuVNeFskj+bsMaGPfRXrTQrft8CoaHtFX81MLEI+PtqiF93758rRRTjbJz6Vtc5OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aLhwJ9mf; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0GO6IoUi6OX5hIBpdmxenbEElLpgGsya/I3No8nGL+YCQ49kCDALyWRU/A/yLgK7D1larpCp9J7FL/HzrMt0RzxhOwLDOAdrmDAvdif4U2PzOWkuYI5BDmG0aVfIVElH4WBPn1UtrMt/y0dPlOENrL9mDYZpqINddtX3Qb4mKocs8sX9eBCbwxI1ouaZkzYDuY0F7cNKmfn8BD+ZmF9nqcSXvQu4u8QaMQW78meBTA9r6R9s60HdL8NDgDNFe0XW2qqIKvpIFWvZK0Mc38NsIVvECV1JHWFHxR1H7DICN5bDRLJ2Mh3Ghezj8SMAvHfHloIuFBjxRlHmsNfP7WR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIvkSZ3zA9s62jK0sjWWLOuYXLSPx67+u08zOC73/GA=;
 b=YIbeGrQKTYEmmyXIKsPmtkrgmtSoPsxMRU7YAtIo48GgQ9f/785ZIvrAz8ZyK1qtNo13R9mSkSG2JcxJCkh8ryBISuuIpj82b5WUbkAR3hz3p98FEmOYKph/s7GIi6wZe2WhWFK73M+GIMnBEX3J2Sy6sFoRl3rVTaPtA24/EByS6L/Xyc54cWHfI1V+Mgi7R9teOfoyNGJXD0dP2rqTNj3J1IDyvwIPH/1NpfwjltKrFSxmqA+TxFVeX2nizk1vSFot81fnrY9M2DAbJKH/57b15ZXPladDY7IQsPxWfrSBxRgihcmPDqV3VXmrwWA6SUb6zoBUAhZwYle7VL6Jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIvkSZ3zA9s62jK0sjWWLOuYXLSPx67+u08zOC73/GA=;
 b=aLhwJ9mfowONgaFbsOmdXjmyImRrsx4WzHIdvYqpSuMv7rUWO/6b8jEOpKsAlS6YULNXjDEhmT1pH0rucTFDmUrsyT61GNFwtKg6Jrpobf3a7TRShz8PhxlTxxAJCPm73uoFOsLvcMXJ9s5BsQ5v1BAUXTif9xAMJYRHI2r3Sbkxt24GEh15ayLfu/EsoGO0kGvYxl+eRvuqx3VLp7R7Zr7pht8EwWdKxBxwrXQJFSTxF0c7HOIGJZvh2l2otoFiEK/7oDi6v/NM1cZvupz9bdCwBkeTqJdx5e2IJS1guJfTP4ZB/GzDzDOSzINJq+lCvpJpu/KbOnVGon1mTm1mmw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8140.eurprd04.prod.outlook.com (2603:10a6:10:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 03:35:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 03:35:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Buday Csaba <buday.csaba@prolan.hu>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, =?iso-8859-1?Q?Cs=F3k=E1s=2C_Bence?=
	<csokas.bence@prolan.hu>, Frank Li <frank.li@nxp.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Topic: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Index: AQHctu/GZE92suzIgk2+bQlhrX9NVLW1Lrng
Date: Thu, 19 Mar 2026 03:35:12 +0000
Message-ID:
 <PAXPR04MB8510E8145481F667DD769F23884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
In-Reply-To:
 <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8140:EE_
x-ms-office365-filtering-correlation-id: 31618092-1e3d-4710-7ea7-08de85688719
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700021|18002099003|921020|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Llfm2OnOpoeIZEbUjZif/qiTix2ZXloK6RuXwjRWng3zu8EAlNS1hatA8l2EKWu3TfWc9xpvi7B+Y5LfG5wiRe42Y3z/YO5o7I/sv+US675+KlaPAd/9WdglWsXYLQPgy7DvtUWQsrmSKVVSFAtgtogZO5N/QwWF+cYQkai8kODjIXOcrew/dPGY0athmKVUm2F6c5tn6IDk3AoUfXPxen+TPdlMhEwnRSLHO2EAJmwn5rB17xbTGsyy8TGoSoBt18pKxiQpZbApElZ09KekSqxw4UWpdbpu8VItK5NPqNB/hW1TbSUF653xxekHw9ZUXRHSXQtTzkiRiVNh11l1LGPblLWMk8cwpIruol7HVAWZCJ29Lh7E+IG10ocZ6Ig4m3lmY70xgCYhfJAsChxaXsG5LHDtV4HeIseH4fVyuMQ95OYF/+UQNqaGdwCKt4EC5cyUHXczIpN8oigp36r/+OLIMwYxsVwKYRj01upT/l5TxJSHM3oAPsYOJlR3Q/HTqOYVEB1iYqKf+4bYI4O7+mIZQcMbhYOZeuV+NyUTwQF4gYM2Lz1WFfBKhnNrnxHdOq3wentTqhdqB9DB2FYKs7vWL/eszgWCHgV3UOi9xVRPLQbmqsL7OJ5+IzGCBuFPyjoB8zwLJkNEDVnZroQXt5r0eoa4Be/gfEop3G7BZxEWWYVOBuX3aSIJ8v8g4ie4O3UvTcxVaG8V8M8G+QIczmvstf6GjS6v5Dr2HVHFqI93vC9XBZUCTnEwA818O6CcUFDjLqGcqkIsv5lQpeAgwF48/59MxogasHEVev+XeF1GKRz4AlnVpzQsVzNVytTP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700021)(18002099003)(921020)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vCclr0927FTIODHoVO+N25/yRpsH73WWspquuKv6iT9gdyhCv1KalUTPix?=
 =?iso-8859-1?Q?+g+PHtAJU9rrNGCLxlS9KXwy4I+ToHZIwWmHgFIhqoWcqgAQWM82SlnndE?=
 =?iso-8859-1?Q?BJYlScpb06pkYF79ItLfUpl7MkfbPOl9NF9RnGNKWtvnhKyUFnme4E5mv4?=
 =?iso-8859-1?Q?tb87umwk/oFrX2CPZMraZ3aAhaKg36WN7JJvJRZVwBhWo+HWb8dzeVpP2C?=
 =?iso-8859-1?Q?I1HQcSdgO6wbi7uYT63u9sZtRodNACUuFFa602zjOfbVJjAnnIwUJGhWJU?=
 =?iso-8859-1?Q?K+kOpwahk8145PPEHqrNV8IcchCyasgg+E9gVY2s+JRkwHFh+Y71yva9mH?=
 =?iso-8859-1?Q?HoRm09uk0x1uNboMNUA+qGLICDx5H00p+cqU1/JA7o+YHrhOwdN4QfHdpm?=
 =?iso-8859-1?Q?MMROVXTGgqhRjB4YFhkCT383Z+AMYMup7hTylKNnOAhTCEcWPvwzy8rtbB?=
 =?iso-8859-1?Q?UqCMQTQUFsdRi77HLpDV8jKWn85PdWR4/g6fUjsPf6oStGjlteVXWf3UUY?=
 =?iso-8859-1?Q?dKx4XWiEq+ahU1sbTRYVgU1dL0TG97RYaBrNQmeURBF+NmW9Gb7PEe6FHj?=
 =?iso-8859-1?Q?THOlQzXv4qRNV0ZrMoLqmMkNK8Ez4stjfEgtKuCqnj7mxf3Dnn079MgATF?=
 =?iso-8859-1?Q?nEarjvOmmYQqnbDiyFRXKtTa4yfvcmrZiMvWQ+q9QZBoCsk68H3XL8L5Te?=
 =?iso-8859-1?Q?wjA7EI5nheVbY9ADxgZvnpnZDwd6ZF/hZveMwURXelipSiIBGwrOcCCoUC?=
 =?iso-8859-1?Q?NIwrB32E8YB8ihjiox/pfCIhcMcFJOpf4gJOumyv7L1Sr+ot++2uwSZMJP?=
 =?iso-8859-1?Q?zmCBKOZCCcb5dFHCGQ98pJUiktmD3VAjIQX6yuBW0qgRnPfYMVCzYAtx4V?=
 =?iso-8859-1?Q?P4l7rJ5v+YKWQQTsiVkhdiulvUFyRnoRRg2utCAGmSalxx1e9IOQbKK2Hm?=
 =?iso-8859-1?Q?j/6GTsu6fMh/mBy4EEUtvRqkmAue/uoaL9ViPNVWoY1YRJl9RJhYUCjYF4?=
 =?iso-8859-1?Q?+uHWB1GLGjgKRZ2SEKi6Rf6AjDZ48WH6JAESqvumLB74r7B1weBbXze169?=
 =?iso-8859-1?Q?KtFMXnNRNCeQqR6tdrxqsHK/38vO+3c85R8J6oyxl1HqXV+HhmX/m8ClE6?=
 =?iso-8859-1?Q?lY+SIrFMwI7K7qcCywIsRhK0mOpBRj1SYxUHJXHcqMPE4KE8yMhdarbQyD?=
 =?iso-8859-1?Q?CmAUiWfUnU09ZGQsDLp7FDnDU/vShzscy0WT1pa+Ve2QRXFS+A63O0xTFK?=
 =?iso-8859-1?Q?IBmIw1evOmsRVTiJ8b9HutF5oyJMx106ugT4v3wIk6KuA8JqvnRPC9lgWI?=
 =?iso-8859-1?Q?glHMhh5avb0z953DgPvOwDL0BlSV/jE9bQU8TH6M1/sjs9LVg3g67vhnet?=
 =?iso-8859-1?Q?BpQuVg1FR604eo+gXk0VfzwuoNKHAaQYCGyJ07AxNIywFmUOHT8zMXSIoM?=
 =?iso-8859-1?Q?m8HoljQN95NrSfqyatJ1/iRizY7Vbr6NRLuyBVmX+fY2UNCMgTwXVKjHF8?=
 =?iso-8859-1?Q?7BMtRJhtaUCPj8izkaLEIZuBhNi+YGWQSEX9pI4YB1mDqZo8Z3eF6xTh1o?=
 =?iso-8859-1?Q?Sxd121Nile+qpT0QBxrtf09acAPL/47dXCvfkDsxJgVVMn+3+rgqjzZGYP?=
 =?iso-8859-1?Q?3LgRnCAdOvqwpTdfSdzbIHFLP2UmA3d0bgq7pCn2pT/O/dzzqEUlJ/IeQL?=
 =?iso-8859-1?Q?YSlpf3W90h/aBl/y5jB1qaDYNKDGT9OX7QYHHU7liXxc1UZeYw6oqWsq/O?=
 =?iso-8859-1?Q?7nL8QiETgIwlqS4h8Wo10JDXmeTi+WIPYky8/vFOf6Lbw2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31618092-1e3d-4710-7ea7-08de85688719
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:35:12.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZEdj0tZ08KP6fVEqtXW40nK6P4Z5TKCDtnPf9243Ejqi4KV/M0FSqmW8k//tOf8k9Y9tAxj0hIdAoZnc28I1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8140
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269290-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[prolan.hu,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,toradex.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.974];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,prolan.hu:email,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: B8B3F2C59B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Fixes: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")
>=20
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> b/drivers/net/ethernet/freescale/fec_ptp.c
> index 7f6b574320716..c1af81002b8fa 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -534,7 +534,7 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
>  		if (rq->perout.flags)
>  			return -EOPNOTSUPP;
>=20
> -		if (rq->perout.index !=3D fep->pps_channel)
> +		if (rq->perout.index !=3D 0)
>  			return -EOPNOTSUPP;
>=20
>  		period.tv_sec =3D rq->perout.period.sec;
> --
> 2.39.5
>=20

I think the correct fix should update the n_per_out value like below.

@@ -756,7 +756,7 @@ void fec_ptp_init(struct platform_device *pdev, int irq=
_idx)
        fep->ptp_caps.max_adj =3D 250000000;
        fep->ptp_caps.n_alarm =3D 0;
        fep->ptp_caps.n_ext_ts =3D 0;
-       fep->ptp_caps.n_per_out =3D 1;
+       fep->ptp_caps.n_per_out =3D 4;

The commit 566c2d83887f ("net: fec: make PPS channel configurable") added
the property "fsl,pps-channel" to indicate which pulse channel is available=
. So
we should not fix the pulse output channel to 0.


