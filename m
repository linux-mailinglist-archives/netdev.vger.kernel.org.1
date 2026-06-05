Return-Path: <netdev+bounces-295941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fagxNdwYI2pwiQEAu9opvQ
	(envelope-from <netdev+bounces-295941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7964AB46
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=v8DpqxNZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295941-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295941-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCCF33090A0E
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D23CBE7F;
	Fri,  5 Jun 2026 18:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5DD3C5539;
	Fri,  5 Jun 2026 18:34:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684496; cv=fail; b=qdctKk+jVWN4KuxBTm1ynObZyJG1wJCQ3xDSU6aaoz3Vnyx5gTSgT3klnuUE6LB1ROIO00a0JUelAShH7+H3yZVWg7KUA0qxVJhUj0/U8PL9FEhn8DbGrqsKux+BiM8BgzCYaSddOHorwwB5MMiJL7yzGIKqJcZinNz4lWTylQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684496; c=relaxed/simple;
	bh=huABNhzvD2fSVmUrPJNGWxVzX34AFSNklvIAhEGXH+Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KiwQnezDHokQj1ciurCl8ch26T/w0p1OY2+sG6FGBZ3b/qRyYPzHSeUeQT6Aueh6ea13j74e1SePGh+4uZux7+X5G/Ec3zQTaoXVt7FZrfGmwzKrxYjilbl6OhpKNy8nKLzOG0eSgbFZ2LlCJgc1BUub5vDZY+nmBTgaK3kDRyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v8DpqxNZ; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzAPS6+Pds9JjzkT7Mnyx5OOMtANmNk2Dxi92UIzf4gci7D/wlJHhXxb54UXAhjf/ehbp2BVPyn9Hfdj13/rBvlXgoRa7YbWSx9NwvnNiv85mDZMsJjx9GHE2xzP0G1kRjHWfUvapnQYW3C4dpgKxfqYR9MXyDJ5wJywOjnp8lARgZ7c4+CptCp0RZFA57aZwhPuYO+8KVFiEzz8c9BuHX6JQEMKz5JpYcdff2nX0vez9oeo6GNYQM45+6voD0qt15rQMtbPo4ZHFgPH+mwPSbTd0/cWd23GNIhiGwnS9ZwokxxVnw+aVzUo1rqqamZYyPOfZ31c1bR9i19SouA08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlr2uaCeuIXBRG3dkEPf77eIVpDeWAiB23ZLoDnR7Lg=;
 b=wCodl04khI48azmIvoPnK6/qrjA2+kCb8tQMaLots5EwFeNwMbuflfSXPlvjS/5TebbwFWIsMJTUZPrtXRiAtF6i3Ba+QEG/nzM07JXBRZqpFajLWUbNdBmUAbuhHcctJvZI2VAxEmuGTInCcD/TFmsjyA8z6CJxO664LJlFKJH+VU4fPVgabz3KRFomFnaJrKZOdGCzKecPp6CBygk0d9c9WimhOPrtKVg13H8nfDUOlMaDleAexprPESDMJBFjiu7YdTYqX3uohPwBUTJB0F3mqm8PhwRdDwS778avYGPhCS/7qv/stRWgHZ5aLZZLRJq9kfV3HmKdSYdr8MLeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlr2uaCeuIXBRG3dkEPf77eIVpDeWAiB23ZLoDnR7Lg=;
 b=v8DpqxNZNo75M+Jl6A8s3hE+I6GymOUlT8csnQTfeGKiSjizlxoc556qS4aSJwR0SzLCNgxau8fvODfxTNdbLTDxgY8E1HbuqejLjaD3FZ+HhL2FLUiiKX5aXAUn38K4Ufkf9khZMogQdtjIPPVmcD1r2UjD1P1lw0cbp6WHDVX+bmCCiIT8DQlVSn49o3YbED25sDLOUN40qRG6B3O+dZB1iSFOdvMxu8Si1pgg1PW4Mm0MILHdy3w8rHqOEW0q+8SEDUAd1RDE5wmUkKGRmcxAeVym5ZQf1Xc9gMxgU44u+vy0YbR403g32e/58w0L0s9dVCiBGNJJCu+p8pQgvQ==
Received: from CH3PR11MB7723.namprd11.prod.outlook.com (2603:10b6:610:127::21)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:34:49 +0000
Received: from CH3PR11MB7723.namprd11.prod.outlook.com
 ([fe80::f6b6:c66e:7e46:72b]) by CH3PR11MB7723.namprd11.prod.outlook.com
 ([fe80::f6b6:c66e:7e46:72b%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:34:49 +0000
From: <Jerry.Ray@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>, <Pier.Beruto@onsemi.com>,
	<Parthiban.Veerasooran@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Topic: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Index: AdzvmRIV9Yc6XZqaQq2ja4j42ca11AFgD4jQ
Date: Fri, 5 Jun 2026 18:34:49 +0000
Message-ID:
 <CH3PR11MB7723AA90B2FEDDCE9F70041CEF112@CH3PR11MB7723.namprd11.prod.outlook.com>
References:
 <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
In-Reply-To:
 <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7723:EE_|CH3PR11MB8344:EE_
x-ms-office365-filtering-correlation-id: 9f038a41-b181-4909-f0cb-08dec331200e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700021|22082099003|18002099003|3023799007|56012099006|11063799006;
x-microsoft-antispam-message-info:
 zxDxqAF2H1N2nyRsi0/fFlsltfLHxl/rvxym9ChKSqnO8yUAHqGOt0Za2ANYDuf/SRmHJIKtAW+22wPcGeTptFq2OsT+fR8N/7lyB8126YY6pxFkAcGvWvVUF/sxKR05QqrPYNOUQUCOcF1UsyjNXDzY0guyTREej1xYxAs+zrRDsXIXsjlE8sl0uNovogH3Yip+1yR+aTqj9BnrBKKCen3Bf0P2b/D3hkcFyfNt0HsNvgQl6vH5Wh50VU9r/MnwpmAW2DvaSWBn5Ewp1O9Am7NkPXhJVbermqY15g1cj+bQhsaiHhHmoSmkhJGbOkFm29ZeUwbkP0ehG4H5dnkJaAqTnuSRzGXSD5IcfjAMxudvsp6qAjhCKXrF4HfW4Z2SlsY+THclHKpd74nE1u5+Tt0d7hpN0c8ULuDzy0dEYLMiM3i1VDvPHiOO4gmtT7XALXMHXkA6dD6+lvxtUa+RZQVHTuc67aNLRrJXVuFKBzcyBeBPsCBk4a0QLraySZECbdK5780i1nEst+ASZPNmAEP9hUWD5C1dl5AuJVJoYVtTcRpN5hf09NZYpvHJ2VvOCjJFfWCfv+uh6Ixip4rDZXb+ceUk4Ijg7GnL91z/DLDwkG5URluI1Z+E4wb8f2ySA0mLrb5E03puc+MMUZyMhEfCFpyY0uGNSrfI+kJwMmo2I/ESYQx7tP1OhZK9KU5qC2VuyASaWVHPw5lf+GDTSBeCbN5dcoo9ue6l9fNtzmIKkJtGzeGVvo32utCuvqNkmJsoKwL9NGOLhUvoMR8cIA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7723.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hbceYrHBrJzKo3fHrsVhksRpFd6Y6+btMQe8+mlOJYk6QWAQj83SsXcMbB8C?=
 =?us-ascii?Q?z12mqSKrQhQPmE4v4oVlDbRlbhkeD9TppsHbudgCqSP9AvG6qWGbQhLrZ4wc?=
 =?us-ascii?Q?Qm12YY2wKzXwwI8yuK/vLYQl+PNhXJCww6cNI9dejhltDxLabVvZo4WvyIk+?=
 =?us-ascii?Q?Irixlk2cNhD74o5/fLYi0dI8cjKh62cekWfcqTLHmWFTz3qL/tuEeAIjrDIo?=
 =?us-ascii?Q?CDCexA9FhTa2acb6cCAM8fGNcrb9Y4841oJoqOxP1RvbmF3swb28AwOHIcSJ?=
 =?us-ascii?Q?VW2GygK576BrkpKFjDWeFDZZpIv3lskx6HYUou8Xyu7ZVX0hjcaXcGiMq/tw?=
 =?us-ascii?Q?82cKHkm/tjaldhh1C/kNWTuTIILSQ0vZqncq/Uh6SN6yWUH8I+RlbowFCBUY?=
 =?us-ascii?Q?UbB0G7gmxrY4egYH+wsVS2w+pOWsv8KKWGbCwisGHvjCl7PPR6BWVNdgP96W?=
 =?us-ascii?Q?qyKQrcFsdR15Pq5p4+wXDWljFEyegkFligDdPhZ33yPIFuCsr5fIXtlYW6yz?=
 =?us-ascii?Q?utd8BRjlRAr4zGrL/CqoAWOHNKsM75yIxrvhztsSt1WX9whwzz1sZZbp6l7r?=
 =?us-ascii?Q?5cZTitoIencYRdjDxEkYdlc6PxnnI7xasHxgV/7mbxMWeoKzSR2LUdJi/FLu?=
 =?us-ascii?Q?V8pUzeBXc78CFonqgo+1vhI40U38snrBRH880pZg9Oc+p8jw56ow6wGnyV5S?=
 =?us-ascii?Q?DFTcH64Z/8NMH3Uafnif2pwJslXIfchi6qctK0WutWRkP7bkqN+TIOWCIvWf?=
 =?us-ascii?Q?Psk2KjJpoUaMeaiGxchkkdlmFe1aEzLolSlFo9bba/0pHuTHRQ5Xa4xJlbPy?=
 =?us-ascii?Q?7WDAhYuN2zgWdau2/WmPUwmGuI8SKDCM32j2wHeUtzcr8B4UyT9XqndDUmQv?=
 =?us-ascii?Q?2V2VmQFqmYVWsxCQ2kLoqx047WH9fNLR6x+U9Cy7yti3c1MyUmvnFehCLCsi?=
 =?us-ascii?Q?D8JdFZusOIh6jOHn0dMEkXcGn13EGjOCIzayRKiw269q9axC1yWc/Nq/x0dx?=
 =?us-ascii?Q?x9rsedSTN04j8RuntH/2431Cor7cqV1VbNzpRWza2eNAHdSjkNzdVq9r+1YM?=
 =?us-ascii?Q?uJwjE06bstSr6TssrnpqnMB+UFmBYHhvkwfk8p12HO6YxBlzMuen+BqDzJpM?=
 =?us-ascii?Q?PIw/4fzgpGhZ0ESDjeQXEn85NqF+CmD7UnusaP2zRVjGo2CHkQD4DmBJlUUm?=
 =?us-ascii?Q?Jx/SsW4PpxtcpU2lEMPQlot7jji0aaBiIUQa3X8iTnzmnTlG7OT8e/V3od3C?=
 =?us-ascii?Q?m+ebm0o0TzrDKBLaBAY6gkP0gVyPcRbXAkPvoXTzB5NVuNEY8fon3LTkuwqW?=
 =?us-ascii?Q?96c9yoecbXkmPUdNVMk550sHSWJgGIw/qEfZCbvklZW7rqzIDVTMKv22FCVe?=
 =?us-ascii?Q?pafhoUKqnR4okuYbNRF6PdXsobP9P6wnp0XM3GV4NtNinHUVuHA0cCRKxfGY?=
 =?us-ascii?Q?5/dIzTRcTzgAWjhLCLdtiiowIRp0V16ZTBEQJ0vaRWbjNvZfsSu4+a/U8SXb?=
 =?us-ascii?Q?VmeP/FQ7FYmzGn4iyg/c/z3HybLSuBNs0EAXj5mxtLlVujfVkEdwOcab5F8n?=
 =?us-ascii?Q?N7WRaYZs3RIil2lJ0aISS+LLJ0l3WCyFdJUcWb8NEoefz0OBKx0wfQ5H6LmK?=
 =?us-ascii?Q?11OBIBBBJ+rzHM5zP49vM0lHZBxl4ysQUW+GaYQqufFgzvE2BDctYb+QDA7K?=
 =?us-ascii?Q?g+imLYwMtyb7oVzxzsRDBxS1udCgxSMK7q+jvk9yEv3wjLupYp5jHoc0OkSG?=
 =?us-ascii?Q?Hz66WID2gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7723.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f038a41-b181-4909-f0cb-08dec331200e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:34:49.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nadWup3dzJPKkeYOVaC3YJaLSFv2ufD1mM1ISrbCoC4SSbxOf9S5d1oCy8b4oEzOVia71CoAI1swzrpVXeuWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jerry.Ray@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:Pier.Beruto@onsemi.com,m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Jerry.Ray@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:from_mime,microchip.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33F7964AB46


Hi Rajagopal,

Thanks - confirmed: with patch 08 applied, lan865x just needs the FCS
handling, and s2500 gets it via hw_features |=3D NETIF_F_RXFCS.=20

Two things though:=20
(1) I had dropped patch 08 in my tree, hence the separate strip patch.
(2) Patch 08 uses NETIF_F_RXFCS inverted from its kernel meaning
   ("append FCS"): it strips when the bit is in hw_features and checks
   hw_features rather than dev->features, so ethtool -K rx-fcs on never
   actually delivers the FCS, and a consumer must advertise a debug feature
   to get default behavior. The mainline idiom (r8169, rtase, 8139too, mlx4=
)
   is if (!(dev->features & NETIF_F_RXFCS)) strip;=20
   with hw_features |=3D NETIF_F_RXFCS to allow toggling. Since every OA TC=
6
   device delivers the FCS, I'd suggest the framework strip unconditionally
   by default using that idiom (patch attached), rather than gating on a
   per-vendor opt-in.

Please consider.

>=20
> When MAC-PHY appends FCS to the incoming frame, FCS,
> it is removed from the frame before passing it to the stack.
>=20
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  drivers/net/ethernet/oa_tc6/oa_tc6.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/=
oa_tc6/oa_tc6.c
> index d2b05f98765b..de5f1548139f 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
> @@ -786,6 +786,9 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
>         tc6->netdev->stats.rx_packets++;
>         tc6->netdev->stats.rx_bytes +=3D tc6->rx_skb->len;
>=20
> +       if ((tc6->netdev->hw_features & NETIF_F_RXFCS) !=3D 0)
> +               skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
> +
>         netif_rx(tc6->rx_skb);
>=20
>         tc6->rx_skb =3D NULL;
> --

As below:

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa=
_tc6/oa_tc6.c
index d2b05f98765b..255c7f066032 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -782,6 +782,16 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 {
 	oa_tc6_update_ts_in_rx_skb(tc6);
=20
+	/* The MAC-PHY delivers each frame with its Ethernet FCS attached.
+	 * Strip it before handing the frame to the stack, unless the user has
+	 * asked to keep it via NETIF_F_RXFCS. Leaving the FCS on is harmless
+	 * for IP traffic but is parsed as a (malformed) suffix TLV by PTP,
+	 * which makes ptp4l reject every message as a "bad message".
+	 */
+	if (!(tc6->netdev->features & NETIF_F_RXFCS) &&
+	    tc6->rx_skb->len > ETH_FCS_LEN)
+		skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
+
 	tc6->rx_skb->protocol =3D eth_type_trans(tc6->rx_skb, tc6->netdev);
 	tc6->netdev->stats.rx_packets++;
 	tc6->netdev->stats.rx_bytes +=3D tc6->rx_skb->len;
--

Regards,
Jerry.


